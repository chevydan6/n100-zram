# Native N100 controlled memory-pressure results

Physical N100; controlled memcg reclaim, 768 MiB working set, 384 MiB resident ceiling, 320 MiB high threshold, 1 GiB swap ceiling, CPU0, dedicated 1 GiB logical ZRAM device with priority 200.

every byte in three full permuted passes; four concurrent CPU/register helpers before every trial; no OOM.

Whole-workload time includes pattern generation, swap, byte comparison, service startup
and telemetry. Package energy also includes background activity. Page-compare latencies
include cache/resident pages and swap faults; they are not pure codec or swap-in timings.
This forces real reclaim on the installed 4 GiB target without exhausting the entire machine.
One trial is a harness smoke check, not a repeatability or optimization acceptance result.

| Corpus | Algorithm | Trials | Median elapsed s | Median package J | Median system CPU s | Peak ZRAM MiB |
|---|---|---:|---:|---:|---:|---:|
| mixed-pages | lz4-control | 1 | 30.087 | 179.870 | 5.444 | 307.43 |
| mixed-pages | lz4-mid | 1 | 30.103 | 190.141 | 5.009 | 309.18 |
| period-tail | lz4-control | 1 | 30.087 | 185.984 | 4.994 | 243.19 |
| period-tail | lz4-mid | 1 | 30.087 | 187.740 | 4.900 | 243.24 |

## Competing SHA256 workload

Pinned to CPU0 outside the pressure memcg; fixed 1 MiB hashes, 16 per batch.
Only batches fully inside the pressure launcher window contribute throughput.
This is a controlled CPU-contention probe, not interactive responsiveness.
Package energy covers both workloads, startup and background activity.

| Corpus | Algorithm | Trial | Application MiB/s | Median 16-hash batch ms | Overlapping batches |
|---|---|---:|---:|---:|---:|
| mixed-pages | lz4-control | 0 | 964.017 | 16.526 | 885 |
| period-tail | lz4-control | 0 | 1014.140 | 15.917 | 846 |
| mixed-pages | lz4-mid | 0 | 1015.439 | 15.846 | 875 |
| period-tail | lz4-mid | 0 | 1014.899 | 15.977 | 829 |

## Fixed application observation window

The competing process continues after pressure finishes, through the same fixed window.
Total elapsed/energy above includes that window. Pressure completion is separate below.
This captures post-pressure CPU availability; scheduler weights and clocks still matter.

| Corpus | Algorithm | Trial | Pressure completion s | Fixed window s | Application MiB/s across window |
|---|---|---:|---:|---:|---:|
| mixed-pages | lz4-control | 0 | 14.689 | 30.0 | 1530.667 |
| period-tail | lz4-control | 0 | 13.347 | 30.0 | 1608.000 |
| mixed-pages | lz4-mid | 0 | 13.787 | 30.0 | 1592.000 |
| period-tail | lz4-mid | 0 | 13.069 | 30.0 | 1619.200 |
