#include "clang/Basic/DiagnosticOptions.h"
#include "clang/CodeGen/CodeGenAction.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/CompilerInvocation.h"
#include "clang/Frontend/TextDiagnosticPrinter.h"
#include "clang/Frontend/Utils.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Linker/Linker.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/VirtualFileSystem.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/TargetParser/Host.h"
#include "llvm/Transforms/IPO/GlobalDCE.h"
#include "llvm/Transforms/IPO/GlobalOpt.h"
#include "llvm/Transforms/IPO/SCCP.h"
#include "llvm/Transforms/IPO/StripDeadPrototypes.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/Scalar/CorrelatedValuePropagation.h"
#include "llvm/Transforms/Scalar/IndVarSimplify.h"
#include "llvm/Transforms/Scalar/LoopUnrollPass.h"
#include "llvm/Transforms/Scalar/SCCP.h"
#include "llvm/Transforms/Scalar/SROA.h"
#include "llvm/Transforms/Scalar/SimplifyCFG.h"
#include "llvm/Transforms/Utils/LoopSimplify.h"
#include "llvm/Transforms/Utils/Mem2Reg.h"

#include <llvm-20/llvm/Analysis/InlineCost.h>
#include <llvm-20/llvm/Transforms/IPO/ModuleInliner.h>
#include <memory>

using namespace llvm;

static bool lowerIntrinsic(CallInst *CI) {

  Function *Callee = CI->getCalledFunction();
  if (!Callee || !Callee->isIntrinsic())
    return false;

  IRBuilder<> B(CI);

  switch (Callee->getIntrinsicID()) {

  case Intrinsic::memset: {
    auto *MSI = cast<MemSetInst>(CI);

    Module *M = CI->getModule();
    LLVMContext &Ctx = M->getContext();

    auto *I8PtrTy = PointerType::getUnqual(Ctx);
    auto *I8Ty = Type::getInt8Ty(Ctx);
    auto *I32Ty = Type::getInt32Ty(Ctx);

    FunctionCallee Fn = M->getOrInsertFunction(
        "snova_memset", Type::getVoidTy(Ctx), I8PtrTy, I8Ty, I32Ty);

    IRBuilder<> B(CI);

    B.CreateCall(Fn, {MSI->getDest(), MSI->getValue(), MSI->getLength()});

    CI->eraseFromParent();
    return true;
  }

  case Intrinsic::memcpy: {
    auto *MCI = cast<MemCpyInst>(CI);

    Module *M = CI->getModule();
    LLVMContext &Ctx = M->getContext();

    auto *I8PtrTy = PointerType::getUnqual(Ctx);
    auto *I32Ty = Type::getInt32Ty(Ctx);

    FunctionCallee Fn = M->getOrInsertFunction(
        "snova_memcpy", Type::getVoidTy(Ctx), I8PtrTy, I8PtrTy, I32Ty);

    IRBuilder<> B(CI);

    B.CreateCall(Fn, {MCI->getDest(), MCI->getSource(), MCI->getLength()});

    CI->eraseFromParent();
    return true;
  }
  // llvm.smax.i32
  case Intrinsic::smax: {
    Value *A = CI->getArgOperand(0);
    Value *Bv = CI->getArgOperand(1);

    Value *Cmp = B.CreateICmpSGT(A, Bv);
    Value *Res = B.CreateSelect(Cmp, A, Bv);

    CI->replaceAllUsesWith(Res);
    CI->eraseFromParent();
    return true;
  }

  // llvm.umin.i32
  case Intrinsic::umin: {
    Value *A = CI->getArgOperand(0);
    Value *Bv = CI->getArgOperand(1);

    Value *Cmp = B.CreateICmpULT(A, Bv);
    Value *Res = B.CreateSelect(Cmp, A, Bv);

    CI->replaceAllUsesWith(Res);
    CI->eraseFromParent();
    return true;
  }

  // llvm.fshl
  case Intrinsic::fshl: {

    Value *X = CI->getArgOperand(0);
    Value *Y = CI->getArgOperand(1);
    Value *Shift = CI->getArgOperand(2);

    IntegerType *Ty = cast<IntegerType>(X->getType());

    unsigned BW = Ty->getBitWidth();

    Value *BWVal = ConstantInt::get(Ty, BW);

    Value *Mask = ConstantInt::get(Ty, BW - 1);

    Shift = B.CreateAnd(Shift, Mask);

    Value *Left = B.CreateShl(X, Shift);

    Value *Sub = B.CreateSub(BWVal, Shift);

    Value *Right = B.CreateLShr(Y, Sub);

    Value *Res = B.CreateOr(Left, Right);

    CI->replaceAllUsesWith(Res);
    CI->eraseFromParent();
    return true;
  }

  // llvm.bswap
  case Intrinsic::bswap: {

    Value *X = CI->getArgOperand(0);

    IntegerType *Ty = cast<IntegerType>(X->getType());

    unsigned BW = Ty->getBitWidth();

    if (BW == 32) {

      Value *B0 = B.CreateAnd(X, ConstantInt::get(Ty, 0x000000FF));
      B0 = B.CreateShl(B0, 24);

      Value *B1 = B.CreateAnd(X, ConstantInt::get(Ty, 0x0000FF00));
      B1 = B.CreateShl(B1, 8);

      Value *B2 = B.CreateAnd(X, ConstantInt::get(Ty, 0x00FF0000));
      B2 = B.CreateLShr(B2, 8);

      Value *B3 = B.CreateAnd(X, ConstantInt::get(Ty, 0xFF000000));
      B3 = B.CreateLShr(B3, 24);

      Value *Res = B.CreateOr(B0, B1);
      Res = B.CreateOr(Res, B2);
      Res = B.CreateOr(Res, B3);

      CI->replaceAllUsesWith(Res);
      CI->eraseFromParent();
      return true;
    }

    if (BW == 64) {

      Value *Res = ConstantInt::get(Ty, 0);

      for (unsigned i = 0; i < 8; i++) {

        uint64_t Mask = 0xFFULL << (8 * i);

        Value *Byte = B.CreateAnd(X, ConstantInt::get(Ty, Mask));

        if (i < 7 - i)
          Byte = B.CreateShl(Byte, 8 * (7 - 2 * i));
        else if (i > 7 - i)
          Byte = B.CreateLShr(Byte, 8 * (2 * i - 7));

        Res = B.CreateOr(Res, Byte);
      }

      CI->replaceAllUsesWith(Res);
      CI->eraseFromParent();
      return true;
    }

    return false;
  }

  default:
    return false;
  }
}

