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
| mixed-pages | lz4 | 5 | 6.873 | 46.028 | 5.010 | 307.34 |
| mixed-pages | lz4-small | 5 | 6.887 | 42.102 | 4.913 | 307.30 |
| mixed-pages | lzo-rle | 5 | 6.934 | 42.786 | 4.947 | 387.14 |
| period-tail | lz4 | 5 | 6.565 | 43.511 | 4.873 | 243.27 |
| period-tail | lz4-small | 5 | 6.617 | 39.764 | 4.844 | 243.21 |
| period-tail | lzo-rle | 5 | 6.696 | 40.877 | 4.915 | 398.12 |
