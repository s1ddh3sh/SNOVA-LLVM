#!/usr/bin/env python3
"""weak_system_snova.py — generic equation-based "nonlinear-to-linear
collapse" oracle, run in-process via Unicorn (dist_tests/common/machine.py),
against a pair of gated whole-program SNOVA ELFs.

This is the SNOVA port of the MAYO compute_P3 weak-system probe. The TEST
itself is unchanged -- a GF(16)-linearity check by the standard-basis method
(see "How the test detects it" below). Only the observation target is
re-pointed:

    MAYO                              SNOVA (this file)
    ----                              -----------------
    probe func : compute_P3           probe func : _SNOVA_I_S_AES_ref_sign
    secret     : O (oil matrix)       secret     : T12 (the secret map),
                                                   injected directly into its
                                                   buffer after expand_T12()
    output     : P3                   output     : sig (the signature)

Two independent things, decoupled
-----------------------------------
1. The PROBE function (--func): whichever function's inputs/output we
   actually hook and read. Here it is FIXED to _SNOVA_I_S_AES_ref_sign:
   the signature `sig` is the object whose algebraic dependence on the
   secret we care about.

2. The FAULT location: wherever inside that probe function's call tree a
   `<name>`/`<name>__faulted` gate pair (@__fi_count_<name> /
   @__fi_target_<name>) actually lives -- it can be _SNOVA_I_S_AES_ref_sign
   itself, or any callee reached from it (gf_set_add, gf_mult, shake*,
   keccak*, expand_T12, ...). The black-box test never hooks the gated
   symbol; it only hooks the stable outer probe function, so the SAME
   --func / secret / output configuration is reused for every fault site
   that ultimately changes what the signature is. The tool auto-detects a
   `<func>__faulted` twin and hooks it too when present, but that hook is
   redundant with the fault's own effect on the signature.

What the test checks
-----------------------
The SNOVA secret map T12 is derived from the 32-byte private seed
(skx[SEED_LENGTH_PUBLIC : SEED_LENGTH_PUBLIC + SEED_LENGTH_PRIVATE], i.e.
skx[16:48] for SNOVA_I_S_AES). In an honest signature the on-wire signature

    S_i = V_i + sum_j T12_ij . O_j        (vinegar nodes, i < v)
    S_{v+j} = O_j                          (oil nodes)

is a genuinely NONLINEAR (high-degree) function of the secret: the oil
solution O is itself obtained by inverting a linear system whose
coefficients depend on T12, and the vinegar V is keyed by the private seed
through SHAKE256. That high degree is exactly what makes recovering the key
from signatures hard.

A fault that makes the signature a GF(16)-LINEAR function of the secret --
S(secret) = A . secret -- is the "weak system" this probe hunts for: an
attacker who sees that the signature depends only linearly on the secret
recovers the secret (hence T12, hence an equivalent key) with linear
algebra instead of solving the multivariate-quadratic / oil-vinegar
problem. This is the degree-collapse analogue of the fault-assisted
linear/reconciliation key recovery on SNOVA (cf. ePrint 2024/1883) and of
the "fix the vinegar / vinegar-seed" faults on MAYO and UOV.

How the test detects it, as a black box
------------------------------------------
The swept secret T12 is one-nibble-per-byte field elements; the OUTPUT
argument (sig) is treated as an opaque bitstring, each byte split into its
two nibbles (a fixed, coordinate-independent F2-linear repacking, so it
cannot change any individual nibble's degree in the swept secret
coordinate).

The signature has a nonzero constant term (sig(T12=0) != 0), so the test is
AFFINE-aware: any GF(16)-affine F has the form F(X) = A*X + b with b = F(0).
Restricting X to a set of T12 positions (all other T12 bytes forced to 0 at
the snapshot point): (0) query b = F(0); (1) query F(e_i) for each basis
vector e_i (T12[pos_i]=1); the linear part's i-th column is A_i = F(e_i) - b;
(2) for random extra inputs X predict F_pred(X) = b + sum_i x_i*A_i in
GF(16); (3) query the real system at X and compare. Any differing output
nibble proves F is not GF(16)-affine (degree >= 2 in T12):

    healthy (nonlinear in T12) : nibbles differ from the affine prediction
    collapsed (affine in T12)  : all nibbles match, A*X + b is a valid model

Usage
-------
    # _SNOVA_I_S_AES_ref_sign itself is the fault-gated pair:
    python3 dist_tests/snova/weak_system_snova.py \\
        --func _SNOVA_I_S_AES_ref_sign \\
        --correct-elf build/test_snova/_SNOVA_I_S_AES_ref_sign/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign.elf \\
        --faulty-elf  build/test_snova/_SNOVA_I_S_AES_ref_sign/loadStoreSkip/full_snova_gated/gated__SNOVA_I_S_AES_ref_sign_line911_mem.elf

    # same probe function, but the fault (and its __faulted twin) is one or
    # more levels deeper (e.g. inside gf_set_add); _SNOVA_I_S_AES_ref_sign
    # itself is ungated in both ELFs; --func / --secret-* / --output-* stay
    # identical:
    python3 dist_tests/snova/weak_system_snova.py \\
        --func _SNOVA_I_S_AES_ref_sign \\
        --correct-elf build/test_snova/gf_set_add/full_snova_gated/gated_gf_set_add.elf \\
        --faulty-elf  build/test_snova/gf_set_add/binOpFault/full_snova_gated/gated_gf_set_add_line4_opA.elf

--func _SNOVA_I_S_AES_ref_sign has built-in defaults for --secret-arg/
--secret-len/--output-arg/--output-len (see KNOWN_FUNCS below); pass them
explicitly to probe a differently-shaped function.
"""

