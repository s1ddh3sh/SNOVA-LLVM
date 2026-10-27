#!/usr/bin/env python3
"""distributions_unicorn.py (snova) — sampling helper ported from
dist_tests/snova/setup/driver_dist.py's random_fill(). The driver has no
_DISTRIBUTION_TABLE: every buffer/scalar gets a plain uniform byte fill in
[0, field_mod), regardless of any "distribution" key a witness might
carry. sample_for_distribution() here is therefore just random_fill()
under the name unicorn_runner.run_trial() expects.

SNOVA's reference implementation stores one GF(16) element per byte
(gf_t), so a fill in [0, 16) is a uniform field element in every GF
buffer.
"""


def random_fill(rng, field_mod, length):
    return [rng.randrange(field_mod) for _ in range(length)]


# q = 16 for the default parameter set (SNOVA_I_S_AES): GF(16), one element
# per byte. Every SNOVA sweep/trial uses this by default.
SNOVA_FIELD_MOD = 16


def sample_for_distribution(dist_name, length, rng, field_mod):
    """dist_name is ignored (no distribution table) -- always a plain
    uniform [0, field_mod) fill."""
    return random_fill(rng, field_mod, length)
