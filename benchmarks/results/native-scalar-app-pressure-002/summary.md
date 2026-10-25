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
| mixed-pages | lz4-control | 1 | 14.163 | 92.008 | 5.250 | 307.26 |
| mixed-pages | lz4-mid | 1 | 13.863 | 90.634 | 5.131 | 307.36 |
| period-tail | lz4-control | 1 | 13.552 | 87.518 | 5.077 | 243.02 |
| period-tail | lz4-mid | 1 | 13.096 | 84.625 | 4.852 | 242.98 |

## Competing SHA256 workload

Pinned to CPU0 outside the pressure memcg; fixed 1 MiB hashes, 16 per batch.
Only batches fully inside the pressure launcher window contribute throughput.
This is a controlled CPU-contention probe, not interactive responsiveness.
Package energy covers both workloads, startup and background activity.

| Corpus | Algorithm | Trial | Application MiB/s | Median 16-hash batch ms | Overlapping batches |
|---|---|---:|---:|---:|---:|
| mixed-pages | lz4-control | 0 | 1015.233 | 15.963 | 893 |
| period-tail | lz4-control | 0 | 1012.584 | 15.935 | 851 |
| mixed-pages | lz4-mid | 0 | 1011.911 | 15.979 | 871 |
| period-tail | lz4-mid | 0 | 1013.719 | 15.971 | 824 |
