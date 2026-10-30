# Matched GZRAM and scalar LZ4: physical N100 userspace cohort

The same-run comparison randomizes compression and decompression tasks across scalar and AVX2 bounded GHY1 and four scalar LZ4 table sizes. Each of three sessions has nine rounds, 128 independently recoverable pages per corpus and 8,192 calls per batch. This is userspace screening; no native ZRAM, kernel FPU cost, application responsiveness or real-world acceptance result. GHY1 framing is included while direct LZ4 has no GHY1 container. Allocator-rounded ZRAM usage is not derived from bytes.

Absolute values are pooled medians; percentages are medians of the three session median paired-round ratios, and do not necessarily equal the ratios of pooled medians. Negative time changes mean less time, not the same percentage increase in throughput. Session ranges are descriptive, not confidence intervals. Package energy, when available, includes background package activity and harness bookkeeping; it is not whole-laptop energy or battery life. See audit.json for telemetry, occupancy, PMU and restoration evidence.

| Corpus | Operation | GHY candidate | LZ4 control | Control → GHY ns/page | Paired time change | Control → GHY µJ/page | Paired energy change | Control → GHY bytes/page |
|---|---|---|---|---:|---:|---:|---:|---:|
| bash-exec | compress | ghy-combined-scalar | table14-scalar | 39650.9 → 41395.9 | +4.40% | 91.98 → 97.85 | +5.54% | 3239.09 → 3274.84 |
| bash-exec | compress | ghy-combined-scalar | table12-scalar | 38218.1 → 41395.9 | +8.39% | 90.74 → 97.85 | +7.88% | 3266.32 → 3274.84 |
| bash-exec | compress | ghy-combined-avx2 | table14-scalar | 39650.9 → 40683.2 | +2.57% | 91.98 → 93.15 | +0.92% | 3239.09 → 3274.84 |
| bash-exec | compress | ghy-combined-avx2 | table12-scalar | 38218.1 → 40683.2 | +6.47% | 90.74 → 93.15 | +4.72% | 3266.32 → 3274.84 |
| bash-exec | decompress | ghy-combined-scalar | table14-scalar | 6982.2 → 7121.8 | +1.92% | 15.98 → 16.29 | +3.76% | 3239.09 → 3274.84 |
| bash-exec | decompress | ghy-combined-scalar | table12-scalar | 7079.1 → 7121.8 | +0.66% | 17.16 → 16.29 | +0.75% | 3266.32 → 3274.84 |
| bash-exec | decompress | ghy-combined-avx2 | table14-scalar | 6982.2 → 7124.3 | +2.30% | 15.98 → 16.38 | +8.56% | 3239.09 → 3274.84 |
| bash-exec | decompress | ghy-combined-avx2 | table12-scalar | 7079.1 → 7124.3 | +0.45% | 17.16 → 16.38 | +2.75% | 3266.32 → 3274.84 |
| git-exec | compress | ghy-combined-scalar | table14-scalar | 40206.6 → 41678.1 | +3.71% | 96.31 → 98.66 | +4.29% | 3207.45 → 3242.09 |
| git-exec | compress | ghy-combined-scalar | table12-scalar | 38886.7 → 41678.1 | +7.11% | 93.96 → 98.66 | +6.29% | 3234.09 → 3242.09 |
| git-exec | compress | ghy-combined-avx2 | table14-scalar | 40206.6 → 41053.1 | +2.12% | 96.31 → 98.44 | +2.81% | 3207.45 → 3242.09 |
| git-exec | compress | ghy-combined-avx2 | table12-scalar | 38886.7 → 41053.1 | +5.57% | 93.96 → 98.44 | +3.53% | 3234.09 → 3242.09 |
| git-exec | decompress | ghy-combined-scalar | table14-scalar | 7025.9 → 7147.9 | +1.33% | 16.91 → 17.07 | -2.10% | 3207.45 → 3242.09 |
| git-exec | decompress | ghy-combined-scalar | table12-scalar | 7092.5 → 7147.9 | +0.88% | 16.82 → 17.07 | +6.50% | 3234.09 → 3242.09 |
| git-exec | decompress | ghy-combined-avx2 | table14-scalar | 7025.9 → 7159.8 | +1.79% | 16.91 → 17.53 | +1.96% | 3207.45 → 3242.09 |
| git-exec | decompress | ghy-combined-avx2 | table12-scalar | 7092.5 → 7159.8 | +1.15% | 16.82 → 17.53 | +5.24% | 3234.09 → 3242.09 |
| libc-exec | compress | ghy-combined-scalar | table14-scalar | 38262.3 → 40234.9 | +5.27% | 88.33 → 92.75 | +6.19% | 2982.82 → 3012.23 |
| libc-exec | compress | ghy-combined-scalar | table12-scalar | 37137.1 → 40234.9 | +8.36% | 84.74 → 92.75 | +10.35% | 3004.23 → 3012.23 |
| libc-exec | compress | ghy-combined-avx2 | table14-scalar | 38262.3 → 39514.8 | +3.26% | 88.33 → 89.79 | +1.55% | 2982.82 → 3012.23 |
| libc-exec | compress | ghy-combined-avx2 | table12-scalar | 37137.1 → 39514.8 | +6.35% | 84.74 → 89.79 | +4.55% | 3004.23 → 3012.23 |
| libc-exec | decompress | ghy-combined-scalar | table14-scalar | 7052.5 → 7155.7 | +1.41% | 16.41 → 16.65 | +3.27% | 2982.82 → 3012.23 |
| libc-exec | decompress | ghy-combined-scalar | table12-scalar | 7081.9 → 7155.7 | +1.21% | 16.39 → 16.65 | +3.99% | 3004.23 → 3012.23 |
| libc-exec | decompress | ghy-combined-avx2 | table14-scalar | 7052.5 → 7141.4 | +1.56% | 16.41 → 16.88 | +2.81% | 2982.82 → 3012.23 |
| libc-exec | decompress | ghy-combined-avx2 | table12-scalar | 7081.9 → 7141.4 | +0.77% | 16.39 → 16.88 | +4.54% | 3004.23 → 3012.23 |
| mixed-pages | compress | ghy-combined-scalar | table14-scalar | 17233.7 → 14722.5 | -14.64% | 39.19 → 34.52 | -12.75% | 2151.06 → 2049.07 |
| mixed-pages | compress | ghy-combined-scalar | table12-scalar | 16114.8 → 14722.5 | -8.68% | 37.68 → 34.52 | -8.76% | 2157.41 → 2049.07 |
| mixed-pages | compress | ghy-combined-avx2 | table14-scalar | 17233.7 → 14048.4 | -18.64% | 39.19 → 33.45 | -13.89% | 2151.06 → 2049.07 |
| mixed-pages | compress | ghy-combined-avx2 | table12-scalar | 16114.8 → 14048.4 | -13.06% | 37.68 → 33.45 | -7.73% | 2157.41 → 2049.07 |
| mixed-pages | decompress | ghy-combined-scalar | table14-scalar | 4558.6 → 3457.5 | -23.14% | 10.62 → 7.81 | -28.17% | 2151.06 → 2049.07 |
| mixed-pages | decompress | ghy-combined-scalar | table12-scalar | 4548.9 → 3457.5 | -24.19% | 10.26 → 7.81 | -25.52% | 2157.41 → 2049.07 |
| mixed-pages | decompress | ghy-combined-avx2 | table14-scalar | 4558.6 → 3591.7 | -20.31% | 10.62 → 8.20 | -24.16% | 2151.06 → 2049.07 |
| mixed-pages | decompress | ghy-combined-avx2 | table12-scalar | 4548.9 → 3591.7 | -20.13% | 10.26 → 8.20 | -18.00% | 2157.41 → 2049.07 |
| period127 | compress | ghy-combined-scalar | table14-scalar | 4014.4 → 4690.4 | +16.61% | 9.78 → 11.15 | +17.51% | 153.00 → 161.00 |
| period127 | compress | ghy-combined-scalar | table12-scalar | 3020.6 → 4690.4 | +54.59% | 7.19 → 11.15 | +58.19% | 153.00 → 161.00 |
| period127 | compress | ghy-combined-avx2 | table14-scalar | 4014.4 → 4158.1 | +2.83% | 9.78 → 10.02 | +8.69% | 153.00 → 161.00 |
| period127 | compress | ghy-combined-avx2 | table12-scalar | 3020.6 → 4158.1 | +37.56% | 7.19 → 10.02 | +35.65% | 153.00 → 161.00 |
| period127 | decompress | ghy-combined-scalar | table14-scalar | 962.2 → 974.9 | +1.45% | 2.38 → 2.39 | +6.00% | 153.00 → 161.00 |
| period127 | decompress | ghy-combined-scalar | table12-scalar | 963.0 → 974.9 | +1.97% | 2.28 → 2.39 | +4.96% | 153.00 → 161.00 |
| period127 | decompress | ghy-combined-avx2 | table14-scalar | 962.2 → 969.6 | +0.87% | 2.38 → 2.38 | -1.70% | 153.00 → 161.00 |
| period127 | decompress | ghy-combined-avx2 | table12-scalar | 963.0 → 969.6 | +0.64% | 2.28 → 2.38 | +3.08% | 153.00 → 161.00 |
| random | compress | ghy-combined-scalar | table14-scalar | 5161.9 → 6613.9 | +28.38% | 12.44 → 15.60 | +26.06% | 4114.00 → 4104.00 |
| random | compress | ghy-combined-scalar | table12-scalar | 4260.4 → 6613.9 | +54.19% | 10.30 → 15.60 | +54.39% | 4114.00 → 4104.00 |
| random | compress | ghy-combined-avx2 | table14-scalar | 5161.9 → 6022.2 | +16.85% | 12.44 → 14.01 | +13.25% | 4114.00 → 4104.00 |
| random | compress | ghy-combined-avx2 | table12-scalar | 4260.4 → 6022.2 | +42.66% | 10.30 → 14.01 | +30.78% | 4114.00 → 4104.00 |
| random | decompress | ghy-combined-scalar | table14-scalar | 504.0 → 473.8 | -6.09% | 1.12 → 1.11 | -5.39% | 4114.00 → 4104.00 |
| random | decompress | ghy-combined-scalar | table12-scalar | 502.3 → 473.8 | -5.85% | 1.21 → 1.11 | -5.39% | 4114.00 → 4104.00 |
| random | decompress | ghy-combined-avx2 | table14-scalar | 504.0 → 477.6 | -4.91% | 1.12 → 1.16 | -5.55% | 4114.00 → 4104.00 |
| random | decompress | ghy-combined-avx2 | table12-scalar | 502.3 → 477.6 | -5.20% | 1.21 → 1.16 | -5.31% | 4114.00 → 4104.00 |
| sparse-words | compress | ghy-combined-scalar | table14-scalar | 17675.6 → 5973.0 | -66.21% | 41.39 → 14.57 | -65.74% | 1079.64 → 660.84 |
| sparse-words | compress | ghy-combined-scalar | table12-scalar | 16552.9 → 5973.0 | -63.97% | 39.03 → 14.57 | -62.84% | 1081.36 → 660.84 |
| sparse-words | compress | ghy-combined-avx2 | table14-scalar | 17675.6 → 5003.9 | -71.75% | 41.39 → 11.88 | -71.27% | 1079.64 → 660.84 |
| sparse-words | compress | ghy-combined-avx2 | table12-scalar | 16552.9 → 5003.9 | -70.06% | 39.03 → 11.88 | -69.20% | 1081.36 → 660.84 |
| sparse-words | decompress | ghy-combined-scalar | table14-scalar | 7911.0 → 3935.3 | -49.87% | 18.77 → 9.51 | -47.75% | 1079.64 → 660.84 |
| sparse-words | decompress | ghy-combined-scalar | table12-scalar | 7897.0 → 3935.3 | -49.99% | 18.53 → 9.51 | -49.44% | 1081.36 → 660.84 |
| sparse-words | decompress | ghy-combined-avx2 | table14-scalar | 7911.0 → 4293.3 | -45.46% | 18.77 → 10.21 | -44.01% | 1079.64 → 660.84 |
| sparse-words | decompress | ghy-combined-avx2 | table12-scalar | 7897.0 → 4293.3 | -45.37% | 18.53 → 10.21 | -43.77% | 1081.36 → 660.84 |

All controls, decompression, CPU time, cycles, instructions and session changes are retained in paired.json and raw CSVs. The LZ4 variants use one decoder entry; scalar and AVX2 GHY use distinct entries, so small decode differences may reflect code layout and setup. The executable fixtures are distributed file-backed pages, not an observed reclaim distribution. No overall improvement is claimed.
