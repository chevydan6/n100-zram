obj-m += n100_gzram_hybrid_selftest.o
n100_gzram_hybrid_selftest-y := selftest.o adapters.o dispatch.o fallback.o scalar/encoder/core.o scalar/decoder/core.o scalar/hybrid.o scalar/lz4_compress.o scalar/lz4_decompress.o vector-encoder/core.o vector-decoder/core.o vector-trial.o
ccflags-y += -O3 -fno-tree-vectorize -fno-strict-aliasing -mno-sse -mno-mmx -mno-avx -Werror -Wframe-larger-than=1024 -fstack-usage
CFLAGS_vector-encoder/core.o += $(CC_FLAGS_FPU) -mavx2 -isystem $(shell $(CC) -print-file-name=include)
CFLAGS_vector-decoder/core.o += $(CC_FLAGS_FPU) -mavx2 -isystem $(shell $(CC) -print-file-name=include)
CFLAGS_vector-trial.o += $(CC_FLAGS_FPU) -mavx2 -isystem $(shell $(CC) -print-file-name=include)
