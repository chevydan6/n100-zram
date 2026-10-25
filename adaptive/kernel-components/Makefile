# SPDX-License-Identifier: GPL-2.0-only
obj-m += n100_component_probe.o
n100_component_probe-y := module.o scalar.o sse.o avx2.o
CFLAGS_scalar.o += -O3 -fno-tree-vectorize
CFLAGS_sse.o += -O3 -msse2 -fno-tree-vectorize
CFLAGS_avx2.o += -O3 -mavx2 -fno-tree-vectorize
