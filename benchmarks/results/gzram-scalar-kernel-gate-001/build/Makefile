obj-m += n100_gzram_scalar_selftest.o
n100_gzram_scalar_selftest-y := selftest.o control/core.o candidate/core.o
ccflags-y += -O3 -fno-tree-vectorize -fno-strict-aliasing -mno-sse -mno-mmx -mno-avx -Werror
CFLAGS_control/core.o += -Dgzram_encode_scalar=control_encode_scalar -Dgzram_decode_scalar=control_decode_scalar -Dgzram_encode_avx2=control_encode_avx2 -Dgzram_decode_avx2=control_decode_avx2 -Dgzram_avx2_available=control_avx2_available
CFLAGS_candidate/core.o += -Dgzram_encode_scalar=candidate_encode_scalar -Dgzram_decode_scalar=candidate_decode_scalar -Dgzram_encode_avx2=candidate_encode_avx2 -Dgzram_decode_avx2=candidate_decode_avx2 -Dgzram_avx2_available=candidate_avx2_available
