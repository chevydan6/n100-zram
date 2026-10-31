# SPDX-License-Identifier: GPL-2.0-only

n100_zram-y	:=	zcomp.o zram_drv.o

n100_zram-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
n100_zram-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
n100_zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
n100_zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
n100_zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)	+= backend_deflate.o
n100_zram-$(CONFIG_ZRAM_BACKEND_842)		+= backend_842.o

obj-m += n100_zram.o

# Keep the normal kernel no-SIMD flags. The private table ABI never escapes.
n100_zram-$(CONFIG_ZRAM_BACKEND_LZ4_SMALL) += backend_lz4_small.o n100s_lz4_compress.o
CFLAGS_n100s_lz4_compress.o += -O3 -fno-tree-vectorize -include $(src)/n100s_rename.h

ccflags-y += -DCONFIG_ZRAM_BACKEND_LZ4_SMALL=1

n100_zram-y += backend_lz4_control.o n100c_lz4_compress.o
CFLAGS_n100c_lz4_compress.o += -O3 -fno-tree-vectorize -include $(src)/n100c_rename.h
ccflags-y += -DCONFIG_ZRAM_BACKEND_LZ4_CONTROL=1
