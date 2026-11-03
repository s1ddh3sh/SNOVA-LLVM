#!/usr/bin/env bash
#
# run_vinegar_dist_snova.sh — run vinegar_dist_snova.py's secret-dependence
# distribution test for one SNOVA function, once per faulty gated ELF found
# under build/test_snova/<func_name>, against that function's correct gated ELF.
#
# With NO func_name, it sweeps EVERY function key listed in snova.json (repo
# root), re-invoking itself once per key.
#
# Like run_weak_system_snova.sh, the observation point is ALWAYS
# _SNOVA_I_S_AES_ref_sign (the signing call whose vinegar is captured),
# regardless of <func_name>: the faulty ELF's injected fault may live anywhere
# in the call tree (sign itself, shake_absorb, expand_T12, ...), but the target
# we read -- the vinegar -- is the same. <func_name> only selects which
# full_snova_gated/ ELF pair to test.
#
# ELF layout assumed (default --elf-dir is build/test_snova/<func_name>):
#   <elf-dir>/full_snova_gated/gated_<func_name>.elf  -- the correct build
#   <elf-dir>/**/full_snova_gated/*.elf               -- every other gated
#                                  .elf (searched recursively) is a faulty
#                                  variant, tested one at a time against the
#                                  correct build.
#
# The gated builds are produced ON DEMAND: if the correct gated ELF is not
# present under the default --elf-dir, this driver builds whatever is missing:
#   1. gated whole-program .ll (correct + faulty), by fusing each per-function
#      .ll back into the base program:  fuseback_gen.sh <func_name>
#   2. the ELFs, by compiling those .ll: snova_build.sh test_snova/<func_name>
# Only the per-function .ll (from run_faults.sh) need pre-exist. Pass
# --no-build to disable, or --elf-dir to point at a prebuilt tree.
#
# For each faulty ELF, the test's stdout/report are stored in the equivalent
# subdirectory under test_snova/<func_name>/, e.g.:
#   build/test_snova/_SNOVA_I_S_AES_ref_sign/loopOrFuncSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_fnSkip_shake_absorb_line168.elf
#     -> test_snova/_SNOVA_I_S_AES_ref_sign/loopOrFuncSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_fnSkip_shake_absorb_line168/vinegar_dist_result.txt
#        .../vinegar_dist_report.json
#
# Usage:
#   ./run_vinegar_dist_snova.sh [func_name] [--elf-dir DIR] [--n-seeds N] [--seed N] [--no-build] [--snova-json FILE]
#
# Examples:
#   ./run_vinegar_dist_snova.sh                            # all functions in snova.json
#   ./run_vinegar_dist_snova.sh _SNOVA_I_S_AES_ref_sign
#   ./run_vinegar_dist_snova.sh _SNOVA_I_S_AES_ref_sign --n-seeds 64

set -euo pipefail

PROBE_FUNC="_SNOVA_I_S_AES_ref_sign"

# Anchor every path to this script's location so the driver works from any cwd.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LLVM_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
PROBE_PY="${SCRIPT_DIR}/vinegar_dist_snova.py"
SNOVA_BUILD="${SCRIPT_DIR}/snova_build.sh"
FUSEBACK_GEN="${LLVM_DIR}/fault_types/fuseback_gen.sh"
SNOVA_JSON="$(cd "${LLVM_DIR}/.." && pwd)/snova.json"

# Parse args. The function name is an optional positional: if omitted, the
# driver runs every function key listed in snova.json. Options are collected
# into PASS_ARGS so they can be forwarded to the per-function self-invocations.
FUNC_NAME=""
ELF_DIR=""
ELF_DIR_DEFAULT=1
N_SEEDS=""
SEED=""
NO_BUILD=0
PASS_ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --elf-dir) ELF_DIR="$2"; ELF_DIR_DEFAULT=0; PASS_ARGS+=(--elf-dir "$2"); shift 2 ;;
        --n-seeds) N_SEEDS="$2"; PASS_ARGS+=(--n-seeds "$2"); shift 2 ;;
        --seed) SEED="$2"; PASS_ARGS+=(--seed "$2"); shift 2 ;;
        --no-build) NO_BUILD=1; PASS_ARGS+=(--no-build); shift ;;
        --snova-json) SNOVA_JSON="$2"; shift 2 ;;
        -h|--help) echo "Usage: $0 [func_name] [--elf-dir DIR] [--n-seeds N] [--seed N] [--no-build] [--snova-json FILE]"; exit 0 ;;
        --*) echo "[!] unrecognized argument: $1" >&2; exit 1 ;;
        *) if [[ -z "$FUNC_NAME" ]]; then FUNC_NAME="$1"; else echo "[!] unexpected extra argument: $1" >&2; exit 1; fi; shift ;;
    esac
