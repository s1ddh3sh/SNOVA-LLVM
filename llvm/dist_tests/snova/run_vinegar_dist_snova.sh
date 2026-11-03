#!/usr/bin/env bash
#
# run_vinegar_dist_snova.sh — run vinegar_dist_snova.py's secret-dependence
# distribution test for one SNOVA function, once per faulty gated ELF found
# under build/test_snova/<func_name>, against that function's correct gated ELF.
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
# Build the gated ELFs first:
#   (cd llvm/fault_types && ./fuseback_gen.sh)        # fuse faults -> gated .ll
#   (cd llvm && ./dist_tests/snova/snova_build.sh test_snova/<func_name>)  # .ll -> .elf
#
# For each faulty ELF, the test's stdout/report are stored in the equivalent
# subdirectory under test_snova/<func_name>/, e.g.:
#   build/test_snova/_SNOVA_I_S_AES_ref_sign/loopOrFuncSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_fnSkip_shake_absorb_line168.elf
#     -> test_snova/_SNOVA_I_S_AES_ref_sign/loopOrFuncSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_fnSkip_shake_absorb_line168/vinegar_dist_result.txt
#        .../vinegar_dist_report.json
#
# Usage:
#   ./run_vinegar_dist_snova.sh <func_name> [--elf-dir DIR] [--n-seeds N] [--seed N] [--no-build]
#
# Examples:
#   ./run_vinegar_dist_snova.sh _SNOVA_I_S_AES_ref_sign
#   ./run_vinegar_dist_snova.sh _SNOVA_I_S_AES_ref_sign --n-seeds 64

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <func_name> [--elf-dir DIR] [--n-seeds N] [--seed N] [--no-build]" >&2
    exit 1
fi

FUNC_NAME="$1"; shift
PROBE_FUNC="_SNOVA_I_S_AES_ref_sign"

# Anchor every path to this script's location so the driver works from any cwd.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LLVM_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
PROBE_PY="${SCRIPT_DIR}/vinegar_dist_snova.py"
SNOVA_BUILD="${SCRIPT_DIR}/snova_build.sh"

SRC_DIR="${LLVM_DIR}/test_snova/${FUNC_NAME}"          # the .ll tree
OUT_DIR="${LLVM_DIR}/test_snova/${FUNC_NAME}"          # where results are written
ELF_DIR="${LLVM_DIR}/build/test_snova/${FUNC_NAME}"    # the compiled ELFs
ELF_DIR_DEFAULT=1
N_SEEDS=""
SEED=""
NO_BUILD=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --elf-dir) ELF_DIR="$2"; ELF_DIR_DEFAULT=0; shift 2 ;;
        --n-seeds) N_SEEDS="$2"; shift 2 ;;
        --seed) SEED="$2"; shift 2 ;;
        --no-build) NO_BUILD=1; shift ;;
        *) echo "[!] unrecognized argument: $1" >&2; exit 1 ;;
    esac
done

[[ -f "$PROBE_PY" ]] || { echo "[!] required script not found: $PROBE_PY" >&2; exit 1; }

CORRECT_ELF="${ELF_DIR}/full_snova_gated/gated_${FUNC_NAME}.elf"

# Build the gated ELFs on demand: if they are not present under the default
# ELF dir, compile the function's .ll tree with snova_build.sh. A custom
# --elf-dir is assumed to be a prebuilt tree the caller manages, so no
# auto-build is attempted for it.
if [[ ! -f "$CORRECT_ELF" && "$NO_BUILD" -eq 0 && "$ELF_DIR_DEFAULT" -eq 1 ]]; then
    if [[ ! -d "$SRC_DIR" ]]; then
        echo "[!] no ELFs under $ELF_DIR and no source IR under $SRC_DIR" >&2
        echo "    generate the gated .ll first: (cd ${LLVM_DIR}/fault_types && ./fuseback_gen.sh)" >&2
        exit 1
    fi
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
