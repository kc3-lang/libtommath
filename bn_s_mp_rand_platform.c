#include "tommath_private.h"
#ifdef BN_S_MP_RAND_PLATFORM_C
/* LibTomMath, multiple-precision integer library -- Tom St Denis */
/* SPDX-License-Identifier: Unlicense */

void arc4random_buf(void *buf, size_t nbytes);

mp_err s_mp_rand_platform(void *p, size_t n)
{
   arc4random_buf(p, n);
   return MP_OKAY;
}

#endif
