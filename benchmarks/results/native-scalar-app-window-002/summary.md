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
| mixed-pages | lz4-control | 5 | 30.089 | 180.224 | 5.388 | 307.64 |
| mixed-pages | lz4-mid | 5 | 30.087 | 183.815 | 5.123 | 307.45 |
| period-tail | lz4-control | 5 | 30.088 | 180.301 | 5.193 | 243.18 |
| period-tail | lz4-mid | 5 | 30.089 | 180.324 | 5.059 | 243.14 |

## Competing SHA256 workload

Pinned to CPU0 outside the pressure memcg; fixed 1 MiB hashes, 16 per batch.
Only batches fully inside the pressure launcher window contribute throughput.
This is a controlled CPU-contention probe, not interactive responsiveness.
Package energy covers both workloads, startup and background activity.

| Corpus | Algorithm | Trial | Application MiB/s | Median 16-hash batch ms | Overlapping batches |
|---|---|---:|---:|---:|---:|
| mixed-pages | lz4-control | 0 | 981.959 | 16.387 | 891 |
| mixed-pages | lz4-control | 1 | 973.217 | 16.426 | 889 |
| mixed-pages | lz4-control | 2 | 981.930 | 16.381 | 891 |
| mixed-pages | lz4-control | 3 | 968.286 | 16.463 | 888 |
| mixed-pages | lz4-control | 4 | 977.498 | 16.413 | 889 |
| period-tail | lz4-control | 0 | 974.396 | 16.409 | 849 |
| period-tail | lz4-control | 1 | 974.939 | 16.412 | 847 |
| period-tail | lz4-control | 2 | 972.833 | 16.414 | 846 |
| period-tail | lz4-control | 3 | 975.479 | 16.401 | 848 |
| period-tail | lz4-control | 4 | 975.819 | 16.396 | 847 |
| mixed-pages | lz4-mid | 0 | 976.860 | 16.403 | 866 |
| mixed-pages | lz4-mid | 1 | 1016.021 | 15.815 | 872 |
| mixed-pages | lz4-mid | 2 | 974.827 | 16.425 | 871 |
| mixed-pages | lz4-mid | 3 | 1012.838 | 15.894 | 874 |
| mixed-pages | lz4-mid | 4 | 997.235 | 16.145 | 873 |
| period-tail | lz4-mid | 0 | 976.733 | 16.404 | 826 |
| period-tail | lz4-mid | 1 | 978.348 | 16.400 | 825 |
| period-tail | lz4-mid | 2 | 971.076 | 16.478 | 823 |
| period-tail | lz4-mid | 3 | 970.316 | 16.504 | 836 |
| period-tail | lz4-mid | 4 | 971.994 | 16.437 | 827 |

## Fixed application observation window

The competing process continues after pressure finishes, through the same fixed window.
Total elapsed/energy above includes that window. Pressure completion is separate below.
This captures post-pressure CPU availability; scheduler weights and clocks still matter.

| Corpus | Algorithm | Trial | Pressure completion s | Fixed window s | Application MiB/s across window |
|---|---|---:|---:|---:|---:|
| mixed-pages | lz4-control | 0 | 14.518 | 30.0 | 1544.533 |
| mixed-pages | lz4-control | 1 | 14.615 | 30.0 | 1526.933 |
| mixed-pages | lz4-control | 2 | 14.518 | 30.0 | 1545.600 |
| mixed-pages | lz4-control | 3 | 14.673 | 30.0 | 1530.667 |
| mixed-pages | lz4-control | 4 | 14.551 | 30.0 | 1536.533 |
| period-tail | lz4-control | 0 | 13.941 | 30.0 | 1563.733 |
| period-tail | lz4-control | 1 | 13.900 | 30.0 | 1558.400 |
| period-tail | lz4-control | 2 | 13.914 | 30.0 | 1560.533 |
| period-tail | lz4-control | 3 | 13.909 | 30.0 | 1560.000 |
| period-tail | lz4-control | 4 | 13.888 | 30.0 | 1564.800 |
| mixed-pages | lz4-mid | 0 | 14.184 | 30.0 | 1551.467 |
| mixed-pages | lz4-mid | 1 | 13.732 | 30.0 | 1594.667 |
| mixed-pages | lz4-mid | 2 | 14.296 | 30.0 | 1544.000 |
| mixed-pages | lz4-mid | 3 | 13.807 | 30.0 | 1589.867 |
| mixed-pages | lz4-mid | 4 | 14.007 | 30.0 | 1568.533 |
| period-tail | lz4-mid | 0 | 13.531 | 30.0 | 1580.267 |
| period-tail | lz4-mid | 1 | 13.492 | 30.0 | 1572.800 |
| period-tail | lz4-mid | 2 | 13.560 | 30.0 | 1571.200 |
| period-tail | lz4-mid | 3 | 13.785 | 30.0 | 1560.000 |
| period-tail | lz4-mid | 4 | 13.613 | 30.0 | 1562.667 |
