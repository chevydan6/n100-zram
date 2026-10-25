# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 50% nominal compression, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled trials per algorithm; full-device CRC32C after every trial and after write profiling.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 443,150 | 1,979 | 14.888 | 432,095–447,456 |
| lz4 | randwrite | 231,298 | 3,003 | 30.939 | 230,299–233,563 |
| lz4-small | randread | 440,129 | 1,996 | 14.533 | 431,501–442,823 |
| lz4-small | randwrite | 250,271 | 2,690 | 28.090 | 241,762–252,677 |
| lzo-rle | randread | 556,095 | 1,519 | 11.965 | 546,106–578,757 |
| lzo-rle | randwrite | 265,205 | 2,471 | 26.671 | 260,666–265,640 |


## Paired trial comparisons against LZ4

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4-small | randread | -0.08% [-3.57, +1.75] | -2.74% [-3.30, +5.25] |
| lz4-small | randwrite | +8.20% [+4.98, +9.10] | -9.70% [-11.64, -6.47] |
| lzo-rle | randread | +25.47% [+22.05, +33.94] | -19.81% [-24.45, -14.09] |
| lzo-rle | randwrite | +13.70% [+13.15, +15.35] | -14.29% [-15.53, -12.61] |
