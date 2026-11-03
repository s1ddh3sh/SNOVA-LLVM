#!/usr/bin/env python3
"""vinegar_dist_snova.py — a generalized secret-dependence *distribution* test
on the SNOVA signing vinegar, run in-process via Unicorn
(dist_tests/common/machine.py) against a pair of gated whole-program SNOVA
ELFs (a correct build and a faulty build). Detects attack A -- the private-seed
shake_absorb skip (fault `..._fnSkip_shake_absorb_line168`) -- and, more
generally, ANY fault that reduces how much of the vinegar still depends on the
secret, including PARTIAL faults that freeze only some of the vinegar.

Why a distribution test (and why NOT a frequency / chi-square test)
-------------------------------------------------------------------
In honest signing the vinegar is

    V = SHAKE256( s_secret || digest || salt || numsig )            (Alg. 14)

so it is keyed by the 32-byte PRIVATE seed s_secret. Attack A skips the
absorb of s_secret, leaving

    V = SHAKE256( digest || salt || numsig )                       (no secret)

Both are UNIFORM over GF(16). So a chi-square / frequency goodness-of-fit test
on the *value histogram* of V cannot tell them apart -- both pass as "uniform"
(the histogram printed below confirms this). The value distribution is the
wrong thing to measure.

What actually changes is the *conditional* distribution V | s_secret:

    correct  : as s_secret varies, V varies   -> each output position carries
               ~log2(16)=4 bits of entropy w.r.t. the secret sweep
    faulty A : as s_secret varies, V is frozen -> ~0 bits of entropy

So this test measures secret-dependence as a distribution over a SWEEP of
secrets, position by position, and COMPARES the correct and faulty profiles.

The statistic: per-position secret-sweep entropy
------------------------------------------------
Sweep N random private seeds (digest/salt/numsig held fixed, so the only
varying input is the secret). Capture the vinegar block for each seed in both
builds. For every nibble position p, over the N captured values, compute the
empirical Shannon entropy H[p] (bits, max 4). Then:

    live-in-correct   : H_correct[p]  is high  (secret reaches this position)
    collapsed (leaked): H_correct[p] high AND H_faulty[p] near 0
                        (secret no longer reaches it in the faulty build)

    leak_fraction = #collapsed / #live-in-correct

    leak_fraction == 1  -> FULL collapse  : vinegar wholly secret-independent
                                             (attack A)
    0 < leak_fraction<1 -> PARTIAL collapse: a subset of the vinegar is frozen
    leak_fraction == 0  -> no collapse     : both builds equally secret-keyed

This is a graded, distribution-level comparison, not the earlier binary
"distinct==1 vs >=2" oracle: it quantifies *how much* of the vinegar lost its
dependence on the secret, so it also flags partial freezes a distinct-count
would miss. Collision rate and the nibble histogram are reported alongside as
diagnostics (the histogram shows the value distribution stays ~uniform, i.e.
why a chi-square test is the wrong instrument here).

How the vinegar is captured
---------------------------
The vinegar instance is identified robustly as the shake instance that absorbs
a length-1 input -- the num_sign byte, unique to the vinegar PRG (Alg. 14) and
present in both the correct and the seed-absorb-skipped builds. Its first
squeeze is the vinegar block. The private seed is patched at skx[16:48] at the
sign-entry snapshot before each run.

Usage
-----
    python3 dist_tests/snova/vinegar_dist_snova.py \\
      --correct-elf build/test_snova/_SNOVA_I_S_AES_ref_sign/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign.elf \\
      --faulty-elf  build/test_snova/_SNOVA_I_S_AES_ref_sign/loopOrFuncSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_fnSkip_shake_absorb_line168.elf \\
      --n-seeds 64
"""

import argparse
import collections
import json
import math
import os
import random
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..")))

from dist_tests.common.machine import Machine, EmulationError  # noqa: E402

DEFAULT_ENTRY = "_SNOVA_I_S_AES_ref_sign"
SQUEEZE = "shake_squeeze"
PRIV_OFF = 16        # SEED_LENGTH_PUBLIC: private seed starts here within skx
PRIV_LEN = 32        # SEED_LENGTH_PRIVATE
RUN_TIMEOUT_US = 30_000_000

