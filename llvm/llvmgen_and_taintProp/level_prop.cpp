// #include "z3++.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/DebugProgramInstruction.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Passes/PassBuilder.h"

#include <llvm-20/llvm/Support/Casting.h>
#include <llvm-20/llvm/Support/raw_ostream.h>
#include <map>
#include <set>
#include <system_error>
#include <vector>

using namespace llvm;
using namespace std;

enum class Level { Public = 0, EphSecret = 1, Secret = 2 };

Level join(Level a, Level b) { return (Level)max((int)a, (int)b); }

static StringRef instTypeStr(Instruction &I) {
  if (isa<AllocaInst>(&I))
    return "AllocaInst";
  if (isa<GetElementPtrInst>(&I))
    return "GetElementPtrInst";
  if (isa<LoadInst>(&I))
    return "LoadInst";
  if (isa<StoreInst>(&I))
    return "StoreInst";
  if (isa<BinaryOperator>(&I))
    return "BinOp";
  if (isa<CallInst>(&I))
    return "CallInst";
  if (isa<ReturnInst>(&I))
    return "ReturnInst";
  if (isa<PHINode>(&I))
    return "PHINode";
  if (isa<BranchInst>(&I))
    return "BranchInst";
  if (isa<CastInst>(&I))
    return "CastInst";
  if (isa<CmpInst>(&I))
    return "CmpInst";
  return "Other";
}

struct Env {
  map<Value *, Level> reg;
  map<Value *, Level> mem;
  Level returnlevel = Level::Public;
};

class LevelPropPass : public PassInfoMixin<LevelPropPass> {
  map<Function *, Level> funcLevel;
  vector<Function *> callStack;

  // Per-function list of tainted instructions with their levels
  map<Function *, map<Instruction *, Level>> funcTaintedInsts;

  // Memoization: cache (Function*, per-arg reg/mem levels) -> result Env.
  // Keyed per argument so a public call (shake256 on the message, unpacking
  // cpk) does not reuse the summary of a secret call and taint its arguments.
  map<pair<Function *, vector<Level>>, Env> funcCache;

public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &) {
    Function *main = M.getFunction("main");
    if (!main) {
      errs() << "Error: 'main' function not found in module.\n";
      return PreservedAnalyses::all();
    }

    Env global;
    analyzeFunc(main, global);
    // printMaps();
    dumpJSONs();
    return PreservedAnalyses::all();
  }

