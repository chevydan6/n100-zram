# Physical N100 ZRAM I/O comparison

Kernel: 7.2.8-200.fc44.x86_64. Five randomized trials per backend for experimental modules; three for the installed-stock baseline.

64 MiB synthetic device; 4 KiB synchronous direct I/O; CPU0; 50% nominal fio buffer compression. Every trial passed full CRC32C verification. Energy includes complete fio process startup and package background work, rather than codec-only energy.

| Algorithm | Operation | Median IOPS | IOPS range | Median package uJ/IO |
|---|---|---:|---:|---:|
| lz4 | randread | 471,466 | 466,436–479,386 | 13.800 |
| lz4 | randwrite | 239,031 | 235,939–240,291 | 29.940 |
| lzo-rle | randread | 605,483 | 602,490–605,684 | 11.177 |
| lzo-rle | randwrite | 272,284 | 271,459–276,007 | 25.645 |

The rebuilt driver controls differ from the separate installed-stock baseline. Cross-module differences are not assigned to codec changes. Compare candidates with LZ4 in the same module. Temperatures/frequency snapshots and every recorded fio result are preserved. Frequency was sampled around each job, rather than continuously within the five-second interval; this limits cross-run attribution. No overall production optimization is accepted from these results.
