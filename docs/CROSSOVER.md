# Adaptive SIMD experiment plan

Separate branch: feature/n100-adaptive-simd-zram. Scalar optimization continues
on feature/n100-avx2-zram; no experimental SIMD policy is merged into that branch.

Initial sweep: 16, 32, 64, 128, 256, 512, 1024, 2048 and 4096-byte independent
LZ4 blocks, 128 inputs each, incompressible/moderate/periodic patterns, scalar,
SSE2 guard and AVX2 guard implementations with identical 4 KiB hash arrays.
Three sessions, nine shuffled recorded rounds and two warm-ups per combination.
This varies internal codec workload lengths, not Linux memory page size.

The benchmark measures whole-block compression and decompression separately.
It does not yet isolate match searching, literal handling or overlapping copies,
and must not be used to infer those component thresholds. It excludes kernel
SIMD entry/exit costs. Its userspace results are screening evidence only.

PMU group: user-only cycles, instructions, branch misses and cache misses.
Preserve enabled/running fraction and reject incomplete or multiplexed counters
for crossover decisions; unavailable counters are -1. Counters include timed
loop/check/call and clock bookkeeping, not merely codec instructions. Package
energy and application responsiveness require additional native kernel workloads.

A crossover is workload-specific and may be nonmonotonic. Refine intervals only
where repeated paired results justify it; a single winning point is no threshold.
Re-run affected comparisons whenever scalar optimizations change. Test held-out
patterns and the full kernel dispatch/state cost before selecting a hybrid path.
No batching or MM page-size change is introduced by this sweep.

Build: python3 tools/build.py --variants scalar sse-guard avx2-guard;
python3 tools/prepare-crossover.py;
gcc -O2 -Wall -Wextra -Werror benchmarks/crossover.c -ldl -o build/crossover/benchmark.
Run tools/run-crossover.py with explicit --directory and a fresh private --output
on the physical N100 under the shared native hardware lock.
