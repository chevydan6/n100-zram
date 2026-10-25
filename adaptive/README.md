# Kernel SIMD component experiment

This separate probe measures match comparison, bounded literal copy and period-8
match expansion. Normal scalar, scalar with kernel FPU bracketing, SSE2 and AVX2
paths share the same root-only misc interface. It does not replace ZRAM.

Lengths 16..65536 bytes are diagnostic internal operation sizes. Linux MM page
size is unchanged. Operations larger than 4096 do not imply batching is available
on the ZRAM swap path. Match patterns include equal, first/middle/last mismatch.

Generate with kernel-components/prepare.py --output /fresh/probe and build with
make -C /usr/src/kernels/EXACT_RELEASE M=/fresh/probe modules. Scalar/main objects
retain normal kernel no-SIMD flags; only vector leaf objects enable SSE2/AVX2.
Every vector invocation checks context and CPU capability, brackets kernel FPU
state, and falls back to scalar when SIMD is unavailable or already active.
No allocation, mutex acquisition or sleeping call occurs inside the FPU section.

Compile components-bench.c with -O2 -Wall -Wextra -Werror -mno-avx
-fno-tree-vectorize -Ikernel-components. The helper tests all sixteen YMM
sentinels and configures clean/SSE-dirty/YMM-dirty caller fixtures. Latencies
include syscall, mutex, dispatch, loop and FPU costs; scalar/FPU-scalar isolates
much of state-handling cost. Requested caller states are fixtures, not complete
models of every application's kernel xstate history. PMU groups include user
and kernel activity. RAPL covers whole batches and bookkeeping/background work.

Diskless exact-ABI validation passed 78 configurations, 312 YMM-sentinel calls,
oddsized initialization checks, output canaries and nested-FPU scalar fallback.
No native performance conclusion is established by that VM. Native execution
requires the shared hardware lock, exact-module validation hash and the existing
verified recovery path. run-components.py unloads only its own probe afterward.

These three primitives are not all compression/decompression operations. They do
not yet establish hash-search, format parsing, global classification, whole-codec
or end-to-end ZRAM thresholds. No adaptive dispatch policy is selected from them.

## First physical N100 component results

All three sessions and 14,040 rows are retained in
../benchmarks/results/native-components-001, including user/kernel PMU and direct
RAPL data. Every PMU group was fully scheduled, every energy row was measured,
and the owned probe unloaded successfully after validation.

For the YMM-dirty, equal-input 4096-byte fixture (syscall/mutex/loop included):
scalar vs AVX2 match comparison was approximately 470 vs 768 ns; literal copy
309 vs 721 ns; repeated-8 copy 316 vs 706 ns. The same scalar body with FPU state
bracketing added approximately 430 ns. At 16 KiB, AVX2 comparison still lost by
about 5%; at 32 KiB it won by about 22%; at 64 KiB about 35%. These are specific
long-equal-comparison fixtures, not a universal crossover. Early mismatches and
copying require separate analysis; larger diagnostics do not justify page batching.
No adaptive kernel dispatch is selected from these component results alone.