std::unique_ptr<Module> c2ir(const std::vector<std::string> &filepaths,
                             const std::vector<std::string> &includeDirs,
                             LLVMContext &llvm_ctx,
                             const std::vector<std::string> &defines) {
  auto composite = std::make_unique<Module>("composite", llvm_ctx);

  // composite->setTargetTriple("arm-unknown-none-eabi");
  composite->setTargetTriple("thumbv7em-unknown-none-eabihf");
  // composite->setDataLayout(
  //     llvm::DataLayout("e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"));

  Linker linker(*composite);

  for (const auto &filepath : filepaths) {
    clang::CompilerInstance compiler;

    auto VFS = llvm::vfs::getRealFileSystem();
    compiler.createDiagnostics(
        *VFS, new clang::TextDiagnosticPrinter(llvm::errs(),
                                               new clang::DiagnosticOptions()));

    // std::vector<const char *> args = {
    //     "clang-tool",
    //     "-O0",
    //     "-ffreestanding",
    //     "-target",
    //     "thumbv7em-unknown-none-eabihf",
    //     "-mcpu=cortex-m4",
    //     "-mfloat-abi=hard",
    //     "-mfpu=fpv4-sp-d16",
    // };
    std::vector<const char *> args = {
        "clang-tool",
        "-O0",
        "-ffreestanding",
        "-triple",
        "thumbv7em-unknown-none-eabihf",
        "-target-cpu",
        "cortex-m4",
        "-target-abi",
        "aapcs-vfp",
        "-target-feature",
        "+vfp4d16sp",
        "-target-feature",
        "+dsp",
        "-target-feature",
        "+fp16",
        "-target-feature",
        "+hwdiv",
        // "-fno-builtin",
    };
    for (const auto &def : defines)
      args.push_back(def.c_str());

    auto &CGO = compiler.getInvocation().getCodeGenOpts();
    CGO.setDebugInfo(llvm::codegenoptions::FullDebugInfo);
    CGO.DebugColumnInfo = true;

    // Run clang -print-resource-dir programmatically
    FILE *pipe = popen("clang-20 -print-resource-dir 2>/dev/null", "r");
    char buf[256];
    fgets(buf, sizeof(buf), pipe);
    pclose(pipe);
    std::string resourceDir = std::string(buf);
    resourceDir.erase(resourceDir.find_last_not_of(" \n\r") + 1);

    // std::string resourceDir = "/usr/local/lib/clang/23";

    args.push_back("-Wno-macro-redefined");

    args.push_back("-resource-dir");
    args.push_back(resourceDir.c_str());

    args.push_back("-ffreestanding");
    args.push_back("-fno-builtin");

    compiler.getInvocation().getHeaderSearchOpts().Sysroot =
        "/usr/lib/arm-none-eabi";

    args.push_back("-isystem");
    args.push_back("/usr/lib/arm-none-eabi/include");

    args.push_back("-isystem");
    args.push_back("/usr/lib/gcc/arm-none-eabi/13.2.1/include");

    std::string builtinInclude = resourceDir + "/include";
    args.push_back("-internal-isystem");
    args.push_back(strdup(builtinInclude.c_str()));

    for (const auto &dir : includeDirs) {
      args.push_back("-I");
      args.push_back(dir.c_str());
    }

    clang::CompilerInvocation::CreateFromArgs(compiler.getInvocation(), args,
                                              compiler.getDiagnostics());

    CGO.FloatABI = "hard"; // or "hard" if FPU
    CGO.RelocationModel = llvm::Reloc::Model::Static;
    CGO.CodeModel = "small";

    auto &frontendOpts = compiler.getInvocation().getFrontendOpts();
    frontendOpts.Inputs.clear();
    frontendOpts.Inputs.emplace_back(filepath, clang::Language::C);
    // compiler.getInvocation().getTargetOpts().Triple =
    // "arm-unknown-none-eabi";

    // auto &TO = compiler.getInvocation().getTargetOpts();
    // TO.CPU = "cortex-m4";
    // TO.Features = {"+thumb2"};

    compiler.createFileManager();
    compiler.createSourceManager(compiler.getFileManager());

    auto TO_shared = std::make_shared<clang::TargetOptions>(
        compiler.getInvocation().getTargetOpts());

    compiler.setTarget(clang::TargetInfo::CreateTargetInfo(
        compiler.getDiagnostics(), TO_shared));

    auto action = std::make_unique<clang::EmitLLVMOnlyAction>(&llvm_ctx);
    if (!compiler.ExecuteAction(*action)) {
      return nullptr;
    }

    std::unique_ptr<Module> mod = action->takeModule();
    if (!mod) {
      llvm::errs() << "Module generation failed\n";
      return nullptr;
    }
    if (linker.linkInModule(std::move(mod))) {
      return nullptr;
    }
  }
  return composite;
}

