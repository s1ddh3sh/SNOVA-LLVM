// SPDX-License-Identifier: MIT

/**
 * Host helper for llvmgen: runs the reference snova_init() and prints every
 * global it fills, one "<name> <hex bytes>" line each. llvmgen gives the IR
 * globals these values as static initialisers, so a function extracted
 * without snova_init() (the per-function fault tests) still sees the real
 * GF tables.
 */

#include "snova_ref.c"

static void dump(const char *name, const uint8_t *data, size_t len) {
    printf("%s ", name);
    for (size_t i = 0; i < len; i++) {
        printf("%02x", data[i]);
    }
    printf("\n");
}

int main(void) {
    snova_init();

    dump("gf_multtab", gf_multtab, sizeof(gf_multtab));
    dump("gf_invtab", gf_invtab, sizeof(gf_invtab));
    dump("gf_addtab", gf_addtab, sizeof(gf_addtab));
    dump("gf_S", gf_S, sizeof(gf_S));
#if FIXED_ABQ
    dump("fixed_abq", fixed_abq, sizeof(fixed_abq));
#endif
    return 0;
}
