; ModuleID = 'composite'
source_filename = "composite"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv7em-unknown-none-eabihf"

%struct.AES256_CTR_DRBG_struct = type { [32 x i8], [16 x i8], i32 }
%struct.shake_t = type { [28 x i64] }
%struct.snova_pk_expander_t = type { [46 x i64] }

@__const.example_snova.msg = private unnamed_addr constant <{ i8, [31 x i8] }> <{ i8 14, [31 x i8] zeroinitializer }>, align 1
@gf_multtab = dso_local local_unnamed_addr global [256 x i8] c"\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\00\02\04\06\08\0A\0C\0E\03\01\07\05\0B\09\0F\0D\00\03\06\05\0C\0F\0A\09\0B\08\0D\0E\07\04\01\02\00\04\08\0C\03\07\0B\0F\06\02\0E\0A\05\01\0D\09\00\05\0A\0F\07\02\0D\08\0E\0B\04\01\09\0C\03\06\00\06\0C\0A\0B\0D\07\01\05\03\09\0F\0E\08\02\04\00\07\0E\09\0F\08\01\06\0D\0A\03\04\02\05\0C\0B\00\08\03\0B\06\0E\05\0D\0C\04\0F\07\0A\02\09\01\00\09\01\08\02\0B\03\0A\04\0D\05\0C\06\0F\07\0E\00\0A\07\0D\0E\04\09\03\0F\05\08\02\01\0B\06\0C\00\0B\05\0E\0A\01\0F\04\07\0C\02\09\0D\06\08\03\00\0C\0B\07\05\09\0E\02\0A\06\01\0D\0F\03\04\08\00\0D\09\04\01\0C\08\05\02\0F\0B\06\03\0E\0A\07\00\0E\0F\01\0D\03\02\0C\09\07\06\08\04\0A\0B\05\00\0F\0D\02\09\06\04\0B\01\0E\0C\03\08\07\05\0A", align 1, !dbg !0
@gf_invtab = dso_local local_unnamed_addr global [16 x i8] c"\00\01\09\0E\0D\0B\07\06\0F\02\0C\05\0A\04\03\08", align 1, !dbg !15
@gf_addtab = dso_local local_unnamed_addr global [256 x i8] c"\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\01\00\03\02\05\04\07\06\09\08\0B\0A\0D\0C\0F\0E\02\03\00\01\06\07\04\05\0A\0B\08\09\0E\0F\0C\0D\03\02\01\00\07\06\05\04\0B\0A\09\08\0F\0E\0D\0C\04\05\06\07\00\01\02\03\0C\0D\0E\0F\08\09\0A\0B\05\04\07\06\01\00\03\02\0D\0C\0F\0E\09\08\0B\0A\06\07\04\05\02\03\00\01\0E\0F\0C\0D\0A\0B\08\09\07\06\05\04\03\02\01\00\0F\0E\0D\0C\0B\0A\09\08\08\09\0A\0B\0C\0D\0E\0F\00\01\02\03\04\05\06\07\09\08\0B\0A\0D\0C\0F\0E\01\00\03\02\05\04\07\06\0A\0B\08\09\0E\0F\0C\0D\02\03\00\01\06\07\04\05\0B\0A\09\08\0F\0E\0D\0C\03\02\01\00\07\06\05\04\0C\0D\0E\0F\08\09\0A\0B\04\05\06\07\00\01\02\03\0D\0C\0F\0E\09\08\0B\0A\05\04\07\06\01\00\03\02\0E\0F\0C\0D\0A\0B\08\09\06\07\04\05\02\03\00\01\0F\0E\0D\0C\0B\0A\09\08\07\06\05\04\03\02\01\00", align 1, !dbg !22
@gf_S = dso_local global [64 x i8] c"\01\00\00\00\00\01\00\00\00\00\01\00\00\00\00\01\08\07\06\05\07\06\05\04\06\05\04\03\05\04\03\02\0F\06\09\01\06\00\07\04\09\07\03\00\01\04\00\00\06\03\08\07\03\0A\04\0C\08\04\07\01\07\0C\01\06", align 1, !dbg !27
@fixed_abq = dso_local global [4800 x i8] c"\00\0B\08\01\05\02\08\06\09\0F\03\05\00\09\01\0A\0B\08\01\03\06\08\0C\07\00\01\04\01\04\04\0B\09\0F\0C\04\0A\06\0D\0A\07\05\08\06\03\02\0A\0C\07\0E\0F\0A\02\0A\00\0A\0A\0D\0E\0E\0C\0D\0E\07\0A\03\04\06\09\09\02\03\0A\00\07\01\0D\04\0B\0D\0B\08\02\04\0E\0C\0B\06\0D\02\07\0F\0D\08\04\0B\0C\08\09\07\02\08\07\0D\04\0D\0B\0C\06\06\02\06\0F\02\06\06\08\05\03\03\05\0E\04\08\08\09\03\06\02\04\0A\03\00\0A\0C\0A\0F\01\0F\0C\01\06\0C\03\03\0E\04\0F\05\0F\07\0D\00\09\0A\02\01\05\01\06\08\0A\09\06\01\03\0B\09\0F\03\02\02\02\0F\04\08\0E\03\09\0F\03\0B\02\01\01\01\07\06\07\04\07\07\06\07\06\0F\00\00\06\04\0C\09\0C\0B\0E\0E\00\0B\01\00\00\0F\09\00\08\0D\0A\06\0F\0E\0A\0C\06\06\04\0D\02\03\0B\00\0F\00\0C\02\0B\0E\0C\0D\0E\0F\07\01\03\0C\07\07\03\08\0B\08\02\07\0E\02\0C\03\0A\01\07\0C\0E\05\01\0B\0C\0B\08\02\0C\0B\01\09\09\0F\00\06\03\0A\00\06\04\06\01\06\02\03\0D\0A\0E\00\0B\00\0D\05\0B\09\02\05\05\01\0A\06\07\01\0B\07\04\0A\00\0F\0E\06\0F\04\00\00\03\0F\0D\04\06\0C\0D\04\0B\09\06\0E\08\09\03\09\01\0C\0B\00\06\05\0F\01\0D\0B\07\06\06\0F\04\08\06\0A\03\0F\06\0A\0A\0E\00\09\09\07\02\08\07\01\0A\00\01\00\07\03\06\02\00\07\01\08\02\0B\05\05\00\06\09\0E\06\05\0C\00\0C\08\08\06\05\04\0C\07\03\0A\0B\0D\05\05\02\03\04\09\06\0E\07\02\05\00\00\0E\0D\04\09\05\09\0D\04\08\0F\03\0C\0A\0E\05\07\06\06\05\0F\03\0A\0F\04\0A\01\0D\07\00\0A\0F\00\03\02\02\04\0C\0D\07\0C\03\07\0A\02\04\0C\05\08\0F\01\05\0B\00\0D\06\06\0F\04\07\0E\06\01\02\07\08\07\08\0A\06\01\03\0E\05\06\05\09\09\07\00\08\0D\09\04\02\03\01\00\0B\0B\0D\0F\04\0F\06\06\0D\0E\04\07\0E\0C\0D\08\00\00\0A\0E\0F\0E\09\08\08\09\0E\0D\04\02\00\04\0C\09\0A\02\0D\09\02\05\0E\09\09\04\00\07\04\01\03\02\01\0F\01\0A\03\00\00\09\00\06\0A\03\0B\06\0E\04\01\0E\0A\05\0A\0B\02\05\0F\02\01\03\06\0A\05\08\02\07\02\04\04\02\03\0E\02\02\03\0E\0D\05\0B\04\0D\0F\08\02\05\04\0C\0F\0F\06\0E\08\02\0C\03\00\03\0C\09\07\06\0E\0F\0A\08\0F\0A\05\05\09\03\07\03\04\04\0C\03\0D\0D\01\06\0B\00\03\01\00\08\0C\0E\0E\08\0A\09\03\0F\05\04\06\0F\01\0F\0F\05\0B\05\0B\03\07\02\01\0B\08\0B\02\04\0B\02\0B\06\0E\0F\03\02\0C\0C\0B\0D\09\01\0D\03\04\07\04\0C\05\03\01\0F\06\0B\0D\0B\0B\0D\0F\08\06\09\01\09\0C\00\08\0A\0C\03\0E\08\00\01\04\08\02\03\02\0D\0F\03\00\04\05\0E\06\0E\01\0F\0E\06\07\06\0B\07\04\0C\09\07\0A\08\0A\06\02\0A\06\08\0C\02\02\05\0B\08\07\0E\00\03\09\04\0B\09\0D\06\05\02\08\0C\0E\05\0A\02\01\0E\0B\0F\0D\06\01\0C\07\05\01\06\07\08\04\02\04\07\0B\0E\08\01\05\0A\04\0C\0C\0C\09\04\08\04\00\0C\06\0E\05\0B\02\08\02\0D\06\09\0B\0F\06\0E\02\07\02\07\02\00\07\0E\0B\00\05\0B\09\0E\04\03\00\0F\00\00\0C\0E\0F\09\0E\0D\05\07\02\04\0D\0A\04\0E\0F\0F\03\09\0E\0A\0F\04\00\01\09\0B\06\0E\06\00\0E\06\03\05\07\0B\07\05\03\00\00\03\0A\09\07\0B\0E\01\0D\0B\01\07\05\0C\0F\0C\07\03\0C\09\0C\09\0C\04\09\07\01\04\05\05\08\0F\0A\0D\0A\0F\0A\00\06\0F\0A\04\0C\0A\00\0C\09\01\00\06\01\02\05\07\0F\00\0D\03\0E\0C\05\03\09\02\0A\09\01\04\0C\0E\08\07\00\05\0B\07\08\05\0F\02\07\05\0E\0A\03\0F\0B\04\00\02\09\02\06\0E\0F\06\0D\0E\0E\0A\0B\0A\05\05\07\08\0A\07\06\07\0A\03\08\08\02\00\09\08\0A\02\0A\02\0D\0F\0B\04\06\0D\06\09\05\01\0B\0D\03\05\02\06\08\0F\06\0A\0B\06\0A\0F\0A\02\0A\03\0B\01\03\03\06\0A\08\0E\07\02\05\0E\07\08\00\00\01\0A\0D\07\01\09\0A\02\04\0E\02\00\0C\01\0D\05\04\05\07\09\03\08\02\02\0E\0D\0A\09\00\0F\01\06\00\04\09\0F\05\0E\04\03\00\09\0E\0B\0F\03\0E\04\07\09\0A\0B\07\05\06\0A\07\03\00\06\01\04\05\07\05\0C\06\07\04\0C\02\00\0C\03\06\0D\03\0B\02\03\00\00\08\0C\00\07\04\0D\0A\0C\02\04\0F\02\09\07\02\0D\06\04\05\09\0F\08\0E\00\08\06\0C\0C\05\07\0C\03\03\0F\00\0B\0A\0F\02\0C\05\00\01\0B\04\0F\09\04\02\08\0A\0C\0E\08\0E\0F\06\0B\0C\0D\07\05\0F\0D\0A\08\00\02\02\07\00\08\01\09\0E\09\04\04\00\02\07\02\09\0B\0C\05\0D\09\0A\06\06\0B\06\02\03\0A\0B\0B\08\07\06\03\0C\0F\0E\09\09\0E\0D\08\00\0C\05\04\06\02\03\07\03\08\03\04\02\0E\07\00\05\0C\04\03\04\01\04\04\02\06\03\06\0B\01\0B\0E\0E\0B\03\0D\04\04\05\0F\0F\03\01\07\0A\09\00\03\0E\05\07\07\0F\09\06\06\01\08\06\04\01\0E\0E\0C\04\0A\02\02\05\0E\02\06\03\02\0E\0B\07\05\08\03\0D\00\06\00\0A\05\01\06\09\00\01\02\07\08\0F\01\0F\02\04\0C\02\00\0B\03\08\0E\08\0B\06\01\07\02\03\02\07\07\06\00\03\06\00\0A\0D\08\06\06\09\04\0C\04\0B\0E\05\06\06\0B\0A\00\0A\0A\05\04\0C\0A\00\04\0B\04\02\08\0A\02\02\07\09\0D\00\03\0A\0D\00\03\0B\07\06\0C\02\07\04\02\0B\09\0C\0B\08\01\0D\0B\0D\02\0F\04\0C\07\03\04\0E\09\0B\07\0A\04\00\01\0C\0C\04\01\02\09\0C\00\0C\0D\0F\04\03\0C\0B\0D\04\0E\0F\08\0D\06\0E\01\0A\00\04\05\0E\0E\01\0E\04\0C\09\0B\09\04\0A\02\04\0D\01\01\0F\0E\0E\02\0A\0F\01\0F\06\06\0B\0A\0E\0B\0D\01\0B\0D\09\01\0C\0B\0F\03\08\0D\0F\03\0C\09\0C\0D\0E\08\08\05\06\0E\0D\05\01\09\0E\07\00\0F\0E\06\02\0F\0A\0B\09\07\00\0F\09\00\06\0B\0F\00\0B\0B\0E\0A\05\06\0C\01\0A\0F\08\05\09\0D\0A\01\08\0F\0D\0A\0D\0B\0A\02\02\0E\03\07\0D\06\01\06\09\0B\04\01\0D\05\0D\0E\03\0E\06\0C\04\04\05\06\03\01\07\06\01\0A\03\0C\06\0A\0D\0E\0A\01\0A\06\01\05\05\09\07\05\05\0F\05\04\07\0B\03\0B\02\08\00\06\01\0F\06\0F\07\0A\03\0A\07\0C\08\0C\07\02\0C\03\05\01\0C\01\0A\06\0B\0A\00\09\0C\00\04\08\03\0D\0E\08\03\09\07\04\02\08\0D\06\02\03\03\03\0A\0B\06\02\08\0C\08\08\0F\0D\04\02\02\09\00\09\09\09\0F\0F\05\03\03\09\02\04\0C\06\02\07\03\0A\0E\0B\0E\05\01\03\02\07\05\09\03\04\08\07\09\01\09\08\0B\0A\04\0A\04\09\0C\0D\01\01\0B\0A\0B\09\01\0D\0F\0C\0F\01\0A\01\02\0E\00\08\0A\0A\05\06\05\0C\08\09\03\07\0C\0D\0A\04\01\0E\0B\0D\0A\03\07\09\0A\06\09\0A\0A\00\0C\0F\00\06\09\04\05\0E\0E\05\08\0B\00\0A\09\0E\06\0A\0B\0F\0F\0E\0C\00\01\05\02\06\05\03\06\05\09\0C\04\01\09\0A\0E\05\04\09\0C\0D\0D\0E\05\08\04\06\0C\0D\00\02\03\0E\01\07\09\0C\0D\07\0A\0E\03\06\03\00\02\08\06\06\0F\07\0C\00\07\0A\03\07\04\0D\0F\0A\0A\07\08\04\0D\0D\09\0E\0A\03\02\0B\01\08\0C\04\0C\00\0D\08\02\0E\05\0A\04\06\02\04\08\0C\0B\08\06\0A\06\05\03\0B\0F\01\06\07\06\03\08\04\0A\0E\0A\01\07\06\0D\0E\0F\01\0E\0E\0E\0B\04\0D\06\01\00\0B\06\01\0E\05\0B\02\03\02\08\0B\01\0C\0A\07\02\04\09\0A\0F\08\00\0A\0A\00\0B\05\0F\03\0B\02\04\0B\00\0C\08\08\01\03\08\09\0F\05\0A\0B\02\01\0B\08\06\01\04\0E\07\03\04\0B\0D\0D\02\04\08\09\09\0A\09\04\08\06\0E\08\08\03\0B\0C\0E\02\03\03\05\06\0F\0D\00\04\0B\07\01\06\07\04\06\05\0F\0D\0C\03\07\00\03\08\0B\04\0F\01\0D\0F\0C\03\04\03\0F\09\08\01\0E\03\06\08\09\0F\06\07\01\01\02\0D\01\0B\0B\00\02\00\0C\00\04\0C\02\05\08\07\0C\09\0F\05\02\0F\0B\00\09\0F\0E\05\0F\0B\0F\0A\08\0B\08\01\0C\0E\08\07\06\05\0B\08\0C\0D\02\0A\0B\01\02\09\0D\00\0C\0D\0D\03\00\0D\0F\0E\0C\03\07\09\05\06\0A\06\0D\05\02\09\0A\0E\0C\0F\08\02\09\0B\04\09\0D\05\0F\0A\05\02\06\0B\00\06\0F\00\07\09\06\02\09\09\05\0D\0E\05\0A\07\0C\01\01\05\01\0D\0D\0A\0F\05\0A\0F\03\06\04\0A\00\09\09\08\0D\03\0D\0E\0C\0C\00\0E\0A\0E\04\05\06\01\0F\0E\01\08\01\00\05\0A\0D\0D\04\09\04\00\06\0D\0D\0B\03\00\00\0B\0E\02\07\06\0C\02\0C\06\07\0B\00\0A\05\0B\0F\08\0F\0C\0A\02\0F\02\06\0A\08\0A\0B\0A\01\08\00\0B\0B\08\0A\02\09\0A\04\08\0E\00\0C\0B\06\0E\03\01\00\0A\04\06\0C\0A\0B\00\04\05\00\01\03\05\0C\00\00\0C\00\00\0A\0F\0D\07\02\06\00\06\0B\08\05\01\03\04\00\0B\00\0C\02\02\02\08\0B\03\04\05\0F\04\04\05\02\02\00\09\00\0E\0D\03\01\06\05\0A\03\04\06\03\00\05\02\03\0E\04\0B\0F\06\03\0C\03\0A\09\0F\02\04\03\08\00\0E\07\0B\03\07\0A\0D\0E\04\0C\0D\07\0B\04\05\05\08\02\0D\0B\08\0A\06\0D\08\05\01\00\08\0E\05\09\04\0D\0A\04\03\01\08\08\0B\0E\02\0D\0E\0C\00\03\0C\0C\03\0C\06\04\06\02\05\0F\0A\03\0A\08\07\09\00\0E\0C\04\0B\05\0B\03\0E\09\0C\0A\05\05\0F\01\0C\07\0F\0E\0E\0C\03\05\0C\0F\09\0A\0C\09\07\03\0E\09\01\0E\06\08\06\0C\01\0D\01\05\05\00\03\09\00\06\0F\0B\0C\0F\0B\03\09\0D\0A\01\06\0E\0A\07\0D\04\0B\01\0E\0E\02\00\00\02\03\0C\07\0C\04\00\0A\07\0F\09\0D\0D\08\0B\07\0B\09\08\06\05\09\03\00\0A\02\0B\0A\05\04\09\01\07\06\0B\07\0D\0B\0E\06\0C\08\07\03\07\06\0B\08\0F\02\08\08\05\0B\09\01\0A\0D\0E\0B\0A\0C\00\0B\0C\0F\00\05\09\09\01\00\0C\0A\03\09\0E\06\02\0F\02\0F\09\01\07\03\0A\07\0C\00\09\01\02\0F\01\03\0C\08\05\0A\0F\0F\0C\0F\0D\06\08\0E\0B\00\00\0B\0A\0A\0C\0E\0C\04\03\03\03\0F\03\03\0A\0F\0B\05\0C\0D\05\0A\0F\06\0B\06\03\05\03\0D\0A\08\03\0C\05\0C\0F\05\0B\04\0F\0A\0D\09\02\0F\0C\08\0F\00\0D\0B\05\0B\09\0D\02\0B\03\06\0C\0E\00\04\0E\07\09\0B\09\0D\0F\0E\0B\0C\04\0E\0F\08\03\05\0C\02\07\0C\04\05\01\0C\0A\03\09\0B\03\0F\08\02\0D\03\0E\05\07\04\09\08\0B\0E\09\07\03\03\0B\05\07\09\02\0B\08\04\06\0B\09\04\04\0E\02\0A\08\09\09\0B\03\0B\02\0E\0C\0D\0D\09\0C\09\0A\04\0A\03\01\09\05\08\0B\0C\02\0D\05\09\00\05\0F\09\0B\0A\01\02\03\0A\0D\05\05\0B\09\06\0F\08\09\07\0D\09\05\0E\05\09\03\01\02\0C\0B\02\03\03\04\0C\06\0F\02\0A\01\00\04\0F\08\03\01\05\06\00\08\09\06\0B\04\04\01\09\06\00\00\09\02\02\03\0F\0C\0C\09\01\0D\0B\02\0B\0A\0C\05\03\0D\09\02\08\0E\0A\0E\07\0E\0D\05\08\0C\02\06\0E\0F\09\09\0E\0A\08\06\0C\0B\02\0A\0E\02\01\0E\0C\0C\02\09\08\08\0C\03\08\04\0C\09\07\0A\0F\05\0C\06\0E\0E\07\08\0E\07\0E\01\0C\04\0B\08\0C\0B\08\0F\0D\06\02\0F\09\0E\0A\00\00\0C\0B\0A\06\0B\04\0B\0E\01\08\04\05\09\03\03\00\0B\06\0A\00\0B\0A\0B\04\0B\05\0A\06\00\06\02\04\0E\01\02\00\09\08\02\03\0B\0A\05\03\06\09\0B\00\0F\03\03\0F\05\04\0E\05\07\06\08\08\08\00\06\0F\04\0C\00\05\0E\0C\09\06\0B\0E\07\01\01\01\03\0C\0C\03\05\0C\09\08\02\01\0B\02\0E\07\06\0F\03\02\07\0C\07\07\08\01\0F\0A\0E\00\0A\07\03\01\01\09\09\04\05\04\02\0B\0D\0F\0B\00\04\0C\03\05\04\05\0D\05\06\0E\01\05\0A\08\08\06\06\0D\00\01\0C\0C\03\0A\04\09\0C\0C\07\0E\0F\04\08\02\0B\08\01\04\03\0E\0A\04\06\06\08\0A\09\09\0B\06\07\09\00\03\09\02\00\0E\06\0C\03\09\09\06\06\06\02\0B\08\03\0B\0B\07\0C\0A\09\0E\0F\09\0D\00\0D\0F\0C\0D\05\0D\0A\05\00\03\06\07\09\0E\04\0D\00\0E\05\05\02\04\0F\0B\08\0D\01\0C\0B\06\04\0F\0C\0A\0A\06\01\07\03\07\04\03\0D\0E\0D\07\09\0A\03\0C\00\0D\08\00\0E\0F\0E\0B\00\00\0F\06\0D\0A\0C\06\0A\0F\0D\09\07\0E\0B\04\00\0D\0A\05\0F\0F\0D\0C\00\06\02\08\03\0E\0B\04\0B\08\02\0D\0D\03\07\07\09\0D\06\04\03\05\0A\00\09\01\09\06\0E\0E\00\03\06\04\03\07\00\01\0F\0F\0D\02\0B\02\02\06\0B\0E\05\06\09\0B\01\01\0C\09\02\06\0E\0E\0D\01\0B\03\0D\0E\09\0F\02\01\03\0D\04\0D\0A\08\04\09\00\09\0B\05\07\09\0F\0F\02\02\00\01\08\0F\0F\01\0F\0A\01\0C\0C\07\01\02\08\0A\0C\02\08\04\0A\04\0B\0F\05\03\0F\0D\0F\07\01\08\0B\05\05\0C\0C\03\07\0A\0B\0E\0B\09\0E\04\01\06\06\04\05\07\03\05\0D\05\03\04\0C\09\03\00\0C\06\0A\0D\0F\0A\0D\06\08\0B\07\0D\01\02\02\0C\0D\06\01\07\00\03\00\0E\09\02\02\0D\01\04\07\00\03\04\03\09\05\00\0A\0A\02\0E\00\02\0C\04\0E\06\0F\0B\02\0C\0F\0C\0C\09\04\07\0F\02\0A\09\01\03\06\04\0B\0F\02\0A\0B\0C\08\07\0E\01\0E\05\00\0B\0A\07\07\01\06\06\08\01\03\04\09\0B\03\09\0F\01\0F\08\0E\04\0D\0B\0E\01\03\03\01\0F\07\06\0E\0F\07\08\05\0F\0C\00\0E\05\05\05\0D\0B\06\0B\0B\02\01\0F\05\0D\0C\0B\05\08\02\03\0D\0E\05\0A\0E\05\0C\01\04\00\09\04\0D\05\0F\0E\00\01\0C\09\01\0B\0B\0B\06\0C\0F\0C\0A\03\0B\01\0D\0B\09\0B\00\0B\08\0B\07\0D\04\05\09\00\00\0F\01\07\01\0C\04\0E\09\02\00\01\03\0C\0B\0F\01\03\0C\01\06\0C\0A\09\02\05\0E\08\0A\08\09\07\03\01\05\09\0E\08\03\05\06\09\0D\03\0C\04\01\04\01\04\00\04\0F\03\04\06\0A\0D\0B\01\0F\0B\01\05\02\0A\07\0A\02\04\00\03\08\08\07\0D\0A\07\0B\0C\00\0D\0C\09\09\05\09\01\01\0B\06\0C\07\0B\01\07\0C\0F\07\05\0E\02\04\09\0F\07\09\01\06\0A\05\07\0C\04\09\07\0D\02\06\0A\0C\03\06\05\04\0B\06\00\07\06\0E\05\03\02\02\0E\0A\0A\01\08\09\01\01\09\0B\07\02\00\0C\05\02\01\0A\04\0E\04\0B\02\09\08\00\0C\09\0E\00\08\07\0C\00\0E\04\00\0A\09\00\09\0C\0B\0E\08\07\0A\02\06\0A\0A\0D\0E\02\06\0A\04\03\0D\02\0B\00\0D\0D\08\05\0F\04\0F\00\02\0E\02\04\07\0A\04\01\00\0A\09\0F\08\0D\0D\09\0B\0D\09\0D\0F\0F\0A\09\0D\08\0A\03\0A\02\02\02\00\00\0C\03\0E\0B\05\09\0C\0E\04\08\03\06\0A\02\04\07\02\04\0E\01\05\02\0C\04\01\05\0C\0E\04\0C\05\00\09\01\0D\0E\0E\08\06\05\03\03\0C\0E\0E\0B\08\01\00\01\0B\07\09\0D\04\0F\04\09\0B\09\0D\06\0E\08\05\01\01\05\06\00\0E\08\00\05\05\0C\05\03\0D\00\01\05\09\04\01\02\04\05\0F\07\07\0E\0D\02\05\09\00\08\0D\07\0D\0B\03\01\0E\02\00\0F\03\04\0B\0F\08\08\00\08\01\0C\0C\06\01\06\07\0C\05\04\04\06\0C\02\06\04\00\0D\04\0E\03\04\0E\0F\08\0F\05\05\05\08\0F\02\0F\0D\04\01\07\08\09\0C\00\09\02\0B\0E\09\0B\0E\0B\0B\0A\03\0C\01\0B\0B\04\0A\0D\00\07\0B\0B\04\0C\06\02\03\0C\05\0A\0A\02\09\03\04\05\00\01\0F\00\00\0C\02\0B\0C\0F\0A\0C\09\08\02\0C\0E\02\0D\03\08\09\05\03\01\0F\0E\0B\0F\07\06\0C\0E\08\0F\08\0A\0E\03\0E\0D\05\04\07\0A\03\02\07\0E\07\06\08\02\0A\01\08\03\08\0F\06\0C\07\05\0F\03\0F\07\04\0B\0D\04\08\01\04\03\04\0B\00\02\03\0D\0A\0B\00\09\07\06\0C\03\09\02\0B\05\03\01\05\08\0C\07\06\0E\01\08\07\05\0D\0F\00\0D\0E\07\0A\08\0E\0A\0E\00\0C\07\05\09\07\0F\02\01\0B\0C\09\01\0C\0A\06\0F\0A\0B\01\09\09\08\02\0F\0F\02\0A\0E\03\04\0C\04\04\0C\0C\06\05\0E\0C\0F\0E\0B\0B\0D\0C\07\0B\0B\02\09\00\02\0F\0E\07\07\06\04\0F\0C\04\04\0C\01\05\09\08\07\05\06\0E\03\00\01\0E\06\05\02\07\0B\07\0F\01\0E\04\0E\0D\0C\0E\0F\0E\0C\0F\0F\06\0E\09\0F\0A\0D\02\06\0B\05\00\07\04\0F\02\07\05\07\02\04\0B\00\0B\0C\07\0F\0E\03\0B\0A\04\02\0A\01\00\0E\0B\06\06\05\07\02\04\05\0F\00\03\06\0C\0B\0D\0F\0B\00\00\0B\06\0A\02\07\06\06\0A\04\07\03\09\0F\02\0D\09\0C\0F\0D\06\00\06\03\0A\06\09\04\0D\0D\0F\0F\0B\02\08\0F\07\01\04\0C\00\03\07\08\01\09\0E\0D\05\09\0A\02\0D\0D\07\08\08\09\01\0A\0C\02\0C\0E\0C\06\0F\02\01\01\06\07\07\0E\04\01\02\0C\0C\06\0D\0A\03\0D\07\03\05\03\02\05\05\07\01\05\0F\0F\0D\06\03\09\09\05\0B\09\0F\0C\0A\09\0A\09\08\0E\0C\00\05\09\04\0A\04\01\05\02\0A\0D\04\02\09\04\08\09\07\0B\00\02\0D\0D\0C\09\08\0F\0C\06\0F\09\00\04\04\0F\0E\00\00\00\0A\0B\0F\02\0A\04\09\01\09\09\0C\06\07\0A\08\07\0F\05\0A\0C\0A\0B\0A\03\08\03\09\05\07\0A\07\0A\0F\0F\0E\0C\00\0F\07\06\07\06\0F\00\01\0F\04\05\0F\0F\0E\0E\07\08\0C\00\0C\07\05\05\0F\08\02\07\0E\0A\05\05\07\0F\0C\07\01\00\0B\0D\06\09\0B\0B\0A\0D\02\0D\01\07\07\0E\08\0D\00\04\0F\01\00\03\03\07\03\07\06\0A\00\08\01\0E\04\0E\0A\0F\02\0D\0B\08\09\0A\03\03\02\08\0D\03\0E\04\0B\0C\0F\0F\0D\06\06\07\0C\08\00\08\08\04\0C\0E\0B\01\07\08\0D\02\01\0B\0A\0D\09\05\0D\0E\06\03\0D\0C\07\04\07\0B\05\0E\0A\0A\09\06\02\0C\0F\07\0C\03\06\00\02\08\09\09\0C\06\0A\0B\0C\0C\00\04\0F\00\0B\07\07\07\09\00\08\02\02\02\05\00\0E\00\04\06\02\0C\09\08\05\09\0E\0C\0D\0B\09\0D\08\01\03\0F\00\03\00\0F\00\04\0F\00\0A\09\0A\08\02\09\0C\08\0F\01\03\08\03\0F\01\00\00\01\0A\07\02\09\03\0C\0E\07\0C\0A\06\07\0C\0B\01\00\07\0E\08\0D\09\00\0B\0D\00\0D\03\0C\03\09\02\00\0F\07\03\06\08\00\04\00\02\0E\07\0D\0A\02\03\07\0E\0F\0D\04\0E\05\08\09\08\00\0E\06\0E\0F\0F\00\08\0B\0C\09\07\01\0D\02\00\01\02\0C\0B\0B\0A\0E\04\04\06\08\03\0C\08\01\07\0A\09\05\09\06\0B\0B\0A\08\0D\0E\02\02\09\0D\0A\04\05\0B\03\04\07\08\00\09\0B\08\07\0B\0B\00\07\01\0D\01\03\0F\02\03\0E\03\02\07\00\0A\08\0B\04\01\07\02\03\0D\00\0B\04\07\06\01\02\02\0E\01\0E\06\00\05\0F\05\02\0F\07\0B\06\05\03\06\03\03\04\03\04\0E\08\0D\04\02\0A\01\04\0B\0D\0B\0D\0E\0D", align 1, !dbg !32
@first_time = internal unnamed_addr global i1 false, align 4, !dbg !46
@.str = private unnamed_addr constant [10 x i8] c"SNOVA_ABQ\00", align 1, !dbg !40
@__const.init_gf_tables.F_star = private unnamed_addr constant [15 x i8] c"\01\02\04\08\03\06\0C\0B\05\0A\07\0E\0F\0D\09", align 1
@KeccakF_RoundConstants = internal unnamed_addr constant [24 x i64] [i64 1, i64 32898, i64 -9223372036854742902, i64 -9223372034707259392, i64 32907, i64 2147483649, i64 -9223372034707259263, i64 -9223372036854743031, i64 138, i64 136, i64 2147516425, i64 2147483658, i64 2147516555, i64 -9223372036854775669, i64 -9223372036854742903, i64 -9223372036854743037, i64 -9223372036854743038, i64 -9223372036854775680, i64 32778, i64 -9223372034707292150, i64 -9223372034707259263, i64 -9223372036854742912, i64 2147483649, i64 -9223372034707259384], align 8, !dbg !47
@DRBG_ctx = dso_local global %struct.AES256_CTR_DRBG_struct zeroinitializer, align 4, !dbg !62
@.str.37 = private unnamed_addr constant [19 x i8] c"../../../src/aes.c\00", align 1, !dbg !81
@.str.1 = private unnamed_addr constant [17 x i8] c"inputByteLen > 0\00", align 1, !dbg !87
@Rcon = internal unnamed_addr constant [10 x i8] c"\01\02\04\08\10 @\80\1B6", align 1, !dbg !92
@.str.2 = private unnamed_addr constant [24 x i8] c"plaintext_len % 16 == 0\00", align 1, !dbg !120

; Function Attrs: nounwind
define dso_local range(i32 -1, 1) i32 @main() local_unnamed_addr #0 !dbg !134 {
entry:
  %call = call fastcc i32 @example_snova() #3, !dbg !138
  ret i32 %call, !dbg !139
}

; Function Attrs: nounwind
define internal fastcc range(i32 -1, 1) i32 @example_snova() unnamed_addr #0 !dbg !140 {
entry:
  %entropy_input = alloca [48 x i8], align 1
  %mlen = alloca i64, align 8
  %smlen = alloca i64, align 8
  %pk = alloca [1016 x i8], align 1
  %sk = alloca [96 x i8], align 1
  %sm = alloca [304 x i8], align 1
  %msg = alloca [32 x i8], align 1
  %msg2 = alloca [32 x i8], align 1
    #dbg_declare(ptr %entropy_input, !142, !DIExpression(), !146)
    #dbg_value(i32 0, !147, !DIExpression(), !149)
  br label %for.cond, !dbg !150

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !151
    #dbg_value(i32 %i.0, !147, !DIExpression(), !149)
  %exitcond = icmp ne i32 %i.0, 48, !dbg !152
  br i1 %exitcond, label %for.body, label %for.end, !dbg !154

for.body:                                         ; preds = %for.cond
  %conv = trunc nuw nsw i32 %i.0 to i8, !dbg !155
  %arrayidx = getelementptr inbounds nuw [48 x i8], ptr %entropy_input, i32 0, i32 %i.0, !dbg !157
  store i8 %conv, ptr %arrayidx, align 1, !dbg !158
  %inc = add nuw nsw i32 %i.0, 1, !dbg !159
    #dbg_value(i32 %inc, !147, !DIExpression(), !149)
  br label %for.cond, !dbg !160, !llvm.loop !161

for.end:                                          ; preds = %for.cond
  call void @randombytes_init(ptr noundef nonnull %entropy_input, ptr noundef null, i32 noundef 256) #3, !dbg !164
    #dbg_value(i64 32, !165, !DIExpression(), !166)
  store i64 32, ptr %mlen, align 8, !dbg !167
    #dbg_value(i64 0, !168, !DIExpression(), !166)
  store i64 0, ptr %smlen, align 8, !dbg !169
    #dbg_declare(ptr %pk, !170, !DIExpression(), !174)
    #dbg_declare(ptr %sk, !175, !DIExpression(), !179)
    #dbg_declare(ptr %sm, !180, !DIExpression(), !184)
    #dbg_declare(ptr %msg, !185, !DIExpression(), !186)
  call void @snova_memcpy(ptr %msg, ptr @__const.example_snova.msg, i32 32), !dbg !186
    #dbg_declare(ptr %msg2, !187, !DIExpression(), !188)
  call void @snova_memset(ptr %msg2, i8 0, i32 32), !dbg !188
  %call = call i32 @crypto_sign_keypair(ptr noundef nonnull %pk, ptr noundef nonnull %sk) #3, !dbg !189
    #dbg_value(i32 0, !190, !DIExpression(), !166)
  %0 = load i64, ptr %mlen, align 8, !dbg !191
    #dbg_value(i64 %0, !165, !DIExpression(), !166)
    #dbg_value(ptr %smlen, !168, !DIExpression(DW_OP_deref), !166)
  %call8 = call i32 @crypto_sign(ptr noundef nonnull %sm, ptr noundef nonnull %smlen, ptr noundef nonnull %msg, i64 noundef %0, ptr noundef nonnull %sk) #3, !dbg !192
    #dbg_value(i32 %call8, !190, !DIExpression(), !166)
  %cmp9.not = icmp eq i32 %call8, 0, !dbg !193
  br i1 %cmp9.not, label %if.end13, label %err, !dbg !193

if.end13:                                         ; preds = %for.end
  %1 = load i64, ptr %smlen, align 8, !dbg !195
    #dbg_value(i64 %1, !168, !DIExpression(), !166)
    #dbg_value(ptr %mlen, !165, !DIExpression(DW_OP_deref), !166)
  %call17 = call i32 @crypto_sign_open(ptr noundef nonnull %msg2, ptr noundef nonnull %mlen, ptr noundef nonnull %sm, i64 noundef %1, ptr noundef nonnull %pk) #3, !dbg !196
    #dbg_value(i32 %call17, !190, !DIExpression(), !166)
  %cmp18.not = icmp eq i32 %call17, 0, !dbg !197
  br i1 %cmp18.not, label %lor.lhs.false, label %err, !dbg !199

lor.lhs.false:                                    ; preds = %if.end13
  %2 = load i64, ptr %mlen, align 8, !dbg !200
    #dbg_value(i64 %2, !165, !DIExpression(), !166)
  %conv22 = trunc i64 %2 to i32, !dbg !200
  %call23 = call i32 @memcmp(ptr noundef nonnull %msg, ptr noundef nonnull %msg2, i32 noundef %conv22) #4, !dbg !201
  %tobool.not = icmp ne i32 %call23, 0, !dbg !201
  %spec.select = sext i1 %tobool.not to i32, !dbg !199
  br label %err, !dbg !199

err:                                              ; preds = %lor.lhs.false, %if.end13, %for.end
  %res.0 = phi i32 [ -1, %for.end ], [ -1, %if.end13 ], [ %spec.select, %lor.lhs.false ], !dbg !166
    #dbg_value(i32 %res.0, !190, !DIExpression(), !166)
    #dbg_label(!202, !203)
  call void @snova_secure_clear(ptr noundef nonnull %sk, i32 noundef 96) #3, !dbg !204
  ret i32 %res.0, !dbg !205
}

declare dso_local i32 @memcmp(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind
define dso_local void @snova_memset(ptr noundef %dst, i8 noundef zeroext %val, i32 noundef %len) local_unnamed_addr #0 !dbg !206 {
entry:
    #dbg_value(ptr %dst, !210, !DIExpression(), !211)
    #dbg_value(i8 %val, !212, !DIExpression(), !211)
    #dbg_value(i32 %len, !213, !DIExpression(), !211)
    #dbg_value(ptr %dst, !214, !DIExpression(), !211)
    #dbg_value(i32 0, !215, !DIExpression(), !217)
  br label %for.cond, !dbg !218

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !219
    #dbg_value(i32 %i.0, !215, !DIExpression(), !217)
  %exitcond = icmp ne i32 %i.0, %len, !dbg !220
  br i1 %exitcond, label %for.body, label %for.end, !dbg !222

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw i8, ptr %dst, i32 %i.0, !dbg !223
  store i8 %val, ptr %arrayidx, align 1, !dbg !224
  %inc = add i32 %i.0, 1, !dbg !225
    #dbg_value(i32 %inc, !215, !DIExpression(), !217)
  br label %for.cond, !dbg !226, !llvm.loop !227

for.end:                                          ; preds = %for.cond
  ret void, !dbg !229
}

; Function Attrs: nounwind
define dso_local void @snova_memcpy(ptr noundef %dst, ptr noundef %src, i32 noundef %len) local_unnamed_addr #0 !dbg !230 {
entry:
    #dbg_value(ptr %dst, !235, !DIExpression(), !236)
    #dbg_value(ptr %src, !237, !DIExpression(), !236)
    #dbg_value(i32 %len, !238, !DIExpression(), !236)
    #dbg_value(ptr %dst, !239, !DIExpression(), !236)
    #dbg_value(ptr %src, !240, !DIExpression(), !236)
    #dbg_value(i32 0, !243, !DIExpression(), !245)
  br label %for.cond, !dbg !246

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !247
    #dbg_value(i32 %i.0, !243, !DIExpression(), !245)
  %exitcond = icmp ne i32 %i.0, %len, !dbg !248
  br i1 %exitcond, label %for.body, label %for.end, !dbg !250

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw i8, ptr %src, i32 %i.0, !dbg !251
  %0 = load i8, ptr %arrayidx, align 1, !dbg !251
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %dst, i32 %i.0, !dbg !252
  store i8 %0, ptr %arrayidx1, align 1, !dbg !253
  %inc = add i32 %i.0, 1, !dbg !254
    #dbg_value(i32 %inc, !243, !DIExpression(), !245)
  br label %for.cond, !dbg !255, !llvm.loop !256

for.end:                                          ; preds = %for.cond
  ret void, !dbg !258
}

; Function Attrs: nounwind
define dso_local i32 @crypto_sign_keypair(ptr noundef %pk, ptr noundef %sk) local_unnamed_addr #0 !dbg !259 {
entry:
  %seed = alloca [48 x i8], align 1
    #dbg_value(ptr %pk, !264, !DIExpression(), !265)
    #dbg_value(ptr %sk, !266, !DIExpression(), !265)
    #dbg_declare(ptr %seed, !267, !DIExpression(), !269)
  %call = call i32 @randombytes(ptr noundef nonnull %seed, i64 noundef 48) #3, !dbg !270
  %call2 = call i32 @_SNOVA_I_S_AES_ref_genkeys(ptr noundef %pk, ptr noundef %sk, ptr noundef nonnull %seed) #3, !dbg !271
    #dbg_value(i32 0, !272, !DIExpression(), !265)
  call void @snova_secure_clear(ptr noundef nonnull %seed, i32 noundef 48) #3, !dbg !273
  ret i32 0, !dbg !274
}

; Function Attrs: nounwind
define dso_local range(i32 -1, 1) i32 @crypto_sign(ptr noundef %sm, ptr noundef %smlen, ptr noundef %m, i64 noundef %mlen, ptr noundef %sk) local_unnamed_addr #0 !dbg !275 {
entry:
  %skx_d = alloca [96 x i8], align 1
  %salt = alloca [16 x i8], align 1
  %digest = alloca [64 x i8], align 1
  %sig = alloca [272 x i8], align 1
    #dbg_value(ptr %sm, !280, !DIExpression(), !281)
    #dbg_value(ptr %smlen, !282, !DIExpression(), !281)
    #dbg_value(ptr %m, !283, !DIExpression(), !281)
    #dbg_value(i64 %mlen, !284, !DIExpression(), !281)
    #dbg_value(ptr %sk, !285, !DIExpression(), !281)
    #dbg_declare(ptr %skx_d, !286, !DIExpression(), !288)
    #dbg_value(ptr %skx_d, !289, !DIExpression(), !281)
  %call = call i32 @_SNOVA_I_S_AES_ref_sk_expand(ptr noundef nonnull %skx_d, ptr noundef %sk) #3, !dbg !290
    #dbg_value(i32 0, !291, !DIExpression(), !281)
    #dbg_declare(ptr %salt, !292, !DIExpression(), !293)
  %call2 = call i32 @randombytes(ptr noundef nonnull %salt, i64 noundef 16) #3, !dbg !294
    #dbg_declare(ptr %digest, !295, !DIExpression(), !297)
  %conv = trunc i64 %mlen to i32, !dbg !298
  call void @shake256(ptr noundef nonnull %digest, i32 noundef 64, ptr noundef %m, i32 noundef %conv) #3, !dbg !299
    #dbg_declare(ptr %sig, !300, !DIExpression(), !304)
  %call7 = call i32 @_SNOVA_I_S_AES_ref_sign(ptr noundef nonnull %skx_d, ptr noundef nonnull %sig, ptr noundef nonnull %digest, i32 noundef 64, ptr noundef nonnull %salt) #3, !dbg !305
    #dbg_value(i32 %call7, !291, !DIExpression(), !281)
  %tobool8.not = icmp eq i32 %call7, 0, !dbg !306
  br i1 %tobool8.not, label %if.then9, label %if.end14, !dbg !308

if.then9:                                         ; preds = %entry
  %add.ptr = getelementptr inbounds nuw i8, ptr %sm, i32 272, !dbg !309
  %conv10 = trunc i64 %mlen to i32, !dbg !311
  %call11 = call ptr @memmove(ptr noundef nonnull %add.ptr, ptr noundef %m, i32 noundef %conv10) #4, !dbg !312
  %call13 = call ptr @memcpy(ptr noundef %sm, ptr noundef nonnull %sig, i32 noundef 272) #4, !dbg !313
  %add = add i64 %mlen, 272, !dbg !314
  store i64 %add, ptr %smlen, align 8, !dbg !315
  br label %if.end14, !dbg !316

if.end14:                                         ; preds = %if.then9, %entry
  call void @snova_secure_clear(ptr noundef nonnull %skx_d, i32 noundef 96) #3, !dbg !317
  ret i32 %call7, !dbg !318
}

declare dso_local ptr @memmove(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #1

declare dso_local ptr @memcpy(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind
define dso_local range(i32 -1, 1) i32 @crypto_sign_open(ptr noundef %m, ptr noundef %mlen, ptr noundef %sm, i64 noundef %smlen, ptr noundef %pk) local_unnamed_addr #0 !dbg !319 {
entry:
  %pkx = alloca [86784 x i8], align 1
  %digest = alloca [64 x i8], align 1
    #dbg_value(ptr %m, !320, !DIExpression(), !321)
    #dbg_value(ptr %mlen, !322, !DIExpression(), !321)
    #dbg_value(ptr %sm, !323, !DIExpression(), !321)
    #dbg_value(i64 %smlen, !324, !DIExpression(), !321)
    #dbg_value(ptr %pk, !325, !DIExpression(), !321)
  %cmp = icmp ult i64 %smlen, 272, !dbg !326
  br i1 %cmp, label %return, label %if.end, !dbg !326

if.end:                                           ; preds = %entry
    #dbg_declare(ptr %pkx, !328, !DIExpression(), !332)
    #dbg_value(ptr %pkx, !333, !DIExpression(), !321)
  %call = call i32 @_SNOVA_I_S_AES_ref_pk_expand(ptr noundef nonnull %pkx, ptr noundef %pk) #3, !dbg !334
    #dbg_value(i32 %call, !335, !DIExpression(), !321)
  %tobool.not = icmp eq i32 %call, 0, !dbg !336
  br i1 %tobool.not, label %if.end2, label %return, !dbg !336

if.end2:                                          ; preds = %if.end
    #dbg_declare(ptr %digest, !338, !DIExpression(), !339)
  %add.ptr = getelementptr inbounds nuw i8, ptr %sm, i32 272, !dbg !340
  %0 = trunc i64 %smlen to i32, !dbg !341
  %conv = add i32 %0, -272, !dbg !341
  call void @shake256(ptr noundef nonnull %digest, i32 noundef 64, ptr noundef nonnull %add.ptr, i32 noundef %conv) #3, !dbg !342
  %call5 = call i32 @_SNOVA_I_S_AES_ref_verify(ptr noundef nonnull %pkx, ptr noundef %sm, ptr noundef nonnull %digest, i32 noundef 64) #3, !dbg !343
    #dbg_value(i32 %call5, !335, !DIExpression(), !321)
  %tobool6.not = icmp eq i32 %call5, 0, !dbg !344
  br i1 %tobool6.not, label %if.then7, label %return, !dbg !346

if.then7:                                         ; preds = %if.end2
  %add.ptr8 = getelementptr inbounds nuw i8, ptr %sm, i32 272, !dbg !347
  %1 = trunc i64 %smlen to i32, !dbg !349
  %conv10 = add i32 %1, -272, !dbg !349
  %call11 = call ptr @memmove(ptr noundef %m, ptr noundef nonnull %add.ptr8, i32 noundef %conv10) #4, !dbg !350
  %sub12 = add i64 %smlen, -272, !dbg !351
  store i64 %sub12, ptr %mlen, align 8, !dbg !352
  br label %return, !dbg !353

return:                                           ; preds = %if.end2, %if.end, %entry, %if.then7
  %retval.0 = phi i32 [ 0, %if.then7 ], [ -1, %entry ], [ -1, %if.end ], [ -1, %if.end2 ], !dbg !321
  ret i32 %retval.0, !dbg !354
}

; Function Attrs: nounwind
define dso_local void @expand_public(ptr noundef %P_matrix, ptr noundef %seed) local_unnamed_addr #0 !dbg !355 {
entry:
  %pk_bytes = alloca [39960 x i8], align 1
    #dbg_value(ptr %P_matrix, !359, !DIExpression(), !360)
    #dbg_value(ptr %seed, !361, !DIExpression(), !360)
    #dbg_declare(ptr %pk_bytes, !362, !DIExpression(), !366)
  call void @snova_pk_expand(ptr noundef nonnull %pk_bytes, i32 noundef 39960, ptr noundef %seed, i32 noundef 16) #3, !dbg !367
  call fastcc void @convert_bytes_to_GF(ptr noundef %P_matrix, ptr noundef nonnull %pk_bytes, i32 noundef 79920) #3, !dbg !368
  ret void, !dbg !369
}

; Function Attrs: nounwind
define internal fastcc void @convert_bytes_to_GF(ptr noundef %gf_array, ptr noundef nonnull %byte_array, i32 noundef range(i32 4800, 79921) %num) unnamed_addr #0 !dbg !370 {
entry:
    #dbg_value(ptr %gf_array, !373, !DIExpression(), !374)
    #dbg_value(ptr %byte_array, !375, !DIExpression(), !374)
    #dbg_value(i32 %num, !376, !DIExpression(), !374)
    #dbg_value(i32 0, !377, !DIExpression(), !379)
  %0 = lshr i32 %num, 1, !dbg !380
  br label %for.cond, !dbg !380

for.cond:                                         ; preds = %for.body, %entry
  %idx.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !381
    #dbg_value(i32 %idx.0, !377, !DIExpression(), !379)
  %exitcond = icmp ne i32 %idx.0, %0, !dbg !382
  br i1 %exitcond, label %for.body, label %for.end, !dbg !384

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw i8, ptr %byte_array, i32 %idx.0, !dbg !385
  %1 = load i8, ptr %arrayidx, align 1, !dbg !385
  %2 = and i8 %1, 15, !dbg !387
  %mul = shl nuw nsw i32 %idx.0, 1, !dbg !388
  %arrayidx2 = getelementptr inbounds nuw i8, ptr %gf_array, i32 %mul, !dbg !389
  store i8 %2, ptr %arrayidx2, align 1, !dbg !390
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %byte_array, i32 %idx.0, !dbg !391
  %3 = load i8, ptr %arrayidx3, align 1, !dbg !391
  %4 = lshr i8 %3, 4, !dbg !392
  %mul7 = shl nuw nsw i32 %idx.0, 1, !dbg !393
  %add = or disjoint i32 %mul7, 1, !dbg !394
  %arrayidx8 = getelementptr inbounds nuw i8, ptr %gf_array, i32 %add, !dbg !395
  store i8 %4, ptr %arrayidx8, align 1, !dbg !396
  %inc = add nuw nsw i32 %idx.0, 1, !dbg !397
    #dbg_value(i32 %inc, !377, !DIExpression(), !379)
  br label %for.cond, !dbg !398, !llvm.loop !399

for.end:                                          ; preds = %for.cond
  %and9 = and i32 %num, 1, !dbg !401
  %tobool.not = icmp eq i32 %and9, 0, !dbg !401
  br i1 %tobool.not, label %if.end, label %if.then, !dbg !401

if.then:                                          ; preds = %for.end
  %div102 = lshr i32 %num, 1, !dbg !403
  %arrayidx11 = getelementptr inbounds nuw i8, ptr %byte_array, i32 %div102, !dbg !405
  %5 = load i8, ptr %arrayidx11, align 1, !dbg !405
  %6 = and i8 %5, 15, !dbg !406
  %7 = getelementptr i8, ptr %gf_array, i32 %num, !dbg !407
  %arrayidx16 = getelementptr i8, ptr %7, i32 -1, !dbg !407
  store i8 %6, ptr %arrayidx16, align 1, !dbg !408
  br label %if.end, !dbg !409

if.end:                                           ; preds = %if.then, %for.end
  ret void, !dbg !410
}

; Function Attrs: nounwind
define dso_local i32 @_SNOVA_I_S_AES_ref_genkeys(ptr noundef %pk, ptr noundef %sk, ptr noundef %seed) local_unnamed_addr #0 !dbg !411 {
entry:
  %T12 = alloca [2160 x i8], align 1
  %P22 = alloca [2000 x i8], align 1
  %P_matrix = alloca [84720 x i8], align 1
  %F12 = alloca [10800 x i8], align 1
    #dbg_value(ptr %pk, !414, !DIExpression(), !415)
    #dbg_value(ptr %sk, !416, !DIExpression(), !415)
    #dbg_value(ptr %seed, !417, !DIExpression(), !415)
  %.b = load i1, ptr @first_time, align 1, !dbg !418
  br i1 %.b, label %if.end, label %if.then, !dbg !418

if.then:                                          ; preds = %entry
  call fastcc void @snova_init() #3, !dbg !420
  br label %if.end, !dbg !422

if.end:                                           ; preds = %if.then, %entry
    #dbg_declare(ptr %T12, !423, !DIExpression(), !427)
    #dbg_declare(ptr %P22, !428, !DIExpression(), !432)
  call void @snova_memset(ptr %P22, i8 0, i32 2000), !dbg !432
  %add.ptr = getelementptr inbounds nuw i8, ptr %seed, i32 16, !dbg !433
  call fastcc void @expand_T12(ptr noundef nonnull %T12, ptr noundef nonnull %add.ptr) #3, !dbg !434
    #dbg_declare(ptr %P_matrix, !435, !DIExpression(), !439)
  call void @expand_public(ptr noundef nonnull %P_matrix, ptr noundef %seed) #3, !dbg !440
    #dbg_value(ptr %P_matrix, !441, !DIExpression(), !415)
  %add.ptr4 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 58320, !dbg !442
    #dbg_value(ptr %add.ptr4, !443, !DIExpression(), !415)
    #dbg_value(ptr %add.ptr6, !444, !DIExpression(), !415)
    #dbg_declare(ptr %F12, !445, !DIExpression(), !449)
  call void @snova_memset(ptr %F12, i8 0, i32 10800), !dbg !449
    #dbg_value(i32 0, !450, !DIExpression(), !452)
  br label %for.cond, !dbg !453

for.cond:                                         ; preds = %for.inc35, %if.end
  %i1.0 = phi i32 [ 0, %if.end ], [ %inc36, %for.inc35 ], !dbg !454
    #dbg_value(i32 %i1.0, !450, !DIExpression(), !452)
  %exitcond3 = icmp ne i32 %i1.0, 5, !dbg !455
  br i1 %exitcond3, label %for.cond7.preheader, label %for.cond39.preheader, !dbg !457

for.cond7.preheader:                              ; preds = %for.cond
  br label %for.cond7, !dbg !458

for.cond39.preheader:                             ; preds = %for.cond
  br label %for.cond39, !dbg !461

for.cond7:                                        ; preds = %for.cond7.preheader, %for.inc32
  %j1.0 = phi i32 [ %inc33, %for.inc32 ], [ 0, %for.cond7.preheader ], !dbg !463
    #dbg_value(i32 %j1.0, !464, !DIExpression(), !465)
  %exitcond2 = icmp ne i32 %j1.0, 27, !dbg !466
  br i1 %exitcond2, label %for.cond10.preheader, label %for.inc35, !dbg !458

for.cond10.preheader:                             ; preds = %for.cond7
  br label %for.cond10, !dbg !468

for.cond10:                                       ; preds = %for.cond10.preheader, %for.inc29
  %idx.0 = phi i32 [ %inc30, %for.inc29 ], [ 0, %for.cond10.preheader ], !dbg !471
    #dbg_value(i32 %idx.0, !472, !DIExpression(), !473)
  %exitcond1 = icmp ne i32 %idx.0, 27, !dbg !474
  br i1 %exitcond1, label %for.cond13.preheader, label %for.inc32, !dbg !468

for.cond13.preheader:                             ; preds = %for.cond10
  br label %for.cond13, !dbg !476

for.cond13:                                       ; preds = %for.cond13.preheader, %for.body15
  %k1.0 = phi i32 [ %inc, %for.body15 ], [ 0, %for.cond13.preheader ], !dbg !479
    #dbg_value(i32 %k1.0, !480, !DIExpression(), !481)
  %exitcond = icmp ne i32 %k1.0, 5, !dbg !482
  br i1 %exitcond, label %for.body15, label %for.inc29, !dbg !476

for.body15:                                       ; preds = %for.cond13
  %mul = mul nuw nsw i32 %i1.0, 27, !dbg !484
  %add = add nuw nsw i32 %mul, %j1.0, !dbg !486
  %mul16 = mul nuw nsw i32 %add, 5, !dbg !487
  %add17 = add nuw nsw i32 %mul16, %k1.0, !dbg !488
  %mul18 = shl nuw nsw i32 %add17, 4, !dbg !489
  %arrayidx = getelementptr inbounds nuw [10800 x i8], ptr %F12, i32 0, i32 %mul18, !dbg !490
  %mul19 = mul nuw nsw i32 %i1.0, 27, !dbg !491
  %add20 = add nuw nsw i32 %mul19, %j1.0, !dbg !492
  %mul21 = mul nuw nsw i32 %add20, 27, !dbg !493
  %add22 = add nuw nsw i32 %mul21, %idx.0, !dbg !494
  %mul23 = shl nuw nsw i32 %add22, 4, !dbg !495
  %arrayidx24 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 %mul23, !dbg !496
  %mul25 = mul nuw nsw i32 %idx.0, 5, !dbg !497
  %add26 = add nuw nsw i32 %mul25, %k1.0, !dbg !498
  %mul27 = shl nuw nsw i32 %add26, 4, !dbg !499
  %arrayidx28 = getelementptr inbounds nuw [2160 x i8], ptr %T12, i32 0, i32 %mul27, !dbg !500
  call fastcc void @gf_mat_mul_add(ptr noundef nonnull %arrayidx, ptr noundef nonnull %arrayidx24, ptr noundef nonnull %arrayidx28) #3, !dbg !501
  %inc = add nuw nsw i32 %k1.0, 1, !dbg !502
    #dbg_value(i32 %inc, !480, !DIExpression(), !481)
  br label %for.cond13, !dbg !503, !llvm.loop !504

for.inc29:                                        ; preds = %for.cond13
  %inc30 = add nuw nsw i32 %idx.0, 1, !dbg !506
    #dbg_value(i32 %inc30, !472, !DIExpression(), !473)
  br label %for.cond10, !dbg !507, !llvm.loop !508

for.inc32:                                        ; preds = %for.cond10
  %inc33 = add nuw nsw i32 %j1.0, 1, !dbg !510
    #dbg_value(i32 %inc33, !464, !DIExpression(), !465)
  br label %for.cond7, !dbg !511, !llvm.loop !512

for.inc35:                                        ; preds = %for.cond7
  %inc36 = add nuw nsw i32 %i1.0, 1, !dbg !514
    #dbg_value(i32 %inc36, !450, !DIExpression(), !452)
  br label %for.cond, !dbg !515, !llvm.loop !516

for.cond39:                                       ; preds = %for.cond39.preheader, %for.body41
  %i138.0 = phi i32 [ %inc45, %for.body41 ], [ 0, %for.cond39.preheader ], !dbg !518
    #dbg_value(i32 %i138.0, !519, !DIExpression(), !520)
  %exitcond4 = icmp ne i32 %i138.0, 10800, !dbg !521
  br i1 %exitcond4, label %for.body41, label %for.cond48.preheader, !dbg !461

for.cond48.preheader:                             ; preds = %for.cond39
  br label %for.cond48, !dbg !523

for.body41:                                       ; preds = %for.cond39
  %arrayidx42 = getelementptr inbounds nuw [10800 x i8], ptr %F12, i32 0, i32 %i138.0, !dbg !525
  %arrayidx43 = getelementptr inbounds nuw i8, ptr %add.ptr4, i32 %i138.0, !dbg !527
  %0 = load i8, ptr %arrayidx43, align 1, !dbg !527
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx42, i8 noundef zeroext %0) #3, !dbg !528
  %inc45 = add nuw nsw i32 %i138.0, 1, !dbg !529
    #dbg_value(i32 %inc45, !519, !DIExpression(), !520)
  br label %for.cond39, !dbg !530, !llvm.loop !531

for.cond48:                                       ; preds = %for.cond48.preheader, %for.inc88
  %i147.0 = phi i32 [ %inc89, %for.inc88 ], [ 0, %for.cond48.preheader ], !dbg !533
    #dbg_value(i32 %i147.0, !534, !DIExpression(), !535)
  %exitcond8 = icmp ne i32 %i147.0, 5, !dbg !536
  br i1 %exitcond8, label %for.cond52.preheader, label %for.cond92.preheader, !dbg !523

for.cond52.preheader:                             ; preds = %for.cond48
  br label %for.cond52, !dbg !538

for.cond92.preheader:                             ; preds = %for.cond48
  %add.ptr6 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 69120, !dbg !541
  br label %for.cond92, !dbg !542

for.cond52:                                       ; preds = %for.cond52.preheader, %for.inc85
  %idx51.0 = phi i32 [ %inc86, %for.inc85 ], [ 0, %for.cond52.preheader ], !dbg !544
    #dbg_value(i32 %idx51.0, !545, !DIExpression(), !546)
  %exitcond7 = icmp ne i32 %idx51.0, 27, !dbg !547
  br i1 %exitcond7, label %for.cond56.preheader, label %for.inc88, !dbg !538

for.cond56.preheader:                             ; preds = %for.cond52
  br label %for.cond56, !dbg !549

for.cond56:                                       ; preds = %for.cond56.preheader, %for.inc82
  %k155.0 = phi i32 [ %inc83, %for.inc82 ], [ 0, %for.cond56.preheader ], !dbg !552
    #dbg_value(i32 %k155.0, !553, !DIExpression(), !554)
  %exitcond6 = icmp ne i32 %k155.0, 5, !dbg !555
  br i1 %exitcond6, label %for.cond60.preheader, label %for.inc85, !dbg !549

for.cond60.preheader:                             ; preds = %for.cond56
  br label %for.cond60, !dbg !557

for.cond60:                                       ; preds = %for.cond60.preheader, %for.body62
  %j159.0 = phi i32 [ %inc80, %for.body62 ], [ 0, %for.cond60.preheader ], !dbg !560
    #dbg_value(i32 %j159.0, !561, !DIExpression(), !562)
  %exitcond5 = icmp ne i32 %j159.0, 5, !dbg !563
  br i1 %exitcond5, label %for.body62, label %for.inc82, !dbg !557

for.body62:                                       ; preds = %for.cond60
  %mul63 = mul nuw nsw i32 %i147.0, 5, !dbg !565
  %add64 = add nuw nsw i32 %mul63, %j159.0, !dbg !567
  %mul65 = mul nuw nsw i32 %add64, 5, !dbg !568
  %add66 = add nuw nsw i32 %mul65, %k155.0, !dbg !569
  %mul67 = shl nuw nsw i32 %add66, 4, !dbg !570
  %arrayidx68 = getelementptr inbounds nuw [2000 x i8], ptr %P22, i32 0, i32 %mul67, !dbg !571
  %mul69 = mul nuw nsw i32 %idx51.0, 5, !dbg !572
  %add70 = add nuw nsw i32 %mul69, %j159.0, !dbg !573
  %mul71 = shl nuw nsw i32 %add70, 4, !dbg !574
  %arrayidx72 = getelementptr inbounds nuw [2160 x i8], ptr %T12, i32 0, i32 %mul71, !dbg !575
  %mul73 = mul nuw nsw i32 %i147.0, 27, !dbg !576
  %add74 = add nuw nsw i32 %mul73, %idx51.0, !dbg !577
  %mul75 = mul nuw nsw i32 %add74, 5, !dbg !578
  %add76 = add nuw nsw i32 %mul75, %k155.0, !dbg !579
  %mul77 = shl nuw nsw i32 %add76, 4, !dbg !580
  %arrayidx78 = getelementptr inbounds nuw [10800 x i8], ptr %F12, i32 0, i32 %mul77, !dbg !581
  call fastcc void @gf_mat_mul_add(ptr noundef nonnull %arrayidx68, ptr noundef nonnull %arrayidx72, ptr noundef nonnull %arrayidx78) #3, !dbg !582
  %inc80 = add nuw nsw i32 %j159.0, 1, !dbg !583
    #dbg_value(i32 %inc80, !561, !DIExpression(), !562)
  br label %for.cond60, !dbg !584, !llvm.loop !585

for.inc82:                                        ; preds = %for.cond60
  %inc83 = add nuw nsw i32 %k155.0, 1, !dbg !587
    #dbg_value(i32 %inc83, !553, !DIExpression(), !554)
  br label %for.cond56, !dbg !588, !llvm.loop !589

for.inc85:                                        ; preds = %for.cond56
  %inc86 = add nuw nsw i32 %idx51.0, 1, !dbg !591
    #dbg_value(i32 %inc86, !545, !DIExpression(), !546)
  br label %for.cond52, !dbg !592, !llvm.loop !593

for.inc88:                                        ; preds = %for.cond52
  %inc89 = add nuw nsw i32 %i147.0, 1, !dbg !595
    #dbg_value(i32 %inc89, !534, !DIExpression(), !535)
  br label %for.cond48, !dbg !596, !llvm.loop !597

for.cond92:                                       ; preds = %for.cond92.preheader, %for.inc132
  %i191.0 = phi i32 [ %inc133, %for.inc132 ], [ 0, %for.cond92.preheader ], !dbg !599
    #dbg_value(i32 %i191.0, !600, !DIExpression(), !601)
  %exitcond12 = icmp ne i32 %i191.0, 5, !dbg !602
  br i1 %exitcond12, label %for.cond96.preheader, label %for.end134, !dbg !542

for.cond96.preheader:                             ; preds = %for.cond92
  br label %for.cond96, !dbg !604

for.cond96:                                       ; preds = %for.cond96.preheader, %for.inc129
  %j195.0 = phi i32 [ %inc130, %for.inc129 ], [ 0, %for.cond96.preheader ], !dbg !607
    #dbg_value(i32 %j195.0, !608, !DIExpression(), !609)
  %exitcond11 = icmp ne i32 %j195.0, 5, !dbg !610
  br i1 %exitcond11, label %for.cond100.preheader, label %for.inc132, !dbg !604

for.cond100.preheader:                            ; preds = %for.cond96
  br label %for.cond100, !dbg !612

for.cond100:                                      ; preds = %for.cond100.preheader, %for.inc126
  %idx99.0 = phi i32 [ %inc127, %for.inc126 ], [ 0, %for.cond100.preheader ], !dbg !615
    #dbg_value(i32 %idx99.0, !616, !DIExpression(), !617)
  %exitcond10 = icmp ne i32 %idx99.0, 27, !dbg !618
  br i1 %exitcond10, label %for.cond104.preheader, label %for.inc129, !dbg !612

for.cond104.preheader:                            ; preds = %for.cond100
  br label %for.cond104, !dbg !620

for.cond104:                                      ; preds = %for.cond104.preheader, %for.body106
  %k1103.0 = phi i32 [ %inc124, %for.body106 ], [ 0, %for.cond104.preheader ], !dbg !623
    #dbg_value(i32 %k1103.0, !624, !DIExpression(), !625)
  %exitcond9 = icmp ne i32 %k1103.0, 5, !dbg !626
  br i1 %exitcond9, label %for.body106, label %for.inc126, !dbg !620

for.body106:                                      ; preds = %for.cond104
  %mul107 = mul nuw nsw i32 %i191.0, 5, !dbg !628
  %add108 = add nuw nsw i32 %mul107, %j195.0, !dbg !630
  %mul109 = mul nuw nsw i32 %add108, 5, !dbg !631
  %add110 = add nuw nsw i32 %mul109, %k1103.0, !dbg !632
  %mul111 = shl nuw nsw i32 %add110, 4, !dbg !633
  %arrayidx112 = getelementptr inbounds nuw [2000 x i8], ptr %P22, i32 0, i32 %mul111, !dbg !634
  %mul113 = mul nuw nsw i32 %i191.0, 5, !dbg !635
  %add114 = add nuw nsw i32 %mul113, %j195.0, !dbg !636
  %mul115 = mul nuw nsw i32 %add114, 27, !dbg !637
  %add116 = add nuw nsw i32 %mul115, %idx99.0, !dbg !638
  %mul117 = shl nuw nsw i32 %add116, 4, !dbg !639
  %arrayidx118 = getelementptr inbounds nuw i8, ptr %add.ptr6, i32 %mul117, !dbg !640
  %mul119 = mul nuw nsw i32 %idx99.0, 5, !dbg !641
  %add120 = add nuw nsw i32 %mul119, %k1103.0, !dbg !642
  %mul121 = shl nuw nsw i32 %add120, 4, !dbg !643
  %arrayidx122 = getelementptr inbounds nuw [2160 x i8], ptr %T12, i32 0, i32 %mul121, !dbg !644
  call fastcc void @gf_mat_mul_add(ptr noundef nonnull %arrayidx112, ptr noundef nonnull %arrayidx118, ptr noundef nonnull %arrayidx122) #3, !dbg !645
  %inc124 = add nuw nsw i32 %k1103.0, 1, !dbg !646
    #dbg_value(i32 %inc124, !624, !DIExpression(), !625)
  br label %for.cond104, !dbg !647, !llvm.loop !648

for.inc126:                                       ; preds = %for.cond104
  %inc127 = add nuw nsw i32 %idx99.0, 1, !dbg !650
    #dbg_value(i32 %inc127, !616, !DIExpression(), !617)
  br label %for.cond100, !dbg !651, !llvm.loop !652

for.inc129:                                       ; preds = %for.cond100
  %inc130 = add nuw nsw i32 %j195.0, 1, !dbg !654
    #dbg_value(i32 %inc130, !608, !DIExpression(), !609)
  br label %for.cond96, !dbg !655, !llvm.loop !656

for.inc132:                                       ; preds = %for.cond96
  %inc133 = add nuw nsw i32 %i191.0, 1, !dbg !658
    #dbg_value(i32 %inc133, !600, !DIExpression(), !601)
  br label %for.cond92, !dbg !659, !llvm.loop !660

for.end134:                                       ; preds = %for.cond92
  %call = call ptr @memcpy(ptr noundef %pk, ptr noundef %seed, i32 noundef 16) #4, !dbg !662
  %add.ptr135 = getelementptr inbounds nuw i8, ptr %pk, i32 16, !dbg !663
  call fastcc void @compress_pk(ptr noundef nonnull %add.ptr135, ptr noundef nonnull %P22) #3, !dbg !664
  %call137 = call ptr @memcpy(ptr noundef %sk, ptr noundef %seed, i32 noundef 48) #4, !dbg !665
  %add.ptr139 = getelementptr inbounds nuw i8, ptr %sk, i32 48, !dbg !666
  call void @shake256(ptr noundef nonnull %add.ptr139, i32 noundef 48, ptr noundef %pk, i32 noundef 1016) #3, !dbg !667
  ret i32 0, !dbg !668
}

; Function Attrs: nounwind
define internal fastcc void @snova_init() unnamed_addr #0 !dbg !669 {
entry:
  store i1 true, ptr @first_time, align 1, !dbg !672
  call fastcc void @init_gf_tables() #3, !dbg !673
  call fastcc void @gen_S_array() #3, !dbg !674
  call fastcc void @gen_fixed_ABQ(ptr noundef nonnull @.str) #3, !dbg !675
  ret void, !dbg !676
}

; Function Attrs: nounwind
define internal fastcc void @expand_T12(ptr noundef nonnull %T12, ptr noundef %seed) unnamed_addr #0 !dbg !677 {
entry:
  %T12coef = alloca [540 x i8], align 1
  %sk_data = alloca [32 x i8], align 1
  %state = alloca %struct.shake_t, align 8
    #dbg_value(ptr %T12, !678, !DIExpression(), !679)
    #dbg_value(ptr %seed, !680, !DIExpression(), !679)
    #dbg_declare(ptr %T12coef, !681, !DIExpression(), !685)
    #dbg_declare(ptr %sk_data, !686, !DIExpression(), !688)
    #dbg_declare(ptr %state, !689, !DIExpression(), !698)
  call void @shake256_init(ptr noundef nonnull %state) #3, !dbg !699
  call void @shake_absorb(ptr noundef nonnull %state, ptr noundef %seed, i32 noundef 32) #3, !dbg !700
  call void @shake_finalize(ptr noundef nonnull %state) #3, !dbg !701
    #dbg_value(i32 32, !702, !DIExpression(), !679)
    #dbg_value(i32 0, !703, !DIExpression(), !679)
  br label %while.cond, !dbg !704

while.cond:                                       ; preds = %if.end, %entry
  %idx.0 = phi i32 [ 32, %entry ], [ %inc9, %if.end ], !dbg !679
  %t_idx.0 = phi i32 [ 0, %entry ], [ %inc8, %if.end ], !dbg !679
    #dbg_value(i32 %t_idx.0, !703, !DIExpression(), !679)
    #dbg_value(i32 %idx.0, !702, !DIExpression(), !679)
  %cmp = icmp samesign ult i32 %t_idx.0, 540, !dbg !705
  br i1 %cmp, label %while.body, label %for.cond.preheader, !dbg !704

for.cond.preheader:                               ; preds = %while.cond
  br label %for.cond, !dbg !706

while.body:                                       ; preds = %while.cond
  %cmp1 = icmp ugt i32 %idx.0, 31, !dbg !708
  br i1 %cmp1, label %if.then, label %if.end, !dbg !708

if.then:                                          ; preds = %while.body
  call void @shake_squeeze(ptr noundef nonnull %sk_data, i32 noundef 32, ptr noundef nonnull %state) #3, !dbg !711
    #dbg_value(i32 0, !702, !DIExpression(), !679)
  br label %if.end, !dbg !713

if.end:                                           ; preds = %if.then, %while.body
  %idx.1 = phi i32 [ 0, %if.then ], [ %idx.0, %while.body ], !dbg !679
    #dbg_value(i32 %idx.1, !702, !DIExpression(), !679)
  %arrayidx = getelementptr inbounds nuw [32 x i8], ptr %sk_data, i32 0, i32 %idx.1, !dbg !714
  %0 = load i8, ptr %arrayidx, align 1, !dbg !714
  %1 = and i8 %0, 15, !dbg !715
  %arrayidx3 = getelementptr inbounds nuw [540 x i8], ptr %T12coef, i32 0, i32 %t_idx.0, !dbg !716
  store i8 %1, ptr %arrayidx3, align 1, !dbg !717
  %inc = or disjoint i32 %t_idx.0, 1, !dbg !718
    #dbg_value(i32 %inc, !703, !DIExpression(), !679)
  %2 = lshr i8 %0, 4, !dbg !719
  %arrayidx7 = getelementptr inbounds nuw [540 x i8], ptr %T12coef, i32 0, i32 %inc, !dbg !720
  store i8 %2, ptr %arrayidx7, align 1, !dbg !721
  %inc8 = add nuw nsw i32 %t_idx.0, 2, !dbg !722
    #dbg_value(i32 %inc8, !703, !DIExpression(), !679)
  %inc9 = add nuw nsw i32 %idx.1, 1, !dbg !723
    #dbg_value(i32 %inc9, !702, !DIExpression(), !679)
  br label %while.cond, !dbg !704, !llvm.loop !724

for.cond:                                         ; preds = %for.cond.preheader, %for.body
  %i1.0 = phi i32 [ %inc15, %for.body ], [ 0, %for.cond.preheader ], !dbg !726
    #dbg_value(i32 %i1.0, !727, !DIExpression(), !728)
  %exitcond = icmp ne i32 %i1.0, 135, !dbg !729
  br i1 %exitcond, label %for.body, label %for.end, !dbg !706

for.body:                                         ; preds = %for.cond
  %mul = shl nuw nsw i32 %i1.0, 4, !dbg !731
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %T12, i32 %mul, !dbg !733
  %mul13 = shl nuw nsw i32 %i1.0, 2, !dbg !734
  %arrayidx14 = getelementptr inbounds nuw [540 x i8], ptr %T12coef, i32 0, i32 %mul13, !dbg !735
  call fastcc void @gen_a_FqS_sec(ptr noundef %arrayidx12, ptr noundef nonnull %arrayidx14) #3, !dbg !736
  %inc15 = add nuw nsw i32 %i1.0, 1, !dbg !737
    #dbg_value(i32 %inc15, !727, !DIExpression(), !728)
  br label %for.cond, !dbg !738, !llvm.loop !739

for.end:                                          ; preds = %for.cond
  ret void, !dbg !741
}

; Function Attrs: nounwind
define internal fastcc void @gf_mat_mul_add(ptr noundef nonnull %a, ptr noundef nonnull %b, ptr noundef nonnull %c) unnamed_addr #0 !dbg !742 {
entry:
  %sum = alloca i8, align 1
    #dbg_value(ptr %a, !747, !DIExpression(), !748)
    #dbg_value(ptr %b, !749, !DIExpression(), !748)
    #dbg_value(ptr %c, !750, !DIExpression(), !748)
    #dbg_value(i32 0, !751, !DIExpression(), !753)
  br label %for.cond, !dbg !754

for.cond:                                         ; preds = %for.inc16, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc17, %for.inc16 ], !dbg !755
    #dbg_value(i32 %i1.0, !751, !DIExpression(), !753)
  %exitcond2 = icmp ne i32 %i1.0, 4, !dbg !756
  br i1 %exitcond2, label %for.cond1.preheader, label %for.end18, !dbg !758

for.cond1.preheader:                              ; preds = %for.cond
  br label %for.cond1, !dbg !759

for.cond1:                                        ; preds = %for.cond1.preheader, %for.end
  %j1.0 = phi i32 [ %inc14, %for.end ], [ 0, %for.cond1.preheader ], !dbg !761
    #dbg_value(i32 %j1.0, !762, !DIExpression(), !763)
  %exitcond1 = icmp ne i32 %j1.0, 4, !dbg !764
  br i1 %exitcond1, label %for.body3, label %for.inc16, !dbg !759

for.body3:                                        ; preds = %for.cond1
    #dbg_value(i8 0, !766, !DIExpression(), !768)
  store i8 0, ptr %sum, align 1, !dbg !769
    #dbg_value(i32 0, !770, !DIExpression(), !772)
  br label %for.cond4, !dbg !773

for.cond4:                                        ; preds = %for.body6, %for.body3
  %k1.0 = phi i32 [ 0, %for.body3 ], [ %inc, %for.body6 ], !dbg !774
    #dbg_value(i32 %k1.0, !770, !DIExpression(), !772)
  %exitcond = icmp ne i32 %k1.0, 4, !dbg !775
  br i1 %exitcond, label %for.body6, label %for.end, !dbg !777

for.body6:                                        ; preds = %for.cond4
  %mul = shl nuw nsw i32 %i1.0, 2, !dbg !778
  %add = or disjoint i32 %mul, %k1.0, !dbg !780
  %arrayidx = getelementptr inbounds nuw i8, ptr %b, i32 %add, !dbg !781
  %0 = load i8, ptr %arrayidx, align 1, !dbg !781
  %mul7 = shl nuw nsw i32 %k1.0, 2, !dbg !782
  %add8 = or disjoint i32 %mul7, %j1.0, !dbg !783
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %c, i32 %add8, !dbg !784
  %1 = load i8, ptr %arrayidx9, align 1, !dbg !784
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %0, i8 noundef zeroext %1) #3, !dbg !785
    #dbg_value(ptr %sum, !766, !DIExpression(DW_OP_deref), !768)
  call fastcc void @gf_set_add(ptr noundef nonnull %sum, i8 noundef zeroext %call) #3, !dbg !786
  %inc = add nuw nsw i32 %k1.0, 1, !dbg !787
    #dbg_value(i32 %inc, !770, !DIExpression(), !772)
  br label %for.cond4, !dbg !788, !llvm.loop !789

for.end:                                          ; preds = %for.cond4
  %mul10 = shl nuw nsw i32 %i1.0, 2, !dbg !791
  %add11 = or disjoint i32 %mul10, %j1.0, !dbg !792
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %a, i32 %add11, !dbg !793
  %2 = load i8, ptr %sum, align 1, !dbg !794
    #dbg_value(i8 %2, !766, !DIExpression(), !768)
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx12, i8 noundef zeroext %2) #3, !dbg !795
  %inc14 = add nuw nsw i32 %j1.0, 1, !dbg !796
    #dbg_value(i32 %inc14, !762, !DIExpression(), !763)
  br label %for.cond1, !dbg !797, !llvm.loop !798

for.inc16:                                        ; preds = %for.cond1
  %inc17 = add nuw nsw i32 %i1.0, 1, !dbg !800
    #dbg_value(i32 %inc17, !751, !DIExpression(), !753)
  br label %for.cond, !dbg !801, !llvm.loop !802

for.end18:                                        ; preds = %for.cond
  ret void, !dbg !804
}

; Function Attrs: nounwind
define internal fastcc void @gf_set_add(ptr noundef %a, i8 noundef zeroext %b) unnamed_addr #0 !dbg !805 {
entry:
    #dbg_value(ptr %a, !808, !DIExpression(), !809)
    #dbg_value(i8 %b, !810, !DIExpression(), !809)
  %0 = load i8, ptr %a, align 1, !dbg !811
  %conv = zext i8 %0 to i32, !dbg !811
  %mul = shl nuw nsw i32 %conv, 4, !dbg !812
  %conv1 = zext i8 %b to i32, !dbg !813
  %add = add nuw nsw i32 %mul, %conv1, !dbg !814
  %arrayidx = getelementptr inbounds nuw [256 x i8], ptr @gf_addtab, i32 0, i32 %add, !dbg !815
  %1 = load i8, ptr %arrayidx, align 1, !dbg !815
  store i8 %1, ptr %a, align 1, !dbg !816
  ret void, !dbg !817
}

; Function Attrs: nounwind
define internal fastcc void @compress_pk(ptr noundef %pk, ptr noundef nonnull %P22) unnamed_addr #0 !dbg !818 {
entry:
    #dbg_value(ptr %pk, !821, !DIExpression(), !822)
    #dbg_value(ptr %P22, !823, !DIExpression(), !822)
  call fastcc void @compress_gf(ptr noundef %pk, ptr noundef %P22, i32 noundef 2000) #3, !dbg !824
  ret void, !dbg !825
}

; Function Attrs: nounwind
define internal fastcc void @compress_gf(ptr noundef %byte_array, ptr noundef nonnull %gf_array, i32 noundef range(i32 512, 2001) %num) unnamed_addr #0 !dbg !826 {
entry:
    #dbg_value(ptr %byte_array, !829, !DIExpression(), !830)
    #dbg_value(ptr %gf_array, !831, !DIExpression(), !830)
    #dbg_value(i32 %num, !832, !DIExpression(), !830)
    #dbg_value(i32 0, !833, !DIExpression(), !830)
    #dbg_value(i32 0, !834, !DIExpression(), !830)
  %sub = add nuw nsw i32 %num, 1, !dbg !835
  %div2 = lshr i32 %sub, 1, !dbg !835
    #dbg_value(i32 %div2, !836, !DIExpression(), !830)
  br label %do.body, !dbg !837

do.body:                                          ; preds = %do.cond, %entry
  %out_idx.0 = phi i32 [ 0, %entry ], [ %out_idx.1.lcssa, %do.cond ], !dbg !838
  %idx.0 = phi i32 [ 0, %entry ], [ %idx.1.lcssa, %do.cond ], !dbg !839
    #dbg_value(i32 %idx.0, !833, !DIExpression(), !830)
    #dbg_value(i32 %out_idx.0, !834, !DIExpression(), !830)
    #dbg_value(i64 0, !840, !DIExpression(), !842)
    #dbg_value(i64 1, !843, !DIExpression(), !842)
    #dbg_value(i32 0, !844, !DIExpression(), !842)
  br label %while.cond, !dbg !845

while.cond:                                       ; preds = %while.body, %do.body
  %val.0 = phi i64 [ 0, %do.body ], [ %add4, %while.body ], !dbg !842
  %idx.1 = phi i32 [ %idx.0, %do.body ], [ %inc, %while.body ], !dbg !830
  %fact.0 = phi i64 [ 1, %do.body ], [ %mul6, %while.body ], !dbg !842
  %i1.0 = phi i32 [ 0, %do.body ], [ %inc5, %while.body ], !dbg !842
    #dbg_value(i32 %i1.0, !844, !DIExpression(), !842)
    #dbg_value(i64 %fact.0, !843, !DIExpression(), !842)
    #dbg_value(i32 %idx.1, !833, !DIExpression(), !830)
    #dbg_value(i64 %val.0, !840, !DIExpression(), !842)
  %cmp = icmp samesign ult i32 %i1.0, 2, !dbg !846
  %cmp1 = icmp ult i32 %idx.1, %num
  %spec.select = select i1 %cmp, i1 %cmp1, i1 false, !dbg !847
  br i1 %spec.select, label %while.body, label %while.cond9.preheader, !dbg !845

while.cond9.preheader:                            ; preds = %while.cond
  %val.0.lcssa = phi i64 [ %val.0, %while.cond ], !dbg !842
  %idx.1.lcssa = phi i32 [ %idx.1, %while.cond ], !dbg !830
  br label %while.cond9, !dbg !848

while.body:                                       ; preds = %while.cond
  %arrayidx = getelementptr inbounds nuw i8, ptr %gf_array, i32 %idx.1, !dbg !849
  %0 = load i8, ptr %arrayidx, align 1, !dbg !849
  %rem1 = and i8 %0, 15, !dbg !851
  %conv2 = zext nneg i8 %rem1 to i64, !dbg !852
  %mul3 = mul i64 %fact.0, %conv2, !dbg !853
  %add4 = add i64 %val.0, %mul3, !dbg !854
    #dbg_value(i64 %add4, !840, !DIExpression(), !842)
  %inc = add nuw nsw i32 %idx.1, 1, !dbg !855
    #dbg_value(i32 %inc, !833, !DIExpression(), !830)
  %inc5 = add nuw nsw i32 %i1.0, 1, !dbg !856
    #dbg_value(i32 %inc5, !844, !DIExpression(), !842)
  %mul6 = shl i64 %fact.0, 4, !dbg !857
    #dbg_value(i64 %mul6, !843, !DIExpression(), !842)
  br label %while.cond, !dbg !845, !llvm.loop !858

while.cond9:                                      ; preds = %while.cond9.preheader, %while.body16
  %val.1 = phi i64 [ %shr, %while.body16 ], [ %val.0.lcssa, %while.cond9.preheader ], !dbg !842
  %out_idx.1 = phi i32 [ %inc19, %while.body16 ], [ %out_idx.0, %while.cond9.preheader ], !dbg !830
  %cmp10 = phi i1 [ false, %while.body16 ], [ true, %while.cond9.preheader ], !dbg !842
    #dbg_value(i32 poison, !860, !DIExpression(), !842)
    #dbg_value(i32 %out_idx.1, !834, !DIExpression(), !830)
    #dbg_value(i64 %val.1, !840, !DIExpression(), !842)
  %cmp13 = icmp ult i32 %out_idx.1, %div2
  %spec.select3 = select i1 %cmp10, i1 %cmp13, i1 false, !dbg !861
  br i1 %spec.select3, label %while.body16, label %do.cond, !dbg !848

while.body16:                                     ; preds = %while.cond9
  %conv17 = trunc i64 %val.1 to i8, !dbg !862
  %arrayidx18 = getelementptr inbounds nuw i8, ptr %byte_array, i32 %out_idx.1, !dbg !864
  store i8 %conv17, ptr %arrayidx18, align 1, !dbg !865
  %inc19 = add nuw nsw i32 %out_idx.1, 1, !dbg !866
    #dbg_value(i32 %inc19, !834, !DIExpression(), !830)
  %shr = lshr i64 %val.1, 8, !dbg !867
    #dbg_value(i64 %shr, !840, !DIExpression(), !842)
    #dbg_value(i32 1, !860, !DIExpression(), !842)
  br label %while.cond9, !dbg !848, !llvm.loop !868

do.cond:                                          ; preds = %while.cond9
  %out_idx.1.lcssa = phi i32 [ %out_idx.1, %while.cond9 ], !dbg !830
  %cmp22 = icmp ult i32 %idx.1.lcssa, %num, !dbg !870
  br i1 %cmp22, label %do.body, label %do.end, !dbg !871, !llvm.loop !872

do.end:                                           ; preds = %do.cond
  ret void, !dbg !874
}

; Function Attrs: nounwind
define internal fastcc zeroext i8 @gf_mult(i8 noundef zeroext %a, i8 noundef zeroext %b) unnamed_addr #0 !dbg !875 {
entry:
    #dbg_value(i8 %a, !878, !DIExpression(), !879)
    #dbg_value(i8 %b, !880, !DIExpression(), !879)
  %conv = zext i8 %a to i32, !dbg !881
  %mul = shl nuw nsw i32 %conv, 4, !dbg !882
  %conv1 = zext i8 %b to i32, !dbg !883
  %add = add nuw nsw i32 %mul, %conv1, !dbg !884
  %arrayidx = getelementptr inbounds nuw [256 x i8], ptr @gf_multtab, i32 0, i32 %add, !dbg !885
  %0 = load i8, ptr %arrayidx, align 1, !dbg !885
  ret i8 %0, !dbg !886
}

; Function Attrs: nounwind
define internal fastcc void @gen_a_FqS_sec(ptr noundef nonnull %Qm, ptr noundef nonnull %q) unnamed_addr #0 !dbg !887 {
entry:
  %sum = alloca i8, align 1
    #dbg_value(ptr %Qm, !890, !DIExpression(), !891)
    #dbg_value(ptr %q, !892, !DIExpression(), !891)
    #dbg_value(i32 0, !893, !DIExpression(), !895)
  br label %for.cond, !dbg !896

for.cond:                                         ; preds = %for.end, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc7, %for.end ], !dbg !897
    #dbg_value(i32 %i1.0, !893, !DIExpression(), !895)
  %exitcond1 = icmp ne i32 %i1.0, 16, !dbg !898
  br i1 %exitcond1, label %for.body, label %for.end8, !dbg !900

for.body:                                         ; preds = %for.cond
    #dbg_value(i8 0, !901, !DIExpression(), !903)
  store i8 0, ptr %sum, align 1, !dbg !904
    #dbg_value(i32 0, !905, !DIExpression(), !907)
  br label %for.cond1, !dbg !908

for.cond1:                                        ; preds = %for.body3, %for.body
  %j1.0 = phi i32 [ 0, %for.body ], [ %inc, %for.body3 ], !dbg !909
    #dbg_value(i32 %j1.0, !905, !DIExpression(), !907)
  %exitcond = icmp ne i32 %j1.0, 4, !dbg !910
  br i1 %exitcond, label %for.body3, label %for.end, !dbg !912

for.body3:                                        ; preds = %for.cond1
  %arrayidx = getelementptr inbounds nuw i8, ptr %q, i32 %j1.0, !dbg !913
  %0 = load i8, ptr %arrayidx, align 1, !dbg !913
  %mul = shl nuw nsw i32 %j1.0, 4, !dbg !915
  %add = or disjoint i32 %mul, %i1.0, !dbg !916
  %arrayidx4 = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %add, !dbg !917
  %1 = load i8, ptr %arrayidx4, align 1, !dbg !917
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %0, i8 noundef zeroext %1) #3, !dbg !918
    #dbg_value(ptr %sum, !901, !DIExpression(DW_OP_deref), !903)
  call fastcc void @gf_set_add(ptr noundef nonnull %sum, i8 noundef zeroext %call) #3, !dbg !919
  %inc = add nuw nsw i32 %j1.0, 1, !dbg !920
    #dbg_value(i32 %inc, !905, !DIExpression(), !907)
  br label %for.cond1, !dbg !921, !llvm.loop !922

for.end:                                          ; preds = %for.cond1
  %2 = load i8, ptr %sum, align 1, !dbg !924
    #dbg_value(i8 %2, !901, !DIExpression(), !903)
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %Qm, i32 %i1.0, !dbg !925
  store i8 %2, ptr %arrayidx5, align 1, !dbg !926
  %inc7 = add nuw nsw i32 %i1.0, 1, !dbg !927
    #dbg_value(i32 %inc7, !893, !DIExpression(), !895)
  br label %for.cond, !dbg !928, !llvm.loop !929

for.end8:                                         ; preds = %for.cond
  ret void, !dbg !931
}

; Function Attrs: nounwind
define internal fastcc void @init_gf_tables() unnamed_addr #0 !dbg !932 {
entry:
    #dbg_declare(ptr @__const.init_gf_tables.F_star, !933, !DIExpression(), !937)
    #dbg_value(i32 0, !938, !DIExpression(), !940)
  br label %for.cond, !dbg !941

for.cond:                                         ; preds = %for.body, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !942
    #dbg_value(i32 %i1.0, !938, !DIExpression(), !940)
  %exitcond = icmp ne i32 %i1.0, 16, !dbg !943
  br i1 %exitcond, label %for.body, label %for.cond3.preheader, !dbg !945

for.cond3.preheader:                              ; preds = %for.cond
  br label %for.cond3, !dbg !946

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw [256 x i8], ptr @gf_multtab, i32 0, i32 %i1.0, !dbg !948
  store i8 0, ptr %arrayidx, align 1, !dbg !950
  %mul = shl nuw nsw i32 %i1.0, 4, !dbg !951
  %arrayidx1 = getelementptr inbounds nuw [256 x i8], ptr @gf_multtab, i32 0, i32 %mul, !dbg !952
  store i8 0, ptr %arrayidx1, align 1, !dbg !953
  %inc = add nuw nsw i32 %i1.0, 1, !dbg !954
    #dbg_value(i32 %inc, !938, !DIExpression(), !940)
  br label %for.cond, !dbg !955, !llvm.loop !956

for.cond3:                                        ; preds = %for.cond3.preheader, %for.inc19
  %i12.0 = phi i32 [ %inc20, %for.inc19 ], [ 0, %for.cond3.preheader ], !dbg !958
    #dbg_value(i32 %i12.0, !959, !DIExpression(), !960)
  %exitcond2 = icmp ne i32 %i12.0, 15, !dbg !961
  br i1 %exitcond2, label %for.cond6.preheader, label %for.cond23.preheader, !dbg !946

for.cond6.preheader:                              ; preds = %for.cond3
  br label %for.cond6, !dbg !963

for.cond23.preheader:                             ; preds = %for.cond3
  br label %for.cond23, !dbg !965

for.cond6:                                        ; preds = %for.cond6.preheader, %for.body8
  %j1.0 = phi i32 [ %inc17, %for.body8 ], [ 0, %for.cond6.preheader ], !dbg !967
    #dbg_value(i32 %j1.0, !968, !DIExpression(), !969)
  %exitcond1 = icmp ne i32 %j1.0, 15, !dbg !970
  br i1 %exitcond1, label %for.body8, label %for.inc19, !dbg !963

for.body8:                                        ; preds = %for.cond6
  %add = add nuw nsw i32 %i12.0, %j1.0, !dbg !972
  %rem = urem i32 %add, 15, !dbg !974
  %arrayidx9 = getelementptr inbounds nuw [15 x i8], ptr @__const.init_gf_tables.F_star, i32 0, i32 %rem, !dbg !975
  %0 = load i8, ptr %arrayidx9, align 1, !dbg !975
  %arrayidx10 = getelementptr inbounds nuw [15 x i8], ptr @__const.init_gf_tables.F_star, i32 0, i32 %i12.0, !dbg !976
  %1 = load i8, ptr %arrayidx10, align 1, !dbg !976
  %conv = zext i8 %1 to i32, !dbg !976
  %mul11 = shl nuw nsw i32 %conv, 4, !dbg !977
  %arrayidx12 = getelementptr inbounds nuw [15 x i8], ptr @__const.init_gf_tables.F_star, i32 0, i32 %j1.0, !dbg !978
  %2 = load i8, ptr %arrayidx12, align 1, !dbg !978
  %conv13 = zext i8 %2 to i32, !dbg !978
  %add14 = add nuw nsw i32 %mul11, %conv13, !dbg !979
  %arrayidx15 = getelementptr inbounds nuw [256 x i8], ptr @gf_multtab, i32 0, i32 %add14, !dbg !980
  store i8 %0, ptr %arrayidx15, align 1, !dbg !981
  %inc17 = add nuw nsw i32 %j1.0, 1, !dbg !982
    #dbg_value(i32 %inc17, !968, !DIExpression(), !969)
  br label %for.cond6, !dbg !983, !llvm.loop !984

for.inc19:                                        ; preds = %for.cond6
  %inc20 = add nuw nsw i32 %i12.0, 1, !dbg !986
    #dbg_value(i32 %inc20, !959, !DIExpression(), !960)
  br label %for.cond3, !dbg !987, !llvm.loop !988

for.cond23:                                       ; preds = %for.cond23.preheader, %for.inc39
  %i122.0 = phi i32 [ %inc40, %for.inc39 ], [ 0, %for.cond23.preheader ], !dbg !990
    #dbg_value(i32 %i122.0, !991, !DIExpression(), !992)
  %exitcond4 = icmp ne i32 %i122.0, 16, !dbg !993
  br i1 %exitcond4, label %for.cond28.preheader, label %for.cond43.preheader, !dbg !965

for.cond28.preheader:                             ; preds = %for.cond23
  br label %for.cond28, !dbg !995

for.cond43.preheader:                             ; preds = %for.cond23
  br label %for.cond43, !dbg !997

for.cond28:                                       ; preds = %for.cond28.preheader, %for.body31
  %j127.0 = phi i32 [ %inc37, %for.body31 ], [ 0, %for.cond28.preheader ], !dbg !999
    #dbg_value(i32 %j127.0, !1000, !DIExpression(), !1001)
  %exitcond3 = icmp ne i32 %j127.0, 16, !dbg !1002
  br i1 %exitcond3, label %for.body31, label %for.inc39, !dbg !995

for.body31:                                       ; preds = %for.cond28
  %xor = xor i32 %i122.0, %j127.0, !dbg !1004
  %conv32 = trunc nuw i32 %xor to i8, !dbg !1006
  %mul33 = shl nuw nsw i32 %i122.0, 4, !dbg !1007
  %add34 = or disjoint i32 %mul33, %j127.0, !dbg !1008
  %arrayidx35 = getelementptr inbounds nuw [256 x i8], ptr @gf_addtab, i32 0, i32 %add34, !dbg !1009
  store i8 %conv32, ptr %arrayidx35, align 1, !dbg !1010
  %inc37 = add nuw nsw i32 %j127.0, 1, !dbg !1011
    #dbg_value(i32 %inc37, !1000, !DIExpression(), !1001)
  br label %for.cond28, !dbg !1012, !llvm.loop !1013

for.inc39:                                        ; preds = %for.cond28
  %inc40 = add nuw nsw i32 %i122.0, 1, !dbg !1015
    #dbg_value(i32 %inc40, !991, !DIExpression(), !992)
  br label %for.cond23, !dbg !1016, !llvm.loop !1017

for.cond43:                                       ; preds = %for.cond43.preheader, %for.end56
  %i142.0 = phi i32 [ %inc59, %for.end56 ], [ 0, %for.cond43.preheader ], !dbg !1019
    #dbg_value(i32 %i142.0, !1020, !DIExpression(), !1021)
  %exitcond6 = icmp ne i32 %i142.0, 16, !dbg !1022
  br i1 %exitcond6, label %for.body46, label %for.end60, !dbg !997

for.body46:                                       ; preds = %for.cond43
  %conv47 = trunc nuw nsw i32 %i142.0 to i8, !dbg !1024
    #dbg_value(i8 %conv47, !1026, !DIExpression(), !1027)
    #dbg_value(i32 3, !1028, !DIExpression(), !1030)
  br label %for.cond49, !dbg !1031

for.cond49:                                       ; preds = %for.body52, %for.body46
  %j148.0 = phi i32 [ 3, %for.body46 ], [ %inc55, %for.body52 ], !dbg !1032
  %val.0 = phi i8 [ %conv47, %for.body46 ], [ %call, %for.body52 ], !dbg !1027
    #dbg_value(i8 %val.0, !1026, !DIExpression(), !1027)
    #dbg_value(i32 %j148.0, !1028, !DIExpression(), !1030)
  %exitcond5 = icmp ne i32 %j148.0, 16, !dbg !1033
  br i1 %exitcond5, label %for.body52, label %for.end56, !dbg !1035

for.body52:                                       ; preds = %for.cond49
  %conv53 = trunc nuw nsw i32 %i142.0 to i8, !dbg !1036
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %val.0, i8 noundef zeroext %conv53) #3, !dbg !1038
    #dbg_value(i8 %call, !1026, !DIExpression(), !1027)
  %inc55 = add nuw nsw i32 %j148.0, 1, !dbg !1039
    #dbg_value(i32 %inc55, !1028, !DIExpression(), !1030)
  br label %for.cond49, !dbg !1040, !llvm.loop !1041

for.end56:                                        ; preds = %for.cond49
  %val.0.lcssa = phi i8 [ %val.0, %for.cond49 ], !dbg !1027
  %arrayidx57 = getelementptr inbounds nuw [16 x i8], ptr @gf_invtab, i32 0, i32 %i142.0, !dbg !1043
  store i8 %val.0.lcssa, ptr %arrayidx57, align 1, !dbg !1044
  %inc59 = add nuw nsw i32 %i142.0, 1, !dbg !1045
    #dbg_value(i32 %inc59, !1020, !DIExpression(), !1021)
  br label %for.cond43, !dbg !1046, !llvm.loop !1047

for.end60:                                        ; preds = %for.cond43
  ret void, !dbg !1049
}

; Function Attrs: nounwind
define internal fastcc void @gen_S_array() unnamed_addr #0 !dbg !1050 {
entry:
  %call = call ptr @memset(ptr noundef nonnull @gf_S, i32 noundef 0, i32 noundef 64) #4, !dbg !1051
    #dbg_value(i32 0, !1052, !DIExpression(), !1054)
  br label %for.cond, !dbg !1055

for.cond:                                         ; preds = %for.body, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !1056
    #dbg_value(i32 %i1.0, !1052, !DIExpression(), !1054)
  %exitcond = icmp ne i32 %i1.0, 4, !dbg !1057
  br i1 %exitcond, label %for.body, label %for.end, !dbg !1059

for.body:                                         ; preds = %for.cond
  %add = mul nuw nsw i32 %i1.0, 5, !dbg !1060
  %arrayidx = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %add, !dbg !1062
  store i8 1, ptr %arrayidx, align 1, !dbg !1063
  %inc = add nuw nsw i32 %i1.0, 1, !dbg !1064
    #dbg_value(i32 %inc, !1052, !DIExpression(), !1054)
  br label %for.cond, !dbg !1065, !llvm.loop !1066

for.end:                                          ; preds = %for.cond
  call fastcc void @set_S(ptr noundef nonnull getelementptr inbounds nuw (i8, ptr @gf_S, i32 16)) #3, !dbg !1068
    #dbg_value(i32 2, !1069, !DIExpression(), !1071)
  br label %for.cond2, !dbg !1072

for.cond2:                                        ; preds = %for.body4, %for.end
  %i11.0 = phi i32 [ 2, %for.end ], [ %inc10, %for.body4 ], !dbg !1073
    #dbg_value(i32 %i11.0, !1069, !DIExpression(), !1071)
  %exitcond1 = icmp ne i32 %i11.0, 4, !dbg !1074
  br i1 %exitcond1, label %for.body4, label %for.end11, !dbg !1076

for.body4:                                        ; preds = %for.cond2
  %mul5 = shl nuw nsw i32 %i11.0, 4, !dbg !1077
  %arrayidx6 = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %mul5, !dbg !1079
  %sub = shl nuw nsw i32 %i11.0, 4, !dbg !1080
  %mul7 = add nsw i32 %sub, -16, !dbg !1080
  %arrayidx8 = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %mul7, !dbg !1081
  call fastcc void @gf_mat_mul(ptr noundef nonnull %arrayidx6, ptr noundef nonnull getelementptr inbounds nuw (i8, ptr @gf_S, i32 16), ptr noundef nonnull %arrayidx8) #3, !dbg !1082
  %inc10 = add nuw nsw i32 %i11.0, 1, !dbg !1083
    #dbg_value(i32 %inc10, !1069, !DIExpression(), !1071)
  br label %for.cond2, !dbg !1084, !llvm.loop !1085

for.end11:                                        ; preds = %for.cond2
  ret void, !dbg !1087
}

; Function Attrs: nounwind
define internal fastcc void @gen_fixed_ABQ(ptr noundef %abq_seed) unnamed_addr #0 !dbg !1088 {
entry:
  %rng_out = alloca [4800 x i8], align 1
    #dbg_value(ptr @.str, !1093, !DIExpression(), !1094)
    #dbg_declare(ptr %rng_out, !1095, !DIExpression(), !1096)
  call void @snova_memset(ptr %rng_out, i8 0, i32 4800), !dbg !1096
  %call = call i32 @strlen(ptr noundef nonnull @.str) #4, !dbg !1097
  call void @shake256(ptr noundef nonnull %rng_out, i32 noundef 4800, ptr noundef nonnull @.str, i32 noundef %call) #3, !dbg !1098
  call fastcc void @convert_bytes_to_GF(ptr noundef nonnull @fixed_abq, ptr noundef nonnull %rng_out, i32 noundef 4800) #3, !dbg !1099
  ret void, !dbg !1100
}

declare dso_local i32 @strlen(ptr noundef) local_unnamed_addr #1

declare dso_local ptr @memset(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind
define internal fastcc void @set_S(ptr noundef %gf_S1) unnamed_addr #0 !dbg !1101 {
entry:
    #dbg_value(ptr getelementptr inbounds nuw (i8, ptr @gf_S, i32 16), !1104, !DIExpression(), !1105)
    #dbg_value(i32 0, !1106, !DIExpression(), !1108)
  br label %for.cond, !dbg !1109

for.cond:                                         ; preds = %for.inc5, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc6, %for.inc5 ], !dbg !1110
    #dbg_value(i32 %i1.0, !1106, !DIExpression(), !1108)
  %exitcond1 = icmp ne i32 %i1.0, 4, !dbg !1111
  br i1 %exitcond1, label %for.cond1.preheader, label %for.end7, !dbg !1113

for.cond1.preheader:                              ; preds = %for.cond
  br label %for.cond1, !dbg !1114

for.cond1:                                        ; preds = %for.cond1.preheader, %for.body3
  %j1.0 = phi i32 [ %inc, %for.body3 ], [ 0, %for.cond1.preheader ], !dbg !1116
    #dbg_value(i32 %j1.0, !1117, !DIExpression(), !1118)
  %exitcond = icmp ne i32 %j1.0, 4, !dbg !1119
  br i1 %exitcond, label %for.body3, label %for.inc5, !dbg !1114

for.body3:                                        ; preds = %for.cond1
  %add = add nuw nsw i32 %i1.0, %j1.0, !dbg !1121
  %0 = trunc nuw i32 %add to i8, !dbg !1123
  %conv = sub nuw nsw i8 8, %0, !dbg !1123
  %mul = shl nuw nsw i32 %i1.0, 2, !dbg !1124
  %add4 = or disjoint i32 %mul, %j1.0, !dbg !1125
  %arrayidx = getelementptr inbounds nuw i8, ptr getelementptr inbounds nuw (i8, ptr @gf_S, i32 16), i32 %add4, !dbg !1126
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1127
  %inc = add nuw nsw i32 %j1.0, 1, !dbg !1128
    #dbg_value(i32 %inc, !1117, !DIExpression(), !1118)
  br label %for.cond1, !dbg !1129, !llvm.loop !1130

for.inc5:                                         ; preds = %for.cond1
  %inc6 = add nuw nsw i32 %i1.0, 1, !dbg !1132
    #dbg_value(i32 %inc6, !1106, !DIExpression(), !1108)
  br label %for.cond, !dbg !1133, !llvm.loop !1134

for.end7:                                         ; preds = %for.cond
  ret void, !dbg !1136
}

; Function Attrs: nounwind
define internal fastcc void @gf_mat_mul(ptr noundef %a, ptr noundef %b, ptr noundef %c) unnamed_addr #0 !dbg !1137 {
entry:
  %sum = alloca i8, align 1
    #dbg_value(ptr %a, !1138, !DIExpression(), !1139)
    #dbg_value(ptr getelementptr inbounds nuw (i8, ptr @gf_S, i32 16), !1140, !DIExpression(), !1139)
    #dbg_value(ptr %c, !1141, !DIExpression(), !1139)
    #dbg_value(i32 0, !1142, !DIExpression(), !1144)
  br label %for.cond, !dbg !1145

for.cond:                                         ; preds = %for.inc16, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc17, %for.inc16 ], !dbg !1146
    #dbg_value(i32 %i1.0, !1142, !DIExpression(), !1144)
  %exitcond2 = icmp ne i32 %i1.0, 4, !dbg !1147
  br i1 %exitcond2, label %for.cond1.preheader, label %for.end18, !dbg !1149

for.cond1.preheader:                              ; preds = %for.cond
  br label %for.cond1, !dbg !1150

for.cond1:                                        ; preds = %for.cond1.preheader, %for.end
  %j1.0 = phi i32 [ %inc14, %for.end ], [ 0, %for.cond1.preheader ], !dbg !1152
    #dbg_value(i32 %j1.0, !1153, !DIExpression(), !1154)
  %exitcond1 = icmp ne i32 %j1.0, 4, !dbg !1155
  br i1 %exitcond1, label %for.body3, label %for.inc16, !dbg !1150

for.body3:                                        ; preds = %for.cond1
    #dbg_value(i8 0, !1157, !DIExpression(), !1159)
  store i8 0, ptr %sum, align 1, !dbg !1160
    #dbg_value(i32 0, !1161, !DIExpression(), !1163)
  br label %for.cond4, !dbg !1164

for.cond4:                                        ; preds = %for.body6, %for.body3
  %k1.0 = phi i32 [ 0, %for.body3 ], [ %inc, %for.body6 ], !dbg !1165
    #dbg_value(i32 %k1.0, !1161, !DIExpression(), !1163)
  %exitcond = icmp ne i32 %k1.0, 4, !dbg !1166
  br i1 %exitcond, label %for.body6, label %for.end, !dbg !1168

for.body6:                                        ; preds = %for.cond4
  %mul = shl nuw nsw i32 %i1.0, 2, !dbg !1169
  %add = or disjoint i32 %mul, %k1.0, !dbg !1171
  %arrayidx = getelementptr inbounds nuw i8, ptr getelementptr inbounds nuw (i8, ptr @gf_S, i32 16), i32 %add, !dbg !1172
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1172
  %mul7 = shl nuw nsw i32 %k1.0, 2, !dbg !1173
  %add8 = or disjoint i32 %mul7, %j1.0, !dbg !1174
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %c, i32 %add8, !dbg !1175
  %1 = load i8, ptr %arrayidx9, align 1, !dbg !1175
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %0, i8 noundef zeroext %1) #3, !dbg !1176
    #dbg_value(ptr %sum, !1157, !DIExpression(DW_OP_deref), !1159)
  call fastcc void @gf_set_add(ptr noundef nonnull %sum, i8 noundef zeroext %call) #3, !dbg !1177
  %inc = add nuw nsw i32 %k1.0, 1, !dbg !1178
    #dbg_value(i32 %inc, !1161, !DIExpression(), !1163)
  br label %for.cond4, !dbg !1179, !llvm.loop !1180

for.end:                                          ; preds = %for.cond4
  %2 = load i8, ptr %sum, align 1, !dbg !1182
    #dbg_value(i8 %2, !1157, !DIExpression(), !1159)
  %mul10 = shl nuw nsw i32 %i1.0, 2, !dbg !1183
  %add11 = or disjoint i32 %mul10, %j1.0, !dbg !1184
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %a, i32 %add11, !dbg !1185
  store i8 %2, ptr %arrayidx12, align 1, !dbg !1186
  %inc14 = add nuw nsw i32 %j1.0, 1, !dbg !1187
    #dbg_value(i32 %inc14, !1153, !DIExpression(), !1154)
  br label %for.cond1, !dbg !1188, !llvm.loop !1189

for.inc16:                                        ; preds = %for.cond1
  %inc17 = add nuw nsw i32 %i1.0, 1, !dbg !1191
    #dbg_value(i32 %inc17, !1142, !DIExpression(), !1144)
  br label %for.cond, !dbg !1192, !llvm.loop !1193

for.end18:                                        ; preds = %for.cond
  ret void, !dbg !1195
}

; Function Attrs: nounwind
define dso_local i32 @_SNOVA_I_S_AES_ref_sk_expand(ptr noundef %skx, ptr noundef %sk) local_unnamed_addr #0 !dbg !1196 {
entry:
    #dbg_value(ptr %skx, !1199, !DIExpression(), !1200)
    #dbg_value(ptr %sk, !1201, !DIExpression(), !1200)
  %call = call ptr @memcpy(ptr noundef %skx, ptr noundef %sk, i32 noundef 96) #4, !dbg !1202
  ret i32 0, !dbg !1203
}

; Function Attrs: nounwind
define dso_local range(i32 -1, 1) i32 @_SNOVA_I_S_AES_ref_sign(ptr noundef %skx, ptr noundef %sig, ptr noundef %digest, i32 noundef %len_digest, ptr noundef %salt) local_unnamed_addr #0 !dbg !1204 {
entry:
  %T12 = alloca [2160 x i8], align 1
  %P_matrix = alloca [84720 x i8], align 1
  %F21 = alloca [10800 x i8], align 1
  %F12 = alloca [10800 x i8], align 1
  %Am = alloca [1920 x i8], align 1
  %Bm = alloca [1920 x i8], align 1
  %Q1 = alloca [1920 x i8], align 1
  %Q2 = alloca [1920 x i8], align 1
  %hash_in_GF16 = alloca [80 x i8], align 1
  %sign_hashb = alloca [40 x i8], align 1
  %gauss = alloca [80 x [81 x i8]], align 1
  %solution = alloca [80 x i8], align 1
  %signature_in_GF = alloca [512 x i8], align 1
  %num_sign = alloca i8, align 1
  %vinegar_in_byte = alloca [216 x i8], align 1
  %v_instance = alloca %struct.shake_t, align 8
  %Fvv_in_GF16Matrix = alloca [80 x i8], align 1
  %sum_t0 = alloca [8640 x i8], align 1
  %sum_t1 = alloca [1280 x i8], align 1
  %whipped_sig = alloca [1728 x i8], align 1
  %gf16m_temp1 = alloca [16 x i8], align 1
  %gf16m_temp2 = alloca [16 x i8], align 1
  %sumb = alloca [16 x i8], align 1
  %whipped_F21 = alloca [1600 x i8], align 1
  %whipped_F12 = alloca [1600 x i8], align 1
  %gf16m_temp0 = alloca [16 x i8], align 1
  %gf16m_temp1585 = alloca [16 x i8], align 1
  %X_tmp = alloca [16 x i8], align 1
  %gf16m_temp0704 = alloca [16 x i8], align 1
  %gf16m_temp1705 = alloca [16 x i8], align 1
  %X_tmp706 = alloca [16 x i8], align 1
  %sum = alloca i8, align 1
    #dbg_value(ptr %skx, !1208, !DIExpression(), !1209)
    #dbg_value(ptr %sig, !1210, !DIExpression(), !1209)
    #dbg_value(ptr %digest, !1211, !DIExpression(), !1209)
    #dbg_value(i32 %len_digest, !1212, !DIExpression(), !1209)
    #dbg_value(ptr %salt, !1213, !DIExpression(), !1209)
  %.b = load i1, ptr @first_time, align 1, !dbg !1214
  br i1 %.b, label %if.end, label %if.then, !dbg !1214

if.then:                                          ; preds = %entry
  call fastcc void @snova_init() #3, !dbg !1216
  br label %if.end, !dbg !1218

if.end:                                           ; preds = %if.then, %entry
    #dbg_value(ptr %skx, !1219, !DIExpression(), !1209)
    #dbg_declare(ptr %T12, !1220, !DIExpression(), !1221)
  %add.ptr = getelementptr inbounds nuw i8, ptr %skx, i32 16, !dbg !1222
  call fastcc void @expand_T12(ptr noundef nonnull %T12, ptr noundef nonnull %add.ptr) #3, !dbg !1223
    #dbg_declare(ptr %P_matrix, !1224, !DIExpression(), !1225)
  call void @expand_public(ptr noundef nonnull %P_matrix, ptr noundef %skx) #3, !dbg !1226
    #dbg_value(ptr %P_matrix, !1227, !DIExpression(), !1209)
  %add.ptr4 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 58320, !dbg !1228
    #dbg_value(ptr %add.ptr4, !1229, !DIExpression(), !1209)
    #dbg_value(ptr %add.ptr6, !1230, !DIExpression(), !1209)
    #dbg_declare(ptr %F21, !1231, !DIExpression(), !1232)
  call void @snova_memset(ptr %F21, i8 0, i32 10800), !dbg !1232
    #dbg_value(i32 0, !1233, !DIExpression(), !1235)
  br label %for.cond, !dbg !1236

for.cond:                                         ; preds = %for.inc35, %if.end
  %i1.0 = phi i32 [ 0, %if.end ], [ %inc36, %for.inc35 ], !dbg !1237
    #dbg_value(i32 %i1.0, !1233, !DIExpression(), !1235)
  %exitcond5 = icmp ne i32 %i1.0, 5, !dbg !1238
  br i1 %exitcond5, label %for.cond7.preheader, label %for.end37, !dbg !1240

for.cond7.preheader:                              ; preds = %for.cond
  br label %for.cond7, !dbg !1241

for.cond7:                                        ; preds = %for.cond7.preheader, %for.inc32
  %j1.0 = phi i32 [ %inc33, %for.inc32 ], [ 0, %for.cond7.preheader ], !dbg !1244
    #dbg_value(i32 %j1.0, !1245, !DIExpression(), !1246)
  %exitcond4 = icmp ne i32 %j1.0, 27, !dbg !1247
  br i1 %exitcond4, label %for.cond10.preheader, label %for.inc35, !dbg !1241

for.cond10.preheader:                             ; preds = %for.cond7
  br label %for.cond10, !dbg !1249

for.cond10:                                       ; preds = %for.cond10.preheader, %for.inc29
  %j2.0 = phi i32 [ %inc30, %for.inc29 ], [ 0, %for.cond10.preheader ], !dbg !1252
    #dbg_value(i32 %j2.0, !1253, !DIExpression(), !1254)
  %exitcond3 = icmp ne i32 %j2.0, 27, !dbg !1255
  br i1 %exitcond3, label %for.cond13.preheader, label %for.inc32, !dbg !1249

for.cond13.preheader:                             ; preds = %for.cond10
  br label %for.cond13, !dbg !1257

for.cond13:                                       ; preds = %for.cond13.preheader, %for.body15
  %k1.0 = phi i32 [ %inc, %for.body15 ], [ 0, %for.cond13.preheader ], !dbg !1260
    #dbg_value(i32 %k1.0, !1261, !DIExpression(), !1262)
  %exitcond = icmp ne i32 %k1.0, 5, !dbg !1263
  br i1 %exitcond, label %for.body15, label %for.inc29, !dbg !1257

for.body15:                                       ; preds = %for.cond13
  %mul = mul nuw nsw i32 %i1.0, 5, !dbg !1265
  %add = add nuw nsw i32 %mul, %k1.0, !dbg !1267
  %mul16 = mul nuw nsw i32 %add, 27, !dbg !1268
  %add17 = add nuw nsw i32 %mul16, %j1.0, !dbg !1269
  %mul18 = shl nuw nsw i32 %add17, 4, !dbg !1270
  %arrayidx = getelementptr inbounds nuw [10800 x i8], ptr %F21, i32 0, i32 %mul18, !dbg !1271
  %mul19 = mul nuw nsw i32 %j2.0, 5, !dbg !1272
  %add20 = add nuw nsw i32 %mul19, %k1.0, !dbg !1273
  %mul21 = shl nuw nsw i32 %add20, 4, !dbg !1274
  %arrayidx22 = getelementptr inbounds nuw [2160 x i8], ptr %T12, i32 0, i32 %mul21, !dbg !1275
  %mul23 = mul nuw nsw i32 %i1.0, 27, !dbg !1276
  %add24 = add nuw nsw i32 %mul23, %j2.0, !dbg !1277
  %mul25 = mul nuw nsw i32 %add24, 27, !dbg !1278
  %add26 = add nuw nsw i32 %mul25, %j1.0, !dbg !1279
  %mul27 = shl nuw nsw i32 %add26, 4, !dbg !1280
  %arrayidx28 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 %mul27, !dbg !1281
  call fastcc void @gf_mat_mul_add(ptr noundef nonnull %arrayidx, ptr noundef nonnull %arrayidx22, ptr noundef nonnull %arrayidx28) #3, !dbg !1282
  %inc = add nuw nsw i32 %k1.0, 1, !dbg !1283
    #dbg_value(i32 %inc, !1261, !DIExpression(), !1262)
  br label %for.cond13, !dbg !1284, !llvm.loop !1285

for.inc29:                                        ; preds = %for.cond13
  %inc30 = add nuw nsw i32 %j2.0, 1, !dbg !1287
    #dbg_value(i32 %inc30, !1253, !DIExpression(), !1254)
  br label %for.cond10, !dbg !1288, !llvm.loop !1289

for.inc32:                                        ; preds = %for.cond10
  %inc33 = add nuw nsw i32 %j1.0, 1, !dbg !1291
    #dbg_value(i32 %inc33, !1245, !DIExpression(), !1246)
  br label %for.cond7, !dbg !1292, !llvm.loop !1293

for.inc35:                                        ; preds = %for.cond7
  %inc36 = add nuw nsw i32 %i1.0, 1, !dbg !1295
    #dbg_value(i32 %inc36, !1233, !DIExpression(), !1235)
  br label %for.cond, !dbg !1296, !llvm.loop !1297

for.end37:                                        ; preds = %for.cond
    #dbg_declare(ptr %F12, !1299, !DIExpression(), !1300)
  call void @snova_memset(ptr %F12, i8 0, i32 10800), !dbg !1300
    #dbg_value(i32 0, !1301, !DIExpression(), !1303)
  br label %for.cond39, !dbg !1304

for.cond39:                                       ; preds = %for.inc79, %for.end37
  %i138.0 = phi i32 [ 0, %for.end37 ], [ %inc80, %for.inc79 ], !dbg !1305
    #dbg_value(i32 %i138.0, !1301, !DIExpression(), !1303)
  %exitcond9 = icmp ne i32 %i138.0, 5, !dbg !1306
  br i1 %exitcond9, label %for.cond43.preheader, label %for.cond83.preheader, !dbg !1308

for.cond43.preheader:                             ; preds = %for.cond39
  br label %for.cond43, !dbg !1309

for.cond83.preheader:                             ; preds = %for.cond39
  br label %for.cond83, !dbg !1312

for.cond43:                                       ; preds = %for.cond43.preheader, %for.inc76
  %j142.0 = phi i32 [ %inc77, %for.inc76 ], [ 0, %for.cond43.preheader ], !dbg !1314
    #dbg_value(i32 %j142.0, !1315, !DIExpression(), !1316)
  %exitcond8 = icmp ne i32 %j142.0, 27, !dbg !1317
  br i1 %exitcond8, label %for.cond47.preheader, label %for.inc79, !dbg !1309

for.cond47.preheader:                             ; preds = %for.cond43
  br label %for.cond47, !dbg !1319

for.cond47:                                       ; preds = %for.cond47.preheader, %for.inc73
  %j246.0 = phi i32 [ %inc74, %for.inc73 ], [ 0, %for.cond47.preheader ], !dbg !1322
    #dbg_value(i32 %j246.0, !1323, !DIExpression(), !1324)
  %exitcond7 = icmp ne i32 %j246.0, 27, !dbg !1325
  br i1 %exitcond7, label %for.cond51.preheader, label %for.inc76, !dbg !1319

for.cond51.preheader:                             ; preds = %for.cond47
  br label %for.cond51, !dbg !1327

for.cond51:                                       ; preds = %for.cond51.preheader, %for.body53
  %k150.0 = phi i32 [ %inc71, %for.body53 ], [ 0, %for.cond51.preheader ], !dbg !1330
    #dbg_value(i32 %k150.0, !1331, !DIExpression(), !1332)
  %exitcond6 = icmp ne i32 %k150.0, 5, !dbg !1333
  br i1 %exitcond6, label %for.body53, label %for.inc73, !dbg !1327

for.body53:                                       ; preds = %for.cond51
  %mul54 = mul nuw nsw i32 %i138.0, 27, !dbg !1335
  %add55 = add nuw nsw i32 %mul54, %j142.0, !dbg !1337
  %mul56 = mul nuw nsw i32 %add55, 5, !dbg !1338
  %add57 = add nuw nsw i32 %mul56, %k150.0, !dbg !1339
  %mul58 = shl nuw nsw i32 %add57, 4, !dbg !1340
  %arrayidx59 = getelementptr inbounds nuw [10800 x i8], ptr %F12, i32 0, i32 %mul58, !dbg !1341
  %mul60 = mul nuw nsw i32 %i138.0, 27, !dbg !1342
  %add61 = add nuw nsw i32 %mul60, %j142.0, !dbg !1343
  %mul62 = mul nuw nsw i32 %add61, 27, !dbg !1344
  %add63 = add nuw nsw i32 %mul62, %j246.0, !dbg !1345
  %mul64 = shl nuw nsw i32 %add63, 4, !dbg !1346
  %arrayidx65 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 %mul64, !dbg !1347
  %mul66 = mul nuw nsw i32 %j246.0, 5, !dbg !1348
  %add67 = add nuw nsw i32 %mul66, %k150.0, !dbg !1349
  %mul68 = shl nuw nsw i32 %add67, 4, !dbg !1350
  %arrayidx69 = getelementptr inbounds nuw [2160 x i8], ptr %T12, i32 0, i32 %mul68, !dbg !1351
  call fastcc void @gf_mat_mul_add(ptr noundef nonnull %arrayidx59, ptr noundef nonnull %arrayidx65, ptr noundef nonnull %arrayidx69) #3, !dbg !1352
  %inc71 = add nuw nsw i32 %k150.0, 1, !dbg !1353
    #dbg_value(i32 %inc71, !1331, !DIExpression(), !1332)
  br label %for.cond51, !dbg !1354, !llvm.loop !1355

for.inc73:                                        ; preds = %for.cond51
  %inc74 = add nuw nsw i32 %j246.0, 1, !dbg !1357
    #dbg_value(i32 %inc74, !1323, !DIExpression(), !1324)
  br label %for.cond47, !dbg !1358, !llvm.loop !1359

for.inc76:                                        ; preds = %for.cond47
  %inc77 = add nuw nsw i32 %j142.0, 1, !dbg !1361
    #dbg_value(i32 %inc77, !1315, !DIExpression(), !1316)
  br label %for.cond43, !dbg !1362, !llvm.loop !1363

for.inc79:                                        ; preds = %for.cond43
  %inc80 = add nuw nsw i32 %i138.0, 1, !dbg !1365
    #dbg_value(i32 %inc80, !1301, !DIExpression(), !1303)
  br label %for.cond39, !dbg !1366, !llvm.loop !1367

for.cond83:                                       ; preds = %for.cond83.preheader, %for.body85
  %i182.0 = phi i32 [ %inc89, %for.body85 ], [ 0, %for.cond83.preheader ], !dbg !1369
    #dbg_value(i32 %i182.0, !1370, !DIExpression(), !1371)
  %exitcond10 = icmp ne i32 %i182.0, 10800, !dbg !1372
  br i1 %exitcond10, label %for.body85, label %for.cond92.preheader, !dbg !1312

for.cond92.preheader:                             ; preds = %for.cond83
  %add.ptr6 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 69120, !dbg !1374
  br label %for.cond92, !dbg !1375

for.body85:                                       ; preds = %for.cond83
  %arrayidx86 = getelementptr inbounds nuw [10800 x i8], ptr %F12, i32 0, i32 %i182.0, !dbg !1377
  %arrayidx87 = getelementptr inbounds nuw i8, ptr %add.ptr4, i32 %i182.0, !dbg !1379
  %0 = load i8, ptr %arrayidx87, align 1, !dbg !1379
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx86, i8 noundef zeroext %0) #3, !dbg !1380
  %inc89 = add nuw nsw i32 %i182.0, 1, !dbg !1381
    #dbg_value(i32 %inc89, !1370, !DIExpression(), !1371)
  br label %for.cond83, !dbg !1382, !llvm.loop !1383

for.cond92:                                       ; preds = %for.cond92.preheader, %for.body94
  %i191.0 = phi i32 [ %inc98, %for.body94 ], [ 0, %for.cond92.preheader ], !dbg !1385
    #dbg_value(i32 %i191.0, !1386, !DIExpression(), !1387)
  %exitcond11 = icmp ne i32 %i191.0, 10800, !dbg !1388
  br i1 %exitcond11, label %for.body94, label %for.end99, !dbg !1375

for.body94:                                       ; preds = %for.cond92
  %arrayidx95 = getelementptr inbounds nuw [10800 x i8], ptr %F21, i32 0, i32 %i191.0, !dbg !1390
  %arrayidx96 = getelementptr inbounds nuw i8, ptr %add.ptr6, i32 %i191.0, !dbg !1392
  %1 = load i8, ptr %arrayidx96, align 1, !dbg !1392
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx95, i8 noundef zeroext %1) #3, !dbg !1393
  %inc98 = add nuw nsw i32 %i191.0, 1, !dbg !1394
    #dbg_value(i32 %inc98, !1386, !DIExpression(), !1387)
  br label %for.cond92, !dbg !1395, !llvm.loop !1396

for.end99:                                        ; preds = %for.cond92
    #dbg_declare(ptr %Am, !1398, !DIExpression(), !1402)
    #dbg_declare(ptr %Bm, !1403, !DIExpression(), !1404)
    #dbg_declare(ptr %Q1, !1405, !DIExpression(), !1406)
    #dbg_declare(ptr %Q2, !1407, !DIExpression(), !1408)
  %add.ptr101 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 79920, !dbg !1409
    #dbg_value(ptr %add.ptr101, !1410, !DIExpression(), !1209)
  %add.ptr102 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 83760, !dbg !1411
    #dbg_value(ptr %add.ptr102, !1412, !DIExpression(), !1209)
  %add.ptr103 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 84240, !dbg !1413
    #dbg_value(ptr %add.ptr103, !1414, !DIExpression(), !1209)
  %call = call ptr @memcpy(ptr noundef nonnull %add.ptr101, ptr noundef nonnull @fixed_abq, i32 noundef 4800) #4, !dbg !1415
  call fastcc void @gen_ABQ(ptr noundef nonnull %add.ptr101, ptr noundef nonnull %Am, ptr noundef nonnull %Bm, ptr noundef nonnull %Q1, ptr noundef nonnull %Q2) #3, !dbg !1416
    #dbg_declare(ptr %hash_in_GF16, !1417, !DIExpression(), !1421)
    #dbg_declare(ptr %sign_hashb, !1422, !DIExpression(), !1426)
  %add.ptr110 = getelementptr inbounds nuw i8, ptr %skx, i32 48, !dbg !1427
  call fastcc void @hash_combined(ptr noundef nonnull %sign_hashb, ptr noundef %digest, i32 noundef %len_digest, ptr noundef nonnull %add.ptr110, ptr noundef %salt) #3, !dbg !1428
  %call113 = call fastcc i32 @expand_gf(ptr noundef nonnull %hash_in_GF16, ptr noundef nonnull %sign_hashb, i32 noundef 80) #3, !dbg !1429
    #dbg_declare(ptr %gauss, !1430, !DIExpression(), !1434)
    #dbg_declare(ptr %solution, !1435, !DIExpression(), !1436)
  call void @snova_memset(ptr %solution, i8 0, i32 80), !dbg !1436
    #dbg_declare(ptr %signature_in_GF, !1437, !DIExpression(), !1441)
  call void @snova_memset(ptr %signature_in_GF, i8 0, i32 512), !dbg !1441
    #dbg_value(i32 1, !1442, !DIExpression(), !1209)
    #dbg_value(i8 0, !1443, !DIExpression(), !1209)
  store i8 0, ptr %num_sign, align 1, !dbg !1444
  br label %do.body, !dbg !1445

do.body.loopexit:                                 ; preds = %if.end868
  br label %do.body, !dbg !1446

do.body:                                          ; preds = %do.body.loopexit, %for.end99
  %call115 = call ptr @memset(ptr noundef nonnull %gauss, i32 noundef 0, i32 noundef 6480) #4, !dbg !1449
  %2 = load i8, ptr %num_sign, align 1, !dbg !1450
    #dbg_value(i8 %2, !1443, !DIExpression(), !1209)
  %inc116 = add i8 %2, 1, !dbg !1450
    #dbg_value(i8 %inc116, !1443, !DIExpression(), !1209)
  store i8 %inc116, ptr %num_sign, align 1, !dbg !1450
    #dbg_value(i8 %inc116, !1443, !DIExpression(), !1209)
  %cmp117 = icmp eq i8 %inc116, -1, !dbg !1446
  br i1 %cmp117, label %if.then119, label %if.end121, !dbg !1446

if.then119:                                       ; preds = %do.body
  %call120 = call ptr @memset(ptr noundef %sig, i32 noundef 0, i32 noundef 272) #4, !dbg !1451
  br label %return, !dbg !1453

if.end121:                                        ; preds = %do.body
    #dbg_value(i32 0, !1442, !DIExpression(), !1209)
    #dbg_declare(ptr %vinegar_in_byte, !1454, !DIExpression(), !1458)
    #dbg_declare(ptr %v_instance, !1459, !DIExpression(), !1460)
  call void @shake256_init(ptr noundef nonnull %v_instance) #3, !dbg !1461
  %add.ptr122 = getelementptr inbounds nuw i8, ptr %skx, i32 16, !dbg !1462
  call void @shake_absorb(ptr noundef nonnull %v_instance, ptr noundef nonnull %add.ptr122, i32 noundef 32) #3, !dbg !1463
  call void @shake_absorb(ptr noundef nonnull %v_instance, ptr noundef %digest, i32 noundef 64) #3, !dbg !1464
  call void @shake_absorb(ptr noundef nonnull %v_instance, ptr noundef %salt, i32 noundef 16) #3, !dbg !1465
    #dbg_value(ptr %num_sign, !1443, !DIExpression(DW_OP_deref), !1209)
  call void @shake_absorb(ptr noundef nonnull %v_instance, ptr noundef nonnull %num_sign, i32 noundef 1) #3, !dbg !1466
  call void @shake_finalize(ptr noundef nonnull %v_instance) #3, !dbg !1467
    #dbg_value(i32 32, !1468, !DIExpression(), !1469)
    #dbg_value(i32 0, !1470, !DIExpression(), !1469)
  br label %while.cond, !dbg !1471

while.cond:                                       ; preds = %if.end129, %if.end121
  %t_idx.0 = phi i32 [ 0, %if.end121 ], [ %inc139, %if.end129 ], !dbg !1469
  %b_idx.0 = phi i32 [ 32, %if.end121 ], [ %inc140, %if.end129 ], !dbg !1469
    #dbg_value(i32 %b_idx.0, !1468, !DIExpression(), !1469)
    #dbg_value(i32 %t_idx.0, !1470, !DIExpression(), !1469)
  %cmp123 = icmp samesign ult i32 %t_idx.0, 432, !dbg !1472
  br i1 %cmp123, label %while.body, label %while.end, !dbg !1471

while.body:                                       ; preds = %while.cond
  %cmp125 = icmp ugt i32 %b_idx.0, 31, !dbg !1473
  br i1 %cmp125, label %if.then127, label %if.end129, !dbg !1473

if.then127:                                       ; preds = %while.body
  call void @shake_squeeze(ptr noundef nonnull %vinegar_in_byte, i32 noundef 32, ptr noundef nonnull %v_instance) #3, !dbg !1476
    #dbg_value(i32 0, !1468, !DIExpression(), !1469)
  br label %if.end129, !dbg !1478

if.end129:                                        ; preds = %if.then127, %while.body
  %b_idx.1 = phi i32 [ 0, %if.then127 ], [ %b_idx.0, %while.body ], !dbg !1469
    #dbg_value(i32 %b_idx.1, !1468, !DIExpression(), !1469)
  %arrayidx130 = getelementptr inbounds nuw [216 x i8], ptr %vinegar_in_byte, i32 0, i32 %b_idx.1, !dbg !1479
  %3 = load i8, ptr %arrayidx130, align 1, !dbg !1479
  %4 = and i8 %3, 15, !dbg !1480
  %arrayidx133 = getelementptr inbounds nuw [512 x i8], ptr %signature_in_GF, i32 0, i32 %t_idx.0, !dbg !1481
  store i8 %4, ptr %arrayidx133, align 1, !dbg !1482
  %inc134 = or disjoint i32 %t_idx.0, 1, !dbg !1483
    #dbg_value(i32 %inc134, !1470, !DIExpression(), !1469)
  %5 = lshr i8 %3, 4, !dbg !1484
  %arrayidx138 = getelementptr inbounds nuw [512 x i8], ptr %signature_in_GF, i32 0, i32 %inc134, !dbg !1485
  store i8 %5, ptr %arrayidx138, align 1, !dbg !1486
  %inc139 = add nuw nsw i32 %t_idx.0, 2, !dbg !1487
    #dbg_value(i32 %inc139, !1470, !DIExpression(), !1469)
  %inc140 = add nuw nsw i32 %b_idx.1, 1, !dbg !1488
    #dbg_value(i32 %inc140, !1468, !DIExpression(), !1469)
  br label %while.cond, !dbg !1471, !llvm.loop !1489

while.end:                                        ; preds = %while.cond
    #dbg_declare(ptr %Fvv_in_GF16Matrix, !1491, !DIExpression(), !1492)
  call void @snova_memset(ptr %Fvv_in_GF16Matrix, i8 0, i32 80), !dbg !1492
    #dbg_declare(ptr %sum_t0, !1493, !DIExpression(), !1497)
  call void @snova_memset(ptr %sum_t0, i8 0, i32 8640), !dbg !1497
    #dbg_declare(ptr %sum_t1, !1498, !DIExpression(), !1502)
  call void @snova_memset(ptr %sum_t1, i8 0, i32 1280), !dbg !1502
    #dbg_declare(ptr %whipped_sig, !1503, !DIExpression(), !1507)
  call void @snova_memset(ptr %whipped_sig, i8 0, i32 1728), !dbg !1507
    #dbg_value(i32 0, !1508, !DIExpression(), !1510)
  br label %for.cond141, !dbg !1511

for.cond141:                                      ; preds = %for.inc194, %while.end
  %ab.0 = phi i32 [ 0, %while.end ], [ %inc195, %for.inc194 ], !dbg !1512
    #dbg_value(i32 %ab.0, !1508, !DIExpression(), !1510)
  %exitcond16 = icmp ne i32 %ab.0, 4, !dbg !1513
  br i1 %exitcond16, label %for.cond145.preheader, label %for.cond197.preheader, !dbg !1515

for.cond197.preheader:                            ; preds = %for.cond141
  br label %for.cond197, !dbg !1516

for.cond145.preheader:                            ; preds = %for.cond141
  br label %for.cond145, !dbg !1518

for.cond145:                                      ; preds = %for.cond145.preheader, %for.inc191
  %ni.0 = phi i32 [ %inc192, %for.inc191 ], [ 0, %for.cond145.preheader ], !dbg !1520
    #dbg_value(i32 %ni.0, !1521, !DIExpression(), !1522)
  %exitcond15 = icmp ne i32 %ni.0, 27, !dbg !1523
  br i1 %exitcond15, label %for.cond150.preheader, label %for.inc194, !dbg !1518

for.cond150.preheader:                            ; preds = %for.cond145
  br label %for.cond150, !dbg !1525

for.cond150:                                      ; preds = %for.cond150.preheader, %for.inc188
  %i1149.0 = phi i32 [ %inc189, %for.inc188 ], [ 0, %for.cond150.preheader ], !dbg !1527
    #dbg_value(i32 %i1149.0, !1528, !DIExpression(), !1529)
  %exitcond14 = icmp ne i32 %i1149.0, 4, !dbg !1530
  br i1 %exitcond14, label %for.cond155.preheader, label %for.inc191, !dbg !1525

for.cond155.preheader:                            ; preds = %for.cond150
  br label %for.cond155, !dbg !1532

for.cond155:                                      ; preds = %for.cond155.preheader, %for.inc185
  %j1154.0 = phi i32 [ %inc186, %for.inc185 ], [ 0, %for.cond155.preheader ], !dbg !1534
    #dbg_value(i32 %j1154.0, !1535, !DIExpression(), !1536)
  %exitcond13 = icmp ne i32 %j1154.0, 4, !dbg !1537
  br i1 %exitcond13, label %for.cond160.preheader, label %for.inc188, !dbg !1532

for.cond160.preheader:                            ; preds = %for.cond155
  br label %for.cond160, !dbg !1539

for.cond160:                                      ; preds = %for.cond160.preheader, %for.body163
  %k1159.0 = phi i32 [ %inc183, %for.body163 ], [ 0, %for.cond160.preheader ], !dbg !1541
    #dbg_value(i32 %k1159.0, !1542, !DIExpression(), !1543)
  %exitcond12 = icmp ne i32 %k1159.0, 4, !dbg !1544
  br i1 %exitcond12, label %for.body163, label %for.inc185, !dbg !1539

for.body163:                                      ; preds = %for.cond160
  %mul164 = mul nuw nsw i32 %ab.0, 27, !dbg !1546
  %add165 = add nuw nsw i32 %mul164, %ni.0, !dbg !1547
  %mul166 = shl nuw nsw i32 %add165, 4, !dbg !1548
  %mul167 = shl nuw nsw i32 %i1149.0, 2, !dbg !1549
  %add168 = or disjoint i32 %mul166, %mul167, !dbg !1550
  %add169 = or disjoint i32 %add168, %j1154.0, !dbg !1551
  %arrayidx170 = getelementptr inbounds nuw [1728 x i8], ptr %whipped_sig, i32 0, i32 %add169, !dbg !1552
  %mul171 = shl nuw nsw i32 %ab.0, 4, !dbg !1553
  %mul172 = shl nuw nsw i32 %i1149.0, 2, !dbg !1554
  %add173 = or disjoint i32 %mul171, %mul172, !dbg !1555
  %add174 = or disjoint i32 %add173, %k1159.0, !dbg !1556
  %arrayidx175 = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %add174, !dbg !1557
  %6 = load i8, ptr %arrayidx175, align 1, !dbg !1557
  %mul176 = shl nuw nsw i32 %ni.0, 4, !dbg !1558
  %mul177 = shl nuw nsw i32 %k1159.0, 2, !dbg !1559
  %add178 = or disjoint i32 %mul176, %mul177, !dbg !1560
  %add179 = or disjoint i32 %add178, %j1154.0, !dbg !1561
  %arrayidx180 = getelementptr inbounds nuw [512 x i8], ptr %signature_in_GF, i32 0, i32 %add179, !dbg !1562
  %7 = load i8, ptr %arrayidx180, align 1, !dbg !1562
  %call181 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %6, i8 noundef zeroext %7) #3, !dbg !1563
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx170, i8 noundef zeroext %call181) #3, !dbg !1564
  %inc183 = add nuw nsw i32 %k1159.0, 1, !dbg !1565
    #dbg_value(i32 %inc183, !1542, !DIExpression(), !1543)
  br label %for.cond160, !dbg !1566, !llvm.loop !1567

for.inc185:                                       ; preds = %for.cond160
  %inc186 = add nuw nsw i32 %j1154.0, 1, !dbg !1569
    #dbg_value(i32 %inc186, !1535, !DIExpression(), !1536)
  br label %for.cond155, !dbg !1570, !llvm.loop !1571

for.inc188:                                       ; preds = %for.cond155
  %inc189 = add nuw nsw i32 %i1149.0, 1, !dbg !1573
    #dbg_value(i32 %inc189, !1528, !DIExpression(), !1529)
  br label %for.cond150, !dbg !1574, !llvm.loop !1575

for.inc191:                                       ; preds = %for.cond150
  %inc192 = add nuw nsw i32 %ni.0, 1, !dbg !1577
    #dbg_value(i32 %inc192, !1521, !DIExpression(), !1522)
  br label %for.cond145, !dbg !1578, !llvm.loop !1579

for.inc194:                                       ; preds = %for.cond145
  %inc195 = add nuw nsw i32 %ab.0, 1, !dbg !1581
    #dbg_value(i32 %inc195, !1508, !DIExpression(), !1510)
  br label %for.cond141, !dbg !1582, !llvm.loop !1583

for.cond197:                                      ; preds = %for.cond197.preheader, %for.inc312
  %mi.0 = phi i32 [ %inc313, %for.inc312 ], [ 0, %for.cond197.preheader ], !dbg !1585
    #dbg_value(i32 %mi.0, !1586, !DIExpression(), !1587)
  %exitcond26 = icmp ne i32 %mi.0, 5, !dbg !1588
  br i1 %exitcond26, label %for.cond202.preheader, label %for.cond316.preheader, !dbg !1516

for.cond316.preheader:                            ; preds = %for.cond197
  br label %for.cond316, !dbg !1590

for.cond202.preheader:                            ; preds = %for.cond197
  br label %for.cond202, !dbg !1592

for.cond202:                                      ; preds = %for.cond202.preheader, %for.inc236
  %ni201.0 = phi i32 [ %inc237, %for.inc236 ], [ 0, %for.cond202.preheader ], !dbg !1595
    #dbg_value(i32 %ni201.0, !1596, !DIExpression(), !1597)
  %exitcond19 = icmp ne i32 %ni201.0, 27, !dbg !1598
  br i1 %exitcond19, label %for.cond206.preheader, label %for.cond239.preheader, !dbg !1592

for.cond239.preheader:                            ; preds = %for.cond202
  br label %for.cond239, !dbg !1600

for.cond206.preheader:                            ; preds = %for.cond202
  br label %for.cond206, !dbg !1602

for.cond206:                                      ; preds = %for.cond206.preheader, %for.inc233
  %b1.0 = phi i32 [ %inc234, %for.inc233 ], [ 0, %for.cond206.preheader ], !dbg !1604
    #dbg_value(i32 %b1.0, !1605, !DIExpression(), !1606)
  %exitcond18 = icmp ne i32 %b1.0, 4, !dbg !1607
  br i1 %exitcond18, label %for.cond210.preheader, label %for.inc236, !dbg !1602

for.cond210.preheader:                            ; preds = %for.cond206
  br label %for.cond210, !dbg !1609

for.cond210:                                      ; preds = %for.cond210.preheader, %for.body213
  %nj.0 = phi i32 [ %inc231, %for.body213 ], [ 0, %for.cond210.preheader ], !dbg !1611
    #dbg_value(i32 %nj.0, !1612, !DIExpression(), !1613)
  %exitcond17 = icmp ne i32 %nj.0, 27, !dbg !1614
  br i1 %exitcond17, label %for.body213, label %for.inc233, !dbg !1609

for.body213:                                      ; preds = %for.cond210
  %mul214 = shl nuw nsw i32 %mi.0, 2, !dbg !1616
  %add215 = or disjoint i32 %mul214, %b1.0, !dbg !1617
  %mul216 = mul nuw nsw i32 %add215, 27, !dbg !1618
  %add217 = add nuw nsw i32 %mul216, %ni201.0, !dbg !1619
  %mul218 = shl nuw nsw i32 %add217, 4, !dbg !1620
  %arrayidx219 = getelementptr inbounds nuw [8640 x i8], ptr %sum_t0, i32 0, i32 %mul218, !dbg !1621
  %mul220 = mul nuw nsw i32 %mi.0, 27, !dbg !1622
  %add221 = add nuw nsw i32 %mul220, %ni201.0, !dbg !1623
  %mul222 = mul nuw nsw i32 %add221, 27, !dbg !1624
  %add223 = add nuw nsw i32 %mul222, %nj.0, !dbg !1625
  %mul224 = shl nuw nsw i32 %add223, 4, !dbg !1626
  %arrayidx225 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 %mul224, !dbg !1627
  %mul226 = mul nuw nsw i32 %b1.0, 27, !dbg !1628
  %add227 = add nuw nsw i32 %mul226, %nj.0, !dbg !1629
  %mul228 = shl nuw nsw i32 %add227, 4, !dbg !1630
  %arrayidx229 = getelementptr inbounds nuw [1728 x i8], ptr %whipped_sig, i32 0, i32 %mul228, !dbg !1631
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %arrayidx219, ptr noundef nonnull %arrayidx225, ptr noundef nonnull %arrayidx229, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !1632
  %inc231 = add nuw nsw i32 %nj.0, 1, !dbg !1633
    #dbg_value(i32 %inc231, !1612, !DIExpression(), !1613)
  br label %for.cond210, !dbg !1634, !llvm.loop !1635

for.inc233:                                       ; preds = %for.cond210
  %inc234 = add nuw nsw i32 %b1.0, 1, !dbg !1637
    #dbg_value(i32 %inc234, !1605, !DIExpression(), !1606)
  br label %for.cond206, !dbg !1638, !llvm.loop !1639

for.inc236:                                       ; preds = %for.cond206
  %inc237 = add nuw nsw i32 %ni201.0, 1, !dbg !1641
    #dbg_value(i32 %inc237, !1596, !DIExpression(), !1597)
  br label %for.cond202, !dbg !1642, !llvm.loop !1643

for.cond239:                                      ; preds = %for.cond239.preheader, %for.inc309
  %a1.0 = phi i32 [ %inc310, %for.inc309 ], [ 0, %for.cond239.preheader ], !dbg !1645
    #dbg_value(i32 %a1.0, !1646, !DIExpression(), !1647)
  %exitcond25 = icmp ne i32 %a1.0, 4, !dbg !1648
  br i1 %exitcond25, label %for.cond244.preheader, label %for.inc312, !dbg !1600

for.cond244.preheader:                            ; preds = %for.cond239
  br label %for.cond244, !dbg !1650

for.cond244:                                      ; preds = %for.cond244.preheader, %for.inc306
  %b1243.0 = phi i32 [ %inc307, %for.inc306 ], [ 0, %for.cond244.preheader ], !dbg !1652
    #dbg_value(i32 %b1243.0, !1653, !DIExpression(), !1654)
  %exitcond24 = icmp ne i32 %b1243.0, 4, !dbg !1655
  br i1 %exitcond24, label %for.cond249.preheader, label %for.inc309, !dbg !1650

for.cond249.preheader:                            ; preds = %for.cond244
  br label %for.cond249, !dbg !1657

for.cond249:                                      ; preds = %for.cond249.preheader, %for.inc303
  %ni248.0 = phi i32 [ %inc304, %for.inc303 ], [ 0, %for.cond249.preheader ], !dbg !1659
    #dbg_value(i32 %ni248.0, !1660, !DIExpression(), !1661)
  %exitcond23 = icmp ne i32 %ni248.0, 27, !dbg !1662
  br i1 %exitcond23, label %for.cond254.preheader, label %for.inc306, !dbg !1657

for.cond254.preheader:                            ; preds = %for.cond249
  br label %for.cond254, !dbg !1664

for.cond254:                                      ; preds = %for.cond254.preheader, %for.inc300
  %i1253.0 = phi i32 [ %inc301, %for.inc300 ], [ 0, %for.cond254.preheader ], !dbg !1666
    #dbg_value(i32 %i1253.0, !1667, !DIExpression(), !1668)
  %exitcond22 = icmp ne i32 %i1253.0, 4, !dbg !1669
  br i1 %exitcond22, label %for.cond259.preheader, label %for.inc303, !dbg !1664

for.cond259.preheader:                            ; preds = %for.cond254
  br label %for.cond259, !dbg !1671

for.cond259:                                      ; preds = %for.cond259.preheader, %for.inc297
  %j1258.0 = phi i32 [ %inc298, %for.inc297 ], [ 0, %for.cond259.preheader ], !dbg !1673
    #dbg_value(i32 %j1258.0, !1674, !DIExpression(), !1675)
  %exitcond21 = icmp ne i32 %j1258.0, 4, !dbg !1676
  br i1 %exitcond21, label %for.cond264.preheader, label %for.inc300, !dbg !1671

for.cond264.preheader:                            ; preds = %for.cond259
  br label %for.cond264, !dbg !1678

for.cond264:                                      ; preds = %for.cond264.preheader, %for.body267
  %k1263.0 = phi i32 [ %inc295, %for.body267 ], [ 0, %for.cond264.preheader ], !dbg !1680
    #dbg_value(i32 %k1263.0, !1681, !DIExpression(), !1682)
  %exitcond20 = icmp ne i32 %k1263.0, 4, !dbg !1683
  br i1 %exitcond20, label %for.body267, label %for.inc297, !dbg !1678

for.body267:                                      ; preds = %for.cond264
  %mul268 = shl nuw nsw i32 %mi.0, 4, !dbg !1685
  %mul269 = shl nuw nsw i32 %a1.0, 2, !dbg !1686
  %add270 = or disjoint i32 %mul268, %mul269, !dbg !1687
  %add271 = or disjoint i32 %add270, %b1243.0, !dbg !1688
  %mul272 = shl nuw nsw i32 %add271, 4, !dbg !1689
  %mul273 = shl nuw nsw i32 %i1253.0, 2, !dbg !1690
  %add274 = or disjoint i32 %mul272, %mul273, !dbg !1691
  %add275 = or disjoint i32 %add274, %j1258.0, !dbg !1692
  %arrayidx276 = getelementptr inbounds nuw [1280 x i8], ptr %sum_t1, i32 0, i32 %add275, !dbg !1693
  %mul277 = mul nuw nsw i32 %a1.0, 27, !dbg !1694
  %add278 = add nuw nsw i32 %mul277, %ni248.0, !dbg !1695
  %mul279 = shl nuw nsw i32 %add278, 4, !dbg !1696
  %mul280 = shl nuw nsw i32 %k1263.0, 2, !dbg !1697
  %add281 = or disjoint i32 %mul279, %mul280, !dbg !1698
  %add282 = or disjoint i32 %add281, %i1253.0, !dbg !1699
  %arrayidx283 = getelementptr inbounds nuw [1728 x i8], ptr %whipped_sig, i32 0, i32 %add282, !dbg !1700
  %8 = load i8, ptr %arrayidx283, align 1, !dbg !1700
  %mul284 = shl nuw nsw i32 %mi.0, 2, !dbg !1701
  %add285 = or disjoint i32 %mul284, %b1243.0, !dbg !1702
  %mul286 = mul nuw nsw i32 %add285, 27, !dbg !1703
  %add287 = add nuw nsw i32 %mul286, %ni248.0, !dbg !1704
  %mul288 = shl nuw nsw i32 %add287, 4, !dbg !1705
  %mul289 = shl nuw nsw i32 %k1263.0, 2, !dbg !1706
  %add290 = or disjoint i32 %mul288, %mul289, !dbg !1707
  %add291 = or disjoint i32 %add290, %j1258.0, !dbg !1708
  %arrayidx292 = getelementptr inbounds nuw [8640 x i8], ptr %sum_t0, i32 0, i32 %add291, !dbg !1709
  %9 = load i8, ptr %arrayidx292, align 1, !dbg !1709
  %call293 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %8, i8 noundef zeroext %9) #3, !dbg !1710
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx276, i8 noundef zeroext %call293) #3, !dbg !1711
  %inc295 = add nuw nsw i32 %k1263.0, 1, !dbg !1712
    #dbg_value(i32 %inc295, !1681, !DIExpression(), !1682)
  br label %for.cond264, !dbg !1713, !llvm.loop !1714

for.inc297:                                       ; preds = %for.cond264
  %inc298 = add nuw nsw i32 %j1258.0, 1, !dbg !1716
    #dbg_value(i32 %inc298, !1674, !DIExpression(), !1675)
  br label %for.cond259, !dbg !1717, !llvm.loop !1718

for.inc300:                                       ; preds = %for.cond259
  %inc301 = add nuw nsw i32 %i1253.0, 1, !dbg !1720
    #dbg_value(i32 %inc301, !1667, !DIExpression(), !1668)
  br label %for.cond254, !dbg !1721, !llvm.loop !1722

for.inc303:                                       ; preds = %for.cond254
  %inc304 = add nuw nsw i32 %ni248.0, 1, !dbg !1724
    #dbg_value(i32 %inc304, !1660, !DIExpression(), !1661)
  br label %for.cond249, !dbg !1725, !llvm.loop !1726

for.inc306:                                       ; preds = %for.cond249
  %inc307 = add nuw nsw i32 %b1243.0, 1, !dbg !1728
    #dbg_value(i32 %inc307, !1653, !DIExpression(), !1654)
  br label %for.cond244, !dbg !1729, !llvm.loop !1730

for.inc309:                                       ; preds = %for.cond244
  %inc310 = add nuw nsw i32 %a1.0, 1, !dbg !1732
    #dbg_value(i32 %inc310, !1646, !DIExpression(), !1647)
  br label %for.cond239, !dbg !1733, !llvm.loop !1734

for.inc312:                                       ; preds = %for.cond239
  %inc313 = add nuw nsw i32 %mi.0, 1, !dbg !1736
    #dbg_value(i32 %inc313, !1586, !DIExpression(), !1587)
  br label %for.cond197, !dbg !1737, !llvm.loop !1738

for.cond316:                                      ; preds = %for.cond316.preheader, %for.inc419
  %mi315.0 = phi i32 [ %inc420, %for.inc419 ], [ 0, %for.cond316.preheader ], !dbg !1740
    #dbg_value(i32 %mi315.0, !1741, !DIExpression(), !1742)
  %exitcond34 = icmp ne i32 %mi315.0, 5, !dbg !1743
  br i1 %exitcond34, label %for.cond320.preheader, label %for.cond423.preheader, !dbg !1590

for.cond423.preheader:                            ; preds = %for.cond316
  br label %for.cond423, !dbg !1745

for.cond320.preheader:                            ; preds = %for.cond316
  br label %for.cond320, !dbg !1747

for.cond320:                                      ; preds = %for.cond320.preheader, %for.end402
  %alpha.0 = phi i32 [ %inc417, %for.end402 ], [ 0, %for.cond320.preheader ], !dbg !1749
    #dbg_value(i32 %alpha.0, !1750, !DIExpression(), !1751)
  %exitcond33 = icmp ne i32 %alpha.0, 24, !dbg !1752
  br i1 %exitcond33, label %for.body323, label %for.inc419, !dbg !1747

for.body323:                                      ; preds = %for.cond320
  %add324 = add nuw nsw i32 %alpha.0, %mi315.0, !dbg !1754
  %rem = urem i32 %add324, 5, !dbg !1754
    #dbg_value(i32 %rem, !1756, !DIExpression(), !1757)
    #dbg_declare(ptr %gf16m_temp1, !1758, !DIExpression(), !1759)
  call void @snova_memset(ptr %gf16m_temp1, i8 0, i32 16), !dbg !1759
    #dbg_declare(ptr %gf16m_temp2, !1760, !DIExpression(), !1761)
  call void @snova_memset(ptr %gf16m_temp2, i8 0, i32 16), !dbg !1761
    #dbg_value(i32 0, !1762, !DIExpression(), !1764)
  br label %for.cond326, !dbg !1765

for.cond326:                                      ; preds = %for.inc400, %for.body323
  %a1325.0 = phi i32 [ 0, %for.body323 ], [ %inc401, %for.inc400 ], !dbg !1766
    #dbg_value(i32 %a1325.0, !1762, !DIExpression(), !1764)
  %exitcond32 = icmp ne i32 %a1325.0, 4, !dbg !1767
  br i1 %exitcond32, label %for.body329, label %for.end402, !dbg !1769

for.body329:                                      ; preds = %for.cond326
    #dbg_declare(ptr %sumb, !1770, !DIExpression(), !1772)
  call void @snova_memset(ptr %sumb, i8 0, i32 16), !dbg !1772
    #dbg_value(i32 0, !1773, !DIExpression(), !1775)
  br label %for.cond331, !dbg !1776

for.cond331:                                      ; preds = %for.inc369, %for.body329
  %b1330.0 = phi i32 [ 0, %for.body329 ], [ %inc370, %for.inc369 ], !dbg !1777
    #dbg_value(i32 %b1330.0, !1773, !DIExpression(), !1775)
  %exitcond29 = icmp ne i32 %b1330.0, 4, !dbg !1778
  br i1 %exitcond29, label %for.cond336.preheader, label %for.cond373.preheader, !dbg !1780

for.cond373.preheader:                            ; preds = %for.cond331
  br label %for.cond373, !dbg !1781

for.cond336.preheader:                            ; preds = %for.cond331
  br label %for.cond336, !dbg !1783

for.cond336:                                      ; preds = %for.cond336.preheader, %for.inc366
  %i1335.0 = phi i32 [ %inc367, %for.inc366 ], [ 0, %for.cond336.preheader ], !dbg !1785
    #dbg_value(i32 %i1335.0, !1786, !DIExpression(), !1787)
  %exitcond28 = icmp ne i32 %i1335.0, 4, !dbg !1788
  br i1 %exitcond28, label %for.cond341.preheader, label %for.inc369, !dbg !1783

for.cond341.preheader:                            ; preds = %for.cond336
  br label %for.cond341, !dbg !1790

for.cond341:                                      ; preds = %for.cond341.preheader, %for.body344
  %j1340.0 = phi i32 [ %inc364, %for.body344 ], [ 0, %for.cond341.preheader ], !dbg !1792
    #dbg_value(i32 %j1340.0, !1793, !DIExpression(), !1794)
  %exitcond27 = icmp ne i32 %j1340.0, 4, !dbg !1795
  br i1 %exitcond27, label %for.body344, label %for.inc366, !dbg !1790

for.body344:                                      ; preds = %for.cond341
  %mul345 = shl nuw nsw i32 %i1335.0, 2, !dbg !1797
  %add346 = or disjoint i32 %mul345, %j1340.0, !dbg !1798
  %arrayidx347 = getelementptr inbounds nuw [16 x i8], ptr %sumb, i32 0, i32 %add346, !dbg !1799
  %mul348 = shl nuw nsw i32 %rem, 4, !dbg !1800
  %mul349 = shl nuw nsw i32 %a1325.0, 2, !dbg !1801
  %add350 = or disjoint i32 %mul348, %mul349, !dbg !1802
  %add351 = or disjoint i32 %add350, %b1330.0, !dbg !1803
  %mul352 = shl nuw nsw i32 %add351, 4, !dbg !1804
  %mul353 = shl nuw nsw i32 %i1335.0, 2, !dbg !1805
  %add354 = or disjoint i32 %mul352, %mul353, !dbg !1806
  %add355 = or disjoint i32 %add354, %j1340.0, !dbg !1807
  %arrayidx356 = getelementptr inbounds nuw [1280 x i8], ptr %sum_t1, i32 0, i32 %add355, !dbg !1808
  %10 = load i8, ptr %arrayidx356, align 1, !dbg !1808
  %mul357 = mul nuw nsw i32 %mi315.0, 24, !dbg !1809
  %add358 = add nuw nsw i32 %mul357, %alpha.0, !dbg !1810
  %mul359 = shl nuw nsw i32 %add358, 2, !dbg !1811
  %add360 = or disjoint i32 %mul359, %b1330.0, !dbg !1812
  %arrayidx361 = getelementptr inbounds nuw i8, ptr %add.ptr103, i32 %add360, !dbg !1813
  %11 = load i8, ptr %arrayidx361, align 1, !dbg !1813
  %call362 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %10, i8 noundef zeroext %11) #3, !dbg !1814
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx347, i8 noundef zeroext %call362) #3, !dbg !1815
  %inc364 = add nuw nsw i32 %j1340.0, 1, !dbg !1816
    #dbg_value(i32 %inc364, !1793, !DIExpression(), !1794)
  br label %for.cond341, !dbg !1817, !llvm.loop !1818

for.inc366:                                       ; preds = %for.cond341
  %inc367 = add nuw nsw i32 %i1335.0, 1, !dbg !1820
    #dbg_value(i32 %inc367, !1786, !DIExpression(), !1787)
  br label %for.cond336, !dbg !1821, !llvm.loop !1822

for.inc369:                                       ; preds = %for.cond336
  %inc370 = add nuw nsw i32 %b1330.0, 1, !dbg !1824
    #dbg_value(i32 %inc370, !1773, !DIExpression(), !1775)
  br label %for.cond331, !dbg !1825, !llvm.loop !1826

for.cond373:                                      ; preds = %for.cond373.preheader, %for.inc397
  %i1372.0 = phi i32 [ %inc398, %for.inc397 ], [ 0, %for.cond373.preheader ], !dbg !1828
    #dbg_value(i32 %i1372.0, !1829, !DIExpression(), !1830)
  %exitcond31 = icmp ne i32 %i1372.0, 4, !dbg !1831
  br i1 %exitcond31, label %for.cond378.preheader, label %for.inc400, !dbg !1781

for.cond378.preheader:                            ; preds = %for.cond373
  br label %for.cond378, !dbg !1833

for.cond378:                                      ; preds = %for.cond378.preheader, %for.body381
  %j1377.0 = phi i32 [ %inc395, %for.body381 ], [ 0, %for.cond378.preheader ], !dbg !1835
    #dbg_value(i32 %j1377.0, !1836, !DIExpression(), !1837)
  %exitcond30 = icmp ne i32 %j1377.0, 4, !dbg !1838
  br i1 %exitcond30, label %for.body381, label %for.inc397, !dbg !1833

for.body381:                                      ; preds = %for.cond378
  %mul382 = shl nuw nsw i32 %i1372.0, 2, !dbg !1840
  %add383 = or disjoint i32 %mul382, %j1377.0, !dbg !1841
  %arrayidx384 = getelementptr inbounds nuw [16 x i8], ptr %gf16m_temp1, i32 0, i32 %add383, !dbg !1842
  %mul385 = shl nuw nsw i32 %i1372.0, 2, !dbg !1843
  %add386 = or disjoint i32 %mul385, %j1377.0, !dbg !1844
  %arrayidx387 = getelementptr inbounds nuw [16 x i8], ptr %sumb, i32 0, i32 %add386, !dbg !1845
  %12 = load i8, ptr %arrayidx387, align 1, !dbg !1845
  %mul388 = mul nuw nsw i32 %mi315.0, 24, !dbg !1846
  %add389 = add nuw nsw i32 %mul388, %alpha.0, !dbg !1847
  %mul390 = shl nuw nsw i32 %add389, 2, !dbg !1848
  %add391 = or disjoint i32 %mul390, %a1325.0, !dbg !1849
  %arrayidx392 = getelementptr inbounds nuw i8, ptr %add.ptr102, i32 %add391, !dbg !1850
  %13 = load i8, ptr %arrayidx392, align 1, !dbg !1850
  %call393 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %12, i8 noundef zeroext %13) #3, !dbg !1851
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx384, i8 noundef zeroext %call393) #3, !dbg !1852
  %inc395 = add nuw nsw i32 %j1377.0, 1, !dbg !1853
    #dbg_value(i32 %inc395, !1836, !DIExpression(), !1837)
  br label %for.cond378, !dbg !1854, !llvm.loop !1855

for.inc397:                                       ; preds = %for.cond378
  %inc398 = add nuw nsw i32 %i1372.0, 1, !dbg !1857
    #dbg_value(i32 %inc398, !1829, !DIExpression(), !1830)
  br label %for.cond373, !dbg !1858, !llvm.loop !1859

for.inc400:                                       ; preds = %for.cond373
  %inc401 = add nuw nsw i32 %a1325.0, 1, !dbg !1861
    #dbg_value(i32 %inc401, !1762, !DIExpression(), !1764)
  br label %for.cond326, !dbg !1862, !llvm.loop !1863

for.end402:                                       ; preds = %for.cond326
  %mul405 = mul nuw nsw i32 %mi315.0, 24, !dbg !1865
  %add406 = add nuw nsw i32 %mul405, %alpha.0, !dbg !1866
  %mul407 = shl nuw nsw i32 %add406, 4, !dbg !1867
  %arrayidx408 = getelementptr inbounds nuw [1920 x i8], ptr %Bm, i32 0, i32 %mul407, !dbg !1868
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %gf16m_temp2, ptr noundef nonnull %gf16m_temp1, ptr noundef nonnull %arrayidx408, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !1869
  %mul409 = shl nuw nsw i32 %mi315.0, 4, !dbg !1870
  %arrayidx410 = getelementptr inbounds nuw [80 x i8], ptr %Fvv_in_GF16Matrix, i32 0, i32 %mul409, !dbg !1871
  %mul411 = mul nuw nsw i32 %mi315.0, 24, !dbg !1872
  %add412 = add nuw nsw i32 %mul411, %alpha.0, !dbg !1873
  %mul413 = shl nuw nsw i32 %add412, 4, !dbg !1874
  %arrayidx414 = getelementptr inbounds nuw [1920 x i8], ptr %Am, i32 0, i32 %mul413, !dbg !1875
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %arrayidx410, ptr noundef nonnull %arrayidx414, ptr noundef nonnull %gf16m_temp2, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !1876
  %inc417 = add nuw nsw i32 %alpha.0, 1, !dbg !1877
    #dbg_value(i32 %inc417, !1750, !DIExpression(), !1751)
  br label %for.cond320, !dbg !1878, !llvm.loop !1879

for.inc419:                                       ; preds = %for.cond320
  %inc420 = add nuw nsw i32 %mi315.0, 1, !dbg !1881
    #dbg_value(i32 %inc420, !1741, !DIExpression(), !1742)
  br label %for.cond316, !dbg !1882, !llvm.loop !1883

for.cond423:                                      ; preds = %for.cond423.preheader, %for.inc446
  %mi422.0 = phi i32 [ %inc447, %for.inc446 ], [ 0, %for.cond423.preheader ], !dbg !1885
    #dbg_value(i32 %mi422.0, !1886, !DIExpression(), !1887)
  %exitcond36 = icmp ne i32 %mi422.0, 5, !dbg !1888
  br i1 %exitcond36, label %for.cond428.preheader, label %for.end448, !dbg !1745

for.cond428.preheader:                            ; preds = %for.cond423
  br label %for.cond428, !dbg !1890

for.cond428:                                      ; preds = %for.cond428.preheader, %for.body431
  %i1427.0 = phi i32 [ %inc444, %for.body431 ], [ 0, %for.cond428.preheader ], !dbg !1892
    #dbg_value(i32 %i1427.0, !1893, !DIExpression(), !1894)
  %exitcond35 = icmp ne i32 %i1427.0, 16, !dbg !1895
  br i1 %exitcond35, label %for.body431, label %for.inc446, !dbg !1890

for.body431:                                      ; preds = %for.cond428
  %mul432 = shl nuw nsw i32 %mi422.0, 4, !dbg !1897
  %add433 = or disjoint i32 %mul432, %i1427.0, !dbg !1899
  %arrayidx434 = getelementptr inbounds nuw [80 x i8], ptr %hash_in_GF16, i32 0, i32 %add433, !dbg !1900
  %14 = load i8, ptr %arrayidx434, align 1, !dbg !1900
  %mul435 = shl nuw nsw i32 %mi422.0, 4, !dbg !1901
  %add436 = or disjoint i32 %mul435, %i1427.0, !dbg !1902
  %arrayidx437 = getelementptr inbounds nuw [80 x i8], ptr %Fvv_in_GF16Matrix, i32 0, i32 %add436, !dbg !1903
  %15 = load i8, ptr %arrayidx437, align 1, !dbg !1903
  %call438 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %14, i8 noundef zeroext %15) #3, !dbg !1904
  %mul439 = shl nuw nsw i32 %mi422.0, 4, !dbg !1905
  %add440 = or disjoint i32 %mul439, %i1427.0, !dbg !1906
  %arrayidx442 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %add440, i32 80, !dbg !1907
  store i8 %call438, ptr %arrayidx442, align 1, !dbg !1908
  %inc444 = add nuw nsw i32 %i1427.0, 1, !dbg !1909
    #dbg_value(i32 %inc444, !1893, !DIExpression(), !1894)
  br label %for.cond428, !dbg !1910, !llvm.loop !1911

for.inc446:                                       ; preds = %for.cond428
  %inc447 = add nuw nsw i32 %mi422.0, 1, !dbg !1913
    #dbg_value(i32 %inc447, !1886, !DIExpression(), !1887)
  br label %for.cond423, !dbg !1914, !llvm.loop !1915

for.end448:                                       ; preds = %for.cond423
    #dbg_declare(ptr %whipped_F21, !1917, !DIExpression(), !1921)
  call void @snova_memset(ptr %whipped_F21, i8 0, i32 1600), !dbg !1921
    #dbg_declare(ptr %whipped_F12, !1922, !DIExpression(), !1923)
  call void @snova_memset(ptr %whipped_F12, i8 0, i32 1600), !dbg !1923
    #dbg_value(i32 0, !1924, !DIExpression(), !1926)
  br label %for.cond450, !dbg !1927

for.cond450:                                      ; preds = %for.inc567, %for.end448
  %mi449.0 = phi i32 [ 0, %for.end448 ], [ %inc568, %for.inc567 ], !dbg !1928
    #dbg_value(i32 %mi449.0, !1924, !DIExpression(), !1926)
  %exitcond46 = icmp ne i32 %mi449.0, 5, !dbg !1929
  br i1 %exitcond46, label %for.cond454.preheader, label %for.cond571.preheader, !dbg !1931

for.cond571.preheader:                            ; preds = %for.cond450
  br label %for.cond571, !dbg !1932

for.cond454.preheader:                            ; preds = %for.cond450
  br label %for.cond454, !dbg !1934

for.cond454:                                      ; preds = %for.cond454.preheader, %for.inc490
  %idx.0 = phi i32 [ %inc491, %for.inc490 ], [ 0, %for.cond454.preheader ], !dbg !1937
    #dbg_value(i32 %idx.0, !1938, !DIExpression(), !1939)
  %exitcond39 = icmp ne i32 %idx.0, 5, !dbg !1940
  br i1 %exitcond39, label %for.cond459.preheader, label %for.cond494.preheader, !dbg !1934

for.cond494.preheader:                            ; preds = %for.cond454
  br label %for.cond494, !dbg !1942

for.cond459.preheader:                            ; preds = %for.cond454
  br label %for.cond459, !dbg !1944

for.cond459:                                      ; preds = %for.cond459.preheader, %for.inc487
  %b1458.0 = phi i32 [ %inc488, %for.inc487 ], [ 0, %for.cond459.preheader ], !dbg !1946
    #dbg_value(i32 %b1458.0, !1947, !DIExpression(), !1948)
  %exitcond38 = icmp ne i32 %b1458.0, 4, !dbg !1949
  br i1 %exitcond38, label %for.cond464.preheader, label %for.inc490, !dbg !1944

for.cond464.preheader:                            ; preds = %for.cond459
  br label %for.cond464, !dbg !1951

for.cond464:                                      ; preds = %for.cond464.preheader, %for.body467
  %nj463.0 = phi i32 [ %inc485, %for.body467 ], [ 0, %for.cond464.preheader ], !dbg !1953
    #dbg_value(i32 %nj463.0, !1954, !DIExpression(), !1955)
  %exitcond37 = icmp ne i32 %nj463.0, 27, !dbg !1956
  br i1 %exitcond37, label %for.body467, label %for.inc487, !dbg !1951

for.body467:                                      ; preds = %for.cond464
  %mul468 = shl nuw nsw i32 %mi449.0, 2, !dbg !1958
  %add469 = or disjoint i32 %mul468, %b1458.0, !dbg !1959
  %mul470 = mul nuw nsw i32 %add469, 5, !dbg !1960
  %add471 = add nuw nsw i32 %mul470, %idx.0, !dbg !1961
  %mul472 = shl nuw nsw i32 %add471, 4, !dbg !1962
  %arrayidx473 = getelementptr inbounds nuw [1600 x i8], ptr %whipped_F21, i32 0, i32 %mul472, !dbg !1963
  %mul474 = mul nuw nsw i32 %mi449.0, 5, !dbg !1964
  %add475 = add nuw nsw i32 %mul474, %idx.0, !dbg !1965
  %mul476 = mul nuw nsw i32 %add475, 27, !dbg !1966
  %add477 = add nuw nsw i32 %mul476, %nj463.0, !dbg !1967
  %mul478 = shl nuw nsw i32 %add477, 4, !dbg !1968
  %arrayidx479 = getelementptr inbounds nuw [10800 x i8], ptr %F21, i32 0, i32 %mul478, !dbg !1969
  %mul480 = mul nuw nsw i32 %b1458.0, 27, !dbg !1970
  %add481 = add nuw nsw i32 %mul480, %nj463.0, !dbg !1971
  %mul482 = shl nuw nsw i32 %add481, 4, !dbg !1972
  %arrayidx483 = getelementptr inbounds nuw [1728 x i8], ptr %whipped_sig, i32 0, i32 %mul482, !dbg !1973
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %arrayidx473, ptr noundef nonnull %arrayidx479, ptr noundef nonnull %arrayidx483, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !1974
  %inc485 = add nuw nsw i32 %nj463.0, 1, !dbg !1975
    #dbg_value(i32 %inc485, !1954, !DIExpression(), !1955)
  br label %for.cond464, !dbg !1976, !llvm.loop !1977

for.inc487:                                       ; preds = %for.cond464
  %inc488 = add nuw nsw i32 %b1458.0, 1, !dbg !1979
    #dbg_value(i32 %inc488, !1947, !DIExpression(), !1948)
  br label %for.cond459, !dbg !1980, !llvm.loop !1981

for.inc490:                                       ; preds = %for.cond459
  %inc491 = add nuw nsw i32 %idx.0, 1, !dbg !1983
    #dbg_value(i32 %inc491, !1938, !DIExpression(), !1939)
  br label %for.cond454, !dbg !1984, !llvm.loop !1985

for.cond494:                                      ; preds = %for.cond494.preheader, %for.inc564
  %idx493.0 = phi i32 [ %inc565, %for.inc564 ], [ 0, %for.cond494.preheader ], !dbg !1987
    #dbg_value(i32 %idx493.0, !1988, !DIExpression(), !1989)
  %exitcond45 = icmp ne i32 %idx493.0, 5, !dbg !1990
  br i1 %exitcond45, label %for.cond499.preheader, label %for.inc567, !dbg !1942

for.cond499.preheader:                            ; preds = %for.cond494
  br label %for.cond499, !dbg !1992

for.cond499:                                      ; preds = %for.cond499.preheader, %for.inc561
  %b1498.0 = phi i32 [ %inc562, %for.inc561 ], [ 0, %for.cond499.preheader ], !dbg !1994
    #dbg_value(i32 %b1498.0, !1995, !DIExpression(), !1996)
  %exitcond44 = icmp ne i32 %b1498.0, 4, !dbg !1997
  br i1 %exitcond44, label %for.cond504.preheader, label %for.inc564, !dbg !1992

for.cond504.preheader:                            ; preds = %for.cond499
  br label %for.cond504, !dbg !1999

for.cond504:                                      ; preds = %for.cond504.preheader, %for.inc558
  %nj503.0 = phi i32 [ %inc559, %for.inc558 ], [ 0, %for.cond504.preheader ], !dbg !2001
    #dbg_value(i32 %nj503.0, !2002, !DIExpression(), !2003)
  %exitcond43 = icmp ne i32 %nj503.0, 27, !dbg !2004
  br i1 %exitcond43, label %for.cond509.preheader, label %for.inc561, !dbg !1999

for.cond509.preheader:                            ; preds = %for.cond504
  br label %for.cond509, !dbg !2006

for.cond509:                                      ; preds = %for.cond509.preheader, %for.inc555
  %i1508.0 = phi i32 [ %inc556, %for.inc555 ], [ 0, %for.cond509.preheader ], !dbg !2008
    #dbg_value(i32 %i1508.0, !2009, !DIExpression(), !2010)
  %exitcond42 = icmp ne i32 %i1508.0, 4, !dbg !2011
  br i1 %exitcond42, label %for.cond514.preheader, label %for.inc558, !dbg !2006

for.cond514.preheader:                            ; preds = %for.cond509
  br label %for.cond514, !dbg !2013

for.cond514:                                      ; preds = %for.cond514.preheader, %for.inc552
  %j1513.0 = phi i32 [ %inc553, %for.inc552 ], [ 0, %for.cond514.preheader ], !dbg !2015
    #dbg_value(i32 %j1513.0, !2016, !DIExpression(), !2017)
  %exitcond41 = icmp ne i32 %j1513.0, 4, !dbg !2018
  br i1 %exitcond41, label %for.cond519.preheader, label %for.inc555, !dbg !2013

for.cond519.preheader:                            ; preds = %for.cond514
  br label %for.cond519, !dbg !2020

for.cond519:                                      ; preds = %for.cond519.preheader, %for.body522
  %k1518.0 = phi i32 [ %inc550, %for.body522 ], [ 0, %for.cond519.preheader ], !dbg !2022
    #dbg_value(i32 %k1518.0, !2023, !DIExpression(), !2024)
  %exitcond40 = icmp ne i32 %k1518.0, 4, !dbg !2025
  br i1 %exitcond40, label %for.body522, label %for.inc552, !dbg !2020

for.body522:                                      ; preds = %for.cond519
  %mul523 = shl nuw nsw i32 %mi449.0, 2, !dbg !2027
  %add524 = or disjoint i32 %mul523, %b1498.0, !dbg !2028
  %mul525 = mul nuw nsw i32 %add524, 5, !dbg !2029
  %add526 = add nuw nsw i32 %mul525, %idx493.0, !dbg !2030
  %mul527 = shl nuw nsw i32 %add526, 4, !dbg !2031
  %mul528 = shl nuw nsw i32 %i1508.0, 2, !dbg !2032
  %add529 = or disjoint i32 %mul527, %mul528, !dbg !2033
  %add530 = or disjoint i32 %add529, %j1513.0, !dbg !2034
  %arrayidx531 = getelementptr inbounds nuw [1600 x i8], ptr %whipped_F12, i32 0, i32 %add530, !dbg !2035
  %mul532 = mul nuw nsw i32 %mi449.0, 27, !dbg !2036
  %add533 = add nuw nsw i32 %mul532, %nj503.0, !dbg !2037
  %mul534 = mul nuw nsw i32 %add533, 5, !dbg !2038
  %add535 = add nuw nsw i32 %mul534, %idx493.0, !dbg !2039
  %mul536 = shl nuw nsw i32 %add535, 4, !dbg !2040
  %mul537 = shl nuw nsw i32 %k1518.0, 2, !dbg !2041
  %add538 = or disjoint i32 %mul536, %mul537, !dbg !2042
  %add539 = or disjoint i32 %add538, %i1508.0, !dbg !2043
  %arrayidx540 = getelementptr inbounds nuw [10800 x i8], ptr %F12, i32 0, i32 %add539, !dbg !2044
  %16 = load i8, ptr %arrayidx540, align 1, !dbg !2044
  %mul541 = mul nuw nsw i32 %b1498.0, 27, !dbg !2045
  %add542 = add nuw nsw i32 %mul541, %nj503.0, !dbg !2046
  %mul543 = shl nuw nsw i32 %add542, 4, !dbg !2047
  %mul544 = shl nuw nsw i32 %k1518.0, 2, !dbg !2048
  %add545 = or disjoint i32 %mul543, %mul544, !dbg !2049
  %add546 = or disjoint i32 %add545, %j1513.0, !dbg !2050
  %arrayidx547 = getelementptr inbounds nuw [1728 x i8], ptr %whipped_sig, i32 0, i32 %add546, !dbg !2051
  %17 = load i8, ptr %arrayidx547, align 1, !dbg !2051
  %call548 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %16, i8 noundef zeroext %17) #3, !dbg !2052
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx531, i8 noundef zeroext %call548) #3, !dbg !2053
  %inc550 = add nuw nsw i32 %k1518.0, 1, !dbg !2054
    #dbg_value(i32 %inc550, !2023, !DIExpression(), !2024)
  br label %for.cond519, !dbg !2055, !llvm.loop !2056

for.inc552:                                       ; preds = %for.cond519
  %inc553 = add nuw nsw i32 %j1513.0, 1, !dbg !2058
    #dbg_value(i32 %inc553, !2016, !DIExpression(), !2017)
  br label %for.cond514, !dbg !2059, !llvm.loop !2060

for.inc555:                                       ; preds = %for.cond514
  %inc556 = add nuw nsw i32 %i1508.0, 1, !dbg !2062
    #dbg_value(i32 %inc556, !2009, !DIExpression(), !2010)
  br label %for.cond509, !dbg !2063, !llvm.loop !2064

for.inc558:                                       ; preds = %for.cond509
  %inc559 = add nuw nsw i32 %nj503.0, 1, !dbg !2066
    #dbg_value(i32 %inc559, !2002, !DIExpression(), !2003)
  br label %for.cond504, !dbg !2067, !llvm.loop !2068

for.inc561:                                       ; preds = %for.cond504
  %inc562 = add nuw nsw i32 %b1498.0, 1, !dbg !2070
    #dbg_value(i32 %inc562, !1995, !DIExpression(), !1996)
  br label %for.cond499, !dbg !2071, !llvm.loop !2072

for.inc564:                                       ; preds = %for.cond499
  %inc565 = add nuw nsw i32 %idx493.0, 1, !dbg !2074
    #dbg_value(i32 %inc565, !1988, !DIExpression(), !1989)
  br label %for.cond494, !dbg !2075, !llvm.loop !2076

for.inc567:                                       ; preds = %for.cond494
  %inc568 = add nuw nsw i32 %mi449.0, 1, !dbg !2078
    #dbg_value(i32 %inc568, !1924, !DIExpression(), !1926)
  br label %for.cond450, !dbg !2079, !llvm.loop !2080

for.cond571:                                      ; preds = %for.cond571.preheader, %for.inc686
  %mi570.0 = phi i32 [ %inc687, %for.inc686 ], [ 0, %for.cond571.preheader ], !dbg !2082
    #dbg_value(i32 %mi570.0, !2083, !DIExpression(), !2084)
  %exitcond55 = icmp ne i32 %mi570.0, 5, !dbg !2085
  br i1 %exitcond55, label %for.cond576.preheader, label %for.cond690.preheader, !dbg !1932

for.cond690.preheader:                            ; preds = %for.cond571
  br label %for.cond690, !dbg !2087

for.cond576.preheader:                            ; preds = %for.cond571
  br label %for.cond576, !dbg !2089

for.cond576:                                      ; preds = %for.cond576.preheader, %for.inc683
  %idx575.0 = phi i32 [ %inc684, %for.inc683 ], [ 0, %for.cond576.preheader ], !dbg !2092
    #dbg_value(i32 %idx575.0, !2093, !DIExpression(), !2094)
  %exitcond54 = icmp ne i32 %idx575.0, 5, !dbg !2095
  br i1 %exitcond54, label %for.cond581.preheader, label %for.inc686, !dbg !2089

for.cond581.preheader:                            ; preds = %for.cond576
  br label %for.cond581, !dbg !2097

for.cond581:                                      ; preds = %for.cond581.preheader, %for.inc680
  %alpha580.0 = phi i32 [ %inc681, %for.inc680 ], [ 0, %for.cond581.preheader ], !dbg !2100
    #dbg_value(i32 %alpha580.0, !2101, !DIExpression(), !2102)
  %exitcond53 = icmp ne i32 %alpha580.0, 24, !dbg !2103
  br i1 %exitcond53, label %for.body584, label %for.inc683, !dbg !2097

for.body584:                                      ; preds = %for.cond581
    #dbg_declare(ptr %gf16m_temp0, !2105, !DIExpression(), !2107)
  call void @snova_memset(ptr %gf16m_temp0, i8 0, i32 16), !dbg !2107
    #dbg_declare(ptr %gf16m_temp1585, !2108, !DIExpression(), !2109)
  call void @snova_memset(ptr %gf16m_temp1585, i8 0, i32 16), !dbg !2109
    #dbg_declare(ptr %X_tmp, !2110, !DIExpression(), !2111)
  call void @snova_memset(ptr %X_tmp, i8 0, i32 16), !dbg !2111
  %add587 = add nuw nsw i32 %alpha580.0, %mi570.0, !dbg !2112
  %rem588 = urem i32 %add587, 5, !dbg !2112
    #dbg_value(i32 %rem588, !2113, !DIExpression(), !2114)
    #dbg_value(i32 0, !2115, !DIExpression(), !2117)
  br label %for.cond590, !dbg !2118

for.cond590:                                      ; preds = %for.inc616, %for.body584
  %b1589.0 = phi i32 [ 0, %for.body584 ], [ %inc617, %for.inc616 ], !dbg !2119
    #dbg_value(i32 %b1589.0, !2115, !DIExpression(), !2117)
  %exitcond48 = icmp ne i32 %b1589.0, 4, !dbg !2120
  br i1 %exitcond48, label %for.cond595.preheader, label %for.end618, !dbg !2122

for.cond595.preheader:                            ; preds = %for.cond590
  br label %for.cond595, !dbg !2123

for.cond595:                                      ; preds = %for.cond595.preheader, %for.body598
  %i1594.0 = phi i32 [ %inc614, %for.body598 ], [ 0, %for.cond595.preheader ], !dbg !2125
    #dbg_value(i32 %i1594.0, !2126, !DIExpression(), !2127)
  %exitcond47 = icmp ne i32 %i1594.0, 16, !dbg !2128
  br i1 %exitcond47, label %for.body598, label %for.inc616, !dbg !2123

for.body598:                                      ; preds = %for.cond595
  %arrayidx599 = getelementptr inbounds nuw [16 x i8], ptr %gf16m_temp1585, i32 0, i32 %i1594.0, !dbg !2130
  %mul600 = shl nuw nsw i32 %rem588, 2, !dbg !2131
  %add601 = or disjoint i32 %mul600, %b1589.0, !dbg !2132
  %mul602 = mul nuw nsw i32 %add601, 5, !dbg !2133
  %add603 = add nuw nsw i32 %mul602, %idx575.0, !dbg !2134
  %mul604 = shl nuw nsw i32 %add603, 4, !dbg !2135
  %add605 = or disjoint i32 %mul604, %i1594.0, !dbg !2136
  %arrayidx606 = getelementptr inbounds nuw [1600 x i8], ptr %whipped_F21, i32 0, i32 %add605, !dbg !2137
  %18 = load i8, ptr %arrayidx606, align 1, !dbg !2137
  %mul607 = mul nuw nsw i32 %mi570.0, 24, !dbg !2138
  %add608 = add nuw nsw i32 %mul607, %alpha580.0, !dbg !2139
  %mul609 = shl nuw nsw i32 %add608, 2, !dbg !2140
  %add610 = or disjoint i32 %mul609, %b1589.0, !dbg !2141
  %arrayidx611 = getelementptr inbounds nuw i8, ptr %add.ptr103, i32 %add610, !dbg !2142
  %19 = load i8, ptr %arrayidx611, align 1, !dbg !2142
  %call612 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %18, i8 noundef zeroext %19) #3, !dbg !2143
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx599, i8 noundef zeroext %call612) #3, !dbg !2144
  %inc614 = add nuw nsw i32 %i1594.0, 1, !dbg !2145
    #dbg_value(i32 %inc614, !2126, !DIExpression(), !2127)
  br label %for.cond595, !dbg !2146, !llvm.loop !2147

for.inc616:                                       ; preds = %for.cond595
  %inc617 = add nuw nsw i32 %b1589.0, 1, !dbg !2149
    #dbg_value(i32 %inc617, !2115, !DIExpression(), !2117)
  br label %for.cond590, !dbg !2150, !llvm.loop !2151

for.end618:                                       ; preds = %for.cond590
  %mul621 = mul nuw nsw i32 %mi570.0, 24, !dbg !2153
  %add622 = add nuw nsw i32 %mul621, %alpha580.0, !dbg !2154
  %mul623 = shl nuw nsw i32 %add622, 4, !dbg !2155
  %arrayidx624 = getelementptr inbounds nuw [1920 x i8], ptr %Bm, i32 0, i32 %mul623, !dbg !2156
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %gf16m_temp0, ptr noundef nonnull %gf16m_temp1585, ptr noundef nonnull %arrayidx624, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !2157
  %mul626 = mul nuw nsw i32 %mi570.0, 24, !dbg !2158
  %add627 = add nuw nsw i32 %mul626, %alpha580.0, !dbg !2159
  %mul628 = shl nuw nsw i32 %add627, 4, !dbg !2160
  %arrayidx629 = getelementptr inbounds nuw [1920 x i8], ptr %Q1, i32 0, i32 %mul628, !dbg !2161
  call fastcc void @gf_mat_mul_add(ptr noundef nonnull %X_tmp, ptr noundef nonnull %arrayidx629, ptr noundef nonnull %gf16m_temp0) #3, !dbg !2162
    #dbg_value(i32 0, !2163, !DIExpression(), !2165)
  br label %for.cond631, !dbg !2166

for.cond631:                                      ; preds = %for.inc677, %for.end618
  %ti1.0 = phi i32 [ 0, %for.end618 ], [ %inc678, %for.inc677 ], !dbg !2167
    #dbg_value(i32 %ti1.0, !2163, !DIExpression(), !2165)
  %exitcond52 = icmp ne i32 %ti1.0, 4, !dbg !2168
  br i1 %exitcond52, label %for.cond635.preheader, label %for.inc680, !dbg !2170

for.cond635.preheader:                            ; preds = %for.cond631
  br label %for.cond635, !dbg !2171

for.cond635:                                      ; preds = %for.cond635.preheader, %for.inc674
  %ti2.0 = phi i32 [ %inc675, %for.inc674 ], [ 0, %for.cond635.preheader ], !dbg !2173
    #dbg_value(i32 %ti2.0, !2174, !DIExpression(), !2175)
  %exitcond51 = icmp ne i32 %ti2.0, 4, !dbg !2176
  br i1 %exitcond51, label %for.cond639.preheader, label %for.inc677, !dbg !2171

for.cond639.preheader:                            ; preds = %for.cond635
  br label %for.cond639, !dbg !2178

for.cond639:                                      ; preds = %for.cond639.preheader, %for.inc671
  %tj1.0 = phi i32 [ %inc672, %for.inc671 ], [ 0, %for.cond639.preheader ], !dbg !2180
    #dbg_value(i32 %tj1.0, !2181, !DIExpression(), !2182)
  %exitcond50 = icmp ne i32 %tj1.0, 4, !dbg !2183
  br i1 %exitcond50, label %for.cond643.preheader, label %for.inc674, !dbg !2178

for.cond643.preheader:                            ; preds = %for.cond639
  br label %for.cond643, !dbg !2185

for.cond643:                                      ; preds = %for.cond643.preheader, %for.body646
  %tj2.0 = phi i32 [ %inc669, %for.body646 ], [ 0, %for.cond643.preheader ], !dbg !2187
    #dbg_value(i32 %tj2.0, !2188, !DIExpression(), !2189)
  %exitcond49 = icmp ne i32 %tj2.0, 4, !dbg !2190
  br i1 %exitcond49, label %for.body646, label %for.inc671, !dbg !2185

for.body646:                                      ; preds = %for.cond643
  %mul647 = shl nuw nsw i32 %ti1.0, 2, !dbg !2192
    #dbg_value(!DIArgList(i32 %mul647, i32 %ti2.0), !2194, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value), !2195)
  %mul649 = shl nuw nsw i32 %tj1.0, 2, !dbg !2196
    #dbg_value(!DIArgList(i32 %mul649, i32 %tj2.0), !2197, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value), !2195)
  %mul651 = shl nuw nsw i32 %mi570.0, 4, !dbg !2198
  %20 = or disjoint i32 %mul647, %mul651, !dbg !2199
  %add652 = or disjoint i32 %20, %ti2.0, !dbg !2199
  %mul654 = shl nuw nsw i32 %idx575.0, 4, !dbg !2200
  %21 = or disjoint i32 %mul649, %mul654, !dbg !2201
  %add655 = or disjoint i32 %21, %tj2.0, !dbg !2201
  %arrayidx656 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %add652, i32 %add655, !dbg !2202
  %mul657 = shl nuw nsw i32 %tj1.0, 2, !dbg !2203
  %add658 = or disjoint i32 %mul657, %ti2.0, !dbg !2204
  %arrayidx659 = getelementptr inbounds nuw [16 x i8], ptr %X_tmp, i32 0, i32 %add658, !dbg !2205
  %22 = load i8, ptr %arrayidx659, align 1, !dbg !2205
  %mul660 = mul nuw nsw i32 %mi570.0, 24, !dbg !2206
  %add661 = add nuw nsw i32 %mul660, %alpha580.0, !dbg !2207
  %mul662 = shl nuw nsw i32 %add661, 4, !dbg !2208
  %mul663 = shl nuw nsw i32 %ti1.0, 2, !dbg !2209
  %add664 = or disjoint i32 %mul662, %mul663, !dbg !2210
  %add665 = or disjoint i32 %add664, %tj2.0, !dbg !2211
  %arrayidx666 = getelementptr inbounds nuw [1920 x i8], ptr %Am, i32 0, i32 %add665, !dbg !2212
  %23 = load i8, ptr %arrayidx666, align 1, !dbg !2212
  %call667 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %22, i8 noundef zeroext %23) #3, !dbg !2213
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx656, i8 noundef zeroext %call667) #3, !dbg !2214
  %inc669 = add nuw nsw i32 %tj2.0, 1, !dbg !2215
    #dbg_value(i32 %inc669, !2188, !DIExpression(), !2189)
  br label %for.cond643, !dbg !2216, !llvm.loop !2217

for.inc671:                                       ; preds = %for.cond643
  %inc672 = add nuw nsw i32 %tj1.0, 1, !dbg !2219
    #dbg_value(i32 %inc672, !2181, !DIExpression(), !2182)
  br label %for.cond639, !dbg !2220, !llvm.loop !2221

for.inc674:                                       ; preds = %for.cond639
  %inc675 = add nuw nsw i32 %ti2.0, 1, !dbg !2223
    #dbg_value(i32 %inc675, !2174, !DIExpression(), !2175)
  br label %for.cond635, !dbg !2224, !llvm.loop !2225

for.inc677:                                       ; preds = %for.cond635
  %inc678 = add nuw nsw i32 %ti1.0, 1, !dbg !2227
    #dbg_value(i32 %inc678, !2163, !DIExpression(), !2165)
  br label %for.cond631, !dbg !2228, !llvm.loop !2229

for.inc680:                                       ; preds = %for.cond631
  %inc681 = add nuw nsw i32 %alpha580.0, 1, !dbg !2231
    #dbg_value(i32 %inc681, !2101, !DIExpression(), !2102)
  br label %for.cond581, !dbg !2232, !llvm.loop !2233

for.inc683:                                       ; preds = %for.cond581
  %inc684 = add nuw nsw i32 %idx575.0, 1, !dbg !2235
    #dbg_value(i32 %inc684, !2093, !DIExpression(), !2094)
  br label %for.cond576, !dbg !2236, !llvm.loop !2237

for.inc686:                                       ; preds = %for.cond576
  %inc687 = add nuw nsw i32 %mi570.0, 1, !dbg !2239
    #dbg_value(i32 %inc687, !2083, !DIExpression(), !2084)
  br label %for.cond571, !dbg !2240, !llvm.loop !2241

for.cond690:                                      ; preds = %for.cond690.preheader, %for.inc825
  %mi689.0 = phi i32 [ %inc826, %for.inc825 ], [ 0, %for.cond690.preheader ], !dbg !2243
    #dbg_value(i32 %mi689.0, !2244, !DIExpression(), !2245)
  %exitcond65 = icmp ne i32 %mi689.0, 5, !dbg !2246
  br i1 %exitcond65, label %for.cond695.preheader, label %for.cond828.preheader, !dbg !2087

for.cond828.preheader:                            ; preds = %for.cond690
  br label %for.cond828, !dbg !2248

for.cond695.preheader:                            ; preds = %for.cond690
  br label %for.cond695, !dbg !2250

for.cond695:                                      ; preds = %for.cond695.preheader, %for.inc822
  %idx694.0 = phi i32 [ %inc823, %for.inc822 ], [ 0, %for.cond695.preheader ], !dbg !2253
    #dbg_value(i32 %idx694.0, !2254, !DIExpression(), !2255)
  %exitcond64 = icmp ne i32 %idx694.0, 5, !dbg !2256
  br i1 %exitcond64, label %for.cond700.preheader, label %for.inc825, !dbg !2250

for.cond700.preheader:                            ; preds = %for.cond695
  br label %for.cond700, !dbg !2258

for.cond700:                                      ; preds = %for.cond700.preheader, %for.inc819
  %alpha699.0 = phi i32 [ %inc820, %for.inc819 ], [ 0, %for.cond700.preheader ], !dbg !2261
    #dbg_value(i32 %alpha699.0, !2262, !DIExpression(), !2263)
  %exitcond63 = icmp ne i32 %alpha699.0, 24, !dbg !2264
  br i1 %exitcond63, label %for.body703, label %for.inc822, !dbg !2258

for.body703:                                      ; preds = %for.cond700
    #dbg_declare(ptr %gf16m_temp0704, !2266, !DIExpression(), !2268)
  call void @snova_memset(ptr %gf16m_temp0704, i8 0, i32 16), !dbg !2268
    #dbg_declare(ptr %gf16m_temp1705, !2269, !DIExpression(), !2270)
  call void @snova_memset(ptr %gf16m_temp1705, i8 0, i32 16), !dbg !2270
    #dbg_declare(ptr %X_tmp706, !2271, !DIExpression(), !2272)
  call void @snova_memset(ptr %X_tmp706, i8 0, i32 16), !dbg !2272
  %add708 = add nuw nsw i32 %alpha699.0, %mi689.0, !dbg !2273
  %rem709 = urem i32 %add708, 5, !dbg !2273
    #dbg_value(i32 %rem709, !2274, !DIExpression(), !2275)
    #dbg_value(i32 0, !2276, !DIExpression(), !2278)
  br label %for.cond711, !dbg !2279

for.cond711:                                      ; preds = %for.inc749, %for.body703
  %b1710.0 = phi i32 [ 0, %for.body703 ], [ %inc750, %for.inc749 ], !dbg !2280
    #dbg_value(i32 %b1710.0, !2276, !DIExpression(), !2278)
  %exitcond58 = icmp ne i32 %b1710.0, 4, !dbg !2281
  br i1 %exitcond58, label %for.cond716.preheader, label %for.end751, !dbg !2283

for.cond716.preheader:                            ; preds = %for.cond711
  br label %for.cond716, !dbg !2284

for.cond716:                                      ; preds = %for.cond716.preheader, %for.inc746
  %i1715.0 = phi i32 [ %inc747, %for.inc746 ], [ 0, %for.cond716.preheader ], !dbg !2286
    #dbg_value(i32 %i1715.0, !2287, !DIExpression(), !2288)
  %exitcond57 = icmp ne i32 %i1715.0, 4, !dbg !2289
  br i1 %exitcond57, label %for.cond721.preheader, label %for.inc749, !dbg !2284

for.cond721.preheader:                            ; preds = %for.cond716
  br label %for.cond721, !dbg !2291

for.cond721:                                      ; preds = %for.cond721.preheader, %for.body724
  %j1720.0 = phi i32 [ %inc744, %for.body724 ], [ 0, %for.cond721.preheader ], !dbg !2293
    #dbg_value(i32 %j1720.0, !2294, !DIExpression(), !2295)
  %exitcond56 = icmp ne i32 %j1720.0, 4, !dbg !2296
  br i1 %exitcond56, label %for.body724, label %for.inc746, !dbg !2291

for.body724:                                      ; preds = %for.cond721
  %mul725 = shl nuw nsw i32 %j1720.0, 2, !dbg !2298
  %add726 = or disjoint i32 %mul725, %i1715.0, !dbg !2299
  %arrayidx727 = getelementptr inbounds nuw [16 x i8], ptr %gf16m_temp1705, i32 0, i32 %add726, !dbg !2300
  %mul728 = shl nuw nsw i32 %rem709, 2, !dbg !2301
  %add729 = or disjoint i32 %mul728, %b1710.0, !dbg !2302
  %mul730 = mul nuw nsw i32 %add729, 5, !dbg !2303
  %add731 = add nuw nsw i32 %mul730, %idx694.0, !dbg !2304
  %mul732 = shl nuw nsw i32 %add731, 4, !dbg !2305
  %mul733 = shl nuw nsw i32 %i1715.0, 2, !dbg !2306
  %add734 = or disjoint i32 %mul732, %mul733, !dbg !2307
  %add735 = or disjoint i32 %add734, %j1720.0, !dbg !2308
  %arrayidx736 = getelementptr inbounds nuw [1600 x i8], ptr %whipped_F12, i32 0, i32 %add735, !dbg !2309
  %24 = load i8, ptr %arrayidx736, align 1, !dbg !2309
  %mul737 = mul nuw nsw i32 %mi689.0, 24, !dbg !2310
  %add738 = add nuw nsw i32 %mul737, %alpha699.0, !dbg !2311
  %mul739 = shl nuw nsw i32 %add738, 2, !dbg !2312
  %add740 = or disjoint i32 %mul739, %b1710.0, !dbg !2313
  %arrayidx741 = getelementptr inbounds nuw i8, ptr %add.ptr102, i32 %add740, !dbg !2314
  %25 = load i8, ptr %arrayidx741, align 1, !dbg !2314
  %call742 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %24, i8 noundef zeroext %25) #3, !dbg !2315
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx727, i8 noundef zeroext %call742) #3, !dbg !2316
  %inc744 = add nuw nsw i32 %j1720.0, 1, !dbg !2317
    #dbg_value(i32 %inc744, !2294, !DIExpression(), !2295)
  br label %for.cond721, !dbg !2318, !llvm.loop !2319

for.inc746:                                       ; preds = %for.cond721
  %inc747 = add nuw nsw i32 %i1715.0, 1, !dbg !2321
    #dbg_value(i32 %inc747, !2287, !DIExpression(), !2288)
  br label %for.cond716, !dbg !2322, !llvm.loop !2323

for.inc749:                                       ; preds = %for.cond716
  %inc750 = add nuw nsw i32 %b1710.0, 1, !dbg !2325
    #dbg_value(i32 %inc750, !2276, !DIExpression(), !2278)
  br label %for.cond711, !dbg !2326, !llvm.loop !2327

for.end751:                                       ; preds = %for.cond711
  %mul753 = mul nuw nsw i32 %mi689.0, 24, !dbg !2329
  %add754 = add nuw nsw i32 %mul753, %alpha699.0, !dbg !2330
  %mul755 = shl nuw nsw i32 %add754, 4, !dbg !2331
  %arrayidx756 = getelementptr inbounds nuw [1920 x i8], ptr %Am, i32 0, i32 %mul755, !dbg !2332
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %gf16m_temp0704, ptr noundef nonnull %arrayidx756, ptr noundef nonnull %gf16m_temp1705, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !2333
  %mul760 = mul nuw nsw i32 %mi689.0, 24, !dbg !2334
  %add761 = add nuw nsw i32 %mul760, %alpha699.0, !dbg !2335
  %mul762 = shl nuw nsw i32 %add761, 4, !dbg !2336
  %arrayidx763 = getelementptr inbounds nuw [1920 x i8], ptr %Q2, i32 0, i32 %mul762, !dbg !2337
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %X_tmp706, ptr noundef nonnull %gf16m_temp0704, ptr noundef nonnull %arrayidx763, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !2338
    #dbg_value(i32 0, !2339, !DIExpression(), !2341)
  br label %for.cond765, !dbg !2342

for.cond765:                                      ; preds = %for.inc816, %for.end751
  %ti1764.0 = phi i32 [ 0, %for.end751 ], [ %inc817, %for.inc816 ], !dbg !2343
    #dbg_value(i32 %ti1764.0, !2339, !DIExpression(), !2341)
  %exitcond62 = icmp ne i32 %ti1764.0, 4, !dbg !2344
  br i1 %exitcond62, label %for.cond770.preheader, label %for.inc819, !dbg !2346

for.cond770.preheader:                            ; preds = %for.cond765
  br label %for.cond770, !dbg !2347

for.cond770:                                      ; preds = %for.cond770.preheader, %for.inc813
  %ti2769.0 = phi i32 [ %inc814, %for.inc813 ], [ 0, %for.cond770.preheader ], !dbg !2349
    #dbg_value(i32 %ti2769.0, !2350, !DIExpression(), !2351)
  %exitcond61 = icmp ne i32 %ti2769.0, 4, !dbg !2352
  br i1 %exitcond61, label %for.cond775.preheader, label %for.inc816, !dbg !2347

for.cond775.preheader:                            ; preds = %for.cond770
  br label %for.cond775, !dbg !2354

for.cond775:                                      ; preds = %for.cond775.preheader, %for.inc810
  %tj1774.0 = phi i32 [ %inc811, %for.inc810 ], [ 0, %for.cond775.preheader ], !dbg !2356
    #dbg_value(i32 %tj1774.0, !2357, !DIExpression(), !2358)
  %exitcond60 = icmp ne i32 %tj1774.0, 4, !dbg !2359
  br i1 %exitcond60, label %for.cond780.preheader, label %for.inc813, !dbg !2354

for.cond780.preheader:                            ; preds = %for.cond775
  br label %for.cond780, !dbg !2361

for.cond780:                                      ; preds = %for.cond780.preheader, %for.body783
  %tj2779.0 = phi i32 [ %inc808, %for.body783 ], [ 0, %for.cond780.preheader ], !dbg !2363
    #dbg_value(i32 %tj2779.0, !2364, !DIExpression(), !2365)
  %exitcond59 = icmp ne i32 %tj2779.0, 4, !dbg !2366
  br i1 %exitcond59, label %for.body783, label %for.inc810, !dbg !2361

for.body783:                                      ; preds = %for.cond780
  %mul785 = shl nuw nsw i32 %ti1764.0, 2, !dbg !2368
    #dbg_value(!DIArgList(i32 %mul785, i32 %ti2769.0), !2370, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value), !2371)
  %mul788 = shl nuw nsw i32 %tj1774.0, 2, !dbg !2372
    #dbg_value(!DIArgList(i32 %mul788, i32 %tj2779.0), !2373, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_stack_value), !2371)
  %mul790 = shl nuw nsw i32 %mi689.0, 4, !dbg !2374
  %26 = or disjoint i32 %mul785, %mul790, !dbg !2375
  %add791 = or disjoint i32 %26, %ti2769.0, !dbg !2375
  %mul793 = shl nuw nsw i32 %idx694.0, 4, !dbg !2376
  %27 = or disjoint i32 %mul788, %mul793, !dbg !2377
  %add794 = or disjoint i32 %27, %tj2779.0, !dbg !2377
  %arrayidx795 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %add791, i32 %add794, !dbg !2378
  %mul796 = shl nuw nsw i32 %ti1764.0, 2, !dbg !2379
  %add797 = or disjoint i32 %mul796, %tj1774.0, !dbg !2380
  %arrayidx798 = getelementptr inbounds nuw [16 x i8], ptr %X_tmp706, i32 0, i32 %add797, !dbg !2381
  %28 = load i8, ptr %arrayidx798, align 1, !dbg !2381
  %mul799 = mul nuw nsw i32 %mi689.0, 24, !dbg !2382
  %add800 = add nuw nsw i32 %mul799, %alpha699.0, !dbg !2383
  %mul801 = shl nuw nsw i32 %add800, 4, !dbg !2384
  %mul802 = shl nuw nsw i32 %tj2779.0, 2, !dbg !2385
  %add803 = or disjoint i32 %mul801, %mul802, !dbg !2386
  %add804 = or disjoint i32 %add803, %ti2769.0, !dbg !2387
  %arrayidx805 = getelementptr inbounds nuw [1920 x i8], ptr %Bm, i32 0, i32 %add804, !dbg !2388
  %29 = load i8, ptr %arrayidx805, align 1, !dbg !2388
  %call806 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %28, i8 noundef zeroext %29) #3, !dbg !2389
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx795, i8 noundef zeroext %call806) #3, !dbg !2390
  %inc808 = add nuw nsw i32 %tj2779.0, 1, !dbg !2391
    #dbg_value(i32 %inc808, !2364, !DIExpression(), !2365)
  br label %for.cond780, !dbg !2392, !llvm.loop !2393

for.inc810:                                       ; preds = %for.cond780
  %inc811 = add nuw nsw i32 %tj1774.0, 1, !dbg !2395
    #dbg_value(i32 %inc811, !2357, !DIExpression(), !2358)
  br label %for.cond775, !dbg !2396, !llvm.loop !2397

for.inc813:                                       ; preds = %for.cond775
  %inc814 = add nuw nsw i32 %ti2769.0, 1, !dbg !2399
    #dbg_value(i32 %inc814, !2350, !DIExpression(), !2351)
  br label %for.cond770, !dbg !2400, !llvm.loop !2401

for.inc816:                                       ; preds = %for.cond770
  %inc817 = add nuw nsw i32 %ti1764.0, 1, !dbg !2403
    #dbg_value(i32 %inc817, !2339, !DIExpression(), !2341)
  br label %for.cond765, !dbg !2404, !llvm.loop !2405

for.inc819:                                       ; preds = %for.cond765
  %inc820 = add nuw nsw i32 %alpha699.0, 1, !dbg !2407
    #dbg_value(i32 %inc820, !2262, !DIExpression(), !2263)
  br label %for.cond700, !dbg !2408, !llvm.loop !2409

for.inc822:                                       ; preds = %for.cond700
  %inc823 = add nuw nsw i32 %idx694.0, 1, !dbg !2411
    #dbg_value(i32 %inc823, !2254, !DIExpression(), !2255)
  br label %for.cond695, !dbg !2412, !llvm.loop !2413

for.inc825:                                       ; preds = %for.cond695
  %inc826 = add nuw nsw i32 %mi689.0, 1, !dbg !2415
    #dbg_value(i32 %inc826, !2244, !DIExpression(), !2245)
  br label %for.cond690, !dbg !2416, !llvm.loop !2417

for.cond828:                                      ; preds = %for.cond828.preheader, %for.inc927
  %i.0 = phi i32 [ %inc928, %for.inc927 ], [ 0, %for.cond828.preheader ], !dbg !2419
    #dbg_value(i32 %i.0, !2420, !DIExpression(), !2421)
  %exitcond70 = icmp eq i32 %i.0, 80, !dbg !2422
  br i1 %exitcond70, label %if.then931, label %for.body831, !dbg !2248

for.body831:                                      ; preds = %for.cond828
  %arrayidx833 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %i.0, !dbg !2424
  %30 = load i8, ptr %arrayidx833, align 1, !dbg !2424
  %cmp835 = icmp eq i8 %30, 0, !dbg !2427
  br i1 %cmp835, label %for.cond839.preheader, label %if.end868, !dbg !2427

for.cond839.preheader:                            ; preds = %for.body831
  br label %for.cond839, !dbg !2428

for.cond839:                                      ; preds = %for.cond839.preheader, %for.body842
  %j.0.in = phi i32 [ %j.0, %for.body842 ], [ %i.0, %for.cond839.preheader ]
  %j.0 = add nuw nsw i32 %j.0.in, 1, !dbg !2431
    #dbg_value(i32 %j.0, !2432, !DIExpression(), !2433)
  %exitcond66 = icmp ne i32 %j.0.in, 79, !dbg !2434
  br i1 %exitcond66, label %for.body842, label %if.end868.loopexit1, !dbg !2428

for.body842:                                      ; preds = %for.cond839
  %arrayidx844 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %j.0, i32 %i.0, !dbg !2436
  %31 = load i8, ptr %arrayidx844, align 1, !dbg !2436
  %cmp846.not = icmp eq i8 %31, 0, !dbg !2439
  br i1 %cmp846.not, label %for.cond839, label %for.cond849.preheader, !dbg !2439, !llvm.loop !2440

for.cond849.preheader:                            ; preds = %for.body842
  %j.0.lcssa2 = phi i32 [ %j.0, %for.body842 ], !dbg !2431
  br label %for.cond849, !dbg !2442

for.cond849:                                      ; preds = %for.cond849.preheader, %for.body852
  %k.0 = phi i32 [ %inc862, %for.body852 ], [ %i.0, %for.cond849.preheader ], !dbg !2445
    #dbg_value(i32 %k.0, !2446, !DIExpression(), !2447)
  %exitcond67 = icmp ne i32 %k.0, 81, !dbg !2448
  br i1 %exitcond67, label %for.body852, label %if.end868.loopexit, !dbg !2442

for.body852:                                      ; preds = %for.cond849
  %arrayidx854 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %k.0, !dbg !2450
  %32 = load i8, ptr %arrayidx854, align 1, !dbg !2450
    #dbg_value(i8 %32, !2452, !DIExpression(), !2453)
  %arrayidx856 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %j.0.lcssa2, i32 %k.0, !dbg !2454
  %33 = load i8, ptr %arrayidx856, align 1, !dbg !2454
  %arrayidx858 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %k.0, !dbg !2455
  store i8 %33, ptr %arrayidx858, align 1, !dbg !2456
  %arrayidx860 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %j.0.lcssa2, i32 %k.0, !dbg !2457
  store i8 %32, ptr %arrayidx860, align 1, !dbg !2458
  %inc862 = add nuw nsw i32 %k.0, 1, !dbg !2459
    #dbg_value(i32 %inc862, !2446, !DIExpression(), !2447)
  br label %for.cond849, !dbg !2460, !llvm.loop !2461

if.end868.loopexit:                               ; preds = %for.cond849
  br label %if.end868, !dbg !2463

if.end868.loopexit1:                              ; preds = %for.cond839
  br label %if.end868, !dbg !2463

if.end868:                                        ; preds = %if.end868.loopexit1, %if.end868.loopexit, %for.body831
  %arrayidx870 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %i.0, !dbg !2463
  %34 = load i8, ptr %arrayidx870, align 1, !dbg !2463
  %cmp872 = icmp eq i8 %34, 0, !dbg !2465
  br i1 %cmp872, label %do.body.loopexit, label %if.end875, !dbg !2465

if.end875:                                        ; preds = %if.end868
  %arrayidx878 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %i.0, !dbg !2466
  %35 = load i8, ptr %arrayidx878, align 1, !dbg !2466
  %call879 = call fastcc zeroext i8 @gf_inv(i8 noundef zeroext %35) #3, !dbg !2467
    #dbg_value(i8 %call879, !2468, !DIExpression(), !2469)
    #dbg_value(i32 %i.0, !2470, !DIExpression(), !2472)
  br label %for.cond881, !dbg !2473

for.cond881:                                      ; preds = %for.body884, %if.end875
  %k880.0 = phi i32 [ %i.0, %if.end875 ], [ %inc891, %for.body884 ], !dbg !2474
    #dbg_value(i32 %k880.0, !2470, !DIExpression(), !2472)
  %exitcond68 = icmp ne i32 %k880.0, 81, !dbg !2475
  br i1 %exitcond68, label %for.body884, label %for.cond895.preheader, !dbg !2477

for.cond895.preheader:                            ; preds = %for.cond881
  br label %for.cond895, !dbg !2478

for.body884:                                      ; preds = %for.cond881
  %arrayidx886 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %k880.0, !dbg !2480
  %36 = load i8, ptr %arrayidx886, align 1, !dbg !2480
  %call887 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %36, i8 noundef zeroext %call879) #3, !dbg !2482
  %arrayidx889 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %k880.0, !dbg !2483
  store i8 %call887, ptr %arrayidx889, align 1, !dbg !2484
  %inc891 = add nuw nsw i32 %k880.0, 1, !dbg !2485
    #dbg_value(i32 %inc891, !2470, !DIExpression(), !2472)
  br label %for.cond881, !dbg !2486, !llvm.loop !2487

for.cond895:                                      ; preds = %for.cond895.preheader, %for.inc924
  %j893.0.in = phi i32 [ %j893.0, %for.inc924 ], [ %i.0, %for.cond895.preheader ]
  %j893.0 = add nuw nsw i32 %j893.0.in, 1, !dbg !2489
    #dbg_value(i32 %j893.0, !2490, !DIExpression(), !2491)
  %cmp896 = icmp samesign ult i32 %j893.0.in, 79, !dbg !2492
  br i1 %cmp896, label %for.body898, label %for.inc927, !dbg !2478

for.body898:                                      ; preds = %for.cond895
  %arrayidx900 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %j893.0, i32 %i.0, !dbg !2494
  %37 = load i8, ptr %arrayidx900, align 1, !dbg !2494
  %cmp902.not = icmp eq i8 %37, 0, !dbg !2497
  br i1 %cmp902.not, label %for.inc924, label %if.then904, !dbg !2497

if.then904:                                       ; preds = %for.body898
  %arrayidx906 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %j893.0, i32 %i.0, !dbg !2498
  %38 = load i8, ptr %arrayidx906, align 1, !dbg !2498
    #dbg_value(i8 %38, !2500, !DIExpression(), !2501)
    #dbg_value(i32 %i.0, !2502, !DIExpression(), !2504)
  br label %for.cond908, !dbg !2505

for.cond908:                                      ; preds = %for.body911, %if.then904
  %k907.0 = phi i32 [ %i.0, %if.then904 ], [ %inc921, %for.body911 ], !dbg !2506
    #dbg_value(i32 %k907.0, !2502, !DIExpression(), !2504)
  %exitcond69 = icmp ne i32 %k907.0, 81, !dbg !2507
  br i1 %exitcond69, label %for.body911, label %for.inc924.loopexit, !dbg !2509

for.body911:                                      ; preds = %for.cond908
  %arrayidx913 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %j893.0, i32 %k907.0, !dbg !2510
  %39 = load i8, ptr %arrayidx913, align 1, !dbg !2510
  %arrayidx915 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i.0, i32 %k907.0, !dbg !2512
  %40 = load i8, ptr %arrayidx915, align 1, !dbg !2512
  %call916 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %40, i8 noundef zeroext %38) #3, !dbg !2513
  %call917 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %39, i8 noundef zeroext %call916) #3, !dbg !2514
  %arrayidx919 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %j893.0, i32 %k907.0, !dbg !2515
  store i8 %call917, ptr %arrayidx919, align 1, !dbg !2516
  %inc921 = add nuw nsw i32 %k907.0, 1, !dbg !2517
    #dbg_value(i32 %inc921, !2502, !DIExpression(), !2504)
  br label %for.cond908, !dbg !2518, !llvm.loop !2519

for.inc924.loopexit:                              ; preds = %for.cond908
  br label %for.inc924, !dbg !2521

for.inc924:                                       ; preds = %for.inc924.loopexit, %for.body898
    #dbg_value(i32 %j893.0, !2490, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !2491)
  br label %for.cond895, !dbg !2521, !llvm.loop !2522

for.inc927:                                       ; preds = %for.cond895
  %inc928 = add nuw nsw i32 %i.0, 1, !dbg !2524
    #dbg_value(i32 %inc928, !2420, !DIExpression(), !2421)
  br label %for.cond828, !dbg !2525, !llvm.loop !2526

if.then931:                                       ; preds = %for.cond828
  %call933 = call ptr @memset(ptr noundef nonnull %solution, i32 noundef 0, i32 noundef 80) #4, !dbg !2528
    #dbg_value(i32 79, !2531, !DIExpression(), !2533)
  br label %for.cond935, !dbg !2534

for.cond935:                                      ; preds = %for.end951, %if.then931
  %i934.0 = phi i32 [ 79, %if.then931 ], [ %dec, %for.end951 ], !dbg !2535
    #dbg_value(i32 %i934.0, !2531, !DIExpression(), !2533)
  %cmp936 = icmp sgt i32 %i934.0, -1, !dbg !2536
  br i1 %cmp936, label %for.body938, label %for.end957, !dbg !2538

for.body938:                                      ; preds = %for.cond935
    #dbg_value(i8 0, !2539, !DIExpression(), !2541)
  store i8 0, ptr %sum, align 1, !dbg !2542
    #dbg_value(i32 %i934.0, !2543, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !2545)
  br label %for.cond941, !dbg !2546

for.cond941:                                      ; preds = %for.body944, %for.body938
  %k939.0.in = phi i32 [ %i934.0, %for.body938 ], [ %k939.0, %for.body944 ]
    #dbg_value(i32 %k939.0.in, !2543, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !2545)
  %exitcond71 = icmp ne i32 %k939.0.in, 79, !dbg !2547
  br i1 %exitcond71, label %for.body944, label %for.end951, !dbg !2549

for.body944:                                      ; preds = %for.cond941
  %k939.0 = add nuw nsw i32 %k939.0.in, 1, !dbg !2550
    #dbg_value(i32 %k939.0, !2543, !DIExpression(), !2545)
  %arrayidx946 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i934.0, i32 %k939.0, !dbg !2551
  %41 = load i8, ptr %arrayidx946, align 1, !dbg !2551
  %arrayidx947 = getelementptr inbounds nuw [80 x i8], ptr %solution, i32 0, i32 %k939.0, !dbg !2553
  %42 = load i8, ptr %arrayidx947, align 1, !dbg !2553
  %call948 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %41, i8 noundef zeroext %42) #3, !dbg !2554
    #dbg_value(ptr %sum, !2539, !DIExpression(DW_OP_deref), !2541)
  call fastcc void @gf_set_add(ptr noundef nonnull %sum, i8 noundef zeroext %call948) #3, !dbg !2555
    #dbg_value(i32 %k939.0, !2543, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !2545)
  br label %for.cond941, !dbg !2556, !llvm.loop !2557

for.end951:                                       ; preds = %for.cond941
  %arrayidx953 = getelementptr inbounds nuw [80 x [81 x i8]], ptr %gauss, i32 0, i32 %i934.0, i32 80, !dbg !2559
  %43 = load i8, ptr %arrayidx953, align 1, !dbg !2559
  %44 = load i8, ptr %sum, align 1, !dbg !2560
    #dbg_value(i8 %44, !2539, !DIExpression(), !2541)
  %call954 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %43, i8 noundef zeroext %44) #3, !dbg !2561
  %arrayidx955 = getelementptr inbounds nuw [80 x i8], ptr %solution, i32 0, i32 %i934.0, !dbg !2562
  store i8 %call954, ptr %arrayidx955, align 1, !dbg !2563
  %dec = add nsw i32 %i934.0, -1, !dbg !2564
    #dbg_value(i32 %dec, !2531, !DIExpression(), !2533)
  br label %for.cond935, !dbg !2565, !llvm.loop !2566

for.end957:                                       ; preds = %for.cond935
  %add.ptr959 = getelementptr inbounds nuw i8, ptr %signature_in_GF, i32 432, !dbg !2568
  %call961 = call ptr @memcpy(ptr noundef nonnull %add.ptr959, ptr noundef nonnull %solution, i32 noundef 80) #4, !dbg !2569
    #dbg_value(i32 0, !2570, !DIExpression(), !2572)
  br label %for.cond962, !dbg !2573

for.cond962:                                      ; preds = %for.inc982, %for.end957
  %index.0 = phi i32 [ 0, %for.end957 ], [ %inc983, %for.inc982 ], !dbg !2574
    #dbg_value(i32 %index.0, !2570, !DIExpression(), !2572)
  %exitcond73 = icmp ne i32 %index.0, 27, !dbg !2575
  br i1 %exitcond73, label %for.cond967.preheader, label %do.end, !dbg !2577

for.cond967.preheader:                            ; preds = %for.cond962
  br label %for.cond967, !dbg !2578

for.cond967:                                      ; preds = %for.cond967.preheader, %for.body970
  %mi966.0 = phi i32 [ %inc980, %for.body970 ], [ 0, %for.cond967.preheader ], !dbg !2581
    #dbg_value(i32 %mi966.0, !2582, !DIExpression(), !2583)
  %exitcond72 = icmp ne i32 %mi966.0, 5, !dbg !2584
  br i1 %exitcond72, label %for.body970, label %for.inc982, !dbg !2578

for.body970:                                      ; preds = %for.cond967
  %mul971 = shl nuw nsw i32 %index.0, 4, !dbg !2586
  %arrayidx972 = getelementptr inbounds nuw [512 x i8], ptr %signature_in_GF, i32 0, i32 %mul971, !dbg !2588
  %mul973 = mul nuw nsw i32 %index.0, 5, !dbg !2589
  %add974 = add nuw nsw i32 %mul973, %mi966.0, !dbg !2590
  %mul975 = shl nuw nsw i32 %add974, 4, !dbg !2591
  %arrayidx976 = getelementptr inbounds nuw [2160 x i8], ptr %T12, i32 0, i32 %mul975, !dbg !2592
  %mul977 = shl nuw nsw i32 %mi966.0, 4, !dbg !2593
  %arrayidx978 = getelementptr inbounds nuw [80 x i8], ptr %solution, i32 0, i32 %mul977, !dbg !2594
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %arrayidx972, ptr noundef nonnull %arrayidx976, ptr noundef nonnull %arrayidx978, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !2595
  %inc980 = add nuw nsw i32 %mi966.0, 1, !dbg !2596
    #dbg_value(i32 %inc980, !2582, !DIExpression(), !2583)
  br label %for.cond967, !dbg !2597, !llvm.loop !2598

for.inc982:                                       ; preds = %for.cond967
  %inc983 = add nuw nsw i32 %index.0, 1, !dbg !2600
    #dbg_value(i32 %inc983, !2570, !DIExpression(), !2572)
  br label %for.cond962, !dbg !2601, !llvm.loop !2602

do.end:                                           ; preds = %for.cond962
  call fastcc void @compress_gf(ptr noundef %sig, ptr noundef nonnull %signature_in_GF, i32 noundef 512) #3, !dbg !2604
  %add.ptr989 = getelementptr inbounds nuw i8, ptr %sig, i32 256, !dbg !2605
  %call990 = call ptr @memcpy(ptr noundef nonnull %add.ptr989, ptr noundef %salt, i32 noundef 16) #4, !dbg !2606
  br label %return, !dbg !2607

return:                                           ; preds = %do.end, %if.then119
  %retval.0 = phi i32 [ -1, %if.then119 ], [ 0, %do.end ], !dbg !1209
  ret i32 %retval.0, !dbg !2608
}

; Function Attrs: nounwind
define internal fastcc void @gen_ABQ(ptr noundef nonnull %A, ptr noundef nonnull %Am, ptr noundef nonnull %Bm, ptr noundef nonnull %Q1m, ptr noundef nonnull %Q2m) unnamed_addr #0 !dbg !2609 {
entry:
    #dbg_value(ptr %A, !2612, !DIExpression(), !2613)
    #dbg_value(ptr %Am, !2614, !DIExpression(), !2613)
    #dbg_value(ptr %Bm, !2615, !DIExpression(), !2613)
    #dbg_value(ptr %Q1m, !2616, !DIExpression(), !2613)
    #dbg_value(ptr %Q2m, !2617, !DIExpression(), !2613)
  %add.ptr = getelementptr inbounds nuw i8, ptr %A, i32 1920, !dbg !2618
    #dbg_value(ptr %add.ptr, !2619, !DIExpression(), !2613)
  %add.ptr1 = getelementptr inbounds nuw i8, ptr %A, i32 3840, !dbg !2620
    #dbg_value(ptr %add.ptr1, !2621, !DIExpression(), !2613)
  %add.ptr2 = getelementptr inbounds nuw i8, ptr %A, i32 4320, !dbg !2622
    #dbg_value(ptr %add.ptr2, !2623, !DIExpression(), !2613)
    #dbg_value(i32 0, !2624, !DIExpression(), !2626)
  br label %for.cond, !dbg !2627

for.cond:                                         ; preds = %for.body, %entry
  %idx.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !2628
    #dbg_value(i32 %idx.0, !2624, !DIExpression(), !2626)
  %exitcond = icmp ne i32 %idx.0, 120, !dbg !2629
  br i1 %exitcond, label %for.body, label %for.end, !dbg !2631

for.body:                                         ; preds = %for.cond
  %mul = shl nuw nsw i32 %idx.0, 4, !dbg !2632
  %arrayidx = getelementptr inbounds nuw i8, ptr %Am, i32 %mul, !dbg !2634
  %mul3 = shl nuw nsw i32 %idx.0, 4, !dbg !2635
  %arrayidx4 = getelementptr inbounds nuw i8, ptr %A, i32 %mul3, !dbg !2636
  call fastcc void @be_invertible_by_add_aS(ptr noundef nonnull %arrayidx, ptr noundef %arrayidx4, i32 noundef 4, i32 noundef 4) #3, !dbg !2637
  %mul5 = shl nuw nsw i32 %idx.0, 4, !dbg !2638
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %Bm, i32 %mul5, !dbg !2639
  %mul7 = shl nuw nsw i32 %idx.0, 4, !dbg !2640
  %arrayidx8 = getelementptr inbounds nuw i8, ptr %add.ptr, i32 %mul7, !dbg !2641
  call fastcc void @be_invertible_by_add_aS(ptr noundef nonnull %arrayidx6, ptr noundef nonnull %arrayidx8, i32 noundef 4, i32 noundef 4) #3, !dbg !2642
  %mul9 = shl nuw nsw i32 %idx.0, 4, !dbg !2643
  %arrayidx10 = getelementptr inbounds nuw i8, ptr %Q1m, i32 %mul9, !dbg !2644
  %mul11 = shl nuw nsw i32 %idx.0, 2, !dbg !2645
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %add.ptr1, i32 %mul11, !dbg !2646
  call fastcc void @gen_a_FqS(ptr noundef %arrayidx10, ptr noundef nonnull %arrayidx12) #3, !dbg !2647
  %mul13 = shl nuw nsw i32 %idx.0, 4, !dbg !2648
  %arrayidx14 = getelementptr inbounds nuw i8, ptr %Q2m, i32 %mul13, !dbg !2649
  %mul15 = shl nuw nsw i32 %idx.0, 2, !dbg !2650
  %arrayidx16 = getelementptr inbounds nuw i8, ptr %add.ptr2, i32 %mul15, !dbg !2651
  call fastcc void @gen_a_FqS(ptr noundef %arrayidx14, ptr noundef nonnull %arrayidx16) #3, !dbg !2652
  %inc = add nuw nsw i32 %idx.0, 1, !dbg !2653
    #dbg_value(i32 %inc, !2624, !DIExpression(), !2626)
  br label %for.cond, !dbg !2654, !llvm.loop !2655

for.end:                                          ; preds = %for.cond
  ret void, !dbg !2657
}

; Function Attrs: nounwind
define internal fastcc void @hash_combined(ptr noundef nonnull %hash_out, ptr noundef %digest, i32 noundef %len_digest, ptr noundef %pk_seed, ptr noundef %salt) unnamed_addr #0 !dbg !2658 {
entry:
  %state = alloca %struct.shake_t, align 8
    #dbg_value(ptr %hash_out, !2661, !DIExpression(), !2662)
    #dbg_value(ptr %digest, !2663, !DIExpression(), !2662)
    #dbg_value(i32 %len_digest, !2664, !DIExpression(), !2662)
    #dbg_value(ptr %pk_seed, !2665, !DIExpression(), !2662)
    #dbg_value(ptr %salt, !2666, !DIExpression(), !2662)
    #dbg_declare(ptr %state, !2667, !DIExpression(), !2668)
  call void @shake256_init(ptr noundef nonnull %state) #3, !dbg !2669
  call void @shake_absorb(ptr noundef nonnull %state, ptr noundef %pk_seed, i32 noundef 48) #3, !dbg !2670
  call void @shake_absorb(ptr noundef nonnull %state, ptr noundef %digest, i32 noundef %len_digest) #3, !dbg !2671
  call void @shake_absorb(ptr noundef nonnull %state, ptr noundef %salt, i32 noundef 16) #3, !dbg !2672
  call void @shake_finalize(ptr noundef nonnull %state) #3, !dbg !2673
  call void @shake_squeeze(ptr noundef nonnull %hash_out, i32 noundef 40, ptr noundef nonnull %state) #3, !dbg !2674
  ret void, !dbg !2675
}

; Function Attrs: nounwind
define internal fastcc range(i32 0, 256) i32 @expand_gf(ptr noundef nonnull %gf_array, ptr noundef %byte_array, i32 noundef range(i32 80, 2001) %num) unnamed_addr #0 !dbg !2676 {
entry:
    #dbg_value(ptr %gf_array, !2679, !DIExpression(), !2680)
    #dbg_value(ptr %byte_array, !2681, !DIExpression(), !2680)
    #dbg_value(i32 %num, !2682, !DIExpression(), !2680)
  %sub = add nuw nsw i32 %num, 1, !dbg !2683
  %div1 = lshr i32 %sub, 1, !dbg !2683
    #dbg_value(i32 %div1, !2684, !DIExpression(), !2680)
    #dbg_value(i32 0, !2685, !DIExpression(), !2680)
    #dbg_value(i32 0, !2686, !DIExpression(), !2680)
    #dbg_value(i32 0, !2687, !DIExpression(), !2680)
  br label %do.body, !dbg !2688

do.body:                                          ; preds = %while.end17, %entry
  %out_idx.0 = phi i32 [ 0, %entry ], [ %out_idx.1.lcssa, %while.end17 ], !dbg !2689
  %idx.0 = phi i32 [ 0, %entry ], [ %idx.1.lcssa, %while.end17 ], !dbg !2690
  %res.0 = phi i32 [ 0, %entry ], [ %conv19, %while.end17 ], !dbg !2680
    #dbg_value(i32 %res.0, !2687, !DIExpression(), !2680)
    #dbg_value(i32 %idx.0, !2685, !DIExpression(), !2680)
    #dbg_value(i32 %out_idx.0, !2686, !DIExpression(), !2680)
    #dbg_value(i64 0, !2691, !DIExpression(), !2680)
    #dbg_value(i32 0, !2692, !DIExpression(), !2694)
  br label %while.cond, !dbg !2695

while.cond:                                       ; preds = %while.body, %do.body
  %idx.1 = phi i32 [ %idx.0, %do.body ], [ %inc, %while.body ], !dbg !2680
  %val.0 = phi i64 [ 0, %do.body ], [ %xor, %while.body ], !dbg !2694
  %cmp = phi i1 [ true, %do.body ], [ false, %while.body ], !dbg !2694
    #dbg_value(i32 poison, !2692, !DIExpression(), !2694)
    #dbg_value(i64 %val.0, !2691, !DIExpression(), !2680)
    #dbg_value(i32 %idx.1, !2685, !DIExpression(), !2680)
  %cmp1 = icmp ult i32 %idx.1, %div1
  %spec.select = select i1 %cmp, i1 %cmp1, i1 false, !dbg !2696
  br i1 %spec.select, label %while.body, label %while.cond4.preheader, !dbg !2695

while.cond4.preheader:                            ; preds = %while.cond
  %idx.1.lcssa = phi i32 [ %idx.1, %while.cond ], !dbg !2680
  %val.0.lcssa = phi i64 [ %val.0, %while.cond ], !dbg !2694
  br label %while.cond4, !dbg !2697

while.body:                                       ; preds = %while.cond
  %arrayidx = getelementptr inbounds nuw i8, ptr %byte_array, i32 %idx.1, !dbg !2698
  %0 = load i8, ptr %arrayidx, align 1, !dbg !2698
  %conv = zext i8 %0 to i64, !dbg !2700
  %xor = xor i64 %val.0, %conv, !dbg !2701
    #dbg_value(i64 %xor, !2691, !DIExpression(), !2680)
  %inc = add nuw nsw i32 %idx.1, 1, !dbg !2702
    #dbg_value(i32 %inc, !2685, !DIExpression(), !2680)
    #dbg_value(i32 1, !2692, !DIExpression(), !2694)
  br label %while.cond, !dbg !2695, !llvm.loop !2703

while.cond4:                                      ; preds = %while.cond4.preheader, %while.body11
  %out_idx.1 = phi i32 [ %inc15, %while.body11 ], [ %out_idx.0, %while.cond4.preheader ], !dbg !2680
  %val.1 = phi i64 [ %div143, %while.body11 ], [ %val.0.lcssa, %while.cond4.preheader ], !dbg !2694
  %j1.0 = phi i32 [ %inc16, %while.body11 ], [ 0, %while.cond4.preheader ], !dbg !2694
    #dbg_value(i32 %j1.0, !2705, !DIExpression(), !2694)
    #dbg_value(i64 %val.1, !2691, !DIExpression(), !2680)
    #dbg_value(i32 %out_idx.1, !2686, !DIExpression(), !2680)
  %cmp5 = icmp samesign ult i32 %j1.0, 2, !dbg !2706
  %cmp8 = icmp ult i32 %out_idx.1, %num
  %spec.select4 = select i1 %cmp5, i1 %cmp8, i1 false, !dbg !2707
  br i1 %spec.select4, label %while.body11, label %while.end17, !dbg !2697

while.body11:                                     ; preds = %while.cond4
  %1 = trunc nuw i64 %val.1 to i8, !dbg !2708
  %conv12 = and i8 %1, 15, !dbg !2708
  %arrayidx13 = getelementptr inbounds nuw i8, ptr %gf_array, i32 %out_idx.1, !dbg !2710
  store i8 %conv12, ptr %arrayidx13, align 1, !dbg !2711
  %div143 = lshr i64 %val.1, 4, !dbg !2712
    #dbg_value(i64 %div143, !2691, !DIExpression(), !2680)
  %inc15 = add nuw nsw i32 %out_idx.1, 1, !dbg !2713
    #dbg_value(i32 %inc15, !2686, !DIExpression(), !2680)
  %inc16 = add nuw nsw i32 %j1.0, 1, !dbg !2714
    #dbg_value(i32 %inc16, !2705, !DIExpression(), !2694)
  br label %while.cond4, !dbg !2697, !llvm.loop !2715

while.end17:                                      ; preds = %while.cond4
  %out_idx.1.lcssa = phi i32 [ %out_idx.1, %while.cond4 ], !dbg !2680
  %val.1.lcssa = phi i64 [ %val.1, %while.cond4 ], !dbg !2694
  %2 = trunc nuw nsw i64 %val.1.lcssa to i32, !dbg !2717
  %conv19 = or i32 %res.0, %2, !dbg !2717
    #dbg_value(i32 %conv19, !2687, !DIExpression(), !2680)
  %cmp20 = icmp ult i32 %out_idx.1.lcssa, %num, !dbg !2718
  br i1 %cmp20, label %do.body, label %do.end, !dbg !2719, !llvm.loop !2720

do.end:                                           ; preds = %while.end17
  %conv19.lcssa = phi i32 [ %conv19, %while.end17 ], !dbg !2717
  %and = and i32 %num, 1, !dbg !2722
  %tobool.not = icmp eq i32 %and, 0, !dbg !2722
  br i1 %tobool.not, label %return, label %if.then, !dbg !2722

if.then:                                          ; preds = %do.end
  %div222 = lshr i32 %num, 1, !dbg !2724
  %arrayidx23 = getelementptr inbounds nuw i8, ptr %byte_array, i32 %div222, !dbg !2726
  %3 = load i8, ptr %arrayidx23, align 1, !dbg !2726
  %4 = and i8 %3, -16, !dbg !2727
  %and25 = zext i8 %4 to i32, !dbg !2727
  br label %return, !dbg !2728

return:                                           ; preds = %do.end, %if.then
  %retval.0 = phi i32 [ %and25, %if.then ], [ %conv19.lcssa, %do.end ], !dbg !2680
  ret i32 %retval.0, !dbg !2729
}

; Function Attrs: nounwind
define internal fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %a, ptr noundef %b, ptr noundef %c, i32 noundef %ad, i32 noundef %bd, i32 noundef %cd) unnamed_addr #0 !dbg !2730 {
entry:
  %sum = alloca i8, align 1
    #dbg_value(ptr %a, !2733, !DIExpression(), !2734)
    #dbg_value(ptr %b, !2735, !DIExpression(), !2734)
    #dbg_value(ptr %c, !2736, !DIExpression(), !2734)
    #dbg_value(i32 4, !2737, !DIExpression(), !2734)
    #dbg_value(i32 4, !2738, !DIExpression(), !2734)
    #dbg_value(i32 4, !2739, !DIExpression(), !2734)
    #dbg_value(i32 0, !2740, !DIExpression(), !2742)
  br label %for.cond, !dbg !2743

for.cond:                                         ; preds = %for.inc16, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc17, %for.inc16 ], !dbg !2744
    #dbg_value(i32 %i1.0, !2740, !DIExpression(), !2742)
  %exitcond2 = icmp ne i32 %i1.0, 4, !dbg !2745
  br i1 %exitcond2, label %for.cond1.preheader, label %for.end18, !dbg !2747

for.cond1.preheader:                              ; preds = %for.cond
  br label %for.cond1, !dbg !2748

for.cond1:                                        ; preds = %for.cond1.preheader, %for.end
  %j1.0 = phi i32 [ %inc14, %for.end ], [ 0, %for.cond1.preheader ], !dbg !2750
    #dbg_value(i32 %j1.0, !2751, !DIExpression(), !2752)
  %exitcond1 = icmp ne i32 %j1.0, 4, !dbg !2753
  br i1 %exitcond1, label %for.body3, label %for.inc16, !dbg !2748

for.body3:                                        ; preds = %for.cond1
    #dbg_value(i8 0, !2755, !DIExpression(), !2757)
  store i8 0, ptr %sum, align 1, !dbg !2758
    #dbg_value(i32 0, !2759, !DIExpression(), !2761)
  br label %for.cond4, !dbg !2762

for.cond4:                                        ; preds = %for.body6, %for.body3
  %k1.0 = phi i32 [ 0, %for.body3 ], [ %inc, %for.body6 ], !dbg !2763
    #dbg_value(i32 %k1.0, !2759, !DIExpression(), !2761)
  %exitcond = icmp ne i32 %k1.0, 4, !dbg !2764
  br i1 %exitcond, label %for.body6, label %for.end, !dbg !2766

for.body6:                                        ; preds = %for.cond4
  %mul = shl nuw nsw i32 %i1.0, 2, !dbg !2767
  %0 = getelementptr i8, ptr %b, i32 %mul, !dbg !2769
  %arrayidx = getelementptr i8, ptr %0, i32 %k1.0, !dbg !2769
  %1 = load i8, ptr %arrayidx, align 1, !dbg !2769
  %mul7 = shl nuw nsw i32 %k1.0, 2, !dbg !2770
  %2 = getelementptr i8, ptr %c, i32 %mul7, !dbg !2771
  %arrayidx9 = getelementptr i8, ptr %2, i32 %j1.0, !dbg !2771
  %3 = load i8, ptr %arrayidx9, align 1, !dbg !2771
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %1, i8 noundef zeroext %3) #3, !dbg !2772
    #dbg_value(ptr %sum, !2755, !DIExpression(DW_OP_deref), !2757)
  call fastcc void @gf_set_add(ptr noundef nonnull %sum, i8 noundef zeroext %call) #3, !dbg !2773
  %inc = add nuw nsw i32 %k1.0, 1, !dbg !2774
    #dbg_value(i32 %inc, !2759, !DIExpression(), !2761)
  br label %for.cond4, !dbg !2775, !llvm.loop !2776

for.end:                                          ; preds = %for.cond4
  %mul10 = shl nuw nsw i32 %i1.0, 2, !dbg !2778
  %4 = getelementptr i8, ptr %a, i32 %mul10, !dbg !2779
  %arrayidx12 = getelementptr i8, ptr %4, i32 %j1.0, !dbg !2779
  %5 = load i8, ptr %sum, align 1, !dbg !2780
    #dbg_value(i8 %5, !2755, !DIExpression(), !2757)
  call fastcc void @gf_set_add(ptr noundef %arrayidx12, i8 noundef zeroext %5) #3, !dbg !2781
  %inc14 = add nuw nsw i32 %j1.0, 1, !dbg !2782
    #dbg_value(i32 %inc14, !2751, !DIExpression(), !2752)
  br label %for.cond1, !dbg !2783, !llvm.loop !2784

for.inc16:                                        ; preds = %for.cond1
  %inc17 = add nuw nsw i32 %i1.0, 1, !dbg !2786
    #dbg_value(i32 %inc17, !2740, !DIExpression(), !2742)
  br label %for.cond, !dbg !2787, !llvm.loop !2788

for.end18:                                        ; preds = %for.cond
  ret void, !dbg !2790
}

; Function Attrs: nounwind
define internal fastcc zeroext i8 @gf_sub(i8 noundef zeroext %a, i8 noundef zeroext %b) unnamed_addr #0 !dbg !2791 {
entry:
    #dbg_value(i8 %a, !2792, !DIExpression(), !2793)
    #dbg_value(i8 %b, !2794, !DIExpression(), !2793)
  %conv = zext i8 %a to i32, !dbg !2795
  %mul = shl nuw nsw i32 %conv, 4, !dbg !2796
  %conv1 = zext i8 %b to i32, !dbg !2797
  %add = add nuw nsw i32 %mul, %conv1, !dbg !2798
  %arrayidx = getelementptr inbounds nuw [256 x i8], ptr @gf_addtab, i32 0, i32 %add, !dbg !2799
  %0 = load i8, ptr %arrayidx, align 1, !dbg !2799
  ret i8 %0, !dbg !2800
}

; Function Attrs: nounwind
define internal fastcc zeroext i8 @gf_inv(i8 noundef zeroext %a) unnamed_addr #0 !dbg !2801 {
entry:
    #dbg_value(i8 %a, !2804, !DIExpression(), !2805)
  %idxprom = zext i8 %a to i32, !dbg !2806
  %arrayidx = getelementptr inbounds nuw [16 x i8], ptr @gf_invtab, i32 0, i32 %idxprom, !dbg !2806
  %0 = load i8, ptr %arrayidx, align 1, !dbg !2806
  ret i8 %0, !dbg !2807
}

; Function Attrs: nounwind
define internal fastcc void @be_invertible_by_add_aS(ptr noundef %mat, ptr noundef nonnull %orig, i32 noundef %l1, i32 noundef %l2) unnamed_addr #0 !dbg !2808 {
entry:
    #dbg_value(ptr %mat, !2812, !DIExpression(), !2813)
    #dbg_value(ptr %orig, !2814, !DIExpression(), !2813)
    #dbg_value(i32 4, !2815, !DIExpression(), !2813)
    #dbg_value(i32 4, !2816, !DIExpression(), !2813)
  %call = call ptr @memcpy(ptr noundef %mat, ptr noundef nonnull %orig, i32 noundef 16) #4, !dbg !2817
  %call2 = call fastcc zeroext i8 @gf_mat_det(ptr noundef %mat) #3, !dbg !2818
  %cmp3 = icmp eq i8 %call2, 0, !dbg !2821
  br i1 %cmp3, label %for.cond.preheader, label %if.end24, !dbg !2821

for.cond.preheader:                               ; preds = %entry
  br label %for.cond, !dbg !2822

for.cond:                                         ; preds = %for.cond.preheader, %for.inc20
  %f1.0 = phi i8 [ %inc21, %for.inc20 ], [ 1, %for.cond.preheader ], !dbg !2825
    #dbg_value(i8 %f1.0, !2826, !DIExpression(), !2827)
  %cmp7 = icmp samesign ult i8 %f1.0, 16, !dbg !2828
  br i1 %cmp7, label %for.cond9.preheader, label %if.end24.loopexit, !dbg !2822

for.cond9.preheader:                              ; preds = %for.cond
  br label %for.cond9, !dbg !2830

for.cond9:                                        ; preds = %for.cond9.preheader, %for.body12
  %i1.0 = phi i32 [ %inc, %for.body12 ], [ 0, %for.cond9.preheader ], !dbg !2833
    #dbg_value(i32 %i1.0, !2834, !DIExpression(), !2835)
  %exitcond = icmp ne i32 %i1.0, 16, !dbg !2836
  br i1 %exitcond, label %for.body12, label %for.end, !dbg !2830

for.body12:                                       ; preds = %for.cond9
  %arrayidx = getelementptr inbounds nuw i8, ptr %mat, i32 %i1.0, !dbg !2838
  %add = or disjoint i32 %i1.0, 16, !dbg !2840
  %arrayidx13 = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %add, !dbg !2841
  %0 = load i8, ptr %arrayidx13, align 1, !dbg !2841
  %call14 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %f1.0, i8 noundef zeroext %0) #3, !dbg !2842
  call fastcc void @gf_set_add(ptr noundef %arrayidx, i8 noundef zeroext %call14) #3, !dbg !2843
  %inc = add nuw nsw i32 %i1.0, 1, !dbg !2844
    #dbg_value(i32 %inc, !2834, !DIExpression(), !2835)
  br label %for.cond9, !dbg !2845, !llvm.loop !2846

for.end:                                          ; preds = %for.cond9
  %call15 = call fastcc zeroext i8 @gf_mat_det(ptr noundef %mat) #3, !dbg !2848
  %cmp17.not = icmp eq i8 %call15, 0, !dbg !2850
  br i1 %cmp17.not, label %for.inc20, label %if.end24.loopexit, !dbg !2850

for.inc20:                                        ; preds = %for.end
  %inc21 = add nuw nsw i8 %f1.0, 1, !dbg !2851
    #dbg_value(i8 %inc21, !2826, !DIExpression(), !2827)
  br label %for.cond, !dbg !2852, !llvm.loop !2853

if.end24.loopexit:                                ; preds = %for.cond, %for.end
  br label %if.end24, !dbg !2855

if.end24:                                         ; preds = %if.end24.loopexit, %entry
  ret void, !dbg !2855
}

; Function Attrs: nounwind
define internal fastcc void @gen_a_FqS(ptr noundef nonnull %Qm, ptr noundef nonnull %q) unnamed_addr #0 !dbg !2856 {
entry:
  %sum = alloca i8, align 1
    #dbg_value(ptr %Qm, !2857, !DIExpression(), !2858)
    #dbg_value(ptr %q, !2859, !DIExpression(), !2858)
    #dbg_value(i32 0, !2860, !DIExpression(), !2862)
  br label %for.cond, !dbg !2863

for.cond:                                         ; preds = %for.end, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc7, %for.end ], !dbg !2864
    #dbg_value(i32 %i1.0, !2860, !DIExpression(), !2862)
  %exitcond1 = icmp ne i32 %i1.0, 16, !dbg !2865
  br i1 %exitcond1, label %for.body, label %for.end8, !dbg !2867

for.body:                                         ; preds = %for.cond
    #dbg_value(i8 0, !2868, !DIExpression(), !2870)
  store i8 0, ptr %sum, align 1, !dbg !2871
    #dbg_value(i32 0, !2872, !DIExpression(), !2874)
  br label %for.cond1, !dbg !2875

for.cond1:                                        ; preds = %for.body3, %for.body
  %j1.0 = phi i32 [ 0, %for.body ], [ %inc, %for.body3 ], !dbg !2876
    #dbg_value(i32 %j1.0, !2872, !DIExpression(), !2874)
  %exitcond = icmp ne i32 %j1.0, 4, !dbg !2877
  br i1 %exitcond, label %for.body3, label %for.end, !dbg !2879

for.body3:                                        ; preds = %for.cond1
  %arrayidx = getelementptr inbounds nuw i8, ptr %q, i32 %j1.0, !dbg !2880
  %0 = load i8, ptr %arrayidx, align 1, !dbg !2880
  %mul = shl nuw nsw i32 %j1.0, 4, !dbg !2882
  %add = or disjoint i32 %mul, %i1.0, !dbg !2883
  %arrayidx4 = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %add, !dbg !2884
  %1 = load i8, ptr %arrayidx4, align 1, !dbg !2884
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %0, i8 noundef zeroext %1) #3, !dbg !2885
    #dbg_value(ptr %sum, !2868, !DIExpression(DW_OP_deref), !2870)
  call fastcc void @gf_set_add(ptr noundef nonnull %sum, i8 noundef zeroext %call) #3, !dbg !2886
  %inc = add nuw nsw i32 %j1.0, 1, !dbg !2887
    #dbg_value(i32 %inc, !2872, !DIExpression(), !2874)
  br label %for.cond1, !dbg !2888, !llvm.loop !2889

for.end:                                          ; preds = %for.cond1
  %2 = load i8, ptr %sum, align 1, !dbg !2891
    #dbg_value(i8 %2, !2868, !DIExpression(), !2870)
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %Qm, i32 %i1.0, !dbg !2892
  store i8 %2, ptr %arrayidx5, align 1, !dbg !2893
  %inc7 = add nuw nsw i32 %i1.0, 1, !dbg !2894
    #dbg_value(i32 %inc7, !2860, !DIExpression(), !2862)
  br label %for.cond, !dbg !2895, !llvm.loop !2896

for.end8:                                         ; preds = %for.cond
  ret void, !dbg !2898
}

; Function Attrs: nounwind
define internal fastcc zeroext i8 @gf_mat_det(ptr noundef %a) unnamed_addr #0 !dbg !2899 {
entry:
  %det = alloca i8, align 1
    #dbg_value(ptr %a, !2902, !DIExpression(), !2903)
    #dbg_value(i8 0, !2904, !DIExpression(), !2903)
  store i8 0, ptr %det, align 1, !dbg !2905
  %0 = load i8, ptr %a, align 1, !dbg !2906
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %a, i32 5, !dbg !2906
  %1 = load i8, ptr %arrayidx1, align 1, !dbg !2906
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %0, i8 noundef zeroext %1) #3, !dbg !2906
  %arrayidx2 = getelementptr inbounds nuw i8, ptr %a, i32 1, !dbg !2906
  %2 = load i8, ptr %arrayidx2, align 1, !dbg !2906
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %a, i32 4, !dbg !2906
  %3 = load i8, ptr %arrayidx3, align 1, !dbg !2906
  %call4 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %2, i8 noundef zeroext %3) #3, !dbg !2906
  %call5 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call, i8 noundef zeroext %call4) #3, !dbg !2906
    #dbg_value(i8 %call5, !2907, !DIExpression(), !2903)
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %a, i32 10, !dbg !2906
  %4 = load i8, ptr %arrayidx6, align 1, !dbg !2906
  %arrayidx7 = getelementptr inbounds nuw i8, ptr %a, i32 15, !dbg !2906
  %5 = load i8, ptr %arrayidx7, align 1, !dbg !2906
  %call8 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %4, i8 noundef zeroext %5) #3, !dbg !2906
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %a, i32 11, !dbg !2906
  %6 = load i8, ptr %arrayidx9, align 1, !dbg !2906
  %arrayidx10 = getelementptr inbounds nuw i8, ptr %a, i32 14, !dbg !2906
  %7 = load i8, ptr %arrayidx10, align 1, !dbg !2906
  %call11 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %6, i8 noundef zeroext %7) #3, !dbg !2906
  %call12 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call8, i8 noundef zeroext %call11) #3, !dbg !2906
    #dbg_value(i8 %call12, !2908, !DIExpression(), !2903)
  %call13 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %call5, i8 noundef zeroext %call12) #3, !dbg !2906
    #dbg_value(ptr %det, !2904, !DIExpression(DW_OP_deref), !2903)
  call fastcc void @gf_set_add(ptr noundef nonnull %det, i8 noundef zeroext %call13) #3, !dbg !2906
  %8 = load i8, ptr %a, align 1, !dbg !2909
  %arrayidx15 = getelementptr inbounds nuw i8, ptr %a, i32 6, !dbg !2909
  %9 = load i8, ptr %arrayidx15, align 1, !dbg !2909
  %call16 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %8, i8 noundef zeroext %9) #3, !dbg !2909
  %arrayidx17 = getelementptr inbounds nuw i8, ptr %a, i32 2, !dbg !2909
  %10 = load i8, ptr %arrayidx17, align 1, !dbg !2909
  %arrayidx18 = getelementptr inbounds nuw i8, ptr %a, i32 4, !dbg !2909
  %11 = load i8, ptr %arrayidx18, align 1, !dbg !2909
  %call19 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %10, i8 noundef zeroext %11) #3, !dbg !2909
  %call20 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call16, i8 noundef zeroext %call19) #3, !dbg !2909
    #dbg_value(i8 %call20, !2907, !DIExpression(), !2903)
  %arrayidx21 = getelementptr inbounds nuw i8, ptr %a, i32 11, !dbg !2909
  %12 = load i8, ptr %arrayidx21, align 1, !dbg !2909
  %arrayidx22 = getelementptr inbounds nuw i8, ptr %a, i32 13, !dbg !2909
  %13 = load i8, ptr %arrayidx22, align 1, !dbg !2909
  %call23 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %12, i8 noundef zeroext %13) #3, !dbg !2909
  %arrayidx24 = getelementptr inbounds nuw i8, ptr %a, i32 9, !dbg !2909
  %14 = load i8, ptr %arrayidx24, align 1, !dbg !2909
  %arrayidx25 = getelementptr inbounds nuw i8, ptr %a, i32 15, !dbg !2909
  %15 = load i8, ptr %arrayidx25, align 1, !dbg !2909
  %call26 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %14, i8 noundef zeroext %15) #3, !dbg !2909
  %call27 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call23, i8 noundef zeroext %call26) #3, !dbg !2909
    #dbg_value(i8 %call27, !2908, !DIExpression(), !2903)
  %call28 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %call20, i8 noundef zeroext %call27) #3, !dbg !2909
  call fastcc void @gf_set_add(ptr noundef nonnull %det, i8 noundef zeroext %call28) #3, !dbg !2909
  %16 = load i8, ptr %a, align 1, !dbg !2910
  %arrayidx30 = getelementptr inbounds nuw i8, ptr %a, i32 7, !dbg !2910
  %17 = load i8, ptr %arrayidx30, align 1, !dbg !2910
  %call31 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %16, i8 noundef zeroext %17) #3, !dbg !2910
  %arrayidx32 = getelementptr inbounds nuw i8, ptr %a, i32 3, !dbg !2910
  %18 = load i8, ptr %arrayidx32, align 1, !dbg !2910
  %arrayidx33 = getelementptr inbounds nuw i8, ptr %a, i32 4, !dbg !2910
  %19 = load i8, ptr %arrayidx33, align 1, !dbg !2910
  %call34 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %18, i8 noundef zeroext %19) #3, !dbg !2910
  %call35 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call31, i8 noundef zeroext %call34) #3, !dbg !2910
    #dbg_value(i8 %call35, !2907, !DIExpression(), !2903)
  %arrayidx36 = getelementptr inbounds nuw i8, ptr %a, i32 9, !dbg !2910
  %20 = load i8, ptr %arrayidx36, align 1, !dbg !2910
  %arrayidx37 = getelementptr inbounds nuw i8, ptr %a, i32 14, !dbg !2910
  %21 = load i8, ptr %arrayidx37, align 1, !dbg !2910
  %call38 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %20, i8 noundef zeroext %21) #3, !dbg !2910
  %arrayidx39 = getelementptr inbounds nuw i8, ptr %a, i32 10, !dbg !2910
  %22 = load i8, ptr %arrayidx39, align 1, !dbg !2910
  %arrayidx40 = getelementptr inbounds nuw i8, ptr %a, i32 13, !dbg !2910
  %23 = load i8, ptr %arrayidx40, align 1, !dbg !2910
  %call41 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %22, i8 noundef zeroext %23) #3, !dbg !2910
  %call42 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call38, i8 noundef zeroext %call41) #3, !dbg !2910
    #dbg_value(i8 %call42, !2908, !DIExpression(), !2903)
  %call43 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %call35, i8 noundef zeroext %call42) #3, !dbg !2910
  call fastcc void @gf_set_add(ptr noundef nonnull %det, i8 noundef zeroext %call43) #3, !dbg !2910
  %arrayidx44 = getelementptr inbounds nuw i8, ptr %a, i32 1, !dbg !2911
  %24 = load i8, ptr %arrayidx44, align 1, !dbg !2911
  %arrayidx45 = getelementptr inbounds nuw i8, ptr %a, i32 6, !dbg !2911
  %25 = load i8, ptr %arrayidx45, align 1, !dbg !2911
  %call46 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %24, i8 noundef zeroext %25) #3, !dbg !2911
  %arrayidx47 = getelementptr inbounds nuw i8, ptr %a, i32 2, !dbg !2911
  %26 = load i8, ptr %arrayidx47, align 1, !dbg !2911
  %arrayidx48 = getelementptr inbounds nuw i8, ptr %a, i32 5, !dbg !2911
  %27 = load i8, ptr %arrayidx48, align 1, !dbg !2911
  %call49 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %26, i8 noundef zeroext %27) #3, !dbg !2911
  %call50 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call46, i8 noundef zeroext %call49) #3, !dbg !2911
    #dbg_value(i8 %call50, !2907, !DIExpression(), !2903)
  %arrayidx51 = getelementptr inbounds nuw i8, ptr %a, i32 8, !dbg !2911
  %28 = load i8, ptr %arrayidx51, align 1, !dbg !2911
  %arrayidx52 = getelementptr inbounds nuw i8, ptr %a, i32 15, !dbg !2911
  %29 = load i8, ptr %arrayidx52, align 1, !dbg !2911
  %call53 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %28, i8 noundef zeroext %29) #3, !dbg !2911
  %arrayidx54 = getelementptr inbounds nuw i8, ptr %a, i32 11, !dbg !2911
  %30 = load i8, ptr %arrayidx54, align 1, !dbg !2911
  %arrayidx55 = getelementptr inbounds nuw i8, ptr %a, i32 12, !dbg !2911
  %31 = load i8, ptr %arrayidx55, align 1, !dbg !2911
  %call56 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %30, i8 noundef zeroext %31) #3, !dbg !2911
  %call57 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call53, i8 noundef zeroext %call56) #3, !dbg !2911
    #dbg_value(i8 %call57, !2908, !DIExpression(), !2903)
  %call58 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %call50, i8 noundef zeroext %call57) #3, !dbg !2911
  call fastcc void @gf_set_add(ptr noundef nonnull %det, i8 noundef zeroext %call58) #3, !dbg !2911
  %arrayidx59 = getelementptr inbounds nuw i8, ptr %a, i32 1, !dbg !2912
  %32 = load i8, ptr %arrayidx59, align 1, !dbg !2912
  %arrayidx60 = getelementptr inbounds nuw i8, ptr %a, i32 7, !dbg !2912
  %33 = load i8, ptr %arrayidx60, align 1, !dbg !2912
  %call61 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %32, i8 noundef zeroext %33) #3, !dbg !2912
  %arrayidx62 = getelementptr inbounds nuw i8, ptr %a, i32 3, !dbg !2912
  %34 = load i8, ptr %arrayidx62, align 1, !dbg !2912
  %arrayidx63 = getelementptr inbounds nuw i8, ptr %a, i32 5, !dbg !2912
  %35 = load i8, ptr %arrayidx63, align 1, !dbg !2912
  %call64 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %34, i8 noundef zeroext %35) #3, !dbg !2912
  %call65 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call61, i8 noundef zeroext %call64) #3, !dbg !2912
    #dbg_value(i8 %call65, !2907, !DIExpression(), !2903)
  %arrayidx66 = getelementptr inbounds nuw i8, ptr %a, i32 10, !dbg !2912
  %36 = load i8, ptr %arrayidx66, align 1, !dbg !2912
  %arrayidx67 = getelementptr inbounds nuw i8, ptr %a, i32 12, !dbg !2912
  %37 = load i8, ptr %arrayidx67, align 1, !dbg !2912
  %call68 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %36, i8 noundef zeroext %37) #3, !dbg !2912
  %arrayidx69 = getelementptr inbounds nuw i8, ptr %a, i32 8, !dbg !2912
  %38 = load i8, ptr %arrayidx69, align 1, !dbg !2912
  %arrayidx70 = getelementptr inbounds nuw i8, ptr %a, i32 14, !dbg !2912
  %39 = load i8, ptr %arrayidx70, align 1, !dbg !2912
  %call71 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %38, i8 noundef zeroext %39) #3, !dbg !2912
  %call72 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call68, i8 noundef zeroext %call71) #3, !dbg !2912
    #dbg_value(i8 %call72, !2908, !DIExpression(), !2903)
  %call73 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %call65, i8 noundef zeroext %call72) #3, !dbg !2912
  call fastcc void @gf_set_add(ptr noundef nonnull %det, i8 noundef zeroext %call73) #3, !dbg !2912
  %arrayidx74 = getelementptr inbounds nuw i8, ptr %a, i32 2, !dbg !2913
  %40 = load i8, ptr %arrayidx74, align 1, !dbg !2913
  %arrayidx75 = getelementptr inbounds nuw i8, ptr %a, i32 7, !dbg !2913
  %41 = load i8, ptr %arrayidx75, align 1, !dbg !2913
  %call76 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %40, i8 noundef zeroext %41) #3, !dbg !2913
  %arrayidx77 = getelementptr inbounds nuw i8, ptr %a, i32 3, !dbg !2913
  %42 = load i8, ptr %arrayidx77, align 1, !dbg !2913
  %arrayidx78 = getelementptr inbounds nuw i8, ptr %a, i32 6, !dbg !2913
  %43 = load i8, ptr %arrayidx78, align 1, !dbg !2913
  %call79 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %42, i8 noundef zeroext %43) #3, !dbg !2913
  %call80 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call76, i8 noundef zeroext %call79) #3, !dbg !2913
    #dbg_value(i8 %call80, !2907, !DIExpression(), !2903)
  %arrayidx81 = getelementptr inbounds nuw i8, ptr %a, i32 8, !dbg !2913
  %44 = load i8, ptr %arrayidx81, align 1, !dbg !2913
  %arrayidx82 = getelementptr inbounds nuw i8, ptr %a, i32 13, !dbg !2913
  %45 = load i8, ptr %arrayidx82, align 1, !dbg !2913
  %call83 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %44, i8 noundef zeroext %45) #3, !dbg !2913
  %arrayidx84 = getelementptr inbounds nuw i8, ptr %a, i32 9, !dbg !2913
  %46 = load i8, ptr %arrayidx84, align 1, !dbg !2913
  %arrayidx85 = getelementptr inbounds nuw i8, ptr %a, i32 12, !dbg !2913
  %47 = load i8, ptr %arrayidx85, align 1, !dbg !2913
  %call86 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %46, i8 noundef zeroext %47) #3, !dbg !2913
  %call87 = call fastcc zeroext i8 @gf_sub(i8 noundef zeroext %call83, i8 noundef zeroext %call86) #3, !dbg !2913
    #dbg_value(i8 %call87, !2908, !DIExpression(), !2903)
  %call88 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %call80, i8 noundef zeroext %call87) #3, !dbg !2913
  call fastcc void @gf_set_add(ptr noundef nonnull %det, i8 noundef zeroext %call88) #3, !dbg !2913
  %48 = load i8, ptr %det, align 1, !dbg !2914
    #dbg_value(i8 %48, !2904, !DIExpression(), !2903)
  ret i8 %48, !dbg !2915
}

; Function Attrs: nounwind
define dso_local range(i32 -1, 1) i32 @_SNOVA_I_S_AES_ref_pk_expand(ptr noundef %pkx, ptr noundef %pk) local_unnamed_addr #0 !dbg !2916 {
entry:
  %P_matrix = alloca [84720 x i8], align 1
  %P22 = alloca [2000 x i8], align 1
    #dbg_value(ptr %pkx, !2917, !DIExpression(), !2918)
    #dbg_value(ptr %pk, !2919, !DIExpression(), !2918)
  %.b = load i1, ptr @first_time, align 1, !dbg !2920
  br i1 %.b, label %if.end, label %if.then, !dbg !2920

if.then:                                          ; preds = %entry
  call fastcc void @snova_init() #3, !dbg !2922
  br label %if.end, !dbg !2924

if.end:                                           ; preds = %if.then, %entry
  %call = call ptr @memset(ptr noundef %pkx, i32 noundef 0, i32 noundef 86784) #4, !dbg !2925
  %add.ptr = getelementptr inbounds nuw i8, ptr %pkx, i32 86720, !dbg !2926
  %call1 = call ptr @memcpy(ptr noundef nonnull %add.ptr, ptr noundef %pk, i32 noundef 16) #4, !dbg !2927
  %add.ptr2 = getelementptr inbounds nuw i8, ptr %pkx, i32 86736, !dbg !2928
  call void @shake256(ptr noundef nonnull %add.ptr2, i32 noundef 48, ptr noundef %pk, i32 noundef 1016) #3, !dbg !2929
    #dbg_declare(ptr %P_matrix, !2930, !DIExpression(), !2931)
    #dbg_declare(ptr %P22, !2932, !DIExpression(), !2933)
    #dbg_value(ptr %P_matrix, !2934, !DIExpression(), !2918)
  %add.ptr4 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 58320, !dbg !2935
    #dbg_value(ptr %add.ptr4, !2936, !DIExpression(), !2918)
  %add.ptr6 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 69120, !dbg !2937
    #dbg_value(ptr %add.ptr6, !2938, !DIExpression(), !2918)
  %add.ptr8 = getelementptr inbounds nuw i8, ptr %pk, i32 16, !dbg !2939
  %call9 = call fastcc i32 @expand_pk(ptr noundef nonnull %P22, ptr noundef nonnull %add.ptr8) #3, !dbg !2941
  %tobool10.not = icmp eq i32 %call9, 0, !dbg !2941
  br i1 %tobool10.not, label %if.end12, label %return, !dbg !2941

if.end12:                                         ; preds = %if.end
  call void @expand_public(ptr noundef nonnull %P_matrix, ptr noundef %pk) #3, !dbg !2942
    #dbg_value(i32 0, !2943, !DIExpression(), !2945)
  br label %for.cond, !dbg !2946

for.cond:                                         ; preds = %for.inc138, %if.end12
  %mi.0 = phi i32 [ 0, %if.end12 ], [ %inc139, %for.inc138 ], !dbg !2947
    #dbg_value(i32 %mi.0, !2943, !DIExpression(), !2945)
  %exitcond10 = icmp ne i32 %mi.0, 5, !dbg !2948
  br i1 %exitcond10, label %for.cond14.preheader, label %for.end140, !dbg !2950

for.cond14.preheader:                             ; preds = %for.cond
  br label %for.cond14, !dbg !2951

for.cond14:                                       ; preds = %for.cond14.preheader, %for.inc67
  %ni.0 = phi i32 [ %inc68, %for.inc67 ], [ 0, %for.cond14.preheader ], !dbg !2954
    #dbg_value(i32 %ni.0, !2955, !DIExpression(), !2956)
  %exitcond4 = icmp ne i32 %ni.0, 27, !dbg !2957
  br i1 %exitcond4, label %for.cond17.preheader, label %for.cond71.preheader, !dbg !2951

for.cond71.preheader:                             ; preds = %for.cond14
  br label %for.cond71, !dbg !2959

for.cond17.preheader:                             ; preds = %for.cond14
  br label %for.cond17, !dbg !2961

for.cond17:                                       ; preds = %for.cond17.preheader, %for.inc35
  %nj.0 = phi i32 [ %inc36, %for.inc35 ], [ 0, %for.cond17.preheader ], !dbg !2964
    #dbg_value(i32 %nj.0, !2965, !DIExpression(), !2966)
  %exitcond1 = icmp ne i32 %nj.0, 27, !dbg !2967
  br i1 %exitcond1, label %for.cond20.preheader, label %for.cond39.preheader, !dbg !2961

for.cond39.preheader:                             ; preds = %for.cond17
  br label %for.cond39, !dbg !2969

for.cond20.preheader:                             ; preds = %for.cond17
  br label %for.cond20, !dbg !2971

for.cond20:                                       ; preds = %for.cond20.preheader, %for.body22
  %idx.0 = phi i32 [ %inc, %for.body22 ], [ 0, %for.cond20.preheader ], !dbg !2974
    #dbg_value(i32 %idx.0, !2975, !DIExpression(), !2976)
  %exitcond = icmp ne i32 %idx.0, 16, !dbg !2977
  br i1 %exitcond, label %for.body22, label %for.inc35, !dbg !2971

for.body22:                                       ; preds = %for.cond20
  %mul = mul nuw nsw i32 %mi.0, 27, !dbg !2979
  %add = add nuw nsw i32 %mul, %ni.0, !dbg !2980
  %mul23 = mul nuw nsw i32 %add, 27, !dbg !2981
  %add24 = add nuw nsw i32 %mul23, %nj.0, !dbg !2982
  %mul25 = shl nuw nsw i32 %add24, 4, !dbg !2983
  %add26 = or disjoint i32 %mul25, %idx.0, !dbg !2984
  %arrayidx = getelementptr inbounds nuw i8, ptr %P_matrix, i32 %add26, !dbg !2985
  %0 = load i8, ptr %arrayidx, align 1, !dbg !2985
  %1 = shl nuw nsw i32 %mi.0, 10, !dbg !2986
  %2 = shl nuw nsw i32 %ni.0, 5, !dbg !2986
  %mul29 = or disjoint i32 %1, %2, !dbg !2986
  %add30 = or disjoint i32 %mul29, %nj.0, !dbg !2987
  %mul31 = shl nuw nsw i32 %add30, 4, !dbg !2988
  %add33 = or disjoint i32 %mul31, %idx.0, !dbg !2989
  %arrayidx34 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add33, !dbg !2990
  store i8 %0, ptr %arrayidx34, align 1, !dbg !2991
  %inc = add nuw nsw i32 %idx.0, 1, !dbg !2992
    #dbg_value(i32 %inc, !2975, !DIExpression(), !2976)
  br label %for.cond20, !dbg !2993, !llvm.loop !2994

for.inc35:                                        ; preds = %for.cond20
  %inc36 = add nuw nsw i32 %nj.0, 1, !dbg !2996
    #dbg_value(i32 %inc36, !2965, !DIExpression(), !2966)
  br label %for.cond17, !dbg !2997, !llvm.loop !2998

for.cond39:                                       ; preds = %for.cond39.preheader, %for.inc64
  %nj38.0 = phi i32 [ %inc65, %for.inc64 ], [ 27, %for.cond39.preheader ], !dbg !3000
    #dbg_value(i32 %nj38.0, !3001, !DIExpression(), !3002)
  %exitcond3 = icmp ne i32 %nj38.0, 32, !dbg !3003
  br i1 %exitcond3, label %for.cond43.preheader, label %for.inc67, !dbg !2969

for.cond43.preheader:                             ; preds = %for.cond39
  br label %for.cond43, !dbg !3005

for.cond43:                                       ; preds = %for.cond43.preheader, %for.body45
  %idx42.0 = phi i32 [ %inc62, %for.body45 ], [ 0, %for.cond43.preheader ], !dbg !3008
    #dbg_value(i32 %idx42.0, !3009, !DIExpression(), !3010)
  %exitcond2 = icmp ne i32 %idx42.0, 16, !dbg !3011
  br i1 %exitcond2, label %for.body45, label %for.inc64, !dbg !3005

for.body45:                                       ; preds = %for.cond43
  %mul46 = mul nuw nsw i32 %mi.0, 27, !dbg !3013
  %add47 = add nuw nsw i32 %mul46, %ni.0, !dbg !3014
  %mul48 = mul nuw nsw i32 %add47, 5, !dbg !3015
  %sub = add nsw i32 %nj38.0, -27, !dbg !3016
  %add49 = add nuw nsw i32 %mul48, %sub, !dbg !3017
  %mul50 = shl nsw i32 %add49, 4, !dbg !3018
  %add51 = or disjoint i32 %mul50, %idx42.0, !dbg !3019
  %arrayidx52 = getelementptr inbounds i8, ptr %add.ptr4, i32 %add51, !dbg !3020
  %3 = load i8, ptr %arrayidx52, align 1, !dbg !3020
  %4 = shl nuw nsw i32 %mi.0, 10, !dbg !3021
  %5 = shl nuw nsw i32 %ni.0, 5, !dbg !3021
  %mul55 = or disjoint i32 %4, %5, !dbg !3021
  %add56 = or disjoint i32 %mul55, %nj38.0, !dbg !3022
  %mul57 = shl nuw nsw i32 %add56, 4, !dbg !3023
  %add59 = or disjoint i32 %mul57, %idx42.0, !dbg !3024
  %arrayidx60 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add59, !dbg !3025
  store i8 %3, ptr %arrayidx60, align 1, !dbg !3026
  %inc62 = add nuw nsw i32 %idx42.0, 1, !dbg !3027
    #dbg_value(i32 %inc62, !3009, !DIExpression(), !3010)
  br label %for.cond43, !dbg !3028, !llvm.loop !3029

for.inc64:                                        ; preds = %for.cond43
  %inc65 = add nuw nsw i32 %nj38.0, 1, !dbg !3031
    #dbg_value(i32 %inc65, !3001, !DIExpression(), !3002)
  br label %for.cond39, !dbg !3032, !llvm.loop !3033

for.inc67:                                        ; preds = %for.cond39
  %inc68 = add nuw nsw i32 %ni.0, 1, !dbg !3035
    #dbg_value(i32 %inc68, !2955, !DIExpression(), !2956)
  br label %for.cond14, !dbg !3036, !llvm.loop !3037

for.cond71:                                       ; preds = %for.cond71.preheader, %for.inc135
  %ni70.0 = phi i32 [ %inc136, %for.inc135 ], [ 27, %for.cond71.preheader ], !dbg !3039
    #dbg_value(i32 %ni70.0, !3040, !DIExpression(), !3041)
  %exitcond9 = icmp ne i32 %ni70.0, 32, !dbg !3042
  br i1 %exitcond9, label %for.cond75.preheader, label %for.inc138, !dbg !2959

for.cond75.preheader:                             ; preds = %for.cond71
  br label %for.cond75, !dbg !3044

for.cond75:                                       ; preds = %for.cond75.preheader, %for.inc101
  %nj74.0 = phi i32 [ %inc102, %for.inc101 ], [ 0, %for.cond75.preheader ], !dbg !3047
    #dbg_value(i32 %nj74.0, !3048, !DIExpression(), !3049)
  %exitcond6 = icmp ne i32 %nj74.0, 27, !dbg !3050
  br i1 %exitcond6, label %for.cond79.preheader, label %for.cond105.preheader, !dbg !3044

for.cond105.preheader:                            ; preds = %for.cond75
  br label %for.cond105, !dbg !3052

for.cond79.preheader:                             ; preds = %for.cond75
  br label %for.cond79, !dbg !3054

for.cond79:                                       ; preds = %for.cond79.preheader, %for.body81
  %idx78.0 = phi i32 [ %inc99, %for.body81 ], [ 0, %for.cond79.preheader ], !dbg !3057
    #dbg_value(i32 %idx78.0, !3058, !DIExpression(), !3059)
  %exitcond5 = icmp ne i32 %idx78.0, 16, !dbg !3060
  br i1 %exitcond5, label %for.body81, label %for.inc101, !dbg !3054

for.body81:                                       ; preds = %for.cond79
  %mul82 = mul nuw nsw i32 %mi.0, 5, !dbg !3062
  %sub83 = add nsw i32 %ni70.0, -27, !dbg !3063
  %add84 = add nuw nsw i32 %mul82, %sub83, !dbg !3064
  %mul85 = mul nuw nsw i32 %add84, 27, !dbg !3065
  %add86 = add nuw nsw i32 %mul85, %nj74.0, !dbg !3066
  %mul87 = shl nsw i32 %add86, 4, !dbg !3067
  %add88 = or disjoint i32 %mul87, %idx78.0, !dbg !3068
  %arrayidx89 = getelementptr inbounds i8, ptr %add.ptr6, i32 %add88, !dbg !3069
  %6 = load i8, ptr %arrayidx89, align 1, !dbg !3069
  %7 = shl nuw nsw i32 %mi.0, 10, !dbg !3070
  %8 = shl nuw nsw i32 %ni70.0, 5, !dbg !3070
  %mul92 = or disjoint i32 %7, %8, !dbg !3070
  %add93 = or disjoint i32 %mul92, %nj74.0, !dbg !3071
  %mul94 = shl nuw nsw i32 %add93, 4, !dbg !3072
  %add96 = or disjoint i32 %mul94, %idx78.0, !dbg !3073
  %arrayidx97 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add96, !dbg !3074
  store i8 %6, ptr %arrayidx97, align 1, !dbg !3075
  %inc99 = add nuw nsw i32 %idx78.0, 1, !dbg !3076
    #dbg_value(i32 %inc99, !3058, !DIExpression(), !3059)
  br label %for.cond79, !dbg !3077, !llvm.loop !3078

for.inc101:                                       ; preds = %for.cond79
  %inc102 = add nuw nsw i32 %nj74.0, 1, !dbg !3080
    #dbg_value(i32 %inc102, !3048, !DIExpression(), !3049)
  br label %for.cond75, !dbg !3081, !llvm.loop !3082

for.cond105:                                      ; preds = %for.cond105.preheader, %for.inc132
  %nj104.0 = phi i32 [ %inc133, %for.inc132 ], [ 27, %for.cond105.preheader ], !dbg !3084
    #dbg_value(i32 %nj104.0, !3085, !DIExpression(), !3086)
  %exitcond8 = icmp ne i32 %nj104.0, 32, !dbg !3087
  br i1 %exitcond8, label %for.cond109.preheader, label %for.inc135, !dbg !3052

for.cond109.preheader:                            ; preds = %for.cond105
  br label %for.cond109, !dbg !3089

for.cond109:                                      ; preds = %for.cond109.preheader, %for.body111
  %idx108.0 = phi i32 [ %inc130, %for.body111 ], [ 0, %for.cond109.preheader ], !dbg !3092
    #dbg_value(i32 %idx108.0, !3093, !DIExpression(), !3094)
  %exitcond7 = icmp ne i32 %idx108.0, 16, !dbg !3095
  br i1 %exitcond7, label %for.body111, label %for.inc132, !dbg !3089

for.body111:                                      ; preds = %for.cond109
  %mul112 = mul nuw nsw i32 %mi.0, 5, !dbg !3097
  %sub113 = add nuw nsw i32 %ni70.0, 268435429, !dbg !3098
  %add114 = add nuw nsw i32 %mul112, %sub113, !dbg !3099
  %mul115 = mul nuw nsw i32 %add114, 5, !dbg !3100
  %add116 = add nuw nsw i32 %mul115, %nj104.0, !dbg !3101
  %sub117 = shl i32 %add116, 4, !dbg !3102
  %mul118 = add nsw i32 %sub117, -432, !dbg !3102
  %add119 = or disjoint i32 %mul118, %idx108.0, !dbg !3103
  %arrayidx120 = getelementptr inbounds [2000 x i8], ptr %P22, i32 0, i32 %add119, !dbg !3104
  %9 = load i8, ptr %arrayidx120, align 1, !dbg !3104
  %10 = shl nuw nsw i32 %mi.0, 10, !dbg !3105
  %11 = shl nuw nsw i32 %ni70.0, 5, !dbg !3105
  %mul123 = or disjoint i32 %10, %11, !dbg !3105
  %add124 = or disjoint i32 %mul123, %nj104.0, !dbg !3106
  %mul125 = shl nuw nsw i32 %add124, 4, !dbg !3107
  %add127 = or disjoint i32 %mul125, %idx108.0, !dbg !3108
  %arrayidx128 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add127, !dbg !3109
  store i8 %9, ptr %arrayidx128, align 1, !dbg !3110
  %inc130 = add nuw nsw i32 %idx108.0, 1, !dbg !3111
    #dbg_value(i32 %inc130, !3093, !DIExpression(), !3094)
  br label %for.cond109, !dbg !3112, !llvm.loop !3113

for.inc132:                                       ; preds = %for.cond109
  %inc133 = add nuw nsw i32 %nj104.0, 1, !dbg !3115
    #dbg_value(i32 %inc133, !3085, !DIExpression(), !3086)
  br label %for.cond105, !dbg !3116, !llvm.loop !3117

for.inc135:                                       ; preds = %for.cond105
  %inc136 = add nuw nsw i32 %ni70.0, 1, !dbg !3119
    #dbg_value(i32 %inc136, !3040, !DIExpression(), !3041)
  br label %for.cond71, !dbg !3120, !llvm.loop !3121

for.inc138:                                       ; preds = %for.cond71
  %inc139 = add nuw nsw i32 %mi.0, 1, !dbg !3123
    #dbg_value(i32 %inc139, !2943, !DIExpression(), !2945)
  br label %for.cond, !dbg !3124, !llvm.loop !3125

for.end140:                                       ; preds = %for.cond
  %add.ptr142 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 79920, !dbg !3127
    #dbg_value(ptr %add.ptr142, !3128, !DIExpression(), !2918)
  %add.ptr143 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 81840, !dbg !3129
    #dbg_value(ptr %add.ptr143, !3130, !DIExpression(), !2918)
  %add.ptr144 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 83760, !dbg !3131
    #dbg_value(ptr %add.ptr144, !3132, !DIExpression(), !2918)
    #dbg_value(ptr %add.ptr145, !3133, !DIExpression(), !2918)
  %call146 = call ptr @memcpy(ptr noundef nonnull %add.ptr142, ptr noundef nonnull @fixed_abq, i32 noundef 4800) #4, !dbg !3134
    #dbg_value(i32 0, !3135, !DIExpression(), !3137)
  br label %for.cond148, !dbg !3138

for.cond148:                                      ; preds = %for.body150, %for.end140
  %idx147.0 = phi i32 [ 0, %for.end140 ], [ %inc162, %for.body150 ], !dbg !3139
    #dbg_value(i32 %idx147.0, !3135, !DIExpression(), !3137)
  %exitcond11 = icmp ne i32 %idx147.0, 120, !dbg !3140
  br i1 %exitcond11, label %for.body150, label %for.end163, !dbg !3142

for.body150:                                      ; preds = %for.cond148
  %mul151 = shl nuw nsw i32 %idx147.0, 4, !dbg !3143
  %add152 = or disjoint i32 %mul151, 81920, !dbg !3145
  %arrayidx153 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add152, !dbg !3146
  %mul154 = shl nuw nsw i32 %idx147.0, 4, !dbg !3147
  %arrayidx155 = getelementptr inbounds nuw i8, ptr %add.ptr142, i32 %mul154, !dbg !3148
  call fastcc void @be_invertible_by_add_aS(ptr noundef nonnull %arrayidx153, ptr noundef nonnull %arrayidx155, i32 noundef 4, i32 noundef 4) #3, !dbg !3149
  %mul156 = shl nuw nsw i32 %idx147.0, 4, !dbg !3150
  %12 = getelementptr inbounds nuw i8, ptr %pkx, i32 %mul156, !dbg !3151
  %arrayidx158 = getelementptr inbounds nuw i8, ptr %12, i32 83840, !dbg !3151
  %mul159 = shl nuw nsw i32 %idx147.0, 4, !dbg !3152
  %arrayidx160 = getelementptr inbounds nuw i8, ptr %add.ptr143, i32 %mul159, !dbg !3153
  call fastcc void @be_invertible_by_add_aS(ptr noundef nonnull %arrayidx158, ptr noundef nonnull %arrayidx160, i32 noundef 4, i32 noundef 4) #3, !dbg !3154
  %inc162 = add nuw nsw i32 %idx147.0, 1, !dbg !3155
    #dbg_value(i32 %inc162, !3135, !DIExpression(), !3137)
  br label %for.cond148, !dbg !3156, !llvm.loop !3157

for.end163:                                       ; preds = %for.cond148
  %add.ptr145 = getelementptr inbounds nuw i8, ptr %P_matrix, i32 84240, !dbg !3159
  %add.ptr164 = getelementptr inbounds nuw i8, ptr %pkx, i32 85760, !dbg !3160
  %call165 = call ptr @memcpy(ptr noundef nonnull %add.ptr164, ptr noundef nonnull %add.ptr144, i32 noundef 480) #4, !dbg !3161
  %add.ptr166 = getelementptr inbounds nuw i8, ptr %pkx, i32 86240, !dbg !3162
  %call167 = call ptr @memcpy(ptr noundef nonnull %add.ptr166, ptr noundef nonnull %add.ptr145, i32 noundef 480) #4, !dbg !3163
  br label %return, !dbg !3164

return:                                           ; preds = %if.end, %for.end163
  %retval.0 = phi i32 [ 0, %for.end163 ], [ -1, %if.end ], !dbg !2918
  ret i32 %retval.0, !dbg !3165
}

; Function Attrs: nounwind
define internal fastcc range(i32 0, 256) i32 @expand_pk(ptr noundef nonnull %P22, ptr noundef %pk) unnamed_addr #0 !dbg !3166 {
entry:
    #dbg_value(ptr %P22, !3169, !DIExpression(), !3170)
    #dbg_value(ptr %pk, !3171, !DIExpression(), !3170)
  %call = call fastcc i32 @expand_gf(ptr noundef %P22, ptr noundef %pk, i32 noundef 2000) #3, !dbg !3172
  ret i32 %call, !dbg !3173
}

; Function Attrs: nounwind
define dso_local range(i32 -1, 1) i32 @_SNOVA_I_S_AES_ref_verify(ptr noundef %pkx, ptr noundef %sig, ptr noundef %digest, i32 noundef %len_digest) local_unnamed_addr #0 !dbg !3174 {
entry:
  %signature_in_GF = alloca [512 x i8], align 1
  %hash_in_GF = alloca [80 x i8], align 1
  %sum_t0 = alloca [10240 x i8], align 1
  %sum_t1 = alloca [1280 x i8], align 1
  %whipped_sig = alloca [2048 x i8], align 1
  %gf16m_temp1 = alloca [16 x i8], align 1
  %gf16m_temp2 = alloca [16 x i8], align 1
  %sumb = alloca [16 x i8], align 1
  %signed_bytes = alloca [40 x i8], align 1
  %signed_gf = alloca [80 x i8], align 1
    #dbg_value(ptr %pkx, !3177, !DIExpression(), !3178)
    #dbg_value(ptr %sig, !3179, !DIExpression(), !3178)
    #dbg_value(ptr %digest, !3180, !DIExpression(), !3178)
    #dbg_value(i32 %len_digest, !3181, !DIExpression(), !3178)
  %.b = load i1, ptr @first_time, align 1, !dbg !3182
  br i1 %.b, label %if.end, label %if.then, !dbg !3182

if.then:                                          ; preds = %entry
  call fastcc void @snova_init() #3, !dbg !3184
  br label %if.end, !dbg !3186

if.end:                                           ; preds = %if.then, %entry
    #dbg_declare(ptr %signature_in_GF, !3187, !DIExpression(), !3188)
  %call = call fastcc i32 @expand_gf(ptr noundef nonnull %signature_in_GF, ptr noundef %sig, i32 noundef 512) #3, !dbg !3189
  %tobool1.not = icmp eq i32 %call, 0, !dbg !3189
  br i1 %tobool1.not, label %if.end3, label %return, !dbg !3189

if.end3:                                          ; preds = %if.end
    #dbg_declare(ptr %hash_in_GF, !3191, !DIExpression(), !3192)
  call void @snova_memset(ptr %hash_in_GF, i8 0, i32 80), !dbg !3192
    #dbg_declare(ptr %sum_t0, !3193, !DIExpression(), !3197)
  call void @snova_memset(ptr %sum_t0, i8 0, i32 10240), !dbg !3197
    #dbg_declare(ptr %sum_t1, !3198, !DIExpression(), !3199)
  call void @snova_memset(ptr %sum_t1, i8 0, i32 1280), !dbg !3199
    #dbg_declare(ptr %whipped_sig, !3200, !DIExpression(), !3204)
  call void @snova_memset(ptr %whipped_sig, i8 0, i32 2048), !dbg !3204
    #dbg_value(i32 0, !3205, !DIExpression(), !3207)
  br label %for.cond, !dbg !3208

for.cond:                                         ; preds = %for.inc40, %if.end3
  %ab.0 = phi i32 [ 0, %if.end3 ], [ %inc41, %for.inc40 ], !dbg !3209
    #dbg_value(i32 %ab.0, !3205, !DIExpression(), !3207)
  %exitcond4 = icmp ne i32 %ab.0, 4, !dbg !3210
  br i1 %exitcond4, label %for.cond4.preheader, label %for.cond43.preheader, !dbg !3212

for.cond4.preheader:                              ; preds = %for.cond
  br label %for.cond4, !dbg !3213

for.cond43.preheader:                             ; preds = %for.cond
  br label %for.cond43, !dbg !3215

for.cond4:                                        ; preds = %for.cond4.preheader, %for.inc37
  %idx.0 = phi i32 [ %inc38, %for.inc37 ], [ 0, %for.cond4.preheader ], !dbg !3217
    #dbg_value(i32 %idx.0, !3218, !DIExpression(), !3219)
  %exitcond3 = icmp ne i32 %idx.0, 32, !dbg !3220
  br i1 %exitcond3, label %for.cond7.preheader, label %for.inc40, !dbg !3213

for.cond7.preheader:                              ; preds = %for.cond4
  br label %for.cond7, !dbg !3222

for.cond7:                                        ; preds = %for.cond7.preheader, %for.inc34
  %i1.0 = phi i32 [ %inc35, %for.inc34 ], [ 0, %for.cond7.preheader ], !dbg !3224
    #dbg_value(i32 %i1.0, !3225, !DIExpression(), !3226)
  %exitcond2 = icmp ne i32 %i1.0, 4, !dbg !3227
  br i1 %exitcond2, label %for.cond10.preheader, label %for.inc37, !dbg !3222

for.cond10.preheader:                             ; preds = %for.cond7
  br label %for.cond10, !dbg !3229

for.cond10:                                       ; preds = %for.cond10.preheader, %for.inc31
  %j1.0 = phi i32 [ %inc32, %for.inc31 ], [ 0, %for.cond10.preheader ], !dbg !3231
    #dbg_value(i32 %j1.0, !3232, !DIExpression(), !3233)
  %exitcond1 = icmp ne i32 %j1.0, 4, !dbg !3234
  br i1 %exitcond1, label %for.cond13.preheader, label %for.inc34, !dbg !3229

for.cond13.preheader:                             ; preds = %for.cond10
  br label %for.cond13, !dbg !3236

for.cond13:                                       ; preds = %for.cond13.preheader, %for.body15
  %k1.0 = phi i32 [ %inc, %for.body15 ], [ 0, %for.cond13.preheader ], !dbg !3238
    #dbg_value(i32 %k1.0, !3239, !DIExpression(), !3240)
  %exitcond = icmp ne i32 %k1.0, 4, !dbg !3241
  br i1 %exitcond, label %for.body15, label %for.inc31, !dbg !3236

for.body15:                                       ; preds = %for.cond13
  %0 = shl nuw nsw i32 %ab.0, 9, !dbg !3243
  %1 = shl nuw nsw i32 %idx.0, 4, !dbg !3243
  %mul16 = or disjoint i32 %0, %1, !dbg !3243
  %mul17 = shl nuw nsw i32 %i1.0, 2, !dbg !3244
  %add18 = or disjoint i32 %mul16, %mul17, !dbg !3245
  %add19 = or disjoint i32 %add18, %j1.0, !dbg !3246
  %arrayidx = getelementptr inbounds nuw [2048 x i8], ptr %whipped_sig, i32 0, i32 %add19, !dbg !3247
  %mul20 = shl nuw nsw i32 %ab.0, 4, !dbg !3248
  %mul21 = shl nuw nsw i32 %i1.0, 2, !dbg !3249
  %add22 = or disjoint i32 %mul20, %mul21, !dbg !3250
  %add23 = or disjoint i32 %add22, %k1.0, !dbg !3251
  %arrayidx24 = getelementptr inbounds nuw [64 x i8], ptr @gf_S, i32 0, i32 %add23, !dbg !3252
  %2 = load i8, ptr %arrayidx24, align 1, !dbg !3252
  %mul25 = shl nuw nsw i32 %idx.0, 4, !dbg !3253
  %mul26 = shl nuw nsw i32 %k1.0, 2, !dbg !3254
  %add27 = or disjoint i32 %mul25, %mul26, !dbg !3255
  %add28 = or disjoint i32 %add27, %j1.0, !dbg !3256
  %arrayidx29 = getelementptr inbounds nuw [512 x i8], ptr %signature_in_GF, i32 0, i32 %add28, !dbg !3257
  %3 = load i8, ptr %arrayidx29, align 1, !dbg !3257
  %call30 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %2, i8 noundef zeroext %3) #3, !dbg !3258
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx, i8 noundef zeroext %call30) #3, !dbg !3259
  %inc = add nuw nsw i32 %k1.0, 1, !dbg !3260
    #dbg_value(i32 %inc, !3239, !DIExpression(), !3240)
  br label %for.cond13, !dbg !3261, !llvm.loop !3262

for.inc31:                                        ; preds = %for.cond13
  %inc32 = add nuw nsw i32 %j1.0, 1, !dbg !3264
    #dbg_value(i32 %inc32, !3232, !DIExpression(), !3233)
  br label %for.cond10, !dbg !3265, !llvm.loop !3266

for.inc34:                                        ; preds = %for.cond10
  %inc35 = add nuw nsw i32 %i1.0, 1, !dbg !3268
    #dbg_value(i32 %inc35, !3225, !DIExpression(), !3226)
  br label %for.cond7, !dbg !3269, !llvm.loop !3270

for.inc37:                                        ; preds = %for.cond7
  %inc38 = add nuw nsw i32 %idx.0, 1, !dbg !3272
    #dbg_value(i32 %inc38, !3218, !DIExpression(), !3219)
  br label %for.cond4, !dbg !3273, !llvm.loop !3274

for.inc40:                                        ; preds = %for.cond4
  %inc41 = add nuw nsw i32 %ab.0, 1, !dbg !3276
    #dbg_value(i32 %inc41, !3205, !DIExpression(), !3207)
  br label %for.cond, !dbg !3277, !llvm.loop !3278

for.cond43:                                       ; preds = %for.cond43.preheader, %for.inc148
  %mi.0 = phi i32 [ %inc149, %for.inc148 ], [ 0, %for.cond43.preheader ], !dbg !3280
    #dbg_value(i32 %mi.0, !3281, !DIExpression(), !3282)
  %exitcond14 = icmp ne i32 %mi.0, 5, !dbg !3283
  br i1 %exitcond14, label %for.cond46.preheader, label %for.cond152.preheader, !dbg !3215

for.cond46.preheader:                             ; preds = %for.cond43
  br label %for.cond46, !dbg !3285

for.cond152.preheader:                            ; preds = %for.cond43
  br label %for.cond152, !dbg !3288

for.cond46:                                       ; preds = %for.cond46.preheader, %for.inc78
  %ni.0 = phi i32 [ %inc79, %for.inc78 ], [ 0, %for.cond46.preheader ], !dbg !3290
    #dbg_value(i32 %ni.0, !3291, !DIExpression(), !3292)
  %exitcond7 = icmp ne i32 %ni.0, 32, !dbg !3293
  br i1 %exitcond7, label %for.cond49.preheader, label %for.cond81.preheader, !dbg !3285

for.cond81.preheader:                             ; preds = %for.cond46
  br label %for.cond81, !dbg !3295

for.cond49.preheader:                             ; preds = %for.cond46
  br label %for.cond49, !dbg !3297

for.cond49:                                       ; preds = %for.cond49.preheader, %for.inc75
  %b1.0 = phi i32 [ %inc76, %for.inc75 ], [ 0, %for.cond49.preheader ], !dbg !3299
    #dbg_value(i32 %b1.0, !3300, !DIExpression(), !3301)
  %exitcond6 = icmp ne i32 %b1.0, 4, !dbg !3302
  br i1 %exitcond6, label %for.cond52.preheader, label %for.inc78, !dbg !3297

for.cond52.preheader:                             ; preds = %for.cond49
  br label %for.cond52, !dbg !3304

for.cond52:                                       ; preds = %for.cond52.preheader, %for.body54
  %nj.0 = phi i32 [ %inc73, %for.body54 ], [ 0, %for.cond52.preheader ], !dbg !3306
    #dbg_value(i32 %nj.0, !3307, !DIExpression(), !3308)
  %exitcond5 = icmp ne i32 %nj.0, 32, !dbg !3309
  br i1 %exitcond5, label %for.body54, label %for.inc75, !dbg !3304

for.body54:                                       ; preds = %for.cond52
  %4 = shl nuw nsw i32 %mi.0, 7, !dbg !3311
  %5 = shl nuw nsw i32 %b1.0, 5, !dbg !3311
  %mul57 = or disjoint i32 %4, %5, !dbg !3311
  %add58 = or disjoint i32 %mul57, %ni.0, !dbg !3312
  %mul59 = shl nuw nsw i32 %add58, 4, !dbg !3313
  %arrayidx60 = getelementptr inbounds nuw [10240 x i8], ptr %sum_t0, i32 0, i32 %mul59, !dbg !3314
  %6 = shl nuw nsw i32 %mi.0, 10, !dbg !3315
  %7 = shl nuw nsw i32 %ni.0, 5, !dbg !3315
  %mul63 = or disjoint i32 %6, %7, !dbg !3315
  %add64 = or disjoint i32 %mul63, %nj.0, !dbg !3316
  %mul65 = shl nuw nsw i32 %add64, 4, !dbg !3317
  %arrayidx67 = getelementptr inbounds nuw i8, ptr %pkx, i32 %mul65, !dbg !3318
  %8 = shl nuw nsw i32 %b1.0, 9, !dbg !3319
  %9 = shl nuw nsw i32 %nj.0, 4, !dbg !3319
  %mul70 = or disjoint i32 %8, %9, !dbg !3319
  %arrayidx71 = getelementptr inbounds nuw [2048 x i8], ptr %whipped_sig, i32 0, i32 %mul70, !dbg !3320
  call fastcc void @gf_mat_mul_add16(ptr noundef nonnull %arrayidx60, ptr noundef %arrayidx67, ptr noundef nonnull %arrayidx71) #3, !dbg !3321
  %inc73 = add nuw nsw i32 %nj.0, 1, !dbg !3322
    #dbg_value(i32 %inc73, !3307, !DIExpression(), !3308)
  br label %for.cond52, !dbg !3323, !llvm.loop !3324

for.inc75:                                        ; preds = %for.cond52
  %inc76 = add nuw nsw i32 %b1.0, 1, !dbg !3326
    #dbg_value(i32 %inc76, !3300, !DIExpression(), !3301)
  br label %for.cond49, !dbg !3327, !llvm.loop !3328

for.inc78:                                        ; preds = %for.cond49
  %inc79 = add nuw nsw i32 %ni.0, 1, !dbg !3330
    #dbg_value(i32 %inc79, !3291, !DIExpression(), !3292)
  br label %for.cond46, !dbg !3331, !llvm.loop !3332

for.cond81:                                       ; preds = %for.cond81.preheader, %for.inc145
  %a1.0 = phi i32 [ %inc146, %for.inc145 ], [ 0, %for.cond81.preheader ], !dbg !3334
    #dbg_value(i32 %a1.0, !3335, !DIExpression(), !3336)
  %exitcond13 = icmp ne i32 %a1.0, 4, !dbg !3337
  br i1 %exitcond13, label %for.cond85.preheader, label %for.inc148, !dbg !3295

for.cond85.preheader:                             ; preds = %for.cond81
  br label %for.cond85, !dbg !3339

for.cond85:                                       ; preds = %for.cond85.preheader, %for.inc142
  %b184.0 = phi i32 [ %inc143, %for.inc142 ], [ 0, %for.cond85.preheader ], !dbg !3341
    #dbg_value(i32 %b184.0, !3342, !DIExpression(), !3343)
  %exitcond12 = icmp ne i32 %b184.0, 4, !dbg !3344
  br i1 %exitcond12, label %for.cond89.preheader, label %for.inc145, !dbg !3339

for.cond89.preheader:                             ; preds = %for.cond85
  br label %for.cond89, !dbg !3346

for.cond89:                                       ; preds = %for.cond89.preheader, %for.inc139
  %ni88.0 = phi i32 [ %inc140, %for.inc139 ], [ 0, %for.cond89.preheader ], !dbg !3348
    #dbg_value(i32 %ni88.0, !3349, !DIExpression(), !3350)
  %exitcond11 = icmp ne i32 %ni88.0, 32, !dbg !3351
  br i1 %exitcond11, label %for.cond93.preheader, label %for.inc142, !dbg !3346

for.cond93.preheader:                             ; preds = %for.cond89
  br label %for.cond93, !dbg !3353

for.cond93:                                       ; preds = %for.cond93.preheader, %for.inc136
  %i192.0 = phi i32 [ %inc137, %for.inc136 ], [ 0, %for.cond93.preheader ], !dbg !3355
    #dbg_value(i32 %i192.0, !3356, !DIExpression(), !3357)
  %exitcond10 = icmp ne i32 %i192.0, 4, !dbg !3358
  br i1 %exitcond10, label %for.cond97.preheader, label %for.inc139, !dbg !3353

for.cond97.preheader:                             ; preds = %for.cond93
  br label %for.cond97, !dbg !3360

for.cond97:                                       ; preds = %for.cond97.preheader, %for.inc133
  %j196.0 = phi i32 [ %inc134, %for.inc133 ], [ 0, %for.cond97.preheader ], !dbg !3362
    #dbg_value(i32 %j196.0, !3363, !DIExpression(), !3364)
  %exitcond9 = icmp ne i32 %j196.0, 4, !dbg !3365
  br i1 %exitcond9, label %for.cond101.preheader, label %for.inc136, !dbg !3360

for.cond101.preheader:                            ; preds = %for.cond97
  br label %for.cond101, !dbg !3367

for.cond101:                                      ; preds = %for.cond101.preheader, %for.body103
  %k1100.0 = phi i32 [ %inc131, %for.body103 ], [ 0, %for.cond101.preheader ], !dbg !3369
    #dbg_value(i32 %k1100.0, !3370, !DIExpression(), !3371)
  %exitcond8 = icmp ne i32 %k1100.0, 4, !dbg !3372
  br i1 %exitcond8, label %for.body103, label %for.inc133, !dbg !3367

for.body103:                                      ; preds = %for.cond101
  %mul104 = shl nuw nsw i32 %mi.0, 4, !dbg !3374
  %mul105 = shl nuw nsw i32 %a1.0, 2, !dbg !3375
  %add106 = or disjoint i32 %mul104, %mul105, !dbg !3376
  %add107 = or disjoint i32 %add106, %b184.0, !dbg !3377
  %mul108 = shl nuw nsw i32 %add107, 4, !dbg !3378
  %mul109 = shl nuw nsw i32 %i192.0, 2, !dbg !3379
  %add110 = or disjoint i32 %mul108, %mul109, !dbg !3380
  %add111 = or disjoint i32 %add110, %j196.0, !dbg !3381
  %arrayidx112 = getelementptr inbounds nuw [1280 x i8], ptr %sum_t1, i32 0, i32 %add111, !dbg !3382
  %10 = shl nuw nsw i32 %a1.0, 9, !dbg !3383
  %11 = shl nuw nsw i32 %ni88.0, 4, !dbg !3383
  %mul115 = or disjoint i32 %10, %11, !dbg !3383
  %mul116 = shl nuw nsw i32 %k1100.0, 2, !dbg !3384
  %add117 = or disjoint i32 %mul115, %mul116, !dbg !3385
  %add118 = or disjoint i32 %add117, %i192.0, !dbg !3386
  %arrayidx119 = getelementptr inbounds nuw [2048 x i8], ptr %whipped_sig, i32 0, i32 %add118, !dbg !3387
  %12 = load i8, ptr %arrayidx119, align 1, !dbg !3387
  %13 = shl nuw nsw i32 %mi.0, 7, !dbg !3388
  %14 = shl nuw nsw i32 %b184.0, 5, !dbg !3388
  %mul122 = or disjoint i32 %13, %14, !dbg !3388
  %add123 = or disjoint i32 %mul122, %ni88.0, !dbg !3389
  %mul124 = shl nuw nsw i32 %add123, 4, !dbg !3390
  %mul125 = shl nuw nsw i32 %k1100.0, 2, !dbg !3391
  %add126 = or disjoint i32 %mul124, %mul125, !dbg !3392
  %add127 = or disjoint i32 %add126, %j196.0, !dbg !3393
  %arrayidx128 = getelementptr inbounds nuw [10240 x i8], ptr %sum_t0, i32 0, i32 %add127, !dbg !3394
  %15 = load i8, ptr %arrayidx128, align 1, !dbg !3394
  %call129 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %12, i8 noundef zeroext %15) #3, !dbg !3395
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx112, i8 noundef zeroext %call129) #3, !dbg !3396
  %inc131 = add nuw nsw i32 %k1100.0, 1, !dbg !3397
    #dbg_value(i32 %inc131, !3370, !DIExpression(), !3371)
  br label %for.cond101, !dbg !3398, !llvm.loop !3399

for.inc133:                                       ; preds = %for.cond101
  %inc134 = add nuw nsw i32 %j196.0, 1, !dbg !3401
    #dbg_value(i32 %inc134, !3363, !DIExpression(), !3364)
  br label %for.cond97, !dbg !3402, !llvm.loop !3403

for.inc136:                                       ; preds = %for.cond97
  %inc137 = add nuw nsw i32 %i192.0, 1, !dbg !3405
    #dbg_value(i32 %inc137, !3356, !DIExpression(), !3357)
  br label %for.cond93, !dbg !3406, !llvm.loop !3407

for.inc139:                                       ; preds = %for.cond93
  %inc140 = add nuw nsw i32 %ni88.0, 1, !dbg !3409
    #dbg_value(i32 %inc140, !3349, !DIExpression(), !3350)
  br label %for.cond89, !dbg !3410, !llvm.loop !3411

for.inc142:                                       ; preds = %for.cond89
  %inc143 = add nuw nsw i32 %b184.0, 1, !dbg !3413
    #dbg_value(i32 %inc143, !3342, !DIExpression(), !3343)
  br label %for.cond85, !dbg !3414, !llvm.loop !3415

for.inc145:                                       ; preds = %for.cond85
  %inc146 = add nuw nsw i32 %a1.0, 1, !dbg !3417
    #dbg_value(i32 %inc146, !3335, !DIExpression(), !3336)
  br label %for.cond81, !dbg !3418, !llvm.loop !3419

for.inc148:                                       ; preds = %for.cond81
  %inc149 = add nuw nsw i32 %mi.0, 1, !dbg !3421
    #dbg_value(i32 %inc149, !3281, !DIExpression(), !3282)
  br label %for.cond43, !dbg !3422, !llvm.loop !3423

for.cond152:                                      ; preds = %for.cond152.preheader, %for.inc251
  %mi151.0 = phi i32 [ %inc252, %for.inc251 ], [ 0, %for.cond152.preheader ], !dbg !3425
    #dbg_value(i32 %mi151.0, !3426, !DIExpression(), !3427)
  %exitcond22 = icmp ne i32 %mi151.0, 5, !dbg !3428
  br i1 %exitcond22, label %for.cond155.preheader, label %for.end253, !dbg !3288

for.cond155.preheader:                            ; preds = %for.cond152
  br label %for.cond155, !dbg !3430

for.cond155:                                      ; preds = %for.cond155.preheader, %for.end232
  %alpha.0 = phi i32 [ %inc249, %for.end232 ], [ 0, %for.cond155.preheader ], !dbg !3432
    #dbg_value(i32 %alpha.0, !3433, !DIExpression(), !3434)
  %exitcond21 = icmp ne i32 %alpha.0, 24, !dbg !3435
  br i1 %exitcond21, label %for.body157, label %for.inc251, !dbg !3430

for.body157:                                      ; preds = %for.cond155
  %add158 = add nuw nsw i32 %alpha.0, %mi151.0, !dbg !3437
  %rem = urem i32 %add158, 5, !dbg !3437
    #dbg_value(i32 %rem, !3439, !DIExpression(), !3440)
    #dbg_declare(ptr %gf16m_temp1, !3441, !DIExpression(), !3442)
  call void @snova_memset(ptr %gf16m_temp1, i8 0, i32 16), !dbg !3442
    #dbg_declare(ptr %gf16m_temp2, !3443, !DIExpression(), !3444)
  call void @snova_memset(ptr %gf16m_temp2, i8 0, i32 16), !dbg !3444
    #dbg_value(i32 0, !3445, !DIExpression(), !3447)
  br label %for.cond160, !dbg !3448

for.cond160:                                      ; preds = %for.inc230, %for.body157
  %a1159.0 = phi i32 [ 0, %for.body157 ], [ %inc231, %for.inc230 ], !dbg !3449
    #dbg_value(i32 %a1159.0, !3445, !DIExpression(), !3447)
  %exitcond20 = icmp ne i32 %a1159.0, 4, !dbg !3450
  br i1 %exitcond20, label %for.body162, label %for.end232, !dbg !3452

for.body162:                                      ; preds = %for.cond160
    #dbg_declare(ptr %sumb, !3453, !DIExpression(), !3455)
  call void @snova_memset(ptr %sumb, i8 0, i32 16), !dbg !3455
    #dbg_value(i32 0, !3456, !DIExpression(), !3458)
  br label %for.cond164, !dbg !3459

for.cond164:                                      ; preds = %for.inc200, %for.body162
  %b1163.0 = phi i32 [ 0, %for.body162 ], [ %inc201, %for.inc200 ], !dbg !3460
    #dbg_value(i32 %b1163.0, !3456, !DIExpression(), !3458)
  %exitcond17 = icmp ne i32 %b1163.0, 4, !dbg !3461
  br i1 %exitcond17, label %for.cond168.preheader, label %for.cond204.preheader, !dbg !3463

for.cond204.preheader:                            ; preds = %for.cond164
  br label %for.cond204, !dbg !3464

for.cond168.preheader:                            ; preds = %for.cond164
  br label %for.cond168, !dbg !3466

for.cond168:                                      ; preds = %for.cond168.preheader, %for.inc197
  %i1167.0 = phi i32 [ %inc198, %for.inc197 ], [ 0, %for.cond168.preheader ], !dbg !3468
    #dbg_value(i32 %i1167.0, !3469, !DIExpression(), !3470)
  %exitcond16 = icmp ne i32 %i1167.0, 4, !dbg !3471
  br i1 %exitcond16, label %for.cond172.preheader, label %for.inc200, !dbg !3466

for.cond172.preheader:                            ; preds = %for.cond168
  br label %for.cond172, !dbg !3473

for.cond172:                                      ; preds = %for.cond172.preheader, %for.body174
  %j1171.0 = phi i32 [ %inc195, %for.body174 ], [ 0, %for.cond172.preheader ], !dbg !3475
    #dbg_value(i32 %j1171.0, !3476, !DIExpression(), !3477)
  %exitcond15 = icmp ne i32 %j1171.0, 4, !dbg !3478
  br i1 %exitcond15, label %for.body174, label %for.inc197, !dbg !3473

for.body174:                                      ; preds = %for.cond172
  %mul175 = shl nuw nsw i32 %i1167.0, 2, !dbg !3480
  %add176 = or disjoint i32 %mul175, %j1171.0, !dbg !3481
  %arrayidx177 = getelementptr inbounds nuw [16 x i8], ptr %sumb, i32 0, i32 %add176, !dbg !3482
  %mul178 = shl nuw nsw i32 %rem, 4, !dbg !3483
  %mul179 = shl nuw nsw i32 %a1159.0, 2, !dbg !3484
  %add180 = or disjoint i32 %mul178, %mul179, !dbg !3485
  %add181 = or disjoint i32 %add180, %b1163.0, !dbg !3486
  %mul182 = shl nuw nsw i32 %add181, 4, !dbg !3487
  %mul183 = shl nuw nsw i32 %i1167.0, 2, !dbg !3488
  %add184 = or disjoint i32 %mul182, %mul183, !dbg !3489
  %add185 = or disjoint i32 %add184, %j1171.0, !dbg !3490
  %arrayidx186 = getelementptr inbounds nuw [1280 x i8], ptr %sum_t1, i32 0, i32 %add185, !dbg !3491
  %16 = load i8, ptr %arrayidx186, align 1, !dbg !3491
  %mul187 = mul nuw nsw i32 %mi151.0, 24, !dbg !3492
  %add188 = add nuw nsw i32 %mul187, %alpha.0, !dbg !3493
  %mul189 = shl nuw nsw i32 %add188, 2, !dbg !3494
  %add190 = add nuw nsw i32 %mul189, 86240, !dbg !3495
  %add191 = or disjoint i32 %add190, %b1163.0, !dbg !3496
  %arrayidx192 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add191, !dbg !3497
  %17 = load i8, ptr %arrayidx192, align 1, !dbg !3497
  %call193 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %16, i8 noundef zeroext %17) #3, !dbg !3498
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx177, i8 noundef zeroext %call193) #3, !dbg !3499
  %inc195 = add nuw nsw i32 %j1171.0, 1, !dbg !3500
    #dbg_value(i32 %inc195, !3476, !DIExpression(), !3477)
  br label %for.cond172, !dbg !3501, !llvm.loop !3502

for.inc197:                                       ; preds = %for.cond172
  %inc198 = add nuw nsw i32 %i1167.0, 1, !dbg !3504
    #dbg_value(i32 %inc198, !3469, !DIExpression(), !3470)
  br label %for.cond168, !dbg !3505, !llvm.loop !3506

for.inc200:                                       ; preds = %for.cond168
  %inc201 = add nuw nsw i32 %b1163.0, 1, !dbg !3508
    #dbg_value(i32 %inc201, !3456, !DIExpression(), !3458)
  br label %for.cond164, !dbg !3509, !llvm.loop !3510

for.cond204:                                      ; preds = %for.cond204.preheader, %for.inc227
  %i1203.0 = phi i32 [ %inc228, %for.inc227 ], [ 0, %for.cond204.preheader ], !dbg !3512
    #dbg_value(i32 %i1203.0, !3513, !DIExpression(), !3514)
  %exitcond19 = icmp ne i32 %i1203.0, 4, !dbg !3515
  br i1 %exitcond19, label %for.cond208.preheader, label %for.inc230, !dbg !3464

for.cond208.preheader:                            ; preds = %for.cond204
  br label %for.cond208, !dbg !3517

for.cond208:                                      ; preds = %for.cond208.preheader, %for.body210
  %j1207.0 = phi i32 [ %inc225, %for.body210 ], [ 0, %for.cond208.preheader ], !dbg !3519
    #dbg_value(i32 %j1207.0, !3520, !DIExpression(), !3521)
  %exitcond18 = icmp ne i32 %j1207.0, 4, !dbg !3522
  br i1 %exitcond18, label %for.body210, label %for.inc227, !dbg !3517

for.body210:                                      ; preds = %for.cond208
  %mul211 = shl nuw nsw i32 %i1203.0, 2, !dbg !3524
  %add212 = or disjoint i32 %mul211, %j1207.0, !dbg !3525
  %arrayidx213 = getelementptr inbounds nuw [16 x i8], ptr %gf16m_temp1, i32 0, i32 %add212, !dbg !3526
  %mul214 = shl nuw nsw i32 %i1203.0, 2, !dbg !3527
  %add215 = or disjoint i32 %mul214, %j1207.0, !dbg !3528
  %arrayidx216 = getelementptr inbounds nuw [16 x i8], ptr %sumb, i32 0, i32 %add215, !dbg !3529
  %18 = load i8, ptr %arrayidx216, align 1, !dbg !3529
  %mul217 = mul nuw nsw i32 %mi151.0, 24, !dbg !3530
  %add218 = add nuw nsw i32 %mul217, %alpha.0, !dbg !3531
  %mul219 = shl nuw nsw i32 %add218, 2, !dbg !3532
  %add220 = add nuw nsw i32 %mul219, 85760, !dbg !3533
  %add221 = or disjoint i32 %add220, %a1159.0, !dbg !3534
  %arrayidx222 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add221, !dbg !3535
  %19 = load i8, ptr %arrayidx222, align 1, !dbg !3535
  %call223 = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %18, i8 noundef zeroext %19) #3, !dbg !3536
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx213, i8 noundef zeroext %call223) #3, !dbg !3537
  %inc225 = add nuw nsw i32 %j1207.0, 1, !dbg !3538
    #dbg_value(i32 %inc225, !3520, !DIExpression(), !3521)
  br label %for.cond208, !dbg !3539, !llvm.loop !3540

for.inc227:                                       ; preds = %for.cond208
  %inc228 = add nuw nsw i32 %i1203.0, 1, !dbg !3542
    #dbg_value(i32 %inc228, !3513, !DIExpression(), !3514)
  br label %for.cond204, !dbg !3543, !llvm.loop !3544

for.inc230:                                       ; preds = %for.cond204
  %inc231 = add nuw nsw i32 %a1159.0, 1, !dbg !3546
    #dbg_value(i32 %inc231, !3445, !DIExpression(), !3447)
  br label %for.cond160, !dbg !3547, !llvm.loop !3548

for.end232:                                       ; preds = %for.cond160
  %mul235 = mul nuw nsw i32 %mi151.0, 24, !dbg !3550
  %add236 = add nuw nsw i32 %mul235, %alpha.0, !dbg !3551
  %mul237 = shl nuw nsw i32 %add236, 4, !dbg !3552
  %20 = getelementptr inbounds nuw i8, ptr %pkx, i32 %mul237, !dbg !3553
  %arrayidx239 = getelementptr inbounds nuw i8, ptr %20, i32 83840, !dbg !3553
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %gf16m_temp2, ptr noundef nonnull %gf16m_temp1, ptr noundef nonnull %arrayidx239, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !3554
  %mul240 = shl nuw nsw i32 %mi151.0, 4, !dbg !3555
  %arrayidx241 = getelementptr inbounds nuw [80 x i8], ptr %hash_in_GF, i32 0, i32 %mul240, !dbg !3556
  %mul242 = mul nuw nsw i32 %mi151.0, 24, !dbg !3557
  %add243 = add nuw nsw i32 %mul242, %alpha.0, !dbg !3558
  %mul244 = shl nuw nsw i32 %add243, 4, !dbg !3559
  %add245 = or disjoint i32 %mul244, 81920, !dbg !3560
  %arrayidx246 = getelementptr inbounds nuw i8, ptr %pkx, i32 %add245, !dbg !3561
  call fastcc void @gf_mat_mul_add_lr(ptr noundef nonnull %arrayidx241, ptr noundef nonnull %arrayidx246, ptr noundef nonnull %gf16m_temp2, i32 noundef 4, i32 noundef 4, i32 noundef 4) #3, !dbg !3562
  %inc249 = add nuw nsw i32 %alpha.0, 1, !dbg !3563
    #dbg_value(i32 %inc249, !3433, !DIExpression(), !3434)
  br label %for.cond155, !dbg !3564, !llvm.loop !3565

for.inc251:                                       ; preds = %for.cond155
  %inc252 = add nuw nsw i32 %mi151.0, 1, !dbg !3567
    #dbg_value(i32 %inc252, !3426, !DIExpression(), !3427)
  br label %for.cond152, !dbg !3568, !llvm.loop !3569

for.end253:                                       ; preds = %for.cond152
    #dbg_declare(ptr %signed_bytes, !3571, !DIExpression(), !3572)
    #dbg_declare(ptr %signed_gf, !3573, !DIExpression(), !3575)
  call void @snova_memset(ptr %signed_gf, i8 0, i32 80), !dbg !3575
  %add.ptr254 = getelementptr inbounds nuw i8, ptr %sig, i32 256, !dbg !3576
    #dbg_value(ptr %add.ptr254, !3577, !DIExpression(), !3178)
  %add.ptr256 = getelementptr inbounds nuw i8, ptr %pkx, i32 86736, !dbg !3578
  call fastcc void @hash_combined(ptr noundef nonnull %signed_bytes, ptr noundef %digest, i32 noundef %len_digest, ptr noundef nonnull %add.ptr256, ptr noundef nonnull %add.ptr254) #3, !dbg !3579
  %call259 = call fastcc i32 @expand_gf(ptr noundef nonnull %signed_gf, ptr noundef nonnull %signed_bytes, i32 noundef 80) #3, !dbg !3580
    #dbg_value(i32 0, !3581, !DIExpression(), !3178)
    #dbg_value(i32 0, !3582, !DIExpression(), !3584)
  br label %for.cond260, !dbg !3585

for.cond260:                                      ; preds = %for.inc270, %for.end253
  %i.0 = phi i32 [ 0, %for.end253 ], [ %inc271, %for.inc270 ], !dbg !3586
    #dbg_value(i32 %i.0, !3582, !DIExpression(), !3584)
  %exitcond23 = icmp ne i32 %i.0, 80, !dbg !3587
  br i1 %exitcond23, label %for.body262, label %return.loopexit, !dbg !3589

for.body262:                                      ; preds = %for.cond260
  %arrayidx263 = getelementptr inbounds nuw [80 x i8], ptr %hash_in_GF, i32 0, i32 %i.0, !dbg !3590
  %21 = load i8, ptr %arrayidx263, align 1, !dbg !3590
  %arrayidx264 = getelementptr inbounds nuw [80 x i8], ptr %signed_gf, i32 0, i32 %i.0, !dbg !3593
  %22 = load i8, ptr %arrayidx264, align 1, !dbg !3593
  %cmp266.not = icmp eq i8 %21, %22, !dbg !3594
  br i1 %cmp266.not, label %for.inc270, label %return.loopexit, !dbg !3594

for.inc270:                                       ; preds = %for.body262
  %inc271 = add nuw nsw i32 %i.0, 1, !dbg !3595
    #dbg_value(i32 %inc271, !3582, !DIExpression(), !3584)
  br label %for.cond260, !dbg !3596, !llvm.loop !3597

return.loopexit:                                  ; preds = %for.body262, %for.cond260
  %retval.0.ph = phi i32 [ -1, %for.body262 ], [ 0, %for.cond260 ]
  br label %return, !dbg !3599

return:                                           ; preds = %return.loopexit, %if.end
  %retval.0 = phi i32 [ -1, %if.end ], [ %retval.0.ph, %return.loopexit ], !dbg !3178
  ret i32 %retval.0, !dbg !3599
}

; Function Attrs: nounwind
define internal fastcc void @gf_mat_mul_add16(ptr noundef nonnull %a, ptr noundef %b, ptr noundef nonnull %c) unnamed_addr #0 !dbg !3600 {
entry:
  %sum = alloca i8, align 1
    #dbg_value(ptr %a, !3601, !DIExpression(), !3602)
    #dbg_value(ptr %b, !3603, !DIExpression(), !3602)
    #dbg_value(ptr %c, !3604, !DIExpression(), !3602)
    #dbg_value(i32 0, !3605, !DIExpression(), !3607)
  br label %for.cond, !dbg !3608

for.cond:                                         ; preds = %for.inc16, %entry
  %i1.0 = phi i32 [ 0, %entry ], [ %inc17, %for.inc16 ], !dbg !3609
    #dbg_value(i32 %i1.0, !3605, !DIExpression(), !3607)
  %exitcond2 = icmp ne i32 %i1.0, 4, !dbg !3610
  br i1 %exitcond2, label %for.cond1.preheader, label %for.end18, !dbg !3612

for.cond1.preheader:                              ; preds = %for.cond
  br label %for.cond1, !dbg !3613

for.cond1:                                        ; preds = %for.cond1.preheader, %for.end
  %j1.0 = phi i32 [ %inc14, %for.end ], [ 0, %for.cond1.preheader ], !dbg !3615
    #dbg_value(i32 %j1.0, !3616, !DIExpression(), !3617)
  %exitcond1 = icmp ne i32 %j1.0, 4, !dbg !3618
  br i1 %exitcond1, label %for.body3, label %for.inc16, !dbg !3613

for.body3:                                        ; preds = %for.cond1
    #dbg_value(i8 0, !3620, !DIExpression(), !3622)
  store i8 0, ptr %sum, align 1, !dbg !3623
    #dbg_value(i32 0, !3624, !DIExpression(), !3626)
  br label %for.cond4, !dbg !3627

for.cond4:                                        ; preds = %for.body6, %for.body3
  %k1.0 = phi i32 [ 0, %for.body3 ], [ %inc, %for.body6 ], !dbg !3628
    #dbg_value(i32 %k1.0, !3624, !DIExpression(), !3626)
  %exitcond = icmp ne i32 %k1.0, 4, !dbg !3629
  br i1 %exitcond, label %for.body6, label %for.end, !dbg !3631

for.body6:                                        ; preds = %for.cond4
  %mul = shl nuw nsw i32 %i1.0, 2, !dbg !3632
  %add = or disjoint i32 %mul, %k1.0, !dbg !3634
  %arrayidx = getelementptr inbounds nuw i8, ptr %b, i32 %add, !dbg !3635
  %0 = load i8, ptr %arrayidx, align 1, !dbg !3635
  %mul7 = shl nuw nsw i32 %k1.0, 2, !dbg !3636
  %add8 = or disjoint i32 %mul7, %j1.0, !dbg !3637
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %c, i32 %add8, !dbg !3638
  %1 = load i8, ptr %arrayidx9, align 1, !dbg !3638
  %call = call fastcc zeroext i8 @gf_mult(i8 noundef zeroext %0, i8 noundef zeroext %1) #3, !dbg !3639
    #dbg_value(ptr %sum, !3620, !DIExpression(DW_OP_deref), !3622)
  call fastcc void @gf_set_add(ptr noundef nonnull %sum, i8 noundef zeroext %call) #3, !dbg !3640
  %inc = add nuw nsw i32 %k1.0, 1, !dbg !3641
    #dbg_value(i32 %inc, !3624, !DIExpression(), !3626)
  br label %for.cond4, !dbg !3642, !llvm.loop !3643

for.end:                                          ; preds = %for.cond4
  %mul10 = shl nuw nsw i32 %i1.0, 2, !dbg !3645
  %add11 = or disjoint i32 %mul10, %j1.0, !dbg !3646
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %a, i32 %add11, !dbg !3647
  %2 = load i8, ptr %sum, align 1, !dbg !3648
    #dbg_value(i8 %2, !3620, !DIExpression(), !3622)
  call fastcc void @gf_set_add(ptr noundef nonnull %arrayidx12, i8 noundef zeroext %2) #3, !dbg !3649
  %inc14 = add nuw nsw i32 %j1.0, 1, !dbg !3650
    #dbg_value(i32 %inc14, !3616, !DIExpression(), !3617)
  br label %for.cond1, !dbg !3651, !llvm.loop !3652

for.inc16:                                        ; preds = %for.cond1
  %inc17 = add nuw nsw i32 %i1.0, 1, !dbg !3654
    #dbg_value(i32 %inc17, !3605, !DIExpression(), !3607)
  br label %for.cond, !dbg !3655, !llvm.loop !3656

for.end18:                                        ; preds = %for.cond
  ret void, !dbg !3658
}

; Function Attrs: nounwind
define dso_local void @snova_secure_clear(ptr noundef %ptr, i32 noundef %len) local_unnamed_addr #0 !dbg !3659 {
entry:
    #dbg_value(ptr %ptr, !3663, !DIExpression(), !3664)
    #dbg_value(i32 %len, !3665, !DIExpression(), !3664)
  %call = call ptr @memset(ptr noundef %ptr, i32 noundef 0, i32 noundef %len) #4, !dbg !3666
  ret void, !dbg !3667
}

; Function Attrs: nounwind
define dso_local void @shake128_init(ptr noundef %instance) local_unnamed_addr #0 !dbg !3668 {
entry:
    #dbg_value(ptr %instance, !3676, !DIExpression(), !3677)
  %call = call ptr @memset(ptr noundef %instance, i32 noundef 0, i32 noundef 224) #4, !dbg !3678
  %arrayidx = getelementptr inbounds nuw i8, ptr %instance, i32 208, !dbg !3679
  store i64 168, ptr %arrayidx, align 8, !dbg !3680
  ret void, !dbg !3681
}

; Function Attrs: nounwind
define dso_local void @shake256_init(ptr noundef %instance) local_unnamed_addr #0 !dbg !3682 {
entry:
    #dbg_value(ptr %instance, !3683, !DIExpression(), !3684)
  %call = call ptr @memset(ptr noundef %instance, i32 noundef 0, i32 noundef 224) #4, !dbg !3685
  %arrayidx = getelementptr inbounds nuw i8, ptr %instance, i32 208, !dbg !3686
  store i64 136, ptr %arrayidx, align 8, !dbg !3687
  ret void, !dbg !3688
}

; Function Attrs: nounwind
define dso_local void @shake_absorb(ptr noundef %instance, ptr noundef %in, i32 noundef %inlen) local_unnamed_addr #0 !dbg !3689 {
entry:
    #dbg_value(ptr %instance, !3692, !DIExpression(), !3693)
    #dbg_value(ptr %in, !3694, !DIExpression(), !3693)
    #dbg_value(i32 %inlen, !3695, !DIExpression(), !3693)
  %arrayidx = getelementptr inbounds nuw i8, ptr %instance, i32 208, !dbg !3696
  %0 = load i64, ptr %arrayidx, align 8, !dbg !3696
  %conv = trunc i64 %0 to i32, !dbg !3696
  call fastcc void @keccak_inc_absorb(ptr noundef %instance, i32 noundef %conv, ptr noundef %in, i32 noundef %inlen) #3, !dbg !3697
  ret void, !dbg !3698
}

; Function Attrs: nounwind
define internal fastcc void @keccak_inc_absorb(ptr noundef %s_inc, i32 noundef %r, ptr noundef %m, i32 noundef %mlen) unnamed_addr #0 !dbg !3699 {
entry:
    #dbg_value(ptr %s_inc, !3703, !DIExpression(), !3704)
    #dbg_value(i32 %r, !3705, !DIExpression(), !3704)
    #dbg_value(ptr %m, !3706, !DIExpression(), !3704)
    #dbg_value(i32 %mlen, !3707, !DIExpression(), !3704)
  br label %while.cond, !dbg !3708

while.cond:                                       ; preds = %for.end, %entry
  %m.addr.0 = phi ptr [ %m, %entry ], [ %add.ptr, %for.end ]
  %mlen.addr.0 = phi i32 [ %mlen, %entry ], [ %sub20, %for.end ]
    #dbg_value(i32 %mlen.addr.0, !3707, !DIExpression(), !3704)
    #dbg_value(ptr %m.addr.0, !3706, !DIExpression(), !3704)
  %conv = zext i32 %mlen.addr.0 to i64, !dbg !3709
  %arrayidx = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3710
  %0 = load i64, ptr %arrayidx, align 8, !dbg !3710
  %add = add i64 %0, %conv, !dbg !3711
  %conv1 = zext i32 %r to i64, !dbg !3712
  %cmp.not = icmp ult i64 %add, %conv1, !dbg !3713
  br i1 %cmp.not, label %for.cond25.preheader, label %for.cond.preheader, !dbg !3708

for.cond.preheader:                               ; preds = %while.cond
  br label %for.cond, !dbg !3714

for.cond25.preheader:                             ; preds = %while.cond
  %mlen.addr.0.lcssa1 = phi i32 [ %mlen.addr.0, %while.cond ]
  %m.addr.0.lcssa = phi ptr [ %m.addr.0, %while.cond ]
  %mlen.addr.0.lcssa = phi i32 [ %mlen.addr.0, %while.cond ]
  br label %for.cond25, !dbg !3717

for.cond:                                         ; preds = %for.cond.preheader, %for.body
  %i.0 = phi i32 [ %inc, %for.body ], [ 0, %for.cond.preheader ], !dbg !3719
    #dbg_value(i32 %i.0, !3720, !DIExpression(), !3704)
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3721
  %1 = load i64, ptr %arrayidx3, align 8, !dbg !3721
  %conv4 = trunc i64 %1 to i32, !dbg !3723
  %sub = sub i32 %r, %conv4, !dbg !3724
  %cmp5 = icmp ult i32 %i.0, %sub, !dbg !3725
  br i1 %cmp5, label %for.body, label %for.end, !dbg !3714

for.body:                                         ; preds = %for.cond
  %arrayidx7 = getelementptr inbounds nuw i8, ptr %m.addr.0, i32 %i.0, !dbg !3726
  %2 = load i8, ptr %arrayidx7, align 1, !dbg !3726
  %conv8 = zext i8 %2 to i64, !dbg !3728
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3729
  %3 = load i64, ptr %arrayidx9, align 8, !dbg !3729
  %conv10 = zext i32 %i.0 to i64, !dbg !3730
  %add11 = add i64 %3, %conv10, !dbg !3731
  %and = shl i64 %add11, 3, !dbg !3732
  %mul = and i64 %and, 56, !dbg !3732
  %shl = shl nuw i64 %conv8, %mul, !dbg !3733
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3734
  %4 = load i64, ptr %arrayidx12, align 8, !dbg !3734
  %conv13 = zext i32 %i.0 to i64, !dbg !3735
  %add14 = add i64 %4, %conv13, !dbg !3736
  %shr = lshr i64 %add14, 3, !dbg !3737
  %idxprom = trunc i64 %shr to i32, !dbg !3738
  %arrayidx15 = getelementptr inbounds nuw i64, ptr %s_inc, i32 %idxprom, !dbg !3738
  %5 = load i64, ptr %arrayidx15, align 8, !dbg !3739
  %xor = xor i64 %5, %shl, !dbg !3739
  store i64 %xor, ptr %arrayidx15, align 8, !dbg !3739
  %inc = add nuw i32 %i.0, 1, !dbg !3740
    #dbg_value(i32 %inc, !3720, !DIExpression(), !3704)
  br label %for.cond, !dbg !3741, !llvm.loop !3742

for.end:                                          ; preds = %for.cond
  %arrayidx17 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3744
  %6 = load i64, ptr %arrayidx17, align 8, !dbg !3744
  %7 = trunc i64 %6 to i32, !dbg !3745
  %conv19.neg = sub i32 %7, %r, !dbg !3745
  %sub20 = add i32 %conv19.neg, %mlen.addr.0, !dbg !3746
    #dbg_value(i32 %sub20, !3707, !DIExpression(), !3704)
  %8 = trunc i64 %6 to i32, !dbg !3747
  %idx.ext = sub i32 %r, %8, !dbg !3747
  %add.ptr = getelementptr inbounds nuw i8, ptr %m.addr.0, i32 %idx.ext, !dbg !3747
    #dbg_value(ptr %add.ptr, !3706, !DIExpression(), !3704)
  %arrayidx24 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3748
  store i64 0, ptr %arrayidx24, align 8, !dbg !3749
  call fastcc void @KeccakF1600_StatePermute(ptr noundef nonnull %s_inc) #3, !dbg !3750
  br label %while.cond, !dbg !3708, !llvm.loop !3751

for.cond25:                                       ; preds = %for.cond25.preheader, %for.body28
  %i.1 = phi i32 [ %inc45, %for.body28 ], [ 0, %for.cond25.preheader ], !dbg !3753
    #dbg_value(i32 %i.1, !3720, !DIExpression(), !3704)
  %exitcond = icmp ne i32 %i.1, %mlen.addr.0.lcssa1, !dbg !3754
  br i1 %exitcond, label %for.body28, label %for.end46, !dbg !3717

for.body28:                                       ; preds = %for.cond25
  %arrayidx29 = getelementptr inbounds nuw i8, ptr %m.addr.0.lcssa, i32 %i.1, !dbg !3756
  %9 = load i8, ptr %arrayidx29, align 1, !dbg !3756
  %conv30 = zext i8 %9 to i64, !dbg !3758
  %arrayidx31 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3759
  %10 = load i64, ptr %arrayidx31, align 8, !dbg !3759
  %conv32 = zext i32 %i.1 to i64, !dbg !3760
  %add33 = add i64 %10, %conv32, !dbg !3761
  %and34 = shl i64 %add33, 3, !dbg !3762
  %mul35 = and i64 %and34, 56, !dbg !3762
  %shl36 = shl nuw i64 %conv30, %mul35, !dbg !3763
  %arrayidx37 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3764
  %11 = load i64, ptr %arrayidx37, align 8, !dbg !3764
  %conv38 = zext i32 %i.1 to i64, !dbg !3765
  %add39 = add i64 %11, %conv38, !dbg !3766
  %shr40 = lshr i64 %add39, 3, !dbg !3767
  %idxprom41 = trunc i64 %shr40 to i32, !dbg !3768
  %arrayidx42 = getelementptr inbounds nuw i64, ptr %s_inc, i32 %idxprom41, !dbg !3768
  %12 = load i64, ptr %arrayidx42, align 8, !dbg !3769
  %xor43 = xor i64 %12, %shl36, !dbg !3769
  store i64 %xor43, ptr %arrayidx42, align 8, !dbg !3769
  %inc45 = add i32 %i.1, 1, !dbg !3770
    #dbg_value(i32 %inc45, !3720, !DIExpression(), !3704)
  br label %for.cond25, !dbg !3771, !llvm.loop !3772

for.end46:                                        ; preds = %for.cond25
  %conv47 = zext i32 %mlen.addr.0.lcssa to i64, !dbg !3774
  %arrayidx48 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !3775
  %13 = load i64, ptr %arrayidx48, align 8, !dbg !3776
  %add49 = add i64 %13, %conv47, !dbg !3776
  store i64 %add49, ptr %arrayidx48, align 8, !dbg !3776
  ret void, !dbg !3777
}

; Function Attrs: nounwind
define internal fastcc void @KeccakF1600_StatePermute(ptr noundef %state) unnamed_addr #0 !dbg !3778 {
entry:
    #dbg_value(ptr %state, !3781, !DIExpression(), !3782)
  %0 = load i64, ptr %state, align 8, !dbg !3783
    #dbg_value(i64 %0, !3784, !DIExpression(), !3782)
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %state, i32 8, !dbg !3785
  %1 = load i64, ptr %arrayidx1, align 8, !dbg !3785
    #dbg_value(i64 %1, !3786, !DIExpression(), !3782)
  %arrayidx2 = getelementptr inbounds nuw i8, ptr %state, i32 16, !dbg !3787
  %2 = load i64, ptr %arrayidx2, align 8, !dbg !3787
    #dbg_value(i64 %2, !3788, !DIExpression(), !3782)
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %state, i32 24, !dbg !3789
  %3 = load i64, ptr %arrayidx3, align 8, !dbg !3789
    #dbg_value(i64 %3, !3790, !DIExpression(), !3782)
  %arrayidx4 = getelementptr inbounds nuw i8, ptr %state, i32 32, !dbg !3791
  %4 = load i64, ptr %arrayidx4, align 8, !dbg !3791
    #dbg_value(i64 %4, !3792, !DIExpression(), !3782)
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %state, i32 40, !dbg !3793
  %5 = load i64, ptr %arrayidx5, align 8, !dbg !3793
    #dbg_value(i64 %5, !3794, !DIExpression(), !3782)
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %state, i32 48, !dbg !3795
  %6 = load i64, ptr %arrayidx6, align 8, !dbg !3795
    #dbg_value(i64 %6, !3796, !DIExpression(), !3782)
  %arrayidx7 = getelementptr inbounds nuw i8, ptr %state, i32 56, !dbg !3797
  %7 = load i64, ptr %arrayidx7, align 8, !dbg !3797
    #dbg_value(i64 %7, !3798, !DIExpression(), !3782)
  %arrayidx8 = getelementptr inbounds nuw i8, ptr %state, i32 64, !dbg !3799
  %8 = load i64, ptr %arrayidx8, align 8, !dbg !3799
    #dbg_value(i64 %8, !3800, !DIExpression(), !3782)
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %state, i32 72, !dbg !3801
  %9 = load i64, ptr %arrayidx9, align 8, !dbg !3801
    #dbg_value(i64 %9, !3802, !DIExpression(), !3782)
  %arrayidx10 = getelementptr inbounds nuw i8, ptr %state, i32 80, !dbg !3803
  %10 = load i64, ptr %arrayidx10, align 8, !dbg !3803
    #dbg_value(i64 %10, !3804, !DIExpression(), !3782)
  %arrayidx11 = getelementptr inbounds nuw i8, ptr %state, i32 88, !dbg !3805
  %11 = load i64, ptr %arrayidx11, align 8, !dbg !3805
    #dbg_value(i64 %11, !3806, !DIExpression(), !3782)
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %state, i32 96, !dbg !3807
  %12 = load i64, ptr %arrayidx12, align 8, !dbg !3807
    #dbg_value(i64 %12, !3808, !DIExpression(), !3782)
  %arrayidx13 = getelementptr inbounds nuw i8, ptr %state, i32 104, !dbg !3809
  %13 = load i64, ptr %arrayidx13, align 8, !dbg !3809
    #dbg_value(i64 %13, !3810, !DIExpression(), !3782)
  %arrayidx14 = getelementptr inbounds nuw i8, ptr %state, i32 112, !dbg !3811
  %14 = load i64, ptr %arrayidx14, align 8, !dbg !3811
    #dbg_value(i64 %14, !3812, !DIExpression(), !3782)
  %arrayidx15 = getelementptr inbounds nuw i8, ptr %state, i32 120, !dbg !3813
  %15 = load i64, ptr %arrayidx15, align 8, !dbg !3813
    #dbg_value(i64 %15, !3814, !DIExpression(), !3782)
  %arrayidx16 = getelementptr inbounds nuw i8, ptr %state, i32 128, !dbg !3815
  %16 = load i64, ptr %arrayidx16, align 8, !dbg !3815
    #dbg_value(i64 %16, !3816, !DIExpression(), !3782)
  %arrayidx17 = getelementptr inbounds nuw i8, ptr %state, i32 136, !dbg !3817
  %17 = load i64, ptr %arrayidx17, align 8, !dbg !3817
    #dbg_value(i64 %17, !3818, !DIExpression(), !3782)
  %arrayidx18 = getelementptr inbounds nuw i8, ptr %state, i32 144, !dbg !3819
  %18 = load i64, ptr %arrayidx18, align 8, !dbg !3819
    #dbg_value(i64 %18, !3820, !DIExpression(), !3782)
  %arrayidx19 = getelementptr inbounds nuw i8, ptr %state, i32 152, !dbg !3821
  %19 = load i64, ptr %arrayidx19, align 8, !dbg !3821
    #dbg_value(i64 %19, !3822, !DIExpression(), !3782)
  %arrayidx20 = getelementptr inbounds nuw i8, ptr %state, i32 160, !dbg !3823
  %20 = load i64, ptr %arrayidx20, align 8, !dbg !3823
    #dbg_value(i64 %20, !3824, !DIExpression(), !3782)
  %arrayidx21 = getelementptr inbounds nuw i8, ptr %state, i32 168, !dbg !3825
  %21 = load i64, ptr %arrayidx21, align 8, !dbg !3825
    #dbg_value(i64 %21, !3826, !DIExpression(), !3782)
  %arrayidx22 = getelementptr inbounds nuw i8, ptr %state, i32 176, !dbg !3827
  %22 = load i64, ptr %arrayidx22, align 8, !dbg !3827
    #dbg_value(i64 %22, !3828, !DIExpression(), !3782)
  %arrayidx23 = getelementptr inbounds nuw i8, ptr %state, i32 184, !dbg !3829
  %23 = load i64, ptr %arrayidx23, align 8, !dbg !3829
    #dbg_value(i64 %23, !3830, !DIExpression(), !3782)
  %arrayidx24 = getelementptr inbounds nuw i8, ptr %state, i32 192, !dbg !3831
  %24 = load i64, ptr %arrayidx24, align 8, !dbg !3831
    #dbg_value(i64 %24, !3832, !DIExpression(), !3782)
    #dbg_value(i32 0, !3833, !DIExpression(), !3782)
  br label %for.cond, !dbg !3834

for.cond:                                         ; preds = %for.inc, %entry
  %Aso.0 = phi i64 [ %23, %entry ], [ %xor444, %for.inc ], !dbg !3782
  %Asi.0 = phi i64 [ %22, %entry ], [ %xor441, %for.inc ], !dbg !3782
  %Ase.0 = phi i64 [ %21, %entry ], [ %xor438, %for.inc ], !dbg !3782
  %Asa.0 = phi i64 [ %20, %entry ], [ %xor435, %for.inc ], !dbg !3782
  %Amu.0 = phi i64 [ %19, %entry ], [ %xor412, %for.inc ], !dbg !3782
  %Amo.0 = phi i64 [ %18, %entry ], [ %xor409, %for.inc ], !dbg !3782
  %Ami.0 = phi i64 [ %17, %entry ], [ %xor406, %for.inc ], !dbg !3782
  %Ame.0 = phi i64 [ %16, %entry ], [ %xor403, %for.inc ], !dbg !3782
  %Ama.0 = phi i64 [ %15, %entry ], [ %xor400, %for.inc ], !dbg !3782
  %Aku.0 = phi i64 [ %14, %entry ], [ %xor377, %for.inc ], !dbg !3782
  %Ako.0 = phi i64 [ %13, %entry ], [ %xor374, %for.inc ], !dbg !3782
  %Aki.0 = phi i64 [ %12, %entry ], [ %xor371, %for.inc ], !dbg !3782
  %Ake.0 = phi i64 [ %11, %entry ], [ %xor368, %for.inc ], !dbg !3782
  %Aka.0 = phi i64 [ %10, %entry ], [ %xor365, %for.inc ], !dbg !3782
  %Agu.0 = phi i64 [ %9, %entry ], [ %xor342, %for.inc ], !dbg !3782
  %Ago.0 = phi i64 [ %8, %entry ], [ %xor339, %for.inc ], !dbg !3782
  %Agi.0 = phi i64 [ %7, %entry ], [ %xor336, %for.inc ], !dbg !3782
  %Age.0 = phi i64 [ %6, %entry ], [ %xor333, %for.inc ], !dbg !3782
  %Aga.0 = phi i64 [ %5, %entry ], [ %xor330, %for.inc ], !dbg !3782
  %Abu.0 = phi i64 [ %4, %entry ], [ %xor307, %for.inc ], !dbg !3782
  %Abo.0 = phi i64 [ %3, %entry ], [ %xor304, %for.inc ], !dbg !3782
  %Abi.0 = phi i64 [ %2, %entry ], [ %xor301, %for.inc ], !dbg !3782
  %Abe.0 = phi i64 [ %1, %entry ], [ %xor298, %for.inc ], !dbg !3782
  %Aba.0 = phi i64 [ %0, %entry ], [ %xor295, %for.inc ], !dbg !3782
  %round.0 = phi i32 [ 0, %entry ], [ %add448, %for.inc ], !dbg !3836
  %Asu.0 = phi i64 [ %24, %entry ], [ %xor447, %for.inc ], !dbg !3782
    #dbg_value(i64 %Asu.0, !3832, !DIExpression(), !3782)
    #dbg_value(i32 %round.0, !3833, !DIExpression(), !3782)
    #dbg_value(i64 %Aba.0, !3784, !DIExpression(), !3782)
    #dbg_value(i64 %Abe.0, !3786, !DIExpression(), !3782)
    #dbg_value(i64 %Abi.0, !3788, !DIExpression(), !3782)
    #dbg_value(i64 %Abo.0, !3790, !DIExpression(), !3782)
    #dbg_value(i64 %Abu.0, !3792, !DIExpression(), !3782)
    #dbg_value(i64 %Aga.0, !3794, !DIExpression(), !3782)
    #dbg_value(i64 %Age.0, !3796, !DIExpression(), !3782)
    #dbg_value(i64 %Agi.0, !3798, !DIExpression(), !3782)
    #dbg_value(i64 %Ago.0, !3800, !DIExpression(), !3782)
    #dbg_value(i64 %Agu.0, !3802, !DIExpression(), !3782)
    #dbg_value(i64 %Aka.0, !3804, !DIExpression(), !3782)
    #dbg_value(i64 %Ake.0, !3806, !DIExpression(), !3782)
    #dbg_value(i64 %Aki.0, !3808, !DIExpression(), !3782)
    #dbg_value(i64 %Ako.0, !3810, !DIExpression(), !3782)
    #dbg_value(i64 %Aku.0, !3812, !DIExpression(), !3782)
    #dbg_value(i64 %Ama.0, !3814, !DIExpression(), !3782)
    #dbg_value(i64 %Ame.0, !3816, !DIExpression(), !3782)
    #dbg_value(i64 %Ami.0, !3818, !DIExpression(), !3782)
    #dbg_value(i64 %Amo.0, !3820, !DIExpression(), !3782)
    #dbg_value(i64 %Amu.0, !3822, !DIExpression(), !3782)
    #dbg_value(i64 %Asa.0, !3824, !DIExpression(), !3782)
    #dbg_value(i64 %Ase.0, !3826, !DIExpression(), !3782)
    #dbg_value(i64 %Asi.0, !3828, !DIExpression(), !3782)
    #dbg_value(i64 %Aso.0, !3830, !DIExpression(), !3782)
  %cmp = icmp samesign ult i32 %round.0, 24, !dbg !3837
  br i1 %cmp, label %for.inc, label %for.end, !dbg !3839

for.inc:                                          ; preds = %for.cond
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %Asa.0, i64 %Ama.0, i64 %Aka.0, i64 %Aga.0), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abe.0, i64 %Ase.0, i64 %Ame.0, i64 %Ake.0, i64 %Age.0), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abi.0, i64 %Asi.0, i64 %Ami.0, i64 %Aki.0, i64 %Agi.0), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abo.0, i64 %Aso.0, i64 %Amo.0, i64 %Ako.0, i64 %Ago.0), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abu.0, i64 %Asu.0, i64 %Amu.0, i64 %Aku.0, i64 %Agu.0), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3845, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3846, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3847, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3848, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3849, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3796, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3808, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3820, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3832, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3852, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3790, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3802, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3804, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3816, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3828, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3855, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3857, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3858, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3859, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3786, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3798, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3810, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3822, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3824, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3860, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3862, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3864, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3794, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3818, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3830, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3865, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3867, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3869, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3788, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3812, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3814, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3826, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3870, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3871, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3872, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3874, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_LLVM_arg, 10, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 13, DW_OP_LLVM_arg, 14, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 13, DW_OP_LLVM_arg, 14, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3845, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3846, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3847, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3848, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison), !3849, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3862, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3874, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3786, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3788, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3790, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3859, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3860, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3872, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3794, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3796, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3798, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3802, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3857, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3869, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3870, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3804, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3808, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3810, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3812, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3855, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3867, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison, i64 poison, i64 poison), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3814, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3816, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3818, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3820, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3822, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3852, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3858, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3864, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3865, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3871, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 poison, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3824, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3826, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3828, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3830, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 poison, i64 poison, i64 poison), !3832, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor32 = xor i64 %Abi.0, %Agi.0, !dbg !3875
    #dbg_value(!DIArgList(i64 %xor32, i64 %Asi.0, i64 %Ami.0, i64 %Aki.0), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor33 = xor i64 %xor32, %Aki.0, !dbg !3877
    #dbg_value(!DIArgList(i64 %xor33, i64 %Asi.0, i64 %Ami.0), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor34 = xor i64 %xor33, %Ami.0, !dbg !3878
    #dbg_value(!DIArgList(i64 %xor34, i64 %Asi.0), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor35 = xor i64 %xor34, %Asi.0, !dbg !3879
    #dbg_value(i64 %xor35, !3842, !DIExpression(), !3782)
  %xor40 = xor i64 %Abu.0, %Agu.0, !dbg !3880
    #dbg_value(!DIArgList(i64 %xor40, i64 %Asu.0, i64 %Amu.0, i64 %Aku.0), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor41 = xor i64 %xor40, %Aku.0, !dbg !3881
    #dbg_value(!DIArgList(i64 %xor41, i64 %Asu.0, i64 %Amu.0), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor42 = xor i64 %xor41, %Amu.0, !dbg !3882
    #dbg_value(!DIArgList(i64 %xor42, i64 %Asu.0), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor43 = xor i64 %xor42, %Asu.0, !dbg !3883
    #dbg_value(i64 %xor43, !3844, !DIExpression(), !3782)
  %25 = shl i64 %xor43, 1, !dbg !3884
  %26 = lshr i64 %xor43, 63, !dbg !3884
  %27 = or i64 %25, %26, !dbg !3884
    #dbg_value(!DIArgList(i64 %Ago.0, i64 %xor35, i64 %27), !3800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abo.0, i64 %xor35, i64 %27), !3790, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ako.0, i64 %xor35, i64 %27), !3810, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Amo.0, i64 %xor35, i64 %27), !3820, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aso.0, i64 %xor35, i64 %27), !3830, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor35, i64 %27), !3848, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor57 = xor i64 %xor35, %27, !dbg !3885
    #dbg_value(!DIArgList(i64 %Ago.0, i64 %xor57), !3800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abo.0, i64 %xor57), !3790, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ako.0, i64 %xor57), !3810, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Amo.0, i64 %xor57), !3820, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aso.0, i64 %xor57), !3830, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 %xor57, !3848, !DIExpression(), !3782)
  %xor203 = xor i64 %Ago.0, %xor57, !dbg !3886
    #dbg_value(i64 %xor203, !3800, !DIExpression(), !3782)
  %28 = shl i64 %xor203, 55, !dbg !3887
  %29 = lshr i64 %xor203, 9, !dbg !3887
  %30 = or i64 %28, %29, !dbg !3887
    #dbg_value(i64 %30, !3841, !DIExpression(), !3782)
  %xor28 = xor i64 %Abe.0, %Age.0, !dbg !3888
    #dbg_value(!DIArgList(i64 %xor28, i64 %Ase.0, i64 %Ame.0, i64 %Ake.0), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor29 = xor i64 %xor28, %Ake.0, !dbg !3889
    #dbg_value(!DIArgList(i64 %xor29, i64 %Ase.0, i64 %Ame.0), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor30 = xor i64 %xor29, %Ame.0, !dbg !3890
    #dbg_value(!DIArgList(i64 %xor30, i64 %Ase.0), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor31 = xor i64 %xor30, %Ase.0, !dbg !3891
    #dbg_value(i64 %xor31, !3841, !DIExpression(), !3782)
  %31 = shl i64 %xor31, 1, !dbg !3892
  %32 = lshr i64 %xor31, 63, !dbg !3892
  %33 = or i64 %31, %32, !dbg !3892
    #dbg_value(!DIArgList(i64 %xor43, i64 %33), !3845, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %xor43, i64 %33), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %xor43, i64 %33), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aka.0, i64 %xor43, i64 %33), !3804, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aga.0, i64 %xor43, i64 %33), !3794, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Asa.0, i64 %xor43, i64 %33), !3824, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ama.0, i64 %xor43, i64 %33), !3814, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor45 = xor i64 %xor43, %33, !dbg !3893
    #dbg_value(i64 %xor45, !3845, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %xor45), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %xor45), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aka.0, i64 %xor45), !3804, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aga.0, i64 %xor45), !3794, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Asa.0, i64 %xor45), !3824, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ama.0, i64 %xor45), !3814, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor211 = xor i64 %Ama.0, %xor45, !dbg !3894
    #dbg_value(i64 %xor211, !3814, !DIExpression(), !3782)
  %34 = shl i64 %xor211, 41, !dbg !3895
  %35 = lshr i64 %xor211, 23, !dbg !3895
  %36 = or i64 %34, %35, !dbg !3895
    #dbg_value(i64 %36, !3843, !DIExpression(), !3782)
  %xor36 = xor i64 %Abo.0, %Ago.0, !dbg !3896
    #dbg_value(!DIArgList(i64 %xor36, i64 %Aso.0, i64 %Amo.0, i64 %Ako.0), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor37 = xor i64 %xor36, %Ako.0, !dbg !3897
    #dbg_value(!DIArgList(i64 %xor37, i64 %Aso.0, i64 %Amo.0), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor38 = xor i64 %xor37, %Amo.0, !dbg !3898
    #dbg_value(!DIArgList(i64 %xor38, i64 %Aso.0), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor39 = xor i64 %xor38, %Aso.0, !dbg !3899
    #dbg_value(i64 %xor39, !3843, !DIExpression(), !3782)
  %xor = xor i64 %Aba.0, %Aga.0, !dbg !3900
    #dbg_value(!DIArgList(i64 %xor, i64 %Asa.0, i64 %Ama.0, i64 %Aka.0), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor25 = xor i64 %xor, %Aka.0, !dbg !3901
    #dbg_value(!DIArgList(i64 %xor25, i64 %Asa.0, i64 %Ama.0), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor26 = xor i64 %xor25, %Ama.0, !dbg !3902
    #dbg_value(!DIArgList(i64 %xor26, i64 %Asa.0), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor27 = xor i64 %xor26, %Asa.0, !dbg !3903
    #dbg_value(i64 %xor27, !3840, !DIExpression(), !3782)
  %37 = shl i64 %xor27, 1, !dbg !3904
  %38 = lshr i64 %xor27, 63, !dbg !3904
  %39 = or i64 %37, %38, !dbg !3904
    #dbg_value(!DIArgList(i64 %Agu.0, i64 %xor39, i64 %39), !3802, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abu.0, i64 %xor39, i64 %39), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Asu.0, i64 %xor39, i64 %39), !3832, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Amu.0, i64 %xor39, i64 %39), !3822, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor39, i64 %39), !3849, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aku.0, i64 %xor39, i64 %39), !3812, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor61 = xor i64 %xor39, %39, !dbg !3905
    #dbg_value(!DIArgList(i64 %Agu.0, i64 %xor61), !3802, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abu.0, i64 %xor61), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Asu.0, i64 %xor61), !3832, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Amu.0, i64 %xor61), !3822, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 %xor61, !3849, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %Aku.0, i64 %xor61), !3812, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor207 = xor i64 %Aku.0, %xor61, !dbg !3906
    #dbg_value(i64 %xor207, !3812, !DIExpression(), !3782)
  %40 = shl i64 %xor207, 39, !dbg !3907
  %41 = lshr i64 %xor207, 25, !dbg !3907
  %42 = or i64 %40, %41, !dbg !3907
    #dbg_value(i64 %42, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %30, i64 %36, i64 %42), !3871, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not222 = xor i64 %42, -1, !dbg !3908
    #dbg_value(!DIArgList(i64 %30, i64 %36, i64 %not222), !3871, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and223 = and i64 %36, %not222, !dbg !3909
    #dbg_value(!DIArgList(i64 %30, i64 %and223), !3871, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor224 = xor i64 %30, %and223, !dbg !3910
    #dbg_value(i64 %xor224, !3871, !DIExpression(), !3782)
  %43 = shl i64 %xor39, 1, !dbg !3911
  %44 = lshr i64 %xor39, 63, !dbg !3911
  %45 = or i64 %43, %44, !dbg !3911
    #dbg_value(!DIArgList(i64 %xor31, i64 %45), !3847, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Aki.0, i64 %xor31, i64 %45), !3808, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Agi.0, i64 %xor31, i64 %45), !3798, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abi.0, i64 %xor31, i64 %45), !3788, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Asi.0, i64 %xor31, i64 %45), !3828, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ami.0, i64 %xor31, i64 %45), !3818, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor53 = xor i64 %xor31, %45, !dbg !3912
    #dbg_value(i64 %xor53, !3847, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %Aki.0, i64 %xor53), !3808, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Agi.0, i64 %xor53), !3798, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abi.0, i64 %xor53), !3788, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Asi.0, i64 %xor53), !3828, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ami.0, i64 %xor53), !3818, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor67 = xor i64 %Aki.0, %xor53, !dbg !3913
    #dbg_value(i64 %xor67, !3808, !DIExpression(), !3782)
  %46 = shl i64 %xor67, 43, !dbg !3914
  %47 = lshr i64 %xor67, 21, !dbg !3914
  %48 = or i64 %46, %47, !dbg !3914
    #dbg_value(i64 %48, !3842, !DIExpression(), !3782)
  %49 = shl i64 %xor35, 1, !dbg !3915
  %50 = lshr i64 %xor35, 63, !dbg !3915
  %51 = or i64 %49, %50, !dbg !3915
    #dbg_value(!DIArgList(i64 %xor27, i64 %51), !3846, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Age.0, i64 %xor27, i64 %51), !3796, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abe.0, i64 %xor27, i64 %51), !3786, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ake.0, i64 %xor27, i64 %51), !3806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ame.0, i64 %xor27, i64 %51), !3816, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ase.0, i64 %xor27, i64 %51), !3826, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor49 = xor i64 %xor27, %51, !dbg !3916
    #dbg_value(i64 %xor49, !3846, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %Age.0, i64 %xor49), !3796, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Abe.0, i64 %xor49), !3786, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ake.0, i64 %xor49), !3806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ame.0, i64 %xor49), !3816, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %Ase.0, i64 %xor49), !3826, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor63 = xor i64 %Age.0, %xor49, !dbg !3917
    #dbg_value(i64 %xor63, !3796, !DIExpression(), !3782)
  %52 = shl i64 %xor63, 44, !dbg !3918
  %53 = lshr i64 %xor63, 20, !dbg !3918
  %54 = or i64 %52, %53, !dbg !3918
    #dbg_value(i64 %54, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %48, i64 %xor45, i64 %54), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not = xor i64 %54, -1, !dbg !3919
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %48, i64 %xor45, i64 %not), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and = and i64 %48, %not, !dbg !3920
    #dbg_value(!DIArgList(i64 %Aba.0, i64 %and, i64 %xor45), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %arrayidx80 = getelementptr inbounds nuw [24 x i64], ptr @KeccakF_RoundConstants, i32 0, i32 %round.0, !dbg !3921
  %55 = load i64, ptr %arrayidx80, align 8, !dbg !3921
    #dbg_value(!DIArgList(i64 %and, i64 %Aba.0, i64 %xor45, i64 %55), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %56 = xor i64 %and, %55, !dbg !3922
    #dbg_value(!DIArgList(i64 %56, i64 %Aba.0, i64 %xor45), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor62 = xor i64 %Aba.0, %xor45, !dbg !3923
    #dbg_value(i64 %xor62, !3784, !DIExpression(), !3782)
    #dbg_value(i64 %xor62, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %56, i64 %xor62), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor81 = xor i64 %56, %xor62, !dbg !3922
    #dbg_value(i64 %xor81, !3850, !DIExpression(), !3782)
  %xor94 = xor i64 %Abo.0, %xor57, !dbg !3924
    #dbg_value(i64 %xor94, !3790, !DIExpression(), !3782)
  %57 = shl i64 %xor94, 28, !dbg !3925
  %58 = lshr i64 %xor94, 36, !dbg !3925
  %59 = or i64 %57, %58, !dbg !3925
    #dbg_value(i64 %59, !3840, !DIExpression(), !3782)
  %xor102 = xor i64 %Aka.0, %xor45, !dbg !3926
    #dbg_value(i64 %xor102, !3804, !DIExpression(), !3782)
  %60 = shl i64 %xor102, 3, !dbg !3927
  %61 = lshr i64 %xor102, 61, !dbg !3927
  %62 = or i64 %60, %61, !dbg !3927
    #dbg_value(i64 %62, !3842, !DIExpression(), !3782)
  %xor98 = xor i64 %Agu.0, %xor61, !dbg !3928
    #dbg_value(i64 %xor98, !3802, !DIExpression(), !3782)
  %63 = shl i64 %xor98, 20, !dbg !3929
  %64 = lshr i64 %xor98, 44, !dbg !3929
  %65 = or i64 %63, %64, !dbg !3929
    #dbg_value(i64 %65, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %59, i64 %62, i64 %65), !3855, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not114 = xor i64 %65, -1, !dbg !3930
    #dbg_value(!DIArgList(i64 %59, i64 %62, i64 %not114), !3855, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and115 = and i64 %62, %not114, !dbg !3931
    #dbg_value(!DIArgList(i64 %59, i64 %and115), !3855, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor116 = xor i64 %59, %and115, !dbg !3932
    #dbg_value(i64 %xor116, !3855, !DIExpression(), !3782)
  %xor234 = xor i64 %xor81, %xor116, !dbg !3933
  %xor129 = xor i64 %Abe.0, %xor49, !dbg !3934
    #dbg_value(i64 %xor129, !3786, !DIExpression(), !3782)
  %66 = shl i64 %xor129, 1, !dbg !3935
  %67 = lshr i64 %xor129, 63, !dbg !3935
  %68 = or i64 %66, %67, !dbg !3935
    #dbg_value(i64 %68, !3840, !DIExpression(), !3782)
  %xor137 = xor i64 %Ako.0, %xor57, !dbg !3936
    #dbg_value(i64 %xor137, !3810, !DIExpression(), !3782)
  %69 = shl i64 %xor137, 25, !dbg !3937
  %70 = lshr i64 %xor137, 39, !dbg !3937
  %71 = or i64 %69, %70, !dbg !3937
    #dbg_value(i64 %71, !3842, !DIExpression(), !3782)
  %xor133 = xor i64 %Agi.0, %xor53, !dbg !3938
    #dbg_value(i64 %xor133, !3798, !DIExpression(), !3782)
  %72 = shl i64 %xor133, 6, !dbg !3939
  %73 = lshr i64 %xor133, 58, !dbg !3939
  %74 = or i64 %72, %73, !dbg !3939
    #dbg_value(i64 %74, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %68, i64 %71, i64 %74), !3860, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not149 = xor i64 %74, -1, !dbg !3940
    #dbg_value(!DIArgList(i64 %68, i64 %71, i64 %not149), !3860, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and150 = and i64 %71, %not149, !dbg !3941
    #dbg_value(!DIArgList(i64 %68, i64 %and150), !3860, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor151 = xor i64 %68, %and150, !dbg !3942
    #dbg_value(i64 %xor151, !3860, !DIExpression(), !3782)
  %xor235 = xor i64 %xor234, %xor151, !dbg !3943
  %xor164 = xor i64 %Abu.0, %xor61, !dbg !3944
    #dbg_value(i64 %xor164, !3792, !DIExpression(), !3782)
  %75 = shl i64 %xor164, 27, !dbg !3945
  %76 = lshr i64 %xor164, 37, !dbg !3945
  %77 = or i64 %75, %76, !dbg !3945
    #dbg_value(i64 %77, !3840, !DIExpression(), !3782)
  %xor172 = xor i64 %Ake.0, %xor49, !dbg !3946
    #dbg_value(i64 %xor172, !3806, !DIExpression(), !3782)
  %78 = shl i64 %xor172, 10, !dbg !3947
  %79 = lshr i64 %xor172, 54, !dbg !3947
  %80 = or i64 %78, %79, !dbg !3947
    #dbg_value(i64 %80, !3842, !DIExpression(), !3782)
  %xor168 = xor i64 %Aga.0, %xor45, !dbg !3948
    #dbg_value(i64 %xor168, !3794, !DIExpression(), !3782)
  %81 = shl i64 %xor168, 36, !dbg !3949
  %82 = lshr i64 %xor168, 28, !dbg !3949
  %83 = or i64 %81, %82, !dbg !3949
    #dbg_value(i64 %83, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %77, i64 %80, i64 %83), !3865, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not184 = xor i64 %83, -1, !dbg !3950
    #dbg_value(!DIArgList(i64 %77, i64 %80, i64 %not184), !3865, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and185 = and i64 %80, %not184, !dbg !3951
    #dbg_value(!DIArgList(i64 %77, i64 %and185), !3865, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor186 = xor i64 %77, %and185, !dbg !3952
    #dbg_value(i64 %xor186, !3865, !DIExpression(), !3782)
  %xor236 = xor i64 %xor235, %xor186, !dbg !3953
  %xor199 = xor i64 %Abi.0, %xor53, !dbg !3954
    #dbg_value(i64 %xor199, !3788, !DIExpression(), !3782)
  %84 = shl i64 %xor199, 62, !dbg !3955
  %85 = lshr i64 %xor199, 2, !dbg !3955
  %86 = or i64 %84, %85, !dbg !3955
    #dbg_value(!DIArgList(i64 %86, i64 %42, i64 %30), !3870, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor236, i64 %86, i64 %42, i64 %30), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not219 = xor i64 %30, -1, !dbg !3956
    #dbg_value(!DIArgList(i64 %86, i64 %42, i64 %not219), !3870, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor236, i64 %86, i64 %42, i64 %not219), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and220 = and i64 %42, %not219, !dbg !3957
    #dbg_value(!DIArgList(i64 %86, i64 %and220), !3870, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor236, i64 %86, i64 %and220), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor221 = xor i64 %86, %and220, !dbg !3958
    #dbg_value(i64 %xor221, !3870, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor236, i64 %xor221), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor237 = xor i64 %xor236, %xor221, !dbg !3959
    #dbg_value(i64 %xor237, !3840, !DIExpression(), !3782)
  %xor75 = xor i64 %Asu.0, %xor61, !dbg !3960
    #dbg_value(i64 %xor75, !3832, !DIExpression(), !3782)
  %87 = shl i64 %xor75, 14, !dbg !3961
  %88 = lshr i64 %xor75, 50, !dbg !3961
  %89 = or i64 %87, %88, !dbg !3961
    #dbg_value(i64 %89, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %89, i64 %54, i64 %xor62), !3854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor71 = xor i64 %Amo.0, %xor57, !dbg !3962
    #dbg_value(i64 %xor71, !3820, !DIExpression(), !3782)
  %90 = shl i64 %xor71, 21, !dbg !3963
  %91 = lshr i64 %xor71, 43, !dbg !3963
  %92 = or i64 %90, %91, !dbg !3963
    #dbg_value(i64 %92, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %48, i64 %89, i64 %92), !3852, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %54, i64 %92, i64 %48), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %xor62, i64 %89), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not85 = xor i64 %92, -1, !dbg !3964
    #dbg_value(!DIArgList(i64 %48, i64 %89, i64 %not85), !3852, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and86 = and i64 %89, %not85, !dbg !3965
    #dbg_value(!DIArgList(i64 %48, i64 %and86), !3852, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor87 = xor i64 %48, %and86, !dbg !3966
    #dbg_value(i64 %xor87, !3852, !DIExpression(), !3782)
  %xor110 = xor i64 %Asi.0, %xor53, !dbg !3967
    #dbg_value(i64 %xor110, !3828, !DIExpression(), !3782)
  %93 = shl i64 %xor110, 61, !dbg !3968
  %94 = lshr i64 %xor110, 3, !dbg !3968
  %95 = or i64 %93, %94, !dbg !3968
    #dbg_value(i64 %95, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %95, i64 %65, i64 %59), !3859, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor106 = xor i64 %Ame.0, %xor49, !dbg !3969
    #dbg_value(i64 %xor106, !3816, !DIExpression(), !3782)
  %96 = shl i64 %xor106, 45, !dbg !3970
  %97 = lshr i64 %xor106, 19, !dbg !3970
  %98 = or i64 %96, %97, !dbg !3970
    #dbg_value(i64 %98, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %62, i64 %95, i64 %98), !3857, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %98, i64 %59, i64 %95), !3858, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %65, i64 %98, i64 %62), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not120 = xor i64 %98, -1, !dbg !3971
    #dbg_value(!DIArgList(i64 %62, i64 %95, i64 %not120), !3857, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and121 = and i64 %95, %not120, !dbg !3972
    #dbg_value(!DIArgList(i64 %62, i64 %and121), !3857, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor122 = xor i64 %62, %and121, !dbg !3973
    #dbg_value(i64 %xor122, !3857, !DIExpression(), !3782)
  %xor242 = xor i64 %xor87, %xor122, !dbg !3974
  %xor145 = xor i64 %Asa.0, %xor45, !dbg !3975
    #dbg_value(i64 %xor145, !3824, !DIExpression(), !3782)
  %99 = shl i64 %xor145, 18, !dbg !3976
  %100 = lshr i64 %xor145, 46, !dbg !3976
  %101 = or i64 %99, %100, !dbg !3976
    #dbg_value(i64 %101, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %101, i64 %74, i64 %68), !3864, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor141 = xor i64 %Amu.0, %xor61, !dbg !3977
    #dbg_value(i64 %xor141, !3822, !DIExpression(), !3782)
  %102 = shl i64 %xor141, 8, !dbg !3978
  %103 = lshr i64 %xor141, 56, !dbg !3978
  %104 = or i64 %102, %103, !dbg !3978
    #dbg_value(i64 %104, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %71, i64 %101, i64 %104), !3862, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %74, i64 %104, i64 %71), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %104, i64 %68, i64 %101), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not155 = xor i64 %104, -1, !dbg !3979
    #dbg_value(!DIArgList(i64 %71, i64 %101, i64 %not155), !3862, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and156 = and i64 %101, %not155, !dbg !3980
    #dbg_value(!DIArgList(i64 %71, i64 %and156), !3862, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor157 = xor i64 %71, %and156, !dbg !3981
    #dbg_value(i64 %xor157, !3862, !DIExpression(), !3782)
  %xor243 = xor i64 %xor242, %xor157, !dbg !3982
  %xor180 = xor i64 %Aso.0, %xor57, !dbg !3983
    #dbg_value(i64 %xor180, !3830, !DIExpression(), !3782)
  %105 = shl i64 %xor180, 56, !dbg !3984
  %106 = lshr i64 %xor180, 8, !dbg !3984
  %107 = or i64 %105, %106, !dbg !3984
    #dbg_value(i64 %107, !3844, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %107, i64 %83, i64 %77), !3869, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor176 = xor i64 %Ami.0, %xor53, !dbg !3985
    #dbg_value(i64 %xor176, !3818, !DIExpression(), !3782)
  %108 = shl i64 %xor176, 15, !dbg !3986
  %109 = lshr i64 %xor176, 49, !dbg !3986
  %110 = or i64 %108, %109, !dbg !3986
    #dbg_value(i64 %110, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %80, i64 %107, i64 %110), !3867, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %83, i64 %110, i64 %80), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %110, i64 %77, i64 %107), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %54, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71, i64 %65, i64 %98, i64 %62, i64 %92, i64 %48), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_LLVM_arg, 10, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %not190 = xor i64 %110, -1, !dbg !3987
    #dbg_value(!DIArgList(i64 %80, i64 %107, i64 %not190), !3867, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and191 = and i64 %107, %not190, !dbg !3988
    #dbg_value(!DIArgList(i64 %80, i64 %and191), !3867, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor192 = xor i64 %80, %and191, !dbg !3989
    #dbg_value(i64 %xor192, !3867, !DIExpression(), !3782)
  %xor244 = xor i64 %xor243, %xor192, !dbg !3990
  %xor215 = xor i64 %Ase.0, %xor49, !dbg !3991
    #dbg_value(i64 %xor215, !3826, !DIExpression(), !3782)
  %111 = shl i64 %xor215, 2, !dbg !3992
  %112 = lshr i64 %xor215, 62, !dbg !3992
  %113 = or i64 %111, %112, !dbg !3992
    #dbg_value(!DIArgList(i64 %42, i64 %113, i64 %36), !3872, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %113, i64 %30, i64 %86), !3874, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %36, i64 %86, i64 %113), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor244, i64 %42, i64 %113, i64 %36), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101, i64 %98, i64 %xor62, i64 %89, i64 %59, i64 %95), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 13, DW_OP_LLVM_arg, 14, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %89, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68, i64 %95, i64 %65, i64 %59, i64 %54, i64 %xor62), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 13, DW_OP_LLVM_arg, 14, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not225 = xor i64 %36, -1, !dbg !3993
    #dbg_value(!DIArgList(i64 %42, i64 %113, i64 %not225), !3872, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor244, i64 %42, i64 %113, i64 %not225), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and226 = and i64 %113, %not225, !dbg !3994
    #dbg_value(!DIArgList(i64 %42, i64 %and226), !3872, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor244, i64 %42, i64 %and226), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor227 = xor i64 %42, %and226, !dbg !3995
    #dbg_value(i64 %xor227, !3872, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor244, i64 %xor227), !3842, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor245 = xor i64 %xor244, %xor227, !dbg !3996
    #dbg_value(i64 %xor245, !3842, !DIExpression(), !3782)
  %114 = shl i64 %xor245, 1, !dbg !3997
  %115 = lshr i64 %xor245, 63, !dbg !3997
  %116 = or i64 %114, %115, !dbg !3997
    #dbg_value(!DIArgList(i64 %xor224, i64 %xor237, i64 %116), !3871, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %54, i64 %xor237, i64 %92, i64 %48, i64 %116), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %65, i64 %xor237, i64 %98, i64 %62, i64 %116), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %74, i64 %xor237, i64 %104, i64 %71, i64 %116), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %83, i64 %xor237, i64 %110, i64 %80, i64 %116), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor237, i64 %116), !3846, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor261 = xor i64 %xor237, %116, !dbg !3998
    #dbg_value(!DIArgList(i64 %xor224, i64 %xor261), !3871, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %54, i64 %xor261, i64 %92, i64 %48), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %65, i64 %xor261, i64 %98, i64 %62), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %74, i64 %xor261, i64 %104, i64 %71), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %83, i64 %xor261, i64 %110, i64 %80), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 %xor261, !3846, !DIExpression(), !3782)
  %xor429 = xor i64 %xor224, %xor261, !dbg !3999
    #dbg_value(i64 %xor429, !3871, !DIExpression(), !3782)
  %117 = shl i64 %xor429, 2, !dbg !4000
  %118 = lshr i64 %xor429, 62, !dbg !4000
  %119 = or i64 %117, %118, !dbg !4000
    #dbg_value(i64 %119, !3844, !DIExpression(), !3782)
  %not123 = xor i64 %95, -1, !dbg !4001
    #dbg_value(!DIArgList(i64 %98, i64 %59, i64 %not123), !3858, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101, i64 %98, i64 %xor62, i64 %89, i64 %59, i64 %not123), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 13, DW_OP_LLVM_arg, 14, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and124 = and i64 %59, %not123, !dbg !4002
    #dbg_value(!DIArgList(i64 %98, i64 %and124), !3858, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101, i64 %98, i64 %xor62, i64 %89, i64 %and124), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 13, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor125 = xor i64 %98, %and124, !dbg !4003
    #dbg_value(i64 %xor125, !3858, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101, i64 %xor125, i64 %xor62, i64 %89), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not91 = xor i64 %xor62, -1, !dbg !4004
    #dbg_value(!DIArgList(i64 %89, i64 %54, i64 %not91), !3854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %89, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68, i64 %95, i64 %65, i64 %59, i64 %54, i64 %not91), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 13, DW_OP_LLVM_arg, 14, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and92 = and i64 %54, %not91, !dbg !4005
    #dbg_value(!DIArgList(i64 %89, i64 %and92), !3854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %89, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68, i64 %95, i64 %65, i64 %59, i64 %and92), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 13, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor93 = xor i64 %89, %and92, !dbg !4006
    #dbg_value(i64 %xor93, !3854, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor93, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68, i64 %95, i64 %65, i64 %59), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not126 = xor i64 %59, -1, !dbg !4007
    #dbg_value(!DIArgList(i64 %95, i64 %65, i64 %not126), !3859, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor93, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68, i64 %95, i64 %65, i64 %not126), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and127 = and i64 %65, %not126, !dbg !4008
    #dbg_value(!DIArgList(i64 %95, i64 %and127), !3859, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor93, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68, i64 %95, i64 %and127), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 10, DW_OP_LLVM_arg, 11, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor128 = xor i64 %95, %and127, !dbg !4009
    #dbg_value(i64 %xor128, !3859, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor93, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68, i64 %xor128), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 10, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor250 = xor i64 %xor93, %xor128, !dbg !4010
    #dbg_value(!DIArgList(i64 %xor250, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %68), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not161 = xor i64 %68, -1, !dbg !4011
    #dbg_value(!DIArgList(i64 %101, i64 %74, i64 %not161), !3864, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor250, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %74, i64 %not161), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and162 = and i64 %74, %not161, !dbg !4012
    #dbg_value(!DIArgList(i64 %101, i64 %and162), !3864, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor250, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %101, i64 %and162), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor163 = xor i64 %101, %and162, !dbg !4013
    #dbg_value(i64 %xor163, !3864, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor250, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77, i64 %xor163), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor251 = xor i64 %xor250, %xor163, !dbg !4014
    #dbg_value(!DIArgList(i64 %xor251, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %77), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not196 = xor i64 %77, -1, !dbg !4015
    #dbg_value(!DIArgList(i64 %107, i64 %83, i64 %not196), !3869, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor251, i64 %113, i64 %30, i64 %86, i64 %107, i64 %83, i64 %not196), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and197 = and i64 %83, %not196, !dbg !4016
    #dbg_value(!DIArgList(i64 %107, i64 %and197), !3869, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor251, i64 %113, i64 %30, i64 %86, i64 %107, i64 %and197), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor198 = xor i64 %107, %and197, !dbg !4017
    #dbg_value(i64 %xor198, !3869, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor251, i64 %113, i64 %30, i64 %86, i64 %xor198), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor252 = xor i64 %xor251, %xor198, !dbg !4018
    #dbg_value(!DIArgList(i64 %xor252, i64 %113, i64 %30, i64 %86), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not231 = xor i64 %86, -1, !dbg !4019
    #dbg_value(!DIArgList(i64 %113, i64 %30, i64 %not231), !3874, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor252, i64 %113, i64 %30, i64 %not231), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %and232 = and i64 %30, %not231, !dbg !4020
    #dbg_value(!DIArgList(i64 %113, i64 %and232), !3874, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor252, i64 %113, i64 %and232), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor233 = xor i64 %113, %and232, !dbg !4021
    #dbg_value(i64 %xor233, !3874, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor252, i64 %xor233), !3844, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor253 = xor i64 %xor252, %xor233, !dbg !4022
    #dbg_value(i64 %xor253, !3844, !DIExpression(), !3782)
  %120 = shl i64 %xor253, 1, !dbg !4023
  %121 = lshr i64 %xor253, 63, !dbg !4023
  %122 = or i64 %120, %121, !dbg !4023
    #dbg_value(!DIArgList(i64 %xor125, i64 %xor245, i64 %122), !3858, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %xor245, i64 %xor62, i64 %89, i64 %122), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %104, i64 %xor245, i64 %68, i64 %101, i64 %122), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %110, i64 %xor245, i64 %77, i64 %107, i64 %122), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %36, i64 %xor245, i64 %86, i64 %113, i64 %122), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor245, i64 %122), !3848, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor269 = xor i64 %xor245, %122, !dbg !4024
    #dbg_value(!DIArgList(i64 %xor125, i64 %xor269), !3858, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %xor269, i64 %xor62, i64 %89), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %104, i64 %xor269, i64 %68, i64 %101), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %110, i64 %xor269, i64 %77, i64 %107), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %36, i64 %xor269, i64 %86, i64 %113), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 %xor269, !3848, !DIExpression(), !3782)
  %xor417 = xor i64 %xor125, %xor269, !dbg !4025
    #dbg_value(i64 %xor417, !3858, !DIExpression(), !3782)
  %123 = shl i64 %xor417, 55, !dbg !4026
  %124 = lshr i64 %xor417, 9, !dbg !4026
  %125 = or i64 %123, %124, !dbg !4026
    #dbg_value(i64 %125, !3841, !DIExpression(), !3782)
  %not82 = xor i64 %48, -1, !dbg !4027
    #dbg_value(!DIArgList(i64 %54, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71, i64 %65, i64 %98, i64 %62, i64 %92, i64 %not82), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_LLVM_arg, 10, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %54, i64 %xor261, i64 %92, i64 %not82), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and83 = and i64 %92, %not82, !dbg !4028
    #dbg_value(!DIArgList(i64 %54, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71, i64 %65, i64 %98, i64 %62, i64 %and83), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_xor, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_LLVM_arg, 10, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %54, i64 %xor261, i64 %and83), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor84 = xor i64 %54, %and83, !dbg !4029
    #dbg_value(!DIArgList(i64 %xor84, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71, i64 %65, i64 %98, i64 %62), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_LLVM_arg, 10, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor84, i64 %xor261), !3851, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %not117 = xor i64 %62, -1, !dbg !4030
    #dbg_value(!DIArgList(i64 %xor84, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71, i64 %65, i64 %98, i64 %not117), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_LLVM_arg, 10, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %65, i64 %xor261, i64 %98, i64 %not117), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and118 = and i64 %98, %not117, !dbg !4031
    #dbg_value(!DIArgList(i64 %xor84, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71, i64 %65, i64 %and118), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %65, i64 %xor261, i64 %and118), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor119 = xor i64 %65, %and118, !dbg !4032
    #dbg_value(!DIArgList(i64 %xor84, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71, i64 %xor119), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 8, DW_OP_xor, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor119, i64 %xor261), !3856, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor238 = xor i64 %xor84, %xor119, !dbg !4033
    #dbg_value(!DIArgList(i64 %xor238, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %71), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %not152 = xor i64 %71, -1, !dbg !4034
    #dbg_value(!DIArgList(i64 %xor238, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %104, i64 %not152), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_LLVM_arg, 7, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %74, i64 %xor261, i64 %104, i64 %not152), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and153 = and i64 %104, %not152, !dbg !4035
    #dbg_value(!DIArgList(i64 %xor238, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %74, i64 %and153), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %74, i64 %xor261, i64 %and153), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor154 = xor i64 %74, %and153, !dbg !4036
    #dbg_value(!DIArgList(i64 %xor238, i64 %xor224, i64 %83, i64 %110, i64 %80, i64 %xor154), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 5, DW_OP_xor, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor154, i64 %xor261), !3861, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor239 = xor i64 %xor238, %xor154, !dbg !4037
    #dbg_value(!DIArgList(i64 %xor239, i64 %xor224, i64 %83, i64 %110, i64 %80), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %not187 = xor i64 %80, -1, !dbg !4038
    #dbg_value(!DIArgList(i64 %xor239, i64 %xor224, i64 %83, i64 %110, i64 %not187), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_LLVM_arg, 4, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %83, i64 %xor261, i64 %110, i64 %not187), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and188 = and i64 %110, %not187, !dbg !4039
    #dbg_value(!DIArgList(i64 %xor239, i64 %xor224, i64 %83, i64 %and188), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %83, i64 %xor261, i64 %and188), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor189 = xor i64 %83, %and188, !dbg !4040
    #dbg_value(!DIArgList(i64 %xor239, i64 %xor224, i64 %xor189), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor189, i64 %xor261), !3866, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor240 = xor i64 %xor239, %xor189, !dbg !4041
    #dbg_value(!DIArgList(i64 %xor240, i64 %xor224), !3841, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor241 = xor i64 %xor240, %xor224, !dbg !4042
    #dbg_value(i64 %xor241, !3841, !DIExpression(), !3782)
  %not88 = xor i64 %89, -1, !dbg !4043
    #dbg_value(!DIArgList(i64 %92, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101, i64 %xor125, i64 %xor62, i64 %not88), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_LLVM_arg, 12, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %xor269, i64 %xor62, i64 %not88), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and89 = and i64 %xor62, %not88, !dbg !4044
    #dbg_value(!DIArgList(i64 %92, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101, i64 %xor125, i64 %and89), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 11, DW_OP_xor, DW_OP_LLVM_arg, 10, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %92, i64 %xor269, i64 %and89), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor90 = xor i64 %92, %and89, !dbg !4045
    #dbg_value(!DIArgList(i64 %xor90, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101, i64 %xor125), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 10, DW_OP_xor, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor90, i64 %xor269), !3853, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor246 = xor i64 %xor90, %xor125, !dbg !4046
    #dbg_value(!DIArgList(i64 %xor246, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %101), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not158 = xor i64 %101, -1, !dbg !4047
    #dbg_value(!DIArgList(i64 %xor246, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %68, i64 %not158), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_LLVM_arg, 9, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %104, i64 %xor269, i64 %68, i64 %not158), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and159 = and i64 %68, %not158, !dbg !4048
    #dbg_value(!DIArgList(i64 %xor246, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %104, i64 %and159), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_LLVM_arg, 8, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %104, i64 %xor269, i64 %and159), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor160 = xor i64 %104, %and159, !dbg !4049
    #dbg_value(!DIArgList(i64 %xor246, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107, i64 %xor160), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 7, DW_OP_xor, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor160, i64 %xor269), !3863, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor247 = xor i64 %xor246, %xor160, !dbg !4050
    #dbg_value(!DIArgList(i64 %xor247, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %107), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not193 = xor i64 %107, -1, !dbg !4051
    #dbg_value(!DIArgList(i64 %xor247, i64 %36, i64 %86, i64 %113, i64 %110, i64 %77, i64 %not193), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_LLVM_arg, 6, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %110, i64 %xor269, i64 %77, i64 %not193), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and194 = and i64 %77, %not193, !dbg !4052
    #dbg_value(!DIArgList(i64 %xor247, i64 %36, i64 %86, i64 %113, i64 %110, i64 %and194), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_LLVM_arg, 5, DW_OP_xor, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %110, i64 %xor269, i64 %and194), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor195 = xor i64 %110, %and194, !dbg !4053
    #dbg_value(!DIArgList(i64 %xor247, i64 %36, i64 %86, i64 %113, i64 %xor195), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 4, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor195, i64 %xor269), !3868, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor248 = xor i64 %xor247, %xor195, !dbg !4054
    #dbg_value(!DIArgList(i64 %xor248, i64 %36, i64 %86, i64 %113), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %not228 = xor i64 %113, -1, !dbg !4055
    #dbg_value(!DIArgList(i64 %xor248, i64 %36, i64 %86, i64 %not228), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %36, i64 %xor269, i64 %86, i64 %not228), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and229 = and i64 %86, %not228, !dbg !4056
    #dbg_value(!DIArgList(i64 %xor248, i64 %36, i64 %and229), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %36, i64 %xor269, i64 %and229), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor230 = xor i64 %36, %and229, !dbg !4057
    #dbg_value(!DIArgList(i64 %xor248, i64 %xor230), !3843, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor230, i64 %xor269), !3873, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor249 = xor i64 %xor248, %xor230, !dbg !4058
    #dbg_value(i64 %xor249, !3843, !DIExpression(), !3782)
  %126 = shl i64 %xor249, 1, !dbg !4059
  %127 = lshr i64 %xor249, 63, !dbg !4059
  %128 = or i64 %126, %127, !dbg !4059
    #dbg_value(!DIArgList(i64 %xor241, i64 %128), !3847, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor87, i64 %xor241, i64 %128), !3852, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor192, i64 %xor241, i64 %128), !3867, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor122, i64 %xor241, i64 %128), !3857, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor227, i64 %xor241, i64 %128), !3872, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor157, i64 %xor241, i64 %128), !3862, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor265 = xor i64 %xor241, %128, !dbg !4060
    #dbg_value(i64 %xor265, !3847, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor87, i64 %xor265), !3852, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor192, i64 %xor265), !3867, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor122, i64 %xor265), !3857, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor227, i64 %xor265), !3872, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor157, i64 %xor265), !3862, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor413 = xor i64 %xor87, %xor265, !dbg !4061
    #dbg_value(i64 %xor413, !3852, !DIExpression(), !3782)
  %129 = shl i64 %xor413, 62, !dbg !4062
  %130 = lshr i64 %xor413, 2, !dbg !4062
  %131 = or i64 %129, %130, !dbg !4062
    #dbg_value(i64 %131, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %119, i64 %125, i64 %131), !3832, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not445 = xor i64 %131, -1, !dbg !4063
    #dbg_value(!DIArgList(i64 %119, i64 %125, i64 %not445), !3832, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and446 = and i64 %125, %not445, !dbg !4064
    #dbg_value(!DIArgList(i64 %119, i64 %and446), !3832, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor447 = xor i64 %119, %and446, !dbg !4065
    #dbg_value(i64 %xor447, !3832, !DIExpression(), !3782)
  %132 = shl i64 %xor241, 1, !dbg !4066
  %133 = lshr i64 %xor241, 63, !dbg !4066
  %134 = or i64 %132, %133, !dbg !4066
    #dbg_value(!DIArgList(i64 %xor253, i64 %134), !3845, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor116, i64 %xor253, i64 %134), !3855, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor221, i64 %xor253, i64 %134), !3870, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor151, i64 %xor253, i64 %134), !3860, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor81, i64 %xor253, i64 %134), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor81, i64 %xor253, i64 %134), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor186, i64 %xor253, i64 %134), !3865, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor257 = xor i64 %xor253, %134, !dbg !4067
    #dbg_value(i64 %xor257, !3845, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor116, i64 %xor257), !3855, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor221, i64 %xor257), !3870, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor151, i64 %xor257), !3860, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor81, i64 %xor257), !3840, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor81, i64 %xor257), !3850, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor186, i64 %xor257), !3865, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor425 = xor i64 %xor186, %xor257, !dbg !4068
    #dbg_value(i64 %xor425, !3865, !DIExpression(), !3782)
  %135 = shl i64 %xor425, 41, !dbg !4069
  %136 = lshr i64 %xor425, 23, !dbg !4069
  %137 = or i64 %135, %136, !dbg !4069
    #dbg_value(i64 %137, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %137, i64 %131, i64 %119), !3830, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not442 = xor i64 %119, -1, !dbg !4070
    #dbg_value(!DIArgList(i64 %137, i64 %131, i64 %not442), !3830, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and443 = and i64 %131, %not442, !dbg !4071
    #dbg_value(!DIArgList(i64 %137, i64 %and443), !3830, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor444 = xor i64 %137, %and443, !dbg !4072
    #dbg_value(i64 %xor444, !3830, !DIExpression(), !3782)
  %138 = shl i64 %xor237, 1, !dbg !4073
  %139 = lshr i64 %xor237, 63, !dbg !4073
  %140 = or i64 %138, %139, !dbg !4073
    #dbg_value(!DIArgList(i64 %xor93, i64 %xor249, i64 %140), !3854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor198, i64 %xor249, i64 %140), !3869, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor128, i64 %xor249, i64 %140), !3859, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor233, i64 %xor249, i64 %140), !3874, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor249, i64 %140), !3849, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor163, i64 %xor249, i64 %140), !3864, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor273 = xor i64 %xor249, %140, !dbg !4074
    #dbg_value(!DIArgList(i64 %xor93, i64 %xor273), !3854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor198, i64 %xor273), !3869, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor128, i64 %xor273), !3859, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor233, i64 %xor273), !3874, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(i64 %xor273, !3849, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %xor163, i64 %xor273), !3864, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor421 = xor i64 %xor163, %xor273, !dbg !4075
    #dbg_value(i64 %xor421, !3864, !DIExpression(), !3782)
  %141 = shl i64 %xor421, 39, !dbg !4076
  %142 = lshr i64 %xor421, 25, !dbg !4076
  %143 = or i64 %141, %142, !dbg !4076
    #dbg_value(i64 %143, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %143, i64 %119, i64 %137), !3828, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %125, i64 %137, i64 %143), !3826, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %131, i64 %143, i64 %125), !3824, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not439 = xor i64 %137, -1, !dbg !4077
    #dbg_value(!DIArgList(i64 %143, i64 %119, i64 %not439), !3828, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and440 = and i64 %119, %not439, !dbg !4078
    #dbg_value(!DIArgList(i64 %143, i64 %and440), !3828, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor441 = xor i64 %143, %and440, !dbg !4079
    #dbg_value(i64 %xor441, !3828, !DIExpression(), !3782)
  %not436 = xor i64 %143, -1, !dbg !4080
    #dbg_value(!DIArgList(i64 %125, i64 %137, i64 %not436), !3826, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and437 = and i64 %137, %not436, !dbg !4081
    #dbg_value(!DIArgList(i64 %125, i64 %and437), !3826, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor438 = xor i64 %125, %and437, !dbg !4082
    #dbg_value(i64 %xor438, !3826, !DIExpression(), !3782)
  %not433 = xor i64 %125, -1, !dbg !4083
    #dbg_value(!DIArgList(i64 %131, i64 %143, i64 %not433), !3824, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and434 = and i64 %143, %not433, !dbg !4084
    #dbg_value(!DIArgList(i64 %131, i64 %and434), !3824, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor435 = xor i64 %131, %and434, !dbg !4085
    #dbg_value(i64 %xor435, !3824, !DIExpression(), !3782)
  %xor394 = xor i64 %xor230, %xor269, !dbg !4086
    #dbg_value(i64 %xor394, !3873, !DIExpression(), !3782)
  %144 = shl i64 %xor394, 56, !dbg !4087
  %145 = lshr i64 %xor394, 8, !dbg !4087
  %146 = or i64 %144, %145, !dbg !4087
    #dbg_value(i64 %146, !3844, !DIExpression(), !3782)
  %xor382 = xor i64 %xor116, %xor257, !dbg !4088
    #dbg_value(i64 %xor382, !3855, !DIExpression(), !3782)
  %147 = shl i64 %xor382, 36, !dbg !4089
  %148 = lshr i64 %xor382, 28, !dbg !4089
  %149 = or i64 %147, %148, !dbg !4089
    #dbg_value(i64 %149, !3841, !DIExpression(), !3782)
  %xor378 = xor i64 %xor93, %xor273, !dbg !4090
    #dbg_value(i64 %xor378, !3854, !DIExpression(), !3782)
  %150 = shl i64 %xor378, 27, !dbg !4091
  %151 = lshr i64 %xor378, 37, !dbg !4091
  %152 = or i64 %150, %151, !dbg !4091
    #dbg_value(i64 %152, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %146, i64 %149, i64 %152), !3822, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not410 = xor i64 %152, -1, !dbg !4092
    #dbg_value(!DIArgList(i64 %146, i64 %149, i64 %not410), !3822, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and411 = and i64 %149, %not410, !dbg !4093
    #dbg_value(!DIArgList(i64 %146, i64 %and411), !3822, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor412 = xor i64 %146, %and411, !dbg !4094
    #dbg_value(i64 %xor412, !3822, !DIExpression(), !3782)
  %xor390 = xor i64 %xor192, %xor265, !dbg !4095
    #dbg_value(i64 %xor390, !3867, !DIExpression(), !3782)
  %153 = shl i64 %xor390, 15, !dbg !4096
  %154 = lshr i64 %xor390, 49, !dbg !4096
  %155 = or i64 %153, %154, !dbg !4096
    #dbg_value(i64 %155, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %155, i64 %152, i64 %146), !3820, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not407 = xor i64 %146, -1, !dbg !4097
    #dbg_value(!DIArgList(i64 %155, i64 %152, i64 %not407), !3820, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and408 = and i64 %152, %not407, !dbg !4098
    #dbg_value(!DIArgList(i64 %155, i64 %and408), !3820, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor409 = xor i64 %155, %and408, !dbg !4099
    #dbg_value(i64 %xor409, !3820, !DIExpression(), !3782)
  %xor386 = xor i64 %xor154, %xor261, !dbg !4100
    #dbg_value(i64 %xor386, !3861, !DIExpression(), !3782)
  %156 = shl i64 %xor386, 10, !dbg !4101
  %157 = lshr i64 %xor386, 54, !dbg !4101
  %158 = or i64 %156, %157, !dbg !4101
    #dbg_value(i64 %158, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %158, i64 %146, i64 %155), !3818, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %149, i64 %155, i64 %158), !3816, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %152, i64 %158, i64 %149), !3814, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not404 = xor i64 %155, -1, !dbg !4102
    #dbg_value(!DIArgList(i64 %158, i64 %146, i64 %not404), !3818, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and405 = and i64 %146, %not404, !dbg !4103
    #dbg_value(!DIArgList(i64 %158, i64 %and405), !3818, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor406 = xor i64 %158, %and405, !dbg !4104
    #dbg_value(i64 %xor406, !3818, !DIExpression(), !3782)
  %not401 = xor i64 %158, -1, !dbg !4105
    #dbg_value(!DIArgList(i64 %149, i64 %155, i64 %not401), !3816, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and402 = and i64 %155, %not401, !dbg !4106
    #dbg_value(!DIArgList(i64 %149, i64 %and402), !3816, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor403 = xor i64 %149, %and402, !dbg !4107
    #dbg_value(i64 %xor403, !3816, !DIExpression(), !3782)
  %not398 = xor i64 %149, -1, !dbg !4108
    #dbg_value(!DIArgList(i64 %152, i64 %158, i64 %not398), !3814, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and399 = and i64 %158, %not398, !dbg !4109
    #dbg_value(!DIArgList(i64 %152, i64 %and399), !3814, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor400 = xor i64 %152, %and399, !dbg !4110
    #dbg_value(i64 %xor400, !3814, !DIExpression(), !3782)
  %xor359 = xor i64 %xor221, %xor257, !dbg !4111
    #dbg_value(i64 %xor359, !3870, !DIExpression(), !3782)
  %159 = shl i64 %xor359, 18, !dbg !4112
  %160 = lshr i64 %xor359, 46, !dbg !4112
  %161 = or i64 %159, %160, !dbg !4112
    #dbg_value(i64 %161, !3844, !DIExpression(), !3782)
  %xor347 = xor i64 %xor122, %xor265, !dbg !4113
    #dbg_value(i64 %xor347, !3857, !DIExpression(), !3782)
  %162 = shl i64 %xor347, 6, !dbg !4114
  %163 = lshr i64 %xor347, 58, !dbg !4114
  %164 = or i64 %162, %163, !dbg !4114
    #dbg_value(i64 %164, !3841, !DIExpression(), !3782)
  %xor343 = xor i64 %xor84, %xor261, !dbg !4115
    #dbg_value(i64 %xor343, !3851, !DIExpression(), !3782)
  %165 = shl i64 %xor343, 1, !dbg !4116
  %166 = lshr i64 %xor343, 63, !dbg !4116
  %167 = or i64 %165, %166, !dbg !4116
    #dbg_value(i64 %167, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %161, i64 %164, i64 %167), !3812, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not375 = xor i64 %167, -1, !dbg !4117
    #dbg_value(!DIArgList(i64 %161, i64 %164, i64 %not375), !3812, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and376 = and i64 %164, %not375, !dbg !4118
    #dbg_value(!DIArgList(i64 %161, i64 %and376), !3812, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor377 = xor i64 %161, %and376, !dbg !4119
    #dbg_value(i64 %xor377, !3812, !DIExpression(), !3782)
  %xor355 = xor i64 %xor198, %xor273, !dbg !4120
    #dbg_value(i64 %xor355, !3869, !DIExpression(), !3782)
  %168 = shl i64 %xor355, 8, !dbg !4121
  %169 = lshr i64 %xor355, 56, !dbg !4121
  %170 = or i64 %168, %169, !dbg !4121
    #dbg_value(i64 %170, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %170, i64 %167, i64 %161), !3810, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not372 = xor i64 %161, -1, !dbg !4122
    #dbg_value(!DIArgList(i64 %170, i64 %167, i64 %not372), !3810, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and373 = and i64 %167, %not372, !dbg !4123
    #dbg_value(!DIArgList(i64 %170, i64 %and373), !3810, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor374 = xor i64 %170, %and373, !dbg !4124
    #dbg_value(i64 %xor374, !3810, !DIExpression(), !3782)
  %xor351 = xor i64 %xor160, %xor269, !dbg !4125
    #dbg_value(i64 %xor351, !3863, !DIExpression(), !3782)
  %171 = shl i64 %xor351, 25, !dbg !4126
  %172 = lshr i64 %xor351, 39, !dbg !4126
  %173 = or i64 %171, %172, !dbg !4126
    #dbg_value(i64 %173, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %173, i64 %161, i64 %170), !3808, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %164, i64 %170, i64 %173), !3806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %167, i64 %173, i64 %164), !3804, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not369 = xor i64 %170, -1, !dbg !4127
    #dbg_value(!DIArgList(i64 %173, i64 %161, i64 %not369), !3808, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and370 = and i64 %161, %not369, !dbg !4128
    #dbg_value(!DIArgList(i64 %173, i64 %and370), !3808, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor371 = xor i64 %173, %and370, !dbg !4129
    #dbg_value(i64 %xor371, !3808, !DIExpression(), !3782)
  %not366 = xor i64 %173, -1, !dbg !4130
    #dbg_value(!DIArgList(i64 %164, i64 %170, i64 %not366), !3806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and367 = and i64 %170, %not366, !dbg !4131
    #dbg_value(!DIArgList(i64 %164, i64 %and367), !3806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor368 = xor i64 %164, %and367, !dbg !4132
    #dbg_value(i64 %xor368, !3806, !DIExpression(), !3782)
  %not363 = xor i64 %164, -1, !dbg !4133
    #dbg_value(!DIArgList(i64 %167, i64 %173, i64 %not363), !3804, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and364 = and i64 %173, %not363, !dbg !4134
    #dbg_value(!DIArgList(i64 %167, i64 %and364), !3804, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor365 = xor i64 %167, %and364, !dbg !4135
    #dbg_value(i64 %xor365, !3804, !DIExpression(), !3782)
  %xor324 = xor i64 %xor227, %xor265, !dbg !4136
    #dbg_value(i64 %xor324, !3872, !DIExpression(), !3782)
  %174 = shl i64 %xor324, 61, !dbg !4137
  %175 = lshr i64 %xor324, 3, !dbg !4137
  %176 = or i64 %174, %175, !dbg !4137
    #dbg_value(i64 %176, !3844, !DIExpression(), !3782)
  %xor312 = xor i64 %xor128, %xor273, !dbg !4138
    #dbg_value(i64 %xor312, !3859, !DIExpression(), !3782)
  %177 = shl i64 %xor312, 20, !dbg !4139
  %178 = lshr i64 %xor312, 44, !dbg !4139
  %179 = or i64 %177, %178, !dbg !4139
    #dbg_value(i64 %179, !3841, !DIExpression(), !3782)
  %xor308 = xor i64 %xor90, %xor269, !dbg !4140
    #dbg_value(i64 %xor308, !3853, !DIExpression(), !3782)
  %180 = shl i64 %xor308, 28, !dbg !4141
  %181 = lshr i64 %xor308, 36, !dbg !4141
  %182 = or i64 %180, %181, !dbg !4141
    #dbg_value(i64 %182, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %176, i64 %179, i64 %182), !3802, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not340 = xor i64 %182, -1, !dbg !4142
    #dbg_value(!DIArgList(i64 %176, i64 %179, i64 %not340), !3802, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and341 = and i64 %179, %not340, !dbg !4143
    #dbg_value(!DIArgList(i64 %176, i64 %and341), !3802, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor342 = xor i64 %176, %and341, !dbg !4144
    #dbg_value(i64 %xor342, !3802, !DIExpression(), !3782)
  %xor320 = xor i64 %xor189, %xor261, !dbg !4145
    #dbg_value(i64 %xor320, !3866, !DIExpression(), !3782)
  %183 = shl i64 %xor320, 45, !dbg !4146
  %184 = lshr i64 %xor320, 19, !dbg !4146
  %185 = or i64 %183, %184, !dbg !4146
    #dbg_value(i64 %185, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %185, i64 %182, i64 %176), !3800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not337 = xor i64 %176, -1, !dbg !4147
    #dbg_value(!DIArgList(i64 %185, i64 %182, i64 %not337), !3800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and338 = and i64 %182, %not337, !dbg !4148
    #dbg_value(!DIArgList(i64 %185, i64 %and338), !3800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor339 = xor i64 %185, %and338, !dbg !4149
    #dbg_value(i64 %xor339, !3800, !DIExpression(), !3782)
  %xor316 = xor i64 %xor151, %xor257, !dbg !4150
    #dbg_value(i64 %xor316, !3860, !DIExpression(), !3782)
  %186 = shl i64 %xor316, 3, !dbg !4151
  %187 = lshr i64 %xor316, 61, !dbg !4151
  %188 = or i64 %186, %187, !dbg !4151
    #dbg_value(i64 %188, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %188, i64 %176, i64 %185), !3798, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %179, i64 %185, i64 %188), !3796, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %182, i64 %188, i64 %179), !3794, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not334 = xor i64 %185, -1, !dbg !4152
    #dbg_value(!DIArgList(i64 %188, i64 %176, i64 %not334), !3798, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and335 = and i64 %176, %not334, !dbg !4153
    #dbg_value(!DIArgList(i64 %188, i64 %and335), !3798, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor336 = xor i64 %188, %and335, !dbg !4154
    #dbg_value(i64 %xor336, !3798, !DIExpression(), !3782)
  %not331 = xor i64 %188, -1, !dbg !4155
    #dbg_value(!DIArgList(i64 %179, i64 %185, i64 %not331), !3796, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and332 = and i64 %185, %not331, !dbg !4156
    #dbg_value(!DIArgList(i64 %179, i64 %and332), !3796, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor333 = xor i64 %179, %and332, !dbg !4157
    #dbg_value(i64 %xor333, !3796, !DIExpression(), !3782)
  %not328 = xor i64 %179, -1, !dbg !4158
    #dbg_value(!DIArgList(i64 %182, i64 %188, i64 %not328), !3794, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and329 = and i64 %188, %not328, !dbg !4159
    #dbg_value(!DIArgList(i64 %182, i64 %and329), !3794, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor330 = xor i64 %182, %and329, !dbg !4160
    #dbg_value(i64 %xor330, !3794, !DIExpression(), !3782)
  %xor287 = xor i64 %xor233, %xor273, !dbg !4161
    #dbg_value(i64 %xor287, !3874, !DIExpression(), !3782)
  %189 = shl i64 %xor287, 14, !dbg !4162
  %190 = lshr i64 %xor287, 50, !dbg !4162
  %191 = or i64 %189, %190, !dbg !4162
    #dbg_value(i64 %191, !3844, !DIExpression(), !3782)
  %xor275 = xor i64 %xor119, %xor261, !dbg !4163
    #dbg_value(i64 %xor275, !3856, !DIExpression(), !3782)
  %192 = shl i64 %xor275, 44, !dbg !4164
  %193 = lshr i64 %xor275, 20, !dbg !4164
  %194 = or i64 %192, %193, !dbg !4164
    #dbg_value(i64 %194, !3841, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %191, i64 %194, i64 %xor81, i64 %xor257), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_xor, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor274 = xor i64 %xor81, %xor257, !dbg !4165
    #dbg_value(i64 %xor274, !3850, !DIExpression(), !3782)
    #dbg_value(i64 %xor274, !3840, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %191, i64 %194, i64 %xor274), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not305 = xor i64 %xor274, -1, !dbg !4166
    #dbg_value(!DIArgList(i64 %191, i64 %194, i64 %not305), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and306 = and i64 %194, %not305, !dbg !4167
    #dbg_value(!DIArgList(i64 %191, i64 %and306), !3792, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor307 = xor i64 %191, %and306, !dbg !4168
    #dbg_value(i64 %xor307, !3792, !DIExpression(), !3782)
  %xor283 = xor i64 %xor195, %xor269, !dbg !4169
    #dbg_value(i64 %xor283, !3868, !DIExpression(), !3782)
  %195 = shl i64 %xor283, 21, !dbg !4170
  %196 = lshr i64 %xor283, 43, !dbg !4170
  %197 = or i64 %195, %196, !dbg !4170
    #dbg_value(i64 %197, !3843, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %197, i64 %xor274, i64 %191), !3790, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not302 = xor i64 %191, -1, !dbg !4171
    #dbg_value(!DIArgList(i64 %197, i64 %xor274, i64 %not302), !3790, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and303 = and i64 %xor274, %not302, !dbg !4172
    #dbg_value(!DIArgList(i64 %197, i64 %and303), !3790, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor304 = xor i64 %197, %and303, !dbg !4173
    #dbg_value(i64 %xor304, !3790, !DIExpression(), !3782)
  %xor279 = xor i64 %xor157, %xor265, !dbg !4174
    #dbg_value(i64 %xor279, !3862, !DIExpression(), !3782)
  %198 = shl i64 %xor279, 43, !dbg !4175
  %199 = lshr i64 %xor279, 21, !dbg !4175
  %200 = or i64 %198, %199, !dbg !4175
    #dbg_value(i64 %200, !3842, !DIExpression(), !3782)
    #dbg_value(!DIArgList(i64 %200, i64 %191, i64 %197), !3788, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %194, i64 %197, i64 %200), !3786, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
    #dbg_value(!DIArgList(i64 %xor274, i64 %200, i64 %194), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %not299 = xor i64 %197, -1, !dbg !4176
    #dbg_value(!DIArgList(i64 %200, i64 %191, i64 %not299), !3788, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and300 = and i64 %191, %not299, !dbg !4177
    #dbg_value(!DIArgList(i64 %200, i64 %and300), !3788, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor301 = xor i64 %200, %and300, !dbg !4178
    #dbg_value(i64 %xor301, !3788, !DIExpression(), !3782)
  %not296 = xor i64 %200, -1, !dbg !4179
    #dbg_value(!DIArgList(i64 %194, i64 %197, i64 %not296), !3786, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_arg, 2, DW_OP_and, DW_OP_xor, DW_OP_stack_value), !3782)
  %and297 = and i64 %197, %not296, !dbg !4180
    #dbg_value(!DIArgList(i64 %194, i64 %and297), !3786, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %xor298 = xor i64 %194, %and297, !dbg !4181
    #dbg_value(i64 %xor298, !3786, !DIExpression(), !3782)
  %add = or disjoint i32 %round.0, 1, !dbg !4182
  %arrayidx294 = getelementptr inbounds nuw [24 x i64], ptr @KeccakF_RoundConstants, i32 0, i32 %add, !dbg !4183
  %201 = load i64, ptr %arrayidx294, align 8, !dbg !4183
    #dbg_value(!DIArgList(i64 %xor274, i64 %201, i64 %200, i64 %194), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_constu, 18446744073709551615, DW_OP_xor, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %not291 = xor i64 %194, -1, !dbg !4184
    #dbg_value(!DIArgList(i64 %xor274, i64 %201, i64 %200, i64 %not291), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_LLVM_arg, 3, DW_OP_and, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %and292 = and i64 %200, %not291, !dbg !4185
    #dbg_value(!DIArgList(i64 %xor274, i64 %201, i64 %and292), !3784, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !3782)
  %202 = xor i64 %and292, %201, !dbg !4186
  %xor295 = xor i64 %202, %xor274, !dbg !4186
    #dbg_value(i64 %xor295, !3784, !DIExpression(), !3782)
  %add448 = add nuw nsw i32 %round.0, 2, !dbg !4187
    #dbg_value(i32 %add448, !3833, !DIExpression(), !3782)
  br label %for.cond, !dbg !4188, !llvm.loop !4189

for.end:                                          ; preds = %for.cond
  %Aso.0.lcssa = phi i64 [ %Aso.0, %for.cond ], !dbg !3782
  %Asi.0.lcssa = phi i64 [ %Asi.0, %for.cond ], !dbg !3782
  %Ase.0.lcssa = phi i64 [ %Ase.0, %for.cond ], !dbg !3782
  %Asa.0.lcssa = phi i64 [ %Asa.0, %for.cond ], !dbg !3782
  %Amu.0.lcssa = phi i64 [ %Amu.0, %for.cond ], !dbg !3782
  %Amo.0.lcssa = phi i64 [ %Amo.0, %for.cond ], !dbg !3782
  %Ami.0.lcssa = phi i64 [ %Ami.0, %for.cond ], !dbg !3782
  %Ame.0.lcssa = phi i64 [ %Ame.0, %for.cond ], !dbg !3782
  %Ama.0.lcssa = phi i64 [ %Ama.0, %for.cond ], !dbg !3782
  %Aku.0.lcssa = phi i64 [ %Aku.0, %for.cond ], !dbg !3782
  %Ako.0.lcssa = phi i64 [ %Ako.0, %for.cond ], !dbg !3782
  %Aki.0.lcssa = phi i64 [ %Aki.0, %for.cond ], !dbg !3782
  %Ake.0.lcssa = phi i64 [ %Ake.0, %for.cond ], !dbg !3782
  %Aka.0.lcssa = phi i64 [ %Aka.0, %for.cond ], !dbg !3782
  %Agu.0.lcssa = phi i64 [ %Agu.0, %for.cond ], !dbg !3782
  %Ago.0.lcssa = phi i64 [ %Ago.0, %for.cond ], !dbg !3782
  %Agi.0.lcssa = phi i64 [ %Agi.0, %for.cond ], !dbg !3782
  %Age.0.lcssa = phi i64 [ %Age.0, %for.cond ], !dbg !3782
  %Aga.0.lcssa = phi i64 [ %Aga.0, %for.cond ], !dbg !3782
  %Abu.0.lcssa = phi i64 [ %Abu.0, %for.cond ], !dbg !3782
  %Abo.0.lcssa = phi i64 [ %Abo.0, %for.cond ], !dbg !3782
  %Abi.0.lcssa = phi i64 [ %Abi.0, %for.cond ], !dbg !3782
  %Abe.0.lcssa = phi i64 [ %Abe.0, %for.cond ], !dbg !3782
  %Aba.0.lcssa = phi i64 [ %Aba.0, %for.cond ], !dbg !3782
  %Asu.0.lcssa = phi i64 [ %Asu.0, %for.cond ], !dbg !3782
  store i64 %Aba.0.lcssa, ptr %state, align 8, !dbg !4191
  %arrayidx450 = getelementptr inbounds nuw i8, ptr %state, i32 8, !dbg !4192
  store i64 %Abe.0.lcssa, ptr %arrayidx450, align 8, !dbg !4193
  %arrayidx451 = getelementptr inbounds nuw i8, ptr %state, i32 16, !dbg !4194
  store i64 %Abi.0.lcssa, ptr %arrayidx451, align 8, !dbg !4195
  %arrayidx452 = getelementptr inbounds nuw i8, ptr %state, i32 24, !dbg !4196
  store i64 %Abo.0.lcssa, ptr %arrayidx452, align 8, !dbg !4197
  %arrayidx453 = getelementptr inbounds nuw i8, ptr %state, i32 32, !dbg !4198
  store i64 %Abu.0.lcssa, ptr %arrayidx453, align 8, !dbg !4199
  %arrayidx454 = getelementptr inbounds nuw i8, ptr %state, i32 40, !dbg !4200
  store i64 %Aga.0.lcssa, ptr %arrayidx454, align 8, !dbg !4201
  %arrayidx455 = getelementptr inbounds nuw i8, ptr %state, i32 48, !dbg !4202
  store i64 %Age.0.lcssa, ptr %arrayidx455, align 8, !dbg !4203
  %arrayidx456 = getelementptr inbounds nuw i8, ptr %state, i32 56, !dbg !4204
  store i64 %Agi.0.lcssa, ptr %arrayidx456, align 8, !dbg !4205
  %arrayidx457 = getelementptr inbounds nuw i8, ptr %state, i32 64, !dbg !4206
  store i64 %Ago.0.lcssa, ptr %arrayidx457, align 8, !dbg !4207
  %arrayidx458 = getelementptr inbounds nuw i8, ptr %state, i32 72, !dbg !4208
  store i64 %Agu.0.lcssa, ptr %arrayidx458, align 8, !dbg !4209
  %arrayidx459 = getelementptr inbounds nuw i8, ptr %state, i32 80, !dbg !4210
  store i64 %Aka.0.lcssa, ptr %arrayidx459, align 8, !dbg !4211
  %arrayidx460 = getelementptr inbounds nuw i8, ptr %state, i32 88, !dbg !4212
  store i64 %Ake.0.lcssa, ptr %arrayidx460, align 8, !dbg !4213
  %arrayidx461 = getelementptr inbounds nuw i8, ptr %state, i32 96, !dbg !4214
  store i64 %Aki.0.lcssa, ptr %arrayidx461, align 8, !dbg !4215
  %arrayidx462 = getelementptr inbounds nuw i8, ptr %state, i32 104, !dbg !4216
  store i64 %Ako.0.lcssa, ptr %arrayidx462, align 8, !dbg !4217
  %arrayidx463 = getelementptr inbounds nuw i8, ptr %state, i32 112, !dbg !4218
  store i64 %Aku.0.lcssa, ptr %arrayidx463, align 8, !dbg !4219
  %arrayidx464 = getelementptr inbounds nuw i8, ptr %state, i32 120, !dbg !4220
  store i64 %Ama.0.lcssa, ptr %arrayidx464, align 8, !dbg !4221
  %arrayidx465 = getelementptr inbounds nuw i8, ptr %state, i32 128, !dbg !4222
  store i64 %Ame.0.lcssa, ptr %arrayidx465, align 8, !dbg !4223
  %arrayidx466 = getelementptr inbounds nuw i8, ptr %state, i32 136, !dbg !4224
  store i64 %Ami.0.lcssa, ptr %arrayidx466, align 8, !dbg !4225
  %arrayidx467 = getelementptr inbounds nuw i8, ptr %state, i32 144, !dbg !4226
  store i64 %Amo.0.lcssa, ptr %arrayidx467, align 8, !dbg !4227
  %arrayidx468 = getelementptr inbounds nuw i8, ptr %state, i32 152, !dbg !4228
  store i64 %Amu.0.lcssa, ptr %arrayidx468, align 8, !dbg !4229
  %arrayidx469 = getelementptr inbounds nuw i8, ptr %state, i32 160, !dbg !4230
  store i64 %Asa.0.lcssa, ptr %arrayidx469, align 8, !dbg !4231
  %arrayidx470 = getelementptr inbounds nuw i8, ptr %state, i32 168, !dbg !4232
  store i64 %Ase.0.lcssa, ptr %arrayidx470, align 8, !dbg !4233
  %arrayidx471 = getelementptr inbounds nuw i8, ptr %state, i32 176, !dbg !4234
  store i64 %Asi.0.lcssa, ptr %arrayidx471, align 8, !dbg !4235
  %arrayidx472 = getelementptr inbounds nuw i8, ptr %state, i32 184, !dbg !4236
  store i64 %Aso.0.lcssa, ptr %arrayidx472, align 8, !dbg !4237
  %arrayidx473 = getelementptr inbounds nuw i8, ptr %state, i32 192, !dbg !4238
  store i64 %Asu.0.lcssa, ptr %arrayidx473, align 8, !dbg !4239
  ret void, !dbg !4240
}

; Function Attrs: nounwind
define dso_local void @shake_finalize(ptr noundef %instance) local_unnamed_addr #0 !dbg !4241 {
entry:
    #dbg_value(ptr %instance, !4242, !DIExpression(), !4243)
  %arrayidx = getelementptr inbounds nuw i8, ptr %instance, i32 208, !dbg !4244
  %0 = load i64, ptr %arrayidx, align 8, !dbg !4244
  %conv = trunc i64 %0 to i32, !dbg !4244
  call fastcc void @keccak_inc_finalize(ptr noundef %instance, i32 noundef %conv, i8 noundef zeroext 31) #3, !dbg !4245
  ret void, !dbg !4246
}

; Function Attrs: nounwind
define internal fastcc void @keccak_inc_finalize(ptr noundef %s_inc, i32 noundef %r, i8 noundef zeroext %p) unnamed_addr #0 !dbg !4247 {
entry:
    #dbg_value(ptr %s_inc, !4250, !DIExpression(), !4251)
    #dbg_value(i32 %r, !4252, !DIExpression(), !4251)
    #dbg_value(i8 31, !4253, !DIExpression(), !4251)
  %arrayidx = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !4254
  %0 = load i64, ptr %arrayidx, align 8, !dbg !4254
  %and = shl i64 %0, 3, !dbg !4255
  %mul = and i64 %and, 56, !dbg !4255
  %shl = shl nuw nsw i64 31, %mul, !dbg !4256
  %shr = lshr i64 %0, 3, !dbg !4257
  %idxprom = trunc i64 %shr to i32, !dbg !4258
  %arrayidx2 = getelementptr inbounds nuw i64, ptr %s_inc, i32 %idxprom, !dbg !4258
  %1 = load i64, ptr %arrayidx2, align 8, !dbg !4259
  %xor = xor i64 %1, %shl, !dbg !4259
  store i64 %xor, ptr %arrayidx2, align 8, !dbg !4259
  %sub = shl i32 %r, 3, !dbg !4260
  %and3 = add i32 %sub, 56, !dbg !4260
  %mul4 = and i32 %and3, 56, !dbg !4260
  %sh_prom = zext nneg i32 %mul4 to i64, !dbg !4261
  %shl5 = shl nuw i64 128, %sh_prom, !dbg !4261
  %sub6 = add i32 %r, -1, !dbg !4262
  %shr7 = lshr i32 %sub6, 3, !dbg !4263
  %arrayidx8 = getelementptr inbounds nuw i64, ptr %s_inc, i32 %shr7, !dbg !4264
  %2 = load i64, ptr %arrayidx8, align 8, !dbg !4265
  %xor9 = xor i64 %2, %shl5, !dbg !4265
  store i64 %xor9, ptr %arrayidx8, align 8, !dbg !4265
  %arrayidx10 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !4266
  store i64 0, ptr %arrayidx10, align 8, !dbg !4267
  ret void, !dbg !4268
}

; Function Attrs: nounwind
define dso_local void @shake_squeeze(ptr noundef %out, i32 noundef %outlen, ptr noundef %instance) local_unnamed_addr #0 !dbg !4269 {
entry:
    #dbg_value(ptr %out, !4272, !DIExpression(), !4273)
    #dbg_value(i32 %outlen, !4274, !DIExpression(), !4273)
    #dbg_value(ptr %instance, !4275, !DIExpression(), !4273)
  %arrayidx = getelementptr inbounds nuw i8, ptr %instance, i32 208, !dbg !4276
  %0 = load i64, ptr %arrayidx, align 8, !dbg !4276
  %conv = trunc i64 %0 to i32, !dbg !4276
  call fastcc void @keccak_inc_squeeze(ptr noundef %out, i32 noundef %outlen, ptr noundef %instance, i32 noundef %conv) #3, !dbg !4277
  ret void, !dbg !4278
}

; Function Attrs: nounwind
define internal fastcc void @keccak_inc_squeeze(ptr noundef %h, i32 noundef %outlen, ptr noundef %s_inc, i32 noundef %r) unnamed_addr #0 !dbg !4279 {
entry:
    #dbg_value(ptr %h, !4282, !DIExpression(), !4283)
    #dbg_value(i32 %outlen, !4284, !DIExpression(), !4283)
    #dbg_value(ptr %s_inc, !4285, !DIExpression(), !4283)
    #dbg_value(i32 %r, !4286, !DIExpression(), !4283)
    #dbg_value(i32 0, !4287, !DIExpression(), !4283)
  br label %for.cond, !dbg !4288

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !4290
    #dbg_value(i32 %i.0, !4287, !DIExpression(), !4283)
  %exitcond = icmp ne i32 %i.0, %outlen, !dbg !4291
  br i1 %exitcond, label %land.rhs, label %for.end, !dbg !4293

land.rhs:                                         ; preds = %for.cond
  %conv = zext i32 %i.0 to i64, !dbg !4294
  %arrayidx = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !4295
  %0 = load i64, ptr %arrayidx, align 8, !dbg !4295
  %cmp1 = icmp ugt i64 %0, %conv, !dbg !4296
  br i1 %cmp1, label %for.body, label %for.end, !dbg !4297

for.body:                                         ; preds = %land.rhs
  %conv3 = zext i32 %r to i64, !dbg !4298
  %arrayidx4 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !4300
  %1 = load i64, ptr %arrayidx4, align 8, !dbg !4300
  %sub = sub i64 %conv3, %1, !dbg !4301
  %conv5 = zext i32 %i.0 to i64, !dbg !4302
  %add = add i64 %sub, %conv5, !dbg !4303
  %shr = lshr i64 %add, 3, !dbg !4304
  %idxprom = trunc i64 %shr to i32, !dbg !4305
  %arrayidx6 = getelementptr inbounds nuw i64, ptr %s_inc, i32 %idxprom, !dbg !4305
  %2 = load i64, ptr %arrayidx6, align 8, !dbg !4305
  %conv7 = zext i32 %r to i64, !dbg !4306
  %arrayidx8 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !4307
  %3 = load i64, ptr %arrayidx8, align 8, !dbg !4307
  %sub9 = sub i64 %conv7, %3, !dbg !4308
  %conv10 = zext i32 %i.0 to i64, !dbg !4309
  %add11 = add i64 %sub9, %conv10, !dbg !4310
  %and = shl i64 %add11, 3, !dbg !4311
  %mul = and i64 %and, 56, !dbg !4311
  %shr12 = lshr i64 %2, %mul, !dbg !4312
  %conv13 = trunc i64 %shr12 to i8, !dbg !4313
  %arrayidx14 = getelementptr inbounds nuw i8, ptr %h, i32 %i.0, !dbg !4314
  store i8 %conv13, ptr %arrayidx14, align 1, !dbg !4315
  %inc = add i32 %i.0, 1, !dbg !4316
    #dbg_value(i32 %inc, !4287, !DIExpression(), !4283)
  br label %for.cond, !dbg !4317, !llvm.loop !4318

for.end:                                          ; preds = %for.cond, %land.rhs
  %i.0.lcssa = phi i32 [ %outlen, %for.cond ], [ %i.0, %land.rhs ], !dbg !4290
  %add.ptr = getelementptr inbounds nuw i8, ptr %h, i32 %i.0.lcssa, !dbg !4320
    #dbg_value(ptr %add.ptr, !4282, !DIExpression(), !4283)
  %sub15 = sub i32 %outlen, %i.0.lcssa, !dbg !4321
    #dbg_value(i32 %sub15, !4284, !DIExpression(), !4283)
  %conv16 = zext i32 %i.0.lcssa to i64, !dbg !4322
  %arrayidx17 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !4323
  %4 = load i64, ptr %arrayidx17, align 8, !dbg !4324
  %sub18 = sub i64 %4, %conv16, !dbg !4324
  store i64 %sub18, ptr %arrayidx17, align 8, !dbg !4324
  br label %while.cond, !dbg !4325

while.cond:                                       ; preds = %for.end38, %for.end
  %outlen.addr.0 = phi i32 [ %sub15, %for.end ], [ %sub40, %for.end38 ], !dbg !4283
  %h.addr.0 = phi ptr [ %add.ptr, %for.end ], [ %add.ptr39, %for.end38 ], !dbg !4283
    #dbg_value(ptr %h.addr.0, !4282, !DIExpression(), !4283)
    #dbg_value(i32 %outlen.addr.0, !4284, !DIExpression(), !4283)
  %cmp19.not = icmp eq i32 %outlen.addr.0, 0, !dbg !4326
  br i1 %cmp19.not, label %while.end, label %while.body, !dbg !4325

while.body:                                       ; preds = %while.cond
  call fastcc void @KeccakF1600_StatePermute(ptr noundef nonnull %s_inc) #3, !dbg !4327
    #dbg_value(i32 0, !4287, !DIExpression(), !4283)
  %5 = icmp ult i32 %outlen.addr.0, %r, !dbg !4329
  %6 = select i1 %5, i32 %outlen.addr.0, i32 %r, !dbg !4329
  br label %for.cond21, !dbg !4329

for.cond21:                                       ; preds = %for.body28, %while.body
  %i.1 = phi i32 [ 0, %while.body ], [ %inc37, %for.body28 ], !dbg !4331
    #dbg_value(i32 %i.1, !4287, !DIExpression(), !4283)
  %exitcond1 = icmp ne i32 %i.1, %6, !dbg !4332
  br i1 %exitcond1, label %for.body28, label %for.end38, !dbg !4334

for.body28:                                       ; preds = %for.cond21
  %shr29 = lshr i32 %i.1, 3, !dbg !4335
  %arrayidx30 = getelementptr inbounds nuw i64, ptr %s_inc, i32 %shr29, !dbg !4337
  %7 = load i64, ptr %arrayidx30, align 8, !dbg !4337
  %and31 = shl i32 %i.1, 3, !dbg !4338
  %mul32 = and i32 %and31, 56, !dbg !4338
  %sh_prom = zext nneg i32 %mul32 to i64, !dbg !4339
  %shr33 = lshr i64 %7, %sh_prom, !dbg !4339
  %conv34 = trunc i64 %shr33 to i8, !dbg !4340
  %arrayidx35 = getelementptr inbounds nuw i8, ptr %h.addr.0, i32 %i.1, !dbg !4341
  store i8 %conv34, ptr %arrayidx35, align 1, !dbg !4342
  %inc37 = add i32 %i.1, 1, !dbg !4343
    #dbg_value(i32 %inc37, !4287, !DIExpression(), !4283)
  br label %for.cond21, !dbg !4344, !llvm.loop !4345

for.end38:                                        ; preds = %for.cond21
  %i.1.lcssa = phi i32 [ %i.1, %for.cond21 ], !dbg !4331
  %add.ptr39 = getelementptr inbounds nuw i8, ptr %h.addr.0, i32 %i.1.lcssa, !dbg !4347
    #dbg_value(ptr %add.ptr39, !4282, !DIExpression(), !4283)
  %sub40 = sub i32 %outlen.addr.0, %i.1.lcssa, !dbg !4348
    #dbg_value(i32 %sub40, !4284, !DIExpression(), !4283)
  %sub41 = sub i32 %r, %i.1.lcssa, !dbg !4349
  %conv42 = zext i32 %sub41 to i64, !dbg !4350
  %arrayidx43 = getelementptr inbounds nuw i8, ptr %s_inc, i32 200, !dbg !4351
  store i64 %conv42, ptr %arrayidx43, align 8, !dbg !4352
  br label %while.cond, !dbg !4325, !llvm.loop !4353

while.end:                                        ; preds = %while.cond
  ret void, !dbg !4355
}

; Function Attrs: nounwind
define dso_local void @shake256(ptr noundef %out, i32 noundef %outlen, ptr noundef %in, i32 noundef %inlen) local_unnamed_addr #0 !dbg !4356 {
entry:
  %instance = alloca %struct.shake_t, align 8
    #dbg_value(ptr %out, !4359, !DIExpression(), !4360)
    #dbg_value(i32 %outlen, !4361, !DIExpression(), !4360)
    #dbg_value(ptr %in, !4362, !DIExpression(), !4360)
    #dbg_value(i32 %inlen, !4363, !DIExpression(), !4360)
    #dbg_declare(ptr %instance, !4364, !DIExpression(), !4365)
  call void @shake256_init(ptr noundef nonnull %instance) #3, !dbg !4366
  call void @shake_absorb(ptr noundef nonnull %instance, ptr noundef %in, i32 noundef %inlen) #3, !dbg !4367
  call void @shake_finalize(ptr noundef nonnull %instance) #3, !dbg !4368
  call void @shake_squeeze(ptr noundef %out, i32 noundef %outlen, ptr noundef nonnull %instance) #3, !dbg !4369
  ret void, !dbg !4370
}

; Function Attrs: nounwind
define dso_local void @snova_pk_expander_init(ptr noundef %instance, ptr noundef %seed, i32 noundef %input_bytes) local_unnamed_addr #0 !dbg !4371 {
entry:
    #dbg_value(ptr %instance, !4382, !DIExpression(), !4383)
    #dbg_value(ptr %seed, !4384, !DIExpression(), !4383)
    #dbg_value(i32 %input_bytes, !4385, !DIExpression(), !4383)
  %call = call ptr @memcpy(ptr noundef %instance, ptr noundef %seed, i32 noundef 16) #4, !dbg !4386
  ret void, !dbg !4387
}

; Function Attrs: nounwind
define dso_local void @snova_pk_expander(ptr noundef %data, i32 noundef %num_bytes, ptr noundef %instance) local_unnamed_addr #0 !dbg !4388 {
entry:
    #dbg_value(ptr %data, !4391, !DIExpression(), !4392)
    #dbg_value(i32 %num_bytes, !4393, !DIExpression(), !4392)
    #dbg_value(ptr %instance, !4394, !DIExpression(), !4392)
  %call = call i32 @AES128_CTR(ptr noundef %data, i32 noundef %num_bytes, ptr noundef %instance, i32 noundef 16) #3, !dbg !4395
  ret void, !dbg !4396
}

; Function Attrs: nounwind
define dso_local void @snova_pk_expand(ptr noundef %out, i32 noundef %outlen, ptr noundef %in, i32 noundef %inlen) local_unnamed_addr #0 !dbg !4397 {
entry:
  %instance = alloca %struct.snova_pk_expander_t, align 8
    #dbg_value(ptr %out, !4398, !DIExpression(), !4399)
    #dbg_value(i32 %outlen, !4400, !DIExpression(), !4399)
    #dbg_value(ptr %in, !4401, !DIExpression(), !4399)
    #dbg_value(i32 %inlen, !4402, !DIExpression(), !4399)
    #dbg_declare(ptr %instance, !4403, !DIExpression(), !4404)
  call void @snova_pk_expander_init(ptr noundef nonnull %instance, ptr noundef %in, i32 noundef %inlen) #3, !dbg !4405
  call void @snova_pk_expander(ptr noundef %out, i32 noundef %outlen, ptr noundef nonnull %instance) #3, !dbg !4406
  ret void, !dbg !4407
}

; Function Attrs: nounwind
define dso_local i32 @seedexpander_init(ptr noundef %ctx, ptr noundef %seed, ptr noundef %diversifier, i32 noundef %maxlen) local_unnamed_addr #0 !dbg !4408 {
entry:
    #dbg_value(ptr %ctx, !4421, !DIExpression(), !4422)
    #dbg_value(ptr %seed, !4423, !DIExpression(), !4422)
    #dbg_value(ptr %diversifier, !4424, !DIExpression(), !4422)
    #dbg_value(i32 %maxlen, !4425, !DIExpression(), !4422)
  %length_remaining = getelementptr inbounds nuw i8, ptr %ctx, i32 20, !dbg !4426
  store i32 %maxlen, ptr %length_remaining, align 4, !dbg !4427
  %key = getelementptr inbounds nuw i8, ptr %ctx, i32 24, !dbg !4428
  %call = call ptr @memcpy(ptr noundef nonnull %key, ptr noundef %seed, i32 noundef 32) #4, !dbg !4429
  %ctr = getelementptr inbounds nuw i8, ptr %ctx, i32 56, !dbg !4430
  %call3 = call ptr @memcpy(ptr noundef nonnull %ctr, ptr noundef %diversifier, i32 noundef 8) #4, !dbg !4431
  %conv4 = trunc i32 %maxlen to i8, !dbg !4432
  %arrayidx = getelementptr inbounds nuw i8, ptr %ctx, i32 67, !dbg !4433
  store i8 %conv4, ptr %arrayidx, align 1, !dbg !4434
  %shr = lshr i32 %maxlen, 8, !dbg !4435
    #dbg_value(i32 %shr, !4425, !DIExpression(), !4422)
  %conv7 = trunc i32 %shr to i8, !dbg !4436
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %ctx, i32 66, !dbg !4437
  store i8 %conv7, ptr %arrayidx9, align 2, !dbg !4438
  %shr10 = lshr i32 %maxlen, 16, !dbg !4439
    #dbg_value(i32 %shr10, !4425, !DIExpression(), !4422)
  %rem11.lhs.trunc = trunc i32 %shr10 to i8, !dbg !4440
  %arrayidx14 = getelementptr inbounds nuw i8, ptr %ctx, i32 65, !dbg !4441
  store i8 %rem11.lhs.trunc, ptr %arrayidx14, align 1, !dbg !4442
  %shr15 = lshr i32 %maxlen, 24, !dbg !4443
    #dbg_value(i32 %shr15, !4425, !DIExpression(), !4422)
  %conv17 = trunc nuw i32 %shr15 to i8, !dbg !4444
  %arrayidx19 = getelementptr inbounds nuw i8, ptr %ctx, i32 64, !dbg !4445
  store i8 %conv17, ptr %arrayidx19, align 4, !dbg !4446
  %add.ptr = getelementptr inbounds nuw i8, ptr %ctx, i32 68, !dbg !4447
  %call22 = call ptr @memset(ptr noundef nonnull %add.ptr, i32 noundef 0, i32 noundef 4) #4, !dbg !4448
  %buffer_pos = getelementptr inbounds nuw i8, ptr %ctx, i32 16, !dbg !4449
  store i32 16, ptr %buffer_pos, align 4, !dbg !4450
  %call24 = call ptr @memset(ptr noundef %ctx, i32 noundef 0, i32 noundef 16) #4, !dbg !4451
  ret i32 0, !dbg !4452
}

; Function Attrs: nounwind
define dso_local range(i32 -3, 1) i32 @seedexpander(ptr noundef %ctx, ptr noundef %x, i32 noundef %xlen) local_unnamed_addr #0 !dbg !4453 {
entry:
    #dbg_value(ptr %ctx, !4456, !DIExpression(), !4457)
    #dbg_value(ptr %x, !4458, !DIExpression(), !4457)
    #dbg_value(i32 %xlen, !4459, !DIExpression(), !4457)
  %cmp = icmp eq ptr %x, null, !dbg !4460
  br i1 %cmp, label %return, label %if.end, !dbg !4460

if.end:                                           ; preds = %entry
  %length_remaining = getelementptr inbounds nuw i8, ptr %ctx, i32 20, !dbg !4462
  %0 = load i32, ptr %length_remaining, align 4, !dbg !4462
  %cmp1.not = icmp ult i32 %xlen, %0, !dbg !4464
  br i1 %cmp1.not, label %if.end3, label %return, !dbg !4464

if.end3:                                          ; preds = %if.end
  %length_remaining4 = getelementptr inbounds nuw i8, ptr %ctx, i32 20, !dbg !4465
  %1 = load i32, ptr %length_remaining4, align 4, !dbg !4466
  %sub = sub i32 %1, %xlen, !dbg !4466
  store i32 %sub, ptr %length_remaining4, align 4, !dbg !4466
    #dbg_value(i32 0, !4467, !DIExpression(), !4457)
  br label %while.cond, !dbg !4468

while.cond:                                       ; preds = %for.end, %if.end3
  %xlen.addr.0 = phi i32 [ %xlen, %if.end3 ], [ %sub23, %for.end ]
  %offset.0 = phi i32 [ 0, %if.end3 ], [ %add26, %for.end ], !dbg !4457
    #dbg_value(i32 %offset.0, !4467, !DIExpression(), !4457)
    #dbg_value(i32 %xlen.addr.0, !4459, !DIExpression(), !4457)
  %cmp5.not = icmp eq i32 %xlen.addr.0, 0, !dbg !4469
  br i1 %cmp5.not, label %return.loopexit, label %while.body, !dbg !4468

while.body:                                       ; preds = %while.cond
  %buffer_pos = getelementptr inbounds nuw i8, ptr %ctx, i32 16, !dbg !4470
  %2 = load i32, ptr %buffer_pos, align 4, !dbg !4470
  %sub6 = sub nsw i32 16, %2, !dbg !4473
  %cmp7.not = icmp sgt i32 %xlen.addr.0, %sub6, !dbg !4474
  br i1 %cmp7.not, label %if.end12, label %if.then8, !dbg !4474

if.then8:                                         ; preds = %while.body
  %xlen.addr.0.lcssa3 = phi i32 [ %xlen.addr.0, %while.body ]
  %offset.0.lcssa2 = phi i32 [ %offset.0, %while.body ], !dbg !4457
  %add.ptr = getelementptr inbounds nuw i8, ptr %x, i32 %offset.0.lcssa2, !dbg !4475
  %buffer_pos9 = getelementptr inbounds nuw i8, ptr %ctx, i32 16, !dbg !4477
  %3 = load i32, ptr %buffer_pos9, align 4, !dbg !4477
  %add.ptr10 = getelementptr inbounds i8, ptr %ctx, i32 %3, !dbg !4478
  %call = call ptr @memcpy(ptr noundef nonnull %add.ptr, ptr noundef %add.ptr10, i32 noundef %xlen.addr.0.lcssa3) #4, !dbg !4479
  %buffer_pos11 = getelementptr inbounds nuw i8, ptr %ctx, i32 16, !dbg !4480
  %4 = load i32, ptr %buffer_pos11, align 4, !dbg !4481
  %add = add i32 %4, %xlen.addr.0.lcssa3, !dbg !4481
  store i32 %add, ptr %buffer_pos11, align 4, !dbg !4481
  br label %return, !dbg !4482

if.end12:                                         ; preds = %while.body
  %add.ptr13 = getelementptr inbounds nuw i8, ptr %x, i32 %offset.0, !dbg !4483
  %buffer_pos16 = getelementptr inbounds nuw i8, ptr %ctx, i32 16, !dbg !4484
  %5 = load i32, ptr %buffer_pos16, align 4, !dbg !4484
  %add.ptr17 = getelementptr inbounds i8, ptr %ctx, i32 %5, !dbg !4485
  %sub19 = sub nsw i32 16, %5, !dbg !4486
  %call20 = call ptr @memcpy(ptr noundef nonnull %add.ptr13, ptr noundef %add.ptr17, i32 noundef %sub19) #4, !dbg !4487
  %buffer_pos21 = getelementptr inbounds nuw i8, ptr %ctx, i32 16, !dbg !4488
  %6 = load i32, ptr %buffer_pos21, align 4, !dbg !4488
  %sub22.neg = add i32 %6, -16, !dbg !4489
  %sub23 = add i32 %sub22.neg, %xlen.addr.0, !dbg !4490
    #dbg_value(i32 %sub23, !4459, !DIExpression(), !4457)
  %reass.sub = sub i32 %offset.0, %6, !dbg !4491
  %add26 = add i32 %reass.sub, 16, !dbg !4491
    #dbg_value(i32 %add26, !4467, !DIExpression(), !4457)
  %key = getelementptr inbounds nuw i8, ptr %ctx, i32 24, !dbg !4492
  %ctr = getelementptr inbounds nuw i8, ptr %ctx, i32 56, !dbg !4493
  call void @AES256_ECB(ptr noundef nonnull %key, ptr noundef nonnull %ctr, ptr noundef %ctx) #3, !dbg !4494
  %buffer_pos31 = getelementptr inbounds nuw i8, ptr %ctx, i32 16, !dbg !4495
  store i32 0, ptr %buffer_pos31, align 4, !dbg !4496
    #dbg_value(i32 15, !4497, !DIExpression(), !4499)
  br label %for.cond, !dbg !4500

for.cond:                                         ; preds = %if.then36, %if.end12
  %i.0 = phi i32 [ 15, %if.end12 ], [ %dec, %if.then36 ], !dbg !4501
    #dbg_value(i32 %i.0, !4497, !DIExpression(), !4499)
  %cmp32 = icmp ugt i32 %i.0, 11, !dbg !4502
  br i1 %cmp32, label %for.body, label %for.end.loopexit, !dbg !4504

for.body:                                         ; preds = %for.cond
  %ctr33 = getelementptr inbounds nuw i8, ptr %ctx, i32 56, !dbg !4505
  %arrayidx = getelementptr inbounds nuw [16 x i8], ptr %ctr33, i32 0, i32 %i.0, !dbg !4508
  %7 = load i8, ptr %arrayidx, align 1, !dbg !4508
  %cmp34 = icmp eq i8 %7, -1, !dbg !4509
  br i1 %cmp34, label %if.then36, label %if.else, !dbg !4509

if.then36:                                        ; preds = %for.body
  %ctr37 = getelementptr inbounds nuw i8, ptr %ctx, i32 56, !dbg !4510
  %arrayidx38 = getelementptr inbounds nuw [16 x i8], ptr %ctr37, i32 0, i32 %i.0, !dbg !4512
  store i8 0, ptr %arrayidx38, align 1, !dbg !4513
  %dec = add nsw i32 %i.0, -1, !dbg !4514
    #dbg_value(i32 %dec, !4497, !DIExpression(), !4499)
  br label %for.cond, !dbg !4515, !llvm.loop !4516

if.else:                                          ; preds = %for.body
  %i.0.lcssa1 = phi i32 [ %i.0, %for.body ], !dbg !4501
  %ctr39 = getelementptr inbounds nuw i8, ptr %ctx, i32 56, !dbg !4518
  %arrayidx40 = getelementptr inbounds nuw [16 x i8], ptr %ctr39, i32 0, i32 %i.0.lcssa1, !dbg !4520
  %8 = load i8, ptr %arrayidx40, align 1, !dbg !4521
  %inc = add i8 %8, 1, !dbg !4521
  store i8 %inc, ptr %arrayidx40, align 1, !dbg !4521
  br label %for.end, !dbg !4522

for.end.loopexit:                                 ; preds = %for.cond
  br label %for.end, !dbg !4468

for.end:                                          ; preds = %for.end.loopexit, %if.else
  br label %while.cond, !dbg !4468, !llvm.loop !4523

return.loopexit:                                  ; preds = %while.cond
  br label %return, !dbg !4525

return:                                           ; preds = %return.loopexit, %if.end, %entry, %if.then8
  %retval.0 = phi i32 [ 0, %if.then8 ], [ -2, %entry ], [ -3, %if.end ], [ 0, %return.loopexit ], !dbg !4457
  ret i32 %retval.0, !dbg !4525
}

; Function Attrs: nounwind
define dso_local void @randombytes_init(ptr noundef %entropy_input, ptr noundef %personalization_string, i32 noundef %security_strength) local_unnamed_addr #0 !dbg !4526 {
entry:
  %seed_material = alloca [48 x i8], align 1
    #dbg_value(ptr %entropy_input, !4529, !DIExpression(), !4530)
    #dbg_value(ptr %personalization_string, !4531, !DIExpression(), !4530)
    #dbg_value(i32 %security_strength, !4532, !DIExpression(), !4530)
    #dbg_declare(ptr %seed_material, !4533, !DIExpression(), !4534)
  %call = call ptr @memcpy(ptr noundef nonnull %seed_material, ptr noundef %entropy_input, i32 noundef 48) #4, !dbg !4535
  %tobool.not = icmp eq ptr %personalization_string, null, !dbg !4536
  br i1 %tobool.not, label %if.end, label %for.cond.preheader, !dbg !4536

for.cond.preheader:                               ; preds = %entry
  br label %for.cond, !dbg !4538

for.cond:                                         ; preds = %for.cond.preheader, %for.body
  %i.0 = phi i32 [ %inc, %for.body ], [ 0, %for.cond.preheader ], !dbg !4540
    #dbg_value(i32 %i.0, !4541, !DIExpression(), !4542)
  %exitcond = icmp ne i32 %i.0, 48, !dbg !4543
  br i1 %exitcond, label %for.body, label %if.end.loopexit, !dbg !4538

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw i8, ptr %personalization_string, i32 %i.0, !dbg !4545
  %0 = load i8, ptr %arrayidx, align 1, !dbg !4545
  %arrayidx1 = getelementptr inbounds nuw [48 x i8], ptr %seed_material, i32 0, i32 %i.0, !dbg !4547
  %1 = load i8, ptr %arrayidx1, align 1, !dbg !4548
  %xor1 = xor i8 %1, %0, !dbg !4548
  store i8 %xor1, ptr %arrayidx1, align 1, !dbg !4548
  %inc = add nuw nsw i32 %i.0, 1, !dbg !4549
    #dbg_value(i32 %inc, !4541, !DIExpression(), !4542)
  br label %for.cond, !dbg !4550, !llvm.loop !4551

if.end.loopexit:                                  ; preds = %for.cond
  br label %if.end, !dbg !4553

if.end:                                           ; preds = %if.end.loopexit, %entry
  %call4 = call ptr @memset(ptr noundef nonnull @DRBG_ctx, i32 noundef 0, i32 noundef 32) #4, !dbg !4553
  %call5 = call ptr @memset(ptr noundef nonnull getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 32), i32 noundef 0, i32 noundef 16) #4, !dbg !4554
  call void @AES256_CTR_DRBG_Update(ptr noundef nonnull %seed_material, ptr noundef nonnull @DRBG_ctx, ptr noundef nonnull getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 32)) #3, !dbg !4555
  store i32 1, ptr getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 48), align 4, !dbg !4556
  ret void, !dbg !4557
}

; Function Attrs: nounwind
define dso_local void @AES256_CTR_DRBG_Update(ptr noundef %provided_data, ptr noundef %Key, ptr noundef %V) local_unnamed_addr #0 !dbg !4558 {
entry:
  %temp = alloca [48 x i8], align 1
    #dbg_value(ptr %provided_data, !4561, !DIExpression(), !4562)
    #dbg_value(ptr %Key, !4563, !DIExpression(), !4562)
    #dbg_value(ptr %V, !4564, !DIExpression(), !4562)
    #dbg_declare(ptr %temp, !4565, !DIExpression(), !4566)
    #dbg_value(i32 0, !4567, !DIExpression(), !4569)
  br label %for.cond, !dbg !4570

for.cond:                                         ; preds = %for.end, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc9, %for.end ], !dbg !4571
    #dbg_value(i32 %i.0, !4567, !DIExpression(), !4569)
  %exitcond = icmp ne i32 %i.0, 3, !dbg !4572
  br i1 %exitcond, label %for.cond1.preheader, label %for.end10, !dbg !4574

for.cond1.preheader:                              ; preds = %for.cond
  br label %for.cond1, !dbg !4575

for.cond1:                                        ; preds = %for.cond1.preheader, %if.then
  %j.0 = phi i32 [ %dec, %if.then ], [ 15, %for.cond1.preheader ], !dbg !4578
    #dbg_value(i32 %j.0, !4579, !DIExpression(), !4580)
  %cmp2 = icmp sgt i32 %j.0, -1, !dbg !4581
  br i1 %cmp2, label %for.body3, label %for.end.loopexit, !dbg !4575

for.body3:                                        ; preds = %for.cond1
  %arrayidx = getelementptr inbounds nuw i8, ptr %V, i32 %j.0, !dbg !4583
  %0 = load i8, ptr %arrayidx, align 1, !dbg !4583
  %cmp4 = icmp eq i8 %0, -1, !dbg !4586
  br i1 %cmp4, label %if.then, label %if.else, !dbg !4586

if.then:                                          ; preds = %for.body3
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %V, i32 %j.0, !dbg !4587
  store i8 0, ptr %arrayidx6, align 1, !dbg !4589
  %dec = add nsw i32 %j.0, -1, !dbg !4590
    #dbg_value(i32 %dec, !4579, !DIExpression(), !4580)
  br label %for.cond1, !dbg !4591, !llvm.loop !4592

if.else:                                          ; preds = %for.body3
  %j.0.lcssa2 = phi i32 [ %j.0, %for.body3 ], !dbg !4578
  %arrayidx7 = getelementptr inbounds nuw i8, ptr %V, i32 %j.0.lcssa2, !dbg !4594
  %1 = load i8, ptr %arrayidx7, align 1, !dbg !4596
  %inc = add i8 %1, 1, !dbg !4596
  store i8 %inc, ptr %arrayidx7, align 1, !dbg !4596
  br label %for.end, !dbg !4597

for.end.loopexit:                                 ; preds = %for.cond1
  br label %for.end, !dbg !4598

for.end:                                          ; preds = %for.end.loopexit, %if.else
  %mul = shl nuw nsw i32 %i.0, 4, !dbg !4598
  %add.ptr = getelementptr inbounds nuw i8, ptr %temp, i32 %mul, !dbg !4599
  call void @AES256_ECB(ptr noundef %Key, ptr noundef %V, ptr noundef nonnull %add.ptr) #3, !dbg !4600
  %inc9 = add nuw nsw i32 %i.0, 1, !dbg !4601
    #dbg_value(i32 %inc9, !4567, !DIExpression(), !4569)
  br label %for.cond, !dbg !4602, !llvm.loop !4603

for.end10:                                        ; preds = %for.cond
  %cmp11.not = icmp eq ptr %provided_data, null, !dbg !4605
  br i1 %cmp11.not, label %if.end27, label %for.cond15.preheader, !dbg !4605

for.cond15.preheader:                             ; preds = %for.end10
  br label %for.cond15, !dbg !4607

for.cond15:                                       ; preds = %for.cond15.preheader, %for.body18
  %i14.0 = phi i32 [ %inc25, %for.body18 ], [ 0, %for.cond15.preheader ], !dbg !4609
    #dbg_value(i32 %i14.0, !4610, !DIExpression(), !4611)
  %exitcond3 = icmp ne i32 %i14.0, 48, !dbg !4612
  br i1 %exitcond3, label %for.body18, label %if.end27.loopexit, !dbg !4607

for.body18:                                       ; preds = %for.cond15
  %arrayidx19 = getelementptr inbounds nuw i8, ptr %provided_data, i32 %i14.0, !dbg !4614
  %2 = load i8, ptr %arrayidx19, align 1, !dbg !4614
  %arrayidx21 = getelementptr inbounds nuw [48 x i8], ptr %temp, i32 0, i32 %i14.0, !dbg !4616
  %3 = load i8, ptr %arrayidx21, align 1, !dbg !4617
  %xor1 = xor i8 %3, %2, !dbg !4617
  store i8 %xor1, ptr %arrayidx21, align 1, !dbg !4617
  %inc25 = add nuw nsw i32 %i14.0, 1, !dbg !4618
    #dbg_value(i32 %inc25, !4610, !DIExpression(), !4611)
  br label %for.cond15, !dbg !4619, !llvm.loop !4620

if.end27.loopexit:                                ; preds = %for.cond15
  br label %if.end27, !dbg !4622

if.end27:                                         ; preds = %if.end27.loopexit, %for.end10
  %call = call ptr @memcpy(ptr noundef %Key, ptr noundef nonnull %temp, i32 noundef 32) #4, !dbg !4622
  %add.ptr30 = getelementptr inbounds nuw i8, ptr %temp, i32 32, !dbg !4623
  %call31 = call ptr @memcpy(ptr noundef %V, ptr noundef nonnull %add.ptr30, i32 noundef 16) #4, !dbg !4624
  ret void, !dbg !4625
}

; Function Attrs: nounwind
define dso_local i32 @randombytes(ptr noundef %x, i64 noundef %xlen) local_unnamed_addr #0 !dbg !4626 {
entry:
  %block = alloca [16 x i8], align 1
    #dbg_value(ptr %x, !4629, !DIExpression(), !4630)
    #dbg_value(i64 %xlen, !4631, !DIExpression(), !4630)
    #dbg_declare(ptr %block, !4632, !DIExpression(), !4633)
    #dbg_value(i32 0, !4634, !DIExpression(), !4630)
  br label %while.cond, !dbg !4635

while.cond:                                       ; preds = %if.end15, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %i.1, %if.end15 ], !dbg !4630
  %xlen.addr.0 = phi i64 [ %xlen, %entry ], [ %xlen.addr.1, %if.end15 ]
    #dbg_value(i64 %xlen.addr.0, !4631, !DIExpression(), !4630)
    #dbg_value(i32 %i.0, !4634, !DIExpression(), !4630)
  %cmp.not = icmp eq i64 %xlen.addr.0, 0, !dbg !4636
  br i1 %cmp.not, label %while.end, label %for.cond.preheader, !dbg !4635

for.cond.preheader:                               ; preds = %while.cond
  br label %for.cond, !dbg !4637

for.cond:                                         ; preds = %for.cond.preheader, %if.then
  %j.0 = phi i32 [ %dec, %if.then ], [ 15, %for.cond.preheader ], !dbg !4640
    #dbg_value(i32 %j.0, !4641, !DIExpression(), !4642)
  %cmp1 = icmp sgt i32 %j.0, -1, !dbg !4643
  br i1 %cmp1, label %for.body, label %for.end.loopexit, !dbg !4637

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw [16 x i8], ptr getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 32), i32 0, i32 %j.0, !dbg !4645
  %0 = load i8, ptr %arrayidx, align 1, !dbg !4645
  %cmp2 = icmp eq i8 %0, -1, !dbg !4648
  br i1 %cmp2, label %if.then, label %if.else, !dbg !4648

if.then:                                          ; preds = %for.body
  %arrayidx4 = getelementptr inbounds nuw [16 x i8], ptr getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 32), i32 0, i32 %j.0, !dbg !4649
  store i8 0, ptr %arrayidx4, align 1, !dbg !4651
  %dec = add nsw i32 %j.0, -1, !dbg !4652
    #dbg_value(i32 %dec, !4641, !DIExpression(), !4642)
  br label %for.cond, !dbg !4653, !llvm.loop !4654

if.else:                                          ; preds = %for.body
  %j.0.lcssa1 = phi i32 [ %j.0, %for.body ], !dbg !4640
  %arrayidx5 = getelementptr inbounds nuw [16 x i8], ptr getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 32), i32 0, i32 %j.0.lcssa1, !dbg !4656
  %1 = load i8, ptr %arrayidx5, align 1, !dbg !4658
  %inc = add i8 %1, 1, !dbg !4658
  store i8 %inc, ptr %arrayidx5, align 1, !dbg !4658
  br label %for.end, !dbg !4659

for.end.loopexit:                                 ; preds = %for.cond
  br label %for.end, !dbg !4660

for.end:                                          ; preds = %for.end.loopexit, %if.else
  call void @AES256_ECB(ptr noundef nonnull @DRBG_ctx, ptr noundef nonnull getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 32), ptr noundef nonnull %block) #3, !dbg !4660
  %cmp6 = icmp ugt i64 %xlen.addr.0, 15, !dbg !4661
  br i1 %cmp6, label %if.then8, label %if.else10, !dbg !4661

if.then8:                                         ; preds = %for.end
  %add.ptr = getelementptr inbounds i8, ptr %x, i32 %i.0, !dbg !4663
  %call = call ptr @memcpy(ptr noundef %add.ptr, ptr noundef nonnull %block, i32 noundef 16) #4, !dbg !4665
  %add = add nsw i32 %i.0, 16, !dbg !4666
    #dbg_value(i32 %add, !4634, !DIExpression(), !4630)
  %sub = add i64 %xlen.addr.0, -16, !dbg !4667
    #dbg_value(i64 %sub, !4631, !DIExpression(), !4630)
  br label %if.end15, !dbg !4668

if.else10:                                        ; preds = %for.end
  %add.ptr11 = getelementptr inbounds i8, ptr %x, i32 %i.0, !dbg !4669
  %conv13 = trunc nuw nsw i64 %xlen.addr.0 to i32, !dbg !4671
  %call14 = call ptr @memcpy(ptr noundef %add.ptr11, ptr noundef nonnull %block, i32 noundef %conv13) #4, !dbg !4672
    #dbg_value(i64 0, !4631, !DIExpression(), !4630)
  br label %if.end15

if.end15:                                         ; preds = %if.else10, %if.then8
  %i.1 = phi i32 [ %add, %if.then8 ], [ %i.0, %if.else10 ], !dbg !4630
  %xlen.addr.1 = phi i64 [ %sub, %if.then8 ], [ 0, %if.else10 ], !dbg !4673
    #dbg_value(i64 %xlen.addr.1, !4631, !DIExpression(), !4630)
    #dbg_value(i32 %i.1, !4634, !DIExpression(), !4630)
  br label %while.cond, !dbg !4635, !llvm.loop !4674

while.end:                                        ; preds = %while.cond
  call void @AES256_CTR_DRBG_Update(ptr noundef null, ptr noundef nonnull @DRBG_ctx, ptr noundef nonnull getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 32)) #3, !dbg !4676
  %2 = load i32, ptr getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 48), align 4, !dbg !4677
  %inc16 = add nsw i32 %2, 1, !dbg !4677
  store i32 %inc16, ptr getelementptr inbounds nuw (i8, ptr @DRBG_ctx, i32 48), align 4, !dbg !4677
  ret i32 0, !dbg !4678
}

; Function Attrs: nounwind
define dso_local i32 @AES128_CTR(ptr noundef %output, i32 noundef %outputByteLen, ptr noundef %input, i32 noundef %inputByteLen) local_unnamed_addr #0 !dbg !4679 {
entry:
  %iv = alloca [16 x i8], align 1
  %schedule = alloca ptr, align 4
    #dbg_value(ptr %output, !4682, !DIExpression(), !4683)
    #dbg_value(i32 %outputByteLen, !4684, !DIExpression(), !4683)
    #dbg_value(ptr %input, !4685, !DIExpression(), !4683)
    #dbg_value(i32 %inputByteLen, !4686, !DIExpression(), !4683)
  %cmp.not = icmp eq i32 %inputByteLen, 0, !dbg !4687
  br i1 %cmp.not, label %cond.false, label %cond.end, !dbg !4687

cond.false:                                       ; preds = %entry
  call void @__assert_func(ptr noundef nonnull @.str.37, i32 noundef 1781, ptr noundef null, ptr noundef nonnull @.str.1) #4, !dbg !4687
  br label %cond.end, !dbg !4687

cond.end:                                         ; preds = %entry, %cond.false
    #dbg_declare(ptr %iv, !4688, !DIExpression(), !4690)
  call void @snova_memset(ptr %iv, i8 0, i32 16), !dbg !4690
    #dbg_value(ptr null, !4691, !DIExpression(), !4683)
  store ptr null, ptr %schedule, align 4, !dbg !4692
    #dbg_value(ptr %schedule, !4691, !DIExpression(DW_OP_deref), !4683)
  call fastcc void @oqs_aes128_load_schedule_c(ptr noundef %input, ptr noundef nonnull %schedule) #3, !dbg !4693
  %0 = load ptr, ptr %schedule, align 4, !dbg !4694
    #dbg_value(ptr %0, !4691, !DIExpression(), !4683)
  call fastcc void @oqs_aes128_ctr_enc_sch_c(ptr noundef nonnull %iv, i32 noundef 16, ptr noundef %0, ptr noundef %output, i32 noundef %outputByteLen) #3, !dbg !4695
  %1 = load ptr, ptr %schedule, align 4, !dbg !4696
    #dbg_value(ptr %1, !4691, !DIExpression(), !4683)
  call fastcc void @oqs_aes128_free_schedule_c(ptr noundef %1) #3, !dbg !4697
  ret i32 %outputByteLen, !dbg !4698
}

declare dso_local void @__assert_func(ptr noundef, i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind
define internal fastcc void @oqs_aes128_load_schedule_c(ptr noundef %key, ptr noundef nonnull %_schedule) unnamed_addr #0 !dbg !4699 {
entry:
  %skey = alloca [22 x i64], align 8
    #dbg_value(ptr %key, !4703, !DIExpression(), !4704)
    #dbg_value(ptr %_schedule, !4705, !DIExpression(), !4704)
  %call = call dereferenceable_or_null(720) ptr @malloc(i32 noundef 720) #5, !dbg !4706
  store ptr %call, ptr %_schedule, align 4, !dbg !4707
  %cmp = icmp eq ptr %call, null, !dbg !4708
  br i1 %cmp, label %if.then, label %do.end, !dbg !4708

if.then:                                          ; preds = %entry
  call void @exit(i32 noundef 1) #4, !dbg !4711
  br label %do.end, !dbg !4711

do.end:                                           ; preds = %entry, %if.then
  %0 = load ptr, ptr %_schedule, align 4, !dbg !4713
    #dbg_value(ptr %0, !4714, !DIExpression(), !4704)
    #dbg_declare(ptr %skey, !4715, !DIExpression(), !4719)
  call fastcc void @br_aes_ct64_keysched(ptr noundef nonnull %skey, ptr noundef %key, i32 noundef 16) #3, !dbg !4720
  call fastcc void @br_aes_ct64_skey_expand(ptr noundef %0, ptr noundef nonnull %skey, i32 noundef 10) #3, !dbg !4721
  ret void, !dbg !4722
}

; Function Attrs: nounwind
define internal fastcc void @oqs_aes128_ctr_enc_sch_c(ptr noundef nonnull %iv, i32 noundef %iv_len, ptr noundef %schedule, ptr noundef %out, i32 noundef %out_len) unnamed_addr #0 !dbg !4723 {
entry:
    #dbg_value(ptr %iv, !4726, !DIExpression(), !4727)
    #dbg_value(i32 16, !4728, !DIExpression(), !4727)
    #dbg_value(ptr %schedule, !4729, !DIExpression(), !4727)
    #dbg_value(ptr %out, !4730, !DIExpression(), !4727)
    #dbg_value(i32 %out_len, !4731, !DIExpression(), !4727)
    #dbg_value(ptr %schedule, !4732, !DIExpression(), !4727)
  call fastcc void @aes_ctr(ptr noundef %out, i32 noundef %out_len, ptr noundef %iv, i32 noundef 16, ptr noundef %schedule, i32 noundef 10) #3, !dbg !4733
  ret void, !dbg !4734
}

; Function Attrs: nounwind
define internal fastcc void @oqs_aes128_free_schedule_c(ptr noundef %schedule) unnamed_addr #0 !dbg !4735 {
entry:
    #dbg_value(ptr %schedule, !4738, !DIExpression(), !4739)
  %cmp.not = icmp eq ptr %schedule, null, !dbg !4740
  br i1 %cmp.not, label %if.end, label %if.then, !dbg !4740

if.then:                                          ; preds = %entry
    #dbg_value(ptr %schedule, !4742, !DIExpression(), !4744)
  call fastcc void @OQS_MEM_secure_free(ptr noundef nonnull %schedule, i32 noundef 720) #3, !dbg !4745
  br label %if.end, !dbg !4746

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !4747
}

; Function Attrs: nounwind
define internal fastcc void @OQS_MEM_secure_free(ptr noundef nonnull %ptr, i32 noundef range(i32 720, 977) %len) unnamed_addr #0 !dbg !4748 {
entry:
    #dbg_value(ptr %ptr, !4749, !DIExpression(), !4750)
    #dbg_value(i32 %len, !4751, !DIExpression(), !4750)
  %call = call ptr @memset(ptr noundef nonnull %ptr, i32 noundef 0, i32 noundef %len) #4, !dbg !4752
  call void @free(ptr noundef nonnull %ptr) #4, !dbg !4755
  ret void, !dbg !4756
}

declare dso_local void @free(ptr noundef) local_unnamed_addr #1

; Function Attrs: nounwind
define internal fastcc void @aes_ctr(ptr noundef %out, i32 noundef %outlen, ptr noundef nonnull %iv, i32 noundef %iv_len, ptr noundef %rkeys, i32 noundef %nrounds) unnamed_addr #0 !dbg !4757 {
entry:
  %ivw = alloca [16 x i32], align 4
  %tmp = alloca [64 x i8], align 1
    #dbg_value(ptr %out, !4761, !DIExpression(), !4762)
    #dbg_value(i32 %outlen, !4763, !DIExpression(), !4762)
    #dbg_value(ptr %iv, !4764, !DIExpression(), !4762)
    #dbg_value(i32 16, !4765, !DIExpression(), !4762)
    #dbg_value(ptr %rkeys, !4766, !DIExpression(), !4762)
    #dbg_value(i32 10, !4767, !DIExpression(), !4762)
    #dbg_declare(ptr %ivw, !4768, !DIExpression(), !4770)
  call fastcc void @br_range_dec32le(ptr noundef nonnull %ivw, i32 noundef 4, ptr noundef nonnull %iv) #3, !dbg !4771
  %add.ptr = getelementptr inbounds nuw i8, ptr %ivw, i32 16, !dbg !4775
  %call = call ptr @memcpy(ptr noundef nonnull %add.ptr, ptr noundef nonnull %ivw, i32 noundef 12) #4, !dbg !4776
  %add.ptr9 = getelementptr inbounds nuw i8, ptr %ivw, i32 32, !dbg !4777
  %call11 = call ptr @memcpy(ptr noundef nonnull %add.ptr9, ptr noundef nonnull %ivw, i32 noundef 12) #4, !dbg !4778
  %add.ptr13 = getelementptr inbounds nuw i8, ptr %ivw, i32 48, !dbg !4779
  %call15 = call ptr @memcpy(ptr noundef nonnull %add.ptr13, ptr noundef nonnull %ivw, i32 noundef 12) #4, !dbg !4780
  %arrayidx16 = getelementptr inbounds nuw i8, ptr %ivw, i32 12, !dbg !4781
  %0 = load i32, ptr %arrayidx16, align 4, !dbg !4781
  %call17 = call fastcc i32 @br_swap32(i32 noundef %0) #3, !dbg !4782
    #dbg_value(i32 %call17, !4783, !DIExpression(), !4762)
  %add = add i32 %call17, 1, !dbg !4784
  %call18 = call fastcc i32 @br_swap32(i32 noundef %add) #3, !dbg !4785
  %arrayidx19 = getelementptr inbounds nuw i8, ptr %ivw, i32 28, !dbg !4786
  store i32 %call18, ptr %arrayidx19, align 4, !dbg !4787
  %add20 = add i32 %call17, 2, !dbg !4788
  %call21 = call fastcc i32 @br_swap32(i32 noundef %add20) #3, !dbg !4789
  %arrayidx22 = getelementptr inbounds nuw i8, ptr %ivw, i32 44, !dbg !4790
  store i32 %call21, ptr %arrayidx22, align 4, !dbg !4791
  %add23 = add i32 %call17, 3, !dbg !4792
  %call24 = call fastcc i32 @br_swap32(i32 noundef %add23) #3, !dbg !4793
  %arrayidx25 = getelementptr inbounds nuw i8, ptr %ivw, i32 60, !dbg !4794
  store i32 %call24, ptr %arrayidx25, align 4, !dbg !4795
  br label %while.cond, !dbg !4796

while.cond:                                       ; preds = %while.body, %entry
  %outlen.addr.0 = phi i32 [ %outlen, %entry ], [ %sub, %while.body ]
  %out.addr.0 = phi ptr [ %out, %entry ], [ %add.ptr28, %while.body ]
    #dbg_value(ptr %out.addr.0, !4761, !DIExpression(), !4762)
    #dbg_value(i32 %outlen.addr.0, !4763, !DIExpression(), !4762)
  %cmp26 = icmp ugt i32 %outlen.addr.0, 63, !dbg !4797
  br i1 %cmp26, label %while.body, label %while.end, !dbg !4796

while.body:                                       ; preds = %while.cond
  call fastcc void @aes_ctr4x(ptr noundef %out.addr.0, ptr noundef nonnull %ivw, ptr noundef %rkeys, i32 noundef 10) #3, !dbg !4798
  %add.ptr28 = getelementptr inbounds nuw i8, ptr %out.addr.0, i32 64, !dbg !4800
    #dbg_value(ptr %add.ptr28, !4761, !DIExpression(), !4762)
  %sub = add i32 %outlen.addr.0, -64, !dbg !4801
    #dbg_value(i32 %sub, !4763, !DIExpression(), !4762)
  br label %while.cond, !dbg !4796, !llvm.loop !4802

while.end:                                        ; preds = %while.cond
  %outlen.addr.0.lcssa = phi i32 [ %outlen.addr.0, %while.cond ]
  %out.addr.0.lcssa = phi ptr [ %out.addr.0, %while.cond ]
  %cmp29.not = icmp eq i32 %outlen.addr.0.lcssa, 0, !dbg !4804
  br i1 %cmp29.not, label %if.end36, label %if.then30, !dbg !4804

if.then30:                                        ; preds = %while.end
    #dbg_declare(ptr %tmp, !4806, !DIExpression(), !4809)
  call fastcc void @aes_ctr4x(ptr noundef nonnull %tmp, ptr noundef nonnull %ivw, ptr noundef %rkeys, i32 noundef 10) #3, !dbg !4810
    #dbg_value(i32 0, !4811, !DIExpression(), !4762)
  br label %for.cond, !dbg !4812

for.cond:                                         ; preds = %for.body, %if.then30
  %i.0 = phi i32 [ 0, %if.then30 ], [ %inc, %for.body ], !dbg !4814
    #dbg_value(i32 %i.0, !4811, !DIExpression(), !4762)
  %cmp33 = icmp ult i32 %i.0, %outlen.addr.0.lcssa, !dbg !4815
  br i1 %cmp33, label %for.body, label %if.end36.loopexit, !dbg !4817

for.body:                                         ; preds = %for.cond
  %arrayidx34 = getelementptr inbounds nuw [64 x i8], ptr %tmp, i32 0, i32 %i.0, !dbg !4818
  %1 = load i8, ptr %arrayidx34, align 1, !dbg !4818
  %arrayidx35 = getelementptr inbounds nuw i8, ptr %out.addr.0.lcssa, i32 %i.0, !dbg !4820
  store i8 %1, ptr %arrayidx35, align 1, !dbg !4821
  %inc = add nuw nsw i32 %i.0, 1, !dbg !4822
    #dbg_value(i32 %inc, !4811, !DIExpression(), !4762)
  br label %for.cond, !dbg !4823, !llvm.loop !4824

if.end36.loopexit:                                ; preds = %for.cond
  br label %if.end36, !dbg !4826

if.end36:                                         ; preds = %if.end36.loopexit, %while.end
  ret void, !dbg !4826
}

; Function Attrs: nounwind
define internal fastcc void @br_range_dec32le(ptr noundef nonnull %v, i32 noundef range(i32 4, 17) %num, ptr noundef %src) unnamed_addr #0 !dbg !4827 {
entry:
    #dbg_value(ptr %v, !4831, !DIExpression(), !4832)
    #dbg_value(i32 %num, !4833, !DIExpression(), !4832)
    #dbg_value(ptr %src, !4834, !DIExpression(), !4832)
  br label %while.cond, !dbg !4835

while.cond:                                       ; preds = %while.body, %entry
  %src.addr.0 = phi ptr [ %src, %entry ], [ %add.ptr, %while.body ]
  %num.addr.0 = phi i32 [ %num, %entry ], [ %dec, %while.body ]
  %v.addr.0 = phi ptr [ %v, %entry ], [ %incdec.ptr, %while.body ]
    #dbg_value(ptr %v.addr.0, !4831, !DIExpression(), !4832)
    #dbg_value(i32 %num.addr.0, !4833, !DIExpression(), !4832)
    #dbg_value(ptr %src.addr.0, !4834, !DIExpression(), !4832)
    #dbg_value(i32 %num.addr.0, !4833, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !4832)
  %cmp.not = icmp eq i32 %num.addr.0, 0, !dbg !4836
  br i1 %cmp.not, label %while.end, label %while.body, !dbg !4835

while.body:                                       ; preds = %while.cond
  %dec = add nsw i32 %num.addr.0, -1, !dbg !4837
    #dbg_value(i32 %dec, !4833, !DIExpression(), !4832)
  %call = call fastcc i32 @br_dec32le(ptr noundef %src.addr.0) #3, !dbg !4838
  %incdec.ptr = getelementptr inbounds nuw i8, ptr %v.addr.0, i32 4, !dbg !4840
    #dbg_value(ptr %incdec.ptr, !4831, !DIExpression(), !4832)
  store i32 %call, ptr %v.addr.0, align 4, !dbg !4841
  %add.ptr = getelementptr inbounds nuw i8, ptr %src.addr.0, i32 4, !dbg !4842
    #dbg_value(ptr %add.ptr, !4834, !DIExpression(), !4832)
  br label %while.cond, !dbg !4835, !llvm.loop !4843

while.end:                                        ; preds = %while.cond
  ret void, !dbg !4845
}

declare dso_local void @exit(i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind
define internal fastcc i32 @br_swap32(i32 noundef %x) unnamed_addr #0 !dbg !4846 {
entry:
    #dbg_value(i32 %x, !4849, !DIExpression(), !4850)
    #dbg_value(!DIArgList(i32 %x, i32 %x), !4849, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_constu, 8, DW_OP_shl, DW_OP_constu, 18446744073692839680, DW_OP_and, DW_OP_LLVM_arg, 1, DW_OP_constu, 8, DW_OP_shr, DW_OP_constu, 16711935, DW_OP_and, DW_OP_or, DW_OP_stack_value), !4850)
  %0 = and i32 %x, 255, !dbg !4851
  %1 = shl i32 %0, 24, !dbg !4851
  %2 = and i32 %x, 65280, !dbg !4851
  %3 = shl i32 %2, 8, !dbg !4851
  %4 = and i32 %x, 16711680, !dbg !4851
  %5 = lshr i32 %4, 8, !dbg !4851
  %6 = and i32 %x, -16777216, !dbg !4851
  %7 = lshr i32 %6, 24, !dbg !4851
  %8 = or i32 %1, %3, !dbg !4851
  %9 = or i32 %8, %5, !dbg !4851
  %10 = or i32 %9, %7, !dbg !4851
  ret i32 %10, !dbg !4852
}

; Function Attrs: nounwind
define internal fastcc void @aes_ctr4x(ptr noundef %out, ptr noundef nonnull %ivw, ptr noundef %sk_exp, i32 noundef %nrounds) unnamed_addr #0 !dbg !4853 {
entry:
    #dbg_value(ptr %out, !4856, !DIExpression(), !4857)
    #dbg_value(ptr %ivw, !4858, !DIExpression(), !4857)
    #dbg_value(ptr %sk_exp, !4859, !DIExpression(), !4857)
    #dbg_value(i32 10, !4860, !DIExpression(), !4857)
  call fastcc void @aes_ecb4x(ptr noundef %out, ptr noundef %ivw, ptr noundef %sk_exp, i32 noundef 10) #3, !dbg !4861
  %add.ptr = getelementptr inbounds nuw i8, ptr %ivw, i32 12, !dbg !4862
  call fastcc void @inc4_be(ptr noundef nonnull %add.ptr) #3, !dbg !4863
  %add.ptr1 = getelementptr inbounds nuw i8, ptr %ivw, i32 28, !dbg !4864
  call fastcc void @inc4_be(ptr noundef nonnull %add.ptr1) #3, !dbg !4865
  %add.ptr2 = getelementptr inbounds nuw i8, ptr %ivw, i32 44, !dbg !4866
  call fastcc void @inc4_be(ptr noundef nonnull %add.ptr2) #3, !dbg !4867
  %add.ptr3 = getelementptr inbounds nuw i8, ptr %ivw, i32 60, !dbg !4868
  call fastcc void @inc4_be(ptr noundef nonnull %add.ptr3) #3, !dbg !4869
  ret void, !dbg !4870
}

; Function Attrs: nounwind
define internal fastcc void @aes_ecb4x(ptr noundef %out, ptr noundef nonnull %ivw, ptr noundef %sk_exp, i32 noundef range(i32 10, 15) %nrounds) unnamed_addr #0 !dbg !4871 {
entry:
  %w = alloca [16 x i32], align 4
  %q = alloca [8 x i64], align 8
    #dbg_value(ptr %out, !4876, !DIExpression(), !4877)
    #dbg_value(ptr %ivw, !4878, !DIExpression(), !4877)
    #dbg_value(ptr %sk_exp, !4879, !DIExpression(), !4877)
    #dbg_value(i32 %nrounds, !4880, !DIExpression(), !4877)
    #dbg_declare(ptr %w, !4881, !DIExpression(), !4882)
    #dbg_declare(ptr %q, !4883, !DIExpression(), !4887)
  %call = call ptr @memcpy(ptr noundef nonnull %w, ptr noundef nonnull %ivw, i32 noundef 64) #4, !dbg !4888
    #dbg_value(i32 0, !4889, !DIExpression(), !4877)
  br label %for.cond, !dbg !4890

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !4892
    #dbg_value(i32 %i.0, !4889, !DIExpression(), !4877)
  %exitcond = icmp ne i32 %i.0, 4, !dbg !4893
  br i1 %exitcond, label %for.body, label %for.end, !dbg !4895

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw [8 x i64], ptr %q, i32 0, i32 %i.0, !dbg !4896
  %add = or disjoint i32 %i.0, 4, !dbg !4898
  %arrayidx1 = getelementptr inbounds nuw [8 x i64], ptr %q, i32 0, i32 %add, !dbg !4899
  %add.ptr.idx = shl nuw nsw i32 %i.0, 4, !dbg !4900
  %add.ptr = getelementptr inbounds nuw i8, ptr %w, i32 %add.ptr.idx, !dbg !4900
  call fastcc void @br_aes_ct64_interleave_in(ptr noundef nonnull %arrayidx, ptr noundef nonnull %arrayidx1, ptr noundef nonnull %add.ptr) #3, !dbg !4901
  %inc = add nuw nsw i32 %i.0, 1, !dbg !4902
    #dbg_value(i32 %inc, !4889, !DIExpression(), !4877)
  br label %for.cond, !dbg !4903, !llvm.loop !4904

for.end:                                          ; preds = %for.cond
  call fastcc void @br_aes_ct64_ortho(ptr noundef nonnull %q) #3, !dbg !4906
  call fastcc void @add_round_key(ptr noundef nonnull %q, ptr noundef %sk_exp) #3, !dbg !4907
    #dbg_value(i32 1, !4889, !DIExpression(), !4877)
  br label %for.cond5, !dbg !4908

for.cond5:                                        ; preds = %for.body7, %for.end
  %i.1 = phi i32 [ 1, %for.end ], [ %inc15, %for.body7 ], !dbg !4910
    #dbg_value(i32 %i.1, !4889, !DIExpression(), !4877)
  %exitcond1 = icmp ne i32 %i.1, %nrounds, !dbg !4911
  br i1 %exitcond1, label %for.body7, label %for.end16, !dbg !4913

for.body7:                                        ; preds = %for.cond5
  call fastcc void @br_aes_ct64_bitslice_Sbox(ptr noundef nonnull %q) #3, !dbg !4914
  call fastcc void @shift_rows(ptr noundef nonnull %q) #3, !dbg !4916
  call fastcc void @mix_columns(ptr noundef nonnull %q) #3, !dbg !4917
  %add.ptr13.idx = shl nuw nsw i32 %i.1, 6, !dbg !4918
  %add.ptr13 = getelementptr inbounds nuw i8, ptr %sk_exp, i32 %add.ptr13.idx, !dbg !4918
  call fastcc void @add_round_key(ptr noundef nonnull %q, ptr noundef nonnull %add.ptr13) #3, !dbg !4919
  %inc15 = add nuw nsw i32 %i.1, 1, !dbg !4920
    #dbg_value(i32 %inc15, !4889, !DIExpression(), !4877)
  br label %for.cond5, !dbg !4921, !llvm.loop !4922

for.end16:                                        ; preds = %for.cond5
  call fastcc void @br_aes_ct64_bitslice_Sbox(ptr noundef nonnull %q) #3, !dbg !4924
  call fastcc void @shift_rows(ptr noundef nonnull %q) #3, !dbg !4925
  %add.ptr20.idx = shl nuw nsw i32 %nrounds, 6, !dbg !4926
  %add.ptr20 = getelementptr inbounds nuw i8, ptr %sk_exp, i32 %add.ptr20.idx, !dbg !4926
  call fastcc void @add_round_key(ptr noundef nonnull %q, ptr noundef nonnull %add.ptr20) #3, !dbg !4927
  call fastcc void @br_aes_ct64_ortho(ptr noundef nonnull %q) #3, !dbg !4928
    #dbg_value(i32 0, !4889, !DIExpression(), !4877)
  br label %for.cond22, !dbg !4929

for.cond22:                                       ; preds = %for.body24, %for.end16
  %i.2 = phi i32 [ 0, %for.end16 ], [ %inc32, %for.body24 ], !dbg !4931
    #dbg_value(i32 %i.2, !4889, !DIExpression(), !4877)
  %exitcond2 = icmp ne i32 %i.2, 4, !dbg !4932
  br i1 %exitcond2, label %for.body24, label %for.end33, !dbg !4934

for.body24:                                       ; preds = %for.cond22
  %add.ptr27.idx = shl nuw nsw i32 %i.2, 4, !dbg !4935
  %add.ptr27 = getelementptr inbounds nuw i8, ptr %w, i32 %add.ptr27.idx, !dbg !4935
  %arrayidx28 = getelementptr inbounds nuw [8 x i64], ptr %q, i32 0, i32 %i.2, !dbg !4937
  %0 = load i64, ptr %arrayidx28, align 8, !dbg !4937
  %add29 = or disjoint i32 %i.2, 4, !dbg !4938
  %arrayidx30 = getelementptr inbounds nuw [8 x i64], ptr %q, i32 0, i32 %add29, !dbg !4939
  %1 = load i64, ptr %arrayidx30, align 8, !dbg !4939
  call fastcc void @br_aes_ct64_interleave_out(ptr noundef nonnull %add.ptr27, i64 noundef %0, i64 noundef %1) #3, !dbg !4940
  %inc32 = add nuw nsw i32 %i.2, 1, !dbg !4941
    #dbg_value(i32 %inc32, !4889, !DIExpression(), !4877)
  br label %for.cond22, !dbg !4942, !llvm.loop !4943

for.end33:                                        ; preds = %for.cond22
  call fastcc void @br_range_enc32le(ptr noundef %out, ptr noundef nonnull %w, i32 noundef 16) #3, !dbg !4945
  ret void, !dbg !4946
}

; Function Attrs: nounwind
define internal fastcc void @inc4_be(ptr noundef nonnull %x) unnamed_addr #0 !dbg !4947 {
entry:
    #dbg_value(ptr %x, !4950, !DIExpression(), !4951)
  %0 = load i32, ptr %x, align 4, !dbg !4952
  %call = call fastcc i32 @br_swap32(i32 noundef %0) #3, !dbg !4953
  %add = add i32 %call, 4, !dbg !4954
    #dbg_value(i32 %add, !4955, !DIExpression(), !4951)
  %call1 = call fastcc i32 @br_swap32(i32 noundef %add) #3, !dbg !4956
  store i32 %call1, ptr %x, align 4, !dbg !4957
  ret void, !dbg !4958
}

; Function Attrs: nounwind
define internal fastcc void @br_aes_ct64_interleave_in(ptr noundef nonnull %q0, ptr noundef nonnull %q1, ptr noundef nonnull %w) unnamed_addr #0 !dbg !4959 {
entry:
    #dbg_value(ptr %q0, !4962, !DIExpression(), !4963)
    #dbg_value(ptr %q1, !4964, !DIExpression(), !4963)
    #dbg_value(ptr %w, !4965, !DIExpression(), !4963)
  %0 = load i32, ptr %w, align 4, !dbg !4966
  %conv = zext i32 %0 to i64, !dbg !4966
    #dbg_value(i64 %conv, !4967, !DIExpression(), !4963)
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %w, i32 4, !dbg !4968
  %1 = load i32, ptr %arrayidx1, align 4, !dbg !4968
  %conv2 = zext i32 %1 to i64, !dbg !4968
    #dbg_value(i64 %conv2, !4969, !DIExpression(), !4963)
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %w, i32 8, !dbg !4970
  %2 = load i32, ptr %arrayidx3, align 4, !dbg !4970
  %conv4 = zext i32 %2 to i64, !dbg !4970
    #dbg_value(i64 %conv4, !4971, !DIExpression(), !4963)
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %w, i32 12, !dbg !4972
  %3 = load i32, ptr %arrayidx5, align 4, !dbg !4972
  %conv6 = zext i32 %3 to i64, !dbg !4972
    #dbg_value(i64 %conv6, !4973, !DIExpression(), !4963)
  %shl = shl nuw nsw i64 %conv, 16, !dbg !4974
  %or = or i64 %shl, %conv, !dbg !4975
    #dbg_value(i64 %or, !4967, !DIExpression(), !4963)
  %shl7 = shl nuw nsw i64 %conv2, 16, !dbg !4976
  %or8 = or i64 %shl7, %conv2, !dbg !4977
    #dbg_value(i64 %or8, !4969, !DIExpression(), !4963)
  %shl9 = shl nuw nsw i64 %conv4, 16, !dbg !4978
  %or10 = or i64 %shl9, %conv4, !dbg !4979
    #dbg_value(i64 %or10, !4971, !DIExpression(), !4963)
  %shl11 = shl nuw nsw i64 %conv6, 16, !dbg !4980
  %or12 = or i64 %shl11, %conv6, !dbg !4981
    #dbg_value(i64 %or12, !4973, !DIExpression(), !4963)
  %and = and i64 %or, 281470681808895, !dbg !4982
    #dbg_value(i64 %and, !4967, !DIExpression(), !4963)
  %and13 = and i64 %or8, 281470681808895, !dbg !4983
    #dbg_value(i64 %and13, !4969, !DIExpression(), !4963)
  %and14 = and i64 %or10, 281470681808895, !dbg !4984
    #dbg_value(i64 %and14, !4971, !DIExpression(), !4963)
  %and15 = and i64 %or12, 281470681808895, !dbg !4985
    #dbg_value(i64 %and15, !4973, !DIExpression(), !4963)
  %shl16 = shl nuw nsw i64 %and, 8, !dbg !4986
  %or17 = or i64 %and, %shl16, !dbg !4987
    #dbg_value(i64 %or17, !4967, !DIExpression(), !4963)
  %shl18 = shl nuw nsw i64 %and13, 8, !dbg !4988
  %or19 = or i64 %and13, %shl18, !dbg !4989
    #dbg_value(i64 %or19, !4969, !DIExpression(), !4963)
    #dbg_value(!DIArgList(i64 %and14, i64 %and14), !4971, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 8, DW_OP_shl, DW_OP_or, DW_OP_stack_value), !4963)
    #dbg_value(!DIArgList(i64 %and15, i64 %and15), !4973, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 8, DW_OP_shl, DW_OP_or, DW_OP_stack_value), !4963)
  %and24 = and i64 %or17, 71777214294589695, !dbg !4990
    #dbg_value(i64 %and24, !4967, !DIExpression(), !4963)
  %and25 = and i64 %or19, 71777214294589695, !dbg !4991
    #dbg_value(i64 %and25, !4969, !DIExpression(), !4963)
    #dbg_value(!DIArgList(i64 %and14, i64 %and14), !4971, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 8, DW_OP_shl, DW_OP_or, DW_OP_constu, 71777214294589695, DW_OP_and, DW_OP_stack_value), !4963)
    #dbg_value(!DIArgList(i64 %and15, i64 %and15), !4973, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 8, DW_OP_shl, DW_OP_or, DW_OP_constu, 71777214294589695, DW_OP_and, DW_OP_stack_value), !4963)
  %4 = shl nuw i64 %and14, 16, !dbg !4992
  %5 = shl nuw nsw i64 %and14, 8, !dbg !4992
  %and26 = or i64 %4, %5, !dbg !4992
  %shl28 = and i64 %and26, -71777214294589696, !dbg !4992
  %or29 = or disjoint i64 %and24, %shl28, !dbg !4993
  store i64 %or29, ptr %q0, align 8, !dbg !4994
  %6 = shl nuw i64 %and15, 16, !dbg !4995
  %7 = shl nuw nsw i64 %and15, 8, !dbg !4995
  %and27 = or i64 %6, %7, !dbg !4995
  %shl30 = and i64 %and27, -71777214294589696, !dbg !4995
  %or31 = or disjoint i64 %and25, %shl30, !dbg !4996
  store i64 %or31, ptr %q1, align 8, !dbg !4997
  ret void, !dbg !4998
}

; Function Attrs: nounwind
define internal fastcc void @br_aes_ct64_ortho(ptr noundef nonnull %q) unnamed_addr #0 !dbg !4999 {
entry:
    #dbg_value(ptr %q, !5000, !DIExpression(), !5001)
  %0 = load i64, ptr %q, align 8, !dbg !5002
    #dbg_value(i64 %0, !5004, !DIExpression(), !5005)
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5002
  %1 = load i64, ptr %arrayidx1, align 8, !dbg !5002
    #dbg_value(i64 %1, !5006, !DIExpression(), !5005)
  %and = and i64 %0, 6148914691236517205, !dbg !5002
  %and2 = shl i64 %1, 1, !dbg !5002
  %shl = and i64 %and2, -6148914691236517206, !dbg !5002
  %or = or disjoint i64 %and, %shl, !dbg !5002
  store i64 %or, ptr %q, align 8, !dbg !5002
  %and4 = lshr i64 %0, 1, !dbg !5002
  %shr = and i64 %and4, 6148914691236517205, !dbg !5002
  %and5 = and i64 %1, -6148914691236517206, !dbg !5002
  %or6 = or disjoint i64 %shr, %and5, !dbg !5002
  %arrayidx7 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5002
  store i64 %or6, ptr %arrayidx7, align 8, !dbg !5002
  %arrayidx11 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5007
  %2 = load i64, ptr %arrayidx11, align 8, !dbg !5007
    #dbg_value(i64 %2, !5009, !DIExpression(), !5010)
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5007
  %3 = load i64, ptr %arrayidx12, align 8, !dbg !5007
    #dbg_value(i64 %3, !5011, !DIExpression(), !5010)
  %and13 = and i64 %2, 6148914691236517205, !dbg !5007
  %and14 = shl i64 %3, 1, !dbg !5007
  %shl15 = and i64 %and14, -6148914691236517206, !dbg !5007
  %or16 = or disjoint i64 %and13, %shl15, !dbg !5007
  %arrayidx17 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5007
  store i64 %or16, ptr %arrayidx17, align 8, !dbg !5007
  %and18 = lshr i64 %2, 1, !dbg !5007
  %shr19 = and i64 %and18, 6148914691236517205, !dbg !5007
  %and20 = and i64 %3, -6148914691236517206, !dbg !5007
  %or21 = or disjoint i64 %shr19, %and20, !dbg !5007
  %arrayidx22 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5007
  store i64 %or21, ptr %arrayidx22, align 8, !dbg !5007
  %arrayidx27 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5012
  %4 = load i64, ptr %arrayidx27, align 8, !dbg !5012
    #dbg_value(i64 %4, !5014, !DIExpression(), !5015)
  %arrayidx28 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5012
  %5 = load i64, ptr %arrayidx28, align 8, !dbg !5012
    #dbg_value(i64 %5, !5016, !DIExpression(), !5015)
  %and29 = and i64 %4, 6148914691236517205, !dbg !5012
  %and30 = shl i64 %5, 1, !dbg !5012
  %shl31 = and i64 %and30, -6148914691236517206, !dbg !5012
  %or32 = or disjoint i64 %and29, %shl31, !dbg !5012
  %arrayidx33 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5012
  store i64 %or32, ptr %arrayidx33, align 8, !dbg !5012
  %and34 = lshr i64 %4, 1, !dbg !5012
  %shr35 = and i64 %and34, 6148914691236517205, !dbg !5012
  %and36 = and i64 %5, -6148914691236517206, !dbg !5012
  %or37 = or disjoint i64 %shr35, %and36, !dbg !5012
  %arrayidx38 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5012
  store i64 %or37, ptr %arrayidx38, align 8, !dbg !5012
  %arrayidx43 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5017
  %6 = load i64, ptr %arrayidx43, align 8, !dbg !5017
    #dbg_value(i64 %6, !5019, !DIExpression(), !5020)
  %arrayidx44 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5017
  %7 = load i64, ptr %arrayidx44, align 8, !dbg !5017
    #dbg_value(i64 %7, !5021, !DIExpression(), !5020)
  %and45 = and i64 %6, 6148914691236517205, !dbg !5017
  %and46 = shl i64 %7, 1, !dbg !5017
  %shl47 = and i64 %and46, -6148914691236517206, !dbg !5017
  %or48 = or disjoint i64 %and45, %shl47, !dbg !5017
  %arrayidx49 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5017
  store i64 %or48, ptr %arrayidx49, align 8, !dbg !5017
  %and50 = lshr i64 %6, 1, !dbg !5017
  %shr51 = and i64 %and50, 6148914691236517205, !dbg !5017
  %and52 = and i64 %7, -6148914691236517206, !dbg !5017
  %or53 = or disjoint i64 %shr51, %and52, !dbg !5017
  %arrayidx54 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5017
  store i64 %or53, ptr %arrayidx54, align 8, !dbg !5017
  %8 = load i64, ptr %q, align 8, !dbg !5022
    #dbg_value(i64 %8, !5024, !DIExpression(), !5025)
  %arrayidx60 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5022
  %9 = load i64, ptr %arrayidx60, align 8, !dbg !5022
    #dbg_value(i64 %9, !5026, !DIExpression(), !5025)
  %and61 = and i64 %8, 3689348814741910323, !dbg !5022
  %and62 = shl i64 %9, 2, !dbg !5022
  %shl63 = and i64 %and62, -3689348814741910324, !dbg !5022
  %or64 = or disjoint i64 %and61, %shl63, !dbg !5022
  store i64 %or64, ptr %q, align 8, !dbg !5022
  %and66 = lshr i64 %8, 2, !dbg !5022
  %shr67 = and i64 %and66, 3689348814741910323, !dbg !5022
  %and68 = and i64 %9, -3689348814741910324, !dbg !5022
  %or69 = or disjoint i64 %shr67, %and68, !dbg !5022
  %arrayidx70 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5022
  store i64 %or69, ptr %arrayidx70, align 8, !dbg !5022
  %arrayidx75 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5027
  %10 = load i64, ptr %arrayidx75, align 8, !dbg !5027
    #dbg_value(i64 %10, !5029, !DIExpression(), !5030)
  %arrayidx76 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5027
  %11 = load i64, ptr %arrayidx76, align 8, !dbg !5027
    #dbg_value(i64 %11, !5031, !DIExpression(), !5030)
  %and77 = and i64 %10, 3689348814741910323, !dbg !5027
  %and78 = shl i64 %11, 2, !dbg !5027
  %shl79 = and i64 %and78, -3689348814741910324, !dbg !5027
  %or80 = or disjoint i64 %and77, %shl79, !dbg !5027
  %arrayidx81 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5027
  store i64 %or80, ptr %arrayidx81, align 8, !dbg !5027
  %and82 = lshr i64 %10, 2, !dbg !5027
  %shr83 = and i64 %and82, 3689348814741910323, !dbg !5027
  %and84 = and i64 %11, -3689348814741910324, !dbg !5027
  %or85 = or disjoint i64 %shr83, %and84, !dbg !5027
  %arrayidx86 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5027
  store i64 %or85, ptr %arrayidx86, align 8, !dbg !5027
  %arrayidx91 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5032
  %12 = load i64, ptr %arrayidx91, align 8, !dbg !5032
    #dbg_value(i64 %12, !5034, !DIExpression(), !5035)
  %arrayidx92 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5032
  %13 = load i64, ptr %arrayidx92, align 8, !dbg !5032
    #dbg_value(i64 %13, !5036, !DIExpression(), !5035)
  %and93 = and i64 %12, 3689348814741910323, !dbg !5032
  %and94 = shl i64 %13, 2, !dbg !5032
  %shl95 = and i64 %and94, -3689348814741910324, !dbg !5032
  %or96 = or disjoint i64 %and93, %shl95, !dbg !5032
  %arrayidx97 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5032
  store i64 %or96, ptr %arrayidx97, align 8, !dbg !5032
  %and98 = lshr i64 %12, 2, !dbg !5032
  %shr99 = and i64 %and98, 3689348814741910323, !dbg !5032
  %and100 = and i64 %13, -3689348814741910324, !dbg !5032
  %or101 = or disjoint i64 %shr99, %and100, !dbg !5032
  %arrayidx102 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5032
  store i64 %or101, ptr %arrayidx102, align 8, !dbg !5032
  %arrayidx107 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5037
  %14 = load i64, ptr %arrayidx107, align 8, !dbg !5037
    #dbg_value(i64 %14, !5039, !DIExpression(), !5040)
  %arrayidx108 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5037
  %15 = load i64, ptr %arrayidx108, align 8, !dbg !5037
    #dbg_value(i64 %15, !5041, !DIExpression(), !5040)
  %and109 = and i64 %14, 3689348814741910323, !dbg !5037
  %and110 = shl i64 %15, 2, !dbg !5037
  %shl111 = and i64 %and110, -3689348814741910324, !dbg !5037
  %or112 = or disjoint i64 %and109, %shl111, !dbg !5037
  %arrayidx113 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5037
  store i64 %or112, ptr %arrayidx113, align 8, !dbg !5037
  %and114 = lshr i64 %14, 2, !dbg !5037
  %shr115 = and i64 %and114, 3689348814741910323, !dbg !5037
  %and116 = and i64 %15, -3689348814741910324, !dbg !5037
  %or117 = or disjoint i64 %shr115, %and116, !dbg !5037
  %arrayidx118 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5037
  store i64 %or117, ptr %arrayidx118, align 8, !dbg !5037
  %16 = load i64, ptr %q, align 8, !dbg !5042
    #dbg_value(i64 %16, !5044, !DIExpression(), !5045)
  %arrayidx124 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5042
  %17 = load i64, ptr %arrayidx124, align 8, !dbg !5042
    #dbg_value(i64 %17, !5046, !DIExpression(), !5045)
  %and125 = and i64 %16, 1085102592571150095, !dbg !5042
  %and126 = shl i64 %17, 4, !dbg !5042
  %shl127 = and i64 %and126, -1085102592571150096, !dbg !5042
  %or128 = or disjoint i64 %and125, %shl127, !dbg !5042
  store i64 %or128, ptr %q, align 8, !dbg !5042
  %and130 = lshr i64 %16, 4, !dbg !5042
  %shr131 = and i64 %and130, 1085102592571150095, !dbg !5042
  %and132 = and i64 %17, -1085102592571150096, !dbg !5042
  %or133 = or disjoint i64 %shr131, %and132, !dbg !5042
  %arrayidx134 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5042
  store i64 %or133, ptr %arrayidx134, align 8, !dbg !5042
  %arrayidx139 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5047
  %18 = load i64, ptr %arrayidx139, align 8, !dbg !5047
    #dbg_value(i64 %18, !5049, !DIExpression(), !5050)
  %arrayidx140 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5047
  %19 = load i64, ptr %arrayidx140, align 8, !dbg !5047
    #dbg_value(i64 %19, !5051, !DIExpression(), !5050)
  %and141 = and i64 %18, 1085102592571150095, !dbg !5047
  %and142 = shl i64 %19, 4, !dbg !5047
  %shl143 = and i64 %and142, -1085102592571150096, !dbg !5047
  %or144 = or disjoint i64 %and141, %shl143, !dbg !5047
  %arrayidx145 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5047
  store i64 %or144, ptr %arrayidx145, align 8, !dbg !5047
  %and146 = lshr i64 %18, 4, !dbg !5047
  %shr147 = and i64 %and146, 1085102592571150095, !dbg !5047
  %and148 = and i64 %19, -1085102592571150096, !dbg !5047
  %or149 = or disjoint i64 %shr147, %and148, !dbg !5047
  %arrayidx150 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5047
  store i64 %or149, ptr %arrayidx150, align 8, !dbg !5047
  %arrayidx155 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5052
  %20 = load i64, ptr %arrayidx155, align 8, !dbg !5052
    #dbg_value(i64 %20, !5054, !DIExpression(), !5055)
  %arrayidx156 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5052
  %21 = load i64, ptr %arrayidx156, align 8, !dbg !5052
    #dbg_value(i64 %21, !5056, !DIExpression(), !5055)
  %and157 = and i64 %20, 1085102592571150095, !dbg !5052
  %and158 = shl i64 %21, 4, !dbg !5052
  %shl159 = and i64 %and158, -1085102592571150096, !dbg !5052
  %or160 = or disjoint i64 %and157, %shl159, !dbg !5052
  %arrayidx161 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5052
  store i64 %or160, ptr %arrayidx161, align 8, !dbg !5052
  %and162 = lshr i64 %20, 4, !dbg !5052
  %shr163 = and i64 %and162, 1085102592571150095, !dbg !5052
  %and164 = and i64 %21, -1085102592571150096, !dbg !5052
  %or165 = or disjoint i64 %shr163, %and164, !dbg !5052
  %arrayidx166 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5052
  store i64 %or165, ptr %arrayidx166, align 8, !dbg !5052
  %arrayidx171 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5057
  %22 = load i64, ptr %arrayidx171, align 8, !dbg !5057
    #dbg_value(i64 %22, !5059, !DIExpression(), !5060)
  %arrayidx172 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5057
  %23 = load i64, ptr %arrayidx172, align 8, !dbg !5057
    #dbg_value(i64 %23, !5061, !DIExpression(), !5060)
  %and173 = and i64 %22, 1085102592571150095, !dbg !5057
  %and174 = shl i64 %23, 4, !dbg !5057
  %shl175 = and i64 %and174, -1085102592571150096, !dbg !5057
  %or176 = or disjoint i64 %and173, %shl175, !dbg !5057
  %arrayidx177 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5057
  store i64 %or176, ptr %arrayidx177, align 8, !dbg !5057
  %and178 = lshr i64 %22, 4, !dbg !5057
  %shr179 = and i64 %and178, 1085102592571150095, !dbg !5057
  %and180 = and i64 %23, -1085102592571150096, !dbg !5057
  %or181 = or disjoint i64 %shr179, %and180, !dbg !5057
  %arrayidx182 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5057
  store i64 %or181, ptr %arrayidx182, align 8, !dbg !5057
  ret void, !dbg !5062
}

; Function Attrs: nounwind
define internal fastcc void @add_round_key(ptr noundef nonnull %q, ptr noundef %sk) unnamed_addr #0 !dbg !5063 {
entry:
    #dbg_value(ptr %q, !5066, !DIExpression(), !5067)
    #dbg_value(ptr %sk, !5068, !DIExpression(), !5067)
  %0 = load i64, ptr %sk, align 8, !dbg !5069
  %1 = load i64, ptr %q, align 8, !dbg !5070
  %xor = xor i64 %1, %0, !dbg !5070
  store i64 %xor, ptr %q, align 8, !dbg !5070
  %arrayidx2 = getelementptr inbounds nuw i8, ptr %sk, i32 8, !dbg !5071
  %2 = load i64, ptr %arrayidx2, align 8, !dbg !5071
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5072
  %3 = load i64, ptr %arrayidx3, align 8, !dbg !5073
  %xor4 = xor i64 %3, %2, !dbg !5073
  store i64 %xor4, ptr %arrayidx3, align 8, !dbg !5073
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %sk, i32 16, !dbg !5074
  %4 = load i64, ptr %arrayidx5, align 8, !dbg !5074
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5075
  %5 = load i64, ptr %arrayidx6, align 8, !dbg !5076
  %xor7 = xor i64 %5, %4, !dbg !5076
  store i64 %xor7, ptr %arrayidx6, align 8, !dbg !5076
  %arrayidx8 = getelementptr inbounds nuw i8, ptr %sk, i32 24, !dbg !5077
  %6 = load i64, ptr %arrayidx8, align 8, !dbg !5077
  %arrayidx9 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5078
  %7 = load i64, ptr %arrayidx9, align 8, !dbg !5079
  %xor10 = xor i64 %7, %6, !dbg !5079
  store i64 %xor10, ptr %arrayidx9, align 8, !dbg !5079
  %arrayidx11 = getelementptr inbounds nuw i8, ptr %sk, i32 32, !dbg !5080
  %8 = load i64, ptr %arrayidx11, align 8, !dbg !5080
  %arrayidx12 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5081
  %9 = load i64, ptr %arrayidx12, align 8, !dbg !5082
  %xor13 = xor i64 %9, %8, !dbg !5082
  store i64 %xor13, ptr %arrayidx12, align 8, !dbg !5082
  %arrayidx14 = getelementptr inbounds nuw i8, ptr %sk, i32 40, !dbg !5083
  %10 = load i64, ptr %arrayidx14, align 8, !dbg !5083
  %arrayidx15 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5084
  %11 = load i64, ptr %arrayidx15, align 8, !dbg !5085
  %xor16 = xor i64 %11, %10, !dbg !5085
  store i64 %xor16, ptr %arrayidx15, align 8, !dbg !5085
  %arrayidx17 = getelementptr inbounds nuw i8, ptr %sk, i32 48, !dbg !5086
  %12 = load i64, ptr %arrayidx17, align 8, !dbg !5086
  %arrayidx18 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5087
  %13 = load i64, ptr %arrayidx18, align 8, !dbg !5088
  %xor19 = xor i64 %13, %12, !dbg !5088
  store i64 %xor19, ptr %arrayidx18, align 8, !dbg !5088
  %arrayidx20 = getelementptr inbounds nuw i8, ptr %sk, i32 56, !dbg !5089
  %14 = load i64, ptr %arrayidx20, align 8, !dbg !5089
  %arrayidx21 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5090
  %15 = load i64, ptr %arrayidx21, align 8, !dbg !5091
  %xor22 = xor i64 %15, %14, !dbg !5091
  store i64 %xor22, ptr %arrayidx21, align 8, !dbg !5091
  ret void, !dbg !5092
}

; Function Attrs: nounwind
define internal fastcc void @br_aes_ct64_bitslice_Sbox(ptr noundef nonnull %q) unnamed_addr #0 !dbg !5093 {
entry:
    #dbg_value(ptr %q, !5094, !DIExpression(), !5095)
  %arrayidx = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5096
  %0 = load i64, ptr %arrayidx, align 8, !dbg !5096
    #dbg_value(i64 %0, !5097, !DIExpression(), !5095)
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5098
  %1 = load i64, ptr %arrayidx1, align 8, !dbg !5098
    #dbg_value(i64 %1, !5099, !DIExpression(), !5095)
  %arrayidx2 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5100
  %2 = load i64, ptr %arrayidx2, align 8, !dbg !5100
    #dbg_value(i64 %2, !5101, !DIExpression(), !5095)
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5102
  %3 = load i64, ptr %arrayidx3, align 8, !dbg !5102
    #dbg_value(i64 %3, !5103, !DIExpression(), !5095)
  %arrayidx4 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5104
  %4 = load i64, ptr %arrayidx4, align 8, !dbg !5104
    #dbg_value(i64 %4, !5105, !DIExpression(), !5095)
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5106
  %5 = load i64, ptr %arrayidx5, align 8, !dbg !5106
    #dbg_value(i64 %5, !5107, !DIExpression(), !5095)
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5108
  %6 = load i64, ptr %arrayidx6, align 8, !dbg !5108
    #dbg_value(i64 %6, !5109, !DIExpression(), !5095)
  %7 = load i64, ptr %q, align 8, !dbg !5110
    #dbg_value(i64 %7, !5111, !DIExpression(), !5095)
  %xor = xor i64 %3, %5, !dbg !5112
    #dbg_value(i64 %xor, !5113, !DIExpression(), !5095)
  %xor8 = xor i64 %0, %6, !dbg !5114
    #dbg_value(i64 %xor8, !5115, !DIExpression(), !5095)
  %xor9 = xor i64 %0, %3, !dbg !5116
    #dbg_value(i64 %xor9, !5117, !DIExpression(), !5095)
  %xor10 = xor i64 %0, %5, !dbg !5118
    #dbg_value(i64 %xor10, !5119, !DIExpression(), !5095)
  %xor11 = xor i64 %1, %2, !dbg !5120
    #dbg_value(i64 %xor11, !5121, !DIExpression(), !5095)
  %xor12 = xor i64 %xor11, %7, !dbg !5122
    #dbg_value(i64 %xor12, !5123, !DIExpression(), !5095)
  %xor13 = xor i64 %xor12, %3, !dbg !5124
    #dbg_value(i64 %xor13, !5125, !DIExpression(), !5095)
  %xor14 = xor i64 %xor8, %xor, !dbg !5126
    #dbg_value(i64 %xor14, !5127, !DIExpression(), !5095)
  %xor15 = xor i64 %xor12, %0, !dbg !5128
    #dbg_value(i64 %xor15, !5129, !DIExpression(), !5095)
  %xor16 = xor i64 %xor12, %6, !dbg !5130
    #dbg_value(i64 %xor16, !5131, !DIExpression(), !5095)
  %xor17 = xor i64 %xor16, %xor10, !dbg !5132
    #dbg_value(i64 %xor17, !5133, !DIExpression(), !5095)
  %xor18 = xor i64 %4, %xor14, !dbg !5134
    #dbg_value(i64 %xor18, !5135, !DIExpression(), !5095)
  %xor19 = xor i64 %xor18, %5, !dbg !5136
    #dbg_value(i64 %xor19, !5137, !DIExpression(), !5095)
  %xor20 = xor i64 %xor18, %1, !dbg !5138
    #dbg_value(i64 %xor20, !5139, !DIExpression(), !5095)
  %xor21 = xor i64 %xor19, %7, !dbg !5140
    #dbg_value(i64 %xor21, !5141, !DIExpression(), !5095)
  %xor22 = xor i64 %xor19, %xor11, !dbg !5142
    #dbg_value(i64 %xor22, !5143, !DIExpression(), !5095)
  %xor23 = xor i64 %xor20, %xor9, !dbg !5144
    #dbg_value(i64 %xor23, !5145, !DIExpression(), !5095)
  %xor24 = xor i64 %7, %xor23, !dbg !5146
    #dbg_value(i64 %xor24, !5147, !DIExpression(), !5095)
  %xor25 = xor i64 %xor22, %xor23, !dbg !5148
    #dbg_value(i64 %xor25, !5149, !DIExpression(), !5095)
    #dbg_value(!DIArgList(i64 %xor22, i64 %xor10), !5150, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
  %xor27 = xor i64 %xor11, %xor23, !dbg !5151
    #dbg_value(i64 %xor27, !5152, !DIExpression(), !5095)
    #dbg_value(!DIArgList(i64 %xor8, i64 %xor27), !5153, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
    #dbg_value(!DIArgList(i64 %0, i64 %xor27), !5154, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
  %and = and i64 %xor14, %xor19, !dbg !5155
    #dbg_value(i64 %and, !5156, !DIExpression(), !5095)
  %and30 = and i64 %xor17, %xor21, !dbg !5157
    #dbg_value(i64 %and30, !5158, !DIExpression(), !5095)
  %xor31 = xor i64 %and30, %and, !dbg !5159
    #dbg_value(i64 %xor31, !5160, !DIExpression(), !5095)
  %and32 = and i64 %xor13, %7, !dbg !5161
    #dbg_value(i64 %and32, !5162, !DIExpression(), !5095)
    #dbg_value(!DIArgList(i64 %and32, i64 %and), !5163, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
  %and34 = and i64 %xor8, %xor27, !dbg !5164
    #dbg_value(i64 %and34, !5165, !DIExpression(), !5095)
  %and35 = and i64 %xor16, %xor12, !dbg !5166
    #dbg_value(i64 %and35, !5167, !DIExpression(), !5095)
    #dbg_value(!DIArgList(i64 %and35, i64 %and34), !5168, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
  %and37 = and i64 %xor15, %xor24, !dbg !5169
    #dbg_value(i64 %and37, !5170, !DIExpression(), !5095)
    #dbg_value(!DIArgList(i64 %and37, i64 %and34), !5171, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
  %and39 = and i64 %xor9, %xor23, !dbg !5172
    #dbg_value(i64 %and39, !5173, !DIExpression(), !5095)
  %and40 = and i64 %xor, %xor25, !dbg !5174
    #dbg_value(i64 %and40, !5175, !DIExpression(), !5095)
  %xor41 = xor i64 %and40, %and39, !dbg !5176
    #dbg_value(i64 %xor41, !5177, !DIExpression(), !5095)
  %and42 = and i64 %xor10, %xor22, !dbg !5178
    #dbg_value(i64 %and42, !5179, !DIExpression(), !5095)
  %xor43 = xor i64 %and42, %and39, !dbg !5180
    #dbg_value(i64 %xor43, !5181, !DIExpression(), !5095)
  %xor44 = xor i64 %xor31, %xor41, !dbg !5182
    #dbg_value(i64 %xor44, !5183, !DIExpression(), !5095)
    #dbg_value(!DIArgList(i64 %and32, i64 %xor43, i64 %and), !5184, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
    #dbg_value(!DIArgList(i64 %and35, i64 %xor41, i64 %and34), !5185, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
    #dbg_value(!DIArgList(i64 %and37, i64 %xor43, i64 %and34), !5186, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 2, DW_OP_xor, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
  %xor48 = xor i64 %xor44, %xor20, !dbg !5187
    #dbg_value(i64 %xor48, !5188, !DIExpression(), !5095)
  %8 = xor i64 %xor10, %and32, !dbg !5189
  %9 = xor i64 %8, %xor22, !dbg !5189
  %10 = xor i64 %9, %and, !dbg !5189
  %xor49 = xor i64 %10, %xor43, !dbg !5189
    #dbg_value(i64 %xor49, !5190, !DIExpression(), !5095)
  %11 = xor i64 %xor27, %and35, !dbg !5191
  %12 = xor i64 %11, %xor8, !dbg !5191
  %13 = xor i64 %12, %and34, !dbg !5191
  %xor50 = xor i64 %13, %xor41, !dbg !5191
    #dbg_value(i64 %xor50, !5192, !DIExpression(), !5095)
  %14 = xor i64 %xor27, %and37, !dbg !5193
  %15 = xor i64 %14, %0, !dbg !5193
  %16 = xor i64 %15, %and34, !dbg !5193
  %xor51 = xor i64 %16, %xor43, !dbg !5193
    #dbg_value(i64 %xor51, !5194, !DIExpression(), !5095)
  %xor52 = xor i64 %xor48, %xor49, !dbg !5195
    #dbg_value(i64 %xor52, !5196, !DIExpression(), !5095)
  %and53 = and i64 %xor48, %xor50, !dbg !5197
    #dbg_value(i64 %and53, !5198, !DIExpression(), !5095)
  %xor54 = xor i64 %xor51, %and53, !dbg !5199
    #dbg_value(i64 %xor54, !5200, !DIExpression(), !5095)
  %and55 = and i64 %xor52, %xor54, !dbg !5201
    #dbg_value(i64 %and55, !5202, !DIExpression(), !5095)
  %xor56 = xor i64 %and55, %xor49, !dbg !5203
    #dbg_value(i64 %xor56, !5204, !DIExpression(), !5095)
  %xor57 = xor i64 %xor50, %xor51, !dbg !5205
    #dbg_value(i64 %xor57, !5206, !DIExpression(), !5095)
  %xor58 = xor i64 %xor49, %and53, !dbg !5207
    #dbg_value(i64 %xor58, !5208, !DIExpression(), !5095)
  %and59 = and i64 %xor58, %xor57, !dbg !5209
    #dbg_value(i64 %and59, !5210, !DIExpression(), !5095)
  %xor60 = xor i64 %and59, %xor51, !dbg !5211
    #dbg_value(i64 %xor60, !5212, !DIExpression(), !5095)
  %xor61 = xor i64 %xor50, %xor60, !dbg !5213
    #dbg_value(i64 %xor61, !5214, !DIExpression(), !5095)
  %xor62 = xor i64 %and59, %and53, !dbg !5215
    #dbg_value(i64 %xor62, !5216, !DIExpression(), !5095)
  %and63 = and i64 %xor51, %xor62, !dbg !5217
    #dbg_value(i64 %and63, !5218, !DIExpression(), !5095)
  %xor64 = xor i64 %and63, %xor61, !dbg !5219
    #dbg_value(i64 %xor64, !5220, !DIExpression(), !5095)
  %xor65 = xor i64 %xor54, %and63, !dbg !5221
    #dbg_value(i64 %xor65, !5222, !DIExpression(), !5095)
  %and66 = and i64 %xor56, %xor65, !dbg !5223
    #dbg_value(i64 %and66, !5224, !DIExpression(), !5095)
  %xor67 = xor i64 %xor52, %and66, !dbg !5225
    #dbg_value(i64 %xor67, !5226, !DIExpression(), !5095)
  %xor68 = xor i64 %xor67, %xor64, !dbg !5227
    #dbg_value(i64 %xor68, !5228, !DIExpression(), !5095)
  %xor69 = xor i64 %xor56, %xor60, !dbg !5229
    #dbg_value(i64 %xor69, !5230, !DIExpression(), !5095)
  %xor70 = xor i64 %xor56, %xor67, !dbg !5231
    #dbg_value(i64 %xor70, !5232, !DIExpression(), !5095)
  %xor71 = xor i64 %and63, %xor50, !dbg !5233
    #dbg_value(i64 %xor71, !5234, !DIExpression(), !5095)
  %xor72 = xor i64 %xor69, %xor68, !dbg !5235
    #dbg_value(i64 %xor72, !5236, !DIExpression(), !5095)
  %and73 = and i64 %xor71, %xor19, !dbg !5237
    #dbg_value(i64 %and73, !5238, !DIExpression(), !5095)
  %and74 = and i64 %xor64, %xor21, !dbg !5239
    #dbg_value(i64 %and74, !5240, !DIExpression(), !5095)
  %and75 = and i64 %xor60, %7, !dbg !5241
    #dbg_value(i64 %and75, !5242, !DIExpression(), !5095)
  %and76 = and i64 %xor70, %xor27, !dbg !5243
    #dbg_value(i64 %and76, !5244, !DIExpression(), !5095)
  %and77 = and i64 %xor67, %xor12, !dbg !5245
    #dbg_value(i64 %and77, !5246, !DIExpression(), !5095)
  %and78 = and i64 %xor56, %xor24, !dbg !5247
    #dbg_value(i64 %and78, !5248, !DIExpression(), !5095)
  %and79 = and i64 %xor69, %xor23, !dbg !5249
    #dbg_value(i64 %and79, !5250, !DIExpression(), !5095)
  %and80 = and i64 %xor72, %xor25, !dbg !5251
    #dbg_value(i64 %and80, !5252, !DIExpression(), !5095)
  %and81 = and i64 %xor68, %xor22, !dbg !5253
    #dbg_value(i64 %and81, !5254, !DIExpression(), !5095)
  %and82 = and i64 %xor71, %xor14, !dbg !5255
    #dbg_value(i64 %and82, !5256, !DIExpression(), !5095)
  %and83 = and i64 %xor64, %xor17, !dbg !5257
    #dbg_value(i64 %and83, !5258, !DIExpression(), !5095)
  %and84 = and i64 %xor60, %xor13, !dbg !5259
    #dbg_value(i64 %and84, !5260, !DIExpression(), !5095)
  %and85 = and i64 %xor70, %xor8, !dbg !5261
    #dbg_value(i64 %and85, !5262, !DIExpression(), !5095)
  %and86 = and i64 %xor67, %xor16, !dbg !5263
    #dbg_value(i64 %and86, !5264, !DIExpression(), !5095)
  %and87 = and i64 %xor56, %xor15, !dbg !5265
    #dbg_value(i64 %and87, !5266, !DIExpression(), !5095)
  %and88 = and i64 %xor69, %xor9, !dbg !5267
    #dbg_value(i64 %and88, !5268, !DIExpression(), !5095)
  %and89 = and i64 %xor72, %xor, !dbg !5269
    #dbg_value(i64 %and89, !5270, !DIExpression(), !5095)
  %and90 = and i64 %xor68, %xor10, !dbg !5271
    #dbg_value(i64 %and90, !5272, !DIExpression(), !5095)
  %xor91 = xor i64 %and88, %and89, !dbg !5273
    #dbg_value(i64 %xor91, !5274, !DIExpression(), !5095)
  %xor92 = xor i64 %and83, %and84, !dbg !5275
    #dbg_value(i64 %xor92, !5276, !DIExpression(), !5095)
  %xor93 = xor i64 %and78, %and86, !dbg !5277
    #dbg_value(i64 %xor93, !5278, !DIExpression(), !5095)
  %xor94 = xor i64 %and82, %and83, !dbg !5279
    #dbg_value(i64 %xor94, !5280, !DIExpression(), !5095)
  %xor95 = xor i64 %and75, %and85, !dbg !5281
    #dbg_value(i64 %xor95, !5282, !DIExpression(), !5095)
  %xor96 = xor i64 %and75, %and78, !dbg !5283
    #dbg_value(i64 %xor96, !5284, !DIExpression(), !5095)
  %xor97 = xor i64 %and80, %and81, !dbg !5285
    #dbg_value(i64 %xor97, !5286, !DIExpression(), !5095)
  %xor98 = xor i64 %and73, %and76, !dbg !5287
    #dbg_value(i64 %xor98, !5288, !DIExpression(), !5095)
  %xor99 = xor i64 %and79, %and80, !dbg !5289
    #dbg_value(i64 %xor99, !5290, !DIExpression(), !5095)
  %xor100 = xor i64 %and89, %and90, !dbg !5291
    #dbg_value(i64 %xor100, !5292, !DIExpression(), !5095)
  %xor101 = xor i64 %and85, %xor93, !dbg !5293
    #dbg_value(i64 %xor101, !5294, !DIExpression(), !5095)
  %xor102 = xor i64 %xor95, %xor98, !dbg !5295
    #dbg_value(i64 %xor102, !5296, !DIExpression(), !5095)
  %xor103 = xor i64 %and77, %xor91, !dbg !5297
    #dbg_value(i64 %xor103, !5298, !DIExpression(), !5095)
  %xor104 = xor i64 %and76, %xor99, !dbg !5299
    #dbg_value(i64 %xor104, !5300, !DIExpression(), !5095)
  %xor105 = xor i64 %xor91, %xor102, !dbg !5301
    #dbg_value(i64 %xor105, !5302, !DIExpression(), !5095)
  %xor106 = xor i64 %and87, %xor102, !dbg !5303
    #dbg_value(i64 %xor106, !5304, !DIExpression(), !5095)
  %xor107 = xor i64 %xor97, %xor103, !dbg !5305
    #dbg_value(i64 %xor107, !5306, !DIExpression(), !5095)
  %xor108 = xor i64 %xor94, %xor103, !dbg !5307
    #dbg_value(i64 %xor108, !5308, !DIExpression(), !5095)
  %xor109 = xor i64 %and77, %xor104, !dbg !5309
    #dbg_value(i64 %xor109, !5310, !DIExpression(), !5095)
  %xor110 = xor i64 %xor106, %xor107, !dbg !5311
    #dbg_value(i64 %xor110, !5312, !DIExpression(), !5095)
  %xor111 = xor i64 %and74, %xor108, !dbg !5313
    #dbg_value(i64 %xor111, !5314, !DIExpression(), !5095)
  %xor112 = xor i64 %xor104, %xor108, !dbg !5315
    #dbg_value(i64 %xor112, !5316, !DIExpression(), !5095)
  %17 = xor i64 %xor107, %xor101, !dbg !5317
  %xor113 = xor i64 %17, -1, !dbg !5317
    #dbg_value(i64 %xor113, !5318, !DIExpression(), !5095)
  %18 = xor i64 %xor105, %xor93, !dbg !5319
  %xor115 = xor i64 %18, -1, !dbg !5319
    #dbg_value(i64 %xor115, !5320, !DIExpression(), !5095)
    #dbg_value(!DIArgList(i64 %xor109, i64 %xor110), !5321, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_stack_value), !5095)
  %xor117 = xor i64 %xor98, %xor111, !dbg !5322
    #dbg_value(i64 %xor117, !5323, !DIExpression(), !5095)
  %xor118 = xor i64 %xor96, %xor111, !dbg !5324
    #dbg_value(i64 %xor118, !5325, !DIExpression(), !5095)
  %xor119 = xor i64 %xor92, %xor110, !dbg !5326
    #dbg_value(i64 %xor119, !5327, !DIExpression(), !5095)
  %19 = xor i64 %xor117, %xor109, !dbg !5328
  %xor121 = xor i64 %19, -1, !dbg !5328
    #dbg_value(i64 %xor121, !5329, !DIExpression(), !5095)
  %20 = xor i64 %xor110, %xor100, !dbg !5330
  %21 = xor i64 %20, %xor109, !dbg !5330
  %xor123 = xor i64 %21, -1, !dbg !5330
    #dbg_value(i64 %xor123, !5331, !DIExpression(), !5095)
  %arrayidx124 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5332
  store i64 %xor112, ptr %arrayidx124, align 8, !dbg !5333
  %arrayidx125 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5334
  store i64 %xor121, ptr %arrayidx125, align 8, !dbg !5335
  %arrayidx126 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5336
  store i64 %xor123, ptr %arrayidx126, align 8, !dbg !5337
  %arrayidx127 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5338
  store i64 %xor117, ptr %arrayidx127, align 8, !dbg !5339
  %arrayidx128 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5340
  store i64 %xor118, ptr %arrayidx128, align 8, !dbg !5341
  %arrayidx129 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5342
  store i64 %xor119, ptr %arrayidx129, align 8, !dbg !5343
  %arrayidx130 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5344
  store i64 %xor113, ptr %arrayidx130, align 8, !dbg !5345
  store i64 %xor115, ptr %q, align 8, !dbg !5346
  ret void, !dbg !5347
}

; Function Attrs: nounwind
define internal fastcc void @shift_rows(ptr noundef nonnull %q) unnamed_addr #0 !dbg !5348 {
entry:
    #dbg_value(ptr %q, !5349, !DIExpression(), !5350)
    #dbg_value(i32 0, !5351, !DIExpression(), !5350)
  br label %for.cond, !dbg !5352

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !5354
    #dbg_value(i32 %i.0, !5351, !DIExpression(), !5350)
  %exitcond = icmp ne i32 %i.0, 8, !dbg !5355
  br i1 %exitcond, label %for.body, label %for.end, !dbg !5357

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw i64, ptr %q, i32 %i.0, !dbg !5358
  %0 = load i64, ptr %arrayidx, align 8, !dbg !5358
    #dbg_value(i64 %0, !5360, !DIExpression(), !5361)
  %and = and i64 %0, 65535, !dbg !5362
  %and1 = lshr i64 %0, 4, !dbg !5363
  %shr = and i64 %and1, 268369920, !dbg !5363
  %or = or disjoint i64 %and, %shr, !dbg !5364
  %and2 = shl i64 %0, 12, !dbg !5365
  %shl = and i64 %and2, 4026531840, !dbg !5365
  %or3 = or disjoint i64 %or, %shl, !dbg !5366
  %and4 = lshr i64 %0, 8, !dbg !5367
  %shr5 = and i64 %and4, 1095216660480, !dbg !5367
  %or6 = or disjoint i64 %or3, %shr5, !dbg !5368
  %and7 = shl i64 %0, 8, !dbg !5369
  %shl8 = and i64 %and7, 280375465082880, !dbg !5369
  %or9 = or disjoint i64 %or6, %shl8, !dbg !5370
  %and10 = lshr i64 %0, 12, !dbg !5371
  %shr11 = and i64 %and10, 4222124650659840, !dbg !5371
  %or12 = or disjoint i64 %or9, %shr11, !dbg !5372
  %and13 = shl i64 %0, 4, !dbg !5373
  %shl14 = and i64 %and13, -4503599627370496, !dbg !5373
  %or15 = or i64 %or12, %shl14, !dbg !5374
  %arrayidx16 = getelementptr inbounds nuw i64, ptr %q, i32 %i.0, !dbg !5375
  store i64 %or15, ptr %arrayidx16, align 8, !dbg !5376
  %inc = add nuw nsw i32 %i.0, 1, !dbg !5377
    #dbg_value(i32 %inc, !5351, !DIExpression(), !5350)
  br label %for.cond, !dbg !5378, !llvm.loop !5379

for.end:                                          ; preds = %for.cond
  ret void, !dbg !5381
}

; Function Attrs: nounwind
define internal fastcc void @mix_columns(ptr noundef nonnull %q) unnamed_addr #0 !dbg !5382 {
entry:
    #dbg_value(ptr %q, !5383, !DIExpression(), !5384)
  %0 = load i64, ptr %q, align 8, !dbg !5385
    #dbg_value(i64 %0, !5386, !DIExpression(), !5384)
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5387
  %1 = load i64, ptr %arrayidx1, align 8, !dbg !5387
    #dbg_value(i64 %1, !5388, !DIExpression(), !5384)
  %arrayidx2 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5389
  %2 = load i64, ptr %arrayidx2, align 8, !dbg !5389
    #dbg_value(i64 %2, !5390, !DIExpression(), !5384)
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5391
  %3 = load i64, ptr %arrayidx3, align 8, !dbg !5391
    #dbg_value(i64 %3, !5392, !DIExpression(), !5384)
  %arrayidx4 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5393
  %4 = load i64, ptr %arrayidx4, align 8, !dbg !5393
    #dbg_value(i64 %4, !5394, !DIExpression(), !5384)
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5395
  %5 = load i64, ptr %arrayidx5, align 8, !dbg !5395
    #dbg_value(i64 %5, !5396, !DIExpression(), !5384)
  %arrayidx6 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5397
  %6 = load i64, ptr %arrayidx6, align 8, !dbg !5397
    #dbg_value(i64 %6, !5398, !DIExpression(), !5384)
  %arrayidx7 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5399
  %7 = load i64, ptr %arrayidx7, align 8, !dbg !5399
    #dbg_value(i64 %7, !5400, !DIExpression(), !5384)
  %8 = shl i64 %0, 48, !dbg !5401
  %9 = lshr i64 %0, 16, !dbg !5401
  %10 = or i64 %8, %9, !dbg !5401
    #dbg_value(i64 %10, !5402, !DIExpression(), !5384)
  %11 = shl i64 %1, 48, !dbg !5403
  %12 = lshr i64 %1, 16, !dbg !5403
  %13 = or i64 %11, %12, !dbg !5403
    #dbg_value(i64 %13, !5404, !DIExpression(), !5384)
  %14 = shl i64 %2, 48, !dbg !5405
  %15 = lshr i64 %2, 16, !dbg !5405
  %16 = or i64 %14, %15, !dbg !5405
    #dbg_value(i64 %16, !5406, !DIExpression(), !5384)
  %17 = shl i64 %3, 48, !dbg !5407
  %18 = lshr i64 %3, 16, !dbg !5407
  %19 = or i64 %17, %18, !dbg !5407
    #dbg_value(i64 %19, !5408, !DIExpression(), !5384)
  %20 = shl i64 %4, 48, !dbg !5409
  %21 = lshr i64 %4, 16, !dbg !5409
  %22 = or i64 %20, %21, !dbg !5409
    #dbg_value(i64 %22, !5410, !DIExpression(), !5384)
  %23 = shl i64 %5, 48, !dbg !5411
  %24 = lshr i64 %5, 16, !dbg !5411
  %25 = or i64 %23, %24, !dbg !5411
    #dbg_value(i64 %25, !5412, !DIExpression(), !5384)
  %26 = shl i64 %6, 48, !dbg !5413
  %27 = lshr i64 %6, 16, !dbg !5413
  %28 = or i64 %26, %27, !dbg !5413
    #dbg_value(i64 %28, !5414, !DIExpression(), !5384)
  %29 = shl i64 %7, 48, !dbg !5415
  %30 = lshr i64 %7, 16, !dbg !5415
  %31 = or i64 %29, %30, !dbg !5415
    #dbg_value(i64 %31, !5416, !DIExpression(), !5384)
  %xor30 = xor i64 %0, %10, !dbg !5417
  %call = call fastcc i64 @rotr32(i64 noundef %xor30) #3, !dbg !5418
  %32 = xor i64 %31, %call, !dbg !5419
  %33 = xor i64 %32, %7, !dbg !5419
  %xor31 = xor i64 %33, %10, !dbg !5419
  store i64 %xor31, ptr %q, align 8, !dbg !5420
  %xor37 = xor i64 %1, %13, !dbg !5421
  %call38 = call fastcc i64 @rotr32(i64 noundef %xor37) #3, !dbg !5422
  %34 = xor i64 %10, %call38, !dbg !5423
  %35 = xor i64 %34, %0, !dbg !5423
  %36 = xor i64 %35, %7, !dbg !5423
  %37 = xor i64 %36, %31, !dbg !5423
  %xor39 = xor i64 %37, %13, !dbg !5423
  %arrayidx40 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5424
  store i64 %xor39, ptr %arrayidx40, align 8, !dbg !5425
  %xor43 = xor i64 %2, %16, !dbg !5426
  %call44 = call fastcc i64 @rotr32(i64 noundef %xor43) #3, !dbg !5427
  %38 = xor i64 %13, %call44, !dbg !5428
  %39 = xor i64 %38, %1, !dbg !5428
  %xor45 = xor i64 %39, %16, !dbg !5428
  %arrayidx46 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5429
  store i64 %xor45, ptr %arrayidx46, align 8, !dbg !5430
  %xor51 = xor i64 %3, %19, !dbg !5431
  %call52 = call fastcc i64 @rotr32(i64 noundef %xor51) #3, !dbg !5432
  %40 = xor i64 %16, %call52, !dbg !5433
  %41 = xor i64 %40, %2, !dbg !5433
  %42 = xor i64 %41, %7, !dbg !5433
  %43 = xor i64 %42, %31, !dbg !5433
  %xor53 = xor i64 %43, %19, !dbg !5433
  %arrayidx54 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5434
  store i64 %xor53, ptr %arrayidx54, align 8, !dbg !5435
  %xor59 = xor i64 %4, %22, !dbg !5436
  %call60 = call fastcc i64 @rotr32(i64 noundef %xor59) #3, !dbg !5437
  %44 = xor i64 %19, %call60, !dbg !5438
  %45 = xor i64 %44, %3, !dbg !5438
  %46 = xor i64 %45, %7, !dbg !5438
  %47 = xor i64 %46, %31, !dbg !5438
  %xor61 = xor i64 %47, %22, !dbg !5438
  %arrayidx62 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5439
  store i64 %xor61, ptr %arrayidx62, align 8, !dbg !5440
  %xor65 = xor i64 %5, %25, !dbg !5441
  %call66 = call fastcc i64 @rotr32(i64 noundef %xor65) #3, !dbg !5442
  %48 = xor i64 %22, %call66, !dbg !5443
  %49 = xor i64 %48, %4, !dbg !5443
  %xor67 = xor i64 %49, %25, !dbg !5443
  %arrayidx68 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5444
  store i64 %xor67, ptr %arrayidx68, align 8, !dbg !5445
  %xor71 = xor i64 %6, %28, !dbg !5446
  %call72 = call fastcc i64 @rotr32(i64 noundef %xor71) #3, !dbg !5447
  %50 = xor i64 %25, %call72, !dbg !5448
  %51 = xor i64 %50, %5, !dbg !5448
  %xor73 = xor i64 %51, %28, !dbg !5448
  %arrayidx74 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5449
  store i64 %xor73, ptr %arrayidx74, align 8, !dbg !5450
  %xor77 = xor i64 %7, %31, !dbg !5451
  %call78 = call fastcc i64 @rotr32(i64 noundef %xor77) #3, !dbg !5452
  %52 = xor i64 %28, %call78, !dbg !5453
  %53 = xor i64 %52, %6, !dbg !5453
  %xor79 = xor i64 %53, %31, !dbg !5453
  %arrayidx80 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5454
  store i64 %xor79, ptr %arrayidx80, align 8, !dbg !5455
  ret void, !dbg !5456
}

; Function Attrs: nounwind
define internal fastcc void @br_aes_ct64_interleave_out(ptr noundef nonnull %w, i64 noundef %q0, i64 noundef %q1) unnamed_addr #0 !dbg !5457 {
entry:
    #dbg_value(ptr %w, !5460, !DIExpression(), !5461)
    #dbg_value(i64 %q0, !5462, !DIExpression(), !5461)
    #dbg_value(i64 %q1, !5463, !DIExpression(), !5461)
  %and = and i64 %q0, 71777214294589695, !dbg !5464
    #dbg_value(i64 %and, !5465, !DIExpression(), !5461)
  %and1 = and i64 %q1, 71777214294589695, !dbg !5466
    #dbg_value(i64 %and1, !5467, !DIExpression(), !5461)
  %shr = lshr i64 %q0, 8, !dbg !5468
  %and2 = and i64 %shr, 71776119077928960, !dbg !5469
    #dbg_value(i64 %shr, !5470, !DIExpression(DW_OP_constu, 71777214294589440, DW_OP_and, DW_OP_stack_value), !5461)
  %shr3 = lshr i64 %q1, 8, !dbg !5471
  %and4 = and i64 %shr3, 71776119077928960, !dbg !5472
    #dbg_value(i64 %shr3, !5473, !DIExpression(DW_OP_constu, 71777214294589440, DW_OP_and, DW_OP_stack_value), !5461)
  %shr5 = lshr i64 %and, 8, !dbg !5474
  %or = or disjoint i64 %and, %shr5, !dbg !5475
    #dbg_value(i64 %or, !5465, !DIExpression(), !5461)
  %shr6 = lshr i64 %and1, 8, !dbg !5476
  %or7 = or disjoint i64 %and1, %shr6, !dbg !5477
    #dbg_value(i64 %or7, !5467, !DIExpression(), !5461)
  %0 = and i64 %q0, 280375465148160, !dbg !5478
  %1 = or disjoint i64 %and2, %0, !dbg !5478
  %or9 = lshr exact i64 %1, 8, !dbg !5478
    #dbg_value(!DIArgList(i64 %and2, i64 %0), !5470, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_constu, 8, DW_OP_shr, DW_OP_stack_value), !5461)
  %2 = and i64 %q1, 280375465148160, !dbg !5479
  %3 = or disjoint i64 %and4, %2, !dbg !5479
  %or11 = lshr exact i64 %3, 8, !dbg !5479
    #dbg_value(!DIArgList(i64 %and4, i64 %2), !5473, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_or, DW_OP_constu, 8, DW_OP_shr, DW_OP_stack_value), !5461)
  %and12 = and i64 %or, 281470681808895, !dbg !5480
    #dbg_value(i64 %and12, !5465, !DIExpression(), !5461)
  %and13 = and i64 %or7, 281470681808895, !dbg !5481
    #dbg_value(i64 %and13, !5467, !DIExpression(), !5461)
    #dbg_value(i64 %or9, !5470, !DIExpression(), !5461)
    #dbg_value(i64 %or11, !5473, !DIExpression(), !5461)
  %shr16 = lshr i64 %and12, 16, !dbg !5482
  %or181 = or disjoint i64 %and12, %shr16, !dbg !5483
  %or18 = trunc i64 %or181 to i32, !dbg !5483
  store i32 %or18, ptr %w, align 4, !dbg !5484
  %shr20 = lshr i64 %and13, 16, !dbg !5485
  %or222 = or disjoint i64 %and13, %shr20, !dbg !5486
  %or22 = trunc i64 %or222 to i32, !dbg !5486
  %arrayidx23 = getelementptr inbounds nuw i8, ptr %w, i32 4, !dbg !5487
  store i32 %or22, ptr %arrayidx23, align 4, !dbg !5488
  %shr25 = lshr i64 %1, 24, !dbg !5489
  %or273 = or disjoint i64 %or9, %shr25, !dbg !5490
  %or27 = trunc i64 %or273 to i32, !dbg !5490
  %arrayidx28 = getelementptr inbounds nuw i8, ptr %w, i32 8, !dbg !5491
  store i32 %or27, ptr %arrayidx28, align 4, !dbg !5492
  %shr30 = lshr i64 %3, 24, !dbg !5493
  %or324 = or disjoint i64 %or11, %shr30, !dbg !5494
  %or32 = trunc i64 %or324 to i32, !dbg !5494
  %arrayidx33 = getelementptr inbounds nuw i8, ptr %w, i32 12, !dbg !5495
  store i32 %or32, ptr %arrayidx33, align 4, !dbg !5496
  ret void, !dbg !5497
}

; Function Attrs: nounwind
define internal fastcc void @br_range_enc32le(ptr noundef %dst, ptr noundef nonnull %v, i32 noundef %num) unnamed_addr #0 !dbg !5498 {
entry:
    #dbg_value(ptr %dst, !5501, !DIExpression(), !5502)
    #dbg_value(ptr %v, !5503, !DIExpression(), !5502)
    #dbg_value(i32 16, !5504, !DIExpression(), !5502)
  br label %while.cond, !dbg !5505

while.cond:                                       ; preds = %while.body, %entry
  %num.addr.0 = phi i32 [ 16, %entry ], [ %dec, %while.body ]
  %v.addr.0 = phi ptr [ %v, %entry ], [ %incdec.ptr, %while.body ]
  %dst.addr.0 = phi ptr [ %dst, %entry ], [ %add.ptr, %while.body ]
    #dbg_value(ptr %dst.addr.0, !5501, !DIExpression(), !5502)
    #dbg_value(ptr %v.addr.0, !5503, !DIExpression(), !5502)
    #dbg_value(i32 %num.addr.0, !5504, !DIExpression(), !5502)
    #dbg_value(i32 %num.addr.0, !5504, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !5502)
  %cmp.not = icmp eq i32 %num.addr.0, 0, !dbg !5506
  br i1 %cmp.not, label %while.end, label %while.body, !dbg !5505

while.body:                                       ; preds = %while.cond
  %dec = add nsw i32 %num.addr.0, -1, !dbg !5507
    #dbg_value(i32 %dec, !5504, !DIExpression(), !5502)
  %incdec.ptr = getelementptr inbounds nuw i8, ptr %v.addr.0, i32 4, !dbg !5508
    #dbg_value(ptr %incdec.ptr, !5503, !DIExpression(), !5502)
  %0 = load i32, ptr %v.addr.0, align 4, !dbg !5510
  call fastcc void @br_enc32le(ptr noundef %dst.addr.0, i32 noundef %0) #3, !dbg !5511
  %add.ptr = getelementptr inbounds nuw i8, ptr %dst.addr.0, i32 4, !dbg !5512
    #dbg_value(ptr %add.ptr, !5501, !DIExpression(), !5502)
  br label %while.cond, !dbg !5505, !llvm.loop !5513

while.end:                                        ; preds = %while.cond
  ret void, !dbg !5515
}

; Function Attrs: nounwind
define internal fastcc void @br_enc32le(ptr noundef %dst, i32 noundef %x) unnamed_addr #0 !dbg !5516 {
entry:
    #dbg_value(ptr %dst, !5519, !DIExpression(), !5520)
    #dbg_value(i32 %x, !5521, !DIExpression(), !5520)
  %conv = trunc i32 %x to i8, !dbg !5522
  store i8 %conv, ptr %dst, align 1, !dbg !5523
  %shr = lshr i32 %x, 8, !dbg !5524
  %conv1 = trunc i32 %shr to i8, !dbg !5525
  %arrayidx2 = getelementptr inbounds nuw i8, ptr %dst, i32 1, !dbg !5526
  store i8 %conv1, ptr %arrayidx2, align 1, !dbg !5527
  %shr3 = lshr i32 %x, 16, !dbg !5528
  %conv4 = trunc i32 %shr3 to i8, !dbg !5529
  %arrayidx5 = getelementptr inbounds nuw i8, ptr %dst, i32 2, !dbg !5530
  store i8 %conv4, ptr %arrayidx5, align 1, !dbg !5531
  %shr6 = lshr i32 %x, 24, !dbg !5532
  %conv7 = trunc nuw i32 %shr6 to i8, !dbg !5533
  %arrayidx8 = getelementptr inbounds nuw i8, ptr %dst, i32 3, !dbg !5534
  store i8 %conv7, ptr %arrayidx8, align 1, !dbg !5535
  ret void, !dbg !5536
}

; Function Attrs: nounwind
define internal fastcc i64 @rotr32(i64 noundef %x) unnamed_addr #0 !dbg !5537 {
entry:
    #dbg_value(i64 %x, !5540, !DIExpression(), !5541)
  %0 = shl i64 %x, 32, !dbg !5542
  %1 = lshr i64 %x, 32, !dbg !5542
  %2 = or i64 %0, %1, !dbg !5542
  ret i64 %2, !dbg !5543
}

; Function Attrs: nounwind
define internal fastcc i32 @br_dec32le(ptr noundef %src) unnamed_addr #0 !dbg !5544 {
entry:
    #dbg_value(ptr %src, !5547, !DIExpression(), !5548)
  %0 = load i8, ptr %src, align 1, !dbg !5549
  %conv = zext i8 %0 to i32, !dbg !5550
  %arrayidx1 = getelementptr inbounds nuw i8, ptr %src, i32 1, !dbg !5551
  %1 = load i8, ptr %arrayidx1, align 1, !dbg !5551
  %conv2 = zext i8 %1 to i32, !dbg !5552
  %shl = shl nuw nsw i32 %conv2, 8, !dbg !5553
  %or = or disjoint i32 %shl, %conv, !dbg !5554
  %arrayidx3 = getelementptr inbounds nuw i8, ptr %src, i32 2, !dbg !5555
  %2 = load i8, ptr %arrayidx3, align 1, !dbg !5555
  %conv4 = zext i8 %2 to i32, !dbg !5556
  %shl5 = shl nuw nsw i32 %conv4, 16, !dbg !5557
  %or6 = or disjoint i32 %or, %shl5, !dbg !5558
  %arrayidx7 = getelementptr inbounds nuw i8, ptr %src, i32 3, !dbg !5559
  %3 = load i8, ptr %arrayidx7, align 1, !dbg !5559
  %conv8 = zext i8 %3 to i32, !dbg !5560
  %shl9 = shl nuw i32 %conv8, 24, !dbg !5561
  %or10 = or disjoint i32 %or6, %shl9, !dbg !5562
  ret i32 %or10, !dbg !5563
}

; Function Attrs: allocsize(0)
declare dso_local ptr @malloc(i32 noundef) local_unnamed_addr #2

; Function Attrs: nounwind
define internal fastcc void @br_aes_ct64_keysched(ptr noundef nonnull %comp_skey, ptr noundef %key, i32 noundef range(i32 16, 33) %key_len) unnamed_addr #0 !dbg !5564 {
entry:
  %skey = alloca [60 x i32], align 4
  %q = alloca [8 x i64], align 8
    #dbg_value(ptr %comp_skey, !5567, !DIExpression(), !5568)
    #dbg_value(ptr %key, !5569, !DIExpression(), !5568)
    #dbg_value(i32 %key_len, !5570, !DIExpression(), !5568)
    #dbg_declare(ptr %skey, !5571, !DIExpression(), !5575)
  %0 = and i32 %key_len, 60, !dbg !5576
    #dbg_value(i32 %key_len, !5577, !DIExpression(DW_OP_constu, 16, DW_OP_minus, DW_OP_constu, 2, DW_OP_shr, DW_OP_plus_uconst, 10, DW_OP_stack_value), !5568)
  %shr1 = lshr i32 %key_len, 2, !dbg !5578
    #dbg_value(i32 %shr1, !5579, !DIExpression(), !5568)
  %shl = add nuw nsw i32 %0, 28, !dbg !5576
    #dbg_value(i32 %shl, !5580, !DIExpression(), !5568)
  %shr3 = lshr i32 %key_len, 2, !dbg !5581
  call fastcc void @br_range_dec32le(ptr noundef nonnull %skey, i32 noundef %shr3, ptr noundef %key) #3, !dbg !5582
  %shr4 = lshr i32 %key_len, 2, !dbg !5583
  %sub5 = add nsw i32 %shr4, -1, !dbg !5584
  %arrayidx = getelementptr inbounds nuw [60 x i32], ptr %skey, i32 0, i32 %sub5, !dbg !5585
  %1 = load i32, ptr %arrayidx, align 4, !dbg !5585
    #dbg_value(i32 %1, !5586, !DIExpression(), !5568)
    #dbg_value(i32 %shr1, !5587, !DIExpression(), !5568)
    #dbg_value(i32 0, !5588, !DIExpression(), !5568)
    #dbg_value(i32 0, !5589, !DIExpression(), !5568)
  br label %for.cond, !dbg !5590

for.cond:                                         ; preds = %if.end16, %entry
  %i.0 = phi i32 [ %shr1, %entry ], [ %inc26, %if.end16 ], !dbg !5592
  %j.0 = phi i32 [ 0, %entry ], [ %spec.select, %if.end16 ], !dbg !5593
  %k.0 = phi i32 [ 0, %entry ], [ %spec.select1, %if.end16 ], !dbg !5593
  %tmp.0 = phi i32 [ %1, %entry ], [ %xor19, %if.end16 ], !dbg !5568
    #dbg_value(i32 %tmp.0, !5586, !DIExpression(), !5568)
    #dbg_value(i32 %k.0, !5589, !DIExpression(), !5568)
    #dbg_value(i32 %j.0, !5588, !DIExpression(), !5568)
    #dbg_value(i32 %i.0, !5587, !DIExpression(), !5568)
  %exitcond = icmp ne i32 %i.0, %shl, !dbg !5594
  br i1 %exitcond, label %for.body, label %for.cond27.preheader, !dbg !5596

for.cond27.preheader:                             ; preds = %for.cond
  br label %for.cond27, !dbg !5597

for.body:                                         ; preds = %for.cond
  %cmp6 = icmp eq i32 %j.0, 0, !dbg !5599
  br i1 %cmp6, label %if.then, label %if.else, !dbg !5599

if.then:                                          ; preds = %for.body
  %2 = shl i32 %tmp.0, 24, !dbg !5602
  %3 = lshr i32 %tmp.0, 8, !dbg !5602
  %4 = or i32 %2, %3, !dbg !5602
    #dbg_value(i32 %4, !5586, !DIExpression(), !5568)
  %call = call fastcc i32 @sub_word(i32 noundef %4) #3, !dbg !5604
  %arrayidx9 = getelementptr inbounds nuw [10 x i8], ptr @Rcon, i32 0, i32 %k.0, !dbg !5605
  %5 = load i8, ptr %arrayidx9, align 1, !dbg !5605
  %conv = zext i8 %5 to i32, !dbg !5605
  %xor = xor i32 %call, %conv, !dbg !5606
    #dbg_value(i32 %xor, !5586, !DIExpression(), !5568)
  br label %if.end16, !dbg !5607

if.else:                                          ; preds = %for.body
  %cmp10 = icmp samesign ugt i32 %key_len, 27, !dbg !5608
  %cmp12 = icmp eq i32 %j.0, 4
  %or.cond = and i1 %cmp10, %cmp12, !dbg !5610
  br i1 %or.cond, label %if.then14, label %if.end16, !dbg !5610

if.then14:                                        ; preds = %if.else
  %call15 = call fastcc i32 @sub_word(i32 noundef %tmp.0) #3, !dbg !5611
    #dbg_value(i32 %call15, !5586, !DIExpression(), !5568)
  br label %if.end16, !dbg !5613

if.end16:                                         ; preds = %if.else, %if.then14, %if.then
  %tmp.2 = phi i32 [ %xor, %if.then ], [ %call15, %if.then14 ], [ %tmp.0, %if.else ], !dbg !5614
    #dbg_value(i32 %tmp.2, !5586, !DIExpression(), !5568)
  %sub17 = sub nuw nsw i32 %i.0, %shr1, !dbg !5615
  %arrayidx18 = getelementptr inbounds nuw [60 x i32], ptr %skey, i32 0, i32 %sub17, !dbg !5616
  %6 = load i32, ptr %arrayidx18, align 4, !dbg !5616
  %xor19 = xor i32 %tmp.2, %6, !dbg !5617
    #dbg_value(i32 %xor19, !5586, !DIExpression(), !5568)
  %arrayidx20 = getelementptr inbounds nuw [60 x i32], ptr %skey, i32 0, i32 %i.0, !dbg !5618
  store i32 %xor19, ptr %arrayidx20, align 4, !dbg !5619
  %inc = add i32 %j.0, 1, !dbg !5620
    #dbg_value(i32 %inc, !5588, !DIExpression(), !5568)
  %cmp21 = icmp eq i32 %inc, %shr1, !dbg !5622
  %spec.select = select i1 %cmp21, i32 0, i32 %inc, !dbg !5622
  %inc24 = zext i1 %cmp21 to i32, !dbg !5622
  %spec.select1 = add i32 %k.0, %inc24, !dbg !5622
    #dbg_value(i32 %spec.select1, !5589, !DIExpression(), !5568)
    #dbg_value(i32 %spec.select, !5588, !DIExpression(), !5568)
  %inc26 = add nuw nsw i32 %i.0, 1, !dbg !5623
    #dbg_value(i32 %inc26, !5587, !DIExpression(), !5568)
  br label %for.cond, !dbg !5624, !llvm.loop !5625

for.cond27:                                       ; preds = %for.cond27.preheader, %for.body30
  %i.1 = phi i32 [ %add73, %for.body30 ], [ 0, %for.cond27.preheader ], !dbg !5627
  %j.2 = phi i32 [ %add74, %for.body30 ], [ 0, %for.cond27.preheader ], !dbg !5627
    #dbg_value(i32 %j.2, !5588, !DIExpression(), !5568)
    #dbg_value(i32 %i.1, !5587, !DIExpression(), !5568)
  %cmp28 = icmp samesign ult i32 %i.1, %shl, !dbg !5628
  br i1 %cmp28, label %for.body30, label %for.end75, !dbg !5597

for.body30:                                       ; preds = %for.cond27
    #dbg_declare(ptr %q, !5630, !DIExpression(), !5632)
  %arrayidx32 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5633
  %add.ptr = getelementptr inbounds nuw i32, ptr %skey, i32 %i.1, !dbg !5634
  call fastcc void @br_aes_ct64_interleave_in(ptr noundef nonnull %q, ptr noundef nonnull %arrayidx32, ptr noundef nonnull %add.ptr) #3, !dbg !5635
  %7 = load i64, ptr %q, align 8, !dbg !5636
  %arrayidx35 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5637
  store i64 %7, ptr %arrayidx35, align 8, !dbg !5638
  %arrayidx37 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5639
  store i64 %7, ptr %arrayidx37, align 8, !dbg !5640
  %arrayidx39 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5641
  store i64 %7, ptr %arrayidx39, align 8, !dbg !5642
  %arrayidx40 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5643
  %8 = load i64, ptr %arrayidx40, align 8, !dbg !5643
  %arrayidx41 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5644
  store i64 %8, ptr %arrayidx41, align 8, !dbg !5645
  %arrayidx43 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5646
  store i64 %8, ptr %arrayidx43, align 8, !dbg !5647
  %arrayidx45 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5648
  store i64 %8, ptr %arrayidx45, align 8, !dbg !5649
  call fastcc void @br_aes_ct64_ortho(ptr noundef nonnull %q) #3, !dbg !5650
  %9 = load i64, ptr %q, align 8, !dbg !5651
  %and = and i64 %9, 1229782938247303441, !dbg !5652
  %arrayidx48 = getelementptr inbounds nuw i8, ptr %q, i32 8, !dbg !5653
  %10 = load i64, ptr %arrayidx48, align 8, !dbg !5653
  %and49 = and i64 %10, 2459565876494606882, !dbg !5654
  %or50 = or disjoint i64 %and, %and49, !dbg !5655
  %arrayidx51 = getelementptr inbounds nuw i8, ptr %q, i32 16, !dbg !5656
  %11 = load i64, ptr %arrayidx51, align 8, !dbg !5656
  %and52 = and i64 %11, 4919131752989213764, !dbg !5657
  %or53 = or disjoint i64 %or50, %and52, !dbg !5658
  %arrayidx54 = getelementptr inbounds nuw i8, ptr %q, i32 24, !dbg !5659
  %12 = load i64, ptr %arrayidx54, align 8, !dbg !5659
  %and55 = and i64 %12, -8608480567731124088, !dbg !5660
  %or56 = or disjoint i64 %or53, %and55, !dbg !5661
  %arrayidx58 = getelementptr inbounds nuw i64, ptr %comp_skey, i32 %j.2, !dbg !5662
  store i64 %or56, ptr %arrayidx58, align 8, !dbg !5663
  %arrayidx59 = getelementptr inbounds nuw i8, ptr %q, i32 32, !dbg !5664
  %13 = load i64, ptr %arrayidx59, align 8, !dbg !5664
  %and60 = and i64 %13, 1229782938247303441, !dbg !5665
  %arrayidx61 = getelementptr inbounds nuw i8, ptr %q, i32 40, !dbg !5666
  %14 = load i64, ptr %arrayidx61, align 8, !dbg !5666
  %and62 = and i64 %14, 2459565876494606882, !dbg !5667
  %or63 = or disjoint i64 %and60, %and62, !dbg !5668
  %arrayidx64 = getelementptr inbounds nuw i8, ptr %q, i32 48, !dbg !5669
  %15 = load i64, ptr %arrayidx64, align 8, !dbg !5669
  %and65 = and i64 %15, 4919131752989213764, !dbg !5670
  %or66 = or disjoint i64 %or63, %and65, !dbg !5671
  %arrayidx67 = getelementptr inbounds nuw i8, ptr %q, i32 56, !dbg !5672
  %16 = load i64, ptr %arrayidx67, align 8, !dbg !5672
  %and68 = and i64 %16, -8608480567731124088, !dbg !5673
  %or69 = or disjoint i64 %or66, %and68, !dbg !5674
  %add70 = or disjoint i32 %j.2, 1, !dbg !5675
  %arrayidx71 = getelementptr inbounds nuw i64, ptr %comp_skey, i32 %add70, !dbg !5676
  store i64 %or69, ptr %arrayidx71, align 8, !dbg !5677
  %add73 = add nuw nsw i32 %i.1, 4, !dbg !5678
    #dbg_value(i32 %add73, !5587, !DIExpression(), !5568)
  %add74 = add nuw nsw i32 %j.2, 2, !dbg !5679
    #dbg_value(i32 %add74, !5588, !DIExpression(), !5568)
  br label %for.cond27, !dbg !5680, !llvm.loop !5681

for.end75:                                        ; preds = %for.cond27
  ret void, !dbg !5683
}

; Function Attrs: nounwind
define internal fastcc void @br_aes_ct64_skey_expand(ptr noundef %skey, ptr noundef nonnull %comp_skey, i32 noundef range(i32 10, 15) %nrounds) unnamed_addr #0 !dbg !5684 {
entry:
    #dbg_value(ptr %skey, !5687, !DIExpression(), !5688)
    #dbg_value(ptr %comp_skey, !5689, !DIExpression(), !5688)
    #dbg_value(i32 %nrounds, !5690, !DIExpression(), !5688)
  %add = shl nuw nsw i32 %nrounds, 1, !dbg !5691
  %shl = add nuw nsw i32 %add, 2, !dbg !5691
    #dbg_value(i32 %shl, !5692, !DIExpression(), !5688)
    #dbg_value(i32 0, !5693, !DIExpression(), !5688)
    #dbg_value(i32 0, !5694, !DIExpression(), !5688)
  br label %for.cond, !dbg !5695

for.cond:                                         ; preds = %for.body, %entry
  %u.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ], !dbg !5697
  %v.0 = phi i32 [ 0, %entry ], [ %add21, %for.body ], !dbg !5697
    #dbg_value(i32 %v.0, !5694, !DIExpression(), !5688)
    #dbg_value(i32 %u.0, !5693, !DIExpression(), !5688)
  %exitcond = icmp ne i32 %u.0, %shl, !dbg !5698
  br i1 %exitcond, label %for.body, label %for.end, !dbg !5700

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds nuw i64, ptr %comp_skey, i32 %u.0, !dbg !5701
  %0 = load i64, ptr %arrayidx, align 8, !dbg !5701
    #dbg_value(i64 %0, !5703, !DIExpression(), !5704)
    #dbg_value(i64 %0, !5705, !DIExpression(), !5704)
    #dbg_value(i64 %0, !5706, !DIExpression(), !5704)
    #dbg_value(i64 %0, !5707, !DIExpression(), !5704)
  %and = and i64 %0, 1229782938247303441, !dbg !5708
    #dbg_value(i64 %and, !5707, !DIExpression(), !5704)
    #dbg_value(i64 %0, !5706, !DIExpression(DW_OP_constu, 2459565876494606882, DW_OP_and, DW_OP_stack_value), !5704)
    #dbg_value(i64 %0, !5705, !DIExpression(DW_OP_constu, 4919131752989213764, DW_OP_and, DW_OP_stack_value), !5704)
    #dbg_value(i64 %0, !5703, !DIExpression(DW_OP_constu, 9838263505978427528, DW_OP_and, DW_OP_stack_value), !5704)
  %and1 = lshr i64 %0, 1, !dbg !5709
  %shr = and i64 %and1, 1229782938247303441, !dbg !5709
    #dbg_value(i64 %shr, !5706, !DIExpression(), !5704)
  %and2 = lshr i64 %0, 2, !dbg !5710
  %shr4 = and i64 %and2, 1229782938247303441, !dbg !5710
    #dbg_value(i64 %shr4, !5705, !DIExpression(), !5704)
  %and3 = lshr i64 %0, 3, !dbg !5711
  %shr5 = and i64 %and3, 1229782938247303441, !dbg !5711
    #dbg_value(i64 %shr5, !5703, !DIExpression(), !5704)
  %sub = mul nuw i64 %and, 15, !dbg !5712
  %arrayidx8 = getelementptr inbounds nuw i64, ptr %skey, i32 %v.0, !dbg !5713
  store i64 %sub, ptr %arrayidx8, align 8, !dbg !5714
  %sub10 = mul nuw i64 %shr, 15, !dbg !5715
  %add11 = or disjoint i32 %v.0, 1, !dbg !5716
  %arrayidx12 = getelementptr inbounds nuw i64, ptr %skey, i32 %add11, !dbg !5717
  store i64 %sub10, ptr %arrayidx12, align 8, !dbg !5718
  %sub14 = mul nuw i64 %shr4, 15, !dbg !5719
  %add15 = or disjoint i32 %v.0, 2, !dbg !5720
  %arrayidx16 = getelementptr inbounds nuw i64, ptr %skey, i32 %add15, !dbg !5721
  store i64 %sub14, ptr %arrayidx16, align 8, !dbg !5722
  %sub18 = mul nuw i64 %shr5, 15, !dbg !5723
  %add19 = or disjoint i32 %v.0, 3, !dbg !5724
  %arrayidx20 = getelementptr inbounds nuw i64, ptr %skey, i32 %add19, !dbg !5725
  store i64 %sub18, ptr %arrayidx20, align 8, !dbg !5726
  %inc = add nuw nsw i32 %u.0, 1, !dbg !5727
    #dbg_value(i32 %inc, !5693, !DIExpression(), !5688)
  %add21 = add nuw nsw i32 %v.0, 4, !dbg !5728
    #dbg_value(i32 %add21, !5694, !DIExpression(), !5688)
  br label %for.cond, !dbg !5729, !llvm.loop !5730

for.end:                                          ; preds = %for.cond
  ret void, !dbg !5732
}

; Function Attrs: nounwind
define internal fastcc i32 @sub_word(i32 noundef %x) unnamed_addr #0 !dbg !5733 {
entry:
  %q = alloca [8 x i64], align 8
    #dbg_value(i32 %x, !5734, !DIExpression(), !5735)
    #dbg_declare(ptr %q, !5736, !DIExpression(), !5737)
  %call = call ptr @memset(ptr noundef nonnull %q, i32 noundef 0, i32 noundef 64) #4, !dbg !5738
  %conv = zext i32 %x to i64, !dbg !5739
  store i64 %conv, ptr %q, align 8, !dbg !5740
  call fastcc void @br_aes_ct64_ortho(ptr noundef nonnull %q) #3, !dbg !5741
  call fastcc void @br_aes_ct64_bitslice_Sbox(ptr noundef nonnull %q) #3, !dbg !5742
  call fastcc void @br_aes_ct64_ortho(ptr noundef nonnull %q) #3, !dbg !5743
  %0 = load i64, ptr %q, align 8, !dbg !5744
  %conv5 = trunc i64 %0 to i32, !dbg !5745
  ret i32 %conv5, !dbg !5746
}

; Function Attrs: nounwind
define dso_local void @AES128_ECB(ptr noundef %key, ptr noundef %input, ptr noundef %output, i32 noundef %num) local_unnamed_addr #0 !dbg !5747 {
entry:
  %schedule = alloca ptr, align 4
    #dbg_value(ptr %key, !5750, !DIExpression(), !5751)
    #dbg_value(ptr %input, !5752, !DIExpression(), !5751)
    #dbg_value(ptr %output, !5753, !DIExpression(), !5751)
    #dbg_value(i32 %num, !5754, !DIExpression(), !5751)
    #dbg_value(ptr null, !5755, !DIExpression(), !5751)
  store ptr null, ptr %schedule, align 4, !dbg !5756
    #dbg_value(ptr %schedule, !5755, !DIExpression(DW_OP_deref), !5751)
  call fastcc void @oqs_aes128_load_schedule_c(ptr noundef %key, ptr noundef nonnull %schedule) #3, !dbg !5757
  %0 = load ptr, ptr %schedule, align 4, !dbg !5758
    #dbg_value(ptr %0, !5755, !DIExpression(), !5751)
  call fastcc void @oqs_aes128_ecb_enc_sch_c(ptr noundef %input, i32 noundef %num, ptr noundef %0, ptr noundef %output) #3, !dbg !5759
  %1 = load ptr, ptr %schedule, align 4, !dbg !5760
    #dbg_value(ptr %1, !5755, !DIExpression(), !5751)
  call fastcc void @oqs_aes128_free_schedule_c(ptr noundef %1) #3, !dbg !5761
  ret void, !dbg !5762
}

; Function Attrs: nounwind
define internal fastcc void @oqs_aes128_ecb_enc_sch_c(ptr noundef %plaintext, i32 noundef %plaintext_len, ptr noundef %schedule, ptr noundef %ciphertext) unnamed_addr #0 !dbg !5763 {
entry:
    #dbg_value(ptr %plaintext, !5766, !DIExpression(), !5767)
    #dbg_value(i32 %plaintext_len, !5768, !DIExpression(), !5767)
    #dbg_value(ptr %schedule, !5769, !DIExpression(), !5767)
    #dbg_value(ptr %ciphertext, !5770, !DIExpression(), !5767)
  %rem = and i32 %plaintext_len, 15, !dbg !5771
  %cmp = icmp eq i32 %rem, 0, !dbg !5771
  br i1 %cmp, label %cond.end, label %cond.false, !dbg !5771

cond.false:                                       ; preds = %entry
  call void @__assert_func(ptr noundef nonnull @.str.37, i32 noundef 1226, ptr noundef null, ptr noundef nonnull @.str.2) #4, !dbg !5771
  br label %cond.end, !dbg !5771

cond.end:                                         ; preds = %entry, %cond.false
    #dbg_value(ptr %schedule, !5772, !DIExpression(), !5767)
  %div1 = lshr i32 %plaintext_len, 4, !dbg !5773
  call fastcc void @aes_ecb(ptr noundef %ciphertext, ptr noundef %plaintext, i32 noundef %div1, ptr noundef %schedule, i32 noundef 10) #3, !dbg !5774
  ret void, !dbg !5775
}

; Function Attrs: nounwind
define internal fastcc void @aes_ecb(ptr noundef %out, ptr noundef %in, i32 noundef range(i32 0, 268435456) %nblocks, ptr noundef %rkeys, i32 noundef range(i32 10, 15) %nrounds) unnamed_addr #0 !dbg !5776 {
entry:
  %blocks = alloca [16 x i32], align 4
  %t = alloca [64 x i8], align 1
    #dbg_value(ptr %out, !5779, !DIExpression(), !5780)
    #dbg_value(ptr %in, !5781, !DIExpression(), !5780)
    #dbg_value(i32 %nblocks, !5782, !DIExpression(), !5780)
    #dbg_value(ptr %rkeys, !5783, !DIExpression(), !5780)
    #dbg_value(i32 %nrounds, !5784, !DIExpression(), !5780)
    #dbg_declare(ptr %blocks, !5785, !DIExpression(), !5786)
    #dbg_declare(ptr %t, !5787, !DIExpression(), !5788)
  %0 = lshr i32 %nblocks, 2, !dbg !5789
  %1 = shl nuw nsw i32 %0, 2, !dbg !5789
  br label %while.cond, !dbg !5789

while.cond:                                       ; preds = %while.body, %entry
  %nblocks.addr.0 = phi i32 [ %nblocks, %entry ], [ %sub, %while.body ]
  %in.addr.0 = phi ptr [ %in, %entry ], [ %add.ptr, %while.body ]
  %out.addr.0 = phi ptr [ %out, %entry ], [ %add.ptr2, %while.body ]
    #dbg_value(ptr %out.addr.0, !5779, !DIExpression(), !5780)
    #dbg_value(ptr %in.addr.0, !5781, !DIExpression(), !5780)
    #dbg_value(i32 %nblocks.addr.0, !5782, !DIExpression(), !5780)
  %cmp = icmp ugt i32 %nblocks.addr.0, 3, !dbg !5790
  br i1 %cmp, label %while.body, label %while.end, !dbg !5789

while.body:                                       ; preds = %while.cond
  call fastcc void @br_range_dec32le(ptr noundef nonnull %blocks, i32 noundef 16, ptr noundef %in.addr.0) #3, !dbg !5791
  call fastcc void @aes_ecb4x(ptr noundef %out.addr.0, ptr noundef nonnull %blocks, ptr noundef %rkeys, i32 noundef %nrounds) #3, !dbg !5793
  %sub = add nsw i32 %nblocks.addr.0, -4, !dbg !5794
    #dbg_value(i32 %sub, !5782, !DIExpression(), !5780)
  %add.ptr = getelementptr inbounds nuw i8, ptr %in.addr.0, i32 64, !dbg !5795
    #dbg_value(ptr %add.ptr, !5781, !DIExpression(), !5780)
  %add.ptr2 = getelementptr inbounds nuw i8, ptr %out.addr.0, i32 64, !dbg !5796
    #dbg_value(ptr %add.ptr2, !5779, !DIExpression(), !5780)
  br label %while.cond, !dbg !5789, !llvm.loop !5797

while.end:                                        ; preds = %while.cond
  %in.addr.0.lcssa = phi ptr [ %in.addr.0, %while.cond ]
  %out.addr.0.lcssa = phi ptr [ %out.addr.0, %while.cond ]
  %2 = sub i32 %nblocks, %1, !dbg !5789
  %tobool.not = icmp eq i32 %2, 0, !dbg !5799
  br i1 %tobool.not, label %if.end, label %if.then, !dbg !5799

if.then:                                          ; preds = %while.end
  %mul = shl nuw nsw i32 %2, 2, !dbg !5801
  call fastcc void @br_range_dec32le(ptr noundef nonnull %blocks, i32 noundef %mul, ptr noundef %in.addr.0.lcssa) #3, !dbg !5803
  call fastcc void @aes_ecb4x(ptr noundef nonnull %t, ptr noundef nonnull %blocks, ptr noundef %rkeys, i32 noundef %nrounds) #3, !dbg !5804
  %mul7 = shl nuw nsw i32 %2, 4, !dbg !5805
  %call = call ptr @memcpy(ptr noundef %out.addr.0.lcssa, ptr noundef nonnull %t, i32 noundef %mul7) #4, !dbg !5806
  br label %if.end, !dbg !5807

if.end:                                           ; preds = %if.then, %while.end
  ret void, !dbg !5808
}

; Function Attrs: nounwind
define dso_local void @AES256_ECB(ptr noundef %key, ptr noundef %input, ptr noundef %output) local_unnamed_addr #0 !dbg !5809 {
entry:
  %schedule = alloca ptr, align 4
    #dbg_value(ptr %key, !5812, !DIExpression(), !5813)
    #dbg_value(ptr %input, !5814, !DIExpression(), !5813)
    #dbg_value(ptr %output, !5815, !DIExpression(), !5813)
    #dbg_value(ptr null, !5816, !DIExpression(), !5813)
  store ptr null, ptr %schedule, align 4, !dbg !5817
    #dbg_value(ptr %schedule, !5816, !DIExpression(DW_OP_deref), !5813)
  call fastcc void @oqs_aes256_load_schedule_c(ptr noundef %key, ptr noundef nonnull %schedule) #3, !dbg !5818
  %0 = load ptr, ptr %schedule, align 4, !dbg !5819
    #dbg_value(ptr %0, !5816, !DIExpression(), !5813)
  call fastcc void @oqs_aes256_ecb_enc_sch_c(ptr noundef %input, i32 noundef 16, ptr noundef %0, ptr noundef %output) #3, !dbg !5820
  %1 = load ptr, ptr %schedule, align 4, !dbg !5821
    #dbg_value(ptr %1, !5816, !DIExpression(), !5813)
  call fastcc void @oqs_aes256_free_schedule_c(ptr noundef %1) #3, !dbg !5822
  ret void, !dbg !5823
}

; Function Attrs: nounwind
define internal fastcc void @oqs_aes256_load_schedule_c(ptr noundef %key, ptr noundef nonnull %_schedule) unnamed_addr #0 !dbg !5824 {
entry:
  %skey = alloca [30 x i64], align 8
    #dbg_value(ptr %key, !5825, !DIExpression(), !5826)
    #dbg_value(ptr %_schedule, !5827, !DIExpression(), !5826)
  %call = call dereferenceable_or_null(976) ptr @malloc(i32 noundef 976) #5, !dbg !5828
  store ptr %call, ptr %_schedule, align 4, !dbg !5829
  %cmp = icmp eq ptr %call, null, !dbg !5830
  br i1 %cmp, label %if.then, label %do.end, !dbg !5830

if.then:                                          ; preds = %entry
  call void @exit(i32 noundef 1) #4, !dbg !5833
  br label %do.end, !dbg !5833

do.end:                                           ; preds = %entry, %if.then
  %0 = load ptr, ptr %_schedule, align 4, !dbg !5835
    #dbg_value(ptr %0, !5836, !DIExpression(), !5826)
    #dbg_declare(ptr %skey, !5837, !DIExpression(), !5841)
  call fastcc void @br_aes_ct64_keysched(ptr noundef nonnull %skey, ptr noundef %key, i32 noundef 32) #3, !dbg !5842
  call fastcc void @br_aes_ct64_skey_expand(ptr noundef %0, ptr noundef nonnull %skey, i32 noundef 14) #3, !dbg !5843
  ret void, !dbg !5844
}

; Function Attrs: nounwind
define internal fastcc void @oqs_aes256_ecb_enc_sch_c(ptr noundef %plaintext, i32 noundef %plaintext_len, ptr noundef %schedule, ptr noundef %ciphertext) unnamed_addr #0 !dbg !5845 {
entry:
    #dbg_value(ptr %plaintext, !5846, !DIExpression(), !5847)
    #dbg_value(i32 16, !5848, !DIExpression(), !5847)
    #dbg_value(ptr %schedule, !5849, !DIExpression(), !5847)
    #dbg_value(ptr %ciphertext, !5850, !DIExpression(), !5847)
    #dbg_value(ptr %schedule, !5851, !DIExpression(), !5847)
  call fastcc void @aes_ecb(ptr noundef %ciphertext, ptr noundef %plaintext, i32 noundef 1, ptr noundef %schedule, i32 noundef 14) #3, !dbg !5852
  ret void, !dbg !5853
}

; Function Attrs: nounwind
define internal fastcc void @oqs_aes256_free_schedule_c(ptr noundef %schedule) unnamed_addr #0 !dbg !5854 {
entry:
    #dbg_value(ptr %schedule, !5855, !DIExpression(), !5856)
  %cmp.not = icmp eq ptr %schedule, null, !dbg !5857
  br i1 %cmp.not, label %if.end, label %if.then, !dbg !5857

if.then:                                          ; preds = %entry
    #dbg_value(ptr %schedule, !5859, !DIExpression(), !5861)
  call fastcc void @OQS_MEM_secure_free(ptr noundef nonnull %schedule, i32 noundef 976) #3, !dbg !5862
  br label %if.end, !dbg !5863

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !5864
}

attributes #0 = { nounwind "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m4" "target-features"="+armv7e-m,+dsp,+fp16,+hwdiv,+thumb-mode,+vfp2sp,+vfp3d16sp,+vfp4d16sp" }
attributes #1 = { "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m4" "target-features"="+armv7e-m,+dsp,+fp16,+hwdiv,+thumb-mode,+vfp2sp,+vfp3d16sp,+vfp4d16sp" }
attributes #2 = { allocsize(0) "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="cortex-m4" "target-features"="+armv7e-m,+dsp,+fp16,+hwdiv,+thumb-mode,+vfp2sp,+vfp3d16sp,+vfp4d16sp" }
attributes #3 = { nobuiltin "no-builtins" }
attributes #4 = { nobuiltin nounwind "no-builtins" }
attributes #5 = { nobuiltin nounwind allocsize(0) "no-builtins" }

!llvm.dbg.cu = !{!125, !127, !128, !2, !49, !64, !94}
!llvm.ident = !{!129, !129, !129, !129, !129, !129, !129}
!llvm.module.flags = !{!130, !131, !132, !133}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "gf_multtab", scope: !2, file: !17, line: 17, type: !24, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../../../src/<stdin>", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!4 = !{!5, !11}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 32)
!6 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !7, line: 24, baseType: !8)
!7 = !DIFile(filename: "/usr/lib/arm-none-eabi/include/sys/_stdint.h", directory: "")
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !9, line: 43, baseType: !10)
!9 = !DIFile(filename: "/usr/lib/arm-none-eabi/include/machine/_default_types.h", directory: "")
!10 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !7, line: 60, baseType: !12)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !9, line: 105, baseType: !13)
!13 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!14 = !{!0, !15, !22, !27, !32, !37, !40}
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "gf_invtab", scope: !2, file: !17, line: 18, type: !18, isLocal: false, isDefinition: true)
!17 = !DIFile(filename: "../../../src/snova_ref.c", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 128, elements: !20)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "gf_t", file: !17, line: 15, baseType: !6)
!20 = !{!21}
!21 = !DISubrange(count: 16)
!22 = !DIGlobalVariableExpression(var: !23, expr: !DIExpression())
!23 = distinct !DIGlobalVariable(name: "gf_addtab", scope: !2, file: !17, line: 19, type: !24, isLocal: false, isDefinition: true)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 2048, elements: !25)
!25 = !{!26}
!26 = !DISubrange(count: 256)
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(name: "gf_S", scope: !2, file: !17, line: 20, type: !29, isLocal: false, isDefinition: true)
!29 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 512, elements: !30)
!30 = !{!31}
!31 = !DISubrange(count: 64)
!32 = !DIGlobalVariableExpression(var: !33, expr: !DIExpression())
!33 = distinct !DIGlobalVariable(name: "fixed_abq", scope: !2, file: !17, line: 659, type: !34, isLocal: false, isDefinition: true)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 38400, elements: !35)
!35 = !{!36}
!36 = !DISubrange(count: 4800)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "first_time", scope: !2, file: !17, line: 217, type: !39, isLocal: true, isDefinition: true)
!39 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!40 = !DIGlobalVariableExpression(var: !41, expr: !DIExpression())
!41 = distinct !DIGlobalVariable(scope: null, file: !17, line: 240, type: !42, isLocal: true, isDefinition: true)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 80, elements: !44)
!43 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!44 = !{!45}
!45 = !DISubrange(count: 10)
!46 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression(DW_OP_deref_size, 1, DW_OP_constu, 18446744073709551615, DW_OP_mul, DW_OP_constu, 1, DW_OP_plus, DW_OP_stack_value))
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(name: "KeccakF_RoundConstants", scope: !49, file: !57, line: 28, type: !58, isLocal: true, isDefinition: true)
!49 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !50, globals: !56, splitDebugInlining: false, nameTableKind: None)
!50 = !{!5, !51, !11, !54, !6}
!51 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !7, line: 48, baseType: !52)
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !9, line: 79, baseType: !53)
!53 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !55, line: 214, baseType: !53)
!55 = !DIFile(filename: "/usr/lib/gcc/arm-none-eabi/13.2.1/include/stddef.h", directory: "")
!56 = !{!47}
!57 = !DIFile(filename: "../../../src/keccak_opt64.h", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 1536, elements: !60)
!59 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!60 = !{!61}
!61 = !DISubrange(count: 24)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression())
!63 = distinct !DIGlobalVariable(name: "DRBG_ctx", scope: !64, file: !69, line: 31, type: !70, isLocal: false, isDefinition: true)
!64 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !65, globals: !68, splitDebugInlining: false, nameTableKind: None)
!65 = !{!66, !67}
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 32)
!67 = !DIBasicType(name: "long", size: 32, encoding: DW_ATE_signed)
!68 = !{!62}
!69 = !DIFile(filename: "../../../src/rng.c", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "AES256_CTR_DRBG_struct", file: !71, line: 44, baseType: !72)
!71 = !DIFile(filename: "../../../src/rng.h", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!72 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !71, line: 40, size: 416, elements: !73)
!73 = !{!74, !78, !80}
!74 = !DIDerivedType(tag: DW_TAG_member, name: "Key", scope: !72, file: !71, line: 41, baseType: !75, size: 256)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 256, elements: !76)
!76 = !{!77}
!77 = !DISubrange(count: 32)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "V", scope: !72, file: !71, line: 42, baseType: !79, size: 128, offset: 256)
!79 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 128, elements: !20)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "reseed_counter", scope: !72, file: !71, line: 43, baseType: !39, size: 32, offset: 384)
!81 = !DIGlobalVariableExpression(var: !82, expr: !DIExpression())
!82 = distinct !DIGlobalVariable(scope: null, file: !83, line: 1781, type: !84, isLocal: true, isDefinition: true)
!83 = !DIFile(filename: "../../../src/aes.c", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 152, elements: !85)
!85 = !{!86}
!86 = !DISubrange(count: 19)
!87 = !DIGlobalVariableExpression(var: !88, expr: !DIExpression())
!88 = distinct !DIGlobalVariable(scope: null, file: !83, line: 1781, type: !89, isLocal: true, isDefinition: true)
!89 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 136, elements: !90)
!90 = !{!91}
!91 = !DISubrange(count: 17)
!92 = !DIGlobalVariableExpression(var: !93, expr: !DIExpression())
!93 = distinct !DIGlobalVariable(name: "Rcon", scope: !94, file: !83, line: 812, type: !123, isLocal: true, isDefinition: true)
!94 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !95, globals: !119, splitDebugInlining: false, nameTableKind: None)
!95 = !{!66, !39, !96, !11, !51, !106, !10, !108, !117}
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 32)
!97 = !DIDerivedType(tag: DW_TAG_typedef, name: "aes128ctx", file: !83, line: 510, baseType: !98)
!98 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !83, line: 507, size: 5760, elements: !99)
!99 = !{!100, !104}
!100 = !DIDerivedType(tag: DW_TAG_member, name: "sk_exp", scope: !98, file: !83, line: 508, baseType: !101, size: 5632)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 5632, elements: !102)
!102 = !{!103}
!103 = !DISubrange(count: 88)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "iv", scope: !98, file: !83, line: 509, baseType: !105, size: 128, offset: 5632)
!105 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 128, elements: !20)
!106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !107, size: 32)
!107 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !97)
!108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !109, size: 32)
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "aes256ctx", file: !83, line: 516, baseType: !110)
!110 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !83, line: 513, size: 7808, elements: !111)
!111 = !{!112, !116}
!112 = !DIDerivedType(tag: DW_TAG_member, name: "sk_exp", scope: !110, file: !83, line: 514, baseType: !113, size: 7680)
!113 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 7680, elements: !114)
!114 = !{!115}
!115 = !DISubrange(count: 120)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "iv", scope: !110, file: !83, line: 515, baseType: !105, size: 128, offset: 7680)
!117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !118, size: 32)
!118 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !109)
!119 = !{!81, !87, !92, !120}
!120 = !DIGlobalVariableExpression(var: !121, expr: !DIExpression())
!121 = distinct !DIGlobalVariable(scope: null, file: !83, line: 1226, type: !122, isLocal: true, isDefinition: true)
!122 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 192, elements: !60)
!123 = !DICompositeType(tag: DW_TAG_array_type, baseType: !124, size: 80, elements: !44)
!124 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!125 = distinct !DICompileUnit(language: DW_LANG_C11, file: !126, producer: "Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!126 = !DIFile(filename: "../<stdin>", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!127 = distinct !DICompileUnit(language: DW_LANG_C11, file: !126, producer: "Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!128 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!129 = !{!"Ubuntu clang version 20.1.2 (0ubuntu1~24.04.3)"}
!130 = !{i32 2, !"Debug Info Version", i32 3}
!131 = !{i32 1, !"wchar_size", i32 4}
!132 = !{i32 1, !"min_enum_size", i32 4}
!133 = !{i32 1, !"Code Model", i32 1}
!134 = distinct !DISubprogram(name: "main", scope: !135, file: !135, line: 81, type: !136, scopeLine: 81, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !125)
!135 = !DIFile(filename: "../example.c", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!136 = !DISubroutineType(types: !137)
!137 = !{!39}
!138 = !DILocation(line: 82, column: 12, scope: !134)
!139 = !DILocation(line: 82, column: 5, scope: !134)
!140 = distinct !DISubprogram(name: "example_snova", scope: !135, file: !135, line: 21, type: !136, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !125, retainedNodes: !141)
!141 = !{}
!142 = !DILocalVariable(name: "entropy_input", scope: !140, file: !135, line: 23, type: !143)
!143 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 384, elements: !144)
!144 = !{!145}
!145 = !DISubrange(count: 48)
!146 = !DILocation(line: 23, column: 19, scope: !140)
!147 = !DILocalVariable(name: "i", scope: !148, file: !135, line: 24, type: !39)
!148 = distinct !DILexicalBlock(scope: !140, file: !135, line: 24, column: 5)
!149 = !DILocation(line: 0, scope: !148)
!150 = !DILocation(line: 24, column: 10, scope: !148)
!151 = !DILocation(line: 24, scope: !148)
!152 = !DILocation(line: 24, column: 23, scope: !153)
!153 = distinct !DILexicalBlock(scope: !148, file: !135, line: 24, column: 5)
!154 = !DILocation(line: 24, column: 5, scope: !148)
!155 = !DILocation(line: 25, column: 28, scope: !156)
!156 = distinct !DILexicalBlock(scope: !153, file: !135, line: 24, column: 34)
!157 = !DILocation(line: 25, column: 9, scope: !156)
!158 = !DILocation(line: 25, column: 26, scope: !156)
!159 = !DILocation(line: 24, column: 30, scope: !153)
!160 = !DILocation(line: 24, column: 5, scope: !153)
!161 = distinct !{!161, !154, !162, !163}
!162 = !DILocation(line: 26, column: 5, scope: !148)
!163 = !{!"llvm.loop.mustprogress"}
!164 = !DILocation(line: 27, column: 5, scope: !140)
!165 = !DILocalVariable(name: "mlen", scope: !140, file: !135, line: 29, type: !13)
!166 = !DILocation(line: 0, scope: !140)
!167 = !DILocation(line: 29, column: 24, scope: !140)
!168 = !DILocalVariable(name: "smlen", scope: !140, file: !135, line: 30, type: !13)
!169 = !DILocation(line: 30, column: 24, scope: !140)
!170 = !DILocalVariable(name: "pk", scope: !140, file: !135, line: 32, type: !171)
!171 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 8128, elements: !172)
!172 = !{!173}
!173 = !DISubrange(count: 1016)
!174 = !DILocation(line: 32, column: 19, scope: !140)
!175 = !DILocalVariable(name: "sk", scope: !140, file: !135, line: 33, type: !176)
!176 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 768, elements: !177)
!177 = !{!178}
!178 = !DISubrange(count: 96)
!179 = !DILocation(line: 33, column: 19, scope: !140)
!180 = !DILocalVariable(name: "sm", scope: !140, file: !135, line: 35, type: !181)
!181 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 2432, elements: !182)
!182 = !{!183}
!183 = !DISubrange(count: 304)
!184 = !DILocation(line: 35, column: 19, scope: !140)
!185 = !DILocalVariable(name: "msg", scope: !140, file: !135, line: 37, type: !75)
!186 = !DILocation(line: 37, column: 19, scope: !140)
!187 = !DILocalVariable(name: "msg2", scope: !140, file: !135, line: 38, type: !75)
!188 = !DILocation(line: 38, column: 19, scope: !140)
!189 = !DILocation(line: 41, column: 15, scope: !140)
!190 = !DILocalVariable(name: "res", scope: !140, file: !135, line: 41, type: !39)
!191 = !DILocation(line: 48, column: 40, scope: !140)
!192 = !DILocation(line: 48, column: 11, scope: !140)
!193 = !DILocation(line: 49, column: 13, scope: !194)
!194 = distinct !DILexicalBlock(scope: !140, file: !135, line: 49, column: 9)
!195 = !DILocation(line: 55, column: 45, scope: !140)
!196 = !DILocation(line: 55, column: 11, scope: !140)
!197 = !DILocation(line: 56, column: 13, scope: !198)
!198 = distinct !DILexicalBlock(scope: !140, file: !135, line: 56, column: 9)
!199 = !DILocation(line: 56, column: 18, scope: !198)
!200 = !DILocation(line: 56, column: 39, scope: !198)
!201 = !DILocation(line: 56, column: 21, scope: !198)
!202 = !DILabel(scope: !140, name: "err", file: !135, line: 76)
!203 = !DILocation(line: 76, column: 1, scope: !140)
!204 = !DILocation(line: 77, column: 5, scope: !140)
!205 = !DILocation(line: 78, column: 5, scope: !140)
!206 = distinct !DISubprogram(name: "snova_memset", scope: !207, file: !207, line: 3, type: !208, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !127, retainedNodes: !141)
!207 = !DIFile(filename: "../mem.c", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!208 = !DISubroutineType(types: !209)
!209 = !{null, !66, !6, !51}
!210 = !DILocalVariable(name: "dst", arg: 1, scope: !206, file: !207, line: 3, type: !66)
!211 = !DILocation(line: 0, scope: !206)
!212 = !DILocalVariable(name: "val", arg: 2, scope: !206, file: !207, line: 3, type: !6)
!213 = !DILocalVariable(name: "len", arg: 3, scope: !206, file: !207, line: 3, type: !51)
!214 = !DILocalVariable(name: "d", scope: !206, file: !207, line: 5, type: !5)
!215 = !DILocalVariable(name: "i", scope: !216, file: !207, line: 7, type: !51)
!216 = distinct !DILexicalBlock(scope: !206, file: !207, line: 7, column: 5)
!217 = !DILocation(line: 0, scope: !216)
!218 = !DILocation(line: 7, column: 10, scope: !216)
!219 = !DILocation(line: 7, scope: !216)
!220 = !DILocation(line: 7, column: 28, scope: !221)
!221 = distinct !DILexicalBlock(scope: !216, file: !207, line: 7, column: 5)
!222 = !DILocation(line: 7, column: 5, scope: !216)
!223 = !DILocation(line: 8, column: 9, scope: !221)
!224 = !DILocation(line: 8, column: 14, scope: !221)
!225 = !DILocation(line: 7, column: 36, scope: !221)
!226 = !DILocation(line: 7, column: 5, scope: !221)
!227 = distinct !{!227, !222, !228, !163}
!228 = !DILocation(line: 8, column: 16, scope: !216)
!229 = !DILocation(line: 9, column: 1, scope: !206)
!230 = distinct !DISubprogram(name: "snova_memcpy", scope: !207, file: !207, line: 11, type: !231, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !127, retainedNodes: !141)
!231 = !DISubroutineType(types: !232)
!232 = !{null, !66, !233, !51}
!233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !234, size: 32)
!234 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!235 = !DILocalVariable(name: "dst", arg: 1, scope: !230, file: !207, line: 11, type: !66)
!236 = !DILocation(line: 0, scope: !230)
!237 = !DILocalVariable(name: "src", arg: 2, scope: !230, file: !207, line: 11, type: !233)
!238 = !DILocalVariable(name: "len", arg: 3, scope: !230, file: !207, line: 11, type: !51)
!239 = !DILocalVariable(name: "d", scope: !230, file: !207, line: 13, type: !5)
!240 = !DILocalVariable(name: "s", scope: !230, file: !207, line: 14, type: !241)
!241 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 32)
!242 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6)
!243 = !DILocalVariable(name: "i", scope: !244, file: !207, line: 16, type: !51)
!244 = distinct !DILexicalBlock(scope: !230, file: !207, line: 16, column: 5)
!245 = !DILocation(line: 0, scope: !244)
!246 = !DILocation(line: 16, column: 10, scope: !244)
!247 = !DILocation(line: 16, scope: !244)
!248 = !DILocation(line: 16, column: 28, scope: !249)
!249 = distinct !DILexicalBlock(scope: !244, file: !207, line: 16, column: 5)
!250 = !DILocation(line: 16, column: 5, scope: !244)
!251 = !DILocation(line: 17, column: 16, scope: !249)
!252 = !DILocation(line: 17, column: 9, scope: !249)
!253 = !DILocation(line: 17, column: 14, scope: !249)
!254 = !DILocation(line: 16, column: 36, scope: !249)
!255 = !DILocation(line: 16, column: 5, scope: !249)
!256 = distinct !{!256, !250, !257, !163}
!257 = !DILocation(line: 17, column: 19, scope: !244)
!258 = !DILocation(line: 18, column: 1, scope: !230)
!259 = distinct !DISubprogram(name: "crypto_sign_keypair", scope: !260, file: !260, line: 22, type: !261, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !128, retainedNodes: !141)
!260 = !DIFile(filename: "../../../src/sign.c", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!261 = !DISubroutineType(types: !262)
!262 = !{!39, !263, !263}
!263 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 32)
!264 = !DILocalVariable(name: "pk", arg: 1, scope: !259, file: !260, line: 22, type: !263)
!265 = !DILocation(line: 0, scope: !259)
!266 = !DILocalVariable(name: "sk", arg: 2, scope: !259, file: !260, line: 22, type: !263)
!267 = !DILocalVariable(name: "seed", scope: !259, file: !260, line: 23, type: !268)
!268 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 384, elements: !144)
!269 = !DILocation(line: 23, column: 10, scope: !259)
!270 = !DILocation(line: 25, column: 2, scope: !259)
!271 = !DILocation(line: 31, column: 12, scope: !259)
!272 = !DILocalVariable(name: "res", scope: !259, file: !260, line: 31, type: !39)
!273 = !DILocation(line: 40, column: 2, scope: !259)
!274 = !DILocation(line: 42, column: 2, scope: !259)
!275 = distinct !DISubprogram(name: "crypto_sign", scope: !260, file: !260, line: 45, type: !276, scopeLine: 46, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !128, retainedNodes: !141)
!276 = !DISubroutineType(types: !277)
!277 = !{!39, !263, !278, !279, !13, !279}
!278 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 32)
!279 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 32)
!280 = !DILocalVariable(name: "sm", arg: 1, scope: !275, file: !260, line: 45, type: !263)
!281 = !DILocation(line: 0, scope: !275)
!282 = !DILocalVariable(name: "smlen", arg: 2, scope: !275, file: !260, line: 45, type: !278)
!283 = !DILocalVariable(name: "m", arg: 3, scope: !275, file: !260, line: 45, type: !279)
!284 = !DILocalVariable(name: "mlen", arg: 4, scope: !275, file: !260, line: 45, type: !13)
!285 = !DILocalVariable(name: "sk", arg: 5, scope: !275, file: !260, line: 46, type: !279)
!286 = !DILocalVariable(name: "skx_d", scope: !275, file: !260, line: 52, type: !287)
!287 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 768, elements: !177)
!288 = !DILocation(line: 52, column: 10, scope: !275)
!289 = !DILocalVariable(name: "pskx", scope: !275, file: !260, line: 53, type: !5)
!290 = !DILocation(line: 54, column: 8, scope: !275)
!291 = !DILocalVariable(name: "res", scope: !275, file: !260, line: 47, type: !39)
!292 = !DILocalVariable(name: "salt", scope: !275, file: !260, line: 67, type: !105)
!293 = !DILocation(line: 67, column: 10, scope: !275)
!294 = !DILocation(line: 68, column: 2, scope: !275)
!295 = !DILocalVariable(name: "digest", scope: !275, file: !260, line: 74, type: !296)
!296 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 512, elements: !30)
!297 = !DILocation(line: 74, column: 10, scope: !275)
!298 = !DILocation(line: 75, column: 36, scope: !275)
!299 = !DILocation(line: 75, column: 2, scope: !275)
!300 = !DILocalVariable(name: "sig", scope: !275, file: !260, line: 82, type: !301)
!301 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 2176, elements: !302)
!302 = !{!303}
!303 = !DISubrange(count: 272)
!304 = !DILocation(line: 82, column: 10, scope: !275)
!305 = !DILocation(line: 83, column: 8, scope: !275)
!306 = !DILocation(line: 85, column: 7, scope: !307)
!307 = distinct !DILexicalBlock(scope: !275, file: !260, line: 85, column: 6)
!308 = !DILocation(line: 85, column: 6, scope: !307)
!309 = !DILocation(line: 86, column: 14, scope: !310)
!310 = distinct !DILexicalBlock(scope: !307, file: !260, line: 85, column: 12)
!311 = !DILocation(line: 86, column: 33, scope: !310)
!312 = !DILocation(line: 86, column: 3, scope: !310)
!313 = !DILocation(line: 87, column: 3, scope: !310)
!314 = !DILocation(line: 88, column: 17, scope: !310)
!315 = !DILocation(line: 88, column: 10, scope: !310)
!316 = !DILocation(line: 89, column: 2, scope: !310)
!317 = !DILocation(line: 92, column: 2, scope: !275)
!318 = !DILocation(line: 103, column: 1, scope: !275)
!319 = distinct !DISubprogram(name: "crypto_sign_open", scope: !260, file: !260, line: 105, type: !276, scopeLine: 106, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !128, retainedNodes: !141)
!320 = !DILocalVariable(name: "m", arg: 1, scope: !319, file: !260, line: 105, type: !263)
!321 = !DILocation(line: 0, scope: !319)
!322 = !DILocalVariable(name: "mlen", arg: 2, scope: !319, file: !260, line: 105, type: !278)
!323 = !DILocalVariable(name: "sm", arg: 3, scope: !319, file: !260, line: 105, type: !279)
!324 = !DILocalVariable(name: "smlen", arg: 4, scope: !319, file: !260, line: 105, type: !13)
!325 = !DILocalVariable(name: "pk", arg: 5, scope: !319, file: !260, line: 106, type: !279)
!326 = !DILocation(line: 107, column: 12, scope: !327)
!327 = distinct !DILexicalBlock(scope: !319, file: !260, line: 107, column: 6)
!328 = !DILocalVariable(name: "pkx", scope: !319, file: !260, line: 116, type: !329)
!329 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 694272, elements: !330)
!330 = !{!331}
!331 = !DISubrange(count: 86784)
!332 = !DILocation(line: 116, column: 10, scope: !319)
!333 = !DILocalVariable(name: "ppkx", scope: !319, file: !260, line: 117, type: !5)
!334 = !DILocation(line: 118, column: 8, scope: !319)
!335 = !DILocalVariable(name: "res", scope: !319, file: !260, line: 111, type: !39)
!336 = !DILocation(line: 119, column: 6, scope: !337)
!337 = distinct !DILexicalBlock(scope: !319, file: !260, line: 119, column: 6)
!338 = !DILocalVariable(name: "digest", scope: !319, file: !260, line: 131, type: !296)
!339 = !DILocation(line: 131, column: 10, scope: !319)
!340 = !DILocation(line: 132, column: 36, scope: !319)
!341 = !DILocation(line: 132, column: 52, scope: !319)
!342 = !DILocation(line: 132, column: 2, scope: !319)
!343 = !DILocation(line: 134, column: 8, scope: !319)
!344 = !DILocation(line: 135, column: 7, scope: !345)
!345 = distinct !DILexicalBlock(scope: !319, file: !260, line: 135, column: 6)
!346 = !DILocation(line: 135, column: 6, scope: !345)
!347 = !DILocation(line: 136, column: 17, scope: !348)
!348 = distinct !DILexicalBlock(scope: !345, file: !260, line: 135, column: 12)
!349 = !DILocation(line: 136, column: 33, scope: !348)
!350 = !DILocation(line: 136, column: 3, scope: !348)
!351 = !DILocation(line: 137, column: 17, scope: !348)
!352 = !DILocation(line: 137, column: 9, scope: !348)
!353 = !DILocation(line: 142, column: 2, scope: !319)
!354 = !DILocation(line: 143, column: 1, scope: !319)
!355 = distinct !DISubprogram(name: "expand_public", scope: !17, file: !17, line: 424, type: !356, scopeLine: 424, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !141)
!356 = !DISubroutineType(types: !357)
!357 = !{null, !358, !241}
!358 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 32)
!359 = !DILocalVariable(name: "P_matrix", arg: 1, scope: !355, file: !17, line: 424, type: !358)
!360 = !DILocation(line: 0, scope: !355)
!361 = !DILocalVariable(name: "seed", arg: 2, scope: !355, file: !17, line: 424, type: !241)
!362 = !DILocalVariable(name: "pk_bytes", scope: !355, file: !17, line: 425, type: !363)
!363 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 319680, elements: !364)
!364 = !{!365}
!365 = !DISubrange(count: 39960)
!366 = !DILocation(line: 425, column: 10, scope: !355)
!367 = !DILocation(line: 427, column: 2, scope: !355)
!368 = !DILocation(line: 517, column: 2, scope: !355)
!369 = !DILocation(line: 519, column: 1, scope: !355)
!370 = distinct !DISubprogram(name: "convert_bytes_to_GF", scope: !17, file: !17, line: 248, type: !371, scopeLine: 248, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!371 = !DISubroutineType(types: !372)
!372 = !{null, !358, !241, !54}
!373 = !DILocalVariable(name: "gf_array", arg: 1, scope: !370, file: !17, line: 248, type: !358)
!374 = !DILocation(line: 0, scope: !370)
!375 = !DILocalVariable(name: "byte_array", arg: 2, scope: !370, file: !17, line: 248, type: !241)
!376 = !DILocalVariable(name: "num", arg: 3, scope: !370, file: !17, line: 248, type: !54)
!377 = !DILocalVariable(name: "idx", scope: !378, file: !17, line: 254, type: !54)
!378 = distinct !DILexicalBlock(scope: !370, file: !17, line: 254, column: 2)
!379 = !DILocation(line: 0, scope: !378)
!380 = !DILocation(line: 254, column: 7, scope: !378)
!381 = !DILocation(line: 254, scope: !378)
!382 = !DILocation(line: 254, column: 27, scope: !383)
!383 = distinct !DILexicalBlock(scope: !378, file: !17, line: 254, column: 2)
!384 = !DILocation(line: 254, column: 2, scope: !378)
!385 = !DILocation(line: 255, column: 24, scope: !386)
!386 = distinct !DILexicalBlock(scope: !383, file: !17, line: 254, column: 45)
!387 = !DILocation(line: 255, column: 40, scope: !386)
!388 = !DILocation(line: 255, column: 14, scope: !386)
!389 = !DILocation(line: 255, column: 3, scope: !386)
!390 = !DILocation(line: 255, column: 21, scope: !386)
!391 = !DILocation(line: 256, column: 28, scope: !386)
!392 = !DILocation(line: 256, column: 44, scope: !386)
!393 = !DILocation(line: 256, column: 14, scope: !386)
!394 = !DILocation(line: 256, column: 20, scope: !386)
!395 = !DILocation(line: 256, column: 3, scope: !386)
!396 = !DILocation(line: 256, column: 25, scope: !386)
!397 = !DILocation(line: 254, column: 41, scope: !383)
!398 = !DILocation(line: 254, column: 2, scope: !383)
!399 = distinct !{!399, !384, !400, !163}
!400 = !DILocation(line: 257, column: 2, scope: !378)
!401 = !DILocation(line: 258, column: 10, scope: !402)
!402 = distinct !DILexicalBlock(scope: !370, file: !17, line: 258, column: 6)
!403 = !DILocation(line: 259, column: 39, scope: !404)
!404 = distinct !DILexicalBlock(scope: !402, file: !17, line: 258, column: 15)
!405 = !DILocation(line: 259, column: 24, scope: !404)
!406 = !DILocation(line: 259, column: 44, scope: !404)
!407 = !DILocation(line: 259, column: 3, scope: !404)
!408 = !DILocation(line: 259, column: 21, scope: !404)
!409 = !DILocation(line: 260, column: 2, scope: !404)
!410 = !DILocation(line: 262, column: 1, scope: !370)
!411 = distinct !DISubprogram(name: "_SNOVA_I_S_AES_ref_genkeys", scope: !17, file: !17, line: 672, type: !412, scopeLine: 672, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !141)
!412 = !DISubroutineType(types: !413)
!413 = !{!39, !5, !5, !241}
!414 = !DILocalVariable(name: "pk", arg: 1, scope: !411, file: !17, line: 672, type: !5)
!415 = !DILocation(line: 0, scope: !411)
!416 = !DILocalVariable(name: "sk", arg: 2, scope: !411, file: !17, line: 672, type: !5)
!417 = !DILocalVariable(name: "seed", arg: 3, scope: !411, file: !17, line: 672, type: !241)
!418 = !DILocation(line: 673, column: 6, scope: !419)
!419 = distinct !DILexicalBlock(scope: !411, file: !17, line: 673, column: 6)
!420 = !DILocation(line: 674, column: 3, scope: !421)
!421 = distinct !DILexicalBlock(scope: !419, file: !17, line: 673, column: 18)
!422 = !DILocation(line: 675, column: 2, scope: !421)
!423 = !DILocalVariable(name: "T12", scope: !411, file: !17, line: 680, type: !424)
!424 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 17280, elements: !425)
!425 = !{!426}
!426 = !DISubrange(count: 2160)
!427 = !DILocation(line: 680, column: 7, scope: !411)
!428 = !DILocalVariable(name: "P22", scope: !411, file: !17, line: 681, type: !429)
!429 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 16000, elements: !430)
!430 = !{!431}
!431 = !DISubrange(count: 2000)
!432 = !DILocation(line: 681, column: 7, scope: !411)
!433 = !DILocation(line: 683, column: 23, scope: !411)
!434 = !DILocation(line: 683, column: 2, scope: !411)
!435 = !DILocalVariable(name: "P_matrix", scope: !411, file: !17, line: 688, type: !436)
!436 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 677760, elements: !437)
!437 = !{!438}
!438 = !DISubrange(count: 84720)
!439 = !DILocation(line: 688, column: 7, scope: !411)
!440 = !DILocation(line: 690, column: 2, scope: !411)
!441 = !DILocalVariable(name: "P11", scope: !411, file: !17, line: 695, type: !358)
!442 = !DILocation(line: 696, column: 23, scope: !411)
!443 = !DILocalVariable(name: "P12", scope: !411, file: !17, line: 696, type: !358)
!444 = !DILocalVariable(name: "P21", scope: !411, file: !17, line: 697, type: !358)
!445 = !DILocalVariable(name: "F12", scope: !411, file: !17, line: 698, type: !446)
!446 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 86400, elements: !447)
!447 = !{!448}
!448 = !DISubrange(count: 10800)
!449 = !DILocation(line: 698, column: 7, scope: !411)
!450 = !DILocalVariable(name: "i1", scope: !451, file: !17, line: 700, type: !39)
!451 = distinct !DILexicalBlock(scope: !411, file: !17, line: 700, column: 2)
!452 = !DILocation(line: 0, scope: !451)
!453 = !DILocation(line: 700, column: 7, scope: !451)
!454 = !DILocation(line: 700, scope: !451)
!455 = !DILocation(line: 700, column: 22, scope: !456)
!456 = distinct !DILexicalBlock(scope: !451, file: !17, line: 700, column: 2)
!457 = !DILocation(line: 700, column: 2, scope: !451)
!458 = !DILocation(line: 701, column: 3, scope: !459)
!459 = distinct !DILexicalBlock(scope: !460, file: !17, line: 701, column: 3)
!460 = distinct !DILexicalBlock(scope: !456, file: !17, line: 700, column: 40)
!461 = !DILocation(line: 715, column: 2, scope: !462)
!462 = distinct !DILexicalBlock(scope: !411, file: !17, line: 715, column: 2)
!463 = !DILocation(line: 701, scope: !459)
!464 = !DILocalVariable(name: "j1", scope: !459, file: !17, line: 701, type: !39)
!465 = !DILocation(line: 0, scope: !459)
!466 = !DILocation(line: 701, column: 23, scope: !467)
!467 = distinct !DILexicalBlock(scope: !459, file: !17, line: 701, column: 3)
!468 = !DILocation(line: 703, column: 4, scope: !469)
!469 = distinct !DILexicalBlock(scope: !470, file: !17, line: 703, column: 4)
!470 = distinct !DILexicalBlock(scope: !467, file: !17, line: 701, column: 40)
!471 = !DILocation(line: 703, scope: !469)
!472 = !DILocalVariable(name: "idx", scope: !469, file: !17, line: 703, type: !39)
!473 = !DILocation(line: 0, scope: !469)
!474 = !DILocation(line: 703, column: 26, scope: !475)
!475 = distinct !DILexicalBlock(scope: !469, file: !17, line: 703, column: 4)
!476 = !DILocation(line: 704, column: 5, scope: !477)
!477 = distinct !DILexicalBlock(scope: !478, file: !17, line: 704, column: 5)
!478 = distinct !DILexicalBlock(scope: !475, file: !17, line: 703, column: 44)
!479 = !DILocation(line: 704, scope: !477)
!480 = !DILocalVariable(name: "k1", scope: !477, file: !17, line: 704, type: !39)
!481 = !DILocation(line: 0, scope: !477)
!482 = !DILocation(line: 704, column: 25, scope: !483)
!483 = distinct !DILexicalBlock(scope: !477, file: !17, line: 704, column: 5)
!484 = !DILocation(line: 706, column: 31, scope: !485)
!485 = distinct !DILexicalBlock(scope: !483, file: !17, line: 704, column: 42)
!486 = !DILocation(line: 706, column: 41, scope: !485)
!487 = !DILocation(line: 706, column: 47, scope: !485)
!488 = !DILocation(line: 706, column: 57, scope: !485)
!489 = !DILocation(line: 706, column: 63, scope: !485)
!490 = !DILocation(line: 706, column: 22, scope: !485)
!491 = !DILocation(line: 707, column: 31, scope: !485)
!492 = !DILocation(line: 707, column: 41, scope: !485)
!493 = !DILocation(line: 707, column: 47, scope: !485)
!494 = !DILocation(line: 707, column: 57, scope: !485)
!495 = !DILocation(line: 707, column: 64, scope: !485)
!496 = !DILocation(line: 707, column: 22, scope: !485)
!497 = !DILocation(line: 708, column: 31, scope: !485)
!498 = !DILocation(line: 708, column: 41, scope: !485)
!499 = !DILocation(line: 708, column: 47, scope: !485)
!500 = !DILocation(line: 708, column: 22, scope: !485)
!501 = !DILocation(line: 706, column: 6, scope: !485)
!502 = !DILocation(line: 704, column: 38, scope: !483)
!503 = !DILocation(line: 704, column: 5, scope: !483)
!504 = distinct !{!504, !476, !505, !163}
!505 = !DILocation(line: 709, column: 5, scope: !477)
!506 = !DILocation(line: 703, column: 40, scope: !475)
!507 = !DILocation(line: 703, column: 4, scope: !475)
!508 = distinct !{!508, !468, !509, !163}
!509 = !DILocation(line: 710, column: 4, scope: !469)
!510 = !DILocation(line: 701, column: 36, scope: !467)
!511 = !DILocation(line: 701, column: 3, scope: !467)
!512 = distinct !{!512, !458, !513, !163}
!513 = !DILocation(line: 711, column: 3, scope: !459)
!514 = !DILocation(line: 700, column: 36, scope: !456)
!515 = !DILocation(line: 700, column: 2, scope: !456)
!516 = distinct !{!516, !457, !517, !163}
!517 = !DILocation(line: 712, column: 2, scope: !451)
!518 = !DILocation(line: 715, scope: !462)
!519 = !DILocalVariable(name: "i1", scope: !462, file: !17, line: 715, type: !39)
!520 = !DILocation(line: 0, scope: !462)
!521 = !DILocation(line: 715, column: 22, scope: !522)
!522 = distinct !DILexicalBlock(scope: !462, file: !17, line: 715, column: 2)
!523 = !DILocation(line: 719, column: 2, scope: !524)
!524 = distinct !DILexicalBlock(scope: !411, file: !17, line: 719, column: 2)
!525 = !DILocation(line: 716, column: 15, scope: !526)
!526 = distinct !DILexicalBlock(scope: !522, file: !17, line: 715, column: 71)
!527 = !DILocation(line: 716, column: 24, scope: !526)
!528 = !DILocation(line: 716, column: 3, scope: !526)
!529 = !DILocation(line: 715, column: 67, scope: !522)
!530 = !DILocation(line: 715, column: 2, scope: !522)
!531 = distinct !{!531, !461, !532, !163}
!532 = !DILocation(line: 717, column: 2, scope: !462)
!533 = !DILocation(line: 719, scope: !524)
!534 = !DILocalVariable(name: "i1", scope: !524, file: !17, line: 719, type: !39)
!535 = !DILocation(line: 0, scope: !524)
!536 = !DILocation(line: 719, column: 22, scope: !537)
!537 = distinct !DILexicalBlock(scope: !524, file: !17, line: 719, column: 2)
!538 = !DILocation(line: 720, column: 3, scope: !539)
!539 = distinct !DILexicalBlock(scope: !540, file: !17, line: 720, column: 3)
!540 = distinct !DILexicalBlock(scope: !537, file: !17, line: 719, column: 40)
!541 = !DILocation(line: 697, column: 23, scope: !411)
!542 = !DILocation(line: 734, column: 2, scope: !543)
!543 = distinct !DILexicalBlock(scope: !411, file: !17, line: 734, column: 2)
!544 = !DILocation(line: 720, scope: !539)
!545 = !DILocalVariable(name: "idx", scope: !539, file: !17, line: 720, type: !39)
!546 = !DILocation(line: 0, scope: !539)
!547 = !DILocation(line: 720, column: 25, scope: !548)
!548 = distinct !DILexicalBlock(scope: !539, file: !17, line: 720, column: 3)
!549 = !DILocation(line: 721, column: 4, scope: !550)
!550 = distinct !DILexicalBlock(scope: !551, file: !17, line: 721, column: 4)
!551 = distinct !DILexicalBlock(scope: !548, file: !17, line: 720, column: 43)
!552 = !DILocation(line: 721, scope: !550)
!553 = !DILocalVariable(name: "k1", scope: !550, file: !17, line: 721, type: !39)
!554 = !DILocation(line: 0, scope: !550)
!555 = !DILocation(line: 721, column: 24, scope: !556)
!556 = distinct !DILexicalBlock(scope: !550, file: !17, line: 721, column: 4)
!557 = !DILocation(line: 722, column: 5, scope: !558)
!558 = distinct !DILexicalBlock(scope: !559, file: !17, line: 722, column: 5)
!559 = distinct !DILexicalBlock(scope: !556, file: !17, line: 721, column: 41)
!560 = !DILocation(line: 722, scope: !558)
!561 = !DILocalVariable(name: "j1", scope: !558, file: !17, line: 722, type: !39)
!562 = !DILocation(line: 0, scope: !558)
!563 = !DILocation(line: 722, column: 25, scope: !564)
!564 = distinct !DILexicalBlock(scope: !558, file: !17, line: 722, column: 5)
!565 = !DILocation(line: 724, column: 31, scope: !566)
!566 = distinct !DILexicalBlock(scope: !564, file: !17, line: 722, column: 42)
!567 = !DILocation(line: 724, column: 41, scope: !566)
!568 = !DILocation(line: 724, column: 47, scope: !566)
!569 = !DILocation(line: 724, column: 57, scope: !566)
!570 = !DILocation(line: 724, column: 63, scope: !566)
!571 = !DILocation(line: 724, column: 22, scope: !566)
!572 = !DILocation(line: 724, column: 86, scope: !566)
!573 = !DILocation(line: 724, column: 96, scope: !566)
!574 = !DILocation(line: 724, column: 102, scope: !566)
!575 = !DILocation(line: 724, column: 77, scope: !566)
!576 = !DILocation(line: 725, column: 31, scope: !566)
!577 = !DILocation(line: 725, column: 41, scope: !566)
!578 = !DILocation(line: 725, column: 48, scope: !566)
!579 = !DILocation(line: 725, column: 58, scope: !566)
!580 = !DILocation(line: 725, column: 64, scope: !566)
!581 = !DILocation(line: 725, column: 22, scope: !566)
!582 = !DILocation(line: 724, column: 6, scope: !566)
!583 = !DILocation(line: 722, column: 38, scope: !564)
!584 = !DILocation(line: 722, column: 5, scope: !564)
!585 = distinct !{!585, !557, !586, !163}
!586 = !DILocation(line: 726, column: 5, scope: !558)
!587 = !DILocation(line: 721, column: 37, scope: !556)
!588 = !DILocation(line: 721, column: 4, scope: !556)
!589 = distinct !{!589, !549, !590, !163}
!590 = !DILocation(line: 727, column: 4, scope: !550)
!591 = !DILocation(line: 720, column: 39, scope: !548)
!592 = !DILocation(line: 720, column: 3, scope: !548)
!593 = distinct !{!593, !538, !594, !163}
!594 = !DILocation(line: 728, column: 3, scope: !539)
!595 = !DILocation(line: 719, column: 36, scope: !537)
!596 = !DILocation(line: 719, column: 2, scope: !537)
!597 = distinct !{!597, !523, !598, !163}
!598 = !DILocation(line: 729, column: 2, scope: !524)
!599 = !DILocation(line: 734, scope: !543)
!600 = !DILocalVariable(name: "i1", scope: !543, file: !17, line: 734, type: !39)
!601 = !DILocation(line: 0, scope: !543)
!602 = !DILocation(line: 734, column: 22, scope: !603)
!603 = distinct !DILexicalBlock(scope: !543, file: !17, line: 734, column: 2)
!604 = !DILocation(line: 735, column: 3, scope: !605)
!605 = distinct !DILexicalBlock(scope: !606, file: !17, line: 735, column: 3)
!606 = distinct !DILexicalBlock(scope: !603, file: !17, line: 734, column: 40)
!607 = !DILocation(line: 735, scope: !605)
!608 = !DILocalVariable(name: "j1", scope: !605, file: !17, line: 735, type: !39)
!609 = !DILocation(line: 0, scope: !605)
!610 = !DILocation(line: 735, column: 23, scope: !611)
!611 = distinct !DILexicalBlock(scope: !605, file: !17, line: 735, column: 3)
!612 = !DILocation(line: 736, column: 4, scope: !613)
!613 = distinct !DILexicalBlock(scope: !614, file: !17, line: 736, column: 4)
!614 = distinct !DILexicalBlock(scope: !611, file: !17, line: 735, column: 40)
!615 = !DILocation(line: 736, scope: !613)
!616 = !DILocalVariable(name: "idx", scope: !613, file: !17, line: 736, type: !39)
!617 = !DILocation(line: 0, scope: !613)
!618 = !DILocation(line: 736, column: 26, scope: !619)
!619 = distinct !DILexicalBlock(scope: !613, file: !17, line: 736, column: 4)
!620 = !DILocation(line: 737, column: 5, scope: !621)
!621 = distinct !DILexicalBlock(scope: !622, file: !17, line: 737, column: 5)
!622 = distinct !DILexicalBlock(scope: !619, file: !17, line: 736, column: 44)
!623 = !DILocation(line: 737, scope: !621)
!624 = !DILocalVariable(name: "k1", scope: !621, file: !17, line: 737, type: !39)
!625 = !DILocation(line: 0, scope: !621)
!626 = !DILocation(line: 737, column: 25, scope: !627)
!627 = distinct !DILexicalBlock(scope: !621, file: !17, line: 737, column: 5)
!628 = !DILocation(line: 739, column: 31, scope: !629)
!629 = distinct !DILexicalBlock(scope: !627, file: !17, line: 737, column: 42)
!630 = !DILocation(line: 739, column: 41, scope: !629)
!631 = !DILocation(line: 739, column: 47, scope: !629)
!632 = !DILocation(line: 739, column: 57, scope: !629)
!633 = !DILocation(line: 739, column: 63, scope: !629)
!634 = !DILocation(line: 739, column: 22, scope: !629)
!635 = !DILocation(line: 740, column: 31, scope: !629)
!636 = !DILocation(line: 740, column: 41, scope: !629)
!637 = !DILocation(line: 740, column: 47, scope: !629)
!638 = !DILocation(line: 740, column: 57, scope: !629)
!639 = !DILocation(line: 740, column: 64, scope: !629)
!640 = !DILocation(line: 740, column: 22, scope: !629)
!641 = !DILocation(line: 741, column: 31, scope: !629)
!642 = !DILocation(line: 741, column: 41, scope: !629)
!643 = !DILocation(line: 741, column: 47, scope: !629)
!644 = !DILocation(line: 741, column: 22, scope: !629)
!645 = !DILocation(line: 739, column: 6, scope: !629)
!646 = !DILocation(line: 737, column: 38, scope: !627)
!647 = !DILocation(line: 737, column: 5, scope: !627)
!648 = distinct !{!648, !620, !649, !163}
!649 = !DILocation(line: 742, column: 5, scope: !621)
!650 = !DILocation(line: 736, column: 40, scope: !619)
!651 = !DILocation(line: 736, column: 4, scope: !619)
!652 = distinct !{!652, !612, !653, !163}
!653 = !DILocation(line: 743, column: 4, scope: !613)
!654 = !DILocation(line: 735, column: 36, scope: !611)
!655 = !DILocation(line: 735, column: 3, scope: !611)
!656 = distinct !{!656, !604, !657, !163}
!657 = !DILocation(line: 744, column: 3, scope: !605)
!658 = !DILocation(line: 734, column: 36, scope: !603)
!659 = !DILocation(line: 734, column: 2, scope: !603)
!660 = distinct !{!660, !542, !661, !163}
!661 = !DILocation(line: 745, column: 2, scope: !543)
!662 = !DILocation(line: 757, column: 2, scope: !411)
!663 = !DILocation(line: 758, column: 17, scope: !411)
!664 = !DILocation(line: 758, column: 2, scope: !411)
!665 = !DILocation(line: 759, column: 2, scope: !411)
!666 = !DILocation(line: 762, column: 35, scope: !411)
!667 = !DILocation(line: 762, column: 2, scope: !411)
!668 = !DILocation(line: 765, column: 2, scope: !411)
!669 = distinct !DISubprogram(name: "snova_init", scope: !17, file: !17, line: 223, type: !670, scopeLine: 223, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!670 = !DISubroutineType(types: !671)
!671 = !{null}
!672 = !DILocation(line: 224, column: 13, scope: !669)
!673 = !DILocation(line: 225, column: 2, scope: !669)
!674 = !DILocation(line: 226, column: 2, scope: !669)
!675 = !DILocation(line: 240, column: 2, scope: !669)
!676 = !DILocation(line: 243, column: 1, scope: !669)
!677 = distinct !DISubprogram(name: "expand_T12", scope: !17, file: !17, line: 576, type: !356, scopeLine: 576, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!678 = !DILocalVariable(name: "T12", arg: 1, scope: !677, file: !17, line: 576, type: !358)
!679 = !DILocation(line: 0, scope: !677)
!680 = !DILocalVariable(name: "seed", arg: 2, scope: !677, file: !17, line: 576, type: !241)
!681 = !DILocalVariable(name: "T12coef", scope: !677, file: !17, line: 577, type: !682)
!682 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 4320, elements: !683)
!683 = !{!684}
!684 = !DISubrange(count: 540)
!685 = !DILocation(line: 577, column: 7, scope: !677)
!686 = !DILocalVariable(name: "sk_data", scope: !677, file: !17, line: 578, type: !687)
!687 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 256, elements: !76)
!688 = !DILocation(line: 578, column: 7, scope: !677)
!689 = !DILocalVariable(name: "state", scope: !677, file: !17, line: 579, type: !690)
!690 = !DIDerivedType(tag: DW_TAG_typedef, name: "shake_t", file: !691, line: 9, baseType: !692)
!691 = !DIFile(filename: "../../../src/symmetric.h", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!692 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !691, line: 7, size: 1792, elements: !693)
!693 = !{!694}
!694 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !692, file: !691, line: 8, baseType: !695, size: 1792)
!695 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 1792, elements: !696)
!696 = !{!697}
!697 = !DISubrange(count: 28)
!698 = !DILocation(line: 579, column: 10, scope: !677)
!699 = !DILocation(line: 581, column: 2, scope: !677)
!700 = !DILocation(line: 582, column: 2, scope: !677)
!701 = !DILocation(line: 583, column: 2, scope: !677)
!702 = !DILocalVariable(name: "idx", scope: !677, file: !17, line: 585, type: !54)
!703 = !DILocalVariable(name: "t_idx", scope: !677, file: !17, line: 586, type: !54)
!704 = !DILocation(line: 588, column: 2, scope: !677)
!705 = !DILocation(line: 588, column: 15, scope: !677)
!706 = !DILocation(line: 610, column: 2, scope: !707)
!707 = distinct !DILexicalBlock(scope: !677, file: !17, line: 610, column: 2)
!708 = !DILocation(line: 589, column: 11, scope: !709)
!709 = distinct !DILexicalBlock(scope: !710, file: !17, line: 589, column: 7)
!710 = distinct !DILexicalBlock(scope: !677, file: !17, line: 588, column: 46)
!711 = !DILocation(line: 590, column: 4, scope: !712)
!712 = distinct !DILexicalBlock(scope: !709, file: !17, line: 589, column: 29)
!713 = !DILocation(line: 592, column: 3, scope: !712)
!714 = !DILocation(line: 601, column: 20, scope: !710)
!715 = !DILocation(line: 601, column: 33, scope: !710)
!716 = !DILocation(line: 601, column: 3, scope: !710)
!717 = !DILocation(line: 601, column: 18, scope: !710)
!718 = !DILocation(line: 602, column: 8, scope: !710)
!719 = !DILocation(line: 603, column: 33, scope: !710)
!720 = !DILocation(line: 603, column: 3, scope: !710)
!721 = !DILocation(line: 603, column: 18, scope: !710)
!722 = !DILocation(line: 604, column: 8, scope: !710)
!723 = !DILocation(line: 607, column: 6, scope: !710)
!724 = distinct !{!724, !704, !725, !163}
!725 = !DILocation(line: 608, column: 2, scope: !677)
!726 = !DILocation(line: 610, scope: !707)
!727 = !DILocalVariable(name: "i1", scope: !707, file: !17, line: 610, type: !54)
!728 = !DILocation(line: 0, scope: !707)
!729 = !DILocation(line: 610, column: 25, scope: !730)
!730 = distinct !DILexicalBlock(scope: !707, file: !17, line: 610, column: 2)
!731 = !DILocation(line: 611, column: 25, scope: !732)
!732 = distinct !DILexicalBlock(scope: !730, file: !17, line: 610, column: 52)
!733 = !DILocation(line: 611, column: 18, scope: !732)
!734 = !DILocation(line: 611, column: 50, scope: !732)
!735 = !DILocation(line: 611, column: 39, scope: !732)
!736 = !DILocation(line: 611, column: 3, scope: !732)
!737 = !DILocation(line: 610, column: 48, scope: !730)
!738 = !DILocation(line: 610, column: 2, scope: !730)
!739 = distinct !{!739, !706, !740, !163}
!740 = !DILocation(line: 612, column: 2, scope: !707)
!741 = !DILocation(line: 613, column: 1, scope: !677)
!742 = distinct !DISubprogram(name: "gf_mat_mul_add", scope: !17, file: !17, line: 57, type: !743, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!743 = !DISubroutineType(types: !744)
!744 = !{null, !358, !745, !745}
!745 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !746, size: 32)
!746 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
!747 = !DILocalVariable(name: "a", arg: 1, scope: !742, file: !17, line: 57, type: !358)
!748 = !DILocation(line: 0, scope: !742)
!749 = !DILocalVariable(name: "b", arg: 2, scope: !742, file: !17, line: 57, type: !745)
!750 = !DILocalVariable(name: "c", arg: 3, scope: !742, file: !17, line: 57, type: !745)
!751 = !DILocalVariable(name: "i1", scope: !752, file: !17, line: 58, type: !39)
!752 = distinct !DILexicalBlock(scope: !742, file: !17, line: 58, column: 2)
!753 = !DILocation(line: 0, scope: !752)
!754 = !DILocation(line: 58, column: 7, scope: !752)
!755 = !DILocation(line: 58, scope: !752)
!756 = !DILocation(line: 58, column: 22, scope: !757)
!757 = distinct !DILexicalBlock(scope: !752, file: !17, line: 58, column: 2)
!758 = !DILocation(line: 58, column: 2, scope: !752)
!759 = !DILocation(line: 59, column: 3, scope: !760)
!760 = distinct !DILexicalBlock(scope: !757, file: !17, line: 59, column: 3)
!761 = !DILocation(line: 59, scope: !760)
!762 = !DILocalVariable(name: "j1", scope: !760, file: !17, line: 59, type: !39)
!763 = !DILocation(line: 0, scope: !760)
!764 = !DILocation(line: 59, column: 23, scope: !765)
!765 = distinct !DILexicalBlock(scope: !760, file: !17, line: 59, column: 3)
!766 = !DILocalVariable(name: "sum", scope: !767, file: !17, line: 60, type: !19)
!767 = distinct !DILexicalBlock(scope: !765, file: !17, line: 59, column: 40)
!768 = !DILocation(line: 0, scope: !767)
!769 = !DILocation(line: 60, column: 9, scope: !767)
!770 = !DILocalVariable(name: "k1", scope: !771, file: !17, line: 61, type: !39)
!771 = distinct !DILexicalBlock(scope: !767, file: !17, line: 61, column: 4)
!772 = !DILocation(line: 0, scope: !771)
!773 = !DILocation(line: 61, column: 9, scope: !771)
!774 = !DILocation(line: 61, scope: !771)
!775 = !DILocation(line: 61, column: 24, scope: !776)
!776 = distinct !DILexicalBlock(scope: !771, file: !17, line: 61, column: 4)
!777 = !DILocation(line: 61, column: 4, scope: !771)
!778 = !DILocation(line: 62, column: 35, scope: !779)
!779 = distinct !DILexicalBlock(scope: !776, file: !17, line: 61, column: 41)
!780 = !DILocation(line: 62, column: 45, scope: !779)
!781 = !DILocation(line: 62, column: 30, scope: !779)
!782 = !DILocation(line: 62, column: 57, scope: !779)
!783 = !DILocation(line: 62, column: 67, scope: !779)
!784 = !DILocation(line: 62, column: 52, scope: !779)
!785 = !DILocation(line: 62, column: 22, scope: !779)
!786 = !DILocation(line: 62, column: 5, scope: !779)
!787 = !DILocation(line: 61, column: 37, scope: !776)
!788 = !DILocation(line: 61, column: 4, scope: !776)
!789 = distinct !{!789, !777, !790, !163}
!790 = !DILocation(line: 63, column: 4, scope: !771)
!791 = !DILocation(line: 64, column: 21, scope: !767)
!792 = !DILocation(line: 64, column: 31, scope: !767)
!793 = !DILocation(line: 64, column: 16, scope: !767)
!794 = !DILocation(line: 64, column: 38, scope: !767)
!795 = !DILocation(line: 64, column: 4, scope: !767)
!796 = !DILocation(line: 59, column: 36, scope: !765)
!797 = !DILocation(line: 59, column: 3, scope: !765)
!798 = distinct !{!798, !759, !799, !163}
!799 = !DILocation(line: 65, column: 3, scope: !760)
!800 = !DILocation(line: 58, column: 35, scope: !757)
!801 = !DILocation(line: 58, column: 2, scope: !757)
!802 = distinct !{!802, !758, !803, !163}
!803 = !DILocation(line: 65, column: 3, scope: !752)
!804 = !DILocation(line: 66, column: 1, scope: !742)
!805 = distinct !DISubprogram(name: "gf_set_add", scope: !17, file: !17, line: 34, type: !806, scopeLine: 34, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!806 = !DISubroutineType(types: !807)
!807 = !{null, !358, !746}
!808 = !DILocalVariable(name: "a", arg: 1, scope: !805, file: !17, line: 34, type: !358)
!809 = !DILocation(line: 0, scope: !805)
!810 = !DILocalVariable(name: "b", arg: 2, scope: !805, file: !17, line: 34, type: !746)
!811 = !DILocation(line: 35, column: 17, scope: !805)
!812 = !DILocation(line: 35, column: 20, scope: !805)
!813 = !DILocation(line: 35, column: 32, scope: !805)
!814 = !DILocation(line: 35, column: 30, scope: !805)
!815 = !DILocation(line: 35, column: 7, scope: !805)
!816 = !DILocation(line: 35, column: 5, scope: !805)
!817 = !DILocation(line: 36, column: 1, scope: !805)
!818 = distinct !DISubprogram(name: "compress_pk", scope: !17, file: !17, line: 332, type: !819, scopeLine: 332, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!819 = !DISubroutineType(types: !820)
!820 = !{null, !5, !358}
!821 = !DILocalVariable(name: "pk", arg: 1, scope: !818, file: !17, line: 332, type: !5)
!822 = !DILocation(line: 0, scope: !818)
!823 = !DILocalVariable(name: "P22", arg: 2, scope: !818, file: !17, line: 332, type: !358)
!824 = !DILocation(line: 377, column: 2, scope: !818)
!825 = !DILocation(line: 379, column: 1, scope: !818)
!826 = distinct !DISubprogram(name: "compress_gf", scope: !17, file: !17, line: 265, type: !827, scopeLine: 265, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!827 = !DISubroutineType(types: !828)
!828 = !{null, !5, !745, !54}
!829 = !DILocalVariable(name: "byte_array", arg: 1, scope: !826, file: !17, line: 265, type: !5)
!830 = !DILocation(line: 0, scope: !826)
!831 = !DILocalVariable(name: "gf_array", arg: 2, scope: !826, file: !17, line: 265, type: !745)
!832 = !DILocalVariable(name: "num", arg: 3, scope: !826, file: !17, line: 265, type: !54)
!833 = !DILocalVariable(name: "idx", scope: !826, file: !17, line: 266, type: !54)
!834 = !DILocalVariable(name: "out_idx", scope: !826, file: !17, line: 267, type: !54)
!835 = !DILocation(line: 268, column: 21, scope: !826)
!836 = !DILocalVariable(name: "num_bytes", scope: !826, file: !17, line: 268, type: !54)
!837 = !DILocation(line: 270, column: 2, scope: !826)
!838 = !DILocation(line: 267, column: 9, scope: !826)
!839 = !DILocation(line: 266, column: 9, scope: !826)
!840 = !DILocalVariable(name: "val", scope: !841, file: !17, line: 271, type: !11)
!841 = distinct !DILexicalBlock(scope: !826, file: !17, line: 270, column: 5)
!842 = !DILocation(line: 0, scope: !841)
!843 = !DILocalVariable(name: "fact", scope: !841, file: !17, line: 272, type: !11)
!844 = !DILocalVariable(name: "i1", scope: !841, file: !17, line: 274, type: !39)
!845 = !DILocation(line: 275, column: 3, scope: !841)
!846 = !DILocation(line: 275, column: 13, scope: !841)
!847 = !DILocation(line: 275, column: 23, scope: !841)
!848 = !DILocation(line: 284, column: 3, scope: !841)
!849 = !DILocation(line: 276, column: 19, scope: !850)
!850 = distinct !DILexicalBlock(scope: !841, file: !17, line: 275, column: 37)
!851 = !DILocation(line: 276, column: 33, scope: !850)
!852 = !DILocation(line: 276, column: 18, scope: !850)
!853 = !DILocation(line: 276, column: 16, scope: !850)
!854 = !DILocation(line: 276, column: 8, scope: !850)
!855 = !DILocation(line: 277, column: 7, scope: !850)
!856 = !DILocation(line: 278, column: 6, scope: !850)
!857 = !DILocation(line: 279, column: 9, scope: !850)
!858 = distinct !{!858, !845, !859, !163}
!859 = !DILocation(line: 280, column: 3, scope: !841)
!860 = !DILocalVariable(name: "j1", scope: !841, file: !17, line: 283, type: !39)
!861 = !DILocation(line: 284, column: 26, scope: !841)
!862 = !DILocation(line: 285, column: 26, scope: !863)
!863 = distinct !DILexicalBlock(scope: !841, file: !17, line: 284, column: 50)
!864 = !DILocation(line: 285, column: 4, scope: !863)
!865 = !DILocation(line: 285, column: 24, scope: !863)
!866 = !DILocation(line: 286, column: 11, scope: !863)
!867 = !DILocation(line: 287, column: 14, scope: !863)
!868 = distinct !{!868, !848, !869, !163}
!869 = !DILocation(line: 289, column: 3, scope: !841)
!870 = !DILocation(line: 290, column: 15, scope: !826)
!871 = !DILocation(line: 290, column: 2, scope: !841)
!872 = distinct !{!872, !837, !873, !163}
!873 = !DILocation(line: 290, column: 20, scope: !826)
!874 = !DILocation(line: 291, column: 1, scope: !826)
!875 = distinct !DISubprogram(name: "gf_mult", scope: !17, file: !17, line: 22, type: !876, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!876 = !DISubroutineType(types: !877)
!877 = !{!19, !746, !746}
!878 = !DILocalVariable(name: "a", arg: 1, scope: !875, file: !17, line: 22, type: !746)
!879 = !DILocation(line: 0, scope: !875)
!880 = !DILocalVariable(name: "b", arg: 2, scope: !875, file: !17, line: 22, type: !746)
!881 = !DILocation(line: 23, column: 20, scope: !875)
!882 = !DILocation(line: 23, column: 22, scope: !875)
!883 = !DILocation(line: 23, column: 34, scope: !875)
!884 = !DILocation(line: 23, column: 32, scope: !875)
!885 = !DILocation(line: 23, column: 9, scope: !875)
!886 = !DILocation(line: 23, column: 2, scope: !875)
!887 = distinct !DISubprogram(name: "gen_a_FqS_sec", scope: !17, file: !17, line: 555, type: !888, scopeLine: 555, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!888 = !DISubroutineType(types: !889)
!889 = !{null, !358, !358}
!890 = !DILocalVariable(name: "Qm", arg: 1, scope: !887, file: !17, line: 555, type: !358)
!891 = !DILocation(line: 0, scope: !887)
!892 = !DILocalVariable(name: "q", arg: 2, scope: !887, file: !17, line: 555, type: !358)
!893 = !DILocalVariable(name: "i1", scope: !894, file: !17, line: 562, type: !39)
!894 = distinct !DILexicalBlock(scope: !887, file: !17, line: 562, column: 2)
!895 = !DILocation(line: 0, scope: !894)
!896 = !DILocation(line: 562, column: 7, scope: !894)
!897 = !DILocation(line: 562, scope: !894)
!898 = !DILocation(line: 562, column: 22, scope: !899)
!899 = distinct !DILexicalBlock(scope: !894, file: !17, line: 562, column: 2)
!900 = !DILocation(line: 562, column: 2, scope: !894)
!901 = !DILocalVariable(name: "sum", scope: !902, file: !17, line: 563, type: !19)
!902 = distinct !DILexicalBlock(scope: !899, file: !17, line: 562, column: 40)
!903 = !DILocation(line: 0, scope: !902)
!904 = !DILocation(line: 563, column: 8, scope: !902)
!905 = !DILocalVariable(name: "j1", scope: !906, file: !17, line: 564, type: !39)
!906 = distinct !DILexicalBlock(scope: !902, file: !17, line: 564, column: 3)
!907 = !DILocation(line: 0, scope: !906)
!908 = !DILocation(line: 564, column: 8, scope: !906)
!909 = !DILocation(line: 564, scope: !906)
!910 = !DILocation(line: 564, column: 23, scope: !911)
!911 = distinct !DILexicalBlock(scope: !906, file: !17, line: 564, column: 3)
!912 = !DILocation(line: 564, column: 3, scope: !906)
!913 = !DILocation(line: 565, column: 29, scope: !914)
!914 = distinct !DILexicalBlock(scope: !911, file: !17, line: 564, column: 40)
!915 = !DILocation(line: 565, column: 44, scope: !914)
!916 = !DILocation(line: 565, column: 55, scope: !914)
!917 = !DILocation(line: 565, column: 36, scope: !914)
!918 = !DILocation(line: 565, column: 21, scope: !914)
!919 = !DILocation(line: 565, column: 4, scope: !914)
!920 = !DILocation(line: 564, column: 36, scope: !911)
!921 = !DILocation(line: 564, column: 3, scope: !911)
!922 = distinct !{!922, !912, !923, !163}
!923 = !DILocation(line: 566, column: 3, scope: !906)
!924 = !DILocation(line: 567, column: 12, scope: !902)
!925 = !DILocation(line: 567, column: 3, scope: !902)
!926 = !DILocation(line: 567, column: 10, scope: !902)
!927 = !DILocation(line: 562, column: 36, scope: !899)
!928 = !DILocation(line: 562, column: 2, scope: !899)
!929 = distinct !{!929, !900, !930, !163}
!930 = !DILocation(line: 568, column: 2, scope: !894)
!931 = !DILocation(line: 569, column: 1, scope: !887)
!932 = distinct !DISubprogram(name: "init_gf_tables", scope: !17, file: !17, line: 148, type: !670, scopeLine: 148, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!933 = !DILocalVariable(name: "F_star", scope: !932, file: !17, line: 151, type: !934)
!934 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 120, elements: !935)
!935 = !{!936}
!936 = !DISubrange(count: 15)
!937 = !DILocation(line: 151, column: 10, scope: !932)
!938 = !DILocalVariable(name: "i1", scope: !939, file: !17, line: 152, type: !39)
!939 = distinct !DILexicalBlock(scope: !932, file: !17, line: 152, column: 2)
!940 = !DILocation(line: 0, scope: !939)
!941 = !DILocation(line: 152, column: 7, scope: !939)
!942 = !DILocation(line: 152, scope: !939)
!943 = !DILocation(line: 152, column: 22, scope: !944)
!944 = distinct !DILexicalBlock(scope: !939, file: !17, line: 152, column: 2)
!945 = !DILocation(line: 152, column: 2, scope: !939)
!946 = !DILocation(line: 156, column: 2, scope: !947)
!947 = distinct !DILexicalBlock(scope: !932, file: !17, line: 156, column: 2)
!948 = !DILocation(line: 153, column: 3, scope: !949)
!949 = distinct !DILexicalBlock(scope: !944, file: !17, line: 152, column: 34)
!950 = !DILocation(line: 153, column: 18, scope: !949)
!951 = !DILocation(line: 154, column: 17, scope: !949)
!952 = !DILocation(line: 154, column: 3, scope: !949)
!953 = !DILocation(line: 154, column: 28, scope: !949)
!954 = !DILocation(line: 152, column: 30, scope: !944)
!955 = !DILocation(line: 152, column: 2, scope: !944)
!956 = distinct !{!956, !945, !957, !163}
!957 = !DILocation(line: 155, column: 2, scope: !939)
!958 = !DILocation(line: 156, scope: !947)
!959 = !DILocalVariable(name: "i1", scope: !947, file: !17, line: 156, type: !39)
!960 = !DILocation(line: 0, scope: !947)
!961 = !DILocation(line: 156, column: 22, scope: !962)
!962 = distinct !DILexicalBlock(scope: !947, file: !17, line: 156, column: 2)
!963 = !DILocation(line: 157, column: 3, scope: !964)
!964 = distinct !DILexicalBlock(scope: !962, file: !17, line: 157, column: 3)
!965 = !DILocation(line: 161, column: 2, scope: !966)
!966 = distinct !DILexicalBlock(scope: !932, file: !17, line: 161, column: 2)
!967 = !DILocation(line: 157, scope: !964)
!968 = !DILocalVariable(name: "j1", scope: !964, file: !17, line: 157, type: !39)
!969 = !DILocation(line: 0, scope: !964)
!970 = !DILocation(line: 157, column: 23, scope: !971)
!971 = distinct !DILexicalBlock(scope: !964, file: !17, line: 157, column: 3)
!972 = !DILocation(line: 158, column: 63, scope: !973)
!973 = distinct !DILexicalBlock(scope: !971, file: !17, line: 157, column: 44)
!974 = !DILocation(line: 158, column: 69, scope: !973)
!975 = !DILocation(line: 158, column: 52, scope: !973)
!976 = !DILocation(line: 158, column: 15, scope: !973)
!977 = !DILocation(line: 158, column: 26, scope: !973)
!978 = !DILocation(line: 158, column: 38, scope: !973)
!979 = !DILocation(line: 158, column: 36, scope: !973)
!980 = !DILocation(line: 158, column: 4, scope: !973)
!981 = !DILocation(line: 158, column: 50, scope: !973)
!982 = !DILocation(line: 157, column: 40, scope: !971)
!983 = !DILocation(line: 157, column: 3, scope: !971)
!984 = distinct !{!984, !963, !985, !163}
!985 = !DILocation(line: 159, column: 3, scope: !964)
!986 = !DILocation(line: 156, column: 39, scope: !962)
!987 = !DILocation(line: 156, column: 2, scope: !962)
!988 = distinct !{!988, !946, !989, !163}
!989 = !DILocation(line: 159, column: 3, scope: !947)
!990 = !DILocation(line: 161, scope: !966)
!991 = !DILocalVariable(name: "i1", scope: !966, file: !17, line: 161, type: !39)
!992 = !DILocation(line: 0, scope: !966)
!993 = !DILocation(line: 161, column: 22, scope: !994)
!994 = distinct !DILexicalBlock(scope: !966, file: !17, line: 161, column: 2)
!995 = !DILocation(line: 162, column: 3, scope: !996)
!996 = distinct !DILexicalBlock(scope: !994, file: !17, line: 162, column: 3)
!997 = !DILocation(line: 174, column: 2, scope: !998)
!998 = distinct !DILexicalBlock(scope: !932, file: !17, line: 174, column: 2)
!999 = !DILocation(line: 162, scope: !996)
!1000 = !DILocalVariable(name: "j1", scope: !996, file: !17, line: 162, type: !39)
!1001 = !DILocation(line: 0, scope: !996)
!1002 = !DILocation(line: 162, column: 23, scope: !1003)
!1003 = distinct !DILexicalBlock(scope: !996, file: !17, line: 162, column: 3)
!1004 = !DILocation(line: 163, column: 39, scope: !1005)
!1005 = distinct !DILexicalBlock(scope: !1003, file: !17, line: 162, column: 40)
!1006 = !DILocation(line: 163, column: 35, scope: !1005)
!1007 = !DILocation(line: 163, column: 17, scope: !1005)
!1008 = !DILocation(line: 163, column: 27, scope: !1005)
!1009 = !DILocation(line: 163, column: 4, scope: !1005)
!1010 = !DILocation(line: 163, column: 33, scope: !1005)
!1011 = !DILocation(line: 162, column: 36, scope: !1003)
!1012 = !DILocation(line: 162, column: 3, scope: !1003)
!1013 = distinct !{!1013, !995, !1014, !163}
!1014 = !DILocation(line: 164, column: 3, scope: !996)
!1015 = !DILocation(line: 161, column: 35, scope: !994)
!1016 = !DILocation(line: 161, column: 2, scope: !994)
!1017 = distinct !{!1017, !965, !1018, !163}
!1018 = !DILocation(line: 164, column: 3, scope: !966)
!1019 = !DILocation(line: 174, scope: !998)
!1020 = !DILocalVariable(name: "i1", scope: !998, file: !17, line: 174, type: !39)
!1021 = !DILocation(line: 0, scope: !998)
!1022 = !DILocation(line: 174, column: 22, scope: !1023)
!1023 = distinct !DILexicalBlock(scope: !998, file: !17, line: 174, column: 2)
!1024 = !DILocation(line: 175, column: 14, scope: !1025)
!1025 = distinct !DILexicalBlock(scope: !1023, file: !17, line: 174, column: 39)
!1026 = !DILocalVariable(name: "val", scope: !1025, file: !17, line: 175, type: !19)
!1027 = !DILocation(line: 0, scope: !1025)
!1028 = !DILocalVariable(name: "j1", scope: !1029, file: !17, line: 176, type: !39)
!1029 = distinct !DILexicalBlock(scope: !1025, file: !17, line: 176, column: 3)
!1030 = !DILocation(line: 0, scope: !1029)
!1031 = !DILocation(line: 176, column: 8, scope: !1029)
!1032 = !DILocation(line: 176, scope: !1029)
!1033 = !DILocation(line: 176, column: 23, scope: !1034)
!1034 = distinct !DILexicalBlock(scope: !1029, file: !17, line: 176, column: 3)
!1035 = !DILocation(line: 176, column: 3, scope: !1029)
!1036 = !DILocation(line: 177, column: 23, scope: !1037)
!1037 = distinct !DILexicalBlock(scope: !1034, file: !17, line: 176, column: 40)
!1038 = !DILocation(line: 177, column: 10, scope: !1037)
!1039 = !DILocation(line: 176, column: 36, scope: !1034)
!1040 = !DILocation(line: 176, column: 3, scope: !1034)
!1041 = distinct !{!1041, !1035, !1042, !163}
!1042 = !DILocation(line: 178, column: 3, scope: !1029)
!1043 = !DILocation(line: 179, column: 3, scope: !1025)
!1044 = !DILocation(line: 179, column: 17, scope: !1025)
!1045 = !DILocation(line: 174, column: 35, scope: !1023)
!1046 = !DILocation(line: 174, column: 2, scope: !1023)
!1047 = distinct !{!1047, !997, !1048, !163}
!1048 = !DILocation(line: 180, column: 2, scope: !998)
!1049 = !DILocation(line: 181, column: 1, scope: !932)
!1050 = distinct !DISubprogram(name: "gen_S_array", scope: !17, file: !17, line: 202, type: !670, scopeLine: 202, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!1051 = !DILocation(line: 203, column: 2, scope: !1050)
!1052 = !DILocalVariable(name: "i1", scope: !1053, file: !17, line: 205, type: !39)
!1053 = distinct !DILexicalBlock(scope: !1050, file: !17, line: 205, column: 2)
!1054 = !DILocation(line: 0, scope: !1053)
!1055 = !DILocation(line: 205, column: 7, scope: !1053)
!1056 = !DILocation(line: 205, scope: !1053)
!1057 = !DILocation(line: 205, column: 22, scope: !1058)
!1058 = distinct !DILexicalBlock(scope: !1053, file: !17, line: 205, column: 2)
!1059 = !DILocation(line: 205, column: 2, scope: !1053)
!1060 = !DILocation(line: 206, column: 21, scope: !1061)
!1061 = distinct !DILexicalBlock(scope: !1058, file: !17, line: 205, column: 39)
!1062 = !DILocation(line: 206, column: 3, scope: !1061)
!1063 = !DILocation(line: 206, column: 27, scope: !1061)
!1064 = !DILocation(line: 205, column: 35, scope: !1058)
!1065 = !DILocation(line: 205, column: 2, scope: !1058)
!1066 = distinct !{!1066, !1059, !1067, !163}
!1067 = !DILocation(line: 207, column: 2, scope: !1053)
!1068 = !DILocation(line: 209, column: 2, scope: !1050)
!1069 = !DILocalVariable(name: "i1", scope: !1070, file: !17, line: 211, type: !39)
!1070 = distinct !DILexicalBlock(scope: !1050, file: !17, line: 211, column: 2)
!1071 = !DILocation(line: 0, scope: !1070)
!1072 = !DILocation(line: 211, column: 7, scope: !1070)
!1073 = !DILocation(line: 211, scope: !1070)
!1074 = !DILocation(line: 211, column: 22, scope: !1075)
!1075 = distinct !DILexicalBlock(scope: !1070, file: !17, line: 211, column: 2)
!1076 = !DILocation(line: 211, column: 2, scope: !1070)
!1077 = !DILocation(line: 212, column: 23, scope: !1078)
!1078 = distinct !DILexicalBlock(scope: !1075, file: !17, line: 211, column: 39)
!1079 = !DILocation(line: 212, column: 15, scope: !1078)
!1080 = !DILocation(line: 212, column: 72, scope: !1078)
!1081 = !DILocation(line: 212, column: 58, scope: !1078)
!1082 = !DILocation(line: 212, column: 3, scope: !1078)
!1083 = !DILocation(line: 211, column: 35, scope: !1075)
!1084 = !DILocation(line: 211, column: 2, scope: !1075)
!1085 = distinct !{!1085, !1076, !1086, !163}
!1086 = !DILocation(line: 213, column: 2, scope: !1070)
!1087 = !DILocation(line: 215, column: 1, scope: !1050)
!1088 = distinct !DISubprogram(name: "gen_fixed_ABQ", scope: !17, file: !17, line: 661, type: !1089, scopeLine: 661, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!1089 = !DISubroutineType(types: !1090)
!1090 = !{null, !1091}
!1091 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1092, size: 32)
!1092 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !43)
!1093 = !DILocalVariable(name: "abq_seed", arg: 1, scope: !1088, file: !17, line: 661, type: !1091)
!1094 = !DILocation(line: 0, scope: !1088)
!1095 = !DILocalVariable(name: "rng_out", scope: !1088, file: !17, line: 662, type: !34)
!1096 = !DILocation(line: 662, column: 10, scope: !1088)
!1097 = !DILocation(line: 664, column: 102, scope: !1088)
!1098 = !DILocation(line: 664, column: 2, scope: !1088)
!1099 = !DILocation(line: 665, column: 2, scope: !1088)
!1100 = !DILocation(line: 666, column: 1, scope: !1088)
!1101 = distinct !DISubprogram(name: "set_S", scope: !17, file: !17, line: 184, type: !1102, scopeLine: 184, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!1102 = !DISubroutineType(types: !1103)
!1103 = !{null, !358}
!1104 = !DILocalVariable(name: "gf_S1", arg: 1, scope: !1101, file: !17, line: 184, type: !358)
!1105 = !DILocation(line: 0, scope: !1101)
!1106 = !DILocalVariable(name: "i1", scope: !1107, file: !17, line: 186, type: !39)
!1107 = distinct !DILexicalBlock(scope: !1101, file: !17, line: 186, column: 2)
!1108 = !DILocation(line: 0, scope: !1107)
!1109 = !DILocation(line: 186, column: 7, scope: !1107)
!1110 = !DILocation(line: 186, scope: !1107)
!1111 = !DILocation(line: 186, column: 22, scope: !1112)
!1112 = distinct !DILexicalBlock(scope: !1107, file: !17, line: 186, column: 2)
!1113 = !DILocation(line: 186, column: 2, scope: !1107)
!1114 = !DILocation(line: 187, column: 3, scope: !1115)
!1115 = distinct !DILexicalBlock(scope: !1112, file: !17, line: 187, column: 3)
!1116 = !DILocation(line: 187, scope: !1115)
!1117 = !DILocalVariable(name: "j1", scope: !1115, file: !17, line: 187, type: !39)
!1118 = !DILocation(line: 0, scope: !1115)
!1119 = !DILocation(line: 187, column: 23, scope: !1120)
!1120 = distinct !DILexicalBlock(scope: !1115, file: !17, line: 187, column: 3)
!1121 = !DILocation(line: 188, column: 39, scope: !1122)
!1122 = distinct !DILexicalBlock(scope: !1120, file: !17, line: 187, column: 40)
!1123 = !DILocation(line: 188, column: 31, scope: !1122)
!1124 = !DILocation(line: 188, column: 13, scope: !1122)
!1125 = !DILocation(line: 188, column: 23, scope: !1122)
!1126 = !DILocation(line: 188, column: 4, scope: !1122)
!1127 = !DILocation(line: 188, column: 29, scope: !1122)
!1128 = !DILocation(line: 187, column: 36, scope: !1120)
!1129 = !DILocation(line: 187, column: 3, scope: !1120)
!1130 = distinct !{!1130, !1114, !1131, !163}
!1131 = !DILocation(line: 189, column: 3, scope: !1115)
!1132 = !DILocation(line: 186, column: 35, scope: !1112)
!1133 = !DILocation(line: 186, column: 2, scope: !1112)
!1134 = distinct !{!1134, !1113, !1135, !163}
!1135 = !DILocation(line: 189, column: 3, scope: !1107)
!1136 = !DILocation(line: 200, column: 1, scope: !1101)
!1137 = distinct !DISubprogram(name: "gf_mat_mul", scope: !17, file: !17, line: 46, type: !743, scopeLine: 46, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!1138 = !DILocalVariable(name: "a", arg: 1, scope: !1137, file: !17, line: 46, type: !358)
!1139 = !DILocation(line: 0, scope: !1137)
!1140 = !DILocalVariable(name: "b", arg: 2, scope: !1137, file: !17, line: 46, type: !745)
!1141 = !DILocalVariable(name: "c", arg: 3, scope: !1137, file: !17, line: 46, type: !745)
!1142 = !DILocalVariable(name: "i1", scope: !1143, file: !17, line: 47, type: !39)
!1143 = distinct !DILexicalBlock(scope: !1137, file: !17, line: 47, column: 2)
!1144 = !DILocation(line: 0, scope: !1143)
!1145 = !DILocation(line: 47, column: 7, scope: !1143)
!1146 = !DILocation(line: 47, scope: !1143)
!1147 = !DILocation(line: 47, column: 22, scope: !1148)
!1148 = distinct !DILexicalBlock(scope: !1143, file: !17, line: 47, column: 2)
!1149 = !DILocation(line: 47, column: 2, scope: !1143)
!1150 = !DILocation(line: 48, column: 3, scope: !1151)
!1151 = distinct !DILexicalBlock(scope: !1148, file: !17, line: 48, column: 3)
!1152 = !DILocation(line: 48, scope: !1151)
!1153 = !DILocalVariable(name: "j1", scope: !1151, file: !17, line: 48, type: !39)
!1154 = !DILocation(line: 0, scope: !1151)
!1155 = !DILocation(line: 48, column: 23, scope: !1156)
!1156 = distinct !DILexicalBlock(scope: !1151, file: !17, line: 48, column: 3)
!1157 = !DILocalVariable(name: "sum", scope: !1158, file: !17, line: 49, type: !19)
!1158 = distinct !DILexicalBlock(scope: !1156, file: !17, line: 48, column: 40)
!1159 = !DILocation(line: 0, scope: !1158)
!1160 = !DILocation(line: 49, column: 9, scope: !1158)
!1161 = !DILocalVariable(name: "k1", scope: !1162, file: !17, line: 50, type: !39)
!1162 = distinct !DILexicalBlock(scope: !1158, file: !17, line: 50, column: 4)
!1163 = !DILocation(line: 0, scope: !1162)
!1164 = !DILocation(line: 50, column: 9, scope: !1162)
!1165 = !DILocation(line: 50, scope: !1162)
!1166 = !DILocation(line: 50, column: 24, scope: !1167)
!1167 = distinct !DILexicalBlock(scope: !1162, file: !17, line: 50, column: 4)
!1168 = !DILocation(line: 50, column: 4, scope: !1162)
!1169 = !DILocation(line: 51, column: 35, scope: !1170)
!1170 = distinct !DILexicalBlock(scope: !1167, file: !17, line: 50, column: 41)
!1171 = !DILocation(line: 51, column: 45, scope: !1170)
!1172 = !DILocation(line: 51, column: 30, scope: !1170)
!1173 = !DILocation(line: 51, column: 57, scope: !1170)
!1174 = !DILocation(line: 51, column: 67, scope: !1170)
!1175 = !DILocation(line: 51, column: 52, scope: !1170)
!1176 = !DILocation(line: 51, column: 22, scope: !1170)
!1177 = !DILocation(line: 51, column: 5, scope: !1170)
!1178 = !DILocation(line: 50, column: 37, scope: !1167)
!1179 = !DILocation(line: 50, column: 4, scope: !1167)
!1180 = distinct !{!1180, !1168, !1181, !163}
!1181 = !DILocation(line: 52, column: 4, scope: !1162)
!1182 = !DILocation(line: 53, column: 27, scope: !1158)
!1183 = !DILocation(line: 53, column: 9, scope: !1158)
!1184 = !DILocation(line: 53, column: 19, scope: !1158)
!1185 = !DILocation(line: 53, column: 4, scope: !1158)
!1186 = !DILocation(line: 53, column: 25, scope: !1158)
!1187 = !DILocation(line: 48, column: 36, scope: !1156)
!1188 = !DILocation(line: 48, column: 3, scope: !1156)
!1189 = distinct !{!1189, !1150, !1190, !163}
!1190 = !DILocation(line: 54, column: 3, scope: !1151)
!1191 = !DILocation(line: 47, column: 35, scope: !1148)
!1192 = !DILocation(line: 47, column: 2, scope: !1148)
!1193 = distinct !{!1193, !1149, !1194, !163}
!1194 = !DILocation(line: 54, column: 3, scope: !1143)
!1195 = !DILocation(line: 55, column: 1, scope: !1137)
!1196 = distinct !DISubprogram(name: "_SNOVA_I_S_AES_ref_sk_expand", scope: !17, file: !17, line: 771, type: !1197, scopeLine: 771, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !141)
!1197 = !DISubroutineType(types: !1198)
!1198 = !{!39, !5, !241}
!1199 = !DILocalVariable(name: "skx", arg: 1, scope: !1196, file: !17, line: 771, type: !5)
!1200 = !DILocation(line: 0, scope: !1196)
!1201 = !DILocalVariable(name: "sk", arg: 2, scope: !1196, file: !17, line: 771, type: !241)
!1202 = !DILocation(line: 772, column: 2, scope: !1196)
!1203 = !DILocation(line: 774, column: 2, scope: !1196)
!1204 = distinct !DISubprogram(name: "_SNOVA_I_S_AES_ref_sign", scope: !17, file: !17, line: 780, type: !1205, scopeLine: 781, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !141)
!1205 = !DISubroutineType(types: !1206)
!1206 = !{!39, !241, !5, !241, !1207, !241}
!1207 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !54)
!1208 = !DILocalVariable(name: "skx", arg: 1, scope: !1204, file: !17, line: 780, type: !241)
!1209 = !DILocation(line: 0, scope: !1204)
!1210 = !DILocalVariable(name: "sig", arg: 2, scope: !1204, file: !17, line: 780, type: !5)
!1211 = !DILocalVariable(name: "digest", arg: 3, scope: !1204, file: !17, line: 780, type: !241)
!1212 = !DILocalVariable(name: "len_digest", arg: 4, scope: !1204, file: !17, line: 780, type: !1207)
!1213 = !DILocalVariable(name: "salt", arg: 5, scope: !1204, file: !17, line: 781, type: !241)
!1214 = !DILocation(line: 782, column: 6, scope: !1215)
!1215 = distinct !DILexicalBlock(scope: !1204, file: !17, line: 782, column: 6)
!1216 = !DILocation(line: 783, column: 3, scope: !1217)
!1217 = distinct !DILexicalBlock(scope: !1215, file: !17, line: 782, column: 18)
!1218 = !DILocation(line: 784, column: 2, scope: !1217)
!1219 = !DILocalVariable(name: "seed", scope: !1204, file: !17, line: 786, type: !241)
!1220 = !DILocalVariable(name: "T12", scope: !1204, file: !17, line: 788, type: !424)
!1221 = !DILocation(line: 788, column: 7, scope: !1204)
!1222 = !DILocation(line: 789, column: 23, scope: !1204)
!1223 = !DILocation(line: 789, column: 2, scope: !1204)
!1224 = !DILocalVariable(name: "P_matrix", scope: !1204, file: !17, line: 791, type: !436)
!1225 = !DILocation(line: 791, column: 7, scope: !1204)
!1226 = !DILocation(line: 793, column: 2, scope: !1204)
!1227 = !DILocalVariable(name: "P11", scope: !1204, file: !17, line: 798, type: !358)
!1228 = !DILocation(line: 799, column: 23, scope: !1204)
!1229 = !DILocalVariable(name: "P12", scope: !1204, file: !17, line: 799, type: !358)
!1230 = !DILocalVariable(name: "P21", scope: !1204, file: !17, line: 800, type: !358)
!1231 = !DILocalVariable(name: "F21", scope: !1204, file: !17, line: 802, type: !446)
!1232 = !DILocation(line: 802, column: 7, scope: !1204)
!1233 = !DILocalVariable(name: "i1", scope: !1234, file: !17, line: 804, type: !39)
!1234 = distinct !DILexicalBlock(scope: !1204, file: !17, line: 804, column: 2)
!1235 = !DILocation(line: 0, scope: !1234)
!1236 = !DILocation(line: 804, column: 7, scope: !1234)
!1237 = !DILocation(line: 804, scope: !1234)
!1238 = !DILocation(line: 804, column: 22, scope: !1239)
!1239 = distinct !DILexicalBlock(scope: !1234, file: !17, line: 804, column: 2)
!1240 = !DILocation(line: 804, column: 2, scope: !1234)
!1241 = !DILocation(line: 805, column: 3, scope: !1242)
!1242 = distinct !DILexicalBlock(scope: !1243, file: !17, line: 805, column: 3)
!1243 = distinct !DILexicalBlock(scope: !1239, file: !17, line: 804, column: 40)
!1244 = !DILocation(line: 805, scope: !1242)
!1245 = !DILocalVariable(name: "j1", scope: !1242, file: !17, line: 805, type: !39)
!1246 = !DILocation(line: 0, scope: !1242)
!1247 = !DILocation(line: 805, column: 23, scope: !1248)
!1248 = distinct !DILexicalBlock(scope: !1242, file: !17, line: 805, column: 3)
!1249 = !DILocation(line: 806, column: 4, scope: !1250)
!1250 = distinct !DILexicalBlock(scope: !1251, file: !17, line: 806, column: 4)
!1251 = distinct !DILexicalBlock(scope: !1248, file: !17, line: 805, column: 40)
!1252 = !DILocation(line: 806, scope: !1250)
!1253 = !DILocalVariable(name: "j2", scope: !1250, file: !17, line: 806, type: !39)
!1254 = !DILocation(line: 0, scope: !1250)
!1255 = !DILocation(line: 806, column: 24, scope: !1256)
!1256 = distinct !DILexicalBlock(scope: !1250, file: !17, line: 806, column: 4)
!1257 = !DILocation(line: 807, column: 5, scope: !1258)
!1258 = distinct !DILexicalBlock(scope: !1259, file: !17, line: 807, column: 5)
!1259 = distinct !DILexicalBlock(scope: !1256, file: !17, line: 806, column: 41)
!1260 = !DILocation(line: 807, scope: !1258)
!1261 = !DILocalVariable(name: "k1", scope: !1258, file: !17, line: 807, type: !39)
!1262 = !DILocation(line: 0, scope: !1258)
!1263 = !DILocation(line: 807, column: 25, scope: !1264)
!1264 = distinct !DILexicalBlock(scope: !1258, file: !17, line: 807, column: 5)
!1265 = !DILocation(line: 809, column: 31, scope: !1266)
!1266 = distinct !DILexicalBlock(scope: !1264, file: !17, line: 807, column: 42)
!1267 = !DILocation(line: 809, column: 41, scope: !1266)
!1268 = !DILocation(line: 809, column: 47, scope: !1266)
!1269 = !DILocation(line: 809, column: 57, scope: !1266)
!1270 = !DILocation(line: 809, column: 63, scope: !1266)
!1271 = !DILocation(line: 809, column: 22, scope: !1266)
!1272 = !DILocation(line: 809, column: 85, scope: !1266)
!1273 = !DILocation(line: 809, column: 95, scope: !1266)
!1274 = !DILocation(line: 809, column: 101, scope: !1266)
!1275 = !DILocation(line: 809, column: 77, scope: !1266)
!1276 = !DILocation(line: 810, column: 31, scope: !1266)
!1277 = !DILocation(line: 810, column: 41, scope: !1266)
!1278 = !DILocation(line: 810, column: 47, scope: !1266)
!1279 = !DILocation(line: 810, column: 57, scope: !1266)
!1280 = !DILocation(line: 810, column: 63, scope: !1266)
!1281 = !DILocation(line: 810, column: 22, scope: !1266)
!1282 = !DILocation(line: 809, column: 6, scope: !1266)
!1283 = !DILocation(line: 807, column: 38, scope: !1264)
!1284 = !DILocation(line: 807, column: 5, scope: !1264)
!1285 = distinct !{!1285, !1257, !1286, !163}
!1286 = !DILocation(line: 811, column: 5, scope: !1258)
!1287 = !DILocation(line: 806, column: 37, scope: !1256)
!1288 = !DILocation(line: 806, column: 4, scope: !1256)
!1289 = distinct !{!1289, !1249, !1290, !163}
!1290 = !DILocation(line: 812, column: 4, scope: !1250)
!1291 = !DILocation(line: 805, column: 36, scope: !1248)
!1292 = !DILocation(line: 805, column: 3, scope: !1248)
!1293 = distinct !{!1293, !1241, !1294, !163}
!1294 = !DILocation(line: 813, column: 3, scope: !1242)
!1295 = !DILocation(line: 804, column: 36, scope: !1239)
!1296 = !DILocation(line: 804, column: 2, scope: !1239)
!1297 = distinct !{!1297, !1240, !1298, !163}
!1298 = !DILocation(line: 814, column: 2, scope: !1234)
!1299 = !DILocalVariable(name: "F12", scope: !1204, file: !17, line: 816, type: !446)
!1300 = !DILocation(line: 816, column: 7, scope: !1204)
!1301 = !DILocalVariable(name: "i1", scope: !1302, file: !17, line: 818, type: !39)
!1302 = distinct !DILexicalBlock(scope: !1204, file: !17, line: 818, column: 2)
!1303 = !DILocation(line: 0, scope: !1302)
!1304 = !DILocation(line: 818, column: 7, scope: !1302)
!1305 = !DILocation(line: 818, scope: !1302)
!1306 = !DILocation(line: 818, column: 22, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !1302, file: !17, line: 818, column: 2)
!1308 = !DILocation(line: 818, column: 2, scope: !1302)
!1309 = !DILocation(line: 819, column: 3, scope: !1310)
!1310 = distinct !DILexicalBlock(scope: !1311, file: !17, line: 819, column: 3)
!1311 = distinct !DILexicalBlock(scope: !1307, file: !17, line: 818, column: 40)
!1312 = !DILocation(line: 830, column: 2, scope: !1313)
!1313 = distinct !DILexicalBlock(scope: !1204, file: !17, line: 830, column: 2)
!1314 = !DILocation(line: 819, scope: !1310)
!1315 = !DILocalVariable(name: "j1", scope: !1310, file: !17, line: 819, type: !39)
!1316 = !DILocation(line: 0, scope: !1310)
!1317 = !DILocation(line: 819, column: 23, scope: !1318)
!1318 = distinct !DILexicalBlock(scope: !1310, file: !17, line: 819, column: 3)
!1319 = !DILocation(line: 820, column: 4, scope: !1320)
!1320 = distinct !DILexicalBlock(scope: !1321, file: !17, line: 820, column: 4)
!1321 = distinct !DILexicalBlock(scope: !1318, file: !17, line: 819, column: 40)
!1322 = !DILocation(line: 820, scope: !1320)
!1323 = !DILocalVariable(name: "j2", scope: !1320, file: !17, line: 820, type: !39)
!1324 = !DILocation(line: 0, scope: !1320)
!1325 = !DILocation(line: 820, column: 24, scope: !1326)
!1326 = distinct !DILexicalBlock(scope: !1320, file: !17, line: 820, column: 4)
!1327 = !DILocation(line: 821, column: 5, scope: !1328)
!1328 = distinct !DILexicalBlock(scope: !1329, file: !17, line: 821, column: 5)
!1329 = distinct !DILexicalBlock(scope: !1326, file: !17, line: 820, column: 41)
!1330 = !DILocation(line: 821, scope: !1328)
!1331 = !DILocalVariable(name: "k1", scope: !1328, file: !17, line: 821, type: !39)
!1332 = !DILocation(line: 0, scope: !1328)
!1333 = !DILocation(line: 821, column: 25, scope: !1334)
!1334 = distinct !DILexicalBlock(scope: !1328, file: !17, line: 821, column: 5)
!1335 = !DILocation(line: 823, column: 31, scope: !1336)
!1336 = distinct !DILexicalBlock(scope: !1334, file: !17, line: 821, column: 42)
!1337 = !DILocation(line: 823, column: 41, scope: !1336)
!1338 = !DILocation(line: 823, column: 47, scope: !1336)
!1339 = !DILocation(line: 823, column: 57, scope: !1336)
!1340 = !DILocation(line: 823, column: 63, scope: !1336)
!1341 = !DILocation(line: 823, column: 22, scope: !1336)
!1342 = !DILocation(line: 824, column: 31, scope: !1336)
!1343 = !DILocation(line: 824, column: 41, scope: !1336)
!1344 = !DILocation(line: 824, column: 47, scope: !1336)
!1345 = !DILocation(line: 824, column: 57, scope: !1336)
!1346 = !DILocation(line: 824, column: 63, scope: !1336)
!1347 = !DILocation(line: 824, column: 22, scope: !1336)
!1348 = !DILocation(line: 824, column: 85, scope: !1336)
!1349 = !DILocation(line: 824, column: 95, scope: !1336)
!1350 = !DILocation(line: 824, column: 101, scope: !1336)
!1351 = !DILocation(line: 824, column: 77, scope: !1336)
!1352 = !DILocation(line: 823, column: 6, scope: !1336)
!1353 = !DILocation(line: 821, column: 38, scope: !1334)
!1354 = !DILocation(line: 821, column: 5, scope: !1334)
!1355 = distinct !{!1355, !1327, !1356, !163}
!1356 = !DILocation(line: 825, column: 5, scope: !1328)
!1357 = !DILocation(line: 820, column: 37, scope: !1326)
!1358 = !DILocation(line: 820, column: 4, scope: !1326)
!1359 = distinct !{!1359, !1319, !1360, !163}
!1360 = !DILocation(line: 826, column: 4, scope: !1320)
!1361 = !DILocation(line: 819, column: 36, scope: !1318)
!1362 = !DILocation(line: 819, column: 3, scope: !1318)
!1363 = distinct !{!1363, !1309, !1364, !163}
!1364 = !DILocation(line: 827, column: 3, scope: !1310)
!1365 = !DILocation(line: 818, column: 36, scope: !1307)
!1366 = !DILocation(line: 818, column: 2, scope: !1307)
!1367 = distinct !{!1367, !1308, !1368, !163}
!1368 = !DILocation(line: 828, column: 2, scope: !1302)
!1369 = !DILocation(line: 830, scope: !1313)
!1370 = !DILocalVariable(name: "i1", scope: !1313, file: !17, line: 830, type: !39)
!1371 = !DILocation(line: 0, scope: !1313)
!1372 = !DILocation(line: 830, column: 22, scope: !1373)
!1373 = distinct !DILexicalBlock(scope: !1313, file: !17, line: 830, column: 2)
!1374 = !DILocation(line: 800, column: 23, scope: !1204)
!1375 = !DILocation(line: 834, column: 2, scope: !1376)
!1376 = distinct !DILexicalBlock(scope: !1204, file: !17, line: 834, column: 2)
!1377 = !DILocation(line: 831, column: 15, scope: !1378)
!1378 = distinct !DILexicalBlock(scope: !1373, file: !17, line: 830, column: 71)
!1379 = !DILocation(line: 831, column: 24, scope: !1378)
!1380 = !DILocation(line: 831, column: 3, scope: !1378)
!1381 = !DILocation(line: 830, column: 67, scope: !1373)
!1382 = !DILocation(line: 830, column: 2, scope: !1373)
!1383 = distinct !{!1383, !1312, !1384, !163}
!1384 = !DILocation(line: 832, column: 2, scope: !1313)
!1385 = !DILocation(line: 834, scope: !1376)
!1386 = !DILocalVariable(name: "i1", scope: !1376, file: !17, line: 834, type: !39)
!1387 = !DILocation(line: 0, scope: !1376)
!1388 = !DILocation(line: 834, column: 22, scope: !1389)
!1389 = distinct !DILexicalBlock(scope: !1376, file: !17, line: 834, column: 2)
!1390 = !DILocation(line: 835, column: 15, scope: !1391)
!1391 = distinct !DILexicalBlock(scope: !1389, file: !17, line: 834, column: 71)
!1392 = !DILocation(line: 835, column: 24, scope: !1391)
!1393 = !DILocation(line: 835, column: 3, scope: !1391)
!1394 = !DILocation(line: 834, column: 67, scope: !1389)
!1395 = !DILocation(line: 834, column: 2, scope: !1389)
!1396 = distinct !{!1396, !1375, !1397, !163}
!1397 = !DILocation(line: 836, column: 2, scope: !1376)
!1398 = !DILocalVariable(name: "Am", scope: !1204, file: !17, line: 839, type: !1399)
!1399 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 15360, elements: !1400)
!1400 = !{!1401}
!1401 = !DISubrange(count: 1920)
!1402 = !DILocation(line: 839, column: 7, scope: !1204)
!1403 = !DILocalVariable(name: "Bm", scope: !1204, file: !17, line: 840, type: !1399)
!1404 = !DILocation(line: 840, column: 7, scope: !1204)
!1405 = !DILocalVariable(name: "Q1", scope: !1204, file: !17, line: 841, type: !1399)
!1406 = !DILocation(line: 841, column: 7, scope: !1204)
!1407 = !DILocalVariable(name: "Q2", scope: !1204, file: !17, line: 842, type: !1399)
!1408 = !DILocation(line: 842, column: 7, scope: !1204)
!1409 = !DILocation(line: 844, column: 24, scope: !1204)
!1410 = !DILocalVariable(name: "aptr", scope: !1204, file: !17, line: 844, type: !358)
!1411 = !DILocation(line: 845, column: 18, scope: !1204)
!1412 = !DILocalVariable(name: "q1", scope: !1204, file: !17, line: 845, type: !358)
!1413 = !DILocation(line: 846, column: 16, scope: !1204)
!1414 = !DILocalVariable(name: "q2", scope: !1204, file: !17, line: 846, type: !358)
!1415 = !DILocation(line: 849, column: 2, scope: !1204)
!1416 = !DILocation(line: 851, column: 2, scope: !1204)
!1417 = !DILocalVariable(name: "hash_in_GF16", scope: !1204, file: !17, line: 854, type: !1418)
!1418 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 640, elements: !1419)
!1419 = !{!1420}
!1420 = !DISubrange(count: 80)
!1421 = !DILocation(line: 854, column: 7, scope: !1204)
!1422 = !DILocalVariable(name: "sign_hashb", scope: !1204, file: !17, line: 856, type: !1423)
!1423 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 320, elements: !1424)
!1424 = !{!1425}
!1425 = !DISubrange(count: 40)
!1426 = !DILocation(line: 856, column: 10, scope: !1204)
!1427 = !DILocation(line: 858, column: 74, scope: !1204)
!1428 = !DILocation(line: 858, column: 2, scope: !1204)
!1429 = !DILocation(line: 862, column: 2, scope: !1204)
!1430 = !DILocalVariable(name: "gauss", scope: !1204, file: !17, line: 865, type: !1431)
!1431 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 51840, elements: !1432)
!1432 = !{!1420, !1433}
!1433 = !DISubrange(count: 81)
!1434 = !DILocation(line: 865, column: 7, scope: !1204)
!1435 = !DILocalVariable(name: "solution", scope: !1204, file: !17, line: 866, type: !1418)
!1436 = !DILocation(line: 866, column: 7, scope: !1204)
!1437 = !DILocalVariable(name: "signature_in_GF", scope: !1204, file: !17, line: 867, type: !1438)
!1438 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 4096, elements: !1439)
!1439 = !{!1440}
!1440 = !DISubrange(count: 512)
!1441 = !DILocation(line: 867, column: 7, scope: !1204)
!1442 = !DILocalVariable(name: "flag_redo", scope: !1204, file: !17, line: 868, type: !39)
!1443 = !DILocalVariable(name: "num_sign", scope: !1204, file: !17, line: 869, type: !6)
!1444 = !DILocation(line: 869, column: 10, scope: !1204)
!1445 = !DILocation(line: 871, column: 2, scope: !1204)
!1446 = !DILocation(line: 874, column: 16, scope: !1447)
!1447 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 874, column: 7)
!1448 = distinct !DILexicalBlock(scope: !1204, file: !17, line: 871, column: 5)
!1449 = !DILocation(line: 872, column: 3, scope: !1448)
!1450 = !DILocation(line: 873, column: 11, scope: !1448)
!1451 = !DILocation(line: 876, column: 4, scope: !1452)
!1452 = distinct !DILexicalBlock(scope: !1447, file: !17, line: 874, column: 24)
!1453 = !DILocation(line: 877, column: 4, scope: !1452)
!1454 = !DILocalVariable(name: "vinegar_in_byte", scope: !1448, file: !17, line: 882, type: !1455)
!1455 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 1728, elements: !1456)
!1456 = !{!1457}
!1457 = !DISubrange(count: 216)
!1458 = !DILocation(line: 882, column: 11, scope: !1448)
!1459 = !DILocalVariable(name: "v_instance", scope: !1448, file: !17, line: 883, type: !690)
!1460 = !DILocation(line: 883, column: 11, scope: !1448)
!1461 = !DILocation(line: 885, column: 3, scope: !1448)
!1462 = !DILocation(line: 886, column: 34, scope: !1448)
!1463 = !DILocation(line: 886, column: 3, scope: !1448)
!1464 = !DILocation(line: 887, column: 3, scope: !1448)
!1465 = !DILocation(line: 888, column: 3, scope: !1448)
!1466 = !DILocation(line: 889, column: 3, scope: !1448)
!1467 = !DILocation(line: 890, column: 3, scope: !1448)
!1468 = !DILocalVariable(name: "b_idx", scope: !1448, file: !17, line: 892, type: !54)
!1469 = !DILocation(line: 0, scope: !1448)
!1470 = !DILocalVariable(name: "t_idx", scope: !1448, file: !17, line: 893, type: !54)
!1471 = !DILocation(line: 895, column: 3, scope: !1448)
!1472 = !DILocation(line: 895, column: 16, scope: !1448)
!1473 = !DILocation(line: 896, column: 14, scope: !1474)
!1474 = distinct !DILexicalBlock(scope: !1475, file: !17, line: 896, column: 8)
!1475 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 895, column: 47)
!1476 = !DILocation(line: 897, column: 5, scope: !1477)
!1477 = distinct !DILexicalBlock(scope: !1474, file: !17, line: 896, column: 32)
!1478 = !DILocation(line: 899, column: 4, scope: !1477)
!1479 = !DILocation(line: 908, column: 29, scope: !1475)
!1480 = !DILocation(line: 908, column: 52, scope: !1475)
!1481 = !DILocation(line: 908, column: 4, scope: !1475)
!1482 = !DILocation(line: 908, column: 27, scope: !1475)
!1483 = !DILocation(line: 909, column: 9, scope: !1475)
!1484 = !DILocation(line: 910, column: 52, scope: !1475)
!1485 = !DILocation(line: 910, column: 4, scope: !1475)
!1486 = !DILocation(line: 910, column: 27, scope: !1475)
!1487 = !DILocation(line: 911, column: 9, scope: !1475)
!1488 = !DILocation(line: 913, column: 9, scope: !1475)
!1489 = distinct !{!1489, !1471, !1490, !163}
!1490 = !DILocation(line: 914, column: 3, scope: !1448)
!1491 = !DILocalVariable(name: "Fvv_in_GF16Matrix", scope: !1448, file: !17, line: 917, type: !1418)
!1492 = !DILocation(line: 917, column: 8, scope: !1448)
!1493 = !DILocalVariable(name: "sum_t0", scope: !1448, file: !17, line: 922, type: !1494)
!1494 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 69120, elements: !1495)
!1495 = !{!1496}
!1496 = !DISubrange(count: 8640)
!1497 = !DILocation(line: 922, column: 8, scope: !1448)
!1498 = !DILocalVariable(name: "sum_t1", scope: !1448, file: !17, line: 923, type: !1499)
!1499 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 10240, elements: !1500)
!1500 = !{!1501}
!1501 = !DISubrange(count: 1280)
!1502 = !DILocation(line: 923, column: 8, scope: !1448)
!1503 = !DILocalVariable(name: "whipped_sig", scope: !1448, file: !17, line: 928, type: !1504)
!1504 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 13824, elements: !1505)
!1505 = !{!1506}
!1506 = !DISubrange(count: 1728)
!1507 = !DILocation(line: 928, column: 8, scope: !1448)
!1508 = !DILocalVariable(name: "ab", scope: !1509, file: !17, line: 930, type: !39)
!1509 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 930, column: 3)
!1510 = !DILocation(line: 0, scope: !1509)
!1511 = !DILocation(line: 930, column: 8, scope: !1509)
!1512 = !DILocation(line: 930, scope: !1509)
!1513 = !DILocation(line: 930, column: 23, scope: !1514)
!1514 = distinct !DILexicalBlock(scope: !1509, file: !17, line: 930, column: 3)
!1515 = !DILocation(line: 930, column: 3, scope: !1509)
!1516 = !DILocation(line: 940, column: 3, scope: !1517)
!1517 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 940, column: 3)
!1518 = !DILocation(line: 931, column: 4, scope: !1519)
!1519 = distinct !DILexicalBlock(scope: !1514, file: !17, line: 931, column: 4)
!1520 = !DILocation(line: 931, scope: !1519)
!1521 = !DILocalVariable(name: "ni", scope: !1519, file: !17, line: 931, type: !39)
!1522 = !DILocation(line: 0, scope: !1519)
!1523 = !DILocation(line: 931, column: 24, scope: !1524)
!1524 = distinct !DILexicalBlock(scope: !1519, file: !17, line: 931, column: 4)
!1525 = !DILocation(line: 932, column: 5, scope: !1526)
!1526 = distinct !DILexicalBlock(scope: !1524, file: !17, line: 932, column: 5)
!1527 = !DILocation(line: 932, scope: !1526)
!1528 = !DILocalVariable(name: "i1", scope: !1526, file: !17, line: 932, type: !39)
!1529 = !DILocation(line: 0, scope: !1526)
!1530 = !DILocation(line: 932, column: 25, scope: !1531)
!1531 = distinct !DILexicalBlock(scope: !1526, file: !17, line: 932, column: 5)
!1532 = !DILocation(line: 933, column: 6, scope: !1533)
!1533 = distinct !DILexicalBlock(scope: !1531, file: !17, line: 933, column: 6)
!1534 = !DILocation(line: 933, scope: !1533)
!1535 = !DILocalVariable(name: "j1", scope: !1533, file: !17, line: 933, type: !39)
!1536 = !DILocation(line: 0, scope: !1533)
!1537 = !DILocation(line: 933, column: 26, scope: !1538)
!1538 = distinct !DILexicalBlock(scope: !1533, file: !17, line: 933, column: 6)
!1539 = !DILocation(line: 934, column: 7, scope: !1540)
!1540 = distinct !DILexicalBlock(scope: !1538, file: !17, line: 934, column: 7)
!1541 = !DILocation(line: 934, scope: !1540)
!1542 = !DILocalVariable(name: "k1", scope: !1540, file: !17, line: 934, type: !39)
!1543 = !DILocation(line: 0, scope: !1540)
!1544 = !DILocation(line: 934, column: 27, scope: !1545)
!1545 = distinct !DILexicalBlock(scope: !1540, file: !17, line: 934, column: 7)
!1546 = !DILocation(line: 935, column: 36, scope: !1545)
!1547 = !DILocation(line: 935, column: 46, scope: !1545)
!1548 = !DILocation(line: 935, column: 52, scope: !1545)
!1549 = !DILocation(line: 935, column: 68, scope: !1545)
!1550 = !DILocation(line: 935, column: 63, scope: !1545)
!1551 = !DILocation(line: 935, column: 78, scope: !1545)
!1552 = !DILocation(line: 935, column: 20, scope: !1545)
!1553 = !DILocation(line: 936, column: 35, scope: !1545)
!1554 = !DILocation(line: 936, column: 51, scope: !1545)
!1555 = !DILocation(line: 936, column: 46, scope: !1545)
!1556 = !DILocation(line: 936, column: 61, scope: !1545)
!1557 = !DILocation(line: 936, column: 27, scope: !1545)
!1558 = !DILocation(line: 937, column: 46, scope: !1545)
!1559 = !DILocation(line: 937, column: 62, scope: !1545)
!1560 = !DILocation(line: 937, column: 57, scope: !1545)
!1561 = !DILocation(line: 937, column: 72, scope: !1545)
!1562 = !DILocation(line: 937, column: 27, scope: !1545)
!1563 = !DILocation(line: 936, column: 19, scope: !1545)
!1564 = !DILocation(line: 935, column: 8, scope: !1545)
!1565 = !DILocation(line: 934, column: 40, scope: !1545)
!1566 = !DILocation(line: 934, column: 7, scope: !1545)
!1567 = distinct !{!1567, !1539, !1568, !163}
!1568 = !DILocation(line: 937, column: 78, scope: !1540)
!1569 = !DILocation(line: 933, column: 39, scope: !1538)
!1570 = !DILocation(line: 933, column: 6, scope: !1538)
!1571 = distinct !{!1571, !1532, !1572, !163}
!1572 = !DILocation(line: 937, column: 78, scope: !1533)
!1573 = !DILocation(line: 932, column: 38, scope: !1531)
!1574 = !DILocation(line: 932, column: 5, scope: !1531)
!1575 = distinct !{!1575, !1525, !1576, !163}
!1576 = !DILocation(line: 937, column: 78, scope: !1526)
!1577 = !DILocation(line: 931, column: 35, scope: !1524)
!1578 = !DILocation(line: 931, column: 4, scope: !1524)
!1579 = distinct !{!1579, !1518, !1580, !163}
!1580 = !DILocation(line: 937, column: 78, scope: !1519)
!1581 = !DILocation(line: 930, column: 34, scope: !1514)
!1582 = !DILocation(line: 930, column: 3, scope: !1514)
!1583 = distinct !{!1583, !1515, !1584, !163}
!1584 = !DILocation(line: 937, column: 78, scope: !1509)
!1585 = !DILocation(line: 940, scope: !1517)
!1586 = !DILocalVariable(name: "mi", scope: !1517, file: !17, line: 940, type: !39)
!1587 = !DILocation(line: 0, scope: !1517)
!1588 = !DILocation(line: 940, column: 23, scope: !1589)
!1589 = distinct !DILexicalBlock(scope: !1517, file: !17, line: 940, column: 3)
!1590 = !DILocation(line: 964, column: 3, scope: !1591)
!1591 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 964, column: 3)
!1592 = !DILocation(line: 941, column: 4, scope: !1593)
!1593 = distinct !DILexicalBlock(scope: !1594, file: !17, line: 941, column: 4)
!1594 = distinct !DILexicalBlock(scope: !1589, file: !17, line: 940, column: 41)
!1595 = !DILocation(line: 941, scope: !1593)
!1596 = !DILocalVariable(name: "ni", scope: !1593, file: !17, line: 941, type: !39)
!1597 = !DILocation(line: 0, scope: !1593)
!1598 = !DILocation(line: 941, column: 24, scope: !1599)
!1599 = distinct !DILexicalBlock(scope: !1593, file: !17, line: 941, column: 4)
!1600 = !DILocation(line: 949, column: 4, scope: !1601)
!1601 = distinct !DILexicalBlock(scope: !1594, file: !17, line: 949, column: 4)
!1602 = !DILocation(line: 942, column: 5, scope: !1603)
!1603 = distinct !DILexicalBlock(scope: !1599, file: !17, line: 942, column: 5)
!1604 = !DILocation(line: 942, scope: !1603)
!1605 = !DILocalVariable(name: "b1", scope: !1603, file: !17, line: 942, type: !39)
!1606 = !DILocation(line: 0, scope: !1603)
!1607 = !DILocation(line: 942, column: 25, scope: !1608)
!1608 = distinct !DILexicalBlock(scope: !1603, file: !17, line: 942, column: 5)
!1609 = !DILocation(line: 943, column: 6, scope: !1610)
!1610 = distinct !DILexicalBlock(scope: !1608, file: !17, line: 943, column: 6)
!1611 = !DILocation(line: 943, scope: !1610)
!1612 = !DILocalVariable(name: "nj", scope: !1610, file: !17, line: 943, type: !39)
!1613 = !DILocation(line: 0, scope: !1610)
!1614 = !DILocation(line: 943, column: 26, scope: !1615)
!1615 = distinct !DILexicalBlock(scope: !1610, file: !17, line: 943, column: 6)
!1616 = !DILocation(line: 944, column: 38, scope: !1615)
!1617 = !DILocation(line: 944, column: 48, scope: !1615)
!1618 = !DILocation(line: 944, column: 54, scope: !1615)
!1619 = !DILocation(line: 944, column: 64, scope: !1615)
!1620 = !DILocation(line: 944, column: 70, scope: !1615)
!1621 = !DILocation(line: 944, column: 26, scope: !1615)
!1622 = !DILocation(line: 945, column: 35, scope: !1615)
!1623 = !DILocation(line: 945, column: 45, scope: !1615)
!1624 = !DILocation(line: 945, column: 51, scope: !1615)
!1625 = !DILocation(line: 945, column: 61, scope: !1615)
!1626 = !DILocation(line: 945, column: 67, scope: !1615)
!1627 = !DILocation(line: 945, column: 26, scope: !1615)
!1628 = !DILocation(line: 946, column: 42, scope: !1615)
!1629 = !DILocation(line: 946, column: 52, scope: !1615)
!1630 = !DILocation(line: 946, column: 58, scope: !1615)
!1631 = !DILocation(line: 946, column: 26, scope: !1615)
!1632 = !DILocation(line: 944, column: 7, scope: !1615)
!1633 = !DILocation(line: 943, column: 37, scope: !1615)
!1634 = !DILocation(line: 943, column: 6, scope: !1615)
!1635 = distinct !{!1635, !1609, !1636, !163}
!1636 = !DILocation(line: 946, column: 96, scope: !1610)
!1637 = !DILocation(line: 942, column: 36, scope: !1608)
!1638 = !DILocation(line: 942, column: 5, scope: !1608)
!1639 = distinct !{!1639, !1602, !1640, !163}
!1640 = !DILocation(line: 946, column: 96, scope: !1603)
!1641 = !DILocation(line: 941, column: 35, scope: !1599)
!1642 = !DILocation(line: 941, column: 4, scope: !1599)
!1643 = distinct !{!1643, !1592, !1644, !163}
!1644 = !DILocation(line: 946, column: 96, scope: !1593)
!1645 = !DILocation(line: 949, scope: !1601)
!1646 = !DILocalVariable(name: "a1", scope: !1601, file: !17, line: 949, type: !39)
!1647 = !DILocation(line: 0, scope: !1601)
!1648 = !DILocation(line: 949, column: 24, scope: !1649)
!1649 = distinct !DILexicalBlock(scope: !1601, file: !17, line: 949, column: 4)
!1650 = !DILocation(line: 950, column: 5, scope: !1651)
!1651 = distinct !DILexicalBlock(scope: !1649, file: !17, line: 950, column: 5)
!1652 = !DILocation(line: 950, scope: !1651)
!1653 = !DILocalVariable(name: "b1", scope: !1651, file: !17, line: 950, type: !39)
!1654 = !DILocation(line: 0, scope: !1651)
!1655 = !DILocation(line: 950, column: 25, scope: !1656)
!1656 = distinct !DILexicalBlock(scope: !1651, file: !17, line: 950, column: 5)
!1657 = !DILocation(line: 951, column: 6, scope: !1658)
!1658 = distinct !DILexicalBlock(scope: !1656, file: !17, line: 951, column: 6)
!1659 = !DILocation(line: 951, scope: !1658)
!1660 = !DILocalVariable(name: "ni", scope: !1658, file: !17, line: 951, type: !39)
!1661 = !DILocation(line: 0, scope: !1658)
!1662 = !DILocation(line: 951, column: 26, scope: !1663)
!1663 = distinct !DILexicalBlock(scope: !1658, file: !17, line: 951, column: 6)
!1664 = !DILocation(line: 952, column: 7, scope: !1665)
!1665 = distinct !DILexicalBlock(scope: !1663, file: !17, line: 952, column: 7)
!1666 = !DILocation(line: 952, scope: !1665)
!1667 = !DILocalVariable(name: "i1", scope: !1665, file: !17, line: 952, type: !39)
!1668 = !DILocation(line: 0, scope: !1665)
!1669 = !DILocation(line: 952, column: 27, scope: !1670)
!1670 = distinct !DILexicalBlock(scope: !1665, file: !17, line: 952, column: 7)
!1671 = !DILocation(line: 953, column: 8, scope: !1672)
!1672 = distinct !DILexicalBlock(scope: !1670, file: !17, line: 953, column: 8)
!1673 = !DILocation(line: 953, scope: !1672)
!1674 = !DILocalVariable(name: "j1", scope: !1672, file: !17, line: 953, type: !39)
!1675 = !DILocation(line: 0, scope: !1672)
!1676 = !DILocation(line: 953, column: 28, scope: !1677)
!1677 = distinct !DILexicalBlock(scope: !1672, file: !17, line: 953, column: 8)
!1678 = !DILocation(line: 954, column: 9, scope: !1679)
!1679 = distinct !DILexicalBlock(scope: !1677, file: !17, line: 954, column: 9)
!1680 = !DILocation(line: 954, scope: !1679)
!1681 = !DILocalVariable(name: "k1", scope: !1679, file: !17, line: 954, type: !39)
!1682 = !DILocation(line: 0, scope: !1679)
!1683 = !DILocation(line: 954, column: 29, scope: !1684)
!1684 = distinct !DILexicalBlock(scope: !1679, file: !17, line: 954, column: 9)
!1685 = !DILocation(line: 956, column: 26, scope: !1684)
!1686 = !DILocation(line: 956, column: 42, scope: !1684)
!1687 = !DILocation(line: 956, column: 37, scope: !1684)
!1688 = !DILocation(line: 956, column: 52, scope: !1684)
!1689 = !DILocation(line: 956, column: 58, scope: !1684)
!1690 = !DILocation(line: 956, column: 74, scope: !1684)
!1691 = !DILocation(line: 956, column: 69, scope: !1684)
!1692 = !DILocation(line: 956, column: 84, scope: !1684)
!1693 = !DILocation(line: 956, column: 15, scope: !1684)
!1694 = !DILocation(line: 957, column: 38, scope: !1684)
!1695 = !DILocation(line: 957, column: 48, scope: !1684)
!1696 = !DILocation(line: 957, column: 54, scope: !1684)
!1697 = !DILocation(line: 957, column: 70, scope: !1684)
!1698 = !DILocation(line: 957, column: 65, scope: !1684)
!1699 = !DILocation(line: 957, column: 80, scope: !1684)
!1700 = !DILocation(line: 957, column: 22, scope: !1684)
!1701 = !DILocation(line: 958, column: 34, scope: !1684)
!1702 = !DILocation(line: 958, column: 44, scope: !1684)
!1703 = !DILocation(line: 958, column: 50, scope: !1684)
!1704 = !DILocation(line: 958, column: 60, scope: !1684)
!1705 = !DILocation(line: 958, column: 66, scope: !1684)
!1706 = !DILocation(line: 958, column: 82, scope: !1684)
!1707 = !DILocation(line: 958, column: 77, scope: !1684)
!1708 = !DILocation(line: 958, column: 92, scope: !1684)
!1709 = !DILocation(line: 958, column: 22, scope: !1684)
!1710 = !DILocation(line: 957, column: 14, scope: !1684)
!1711 = !DILocation(line: 955, column: 10, scope: !1684)
!1712 = !DILocation(line: 954, column: 42, scope: !1684)
!1713 = !DILocation(line: 954, column: 9, scope: !1684)
!1714 = distinct !{!1714, !1678, !1715, !163}
!1715 = !DILocation(line: 958, column: 98, scope: !1679)
!1716 = !DILocation(line: 953, column: 41, scope: !1677)
!1717 = !DILocation(line: 953, column: 8, scope: !1677)
!1718 = distinct !{!1718, !1671, !1719, !163}
!1719 = !DILocation(line: 958, column: 98, scope: !1672)
!1720 = !DILocation(line: 952, column: 40, scope: !1670)
!1721 = !DILocation(line: 952, column: 7, scope: !1670)
!1722 = distinct !{!1722, !1664, !1723, !163}
!1723 = !DILocation(line: 958, column: 98, scope: !1665)
!1724 = !DILocation(line: 951, column: 37, scope: !1663)
!1725 = !DILocation(line: 951, column: 6, scope: !1663)
!1726 = distinct !{!1726, !1657, !1727, !163}
!1727 = !DILocation(line: 958, column: 98, scope: !1658)
!1728 = !DILocation(line: 950, column: 36, scope: !1656)
!1729 = !DILocation(line: 950, column: 5, scope: !1656)
!1730 = distinct !{!1730, !1650, !1731, !163}
!1731 = !DILocation(line: 958, column: 98, scope: !1651)
!1732 = !DILocation(line: 949, column: 35, scope: !1649)
!1733 = !DILocation(line: 949, column: 4, scope: !1649)
!1734 = distinct !{!1734, !1600, !1735, !163}
!1735 = !DILocation(line: 958, column: 98, scope: !1601)
!1736 = !DILocation(line: 940, column: 35, scope: !1589)
!1737 = !DILocation(line: 940, column: 3, scope: !1589)
!1738 = distinct !{!1738, !1516, !1739, !163}
!1739 = !DILocation(line: 959, column: 3, scope: !1517)
!1740 = !DILocation(line: 964, scope: !1591)
!1741 = !DILocalVariable(name: "mi", scope: !1591, file: !17, line: 964, type: !39)
!1742 = !DILocation(line: 0, scope: !1591)
!1743 = !DILocation(line: 964, column: 23, scope: !1744)
!1744 = distinct !DILexicalBlock(scope: !1591, file: !17, line: 964, column: 3)
!1745 = !DILocation(line: 996, column: 3, scope: !1746)
!1746 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 996, column: 3)
!1747 = !DILocation(line: 965, column: 4, scope: !1748)
!1748 = distinct !DILexicalBlock(scope: !1744, file: !17, line: 965, column: 4)
!1749 = !DILocation(line: 965, scope: !1748)
!1750 = !DILocalVariable(name: "alpha", scope: !1748, file: !17, line: 965, type: !39)
!1751 = !DILocation(line: 0, scope: !1748)
!1752 = !DILocation(line: 965, column: 30, scope: !1753)
!1753 = distinct !DILexicalBlock(scope: !1748, file: !17, line: 965, column: 4)
!1754 = !DILocation(line: 966, column: 20, scope: !1755)
!1755 = distinct !DILexicalBlock(scope: !1753, file: !17, line: 965, column: 54)
!1756 = !DILocalVariable(name: "mi_prime", scope: !1755, file: !17, line: 966, type: !39)
!1757 = !DILocation(line: 0, scope: !1755)
!1758 = !DILocalVariable(name: "gf16m_temp1", scope: !1755, file: !17, line: 968, type: !18)
!1759 = !DILocation(line: 968, column: 10, scope: !1755)
!1760 = !DILocalVariable(name: "gf16m_temp2", scope: !1755, file: !17, line: 969, type: !18)
!1761 = !DILocation(line: 969, column: 10, scope: !1755)
!1762 = !DILocalVariable(name: "a1", scope: !1763, file: !17, line: 972, type: !39)
!1763 = distinct !DILexicalBlock(scope: !1755, file: !17, line: 972, column: 5)
!1764 = !DILocation(line: 0, scope: !1763)
!1765 = !DILocation(line: 972, column: 10, scope: !1763)
!1766 = !DILocation(line: 972, scope: !1763)
!1767 = !DILocation(line: 972, column: 25, scope: !1768)
!1768 = distinct !DILexicalBlock(scope: !1763, file: !17, line: 972, column: 5)
!1769 = !DILocation(line: 972, column: 5, scope: !1763)
!1770 = !DILocalVariable(name: "sumb", scope: !1771, file: !17, line: 973, type: !18)
!1771 = distinct !DILexicalBlock(scope: !1768, file: !17, line: 972, column: 42)
!1772 = !DILocation(line: 973, column: 11, scope: !1771)
!1773 = !DILocalVariable(name: "b1", scope: !1774, file: !17, line: 975, type: !39)
!1774 = distinct !DILexicalBlock(scope: !1771, file: !17, line: 975, column: 6)
!1775 = !DILocation(line: 0, scope: !1774)
!1776 = !DILocation(line: 975, column: 11, scope: !1774)
!1777 = !DILocation(line: 975, scope: !1774)
!1778 = !DILocation(line: 975, column: 26, scope: !1779)
!1779 = distinct !DILexicalBlock(scope: !1774, file: !17, line: 975, column: 6)
!1780 = !DILocation(line: 975, column: 6, scope: !1774)
!1781 = !DILocation(line: 983, column: 6, scope: !1782)
!1782 = distinct !DILexicalBlock(scope: !1771, file: !17, line: 983, column: 6)
!1783 = !DILocation(line: 976, column: 7, scope: !1784)
!1784 = distinct !DILexicalBlock(scope: !1779, file: !17, line: 976, column: 7)
!1785 = !DILocation(line: 976, scope: !1784)
!1786 = !DILocalVariable(name: "i1", scope: !1784, file: !17, line: 976, type: !39)
!1787 = !DILocation(line: 0, scope: !1784)
!1788 = !DILocation(line: 976, column: 27, scope: !1789)
!1789 = distinct !DILexicalBlock(scope: !1784, file: !17, line: 976, column: 7)
!1790 = !DILocation(line: 977, column: 8, scope: !1791)
!1791 = distinct !DILexicalBlock(scope: !1789, file: !17, line: 977, column: 8)
!1792 = !DILocation(line: 977, scope: !1791)
!1793 = !DILocalVariable(name: "j1", scope: !1791, file: !17, line: 977, type: !39)
!1794 = !DILocation(line: 0, scope: !1791)
!1795 = !DILocation(line: 977, column: 28, scope: !1796)
!1796 = distinct !DILexicalBlock(scope: !1791, file: !17, line: 977, column: 8)
!1797 = !DILocation(line: 979, column: 22, scope: !1796)
!1798 = !DILocation(line: 979, column: 32, scope: !1796)
!1799 = !DILocation(line: 979, column: 14, scope: !1796)
!1800 = !DILocation(line: 980, column: 38, scope: !1796)
!1801 = !DILocation(line: 980, column: 54, scope: !1796)
!1802 = !DILocation(line: 980, column: 49, scope: !1796)
!1803 = !DILocation(line: 980, column: 64, scope: !1796)
!1804 = !DILocation(line: 980, column: 70, scope: !1796)
!1805 = !DILocation(line: 980, column: 86, scope: !1796)
!1806 = !DILocation(line: 980, column: 81, scope: !1796)
!1807 = !DILocation(line: 980, column: 96, scope: !1796)
!1808 = !DILocation(line: 980, column: 21, scope: !1796)
!1809 = !DILocation(line: 981, column: 28, scope: !1796)
!1810 = !DILocation(line: 981, column: 42, scope: !1796)
!1811 = !DILocation(line: 981, column: 51, scope: !1796)
!1812 = !DILocation(line: 981, column: 61, scope: !1796)
!1813 = !DILocation(line: 981, column: 21, scope: !1796)
!1814 = !DILocation(line: 980, column: 13, scope: !1796)
!1815 = !DILocation(line: 978, column: 9, scope: !1796)
!1816 = !DILocation(line: 977, column: 41, scope: !1796)
!1817 = !DILocation(line: 977, column: 8, scope: !1796)
!1818 = distinct !{!1818, !1790, !1819, !163}
!1819 = !DILocation(line: 981, column: 67, scope: !1791)
!1820 = !DILocation(line: 976, column: 40, scope: !1789)
!1821 = !DILocation(line: 976, column: 7, scope: !1789)
!1822 = distinct !{!1822, !1783, !1823, !163}
!1823 = !DILocation(line: 981, column: 67, scope: !1784)
!1824 = !DILocation(line: 975, column: 37, scope: !1779)
!1825 = !DILocation(line: 975, column: 6, scope: !1779)
!1826 = distinct !{!1826, !1780, !1827, !163}
!1827 = !DILocation(line: 981, column: 67, scope: !1774)
!1828 = !DILocation(line: 983, scope: !1782)
!1829 = !DILocalVariable(name: "i1", scope: !1782, file: !17, line: 983, type: !39)
!1830 = !DILocation(line: 0, scope: !1782)
!1831 = !DILocation(line: 983, column: 26, scope: !1832)
!1832 = distinct !DILexicalBlock(scope: !1782, file: !17, line: 983, column: 6)
!1833 = !DILocation(line: 984, column: 7, scope: !1834)
!1834 = distinct !DILexicalBlock(scope: !1832, file: !17, line: 984, column: 7)
!1835 = !DILocation(line: 984, scope: !1834)
!1836 = !DILocalVariable(name: "j1", scope: !1834, file: !17, line: 984, type: !39)
!1837 = !DILocation(line: 0, scope: !1834)
!1838 = !DILocation(line: 984, column: 27, scope: !1839)
!1839 = distinct !DILexicalBlock(scope: !1834, file: !17, line: 984, column: 7)
!1840 = !DILocation(line: 985, column: 35, scope: !1839)
!1841 = !DILocation(line: 985, column: 45, scope: !1839)
!1842 = !DILocation(line: 985, column: 20, scope: !1839)
!1843 = !DILocation(line: 986, column: 35, scope: !1839)
!1844 = !DILocation(line: 986, column: 45, scope: !1839)
!1845 = !DILocation(line: 986, column: 27, scope: !1839)
!1846 = !DILocation(line: 986, column: 59, scope: !1839)
!1847 = !DILocation(line: 986, column: 73, scope: !1839)
!1848 = !DILocation(line: 986, column: 82, scope: !1839)
!1849 = !DILocation(line: 986, column: 92, scope: !1839)
!1850 = !DILocation(line: 986, column: 52, scope: !1839)
!1851 = !DILocation(line: 986, column: 19, scope: !1839)
!1852 = !DILocation(line: 985, column: 8, scope: !1839)
!1853 = !DILocation(line: 984, column: 40, scope: !1839)
!1854 = !DILocation(line: 984, column: 7, scope: !1839)
!1855 = distinct !{!1855, !1833, !1856, !163}
!1856 = !DILocation(line: 986, column: 98, scope: !1834)
!1857 = !DILocation(line: 983, column: 39, scope: !1832)
!1858 = !DILocation(line: 983, column: 6, scope: !1832)
!1859 = distinct !{!1859, !1781, !1860, !163}
!1860 = !DILocation(line: 986, column: 98, scope: !1782)
!1861 = !DILocation(line: 972, column: 36, scope: !1768)
!1862 = !DILocation(line: 972, column: 5, scope: !1768)
!1863 = distinct !{!1863, !1769, !1864, !163}
!1864 = !DILocation(line: 987, column: 5, scope: !1763)
!1865 = !DILocation(line: 990, column: 57, scope: !1755)
!1866 = !DILocation(line: 990, column: 71, scope: !1755)
!1867 = !DILocation(line: 990, column: 80, scope: !1755)
!1868 = !DILocation(line: 990, column: 50, scope: !1755)
!1869 = !DILocation(line: 990, column: 5, scope: !1755)
!1870 = !DILocation(line: 992, column: 45, scope: !1755)
!1871 = !DILocation(line: 992, column: 24, scope: !1755)
!1872 = !DILocation(line: 992, column: 66, scope: !1755)
!1873 = !DILocation(line: 992, column: 80, scope: !1755)
!1874 = !DILocation(line: 992, column: 89, scope: !1755)
!1875 = !DILocation(line: 992, column: 59, scope: !1755)
!1876 = !DILocation(line: 992, column: 5, scope: !1755)
!1877 = !DILocation(line: 965, column: 45, scope: !1753)
!1878 = !DILocation(line: 965, column: 4, scope: !1753)
!1879 = distinct !{!1879, !1747, !1880, !163}
!1880 = !DILocation(line: 994, column: 4, scope: !1748)
!1881 = !DILocation(line: 964, column: 34, scope: !1744)
!1882 = !DILocation(line: 964, column: 3, scope: !1744)
!1883 = distinct !{!1883, !1590, !1884, !163}
!1884 = !DILocation(line: 994, column: 4, scope: !1591)
!1885 = !DILocation(line: 996, scope: !1746)
!1886 = !DILocalVariable(name: "mi", scope: !1746, file: !17, line: 996, type: !39)
!1887 = !DILocation(line: 0, scope: !1746)
!1888 = !DILocation(line: 996, column: 23, scope: !1889)
!1889 = distinct !DILexicalBlock(scope: !1746, file: !17, line: 996, column: 3)
!1890 = !DILocation(line: 998, column: 4, scope: !1891)
!1891 = distinct !DILexicalBlock(scope: !1889, file: !17, line: 998, column: 4)
!1892 = !DILocation(line: 998, scope: !1891)
!1893 = !DILocalVariable(name: "i1", scope: !1891, file: !17, line: 998, type: !39)
!1894 = !DILocation(line: 0, scope: !1891)
!1895 = !DILocation(line: 998, column: 24, scope: !1896)
!1896 = distinct !DILexicalBlock(scope: !1891, file: !17, line: 998, column: 4)
!1897 = !DILocation(line: 1000, column: 32, scope: !1898)
!1898 = distinct !DILexicalBlock(scope: !1896, file: !17, line: 998, column: 42)
!1899 = !DILocation(line: 1000, column: 43, scope: !1898)
!1900 = !DILocation(line: 1000, column: 16, scope: !1898)
!1901 = !DILocation(line: 1000, column: 71, scope: !1898)
!1902 = !DILocation(line: 1000, column: 82, scope: !1898)
!1903 = !DILocation(line: 1000, column: 50, scope: !1898)
!1904 = !DILocation(line: 1000, column: 9, scope: !1898)
!1905 = !DILocation(line: 999, column: 14, scope: !1898)
!1906 = !DILocation(line: 999, column: 25, scope: !1898)
!1907 = !DILocation(line: 999, column: 5, scope: !1898)
!1908 = !DILocation(line: 999, column: 51, scope: !1898)
!1909 = !DILocation(line: 998, column: 38, scope: !1896)
!1910 = !DILocation(line: 998, column: 4, scope: !1896)
!1911 = distinct !{!1911, !1890, !1912, !163}
!1912 = !DILocation(line: 1001, column: 4, scope: !1891)
!1913 = !DILocation(line: 996, column: 34, scope: !1889)
!1914 = !DILocation(line: 996, column: 3, scope: !1889)
!1915 = distinct !{!1915, !1745, !1916, !163}
!1916 = !DILocation(line: 1001, column: 4, scope: !1746)
!1917 = !DILocalVariable(name: "whipped_F21", scope: !1448, file: !17, line: 1004, type: !1918)
!1918 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 12800, elements: !1919)
!1919 = !{!1920}
!1920 = !DISubrange(count: 1600)
!1921 = !DILocation(line: 1004, column: 8, scope: !1448)
!1922 = !DILocalVariable(name: "whipped_F12", scope: !1448, file: !17, line: 1005, type: !1918)
!1923 = !DILocation(line: 1005, column: 8, scope: !1448)
!1924 = !DILocalVariable(name: "mi", scope: !1925, file: !17, line: 1011, type: !39)
!1925 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 1011, column: 3)
!1926 = !DILocation(line: 0, scope: !1925)
!1927 = !DILocation(line: 1011, column: 8, scope: !1925)
!1928 = !DILocation(line: 1011, scope: !1925)
!1929 = !DILocation(line: 1011, column: 23, scope: !1930)
!1930 = distinct !DILexicalBlock(scope: !1925, file: !17, line: 1011, column: 3)
!1931 = !DILocation(line: 1011, column: 3, scope: !1925)
!1932 = !DILocation(line: 1034, column: 3, scope: !1933)
!1933 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 1034, column: 3)
!1934 = !DILocation(line: 1012, column: 4, scope: !1935)
!1935 = distinct !DILexicalBlock(scope: !1936, file: !17, line: 1012, column: 4)
!1936 = distinct !DILexicalBlock(scope: !1930, file: !17, line: 1011, column: 41)
!1937 = !DILocation(line: 1012, scope: !1935)
!1938 = !DILocalVariable(name: "idx", scope: !1935, file: !17, line: 1012, type: !39)
!1939 = !DILocation(line: 0, scope: !1935)
!1940 = !DILocation(line: 1012, column: 26, scope: !1941)
!1941 = distinct !DILexicalBlock(scope: !1935, file: !17, line: 1012, column: 4)
!1942 = !DILocation(line: 1020, column: 4, scope: !1943)
!1943 = distinct !DILexicalBlock(scope: !1936, file: !17, line: 1020, column: 4)
!1944 = !DILocation(line: 1013, column: 5, scope: !1945)
!1945 = distinct !DILexicalBlock(scope: !1941, file: !17, line: 1013, column: 5)
!1946 = !DILocation(line: 1013, scope: !1945)
!1947 = !DILocalVariable(name: "b1", scope: !1945, file: !17, line: 1013, type: !39)
!1948 = !DILocation(line: 0, scope: !1945)
!1949 = !DILocation(line: 1013, column: 25, scope: !1950)
!1950 = distinct !DILexicalBlock(scope: !1945, file: !17, line: 1013, column: 5)
!1951 = !DILocation(line: 1014, column: 6, scope: !1952)
!1952 = distinct !DILexicalBlock(scope: !1950, file: !17, line: 1014, column: 6)
!1953 = !DILocation(line: 1014, scope: !1952)
!1954 = !DILocalVariable(name: "nj", scope: !1952, file: !17, line: 1014, type: !39)
!1955 = !DILocation(line: 0, scope: !1952)
!1956 = !DILocation(line: 1014, column: 26, scope: !1957)
!1957 = distinct !DILexicalBlock(scope: !1952, file: !17, line: 1014, column: 6)
!1958 = !DILocation(line: 1015, column: 43, scope: !1957)
!1959 = !DILocation(line: 1015, column: 53, scope: !1957)
!1960 = !DILocation(line: 1015, column: 59, scope: !1957)
!1961 = !DILocation(line: 1015, column: 69, scope: !1957)
!1962 = !DILocation(line: 1015, column: 76, scope: !1957)
!1963 = !DILocation(line: 1015, column: 26, scope: !1957)
!1964 = !DILocation(line: 1016, column: 35, scope: !1957)
!1965 = !DILocation(line: 1016, column: 45, scope: !1957)
!1966 = !DILocation(line: 1016, column: 52, scope: !1957)
!1967 = !DILocation(line: 1016, column: 62, scope: !1957)
!1968 = !DILocation(line: 1016, column: 68, scope: !1957)
!1969 = !DILocation(line: 1016, column: 26, scope: !1957)
!1970 = !DILocation(line: 1017, column: 42, scope: !1957)
!1971 = !DILocation(line: 1017, column: 52, scope: !1957)
!1972 = !DILocation(line: 1017, column: 58, scope: !1957)
!1973 = !DILocation(line: 1017, column: 26, scope: !1957)
!1974 = !DILocation(line: 1015, column: 7, scope: !1957)
!1975 = !DILocation(line: 1014, column: 37, scope: !1957)
!1976 = !DILocation(line: 1014, column: 6, scope: !1957)
!1977 = distinct !{!1977, !1951, !1978, !163}
!1978 = !DILocation(line: 1017, column: 96, scope: !1952)
!1979 = !DILocation(line: 1013, column: 36, scope: !1950)
!1980 = !DILocation(line: 1013, column: 5, scope: !1950)
!1981 = distinct !{!1981, !1944, !1982, !163}
!1982 = !DILocation(line: 1017, column: 96, scope: !1945)
!1983 = !DILocation(line: 1012, column: 40, scope: !1941)
!1984 = !DILocation(line: 1012, column: 4, scope: !1941)
!1985 = distinct !{!1985, !1934, !1986, !163}
!1986 = !DILocation(line: 1017, column: 96, scope: !1935)
!1987 = !DILocation(line: 1020, scope: !1943)
!1988 = !DILocalVariable(name: "idx", scope: !1943, file: !17, line: 1020, type: !39)
!1989 = !DILocation(line: 0, scope: !1943)
!1990 = !DILocation(line: 1020, column: 26, scope: !1991)
!1991 = distinct !DILexicalBlock(scope: !1943, file: !17, line: 1020, column: 4)
!1992 = !DILocation(line: 1021, column: 5, scope: !1993)
!1993 = distinct !DILexicalBlock(scope: !1991, file: !17, line: 1021, column: 5)
!1994 = !DILocation(line: 1021, scope: !1993)
!1995 = !DILocalVariable(name: "b1", scope: !1993, file: !17, line: 1021, type: !39)
!1996 = !DILocation(line: 0, scope: !1993)
!1997 = !DILocation(line: 1021, column: 25, scope: !1998)
!1998 = distinct !DILexicalBlock(scope: !1993, file: !17, line: 1021, column: 5)
!1999 = !DILocation(line: 1022, column: 6, scope: !2000)
!2000 = distinct !DILexicalBlock(scope: !1998, file: !17, line: 1022, column: 6)
!2001 = !DILocation(line: 1022, scope: !2000)
!2002 = !DILocalVariable(name: "nj", scope: !2000, file: !17, line: 1022, type: !39)
!2003 = !DILocation(line: 0, scope: !2000)
!2004 = !DILocation(line: 1022, column: 26, scope: !2005)
!2005 = distinct !DILexicalBlock(scope: !2000, file: !17, line: 1022, column: 6)
!2006 = !DILocation(line: 1023, column: 7, scope: !2007)
!2007 = distinct !DILexicalBlock(scope: !2005, file: !17, line: 1023, column: 7)
!2008 = !DILocation(line: 1023, scope: !2007)
!2009 = !DILocalVariable(name: "i1", scope: !2007, file: !17, line: 1023, type: !39)
!2010 = !DILocation(line: 0, scope: !2007)
!2011 = !DILocation(line: 1023, column: 27, scope: !2012)
!2012 = distinct !DILexicalBlock(scope: !2007, file: !17, line: 1023, column: 7)
!2013 = !DILocation(line: 1024, column: 8, scope: !2014)
!2014 = distinct !DILexicalBlock(scope: !2012, file: !17, line: 1024, column: 8)
!2015 = !DILocation(line: 1024, scope: !2014)
!2016 = !DILocalVariable(name: "j1", scope: !2014, file: !17, line: 1024, type: !39)
!2017 = !DILocation(line: 0, scope: !2014)
!2018 = !DILocation(line: 1024, column: 28, scope: !2019)
!2019 = distinct !DILexicalBlock(scope: !2014, file: !17, line: 1024, column: 8)
!2020 = !DILocation(line: 1025, column: 9, scope: !2021)
!2021 = distinct !DILexicalBlock(scope: !2019, file: !17, line: 1025, column: 9)
!2022 = !DILocation(line: 1025, scope: !2021)
!2023 = !DILocalVariable(name: "k1", scope: !2021, file: !17, line: 1025, type: !39)
!2024 = !DILocation(line: 0, scope: !2021)
!2025 = !DILocation(line: 1025, column: 29, scope: !2026)
!2026 = distinct !DILexicalBlock(scope: !2021, file: !17, line: 1025, column: 9)
!2027 = !DILocation(line: 1027, column: 32, scope: !2026)
!2028 = !DILocation(line: 1027, column: 42, scope: !2026)
!2029 = !DILocation(line: 1027, column: 48, scope: !2026)
!2030 = !DILocation(line: 1027, column: 58, scope: !2026)
!2031 = !DILocation(line: 1027, column: 65, scope: !2026)
!2032 = !DILocation(line: 1027, column: 81, scope: !2026)
!2033 = !DILocation(line: 1027, column: 76, scope: !2026)
!2034 = !DILocation(line: 1027, column: 91, scope: !2026)
!2035 = !DILocation(line: 1027, column: 15, scope: !2026)
!2036 = !DILocation(line: 1028, column: 31, scope: !2026)
!2037 = !DILocation(line: 1028, column: 41, scope: !2026)
!2038 = !DILocation(line: 1028, column: 47, scope: !2026)
!2039 = !DILocation(line: 1028, column: 57, scope: !2026)
!2040 = !DILocation(line: 1028, column: 64, scope: !2026)
!2041 = !DILocation(line: 1028, column: 80, scope: !2026)
!2042 = !DILocation(line: 1028, column: 75, scope: !2026)
!2043 = !DILocation(line: 1028, column: 90, scope: !2026)
!2044 = !DILocation(line: 1028, column: 22, scope: !2026)
!2045 = !DILocation(line: 1029, column: 38, scope: !2026)
!2046 = !DILocation(line: 1029, column: 48, scope: !2026)
!2047 = !DILocation(line: 1029, column: 54, scope: !2026)
!2048 = !DILocation(line: 1029, column: 70, scope: !2026)
!2049 = !DILocation(line: 1029, column: 65, scope: !2026)
!2050 = !DILocation(line: 1029, column: 80, scope: !2026)
!2051 = !DILocation(line: 1029, column: 22, scope: !2026)
!2052 = !DILocation(line: 1028, column: 14, scope: !2026)
!2053 = !DILocation(line: 1026, column: 10, scope: !2026)
!2054 = !DILocation(line: 1025, column: 42, scope: !2026)
!2055 = !DILocation(line: 1025, column: 9, scope: !2026)
!2056 = distinct !{!2056, !2020, !2057, !163}
!2057 = !DILocation(line: 1029, column: 86, scope: !2021)
!2058 = !DILocation(line: 1024, column: 41, scope: !2019)
!2059 = !DILocation(line: 1024, column: 8, scope: !2019)
!2060 = distinct !{!2060, !2013, !2061, !163}
!2061 = !DILocation(line: 1029, column: 86, scope: !2014)
!2062 = !DILocation(line: 1023, column: 40, scope: !2012)
!2063 = !DILocation(line: 1023, column: 7, scope: !2012)
!2064 = distinct !{!2064, !2006, !2065, !163}
!2065 = !DILocation(line: 1029, column: 86, scope: !2007)
!2066 = !DILocation(line: 1022, column: 37, scope: !2005)
!2067 = !DILocation(line: 1022, column: 6, scope: !2005)
!2068 = distinct !{!2068, !1999, !2069, !163}
!2069 = !DILocation(line: 1029, column: 86, scope: !2000)
!2070 = !DILocation(line: 1021, column: 36, scope: !1998)
!2071 = !DILocation(line: 1021, column: 5, scope: !1998)
!2072 = distinct !{!2072, !1992, !2073, !163}
!2073 = !DILocation(line: 1029, column: 86, scope: !1993)
!2074 = !DILocation(line: 1020, column: 40, scope: !1991)
!2075 = !DILocation(line: 1020, column: 4, scope: !1991)
!2076 = distinct !{!2076, !1942, !2077, !163}
!2077 = !DILocation(line: 1029, column: 86, scope: !1943)
!2078 = !DILocation(line: 1011, column: 37, scope: !1930)
!2079 = !DILocation(line: 1011, column: 3, scope: !1930)
!2080 = distinct !{!2080, !1931, !2081, !163}
!2081 = !DILocation(line: 1030, column: 3, scope: !1925)
!2082 = !DILocation(line: 1034, scope: !1933)
!2083 = !DILocalVariable(name: "mi", scope: !1933, file: !17, line: 1034, type: !39)
!2084 = !DILocation(line: 0, scope: !1933)
!2085 = !DILocation(line: 1034, column: 23, scope: !2086)
!2086 = distinct !DILexicalBlock(scope: !1933, file: !17, line: 1034, column: 3)
!2087 = !DILocation(line: 1066, column: 3, scope: !2088)
!2088 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 1066, column: 3)
!2089 = !DILocation(line: 1035, column: 4, scope: !2090)
!2090 = distinct !DILexicalBlock(scope: !2091, file: !17, line: 1035, column: 4)
!2091 = distinct !DILexicalBlock(scope: !2086, file: !17, line: 1034, column: 40)
!2092 = !DILocation(line: 1035, scope: !2090)
!2093 = !DILocalVariable(name: "idx", scope: !2090, file: !17, line: 1035, type: !39)
!2094 = !DILocation(line: 0, scope: !2090)
!2095 = !DILocation(line: 1035, column: 26, scope: !2096)
!2096 = distinct !DILexicalBlock(scope: !2090, file: !17, line: 1035, column: 4)
!2097 = !DILocation(line: 1036, column: 5, scope: !2098)
!2098 = distinct !DILexicalBlock(scope: !2099, file: !17, line: 1036, column: 5)
!2099 = distinct !DILexicalBlock(scope: !2096, file: !17, line: 1035, column: 44)
!2100 = !DILocation(line: 1036, scope: !2098)
!2101 = !DILocalVariable(name: "alpha", scope: !2098, file: !17, line: 1036, type: !39)
!2102 = !DILocation(line: 0, scope: !2098)
!2103 = !DILocation(line: 1036, column: 31, scope: !2104)
!2104 = distinct !DILexicalBlock(scope: !2098, file: !17, line: 1036, column: 5)
!2105 = !DILocalVariable(name: "gf16m_temp0", scope: !2106, file: !17, line: 1037, type: !18)
!2106 = distinct !DILexicalBlock(scope: !2104, file: !17, line: 1036, column: 55)
!2107 = !DILocation(line: 1037, column: 11, scope: !2106)
!2108 = !DILocalVariable(name: "gf16m_temp1", scope: !2106, file: !17, line: 1038, type: !18)
!2109 = !DILocation(line: 1038, column: 11, scope: !2106)
!2110 = !DILocalVariable(name: "X_tmp", scope: !2106, file: !17, line: 1040, type: !18)
!2111 = !DILocation(line: 1040, column: 11, scope: !2106)
!2112 = !DILocation(line: 1041, column: 21, scope: !2106)
!2113 = !DILocalVariable(name: "mi_prime", scope: !2106, file: !17, line: 1041, type: !39)
!2114 = !DILocation(line: 0, scope: !2106)
!2115 = !DILocalVariable(name: "b1", scope: !2116, file: !17, line: 1043, type: !39)
!2116 = distinct !DILexicalBlock(scope: !2106, file: !17, line: 1043, column: 6)
!2117 = !DILocation(line: 0, scope: !2116)
!2118 = !DILocation(line: 1043, column: 11, scope: !2116)
!2119 = !DILocation(line: 1043, scope: !2116)
!2120 = !DILocation(line: 1043, column: 26, scope: !2121)
!2121 = distinct !DILexicalBlock(scope: !2116, file: !17, line: 1043, column: 6)
!2122 = !DILocation(line: 1043, column: 6, scope: !2116)
!2123 = !DILocation(line: 1044, column: 7, scope: !2124)
!2124 = distinct !DILexicalBlock(scope: !2121, file: !17, line: 1044, column: 7)
!2125 = !DILocation(line: 1044, scope: !2124)
!2126 = !DILocalVariable(name: "i1", scope: !2124, file: !17, line: 1044, type: !39)
!2127 = !DILocation(line: 0, scope: !2124)
!2128 = !DILocation(line: 1044, column: 27, scope: !2129)
!2129 = distinct !DILexicalBlock(scope: !2124, file: !17, line: 1044, column: 7)
!2130 = !DILocation(line: 1045, column: 20, scope: !2129)
!2131 = !DILocation(line: 1046, column: 50, scope: !2129)
!2132 = !DILocation(line: 1046, column: 60, scope: !2129)
!2133 = !DILocation(line: 1046, column: 66, scope: !2129)
!2134 = !DILocation(line: 1046, column: 76, scope: !2129)
!2135 = !DILocation(line: 1046, column: 83, scope: !2129)
!2136 = !DILocation(line: 1046, column: 94, scope: !2129)
!2137 = !DILocation(line: 1046, column: 27, scope: !2129)
!2138 = !DILocation(line: 1047, column: 34, scope: !2129)
!2139 = !DILocation(line: 1047, column: 48, scope: !2129)
!2140 = !DILocation(line: 1047, column: 57, scope: !2129)
!2141 = !DILocation(line: 1047, column: 67, scope: !2129)
!2142 = !DILocation(line: 1047, column: 27, scope: !2129)
!2143 = !DILocation(line: 1046, column: 19, scope: !2129)
!2144 = !DILocation(line: 1045, column: 8, scope: !2129)
!2145 = !DILocation(line: 1044, column: 41, scope: !2129)
!2146 = !DILocation(line: 1044, column: 7, scope: !2129)
!2147 = distinct !{!2147, !2123, !2148, !163}
!2148 = !DILocation(line: 1047, column: 73, scope: !2124)
!2149 = !DILocation(line: 1043, column: 37, scope: !2121)
!2150 = !DILocation(line: 1043, column: 6, scope: !2121)
!2151 = distinct !{!2151, !2122, !2152, !163}
!2152 = !DILocation(line: 1047, column: 73, scope: !2116)
!2153 = !DILocation(line: 1048, column: 58, scope: !2106)
!2154 = !DILocation(line: 1048, column: 72, scope: !2106)
!2155 = !DILocation(line: 1048, column: 81, scope: !2106)
!2156 = !DILocation(line: 1048, column: 51, scope: !2106)
!2157 = !DILocation(line: 1048, column: 6, scope: !2106)
!2158 = !DILocation(line: 1050, column: 36, scope: !2106)
!2159 = !DILocation(line: 1050, column: 50, scope: !2106)
!2160 = !DILocation(line: 1050, column: 59, scope: !2106)
!2161 = !DILocation(line: 1050, column: 29, scope: !2106)
!2162 = !DILocation(line: 1050, column: 6, scope: !2106)
!2163 = !DILocalVariable(name: "ti1", scope: !2164, file: !17, line: 1052, type: !39)
!2164 = distinct !DILexicalBlock(scope: !2106, file: !17, line: 1052, column: 6)
!2165 = !DILocation(line: 0, scope: !2164)
!2166 = !DILocation(line: 1052, column: 11, scope: !2164)
!2167 = !DILocation(line: 1052, scope: !2164)
!2168 = !DILocation(line: 1052, column: 28, scope: !2169)
!2169 = distinct !DILexicalBlock(scope: !2164, file: !17, line: 1052, column: 6)
!2170 = !DILocation(line: 1052, column: 6, scope: !2164)
!2171 = !DILocation(line: 1053, column: 7, scope: !2172)
!2172 = distinct !DILexicalBlock(scope: !2169, file: !17, line: 1053, column: 7)
!2173 = !DILocation(line: 1053, scope: !2172)
!2174 = !DILocalVariable(name: "ti2", scope: !2172, file: !17, line: 1053, type: !39)
!2175 = !DILocation(line: 0, scope: !2172)
!2176 = !DILocation(line: 1053, column: 29, scope: !2177)
!2177 = distinct !DILexicalBlock(scope: !2172, file: !17, line: 1053, column: 7)
!2178 = !DILocation(line: 1054, column: 8, scope: !2179)
!2179 = distinct !DILexicalBlock(scope: !2177, file: !17, line: 1054, column: 8)
!2180 = !DILocation(line: 1054, scope: !2179)
!2181 = !DILocalVariable(name: "tj1", scope: !2179, file: !17, line: 1054, type: !39)
!2182 = !DILocation(line: 0, scope: !2179)
!2183 = !DILocation(line: 1054, column: 30, scope: !2184)
!2184 = distinct !DILexicalBlock(scope: !2179, file: !17, line: 1054, column: 8)
!2185 = !DILocation(line: 1055, column: 9, scope: !2186)
!2186 = distinct !DILexicalBlock(scope: !2184, file: !17, line: 1055, column: 9)
!2187 = !DILocation(line: 1055, scope: !2186)
!2188 = !DILocalVariable(name: "tj2", scope: !2186, file: !17, line: 1055, type: !39)
!2189 = !DILocation(line: 0, scope: !2186)
!2190 = !DILocation(line: 1055, column: 31, scope: !2191)
!2191 = distinct !DILexicalBlock(scope: !2186, file: !17, line: 1055, column: 9)
!2192 = !DILocation(line: 1056, column: 23, scope: !2193)
!2193 = distinct !DILexicalBlock(scope: !2191, file: !17, line: 1055, column: 49)
!2194 = !DILocalVariable(name: "ti", scope: !2193, file: !17, line: 1056, type: !39)
!2195 = !DILocation(line: 0, scope: !2193)
!2196 = !DILocation(line: 1057, column: 23, scope: !2193)
!2197 = !DILocalVariable(name: "tj", scope: !2193, file: !17, line: 1057, type: !39)
!2198 = !DILocation(line: 1058, column: 31, scope: !2193)
!2199 = !DILocation(line: 1058, column: 42, scope: !2193)
!2200 = !DILocation(line: 1058, column: 52, scope: !2193)
!2201 = !DILocation(line: 1058, column: 63, scope: !2193)
!2202 = !DILocation(line: 1058, column: 22, scope: !2193)
!2203 = !DILocation(line: 1059, column: 39, scope: !2193)
!2204 = !DILocation(line: 1059, column: 49, scope: !2193)
!2205 = !DILocation(line: 1059, column: 29, scope: !2193)
!2206 = !DILocation(line: 1060, column: 36, scope: !2193)
!2207 = !DILocation(line: 1060, column: 50, scope: !2193)
!2208 = !DILocation(line: 1060, column: 59, scope: !2193)
!2209 = !DILocation(line: 1060, column: 76, scope: !2193)
!2210 = !DILocation(line: 1060, column: 70, scope: !2193)
!2211 = !DILocation(line: 1060, column: 86, scope: !2193)
!2212 = !DILocation(line: 1060, column: 29, scope: !2193)
!2213 = !DILocation(line: 1059, column: 21, scope: !2193)
!2214 = !DILocation(line: 1058, column: 10, scope: !2193)
!2215 = !DILocation(line: 1055, column: 45, scope: !2191)
!2216 = !DILocation(line: 1055, column: 9, scope: !2191)
!2217 = distinct !{!2217, !2185, !2218, !163}
!2218 = !DILocation(line: 1061, column: 9, scope: !2186)
!2219 = !DILocation(line: 1054, column: 44, scope: !2184)
!2220 = !DILocation(line: 1054, column: 8, scope: !2184)
!2221 = distinct !{!2221, !2178, !2222, !163}
!2222 = !DILocation(line: 1061, column: 9, scope: !2179)
!2223 = !DILocation(line: 1053, column: 43, scope: !2177)
!2224 = !DILocation(line: 1053, column: 7, scope: !2177)
!2225 = distinct !{!2225, !2171, !2226, !163}
!2226 = !DILocation(line: 1061, column: 9, scope: !2172)
!2227 = !DILocation(line: 1052, column: 42, scope: !2169)
!2228 = !DILocation(line: 1052, column: 6, scope: !2169)
!2229 = distinct !{!2229, !2170, !2230, !163}
!2230 = !DILocation(line: 1061, column: 9, scope: !2164)
!2231 = !DILocation(line: 1036, column: 51, scope: !2104)
!2232 = !DILocation(line: 1036, column: 5, scope: !2104)
!2233 = distinct !{!2233, !2097, !2234, !163}
!2234 = !DILocation(line: 1062, column: 5, scope: !2098)
!2235 = !DILocation(line: 1035, column: 40, scope: !2096)
!2236 = !DILocation(line: 1035, column: 4, scope: !2096)
!2237 = distinct !{!2237, !2089, !2238, !163}
!2238 = !DILocation(line: 1063, column: 4, scope: !2090)
!2239 = !DILocation(line: 1034, column: 36, scope: !2086)
!2240 = !DILocation(line: 1034, column: 3, scope: !2086)
!2241 = distinct !{!2241, !1932, !2242, !163}
!2242 = !DILocation(line: 1064, column: 3, scope: !1933)
!2243 = !DILocation(line: 1066, scope: !2088)
!2244 = !DILocalVariable(name: "mi", scope: !2088, file: !17, line: 1066, type: !39)
!2245 = !DILocation(line: 0, scope: !2088)
!2246 = !DILocation(line: 1066, column: 23, scope: !2247)
!2247 = distinct !DILexicalBlock(scope: !2088, file: !17, line: 1066, column: 3)
!2248 = !DILocation(line: 1105, column: 3, scope: !2249)
!2249 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 1105, column: 3)
!2250 = !DILocation(line: 1067, column: 4, scope: !2251)
!2251 = distinct !DILexicalBlock(scope: !2252, file: !17, line: 1067, column: 4)
!2252 = distinct !DILexicalBlock(scope: !2247, file: !17, line: 1066, column: 40)
!2253 = !DILocation(line: 1067, scope: !2251)
!2254 = !DILocalVariable(name: "idx", scope: !2251, file: !17, line: 1067, type: !39)
!2255 = !DILocation(line: 0, scope: !2251)
!2256 = !DILocation(line: 1067, column: 26, scope: !2257)
!2257 = distinct !DILexicalBlock(scope: !2251, file: !17, line: 1067, column: 4)
!2258 = !DILocation(line: 1068, column: 5, scope: !2259)
!2259 = distinct !DILexicalBlock(scope: !2260, file: !17, line: 1068, column: 5)
!2260 = distinct !DILexicalBlock(scope: !2257, file: !17, line: 1067, column: 44)
!2261 = !DILocation(line: 1068, scope: !2259)
!2262 = !DILocalVariable(name: "alpha", scope: !2259, file: !17, line: 1068, type: !39)
!2263 = !DILocation(line: 0, scope: !2259)
!2264 = !DILocation(line: 1068, column: 31, scope: !2265)
!2265 = distinct !DILexicalBlock(scope: !2259, file: !17, line: 1068, column: 5)
!2266 = !DILocalVariable(name: "gf16m_temp0", scope: !2267, file: !17, line: 1069, type: !18)
!2267 = distinct !DILexicalBlock(scope: !2265, file: !17, line: 1068, column: 55)
!2268 = !DILocation(line: 1069, column: 11, scope: !2267)
!2269 = !DILocalVariable(name: "gf16m_temp1", scope: !2267, file: !17, line: 1070, type: !18)
!2270 = !DILocation(line: 1070, column: 11, scope: !2267)
!2271 = !DILocalVariable(name: "X_tmp", scope: !2267, file: !17, line: 1072, type: !18)
!2272 = !DILocation(line: 1072, column: 11, scope: !2267)
!2273 = !DILocation(line: 1073, column: 21, scope: !2267)
!2274 = !DILocalVariable(name: "mi_prime", scope: !2267, file: !17, line: 1073, type: !39)
!2275 = !DILocation(line: 0, scope: !2267)
!2276 = !DILocalVariable(name: "b1", scope: !2277, file: !17, line: 1076, type: !39)
!2277 = distinct !DILexicalBlock(scope: !2267, file: !17, line: 1076, column: 6)
!2278 = !DILocation(line: 0, scope: !2277)
!2279 = !DILocation(line: 1076, column: 11, scope: !2277)
!2280 = !DILocation(line: 1076, scope: !2277)
!2281 = !DILocation(line: 1076, column: 26, scope: !2282)
!2282 = distinct !DILexicalBlock(scope: !2277, file: !17, line: 1076, column: 6)
!2283 = !DILocation(line: 1076, column: 6, scope: !2277)
!2284 = !DILocation(line: 1077, column: 7, scope: !2285)
!2285 = distinct !DILexicalBlock(scope: !2282, file: !17, line: 1077, column: 7)
!2286 = !DILocation(line: 1077, scope: !2285)
!2287 = !DILocalVariable(name: "i1", scope: !2285, file: !17, line: 1077, type: !39)
!2288 = !DILocation(line: 0, scope: !2285)
!2289 = !DILocation(line: 1077, column: 27, scope: !2290)
!2290 = distinct !DILexicalBlock(scope: !2285, file: !17, line: 1077, column: 7)
!2291 = !DILocation(line: 1078, column: 8, scope: !2292)
!2292 = distinct !DILexicalBlock(scope: !2290, file: !17, line: 1078, column: 8)
!2293 = !DILocation(line: 1078, scope: !2292)
!2294 = !DILocalVariable(name: "j1", scope: !2292, file: !17, line: 1078, type: !39)
!2295 = !DILocation(line: 0, scope: !2292)
!2296 = !DILocation(line: 1078, column: 28, scope: !2297)
!2297 = distinct !DILexicalBlock(scope: !2292, file: !17, line: 1078, column: 8)
!2298 = !DILocation(line: 1080, column: 29, scope: !2297)
!2299 = !DILocation(line: 1080, column: 39, scope: !2297)
!2300 = !DILocation(line: 1080, column: 14, scope: !2297)
!2301 = !DILocation(line: 1082, column: 40, scope: !2297)
!2302 = !DILocation(line: 1082, column: 50, scope: !2297)
!2303 = !DILocation(line: 1082, column: 56, scope: !2297)
!2304 = !DILocation(line: 1082, column: 66, scope: !2297)
!2305 = !DILocation(line: 1082, column: 73, scope: !2297)
!2306 = !DILocation(line: 1082, column: 89, scope: !2297)
!2307 = !DILocation(line: 1082, column: 84, scope: !2297)
!2308 = !DILocation(line: 1082, column: 99, scope: !2297)
!2309 = !DILocation(line: 1082, column: 17, scope: !2297)
!2310 = !DILocation(line: 1083, column: 24, scope: !2297)
!2311 = !DILocation(line: 1083, column: 38, scope: !2297)
!2312 = !DILocation(line: 1083, column: 47, scope: !2297)
!2313 = !DILocation(line: 1083, column: 57, scope: !2297)
!2314 = !DILocation(line: 1083, column: 17, scope: !2297)
!2315 = !DILocation(line: 1081, column: 13, scope: !2297)
!2316 = !DILocation(line: 1079, column: 9, scope: !2297)
!2317 = !DILocation(line: 1078, column: 41, scope: !2297)
!2318 = !DILocation(line: 1078, column: 8, scope: !2297)
!2319 = distinct !{!2319, !2291, !2320, !163}
!2320 = !DILocation(line: 1083, column: 63, scope: !2292)
!2321 = !DILocation(line: 1077, column: 40, scope: !2290)
!2322 = !DILocation(line: 1077, column: 7, scope: !2290)
!2323 = distinct !{!2323, !2284, !2324, !163}
!2324 = !DILocation(line: 1083, column: 63, scope: !2285)
!2325 = !DILocation(line: 1076, column: 37, scope: !2282)
!2326 = !DILocation(line: 1076, column: 6, scope: !2282)
!2327 = distinct !{!2327, !2283, !2328, !163}
!2328 = !DILocation(line: 1083, column: 63, scope: !2277)
!2329 = !DILocation(line: 1085, column: 45, scope: !2267)
!2330 = !DILocation(line: 1085, column: 59, scope: !2267)
!2331 = !DILocation(line: 1085, column: 68, scope: !2267)
!2332 = !DILocation(line: 1085, column: 38, scope: !2267)
!2333 = !DILocation(line: 1085, column: 6, scope: !2267)
!2334 = !DILocation(line: 1087, column: 52, scope: !2267)
!2335 = !DILocation(line: 1087, column: 66, scope: !2267)
!2336 = !DILocation(line: 1087, column: 75, scope: !2267)
!2337 = !DILocation(line: 1087, column: 45, scope: !2267)
!2338 = !DILocation(line: 1087, column: 6, scope: !2267)
!2339 = !DILocalVariable(name: "ti1", scope: !2340, file: !17, line: 1090, type: !39)
!2340 = distinct !DILexicalBlock(scope: !2267, file: !17, line: 1090, column: 6)
!2341 = !DILocation(line: 0, scope: !2340)
!2342 = !DILocation(line: 1090, column: 11, scope: !2340)
!2343 = !DILocation(line: 1090, scope: !2340)
!2344 = !DILocation(line: 1090, column: 28, scope: !2345)
!2345 = distinct !DILexicalBlock(scope: !2340, file: !17, line: 1090, column: 6)
!2346 = !DILocation(line: 1090, column: 6, scope: !2340)
!2347 = !DILocation(line: 1091, column: 7, scope: !2348)
!2348 = distinct !DILexicalBlock(scope: !2345, file: !17, line: 1091, column: 7)
!2349 = !DILocation(line: 1091, scope: !2348)
!2350 = !DILocalVariable(name: "ti2", scope: !2348, file: !17, line: 1091, type: !39)
!2351 = !DILocation(line: 0, scope: !2348)
!2352 = !DILocation(line: 1091, column: 29, scope: !2353)
!2353 = distinct !DILexicalBlock(scope: !2348, file: !17, line: 1091, column: 7)
!2354 = !DILocation(line: 1092, column: 8, scope: !2355)
!2355 = distinct !DILexicalBlock(scope: !2353, file: !17, line: 1092, column: 8)
!2356 = !DILocation(line: 1092, scope: !2355)
!2357 = !DILocalVariable(name: "tj1", scope: !2355, file: !17, line: 1092, type: !39)
!2358 = !DILocation(line: 0, scope: !2355)
!2359 = !DILocation(line: 1092, column: 30, scope: !2360)
!2360 = distinct !DILexicalBlock(scope: !2355, file: !17, line: 1092, column: 8)
!2361 = !DILocation(line: 1093, column: 9, scope: !2362)
!2362 = distinct !DILexicalBlock(scope: !2360, file: !17, line: 1093, column: 9)
!2363 = !DILocation(line: 1093, scope: !2362)
!2364 = !DILocalVariable(name: "tj2", scope: !2362, file: !17, line: 1093, type: !39)
!2365 = !DILocation(line: 0, scope: !2362)
!2366 = !DILocation(line: 1093, column: 31, scope: !2367)
!2367 = distinct !DILexicalBlock(scope: !2362, file: !17, line: 1093, column: 9)
!2368 = !DILocation(line: 1094, column: 23, scope: !2369)
!2369 = distinct !DILexicalBlock(scope: !2367, file: !17, line: 1093, column: 49)
!2370 = !DILocalVariable(name: "ti", scope: !2369, file: !17, line: 1094, type: !39)
!2371 = !DILocation(line: 0, scope: !2369)
!2372 = !DILocation(line: 1095, column: 23, scope: !2369)
!2373 = !DILocalVariable(name: "tj", scope: !2369, file: !17, line: 1095, type: !39)
!2374 = !DILocation(line: 1096, column: 31, scope: !2369)
!2375 = !DILocation(line: 1096, column: 42, scope: !2369)
!2376 = !DILocation(line: 1096, column: 52, scope: !2369)
!2377 = !DILocation(line: 1096, column: 63, scope: !2369)
!2378 = !DILocation(line: 1096, column: 22, scope: !2369)
!2379 = !DILocation(line: 1097, column: 39, scope: !2369)
!2380 = !DILocation(line: 1097, column: 49, scope: !2369)
!2381 = !DILocation(line: 1097, column: 29, scope: !2369)
!2382 = !DILocation(line: 1098, column: 36, scope: !2369)
!2383 = !DILocation(line: 1098, column: 50, scope: !2369)
!2384 = !DILocation(line: 1098, column: 59, scope: !2369)
!2385 = !DILocation(line: 1098, column: 76, scope: !2369)
!2386 = !DILocation(line: 1098, column: 70, scope: !2369)
!2387 = !DILocation(line: 1098, column: 86, scope: !2369)
!2388 = !DILocation(line: 1098, column: 29, scope: !2369)
!2389 = !DILocation(line: 1097, column: 21, scope: !2369)
!2390 = !DILocation(line: 1096, column: 10, scope: !2369)
!2391 = !DILocation(line: 1093, column: 45, scope: !2367)
!2392 = !DILocation(line: 1093, column: 9, scope: !2367)
!2393 = distinct !{!2393, !2361, !2394, !163}
!2394 = !DILocation(line: 1099, column: 9, scope: !2362)
!2395 = !DILocation(line: 1092, column: 44, scope: !2360)
!2396 = !DILocation(line: 1092, column: 8, scope: !2360)
!2397 = distinct !{!2397, !2354, !2398, !163}
!2398 = !DILocation(line: 1099, column: 9, scope: !2355)
!2399 = !DILocation(line: 1091, column: 43, scope: !2353)
!2400 = !DILocation(line: 1091, column: 7, scope: !2353)
!2401 = distinct !{!2401, !2347, !2402, !163}
!2402 = !DILocation(line: 1099, column: 9, scope: !2348)
!2403 = !DILocation(line: 1090, column: 42, scope: !2345)
!2404 = !DILocation(line: 1090, column: 6, scope: !2345)
!2405 = distinct !{!2405, !2346, !2406, !163}
!2406 = !DILocation(line: 1099, column: 9, scope: !2340)
!2407 = !DILocation(line: 1068, column: 51, scope: !2265)
!2408 = !DILocation(line: 1068, column: 5, scope: !2265)
!2409 = distinct !{!2409, !2258, !2410, !163}
!2410 = !DILocation(line: 1100, column: 5, scope: !2259)
!2411 = !DILocation(line: 1067, column: 40, scope: !2257)
!2412 = !DILocation(line: 1067, column: 4, scope: !2257)
!2413 = distinct !{!2413, !2250, !2414, !163}
!2414 = !DILocation(line: 1101, column: 4, scope: !2251)
!2415 = !DILocation(line: 1066, column: 36, scope: !2247)
!2416 = !DILocation(line: 1066, column: 3, scope: !2247)
!2417 = distinct !{!2417, !2087, !2418, !163}
!2418 = !DILocation(line: 1102, column: 3, scope: !2088)
!2419 = !DILocation(line: 1105, scope: !2249)
!2420 = !DILocalVariable(name: "i", scope: !2249, file: !17, line: 1105, type: !39)
!2421 = !DILocation(line: 0, scope: !2249)
!2422 = !DILocation(line: 1105, column: 21, scope: !2423)
!2423 = distinct !DILexicalBlock(scope: !2249, file: !17, line: 1105, column: 3)
!2424 = !DILocation(line: 1106, column: 8, scope: !2425)
!2425 = distinct !DILexicalBlock(scope: !2426, file: !17, line: 1106, column: 8)
!2426 = distinct !DILexicalBlock(scope: !2423, file: !17, line: 1105, column: 48)
!2427 = !DILocation(line: 1106, column: 20, scope: !2425)
!2428 = !DILocation(line: 1107, column: 5, scope: !2429)
!2429 = distinct !DILexicalBlock(scope: !2430, file: !17, line: 1107, column: 5)
!2430 = distinct !DILexicalBlock(scope: !2425, file: !17, line: 1106, column: 26)
!2431 = !DILocation(line: 1107, scope: !2429)
!2432 = !DILocalVariable(name: "j", scope: !2429, file: !17, line: 1107, type: !39)
!2433 = !DILocation(line: 0, scope: !2429)
!2434 = !DILocation(line: 1107, column: 27, scope: !2435)
!2435 = distinct !DILexicalBlock(scope: !2429, file: !17, line: 1107, column: 5)
!2436 = !DILocation(line: 1108, column: 10, scope: !2437)
!2437 = distinct !DILexicalBlock(scope: !2438, file: !17, line: 1108, column: 10)
!2438 = distinct !DILexicalBlock(scope: !2435, file: !17, line: 1107, column: 54)
!2439 = !DILocation(line: 1108, column: 22, scope: !2437)
!2440 = distinct !{!2440, !2428, !2441, !163}
!2441 = !DILocation(line: 1116, column: 5, scope: !2429)
!2442 = !DILocation(line: 1109, column: 7, scope: !2443)
!2443 = distinct !DILexicalBlock(scope: !2444, file: !17, line: 1109, column: 7)
!2444 = distinct !DILexicalBlock(scope: !2437, file: !17, line: 1108, column: 28)
!2445 = !DILocation(line: 1109, scope: !2443)
!2446 = !DILocalVariable(name: "k", scope: !2443, file: !17, line: 1109, type: !39)
!2447 = !DILocation(line: 0, scope: !2443)
!2448 = !DILocation(line: 1109, column: 25, scope: !2449)
!2449 = distinct !DILexicalBlock(scope: !2443, file: !17, line: 1109, column: 7)
!2450 = !DILocation(line: 1110, column: 22, scope: !2451)
!2451 = distinct !DILexicalBlock(scope: !2449, file: !17, line: 1109, column: 56)
!2452 = !DILocalVariable(name: "t_GF16", scope: !2451, file: !17, line: 1110, type: !19)
!2453 = !DILocation(line: 0, scope: !2451)
!2454 = !DILocation(line: 1111, column: 22, scope: !2451)
!2455 = !DILocation(line: 1111, column: 8, scope: !2451)
!2456 = !DILocation(line: 1111, column: 20, scope: !2451)
!2457 = !DILocation(line: 1112, column: 8, scope: !2451)
!2458 = !DILocation(line: 1112, column: 20, scope: !2451)
!2459 = !DILocation(line: 1109, column: 51, scope: !2449)
!2460 = !DILocation(line: 1109, column: 7, scope: !2449)
!2461 = distinct !{!2461, !2442, !2462, !163}
!2462 = !DILocation(line: 1113, column: 7, scope: !2443)
!2463 = !DILocation(line: 1118, column: 8, scope: !2464)
!2464 = distinct !DILexicalBlock(scope: !2426, file: !17, line: 1118, column: 8)
!2465 = !DILocation(line: 1118, column: 20, scope: !2464)
!2466 = !DILocation(line: 1123, column: 25, scope: !2426)
!2467 = !DILocation(line: 1123, column: 18, scope: !2426)
!2468 = !DILocalVariable(name: "t_GF16", scope: !2426, file: !17, line: 1123, type: !19)
!2469 = !DILocation(line: 0, scope: !2426)
!2470 = !DILocalVariable(name: "k", scope: !2471, file: !17, line: 1124, type: !39)
!2471 = distinct !DILexicalBlock(scope: !2426, file: !17, line: 1124, column: 4)
!2472 = !DILocation(line: 0, scope: !2471)
!2473 = !DILocation(line: 1124, column: 9, scope: !2471)
!2474 = !DILocation(line: 1124, scope: !2471)
!2475 = !DILocation(line: 1124, column: 22, scope: !2476)
!2476 = distinct !DILexicalBlock(scope: !2471, file: !17, line: 1124, column: 4)
!2477 = !DILocation(line: 1124, column: 4, scope: !2471)
!2478 = !DILocation(line: 1128, column: 4, scope: !2479)
!2479 = distinct !DILexicalBlock(scope: !2426, file: !17, line: 1128, column: 4)
!2480 = !DILocation(line: 1125, column: 27, scope: !2481)
!2481 = distinct !DILexicalBlock(scope: !2476, file: !17, line: 1124, column: 53)
!2482 = !DILocation(line: 1125, column: 19, scope: !2481)
!2483 = !DILocation(line: 1125, column: 5, scope: !2481)
!2484 = !DILocation(line: 1125, column: 17, scope: !2481)
!2485 = !DILocation(line: 1124, column: 48, scope: !2476)
!2486 = !DILocation(line: 1124, column: 4, scope: !2476)
!2487 = distinct !{!2487, !2477, !2488, !163}
!2488 = !DILocation(line: 1126, column: 4, scope: !2471)
!2489 = !DILocation(line: 1128, scope: !2479)
!2490 = !DILocalVariable(name: "j", scope: !2479, file: !17, line: 1128, type: !39)
!2491 = !DILocation(line: 0, scope: !2479)
!2492 = !DILocation(line: 1128, column: 26, scope: !2493)
!2493 = distinct !DILexicalBlock(scope: !2479, file: !17, line: 1128, column: 4)
!2494 = !DILocation(line: 1129, column: 9, scope: !2495)
!2495 = distinct !DILexicalBlock(scope: !2496, file: !17, line: 1129, column: 9)
!2496 = distinct !DILexicalBlock(scope: !2493, file: !17, line: 1128, column: 53)
!2497 = !DILocation(line: 1129, column: 21, scope: !2495)
!2498 = !DILocation(line: 1130, column: 17, scope: !2499)
!2499 = distinct !DILexicalBlock(scope: !2495, file: !17, line: 1129, column: 27)
!2500 = !DILocalVariable(name: "gji", scope: !2499, file: !17, line: 1130, type: !19)
!2501 = !DILocation(line: 0, scope: !2499)
!2502 = !DILocalVariable(name: "k", scope: !2503, file: !17, line: 1131, type: !39)
!2503 = distinct !DILexicalBlock(scope: !2499, file: !17, line: 1131, column: 6)
!2504 = !DILocation(line: 0, scope: !2503)
!2505 = !DILocation(line: 1131, column: 11, scope: !2503)
!2506 = !DILocation(line: 1131, scope: !2503)
!2507 = !DILocation(line: 1131, column: 24, scope: !2508)
!2508 = distinct !DILexicalBlock(scope: !2503, file: !17, line: 1131, column: 6)
!2509 = !DILocation(line: 1131, column: 6, scope: !2503)
!2510 = !DILocation(line: 1132, column: 28, scope: !2511)
!2511 = distinct !DILexicalBlock(scope: !2508, file: !17, line: 1131, column: 55)
!2512 = !DILocation(line: 1132, column: 49, scope: !2511)
!2513 = !DILocation(line: 1132, column: 41, scope: !2511)
!2514 = !DILocation(line: 1132, column: 21, scope: !2511)
!2515 = !DILocation(line: 1132, column: 7, scope: !2511)
!2516 = !DILocation(line: 1132, column: 19, scope: !2511)
!2517 = !DILocation(line: 1131, column: 50, scope: !2508)
!2518 = !DILocation(line: 1131, column: 6, scope: !2508)
!2519 = distinct !{!2519, !2509, !2520, !163}
!2520 = !DILocation(line: 1133, column: 6, scope: !2503)
!2521 = !DILocation(line: 1128, column: 4, scope: !2493)
!2522 = distinct !{!2522, !2478, !2523, !163}
!2523 = !DILocation(line: 1135, column: 4, scope: !2479)
!2524 = !DILocation(line: 1105, column: 43, scope: !2423)
!2525 = !DILocation(line: 1105, column: 3, scope: !2423)
!2526 = distinct !{!2526, !2248, !2527, !163}
!2527 = !DILocation(line: 1136, column: 3, scope: !2249)
!2528 = !DILocation(line: 1140, column: 4, scope: !2529)
!2529 = distinct !DILexicalBlock(scope: !2530, file: !17, line: 1138, column: 19)
!2530 = distinct !DILexicalBlock(scope: !1448, file: !17, line: 1138, column: 7)
!2531 = !DILocalVariable(name: "i", scope: !2532, file: !17, line: 1142, type: !39)
!2532 = distinct !DILexicalBlock(scope: !2529, file: !17, line: 1142, column: 4)
!2533 = !DILocation(line: 0, scope: !2532)
!2534 = !DILocation(line: 1142, column: 9, scope: !2532)
!2535 = !DILocation(line: 1142, scope: !2532)
!2536 = !DILocation(line: 1142, column: 43, scope: !2537)
!2537 = distinct !DILexicalBlock(scope: !2532, file: !17, line: 1142, column: 4)
!2538 = !DILocation(line: 1142, column: 4, scope: !2532)
!2539 = !DILocalVariable(name: "sum", scope: !2540, file: !17, line: 1143, type: !19)
!2540 = distinct !DILexicalBlock(scope: !2537, file: !17, line: 1142, column: 54)
!2541 = !DILocation(line: 0, scope: !2540)
!2542 = !DILocation(line: 1143, column: 10, scope: !2540)
!2543 = !DILocalVariable(name: "k", scope: !2544, file: !17, line: 1144, type: !39)
!2544 = distinct !DILexicalBlock(scope: !2540, file: !17, line: 1144, column: 5)
!2545 = !DILocation(line: 0, scope: !2544)
!2546 = !DILocation(line: 1144, column: 10, scope: !2544)
!2547 = !DILocation(line: 1144, column: 27, scope: !2548)
!2548 = distinct !DILexicalBlock(scope: !2544, file: !17, line: 1144, column: 5)
!2549 = !DILocation(line: 1144, column: 5, scope: !2544)
!2550 = !DILocation(line: 1144, scope: !2544)
!2551 = !DILocation(line: 1145, column: 31, scope: !2552)
!2552 = distinct !DILexicalBlock(scope: !2548, file: !17, line: 1144, column: 54)
!2553 = !DILocation(line: 1145, column: 44, scope: !2552)
!2554 = !DILocation(line: 1145, column: 23, scope: !2552)
!2555 = !DILocation(line: 1145, column: 6, scope: !2552)
!2556 = !DILocation(line: 1144, column: 5, scope: !2548)
!2557 = distinct !{!2557, !2549, !2558, !163}
!2558 = !DILocation(line: 1146, column: 5, scope: !2544)
!2559 = !DILocation(line: 1147, column: 26, scope: !2540)
!2560 = !DILocation(line: 1147, column: 56, scope: !2540)
!2561 = !DILocation(line: 1147, column: 19, scope: !2540)
!2562 = !DILocation(line: 1147, column: 5, scope: !2540)
!2563 = !DILocation(line: 1147, column: 17, scope: !2540)
!2564 = !DILocation(line: 1142, column: 49, scope: !2537)
!2565 = !DILocation(line: 1142, column: 4, scope: !2537)
!2566 = distinct !{!2566, !2538, !2567, !163}
!2567 = !DILocation(line: 1148, column: 4, scope: !2532)
!2568 = !DILocation(line: 1149, column: 27, scope: !2529)
!2569 = !DILocation(line: 1149, column: 4, scope: !2529)
!2570 = !DILocalVariable(name: "index", scope: !2571, file: !17, line: 1152, type: !39)
!2571 = distinct !DILexicalBlock(scope: !2529, file: !17, line: 1152, column: 4)
!2572 = !DILocation(line: 0, scope: !2571)
!2573 = !DILocation(line: 1152, column: 9, scope: !2571)
!2574 = !DILocation(line: 1152, scope: !2571)
!2575 = !DILocation(line: 1152, column: 30, scope: !2576)
!2576 = distinct !DILexicalBlock(scope: !2571, file: !17, line: 1152, column: 4)
!2577 = !DILocation(line: 1152, column: 4, scope: !2571)
!2578 = !DILocation(line: 1153, column: 5, scope: !2579)
!2579 = distinct !DILexicalBlock(scope: !2580, file: !17, line: 1153, column: 5)
!2580 = distinct !DILexicalBlock(scope: !2576, file: !17, line: 1152, column: 50)
!2581 = !DILocation(line: 1153, scope: !2579)
!2582 = !DILocalVariable(name: "mi", scope: !2579, file: !17, line: 1153, type: !39)
!2583 = !DILocation(line: 0, scope: !2579)
!2584 = !DILocation(line: 1153, column: 25, scope: !2585)
!2585 = distinct !DILexicalBlock(scope: !2579, file: !17, line: 1153, column: 5)
!2586 = !DILocation(line: 1154, column: 47, scope: !2587)
!2587 = distinct !DILexicalBlock(scope: !2585, file: !17, line: 1153, column: 42)
!2588 = !DILocation(line: 1154, column: 25, scope: !2587)
!2589 = !DILocation(line: 1154, column: 72, scope: !2587)
!2590 = !DILocation(line: 1154, column: 82, scope: !2587)
!2591 = !DILocation(line: 1154, column: 88, scope: !2587)
!2592 = !DILocation(line: 1154, column: 61, scope: !2587)
!2593 = !DILocation(line: 1155, column: 37, scope: !2587)
!2594 = !DILocation(line: 1155, column: 25, scope: !2587)
!2595 = !DILocation(line: 1154, column: 6, scope: !2587)
!2596 = !DILocation(line: 1153, column: 36, scope: !2585)
!2597 = !DILocation(line: 1153, column: 5, scope: !2585)
!2598 = distinct !{!2598, !2578, !2599, !163}
!2599 = !DILocation(line: 1156, column: 5, scope: !2579)
!2600 = !DILocation(line: 1152, column: 41, scope: !2576)
!2601 = !DILocation(line: 1152, column: 4, scope: !2576)
!2602 = distinct !{!2602, !2577, !2603, !163}
!2603 = !DILocation(line: 1157, column: 4, scope: !2571)
!2604 = !DILocation(line: 1161, column: 2, scope: !1204)
!2605 = !DILocation(line: 1162, column: 31, scope: !1204)
!2606 = !DILocation(line: 1162, column: 2, scope: !1204)
!2607 = !DILocation(line: 1164, column: 2, scope: !1204)
!2608 = !DILocation(line: 1165, column: 1, scope: !1204)
!2609 = distinct !DISubprogram(name: "gen_ABQ", scope: !17, file: !17, line: 642, type: !2610, scopeLine: 642, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2610 = !DISubroutineType(types: !2611)
!2611 = !{null, !358, !358, !358, !358, !358}
!2612 = !DILocalVariable(name: "A", arg: 1, scope: !2609, file: !17, line: 642, type: !358)
!2613 = !DILocation(line: 0, scope: !2609)
!2614 = !DILocalVariable(name: "Am", arg: 2, scope: !2609, file: !17, line: 642, type: !358)
!2615 = !DILocalVariable(name: "Bm", arg: 3, scope: !2609, file: !17, line: 642, type: !358)
!2616 = !DILocalVariable(name: "Q1m", arg: 4, scope: !2609, file: !17, line: 642, type: !358)
!2617 = !DILocalVariable(name: "Q2m", arg: 5, scope: !2609, file: !17, line: 642, type: !358)
!2618 = !DILocation(line: 643, column: 14, scope: !2609)
!2619 = !DILocalVariable(name: "B", scope: !2609, file: !17, line: 643, type: !358)
!2620 = !DILocation(line: 644, column: 15, scope: !2609)
!2621 = !DILocalVariable(name: "q1", scope: !2609, file: !17, line: 644, type: !358)
!2622 = !DILocation(line: 645, column: 16, scope: !2609)
!2623 = !DILocalVariable(name: "q2", scope: !2609, file: !17, line: 645, type: !358)
!2624 = !DILocalVariable(name: "idx", scope: !2625, file: !17, line: 647, type: !54)
!2625 = distinct !DILexicalBlock(scope: !2609, file: !17, line: 647, column: 2)
!2626 = !DILocation(line: 0, scope: !2625)
!2627 = !DILocation(line: 647, column: 7, scope: !2625)
!2628 = !DILocation(line: 647, scope: !2625)
!2629 = !DILocation(line: 647, column: 27, scope: !2630)
!2630 = distinct !DILexicalBlock(scope: !2625, file: !17, line: 647, column: 2)
!2631 = !DILocation(line: 647, column: 2, scope: !2625)
!2632 = !DILocation(line: 648, column: 35, scope: !2633)
!2633 = distinct !DILexicalBlock(scope: !2630, file: !17, line: 647, column: 59)
!2634 = !DILocation(line: 648, column: 28, scope: !2633)
!2635 = !DILocation(line: 648, column: 55, scope: !2633)
!2636 = !DILocation(line: 648, column: 49, scope: !2633)
!2637 = !DILocation(line: 648, column: 3, scope: !2633)
!2638 = !DILocation(line: 649, column: 35, scope: !2633)
!2639 = !DILocation(line: 649, column: 28, scope: !2633)
!2640 = !DILocation(line: 649, column: 55, scope: !2633)
!2641 = !DILocation(line: 649, column: 49, scope: !2633)
!2642 = !DILocation(line: 649, column: 3, scope: !2633)
!2643 = !DILocation(line: 650, column: 22, scope: !2633)
!2644 = !DILocation(line: 650, column: 14, scope: !2633)
!2645 = !DILocation(line: 650, column: 43, scope: !2633)
!2646 = !DILocation(line: 650, column: 36, scope: !2633)
!2647 = !DILocation(line: 650, column: 3, scope: !2633)
!2648 = !DILocation(line: 651, column: 22, scope: !2633)
!2649 = !DILocation(line: 651, column: 14, scope: !2633)
!2650 = !DILocation(line: 651, column: 43, scope: !2633)
!2651 = !DILocation(line: 651, column: 36, scope: !2633)
!2652 = !DILocation(line: 651, column: 3, scope: !2633)
!2653 = !DILocation(line: 647, column: 55, scope: !2630)
!2654 = !DILocation(line: 647, column: 2, scope: !2630)
!2655 = distinct !{!2655, !2631, !2656, !163}
!2656 = !DILocation(line: 652, column: 2, scope: !2625)
!2657 = !DILocation(line: 653, column: 1, scope: !2609)
!2658 = distinct !DISubprogram(name: "hash_combined", scope: !17, file: !17, line: 521, type: !2659, scopeLine: 522, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2659 = !DISubroutineType(types: !2660)
!2660 = !{null, !5, !241, !1207, !241, !241}
!2661 = !DILocalVariable(name: "hash_out", arg: 1, scope: !2658, file: !17, line: 521, type: !5)
!2662 = !DILocation(line: 0, scope: !2658)
!2663 = !DILocalVariable(name: "digest", arg: 2, scope: !2658, file: !17, line: 521, type: !241)
!2664 = !DILocalVariable(name: "len_digest", arg: 3, scope: !2658, file: !17, line: 521, type: !1207)
!2665 = !DILocalVariable(name: "pk_seed", arg: 4, scope: !2658, file: !17, line: 521, type: !241)
!2666 = !DILocalVariable(name: "salt", arg: 5, scope: !2658, file: !17, line: 522, type: !241)
!2667 = !DILocalVariable(name: "state", scope: !2658, file: !17, line: 523, type: !690)
!2668 = !DILocation(line: 523, column: 10, scope: !2658)
!2669 = !DILocation(line: 524, column: 2, scope: !2658)
!2670 = !DILocation(line: 526, column: 2, scope: !2658)
!2671 = !DILocation(line: 530, column: 2, scope: !2658)
!2672 = !DILocation(line: 531, column: 2, scope: !2658)
!2673 = !DILocation(line: 532, column: 2, scope: !2658)
!2674 = !DILocation(line: 533, column: 2, scope: !2658)
!2675 = !DILocation(line: 534, column: 1, scope: !2658)
!2676 = distinct !DISubprogram(name: "expand_gf", scope: !17, file: !17, line: 294, type: !2677, scopeLine: 294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2677 = !DISubroutineType(types: !2678)
!2678 = !{!39, !358, !241, !54}
!2679 = !DILocalVariable(name: "gf_array", arg: 1, scope: !2676, file: !17, line: 294, type: !358)
!2680 = !DILocation(line: 0, scope: !2676)
!2681 = !DILocalVariable(name: "byte_array", arg: 2, scope: !2676, file: !17, line: 294, type: !241)
!2682 = !DILocalVariable(name: "num", arg: 3, scope: !2676, file: !17, line: 294, type: !54)
!2683 = !DILocation(line: 295, column: 21, scope: !2676)
!2684 = !DILocalVariable(name: "num_bytes", scope: !2676, file: !17, line: 295, type: !54)
!2685 = !DILocalVariable(name: "idx", scope: !2676, file: !17, line: 296, type: !54)
!2686 = !DILocalVariable(name: "out_idx", scope: !2676, file: !17, line: 297, type: !54)
!2687 = !DILocalVariable(name: "res", scope: !2676, file: !17, line: 299, type: !39)
!2688 = !DILocation(line: 301, column: 2, scope: !2676)
!2689 = !DILocation(line: 297, column: 9, scope: !2676)
!2690 = !DILocation(line: 296, column: 9, scope: !2676)
!2691 = !DILocalVariable(name: "val", scope: !2676, file: !17, line: 298, type: !11)
!2692 = !DILocalVariable(name: "i1", scope: !2693, file: !17, line: 304, type: !39)
!2693 = distinct !DILexicalBlock(scope: !2676, file: !17, line: 301, column: 5)
!2694 = !DILocation(line: 0, scope: !2693)
!2695 = !DILocation(line: 305, column: 3, scope: !2693)
!2696 = !DILocation(line: 305, column: 26, scope: !2693)
!2697 = !DILocation(line: 312, column: 3, scope: !2693)
!2698 = !DILocation(line: 306, column: 28, scope: !2699)
!2699 = distinct !DILexicalBlock(scope: !2693, file: !17, line: 305, column: 46)
!2700 = !DILocation(line: 306, column: 17, scope: !2699)
!2701 = !DILocation(line: 306, column: 14, scope: !2699)
!2702 = !DILocation(line: 307, column: 7, scope: !2699)
!2703 = distinct !{!2703, !2695, !2704, !163}
!2704 = !DILocation(line: 309, column: 3, scope: !2693)
!2705 = !DILocalVariable(name: "j1", scope: !2693, file: !17, line: 311, type: !39)
!2706 = !DILocation(line: 312, column: 13, scope: !2693)
!2707 = !DILocation(line: 312, column: 23, scope: !2693)
!2708 = !DILocation(line: 313, column: 24, scope: !2709)
!2709 = distinct !DILexicalBlock(scope: !2693, file: !17, line: 312, column: 41)
!2710 = !DILocation(line: 313, column: 4, scope: !2709)
!2711 = !DILocation(line: 313, column: 22, scope: !2709)
!2712 = !DILocation(line: 314, column: 14, scope: !2709)
!2713 = !DILocation(line: 315, column: 11, scope: !2709)
!2714 = !DILocation(line: 316, column: 6, scope: !2709)
!2715 = distinct !{!2715, !2697, !2716, !163}
!2716 = !DILocation(line: 317, column: 3, scope: !2693)
!2717 = !DILocation(line: 319, column: 7, scope: !2693)
!2718 = !DILocation(line: 320, column: 19, scope: !2676)
!2719 = !DILocation(line: 320, column: 2, scope: !2693)
!2720 = distinct !{!2720, !2688, !2721, !163}
!2721 = !DILocation(line: 320, column: 24, scope: !2676)
!2722 = !DILocation(line: 323, column: 10, scope: !2723)
!2723 = distinct !DILexicalBlock(scope: !2676, file: !17, line: 323, column: 6)
!2724 = !DILocation(line: 324, column: 25, scope: !2725)
!2725 = distinct !DILexicalBlock(scope: !2723, file: !17, line: 323, column: 15)
!2726 = !DILocation(line: 324, column: 10, scope: !2725)
!2727 = !DILocation(line: 324, column: 30, scope: !2725)
!2728 = !DILocation(line: 324, column: 3, scope: !2725)
!2729 = !DILocation(line: 329, column: 1, scope: !2676)
!2730 = distinct !DISubprogram(name: "gf_mat_mul_add_lr", scope: !17, file: !17, line: 79, type: !2731, scopeLine: 79, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2731 = !DISubroutineType(types: !2732)
!2732 = !{null, !358, !745, !745, !39, !39, !39}
!2733 = !DILocalVariable(name: "a", arg: 1, scope: !2730, file: !17, line: 79, type: !358)
!2734 = !DILocation(line: 0, scope: !2730)
!2735 = !DILocalVariable(name: "b", arg: 2, scope: !2730, file: !17, line: 79, type: !745)
!2736 = !DILocalVariable(name: "c", arg: 3, scope: !2730, file: !17, line: 79, type: !745)
!2737 = !DILocalVariable(name: "ad", arg: 4, scope: !2730, file: !17, line: 79, type: !39)
!2738 = !DILocalVariable(name: "bd", arg: 5, scope: !2730, file: !17, line: 79, type: !39)
!2739 = !DILocalVariable(name: "cd", arg: 6, scope: !2730, file: !17, line: 79, type: !39)
!2740 = !DILocalVariable(name: "i1", scope: !2741, file: !17, line: 80, type: !39)
!2741 = distinct !DILexicalBlock(scope: !2730, file: !17, line: 80, column: 2)
!2742 = !DILocation(line: 0, scope: !2741)
!2743 = !DILocation(line: 80, column: 7, scope: !2741)
!2744 = !DILocation(line: 80, scope: !2741)
!2745 = !DILocation(line: 80, column: 22, scope: !2746)
!2746 = distinct !DILexicalBlock(scope: !2741, file: !17, line: 80, column: 2)
!2747 = !DILocation(line: 80, column: 2, scope: !2741)
!2748 = !DILocation(line: 81, column: 3, scope: !2749)
!2749 = distinct !DILexicalBlock(scope: !2746, file: !17, line: 81, column: 3)
!2750 = !DILocation(line: 81, scope: !2749)
!2751 = !DILocalVariable(name: "j1", scope: !2749, file: !17, line: 81, type: !39)
!2752 = !DILocation(line: 0, scope: !2749)
!2753 = !DILocation(line: 81, column: 23, scope: !2754)
!2754 = distinct !DILexicalBlock(scope: !2749, file: !17, line: 81, column: 3)
!2755 = !DILocalVariable(name: "sum", scope: !2756, file: !17, line: 82, type: !19)
!2756 = distinct !DILexicalBlock(scope: !2754, file: !17, line: 81, column: 35)
!2757 = !DILocation(line: 0, scope: !2756)
!2758 = !DILocation(line: 82, column: 9, scope: !2756)
!2759 = !DILocalVariable(name: "k1", scope: !2760, file: !17, line: 83, type: !39)
!2760 = distinct !DILexicalBlock(scope: !2756, file: !17, line: 83, column: 4)
!2761 = !DILocation(line: 0, scope: !2760)
!2762 = !DILocation(line: 83, column: 9, scope: !2760)
!2763 = !DILocation(line: 83, scope: !2760)
!2764 = !DILocation(line: 83, column: 24, scope: !2765)
!2765 = distinct !DILexicalBlock(scope: !2760, file: !17, line: 83, column: 4)
!2766 = !DILocation(line: 83, column: 4, scope: !2760)
!2767 = !DILocation(line: 84, column: 35, scope: !2768)
!2768 = distinct !DILexicalBlock(scope: !2765, file: !17, line: 83, column: 36)
!2769 = !DILocation(line: 84, column: 30, scope: !2768)
!2770 = !DILocation(line: 84, column: 52, scope: !2768)
!2771 = !DILocation(line: 84, column: 47, scope: !2768)
!2772 = !DILocation(line: 84, column: 22, scope: !2768)
!2773 = !DILocation(line: 84, column: 5, scope: !2768)
!2774 = !DILocation(line: 83, column: 32, scope: !2765)
!2775 = !DILocation(line: 83, column: 4, scope: !2765)
!2776 = distinct !{!2776, !2766, !2777, !163}
!2777 = !DILocation(line: 85, column: 4, scope: !2760)
!2778 = !DILocation(line: 86, column: 21, scope: !2756)
!2779 = !DILocation(line: 86, column: 16, scope: !2756)
!2780 = !DILocation(line: 86, column: 33, scope: !2756)
!2781 = !DILocation(line: 86, column: 4, scope: !2756)
!2782 = !DILocation(line: 81, column: 31, scope: !2754)
!2783 = !DILocation(line: 81, column: 3, scope: !2754)
!2784 = distinct !{!2784, !2748, !2785, !163}
!2785 = !DILocation(line: 87, column: 3, scope: !2749)
!2786 = !DILocation(line: 80, column: 30, scope: !2746)
!2787 = !DILocation(line: 80, column: 2, scope: !2746)
!2788 = distinct !{!2788, !2747, !2789, !163}
!2789 = !DILocation(line: 87, column: 3, scope: !2741)
!2790 = !DILocation(line: 88, column: 1, scope: !2730)
!2791 = distinct !DISubprogram(name: "gf_sub", scope: !17, file: !17, line: 38, type: !876, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2792 = !DILocalVariable(name: "a", arg: 1, scope: !2791, file: !17, line: 38, type: !746)
!2793 = !DILocation(line: 0, scope: !2791)
!2794 = !DILocalVariable(name: "b", arg: 2, scope: !2791, file: !17, line: 38, type: !746)
!2795 = !DILocation(line: 42, column: 19, scope: !2791)
!2796 = !DILocation(line: 42, column: 21, scope: !2791)
!2797 = !DILocation(line: 42, column: 33, scope: !2791)
!2798 = !DILocation(line: 42, column: 31, scope: !2791)
!2799 = !DILocation(line: 42, column: 9, scope: !2791)
!2800 = !DILocation(line: 42, column: 2, scope: !2791)
!2801 = distinct !DISubprogram(name: "gf_inv", scope: !17, file: !17, line: 26, type: !2802, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2802 = !DISubroutineType(types: !2803)
!2803 = !{!19, !746}
!2804 = !DILocalVariable(name: "a", arg: 1, scope: !2801, file: !17, line: 26, type: !746)
!2805 = !DILocation(line: 0, scope: !2801)
!2806 = !DILocation(line: 27, column: 9, scope: !2801)
!2807 = !DILocation(line: 27, column: 2, scope: !2801)
!2808 = distinct !DISubprogram(name: "be_invertible_by_add_aS", scope: !17, file: !17, line: 618, type: !2809, scopeLine: 618, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2809 = !DISubroutineType(types: !2810)
!2810 = !{null, !358, !745, !2811, !2811}
!2811 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!2812 = !DILocalVariable(name: "mat", arg: 1, scope: !2808, file: !17, line: 618, type: !358)
!2813 = !DILocation(line: 0, scope: !2808)
!2814 = !DILocalVariable(name: "orig", arg: 2, scope: !2808, file: !17, line: 618, type: !745)
!2815 = !DILocalVariable(name: "l1", arg: 3, scope: !2808, file: !17, line: 618, type: !2811)
!2816 = !DILocalVariable(name: "l2", arg: 4, scope: !2808, file: !17, line: 618, type: !2811)
!2817 = !DILocation(line: 619, column: 2, scope: !2808)
!2818 = !DILocation(line: 622, column: 7, scope: !2819)
!2819 = distinct !DILexicalBlock(scope: !2820, file: !17, line: 622, column: 7)
!2820 = distinct !DILexicalBlock(scope: !2808, file: !17, line: 621, column: 6)
!2821 = !DILocation(line: 622, column: 23, scope: !2819)
!2822 = !DILocation(line: 623, column: 4, scope: !2823)
!2823 = distinct !DILexicalBlock(scope: !2824, file: !17, line: 623, column: 4)
!2824 = distinct !DILexicalBlock(scope: !2819, file: !17, line: 622, column: 29)
!2825 = !DILocation(line: 623, scope: !2823)
!2826 = !DILocalVariable(name: "f1", scope: !2823, file: !17, line: 623, type: !19)
!2827 = !DILocation(line: 0, scope: !2823)
!2828 = !DILocation(line: 623, column: 25, scope: !2829)
!2829 = distinct !DILexicalBlock(scope: !2823, file: !17, line: 623, column: 4)
!2830 = !DILocation(line: 625, column: 5, scope: !2831)
!2831 = distinct !DILexicalBlock(scope: !2832, file: !17, line: 625, column: 5)
!2832 = distinct !DILexicalBlock(scope: !2829, file: !17, line: 623, column: 42)
!2833 = !DILocation(line: 625, scope: !2831)
!2834 = !DILocalVariable(name: "i1", scope: !2831, file: !17, line: 625, type: !39)
!2835 = !DILocation(line: 0, scope: !2831)
!2836 = !DILocation(line: 625, column: 25, scope: !2837)
!2837 = distinct !DILexicalBlock(scope: !2831, file: !17, line: 625, column: 5)
!2838 = !DILocation(line: 626, column: 18, scope: !2839)
!2839 = distinct !DILexicalBlock(scope: !2837, file: !17, line: 625, column: 43)
!2840 = !DILocation(line: 626, column: 53, scope: !2839)
!2841 = !DILocation(line: 626, column: 39, scope: !2839)
!2842 = !DILocation(line: 626, column: 27, scope: !2839)
!2843 = !DILocation(line: 626, column: 6, scope: !2839)
!2844 = !DILocation(line: 625, column: 39, scope: !2837)
!2845 = !DILocation(line: 625, column: 5, scope: !2837)
!2846 = distinct !{!2846, !2830, !2847, !163}
!2847 = !DILocation(line: 627, column: 5, scope: !2831)
!2848 = !DILocation(line: 631, column: 9, scope: !2849)
!2849 = distinct !DILexicalBlock(scope: !2832, file: !17, line: 631, column: 9)
!2850 = !DILocation(line: 631, column: 25, scope: !2849)
!2851 = !DILocation(line: 623, column: 38, scope: !2829)
!2852 = !DILocation(line: 623, column: 4, scope: !2829)
!2853 = distinct !{!2853, !2822, !2854, !163}
!2854 = !DILocation(line: 634, column: 4, scope: !2823)
!2855 = !DILocation(line: 637, column: 1, scope: !2808)
!2856 = distinct !DISubprogram(name: "gen_a_FqS", scope: !17, file: !17, line: 539, type: !888, scopeLine: 539, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2857 = !DILocalVariable(name: "Qm", arg: 1, scope: !2856, file: !17, line: 539, type: !358)
!2858 = !DILocation(line: 0, scope: !2856)
!2859 = !DILocalVariable(name: "q", arg: 2, scope: !2856, file: !17, line: 539, type: !358)
!2860 = !DILocalVariable(name: "i1", scope: !2861, file: !17, line: 546, type: !39)
!2861 = distinct !DILexicalBlock(scope: !2856, file: !17, line: 546, column: 2)
!2862 = !DILocation(line: 0, scope: !2861)
!2863 = !DILocation(line: 546, column: 7, scope: !2861)
!2864 = !DILocation(line: 546, scope: !2861)
!2865 = !DILocation(line: 546, column: 22, scope: !2866)
!2866 = distinct !DILexicalBlock(scope: !2861, file: !17, line: 546, column: 2)
!2867 = !DILocation(line: 546, column: 2, scope: !2861)
!2868 = !DILocalVariable(name: "sum", scope: !2869, file: !17, line: 547, type: !19)
!2869 = distinct !DILexicalBlock(scope: !2866, file: !17, line: 546, column: 40)
!2870 = !DILocation(line: 0, scope: !2869)
!2871 = !DILocation(line: 547, column: 8, scope: !2869)
!2872 = !DILocalVariable(name: "j1", scope: !2873, file: !17, line: 548, type: !39)
!2873 = distinct !DILexicalBlock(scope: !2869, file: !17, line: 548, column: 3)
!2874 = !DILocation(line: 0, scope: !2873)
!2875 = !DILocation(line: 548, column: 8, scope: !2873)
!2876 = !DILocation(line: 548, scope: !2873)
!2877 = !DILocation(line: 548, column: 23, scope: !2878)
!2878 = distinct !DILexicalBlock(scope: !2873, file: !17, line: 548, column: 3)
!2879 = !DILocation(line: 548, column: 3, scope: !2873)
!2880 = !DILocation(line: 549, column: 29, scope: !2881)
!2881 = distinct !DILexicalBlock(scope: !2878, file: !17, line: 548, column: 40)
!2882 = !DILocation(line: 549, column: 44, scope: !2881)
!2883 = !DILocation(line: 549, column: 55, scope: !2881)
!2884 = !DILocation(line: 549, column: 36, scope: !2881)
!2885 = !DILocation(line: 549, column: 21, scope: !2881)
!2886 = !DILocation(line: 549, column: 4, scope: !2881)
!2887 = !DILocation(line: 548, column: 36, scope: !2878)
!2888 = !DILocation(line: 548, column: 3, scope: !2878)
!2889 = distinct !{!2889, !2879, !2890, !163}
!2890 = !DILocation(line: 550, column: 3, scope: !2873)
!2891 = !DILocation(line: 551, column: 12, scope: !2869)
!2892 = !DILocation(line: 551, column: 3, scope: !2869)
!2893 = !DILocation(line: 551, column: 10, scope: !2869)
!2894 = !DILocation(line: 546, column: 36, scope: !2866)
!2895 = !DILocation(line: 546, column: 2, scope: !2866)
!2896 = distinct !{!2896, !2867, !2897, !163}
!2897 = !DILocation(line: 552, column: 2, scope: !2861)
!2898 = !DILocation(line: 553, column: 1, scope: !2856)
!2899 = distinct !DISubprogram(name: "gf_mat_det", scope: !17, file: !17, line: 90, type: !2900, scopeLine: 90, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2900 = !DISubroutineType(types: !2901)
!2901 = !{!19, !358}
!2902 = !DILocalVariable(name: "a", arg: 1, scope: !2899, file: !17, line: 90, type: !358)
!2903 = !DILocation(line: 0, scope: !2899)
!2904 = !DILocalVariable(name: "det", scope: !2899, file: !17, line: 91, type: !19)
!2905 = !DILocation(line: 91, column: 7, scope: !2899)
!2906 = !DILocation(line: 109, column: 2, scope: !2899)
!2907 = !DILocalVariable(name: "det_l", scope: !2899, file: !17, line: 101, type: !19)
!2908 = !DILocalVariable(name: "det_r", scope: !2899, file: !17, line: 102, type: !19)
!2909 = !DILocation(line: 110, column: 2, scope: !2899)
!2910 = !DILocation(line: 111, column: 2, scope: !2899)
!2911 = !DILocation(line: 112, column: 2, scope: !2899)
!2912 = !DILocation(line: 113, column: 2, scope: !2899)
!2913 = !DILocation(line: 114, column: 2, scope: !2899)
!2914 = !DILocation(line: 145, column: 9, scope: !2899)
!2915 = !DILocation(line: 145, column: 2, scope: !2899)
!2916 = distinct !DISubprogram(name: "_SNOVA_I_S_AES_ref_pk_expand", scope: !17, file: !17, line: 1170, type: !1197, scopeLine: 1170, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !141)
!2917 = !DILocalVariable(name: "pkx", arg: 1, scope: !2916, file: !17, line: 1170, type: !5)
!2918 = !DILocation(line: 0, scope: !2916)
!2919 = !DILocalVariable(name: "pk", arg: 2, scope: !2916, file: !17, line: 1170, type: !241)
!2920 = !DILocation(line: 1171, column: 6, scope: !2921)
!2921 = distinct !DILexicalBlock(scope: !2916, file: !17, line: 1171, column: 6)
!2922 = !DILocation(line: 1172, column: 3, scope: !2923)
!2923 = distinct !DILexicalBlock(scope: !2921, file: !17, line: 1171, column: 18)
!2924 = !DILocation(line: 1173, column: 2, scope: !2923)
!2925 = !DILocation(line: 1175, column: 2, scope: !2916)
!2926 = !DILocation(line: 1176, column: 13, scope: !2916)
!2927 = !DILocation(line: 1176, column: 2, scope: !2916)
!2928 = !DILocation(line: 1178, column: 15, scope: !2916)
!2929 = !DILocation(line: 1178, column: 2, scope: !2916)
!2930 = !DILocalVariable(name: "P_matrix", scope: !2916, file: !17, line: 1184, type: !436)
!2931 = !DILocation(line: 1184, column: 7, scope: !2916)
!2932 = !DILocalVariable(name: "P22", scope: !2916, file: !17, line: 1185, type: !429)
!2933 = !DILocation(line: 1185, column: 7, scope: !2916)
!2934 = !DILocalVariable(name: "P11", scope: !2916, file: !17, line: 1187, type: !358)
!2935 = !DILocation(line: 1188, column: 23, scope: !2916)
!2936 = !DILocalVariable(name: "P12", scope: !2916, file: !17, line: 1188, type: !358)
!2937 = !DILocation(line: 1189, column: 23, scope: !2916)
!2938 = !DILocalVariable(name: "P21", scope: !2916, file: !17, line: 1189, type: !358)
!2939 = !DILocation(line: 1191, column: 24, scope: !2940)
!2940 = distinct !DILexicalBlock(scope: !2916, file: !17, line: 1191, column: 6)
!2941 = !DILocation(line: 1191, column: 6, scope: !2940)
!2942 = !DILocation(line: 1194, column: 2, scope: !2916)
!2943 = !DILocalVariable(name: "mi", scope: !2944, file: !17, line: 1196, type: !39)
!2944 = distinct !DILexicalBlock(scope: !2916, file: !17, line: 1196, column: 2)
!2945 = !DILocation(line: 0, scope: !2944)
!2946 = !DILocation(line: 1196, column: 7, scope: !2944)
!2947 = !DILocation(line: 1196, scope: !2944)
!2948 = !DILocation(line: 1196, column: 22, scope: !2949)
!2949 = distinct !DILexicalBlock(scope: !2944, file: !17, line: 1196, column: 2)
!2950 = !DILocation(line: 1196, column: 2, scope: !2944)
!2951 = !DILocation(line: 1197, column: 3, scope: !2952)
!2952 = distinct !DILexicalBlock(scope: !2953, file: !17, line: 1197, column: 3)
!2953 = distinct !DILexicalBlock(scope: !2949, file: !17, line: 1196, column: 40)
!2954 = !DILocation(line: 1197, scope: !2952)
!2955 = !DILocalVariable(name: "ni", scope: !2952, file: !17, line: 1197, type: !39)
!2956 = !DILocation(line: 0, scope: !2952)
!2957 = !DILocation(line: 1197, column: 23, scope: !2958)
!2958 = distinct !DILexicalBlock(scope: !2952, file: !17, line: 1197, column: 3)
!2959 = !DILocation(line: 1210, column: 3, scope: !2960)
!2960 = distinct !DILexicalBlock(scope: !2953, file: !17, line: 1210, column: 3)
!2961 = !DILocation(line: 1198, column: 4, scope: !2962)
!2962 = distinct !DILexicalBlock(scope: !2963, file: !17, line: 1198, column: 4)
!2963 = distinct !DILexicalBlock(scope: !2958, file: !17, line: 1197, column: 40)
!2964 = !DILocation(line: 1198, scope: !2962)
!2965 = !DILocalVariable(name: "nj", scope: !2962, file: !17, line: 1198, type: !39)
!2966 = !DILocation(line: 0, scope: !2962)
!2967 = !DILocation(line: 1198, column: 24, scope: !2968)
!2968 = distinct !DILexicalBlock(scope: !2962, file: !17, line: 1198, column: 4)
!2969 = !DILocation(line: 1204, column: 4, scope: !2970)
!2970 = distinct !DILexicalBlock(scope: !2963, file: !17, line: 1204, column: 4)
!2971 = !DILocation(line: 1199, column: 5, scope: !2972)
!2972 = distinct !DILexicalBlock(scope: !2973, file: !17, line: 1199, column: 5)
!2973 = distinct !DILexicalBlock(scope: !2968, file: !17, line: 1198, column: 41)
!2974 = !DILocation(line: 1199, scope: !2972)
!2975 = !DILocalVariable(name: "idx", scope: !2972, file: !17, line: 1199, type: !39)
!2976 = !DILocation(line: 0, scope: !2972)
!2977 = !DILocation(line: 1199, column: 27, scope: !2978)
!2978 = distinct !DILexicalBlock(scope: !2972, file: !17, line: 1199, column: 5)
!2979 = !DILocation(line: 1201, column: 19, scope: !2978)
!2980 = !DILocation(line: 1201, column: 29, scope: !2978)
!2981 = !DILocation(line: 1201, column: 35, scope: !2978)
!2982 = !DILocation(line: 1201, column: 45, scope: !2978)
!2983 = !DILocation(line: 1201, column: 51, scope: !2978)
!2984 = !DILocation(line: 1201, column: 62, scope: !2978)
!2985 = !DILocation(line: 1201, column: 10, scope: !2978)
!2986 = !DILocation(line: 1200, column: 39, scope: !2978)
!2987 = !DILocation(line: 1200, column: 49, scope: !2978)
!2988 = !DILocation(line: 1200, column: 55, scope: !2978)
!2989 = !DILocation(line: 1200, column: 66, scope: !2978)
!2990 = !DILocation(line: 1200, column: 6, scope: !2978)
!2991 = !DILocation(line: 1200, column: 73, scope: !2978)
!2992 = !DILocation(line: 1199, column: 42, scope: !2978)
!2993 = !DILocation(line: 1199, column: 5, scope: !2978)
!2994 = distinct !{!2994, !2971, !2995, !163}
!2995 = !DILocation(line: 1201, column: 67, scope: !2972)
!2996 = !DILocation(line: 1198, column: 35, scope: !2968)
!2997 = !DILocation(line: 1198, column: 4, scope: !2968)
!2998 = distinct !{!2998, !2961, !2999, !163}
!2999 = !DILocation(line: 1202, column: 4, scope: !2962)
!3000 = !DILocation(line: 1204, scope: !2970)
!3001 = !DILocalVariable(name: "nj", scope: !2970, file: !17, line: 1204, type: !39)
!3002 = !DILocation(line: 0, scope: !2970)
!3003 = !DILocation(line: 1204, column: 30, scope: !3004)
!3004 = distinct !DILexicalBlock(scope: !2970, file: !17, line: 1204, column: 4)
!3005 = !DILocation(line: 1205, column: 5, scope: !3006)
!3006 = distinct !DILexicalBlock(scope: !3007, file: !17, line: 1205, column: 5)
!3007 = distinct !DILexicalBlock(scope: !3004, file: !17, line: 1204, column: 47)
!3008 = !DILocation(line: 1205, scope: !3006)
!3009 = !DILocalVariable(name: "idx", scope: !3006, file: !17, line: 1205, type: !39)
!3010 = !DILocation(line: 0, scope: !3006)
!3011 = !DILocation(line: 1205, column: 27, scope: !3012)
!3012 = distinct !DILexicalBlock(scope: !3006, file: !17, line: 1205, column: 5)
!3013 = !DILocation(line: 1207, column: 19, scope: !3012)
!3014 = !DILocation(line: 1207, column: 29, scope: !3012)
!3015 = !DILocation(line: 1207, column: 35, scope: !3012)
!3016 = !DILocation(line: 1207, column: 51, scope: !3012)
!3017 = !DILocation(line: 1207, column: 45, scope: !3012)
!3018 = !DILocation(line: 1207, column: 63, scope: !3012)
!3019 = !DILocation(line: 1207, column: 74, scope: !3012)
!3020 = !DILocation(line: 1207, column: 10, scope: !3012)
!3021 = !DILocation(line: 1206, column: 39, scope: !3012)
!3022 = !DILocation(line: 1206, column: 49, scope: !3012)
!3023 = !DILocation(line: 1206, column: 55, scope: !3012)
!3024 = !DILocation(line: 1206, column: 66, scope: !3012)
!3025 = !DILocation(line: 1206, column: 6, scope: !3012)
!3026 = !DILocation(line: 1206, column: 73, scope: !3012)
!3027 = !DILocation(line: 1205, column: 42, scope: !3012)
!3028 = !DILocation(line: 1205, column: 5, scope: !3012)
!3029 = distinct !{!3029, !3005, !3030, !163}
!3030 = !DILocation(line: 1207, column: 79, scope: !3006)
!3031 = !DILocation(line: 1204, column: 41, scope: !3004)
!3032 = !DILocation(line: 1204, column: 4, scope: !3004)
!3033 = distinct !{!3033, !2969, !3034, !163}
!3034 = !DILocation(line: 1208, column: 4, scope: !2970)
!3035 = !DILocation(line: 1197, column: 34, scope: !2958)
!3036 = !DILocation(line: 1197, column: 3, scope: !2958)
!3037 = distinct !{!3037, !2951, !3038, !163}
!3038 = !DILocation(line: 1209, column: 3, scope: !2952)
!3039 = !DILocation(line: 1210, scope: !2960)
!3040 = !DILocalVariable(name: "ni", scope: !2960, file: !17, line: 1210, type: !39)
!3041 = !DILocation(line: 0, scope: !2960)
!3042 = !DILocation(line: 1210, column: 29, scope: !3043)
!3043 = distinct !DILexicalBlock(scope: !2960, file: !17, line: 1210, column: 3)
!3044 = !DILocation(line: 1211, column: 4, scope: !3045)
!3045 = distinct !DILexicalBlock(scope: !3046, file: !17, line: 1211, column: 4)
!3046 = distinct !DILexicalBlock(scope: !3043, file: !17, line: 1210, column: 46)
!3047 = !DILocation(line: 1211, scope: !3045)
!3048 = !DILocalVariable(name: "nj", scope: !3045, file: !17, line: 1211, type: !39)
!3049 = !DILocation(line: 0, scope: !3045)
!3050 = !DILocation(line: 1211, column: 24, scope: !3051)
!3051 = distinct !DILexicalBlock(scope: !3045, file: !17, line: 1211, column: 4)
!3052 = !DILocation(line: 1217, column: 4, scope: !3053)
!3053 = distinct !DILexicalBlock(scope: !3046, file: !17, line: 1217, column: 4)
!3054 = !DILocation(line: 1212, column: 5, scope: !3055)
!3055 = distinct !DILexicalBlock(scope: !3056, file: !17, line: 1212, column: 5)
!3056 = distinct !DILexicalBlock(scope: !3051, file: !17, line: 1211, column: 41)
!3057 = !DILocation(line: 1212, scope: !3055)
!3058 = !DILocalVariable(name: "idx", scope: !3055, file: !17, line: 1212, type: !39)
!3059 = !DILocation(line: 0, scope: !3055)
!3060 = !DILocation(line: 1212, column: 27, scope: !3061)
!3061 = distinct !DILexicalBlock(scope: !3055, file: !17, line: 1212, column: 5)
!3062 = !DILocation(line: 1214, column: 19, scope: !3061)
!3063 = !DILocation(line: 1214, column: 35, scope: !3061)
!3064 = !DILocation(line: 1214, column: 29, scope: !3061)
!3065 = !DILocation(line: 1214, column: 47, scope: !3061)
!3066 = !DILocation(line: 1214, column: 57, scope: !3061)
!3067 = !DILocation(line: 1214, column: 63, scope: !3061)
!3068 = !DILocation(line: 1214, column: 74, scope: !3061)
!3069 = !DILocation(line: 1214, column: 10, scope: !3061)
!3070 = !DILocation(line: 1213, column: 39, scope: !3061)
!3071 = !DILocation(line: 1213, column: 49, scope: !3061)
!3072 = !DILocation(line: 1213, column: 55, scope: !3061)
!3073 = !DILocation(line: 1213, column: 66, scope: !3061)
!3074 = !DILocation(line: 1213, column: 6, scope: !3061)
!3075 = !DILocation(line: 1213, column: 73, scope: !3061)
!3076 = !DILocation(line: 1212, column: 42, scope: !3061)
!3077 = !DILocation(line: 1212, column: 5, scope: !3061)
!3078 = distinct !{!3078, !3054, !3079, !163}
!3079 = !DILocation(line: 1214, column: 79, scope: !3055)
!3080 = !DILocation(line: 1211, column: 35, scope: !3051)
!3081 = !DILocation(line: 1211, column: 4, scope: !3051)
!3082 = distinct !{!3082, !3044, !3083, !163}
!3083 = !DILocation(line: 1215, column: 4, scope: !3045)
!3084 = !DILocation(line: 1217, scope: !3053)
!3085 = !DILocalVariable(name: "nj", scope: !3053, file: !17, line: 1217, type: !39)
!3086 = !DILocation(line: 0, scope: !3053)
!3087 = !DILocation(line: 1217, column: 30, scope: !3088)
!3088 = distinct !DILexicalBlock(scope: !3053, file: !17, line: 1217, column: 4)
!3089 = !DILocation(line: 1218, column: 5, scope: !3090)
!3090 = distinct !DILexicalBlock(scope: !3091, file: !17, line: 1218, column: 5)
!3091 = distinct !DILexicalBlock(scope: !3088, file: !17, line: 1217, column: 47)
!3092 = !DILocation(line: 1218, scope: !3090)
!3093 = !DILocalVariable(name: "idx", scope: !3090, file: !17, line: 1218, type: !39)
!3094 = !DILocation(line: 0, scope: !3090)
!3095 = !DILocation(line: 1218, column: 27, scope: !3096)
!3096 = distinct !DILexicalBlock(scope: !3090, file: !17, line: 1218, column: 5)
!3097 = !DILocation(line: 1220, column: 19, scope: !3096)
!3098 = !DILocation(line: 1220, column: 35, scope: !3096)
!3099 = !DILocation(line: 1220, column: 29, scope: !3096)
!3100 = !DILocation(line: 1220, column: 47, scope: !3096)
!3101 = !DILocation(line: 1220, column: 57, scope: !3096)
!3102 = !DILocation(line: 1220, column: 73, scope: !3096)
!3103 = !DILocation(line: 1220, column: 84, scope: !3096)
!3104 = !DILocation(line: 1220, column: 10, scope: !3096)
!3105 = !DILocation(line: 1219, column: 39, scope: !3096)
!3106 = !DILocation(line: 1219, column: 49, scope: !3096)
!3107 = !DILocation(line: 1219, column: 55, scope: !3096)
!3108 = !DILocation(line: 1219, column: 66, scope: !3096)
!3109 = !DILocation(line: 1219, column: 6, scope: !3096)
!3110 = !DILocation(line: 1219, column: 73, scope: !3096)
!3111 = !DILocation(line: 1218, column: 42, scope: !3096)
!3112 = !DILocation(line: 1218, column: 5, scope: !3096)
!3113 = distinct !{!3113, !3089, !3114, !163}
!3114 = !DILocation(line: 1220, column: 89, scope: !3090)
!3115 = !DILocation(line: 1217, column: 41, scope: !3088)
!3116 = !DILocation(line: 1217, column: 4, scope: !3088)
!3117 = distinct !{!3117, !3052, !3118, !163}
!3118 = !DILocation(line: 1221, column: 4, scope: !3053)
!3119 = !DILocation(line: 1210, column: 40, scope: !3043)
!3120 = !DILocation(line: 1210, column: 3, scope: !3043)
!3121 = distinct !{!3121, !2959, !3122, !163}
!3122 = !DILocation(line: 1222, column: 3, scope: !2960)
!3123 = !DILocation(line: 1196, column: 34, scope: !2949)
!3124 = !DILocation(line: 1196, column: 2, scope: !2949)
!3125 = distinct !{!3125, !2950, !3126, !163}
!3126 = !DILocation(line: 1223, column: 2, scope: !2944)
!3127 = !DILocation(line: 1228, column: 21, scope: !2916)
!3128 = !DILocalVariable(name: "A", scope: !2916, file: !17, line: 1228, type: !358)
!3129 = !DILocation(line: 1229, column: 14, scope: !2916)
!3130 = !DILocalVariable(name: "B", scope: !2916, file: !17, line: 1229, type: !358)
!3131 = !DILocation(line: 1230, column: 15, scope: !2916)
!3132 = !DILocalVariable(name: "q1", scope: !2916, file: !17, line: 1230, type: !358)
!3133 = !DILocalVariable(name: "q2", scope: !2916, file: !17, line: 1231, type: !358)
!3134 = !DILocation(line: 1234, column: 2, scope: !2916)
!3135 = !DILocalVariable(name: "idx", scope: !3136, file: !17, line: 1237, type: !54)
!3136 = distinct !DILexicalBlock(scope: !2916, file: !17, line: 1237, column: 2)
!3137 = !DILocation(line: 0, scope: !3136)
!3138 = !DILocation(line: 1237, column: 7, scope: !3136)
!3139 = !DILocation(line: 1237, scope: !3136)
!3140 = !DILocation(line: 1237, column: 27, scope: !3141)
!3141 = distinct !DILexicalBlock(scope: !3136, file: !17, line: 1237, column: 2)
!3142 = !DILocation(line: 1237, column: 2, scope: !3136)
!3143 = !DILocation(line: 1238, column: 45, scope: !3144)
!3144 = distinct !DILexicalBlock(scope: !3141, file: !17, line: 1237, column: 59)
!3145 = !DILocation(line: 1238, column: 39, scope: !3144)
!3146 = !DILocation(line: 1238, column: 28, scope: !3144)
!3147 = !DILocation(line: 1238, column: 65, scope: !3144)
!3148 = !DILocation(line: 1238, column: 59, scope: !3144)
!3149 = !DILocation(line: 1238, column: 3, scope: !3144)
!3150 = !DILocation(line: 1239, column: 45, scope: !3144)
!3151 = !DILocation(line: 1239, column: 28, scope: !3144)
!3152 = !DILocation(line: 1239, column: 65, scope: !3144)
!3153 = !DILocation(line: 1239, column: 59, scope: !3144)
!3154 = !DILocation(line: 1239, column: 3, scope: !3144)
!3155 = !DILocation(line: 1237, column: 55, scope: !3141)
!3156 = !DILocation(line: 1237, column: 2, scope: !3141)
!3157 = distinct !{!3157, !3142, !3158, !163}
!3158 = !DILocation(line: 1249, column: 2, scope: !3136)
!3159 = !DILocation(line: 1231, column: 16, scope: !2916)
!3160 = !DILocation(line: 1251, column: 13, scope: !2916)
!3161 = !DILocation(line: 1251, column: 2, scope: !2916)
!3162 = !DILocation(line: 1252, column: 13, scope: !2916)
!3163 = !DILocation(line: 1252, column: 2, scope: !2916)
!3164 = !DILocation(line: 1254, column: 2, scope: !2916)
!3165 = !DILocation(line: 1255, column: 1, scope: !2916)
!3166 = distinct !DISubprogram(name: "expand_pk", scope: !17, file: !17, line: 382, type: !3167, scopeLine: 382, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!3167 = !DISubroutineType(types: !3168)
!3168 = !{!39, !358, !241}
!3169 = !DILocalVariable(name: "P22", arg: 1, scope: !3166, file: !17, line: 382, type: !358)
!3170 = !DILocation(line: 0, scope: !3166)
!3171 = !DILocalVariable(name: "pk", arg: 2, scope: !3166, file: !17, line: 382, type: !241)
!3172 = !DILocation(line: 417, column: 9, scope: !3166)
!3173 = !DILocation(line: 417, column: 2, scope: !3166)
!3174 = distinct !DISubprogram(name: "_SNOVA_I_S_AES_ref_verify", scope: !17, file: !17, line: 1260, type: !3175, scopeLine: 1260, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !141)
!3175 = !DISubroutineType(types: !3176)
!3176 = !{!39, !241, !241, !241, !1207}
!3177 = !DILocalVariable(name: "pkx", arg: 1, scope: !3174, file: !17, line: 1260, type: !241)
!3178 = !DILocation(line: 0, scope: !3174)
!3179 = !DILocalVariable(name: "sig", arg: 2, scope: !3174, file: !17, line: 1260, type: !241)
!3180 = !DILocalVariable(name: "digest", arg: 3, scope: !3174, file: !17, line: 1260, type: !241)
!3181 = !DILocalVariable(name: "len_digest", arg: 4, scope: !3174, file: !17, line: 1260, type: !1207)
!3182 = !DILocation(line: 1261, column: 6, scope: !3183)
!3183 = distinct !DILexicalBlock(scope: !3174, file: !17, line: 1261, column: 6)
!3184 = !DILocation(line: 1262, column: 3, scope: !3185)
!3185 = distinct !DILexicalBlock(scope: !3183, file: !17, line: 1261, column: 18)
!3186 = !DILocation(line: 1263, column: 2, scope: !3185)
!3187 = !DILocalVariable(name: "signature_in_GF", scope: !3174, file: !17, line: 1266, type: !1438)
!3188 = !DILocation(line: 1266, column: 7, scope: !3174)
!3189 = !DILocation(line: 1267, column: 6, scope: !3190)
!3190 = distinct !DILexicalBlock(scope: !3174, file: !17, line: 1267, column: 6)
!3191 = !DILocalVariable(name: "hash_in_GF", scope: !3174, file: !17, line: 1274, type: !1418)
!3192 = !DILocation(line: 1274, column: 7, scope: !3174)
!3193 = !DILocalVariable(name: "sum_t0", scope: !3174, file: !17, line: 1275, type: !3194)
!3194 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 81920, elements: !3195)
!3195 = !{!3196}
!3196 = !DISubrange(count: 10240)
!3197 = !DILocation(line: 1275, column: 7, scope: !3174)
!3198 = !DILocalVariable(name: "sum_t1", scope: !3174, file: !17, line: 1276, type: !1499)
!3199 = !DILocation(line: 1276, column: 7, scope: !3174)
!3200 = !DILocalVariable(name: "whipped_sig", scope: !3174, file: !17, line: 1281, type: !3201)
!3201 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 16384, elements: !3202)
!3202 = !{!3203}
!3203 = !DISubrange(count: 2048)
!3204 = !DILocation(line: 1281, column: 7, scope: !3174)
!3205 = !DILocalVariable(name: "ab", scope: !3206, file: !17, line: 1283, type: !39)
!3206 = distinct !DILexicalBlock(scope: !3174, file: !17, line: 1283, column: 2)
!3207 = !DILocation(line: 0, scope: !3206)
!3208 = !DILocation(line: 1283, column: 7, scope: !3206)
!3209 = !DILocation(line: 1283, scope: !3206)
!3210 = !DILocation(line: 1283, column: 22, scope: !3211)
!3211 = distinct !DILexicalBlock(scope: !3206, file: !17, line: 1283, column: 2)
!3212 = !DILocation(line: 1283, column: 2, scope: !3206)
!3213 = !DILocation(line: 1284, column: 3, scope: !3214)
!3214 = distinct !DILexicalBlock(scope: !3211, file: !17, line: 1284, column: 3)
!3215 = !DILocation(line: 1292, column: 2, scope: !3216)
!3216 = distinct !DILexicalBlock(scope: !3174, file: !17, line: 1292, column: 2)
!3217 = !DILocation(line: 1284, scope: !3214)
!3218 = !DILocalVariable(name: "idx", scope: !3214, file: !17, line: 1284, type: !39)
!3219 = !DILocation(line: 0, scope: !3214)
!3220 = !DILocation(line: 1284, column: 25, scope: !3221)
!3221 = distinct !DILexicalBlock(scope: !3214, file: !17, line: 1284, column: 3)
!3222 = !DILocation(line: 1285, column: 4, scope: !3223)
!3223 = distinct !DILexicalBlock(scope: !3221, file: !17, line: 1285, column: 4)
!3224 = !DILocation(line: 1285, scope: !3223)
!3225 = !DILocalVariable(name: "i1", scope: !3223, file: !17, line: 1285, type: !39)
!3226 = !DILocation(line: 0, scope: !3223)
!3227 = !DILocation(line: 1285, column: 24, scope: !3228)
!3228 = distinct !DILexicalBlock(scope: !3223, file: !17, line: 1285, column: 4)
!3229 = !DILocation(line: 1286, column: 5, scope: !3230)
!3230 = distinct !DILexicalBlock(scope: !3228, file: !17, line: 1286, column: 5)
!3231 = !DILocation(line: 1286, scope: !3230)
!3232 = !DILocalVariable(name: "j1", scope: !3230, file: !17, line: 1286, type: !39)
!3233 = !DILocation(line: 0, scope: !3230)
!3234 = !DILocation(line: 1286, column: 25, scope: !3235)
!3235 = distinct !DILexicalBlock(scope: !3230, file: !17, line: 1286, column: 5)
!3236 = !DILocation(line: 1287, column: 6, scope: !3237)
!3237 = distinct !DILexicalBlock(scope: !3235, file: !17, line: 1287, column: 6)
!3238 = !DILocation(line: 1287, scope: !3237)
!3239 = !DILocalVariable(name: "k1", scope: !3237, file: !17, line: 1287, type: !39)
!3240 = !DILocation(line: 0, scope: !3237)
!3241 = !DILocation(line: 1287, column: 26, scope: !3242)
!3242 = distinct !DILexicalBlock(scope: !3237, file: !17, line: 1287, column: 6)
!3243 = !DILocation(line: 1288, column: 52, scope: !3242)
!3244 = !DILocation(line: 1288, column: 68, scope: !3242)
!3245 = !DILocation(line: 1288, column: 63, scope: !3242)
!3246 = !DILocation(line: 1288, column: 78, scope: !3242)
!3247 = !DILocation(line: 1288, column: 19, scope: !3242)
!3248 = !DILocation(line: 1289, column: 34, scope: !3242)
!3249 = !DILocation(line: 1289, column: 50, scope: !3242)
!3250 = !DILocation(line: 1289, column: 45, scope: !3242)
!3251 = !DILocation(line: 1289, column: 60, scope: !3242)
!3252 = !DILocation(line: 1289, column: 26, scope: !3242)
!3253 = !DILocation(line: 1290, column: 46, scope: !3242)
!3254 = !DILocation(line: 1290, column: 62, scope: !3242)
!3255 = !DILocation(line: 1290, column: 57, scope: !3242)
!3256 = !DILocation(line: 1290, column: 72, scope: !3242)
!3257 = !DILocation(line: 1290, column: 26, scope: !3242)
!3258 = !DILocation(line: 1289, column: 18, scope: !3242)
!3259 = !DILocation(line: 1288, column: 7, scope: !3242)
!3260 = !DILocation(line: 1287, column: 39, scope: !3242)
!3261 = !DILocation(line: 1287, column: 6, scope: !3242)
!3262 = distinct !{!3262, !3236, !3263, !163}
!3263 = !DILocation(line: 1290, column: 78, scope: !3237)
!3264 = !DILocation(line: 1286, column: 38, scope: !3235)
!3265 = !DILocation(line: 1286, column: 5, scope: !3235)
!3266 = distinct !{!3266, !3229, !3267, !163}
!3267 = !DILocation(line: 1290, column: 78, scope: !3230)
!3268 = !DILocation(line: 1285, column: 37, scope: !3228)
!3269 = !DILocation(line: 1285, column: 4, scope: !3228)
!3270 = distinct !{!3270, !3222, !3271, !163}
!3271 = !DILocation(line: 1290, column: 78, scope: !3223)
!3272 = !DILocation(line: 1284, column: 36, scope: !3221)
!3273 = !DILocation(line: 1284, column: 3, scope: !3221)
!3274 = distinct !{!3274, !3213, !3275, !163}
!3275 = !DILocation(line: 1290, column: 78, scope: !3214)
!3276 = !DILocation(line: 1283, column: 33, scope: !3211)
!3277 = !DILocation(line: 1283, column: 2, scope: !3211)
!3278 = distinct !{!3278, !3212, !3279, !163}
!3279 = !DILocation(line: 1290, column: 78, scope: !3206)
!3280 = !DILocation(line: 1292, scope: !3216)
!3281 = !DILocalVariable(name: "mi", scope: !3216, file: !17, line: 1292, type: !39)
!3282 = !DILocation(line: 0, scope: !3216)
!3283 = !DILocation(line: 1292, column: 22, scope: !3284)
!3284 = distinct !DILexicalBlock(scope: !3216, file: !17, line: 1292, column: 2)
!3285 = !DILocation(line: 1294, column: 3, scope: !3286)
!3286 = distinct !DILexicalBlock(scope: !3287, file: !17, line: 1294, column: 3)
!3287 = distinct !DILexicalBlock(scope: !3284, file: !17, line: 1292, column: 40)
!3288 = !DILocation(line: 1317, column: 2, scope: !3289)
!3289 = distinct !DILexicalBlock(scope: !3174, file: !17, line: 1317, column: 2)
!3290 = !DILocation(line: 1294, scope: !3286)
!3291 = !DILocalVariable(name: "ni", scope: !3286, file: !17, line: 1294, type: !39)
!3292 = !DILocation(line: 0, scope: !3286)
!3293 = !DILocation(line: 1294, column: 23, scope: !3294)
!3294 = distinct !DILexicalBlock(scope: !3286, file: !17, line: 1294, column: 3)
!3295 = !DILocation(line: 1302, column: 3, scope: !3296)
!3296 = distinct !DILexicalBlock(scope: !3287, file: !17, line: 1302, column: 3)
!3297 = !DILocation(line: 1295, column: 4, scope: !3298)
!3298 = distinct !DILexicalBlock(scope: !3294, file: !17, line: 1295, column: 4)
!3299 = !DILocation(line: 1295, scope: !3298)
!3300 = !DILocalVariable(name: "b1", scope: !3298, file: !17, line: 1295, type: !39)
!3301 = !DILocation(line: 0, scope: !3298)
!3302 = !DILocation(line: 1295, column: 24, scope: !3303)
!3303 = distinct !DILexicalBlock(scope: !3298, file: !17, line: 1295, column: 4)
!3304 = !DILocation(line: 1296, column: 5, scope: !3305)
!3305 = distinct !DILexicalBlock(scope: !3303, file: !17, line: 1296, column: 5)
!3306 = !DILocation(line: 1296, scope: !3305)
!3307 = !DILocalVariable(name: "nj", scope: !3305, file: !17, line: 1296, type: !39)
!3308 = !DILocation(line: 0, scope: !3305)
!3309 = !DILocation(line: 1296, column: 25, scope: !3310)
!3310 = distinct !DILexicalBlock(scope: !3305, file: !17, line: 1296, column: 5)
!3311 = !DILocation(line: 1297, column: 52, scope: !3310)
!3312 = !DILocation(line: 1297, column: 62, scope: !3310)
!3313 = !DILocation(line: 1297, column: 68, scope: !3310)
!3314 = !DILocation(line: 1297, column: 24, scope: !3310)
!3315 = !DILocation(line: 1298, column: 57, scope: !3310)
!3316 = !DILocation(line: 1298, column: 67, scope: !3310)
!3317 = !DILocation(line: 1298, column: 73, scope: !3310)
!3318 = !DILocation(line: 1298, column: 24, scope: !3310)
!3319 = !DILocation(line: 1299, column: 56, scope: !3310)
!3320 = !DILocation(line: 1299, column: 24, scope: !3310)
!3321 = !DILocation(line: 1297, column: 6, scope: !3310)
!3322 = !DILocation(line: 1296, column: 36, scope: !3310)
!3323 = !DILocation(line: 1296, column: 5, scope: !3310)
!3324 = distinct !{!3324, !3304, !3325, !163}
!3325 = !DILocation(line: 1299, column: 67, scope: !3305)
!3326 = !DILocation(line: 1295, column: 35, scope: !3303)
!3327 = !DILocation(line: 1295, column: 4, scope: !3303)
!3328 = distinct !{!3328, !3297, !3329, !163}
!3329 = !DILocation(line: 1299, column: 67, scope: !3298)
!3330 = !DILocation(line: 1294, column: 34, scope: !3294)
!3331 = !DILocation(line: 1294, column: 3, scope: !3294)
!3332 = distinct !{!3332, !3285, !3333, !163}
!3333 = !DILocation(line: 1299, column: 67, scope: !3286)
!3334 = !DILocation(line: 1302, scope: !3296)
!3335 = !DILocalVariable(name: "a1", scope: !3296, file: !17, line: 1302, type: !39)
!3336 = !DILocation(line: 0, scope: !3296)
!3337 = !DILocation(line: 1302, column: 23, scope: !3338)
!3338 = distinct !DILexicalBlock(scope: !3296, file: !17, line: 1302, column: 3)
!3339 = !DILocation(line: 1303, column: 4, scope: !3340)
!3340 = distinct !DILexicalBlock(scope: !3338, file: !17, line: 1303, column: 4)
!3341 = !DILocation(line: 1303, scope: !3340)
!3342 = !DILocalVariable(name: "b1", scope: !3340, file: !17, line: 1303, type: !39)
!3343 = !DILocation(line: 0, scope: !3340)
!3344 = !DILocation(line: 1303, column: 24, scope: !3345)
!3345 = distinct !DILexicalBlock(scope: !3340, file: !17, line: 1303, column: 4)
!3346 = !DILocation(line: 1304, column: 5, scope: !3347)
!3347 = distinct !DILexicalBlock(scope: !3345, file: !17, line: 1304, column: 5)
!3348 = !DILocation(line: 1304, scope: !3347)
!3349 = !DILocalVariable(name: "ni", scope: !3347, file: !17, line: 1304, type: !39)
!3350 = !DILocation(line: 0, scope: !3347)
!3351 = !DILocation(line: 1304, column: 25, scope: !3352)
!3352 = distinct !DILexicalBlock(scope: !3347, file: !17, line: 1304, column: 5)
!3353 = !DILocation(line: 1305, column: 6, scope: !3354)
!3354 = distinct !DILexicalBlock(scope: !3352, file: !17, line: 1305, column: 6)
!3355 = !DILocation(line: 1305, scope: !3354)
!3356 = !DILocalVariable(name: "i1", scope: !3354, file: !17, line: 1305, type: !39)
!3357 = !DILocation(line: 0, scope: !3354)
!3358 = !DILocation(line: 1305, column: 26, scope: !3359)
!3359 = distinct !DILexicalBlock(scope: !3354, file: !17, line: 1305, column: 6)
!3360 = !DILocation(line: 1306, column: 7, scope: !3361)
!3361 = distinct !DILexicalBlock(scope: !3359, file: !17, line: 1306, column: 7)
!3362 = !DILocation(line: 1306, scope: !3361)
!3363 = !DILocalVariable(name: "j1", scope: !3361, file: !17, line: 1306, type: !39)
!3364 = !DILocation(line: 0, scope: !3361)
!3365 = !DILocation(line: 1306, column: 27, scope: !3366)
!3366 = distinct !DILexicalBlock(scope: !3361, file: !17, line: 1306, column: 7)
!3367 = !DILocation(line: 1307, column: 8, scope: !3368)
!3368 = distinct !DILexicalBlock(scope: !3366, file: !17, line: 1307, column: 8)
!3369 = !DILocation(line: 1307, scope: !3368)
!3370 = !DILocalVariable(name: "k1", scope: !3368, file: !17, line: 1307, type: !39)
!3371 = !DILocation(line: 0, scope: !3368)
!3372 = !DILocation(line: 1307, column: 28, scope: !3373)
!3373 = distinct !DILexicalBlock(scope: !3368, file: !17, line: 1307, column: 8)
!3374 = !DILocation(line: 1309, column: 25, scope: !3373)
!3375 = !DILocation(line: 1309, column: 41, scope: !3373)
!3376 = !DILocation(line: 1309, column: 36, scope: !3373)
!3377 = !DILocation(line: 1309, column: 51, scope: !3373)
!3378 = !DILocation(line: 1309, column: 57, scope: !3373)
!3379 = !DILocation(line: 1309, column: 73, scope: !3373)
!3380 = !DILocation(line: 1309, column: 68, scope: !3373)
!3381 = !DILocation(line: 1309, column: 83, scope: !3373)
!3382 = !DILocation(line: 1309, column: 14, scope: !3373)
!3383 = !DILocation(line: 1310, column: 53, scope: !3373)
!3384 = !DILocation(line: 1310, column: 69, scope: !3373)
!3385 = !DILocation(line: 1310, column: 64, scope: !3373)
!3386 = !DILocation(line: 1310, column: 79, scope: !3373)
!3387 = !DILocation(line: 1310, column: 21, scope: !3373)
!3388 = !DILocation(line: 1311, column: 49, scope: !3373)
!3389 = !DILocation(line: 1311, column: 59, scope: !3373)
!3390 = !DILocation(line: 1311, column: 65, scope: !3373)
!3391 = !DILocation(line: 1311, column: 81, scope: !3373)
!3392 = !DILocation(line: 1311, column: 76, scope: !3373)
!3393 = !DILocation(line: 1311, column: 91, scope: !3373)
!3394 = !DILocation(line: 1311, column: 21, scope: !3373)
!3395 = !DILocation(line: 1310, column: 13, scope: !3373)
!3396 = !DILocation(line: 1308, column: 9, scope: !3373)
!3397 = !DILocation(line: 1307, column: 41, scope: !3373)
!3398 = !DILocation(line: 1307, column: 8, scope: !3373)
!3399 = distinct !{!3399, !3367, !3400, !163}
!3400 = !DILocation(line: 1311, column: 97, scope: !3368)
!3401 = !DILocation(line: 1306, column: 40, scope: !3366)
!3402 = !DILocation(line: 1306, column: 7, scope: !3366)
!3403 = distinct !{!3403, !3360, !3404, !163}
!3404 = !DILocation(line: 1311, column: 97, scope: !3361)
!3405 = !DILocation(line: 1305, column: 39, scope: !3359)
!3406 = !DILocation(line: 1305, column: 6, scope: !3359)
!3407 = distinct !{!3407, !3353, !3408, !163}
!3408 = !DILocation(line: 1311, column: 97, scope: !3354)
!3409 = !DILocation(line: 1304, column: 36, scope: !3352)
!3410 = !DILocation(line: 1304, column: 5, scope: !3352)
!3411 = distinct !{!3411, !3346, !3412, !163}
!3412 = !DILocation(line: 1311, column: 97, scope: !3347)
!3413 = !DILocation(line: 1303, column: 35, scope: !3345)
!3414 = !DILocation(line: 1303, column: 4, scope: !3345)
!3415 = distinct !{!3415, !3339, !3416, !163}
!3416 = !DILocation(line: 1311, column: 97, scope: !3340)
!3417 = !DILocation(line: 1302, column: 34, scope: !3338)
!3418 = !DILocation(line: 1302, column: 3, scope: !3338)
!3419 = distinct !{!3419, !3295, !3420, !163}
!3420 = !DILocation(line: 1311, column: 97, scope: !3296)
!3421 = !DILocation(line: 1292, column: 34, scope: !3284)
!3422 = !DILocation(line: 1292, column: 2, scope: !3284)
!3423 = distinct !{!3423, !3215, !3424, !163}
!3424 = !DILocation(line: 1312, column: 2, scope: !3216)
!3425 = !DILocation(line: 1317, scope: !3289)
!3426 = !DILocalVariable(name: "mi", scope: !3289, file: !17, line: 1317, type: !39)
!3427 = !DILocation(line: 0, scope: !3289)
!3428 = !DILocation(line: 1317, column: 22, scope: !3429)
!3429 = distinct !DILexicalBlock(scope: !3289, file: !17, line: 1317, column: 2)
!3430 = !DILocation(line: 1318, column: 3, scope: !3431)
!3431 = distinct !DILexicalBlock(scope: !3429, file: !17, line: 1318, column: 3)
!3432 = !DILocation(line: 1318, scope: !3431)
!3433 = !DILocalVariable(name: "alpha", scope: !3431, file: !17, line: 1318, type: !39)
!3434 = !DILocation(line: 0, scope: !3431)
!3435 = !DILocation(line: 1318, column: 29, scope: !3436)
!3436 = distinct !DILexicalBlock(scope: !3431, file: !17, line: 1318, column: 3)
!3437 = !DILocation(line: 1319, column: 19, scope: !3438)
!3438 = distinct !DILexicalBlock(scope: !3436, file: !17, line: 1318, column: 53)
!3439 = !DILocalVariable(name: "mi_prime", scope: !3438, file: !17, line: 1319, type: !39)
!3440 = !DILocation(line: 0, scope: !3438)
!3441 = !DILocalVariable(name: "gf16m_temp1", scope: !3438, file: !17, line: 1321, type: !18)
!3442 = !DILocation(line: 1321, column: 9, scope: !3438)
!3443 = !DILocalVariable(name: "gf16m_temp2", scope: !3438, file: !17, line: 1322, type: !18)
!3444 = !DILocation(line: 1322, column: 9, scope: !3438)
!3445 = !DILocalVariable(name: "a1", scope: !3446, file: !17, line: 1325, type: !39)
!3446 = distinct !DILexicalBlock(scope: !3438, file: !17, line: 1325, column: 4)
!3447 = !DILocation(line: 0, scope: !3446)
!3448 = !DILocation(line: 1325, column: 9, scope: !3446)
!3449 = !DILocation(line: 1325, scope: !3446)
!3450 = !DILocation(line: 1325, column: 24, scope: !3451)
!3451 = distinct !DILexicalBlock(scope: !3446, file: !17, line: 1325, column: 4)
!3452 = !DILocation(line: 1325, column: 4, scope: !3446)
!3453 = !DILocalVariable(name: "sumb", scope: !3454, file: !17, line: 1326, type: !18)
!3454 = distinct !DILexicalBlock(scope: !3451, file: !17, line: 1325, column: 41)
!3455 = !DILocation(line: 1326, column: 10, scope: !3454)
!3456 = !DILocalVariable(name: "b1", scope: !3457, file: !17, line: 1328, type: !39)
!3457 = distinct !DILexicalBlock(scope: !3454, file: !17, line: 1328, column: 5)
!3458 = !DILocation(line: 0, scope: !3457)
!3459 = !DILocation(line: 1328, column: 10, scope: !3457)
!3460 = !DILocation(line: 1328, scope: !3457)
!3461 = !DILocation(line: 1328, column: 25, scope: !3462)
!3462 = distinct !DILexicalBlock(scope: !3457, file: !17, line: 1328, column: 5)
!3463 = !DILocation(line: 1328, column: 5, scope: !3457)
!3464 = !DILocation(line: 1335, column: 5, scope: !3465)
!3465 = distinct !DILexicalBlock(scope: !3454, file: !17, line: 1335, column: 5)
!3466 = !DILocation(line: 1329, column: 6, scope: !3467)
!3467 = distinct !DILexicalBlock(scope: !3462, file: !17, line: 1329, column: 6)
!3468 = !DILocation(line: 1329, scope: !3467)
!3469 = !DILocalVariable(name: "i1", scope: !3467, file: !17, line: 1329, type: !39)
!3470 = !DILocation(line: 0, scope: !3467)
!3471 = !DILocation(line: 1329, column: 26, scope: !3472)
!3472 = distinct !DILexicalBlock(scope: !3467, file: !17, line: 1329, column: 6)
!3473 = !DILocation(line: 1330, column: 7, scope: !3474)
!3474 = distinct !DILexicalBlock(scope: !3472, file: !17, line: 1330, column: 7)
!3475 = !DILocation(line: 1330, scope: !3474)
!3476 = !DILocalVariable(name: "j1", scope: !3474, file: !17, line: 1330, type: !39)
!3477 = !DILocation(line: 0, scope: !3474)
!3478 = !DILocation(line: 1330, column: 27, scope: !3479)
!3479 = distinct !DILexicalBlock(scope: !3474, file: !17, line: 1330, column: 7)
!3480 = !DILocation(line: 1331, column: 28, scope: !3479)
!3481 = !DILocation(line: 1331, column: 38, scope: !3479)
!3482 = !DILocation(line: 1331, column: 20, scope: !3479)
!3483 = !DILocation(line: 1332, column: 44, scope: !3479)
!3484 = !DILocation(line: 1332, column: 60, scope: !3479)
!3485 = !DILocation(line: 1332, column: 55, scope: !3479)
!3486 = !DILocation(line: 1332, column: 70, scope: !3479)
!3487 = !DILocation(line: 1332, column: 76, scope: !3479)
!3488 = !DILocation(line: 1332, column: 92, scope: !3479)
!3489 = !DILocation(line: 1332, column: 87, scope: !3479)
!3490 = !DILocation(line: 1332, column: 102, scope: !3479)
!3491 = !DILocation(line: 1332, column: 27, scope: !3479)
!3492 = !DILocation(line: 1333, column: 44, scope: !3479)
!3493 = !DILocation(line: 1333, column: 58, scope: !3479)
!3494 = !DILocation(line: 1333, column: 67, scope: !3479)
!3495 = !DILocation(line: 1333, column: 38, scope: !3479)
!3496 = !DILocation(line: 1333, column: 77, scope: !3479)
!3497 = !DILocation(line: 1333, column: 27, scope: !3479)
!3498 = !DILocation(line: 1332, column: 19, scope: !3479)
!3499 = !DILocation(line: 1331, column: 8, scope: !3479)
!3500 = !DILocation(line: 1330, column: 40, scope: !3479)
!3501 = !DILocation(line: 1330, column: 7, scope: !3479)
!3502 = distinct !{!3502, !3473, !3503, !163}
!3503 = !DILocation(line: 1333, column: 83, scope: !3474)
!3504 = !DILocation(line: 1329, column: 39, scope: !3472)
!3505 = !DILocation(line: 1329, column: 6, scope: !3472)
!3506 = distinct !{!3506, !3466, !3507, !163}
!3507 = !DILocation(line: 1333, column: 83, scope: !3467)
!3508 = !DILocation(line: 1328, column: 36, scope: !3462)
!3509 = !DILocation(line: 1328, column: 5, scope: !3462)
!3510 = distinct !{!3510, !3463, !3511, !163}
!3511 = !DILocation(line: 1333, column: 83, scope: !3457)
!3512 = !DILocation(line: 1335, scope: !3465)
!3513 = !DILocalVariable(name: "i1", scope: !3465, file: !17, line: 1335, type: !39)
!3514 = !DILocation(line: 0, scope: !3465)
!3515 = !DILocation(line: 1335, column: 25, scope: !3516)
!3516 = distinct !DILexicalBlock(scope: !3465, file: !17, line: 1335, column: 5)
!3517 = !DILocation(line: 1336, column: 6, scope: !3518)
!3518 = distinct !DILexicalBlock(scope: !3516, file: !17, line: 1336, column: 6)
!3519 = !DILocation(line: 1336, scope: !3518)
!3520 = !DILocalVariable(name: "j1", scope: !3518, file: !17, line: 1336, type: !39)
!3521 = !DILocation(line: 0, scope: !3518)
!3522 = !DILocation(line: 1336, column: 26, scope: !3523)
!3523 = distinct !DILexicalBlock(scope: !3518, file: !17, line: 1336, column: 6)
!3524 = !DILocation(line: 1337, column: 34, scope: !3523)
!3525 = !DILocation(line: 1337, column: 44, scope: !3523)
!3526 = !DILocation(line: 1337, column: 19, scope: !3523)
!3527 = !DILocation(line: 1338, column: 34, scope: !3523)
!3528 = !DILocation(line: 1338, column: 44, scope: !3523)
!3529 = !DILocation(line: 1338, column: 26, scope: !3523)
!3530 = !DILocation(line: 1338, column: 68, scope: !3523)
!3531 = !DILocation(line: 1338, column: 82, scope: !3523)
!3532 = !DILocation(line: 1338, column: 91, scope: !3523)
!3533 = !DILocation(line: 1338, column: 62, scope: !3523)
!3534 = !DILocation(line: 1338, column: 101, scope: !3523)
!3535 = !DILocation(line: 1338, column: 51, scope: !3523)
!3536 = !DILocation(line: 1338, column: 18, scope: !3523)
!3537 = !DILocation(line: 1337, column: 7, scope: !3523)
!3538 = !DILocation(line: 1336, column: 39, scope: !3523)
!3539 = !DILocation(line: 1336, column: 6, scope: !3523)
!3540 = distinct !{!3540, !3517, !3541, !163}
!3541 = !DILocation(line: 1338, column: 107, scope: !3518)
!3542 = !DILocation(line: 1335, column: 38, scope: !3516)
!3543 = !DILocation(line: 1335, column: 5, scope: !3516)
!3544 = distinct !{!3544, !3464, !3545, !163}
!3545 = !DILocation(line: 1338, column: 107, scope: !3465)
!3546 = !DILocation(line: 1325, column: 35, scope: !3451)
!3547 = !DILocation(line: 1325, column: 4, scope: !3451)
!3548 = distinct !{!3548, !3452, !3549, !163}
!3549 = !DILocation(line: 1339, column: 4, scope: !3446)
!3550 = !DILocation(line: 1342, column: 66, scope: !3438)
!3551 = !DILocation(line: 1342, column: 80, scope: !3438)
!3552 = !DILocation(line: 1342, column: 89, scope: !3438)
!3553 = !DILocation(line: 1342, column: 49, scope: !3438)
!3554 = !DILocation(line: 1342, column: 4, scope: !3438)
!3555 = !DILocation(line: 1344, column: 37, scope: !3438)
!3556 = !DILocation(line: 1344, column: 23, scope: !3438)
!3557 = !DILocation(line: 1344, column: 68, scope: !3438)
!3558 = !DILocation(line: 1344, column: 82, scope: !3438)
!3559 = !DILocation(line: 1344, column: 91, scope: !3438)
!3560 = !DILocation(line: 1344, column: 62, scope: !3438)
!3561 = !DILocation(line: 1344, column: 51, scope: !3438)
!3562 = !DILocation(line: 1344, column: 4, scope: !3438)
!3563 = !DILocation(line: 1318, column: 44, scope: !3436)
!3564 = !DILocation(line: 1318, column: 3, scope: !3436)
!3565 = distinct !{!3565, !3430, !3566, !163}
!3566 = !DILocation(line: 1346, column: 3, scope: !3431)
!3567 = !DILocation(line: 1317, column: 33, scope: !3429)
!3568 = !DILocation(line: 1317, column: 2, scope: !3429)
!3569 = distinct !{!3569, !3288, !3570, !163}
!3570 = !DILocation(line: 1346, column: 3, scope: !3289)
!3571 = !DILocalVariable(name: "signed_bytes", scope: !3174, file: !17, line: 1351, type: !1423)
!3572 = !DILocation(line: 1351, column: 10, scope: !3174)
!3573 = !DILocalVariable(name: "signed_gf", scope: !3174, file: !17, line: 1352, type: !3574)
!3574 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 640, elements: !1419)
!3575 = !DILocation(line: 1352, column: 10, scope: !3174)
!3576 = !DILocation(line: 1353, column: 46, scope: !3174)
!3577 = !DILocalVariable(name: "salt", scope: !3174, file: !17, line: 1353, type: !241)
!3578 = !DILocation(line: 1355, column: 54, scope: !3174)
!3579 = !DILocation(line: 1355, column: 2, scope: !3174)
!3580 = !DILocation(line: 1359, column: 2, scope: !3174)
!3581 = !DILocalVariable(name: "result", scope: !3174, file: !17, line: 1361, type: !39)
!3582 = !DILocalVariable(name: "i", scope: !3583, file: !17, line: 1362, type: !39)
!3583 = distinct !DILexicalBlock(scope: !3174, file: !17, line: 1362, column: 2)
!3584 = !DILocation(line: 0, scope: !3583)
!3585 = !DILocation(line: 1362, column: 7, scope: !3583)
!3586 = !DILocation(line: 1362, scope: !3583)
!3587 = !DILocation(line: 1362, column: 20, scope: !3588)
!3588 = distinct !DILexicalBlock(scope: !3583, file: !17, line: 1362, column: 2)
!3589 = !DILocation(line: 1362, column: 2, scope: !3583)
!3590 = !DILocation(line: 1363, column: 7, scope: !3591)
!3591 = distinct !DILexicalBlock(scope: !3592, file: !17, line: 1363, column: 7)
!3592 = distinct !DILexicalBlock(scope: !3588, file: !17, line: 1362, column: 38)
!3593 = !DILocation(line: 1363, column: 24, scope: !3591)
!3594 = !DILocation(line: 1363, column: 21, scope: !3591)
!3595 = !DILocation(line: 1362, column: 33, scope: !3588)
!3596 = !DILocation(line: 1362, column: 2, scope: !3588)
!3597 = distinct !{!3597, !3589, !3598, !163}
!3598 = !DILocation(line: 1367, column: 2, scope: !3583)
!3599 = !DILocation(line: 1370, column: 1, scope: !3174)
!3600 = distinct !DISubprogram(name: "gf_mat_mul_add16", scope: !17, file: !17, line: 68, type: !743, scopeLine: 68, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !141)
!3601 = !DILocalVariable(name: "a", arg: 1, scope: !3600, file: !17, line: 68, type: !358)
!3602 = !DILocation(line: 0, scope: !3600)
!3603 = !DILocalVariable(name: "b", arg: 2, scope: !3600, file: !17, line: 68, type: !745)
!3604 = !DILocalVariable(name: "c", arg: 3, scope: !3600, file: !17, line: 68, type: !745)
!3605 = !DILocalVariable(name: "i1", scope: !3606, file: !17, line: 69, type: !39)
!3606 = distinct !DILexicalBlock(scope: !3600, file: !17, line: 69, column: 2)
!3607 = !DILocation(line: 0, scope: !3606)
!3608 = !DILocation(line: 69, column: 7, scope: !3606)
!3609 = !DILocation(line: 69, scope: !3606)
!3610 = !DILocation(line: 69, column: 22, scope: !3611)
!3611 = distinct !DILexicalBlock(scope: !3606, file: !17, line: 69, column: 2)
!3612 = !DILocation(line: 69, column: 2, scope: !3606)
!3613 = !DILocation(line: 70, column: 3, scope: !3614)
!3614 = distinct !DILexicalBlock(scope: !3611, file: !17, line: 70, column: 3)
!3615 = !DILocation(line: 70, scope: !3614)
!3616 = !DILocalVariable(name: "j1", scope: !3614, file: !17, line: 70, type: !39)
!3617 = !DILocation(line: 0, scope: !3614)
!3618 = !DILocation(line: 70, column: 23, scope: !3619)
!3619 = distinct !DILexicalBlock(scope: !3614, file: !17, line: 70, column: 3)
!3620 = !DILocalVariable(name: "sum", scope: !3621, file: !17, line: 71, type: !19)
!3621 = distinct !DILexicalBlock(scope: !3619, file: !17, line: 70, column: 40)
!3622 = !DILocation(line: 0, scope: !3621)
!3623 = !DILocation(line: 71, column: 9, scope: !3621)
!3624 = !DILocalVariable(name: "k1", scope: !3625, file: !17, line: 72, type: !39)
!3625 = distinct !DILexicalBlock(scope: !3621, file: !17, line: 72, column: 4)
!3626 = !DILocation(line: 0, scope: !3625)
!3627 = !DILocation(line: 72, column: 9, scope: !3625)
!3628 = !DILocation(line: 72, scope: !3625)
!3629 = !DILocation(line: 72, column: 24, scope: !3630)
!3630 = distinct !DILexicalBlock(scope: !3625, file: !17, line: 72, column: 4)
!3631 = !DILocation(line: 72, column: 4, scope: !3625)
!3632 = !DILocation(line: 73, column: 35, scope: !3633)
!3633 = distinct !DILexicalBlock(scope: !3630, file: !17, line: 72, column: 41)
!3634 = !DILocation(line: 73, column: 45, scope: !3633)
!3635 = !DILocation(line: 73, column: 30, scope: !3633)
!3636 = !DILocation(line: 73, column: 57, scope: !3633)
!3637 = !DILocation(line: 73, column: 67, scope: !3633)
!3638 = !DILocation(line: 73, column: 52, scope: !3633)
!3639 = !DILocation(line: 73, column: 22, scope: !3633)
!3640 = !DILocation(line: 73, column: 5, scope: !3633)
!3641 = !DILocation(line: 72, column: 37, scope: !3630)
!3642 = !DILocation(line: 72, column: 4, scope: !3630)
!3643 = distinct !{!3643, !3631, !3644, !163}
!3644 = !DILocation(line: 74, column: 4, scope: !3625)
!3645 = !DILocation(line: 75, column: 21, scope: !3621)
!3646 = !DILocation(line: 75, column: 31, scope: !3621)
!3647 = !DILocation(line: 75, column: 16, scope: !3621)
!3648 = !DILocation(line: 75, column: 38, scope: !3621)
!3649 = !DILocation(line: 75, column: 4, scope: !3621)
!3650 = !DILocation(line: 70, column: 36, scope: !3619)
!3651 = !DILocation(line: 70, column: 3, scope: !3619)
!3652 = distinct !{!3652, !3613, !3653, !163}
!3653 = !DILocation(line: 76, column: 3, scope: !3614)
!3654 = !DILocation(line: 69, column: 35, scope: !3611)
!3655 = !DILocation(line: 69, column: 2, scope: !3611)
!3656 = distinct !{!3656, !3612, !3657, !163}
!3657 = !DILocation(line: 76, column: 3, scope: !3606)
!3658 = !DILocation(line: 77, column: 1, scope: !3600)
!3659 = distinct !DISubprogram(name: "snova_secure_clear", scope: !3660, file: !3660, line: 15, type: !3661, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!3660 = !DIFile(filename: "../../../src/symmetric_ref.c", directory: "/home/siddhesh/Desktop/SNOVA_LLVM/SNOVA/llvm/llvmgen_and_taintProp/build")
!3661 = !DISubroutineType(types: !3662)
!3662 = !{null, !66, !54}
!3663 = !DILocalVariable(name: "ptr", arg: 1, scope: !3659, file: !3660, line: 15, type: !66)
!3664 = !DILocation(line: 0, scope: !3659)
!3665 = !DILocalVariable(name: "len", arg: 2, scope: !3659, file: !3660, line: 15, type: !54)
!3666 = !DILocation(line: 16, column: 2, scope: !3659)
!3667 = !DILocation(line: 17, column: 1, scope: !3659)
!3668 = distinct !DISubprogram(name: "shake128_init", scope: !3660, file: !3660, line: 19, type: !3669, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!3669 = !DISubroutineType(types: !3670)
!3670 = !{null, !3671}
!3671 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3672, size: 32)
!3672 = !DIDerivedType(tag: DW_TAG_typedef, name: "shake_t", file: !691, line: 9, baseType: !3673)
!3673 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !691, line: 7, size: 1792, elements: !3674)
!3674 = !{!3675}
!3675 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !3673, file: !691, line: 8, baseType: !695, size: 1792)
!3676 = !DILocalVariable(name: "instance", arg: 1, scope: !3668, file: !3660, line: 19, type: !3671)
!3677 = !DILocation(line: 0, scope: !3668)
!3678 = !DILocation(line: 20, column: 2, scope: !3668)
!3679 = !DILocation(line: 21, column: 2, scope: !3668)
!3680 = !DILocation(line: 21, column: 22, scope: !3668)
!3681 = !DILocation(line: 22, column: 1, scope: !3668)
!3682 = distinct !DISubprogram(name: "shake256_init", scope: !3660, file: !3660, line: 24, type: !3669, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!3683 = !DILocalVariable(name: "instance", arg: 1, scope: !3682, file: !3660, line: 24, type: !3671)
!3684 = !DILocation(line: 0, scope: !3682)
!3685 = !DILocation(line: 25, column: 2, scope: !3682)
!3686 = !DILocation(line: 26, column: 2, scope: !3682)
!3687 = !DILocation(line: 26, column: 22, scope: !3682)
!3688 = !DILocation(line: 27, column: 1, scope: !3682)
!3689 = distinct !DISubprogram(name: "shake_absorb", scope: !3660, file: !3660, line: 29, type: !3690, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!3690 = !DISubroutineType(types: !3691)
!3691 = !{null, !3671, !241, !54}
!3692 = !DILocalVariable(name: "instance", arg: 1, scope: !3689, file: !3660, line: 29, type: !3671)
!3693 = !DILocation(line: 0, scope: !3689)
!3694 = !DILocalVariable(name: "in", arg: 2, scope: !3689, file: !3660, line: 29, type: !241)
!3695 = !DILocalVariable(name: "inlen", arg: 3, scope: !3689, file: !3660, line: 29, type: !54)
!3696 = !DILocation(line: 30, column: 37, scope: !3689)
!3697 = !DILocation(line: 30, column: 2, scope: !3689)
!3698 = !DILocation(line: 31, column: 1, scope: !3689)
!3699 = distinct !DISubprogram(name: "keccak_inc_absorb", scope: !57, file: !57, line: 320, type: !3700, scopeLine: 320, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !49, retainedNodes: !141)
!3700 = !DISubroutineType(types: !3701)
!3701 = !{null, !3702, !51, !241, !54}
!3702 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 32)
!3703 = !DILocalVariable(name: "s_inc", arg: 1, scope: !3699, file: !57, line: 320, type: !3702)
!3704 = !DILocation(line: 0, scope: !3699)
!3705 = !DILocalVariable(name: "r", arg: 2, scope: !3699, file: !57, line: 320, type: !51)
!3706 = !DILocalVariable(name: "m", arg: 3, scope: !3699, file: !57, line: 320, type: !241)
!3707 = !DILocalVariable(name: "mlen", arg: 4, scope: !3699, file: !57, line: 320, type: !54)
!3708 = !DILocation(line: 324, column: 2, scope: !3699)
!3709 = !DILocation(line: 324, column: 9, scope: !3699)
!3710 = !DILocation(line: 324, column: 16, scope: !3699)
!3711 = !DILocation(line: 324, column: 14, scope: !3699)
!3712 = !DILocation(line: 324, column: 29, scope: !3699)
!3713 = !DILocation(line: 324, column: 26, scope: !3699)
!3714 = !DILocation(line: 325, column: 3, scope: !3715)
!3715 = distinct !DILexicalBlock(scope: !3716, file: !57, line: 325, column: 3)
!3716 = distinct !DILexicalBlock(scope: !3699, file: !57, line: 324, column: 32)
!3717 = !DILocation(line: 337, column: 2, scope: !3718)
!3718 = distinct !DILexicalBlock(scope: !3699, file: !57, line: 337, column: 2)
!3719 = !DILocation(line: 325, scope: !3715)
!3720 = !DILocalVariable(name: "i", scope: !3699, file: !57, line: 321, type: !54)
!3721 = !DILocation(line: 325, column: 33, scope: !3722)
!3722 = distinct !DILexicalBlock(scope: !3715, file: !57, line: 325, column: 3)
!3723 = !DILocation(line: 325, column: 23, scope: !3722)
!3724 = !DILocation(line: 325, column: 21, scope: !3722)
!3725 = !DILocation(line: 325, column: 17, scope: !3722)
!3726 = !DILocation(line: 328, column: 45, scope: !3727)
!3727 = distinct !DILexicalBlock(scope: !3722, file: !57, line: 325, column: 49)
!3728 = !DILocation(line: 328, column: 35, scope: !3727)
!3729 = !DILocation(line: 328, column: 60, scope: !3727)
!3730 = !DILocation(line: 328, column: 72, scope: !3727)
!3731 = !DILocation(line: 328, column: 70, scope: !3727)
!3732 = !DILocation(line: 328, column: 56, scope: !3727)
!3733 = !DILocation(line: 328, column: 50, scope: !3727)
!3734 = !DILocation(line: 328, column: 11, scope: !3727)
!3735 = !DILocation(line: 328, column: 23, scope: !3727)
!3736 = !DILocation(line: 328, column: 21, scope: !3727)
!3737 = !DILocation(line: 328, column: 26, scope: !3727)
!3738 = !DILocation(line: 328, column: 4, scope: !3727)
!3739 = !DILocation(line: 328, column: 32, scope: !3727)
!3740 = !DILocation(line: 325, column: 45, scope: !3722)
!3741 = !DILocation(line: 325, column: 3, scope: !3722)
!3742 = distinct !{!3742, !3714, !3743, !163}
!3743 = !DILocation(line: 329, column: 3, scope: !3715)
!3744 = !DILocation(line: 330, column: 24, scope: !3716)
!3745 = !DILocation(line: 330, column: 11, scope: !3716)
!3746 = !DILocation(line: 330, column: 8, scope: !3716)
!3747 = !DILocation(line: 331, column: 5, scope: !3716)
!3748 = !DILocation(line: 332, column: 3, scope: !3716)
!3749 = !DILocation(line: 332, column: 13, scope: !3716)
!3750 = !DILocation(line: 334, column: 3, scope: !3716)
!3751 = distinct !{!3751, !3708, !3752, !163}
!3752 = !DILocation(line: 335, column: 2, scope: !3699)
!3753 = !DILocation(line: 337, scope: !3718)
!3754 = !DILocation(line: 337, column: 16, scope: !3755)
!3755 = distinct !DILexicalBlock(scope: !3718, file: !57, line: 337, column: 2)
!3756 = !DILocation(line: 338, column: 44, scope: !3757)
!3757 = distinct !DILexicalBlock(scope: !3755, file: !57, line: 337, column: 29)
!3758 = !DILocation(line: 338, column: 34, scope: !3757)
!3759 = !DILocation(line: 338, column: 59, scope: !3757)
!3760 = !DILocation(line: 338, column: 71, scope: !3757)
!3761 = !DILocation(line: 338, column: 69, scope: !3757)
!3762 = !DILocation(line: 338, column: 55, scope: !3757)
!3763 = !DILocation(line: 338, column: 49, scope: !3757)
!3764 = !DILocation(line: 338, column: 10, scope: !3757)
!3765 = !DILocation(line: 338, column: 22, scope: !3757)
!3766 = !DILocation(line: 338, column: 20, scope: !3757)
!3767 = !DILocation(line: 338, column: 25, scope: !3757)
!3768 = !DILocation(line: 338, column: 3, scope: !3757)
!3769 = !DILocation(line: 338, column: 31, scope: !3757)
!3770 = !DILocation(line: 337, column: 25, scope: !3755)
!3771 = !DILocation(line: 337, column: 2, scope: !3755)
!3772 = distinct !{!3772, !3717, !3773, !163}
!3773 = !DILocation(line: 339, column: 2, scope: !3718)
!3774 = !DILocation(line: 340, column: 15, scope: !3699)
!3775 = !DILocation(line: 340, column: 2, scope: !3699)
!3776 = !DILocation(line: 340, column: 12, scope: !3699)
!3777 = !DILocation(line: 341, column: 1, scope: !3699)
!3778 = distinct !DISubprogram(name: "KeccakF1600_StatePermute", scope: !57, file: !57, line: 43, type: !3779, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !49, retainedNodes: !141)
!3779 = !DISubroutineType(types: !3780)
!3780 = !{null, !3702}
!3781 = !DILocalVariable(name: "state", arg: 1, scope: !3778, file: !57, line: 43, type: !3702)
!3782 = !DILocation(line: 0, scope: !3778)
!3783 = !DILocation(line: 60, column: 8, scope: !3778)
!3784 = !DILocalVariable(name: "Aba", scope: !3778, file: !57, line: 46, type: !11)
!3785 = !DILocation(line: 61, column: 8, scope: !3778)
!3786 = !DILocalVariable(name: "Abe", scope: !3778, file: !57, line: 46, type: !11)
!3787 = !DILocation(line: 62, column: 8, scope: !3778)
!3788 = !DILocalVariable(name: "Abi", scope: !3778, file: !57, line: 46, type: !11)
!3789 = !DILocation(line: 63, column: 8, scope: !3778)
!3790 = !DILocalVariable(name: "Abo", scope: !3778, file: !57, line: 46, type: !11)
!3791 = !DILocation(line: 64, column: 8, scope: !3778)
!3792 = !DILocalVariable(name: "Abu", scope: !3778, file: !57, line: 46, type: !11)
!3793 = !DILocation(line: 65, column: 8, scope: !3778)
!3794 = !DILocalVariable(name: "Aga", scope: !3778, file: !57, line: 47, type: !11)
!3795 = !DILocation(line: 66, column: 8, scope: !3778)
!3796 = !DILocalVariable(name: "Age", scope: !3778, file: !57, line: 47, type: !11)
!3797 = !DILocation(line: 67, column: 8, scope: !3778)
!3798 = !DILocalVariable(name: "Agi", scope: !3778, file: !57, line: 47, type: !11)
!3799 = !DILocation(line: 68, column: 8, scope: !3778)
!3800 = !DILocalVariable(name: "Ago", scope: !3778, file: !57, line: 47, type: !11)
!3801 = !DILocation(line: 69, column: 8, scope: !3778)
!3802 = !DILocalVariable(name: "Agu", scope: !3778, file: !57, line: 47, type: !11)
!3803 = !DILocation(line: 70, column: 8, scope: !3778)
!3804 = !DILocalVariable(name: "Aka", scope: !3778, file: !57, line: 48, type: !11)
!3805 = !DILocation(line: 71, column: 8, scope: !3778)
!3806 = !DILocalVariable(name: "Ake", scope: !3778, file: !57, line: 48, type: !11)
!3807 = !DILocation(line: 72, column: 8, scope: !3778)
!3808 = !DILocalVariable(name: "Aki", scope: !3778, file: !57, line: 48, type: !11)
!3809 = !DILocation(line: 73, column: 8, scope: !3778)
!3810 = !DILocalVariable(name: "Ako", scope: !3778, file: !57, line: 48, type: !11)
!3811 = !DILocation(line: 74, column: 8, scope: !3778)
!3812 = !DILocalVariable(name: "Aku", scope: !3778, file: !57, line: 48, type: !11)
!3813 = !DILocation(line: 75, column: 8, scope: !3778)
!3814 = !DILocalVariable(name: "Ama", scope: !3778, file: !57, line: 49, type: !11)
!3815 = !DILocation(line: 76, column: 8, scope: !3778)
!3816 = !DILocalVariable(name: "Ame", scope: !3778, file: !57, line: 49, type: !11)
!3817 = !DILocation(line: 77, column: 8, scope: !3778)
!3818 = !DILocalVariable(name: "Ami", scope: !3778, file: !57, line: 49, type: !11)
!3819 = !DILocation(line: 78, column: 8, scope: !3778)
!3820 = !DILocalVariable(name: "Amo", scope: !3778, file: !57, line: 49, type: !11)
!3821 = !DILocation(line: 79, column: 8, scope: !3778)
!3822 = !DILocalVariable(name: "Amu", scope: !3778, file: !57, line: 49, type: !11)
!3823 = !DILocation(line: 80, column: 8, scope: !3778)
!3824 = !DILocalVariable(name: "Asa", scope: !3778, file: !57, line: 50, type: !11)
!3825 = !DILocation(line: 81, column: 8, scope: !3778)
!3826 = !DILocalVariable(name: "Ase", scope: !3778, file: !57, line: 50, type: !11)
!3827 = !DILocation(line: 82, column: 8, scope: !3778)
!3828 = !DILocalVariable(name: "Asi", scope: !3778, file: !57, line: 50, type: !11)
!3829 = !DILocation(line: 83, column: 8, scope: !3778)
!3830 = !DILocalVariable(name: "Aso", scope: !3778, file: !57, line: 50, type: !11)
!3831 = !DILocation(line: 84, column: 8, scope: !3778)
!3832 = !DILocalVariable(name: "Asu", scope: !3778, file: !57, line: 50, type: !11)
!3833 = !DILocalVariable(name: "round", scope: !3778, file: !57, line: 44, type: !39)
!3834 = !DILocation(line: 86, column: 7, scope: !3835)
!3835 = distinct !DILexicalBlock(scope: !3778, file: !57, line: 86, column: 2)
!3836 = !DILocation(line: 86, scope: !3835)
!3837 = !DILocation(line: 86, column: 24, scope: !3838)
!3838 = distinct !DILexicalBlock(scope: !3835, file: !57, line: 86, column: 2)
!3839 = !DILocation(line: 86, column: 2, scope: !3835)
!3840 = !DILocalVariable(name: "BCa", scope: !3778, file: !57, line: 51, type: !11)
!3841 = !DILocalVariable(name: "BCe", scope: !3778, file: !57, line: 51, type: !11)
!3842 = !DILocalVariable(name: "BCi", scope: !3778, file: !57, line: 51, type: !11)
!3843 = !DILocalVariable(name: "BCo", scope: !3778, file: !57, line: 51, type: !11)
!3844 = !DILocalVariable(name: "BCu", scope: !3778, file: !57, line: 51, type: !11)
!3845 = !DILocalVariable(name: "Da", scope: !3778, file: !57, line: 52, type: !11)
!3846 = !DILocalVariable(name: "De", scope: !3778, file: !57, line: 52, type: !11)
!3847 = !DILocalVariable(name: "Di", scope: !3778, file: !57, line: 52, type: !11)
!3848 = !DILocalVariable(name: "Do", scope: !3778, file: !57, line: 52, type: !11)
!3849 = !DILocalVariable(name: "Du", scope: !3778, file: !57, line: 52, type: !11)
!3850 = !DILocalVariable(name: "Eba", scope: !3778, file: !57, line: 53, type: !11)
!3851 = !DILocalVariable(name: "Ebe", scope: !3778, file: !57, line: 53, type: !11)
!3852 = !DILocalVariable(name: "Ebi", scope: !3778, file: !57, line: 53, type: !11)
!3853 = !DILocalVariable(name: "Ebo", scope: !3778, file: !57, line: 53, type: !11)
!3854 = !DILocalVariable(name: "Ebu", scope: !3778, file: !57, line: 53, type: !11)
!3855 = !DILocalVariable(name: "Ega", scope: !3778, file: !57, line: 54, type: !11)
!3856 = !DILocalVariable(name: "Ege", scope: !3778, file: !57, line: 54, type: !11)
!3857 = !DILocalVariable(name: "Egi", scope: !3778, file: !57, line: 54, type: !11)
!3858 = !DILocalVariable(name: "Ego", scope: !3778, file: !57, line: 54, type: !11)
!3859 = !DILocalVariable(name: "Egu", scope: !3778, file: !57, line: 54, type: !11)
!3860 = !DILocalVariable(name: "Eka", scope: !3778, file: !57, line: 55, type: !11)
!3861 = !DILocalVariable(name: "Eke", scope: !3778, file: !57, line: 55, type: !11)
!3862 = !DILocalVariable(name: "Eki", scope: !3778, file: !57, line: 55, type: !11)
!3863 = !DILocalVariable(name: "Eko", scope: !3778, file: !57, line: 55, type: !11)
!3864 = !DILocalVariable(name: "Eku", scope: !3778, file: !57, line: 55, type: !11)
!3865 = !DILocalVariable(name: "Ema", scope: !3778, file: !57, line: 56, type: !11)
!3866 = !DILocalVariable(name: "Eme", scope: !3778, file: !57, line: 56, type: !11)
!3867 = !DILocalVariable(name: "Emi", scope: !3778, file: !57, line: 56, type: !11)
!3868 = !DILocalVariable(name: "Emo", scope: !3778, file: !57, line: 56, type: !11)
!3869 = !DILocalVariable(name: "Emu", scope: !3778, file: !57, line: 56, type: !11)
!3870 = !DILocalVariable(name: "Esa", scope: !3778, file: !57, line: 57, type: !11)
!3871 = !DILocalVariable(name: "Ese", scope: !3778, file: !57, line: 57, type: !11)
!3872 = !DILocalVariable(name: "Esi", scope: !3778, file: !57, line: 57, type: !11)
!3873 = !DILocalVariable(name: "Eso", scope: !3778, file: !57, line: 57, type: !11)
!3874 = !DILocalVariable(name: "Esu", scope: !3778, file: !57, line: 57, type: !11)
!3875 = !DILocation(line: 90, column: 13, scope: !3876)
!3876 = distinct !DILexicalBlock(scope: !3838, file: !57, line: 86, column: 47)
!3877 = !DILocation(line: 90, column: 19, scope: !3876)
!3878 = !DILocation(line: 90, column: 25, scope: !3876)
!3879 = !DILocation(line: 90, column: 31, scope: !3876)
!3880 = !DILocation(line: 92, column: 13, scope: !3876)
!3881 = !DILocation(line: 92, column: 19, scope: !3876)
!3882 = !DILocation(line: 92, column: 25, scope: !3876)
!3883 = !DILocation(line: 92, column: 31, scope: !3876)
!3884 = !DILocation(line: 98, column: 14, scope: !3876)
!3885 = !DILocation(line: 98, column: 12, scope: !3876)
!3886 = !DILocation(line: 168, column: 7, scope: !3876)
!3887 = !DILocation(line: 169, column: 9, scope: !3876)
!3888 = !DILocation(line: 89, column: 13, scope: !3876)
!3889 = !DILocation(line: 89, column: 19, scope: !3876)
!3890 = !DILocation(line: 89, column: 25, scope: !3876)
!3891 = !DILocation(line: 89, column: 31, scope: !3876)
!3892 = !DILocation(line: 95, column: 14, scope: !3876)
!3893 = !DILocation(line: 95, column: 12, scope: !3876)
!3894 = !DILocation(line: 172, column: 7, scope: !3876)
!3895 = !DILocation(line: 173, column: 9, scope: !3876)
!3896 = !DILocation(line: 91, column: 13, scope: !3876)
!3897 = !DILocation(line: 91, column: 19, scope: !3876)
!3898 = !DILocation(line: 91, column: 25, scope: !3876)
!3899 = !DILocation(line: 91, column: 31, scope: !3876)
!3900 = !DILocation(line: 88, column: 13, scope: !3876)
!3901 = !DILocation(line: 88, column: 19, scope: !3876)
!3902 = !DILocation(line: 88, column: 25, scope: !3876)
!3903 = !DILocation(line: 88, column: 31, scope: !3876)
!3904 = !DILocation(line: 99, column: 14, scope: !3876)
!3905 = !DILocation(line: 99, column: 12, scope: !3876)
!3906 = !DILocation(line: 170, column: 7, scope: !3876)
!3907 = !DILocation(line: 171, column: 9, scope: !3876)
!3908 = !DILocation(line: 177, column: 17, scope: !3876)
!3909 = !DILocation(line: 177, column: 23, scope: !3876)
!3910 = !DILocation(line: 177, column: 13, scope: !3876)
!3911 = !DILocation(line: 97, column: 14, scope: !3876)
!3912 = !DILocation(line: 97, column: 12, scope: !3876)
!3913 = !DILocation(line: 105, column: 7, scope: !3876)
!3914 = !DILocation(line: 106, column: 9, scope: !3876)
!3915 = !DILocation(line: 96, column: 14, scope: !3876)
!3916 = !DILocation(line: 96, column: 12, scope: !3876)
!3917 = !DILocation(line: 103, column: 7, scope: !3876)
!3918 = !DILocation(line: 104, column: 9, scope: !3876)
!3919 = !DILocation(line: 111, column: 17, scope: !3876)
!3920 = !DILocation(line: 111, column: 23, scope: !3876)
!3921 = !DILocation(line: 112, column: 10, scope: !3876)
!3922 = !DILocation(line: 112, column: 7, scope: !3876)
!3923 = !DILocation(line: 101, column: 7, scope: !3876)
!3924 = !DILocation(line: 118, column: 7, scope: !3876)
!3925 = !DILocation(line: 119, column: 9, scope: !3876)
!3926 = !DILocation(line: 122, column: 7, scope: !3876)
!3927 = !DILocation(line: 123, column: 9, scope: !3876)
!3928 = !DILocation(line: 120, column: 7, scope: !3876)
!3929 = !DILocation(line: 121, column: 9, scope: !3876)
!3930 = !DILocation(line: 128, column: 17, scope: !3876)
!3931 = !DILocation(line: 128, column: 23, scope: !3876)
!3932 = !DILocation(line: 128, column: 13, scope: !3876)
!3933 = !DILocation(line: 183, column: 13, scope: !3876)
!3934 = !DILocation(line: 134, column: 7, scope: !3876)
!3935 = !DILocation(line: 135, column: 9, scope: !3876)
!3936 = !DILocation(line: 138, column: 7, scope: !3876)
!3937 = !DILocation(line: 139, column: 9, scope: !3876)
!3938 = !DILocation(line: 136, column: 7, scope: !3876)
!3939 = !DILocation(line: 137, column: 9, scope: !3876)
!3940 = !DILocation(line: 144, column: 17, scope: !3876)
!3941 = !DILocation(line: 144, column: 23, scope: !3876)
!3942 = !DILocation(line: 144, column: 13, scope: !3876)
!3943 = !DILocation(line: 183, column: 19, scope: !3876)
!3944 = !DILocation(line: 150, column: 7, scope: !3876)
!3945 = !DILocation(line: 151, column: 9, scope: !3876)
!3946 = !DILocation(line: 154, column: 7, scope: !3876)
!3947 = !DILocation(line: 155, column: 9, scope: !3876)
!3948 = !DILocation(line: 152, column: 7, scope: !3876)
!3949 = !DILocation(line: 153, column: 9, scope: !3876)
!3950 = !DILocation(line: 160, column: 17, scope: !3876)
!3951 = !DILocation(line: 160, column: 23, scope: !3876)
!3952 = !DILocation(line: 160, column: 13, scope: !3876)
!3953 = !DILocation(line: 183, column: 25, scope: !3876)
!3954 = !DILocation(line: 166, column: 7, scope: !3876)
!3955 = !DILocation(line: 167, column: 9, scope: !3876)
!3956 = !DILocation(line: 176, column: 17, scope: !3876)
!3957 = !DILocation(line: 176, column: 23, scope: !3876)
!3958 = !DILocation(line: 176, column: 13, scope: !3876)
!3959 = !DILocation(line: 183, column: 31, scope: !3876)
!3960 = !DILocation(line: 109, column: 7, scope: !3876)
!3961 = !DILocation(line: 110, column: 9, scope: !3876)
!3962 = !DILocation(line: 107, column: 7, scope: !3876)
!3963 = !DILocation(line: 108, column: 9, scope: !3876)
!3964 = !DILocation(line: 114, column: 17, scope: !3876)
!3965 = !DILocation(line: 114, column: 23, scope: !3876)
!3966 = !DILocation(line: 114, column: 13, scope: !3876)
!3967 = !DILocation(line: 126, column: 7, scope: !3876)
!3968 = !DILocation(line: 127, column: 9, scope: !3876)
!3969 = !DILocation(line: 124, column: 7, scope: !3876)
!3970 = !DILocation(line: 125, column: 9, scope: !3876)
!3971 = !DILocation(line: 130, column: 17, scope: !3876)
!3972 = !DILocation(line: 130, column: 23, scope: !3876)
!3973 = !DILocation(line: 130, column: 13, scope: !3876)
!3974 = !DILocation(line: 185, column: 13, scope: !3876)
!3975 = !DILocation(line: 142, column: 7, scope: !3876)
!3976 = !DILocation(line: 143, column: 9, scope: !3876)
!3977 = !DILocation(line: 140, column: 7, scope: !3876)
!3978 = !DILocation(line: 141, column: 9, scope: !3876)
!3979 = !DILocation(line: 146, column: 17, scope: !3876)
!3980 = !DILocation(line: 146, column: 23, scope: !3876)
!3981 = !DILocation(line: 146, column: 13, scope: !3876)
!3982 = !DILocation(line: 185, column: 19, scope: !3876)
!3983 = !DILocation(line: 158, column: 7, scope: !3876)
!3984 = !DILocation(line: 159, column: 9, scope: !3876)
!3985 = !DILocation(line: 156, column: 7, scope: !3876)
!3986 = !DILocation(line: 157, column: 9, scope: !3876)
!3987 = !DILocation(line: 162, column: 17, scope: !3876)
!3988 = !DILocation(line: 162, column: 23, scope: !3876)
!3989 = !DILocation(line: 162, column: 13, scope: !3876)
!3990 = !DILocation(line: 185, column: 25, scope: !3876)
!3991 = !DILocation(line: 174, column: 7, scope: !3876)
!3992 = !DILocation(line: 175, column: 9, scope: !3876)
!3993 = !DILocation(line: 178, column: 17, scope: !3876)
!3994 = !DILocation(line: 178, column: 23, scope: !3876)
!3995 = !DILocation(line: 178, column: 13, scope: !3876)
!3996 = !DILocation(line: 185, column: 31, scope: !3876)
!3997 = !DILocation(line: 191, column: 14, scope: !3876)
!3998 = !DILocation(line: 191, column: 12, scope: !3876)
!3999 = !DILocation(line: 269, column: 7, scope: !3876)
!4000 = !DILocation(line: 270, column: 9, scope: !3876)
!4001 = !DILocation(line: 131, column: 17, scope: !3876)
!4002 = !DILocation(line: 131, column: 23, scope: !3876)
!4003 = !DILocation(line: 131, column: 13, scope: !3876)
!4004 = !DILocation(line: 116, column: 17, scope: !3876)
!4005 = !DILocation(line: 116, column: 23, scope: !3876)
!4006 = !DILocation(line: 116, column: 13, scope: !3876)
!4007 = !DILocation(line: 132, column: 17, scope: !3876)
!4008 = !DILocation(line: 132, column: 23, scope: !3876)
!4009 = !DILocation(line: 132, column: 13, scope: !3876)
!4010 = !DILocation(line: 187, column: 13, scope: !3876)
!4011 = !DILocation(line: 148, column: 17, scope: !3876)
!4012 = !DILocation(line: 148, column: 23, scope: !3876)
!4013 = !DILocation(line: 148, column: 13, scope: !3876)
!4014 = !DILocation(line: 187, column: 19, scope: !3876)
!4015 = !DILocation(line: 164, column: 17, scope: !3876)
!4016 = !DILocation(line: 164, column: 23, scope: !3876)
!4017 = !DILocation(line: 164, column: 13, scope: !3876)
!4018 = !DILocation(line: 187, column: 25, scope: !3876)
!4019 = !DILocation(line: 180, column: 17, scope: !3876)
!4020 = !DILocation(line: 180, column: 23, scope: !3876)
!4021 = !DILocation(line: 180, column: 13, scope: !3876)
!4022 = !DILocation(line: 187, column: 31, scope: !3876)
!4023 = !DILocation(line: 193, column: 14, scope: !3876)
!4024 = !DILocation(line: 193, column: 12, scope: !3876)
!4025 = !DILocation(line: 263, column: 7, scope: !3876)
!4026 = !DILocation(line: 264, column: 9, scope: !3876)
!4027 = !DILocation(line: 113, column: 17, scope: !3876)
!4028 = !DILocation(line: 113, column: 23, scope: !3876)
!4029 = !DILocation(line: 113, column: 13, scope: !3876)
!4030 = !DILocation(line: 129, column: 17, scope: !3876)
!4031 = !DILocation(line: 129, column: 23, scope: !3876)
!4032 = !DILocation(line: 129, column: 13, scope: !3876)
!4033 = !DILocation(line: 184, column: 13, scope: !3876)
!4034 = !DILocation(line: 145, column: 17, scope: !3876)
!4035 = !DILocation(line: 145, column: 23, scope: !3876)
!4036 = !DILocation(line: 145, column: 13, scope: !3876)
!4037 = !DILocation(line: 184, column: 19, scope: !3876)
!4038 = !DILocation(line: 161, column: 17, scope: !3876)
!4039 = !DILocation(line: 161, column: 23, scope: !3876)
!4040 = !DILocation(line: 161, column: 13, scope: !3876)
!4041 = !DILocation(line: 184, column: 25, scope: !3876)
!4042 = !DILocation(line: 184, column: 31, scope: !3876)
!4043 = !DILocation(line: 115, column: 17, scope: !3876)
!4044 = !DILocation(line: 115, column: 23, scope: !3876)
!4045 = !DILocation(line: 115, column: 13, scope: !3876)
!4046 = !DILocation(line: 186, column: 13, scope: !3876)
!4047 = !DILocation(line: 147, column: 17, scope: !3876)
!4048 = !DILocation(line: 147, column: 23, scope: !3876)
!4049 = !DILocation(line: 147, column: 13, scope: !3876)
!4050 = !DILocation(line: 186, column: 19, scope: !3876)
!4051 = !DILocation(line: 163, column: 17, scope: !3876)
!4052 = !DILocation(line: 163, column: 23, scope: !3876)
!4053 = !DILocation(line: 163, column: 13, scope: !3876)
!4054 = !DILocation(line: 186, column: 25, scope: !3876)
!4055 = !DILocation(line: 179, column: 17, scope: !3876)
!4056 = !DILocation(line: 179, column: 23, scope: !3876)
!4057 = !DILocation(line: 179, column: 13, scope: !3876)
!4058 = !DILocation(line: 186, column: 31, scope: !3876)
!4059 = !DILocation(line: 192, column: 14, scope: !3876)
!4060 = !DILocation(line: 192, column: 12, scope: !3876)
!4061 = !DILocation(line: 261, column: 7, scope: !3876)
!4062 = !DILocation(line: 262, column: 9, scope: !3876)
!4063 = !DILocation(line: 275, column: 17, scope: !3876)
!4064 = !DILocation(line: 275, column: 23, scope: !3876)
!4065 = !DILocation(line: 275, column: 13, scope: !3876)
!4066 = !DILocation(line: 190, column: 14, scope: !3876)
!4067 = !DILocation(line: 190, column: 12, scope: !3876)
!4068 = !DILocation(line: 267, column: 7, scope: !3876)
!4069 = !DILocation(line: 268, column: 9, scope: !3876)
!4070 = !DILocation(line: 274, column: 17, scope: !3876)
!4071 = !DILocation(line: 274, column: 23, scope: !3876)
!4072 = !DILocation(line: 274, column: 13, scope: !3876)
!4073 = !DILocation(line: 194, column: 14, scope: !3876)
!4074 = !DILocation(line: 194, column: 12, scope: !3876)
!4075 = !DILocation(line: 265, column: 7, scope: !3876)
!4076 = !DILocation(line: 266, column: 9, scope: !3876)
!4077 = !DILocation(line: 273, column: 17, scope: !3876)
!4078 = !DILocation(line: 273, column: 23, scope: !3876)
!4079 = !DILocation(line: 273, column: 13, scope: !3876)
!4080 = !DILocation(line: 272, column: 17, scope: !3876)
!4081 = !DILocation(line: 272, column: 23, scope: !3876)
!4082 = !DILocation(line: 272, column: 13, scope: !3876)
!4083 = !DILocation(line: 271, column: 17, scope: !3876)
!4084 = !DILocation(line: 271, column: 23, scope: !3876)
!4085 = !DILocation(line: 271, column: 13, scope: !3876)
!4086 = !DILocation(line: 253, column: 7, scope: !3876)
!4087 = !DILocation(line: 254, column: 9, scope: !3876)
!4088 = !DILocation(line: 247, column: 7, scope: !3876)
!4089 = !DILocation(line: 248, column: 9, scope: !3876)
!4090 = !DILocation(line: 245, column: 7, scope: !3876)
!4091 = !DILocation(line: 246, column: 9, scope: !3876)
!4092 = !DILocation(line: 259, column: 17, scope: !3876)
!4093 = !DILocation(line: 259, column: 23, scope: !3876)
!4094 = !DILocation(line: 259, column: 13, scope: !3876)
!4095 = !DILocation(line: 251, column: 7, scope: !3876)
!4096 = !DILocation(line: 252, column: 9, scope: !3876)
!4097 = !DILocation(line: 258, column: 17, scope: !3876)
!4098 = !DILocation(line: 258, column: 23, scope: !3876)
!4099 = !DILocation(line: 258, column: 13, scope: !3876)
!4100 = !DILocation(line: 249, column: 7, scope: !3876)
!4101 = !DILocation(line: 250, column: 9, scope: !3876)
!4102 = !DILocation(line: 257, column: 17, scope: !3876)
!4103 = !DILocation(line: 257, column: 23, scope: !3876)
!4104 = !DILocation(line: 257, column: 13, scope: !3876)
!4105 = !DILocation(line: 256, column: 17, scope: !3876)
!4106 = !DILocation(line: 256, column: 23, scope: !3876)
!4107 = !DILocation(line: 256, column: 13, scope: !3876)
!4108 = !DILocation(line: 255, column: 17, scope: !3876)
!4109 = !DILocation(line: 255, column: 23, scope: !3876)
!4110 = !DILocation(line: 255, column: 13, scope: !3876)
!4111 = !DILocation(line: 237, column: 7, scope: !3876)
!4112 = !DILocation(line: 238, column: 9, scope: !3876)
!4113 = !DILocation(line: 231, column: 7, scope: !3876)
!4114 = !DILocation(line: 232, column: 9, scope: !3876)
!4115 = !DILocation(line: 229, column: 7, scope: !3876)
!4116 = !DILocation(line: 230, column: 9, scope: !3876)
!4117 = !DILocation(line: 243, column: 17, scope: !3876)
!4118 = !DILocation(line: 243, column: 23, scope: !3876)
!4119 = !DILocation(line: 243, column: 13, scope: !3876)
!4120 = !DILocation(line: 235, column: 7, scope: !3876)
!4121 = !DILocation(line: 236, column: 9, scope: !3876)
!4122 = !DILocation(line: 242, column: 17, scope: !3876)
!4123 = !DILocation(line: 242, column: 23, scope: !3876)
!4124 = !DILocation(line: 242, column: 13, scope: !3876)
!4125 = !DILocation(line: 233, column: 7, scope: !3876)
!4126 = !DILocation(line: 234, column: 9, scope: !3876)
!4127 = !DILocation(line: 241, column: 17, scope: !3876)
!4128 = !DILocation(line: 241, column: 23, scope: !3876)
!4129 = !DILocation(line: 241, column: 13, scope: !3876)
!4130 = !DILocation(line: 240, column: 17, scope: !3876)
!4131 = !DILocation(line: 240, column: 23, scope: !3876)
!4132 = !DILocation(line: 240, column: 13, scope: !3876)
!4133 = !DILocation(line: 239, column: 17, scope: !3876)
!4134 = !DILocation(line: 239, column: 23, scope: !3876)
!4135 = !DILocation(line: 239, column: 13, scope: !3876)
!4136 = !DILocation(line: 221, column: 7, scope: !3876)
!4137 = !DILocation(line: 222, column: 9, scope: !3876)
!4138 = !DILocation(line: 215, column: 7, scope: !3876)
!4139 = !DILocation(line: 216, column: 9, scope: !3876)
!4140 = !DILocation(line: 213, column: 7, scope: !3876)
!4141 = !DILocation(line: 214, column: 9, scope: !3876)
!4142 = !DILocation(line: 227, column: 17, scope: !3876)
!4143 = !DILocation(line: 227, column: 23, scope: !3876)
!4144 = !DILocation(line: 227, column: 13, scope: !3876)
!4145 = !DILocation(line: 219, column: 7, scope: !3876)
!4146 = !DILocation(line: 220, column: 9, scope: !3876)
!4147 = !DILocation(line: 226, column: 17, scope: !3876)
!4148 = !DILocation(line: 226, column: 23, scope: !3876)
!4149 = !DILocation(line: 226, column: 13, scope: !3876)
!4150 = !DILocation(line: 217, column: 7, scope: !3876)
!4151 = !DILocation(line: 218, column: 9, scope: !3876)
!4152 = !DILocation(line: 225, column: 17, scope: !3876)
!4153 = !DILocation(line: 225, column: 23, scope: !3876)
!4154 = !DILocation(line: 225, column: 13, scope: !3876)
!4155 = !DILocation(line: 224, column: 17, scope: !3876)
!4156 = !DILocation(line: 224, column: 23, scope: !3876)
!4157 = !DILocation(line: 224, column: 13, scope: !3876)
!4158 = !DILocation(line: 223, column: 17, scope: !3876)
!4159 = !DILocation(line: 223, column: 23, scope: !3876)
!4160 = !DILocation(line: 223, column: 13, scope: !3876)
!4161 = !DILocation(line: 204, column: 7, scope: !3876)
!4162 = !DILocation(line: 205, column: 9, scope: !3876)
!4163 = !DILocation(line: 198, column: 7, scope: !3876)
!4164 = !DILocation(line: 199, column: 9, scope: !3876)
!4165 = !DILocation(line: 196, column: 7, scope: !3876)
!4166 = !DILocation(line: 211, column: 17, scope: !3876)
!4167 = !DILocation(line: 211, column: 23, scope: !3876)
!4168 = !DILocation(line: 211, column: 13, scope: !3876)
!4169 = !DILocation(line: 202, column: 7, scope: !3876)
!4170 = !DILocation(line: 203, column: 9, scope: !3876)
!4171 = !DILocation(line: 210, column: 17, scope: !3876)
!4172 = !DILocation(line: 210, column: 23, scope: !3876)
!4173 = !DILocation(line: 210, column: 13, scope: !3876)
!4174 = !DILocation(line: 200, column: 7, scope: !3876)
!4175 = !DILocation(line: 201, column: 9, scope: !3876)
!4176 = !DILocation(line: 209, column: 17, scope: !3876)
!4177 = !DILocation(line: 209, column: 23, scope: !3876)
!4178 = !DILocation(line: 209, column: 13, scope: !3876)
!4179 = !DILocation(line: 208, column: 17, scope: !3876)
!4180 = !DILocation(line: 208, column: 23, scope: !3876)
!4181 = !DILocation(line: 208, column: 13, scope: !3876)
!4182 = !DILocation(line: 207, column: 39, scope: !3876)
!4183 = !DILocation(line: 207, column: 10, scope: !3876)
!4184 = !DILocation(line: 206, column: 17, scope: !3876)
!4185 = !DILocation(line: 206, column: 23, scope: !3876)
!4186 = !DILocation(line: 207, column: 7, scope: !3876)
!4187 = !DILocation(line: 86, column: 41, scope: !3838)
!4188 = !DILocation(line: 86, column: 2, scope: !3838)
!4189 = distinct !{!4189, !3839, !4190, !163}
!4190 = !DILocation(line: 276, column: 2, scope: !3835)
!4191 = !DILocation(line: 279, column: 11, scope: !3778)
!4192 = !DILocation(line: 280, column: 2, scope: !3778)
!4193 = !DILocation(line: 280, column: 11, scope: !3778)
!4194 = !DILocation(line: 281, column: 2, scope: !3778)
!4195 = !DILocation(line: 281, column: 11, scope: !3778)
!4196 = !DILocation(line: 282, column: 2, scope: !3778)
!4197 = !DILocation(line: 282, column: 11, scope: !3778)
!4198 = !DILocation(line: 283, column: 2, scope: !3778)
!4199 = !DILocation(line: 283, column: 11, scope: !3778)
!4200 = !DILocation(line: 284, column: 2, scope: !3778)
!4201 = !DILocation(line: 284, column: 11, scope: !3778)
!4202 = !DILocation(line: 285, column: 2, scope: !3778)
!4203 = !DILocation(line: 285, column: 11, scope: !3778)
!4204 = !DILocation(line: 286, column: 2, scope: !3778)
!4205 = !DILocation(line: 286, column: 11, scope: !3778)
!4206 = !DILocation(line: 287, column: 2, scope: !3778)
!4207 = !DILocation(line: 287, column: 11, scope: !3778)
!4208 = !DILocation(line: 288, column: 2, scope: !3778)
!4209 = !DILocation(line: 288, column: 11, scope: !3778)
!4210 = !DILocation(line: 289, column: 2, scope: !3778)
!4211 = !DILocation(line: 289, column: 12, scope: !3778)
!4212 = !DILocation(line: 290, column: 2, scope: !3778)
!4213 = !DILocation(line: 290, column: 12, scope: !3778)
!4214 = !DILocation(line: 291, column: 2, scope: !3778)
!4215 = !DILocation(line: 291, column: 12, scope: !3778)
!4216 = !DILocation(line: 292, column: 2, scope: !3778)
!4217 = !DILocation(line: 292, column: 12, scope: !3778)
!4218 = !DILocation(line: 293, column: 2, scope: !3778)
!4219 = !DILocation(line: 293, column: 12, scope: !3778)
!4220 = !DILocation(line: 294, column: 2, scope: !3778)
!4221 = !DILocation(line: 294, column: 12, scope: !3778)
!4222 = !DILocation(line: 295, column: 2, scope: !3778)
!4223 = !DILocation(line: 295, column: 12, scope: !3778)
!4224 = !DILocation(line: 296, column: 2, scope: !3778)
!4225 = !DILocation(line: 296, column: 12, scope: !3778)
!4226 = !DILocation(line: 297, column: 2, scope: !3778)
!4227 = !DILocation(line: 297, column: 12, scope: !3778)
!4228 = !DILocation(line: 298, column: 2, scope: !3778)
!4229 = !DILocation(line: 298, column: 12, scope: !3778)
!4230 = !DILocation(line: 299, column: 2, scope: !3778)
!4231 = !DILocation(line: 299, column: 12, scope: !3778)
!4232 = !DILocation(line: 300, column: 2, scope: !3778)
!4233 = !DILocation(line: 300, column: 12, scope: !3778)
!4234 = !DILocation(line: 301, column: 2, scope: !3778)
!4235 = !DILocation(line: 301, column: 12, scope: !3778)
!4236 = !DILocation(line: 302, column: 2, scope: !3778)
!4237 = !DILocation(line: 302, column: 12, scope: !3778)
!4238 = !DILocation(line: 303, column: 2, scope: !3778)
!4239 = !DILocation(line: 303, column: 12, scope: !3778)
!4240 = !DILocation(line: 304, column: 1, scope: !3778)
!4241 = distinct !DISubprogram(name: "shake_finalize", scope: !3660, file: !3660, line: 33, type: !3669, scopeLine: 33, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4242 = !DILocalVariable(name: "instance", arg: 1, scope: !4241, file: !3660, line: 33, type: !3671)
!4243 = !DILocation(line: 0, scope: !4241)
!4244 = !DILocation(line: 34, column: 39, scope: !4241)
!4245 = !DILocation(line: 34, column: 2, scope: !4241)
!4246 = !DILocation(line: 35, column: 1, scope: !4241)
!4247 = distinct !DISubprogram(name: "keccak_inc_finalize", scope: !57, file: !57, line: 356, type: !4248, scopeLine: 356, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4248 = !DISubroutineType(types: !4249)
!4249 = !{null, !3702, !51, !6}
!4250 = !DILocalVariable(name: "s_inc", arg: 1, scope: !4247, file: !57, line: 356, type: !3702)
!4251 = !DILocation(line: 0, scope: !4247)
!4252 = !DILocalVariable(name: "r", arg: 2, scope: !4247, file: !57, line: 356, type: !51)
!4253 = !DILocalVariable(name: "p", arg: 3, scope: !4247, file: !57, line: 356, type: !6)
!4254 = !DILocation(line: 359, column: 48, scope: !4247)
!4255 = !DILocation(line: 359, column: 45, scope: !4247)
!4256 = !DILocation(line: 359, column: 39, scope: !4247)
!4257 = !DILocation(line: 359, column: 18, scope: !4247)
!4258 = !DILocation(line: 359, column: 2, scope: !4247)
!4259 = !DILocation(line: 359, column: 24, scope: !4247)
!4260 = !DILocation(line: 360, column: 45, scope: !4247)
!4261 = !DILocation(line: 360, column: 39, scope: !4247)
!4262 = !DILocation(line: 360, column: 11, scope: !4247)
!4263 = !DILocation(line: 360, column: 16, scope: !4247)
!4264 = !DILocation(line: 360, column: 2, scope: !4247)
!4265 = !DILocation(line: 360, column: 22, scope: !4247)
!4266 = !DILocation(line: 361, column: 2, scope: !4247)
!4267 = !DILocation(line: 361, column: 12, scope: !4247)
!4268 = !DILocation(line: 362, column: 1, scope: !4247)
!4269 = distinct !DISubprogram(name: "shake_squeeze", scope: !3660, file: !3660, line: 37, type: !4270, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4270 = !DISubroutineType(types: !4271)
!4271 = !{null, !5, !54, !3671}
!4272 = !DILocalVariable(name: "out", arg: 1, scope: !4269, file: !3660, line: 37, type: !5)
!4273 = !DILocation(line: 0, scope: !4269)
!4274 = !DILocalVariable(name: "outlen", arg: 2, scope: !4269, file: !3660, line: 37, type: !54)
!4275 = !DILocalVariable(name: "instance", arg: 3, scope: !4269, file: !3660, line: 37, type: !3671)
!4276 = !DILocation(line: 38, column: 51, scope: !4269)
!4277 = !DILocation(line: 38, column: 2, scope: !4269)
!4278 = !DILocation(line: 39, column: 1, scope: !4269)
!4279 = distinct !DISubprogram(name: "keccak_inc_squeeze", scope: !57, file: !57, line: 377, type: !4280, scopeLine: 377, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4280 = !DISubroutineType(types: !4281)
!4281 = !{null, !5, !54, !3702, !51}
!4282 = !DILocalVariable(name: "h", arg: 1, scope: !4279, file: !57, line: 377, type: !5)
!4283 = !DILocation(line: 0, scope: !4279)
!4284 = !DILocalVariable(name: "outlen", arg: 2, scope: !4279, file: !57, line: 377, type: !54)
!4285 = !DILocalVariable(name: "s_inc", arg: 3, scope: !4279, file: !57, line: 377, type: !3702)
!4286 = !DILocalVariable(name: "r", arg: 4, scope: !4279, file: !57, line: 377, type: !51)
!4287 = !DILocalVariable(name: "i", scope: !4279, file: !57, line: 378, type: !54)
!4288 = !DILocation(line: 381, column: 7, scope: !4289)
!4289 = distinct !DILexicalBlock(scope: !4279, file: !57, line: 381, column: 2)
!4290 = !DILocation(line: 381, scope: !4289)
!4291 = !DILocation(line: 381, column: 16, scope: !4292)
!4292 = distinct !DILexicalBlock(scope: !4289, file: !57, line: 381, column: 2)
!4293 = !DILocation(line: 381, column: 25, scope: !4292)
!4294 = !DILocation(line: 381, column: 28, scope: !4292)
!4295 = !DILocation(line: 381, column: 32, scope: !4292)
!4296 = !DILocation(line: 381, column: 30, scope: !4292)
!4297 = !DILocation(line: 381, column: 2, scope: !4289)
!4298 = !DILocation(line: 384, column: 27, scope: !4299)
!4299 = distinct !DILexicalBlock(scope: !4292, file: !57, line: 381, column: 48)
!4300 = !DILocation(line: 384, column: 31, scope: !4299)
!4301 = !DILocation(line: 384, column: 29, scope: !4299)
!4302 = !DILocation(line: 384, column: 43, scope: !4299)
!4303 = !DILocation(line: 384, column: 41, scope: !4299)
!4304 = !DILocation(line: 384, column: 46, scope: !4299)
!4305 = !DILocation(line: 384, column: 20, scope: !4299)
!4306 = !DILocation(line: 384, column: 62, scope: !4299)
!4307 = !DILocation(line: 384, column: 66, scope: !4299)
!4308 = !DILocation(line: 384, column: 64, scope: !4299)
!4309 = !DILocation(line: 384, column: 78, scope: !4299)
!4310 = !DILocation(line: 384, column: 76, scope: !4299)
!4311 = !DILocation(line: 384, column: 58, scope: !4299)
!4312 = !DILocation(line: 384, column: 52, scope: !4299)
!4313 = !DILocation(line: 384, column: 10, scope: !4299)
!4314 = !DILocation(line: 384, column: 3, scope: !4299)
!4315 = !DILocation(line: 384, column: 8, scope: !4299)
!4316 = !DILocation(line: 381, column: 44, scope: !4292)
!4317 = !DILocation(line: 381, column: 2, scope: !4292)
!4318 = distinct !{!4318, !4297, !4319, !163}
!4319 = !DILocation(line: 385, column: 2, scope: !4289)
!4320 = !DILocation(line: 386, column: 4, scope: !4279)
!4321 = !DILocation(line: 387, column: 9, scope: !4279)
!4322 = !DILocation(line: 388, column: 15, scope: !4279)
!4323 = !DILocation(line: 388, column: 2, scope: !4279)
!4324 = !DILocation(line: 388, column: 12, scope: !4279)
!4325 = !DILocation(line: 391, column: 2, scope: !4279)
!4326 = !DILocation(line: 391, column: 16, scope: !4279)
!4327 = !DILocation(line: 392, column: 3, scope: !4328)
!4328 = distinct !DILexicalBlock(scope: !4279, file: !57, line: 391, column: 21)
!4329 = !DILocation(line: 394, column: 8, scope: !4330)
!4330 = distinct !DILexicalBlock(scope: !4328, file: !57, line: 394, column: 3)
!4331 = !DILocation(line: 394, scope: !4330)
!4332 = !DILocation(line: 394, column: 26, scope: !4333)
!4333 = distinct !DILexicalBlock(scope: !4330, file: !57, line: 394, column: 3)
!4334 = !DILocation(line: 394, column: 3, scope: !4330)
!4335 = !DILocation(line: 395, column: 29, scope: !4336)
!4336 = distinct !DILexicalBlock(scope: !4333, file: !57, line: 394, column: 41)
!4337 = !DILocation(line: 395, column: 21, scope: !4336)
!4338 = !DILocation(line: 395, column: 41, scope: !4336)
!4339 = !DILocation(line: 395, column: 35, scope: !4336)
!4340 = !DILocation(line: 395, column: 11, scope: !4336)
!4341 = !DILocation(line: 395, column: 4, scope: !4336)
!4342 = !DILocation(line: 395, column: 9, scope: !4336)
!4343 = !DILocation(line: 394, column: 37, scope: !4333)
!4344 = !DILocation(line: 394, column: 3, scope: !4333)
!4345 = distinct !{!4345, !4334, !4346, !163}
!4346 = !DILocation(line: 396, column: 3, scope: !4330)
!4347 = !DILocation(line: 397, column: 5, scope: !4328)
!4348 = !DILocation(line: 398, column: 10, scope: !4328)
!4349 = !DILocation(line: 399, column: 17, scope: !4328)
!4350 = !DILocation(line: 399, column: 15, scope: !4328)
!4351 = !DILocation(line: 399, column: 3, scope: !4328)
!4352 = !DILocation(line: 399, column: 13, scope: !4328)
!4353 = distinct !{!4353, !4325, !4354, !163}
!4354 = !DILocation(line: 400, column: 2, scope: !4279)
!4355 = !DILocation(line: 401, column: 1, scope: !4279)
!4356 = distinct !DISubprogram(name: "shake256", scope: !3660, file: !3660, line: 41, type: !4357, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4357 = !DISubroutineType(types: !4358)
!4358 = !{null, !5, !54, !241, !54}
!4359 = !DILocalVariable(name: "out", arg: 1, scope: !4356, file: !3660, line: 41, type: !5)
!4360 = !DILocation(line: 0, scope: !4356)
!4361 = !DILocalVariable(name: "outlen", arg: 2, scope: !4356, file: !3660, line: 41, type: !54)
!4362 = !DILocalVariable(name: "in", arg: 3, scope: !4356, file: !3660, line: 41, type: !241)
!4363 = !DILocalVariable(name: "inlen", arg: 4, scope: !4356, file: !3660, line: 41, type: !54)
!4364 = !DILocalVariable(name: "instance", scope: !4356, file: !3660, line: 42, type: !3672)
!4365 = !DILocation(line: 42, column: 10, scope: !4356)
!4366 = !DILocation(line: 43, column: 2, scope: !4356)
!4367 = !DILocation(line: 44, column: 2, scope: !4356)
!4368 = !DILocation(line: 45, column: 2, scope: !4356)
!4369 = !DILocation(line: 46, column: 2, scope: !4356)
!4370 = !DILocation(line: 47, column: 1, scope: !4356)
!4371 = distinct !DISubprogram(name: "snova_pk_expander_init", scope: !3660, file: !3660, line: 55, type: !4372, scopeLine: 55, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4372 = !DISubroutineType(types: !4373)
!4373 = !{null, !4374, !241, !54}
!4374 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4375, size: 32)
!4375 = !DIDerivedType(tag: DW_TAG_typedef, name: "snova_pk_expander_t", file: !691, line: 23, baseType: !4376)
!4376 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !691, line: 21, size: 2944, elements: !4377)
!4377 = !{!4378}
!4378 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !4376, file: !691, line: 22, baseType: !4379, size: 2944)
!4379 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 2944, elements: !4380)
!4380 = !{!4381}
!4381 = !DISubrange(count: 46)
!4382 = !DILocalVariable(name: "instance", arg: 1, scope: !4371, file: !3660, line: 55, type: !4374)
!4383 = !DILocation(line: 0, scope: !4371)
!4384 = !DILocalVariable(name: "seed", arg: 2, scope: !4371, file: !3660, line: 55, type: !241)
!4385 = !DILocalVariable(name: "input_bytes", arg: 3, scope: !4371, file: !3660, line: 55, type: !54)
!4386 = !DILocation(line: 57, column: 2, scope: !4371)
!4387 = !DILocation(line: 58, column: 1, scope: !4371)
!4388 = distinct !DISubprogram(name: "snova_pk_expander", scope: !3660, file: !3660, line: 62, type: !4389, scopeLine: 62, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4389 = !DISubroutineType(types: !4390)
!4390 = !{null, !5, !54, !4374}
!4391 = !DILocalVariable(name: "data", arg: 1, scope: !4388, file: !3660, line: 62, type: !5)
!4392 = !DILocation(line: 0, scope: !4388)
!4393 = !DILocalVariable(name: "num_bytes", arg: 2, scope: !4388, file: !3660, line: 62, type: !54)
!4394 = !DILocalVariable(name: "instance", arg: 3, scope: !4388, file: !3660, line: 62, type: !4374)
!4395 = !DILocation(line: 63, column: 2, scope: !4388)
!4396 = !DILocation(line: 64, column: 1, scope: !4388)
!4397 = distinct !DISubprogram(name: "snova_pk_expand", scope: !3660, file: !3660, line: 108, type: !4357, scopeLine: 108, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !49, retainedNodes: !141)
!4398 = !DILocalVariable(name: "out", arg: 1, scope: !4397, file: !3660, line: 108, type: !5)
!4399 = !DILocation(line: 0, scope: !4397)
!4400 = !DILocalVariable(name: "outlen", arg: 2, scope: !4397, file: !3660, line: 108, type: !54)
!4401 = !DILocalVariable(name: "in", arg: 3, scope: !4397, file: !3660, line: 108, type: !241)
!4402 = !DILocalVariable(name: "inlen", arg: 4, scope: !4397, file: !3660, line: 108, type: !54)
!4403 = !DILocalVariable(name: "instance", scope: !4397, file: !3660, line: 109, type: !4375)
!4404 = !DILocation(line: 109, column: 22, scope: !4397)
!4405 = !DILocation(line: 110, column: 2, scope: !4397)
!4406 = !DILocation(line: 111, column: 2, scope: !4397)
!4407 = !DILocation(line: 112, column: 1, scope: !4397)
!4408 = distinct !DISubprogram(name: "seedexpander_init", scope: !69, file: !69, line: 42, type: !4409, scopeLine: 42, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !64, retainedNodes: !141)
!4409 = !DISubroutineType(types: !4410)
!4410 = !{!39, !4411, !263, !263, !4418}
!4411 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4412, size: 32)
!4412 = !DIDerivedType(tag: DW_TAG_typedef, name: "AES_XOF_struct", file: !71, line: 38, baseType: !4413)
!4413 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !71, line: 32, size: 576, elements: !4414)
!4414 = !{!4415, !4416, !4417, !4419, !4420}
!4415 = !DIDerivedType(tag: DW_TAG_member, name: "buffer", scope: !4413, file: !71, line: 33, baseType: !79, size: 128)
!4416 = !DIDerivedType(tag: DW_TAG_member, name: "buffer_pos", scope: !4413, file: !71, line: 34, baseType: !39, size: 32, offset: 128)
!4417 = !DIDerivedType(tag: DW_TAG_member, name: "length_remaining", scope: !4413, file: !71, line: 35, baseType: !4418, size: 32, offset: 160)
!4418 = !DIBasicType(name: "unsigned long", size: 32, encoding: DW_ATE_unsigned)
!4419 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !4413, file: !71, line: 36, baseType: !75, size: 256, offset: 192)
!4420 = !DIDerivedType(tag: DW_TAG_member, name: "ctr", scope: !4413, file: !71, line: 37, baseType: !79, size: 128, offset: 448)
!4421 = !DILocalVariable(name: "ctx", arg: 1, scope: !4408, file: !69, line: 42, type: !4411)
!4422 = !DILocation(line: 0, scope: !4408)
!4423 = !DILocalVariable(name: "seed", arg: 2, scope: !4408, file: !69, line: 42, type: !263)
!4424 = !DILocalVariable(name: "diversifier", arg: 3, scope: !4408, file: !69, line: 42, type: !263)
!4425 = !DILocalVariable(name: "maxlen", arg: 4, scope: !4408, file: !69, line: 42, type: !4418)
!4426 = !DILocation(line: 47, column: 7, scope: !4408)
!4427 = !DILocation(line: 47, column: 24, scope: !4408)
!4428 = !DILocation(line: 49, column: 14, scope: !4408)
!4429 = !DILocation(line: 49, column: 2, scope: !4408)
!4430 = !DILocation(line: 51, column: 14, scope: !4408)
!4431 = !DILocation(line: 51, column: 2, scope: !4408)
!4432 = !DILocation(line: 52, column: 17, scope: !4408)
!4433 = !DILocation(line: 52, column: 2, scope: !4408)
!4434 = !DILocation(line: 52, column: 15, scope: !4408)
!4435 = !DILocation(line: 53, column: 9, scope: !4408)
!4436 = !DILocation(line: 54, column: 17, scope: !4408)
!4437 = !DILocation(line: 54, column: 2, scope: !4408)
!4438 = !DILocation(line: 54, column: 15, scope: !4408)
!4439 = !DILocation(line: 55, column: 9, scope: !4408)
!4440 = !DILocation(line: 56, column: 23, scope: !4408)
!4441 = !DILocation(line: 56, column: 2, scope: !4408)
!4442 = !DILocation(line: 56, column: 14, scope: !4408)
!4443 = !DILocation(line: 57, column: 9, scope: !4408)
!4444 = !DILocation(line: 58, column: 16, scope: !4408)
!4445 = !DILocation(line: 58, column: 2, scope: !4408)
!4446 = !DILocation(line: 58, column: 14, scope: !4408)
!4447 = !DILocation(line: 59, column: 18, scope: !4408)
!4448 = !DILocation(line: 59, column: 2, scope: !4408)
!4449 = !DILocation(line: 61, column: 7, scope: !4408)
!4450 = !DILocation(line: 61, column: 18, scope: !4408)
!4451 = !DILocation(line: 62, column: 2, scope: !4408)
!4452 = !DILocation(line: 65, column: 1, scope: !4408)
!4453 = distinct !DISubprogram(name: "seedexpander", scope: !69, file: !69, line: 73, type: !4454, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !64, retainedNodes: !141)
!4454 = !DISubroutineType(types: !4455)
!4455 = !{!39, !4411, !263, !4418}
!4456 = !DILocalVariable(name: "ctx", arg: 1, scope: !4453, file: !69, line: 73, type: !4411)
!4457 = !DILocation(line: 0, scope: !4453)
!4458 = !DILocalVariable(name: "x", arg: 2, scope: !4453, file: !69, line: 73, type: !263)
!4459 = !DILocalVariable(name: "xlen", arg: 3, scope: !4453, file: !69, line: 73, type: !4418)
!4460 = !DILocation(line: 76, column: 8, scope: !4461)
!4461 = distinct !DILexicalBlock(scope: !4453, file: !69, line: 76, column: 6)
!4462 = !DILocation(line: 79, column: 19, scope: !4463)
!4463 = distinct !DILexicalBlock(scope: !4453, file: !69, line: 79, column: 6)
!4464 = !DILocation(line: 79, column: 11, scope: !4463)
!4465 = !DILocation(line: 83, column: 7, scope: !4453)
!4466 = !DILocation(line: 83, column: 24, scope: !4453)
!4467 = !DILocalVariable(name: "offset", scope: !4453, file: !69, line: 74, type: !4418)
!4468 = !DILocation(line: 86, column: 2, scope: !4453)
!4469 = !DILocation(line: 86, column: 14, scope: !4453)
!4470 = !DILocation(line: 87, column: 32, scope: !4471)
!4471 = distinct !DILexicalBlock(scope: !4472, file: !69, line: 87, column: 7)
!4472 = distinct !DILexicalBlock(scope: !4453, file: !69, line: 86, column: 19)
!4473 = !DILocation(line: 87, column: 25, scope: !4471)
!4474 = !DILocation(line: 87, column: 18, scope: !4471)
!4475 = !DILocation(line: 88, column: 13, scope: !4476)
!4476 = distinct !DILexicalBlock(scope: !4471, file: !69, line: 87, column: 45)
!4477 = !DILocation(line: 88, column: 42, scope: !4476)
!4478 = !DILocation(line: 88, column: 35, scope: !4476)
!4479 = !DILocation(line: 88, column: 4, scope: !4476)
!4480 = !DILocation(line: 89, column: 9, scope: !4476)
!4481 = !DILocation(line: 89, column: 20, scope: !4476)
!4482 = !DILocation(line: 91, column: 4, scope: !4476)
!4483 = !DILocation(line: 95, column: 12, scope: !4472)
!4484 = !DILocation(line: 95, column: 41, scope: !4472)
!4485 = !DILocation(line: 95, column: 34, scope: !4472)
!4486 = !DILocation(line: 95, column: 56, scope: !4472)
!4487 = !DILocation(line: 95, column: 3, scope: !4472)
!4488 = !DILocation(line: 96, column: 21, scope: !4472)
!4489 = !DILocation(line: 96, column: 14, scope: !4472)
!4490 = !DILocation(line: 96, column: 8, scope: !4472)
!4491 = !DILocation(line: 97, column: 10, scope: !4472)
!4492 = !DILocation(line: 99, column: 19, scope: !4472)
!4493 = !DILocation(line: 99, column: 29, scope: !4472)
!4494 = !DILocation(line: 99, column: 3, scope: !4472)
!4495 = !DILocation(line: 100, column: 8, scope: !4472)
!4496 = !DILocation(line: 100, column: 19, scope: !4472)
!4497 = !DILocalVariable(name: "i", scope: !4498, file: !69, line: 103, type: !39)
!4498 = distinct !DILexicalBlock(scope: !4472, file: !69, line: 103, column: 3)
!4499 = !DILocation(line: 0, scope: !4498)
!4500 = !DILocation(line: 103, column: 8, scope: !4498)
!4501 = !DILocation(line: 103, scope: !4498)
!4502 = !DILocation(line: 103, column: 22, scope: !4503)
!4503 = distinct !DILexicalBlock(scope: !4498, file: !69, line: 103, column: 3)
!4504 = !DILocation(line: 103, column: 3, scope: !4498)
!4505 = !DILocation(line: 104, column: 13, scope: !4506)
!4506 = distinct !DILexicalBlock(scope: !4507, file: !69, line: 104, column: 8)
!4507 = distinct !DILexicalBlock(scope: !4503, file: !69, line: 103, column: 34)
!4508 = !DILocation(line: 104, column: 8, scope: !4506)
!4509 = !DILocation(line: 104, column: 20, scope: !4506)
!4510 = !DILocation(line: 105, column: 10, scope: !4511)
!4511 = distinct !DILexicalBlock(scope: !4506, file: !69, line: 104, column: 29)
!4512 = !DILocation(line: 105, column: 5, scope: !4511)
!4513 = !DILocation(line: 105, column: 17, scope: !4511)
!4514 = !DILocation(line: 103, column: 30, scope: !4503)
!4515 = !DILocation(line: 103, column: 3, scope: !4503)
!4516 = distinct !{!4516, !4504, !4517, !163}
!4517 = !DILocation(line: 110, column: 3, scope: !4498)
!4518 = !DILocation(line: 107, column: 10, scope: !4519)
!4519 = distinct !DILexicalBlock(scope: !4506, file: !69, line: 106, column: 11)
!4520 = !DILocation(line: 107, column: 5, scope: !4519)
!4521 = !DILocation(line: 107, column: 16, scope: !4519)
!4522 = !DILocation(line: 108, column: 5, scope: !4519)
!4523 = distinct !{!4523, !4468, !4524, !163}
!4524 = !DILocation(line: 111, column: 2, scope: !4453)
!4525 = !DILocation(line: 114, column: 1, scope: !4453)
!4526 = distinct !DISubprogram(name: "randombytes_init", scope: !69, file: !69, line: 149, type: !4527, scopeLine: 149, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !64, retainedNodes: !141)
!4527 = !DISubroutineType(types: !4528)
!4528 = !{null, !263, !263, !39}
!4529 = !DILocalVariable(name: "entropy_input", arg: 1, scope: !4526, file: !69, line: 149, type: !263)
!4530 = !DILocation(line: 0, scope: !4526)
!4531 = !DILocalVariable(name: "personalization_string", arg: 2, scope: !4526, file: !69, line: 149, type: !263)
!4532 = !DILocalVariable(name: "security_strength", arg: 3, scope: !4526, file: !69, line: 149, type: !39)
!4533 = !DILocalVariable(name: "seed_material", scope: !4526, file: !69, line: 150, type: !143)
!4534 = !DILocation(line: 150, column: 16, scope: !4526)
!4535 = !DILocation(line: 153, column: 2, scope: !4526)
!4536 = !DILocation(line: 154, column: 6, scope: !4537)
!4537 = distinct !DILexicalBlock(scope: !4526, file: !69, line: 154, column: 6)
!4538 = !DILocation(line: 155, column: 3, scope: !4539)
!4539 = distinct !DILexicalBlock(scope: !4537, file: !69, line: 155, column: 3)
!4540 = !DILocation(line: 155, scope: !4539)
!4541 = !DILocalVariable(name: "i", scope: !4539, file: !69, line: 155, type: !39)
!4542 = !DILocation(line: 0, scope: !4539)
!4543 = !DILocation(line: 155, column: 21, scope: !4544)
!4544 = distinct !DILexicalBlock(scope: !4539, file: !69, line: 155, column: 3)
!4545 = !DILocation(line: 156, column: 24, scope: !4546)
!4546 = distinct !DILexicalBlock(scope: !4544, file: !69, line: 155, column: 32)
!4547 = !DILocation(line: 156, column: 4, scope: !4546)
!4548 = !DILocation(line: 156, column: 21, scope: !4546)
!4549 = !DILocation(line: 155, column: 28, scope: !4544)
!4550 = !DILocation(line: 155, column: 3, scope: !4544)
!4551 = distinct !{!4551, !4538, !4552, !163}
!4552 = !DILocation(line: 157, column: 3, scope: !4539)
!4553 = !DILocation(line: 158, column: 2, scope: !4526)
!4554 = !DILocation(line: 159, column: 2, scope: !4526)
!4555 = !DILocation(line: 160, column: 2, scope: !4526)
!4556 = !DILocation(line: 161, column: 26, scope: !4526)
!4557 = !DILocation(line: 162, column: 1, scope: !4526)
!4558 = distinct !DISubprogram(name: "AES256_CTR_DRBG_Update", scope: !69, file: !69, line: 194, type: !4559, scopeLine: 194, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !64, retainedNodes: !141)
!4559 = !DISubroutineType(types: !4560)
!4560 = !{null, !263, !263, !263}
!4561 = !DILocalVariable(name: "provided_data", arg: 1, scope: !4558, file: !69, line: 194, type: !263)
!4562 = !DILocation(line: 0, scope: !4558)
!4563 = !DILocalVariable(name: "Key", arg: 2, scope: !4558, file: !69, line: 194, type: !263)
!4564 = !DILocalVariable(name: "V", arg: 3, scope: !4558, file: !69, line: 194, type: !263)
!4565 = !DILocalVariable(name: "temp", scope: !4558, file: !69, line: 195, type: !143)
!4566 = !DILocation(line: 195, column: 16, scope: !4558)
!4567 = !DILocalVariable(name: "i", scope: !4568, file: !69, line: 197, type: !39)
!4568 = distinct !DILexicalBlock(scope: !4558, file: !69, line: 197, column: 2)
!4569 = !DILocation(line: 0, scope: !4568)
!4570 = !DILocation(line: 197, column: 7, scope: !4568)
!4571 = !DILocation(line: 197, scope: !4568)
!4572 = !DILocation(line: 197, column: 20, scope: !4573)
!4573 = distinct !DILexicalBlock(scope: !4568, file: !69, line: 197, column: 2)
!4574 = !DILocation(line: 197, column: 2, scope: !4568)
!4575 = !DILocation(line: 199, column: 3, scope: !4576)
!4576 = distinct !DILexicalBlock(scope: !4577, file: !69, line: 199, column: 3)
!4577 = distinct !DILexicalBlock(scope: !4573, file: !69, line: 197, column: 30)
!4578 = !DILocation(line: 199, scope: !4576)
!4579 = !DILocalVariable(name: "j", scope: !4576, file: !69, line: 199, type: !39)
!4580 = !DILocation(line: 0, scope: !4576)
!4581 = !DILocation(line: 199, column: 22, scope: !4582)
!4582 = distinct !DILexicalBlock(scope: !4576, file: !69, line: 199, column: 3)
!4583 = !DILocation(line: 200, column: 8, scope: !4584)
!4584 = distinct !DILexicalBlock(scope: !4585, file: !69, line: 200, column: 8)
!4585 = distinct !DILexicalBlock(scope: !4582, file: !69, line: 199, column: 33)
!4586 = !DILocation(line: 200, column: 13, scope: !4584)
!4587 = !DILocation(line: 201, column: 5, scope: !4588)
!4588 = distinct !DILexicalBlock(scope: !4584, file: !69, line: 200, column: 22)
!4589 = !DILocation(line: 201, column: 10, scope: !4588)
!4590 = !DILocation(line: 199, column: 29, scope: !4582)
!4591 = !DILocation(line: 199, column: 3, scope: !4582)
!4592 = distinct !{!4592, !4575, !4593, !163}
!4593 = !DILocation(line: 206, column: 3, scope: !4576)
!4594 = !DILocation(line: 203, column: 5, scope: !4595)
!4595 = distinct !DILexicalBlock(scope: !4584, file: !69, line: 202, column: 11)
!4596 = !DILocation(line: 203, column: 9, scope: !4595)
!4597 = !DILocation(line: 204, column: 5, scope: !4595)
!4598 = !DILocation(line: 208, column: 32, scope: !4577)
!4599 = !DILocation(line: 208, column: 27, scope: !4577)
!4600 = !DILocation(line: 208, column: 3, scope: !4577)
!4601 = !DILocation(line: 197, column: 26, scope: !4573)
!4602 = !DILocation(line: 197, column: 2, scope: !4573)
!4603 = distinct !{!4603, !4574, !4604, !163}
!4604 = !DILocation(line: 209, column: 2, scope: !4568)
!4605 = !DILocation(line: 210, column: 20, scope: !4606)
!4606 = distinct !DILexicalBlock(scope: !4558, file: !69, line: 210, column: 6)
!4607 = !DILocation(line: 211, column: 3, scope: !4608)
!4608 = distinct !DILexicalBlock(scope: !4606, file: !69, line: 211, column: 3)
!4609 = !DILocation(line: 211, scope: !4608)
!4610 = !DILocalVariable(name: "i", scope: !4608, file: !69, line: 211, type: !39)
!4611 = !DILocation(line: 0, scope: !4608)
!4612 = !DILocation(line: 211, column: 21, scope: !4613)
!4613 = distinct !DILexicalBlock(scope: !4608, file: !69, line: 211, column: 3)
!4614 = !DILocation(line: 212, column: 15, scope: !4615)
!4615 = distinct !DILexicalBlock(scope: !4613, file: !69, line: 211, column: 32)
!4616 = !DILocation(line: 212, column: 4, scope: !4615)
!4617 = !DILocation(line: 212, column: 12, scope: !4615)
!4618 = !DILocation(line: 211, column: 28, scope: !4613)
!4619 = !DILocation(line: 211, column: 3, scope: !4613)
!4620 = distinct !{!4620, !4607, !4621, !163}
!4621 = !DILocation(line: 213, column: 3, scope: !4608)
!4622 = !DILocation(line: 214, column: 2, scope: !4558)
!4623 = !DILocation(line: 215, column: 17, scope: !4558)
!4624 = !DILocation(line: 215, column: 2, scope: !4558)
!4625 = !DILocation(line: 216, column: 1, scope: !4558)
!4626 = distinct !DISubprogram(name: "randombytes", scope: !69, file: !69, line: 164, type: !4627, scopeLine: 164, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !64, retainedNodes: !141)
!4627 = !DISubroutineType(types: !4628)
!4628 = !{!39, !263, !13}
!4629 = !DILocalVariable(name: "x", arg: 1, scope: !4626, file: !69, line: 164, type: !263)
!4630 = !DILocation(line: 0, scope: !4626)
!4631 = !DILocalVariable(name: "xlen", arg: 2, scope: !4626, file: !69, line: 164, type: !13)
!4632 = !DILocalVariable(name: "block", scope: !4626, file: !69, line: 165, type: !79)
!4633 = !DILocation(line: 165, column: 16, scope: !4626)
!4634 = !DILocalVariable(name: "i", scope: !4626, file: !69, line: 166, type: !39)
!4635 = !DILocation(line: 168, column: 2, scope: !4626)
!4636 = !DILocation(line: 168, column: 14, scope: !4626)
!4637 = !DILocation(line: 170, column: 3, scope: !4638)
!4638 = distinct !DILexicalBlock(scope: !4639, file: !69, line: 170, column: 3)
!4639 = distinct !DILexicalBlock(scope: !4626, file: !69, line: 168, column: 19)
!4640 = !DILocation(line: 170, scope: !4638)
!4641 = !DILocalVariable(name: "j", scope: !4638, file: !69, line: 170, type: !39)
!4642 = !DILocation(line: 0, scope: !4638)
!4643 = !DILocation(line: 170, column: 22, scope: !4644)
!4644 = distinct !DILexicalBlock(scope: !4638, file: !69, line: 170, column: 3)
!4645 = !DILocation(line: 171, column: 8, scope: !4646)
!4646 = distinct !DILexicalBlock(scope: !4647, file: !69, line: 171, column: 8)
!4647 = distinct !DILexicalBlock(scope: !4644, file: !69, line: 170, column: 33)
!4648 = !DILocation(line: 171, column: 22, scope: !4646)
!4649 = !DILocation(line: 172, column: 5, scope: !4650)
!4650 = distinct !DILexicalBlock(scope: !4646, file: !69, line: 171, column: 31)
!4651 = !DILocation(line: 172, column: 19, scope: !4650)
!4652 = !DILocation(line: 170, column: 29, scope: !4644)
!4653 = !DILocation(line: 170, column: 3, scope: !4644)
!4654 = distinct !{!4654, !4637, !4655, !163}
!4655 = !DILocation(line: 177, column: 3, scope: !4638)
!4656 = !DILocation(line: 174, column: 5, scope: !4657)
!4657 = distinct !DILexicalBlock(scope: !4646, file: !69, line: 173, column: 11)
!4658 = !DILocation(line: 174, column: 18, scope: !4657)
!4659 = !DILocation(line: 175, column: 5, scope: !4657)
!4660 = !DILocation(line: 178, column: 3, scope: !4639)
!4661 = !DILocation(line: 179, column: 12, scope: !4662)
!4662 = distinct !DILexicalBlock(scope: !4639, file: !69, line: 179, column: 7)
!4663 = !DILocation(line: 180, column: 13, scope: !4664)
!4664 = distinct !DILexicalBlock(scope: !4662, file: !69, line: 179, column: 18)
!4665 = !DILocation(line: 180, column: 4, scope: !4664)
!4666 = !DILocation(line: 181, column: 6, scope: !4664)
!4667 = !DILocation(line: 182, column: 9, scope: !4664)
!4668 = !DILocation(line: 183, column: 3, scope: !4664)
!4669 = !DILocation(line: 184, column: 13, scope: !4670)
!4670 = distinct !DILexicalBlock(scope: !4662, file: !69, line: 183, column: 10)
!4671 = !DILocation(line: 184, column: 25, scope: !4670)
!4672 = !DILocation(line: 184, column: 4, scope: !4670)
!4673 = !DILocation(line: 0, scope: !4662)
!4674 = distinct !{!4674, !4635, !4675, !163}
!4675 = !DILocation(line: 187, column: 2, scope: !4626)
!4676 = !DILocation(line: 188, column: 2, scope: !4626)
!4677 = !DILocation(line: 189, column: 25, scope: !4626)
!4678 = !DILocation(line: 191, column: 2, scope: !4626)
!4679 = distinct !DISubprogram(name: "AES128_CTR", scope: !83, file: !83, line: 1780, type: !4680, scopeLine: 1780, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4680 = !DISubroutineType(types: !4681)
!4681 = !{!39, !263, !54, !279, !54}
!4682 = !DILocalVariable(name: "output", arg: 1, scope: !4679, file: !83, line: 1780, type: !263)
!4683 = !DILocation(line: 0, scope: !4679)
!4684 = !DILocalVariable(name: "outputByteLen", arg: 2, scope: !4679, file: !83, line: 1780, type: !54)
!4685 = !DILocalVariable(name: "input", arg: 3, scope: !4679, file: !83, line: 1780, type: !279)
!4686 = !DILocalVariable(name: "inputByteLen", arg: 4, scope: !4679, file: !83, line: 1780, type: !54)
!4687 = !DILocation(line: 1781, column: 2, scope: !4679)
!4688 = !DILocalVariable(name: "iv", scope: !4679, file: !83, line: 1782, type: !4689)
!4689 = !DICompositeType(tag: DW_TAG_array_type, baseType: !242, size: 128, elements: !20)
!4690 = !DILocation(line: 1782, column: 16, scope: !4679)
!4691 = !DILocalVariable(name: "schedule", scope: !4679, file: !83, line: 1783, type: !66)
!4692 = !DILocation(line: 1783, column: 8, scope: !4679)
!4693 = !DILocation(line: 1784, column: 2, scope: !4679)
!4694 = !DILocation(line: 1785, column: 35, scope: !4679)
!4695 = !DILocation(line: 1785, column: 2, scope: !4679)
!4696 = !DILocation(line: 1786, column: 29, scope: !4679)
!4697 = !DILocation(line: 1786, column: 2, scope: !4679)
!4698 = !DILocation(line: 1787, column: 2, scope: !4679)
!4699 = distinct !DISubprogram(name: "oqs_aes128_load_schedule_c", scope: !83, file: !83, line: 1115, type: !4700, scopeLine: 1115, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4700 = !DISubroutineType(types: !4701)
!4701 = !{null, !241, !4702}
!4702 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 32)
!4703 = !DILocalVariable(name: "key", arg: 1, scope: !4699, file: !83, line: 1115, type: !241)
!4704 = !DILocation(line: 0, scope: !4699)
!4705 = !DILocalVariable(name: "_schedule", arg: 2, scope: !4699, file: !83, line: 1115, type: !4702)
!4706 = !DILocation(line: 1116, column: 15, scope: !4699)
!4707 = !DILocation(line: 1116, column: 13, scope: !4699)
!4708 = !DILocation(line: 1117, column: 2, scope: !4709)
!4709 = distinct !DILexicalBlock(scope: !4710, file: !83, line: 1117, column: 2)
!4710 = distinct !DILexicalBlock(scope: !4699, file: !83, line: 1117, column: 2)
!4711 = !DILocation(line: 1117, column: 2, scope: !4712)
!4712 = distinct !DILexicalBlock(scope: !4709, file: !83, line: 1117, column: 2)
!4713 = !DILocation(line: 1118, column: 32, scope: !4699)
!4714 = !DILocalVariable(name: "ctx", scope: !4699, file: !83, line: 1118, type: !96)
!4715 = !DILocalVariable(name: "skey", scope: !4699, file: !83, line: 1119, type: !4716)
!4716 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 1408, elements: !4717)
!4717 = !{!4718}
!4718 = !DISubrange(count: 22)
!4719 = !DILocation(line: 1119, column: 11, scope: !4699)
!4720 = !DILocation(line: 1120, column: 2, scope: !4699)
!4721 = !DILocation(line: 1121, column: 2, scope: !4699)
!4722 = !DILocation(line: 1122, column: 1, scope: !4699)
!4723 = distinct !DISubprogram(name: "oqs_aes128_ctr_enc_sch_c", scope: !83, file: !83, line: 1231, type: !4724, scopeLine: 1232, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4724 = !DISubroutineType(types: !4725)
!4725 = !{null, !241, !1207, !233, !5, !54}
!4726 = !DILocalVariable(name: "iv", arg: 1, scope: !4723, file: !83, line: 1231, type: !241)
!4727 = !DILocation(line: 0, scope: !4723)
!4728 = !DILocalVariable(name: "iv_len", arg: 2, scope: !4723, file: !83, line: 1231, type: !1207)
!4729 = !DILocalVariable(name: "schedule", arg: 3, scope: !4723, file: !83, line: 1231, type: !233)
!4730 = !DILocalVariable(name: "out", arg: 4, scope: !4723, file: !83, line: 1231, type: !5)
!4731 = !DILocalVariable(name: "out_len", arg: 5, scope: !4723, file: !83, line: 1232, type: !54)
!4732 = !DILocalVariable(name: "ctx", scope: !4723, file: !83, line: 1233, type: !106)
!4733 = !DILocation(line: 1234, column: 2, scope: !4723)
!4734 = !DILocation(line: 1235, column: 1, scope: !4723)
!4735 = distinct !DISubprogram(name: "oqs_aes128_free_schedule_c", scope: !83, file: !83, line: 1260, type: !4736, scopeLine: 1260, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4736 = !DISubroutineType(types: !4737)
!4737 = !{null, !66}
!4738 = !DILocalVariable(name: "schedule", arg: 1, scope: !4735, file: !83, line: 1260, type: !66)
!4739 = !DILocation(line: 0, scope: !4735)
!4740 = !DILocation(line: 1261, column: 15, scope: !4741)
!4741 = distinct !DILexicalBlock(scope: !4735, file: !83, line: 1261, column: 6)
!4742 = !DILocalVariable(name: "ctx", scope: !4743, file: !83, line: 1262, type: !96)
!4743 = distinct !DILexicalBlock(scope: !4741, file: !83, line: 1261, column: 24)
!4744 = !DILocation(line: 0, scope: !4743)
!4745 = !DILocation(line: 1263, column: 3, scope: !4743)
!4746 = !DILocation(line: 1264, column: 2, scope: !4743)
!4747 = !DILocation(line: 1265, column: 1, scope: !4735)
!4748 = distinct !DISubprogram(name: "OQS_MEM_secure_free", scope: !83, file: !83, line: 249, type: !3661, scopeLine: 249, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4749 = !DILocalVariable(name: "ptr", arg: 1, scope: !4748, file: !83, line: 249, type: !66)
!4750 = !DILocation(line: 0, scope: !4748)
!4751 = !DILocalVariable(name: "len", arg: 2, scope: !4748, file: !83, line: 249, type: !54)
!4752 = !DILocation(line: 251, column: 3, scope: !4753)
!4753 = distinct !DILexicalBlock(scope: !4754, file: !83, line: 250, column: 19)
!4754 = distinct !DILexicalBlock(scope: !4748, file: !83, line: 250, column: 6)
!4755 = !DILocation(line: 252, column: 3, scope: !4753)
!4756 = !DILocation(line: 254, column: 1, scope: !4748)
!4757 = distinct !DISubprogram(name: "aes_ctr", scope: !83, file: !83, line: 1079, type: !4758, scopeLine: 1080, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4758 = !DISubroutineType(types: !4759)
!4759 = !{null, !263, !54, !279, !1207, !4760, !53}
!4760 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !59, size: 32)
!4761 = !DILocalVariable(name: "out", arg: 1, scope: !4757, file: !83, line: 1079, type: !263)
!4762 = !DILocation(line: 0, scope: !4757)
!4763 = !DILocalVariable(name: "outlen", arg: 2, scope: !4757, file: !83, line: 1079, type: !54)
!4764 = !DILocalVariable(name: "iv", arg: 3, scope: !4757, file: !83, line: 1079, type: !279)
!4765 = !DILocalVariable(name: "iv_len", arg: 4, scope: !4757, file: !83, line: 1079, type: !1207)
!4766 = !DILocalVariable(name: "rkeys", arg: 5, scope: !4757, file: !83, line: 1079, type: !4760)
!4767 = !DILocalVariable(name: "nrounds", arg: 6, scope: !4757, file: !83, line: 1080, type: !53)
!4768 = !DILocalVariable(name: "ivw", scope: !4757, file: !83, line: 1081, type: !4769)
!4769 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 512, elements: !20)
!4770 = !DILocation(line: 1081, column: 11, scope: !4757)
!4771 = !DILocation(line: 1089, column: 3, scope: !4772)
!4772 = distinct !DILexicalBlock(scope: !4773, file: !83, line: 1088, column: 27)
!4773 = distinct !DILexicalBlock(scope: !4774, file: !83, line: 1088, column: 13)
!4774 = distinct !DILexicalBlock(scope: !4757, file: !83, line: 1085, column: 6)
!4775 = !DILocation(line: 1093, column: 13, scope: !4757)
!4776 = !DILocation(line: 1093, column: 2, scope: !4757)
!4777 = !DILocation(line: 1094, column: 13, scope: !4757)
!4778 = !DILocation(line: 1094, column: 2, scope: !4757)
!4779 = !DILocation(line: 1095, column: 13, scope: !4757)
!4780 = !DILocation(line: 1095, column: 2, scope: !4757)
!4781 = !DILocation(line: 1096, column: 17, scope: !4757)
!4782 = !DILocation(line: 1096, column: 7, scope: !4757)
!4783 = !DILocalVariable(name: "cc", scope: !4757, file: !83, line: 1083, type: !51)
!4784 = !DILocation(line: 1097, column: 24, scope: !4757)
!4785 = !DILocation(line: 1097, column: 11, scope: !4757)
!4786 = !DILocation(line: 1097, column: 2, scope: !4757)
!4787 = !DILocation(line: 1097, column: 9, scope: !4757)
!4788 = !DILocation(line: 1098, column: 25, scope: !4757)
!4789 = !DILocation(line: 1098, column: 12, scope: !4757)
!4790 = !DILocation(line: 1098, column: 2, scope: !4757)
!4791 = !DILocation(line: 1098, column: 10, scope: !4757)
!4792 = !DILocation(line: 1099, column: 25, scope: !4757)
!4793 = !DILocation(line: 1099, column: 12, scope: !4757)
!4794 = !DILocation(line: 1099, column: 2, scope: !4757)
!4795 = !DILocation(line: 1099, column: 10, scope: !4757)
!4796 = !DILocation(line: 1101, column: 2, scope: !4757)
!4797 = !DILocation(line: 1101, column: 16, scope: !4757)
!4798 = !DILocation(line: 1102, column: 3, scope: !4799)
!4799 = distinct !DILexicalBlock(scope: !4757, file: !83, line: 1101, column: 23)
!4800 = !DILocation(line: 1103, column: 7, scope: !4799)
!4801 = !DILocation(line: 1104, column: 10, scope: !4799)
!4802 = distinct !{!4802, !4796, !4803, !163}
!4803 = !DILocation(line: 1105, column: 2, scope: !4757)
!4804 = !DILocation(line: 1106, column: 13, scope: !4805)
!4805 = distinct !DILexicalBlock(scope: !4757, file: !83, line: 1106, column: 6)
!4806 = !DILocalVariable(name: "tmp", scope: !4807, file: !83, line: 1107, type: !4808)
!4807 = distinct !DILexicalBlock(scope: !4805, file: !83, line: 1106, column: 18)
!4808 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 512, elements: !30)
!4809 = !DILocation(line: 1107, column: 17, scope: !4807)
!4810 = !DILocation(line: 1108, column: 3, scope: !4807)
!4811 = !DILocalVariable(name: "i", scope: !4757, file: !83, line: 1082, type: !54)
!4812 = !DILocation(line: 1109, column: 8, scope: !4813)
!4813 = distinct !DILexicalBlock(scope: !4807, file: !83, line: 1109, column: 3)
!4814 = !DILocation(line: 1109, scope: !4813)
!4815 = !DILocation(line: 1109, column: 17, scope: !4816)
!4816 = distinct !DILexicalBlock(scope: !4813, file: !83, line: 1109, column: 3)
!4817 = !DILocation(line: 1109, column: 3, scope: !4813)
!4818 = !DILocation(line: 1110, column: 13, scope: !4819)
!4819 = distinct !DILexicalBlock(scope: !4816, file: !83, line: 1109, column: 32)
!4820 = !DILocation(line: 1110, column: 4, scope: !4819)
!4821 = !DILocation(line: 1110, column: 11, scope: !4819)
!4822 = !DILocation(line: 1109, column: 28, scope: !4816)
!4823 = !DILocation(line: 1109, column: 3, scope: !4816)
!4824 = distinct !{!4824, !4817, !4825, !163}
!4825 = !DILocation(line: 1111, column: 3, scope: !4813)
!4826 = !DILocation(line: 1113, column: 1, scope: !4757)
!4827 = distinct !DISubprogram(name: "br_range_dec32le", scope: !83, file: !83, line: 527, type: !4828, scopeLine: 527, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4828 = !DISubroutineType(types: !4829)
!4829 = !{null, !4830, !54, !279}
!4830 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 32)
!4831 = !DILocalVariable(name: "v", arg: 1, scope: !4827, file: !83, line: 527, type: !4830)
!4832 = !DILocation(line: 0, scope: !4827)
!4833 = !DILocalVariable(name: "num", arg: 2, scope: !4827, file: !83, line: 527, type: !54)
!4834 = !DILocalVariable(name: "src", arg: 3, scope: !4827, file: !83, line: 527, type: !279)
!4835 = !DILocation(line: 528, column: 2, scope: !4827)
!4836 = !DILocation(line: 528, column: 15, scope: !4827)
!4837 = !DILocation(line: 528, column: 12, scope: !4827)
!4838 = !DILocation(line: 529, column: 10, scope: !4839)
!4839 = distinct !DILexicalBlock(scope: !4827, file: !83, line: 528, column: 20)
!4840 = !DILocation(line: 529, column: 5, scope: !4839)
!4841 = !DILocation(line: 529, column: 8, scope: !4839)
!4842 = !DILocation(line: 530, column: 7, scope: !4839)
!4843 = distinct !{!4843, !4835, !4844, !163}
!4844 = !DILocation(line: 531, column: 2, scope: !4827)
!4845 = !DILocation(line: 532, column: 1, scope: !4827)
!4846 = distinct !DISubprogram(name: "br_swap32", scope: !83, file: !83, line: 534, type: !4847, scopeLine: 534, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4847 = !DISubroutineType(types: !4848)
!4848 = !{!51, !51}
!4849 = !DILocalVariable(name: "x", arg: 1, scope: !4846, file: !83, line: 534, type: !51)
!4850 = !DILocation(line: 0, scope: !4846)
!4851 = !DILocation(line: 536, column: 19, scope: !4846)
!4852 = !DILocation(line: 536, column: 2, scope: !4846)
!4853 = distinct !DISubprogram(name: "aes_ctr4x", scope: !83, file: !83, line: 984, type: !4854, scopeLine: 984, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4854 = !DISubroutineType(types: !4855)
!4855 = !{null, !263, !4830, !4760, !53}
!4856 = !DILocalVariable(name: "out", arg: 1, scope: !4853, file: !83, line: 984, type: !263)
!4857 = !DILocation(line: 0, scope: !4853)
!4858 = !DILocalVariable(name: "ivw", arg: 2, scope: !4853, file: !83, line: 984, type: !4830)
!4859 = !DILocalVariable(name: "sk_exp", arg: 3, scope: !4853, file: !83, line: 984, type: !4760)
!4860 = !DILocalVariable(name: "nrounds", arg: 4, scope: !4853, file: !83, line: 984, type: !53)
!4861 = !DILocation(line: 985, column: 2, scope: !4853)
!4862 = !DILocation(line: 988, column: 14, scope: !4853)
!4863 = !DILocation(line: 988, column: 2, scope: !4853)
!4864 = !DILocation(line: 989, column: 14, scope: !4853)
!4865 = !DILocation(line: 989, column: 2, scope: !4853)
!4866 = !DILocation(line: 990, column: 14, scope: !4853)
!4867 = !DILocation(line: 990, column: 2, scope: !4853)
!4868 = !DILocation(line: 991, column: 14, scope: !4853)
!4869 = !DILocation(line: 991, column: 2, scope: !4853)
!4870 = !DILocation(line: 992, column: 1, scope: !4853)
!4871 = distinct !DISubprogram(name: "aes_ecb4x", scope: !83, file: !83, line: 955, type: !4872, scopeLine: 955, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4872 = !DISubroutineType(types: !4873)
!4873 = !{null, !263, !4874, !4760, !53}
!4874 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4875, size: 32)
!4875 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !51)
!4876 = !DILocalVariable(name: "out", arg: 1, scope: !4871, file: !83, line: 955, type: !263)
!4877 = !DILocation(line: 0, scope: !4871)
!4878 = !DILocalVariable(name: "ivw", arg: 2, scope: !4871, file: !83, line: 955, type: !4874)
!4879 = !DILocalVariable(name: "sk_exp", arg: 3, scope: !4871, file: !83, line: 955, type: !4760)
!4880 = !DILocalVariable(name: "nrounds", arg: 4, scope: !4871, file: !83, line: 955, type: !53)
!4881 = !DILocalVariable(name: "w", scope: !4871, file: !83, line: 956, type: !4769)
!4882 = !DILocation(line: 956, column: 11, scope: !4871)
!4883 = !DILocalVariable(name: "q", scope: !4871, file: !83, line: 957, type: !4884)
!4884 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 512, elements: !4885)
!4885 = !{!4886}
!4886 = !DISubrange(count: 8)
!4887 = !DILocation(line: 957, column: 11, scope: !4871)
!4888 = !DILocation(line: 960, column: 2, scope: !4871)
!4889 = !DILocalVariable(name: "i", scope: !4871, file: !83, line: 958, type: !53)
!4890 = !DILocation(line: 961, column: 7, scope: !4891)
!4891 = distinct !DILexicalBlock(scope: !4871, file: !83, line: 961, column: 2)
!4892 = !DILocation(line: 961, scope: !4891)
!4893 = !DILocation(line: 961, column: 16, scope: !4894)
!4894 = distinct !DILexicalBlock(scope: !4891, file: !83, line: 961, column: 2)
!4895 = !DILocation(line: 961, column: 2, scope: !4891)
!4896 = !DILocation(line: 962, column: 30, scope: !4897)
!4897 = distinct !DILexicalBlock(scope: !4894, file: !83, line: 961, column: 26)
!4898 = !DILocation(line: 962, column: 41, scope: !4897)
!4899 = !DILocation(line: 962, column: 37, scope: !4897)
!4900 = !DILocation(line: 962, column: 49, scope: !4897)
!4901 = !DILocation(line: 962, column: 3, scope: !4897)
!4902 = !DILocation(line: 961, column: 22, scope: !4894)
!4903 = !DILocation(line: 961, column: 2, scope: !4894)
!4904 = distinct !{!4904, !4895, !4905, !163}
!4905 = !DILocation(line: 963, column: 2, scope: !4891)
!4906 = !DILocation(line: 964, column: 2, scope: !4871)
!4907 = !DILocation(line: 966, column: 2, scope: !4871)
!4908 = !DILocation(line: 967, column: 7, scope: !4909)
!4909 = distinct !DILexicalBlock(scope: !4871, file: !83, line: 967, column: 2)
!4910 = !DILocation(line: 967, scope: !4909)
!4911 = !DILocation(line: 967, column: 16, scope: !4912)
!4912 = distinct !DILexicalBlock(scope: !4909, file: !83, line: 967, column: 2)
!4913 = !DILocation(line: 967, column: 2, scope: !4909)
!4914 = !DILocation(line: 968, column: 3, scope: !4915)
!4915 = distinct !DILexicalBlock(scope: !4912, file: !83, line: 967, column: 32)
!4916 = !DILocation(line: 969, column: 3, scope: !4915)
!4917 = !DILocation(line: 970, column: 3, scope: !4915)
!4918 = !DILocation(line: 971, column: 27, scope: !4915)
!4919 = !DILocation(line: 971, column: 3, scope: !4915)
!4920 = !DILocation(line: 967, column: 28, scope: !4912)
!4921 = !DILocation(line: 967, column: 2, scope: !4912)
!4922 = distinct !{!4922, !4913, !4923, !163}
!4923 = !DILocation(line: 972, column: 2, scope: !4909)
!4924 = !DILocation(line: 973, column: 2, scope: !4871)
!4925 = !DILocation(line: 974, column: 2, scope: !4871)
!4926 = !DILocation(line: 975, column: 26, scope: !4871)
!4927 = !DILocation(line: 975, column: 2, scope: !4871)
!4928 = !DILocation(line: 977, column: 2, scope: !4871)
!4929 = !DILocation(line: 978, column: 7, scope: !4930)
!4930 = distinct !DILexicalBlock(scope: !4871, file: !83, line: 978, column: 2)
!4931 = !DILocation(line: 978, scope: !4930)
!4932 = !DILocation(line: 978, column: 16, scope: !4933)
!4933 = distinct !DILexicalBlock(scope: !4930, file: !83, line: 978, column: 2)
!4934 = !DILocation(line: 978, column: 2, scope: !4930)
!4935 = !DILocation(line: 979, column: 32, scope: !4936)
!4936 = distinct !DILexicalBlock(scope: !4933, file: !83, line: 978, column: 26)
!4937 = !DILocation(line: 979, column: 44, scope: !4936)
!4938 = !DILocation(line: 979, column: 54, scope: !4936)
!4939 = !DILocation(line: 979, column: 50, scope: !4936)
!4940 = !DILocation(line: 979, column: 3, scope: !4936)
!4941 = !DILocation(line: 978, column: 22, scope: !4933)
!4942 = !DILocation(line: 978, column: 2, scope: !4933)
!4943 = distinct !{!4943, !4934, !4944, !163}
!4944 = !DILocation(line: 980, column: 2, scope: !4930)
!4945 = !DILocation(line: 981, column: 2, scope: !4871)
!4946 = !DILocation(line: 982, column: 1, scope: !4871)
!4947 = distinct !DISubprogram(name: "inc4_be", scope: !83, file: !83, line: 950, type: !4948, scopeLine: 950, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4948 = !DISubroutineType(types: !4949)
!4949 = !{null, !4830}
!4950 = !DILocalVariable(name: "x", arg: 1, scope: !4947, file: !83, line: 950, type: !4830)
!4951 = !DILocation(line: 0, scope: !4947)
!4952 = !DILocation(line: 951, column: 25, scope: !4947)
!4953 = !DILocation(line: 951, column: 15, scope: !4947)
!4954 = !DILocation(line: 951, column: 29, scope: !4947)
!4955 = !DILocalVariable(name: "t", scope: !4947, file: !83, line: 951, type: !51)
!4956 = !DILocation(line: 952, column: 7, scope: !4947)
!4957 = !DILocation(line: 952, column: 5, scope: !4947)
!4958 = !DILocation(line: 953, column: 1, scope: !4947)
!4959 = distinct !DISubprogram(name: "br_aes_ct64_interleave_in", scope: !83, file: !83, line: 764, type: !4960, scopeLine: 764, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!4960 = !DISubroutineType(types: !4961)
!4961 = !{null, !3702, !3702, !4874}
!4962 = !DILocalVariable(name: "q0", arg: 1, scope: !4959, file: !83, line: 764, type: !3702)
!4963 = !DILocation(line: 0, scope: !4959)
!4964 = !DILocalVariable(name: "q1", arg: 2, scope: !4959, file: !83, line: 764, type: !3702)
!4965 = !DILocalVariable(name: "w", arg: 3, scope: !4959, file: !83, line: 764, type: !4874)
!4966 = !DILocation(line: 767, column: 7, scope: !4959)
!4967 = !DILocalVariable(name: "x0", scope: !4959, file: !83, line: 765, type: !11)
!4968 = !DILocation(line: 768, column: 7, scope: !4959)
!4969 = !DILocalVariable(name: "x1", scope: !4959, file: !83, line: 765, type: !11)
!4970 = !DILocation(line: 769, column: 7, scope: !4959)
!4971 = !DILocalVariable(name: "x2", scope: !4959, file: !83, line: 765, type: !11)
!4972 = !DILocation(line: 770, column: 7, scope: !4959)
!4973 = !DILocalVariable(name: "x3", scope: !4959, file: !83, line: 765, type: !11)
!4974 = !DILocation(line: 771, column: 12, scope: !4959)
!4975 = !DILocation(line: 771, column: 5, scope: !4959)
!4976 = !DILocation(line: 772, column: 12, scope: !4959)
!4977 = !DILocation(line: 772, column: 5, scope: !4959)
!4978 = !DILocation(line: 773, column: 12, scope: !4959)
!4979 = !DILocation(line: 773, column: 5, scope: !4959)
!4980 = !DILocation(line: 774, column: 12, scope: !4959)
!4981 = !DILocation(line: 774, column: 5, scope: !4959)
!4982 = !DILocation(line: 775, column: 5, scope: !4959)
!4983 = !DILocation(line: 776, column: 5, scope: !4959)
!4984 = !DILocation(line: 777, column: 5, scope: !4959)
!4985 = !DILocation(line: 778, column: 5, scope: !4959)
!4986 = !DILocation(line: 779, column: 12, scope: !4959)
!4987 = !DILocation(line: 779, column: 5, scope: !4959)
!4988 = !DILocation(line: 780, column: 12, scope: !4959)
!4989 = !DILocation(line: 780, column: 5, scope: !4959)
!4990 = !DILocation(line: 783, column: 5, scope: !4959)
!4991 = !DILocation(line: 784, column: 5, scope: !4959)
!4992 = !DILocation(line: 787, column: 17, scope: !4959)
!4993 = !DILocation(line: 787, column: 11, scope: !4959)
!4994 = !DILocation(line: 787, column: 6, scope: !4959)
!4995 = !DILocation(line: 788, column: 17, scope: !4959)
!4996 = !DILocation(line: 788, column: 11, scope: !4959)
!4997 = !DILocation(line: 788, column: 6, scope: !4959)
!4998 = !DILocation(line: 789, column: 1, scope: !4959)
!4999 = distinct !DISubprogram(name: "br_aes_ct64_ortho", scope: !83, file: !83, line: 734, type: !3779, scopeLine: 734, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5000 = !DILocalVariable(name: "q", arg: 1, scope: !4999, file: !83, line: 734, type: !3702)
!5001 = !DILocation(line: 0, scope: !4999)
!5002 = !DILocation(line: 748, column: 2, scope: !5003)
!5003 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 748, column: 2)
!5004 = !DILocalVariable(name: "a", scope: !5003, file: !83, line: 748, type: !11)
!5005 = !DILocation(line: 0, scope: !5003)
!5006 = !DILocalVariable(name: "b", scope: !5003, file: !83, line: 748, type: !11)
!5007 = !DILocation(line: 749, column: 2, scope: !5008)
!5008 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 749, column: 2)
!5009 = !DILocalVariable(name: "a", scope: !5008, file: !83, line: 749, type: !11)
!5010 = !DILocation(line: 0, scope: !5008)
!5011 = !DILocalVariable(name: "b", scope: !5008, file: !83, line: 749, type: !11)
!5012 = !DILocation(line: 750, column: 2, scope: !5013)
!5013 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 750, column: 2)
!5014 = !DILocalVariable(name: "a", scope: !5013, file: !83, line: 750, type: !11)
!5015 = !DILocation(line: 0, scope: !5013)
!5016 = !DILocalVariable(name: "b", scope: !5013, file: !83, line: 750, type: !11)
!5017 = !DILocation(line: 751, column: 2, scope: !5018)
!5018 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 751, column: 2)
!5019 = !DILocalVariable(name: "a", scope: !5018, file: !83, line: 751, type: !11)
!5020 = !DILocation(line: 0, scope: !5018)
!5021 = !DILocalVariable(name: "b", scope: !5018, file: !83, line: 751, type: !11)
!5022 = !DILocation(line: 753, column: 2, scope: !5023)
!5023 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 753, column: 2)
!5024 = !DILocalVariable(name: "a", scope: !5023, file: !83, line: 753, type: !11)
!5025 = !DILocation(line: 0, scope: !5023)
!5026 = !DILocalVariable(name: "b", scope: !5023, file: !83, line: 753, type: !11)
!5027 = !DILocation(line: 754, column: 2, scope: !5028)
!5028 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 754, column: 2)
!5029 = !DILocalVariable(name: "a", scope: !5028, file: !83, line: 754, type: !11)
!5030 = !DILocation(line: 0, scope: !5028)
!5031 = !DILocalVariable(name: "b", scope: !5028, file: !83, line: 754, type: !11)
!5032 = !DILocation(line: 755, column: 2, scope: !5033)
!5033 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 755, column: 2)
!5034 = !DILocalVariable(name: "a", scope: !5033, file: !83, line: 755, type: !11)
!5035 = !DILocation(line: 0, scope: !5033)
!5036 = !DILocalVariable(name: "b", scope: !5033, file: !83, line: 755, type: !11)
!5037 = !DILocation(line: 756, column: 2, scope: !5038)
!5038 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 756, column: 2)
!5039 = !DILocalVariable(name: "a", scope: !5038, file: !83, line: 756, type: !11)
!5040 = !DILocation(line: 0, scope: !5038)
!5041 = !DILocalVariable(name: "b", scope: !5038, file: !83, line: 756, type: !11)
!5042 = !DILocation(line: 758, column: 2, scope: !5043)
!5043 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 758, column: 2)
!5044 = !DILocalVariable(name: "a", scope: !5043, file: !83, line: 758, type: !11)
!5045 = !DILocation(line: 0, scope: !5043)
!5046 = !DILocalVariable(name: "b", scope: !5043, file: !83, line: 758, type: !11)
!5047 = !DILocation(line: 759, column: 2, scope: !5048)
!5048 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 759, column: 2)
!5049 = !DILocalVariable(name: "a", scope: !5048, file: !83, line: 759, type: !11)
!5050 = !DILocation(line: 0, scope: !5048)
!5051 = !DILocalVariable(name: "b", scope: !5048, file: !83, line: 759, type: !11)
!5052 = !DILocation(line: 760, column: 2, scope: !5053)
!5053 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 760, column: 2)
!5054 = !DILocalVariable(name: "a", scope: !5053, file: !83, line: 760, type: !11)
!5055 = !DILocation(line: 0, scope: !5053)
!5056 = !DILocalVariable(name: "b", scope: !5053, file: !83, line: 760, type: !11)
!5057 = !DILocation(line: 761, column: 2, scope: !5058)
!5058 = distinct !DILexicalBlock(scope: !4999, file: !83, line: 761, column: 2)
!5059 = !DILocalVariable(name: "a", scope: !5058, file: !83, line: 761, type: !11)
!5060 = !DILocation(line: 0, scope: !5058)
!5061 = !DILocalVariable(name: "b", scope: !5058, file: !83, line: 761, type: !11)
!5062 = !DILocation(line: 762, column: 1, scope: !4999)
!5063 = distinct !DISubprogram(name: "add_round_key", scope: !83, file: !83, line: 890, type: !5064, scopeLine: 890, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5064 = !DISubroutineType(types: !5065)
!5065 = !{null, !3702, !4760}
!5066 = !DILocalVariable(name: "q", arg: 1, scope: !5063, file: !83, line: 890, type: !3702)
!5067 = !DILocation(line: 0, scope: !5063)
!5068 = !DILocalVariable(name: "sk", arg: 2, scope: !5063, file: !83, line: 890, type: !4760)
!5069 = !DILocation(line: 891, column: 10, scope: !5063)
!5070 = !DILocation(line: 891, column: 7, scope: !5063)
!5071 = !DILocation(line: 892, column: 10, scope: !5063)
!5072 = !DILocation(line: 892, column: 2, scope: !5063)
!5073 = !DILocation(line: 892, column: 7, scope: !5063)
!5074 = !DILocation(line: 893, column: 10, scope: !5063)
!5075 = !DILocation(line: 893, column: 2, scope: !5063)
!5076 = !DILocation(line: 893, column: 7, scope: !5063)
!5077 = !DILocation(line: 894, column: 10, scope: !5063)
!5078 = !DILocation(line: 894, column: 2, scope: !5063)
!5079 = !DILocation(line: 894, column: 7, scope: !5063)
!5080 = !DILocation(line: 895, column: 10, scope: !5063)
!5081 = !DILocation(line: 895, column: 2, scope: !5063)
!5082 = !DILocation(line: 895, column: 7, scope: !5063)
!5083 = !DILocation(line: 896, column: 10, scope: !5063)
!5084 = !DILocation(line: 896, column: 2, scope: !5063)
!5085 = !DILocation(line: 896, column: 7, scope: !5063)
!5086 = !DILocation(line: 897, column: 10, scope: !5063)
!5087 = !DILocation(line: 897, column: 2, scope: !5063)
!5088 = !DILocation(line: 897, column: 7, scope: !5063)
!5089 = !DILocation(line: 898, column: 10, scope: !5063)
!5090 = !DILocation(line: 898, column: 2, scope: !5063)
!5091 = !DILocation(line: 898, column: 7, scope: !5063)
!5092 = !DILocation(line: 899, column: 1, scope: !5063)
!5093 = distinct !DISubprogram(name: "br_aes_ct64_bitslice_Sbox", scope: !83, file: !83, line: 560, type: !3779, scopeLine: 560, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5094 = !DILocalVariable(name: "q", arg: 1, scope: !5093, file: !83, line: 560, type: !3702)
!5095 = !DILocation(line: 0, scope: !5093)
!5096 = !DILocation(line: 586, column: 7, scope: !5093)
!5097 = !DILocalVariable(name: "x0", scope: !5093, file: !83, line: 571, type: !11)
!5098 = !DILocation(line: 587, column: 7, scope: !5093)
!5099 = !DILocalVariable(name: "x1", scope: !5093, file: !83, line: 571, type: !11)
!5100 = !DILocation(line: 588, column: 7, scope: !5093)
!5101 = !DILocalVariable(name: "x2", scope: !5093, file: !83, line: 571, type: !11)
!5102 = !DILocation(line: 589, column: 7, scope: !5093)
!5103 = !DILocalVariable(name: "x3", scope: !5093, file: !83, line: 571, type: !11)
!5104 = !DILocation(line: 590, column: 7, scope: !5093)
!5105 = !DILocalVariable(name: "x4", scope: !5093, file: !83, line: 571, type: !11)
!5106 = !DILocation(line: 591, column: 7, scope: !5093)
!5107 = !DILocalVariable(name: "x5", scope: !5093, file: !83, line: 571, type: !11)
!5108 = !DILocation(line: 592, column: 7, scope: !5093)
!5109 = !DILocalVariable(name: "x6", scope: !5093, file: !83, line: 571, type: !11)
!5110 = !DILocation(line: 593, column: 7, scope: !5093)
!5111 = !DILocalVariable(name: "x7", scope: !5093, file: !83, line: 571, type: !11)
!5112 = !DILocation(line: 598, column: 11, scope: !5093)
!5113 = !DILocalVariable(name: "y14", scope: !5093, file: !83, line: 573, type: !11)
!5114 = !DILocation(line: 599, column: 11, scope: !5093)
!5115 = !DILocalVariable(name: "y13", scope: !5093, file: !83, line: 573, type: !11)
!5116 = !DILocation(line: 600, column: 10, scope: !5093)
!5117 = !DILocalVariable(name: "y9", scope: !5093, file: !83, line: 572, type: !11)
!5118 = !DILocation(line: 601, column: 10, scope: !5093)
!5119 = !DILocalVariable(name: "y8", scope: !5093, file: !83, line: 572, type: !11)
!5120 = !DILocation(line: 602, column: 10, scope: !5093)
!5121 = !DILocalVariable(name: "t0", scope: !5093, file: !83, line: 577, type: !11)
!5122 = !DILocation(line: 603, column: 10, scope: !5093)
!5123 = !DILocalVariable(name: "y1", scope: !5093, file: !83, line: 572, type: !11)
!5124 = !DILocation(line: 604, column: 10, scope: !5093)
!5125 = !DILocalVariable(name: "y4", scope: !5093, file: !83, line: 572, type: !11)
!5126 = !DILocation(line: 605, column: 12, scope: !5093)
!5127 = !DILocalVariable(name: "y12", scope: !5093, file: !83, line: 573, type: !11)
!5128 = !DILocation(line: 606, column: 10, scope: !5093)
!5129 = !DILocalVariable(name: "y2", scope: !5093, file: !83, line: 572, type: !11)
!5130 = !DILocation(line: 607, column: 10, scope: !5093)
!5131 = !DILocalVariable(name: "y5", scope: !5093, file: !83, line: 572, type: !11)
!5132 = !DILocation(line: 608, column: 10, scope: !5093)
!5133 = !DILocalVariable(name: "y3", scope: !5093, file: !83, line: 572, type: !11)
!5134 = !DILocation(line: 609, column: 10, scope: !5093)
!5135 = !DILocalVariable(name: "t1", scope: !5093, file: !83, line: 577, type: !11)
!5136 = !DILocation(line: 610, column: 11, scope: !5093)
!5137 = !DILocalVariable(name: "y15", scope: !5093, file: !83, line: 573, type: !11)
!5138 = !DILocation(line: 611, column: 11, scope: !5093)
!5139 = !DILocalVariable(name: "y20", scope: !5093, file: !83, line: 574, type: !11)
!5140 = !DILocation(line: 612, column: 11, scope: !5093)
!5141 = !DILocalVariable(name: "y6", scope: !5093, file: !83, line: 572, type: !11)
!5142 = !DILocation(line: 613, column: 12, scope: !5093)
!5143 = !DILocalVariable(name: "y10", scope: !5093, file: !83, line: 573, type: !11)
!5144 = !DILocation(line: 614, column: 12, scope: !5093)
!5145 = !DILocalVariable(name: "y11", scope: !5093, file: !83, line: 573, type: !11)
!5146 = !DILocation(line: 615, column: 10, scope: !5093)
!5147 = !DILocalVariable(name: "y7", scope: !5093, file: !83, line: 572, type: !11)
!5148 = !DILocation(line: 616, column: 12, scope: !5093)
!5149 = !DILocalVariable(name: "y17", scope: !5093, file: !83, line: 573, type: !11)
!5150 = !DILocalVariable(name: "y19", scope: !5093, file: !83, line: 573, type: !11)
!5151 = !DILocation(line: 618, column: 11, scope: !5093)
!5152 = !DILocalVariable(name: "y16", scope: !5093, file: !83, line: 573, type: !11)
!5153 = !DILocalVariable(name: "y21", scope: !5093, file: !83, line: 574, type: !11)
!5154 = !DILocalVariable(name: "y18", scope: !5093, file: !83, line: 573, type: !11)
!5155 = !DILocation(line: 625, column: 11, scope: !5093)
!5156 = !DILocalVariable(name: "t2", scope: !5093, file: !83, line: 577, type: !11)
!5157 = !DILocation(line: 626, column: 10, scope: !5093)
!5158 = !DILocalVariable(name: "t3", scope: !5093, file: !83, line: 577, type: !11)
!5159 = !DILocation(line: 627, column: 10, scope: !5093)
!5160 = !DILocalVariable(name: "t4", scope: !5093, file: !83, line: 577, type: !11)
!5161 = !DILocation(line: 628, column: 10, scope: !5093)
!5162 = !DILocalVariable(name: "t5", scope: !5093, file: !83, line: 577, type: !11)
!5163 = !DILocalVariable(name: "t6", scope: !5093, file: !83, line: 577, type: !11)
!5164 = !DILocation(line: 630, column: 11, scope: !5093)
!5165 = !DILocalVariable(name: "t7", scope: !5093, file: !83, line: 577, type: !11)
!5166 = !DILocation(line: 631, column: 10, scope: !5093)
!5167 = !DILocalVariable(name: "t8", scope: !5093, file: !83, line: 577, type: !11)
!5168 = !DILocalVariable(name: "t9", scope: !5093, file: !83, line: 577, type: !11)
!5169 = !DILocation(line: 633, column: 11, scope: !5093)
!5170 = !DILocalVariable(name: "t10", scope: !5093, file: !83, line: 578, type: !11)
!5171 = !DILocalVariable(name: "t11", scope: !5093, file: !83, line: 578, type: !11)
!5172 = !DILocation(line: 635, column: 11, scope: !5093)
!5173 = !DILocalVariable(name: "t12", scope: !5093, file: !83, line: 578, type: !11)
!5174 = !DILocation(line: 636, column: 12, scope: !5093)
!5175 = !DILocalVariable(name: "t13", scope: !5093, file: !83, line: 578, type: !11)
!5176 = !DILocation(line: 637, column: 12, scope: !5093)
!5177 = !DILocalVariable(name: "t14", scope: !5093, file: !83, line: 578, type: !11)
!5178 = !DILocation(line: 638, column: 11, scope: !5093)
!5179 = !DILocalVariable(name: "t15", scope: !5093, file: !83, line: 578, type: !11)
!5180 = !DILocation(line: 639, column: 12, scope: !5093)
!5181 = !DILocalVariable(name: "t16", scope: !5093, file: !83, line: 578, type: !11)
!5182 = !DILocation(line: 640, column: 11, scope: !5093)
!5183 = !DILocalVariable(name: "t17", scope: !5093, file: !83, line: 578, type: !11)
!5184 = !DILocalVariable(name: "t18", scope: !5093, file: !83, line: 578, type: !11)
!5185 = !DILocalVariable(name: "t19", scope: !5093, file: !83, line: 578, type: !11)
!5186 = !DILocalVariable(name: "t20", scope: !5093, file: !83, line: 579, type: !11)
!5187 = !DILocation(line: 644, column: 12, scope: !5093)
!5188 = !DILocalVariable(name: "t21", scope: !5093, file: !83, line: 579, type: !11)
!5189 = !DILocation(line: 645, column: 12, scope: !5093)
!5190 = !DILocalVariable(name: "t22", scope: !5093, file: !83, line: 579, type: !11)
!5191 = !DILocation(line: 646, column: 12, scope: !5093)
!5192 = !DILocalVariable(name: "t23", scope: !5093, file: !83, line: 579, type: !11)
!5193 = !DILocation(line: 647, column: 12, scope: !5093)
!5194 = !DILocalVariable(name: "t24", scope: !5093, file: !83, line: 579, type: !11)
!5195 = !DILocation(line: 649, column: 12, scope: !5093)
!5196 = !DILocalVariable(name: "t25", scope: !5093, file: !83, line: 579, type: !11)
!5197 = !DILocation(line: 650, column: 12, scope: !5093)
!5198 = !DILocalVariable(name: "t26", scope: !5093, file: !83, line: 579, type: !11)
!5199 = !DILocation(line: 651, column: 12, scope: !5093)
!5200 = !DILocalVariable(name: "t27", scope: !5093, file: !83, line: 579, type: !11)
!5201 = !DILocation(line: 652, column: 12, scope: !5093)
!5202 = !DILocalVariable(name: "t28", scope: !5093, file: !83, line: 579, type: !11)
!5203 = !DILocation(line: 653, column: 12, scope: !5093)
!5204 = !DILocalVariable(name: "t29", scope: !5093, file: !83, line: 579, type: !11)
!5205 = !DILocation(line: 654, column: 12, scope: !5093)
!5206 = !DILocalVariable(name: "t30", scope: !5093, file: !83, line: 580, type: !11)
!5207 = !DILocation(line: 655, column: 12, scope: !5093)
!5208 = !DILocalVariable(name: "t31", scope: !5093, file: !83, line: 580, type: !11)
!5209 = !DILocation(line: 656, column: 12, scope: !5093)
!5210 = !DILocalVariable(name: "t32", scope: !5093, file: !83, line: 580, type: !11)
!5211 = !DILocation(line: 657, column: 12, scope: !5093)
!5212 = !DILocalVariable(name: "t33", scope: !5093, file: !83, line: 580, type: !11)
!5213 = !DILocation(line: 658, column: 12, scope: !5093)
!5214 = !DILocalVariable(name: "t34", scope: !5093, file: !83, line: 580, type: !11)
!5215 = !DILocation(line: 659, column: 12, scope: !5093)
!5216 = !DILocalVariable(name: "t35", scope: !5093, file: !83, line: 580, type: !11)
!5217 = !DILocation(line: 660, column: 12, scope: !5093)
!5218 = !DILocalVariable(name: "t36", scope: !5093, file: !83, line: 580, type: !11)
!5219 = !DILocation(line: 661, column: 12, scope: !5093)
!5220 = !DILocalVariable(name: "t37", scope: !5093, file: !83, line: 580, type: !11)
!5221 = !DILocation(line: 662, column: 12, scope: !5093)
!5222 = !DILocalVariable(name: "t38", scope: !5093, file: !83, line: 580, type: !11)
!5223 = !DILocation(line: 663, column: 12, scope: !5093)
!5224 = !DILocalVariable(name: "t39", scope: !5093, file: !83, line: 580, type: !11)
!5225 = !DILocation(line: 664, column: 12, scope: !5093)
!5226 = !DILocalVariable(name: "t40", scope: !5093, file: !83, line: 581, type: !11)
!5227 = !DILocation(line: 666, column: 12, scope: !5093)
!5228 = !DILocalVariable(name: "t41", scope: !5093, file: !83, line: 581, type: !11)
!5229 = !DILocation(line: 667, column: 12, scope: !5093)
!5230 = !DILocalVariable(name: "t42", scope: !5093, file: !83, line: 581, type: !11)
!5231 = !DILocation(line: 668, column: 12, scope: !5093)
!5232 = !DILocalVariable(name: "t43", scope: !5093, file: !83, line: 581, type: !11)
!5233 = !DILocation(line: 669, column: 12, scope: !5093)
!5234 = !DILocalVariable(name: "t44", scope: !5093, file: !83, line: 581, type: !11)
!5235 = !DILocation(line: 670, column: 12, scope: !5093)
!5236 = !DILocalVariable(name: "t45", scope: !5093, file: !83, line: 581, type: !11)
!5237 = !DILocation(line: 671, column: 11, scope: !5093)
!5238 = !DILocalVariable(name: "z0", scope: !5093, file: !83, line: 575, type: !11)
!5239 = !DILocation(line: 672, column: 11, scope: !5093)
!5240 = !DILocalVariable(name: "z1", scope: !5093, file: !83, line: 575, type: !11)
!5241 = !DILocation(line: 673, column: 11, scope: !5093)
!5242 = !DILocalVariable(name: "z2", scope: !5093, file: !83, line: 575, type: !11)
!5243 = !DILocation(line: 674, column: 11, scope: !5093)
!5244 = !DILocalVariable(name: "z3", scope: !5093, file: !83, line: 575, type: !11)
!5245 = !DILocation(line: 675, column: 11, scope: !5093)
!5246 = !DILocalVariable(name: "z4", scope: !5093, file: !83, line: 575, type: !11)
!5247 = !DILocation(line: 676, column: 11, scope: !5093)
!5248 = !DILocalVariable(name: "z5", scope: !5093, file: !83, line: 575, type: !11)
!5249 = !DILocation(line: 677, column: 11, scope: !5093)
!5250 = !DILocalVariable(name: "z6", scope: !5093, file: !83, line: 575, type: !11)
!5251 = !DILocation(line: 678, column: 11, scope: !5093)
!5252 = !DILocalVariable(name: "z7", scope: !5093, file: !83, line: 575, type: !11)
!5253 = !DILocation(line: 679, column: 11, scope: !5093)
!5254 = !DILocalVariable(name: "z8", scope: !5093, file: !83, line: 575, type: !11)
!5255 = !DILocation(line: 680, column: 11, scope: !5093)
!5256 = !DILocalVariable(name: "z9", scope: !5093, file: !83, line: 575, type: !11)
!5257 = !DILocation(line: 681, column: 12, scope: !5093)
!5258 = !DILocalVariable(name: "z10", scope: !5093, file: !83, line: 576, type: !11)
!5259 = !DILocation(line: 682, column: 12, scope: !5093)
!5260 = !DILocalVariable(name: "z11", scope: !5093, file: !83, line: 576, type: !11)
!5261 = !DILocation(line: 683, column: 12, scope: !5093)
!5262 = !DILocalVariable(name: "z12", scope: !5093, file: !83, line: 576, type: !11)
!5263 = !DILocation(line: 684, column: 12, scope: !5093)
!5264 = !DILocalVariable(name: "z13", scope: !5093, file: !83, line: 576, type: !11)
!5265 = !DILocation(line: 685, column: 12, scope: !5093)
!5266 = !DILocalVariable(name: "z14", scope: !5093, file: !83, line: 576, type: !11)
!5267 = !DILocation(line: 686, column: 12, scope: !5093)
!5268 = !DILocalVariable(name: "z15", scope: !5093, file: !83, line: 576, type: !11)
!5269 = !DILocation(line: 687, column: 12, scope: !5093)
!5270 = !DILocalVariable(name: "z16", scope: !5093, file: !83, line: 576, type: !11)
!5271 = !DILocation(line: 688, column: 12, scope: !5093)
!5272 = !DILocalVariable(name: "z17", scope: !5093, file: !83, line: 576, type: !11)
!5273 = !DILocation(line: 693, column: 12, scope: !5093)
!5274 = !DILocalVariable(name: "t46", scope: !5093, file: !83, line: 581, type: !11)
!5275 = !DILocation(line: 694, column: 12, scope: !5093)
!5276 = !DILocalVariable(name: "t47", scope: !5093, file: !83, line: 581, type: !11)
!5277 = !DILocation(line: 695, column: 11, scope: !5093)
!5278 = !DILocalVariable(name: "t48", scope: !5093, file: !83, line: 581, type: !11)
!5279 = !DILocation(line: 696, column: 11, scope: !5093)
!5280 = !DILocalVariable(name: "t49", scope: !5093, file: !83, line: 581, type: !11)
!5281 = !DILocation(line: 697, column: 11, scope: !5093)
!5282 = !DILocalVariable(name: "t50", scope: !5093, file: !83, line: 582, type: !11)
!5283 = !DILocation(line: 698, column: 11, scope: !5093)
!5284 = !DILocalVariable(name: "t51", scope: !5093, file: !83, line: 582, type: !11)
!5285 = !DILocation(line: 699, column: 11, scope: !5093)
!5286 = !DILocalVariable(name: "t52", scope: !5093, file: !83, line: 582, type: !11)
!5287 = !DILocation(line: 700, column: 11, scope: !5093)
!5288 = !DILocalVariable(name: "t53", scope: !5093, file: !83, line: 582, type: !11)
!5289 = !DILocation(line: 701, column: 11, scope: !5093)
!5290 = !DILocalVariable(name: "t54", scope: !5093, file: !83, line: 582, type: !11)
!5291 = !DILocation(line: 702, column: 12, scope: !5093)
!5292 = !DILocalVariable(name: "t55", scope: !5093, file: !83, line: 582, type: !11)
!5293 = !DILocation(line: 703, column: 12, scope: !5093)
!5294 = !DILocalVariable(name: "t56", scope: !5093, file: !83, line: 582, type: !11)
!5295 = !DILocation(line: 704, column: 12, scope: !5093)
!5296 = !DILocalVariable(name: "t57", scope: !5093, file: !83, line: 582, type: !11)
!5297 = !DILocation(line: 705, column: 11, scope: !5093)
!5298 = !DILocalVariable(name: "t58", scope: !5093, file: !83, line: 582, type: !11)
!5299 = !DILocation(line: 706, column: 11, scope: !5093)
!5300 = !DILocalVariable(name: "t59", scope: !5093, file: !83, line: 582, type: !11)
!5301 = !DILocation(line: 707, column: 12, scope: !5093)
!5302 = !DILocalVariable(name: "t60", scope: !5093, file: !83, line: 583, type: !11)
!5303 = !DILocation(line: 708, column: 12, scope: !5093)
!5304 = !DILocalVariable(name: "t61", scope: !5093, file: !83, line: 583, type: !11)
!5305 = !DILocation(line: 709, column: 12, scope: !5093)
!5306 = !DILocalVariable(name: "t62", scope: !5093, file: !83, line: 583, type: !11)
!5307 = !DILocation(line: 710, column: 12, scope: !5093)
!5308 = !DILocalVariable(name: "t63", scope: !5093, file: !83, line: 583, type: !11)
!5309 = !DILocation(line: 711, column: 11, scope: !5093)
!5310 = !DILocalVariable(name: "t64", scope: !5093, file: !83, line: 583, type: !11)
!5311 = !DILocation(line: 712, column: 12, scope: !5093)
!5312 = !DILocalVariable(name: "t65", scope: !5093, file: !83, line: 583, type: !11)
!5313 = !DILocation(line: 713, column: 11, scope: !5093)
!5314 = !DILocalVariable(name: "t66", scope: !5093, file: !83, line: 583, type: !11)
!5315 = !DILocation(line: 714, column: 11, scope: !5093)
!5316 = !DILocalVariable(name: "s0", scope: !5093, file: !83, line: 584, type: !11)
!5317 = !DILocation(line: 715, column: 11, scope: !5093)
!5318 = !DILocalVariable(name: "s6", scope: !5093, file: !83, line: 584, type: !11)
!5319 = !DILocation(line: 716, column: 11, scope: !5093)
!5320 = !DILocalVariable(name: "s7", scope: !5093, file: !83, line: 584, type: !11)
!5321 = !DILocalVariable(name: "t67", scope: !5093, file: !83, line: 583, type: !11)
!5322 = !DILocation(line: 718, column: 11, scope: !5093)
!5323 = !DILocalVariable(name: "s3", scope: !5093, file: !83, line: 584, type: !11)
!5324 = !DILocation(line: 719, column: 11, scope: !5093)
!5325 = !DILocalVariable(name: "s4", scope: !5093, file: !83, line: 584, type: !11)
!5326 = !DILocation(line: 720, column: 11, scope: !5093)
!5327 = !DILocalVariable(name: "s5", scope: !5093, file: !83, line: 584, type: !11)
!5328 = !DILocation(line: 721, column: 11, scope: !5093)
!5329 = !DILocalVariable(name: "s1", scope: !5093, file: !83, line: 584, type: !11)
!5330 = !DILocation(line: 722, column: 11, scope: !5093)
!5331 = !DILocalVariable(name: "s2", scope: !5093, file: !83, line: 584, type: !11)
!5332 = !DILocation(line: 724, column: 2, scope: !5093)
!5333 = !DILocation(line: 724, column: 7, scope: !5093)
!5334 = !DILocation(line: 725, column: 2, scope: !5093)
!5335 = !DILocation(line: 725, column: 7, scope: !5093)
!5336 = !DILocation(line: 726, column: 2, scope: !5093)
!5337 = !DILocation(line: 726, column: 7, scope: !5093)
!5338 = !DILocation(line: 727, column: 2, scope: !5093)
!5339 = !DILocation(line: 727, column: 7, scope: !5093)
!5340 = !DILocation(line: 728, column: 2, scope: !5093)
!5341 = !DILocation(line: 728, column: 7, scope: !5093)
!5342 = !DILocation(line: 729, column: 2, scope: !5093)
!5343 = !DILocation(line: 729, column: 7, scope: !5093)
!5344 = !DILocation(line: 730, column: 2, scope: !5093)
!5345 = !DILocation(line: 730, column: 7, scope: !5093)
!5346 = !DILocation(line: 731, column: 7, scope: !5093)
!5347 = !DILocation(line: 732, column: 1, scope: !5093)
!5348 = distinct !DISubprogram(name: "shift_rows", scope: !83, file: !83, line: 901, type: !3779, scopeLine: 901, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5349 = !DILocalVariable(name: "q", arg: 1, scope: !5348, file: !83, line: 901, type: !3702)
!5350 = !DILocation(line: 0, scope: !5348)
!5351 = !DILocalVariable(name: "i", scope: !5348, file: !83, line: 902, type: !39)
!5352 = !DILocation(line: 904, column: 7, scope: !5353)
!5353 = distinct !DILexicalBlock(scope: !5348, file: !83, line: 904, column: 2)
!5354 = !DILocation(line: 904, scope: !5353)
!5355 = !DILocation(line: 904, column: 16, scope: !5356)
!5356 = distinct !DILexicalBlock(scope: !5353, file: !83, line: 904, column: 2)
!5357 = !DILocation(line: 904, column: 2, scope: !5353)
!5358 = !DILocation(line: 907, column: 7, scope: !5359)
!5359 = distinct !DILexicalBlock(scope: !5356, file: !83, line: 904, column: 26)
!5360 = !DILocalVariable(name: "x", scope: !5359, file: !83, line: 905, type: !11)
!5361 = !DILocation(line: 0, scope: !5359)
!5362 = !DILocation(line: 908, column: 13, scope: !5359)
!5363 = !DILocation(line: 908, column: 83, scope: !5359)
!5364 = !DILocation(line: 908, column: 45, scope: !5359)
!5365 = !DILocation(line: 909, column: 46, scope: !5359)
!5366 = !DILocation(line: 908, column: 89, scope: !5359)
!5367 = !DILocation(line: 909, column: 91, scope: !5359)
!5368 = !DILocation(line: 909, column: 53, scope: !5359)
!5369 = !DILocation(line: 910, column: 46, scope: !5359)
!5370 = !DILocation(line: 909, column: 97, scope: !5359)
!5371 = !DILocation(line: 910, column: 90, scope: !5359)
!5372 = !DILocation(line: 910, column: 52, scope: !5359)
!5373 = !DILocation(line: 911, column: 46, scope: !5359)
!5374 = !DILocation(line: 910, column: 97, scope: !5359)
!5375 = !DILocation(line: 908, column: 3, scope: !5359)
!5376 = !DILocation(line: 908, column: 8, scope: !5359)
!5377 = !DILocation(line: 904, column: 22, scope: !5356)
!5378 = !DILocation(line: 904, column: 2, scope: !5356)
!5379 = distinct !{!5379, !5357, !5380, !163}
!5380 = !DILocation(line: 912, column: 2, scope: !5353)
!5381 = !DILocation(line: 913, column: 1, scope: !5348)
!5382 = distinct !DISubprogram(name: "mix_columns", scope: !83, file: !83, line: 919, type: !3779, scopeLine: 919, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5383 = !DILocalVariable(name: "q", arg: 1, scope: !5382, file: !83, line: 919, type: !3702)
!5384 = !DILocation(line: 0, scope: !5382)
!5385 = !DILocation(line: 923, column: 7, scope: !5382)
!5386 = !DILocalVariable(name: "q0", scope: !5382, file: !83, line: 920, type: !11)
!5387 = !DILocation(line: 924, column: 7, scope: !5382)
!5388 = !DILocalVariable(name: "q1", scope: !5382, file: !83, line: 920, type: !11)
!5389 = !DILocation(line: 925, column: 7, scope: !5382)
!5390 = !DILocalVariable(name: "q2", scope: !5382, file: !83, line: 920, type: !11)
!5391 = !DILocation(line: 926, column: 7, scope: !5382)
!5392 = !DILocalVariable(name: "q3", scope: !5382, file: !83, line: 920, type: !11)
!5393 = !DILocation(line: 927, column: 7, scope: !5382)
!5394 = !DILocalVariable(name: "q4", scope: !5382, file: !83, line: 920, type: !11)
!5395 = !DILocation(line: 928, column: 7, scope: !5382)
!5396 = !DILocalVariable(name: "q5", scope: !5382, file: !83, line: 920, type: !11)
!5397 = !DILocation(line: 929, column: 7, scope: !5382)
!5398 = !DILocalVariable(name: "q6", scope: !5382, file: !83, line: 920, type: !11)
!5399 = !DILocation(line: 930, column: 7, scope: !5382)
!5400 = !DILocalVariable(name: "q7", scope: !5382, file: !83, line: 920, type: !11)
!5401 = !DILocation(line: 931, column: 18, scope: !5382)
!5402 = !DILocalVariable(name: "r0", scope: !5382, file: !83, line: 921, type: !11)
!5403 = !DILocation(line: 932, column: 18, scope: !5382)
!5404 = !DILocalVariable(name: "r1", scope: !5382, file: !83, line: 921, type: !11)
!5405 = !DILocation(line: 933, column: 18, scope: !5382)
!5406 = !DILocalVariable(name: "r2", scope: !5382, file: !83, line: 921, type: !11)
!5407 = !DILocation(line: 934, column: 18, scope: !5382)
!5408 = !DILocalVariable(name: "r3", scope: !5382, file: !83, line: 921, type: !11)
!5409 = !DILocation(line: 935, column: 18, scope: !5382)
!5410 = !DILocalVariable(name: "r4", scope: !5382, file: !83, line: 921, type: !11)
!5411 = !DILocation(line: 936, column: 18, scope: !5382)
!5412 = !DILocalVariable(name: "r5", scope: !5382, file: !83, line: 921, type: !11)
!5413 = !DILocation(line: 937, column: 18, scope: !5382)
!5414 = !DILocalVariable(name: "r6", scope: !5382, file: !83, line: 921, type: !11)
!5415 = !DILocation(line: 938, column: 18, scope: !5382)
!5416 = !DILocalVariable(name: "r7", scope: !5382, file: !83, line: 921, type: !11)
!5417 = !DILocation(line: 940, column: 34, scope: !5382)
!5418 = !DILocation(line: 940, column: 24, scope: !5382)
!5419 = !DILocation(line: 940, column: 22, scope: !5382)
!5420 = !DILocation(line: 940, column: 7, scope: !5382)
!5421 = !DILocation(line: 941, column: 44, scope: !5382)
!5422 = !DILocation(line: 941, column: 34, scope: !5382)
!5423 = !DILocation(line: 941, column: 32, scope: !5382)
!5424 = !DILocation(line: 941, column: 2, scope: !5382)
!5425 = !DILocation(line: 941, column: 7, scope: !5382)
!5426 = !DILocation(line: 942, column: 34, scope: !5382)
!5427 = !DILocation(line: 942, column: 24, scope: !5382)
!5428 = !DILocation(line: 942, column: 22, scope: !5382)
!5429 = !DILocation(line: 942, column: 2, scope: !5382)
!5430 = !DILocation(line: 942, column: 7, scope: !5382)
!5431 = !DILocation(line: 943, column: 44, scope: !5382)
!5432 = !DILocation(line: 943, column: 34, scope: !5382)
!5433 = !DILocation(line: 943, column: 32, scope: !5382)
!5434 = !DILocation(line: 943, column: 2, scope: !5382)
!5435 = !DILocation(line: 943, column: 7, scope: !5382)
!5436 = !DILocation(line: 944, column: 44, scope: !5382)
!5437 = !DILocation(line: 944, column: 34, scope: !5382)
!5438 = !DILocation(line: 944, column: 32, scope: !5382)
!5439 = !DILocation(line: 944, column: 2, scope: !5382)
!5440 = !DILocation(line: 944, column: 7, scope: !5382)
!5441 = !DILocation(line: 945, column: 34, scope: !5382)
!5442 = !DILocation(line: 945, column: 24, scope: !5382)
!5443 = !DILocation(line: 945, column: 22, scope: !5382)
!5444 = !DILocation(line: 945, column: 2, scope: !5382)
!5445 = !DILocation(line: 945, column: 7, scope: !5382)
!5446 = !DILocation(line: 946, column: 34, scope: !5382)
!5447 = !DILocation(line: 946, column: 24, scope: !5382)
!5448 = !DILocation(line: 946, column: 22, scope: !5382)
!5449 = !DILocation(line: 946, column: 2, scope: !5382)
!5450 = !DILocation(line: 946, column: 7, scope: !5382)
!5451 = !DILocation(line: 947, column: 34, scope: !5382)
!5452 = !DILocation(line: 947, column: 24, scope: !5382)
!5453 = !DILocation(line: 947, column: 22, scope: !5382)
!5454 = !DILocation(line: 947, column: 2, scope: !5382)
!5455 = !DILocation(line: 947, column: 7, scope: !5382)
!5456 = !DILocation(line: 948, column: 1, scope: !5382)
!5457 = distinct !DISubprogram(name: "br_aes_ct64_interleave_out", scope: !83, file: !83, line: 791, type: !5458, scopeLine: 791, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5458 = !DISubroutineType(types: !5459)
!5459 = !{null, !4830, !11, !11}
!5460 = !DILocalVariable(name: "w", arg: 1, scope: !5457, file: !83, line: 791, type: !4830)
!5461 = !DILocation(line: 0, scope: !5457)
!5462 = !DILocalVariable(name: "q0", arg: 2, scope: !5457, file: !83, line: 791, type: !11)
!5463 = !DILocalVariable(name: "q1", arg: 3, scope: !5457, file: !83, line: 791, type: !11)
!5464 = !DILocation(line: 794, column: 10, scope: !5457)
!5465 = !DILocalVariable(name: "x0", scope: !5457, file: !83, line: 792, type: !11)
!5466 = !DILocation(line: 795, column: 10, scope: !5457)
!5467 = !DILocalVariable(name: "x1", scope: !5457, file: !83, line: 792, type: !11)
!5468 = !DILocation(line: 796, column: 11, scope: !5457)
!5469 = !DILocation(line: 796, column: 17, scope: !5457)
!5470 = !DILocalVariable(name: "x2", scope: !5457, file: !83, line: 792, type: !11)
!5471 = !DILocation(line: 797, column: 11, scope: !5457)
!5472 = !DILocation(line: 797, column: 17, scope: !5457)
!5473 = !DILocalVariable(name: "x3", scope: !5457, file: !83, line: 792, type: !11)
!5474 = !DILocation(line: 798, column: 12, scope: !5457)
!5475 = !DILocation(line: 798, column: 5, scope: !5457)
!5476 = !DILocation(line: 799, column: 12, scope: !5457)
!5477 = !DILocation(line: 799, column: 5, scope: !5457)
!5478 = !DILocation(line: 800, column: 5, scope: !5457)
!5479 = !DILocation(line: 801, column: 5, scope: !5457)
!5480 = !DILocation(line: 802, column: 5, scope: !5457)
!5481 = !DILocation(line: 803, column: 5, scope: !5457)
!5482 = !DILocation(line: 806, column: 38, scope: !5457)
!5483 = !DILocation(line: 806, column: 22, scope: !5457)
!5484 = !DILocation(line: 806, column: 7, scope: !5457)
!5485 = !DILocation(line: 807, column: 38, scope: !5457)
!5486 = !DILocation(line: 807, column: 22, scope: !5457)
!5487 = !DILocation(line: 807, column: 2, scope: !5457)
!5488 = !DILocation(line: 807, column: 7, scope: !5457)
!5489 = !DILocation(line: 808, column: 38, scope: !5457)
!5490 = !DILocation(line: 808, column: 22, scope: !5457)
!5491 = !DILocation(line: 808, column: 2, scope: !5457)
!5492 = !DILocation(line: 808, column: 7, scope: !5457)
!5493 = !DILocation(line: 809, column: 38, scope: !5457)
!5494 = !DILocation(line: 809, column: 22, scope: !5457)
!5495 = !DILocation(line: 809, column: 2, scope: !5457)
!5496 = !DILocation(line: 809, column: 7, scope: !5457)
!5497 = !DILocation(line: 810, column: 1, scope: !5457)
!5498 = distinct !DISubprogram(name: "br_range_enc32le", scope: !83, file: !83, line: 553, type: !5499, scopeLine: 553, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5499 = !DISubroutineType(types: !5500)
!5500 = !{null, !263, !4874, !54}
!5501 = !DILocalVariable(name: "dst", arg: 1, scope: !5498, file: !83, line: 553, type: !263)
!5502 = !DILocation(line: 0, scope: !5498)
!5503 = !DILocalVariable(name: "v", arg: 2, scope: !5498, file: !83, line: 553, type: !4874)
!5504 = !DILocalVariable(name: "num", arg: 3, scope: !5498, file: !83, line: 553, type: !54)
!5505 = !DILocation(line: 554, column: 2, scope: !5498)
!5506 = !DILocation(line: 554, column: 15, scope: !5498)
!5507 = !DILocation(line: 554, column: 12, scope: !5498)
!5508 = !DILocation(line: 555, column: 21, scope: !5509)
!5509 = distinct !DILexicalBlock(scope: !5498, file: !83, line: 554, column: 20)
!5510 = !DILocation(line: 555, column: 19, scope: !5509)
!5511 = !DILocation(line: 555, column: 3, scope: !5509)
!5512 = !DILocation(line: 556, column: 7, scope: !5509)
!5513 = distinct !{!5513, !5505, !5514, !163}
!5514 = !DILocation(line: 557, column: 2, scope: !5498)
!5515 = !DILocation(line: 558, column: 1, scope: !5498)
!5516 = distinct !DISubprogram(name: "br_enc32le", scope: !83, file: !83, line: 539, type: !5517, scopeLine: 539, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5517 = !DISubroutineType(types: !5518)
!5518 = !{null, !263, !51}
!5519 = !DILocalVariable(name: "dst", arg: 1, scope: !5516, file: !83, line: 539, type: !263)
!5520 = !DILocation(line: 0, scope: !5516)
!5521 = !DILocalVariable(name: "x", arg: 2, scope: !5516, file: !83, line: 539, type: !51)
!5522 = !DILocation(line: 540, column: 11, scope: !5516)
!5523 = !DILocation(line: 540, column: 9, scope: !5516)
!5524 = !DILocation(line: 541, column: 29, scope: !5516)
!5525 = !DILocation(line: 541, column: 11, scope: !5516)
!5526 = !DILocation(line: 541, column: 2, scope: !5516)
!5527 = !DILocation(line: 541, column: 9, scope: !5516)
!5528 = !DILocation(line: 542, column: 29, scope: !5516)
!5529 = !DILocation(line: 542, column: 11, scope: !5516)
!5530 = !DILocation(line: 542, column: 2, scope: !5516)
!5531 = !DILocation(line: 542, column: 9, scope: !5516)
!5532 = !DILocation(line: 543, column: 29, scope: !5516)
!5533 = !DILocation(line: 543, column: 11, scope: !5516)
!5534 = !DILocation(line: 543, column: 2, scope: !5516)
!5535 = !DILocation(line: 543, column: 9, scope: !5516)
!5536 = !DILocation(line: 544, column: 1, scope: !5516)
!5537 = distinct !DISubprogram(name: "rotr32", scope: !83, file: !83, line: 915, type: !5538, scopeLine: 915, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5538 = !DISubroutineType(types: !5539)
!5539 = !{!11, !11}
!5540 = !DILocalVariable(name: "x", arg: 1, scope: !5537, file: !83, line: 915, type: !11)
!5541 = !DILocation(line: 0, scope: !5537)
!5542 = !DILocation(line: 916, column: 19, scope: !5537)
!5543 = !DILocation(line: 916, column: 2, scope: !5537)
!5544 = distinct !DISubprogram(name: "br_dec32le", scope: !83, file: !83, line: 523, type: !5545, scopeLine: 523, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5545 = !DISubroutineType(types: !5546)
!5546 = !{!51, !279}
!5547 = !DILocalVariable(name: "src", arg: 1, scope: !5544, file: !83, line: 523, type: !279)
!5548 = !DILocation(line: 0, scope: !5544)
!5549 = !DILocation(line: 524, column: 19, scope: !5544)
!5550 = !DILocation(line: 524, column: 9, scope: !5544)
!5551 = !DILocation(line: 524, column: 39, scope: !5544)
!5552 = !DILocation(line: 524, column: 29, scope: !5544)
!5553 = !DILocation(line: 524, column: 46, scope: !5544)
!5554 = !DILocation(line: 524, column: 26, scope: !5544)
!5555 = !DILocation(line: 524, column: 65, scope: !5544)
!5556 = !DILocation(line: 524, column: 55, scope: !5544)
!5557 = !DILocation(line: 524, column: 72, scope: !5544)
!5558 = !DILocation(line: 524, column: 52, scope: !5544)
!5559 = !DILocation(line: 524, column: 92, scope: !5544)
!5560 = !DILocation(line: 524, column: 82, scope: !5544)
!5561 = !DILocation(line: 524, column: 99, scope: !5544)
!5562 = !DILocation(line: 524, column: 79, scope: !5544)
!5563 = !DILocation(line: 524, column: 2, scope: !5544)
!5564 = distinct !DISubprogram(name: "br_aes_ct64_keysched", scope: !83, file: !83, line: 825, type: !5565, scopeLine: 825, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5565 = !DISubroutineType(types: !5566)
!5566 = !{null, !3702, !279, !53}
!5567 = !DILocalVariable(name: "comp_skey", arg: 1, scope: !5564, file: !83, line: 825, type: !3702)
!5568 = !DILocation(line: 0, scope: !5564)
!5569 = !DILocalVariable(name: "key", arg: 2, scope: !5564, file: !83, line: 825, type: !279)
!5570 = !DILocalVariable(name: "key_len", arg: 3, scope: !5564, file: !83, line: 825, type: !53)
!5571 = !DILocalVariable(name: "skey", scope: !5564, file: !83, line: 828, type: !5572)
!5572 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 1920, elements: !5573)
!5573 = !{!5574}
!5574 = !DISubrange(count: 60)
!5575 = !DILocation(line: 828, column: 11, scope: !5564)
!5576 = !DILocation(line: 832, column: 23, scope: !5564)
!5577 = !DILocalVariable(name: "nrounds", scope: !5564, file: !83, line: 829, type: !53)
!5578 = !DILocation(line: 831, column: 16, scope: !5564)
!5579 = !DILocalVariable(name: "nk", scope: !5564, file: !83, line: 826, type: !53)
!5580 = !DILocalVariable(name: "nkf", scope: !5564, file: !83, line: 826, type: !53)
!5581 = !DILocation(line: 833, column: 34, scope: !5564)
!5582 = !DILocation(line: 833, column: 2, scope: !5564)
!5583 = !DILocation(line: 834, column: 22, scope: !5564)
!5584 = !DILocation(line: 834, column: 28, scope: !5564)
!5585 = !DILocation(line: 834, column: 8, scope: !5564)
!5586 = !DILocalVariable(name: "tmp", scope: !5564, file: !83, line: 827, type: !51)
!5587 = !DILocalVariable(name: "i", scope: !5564, file: !83, line: 826, type: !53)
!5588 = !DILocalVariable(name: "j", scope: !5564, file: !83, line: 826, type: !53)
!5589 = !DILocalVariable(name: "k", scope: !5564, file: !83, line: 826, type: !53)
!5590 = !DILocation(line: 835, column: 7, scope: !5591)
!5591 = distinct !DILexicalBlock(scope: !5564, file: !83, line: 835, column: 2)
!5592 = !DILocation(line: 835, scope: !5591)
!5593 = !DILocation(line: 0, scope: !5591)
!5594 = !DILocation(line: 835, column: 31, scope: !5595)
!5595 = distinct !DILexicalBlock(scope: !5591, file: !83, line: 835, column: 2)
!5596 = !DILocation(line: 835, column: 2, scope: !5591)
!5597 = !DILocation(line: 850, column: 2, scope: !5598)
!5598 = distinct !DILexicalBlock(scope: !5564, file: !83, line: 850, column: 2)
!5599 = !DILocation(line: 836, column: 9, scope: !5600)
!5600 = distinct !DILexicalBlock(scope: !5601, file: !83, line: 836, column: 7)
!5601 = distinct !DILexicalBlock(scope: !5595, file: !83, line: 835, column: 43)
!5602 = !DILocation(line: 837, column: 22, scope: !5603)
!5603 = distinct !DILexicalBlock(scope: !5600, file: !83, line: 836, column: 15)
!5604 = !DILocation(line: 838, column: 10, scope: !5603)
!5605 = !DILocation(line: 838, column: 26, scope: !5603)
!5606 = !DILocation(line: 838, column: 24, scope: !5603)
!5607 = !DILocation(line: 839, column: 3, scope: !5603)
!5608 = !DILocation(line: 839, column: 17, scope: !5609)
!5609 = distinct !DILexicalBlock(scope: !5600, file: !83, line: 839, column: 14)
!5610 = !DILocation(line: 839, column: 21, scope: !5609)
!5611 = !DILocation(line: 840, column: 10, scope: !5612)
!5612 = distinct !DILexicalBlock(scope: !5609, file: !83, line: 839, column: 32)
!5613 = !DILocation(line: 841, column: 3, scope: !5612)
!5614 = !DILocation(line: 0, scope: !5600)
!5615 = !DILocation(line: 842, column: 17, scope: !5601)
!5616 = !DILocation(line: 842, column: 10, scope: !5601)
!5617 = !DILocation(line: 842, column: 7, scope: !5601)
!5618 = !DILocation(line: 843, column: 3, scope: !5601)
!5619 = !DILocation(line: 843, column: 11, scope: !5601)
!5620 = !DILocation(line: 844, column: 7, scope: !5621)
!5621 = distinct !DILexicalBlock(scope: !5601, file: !83, line: 844, column: 7)
!5622 = !DILocation(line: 844, column: 11, scope: !5621)
!5623 = !DILocation(line: 835, column: 39, scope: !5595)
!5624 = !DILocation(line: 835, column: 2, scope: !5595)
!5625 = distinct !{!5625, !5596, !5626, !163}
!5626 = !DILocation(line: 848, column: 2, scope: !5591)
!5627 = !DILocation(line: 850, scope: !5598)
!5628 = !DILocation(line: 850, column: 23, scope: !5629)
!5629 = distinct !DILexicalBlock(scope: !5598, file: !83, line: 850, column: 2)
!5630 = !DILocalVariable(name: "q", scope: !5631, file: !83, line: 851, type: !4884)
!5631 = distinct !DILexicalBlock(scope: !5629, file: !83, line: 850, column: 46)
!5632 = !DILocation(line: 851, column: 12, scope: !5631)
!5633 = !DILocation(line: 853, column: 37, scope: !5631)
!5634 = !DILocation(line: 853, column: 48, scope: !5631)
!5635 = !DILocation(line: 853, column: 3, scope: !5631)
!5636 = !DILocation(line: 854, column: 10, scope: !5631)
!5637 = !DILocation(line: 854, column: 3, scope: !5631)
!5638 = !DILocation(line: 854, column: 8, scope: !5631)
!5639 = !DILocation(line: 855, column: 3, scope: !5631)
!5640 = !DILocation(line: 855, column: 8, scope: !5631)
!5641 = !DILocation(line: 856, column: 3, scope: !5631)
!5642 = !DILocation(line: 856, column: 8, scope: !5631)
!5643 = !DILocation(line: 857, column: 10, scope: !5631)
!5644 = !DILocation(line: 857, column: 3, scope: !5631)
!5645 = !DILocation(line: 857, column: 8, scope: !5631)
!5646 = !DILocation(line: 858, column: 3, scope: !5631)
!5647 = !DILocation(line: 858, column: 8, scope: !5631)
!5648 = !DILocation(line: 859, column: 3, scope: !5631)
!5649 = !DILocation(line: 859, column: 8, scope: !5631)
!5650 = !DILocation(line: 860, column: 3, scope: !5631)
!5651 = !DILocation(line: 861, column: 23, scope: !5631)
!5652 = !DILocation(line: 861, column: 28, scope: !5631)
!5653 = !DILocation(line: 861, column: 63, scope: !5631)
!5654 = !DILocation(line: 861, column: 68, scope: !5631)
!5655 = !DILocation(line: 861, column: 60, scope: !5631)
!5656 = !DILocation(line: 862, column: 23, scope: !5631)
!5657 = !DILocation(line: 862, column: 28, scope: !5631)
!5658 = !DILocation(line: 861, column: 100, scope: !5631)
!5659 = !DILocation(line: 862, column: 63, scope: !5631)
!5660 = !DILocation(line: 862, column: 68, scope: !5631)
!5661 = !DILocation(line: 862, column: 60, scope: !5631)
!5662 = !DILocation(line: 861, column: 3, scope: !5631)
!5663 = !DILocation(line: 861, column: 20, scope: !5631)
!5664 = !DILocation(line: 863, column: 23, scope: !5631)
!5665 = !DILocation(line: 863, column: 28, scope: !5631)
!5666 = !DILocation(line: 863, column: 63, scope: !5631)
!5667 = !DILocation(line: 863, column: 68, scope: !5631)
!5668 = !DILocation(line: 863, column: 60, scope: !5631)
!5669 = !DILocation(line: 864, column: 23, scope: !5631)
!5670 = !DILocation(line: 864, column: 28, scope: !5631)
!5671 = !DILocation(line: 863, column: 100, scope: !5631)
!5672 = !DILocation(line: 864, column: 63, scope: !5631)
!5673 = !DILocation(line: 864, column: 68, scope: !5631)
!5674 = !DILocation(line: 864, column: 60, scope: !5631)
!5675 = !DILocation(line: 863, column: 15, scope: !5631)
!5676 = !DILocation(line: 863, column: 3, scope: !5631)
!5677 = !DILocation(line: 863, column: 20, scope: !5631)
!5678 = !DILocation(line: 850, column: 32, scope: !5629)
!5679 = !DILocation(line: 850, column: 40, scope: !5629)
!5680 = !DILocation(line: 850, column: 2, scope: !5629)
!5681 = distinct !{!5681, !5597, !5682, !163}
!5682 = !DILocation(line: 865, column: 2, scope: !5598)
!5683 = !DILocation(line: 866, column: 1, scope: !5564)
!5684 = distinct !DISubprogram(name: "br_aes_ct64_skey_expand", scope: !83, file: !83, line: 868, type: !5685, scopeLine: 868, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5685 = !DISubroutineType(types: !5686)
!5686 = !{null, !3702, !4760, !53}
!5687 = !DILocalVariable(name: "skey", arg: 1, scope: !5684, file: !83, line: 868, type: !3702)
!5688 = !DILocation(line: 0, scope: !5684)
!5689 = !DILocalVariable(name: "comp_skey", arg: 2, scope: !5684, file: !83, line: 868, type: !4760)
!5690 = !DILocalVariable(name: "nrounds", arg: 3, scope: !5684, file: !83, line: 868, type: !53)
!5691 = !DILocation(line: 871, column: 20, scope: !5684)
!5692 = !DILocalVariable(name: "n", scope: !5684, file: !83, line: 869, type: !53)
!5693 = !DILocalVariable(name: "u", scope: !5684, file: !83, line: 869, type: !53)
!5694 = !DILocalVariable(name: "v", scope: !5684, file: !83, line: 869, type: !53)
!5695 = !DILocation(line: 872, column: 7, scope: !5696)
!5696 = distinct !DILexicalBlock(scope: !5684, file: !83, line: 872, column: 2)
!5697 = !DILocation(line: 872, scope: !5696)
!5698 = !DILocation(line: 872, column: 23, scope: !5699)
!5699 = distinct !DILexicalBlock(scope: !5696, file: !83, line: 872, column: 2)
!5700 = !DILocation(line: 872, column: 2, scope: !5696)
!5701 = !DILocation(line: 875, column: 23, scope: !5702)
!5702 = distinct !DILexicalBlock(scope: !5699, file: !83, line: 872, column: 41)
!5703 = !DILocalVariable(name: "x3", scope: !5702, file: !83, line: 873, type: !11)
!5704 = !DILocation(line: 0, scope: !5702)
!5705 = !DILocalVariable(name: "x2", scope: !5702, file: !83, line: 873, type: !11)
!5706 = !DILocalVariable(name: "x1", scope: !5702, file: !83, line: 873, type: !11)
!5707 = !DILocalVariable(name: "x0", scope: !5702, file: !83, line: 873, type: !11)
!5708 = !DILocation(line: 876, column: 6, scope: !5702)
!5709 = !DILocation(line: 880, column: 6, scope: !5702)
!5710 = !DILocation(line: 881, column: 6, scope: !5702)
!5711 = !DILocation(line: 882, column: 6, scope: !5702)
!5712 = !DILocation(line: 883, column: 27, scope: !5702)
!5713 = !DILocation(line: 883, column: 3, scope: !5702)
!5714 = !DILocation(line: 883, column: 15, scope: !5702)
!5715 = !DILocation(line: 884, column: 27, scope: !5702)
!5716 = !DILocation(line: 884, column: 10, scope: !5702)
!5717 = !DILocation(line: 884, column: 3, scope: !5702)
!5718 = !DILocation(line: 884, column: 15, scope: !5702)
!5719 = !DILocation(line: 885, column: 27, scope: !5702)
!5720 = !DILocation(line: 885, column: 10, scope: !5702)
!5721 = !DILocation(line: 885, column: 3, scope: !5702)
!5722 = !DILocation(line: 885, column: 15, scope: !5702)
!5723 = !DILocation(line: 886, column: 27, scope: !5702)
!5724 = !DILocation(line: 886, column: 10, scope: !5702)
!5725 = !DILocation(line: 886, column: 3, scope: !5702)
!5726 = !DILocation(line: 886, column: 15, scope: !5702)
!5727 = !DILocation(line: 872, column: 29, scope: !5699)
!5728 = !DILocation(line: 872, column: 35, scope: !5699)
!5729 = !DILocation(line: 872, column: 2, scope: !5699)
!5730 = distinct !{!5730, !5700, !5731, !163}
!5731 = !DILocation(line: 887, column: 2, scope: !5696)
!5732 = !DILocation(line: 888, column: 1, scope: !5684)
!5733 = distinct !DISubprogram(name: "sub_word", scope: !83, file: !83, line: 814, type: !4847, scopeLine: 814, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5734 = !DILocalVariable(name: "x", arg: 1, scope: !5733, file: !83, line: 814, type: !51)
!5735 = !DILocation(line: 0, scope: !5733)
!5736 = !DILocalVariable(name: "q", scope: !5733, file: !83, line: 815, type: !4884)
!5737 = !DILocation(line: 815, column: 11, scope: !5733)
!5738 = !DILocation(line: 817, column: 2, scope: !5733)
!5739 = !DILocation(line: 818, column: 9, scope: !5733)
!5740 = !DILocation(line: 818, column: 7, scope: !5733)
!5741 = !DILocation(line: 819, column: 2, scope: !5733)
!5742 = !DILocation(line: 820, column: 2, scope: !5733)
!5743 = !DILocation(line: 821, column: 2, scope: !5733)
!5744 = !DILocation(line: 822, column: 19, scope: !5733)
!5745 = !DILocation(line: 822, column: 9, scope: !5733)
!5746 = !DILocation(line: 822, column: 2, scope: !5733)
!5747 = distinct !DISubprogram(name: "AES128_ECB", scope: !83, file: !83, line: 1790, type: !5748, scopeLine: 1790, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5748 = !DISubroutineType(types: !5749)
!5749 = !{null, !279, !241, !263, !54}
!5750 = !DILocalVariable(name: "key", arg: 1, scope: !5747, file: !83, line: 1790, type: !279)
!5751 = !DILocation(line: 0, scope: !5747)
!5752 = !DILocalVariable(name: "input", arg: 2, scope: !5747, file: !83, line: 1790, type: !241)
!5753 = !DILocalVariable(name: "output", arg: 3, scope: !5747, file: !83, line: 1790, type: !263)
!5754 = !DILocalVariable(name: "num", arg: 4, scope: !5747, file: !83, line: 1790, type: !54)
!5755 = !DILocalVariable(name: "schedule", scope: !5747, file: !83, line: 1791, type: !66)
!5756 = !DILocation(line: 1791, column: 8, scope: !5747)
!5757 = !DILocation(line: 1792, column: 2, scope: !5747)
!5758 = !DILocation(line: 1793, column: 39, scope: !5747)
!5759 = !DILocation(line: 1793, column: 2, scope: !5747)
!5760 = !DILocation(line: 1794, column: 29, scope: !5747)
!5761 = !DILocation(line: 1794, column: 2, scope: !5747)
!5762 = !DILocation(line: 1795, column: 1, scope: !5747)
!5763 = distinct !DISubprogram(name: "oqs_aes128_ecb_enc_sch_c", scope: !83, file: !83, line: 1224, type: !5764, scopeLine: 1225, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5764 = !DISubroutineType(types: !5765)
!5765 = !{null, !241, !1207, !233, !5}
!5766 = !DILocalVariable(name: "plaintext", arg: 1, scope: !5763, file: !83, line: 1224, type: !241)
!5767 = !DILocation(line: 0, scope: !5763)
!5768 = !DILocalVariable(name: "plaintext_len", arg: 2, scope: !5763, file: !83, line: 1224, type: !1207)
!5769 = !DILocalVariable(name: "schedule", arg: 3, scope: !5763, file: !83, line: 1224, type: !233)
!5770 = !DILocalVariable(name: "ciphertext", arg: 4, scope: !5763, file: !83, line: 1225, type: !5)
!5771 = !DILocation(line: 1226, column: 2, scope: !5763)
!5772 = !DILocalVariable(name: "ctx", scope: !5763, file: !83, line: 1227, type: !106)
!5773 = !DILocation(line: 1228, column: 47, scope: !5763)
!5774 = !DILocation(line: 1228, column: 2, scope: !5763)
!5775 = !DILocation(line: 1229, column: 1, scope: !5763)
!5776 = distinct !DISubprogram(name: "aes_ecb", scope: !83, file: !83, line: 994, type: !5777, scopeLine: 994, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5777 = !DISubroutineType(types: !5778)
!5778 = !{null, !263, !279, !54, !4760, !53}
!5779 = !DILocalVariable(name: "out", arg: 1, scope: !5776, file: !83, line: 994, type: !263)
!5780 = !DILocation(line: 0, scope: !5776)
!5781 = !DILocalVariable(name: "in", arg: 2, scope: !5776, file: !83, line: 994, type: !279)
!5782 = !DILocalVariable(name: "nblocks", arg: 3, scope: !5776, file: !83, line: 994, type: !54)
!5783 = !DILocalVariable(name: "rkeys", arg: 4, scope: !5776, file: !83, line: 994, type: !4760)
!5784 = !DILocalVariable(name: "nrounds", arg: 5, scope: !5776, file: !83, line: 994, type: !53)
!5785 = !DILocalVariable(name: "blocks", scope: !5776, file: !83, line: 995, type: !4769)
!5786 = !DILocation(line: 995, column: 11, scope: !5776)
!5787 = !DILocalVariable(name: "t", scope: !5776, file: !83, line: 996, type: !4808)
!5788 = !DILocation(line: 996, column: 16, scope: !5776)
!5789 = !DILocation(line: 998, column: 2, scope: !5776)
!5790 = !DILocation(line: 998, column: 17, scope: !5776)
!5791 = !DILocation(line: 999, column: 3, scope: !5792)
!5792 = distinct !DILexicalBlock(scope: !5776, file: !83, line: 998, column: 23)
!5793 = !DILocation(line: 1000, column: 3, scope: !5792)
!5794 = !DILocation(line: 1001, column: 11, scope: !5792)
!5795 = !DILocation(line: 1002, column: 6, scope: !5792)
!5796 = !DILocation(line: 1003, column: 7, scope: !5792)
!5797 = distinct !{!5797, !5789, !5798, !163}
!5798 = !DILocation(line: 1004, column: 2, scope: !5776)
!5799 = !DILocation(line: 1006, column: 6, scope: !5800)
!5800 = distinct !DILexicalBlock(scope: !5776, file: !83, line: 1006, column: 6)
!5801 = !DILocation(line: 1007, column: 36, scope: !5802)
!5802 = distinct !DILexicalBlock(scope: !5800, file: !83, line: 1006, column: 15)
!5803 = !DILocation(line: 1007, column: 3, scope: !5802)
!5804 = !DILocation(line: 1008, column: 3, scope: !5802)
!5805 = !DILocation(line: 1009, column: 26, scope: !5802)
!5806 = !DILocation(line: 1009, column: 3, scope: !5802)
!5807 = !DILocation(line: 1010, column: 2, scope: !5802)
!5808 = !DILocation(line: 1011, column: 1, scope: !5776)
!5809 = distinct !DISubprogram(name: "AES256_ECB", scope: !83, file: !83, line: 1797, type: !5810, scopeLine: 1797, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5810 = !DISubroutineType(types: !5811)
!5811 = !{null, !279, !241, !263}
!5812 = !DILocalVariable(name: "key", arg: 1, scope: !5809, file: !83, line: 1797, type: !279)
!5813 = !DILocation(line: 0, scope: !5809)
!5814 = !DILocalVariable(name: "input", arg: 2, scope: !5809, file: !83, line: 1797, type: !241)
!5815 = !DILocalVariable(name: "output", arg: 3, scope: !5809, file: !83, line: 1797, type: !263)
!5816 = !DILocalVariable(name: "schedule", scope: !5809, file: !83, line: 1798, type: !66)
!5817 = !DILocation(line: 1798, column: 8, scope: !5809)
!5818 = !DILocation(line: 1799, column: 2, scope: !5809)
!5819 = !DILocation(line: 1800, column: 38, scope: !5809)
!5820 = !DILocation(line: 1800, column: 2, scope: !5809)
!5821 = !DILocation(line: 1801, column: 29, scope: !5809)
!5822 = !DILocation(line: 1801, column: 2, scope: !5809)
!5823 = !DILocation(line: 1802, column: 1, scope: !5809)
!5824 = distinct !DISubprogram(name: "oqs_aes256_load_schedule_c", scope: !83, file: !83, line: 1124, type: !4700, scopeLine: 1124, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5825 = !DILocalVariable(name: "key", arg: 1, scope: !5824, file: !83, line: 1124, type: !241)
!5826 = !DILocation(line: 0, scope: !5824)
!5827 = !DILocalVariable(name: "_schedule", arg: 2, scope: !5824, file: !83, line: 1124, type: !4702)
!5828 = !DILocation(line: 1125, column: 15, scope: !5824)
!5829 = !DILocation(line: 1125, column: 13, scope: !5824)
!5830 = !DILocation(line: 1126, column: 2, scope: !5831)
!5831 = distinct !DILexicalBlock(scope: !5832, file: !83, line: 1126, column: 2)
!5832 = distinct !DILexicalBlock(scope: !5824, file: !83, line: 1126, column: 2)
!5833 = !DILocation(line: 1126, column: 2, scope: !5834)
!5834 = distinct !DILexicalBlock(scope: !5831, file: !83, line: 1126, column: 2)
!5835 = !DILocation(line: 1127, column: 32, scope: !5824)
!5836 = !DILocalVariable(name: "ctx", scope: !5824, file: !83, line: 1127, type: !108)
!5837 = !DILocalVariable(name: "skey", scope: !5824, file: !83, line: 1128, type: !5838)
!5838 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 1920, elements: !5839)
!5839 = !{!5840}
!5840 = !DISubrange(count: 30)
!5841 = !DILocation(line: 1128, column: 11, scope: !5824)
!5842 = !DILocation(line: 1129, column: 2, scope: !5824)
!5843 = !DILocation(line: 1130, column: 2, scope: !5824)
!5844 = !DILocation(line: 1131, column: 1, scope: !5824)
!5845 = distinct !DISubprogram(name: "oqs_aes256_ecb_enc_sch_c", scope: !83, file: !83, line: 1242, type: !5764, scopeLine: 1243, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5846 = !DILocalVariable(name: "plaintext", arg: 1, scope: !5845, file: !83, line: 1242, type: !241)
!5847 = !DILocation(line: 0, scope: !5845)
!5848 = !DILocalVariable(name: "plaintext_len", arg: 2, scope: !5845, file: !83, line: 1242, type: !1207)
!5849 = !DILocalVariable(name: "schedule", arg: 3, scope: !5845, file: !83, line: 1242, type: !233)
!5850 = !DILocalVariable(name: "ciphertext", arg: 4, scope: !5845, file: !83, line: 1243, type: !5)
!5851 = !DILocalVariable(name: "ctx", scope: !5845, file: !83, line: 1245, type: !117)
!5852 = !DILocation(line: 1246, column: 2, scope: !5845)
!5853 = !DILocation(line: 1247, column: 1, scope: !5845)
!5854 = distinct !DISubprogram(name: "oqs_aes256_free_schedule_c", scope: !83, file: !83, line: 1267, type: !4736, scopeLine: 1267, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !94, retainedNodes: !141)
!5855 = !DILocalVariable(name: "schedule", arg: 1, scope: !5854, file: !83, line: 1267, type: !66)
!5856 = !DILocation(line: 0, scope: !5854)
!5857 = !DILocation(line: 1268, column: 15, scope: !5858)
!5858 = distinct !DILexicalBlock(scope: !5854, file: !83, line: 1268, column: 6)
!5859 = !DILocalVariable(name: "ctx", scope: !5860, file: !83, line: 1269, type: !108)
!5860 = distinct !DILexicalBlock(scope: !5858, file: !83, line: 1268, column: 24)
!5861 = !DILocation(line: 0, scope: !5860)
!5862 = !DILocation(line: 1270, column: 3, scope: !5860)
!5863 = !DILocation(line: 1271, column: 2, scope: !5860)
!5864 = !DILocation(line: 1272, column: 1, scope: !5854)