import argparse
import json
import os
import random
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..")))

from dist_tests.common.machine import Machine, EmulationError  # noqa: E402

ENTRY_FUNC = "_SNOVA_I_S_AES_ref_sign"

DEFAULT_CORRECT_ELF = (
    f"build/test_snova/{ENTRY_FUNC}/full_snova_gated/gated_{ENTRY_FUNC}.elf"
)
DEFAULT_FAULTY_ELF = (
    f"build/test_snova/{ENTRY_FUNC}/loadStoreSkip/full_snova_gated/"
    f"gated_{ENTRY_FUNC}_line911_mem.elf"
)

# Convenience defaults, keyed by probe function name. Each entry describes
# that function's formal-parameter layout (0-based declaration order; every
# pointer/scalar parameter is one 32-bit word, so declaration index IS the
# AAPCS slot: r0-r3 for slots 0-3, incoming-stack word beyond that):
#   secret_arg / secret_len : the pointer argument to perturb, and its
#       buffer length in bytes (one key byte per position).
#   output_arg / output_len : the pointer argument whose bytes get decoded
#       into nibbles and degree-tested, and its buffer length in bytes.
#
# _SNOVA_I_S_AES_ref_sign(const uint8_t *skx, uint8_t *sig,
#                         const uint8_t *digest, size_t len_digest,
#                         const uint8_t *salt)
#   arg 0 skx    : secret key (96B for SNOVA_I_S_AES: public_seed[0:16] |
#                  private_seed[16:48] | pk_hash[48:96]); private_seed is
#                  the region that expand_T12() turns into the secret map T12.
#   arg 1 sig    : signature output (BYTES_SIGNATURE = 272B).
#
# The SNOVA secret is the derived map T12, which is NOT a parameter of sign:
# expand_T12() fills it from the private seed through SHAKE (nonlinear), so
# perturbing skx could never expose a linear dependence. Instead we inject
# straight into the T12 buffer: hook expand_T12, grab its destination pointer
# (r0), let it populate T12, snapshot right after it returns into sign, and
# per trial overwrite T12's raw nibbles. That buffer IS the swept "secret",
# and sig is the output whose GF(16)-degree in T12 we test.
KNOWN_FUNCS = {
    "_SNOVA_I_S_AES_ref_sign": {
        "secret_via_callee": "expand_T12",  # r0 (T12 dest) captured at its entry
        "secret_len": 5 * 27 * 16,          # T12: o*v*l2 = 2160 one-nibble bytes
        "output_arg": 1,
        "output_len": 272,                  # sig: BYTES_SIGNATURE
    },
}

# Signing runs the whole scheme (~2.6e7 instructions/call), so a single
# trial is ~0.5 s with the per-block instruction counter OFF (see
# open_probe_session: count_insns=False). A fault that sends signing into a
# non-terminating loop trips this cap and is reported as an emulation
# failure for that ELF (the sweep continues).
RUN_TIMEOUT_US = 30_000_000

