# Native scalar small-table ZRAM I/O comparison

Physical N100, isolated synthetic ZRAM device, 64 MiB, 50% nominal compression, 4 KiB synchronous direct I/O, CPU 0.
Five shuffled trials per algorithm; full-device CRC32C after every trial and after write profiling.
Installed stock module, primary swap size and algorithm were verified restored.
Package energy covers the complete fio job, including startup/background activity.
This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.
Comparisons include compiler/code-layout differences, not only hash-table size.

| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) | IOPS range |
|---|---|---:|---:|---:|---:|
| lz4 | randread | 439,866 | 1,997 | 14.858 | 433,739–446,108 |
| lz4 | randwrite | 229,774 | 3,039 | 31.239 | 224,704–230,112 |
| lz4-control | randread | 431,693 | 2,050 | 14.838 | 427,946–438,422 |
| lz4-control | randwrite | 229,698 | 3,034 | 30.816 | 224,554–233,330 |
| lz4-small | randread | 434,922 | 2,027 | 15.028 | 433,878–436,446 |
| lz4-small | randwrite | 246,083 | 2,755 | 28.695 | 243,312–246,538 |
| lzo-rle | randread | 548,810 | 1,540 | 12.426 | 537,697–554,313 |
| lzo-rle | randwrite | 252,978 | 2,598 | 26.524 | 252,046–262,331 |


## Paired trial comparisons against lz4-control

Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.
Intervals describe this small experiment and do not establish general workload effects.

| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |
|---|---|---:|---:|
| lz4 | randread | +1.83% [-1.07, +3.92] | -0.15% [-2.20, +3.48] |
| lz4 | randwrite | -0.81% [-3.70, +2.40] | -0.09% [-1.17, +1.92] |
| lz4-small | randread | +1.04% [-0.80, +1.56] | +1.46% [-0.89, +2.47] |
| lz4-small | randwrite | +6.27% [+5.66, +9.59] | -7.28% [-8.78, -6.25] |
| lzo-rle | randread | +27.13% [+25.54, +28.33] | -17.21% [-18.99, -16.21] |
| lzo-rle | randwrite | +10.30% [+9.21, +16.08] | -14.98% [-16.05, -12.93] |