private:
  static StringRef levelStr(Level L) {
    switch (L) {
    case Level::Public:
      return "Public";
    case Level::EphSecret:
      return "EphSecret";
    case Level::Secret:
      return "Secret";
    }
    return "Unknown";
  }

  void printMaps() {
    outs() << "\n===== Function Sensitivity =====\n\n";

    for (auto &it : funcLevel) {
      outs() << it.first->getName() << " -> " << levelStr(it.second) << "\n";
    }

    outs() << "\n===== Secret-Tainted Instructions Per Function =====\n";

    for (auto &[F, insts] : funcTaintedInsts) {
      if (insts.empty())
        continue;

      outs() << "\n--- " << F->getName() << " (" << levelStr(funcLevel[F])
             << ") ---\n";

      for (auto &BB : *F) {
        for (auto &I : BB) {
          if (insts.count(&I)) {
            outs() << "  [" << levelStr(insts[&I]) << "] " << I << "\n";
          }
        }
      }
    }

    outs() << "\n";
  }

  void dumpJSONs() {
    for (auto &[F, instMap] : funcTaintedInsts) {
      if (instMap.empty())
        continue;

      std::error_code EC;
      raw_fd_ostream os("../taintResults/" + F->getName().str() + ".json", EC);
      if (EC) {
        errs() << "Could not open file: " << EC.message() << "\n";
        continue;
      }

      os << "{\n";
      int lineNo = 0;
      bool first = true;
      for (auto &BB : *F) {
        for (auto &I : BB) {
          if (instMap.count(&I)) {
            if (!first)
              os << ",\n";
            first = false;

            std::string instStr;
            raw_string_ostream rso(instStr);
            I.print(rso);

            std::string escaped;
            for (char c : instStr) {
              if (c == '"')
                escaped += "\\\"";
              else if (c == '\\')
                escaped += "\\\\";
              else if (c == '\n')
                escaped += "\\n";
              else
                escaped += c;
            }
            StringRef typeStr = instTypeStr(I);

            os << "  \"" << lineNo << "\": {\n";
            os << "    \"instr\": \"" << escaped << "\",\n";
            os << "    \"type\": \"" << typeStr.str() << "\"";

            if (auto *C = dyn_cast<CallInst>(&I)) {
              if (Function *callee = C->getCalledFunction()) {
                os << ",\n    \"callee\": \"" << callee->getName().str()
                   << "\"";
              } else {
                // indirect call (function pointer) - no static name available
                os << ",\n    \"callee\": null";
              }
            }

            os << "\n  }";
          }
          lineNo++;
        }
      }
      os << "\n}\n";
    }
  }

  // Memory is tracked per base object. Besides GEPs and bitcasts, look through
  // pointer PHIs whose incoming values all reach one base: a pointer advanced
  // in a loop (h += i in keccak_inc_squeeze) still writes its argument.
  Value *getBase(Value *V) {
    set<PHINode *> visiting;
    Value *base = getBase(V, visiting);
    return base ? base : V;
  }

  // Returns nullptr when V only leads back to a PHI already being visited.
  Value *getBase(Value *V, set<PHINode *> &visiting) {
    while (true) {
      if (auto *G = dyn_cast<GetElementPtrInst>(V))
        V = G->getPointerOperand();
      else if (auto *B = dyn_cast<BitCastInst>(V))
        V = B->getOperand(0);
      else
        break;
    }
    auto *P = dyn_cast<PHINode>(V);
    if (!P || !P->getType()->isPointerTy())
      return V;
    if (!visiting.insert(P).second)
      return nullptr;
    Value *base = nullptr;
    for (Value *inc : P->incoming_values()) {
      Value *b = getBase(inc, visiting);
      if (!b)
        continue;
      if (base && b != base)
        return P;
      base = b;
    }
    return base ? base : P;
  }

  // Level of the indices that address V. The reference GF arithmetic is table
  // lookups (gf_multtab[a * q + b]), so a load through a secret index is as
  // sensitive as the index, even though the table itself is public.
  Level indexLevel(Value *V, Env &env) {
    Level L = Level::Public;
    while (true) {
      if (auto *G = dyn_cast<GetElementPtrInst>(V)) {
        for (Use &idx : G->indices())
          if (!isa<Constant>(idx.get()))
            L = join(L, env.reg[idx.get()]);
        V = G->getPointerOperand();
      } else if (auto *B = dyn_cast<BitCastInst>(V))
        V = B->getOperand(0);
      else
        break;
    }
    return L;
  }

  // F is `name` itself or the SNOVA_NAMESPACE'd _<SNOVA_NAME>_ref_<name>.
  // An empty name matches every function.
  static bool isFunc(StringRef F, StringRef name) {
    return name.empty() || F == name || F.ends_with(("_ref_" + name).str());
  }

  // Sensitivity of a variable by name (SNOVA v3.1 spec, Alg. 4, 10, 13, 14,
  // 17). Matched per function where a name is reused for public data (seed is
  // the public seed in expand_public, signature_in_GF the signature in verify).
  //   Secret:    seed = spublic || ssecret (keygen) and its alias of skx
  //              (sign), sk = spublic || ssecret || pkd, the expanded key skx,
  //              T12 with the SHAKE256(ssecret) bytes and coefficients it is
  //              sampled from, and the central map parts F12, F21
  //   EphSecret: vinegar V, squeezed into vinegar_in_byte and sampled into
  //              signature_in_GF, which later holds the signature
  static Level nameLevel(StringRef func, StringRef name) {
    struct Entry {
      StringRef func, var;
      Level level;
    };
    static const vector<Entry> table = {
        {"", "sk", Level::Secret},
        {"", "skx", Level::Secret},
        {"", "skx_d", Level::Secret},
        {"", "pskx", Level::Secret},
        {"", "T12", Level::Secret},
        {"", "T12coef", Level::Secret},
        {"", "sk_data", Level::Secret},
        {"", "F12", Level::Secret},
        {"", "F21", Level::Secret},
        {"crypto_sign_keypair", "seed", Level::Secret},
        {"sign", "seed", Level::Secret},
        {"sign", "vinegar_in_byte", Level::EphSecret},
        {"sign", "signature_in_GF", Level::EphSecret},
    };
    Level L = Level::Public;
    for (auto &e : table)
      if (e.var == name && isFunc(func, e.func))
        L = join(L, e.level);
    return L;
  }

  // Values the spec makes public even though secrets flow into them; they are
  // pinned to Public (declassified). Matched per function. Unlike seeds these
  // may be parameters, since a callee can write secret-derived public output
  // through one.
  //   genkeys: P22 = -(T12^T F12 + P21 T12), packed into pk, and pk itself,
  //            whose first bytes are copied from seed
  //   sign:    the oil solution, which equals the last o signature blocks,
  //            and the packed signature sig
  static bool isDeclassified(StringRef func, StringRef var) {
    static const vector<pair<StringRef, vector<StringRef>>> table = {
        {"genkeys", {"P22", "pk"}},
        {"sign", {"solution", "sig"}},
    };
    for (auto &[f, vars] : table)
      if (isFunc(func, f) && find(vars.begin(), vars.end(), var) != vars.end())
        return true;
    return false;
  }

  // Call arguments that point into a secret buffer, but only at a public part
  // of it. seed / skx hold spublic || ssecret || pkd and memory is tracked per
  // base, so without this the callee would see the whole buffer as Secret.
  //   genkeys, sign: expand_public(P, seed) reads only spublic
  //   sign:          hash_combined(.., seed + 48, salt) reads only pkd
  static bool isPublicArg(StringRef caller, StringRef callee, unsigned idx) {
    static const vector<tuple<StringRef, StringRef, unsigned>> table = {
        {"genkeys", "expand_public", 1},
        {"sign", "expand_public", 1},
        {"sign", "hash_combined", 3},
    };
    for (auto &[f, g, i] : table)
      if (i == idx && isFunc(caller, f) && isFunc(callee, g))
        return true;
    return false;
  }

  // Values that start out sensitive in F: allocas by their IR name, and any
  // local variable by its debug-info name (seed in sign is skx itself, not an
  // alloca). A pointer also seeds its base, since memory is tracked per base.
  // Parameters are not seeded by name (AES has an `sk` arg, expand_T12 a
  // `T12` arg); their level comes from the caller. Declassified values go
  // into publics; unlike seeds they do not spread to their base.
  map<Value *, Level> collectSeeds(Function *F, set<Value *> &publics) {
    map<Value *, Level> seeds;
    auto addPublic = [&](StringRef name, Value *V) {
      if (V && (isa<Instruction>(V) || isa<Argument>(V)) &&
          isDeclassified(F->getName(), name))
        publics.insert(V);
    };
    auto add = [&](Value *V, Level L) {
      if (L == Level::Public || !V ||
          (!isa<Instruction>(V) && !isa<Argument>(V)))
        return;
      seeds[V] = join(seeds[V], L);
      if (V->getType()->isPointerTy()) {
        Value *base = getBase(V);
        if (base != V && (isa<Instruction>(base) || isa<Argument>(base)))
          seeds[base] = join(seeds[base], L);
      }
    };

    for (auto &BB : *F) {
      for (auto &I : BB) {
        if (auto *A = dyn_cast<AllocaInst>(&I)) {
          add(A, nameLevel(F->getName(), A->getName()));
          addPublic(A->getName(), A);
        }

        for (DbgVariableRecord &DVR : filterDbgVars(I.getDbgRecordRange())) {
          DILocalVariable *Var = DVR.getVariable();
          if (!Var)
            continue;
          Level L = Var->getArg() ? Level::Public
                                  : nameLevel(F->getName(), Var->getName());
          for (Value *V : DVR.location_ops()) {
            add(V, L);
            addPublic(Var->getName(), V);
          }
        }
      }
    }
    return seeds;
  }

  Env analyzeFunc(Function *F, Env env) {
    for (auto *f : callStack)
      if (f == F)
        return env;

    // Compute a summary of the input level for cache lookup
    Level inputLvl = Level::Public;
    vector<Level> argLvls;
    for (auto &arg : F->args()) {
      inputLvl = join(inputLvl, env.reg[&arg]);
      inputLvl = join(inputLvl, env.mem[&arg]);
      argLvls.push_back(env.reg[&arg]);
      argLvls.push_back(env.mem[&arg]);
    }

    // Check cache: reuse the result if F was analyzed with the same inputs
    auto cacheKey = make_pair(F, argLvls);
    auto cacheIt = funcCache.find(cacheKey);
    if (cacheIt != funcCache.end()) {
      return cacheIt->second;
    }

    callStack.push_back(F);

    Level funcLvl = inputLvl;

    set<Value *> local;

    for (auto &BB : *F) {
      for (auto &I : BB) {
        if (auto *A = dyn_cast<AllocaInst>(&I)) {
          local.insert(A);
          env.mem[A] = Level::Public;
          env.reg[A] = Level::Public;
        }
      }
    }

    set<Value *> publics;
    map<Value *, Level> seeds = collectSeeds(F, publics);
    for (auto &[v, lvl] : seeds) {
      env.mem[v] = join(env.mem[v], lvl);
      env.reg[v] = join(env.reg[v], lvl);
    }

    // The vinegar is SHAKE256(ssecret || md || salt || numsig): it is fresh
    // per signature, so it stays EphSecret even though ssecret flows into it,
    // and so does signature_in_GF once T12 * oil is added to it.
    // Declassified values (see isDeclassified) stay Public.
    map<Value *, Level> pinned;
    for (auto &[v, lvl] : seeds)
      if (lvl == Level::EphSecret)
        pinned[v] = lvl;
    for (Value *v : publics)
      pinned[v] = Level::Public;

    bool changed = true;
    while (changed) {
      changed = false;
      auto prevReg = env.reg;
      auto prevMem = env.mem;

      for (auto &BB : *F) {
        for (auto &I : BB) {

          if (dyn_cast<AllocaInst>(&I)) {
            continue;
          }

          // gep
          else if (auto *G = dyn_cast<GetElementPtrInst>(&I)) {
            Value *base = getBase(G->getPointerOperand());

            env.reg[&I] = env.reg[base];

            env.mem[&I] = env.mem[base];
          }

          // load
          else if (auto *L = dyn_cast<LoadInst>(&I)) {
            Value *ptr = L->getPointerOperand();
            Value *base = getBase(ptr);

            Level memL = env.mem[base];

            if (!isa<AllocaInst>(base) && !isa<Argument>(base)) {
              memL = join(memL, env.reg[base]);
            }
            env.reg[&I] = join(memL, indexLevel(ptr, env));
          }

          // store
          else if (auto *S = dyn_cast<StoreInst>(&I)) {
            Value *src = S->getValueOperand();
            Value *dst = getBase(S->getPointerOperand());

            env.mem[dst] =
                join(env.mem[dst], join(env.reg[src],
                                        indexLevel(S->getPointerOperand(), env)));
            Value *cur = dst;
            while (auto *LI = dyn_cast<LoadInst>(cur)) {
              Value *loadSrc = getBase(LI->getPointerOperand());
              env.mem[loadSrc] = join(env.mem[loadSrc], env.reg[src]);
              cur = loadSrc;
            }
          }
          // binop
          else if (auto *B = dyn_cast<BinaryOperator>(&I)) {
            env.reg[&I] =
                join(env.reg[B->getOperand(0)], env.reg[B->getOperand(1)]);
          }

          else if (auto *C = dyn_cast<CallInst>(&I)) {
            handleCall(*C, env);
          }

          else if (auto *R = dyn_cast<ReturnInst>(&I)) {
            if (R->getReturnValue()) {
              env.returnlevel = env.reg[R->getReturnValue()];
            }
          } else if (auto *P = dyn_cast<PHINode>(&I)) {
            Level regLvl = Level::Public;
            Level memLvl = Level::Public;

            for (unsigned i = 0; i < P->getNumIncomingValues(); i++) {
              Value *inc = P->getIncomingValue(i);
              Value *base = getBase(inc);
              regLvl = join(regLvl, env.reg[inc]);
              memLvl = join(memLvl, env.mem[base]);
            }

            env.reg[P] = regLvl;
            env.mem[P] = memLvl;
          }
          else if (auto *C = dyn_cast<CastInst>(&I)) {
            env.reg[&I] = env.reg[C->getOperand(0)];
          }

          // comparison
          else if (auto *C = dyn_cast<CmpInst>(&I)) {
            env.reg[&I] =
                join(env.reg[C->getOperand(0)], env.reg[C->getOperand(1)]);
          }

          // select
          else if (auto *S = dyn_cast<SelectInst>(&I)) {
            env.reg[&I] = join(
                env.reg[S->getCondition()],
                join(env.reg[S->getTrueValue()], env.reg[S->getFalseValue()]));
          }

          // re-apply seeds the transfer above may have overwritten
          // (e.g. seed in sign, which is the skx argument itself)
          auto seedIt = seeds.find(&I);
          if (seedIt != seeds.end()) {
            env.reg[&I] = join(env.reg[&I], seedIt->second);
            env.mem[&I] = join(env.mem[&I], seedIt->second);
          }
          for (auto &[v, lvl] : pinned) {
            env.reg[v] = lvl;
            env.mem[v] = lvl;
          }
          // funcLvl = join(funcLvl, env.reg[&I]);
        }
      }

      for (auto &[v, lvl] : env.reg) {
        if (prevReg.find(v) == prevReg.end() || prevReg[v] != lvl) {
          changed = true;
          break;
        }
      }
      if (!changed) {
        for (auto &[v, lvl] : env.mem) {
          if (prevMem.find(v) == prevMem.end() || prevMem[v] != lvl) {
            changed = true;
            break;
          }
        }
      }
    }
    Level outLvl = env.returnlevel;

    for (Value *v : local) {
      outLvl = join(outLvl, env.mem[v]);
    }

    funcLvl = join(funcLvl, outLvl);
    funcLevel[F] = join(funcLevel[F], funcLvl);

    // Collect tainted instructions for this function
    auto &tainted = funcTaintedInsts[F];
    for (auto &BB : *F) {
      for (auto &I : BB) {
        Level instLvl = Level::Public;

        // Check register level (the value produced by this instruction)
        auto regIt = env.reg.find(&I);
        if (regIt != env.reg.end())
          instLvl = join(instLvl, regIt->second);

        // For stores, also check the mem level of the destination
        if (auto *S = dyn_cast<StoreInst>(&I)) {
          Value *dst = getBase(S->getPointerOperand());
          auto memIt = env.mem.find(dst);
          if (memIt != env.mem.end())
            instLvl = join(instLvl, memIt->second);
          // Also check the source value
          auto srcIt = env.reg.find(S->getValueOperand());
          if (srcIt != env.reg.end())
            instLvl = join(instLvl, srcIt->second);
        }

        // For calls, check if any argument is secret
        if (auto *C = dyn_cast<CallInst>(&I)) {
          Function *callee = C->getCalledFunction();
          for (auto &arg : C->args()) {
            if (callee && isPublicArg(F->getName(), callee->getName(),
                                      arg.getOperandNo()))
              continue;
            Value *v = arg.get();
            auto regIt = env.reg.find(v);
            if (regIt != env.reg.end())
              instLvl = join(instLvl, regIt->second);
            auto memIt = env.mem.find(getBase(v));
            if (memIt != env.mem.end())
              instLvl = join(instLvl, memIt->second);
          }
        }

        if (instLvl != Level::Public) {
          tainted[&I] = join(tainted[&I], instLvl);
        }
      }
    }

    // Cache the result for this function
    funcCache[cacheKey] = env;

    callStack.pop_back();

    return env;
  }

  void handleCall(CallInst &C, Env &callerEnv) {
    Function *callee = C.getCalledFunction();
    if (!callee)
      return;
    Env calleeEnv;

    if (callee->isDeclaration()) {
      StringRef name = callee->getName();

      if ((name == "memcpy" || name == "memmove" ||
           name.find("llvm.memcpy") != string::npos ||
           name.find("llvm.memmove") != string::npos) &&
          C.arg_size() >= 2) {
        Value *dst = getBase(C.getArgOperand(0));
        Value *src = getBase(C.getArgOperand(1));

        Level srcLvl = callerEnv.mem[src];
        if (!isa<AllocaInst>(src) && !isa<Argument>(src))
          srcLvl = join(srcLvl, callerEnv.reg[src]);

        callerEnv.mem[dst] = join(callerEnv.mem[dst], srcLvl);
        callerEnv.reg[&C] = Level::Public;
        return;
      }

      if ((name == "memset" || name.find("llvm.memset") != string::npos) &&
          C.arg_size() >= 2) {
        Value *dst = getBase(C.getArgOperand(0));
        Value *fillVal = C.getArgOperand(1);

        Level fillLvl = callerEnv.reg[fillVal];
        callerEnv.mem[dst] = join(callerEnv.mem[dst], fillLvl);
        callerEnv.reg[&C] = Level::Public;
        return;
      }

      if (name == "calloc" || name == "free") {
        callerEnv.reg[&C] = Level::Public;
        return;
      }

      Level ret = Level::Public;
      for (unsigned i = 0; i < C.arg_size(); i++)
        ret = join(ret, callerEnv.reg[C.getArgOperand(i)]);

      callerEnv.reg[&C] = ret;

      for (unsigned i = 0; i < C.arg_size(); i++) {
        Value *arg = C.getArgOperand(i);
        if (arg->getType()->isPointerTy()) {
          Value *base = getBase(arg);
          callerEnv.mem[base] = join(callerEnv.mem[base], ret);
        }
      }
      return;
    }

    StringRef caller = C.getFunction()->getName();
    int minArgs = min((size_t)C.arg_size(), callee->arg_size());
    for (int i = 0; i < minArgs; i++) {
      Value *caller_arg = C.getArgOperand(i);
      Argument &callee_arg = *callee->getArg(i);

      if (isPublicArg(caller, callee->getName(), i)) {
        calleeEnv.reg[&callee_arg] = Level::Public;
        calleeEnv.mem[&callee_arg] = Level::Public;
      } else if (caller_arg->getType()->isPointerTy()) {
        Value *base = getBase(caller_arg);
        Level memLvl = callerEnv.mem[base];

        if (!isa<AllocaInst>(base) && !isa<Argument>(base)) {
          memLvl = join(memLvl, callerEnv.reg[base]);
        }
        calleeEnv.mem[&callee_arg] = memLvl;
        calleeEnv.reg[&callee_arg] = join(callerEnv.reg[caller_arg], memLvl);
      } else {
        calleeEnv.reg[&callee_arg] = callerEnv.reg[caller_arg];
      }
      // calleeEnv.reg[&callee_arg] = callerEnv.reg[caller_arg];
      // calleeEnv.mem[&callee_arg] = callerEnv.mem[getBase(caller_arg)];
    }

    calleeEnv = analyzeFunc(callee, calleeEnv);
    map<Argument *, set<Value *>> argToAllocas;
    for (auto &BB : *callee) {
      for (auto &I : BB) {
        if (auto *S = dyn_cast<StoreInst>(&I)) {
          Value *val = S->getValueOperand();
          Value *dst = S->getPointerOperand();
          for (auto &calleeArg : callee->args()) {
            if (val == &calleeArg) {
              argToAllocas[&calleeArg].insert(dst);
            }
          }
        }
      }
    }
    for (int i = 0; i < minArgs; i++) {
      Value *callerArg = C.getArgOperand(i);
      Argument &calleeArg = *callee->getArg(i);

      // A public view of a secret buffer: the callee's level for it says
      // nothing about the rest of the buffer.
      if (isPublicArg(caller, callee->getName(), i))
        continue;

      if (callerArg->getType()->isPointerTy()) {

        Value *callerBase = getBase(callerArg);
        // Value *calleeBase = getBase(&calleeArg);
        Level memLvl =
            join(callerEnv.mem[callerBase], calleeEnv.mem[&calleeArg]);

        for (Value *alloca : argToAllocas[&calleeArg]) {
          memLvl = join(memLvl, calleeEnv.mem[alloca]);

          for (auto *U : alloca->users()) {
            if (auto *LI = dyn_cast<LoadInst>(U)) {
              memLvl = join(memLvl, calleeEnv.mem[LI]);
              // Also chase GEPs off the loaded pointer (%arrayidx1 etc.)
              for (auto *LU : LI->users()) {
                if (auto *G = dyn_cast<GetElementPtrInst>(LU)) {
                  memLvl = join(memLvl, calleeEnv.mem[G]);
                }
              }
            }
          }
        }

        if (isa<AllocaInst>(callerBase) || isa<Argument>(callerBase)) {
          callerEnv.mem[callerBase] = memLvl;
        } else {
          callerEnv.reg[callerBase] = join(callerEnv.reg[callerBase], memLvl);
          callerEnv.reg[callerArg] = join(callerEnv.reg[callerArg], memLvl);
        }

        Value *cur = callerBase;
        while (auto *LI = dyn_cast<LoadInst>(cur)) {
          Value *loadSrc = getBase(LI->getPointerOperand());
          callerEnv.mem[loadSrc] = join(callerEnv.mem[loadSrc], memLvl);
          cur = loadSrc;
        }
      }
    }

    callerEnv.reg[&C] = calleeEnv.returnlevel;
  }
};

int main(int argc, char **argv) {
  LLVMContext ctx;
  SMDiagnostic err;
  StringRef filename = "../no_struct/snova_i_s_aes_ref.ll";
  if (argc > 1) {
    filename = argv[1];
  }
  auto module = parseIRFile(filename, err, ctx);

  if (!module) {
    errs() << "Error parsing IR file: " << filename << "\n";
    err.print(argv[0], errs());
    return 1;
  }

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

  // Module Pass Manager
  ModulePassManager MPM;
  MPM.addPass(LevelPropPass());
  // MPM.addPass(DefUseGraph());

  // Run
  MPM.run(*module, MAM);
  return 0;
}