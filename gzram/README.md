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