done

[[ -f "$PROBE_PY" ]] || { echo "[!] required script not found: $PROBE_PY" >&2; exit 1; }

# No function name -> sweep every function key in snova.json, by re-invoking
# this script once per key (each run does its own on-demand build + sweep).
if [[ -z "$FUNC_NAME" ]]; then
    [[ -f "$SNOVA_JSON" ]] || { echo "[!] snova.json not found: $SNOVA_JSON (pass --snova-json FILE)" >&2; exit 1; }
    mapfile -t ALL_FUNCS < <(python3 -c 'import json,sys; [print(k) for k in json.load(open(sys.argv[1]))]' "$SNOVA_JSON")
    [[ ${#ALL_FUNCS[@]} -gt 0 ]] || { echo "[!] no function keys found in $SNOVA_JSON" >&2; exit 1; }
    echo "[i] no function specified -- sweeping all ${#ALL_FUNCS[@]} function(s) from ${SNOVA_JSON}"
    printf '       - %s\n' "${ALL_FUNCS[@]}"
    rc=0; ndet=0; nfail=0
    for fn in "${ALL_FUNCS[@]}"; do
        echo ""
        echo "##############################################################"
        echo "# FUNCTION: ${fn}"
        echo "##############################################################"
        set +e
        "${BASH_SOURCE[0]}" "$fn" "${PASS_ARGS[@]}"
        st=$?
        set -e
        if [[ $st -eq 1 ]]; then ndet=$((ndet+1)); elif [[ $st -ne 0 ]]; then nfail=$((nfail+1)); rc=2; fi
    done
    echo ""
    echo "================================================================"
    echo "=== ALL-FUNCTION sweep complete: ${#ALL_FUNCS[@]} function(s) ==="
    echo "================================================================"
    echo "[i] ${ndet} function(s) flagged a secret-dependence collapse; ${nfail} errored out"
    exit $rc
fi

# Per-function mode: resolve the paths that depend on the function name.
SRC_DIR="${LLVM_DIR}/test_snova/${FUNC_NAME}"          # the .ll tree
OUT_DIR="${LLVM_DIR}/test_snova/${FUNC_NAME}"          # where results are written
[[ -n "$ELF_DIR" ]] || ELF_DIR="${LLVM_DIR}/build/test_snova/${FUNC_NAME}"  # the compiled ELFs

CORRECT_ELF="${ELF_DIR}/full_snova_gated/gated_${FUNC_NAME}.elf"
CORRECT_GATED_LL="${SRC_DIR}/full_snova_gated/gated_${FUNC_NAME}.ll"

# Build the gated ELFs on demand: if the correct gated ELF is not present
# under the default ELF dir, (re)generate what is missing and compile. A
# custom --elf-dir is assumed to be a prebuilt tree the caller manages, so no
# auto-build is attempted for it.
#
# Two things can be missing:
#   1. the gated whole-program .ll (correct + faulty) -- produced by fusing
#      each per-function .ll back into the base program (fuseback_gen.sh).
#      Fusing the unmodified <func>.ll is what yields the CORRECT gated build.
#   2. the ELFs -- compiled from those .ll by snova_build.sh.
if [[ ! -f "$CORRECT_ELF" && "$NO_BUILD" -eq 0 && "$ELF_DIR_DEFAULT" -eq 1 ]]; then
    if [[ ! -d "$SRC_DIR" ]]; then
        echo "[!] no ELFs under $ELF_DIR and no source IR under $SRC_DIR" >&2
        echo "    inject faults first: (cd ${LLVM_DIR}/fault_types && ./run_faults.sh ${FUNC_NAME})" >&2
        exit 1
    fi
    # (1) fuse the gated whole-program .ll (incl. the correct build) if absent.
    if [[ ! -f "$CORRECT_GATED_LL" ]]; then
        echo "[i] gated whole-program .ll missing under ${SRC_DIR}/full_snova_gated/"
        echo "[i] fusing them (correct + faulty) via fuseback_gen.sh ${FUNC_NAME} ..."
        "$FUSEBACK_GEN" "$FUNC_NAME"
    fi
    [[ -f "$CORRECT_GATED_LL" ]] || { echo "[!] correct gated .ll still missing after fusing: $CORRECT_GATED_LL" >&2; exit 1; }
    # (2) compile every gated .ll (incl. the correct build) to ELFs.
    echo "[i] gated ELFs not found under ${ELF_DIR}"
    echo "[i] building them from ${SRC_DIR} via snova_build.sh ..."
    "$SNOVA_BUILD" "$SRC_DIR"
    echo "[i] build complete."
fi

[[ -d "$ELF_DIR" ]] || { echo "[!] elf dir not found: $ELF_DIR (build gated ELFs first -- see header)" >&2; exit 1; }
[[ -f "$CORRECT_ELF" ]] || { echo "[!] correct elf not found: $CORRECT_ELF (build may have failed)" >&2; exit 1; }

# Faulty builds are nested several directories deep, so this must be a
# recursive search, not a flat glob. Only whole-program full_snova_gated/
# builds are valid targets, so anything outside a full_snova_gated/ directory
# is skipped.
FAULTY_ELFS=()
while IFS= read -r -d '' f; do
    FAULTY_ELFS+=("$f")
done < <(find "$ELF_DIR" -type f -name '*.elf' -path '*/full_snova_gated/*' -not -samefile "$CORRECT_ELF" -print0 | sort -z)

if [[ ${#FAULTY_ELFS[@]} -eq 0 ]]; then
    echo "[!] no faulty gated ELFs found under $ELF_DIR (besides $CORRECT_ELF)" >&2
    exit 1
fi

echo "[i] function:     ${FUNC_NAME} (observation point: ${PROBE_FUNC})"
echo "[i] correct elf:   ${CORRECT_ELF}"
echo "[i] faulty elfs:   ${#FAULTY_ELFS[@]} found under ${ELF_DIR}"
for f in "${FAULTY_ELFS[@]}"; do
    echo "                    - ${f#${ELF_DIR}/}"
done

EXTRA_ARGS=(--func "$PROBE_FUNC")
[[ -n "$N_SEEDS" ]] && EXTRA_ARGS+=(--n-seeds "$N_SEEDS")
[[ -n "$SEED" ]] && EXTRA_ARGS+=(--seed "$SEED")

echo ""
echo "########## vinegar_dist_snova (${#FAULTY_ELFS[@]} faulty ELF(s)) ##########"

FAILS=0
DETECTED=0
for faulty_elf in "${FAULTY_ELFS[@]}"; do
    # Mirror the faulty ELF's path (relative to ELF_DIR, minus .elf) under
    # test_snova/<func_name>/.
    REL="${faulty_elf#${ELF_DIR}/}"
    REL="${REL%.elf}"
    RESULT_DIR="${OUT_DIR}/${REL}"
    mkdir -p "$RESULT_DIR"

    echo ""
    echo "--- vinegar_dist_snova: ${FUNC_NAME} / ${REL} ---"
    set +e
    python3 "$PROBE_PY" \
        --correct-elf "$CORRECT_ELF" \
        --faulty-elf "$faulty_elf" \
        --report "${RESULT_DIR}/vinegar_dist_report.json" \
        "${EXTRA_ARGS[@]}" \
        2>&1 | tee "${RESULT_DIR}/vinegar_dist_result.txt"
    status="${PIPESTATUS[0]}"
    set -e
    # exit 1 = collapse detected (valid verdict), 0 = no collapse, 2 = emu error
    if [[ "$status" -eq 1 ]]; then
        DETECTED=$((DETECTED + 1))
    elif [[ "$status" -ne 0 ]]; then
        echo "[!] test failed (exit ${status}) for ${faulty_elf}" >&2
        FAILS=$((FAILS + 1))
    fi
done

echo ""
echo "=== vinegar_dist_snova sweep complete: ${FUNC_NAME} (${#FAULTY_ELFS[@]} faulty ELF(s)) ==="
echo "[i] ${DETECTED} ELF(s) flagged a secret-dependence collapse (full or partial)"
echo "[i] per-faulty-ELF results under: test_snova/${FUNC_NAME}/<faulty_elf_relpath>/vinegar_dist_result.txt"

if [[ "$FAILS" -gt 0 ]]; then
    echo "[!] ${FAILS} faulty ELF(s) errored out (emulation failure, not just verdict)" >&2
    exit 2
fi
