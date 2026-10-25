# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 25% deterministic zero-tail bytes, identical input across algorithms, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled read-only trials per algorithm; identical pages and full-device byte/SHA256 verification after every trial.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 414,486 | 2,134 | 15.832 | 412,891–432,117 |
| lz4-control | randread | 412,276 | 2,140 | 15.864 | 410,879–418,995 |
| lz4-mid | randread | 418,912 | 2,122 | 15.933 | 407,500–424,747 |
| lz4-small | randread | 412,696 | 2,138 | 16.127 | 407,478–420,045 |
| lzo-rle | randread | 507,281 | 1,689 | 12.889 | 500,826–536,759 |


## Paired trial comparisons against lz4-control

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4 | randread | +0.49% [-0.46, +3.13] | -1.01% [-3.85, +1.03] |
| lz4-mid | randread | +1.37% [-2.14, +1.85] | -0.65% [-2.30, +3.28] |
| lz4-small | randread | +0.44% [-1.61, +1.88] | +1.66% [-4.80, +5.28] |
| lzo-rle | randread | +23.34% [+19.53, +30.64] | -19.27% [-22.05, -12.47] |
