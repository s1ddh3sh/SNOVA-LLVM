#!/usr/bin/env bash
#
# run_tests_all.sh — build and run the full Unicorn paired-sweep pipeline
# for SNOVA functions, in PARALLEL (one worker per function).
#
# For each function, in its own worker:
#   1. ./snova_build.sh test_snova/<function>   (build the correct + faulty ELFs)
#   2. ./dist_tests/snova/run_combined_unicorn.sh <function> --seeds 0,1,2,3
#
# Each function is fully independent -- it builds into build/test_snova/<func>/
# and writes results under test_snova/<func>/, with no shared writes -- so the
# functions are run concurrently across a bounded pool of workers. Each worker's
# output is captured to a per-function log and printed, in function order, after
# all workers finish (so parallel output is never interleaved).
#
# Like run_combined_unicorn.sh, this script can be run from anywhere
# (it cds to llvm/; snova.json is read from the SNOVA repo root).
#
# Usage:
#   ./dist_tests/snova/run_tests_all.sh [-j N] [--seeds LIST] [--csv FILE] [func ...]
#
#   -j, --jobs N    number of concurrent workers (default: nproc)
#   --seeds LIST    seeds passed to run_combined_unicorn.sh (default: 0,1,2,3)
#   --csv FILE      timing CSV output path (default: test_snova/run_tests_all_timing.csv)
#   func ...        only these functions (default: every key in snova.json)
#
# The CSV has columns function,status,elapsed_seconds -- one row per function,
# then two summary rows (__avg_per_function__, __total_wall_clock__).
#
# Examples:
#   ./dist_tests/snova/run_tests_all.sh                      # all functions, nproc workers
#   ./dist_tests/snova/run_tests_all.sh -j 4                 # all functions, 4 workers
#   ./dist_tests/snova/run_tests_all.sh gf_sub gf_mult       # just these two
#
# A single function's failure (build or test) does not stop the others -- it is
# recorded and reported in the summary at the end, and the script exits
# non-zero if anything failed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}/../.."   # llvm/: test_snova/ and build/ are relative to it
CONFIG_JSON="../snova.json" # SNOVA repo root
SNOVA_BUILD="${SCRIPT_DIR}/snova_build.sh"
RUN_UNICORN="${SCRIPT_DIR}/run_combined_unicorn.sh"

SEEDS="0,1,2,3"
JOBS=""
CSV="test_snova/run_tests_all_timing.csv"
SEL_FUNCS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -j|--jobs) JOBS="$2"; shift 2 ;;
        --seeds) SEEDS="$2"; shift 2 ;;
        --csv) CSV="$2"; shift 2 ;;
        -h|--help) sed -n '2,40p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
        -*) echo "[!] unrecognized argument: $1" >&2; exit 1 ;;
        *) SEL_FUNCS+=("$1"); shift ;;
    esac
done

# Default worker count: one per CPU, but never more than we have functions.
if [[ -z "$JOBS" ]]; then
    JOBS="$(nproc 2>/dev/null || echo 4)"
fi
if ! [[ "$JOBS" =~ ^[1-9][0-9]*$ ]]; then
    echo "[!] --jobs must be a positive integer (got: $JOBS)" >&2
    exit 1
fi

for p in "$SNOVA_BUILD" "$RUN_UNICORN"; do
    [[ -x "$p" ]] || { echo "[!] required script not found or not executable: $p" >&2; exit 1; }
done

# Function list: explicit selection, else every key in snova.json.
if [[ "${#SEL_FUNCS[@]}" -gt 0 ]]; then
    FUNCS=("${SEL_FUNCS[@]}")