# -- GF(16) = F2[x]/(x^4 + x + 1) --------------------------------------------

_GF16_MOD = 0b10011  # x^4 + x + 1


def gf16_mul(a, b):
    a &= 0xF
    b &= 0xF
    p = 0
    for i in range(4):
        if (b >> i) & 1:
            p ^= a << i
    for i in range(6, 3, -1):
        if (p >> i) & 1:
            p ^= _GF16_MOD << (i - 4)
    return p & 0xF


assert gf16_mul(1, 7) == 7 and gf16_mul(0, 9) == 0 and gf16_mul(2, 2) == 4, (
    "gf16_mul sanity check failed"
)


def _read_arg_ptr(machine, arg_index):
    """AAPCS slot `arg_index` (0-based, across ALL declared params) at the
    exact PC of a not-yet-executed function entry: r0-r3 for slots 0-3, or
    the incoming stack for slot >= 4."""
    if arg_index < 4:
        return machine.reg(f"r{arg_index}")
    sp = machine.reg("sp")
    return machine.read_u32(sp + 4 * (arg_index - 4))


class ProbeSession:
    """A machine parked right at the entry of the target `func` call, with a
    snapshot taken there, so many trials (one per basis vector / random
    test) can be replayed cheaply: restore the snapshot, patch the secret
    bytes, run only from the call's entry to its own return -- instead of
    rebooting the ELF and replaying the whole main() round trip from scratch
    for every single trial.
    """

    def __init__(self, machine, snap, secret_ptr, output_ptr, entry_pc, ret_addr,
                 secret_len, output_len):
        self.machine = machine
        self.snap = snap
        self.secret_ptr = secret_ptr
        self.output_ptr = output_ptr
        self.entry_pc = entry_pc
        self.ret_addr = ret_addr
        self.secret_len = secret_len
        self.output_len = output_len

    def query(self, values):
        """values: {pos: gf16 value}; every other secret byte is forced to
        0. Returns the output nibbles. query({}) gives the baseline b = F(0)
        (the affine constant); the caller subtracts it (see linearity_probe)."""
        m = self.machine
        m.restore(self.snap)

        new_secret = [0] * self.secret_len
        for pos, value in values.items():
            if not (0 <= pos < self.secret_len):
                raise ValueError(f"override pos {pos} out of range (secret_len={self.secret_len})")
            new_secret[pos] = value & 0xF
        m.write(self.secret_ptr, bytes(new_secret))

        m._emu_start(self.entry_pc | 1, self.ret_addr, timeout=RUN_TIMEOUT_US)
        return list(m.read(self.output_ptr, self.output_len))


def _probe_func_addrs(m, func, elf_path):
    """Entry addresses of `func` and its `func`__faulted twin, if present."""
    addrs = {}
    for name in (func, f"{func}__faulted"):
        try:
            addrs[name] = m.addr_of(name)
        except KeyError:
            continue
    if func not in addrs:
        raise EmulationError(f"{elf_path}: no symbol named {func!r}")
    return addrs


