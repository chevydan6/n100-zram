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
| mixed-pages | lz4-control | 5 | 14.605 | 87.417 | 5.371 | 307.30 |
| mixed-pages | lz4-mid | 5 | 13.884 | 88.159 | 5.118 | 307.25 |
| period-tail | lz4-control | 5 | 13.941 | 83.802 | 5.163 | 243.20 |
| period-tail | lz4-mid | 5 | 13.551 | 81.615 | 5.052 | 243.21 |

## Competing SHA256 workload

Pinned to CPU0 outside the pressure memcg; fixed 1 MiB hashes, 16 per batch.
Only batches fully inside the pressure launcher window contribute throughput.
This is a controlled CPU-contention probe, not interactive responsiveness.
Package energy covers both workloads, startup and background activity.

| Corpus | Algorithm | Trial | Application MiB/s | Median 16-hash batch ms | Overlapping batches |
|---|---|---:|---:|---:|---:|
| mixed-pages | lz4-control | 0 | 976.979 | 16.391 | 888 |
| mixed-pages | lz4-control | 1 | 979.817 | 16.389 | 889 |
| mixed-pages | lz4-control | 2 | 980.116 | 16.380 | 886 |
| mixed-pages | lz4-control | 3 | 978.462 | 16.392 | 887 |
| mixed-pages | lz4-control | 4 | 973.394 | 16.396 | 883 |
| period-tail | lz4-control | 0 | 1012.347 | 15.909 | 849 |
| period-tail | lz4-control | 1 | 976.677 | 16.413 | 844 |
| period-tail | lz4-control | 2 | 977.179 | 16.401 | 851 |
| period-tail | lz4-control | 3 | 981.676 | 16.381 | 849 |
| period-tail | lz4-control | 4 | 976.188 | 16.405 | 846 |
| mixed-pages | lz4-mid | 0 | 978.416 | 16.395 | 870 |
| mixed-pages | lz4-mid | 1 | 1011.806 | 15.821 | 866 |
| mixed-pages | lz4-mid | 2 | 975.970 | 16.401 | 869 |
| mixed-pages | lz4-mid | 3 | 1014.833 | 15.891 | 873 |
| mixed-pages | lz4-mid | 4 | 1015.948 | 15.959 | 876 |
| period-tail | lz4-mid | 0 | 1015.163 | 15.882 | 829 |
| period-tail | lz4-mid | 1 | 978.063 | 16.388 | 823 |
| period-tail | lz4-mid | 2 | 972.587 | 16.412 | 820 |
| period-tail | lz4-mid | 3 | 982.843 | 16.380 | 824 |
| period-tail | lz4-mid | 4 | 967.922 | 16.472 | 821 |
