# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 75% nominal compression, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled trials per algorithm; full-device CRC32C after every trial and after write profiling.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 438,015 | 2,016 | 15.215 | 413,925–447,196 |
| lz4 | randwrite | 253,049 | 2,711 | 26.904 | 246,992–260,686 |
| lz4-control | randread | 430,546 | 2,054 | 15.377 | 427,535–434,945 |
| lz4-control | randwrite | 250,288 | 2,750 | 27.304 | 242,510–251,480 |
| lz4-mid | randread | 427,667 | 2,081 | 15.568 | 418,421–433,390 |
| lz4-mid | randwrite | 266,048 | 2,525 | 25.468 | 261,978–273,325 |
| lz4-small | randread | 418,754 | 2,116 | 15.683 | 409,909–421,339 |
| lz4-small | randwrite | 275,034 | 2,414 | 25.268 | 271,566–278,086 |
| lzo-rle | randread | 619,580 | 1,336 | 11.044 | 612,814–633,408 |
| lzo-rle | randwrite | 283,717 | 2,254 | 23.055 | 281,712–297,618 |


## Paired trial comparisons against lz4-control

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4 | randread | +1.22% [-4.83, +4.60] | -0.95% [-3.74, +39.04] |
| lz4 | randwrite | +1.10% [-1.60, +4.44] | -1.19% [-5.14, +1.68] |
| lz4-mid | randread | -1.08% [-2.13, -0.36] | -0.54% [-1.54, +1.91] |
| lz4-mid | randwrite | +6.75% [+4.67, +11.76] | -6.12% [-10.51, -3.71] |
| lz4-small | randread | -2.45% [-5.76, -1.98] | +1.15% [-1.70, +6.04] |
| lz4-small | randwrite | +9.37% [+8.96, +14.67] | -7.46% [-9.08, -6.86] |
| lzo-rle | randread | +42.45% [+42.33, +48.15] | -29.08% [-30.34, -26.92] |
| lzo-rle | randwrite | +16.57% [+12.82, +18.58] | -15.48% [-16.69, -9.78] |
