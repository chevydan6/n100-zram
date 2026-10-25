# GZRAM-AVX2

An independent userspace research codec in the N100 ZRAM project. It explores
vector-friendly sparse words and short repeated patterns, separate control/data,
internal block sizes from 32 to 4096 bytes, and explicit raw framing. It is not
an established format, production compressor or native ZRAM replacement.

Build with x86-64 Linux, GCC, Python 3 and libc headers:

```
python3 gzram/tools/build.py
python3 gzram/tests/check.py
```

AVX2 routines are target-attributed with runtime CPU/OS checks and scalar fallback.
The build also provides a matched small-table scalar LZ4 reference. Generated
artifacts remain under build/. See docs/FORMAT.md and docs/RESEARCH.md here.
All performance conclusions must come from physical N100 runs. No improvement
is claimed before native comparisons of ratio, latency, cycles and energy.

Native screening compares sixteen GZRAM scalar/AVX2 block-size combinations
against the existing optimized scalar LZ4, with nine corpora and three sessions.
Compile `gzram/bench.c` using GCC -O2 -Wall -Wextra -Werror -ldl, and run
`gzram/tools/run-native.py` with explicit --directory and a fresh --output under
the shared N100 lock. --resume requires identical input fingerprints and retains
partial attempts. No kernel module or swap configuration is changed by this job.
PMU counts are user-only; missing measurements remain -1. CPU package energy
includes counter/timer bookkeeping and background work, not just instructions.

Initial local correctness and ASan/UBSan passed: 31,296 cross-path round trips,
62,528 guarded-capacity cases, 40,000 malformed/mutated decode cases and 4,000
four-thread round trips. These are correctness results, not N100 speed claims.

First physical N100 results are in ../../benchmarks/results/native-gzram-user-001.
All initial block sizes and regressions are retained. Selected patterns compress
and decode quickly, but period-127 pages expanded from about 153 LZ4 bytes to a
4104-byte GZRAM raw frame. Word-tail and executable data also lose ratio. Fast raw
copying is not evidence of a successful general compressor. No kernel backend or
preferred adaptive policy has been selected.

A separate libgzram-fast.so preserves the original scalar reference and tests a
prefix-derived repeat candidate plus branchless sparse-word masks. It keeps format
bytes identical. Three physical N100 sessions now show lower encoding latency
than the original scalar reference on several patterns; see the comparison below. When this
candidate library is present, the benchmark includes all 25 paths (original scalar,
AVX2, faster scalar across eight block sizes, and optimized scalar LZ4). The runner
records a source fingerprint and checks the N100 CPU model before performance runs.


The faster-scalar comparison is preserved in
[the complete native results](../benchmarks/results/native-gzram-fast-scalar-001/summary.md).
At a 1024-byte internal block size, median encoding latency changed from
3886.9 to 483.2 ns/page on half-zero pages and from 5045.9 to 1913.4 ns/page
on sparse-word pages. AVX2 measured 332.4 and 1469.2 ns/page respectively.
These are warm-cache userspace measurements; kernel SIMD state costs are excluded.
Sparse-word decoding still favors scalar (1363.1 ns/page) over AVX2
(1600.4 ns/page). Encoding and decoding therefore need separate selection.

This candidate changes scanning cost, not compression ratio. Period-127 input
still needs 4104 bytes versus 153 for LZ4, and executable pages also lose ratio.
The original reference, candidate, AVX2 paths and all eight block sizes remain
available. No kernel integration or hybrid threshold is accepted from these data.
The next experiments should address decoder call overhead and ratio failures,
while preserving the original format and scalar reference.
