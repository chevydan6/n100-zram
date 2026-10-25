# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 75% deterministic zero-tail bytes, identical input across algorithms, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled read-only trials per algorithm; identical pages and full-device byte/SHA256 verification after every trial.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 350,711 | 2,551 | 17.940 | 348,952–361,127 |
| lz4-control | randread | 348,812 | 2,589 | 17.817 | 343,073–351,127 |
| lz4-mid | randread | 352,980 | 2,580 | 17.740 | 349,246–355,399 |
| lz4-small | randread | 347,972 | 2,600 | 17.758 | 344,704–351,676 |
| lzo-rle | randread | 644,051 | 1,274 | 10.709 | 627,271–655,748 |


## Paired trial comparisons against lz4-control

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4 | randread | +2.06% [-0.52, +3.53] | +1.26% [-3.22, +1.99] |
| lz4-mid | randread | +0.53% [+0.12, +3.59] | +0.44% [-3.53, +1.05] |
| lz4-small | randread | -0.06% [-0.90, +0.82] | -0.33% [-2.60, +4.62] |
| lzo-rle | randread | +84.64% [+78.65, +91.14] | -39.80% [-43.98, -37.80] |