# Entropy thresholds, as fractions of the max observable per-position entropy
# Hmax = min(log2(16), log2(N)). A position is "live" (secret-dependent) in a
# build if its sweep entropy is above LIVE_FRAC*Hmax, and "frozen" if below
# FROZEN_FRAC*Hmax. The wide gap between them makes the verdict robust to
# finite-sample entropy bias.
LIVE_FRAC = 0.50
FROZEN_FRAC = 0.15


class VinegarSession:
    """Boots one gated ELF to the `sign` entry, snapshots there, and then
    captures the per-call vinegar block for an arbitrary private seed by
    hooking shake_squeeze and reading the vinegar squeeze's output buffer."""

    def __init__(self, elf_path, entry=DEFAULT_ENTRY):
        self.entry = entry
        m = Machine.from_elf(elf_path, count_insns=False)
        self.m = m
        self.elf_path = elf_path
        m.run_until("main")
        main_pc = m.reg("pc") | 1
        self.main_ret = m.reg("lr") & ~1

        addrs = {}
        for name in (entry, f"{entry}__faulted"):
            try:
                addrs[name] = m.addr_of(name)
            except KeyError:
                continue
        if entry not in addrs:
            raise EmulationError(f"{elf_path}: no symbol named {entry!r}")
        self.squeeze_addr = m.addr_of(SQUEEZE)
        self.absorb_addr = m.addr_of("shake_absorb")

        hit = {}

        def sign_hook(machine, address, size):
            if "skx" not in hit:
                hit["skx"] = machine.reg("r0")              # arg0 = skx
                hit["pc"] = address
                hit["ret"] = machine.reg("lr") & ~1
                machine.uc.emu_stop()

        handles = [m.hook_code(sign_hook, begin=a, end=a, precise=False) for a in addrs.values()]
        try:
            m._emu_start(main_pc, self.main_ret, timeout=RUN_TIMEOUT_US)
        finally:
            for h in handles:
                m.unhook(h)
        if "skx" not in hit:
            raise EmulationError(f"{elf_path}: {entry} never reached from main")

        self.skx = hit["skx"]
        self.sign_pc = hit["pc"]
        self.sign_ret = hit["ret"]
        self.snap = m.snapshot()

    def vinegar(self, seed_bytes):
        """Return the vinegar block for a given 32-byte private seed.

        The vinegar instance is identified robustly as the shake instance that
        absorbs a length-1 input -- the num_sign byte, which is unique to the
        vinegar PRG (Algorithm 14) and present in both the correct and the
        seed-absorb-skipped builds. Its first squeeze is the vinegar block.
        Earlier setup squeezes (expand_T12, the message hash) use other
        instances and are ignored.
        """
        m = self.m
        m.restore(self.snap)
        m.write(self.skx + PRIV_OFF, bytes(seed_bytes))
        cap = {"vinst": None}

        def abh(machine, address, size):
            # shake_absorb(instance=r0, in=r1, inlen=r2); num_sign absorb has inlen==1
            if machine.reg("r2") == 1 and cap["vinst"] is None:
                cap["vinst"] = machine.reg("r0")

        def sqh(machine, address, size):
            # shake_squeeze(out=r0, outlen=r1, instance=r2)
            if cap["vinst"] is not None and machine.reg("r2") == cap["vinst"] and "dest" not in cap:
                cap["dest"] = machine.reg("r0")
                cap["len"] = machine.reg("r1")
                cap["ret"] = machine.reg("lr") & ~1
                cap["entry"] = address
                machine.uc.emu_stop()

        ha = m.hook_code(abh, begin=self.absorb_addr, end=self.absorb_addr, precise=False)
        hs = m.hook_code(sqh, begin=self.squeeze_addr, end=self.squeeze_addr, precise=False)
        try:
            m._emu_start(self.sign_pc | 1, self.sign_ret, timeout=RUN_TIMEOUT_US)
            if "dest" not in cap:
                raise EmulationError(
                    f"{self.elf_path}: vinegar squeeze not reached "
                    f"(vinegar instance {'found' if cap['vinst'] else 'NOT found'})"
                )
            # Run the squeeze body to completion, then read its output buffer.
            m._emu_start(cap["entry"] | 1, cap["ret"], timeout=RUN_TIMEOUT_US)
            return bytes(m.read(cap["dest"], cap["len"]))
        finally:
            m.unhook(ha)
            m.unhook(hs)


