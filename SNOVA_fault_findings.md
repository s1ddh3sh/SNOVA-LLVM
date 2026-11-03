# Ineffective-, Correction-, and Vinegar-Distribution Fault Findings on SNOVA (reference implementation)

**Status:** research evaluation via simulation-based fault-detection. Intended for
responsible disclosure to the SNOVA team.
**Date:** 2026-11-03
**Target:** `SNOVA_I_S_AES` reference C implementation, this repository @ `76c43fc`
**Parameter set:** v = 27, o = 5, l = 4, r = 4, q = 16, m1 = 5 (n = v + o = 32; l² = lr = 16;
vinegar size v·l² = 432 GF(16) elements). NIST security level I.
**Author:** talktosiddhesh.shinde@gmail.com

> **Important caveat.** Every "leak" below is a *detection in a simulator*, not a
> bench-confirmed glitch. The pipeline flags secret-dependent divergence under a fault;
> it does not by itself execute end-to-end key recovery. Vectors marked **NEW** are, to
> our reading, not covered by published SNOVA fault analysis, but they still require the
> algebra to be wired up and ideally a hardware confirmation before being treated as
> established attacks. This document is written to help the SNOVA team assess and patch
> the non-commercial reference implementation.

---

## 0. Executive summary

- There is exactly **one** published fault attack on SNOVA: Banegas & Villanueva-Polanco,
  *A Fault Analysis on SNOVA* (ePrint 2024/1883 / arXiv 2509.12879). It uses a
  **value-fixing** model on the vinegar variables and recovers the secret `T12`.
- No published work frames a SNOVA attack as an **ineffective-fault (SIFA-style)**,
  **correction-fault**, or **secret-independence (distribution-collapse)** attack, nor as
  an **instruction-/store-skip** attack. That is the class our methodology probes.
- Three tests in the suite are relevant to key recovery — **ineffective**, **correction**,
  and the whole-program **vinegar-distribution** test (`vinegar_dist_snova.py`). §6 states,
  per test, exactly what it detects, where it fired, and the path from that signal to `T12`.
- Our sweep independently rediscovers the paper's injection point — the vinegar
  generation in `sign` — as an **ineffective leak reached by a store-skip** (stale value),
  not value-fixing. It also confirms the **Keccak-targeting route the paper explicitly
  declined** does leak on SNOVA.
- From the code plus the detections we identify **two vectors we believe are new**:
  - **(A)** skipping the private-seed absorb makes the vinegar **fully known** to the
    attacker ⇒ single-signature key recovery with no unknown constant to guess. This is
    the vector the **vinegar-distribution test detects directly** (and the one the
    value-level and ineffective tests structurally cannot — see §6.3);
  - **(C)** a vinegar-loop counter glitch produces **correlated** vinegar entries ⇒ a
    concrete instantiation of the related-randomness oracle the paper left open.
- A **value-level vinegar sanity check** (rejecting signatures whose fresh vinegar has too
  many repeated/colliding values) would catch the value-fixing / stale-store cases but
  **does not cover (A)**, whose vinegar stays correctly distributed and merely stops
  depending on the secret (§7).

---

## 1. Background: where the secret lives in signing