std::unique_ptr<Module> ir2Module(const std::string &filepath,
                                  LLVMContext &llvm_ctx) {

  SMDiagnostic error;
  std::unique_ptr<llvm::Module> module =
      llvm::parseIRFile(filepath, error, llvm_ctx);
  if (!module)
    return nullptr;

  return module;
}

// snova_init() fills the GF tables, gf_S and fixed_abq at runtime. Give the
// globals the same values as static initialisers, read from the host build
// of snova_init() (init_tables.c), so that a function extracted without
// snova_init() -- the per-function fault tests -- sees the real tables. The
// whole program is unchanged: snova_init() still runs and rewrites the same
// values.
bool presetRuntimeTables(Module &M, const char *dumpCmd) {
  FILE *pipe = popen(dumpCmd, "r");
  if (!pipe) {
    errs() << "Could not run " << dumpCmd << "\n";
    return false;
  }
  unsigned preset = 0;
  bool ok = true;
  char line[16384];
  while (fgets(line, sizeof(line), pipe)) {
    StringRef name, hex;
    std::tie(name, hex) = StringRef(line).trim().split(' ');
    GlobalVariable *G = M.getGlobalVariable(name);
    auto *Ty = G ? dyn_cast<ArrayType>(G->getValueType()) : nullptr;
    if (!Ty || !Ty->getElementType()->isIntegerTy(8) ||
        Ty->getNumElements() * 2 != hex.size()) {
      errs() << "Cannot preset " << name << ": no [" << hex.size() / 2
             << " x i8] global of that name\n";
      ok = false;
      continue;
    }
    std::vector<uint8_t> bytes(hex.size() / 2);
    for (size_t i = 0; i < bytes.size(); i++)
      hex.substr(2 * i, 2).getAsInteger(16, bytes[i]);
    G->setInitializer(ConstantDataArray::get(M.getContext(), bytes));
    preset++;
  }
  if (pclose(pipe) != 0 || preset == 0) {
    errs() << dumpCmd << " failed\n";
    ok = false;
  }
  return ok;
}

void stripOptnoneNoinline(llvm::Module &module) {
  for (Function &F : module) {
    F.removeFnAttr(Attribute::OptimizeNone);
    F.removeFnAttr(Attribute::NoInline);
  }
}

