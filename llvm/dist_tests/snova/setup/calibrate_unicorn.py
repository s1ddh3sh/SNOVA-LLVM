#!/usr/bin/env python3
"""
calibrate_unicorn.py (snova) — drop-in replacement for calibrate.py that
runs every probe IN-PROCESS via the Unicorn Cortex-M4 emulator
(dist_tests/common/unicorn_runner.py) instead of spawning a fresh
qemu-system-arm + gdb-multiarch subprocess pair per probe. Same CLI
surface, same calibrate_buffer() binary-search algorithm,
SKIP_CALIBRATION_BELOW/MAX_SAFE_PROBE_LEN constants and per-buffer
failure isolation, same active_lengths.json output -- this file only
documents what's DIFFERENT here (no qemu/gdb subprocess anywhere).

See calibrate.py's module docstring for the full description of the
calibration algorithm and its safety caps.
"""
import argparse
import json
import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")))

from dist_tests.common.unicorn_runner import run_trial, TrialError
from dist_tests.snova.setup.distributions_unicorn import sample_for_distribution

INPLACE_RUNS = 8  # random pre-call fills per in-place ("inout") buffer
READ_CHECK_RUNS = 4  # ... per output-only buffer, to spot a missing "inout"

SKIP_CALIBRATION_BELOW = 128  # buffers <= this size: just use full
                                 # length directly, calibration overhead
                                 # isn't worth it for small buffers

MAX_SAFE_PROBE_LEN = 8192

ZERO_LENGTH_RETRIES = 8  # extra seeds tried before believing a buffer is
                         # unused (active length 0)


def run_probe(elf_path, witness_path, func, field_mod, buf_name,
               probe_len, seed, co_seed, machine, fixed_scalars=""):
    with open(witness_path) as f:
        layout = json.load(f)["layout"]

    fixed_set = set(s for s in (fixed_scalars or "").split(",") if s)

    try:
        return run_trial(
            elf_path, layout, func, "probe", field_mod, 0, "correct",
            fixed_set, None, probe_buf=buf_name, probe_len=probe_len,
            probe_seed=seed, co_seed=co_seed,
        )
    except TrialError as e:
        raise RuntimeError(
            f"probe (buf={buf_name}, len={probe_len}, seed={seed}) failed: "
            f"{type(e).__name__}: {e}"
        ) from e


class CalibrationFailed(Exception):
    """Raised when a buffer can't be safely calibrated at all."""


def prefill_runs(elf_path, layout, func, field_mod, buf, fixed_scalars, n):
    """n correct-ELF trials that differ only in the pre-call contents of the
    output buffer `buf`: it is filled like an input and drawn from its own
    RNG stream (the runner's ephemeral-input stream, eph_seed k), while every
    other input keeps the same draw (rng_seed 0). Returns [(pre, outputs)]."""
    layout = {name: dict(spec) for name, spec in layout.items()}
    layout[buf]["also_input"] = True
    fixed_set = set(s for s in (fixed_scalars or "").split(",") if s)
    runs = []
    for k in range(n):
        try:
            r = run_trial(elf_path, layout, func, "collect", field_mod, 0,
                          "correct", fixed_set, sample_for_distribution, {},
                          eph_secret={buf}, eph_seed=f"prefill:{k}")
        except TrialError as e:
            raise CalibrationFailed(
                f"{buf}: pre-filled run {k} failed: {type(e).__name__}: {e}"
            ) from e
        runs.append((r["inputs"][f"{buf}_pre"], r["outputs"]))
    return runs


def written_positions(buf, runs):
    """Positions of `buf` the function writes: its output differs from the
    pre-call value there in at least one run. Every other position passes
    through unchanged."""
    return sorted({j for pre, outs in runs
                   for j, (x, y) in enumerate(zip(pre, outs[buf])) if x != y})


