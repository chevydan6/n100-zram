# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 25% nominal compression, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled trials per algorithm; full-device CRC32C after every trial and after write profiling.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 450,050 | 1,949 | 15.143 | 436,922–458,244 |
| lz4 | randwrite | 197,446 | 3,420 | 32.738 | 196,756–199,506 |
| lz4-control | randread | 446,286 | 1,960 | 15.376 | 440,260–457,956 |
| lz4-control | randwrite | 209,294 | 3,248 | 34.746 | 197,397–212,338 |
| lz4-small | randread | 435,018 | 2,027 | 15.468 | 425,856–437,168 |
| lz4-small | randwrite | 213,909 | 3,073 | 30.737 | 212,464–218,992 |
| lzo-rle | randread | 501,289 | 1,710 | 13.570 | 487,766–510,400 |
| lzo-rle | randwrite | 226,475 | 2,823 | 28.846 | 222,979–233,325 |


## Paired trial comparisons against lz4-control

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4 | randread | -0.76% [-2.54, +2.68] | -1.32% [-3.15, +1.75] |
| lz4 | randwrite | -5.99% [-7.01, +1.07] | -5.02% [-7.16, -1.10] |
| lz4-small | randread | -3.27% [-5.25, -1.02] | +2.04% [-0.29, +4.59] |
| lz4-small | randwrite | +2.21% [+0.40, +10.36] | -11.56% [-14.35, -2.83] |
| lzo-rle | randread | +10.79% [+9.72, +15.79] | -12.22% [-12.76, -9.59] |
| lzo-rle | randwrite | +7.90% [+5.58, +17.58] | -15.32% [-18.77, -3.75] |