void prepare(std::unique_ptr<llvm::Module> &module,
             const std::string &variantName) {

  stripOptnoneNoinline(*module);

  LoopAnalysisManager LAM;
  FunctionAnalysisManager FAM;
  CGSCCAnalysisManager CGAM;
  ModuleAnalysisManager MAM;

  PassBuilder PB;

  PB.registerModuleAnalyses(MAM);
  PB.registerCGSCCAnalyses(CGAM);
  PB.registerFunctionAnalyses(FAM);
  PB.registerLoopAnalyses(LAM);
  PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);

  ModulePassManager MPM;
  MPM.addPass(GlobalOptPass());

  // inlining
  // {
  //   InlineParams IP;
  //   IP.DefaultThreshold = 10000;
  //   MPM.addPass(ModuleInlinerPass(IP));
  // }

  {
    FunctionPassManager FPM;
    FPM.addPass(PromotePass());
    FPM.addPass(SROAPass(SROAOptions::ModifyCFG));
    FPM.addPass(SCCPPass());
    FPM.addPass(CorrelatedValuePropagationPass());
    FPM.addPass(InstCombinePass());
    FPM.addPass(SimplifyCFGPass());
    MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
  }

  // Interprocedural constant propagation: propagates constants from
  // call sites into function bodies (e.g. gf_mat_mul_add_lr's ad,bd,cd args)
  // without inlining
  MPM.addPass(IPSCCPPass());

  // Clean up after IPSCCP
  {
    FunctionPassManager FPM;
    FPM.addPass(InstCombinePass());
    FPM.addPass(SimplifyCFGPass());
    MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
  }

  // Loop
  {
    FunctionPassManager FPM;
    FPM.addPass(LoopSimplifyPass());
    FPM.addPass(createFunctionToLoopPassAdaptor(IndVarSimplifyPass()));
    // FPM.addPass(createFunctionToLoopPassAdaptor(
    //     LoopDeletionPass())); // delete dead loops
    // LoopUnrollOptions LUOpts;
    // LUOpts.setFullUnrollMaxCount(1024); // unroll short loops completely
    // // LUOpts.setPartialOptSizeThreshold(0);
    // FPM.addPass(LoopUnrollPass(LUOpts));
    // FPM.addPass(SCCPPass()); // SCCP again after unrolling
    // FPM.addPass(InstCombinePass());
    // FPM.addPass(SimplifyCFGPass());

    // LoopUnrollOptions options;
    // options.setFullUnrollMaxCount(1024);
    // options.setPartial(true);
    // options.setRuntime(true);
    // // options.setUpperBound(true);
    // FPM.addPass(LoopUnrollPass(options));
    // FPM.addPass(InstCombinePass());
    // FPM.addPass(SCCPPass());
    // FPM.addPass(SimplifyCFGPass());

    MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
  }

  MPM.addPass(StripDeadPrototypesPass());

  MPM.run(*module, MAM);
}

int main(int argc, char **argv) {

  // Default parameter set of src/snova_params.h only:
  // SNOVA_I_S_AES (v=27, o=5, q=16, l=4, r=4, m1=5, AES-CTR pk expansion).
  // SNOVA_OPT=0 selects the reference build, as `make OPT=REF` does.
  const std::vector<std::pair<std::vector<std::string>, std::string>>
      variants = {
          {{"-DSNOVA_OPT=0"}, "snova_i_s_aes_ref"},
      };

  // `make OPT=REF` objects: snova_ref, symmetric_ref, rng, sign, aes
  std::vector<std::string> files = {
      "../example.c",
      "../mem.c",
      "../../../src/sign.c",
      "../../../src/snova_ref.c",
      "../../../src/symmetric_ref.c",
      "../../../src/rng.c",
      "../../../src/aes.c",
  };

  std::vector<std::string> includes = {"../../../src"};

  for (auto &[defines, suffix] : variants) {
    llvm::LLVMContext llvm_ctx;
    auto module = c2ir(files, includes, llvm_ctx, defines);
    if (!module) {
      llvm::errs() << "Failed for " << suffix << "\n";
      continue;
    }

    // module->setTargetTriple("arm-unknown-none-eabi");
    module->setTargetTriple("thumbv7em-unknown-none-eabihf");
    if (llvm::verifyModule(*module, &llvm::errs())) {
      llvm::errs() << "Invalid module for " << suffix << "\n";
      continue;
    }

    if (!presetRuntimeTables(*module, "./init_tables")) {
      llvm::errs() << "Failed to preset the GF tables for " << suffix << "\n";
      continue;
    }

    prepare(module, suffix);
    bool Changed = false;

    for (Function &F : *module) {
      for (auto BI = F.begin(); BI != F.end(); ++BI) {

        for (auto II = BI->begin(); II != BI->end();) {

          Instruction *I = &*II++;

          if (auto *CI = dyn_cast<CallInst>(I))
            Changed |= lowerIntrinsic(CI);
        }
      }
    }
    if (Changed) {
      for (auto FI = module->begin(); FI != module->end();) {
        Function &F = *FI++;
        if (F.isDeclaration() && F.use_empty())
          F.eraseFromParent();
      }
    }

    verifyModule(*module, &errs());
    std::string outPath = "../no_struct/" + suffix + ".ll";
    std::error_code EC;
    llvm::raw_fd_ostream outFile(outPath, EC);
    if (!EC)
      module->print(outFile, nullptr);
    llvm::outs() << "Wrote " << outPath << "\n";
  }
}