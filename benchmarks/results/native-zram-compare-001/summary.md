# Physical N100 ZRAM I/O comparison

Kernel: 7.2.8-200.fc44.x86_64. Five randomized trials per backend for experimental modules; three for the installed-stock baseline.

64 MiB synthetic device; 4 KiB synchronous direct I/O; CPU0; 50% nominal fio buffer compression. Every trial passed full CRC32C verification. Energy includes complete fio process startup and package background work, rather than codec-only energy.

The I/O trials completed, but the controller failed to unload because systemd reactivated primary swap. Stock restoration was subsequently verified by comparing live GNU build-id notes with the installed signed module. This recovery failure remains part of the record. The scalar decoder was the unconditional match-only prototype.

| Algorithm | Operation | Median IOPS | IOPS range | Median package uJ/IO |
|---|---|---:|---:|---:|
| lz4 | randread | 455,191 | 451,451–456,171 | 14.640 |
| lz4 | randwrite | 229,493 | 227,639–236,987 | 30.180 |
| lz4-n100 | randread | 379,134 | 372,418–382,120 | 16.920 |
| lz4-n100 | randwrite | 225,088 | 222,997–226,293 | 31.483 |
| lz4-rep8 | randread | 567,535 | 551,690–586,594 | 11.997 |
| lz4-rep8 | randwrite | 232,495 | 225,361–234,980 | 30.121 |
| lzo-rle | randread | 572,547 | 568,175–583,444 | 11.972 |
| lzo-rle | randwrite | 257,966 | 252,841–265,024 | 26.064 |

The rebuilt driver controls differ from the separate installed-stock baseline. Cross-module differences are not assigned to codec changes. Compare candidates with LZ4 in the same module. Temperatures/frequency snapshots and every recorded fio result are preserved. Frequency was sampled around each job, rather than continuously within the five-second interval; this limits cross-run attribution. No overall production optimization is accepted from these results.