def open_probe_session(elf_path, func, secret_arg, secret_via_callee, secret_len,
                       output_arg, output_len, call_index):
    """Boot elf_path to main() and park the machine with a snapshot taken at
    the point where the swept "secret" is about to influence the rest of the
    computation, so many trials replay cheaply (restore, patch the secret,
    run to the probe function's return).

    Two injection modes:

      * secret_via_callee set (SNOVA sign, secret = T12): the secret is an
        internal buffer, not a parameter. Hook the probe function entry to
        grab the output pointer and the probe's own return address; hook the
        generator callee (expand_T12) to grab its destination pointer (r0);
        let the generator populate the buffer; snapshot right after it
        returns INTO the probe function. query() then overwrites that buffer
        and runs the remaining probe-function body to its return.

      * secret_arg set (generic, secret = a pointer parameter): snapshot at
        the probe function entry; query() overwrites the parameter buffer and
        runs the whole call.

    count_insns=False: signing is ~2.6e7 instructions, so the per-basic-block
    Python instruction counter would dominate (~9 s/call vs ~0.5 s). The
    counter is only used to annotate EmulationError messages, which this
    black-box test does not need.
    """
    m = Machine.from_elf(elf_path, count_insns=False)
    m.run_until("main")
    main_entry_pc = m.reg("pc") | 1
    main_ret = m.reg("lr") & ~1

    addrs = _probe_func_addrs(m, func, elf_path)

    if secret_via_callee is None:
        # -- generic argument-pointer injection -----------------------------
        count = 0
        hit = {}

        def entry_hook(machine, address, size):
            nonlocal count
            count += 1
            if count == call_index:
                hit["secret_ptr"] = _read_arg_ptr(machine, secret_arg)
                hit["output_ptr"] = _read_arg_ptr(machine, output_arg)
                hit["ret_addr"] = machine.reg("lr") & ~1
                hit["pc"] = address
                machine.uc.emu_stop()

        handles = [m.hook_code(entry_hook, begin=a, end=a, precise=False) for a in addrs.values()]
        try:
            m._emu_start(main_entry_pc, main_ret, timeout=RUN_TIMEOUT_US)
        finally:
            for h in handles:
                m.unhook(h)
        if "pc" not in hit:
            raise EmulationError(
                f"{elf_path}: {func} call_index {call_index} never reached (only {count} call(s) seen)"
            )
        snap = m.snapshot()
        return ProbeSession(m, snap, hit["secret_ptr"], hit["output_ptr"],
                            hit["pc"], hit["ret_addr"], secret_len, output_len)

    # -- internal-buffer injection via a generator callee (T12) -------------
    try:
        callee_addr = m.addr_of(secret_via_callee)
    except KeyError:
        raise EmulationError(
            f"{elf_path}: no symbol named {secret_via_callee!r} (secret generator)"
        )

    hit = {}
    sign_count = 0

    def sign_hook(machine, address, size):
        nonlocal sign_count
        sign_count += 1
        if sign_count == call_index and "output_ptr" not in hit:
            hit["output_ptr"] = _read_arg_ptr(machine, output_arg)
            hit["probe_ret"] = machine.reg("lr") & ~1

    def callee_hook(machine, address, size):
        # First generator call after the target probe-function entry.
        if "output_ptr" in hit and "secret_ptr" not in hit:
            hit["secret_ptr"] = machine.reg("r0")   # generator's dest buffer
            hit["callee_ret"] = machine.reg("lr") & ~1
            hit["callee_entry"] = address
            machine.uc.emu_stop()

    handles = [m.hook_code(sign_hook, begin=a, end=a, precise=False) for a in addrs.values()]
    handles.append(m.hook_code(callee_hook, begin=callee_addr, end=callee_addr, precise=False))
    try:
        m._emu_start(main_entry_pc, main_ret, timeout=RUN_TIMEOUT_US)
        if "secret_ptr" not in hit:
            raise EmulationError(
                f"{elf_path}: {secret_via_callee} not reached from {func} call {call_index}"
            )
        # Run the generator to completion so the secret buffer is populated,
        # stopping right after it returns into the probe function.
        m._emu_start(hit["callee_entry"] | 1, hit["callee_ret"], timeout=RUN_TIMEOUT_US)
    finally:
        for h in handles:
            m.unhook(h)

    snap = m.snapshot()
    return ProbeSession(m, snap, hit["secret_ptr"], hit["output_ptr"],
                        hit["callee_ret"], hit["probe_ret"], secret_len, output_len)


def _nibbles(byte_list):
    out = []
    for b in byte_list:
        out.append(b & 0xF)
        out.append((b >> 4) & 0xF)
    return out


