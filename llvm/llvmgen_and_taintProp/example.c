// SPDX-License-Identifier: MIT

/**
 * An example to demonstrate how to use the SNOVA API.
 */

#include <string.h>

#include "api.h"
#include "rng.h"
#include "symmetric.h"

/**
 * Example for the SNOVA NIST API (sign.c):
 * - crypto_sign_keypair
 * - crypto_sign
 * - crypto_sign_open
 *
 * @return int return code
 */
static int example_snova(void) {

    unsigned char entropy_input[48];
    for (int i = 0; i < 48; i++) {
        entropy_input[i] = i;
    }
    randombytes_init(entropy_input, NULL, 256);

    unsigned long long mlen = 32;
    unsigned long long smlen = 0;

    unsigned char pk[CRYPTO_PUBLICKEYBYTES];
    unsigned char sk[CRYPTO_SECRETKEYBYTES];

    unsigned char sm[CRYPTO_BYTES + 32];

    unsigned char msg[32] = { 0xe };
    unsigned char msg2[32] = { 0 };


    int res = crypto_sign_keypair(pk, sk);
    if (res != 0) {
        res = -1;
        goto err;
    } else {
    }

    res = crypto_sign(sm, &smlen, msg, mlen, sk);
    if (res != 0) {
        res = -1;
        goto err;
    } else {
    }

    res = crypto_sign_open(msg2, &mlen, sm, smlen, pk);
    if (res != 0 || memcmp(msg, msg2, mlen)) {
        res = -1;
        goto err;
    } else {
        res = 0;
    }

    // printf("crypto_sign_open (with altered signature) -> ");
    // sm[0] = ~sm[0];
    // memset(msg2, 0, mlen);
    // res = crypto_sign_open(msg2, &mlen, sm, smlen, pk);
    // if (res == 0 || !memcmp(msg, msg2, mlen)) {
    //     printf("FAIL\n");
    //     res = -1;
    //     goto err;
    // } else {
    //     res = 0;
    //     printf("OK\n");
    // }

err:
    snova_secure_clear(sk, sizeof(sk));
    return res;
}

int main(void) {
    return example_snova();
}
