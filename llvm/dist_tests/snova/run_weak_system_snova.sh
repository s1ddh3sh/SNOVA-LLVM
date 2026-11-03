#!/usr/bin/env bash
#
# run_weak_system_snova.sh — run weak_system_snova.py's GF(16)-linearity
# probe for one SNOVA function, once per faulty gated ELF found under
# build/test_snova/<func_name>, against that function's correct gated ELF.
#
# The probe's --func is ALWAYS _SNOVA_I_S_AES_ref_sign, regardless of
# <func_name>: per weak_system_snova.py's docstring, the signature is the
# fixed observation point, no matter where in the call tree (sign itself,
# gf_set_add, shake*, expand_T12, ...) a given <func_name>'s fault lives.
# <func_name> only selects which full_snova_gated/ ELF pair to test.
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
# For each faulty ELF, the probe's stdout/report are stored in the
# equivalent subdirectory under test_snova/<func_name>/, e.g.:
#   build/test_snova/_SNOVA_I_S_AES_ref_sign/loadStoreSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_line911_mem.elf
#     -> test_snova/_SNOVA_I_S_AES_ref_sign/loadStoreSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_line911_mem/weak_system_snova_result.txt
#        .../weak_system_snova_report.json
#
# Usage:
#   ./run_weak_system_snova.sh <func_name> [--elf-dir DIR] \
#       [--positions POSLIST] [--n-tests N] [--seed N] [--call-index N] \
#       [--min-nonzero N] [--max-nonzero-faulty N]
#
# --positions defaults to "16-47" (the skx private-seed bytes that
# expand_T12() turns into the secret map T12), or "all" for every skx byte,
# or any comma/range list accepted by weak_system_snova.py.
#
# Example:
#   ./run_weak_system_snova.sh _SNOVA_I_S_AES_ref_sign
#   ./run_weak_system_snova.sh _SNOVA_I_S_AES_ref_sign --positions all
#   ./run_weak_system_snova.sh gf_set_add

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <func_name> [--elf-dir DIR] [--positions POSLIST] [--n-tests N] [--seed N] [--call-index N] [--min-nonzero N] [--max-nonzero-faulty N]" >&2
    exit 1
fi

FUNC_NAME="$1"; shift
PROBE_FUNC="_SNOVA_I_S_AES_ref_sign"
OUT_DIR="test_snova/${FUNC_NAME}"
ELF_DIR="build/test_snova/${FUNC_NAME}"
POSITIONS="16-47"
N_TESTS="4"
SEED=""
CALL_INDEX=""
MIN_NONZERO=""
MAX_NONZERO_FAULTY=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --elf-dir) ELF_DIR="$2"; shift 2 ;;
        --positions) POSITIONS="$2"; shift 2 ;;
        --n-tests) N_TESTS="$2"; shift 2 ;;
        --seed) SEED="$2"; shift 2 ;;
        --call-index) CALL_INDEX="$2"; shift 2 ;;
        --min-nonzero) MIN_NONZERO="$2"; shift 2 ;;
        --max-nonzero-faulty) MAX_NONZERO_FAULTY="$2"; shift 2 ;;
        *) echo "[!] unrecognized argument: $1" >&2; exit 1 ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROBE_PY="${SCRIPT_DIR}/weak_system_snova.py"

[[ -f "$PROBE_PY" ]] || { echo "[!] required script not found: $PROBE_PY" >&2; exit 1; }

CORRECT_ELF="${ELF_DIR}/full_snova_gated/gated_${FUNC_NAME}.elf"
[[ -d "$ELF_DIR" ]] || { echo "[!] elf dir not found: $ELF_DIR (build gated ELFs first -- see header)" >&2; exit 1; }
[[ -f "$CORRECT_ELF" ]] || { echo "[!] correct elf not found: $CORRECT_ELF" >&2; exit 1; }

# Faulty builds are nested several directories deep, so this must be a
# recursive search, not a flat glob. Only whole-program full_snova_gated/
# builds are valid targets for this probe, so anything outside a
# full_snova_gated/ directory is skipped.
FAULTY_ELFS=()
while IFS= read -r -d '' f; do
    FAULTY_ELFS+=("$f")
done < <(find "$ELF_DIR" -type f -name '*.elf' -path '*/full_snova_gated/*' -not -samefile "$CORRECT_ELF" -print0 | sort -z)

if [[ ${#FAULTY_ELFS[@]} -eq 0 ]]; then
    echo "[!] no faulty gated ELFs found under $ELF_DIR (besides $CORRECT_ELF)" >&2
    exit 1
fi

echo "[i] function:     ${FUNC_NAME} (probe --func: ${PROBE_FUNC})"
echo "[i] correct elf:   ${CORRECT_ELF}"
echo "[i] positions:     ${POSITIONS}"
echo "[i] faulty elfs:   ${#FAULTY_ELFS[@]} found under ${ELF_DIR}"
for f in "${FAULTY_ELFS[@]}"; do
    echo "                    - ${f#${ELF_DIR}/}"
done

EXTRA_ARGS=(--positions "$POSITIONS")
[[ -n "$N_TESTS" ]] && EXTRA_ARGS+=(--n-tests "$N_TESTS")
[[ -n "$SEED" ]] && EXTRA_ARGS+=(--seed "$SEED")
[[ -n "$CALL_INDEX" ]] && EXTRA_ARGS+=(--call-index "$CALL_INDEX")
[[ -n "$MIN_NONZERO" ]] && EXTRA_ARGS+=(--min-nonzero "$MIN_NONZERO")
[[ -n "$MAX_NONZERO_FAULTY" ]] && EXTRA_ARGS+=(--max-nonzero-faulty "$MAX_NONZERO_FAULTY")

echo ""
echo "########## weak_system_snova (${#FAULTY_ELFS[@]} faulty ELF(s)) ##########"

FAILS=0
for faulty_elf in "${FAULTY_ELFS[@]}"; do
    # Mirror the faulty ELF's path (relative to ELF_DIR, minus .elf) under
    # test_snova/<func_name>/.
    REL="${faulty_elf#${ELF_DIR}/}"
    REL="${REL%.elf}"
    RESULT_DIR="${OUT_DIR}/${REL}"
    mkdir -p "$RESULT_DIR"

    echo ""
    echo "--- weak_system_snova: ${FUNC_NAME} / ${REL} ---"
    set +e
    python3 "$PROBE_PY" \
        --func "$PROBE_FUNC" \
        --correct-elf "$CORRECT_ELF" \
        --faulty-elf "$faulty_elf" \
        --report "${RESULT_DIR}/weak_system_snova_report.json" \
        "${EXTRA_ARGS[@]}" \
        2>&1 | tee "${RESULT_DIR}/weak_system_snova_result.txt"
    status="${PIPESTATUS[0]}"
    set -e
    if [[ "$status" -ne 0 && "$status" -ne 1 ]]; then
        echo "[!] probe failed (exit ${status}) for ${faulty_elf}" >&2
        FAILS=$((FAILS + 1))
    fi
done

echo ""
echo "=== weak_system_snova sweep complete: ${FUNC_NAME} (${#FAULTY_ELFS[@]} faulty ELF(s)) ==="
echo "[i] per-faulty-ELF results under: test_snova/${FUNC_NAME}/<faulty_elf_relpath>/weak_system_snova_result.txt"

if [[ "$FAILS" -gt 0 ]]; then
    echo "[!] ${FAILS} faulty ELF(s) errored out (emulation failure, not just verdict)" >&2
    exit 2
fi