def linearity_probe(elf_path, func, secret_arg, secret_via_callee, secret_len,
                    output_arg, output_len, call_index, positions, n_tests, seed, label):
    """Affine GF(16)-linearity test via the standard basis.

    Any GF(16)-AFFINE F has the form F(X) = A*X + b, with b = F(0). (The
    signature has a nonzero constant term b -- sig(secret=0) != 0 -- so the
    bare F(X)=A*X model would reject even a genuinely linear-plus-constant
    map; subtracting b makes the test correct for degree <= 1.) Restricting X
    to the coordinates in `positions` (all others held at 0):
      0. query b = F(0) (every swept coordinate 0);
      1. query F(e_i) for each basis vector e_i (secret[pos_i] = 1); the
         linear part's i-th column is A_i = F(e_i) - b;
      2. for random X = (x_1..x_n), predict F_pred(X) = b + sum_i x_i * A_i
         (GF(16) arithmetic, "+" == XOR);
      3. query the black box at X and compare. Any differing output nibble
         proves F is not GF(16)-affine (degree >= 2 in the secret).
    Returns the number of mismatching nibbles summed over all test inputs:
    0 means "affine (collapsed)", clearly nonzero means "still nonlinear".

    One ProbeSession (one boot + one run up to the snapshot point) is reused
    for all 1 + len(positions) + n_tests trials.
    """
    session = open_probe_session(elf_path, func, secret_arg, secret_via_callee,
                                  secret_len, output_arg, output_len, call_index)

    rng = random.Random(seed)
    base = _nibbles(session.query({}))            # b = F(0)
    n = len(base)
    # Linear-part columns A_i = F(e_i) - b (char-2: subtraction == XOR).
    acols = {}
    for pos in positions:
        col = _nibbles(session.query({pos: 1}))
        acols[pos] = [col[i] ^ base[i] for i in range(n)]

    nonzero = 0
    failing_tests = 0
    for t in range(n_tests):
        x = {pos: rng.randrange(1, 16) for pos in positions}
        actual = _nibbles(session.query(x))
        predicted = list(base)
        for pos, xi in x.items():
            a = acols[pos]
            for i in range(n):
                predicted[i] ^= gf16_mul(xi, a[i])
        mism = sum(1 for i in range(n) if predicted[i] != actual[i])
        nonzero += mism
        failing_tests += mism != 0
        print(f"[i] {label}: test {t + 1}/{n_tests} X={x} -> {mism}/{n} nibbles differ from b + sum x_i*A_i")

    print(
        f"[i] {label}: affine-linearity probe over {len(positions)} basis vectors, {n_tests} tests, "
        f"{n} output nibbles -> {nonzero} mismatching nibbles, {failing_tests}/{n_tests} tests failed"
    )
    return {"n_nibbles": n, "n_tests": n_tests,
            "failing_tests": failing_tests, "nonzero_residual": nonzero}


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--func", default=ENTRY_FUNC,
                     help="probe function name: whose secret-argument input "
                          "and output are hooked/checked. Independent of "
                          "where the actual <name>__faulted fault gate "
                          "lives in the call tree.")
    ap.add_argument("--correct-elf", default=DEFAULT_CORRECT_ELF)
    ap.add_argument("--faulty-elf", default=DEFAULT_FAULTY_ELF)
    ap.add_argument("--secret-arg", type=int, default=None,
                     help="0-based declaration-order index of the secret "
                          "pointer argument, for the generic argument-"
                          "injection mode (default: looked up in KNOWN_FUNCS). "
                          "Ignored when --secret-via-callee is set.")
    ap.add_argument("--secret-via-callee", default=None,
                     help="name of the generator callee whose r0 destination "
                          "buffer is the swept secret (SNOVA sign: expand_T12, "
                          "whose output is the secret map T12). Default: "
                          "looked up in KNOWN_FUNCS for --func.")
    ap.add_argument("--secret-len", type=int, default=None,
                     help="secret buffer length in bytes (one nibble/pos).")
    ap.add_argument("--output-arg", type=int, default=None,
                     help="0-based declaration-order index of the output "
                          "pointer argument to degree-test.")
    ap.add_argument("--output-len", type=int, default=None,
                     help="output buffer length in bytes.")
    ap.add_argument("--call-index", type=int, default=1,
                     help="1-based call index of --func the probe targets.")
    ap.add_argument("--positions", default="0-31",
                     help="secret[] byte positions forming the basis e_i "
                          "(comma-separated, ranges like 0-31 allowed, or "
                          "'all' for the full n=secret_len basis). Default "
                          "0-31 sweeps the first 32 nibbles of T12; the full "
                          "T12 is o*v*l2 = 2160 coordinates.")
    ap.add_argument("--n-tests", type=int, default=4,
                     help="number of random extra inputs X compared against "
                          "the prediction sum x_i*C_i.")
    ap.add_argument("--seed", type=int, default=1)
    ap.add_argument(
        "--min-nonzero", type=int, default=5,
        help="minimum absolute nonzero-residual count for a 'correct' probe "
             "to count as genuinely nonlinear in the secret. Sweeping a "
             "single coordinate only exposes a small slice of the output, so "
             "the healthy count is naturally small -- what matters is that it "
             "is clearly nonzero.",
    )
    ap.add_argument(
        "--max-nonzero-faulty", type=int, default=1,
        help="maximum absolute nonzero-residual count still counted as "
             "'collapsed' for the faulty probe (0 is the clean expectation; "
             "a small allowance guards against incidental coincidences).",
    )
    ap.add_argument("--report", default=None)
    args = ap.parse_args()

    defaults = KNOWN_FUNCS.get(args.func, {})
    secret_arg = args.secret_arg if args.secret_arg is not None else defaults.get("secret_arg")
    secret_via_callee = (args.secret_via_callee if args.secret_via_callee is not None
                         else defaults.get("secret_via_callee"))
    secret_len = args.secret_len if args.secret_len is not None else defaults.get("secret_len")
    output_arg = args.output_arg if args.output_arg is not None else defaults.get("output_arg")
    output_len = args.output_len if args.output_len is not None else defaults.get("output_len")

    # One of the two injection modes must be resolvable.
    if secret_via_callee is None and secret_arg is None:
        print(f"[!] --func {args.func!r}: need --secret-via-callee or --secret-arg",
              file=sys.stderr)
        sys.exit(1)

    missing = [
        n for n, v in (
            ("--secret-len", secret_len),
            ("--output-arg", output_arg), ("--output-len", output_len),
        ) if v is None
    ]
    if missing:
        print(
            f"[!] --func {args.func!r} has no built-in defaults; "
            f"missing required argument(s): {', '.join(missing)}",
            file=sys.stderr,
        )
        sys.exit(1)

    for label, path in (("correct ELF", args.correct_elf), ("faulty ELF", args.faulty_elf)):
        if not os.path.isfile(path):
            print(f"[!] {label} not found: {path}", file=sys.stderr)
            sys.exit(1)

    if args.positions.strip() == "all":
        positions = list(range(secret_len))
    else:
        positions = []
        for tok in args.positions.split(","):
            tok = tok.strip()
            if not tok:
                continue
            lo, _, hi = tok.partition("-")
            positions.extend(range(int(lo), int(hi or lo) + 1))

    print("=" * 70)
    print(f"{args.func} degree-collapse probe: is the signature still nonlinear in the secret?")
    print("=" * 70)

    results = {"correct": [], "faulty": []}
    try:
        results["correct"].append(
            linearity_probe(args.correct_elf, args.func, secret_arg, secret_via_callee,
                            secret_len, output_arg, output_len, args.call_index,
                            positions, args.n_tests, args.seed, "correct")
        )
        results["faulty"].append(
            linearity_probe(args.faulty_elf, args.func, secret_arg, secret_via_callee,
                            secret_len, output_arg, output_len, args.call_index,
                            positions, args.n_tests, args.seed, "faulty ")
        )
    except EmulationError as e:
        print(f"[!] emulation failed: {e}", file=sys.stderr)
        sys.exit(2)

    print()
    print("=" * 70)
    print("Verdict")
    print("=" * 70)

    correct_healthy = all(
        r["nonzero_residual"] >= args.min_nonzero for r in results["correct"]
    )
    faulty_collapsed = all(
        r["nonzero_residual"] <= args.max_nonzero_faulty for r in results["faulty"]
    )
    weak_system_detected = correct_healthy and faulty_collapsed

    if weak_system_detected:
        print(
            f"[!] WEAK SYSTEM DETECTED: over the probed secret coordinates "
            f"({positions}), {args.func}'s signature is a GF(16)-"
            f"nonlinear function of the secret in the correct binary but "
            f"is exactly GF(16)-linear (F(X)=AX) in the faulty binary."
        )
        exit_code = 1
    else:
        print("[i] no nonlinear-to-linear collapse detected with these parameters.")
        exit_code = 0

    if args.report:
        with open(args.report, "w") as f:
            json.dump(
                {
                    "func": args.func,
                    "correct_elf": args.correct_elf,
                    "faulty_elf": args.faulty_elf,
                    "secret_arg": secret_arg,
                    "secret_via_callee": secret_via_callee,
                    "secret_len": secret_len,
                    "output_arg": output_arg, "output_len": output_len,
                    "results": results,
                    "weak_system_detected": weak_system_detected,
                },
                f,
                indent=2,
            )
        print(f"[i] report written to {args.report}")

    sys.exit(exit_code)


if __name__ == "__main__":
    main()
