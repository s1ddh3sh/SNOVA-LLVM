#!/usr/bin/env bash
#
# run_tests_all.sh — build and run the full Unicorn paired-sweep pipeline
# for EVERY SNOVA function listed in snova.json.
#
# For each function in snova.json, in order:
#   1. ./snova_build.sh test_snova/<function>   (build the correct + faulty ELFs)
#   2. ./dist_tests/snova/run_combined_unicorn.sh <function> --seeds 0,1,2,3
#
# Like run_combined_unicorn.sh, this script can be run from anywhere
# (it cds to llvm/; snova.json is read from the SNOVA repo root).
#
# Usage:
#   ./dist_tests/snova/run_tests_all.sh
#
# A single function's failure (build or test) does not stop the sweep --
# it is recorded and reported in the summary at the end, and the script
# exits non-zero if anything failed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}/../.."   # llvm/: test_snova/ and build/ are relative to it
CONFIG_JSON="../snova.json" # SNOVA repo root
SNOVA_BUILD="${SCRIPT_DIR}/snova_build.sh"
RUN_UNICORN="${SCRIPT_DIR}/run_combined_unicorn.sh"
SEEDS="0,1,2,3"

if [[ ! -f "$CONFIG_JSON" ]]; then
    echo "[!] ${CONFIG_JSON} not found -- expected at the SNOVA repo root" >&2
    exit 1
fi

if [[ ! -x "$SNOVA_BUILD" ]]; then
    echo "[!] ${SNOVA_BUILD} not found or not executable -- expected at the SNOVA repo root" >&2
    exit 1
fi

if [[ ! -x "$RUN_UNICORN" ]]; then
    echo "[!] required script not found or not executable: ${RUN_UNICORN}" >&2
    exit 1
fi

mapfile -t FUNCS < <(python3 -c "
import json, sys
with open('${CONFIG_JSON}') as f:
    print('\n'.join(json.load(f).keys()))
")

if [[ "${#FUNCS[@]}" -eq 0 ]]; then
    echo "[!] no functions found in ${CONFIG_JSON}" >&2
    exit 1
fi

echo "[i] found ${#FUNCS[@]} function(s) in ${CONFIG_JSON}"

FAILED=()
for func in "${FUNCS[@]}"; do
    echo
    echo "############################################"
    echo "# ${func}"
    echo "############################################"

    echo
    echo "=== [build] ${SNOVA_BUILD} test_snova/${func} ==="
    if ! "$SNOVA_BUILD" "test_snova/${func}"; then
        echo "[!] FAILED (build): ${func}" >&2
        FAILED+=("${func} (build)")
        continue
    fi

    echo
    echo "=== [test] ${RUN_UNICORN} ${func} --seeds ${SEEDS} ==="
    if ! "$RUN_UNICORN" "$func" --seeds "$SEEDS"; then
        echo "[!] FAILED (test): ${func}" >&2
        FAILED+=("${func} (test)")
        continue
    fi

    echo "[i] OK: ${func}"
done

echo
echo "=== Summary: $((${#FUNCS[@]} - ${#FAILED[@]}))/${#FUNCS[@]} function(s) completed successfully ==="
if [[ "${#FAILED[@]}" -gt 0 ]]; then
    echo "Failed:" >&2
    printf '  %s\n' "${FAILED[@]}" >&2
    exit 1
fi