SNOVA signing (`SNOVA_NAMESPACE(sign)`, [src/snova_ref.c](src/snova_ref.c#L780)) derives
per-signature **vinegar** values and solves for the **oil** part so the result verifies.
The private linear map is

```
T = [ I11  T12 ]      S = T⁻¹ · V ,   V = (V₁,…,V_v, O₁,…,O_o)ᵀ
    [  O   I22 ]
```

with the core relation, for i ∈ [v]:

```
S_i + Σ_j T12_ij · S_{v+j} = V_i ,     and   S_{v+j} = O_j .
```

`T12` (v×o matrices over F_q[S]) **is the secret an attacker wants** — recovering it yields
an equivalent key. The vinegar `V_i` are generated fresh per signature from a SHAKE256
stream keyed by the private seed:

[src/snova_ref.c:881-914](src/snova_ref.c#L881-L914)

```c
shake256_init(&v_instance);
shake_absorb(&v_instance, seed + SEED_LENGTH_PUBLIC, SEED_LENGTH_PRIVATE); // L886: PRIVATE seed
shake_absorb(&v_instance, digest, BYTES_DIGEST);                          // L887: public
shake_absorb(&v_instance, salt,   BYTES_SALT);                            // L888: public (in sig)
shake_absorb(&v_instance, &num_sign, 1);                                  // L889: public counter
shake_finalize(&v_instance);
...
while (t_idx < SNOVA_v * SNOVA_l * SNOVA_r) {
    if (b_idx >= SK_BLOCK_SIZE) { shake_squeeze(vinegar_in_byte, SK_BLOCK_SIZE, &v_instance); b_idx = 0; }
    signature_in_GF[t_idx] = vinegar_in_byte[b_idx] & 0xf;  t_idx++;       // L908
    signature_in_GF[t_idx] = vinegar_in_byte[b_idx] >> 4;   t_idx++;       // L910-911
    b_idx++;
}
```

This block is the C analogue of **line 13 of Algorithm 2** in the SNOVA spec — the exact
step the only prior fault paper targets.

`T12` itself is produced at key generation by `expand_T12`
([src/snova_ref.c:576](src/snova_ref.c#L576)) from the private seed, two nibbles per seed byte.

---

## 2. Methodology

The detections come from an LLVM/Unicorn Cortex-M4 fault simulator. For each candidate
fault location in a function it builds a *correct* and a *faulty* ELF. Two complementary
harnesses run against those ELFs:

**(a) Per-function paired-sweep simulator** — runs three tests on each function in
isolation:

| Test | Question it answers |
|---|---|
| **direct_leak** | Does the faulty output equal the secret input (or otherwise expose it directly)? |
| **ineffective** | Over a paired sweep (secret values × public backgrounds), do the correct/faulty outputs *disagree in a secret-dependent way* — i.e. is the fault silently absorbed for some secrets but not others (the SIFA signal)? |
| **correction** | Is the faulty output a *constant XOR offset* of the correct one across all backgrounds (y₁ = y₂ ⊕ α, α ≠ 0)? |

**(b) Whole-program gated-ELF tests** — fuse each faulty function back into the full
program (`fuseback_gen.sh`), synthesise a `main` that calls `_SNOVA_I_S_AES_ref_sign`, and
observe an internal quantity across a secret sweep. The key-recovery-relevant one here is
the **vinegar-distribution** test (`vinegar_dist_snova.py`): it checks whether the signing
**vinegar still depends on the private seed** (§6.3). (A sibling linearity test,
`weak_system_snova.py`, probes whether the signature became a linear function of `T12`.)

Fault primitives swept (both harnesses): `binOpFault` (force an operand/op to
`opA`/`opB`/`zero`/`undef`), `loadStoreSkip` (`_mem`: drop a load/store), and
`loopOrFuncSkip` (`fnSkip`: skip a callee or loop body). "Detected = yes" means the
corresponding test reported a secret-dependent effect.

**Sampling caveat (affects completeness, not correctness).** SNOVA stores one GF(16)
element per byte (`gf_t = uint8_t`, low nibble), but seeds, `sk`/`skx`, messages, the salt,
and the Keccak state are **raw bytes**. The per-function sweep currently fills every input
byte with a value in [0, 16) and sweeps the secret over 16 values. For the *byte*-input
functions (`sign`, `crypto_sign`, `expand_T12`, the SHAKE/Keccak path) this exercises only
the low nibble and leaves high nibbles zero, so their leak sets are likely
**under-reported**. The GF-primitive results (`gf_*`, `compress_gf`) are unaffected. See §9.
(The vinegar-distribution test is not subject to this caveat: it sweeps full 32-byte private
seeds.)

---

## 3. Prior work

| Work | What it does | Relation to these findings |
|---|---|---|
| **Banegas & Villanueva-Polanco, *A Fault Analysis on SNOVA*** — [ePrint 2024/1883](https://eprint.iacr.org/2024/1883), [arXiv 2509.12879](https://arxiv.org/html/2509.12879v1) | The only dedicated SNOVA fault attack. **Value-fixing** of vinegar entries `V_i` at Alg. 2 line 13; differencing many signatures cancels the fixed entries ⇒ linear systems ⇒ `T12`. Also a single-signature "fault-assisted reconciliation attack" (quadratic solve). 22–68 faulty signatures depending on level. Suggested defense = a value-level check on the freshly generated vinegar. | We hit the **same injection point and secret**, but via **skip/ineffective** faults the paper does not model, plus **new** vinegar-control routes. |
| **Jendral & Dubrova, *MAYO Key Recovery by Fixing Vinegar Seeds*** | Faults **Keccak** to fix MAYO's vinegar. | The SNOVA paper explicitly declines this route ("instead of targeting Keccak, we focus directly on the vinegar variables"). Our Keccak/SHAKE detections show the route **does** bias SNOVA's vinegar — see §5. |
| *One vector to rule them all* ([2023/1131](https://eprint.iacr.org/2023/1131)); *Oil, Vinegar, and Sparks* ([2026/154](https://eprint.iacr.org/2026/154)) | UOV-family: one oil-space vector ⇒ key; single-EM-fault key recovery. | Context for how little leaked structure UOV-type schemes need for key recovery. |

The paper's fault model is explicitly **value-fixing only** — it does not consider
instruction-skip, store-skip, or zeroing, and does not frame anything as ineffective/SIFA
or correction faults. That is the gap this evaluation covers.

---

## 4. Detected leaks

89 unique (function, fault, test) detections from the per-function simulator, plus the one
whole-program vinegar-distribution collapse. Grouped by relevance to key recovery:

### 4.1 Signing — direct hit on the vinegar (highest relevance)

| Function | Fault | Test | Detail |
|---|---|---|---|
| `_SNOVA_I_S_AES_ref_sign` | `loadStoreSkip/..._line911_mem` | ineffective | `pos 6: 15/120 pairs disagree (+9 more positions)` |
| `_SNOVA_I_S_AES_ref_sign` | `loopOrFuncSkip/..._fnSkip_shake_absorb_line168` | vinegar-distribution | vinegar frozen across all private seeds (FULL COLLAPSE) — see §6.3 |

`line911` is the vinegar store `signature_in_GF[t_idx] = vinegar_in_byte >> 4`
([L908-911](src/snova_ref.c#L908-L911)). A skipped store leaves the **stale previous value**
in that vinegar slot — a *fixed, unknown* vinegar entry that recurs across signatures. This
is precisely the precondition of the prior paper's many-signature attack (its Alg. 3/4),
reached by a cheap skip glitch instead of precise value control.

`line168` (base-IR line for the private-seed absorb, source [L886](src/snova_ref.c#L886)) is
the single location the vinegar-distribution test flags: skipping it removes the secret from
the vinegar PRG entirely (vector A).

### 4.2 SHAKE / Keccak feeding the vinegar (the "declined" route)

| Function | Fault | Tests |
|---|---|---|
| `shake256_init` | `loopOrFuncSkip/..._fnSkip_memset_line0` | ineffective, correction |
| `shake256_init` | `loadStoreSkip/..._line2_mem` | correction |
| `shake_absorb` | `loopOrFuncSkip/..._fnSkip_keccak_inc_absorb_line3` | ineffective, correction |
| `shake_finalize` | `loopOrFuncSkip/..._fnSkip_keccak_inc_finalize_line3` | direct_leak, correction |
| `keccak_inc_absorb` | `line68_{opB,undef,zero}`, `line77_{opA,opB,undef,zero}`, `line60_mem`, `line76_mem`, `line78_mem` | ineffective and/or correction |
| `keccak_inc_finalize` | ~24 bin-op/mem faults (lines 4–20) | mostly correction |

These show the SHAKE state that produces the vinegar is faultable in a secret-dependent
way — the MAYO-style route the SNOVA paper left open.

### 4.3 Key generation — T12 / sk

| Function | Fault | Tests |
|---|---|---|
| `_SNOVA_I_S_AES_ref_genkeys` | `fnSkip_memcpy_line148_pk`, `fnSkip_memcpy_line151_sk` | ineffective, correction |
| `_SNOVA_I_S_AES_ref_sk_expand` | `fnSkip_memcpy_line0` | ineffective, correction |
| `crypto_sign_keypair` | `fnSkip_randombytes_line1`, `fnSkip_..._genkeys_line2` (pk & sk) | correction |

Keygen-time vectors (weak-key injection); outside the prior paper's signing-only model.

### 4.4 GF(16) primitives (generic SIFA leakage)

`gf_set_add` (lines 0,2,4,6,7 — several opA/opB/zero/undef/mem), `gf_mult`
(`line1_undef`, `line3_undef`), `gf_sub` (`line1_undef`, `line3_undef`), `compress_gf`
(`line22_opB`). Classic ineffective-fault leakage of a GF primitive; attack-relevant only
where the primitive sits on the vinegar/`T12` path, generic elsewhere. Full list in the
appendix.

---

## 5. Mapping detections onto the attack surface

| Detection | Prior-work status | Interpretation |
|---|---|---|
| `sign/line911_mem` (ineffective) | Banegas–VP injection point, **new fault primitive** | Their attack via **store-skip ⇒ stale-value fix** rather than value-fixing. Shows a defense must also cover skipped stores, not only out-of-range values. |
| `sign/line168` seed-absorb skip (vinegar-distribution) | **new vector (A)** | Removes the secret from the vinegar ⇒ vinegar attacker-recomputable. Not value-fixing; a value-level check cannot see it. |
| `shake*`/`keccak_*` leaks | route the paper **declined**; MAYO precedent | Confirms the Keccak-targeting variant biases SNOVA's vinegar. |
| `expand_T12` / `genkeys` memcpy | outside the paper's model | Keygen-time weak-key route. |
| `gf_*`, `compress_gf` | generic | SIFA primitive leakage; context-dependent. |

---

## 6. What each test detects, where, and the key-recovery path

This section answers, per test: **what signal it looks for**, **which locations fired it**,
and **how that signal becomes a `T12` recovery**. The three tests are complementary — they
catch *different* fault classes, and no single one covers all of A–E.

### 6.1 Ineffective (SIFA) test

- **Signal.** Under a paired sweep (many secret values × public backgrounds), the fault is
  *silently absorbed for some secrets and not others*. The pattern of "which secrets make
  the fault visible" is itself secret-dependent — the classic SIFA leak.
- **Locations that fired it.**
  - `sign/line911_mem` — skipped vinegar store ⇒ a **stale, fixed-but-unknown** vinegar slot
    (§4.1).
  - `shake256_init`, `shake_absorb`, `keccak_inc_absorb` — the hash state feeding the
    vinegar (§4.2).
  - `genkeys`/`sk_expand` memcpy — keygen handling of `T12`/`sk` (§4.3).
  - `gf_set_add`, `gf_mult`, `gf_sub`, `compress_gf` — GF primitives (§4.4).
- **Key-recovery path.** When the ineffective fault lands on the vinegar, it produces a
  vinegar entry that is **fixed but unknown** and **recurs across signatures**. Differencing
  about `l·o + 2 = 22` signatures (this parameter set) cancels the fixed entry, leaving a
  linear system in the oil variables whose solution yields `T12` — exactly Banegas–VP's
  many-signature attack (their Alg. 3/4), now triggered by a cheap skip instead of precise
  value control. For GF/Keccak primitives on the `T12`/vinegar path, the SIFA signal leaks
  the intermediate GF value directly; off that path it is generic leakage with no key
  consequence. → **vectors B, D, E.**

### 6.2 Correction test

- **Signal.** The faulty output is a **constant XOR offset** of the correct one across all
  public backgrounds: `y_faulty = y_correct ⊕ α`, with the same `α ≠ 0` every time. This is
  the fingerprint of a *deterministic* corruption (a zeroed/forced byte, a skipped
  state-clear) that an attacker can model and invert, rather than a data-dependent one.
- **Locations that fired it.**
  - `shake256_init/..._memset_line0` and `..._line2_mem` — skipping/perturbing the Keccak
    state clear leaves a **predictable** state (§4.2).
  - `shake_absorb`, `shake_finalize`, and ~24 `keccak_inc_finalize` bin-op/mem faults — a
    fixed offset on the sponge output (§4.2).
  - `genkeys`/`sk_expand` memcpy and `crypto_sign_keypair/randombytes` — fixed corruption of
    `sk`/seed material at keygen (§4.3).
- **Key-recovery path.** A constant, secret-independent offset on the hash/state makes the
  vinegar **predictably biased**: the attacker knows `α`, so the vinegar deviates from the
  honest stream in a way they can account for, reducing the unknowns in `S = T⁻¹·V`. Where
  the offset lands on `T12`/`sk` at keygen, it yields a **structurally weak key** (the
  `S_i + Σ T12_ij S_{v+j} = V_i` relation partially collapses). Correction faults are thus
  the "modelable corruption" counterpart to the ineffective test's "silent absorption." →
  **vectors D, E** (and a predictable-bias assist to B).

### 6.3 Vinegar-distribution (secret-dependence) test — `vinegar_dist_snova.py`

- **Signal.** This is a *whole-program* test, not a value test. It holds `digest`, `salt`,
  `num_sign` fixed and **sweeps the 32-byte private seed** over many values, capturing the
  signing vinegar each time, then measures the **per-nibble-position Shannon entropy** of the
  vinegar across the sweep:
  - **correct build:** every position moves as the seed moves → entropy ≈ max (≈ 4 bits with
    enough seeds); the vinegar is *secret-dependent* (healthy);
  - **faulty build:** the position is *frozen* (entropy 0) → the vinegar no longer depends on
    the secret. The verdict is the fraction of secret-dependent positions that collapse to
    frozen (0 = none, 1 = **full collapse**).
  Crucially the vinegar stays **statistically uniform** in both builds (the nibble histogram
  is ~flat either way), so a frequency/chi-square test — and the ineffective/correction value
  tests — **cannot** see this; only a secret-*dependence* measure can.
- **Location that fired it.** Exactly **one** of the 112 sign-path faults:
  `loopOrFuncSkip/..._fnSkip_shake_absorb_line168` — the skip of the **private-seed absorb**
  (source [L886](src/snova_ref.c#L886)) — reports **FULL COLLAPSE** (all secret-dependent
  positions frozen). Every other sign-path fault (binop/load-store/other skips) reports **no
  collapse**. Off-signing-path functions (keygen, `sk_expand`) are never exercised by the
  sign-only harness and so also report no collapse.
- **Key-recovery path.** With L886 skipped, the vinegar is
  `V = SHAKE256(digest ‖ salt ‖ num_sign)` — all public and present in the signature — so the
  attacker **recomputes `V` exactly**. The reconciliation relation `S = T⁻¹·V` then has a
  **fully known right-hand side**, strictly stronger than the paper's fixed-but-*unknown*
  entry: no constant to guess, no quadratic search. In principle **one** faulty signature
  pins the oil subspace and hence `T12`. → **vector A.**

### 6.4 Summary

| Test | Signal | Fired at (locations) | Vector(s) | Recovery path |
|---|---|---|---|---|
| **ineffective** | secret-dependent silent absorption (SIFA) | `sign/line911_mem`; `shake*`/`keccak_*`; keygen memcpy; `gf_*`/`compress_gf` | **B**, D, E | fixed-unknown vinegar ⇒ difference ~22 sigs ⇒ linear solve ⇒ `T12` |
| **correction** | constant XOR offset `y₁=y₂⊕α` | `shake256_init`; `shake_finalize`; `keccak_inc_finalize`; keygen memcpy; `randombytes` | **D**, E (assist to B) | predictable bias / weak key ⇒ fewer unknowns in `S=T⁻¹V` |
| **vinegar-distribution** | vinegar stops depending on the secret seed | `sign/..._fnSkip_shake_absorb_line168` (= src L886) | **A** | vinegar fully known ⇒ one signature ⇒ `T12` |

Note that **vector C** (vinegar-loop counter glitch, §7) is not surfaced by any of these
three tests as currently wired; it would need a dedicated check for *equalities among*
vinegar entries.

---

## 7. New candidate attack vectors

Ordered by impact. **(A)** and **(C)** are, to our reading, not in the prior literature.

### 🔴 A. Private-seed-absorb skip ⇒ *vinegar becomes fully known*  — **NEW**

The absorbs at [L886-889](src/snova_ref.c#L886-L889) are ordered: private seed (L886),
then digest, salt, counter (all public / recoverable from the signature). A fault that
**skips only L886** gives

```
vinegar = SHAKE256( digest ‖ salt ‖ num_sign )      // no secret input
```

so the attacker can **recompute V exactly** from public signature data. The reconciliation
relation `S = T⁻¹·V` then has a **fully known** right-hand side — strictly stronger than the
paper's *fixed-but-unknown* `ω`: no unknown constant to guess, no quadratic search over it.
In principle **one** faulty signature with its (now known) vinegar pins the oil subspace and
hence `T12`.

- **Detected directly** by the vinegar-distribution test (§6.3): the faulty build's vinegar
  is frozen across all private seeds (FULL COLLAPSE), confirming the secret no longer enters
  the stream.
- Why it is new: the paper assumes the vinegar stays secret-keyed and only *fixes* it; here
  the secret dependence is *removed*, which their model does not consider.
- Realism: a single instruction/function skip of the first of four absorbs — the kind of
  glitch the paper itself demonstrates with a ChipWhisperer.

### 🟠 B. Vinegar store-skip (generalization of `line911_mem`)

Skipping the store at [L908](src/snova_ref.c#L908) or [L910](src/snova_ref.c#L910) leaves a
**stale, fixed-unknown** vinegar entry in the same slot every signature. Differencing ≥ l·o+2
= **22** signatures (this parameter set) cancels the fixed entries and recovers `T12` — the
paper's Alg. 3, triggered by a skip rather than value-fixing. Flagged by the **ineffective**
test (§6.1).

### 🟠 C. Vinegar-loop counter glitch ⇒ *correlated* vinegar  — **NEW**

Skipping a `t_idx`/`b_idx` increment at [L909/L913](src/snova_ref.c#L909-L913) makes one
source nibble fill **two** vinegar slots, forcing `V_{i,a} = V_{i,b}`. That yields **linear
relations among vinegar entries** without fixing them — a concrete instantiation of the
related-randomness oracle the paper defines (their §3.6) but says it "does not know how to
instantiate… in a real scenario." Known equalities among vinegar entries add linear
constraints that, combined across signatures, reduce the reconciliation/MinRank cost. Not
surfaced by the current three tests (§6.4) — would need an equality-among-entries check.

### 🟡 D. `shake256_init` zeroing skip

The `shake256_init_fnSkip_memset_line0` detection: skipping the state `memset` leaves a
stale/predictable Keccak state ⇒ biased vinegar, feeding A/B. SNOVA analogue of the MAYO
Keccak fault. Flagged by both the **ineffective** and **correction** tests (§6.1, §6.2).

### 🟡 E. Keygen-time `T12` fault

Zeroing/fixing `T12` entries in `expand_T12`/`genkeys` (our §4.3 detections) yields a
**structurally weak key**: the `S_i + Σ T12_ij S_{v+j} = V_i` relation partially collapses,
lowering reconciliation cost. Different threat model (one persistent fault at the signer's
keygen), but a one-shot compromise.

---

## 8. Countermeasure coverage

The natural defense against the prior paper's value-fixing is a **value-level vinegar sanity
check**: right after vinegar generation, reject the signature if the freshly generated
vinegar has too many repeated values / column collisions. Whether such a check catches each
vector:

| Vector | Caught by a value-level vinegar check? | Why |
|---|---|---|
| B (stale store), §7 | **Yes** | Stale/fixed values trip the repetition/column check. |
| D (init skip), §7 | **Yes (likely)** | Biased values trip the value check. |
| C (counter glitch), §7 | **Partially** | Only if the forced equalities exceed the collision threshold; small numbers of correlated entries pass. |
| **A (seed-absorb skip), §7** | **No** | The vinegar is still correctly distributed — it is merely *secret-independent* (this is exactly what the vinegar-distribution test in §6.3 measures). No value-level check sees that; only verifying that the private seed actually entered the hash would. |

Recommendation: in addition to value-level checks, (i) bind a check that the **private seed
was absorbed** (e.g. recompute/verify a seed-dependent tag before using the stream), and
(ii) treat **skipped stores/absorbs** — not only out-of-range values — as part of the threat
model.

---

## 9. Limitations

1. **Simulation only.** Detections are secret-dependent divergences / distribution collapses
   in the Unicorn/LLVM model, not executed key recoveries or hardware glitches. Each vector
   needs the algebra implemented (differencing for B/C; the known-`V` solve for A) and
   ideally a ChipWhisperer/EM confirmation, as in the prior paper.
2. **Under-reporting on byte inputs (per-function tests).** As in §2, `sign`, `crypto_sign`,
   `expand_T12` and the SHAKE/Keccak path were swept with low-nibble-only secret variation
   and zero high nibbles. A full-byte sweep (0–255 secrets, 0–255 fills) may surface more of
   A–E. The GF-primitive results are already complete, and the vinegar-distribution test
   (full 32-byte seed sweep) is unaffected.
3. **Novelty is best-effort.** "NEW" means not found in the one SNOVA paper, the MAYO
   vinegar-seed work, or the UOV fault papers reviewed. A fuller literature pass may change
   this.
4. **Parameter-set specificity.** Numbers (n = 32, vinegar = 432, 22-signature bound) are for
   `SNOVA_I_S_AES`. Other sets scale per the paper's Table 3.

---

## 10. Recommendations

1. **Disclose A and C as new vectors**, B as "the known attack is reachable by instruction-
   skip, so any vinegar check must also cover skipped stores/absorbs," and A specifically as
   **not covered** by a value-level vinegar check.
2. **Harden vinegar generation:** verify the private seed entered the SHAKE stream;
   checksum the vinegar-fill loop counters; keep the value-level repetition/column checks.
3. **Re-run the byte-input functions with full-byte sweeps** to close the under-reporting
   gap before finalizing the disclosure.

---

## Appendix A. Parameter set

```
SNOVA_I_S_AES : v=27 o=5 l=4 r=4 q=16 m1=5   n=v+o=32   l²=lr=16
vinegar V size = v·l² = 432 GF(16) elements
many-signature T12 recovery bound (paper Alg.3): l·o + 2 = 22 signatures
```

## Appendix B. Full detected-fault list

Source: `fault_report_snova.csv` @ `76c43fc`. Each row is a (function, fault, test) with
`detected = yes`. Generate the current list with:

```sh
awk -F, '$6=="yes"{print $2" | "$3" | "$5}' fault_report_snova.csv | sort -u
```

See §4 for the grouped and interpreted view, and §6 for the per-test / per-location
key-recovery mapping. Valid (non-error) timeouts — 9 load/store skips in `sign` that stall
the signing loop, plus `shake_absorb`/`shake_squeeze`/`expand_T12` timeouts — are expected
and excluded from the leak analysis.

## Appendix C. Reproducing the vinegar-distribution detection

```sh
# from the repo root; builds the gated ELFs on demand, then runs the test
./llvm/dist_tests/snova/run_vinegar_dist_snova.sh _SNOVA_I_S_AES_ref_sign --n-seeds 48
```

Expected: of the 112 sign-path faulty builds, only
`..._fnSkip_shake_absorb_line168` reports FULL COLLAPSE (vector A); all others report no
collapse. Per-ELF results land under
`llvm/test_snova/_SNOVA_I_S_AES_ref_sign/**/vinegar_dist_{result.txt,report.json}`.