# --------------------------------------------------------------------------
# distribution statistics
# --------------------------------------------------------------------------

def _nibbles(data):
    out = []
    for b in data:
        out.append(b & 0xF)
        out.append((b >> 4) & 0xF)
    return out


def _entropy_bits(values):
    """Empirical Shannon entropy (in bits) of a sample of discrete values."""
    if not values:
        return 0.0
    n = len(values)
    h = 0.0
    for cnt in collections.Counter(values).values():
        p = cnt / n
        h -= p * math.log2(p)
    return h


def _position_entropies(blocks):
    """Per-nibble-position secret-sweep entropy across the captured blocks."""
    nib = [_nibbles(b) for b in blocks]
    npos = len(nib[0])
    return [_entropy_bits([row[p] for row in nib]) for p in range(npos)]


def _hist_str(blocks):
    """Nibble histogram (0..15) over all captured vinegar blocks."""
    c = collections.Counter()
    for b in blocks:
        c.update(_nibbles(b))
    total = sum(c.values()) or 1
    return " ".join(f"{x:x}:{100 * c[x] / total:.0f}%" for x in range(16))


def _collision_rate(blocks):
    """Fraction of unordered block pairs that are identical (0 = all distinct,
    1 = all identical). A distribution-level measure of block-wise spread."""
    n = len(blocks)
    if n < 2:
        return 0.0
    pairs = n * (n - 1) // 2
    same = sum(c * (c - 1) // 2 for c in collections.Counter(blocks).values())
    return same / pairs


def collect(label, elf_path, seeds, entry=DEFAULT_ENTRY):
    """Capture one vinegar block per swept secret seed and summarize its
    secret-sweep distribution (per-position entropy, collision rate, hist)."""
    sess = VinegarSession(elf_path, entry=entry)
    vs = [sess.vinegar(s) for s in seeds]
    ent = _position_entropies(vs)
    res = {
        "label": label.strip(), "elf": elf_path,
        "n_seeds": len(seeds), "block_len": len(vs[0]),
        "distinct": len(set(vs)),
        "collision_rate": _collision_rate(vs),
        "mean_pos_entropy": sum(ent) / len(ent),
        "pos_entropy": ent,
        "nibble_hist": _hist_str(vs),
        "blocks_hex": [v.hex() for v in vs],
    }
    print(f"[i] {label}: {len(seeds)} seeds -> {res['distinct']} distinct block(s), "
          f"collision rate {res['collision_rate']:.3f}, "
          f"mean per-position entropy {res['mean_pos_entropy']:.2f} bits")
    print(f"[i] {label}: nibble histogram (value distribution): {res['nibble_hist']}")
    return res


def compare(res_c, res_f, n_seeds):
    """Compare the correct vs faulty secret-sweep distributions position by
    position and classify the collapse (none / partial / full)."""
    hmax = min(4.0, math.log2(n_seeds)) if n_seeds > 1 else 0.0
    live_t = LIVE_FRAC * hmax
    frozen_t = FROZEN_FRAC * hmax

    hc, hf = res_c["pos_entropy"], res_f["pos_entropy"]
    live = [p for p in range(len(hc)) if hc[p] >= live_t]
    collapsed = [p for p in live if hf[p] <= frozen_t]
    leak_fraction = (len(collapsed) / len(live)) if live else 0.0
    return {
        "hmax_bits": hmax, "live_threshold": live_t, "frozen_threshold": frozen_t,
        "n_positions": len(hc), "n_live_in_correct": len(live),
        "n_collapsed": len(collapsed), "leak_fraction": leak_fraction,
        "collapsed_positions": collapsed,
    }


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--correct-elf", required=True)
    ap.add_argument("--faulty-elf", required=True)
    ap.add_argument("--func", default=DEFAULT_ENTRY,
                    help="fixed observation point: the signing entry symbol whose "
                         "vinegar is captured (default %(default)s). The faulty ELF's "
                         "injected fault may live anywhere in the call tree; this only "
                         "names where the vinegar is read, and is the SAME for every "
                         "gated ELF pair.")
    ap.add_argument("--n-seeds", type=int, default=64,
                    help="number of random private seeds swept (default 64). "
                         "More seeds -> tighter per-position entropy estimate.")
    ap.add_argument("--seed", type=int, default=1, help="RNG seed for the swept seeds.")
    ap.add_argument("--report", default=None)
    args = ap.parse_args()

    for lbl, p in (("correct", args.correct_elf), ("faulty", args.faulty_elf)):
        if not os.path.isfile(p):
            print(f"[!] {lbl} ELF not found: {p}", file=sys.stderr)
            sys.exit(1)
    if args.n_seeds < 2:
        print("[!] --n-seeds must be >= 2 for a distribution comparison", file=sys.stderr)
        sys.exit(1)

    rng = random.Random(args.seed)
    seeds = [bytes(rng.randrange(256) for _ in range(PRIV_LEN)) for _ in range(args.n_seeds)]

    print("=" * 74)
    print("Vinegar secret-dependence DISTRIBUTION test (correct vs faulty)")
    print("=" * 74)

    try:
        res_c = collect("correct", args.correct_elf, seeds, entry=args.func)
        res_f = collect("faulty ", args.faulty_elf, seeds, entry=args.func)
    except EmulationError as e:
        print(f"[!] emulation failed: {e}", file=sys.stderr)
        sys.exit(2)

    cmp = compare(res_c, res_f, args.n_seeds)

    print()
    print("=" * 74)
    print("Verdict")
    print("=" * 74)
    print(f"[i] max observable per-position entropy Hmax = {cmp['hmax_bits']:.2f} bits "
          f"(live > {cmp['live_threshold']:.2f}, frozen < {cmp['frozen_threshold']:.2f})")
    print(f"[i] correct: mean per-position entropy {res_c['mean_pos_entropy']:.2f} bits "
          f"({cmp['n_live_in_correct']}/{cmp['n_positions']} positions secret-dependent)")
    print(f"[i] faulty : mean per-position entropy {res_f['mean_pos_entropy']:.2f} bits")
    print(f"[i] leak: {cmp['n_collapsed']}/{cmp['n_live_in_correct']} secret-dependent "
          f"positions FROZEN in the faulty build (leak fraction {cmp['leak_fraction']:.2f})")

    lf = cmp["leak_fraction"]
    if lf >= 0.999:
        verdict = "full"
        print("[!] FULL COLLAPSE (attack A): every secret-dependent position of the "
              "vinegar is frozen in the faulty build -- the private seed no longer "
              "enters the vinegar PRG, so the vinegar is attacker-recomputable from "
              "public data.")
        exit_code = 1
    elif lf > 0.0:
        verdict = "partial"
        print(f"[!] PARTIAL COLLAPSE: {cmp['n_collapsed']} of {cmp['n_live_in_correct']} "
              "secret-dependent vinegar positions are frozen in the faulty build, "
              "reducing the secret entropy of the vinegar. Collapsed nibble positions: "
              f"{cmp['collapsed_positions']}")
        exit_code = 1
    else:
        verdict = "none"
        print("[i] NO COLLAPSE: the faulty build's vinegar depends on the secret seed "
              "as strongly as the correct build's.")
        exit_code = 0

    if args.report:
        with open(args.report, "w") as f:
            json.dump({"correct": res_c, "faulty": res_f,
                       "comparison": cmp, "verdict": verdict,
                       "collapse_detected": exit_code == 1}, f, indent=2)
        print(f"[i] report written to {args.report}")

    sys.exit(exit_code)


if __name__ == "__main__":
    main()
