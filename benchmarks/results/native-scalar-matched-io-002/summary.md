# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 50% nominal compression, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled trials per algorithm; full-device CRC32C after every trial and after write profiling.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 440,582 | 1,996 | 15.191 | 424,403–444,990 |
| lz4 | randwrite | 217,189 | 3,187 | 29.975 | 215,992–218,285 |
| lz4-control | randread | 425,591 | 2,063 | 16.044 | 288,063–436,431 |
| lz4-control | randwrite | 212,300 | 3,273 | 31.658 | 206,196–229,246 |
| lz4-small | randread | 432,627 | 2,033 | 15.427 | 430,967–441,810 |
| lz4-small | randwrite | 231,369 | 2,903 | 28.358 | 231,279–242,549 |
| lzo-rle | randread | 549,272 | 1,552 | 12.153 | 540,174–555,671 |
| lzo-rle | randwrite | 247,585 | 2,639 | 26.362 | 244,411–260,658 |


## Paired trial comparisons against lz4-control

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4 | randread | +1.56% [-0.78, +52.95] | -3.17% [-57.35, -1.91] |
| lz4 | randwrite | +1.74% [-5.51, +5.86] | -4.98% [-23.85, -3.24] |
| lz4-small | randread | +1.66% [+0.98, +50.19] | -3.50% [-56.76, +0.15] |
| lz4-small | randwrite | +11.07% [+0.89, +12.21] | -11.16% [-28.02, -7.95] |
| lzo-rle | randread | +29.91% [+26.56, +90.68] | -25.80% [-65.88, -18.05] |
| lzo-rle | randwrite | +18.28% [+8.00, +18.53] | -17.27% [-32.43, -12.23] |
