# Benchmarks

## Initial N100 exploratory user-space run

Raw data: `benchmarks/results/n100-initial.csv`. These are codec timings, **not
ZRAM timings**. Kernel stock `7.0.10-201.fc44.x86_64`, Intel N100, GCC 16.2.1 (Red Hat 16.2.1-2), powersave
governor, CPU affinity to CPU 0, 4 GB physical memory. Background desktop activity
was not disabled. Initial thermal readings ranged 20–39 C across reported zones;
some sensors are not CPU package sensors. No frequency or thermal normalization
has yet been applied. This run is exploratory and does not satisfy acceptance.

The exact custom-kernel LZ4 source runs in user space. Four deterministic
synthetic corpora each contain 128 x 4096-byte pages: random, sparse (56 zero
bytes per 64-byte group), period-127, and mixed random/repeated data. There are
2 warmup rounds and 21 recorded rounds. Every operation batch has 8192 pages.
Variant order is deterministically shuffled. Clock: CLOCK_MONOTONIC_RAW.
Compression ratios are identical across variants; compressed byte counts are
recorded in every CSV row. Numbers below are medians, nanoseconds per page.

| Corpus | Operation | Scalar | SSE2 | AVX2 | AVX2 count only |
|---|---|---:|---:|---:|---:|
| random | compress | 1270.4 | 1263.6 | 1221.3 | 1187.2 |
| random | decompress | 113.9 | 114.0 | 114.3 | 113.9 |
| sparse | compress | 1818.3 | 2003.8 | 1881.3 | 1911.9 |
| sparse | decompress | 561.9 | 517.4 | 487.6 | 546.0 |
| period127 | compress | 936.4 | 666.6 | 599.9 | 592.0 |
| period127 | decompress | 224.3 | 188.7 | 217.0 | 224.5 |
| mixed | compress | 3146.6 | 3114.5 | 2962.9 | 2934.7 |
| mixed | decompress | 344.4 | 331.6 | 287.8 | 339.7 |

No energy or CPU core-cycle result is available. Perf is not installed and RAPL
energy counters require administrator access. Timing is wall time per page.
No stock-versus-custom-kernel or swap-latency comparison has occurred.
Zero/same-filled pages are correctness cases, not evidence of codec acceleration
in ZRAM, which can bypass compression for same-filled pages.

Next runs must add real executable pages, paired confidence intervals, thermal
sampling and repeated sessions. Kernel tests must include SIMD state overhead,
controlled secondary ZRAM I/O, actual memory pressure and recovery validation.