def reads_prefill(buf, runs, written):
    """Does any output depend on the pre-call contents of `buf`? Its own
    pass-through positions are left out (they trivially do)."""
    keep = set(written)

    def view(outs):
        return {name: [v for j, v in enumerate(o) if j in keep] if name == buf else o
                for name, o in outs.items()}

    first = view(runs[0][1])
    return any(view(outs) != first for _, outs in runs[1:])


def calibrate_buffer(elf_path, witness_path, func, field_mod, buf_name,
                      full_length, machine, n_repeats=3, base_seed=0,
                      fixed_scalars="", max_probe_len=MAX_SAFE_PROBE_LEN,
                      zero_retries=ZERO_LENGTH_RETRIES):
    """
    Find the minimal prefix length L such that zeroing everything from
    index L onward still reproduces the SAME output as using the full
    buffer -- i.e. the point past which additional bytes no longer
    influence the FUT.

    If prefix length 0 already matches the reference, the match may be a
    coincidence (e.g. a single GF(16) output collides 1 time in 16), so
    up to `zero_retries` further (seed, co_seed) pairs are tried, each
    with its own fresh reference. The first pair under which length 0
    does NOT match is kept for the rest of the search; 0 is reported only
    if every pair matches.

    Raises CalibrationFailed instead of letting a target crash propagate
    as an opaque traceback -- callers should catch this per-buffer and
    continue with the rest of the function's buffers.
    """
    seed = base_seed
    co_seed = base_seed

    effective_length = full_length
    if full_length > max_probe_len:
        print(
            f"[!] {buf_name}: declared length {full_length} exceeds the "
            f"safety cap ({max_probe_len}). This usually means either (a) "
            f"the source alloca is a worst-case/MAX-sized buffer much "
            f"bigger than what this parameter set actually uses, or (b) "
            f"qemu_witness.json paired this key with the wrong call "
            f"argument (see extract_qemu_witness.py's name-matching -- "
            f"check for a sibling buffer reporting the exact same "
            f"length, which would confirm a mismatch rather than a "
            f"genuinely large buffer). Capping the calibration search to "
            f"{max_probe_len}; if the true active length is beyond that, "
            f"it will be UNDER-reported. Pass --max-probe-len to raise "
            f"this if the target genuinely has the RAM for it."
        )
        effective_length = max_probe_len

    def probe(length, seed, co_seed):
        return run_probe(elf_path, witness_path, func, field_mod,
                          buf_name, length, seed, co_seed, machine,
                          fixed_scalars)

    def make_reference(seed, co_seed):
        try:
            return probe(effective_length, seed, co_seed)
        except RuntimeError as e:
            raise CalibrationFailed(
                f"{buf_name}: reference probe at length {effective_length} "
                f"failed -- cannot calibrate this buffer at all.\n{e}"
            ) from e

    reference = make_reference(seed, co_seed)

    def matches_reference(length):
        for r in range(n_repeats):
            result = probe(length, seed, co_seed)
            if result != reference:
                return False
        return True

    if matches_reference(0):
        for k in range(1, zero_retries + 1):
            seed = co_seed = base_seed + k
            reference = make_reference(seed, co_seed)
            if not matches_reference(0):
                print(f"[i] {buf_name}: length-0 probe matched the reference "
                      f"under seed {base_seed} by coincidence; continuing "
                      f"with seed {seed}.")
                break
        else:
            print(f"[!] {buf_name}: output identical to full-buffer reference "
                  f"even with prefix length 0 under {zero_retries + 1} "
                  f"seeds -- buffer may be unused.")
            return 0

    lo, hi = 0, 1
    while hi < effective_length and not matches_reference(hi):
        lo = hi
        hi = min(hi * 2, effective_length)

    if not matches_reference(hi):
        if effective_length < full_length:
            print(
                f"[!] {buf_name}: sensitivity extends past the capped "
                f"search length ({effective_length}); reporting "
                f"{effective_length} but the TRUE active length may be "
                f"larger. Re-run with a higher --max-probe-len to find it."
            )
        return effective_length

    while hi - lo > 1:
        mid = (lo + hi) // 2
        if matches_reference(mid):
            hi = mid
        else:
            lo = mid

    return hi


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--witness", required=True)
    ap.add_argument("--elf", required=True, help="correct.elf")
    ap.add_argument("--field-mod", type=int, default=16)
    ap.add_argument("--machine", default="mps2-an386",
                     help="ignored -- accepted only for CLI compatibility "
                          "with calibrate.py (no real QEMU machine is "
                          "launched by this backend).")
    ap.add_argument("--out", default=None)
    ap.add_argument(
        "--max-probe-len", type=int, default=MAX_SAFE_PROBE_LEN,
        help="Safety cap on the initial/reference probe length for any "
             "one buffer (default: %(default)s). Declared alloca lengths "
             "beyond this are capped rather than probed directly.",
    )
    ap.add_argument(
        "--fixed-scalars",
        default="",
        help="Comma-separated list of scalar layout names (structural "
             "dimensions like m_vec_limbs, colrow_ab, row_a, col_b) that "
             "must stay at their compiled-in init_value during calibration "
             "instead of being randomized -- otherwise the binary search "
             "can corrupt/misjudge sensitivity by varying a parameter that "
             "should be held fixed.",
    )
    args = ap.parse_args()

    with open(args.witness) as f:
        spec = json.load(f)
    layout = spec["layout"]
    func = spec["function"]

    active_lengths = {}
    failed_buffers = {}
    for name, s in layout.items():
        if s.get("role") != "output" or s.get("type") in ("scalar", "scalar_ptr"):
            continue
        n_runs = INPLACE_RUNS if s.get("also_input") else READ_CHECK_RUNS
        try:
            runs = prefill_runs(args.elf, layout, func, args.field_mod, name,
                                args.fixed_scalars, n_runs)
        except CalibrationFailed as e:
            print(f"[!] {name}: pre-filled runs failed.\n{e}")
            if s.get("also_input"):
                failed_buffers[name] = str(e)
            continue
        written = written_positions(name, runs)
        reads = reads_prefill(name, runs, written)
        if s.get("also_input"):
            # In-place buffer: the positions past the last one written only
            # pass through, so its active length is the written extent (a
            # prefix search would always find the full length).
            active_lengths[name] = written[-1] + 1 if written else 0
            print(f"[i] {name} (inout): active length = {active_lengths[name]} "
                  f"/ {s['length']} (written extent), "
                  + ("pre-call value read" if reads else
                     "overwritten without being read"))
        elif reads:
            print(f"[!] {name}: an output depends on the pre-call contents of "
                  f"'{name}', so {func} reads it before writing it. Declare it "
                  f"\"inout\" in snova.json, or it stays 0 in every trial.")

    for name, s in layout.items():
        if s.get("role") != "input":
            continue
        full_len = s["length"]
        if full_len <= SKIP_CALIBRATION_BELOW:
            active_lengths[name] = full_len
            print(f"[i] {name}: length {full_len} <= threshold, skipping calibration")
            continue
        print(f"[i] calibrating {name} (full length {full_len})...")
        try:
            active_len = calibrate_buffer(args.elf, args.witness, func,
                                           args.field_mod, name, full_len,
                                           args.machine,
                                           fixed_scalars=args.fixed_scalars,
                                           max_probe_len=args.max_probe_len)
        except CalibrationFailed as e:
            print(f"[!] {name}: calibration failed, skipping this buffer.\n{e}")
            failed_buffers[name] = str(e)
            continue
        active_lengths[name] = active_len
        print(f"[i] {name}: active length = {active_len} / {full_len}")

    out_path = args.out or os.path.join(os.path.dirname(args.witness), "active_lengths.json")
    with open(out_path, "w") as f:
        json.dump(active_lengths, f, indent=2)
    print(f"[+] wrote {out_path}")
    print(json.dumps(active_lengths, indent=2))

    if failed_buffers:
        print(
            f"\n[!] {len(failed_buffers)} buffer(s) could NOT be "
            f"calibrated and are absent from {out_path}: "
            f"{sorted(failed_buffers.keys())}."
        )


if __name__ == "__main__":
    main()
