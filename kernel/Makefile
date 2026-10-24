# SPDX-License-Identifier: GPL-2.0-only
obj-m += n100_lz4_probe.o
n100_lz4_probe-y := probe.o dispatch.o lz4_compress.o lz4_decompress.o
CFLAGS_lz4_compress.o += -O3 -mavx2 -fno-tree-vectorize -include $(src)/rename.h
CFLAGS_lz4_decompress.o += -O3 -mavx2 -fno-tree-vectorize -include $(src)/rename.h
