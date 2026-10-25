/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_GZRAM_H
#define N100_GZRAM_H
#include <stddef.h>
/* Experimental userspace format. Input/output must not overlap.
 * Encoder: encoded byte count, or 0 on failure. Decoder: decoded byte count,
 * or -1 on failure; a failed call may modify a bounded output prefix.
 * No allocation or mutable workspace is needed. Maximum input is 4096 bytes.
 * block_log is 5..12; the maximum encoded size is input length + 8.
 * AVX2 entry points check CPU/OS support and fall back to scalar. */
int gzram_avx2_available(void);
int gzram_encode_scalar(const void *, size_t, void *, size_t, unsigned);
int gzram_encode_avx2(const void *, size_t, void *, size_t, unsigned);
int gzram_decode_scalar(const void *, size_t, void *, size_t);
int gzram_decode_avx2(const void *, size_t, void *, size_t);
#endif
