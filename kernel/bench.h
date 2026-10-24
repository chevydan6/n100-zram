/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_BENCH_H
#define N100_BENCH_H
#include <linux/ioctl.h>
#define N100_BENCH_PAGES 128
#define N100_BENCH_VALIDATE _IO('N',0)
#define N100_BENCH_COMP_SCALAR _IO('N',1)
#define N100_BENCH_COMP_SIMD _IO('N',2)
#define N100_BENCH_DEC_SCALAR _IO('N',3)
#define N100_BENCH_DEC_SIMD _IO('N',4)
#ifdef __KERNEL__
int n100_bench_register(void);
void n100_bench_unregister(void);
#endif
#endif
