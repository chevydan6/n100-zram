# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 25% nominal compression, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled trials per algorithm; full-device CRC32C after every trial and after write profiling.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 447,587 | 1,950 | 15.104 | 441,229–457,255 |
| lz4 | randwrite | 196,002 | 3,458 | 33.304 | 194,980–209,788 |
| lz4-control | randread | 440,089 | 1,983 | 15.592 | 435,608–443,174 |
| lz4-control | randwrite | 196,966 | 3,438 | 33.013 | 194,675–198,974 |
| lz4-mid | randread | 440,336 | 2,001 | 15.412 | 439,003–446,245 |
| lz4-mid | randwrite | 208,534 | 3,181 | 31.995 | 202,410–216,797 |
| lz4-small | randread | 435,146 | 2,025 | 15.590 | 426,382–435,544 |
| lz4-small | randwrite | 212,045 | 3,104 | 30.720 | 211,376–215,741 |
| lzo-rle | randread | 505,118 | 1,704 | 13.335 | 500,508–513,277 |
| lzo-rle | randwrite | 223,969 | 2,860 | 30.196 | 219,719–232,240 |


## Paired trial comparisons against lz4-control

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4 | randread | +1.72% [+1.29, +3.18] | -3.13% [-6.10, +1.50] |
| lz4 | randwrite | -0.83% [-1.22, +7.76] | +1.43% [+0.64, +6.80] |
| lz4-mid | randread | +0.69% [-0.28, +1.40] | +0.89% [-3.22, +1.99] |
| lz4-mid | randwrite | +5.81% [+2.76, +11.31] | -3.08% [-5.13, +3.91] |
| lz4-small | randread | -1.77% [-3.21, -0.11] | -0.30% [-2.57, +4.63] |
| lz4-small | randwrite | +7.59% [+6.23, +9.53] | -6.89% [-8.66, -5.02] |
| lzo-rle | randread | +14.66% [+14.44, +17.83] | -13.05% [-15.50, -10.93] |
| lzo-rle | randwrite | +13.71% [+12.86, +17.84] | -8.77% [-12.44, -3.46] |
