# Physical N100 ZRAM I/O comparison

Kernel: 7.2.8-200.fc44.x86_64. Five randomized trials per backend for experimental modules; three for the installed-stock baseline.

64 MiB synthetic device; 4 KiB synchronous direct I/O; CPU0; 50% nominal fio buffer compression. Every trial passed full CRC32C verification. Energy includes complete fio process startup and package background work, rather than codec-only energy.

This repeat used the first-match selective decoder. All trials and automated stock restoration passed. The selective decoder lost the earlier I/O gain: a fio CRC header creates short initial matches before the useful long periodic run. Both negative and positive codec findings are retained.

| Algorithm | Operation | Median IOPS | IOPS range | Median package uJ/IO |
|---|---|---:|---:|---:|
| lz4 | randread | 458,909 | 451,023–466,248 | 14.326 |
| lz4 | randwrite | 235,901 | 233,976–237,602 | 30.064 |
| lz4-n100 | randread | 379,403 | 378,024–387,820 | 16.533 |
| lz4-n100 | randwrite | 229,682 | 227,685–230,365 | 30.732 |
| lz4-rep8 | randread | 454,251 | 451,709–461,196 | 14.222 |
| lz4-rep8 | randwrite | 236,773 | 235,758–238,550 | 29.527 |
| lzo-rle | randread | 596,326 | 589,975–604,386 | 11.306 |
| lzo-rle | randwrite | 268,196 | 267,262–268,303 | 25.719 |

The rebuilt driver controls differ from the separate installed-stock baseline. Cross-module differences are not assigned to codec changes. Compare candidates with LZ4 in the same module. Temperatures/frequency snapshots and every recorded fio result are preserved. Frequency was sampled around each job, rather than continuously within the five-second interval; this limits cross-run attribution. No overall production optimization is accepted from these results.
