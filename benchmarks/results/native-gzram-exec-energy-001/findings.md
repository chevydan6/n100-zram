# CPU package energy on executable pages

On the physical N100, three sessions each measured nine rounds on 128 pages per
corpus, with 8,192 calls per batch. All 972 expected rows and library/binary
hashes passed audit. The CPU package RAPL counter was opened read-only and all
rows contain readings. PMU groups were fully scheduled, maximum telemetry gap
was 0.555 s, and median thread occupancy was 99.09% (minimum 84.97%). All 466
telemetry samples show battery discharge and 700–800 MHz CPU policy limits.

Package energy includes benchmark bookkeeping and concurrent package activity;
it is not whole-laptop energy or battery life. A dedicated preflight snapshot
was not captured, so before/after ZRAM and settings restoration cannot be
independently verified by this audit. No system setting or ZRAM operation was
requested by the userspace runner. Results do not include kernel SIMD costs.

Absolute energy values are pooled medians; paired percentages are medians of
three session median ratios, and do not equal ratios of the pooled medians.
Positive percentages mean GZRAM used more package energy per page.

| Executable pages | LZ4 compression µJ/page | Bounded GZRAM µJ/page | Paired change | Session changes |
|---|---:|---:|---:|---|
| Bash | 123.60 | 125.53 | +3.23% | +3.12%, +5.97%, +3.23% |
| Git | 125.51 | 127.98 | +1.52% | +4.24%, +0.77%, +1.52% |
| libc | 115.81 | 122.08 | +4.41% | +6.74%, +3.39%, +4.41% |

Against its unbounded combined GZRAM parent, the bounded candidate used 2.59%,
2.97% and 3.29% less package energy for compression respectively; all three
session changes were negative for each corpus. Its compressed bytes matched
the parent; compared with LZ4, output was approximately eight bytes larger per
page. Its compression time was 3.82–4.83% higher than LZ4 in this cohort.

Decompression energy comparisons versus LZ4 were +2.79%, +0.76% and −1.81%
paired medians, with substantial session variation. Baseline and shared decoder
aliases resolved to the identical entry address in every session; small decoder
energy differences should not be attributed confidently to codec algorithms.
All session values, CPU time, cycles and compressed bytes are in comparisons.json;
raw operation rows and telemetry are retained. This file-page workload is not a
representative reclaim distribution, and no overall ZRAM or energy benefit is
established.
