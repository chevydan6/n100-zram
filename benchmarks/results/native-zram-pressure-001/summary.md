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
| mixed-pages | lz4 | 5 | 7.134 | 43.913 | 5.174 | 307.30 |
| mixed-pages | lz4-n100 | 5 | 7.170 | 43.291 | 5.128 | 307.27 |
| mixed-pages | lz4-rep8 | 5 | 7.075 | 43.295 | 5.123 | 307.25 |
| mixed-pages | lzo-rle | 5 | 6.970 | 42.810 | 4.996 | 386.98 |
| period-tail | lz4 | 5 | 6.695 | 42.303 | 4.876 | 243.16 |
| period-tail | lz4-n100 | 5 | 6.759 | 43.824 | 4.927 | 243.27 |
| period-tail | lz4-rep8 | 5 | 6.782 | 41.891 | 5.008 | 243.18 |
| period-tail | lzo-rle | 5 | 6.521 | 41.150 | 4.763 | 398.11 |

## Paired trial changes versus ordinary LZ4

Each interval resamples the five paired trial ratios (10,000 seeded bootstrap
draws). The small sample and shared machine conditions limit inference; these
are descriptive repeatability intervals. Positive time/energy changes are worse.

| Corpus | Candidate | Elapsed change [95%] | Package-energy change [95%] |
|---|---|---:|---:|
| mixed-pages | lzo-rle | -1.10% [-2.77, +0.58] | -3.88% [-6.86, -1.62] |
| mixed-pages | lz4-n100 | +1.66% [-0.94, +3.81] | -1.87% [-4.89, +0.26] |
| mixed-pages | lz4-rep8 | -0.49% [-3.83, +2.96] | -1.39% [-4.13, +1.42] |
| period-tail | lzo-rle | -1.73% [-3.44, -0.35] | -3.61% [-5.37, -2.26] |
| period-tail | lz4-n100 | +1.12% [-0.36, +2.78] | +2.34% [-1.30, +5.87] |
| period-tail | lz4-rep8 | +1.46% [-0.24, +3.17] | -2.16% [-5.34, +0.62] |

No candidate demonstrates a broad accepted improvement over LZ4 in this run.
Lzo-rle is faster here, while LZ4 uses less peak ZRAM memory: about 307 versus
387 MiB on mixed pages, and 243 versus 398 MiB on periodic tails, with similar
cgroup swap peaks. This is a workload-specific space/time tradeoff, not an
argument for changing the preserved default. Further tests must include compiler
controls and larger working sets before choosing a routine configuration.
