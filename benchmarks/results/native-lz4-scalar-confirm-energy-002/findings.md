# Corrected scalar LZ4 randomized energy confirmation

Three physical N100 sessions, nine randomized operation rounds each, 128 pages per corpus and 8,192 calls per batch. All 1,512 rows, library hashes, preflight/restoration settings and package-energy readings passed audit. Maximum telemetry gap 0.521 s; PMU and occupancy details are in audit.json. Package energy includes benchmark and other package activity, not whole-laptop energy or battery life. Userspace only.

The fixed harness resets each corpus size total. It confirms the previous timing/energy direction and recovered sizes. Pooled absolute medians and medians of session paired-round ratios are different statistics. Negative time means less time, not the same percentage increase in throughput.

| Corpus | Table | Control → candidate compression ns/page | Paired time change | Control → candidate package µJ/page | Paired energy change | Control → candidate bytes/page |
|---|---:|---:|---:|---:|---:|---:|
| bash-exec | 13 | 39123.1 → 38336.4 | -2.05% | 81.43 → 78.33 | -2.20% | 3239.09 → 3247.20 |
| bash-exec | 12 | 39123.1 → 37772.2 | -3.44% | 81.43 → 79.01 | -3.33% | 3239.09 → 3266.32 |
| git-exec | 13 | 39755.7 → 38973.9 | -2.04% | 84.68 → 82.89 | -1.43% | 3207.45 → 3216.27 |
| git-exec | 12 | 39755.7 → 38458.1 | -3.23% | 84.68 → 81.95 | -3.51% | 3207.45 → 3234.09 |
| libc-exec | 13 | 37816.6 → 37146.5 | -1.82% | 77.09 → 75.34 | -1.34% | 2982.82 → 2989.14 |
| libc-exec | 12 | 37816.6 → 36782.7 | -2.74% | 77.09 → 74.74 | -2.08% | 2982.82 → 3004.23 |
| mixed-pages | 13 | 17045.8 → 16349.4 | -4.11% | 36.69 → 35.97 | -2.63% | 2151.06 → 2152.88 |
| mixed-pages | 12 | 17045.8 → 15961.4 | -6.50% | 36.69 → 34.12 | -6.60% | 2151.06 → 2157.41 |
| period127 | 13 | 3964.2 → 3320.2 | -16.19% | 8.63 → 7.11 | -18.80% | 153.00 → 153.00 |
| period127 | 12 | 3964.2 → 2999.2 | -24.30% | 8.63 → 6.53 | -24.55% | 153.00 → 153.00 |
| random | 13 | 5093.0 → 4410.0 | -13.47% | 11.06 → 10.10 | -16.18% | 4114.00 → 4114.00 |
| random | 12 | 5093.0 → 4149.8 | -18.37% | 11.06 → 9.32 | -17.40% | 4114.00 → 4114.00 |
| sparse-words | 13 | 17551.6 → 16818.9 | -4.06% | 37.52 → 36.52 | -4.77% | 1079.64 → 1080.37 |
| sparse-words | 12 | 17551.6 → 16435.8 | -6.45% | 37.52 → 35.38 | -6.03% | 1079.64 → 1081.36 |

Full 2/4/8 KiB comparisons, decompression, CPU time, cycles and session changes are in paired.json. These file-backed executable samples are not a representative reclaim workload. The 4 KiB table spends less time and package energy but raises executable bytes; the 8 KiB table gives smaller gains and smaller size increases. No native ZRAM, overall workload or production-readiness claim is made.
