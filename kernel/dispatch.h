/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_LZ4_DISPATCH_H
#define N100_LZ4_DISPATCH_H
bool n100_lz4_simd_available(void);
int n100_lz4_compress(const char *src, char *dst, int size, int capacity, void *work);
int n100_lz4_decompress(const char *src, char *dst, int size, int capacity);
#endif
