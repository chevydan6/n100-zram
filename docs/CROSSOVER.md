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

The first native three-session sweep is retained in benchmarks/results/native-crossover-002.
All recorded PMU groups reported >=99% scheduled time. The exporter applies an
all-session 2% paired-win screening rule, separately by workload and direction.
Suggested refinement lengths: 40, 48, 56, 320, 384, 448, 1280, 1536, 1792 bytes.
Use tools/run-crossover.py --sizes to collect these points. Some wins can come
from compiler code layout rather than executed SIMD instructions; profiles and
assembly inspection are required. "Scalar" here means scalar codec translation
units; shared userspace libc memcpy/memset may themselves use SIMD. These
measurements cannot predict kernel memory primitives or state-management cost.

Refined native sessions are retained in benchmarks/results/native-crossover-refine-003.
Use tools/combine-crossover.py to combine initial/refined points only when all
three codec library hashes match. Combined nearest-neighbor screening transitions
are in benchmarks/results/crossover-combined-screening.json. An unresolved-to-AVX2
transition does not prove an architectural SIMD threshold: code layout and libc
paths can differ even when the explicit vector loop does not execute. Native
kernel-context and component measurements remain required before hybrid selection.

Instrumented diagnostic builds (`prepare-crossover.py --trace`) count explicit
vector iterations in match comparison and bounded copies. Run trace-crossover.py
for byte identity, independent decoding and path coverage. Trace builds change
code generation and are not timing binaries. Libc SIMD is not counted. Coverage
can distinguish explicit vector-loop execution from an AVX2-labelled codec that
wins due to other compiler/runtime effects; it does not establish profitability.

Native instrumented coverage is in benchmarks/results/native-crossover-path-coverage-001.json.
For the generated 4 KiB random blocks, the AVX2-labelled codec executed zero
explicit match/copy vector iterations in both directions. Its user-space timing
advantage on random blocks therefore cannot be credited to those vector loops.
Compiler layout and shared libc paths require separate accounting. Moderately
compressible and periodic blocks do execute explicit vector paths. Instrumented
builds are correctness/coverage diagnostics and cannot supply performance numbers.
