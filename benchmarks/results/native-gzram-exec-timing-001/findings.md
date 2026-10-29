# Distributed executable-page physical N100 test

Three sessions, nine rounds each, seven matched entries and three executable
corpora produced 1,134 operation rows. Each corpus contains 128 evenly selected
file-backed executable pages, not a representative reclaim distribution. The
machine was on battery, powersave, with 700–800 MHz limits. The audit verified
binary/library hashes, all expected rows, and a maximum telemetry gap of 0.681 s.
PMU groups were fully scheduled. Median thread occupancy was 98.94%, minimum
37.08%; preempted samples remain included. Package energy was unavailable.
A dedicated preflight snapshot was omitted at launch; therefore before/after
setting restoration cannot be established by this audit. This was userspace
only and no system settings or ZRAM operations were requested by the runner.

Pooled median times and median of per-session paired time ratios are shown;
they are distinct statistics, and time changes do not equal throughput changes.

| Corpus | LZ4 compression ns/page | Bounded compression ns/page | Paired time change | LZ4 bytes/page | Bounded bytes/page |
|---|---:|---:|---:|---:|---:|
| Bash | 39,813.0 | 41,245.2 | +4.21% | 3,266.3 | 3,274.8 |
| Git | 40,147.3 | 41,345.2 | +3.10% | 3,234.1 | 3,242.1 |
| libc | 38,862.2 | 40,894.1 | +4.77% | 3,004.2 | 3,012.2 |

Versus the unbounded combined parent, bounded compression changed by −1.56%,
−1.86% and −1.81% respectively; the Bash session signs were mixed. Frame sizes
were identical to that parent. Versus LZ4, decode time changes were −0.20%,
+0.61% and −0.07%; small own-entry differences cannot be assigned confidently
to the unchanged decoder. CPU time, cycles, all session changes and sizes are
retained in comparisons.json, and raw rows include every measured entry.

This confirms a remaining executable-page weakness versus the matched private
LZ4 control. It does not establish a native ZRAM, stock zstd, overall workload
or energy result. Fresh native recovery checks and kernel-inclusive measurements
remain required.