else
    [[ -f "$CONFIG_JSON" ]] || { echo "[!] ${CONFIG_JSON} not found -- expected at the SNOVA repo root" >&2; exit 1; }
    mapfile -t FUNCS < <(python3 -c "
import json
with open('${CONFIG_JSON}') as f:
    print('\n'.join(json.load(f).keys()))
")
fi
[[ "${#FUNCS[@]}" -gt 0 ]] || { echo "[!] no functions to run" >&2; exit 1; }
(( JOBS > ${#FUNCS[@]} )) && JOBS=${#FUNCS[@]}

echo "[i] running ${#FUNCS[@]} function(s) with ${JOBS} concurrent worker(s); seeds=${SEEDS}"

WALL_START="$(date +%s.%N)"

# Per-worker output + status go here; collected after all workers finish.
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

# One worker: build then test one function, capturing all output to its log and
# a single status token (ok | build | test) to its status file. Always returns
# 0 so the bounded-pool `wait -n` under `set -e` never aborts the launcher.
run_one() {
    local func="$1"
    local log="${WORK_DIR}/${func//\//_}.log"
    local status t0 t1
    t0="$(date +%s.%N)"
    {
        echo "=== [build] ${SNOVA_BUILD} test_snova/${func} ==="
        if "$SNOVA_BUILD" "test_snova/${func}"; then
            echo
            echo "=== [test] ${RUN_UNICORN} ${func} --seeds ${SEEDS} ==="
            if "$RUN_UNICORN" "$func" --seeds "$SEEDS"; then status="ok"; else status="test"; fi
        else
            status="build"
        fi
    } > "$log" 2>&1
    t1="$(date +%s.%N)"
    printf '%s' "$status" > "${WORK_DIR}/${func//\//_}.status"
    awk "BEGIN{printf \"%.2f\", ${t1}-${t0}}" > "${WORK_DIR}/${func//\//_}.time"
}

# Launch with a bounded pool: keep at most JOBS workers running at once.
for func in "${FUNCS[@]}"; do
    while (( $(jobs -rp | wc -l) >= JOBS )); do
        wait -n 2>/dev/null || true
    done
    echo "[launch] ${func}"
    run_one "$func" &
done
wait

# Timing CSV: one row per function, then two summary rows.
mkdir -p "$(dirname "$CSV")"
echo "function,status,elapsed_seconds" > "$CSV"

# Collect, in function order, so parallel output is never interleaved.
FAILED=()
TIME_SUM=0
TIME_N=0
declare -A FUNC_TIME
for func in "${FUNCS[@]}"; do
    base="${WORK_DIR}/${func//\//_}"
    echo
    echo "############################################"
    echo "# ${func}"
    echo "############################################"
    [[ -f "${base}.log" ]] && cat "${base}.log"
    secs="$( [[ -f "${base}.time" ]] && cat "${base}.time" || echo "0" )"
    FUNC_TIME["$func"]="$secs"
    TIME_SUM="$(awk "BEGIN{printf \"%.2f\", ${TIME_SUM}+${secs}}")"
    TIME_N=$((TIME_N + 1))
    status="$( [[ -f "${base}.status" ]] && cat "${base}.status" || echo "test" )"
    case "$status" in
        ok)    echo "[i] OK: ${func}  (elapsed ${secs}s)" ;;
        build) echo "[!] FAILED (build): ${func}  (elapsed ${secs}s)" >&2; FAILED+=("${func} (build)") ;;
        *)     echo "[!] FAILED (test): ${func}  (elapsed ${secs}s)" >&2;  FAILED+=("${func} (test)") ;;
    esac
    echo "${func},${status},${secs}" >> "$CSV"
done

WALL="$(awk "BEGIN{printf \"%.2f\", $(date +%s.%N)-${WALL_START}}")"
AVG="$(awk -v s="$TIME_SUM" -v n="$TIME_N" 'BEGIN{printf "%.2f", (n > 0 ? s / n : 0)}')"

echo "__avg_per_function__,summary,${AVG}" >> "$CSV"
echo "__total_wall_clock__,summary,${WALL}" >> "$CSV"

echo
echo "=== Per-function elapsed time ==="
for func in "${FUNCS[@]}"; do
    printf '  %-32s %8ss\n' "$func" "${FUNC_TIME[$func]}"
done

echo
echo "=== Summary: $((${#FUNCS[@]} - ${#FAILED[@]}))/${#FUNCS[@]} function(s) completed successfully (${JOBS} workers) ==="
echo "[i] avg per-function time: ${AVG}s over ${TIME_N} function(s)"
echo "[i] total wall-clock time: ${WALL}s (parallel across ${JOBS} worker(s))"
echo "[i] timing CSV written to: ${CSV}"
if [[ "${#FAILED[@]}" -gt 0 ]]; then
    echo "Failed:" >&2
    printf '  %s\n' "${FAILED[@]}" >&2
    exit 1
fi
