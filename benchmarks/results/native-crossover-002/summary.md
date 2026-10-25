# Native N100 scalar/SSE2/AVX2 whole-codec size sweep

Physical N100 whole-codec size sweep; kernel FPU costs, component thresholds and energy excluded.
Three consecutive sessions, nine shuffled recorded rounds and two warm-ups; 128 independent blocks/corpus, 8,192 calls/batch.
All variants use a 4 KiB hash array. Linux page size is unchanged. Byte identity and cross-decoding passed.
Every recorded batch, user-only cycles/instructions/branch/cache counters and scheduling fractions are retained.
CPU 0; no energy counter or kernel FPU entry/exit measurement is included.
Costs include codec calls, loop/checks and timer bookkeeping. Cache conditions are synthetic.
Compression and decompression are analyzed separately; these are not component-operation thresholds.

A candidate winner must beat both other paths by at least 2% in every session, using
median ratios paired by round. Otherwise the row says unresolved. This is a screening
rule, not a population confidence claim. Isolated wins and nonmonotonic changes must
not be turned into a universal threshold. Scalar improvements require remeasurement.

| Bytes | Corpus | Operation | Scalar / SSE2 / AVX2 ns | Candidate winner |
|---:|---|---|---:|---|
| 16 | random | compress | 107.16 / 105.98 / 105.73 | unresolved |
| 16 | random | decompress | 7.38 / 7.68 / 7.97 | unresolved |
| 16 | moderate | compress | 106.72 / 105.93 / 105.68 | unresolved |
| 16 | moderate | decompress | 7.38 / 7.69 / 7.97 | unresolved |
| 16 | periodic | compress | 106.80 / 106.12 / 105.72 | unresolved |
| 16 | periodic | decompress | 7.38 / 7.69 / 7.97 | unresolved |
| 32 | random | compress | 124.71 / 124.08 / 122.97 | unresolved |
| 32 | random | decompress | 7.39 / 7.45 / 7.97 | unresolved |
| 32 | moderate | compress | 124.15 / 123.95 / 122.54 | unresolved |
| 32 | moderate | decompress | 7.38 / 7.44 / 7.97 | unresolved |
| 32 | periodic | compress | 115.06 / 114.50 / 114.01 | unresolved |
| 32 | periodic | decompress | 17.11 / 17.46 / 17.56 | unresolved |
| 64 | random | compress | 161.63 / 162.01 / 156.42 | avx2 |
| 64 | random | decompress | 7.51 / 7.51 / 7.97 | unresolved |
| 64 | moderate | compress | 155.00 / 154.95 / 149.57 | avx2 |
| 64 | moderate | decompress | 20.68 / 18.95 / 18.67 | unresolved |
| 64 | periodic | compress | 117.61 / 115.67 / 114.27 | unresolved |
| 64 | periodic | decompress | 31.26 / 31.19 / 31.70 | unresolved |
| 128 | random | compress | 211.69 / 211.75 / 202.71 | avx2 |
| 128 | random | decompress | 8.45 / 7.99 / 8.58 | unresolved |
| 128 | moderate | compress | 210.13 / 210.72 / 201.12 | avx2 |
| 128 | moderate | decompress | 30.04 / 29.88 / 31.96 | unresolved |
| 128 | periodic | compress | 125.46 / 121.56 / 119.83 | unresolved |
| 128 | periodic | decompress | 59.01 / 59.38 / 59.92 | unresolved |
| 256 | random | compress | 287.68 / 289.05 / 272.72 | avx2 |
| 256 | random | decompress | 9.26 / 9.03 / 9.31 | unresolved |
| 256 | moderate | compress | 315.90 / 319.02 / 300.12 | avx2 |
| 256 | moderate | decompress | 49.16 / 47.02 / 47.96 | unresolved |
| 256 | periodic | compress | 140.68 / 126.42 / 124.14 | unresolved |
| 256 | periodic | decompress | 116.10 / 115.41 / 115.22 | unresolved |
| 512 | random | compress | 384.08 / 385.77 / 358.06 | avx2 |
| 512 | random | decompress | 22.16 / 22.08 / 22.70 | unresolved |
| 512 | moderate | compress | 558.52 / 562.00 / 529.90 | avx2 |
| 512 | moderate | decompress | 93.04 / 92.22 / 91.41 | unresolved |
| 512 | periodic | compress | 175.20 / 136.03 / 130.96 | avx2 |
| 512 | periodic | decompress | 227.59 / 226.60 / 227.37 | unresolved |
| 1024 | random | compress | 518.79 / 521.61 / 482.56 | avx2 |
| 1024 | random | decompress | 33.45 / 33.49 / 34.48 | unresolved |
| 1024 | moderate | compress | 1064.67 / 1079.27 / 1010.44 | avx2 |
| 1024 | moderate | decompress | 185.16 / 190.54 / 185.10 | unresolved |
| 1024 | periodic | compress | 234.06 / 158.46 / 145.14 | avx2 |
| 1024 | periodic | decompress | 452.45 / 451.31 / 452.61 | unresolved |
| 2048 | random | compress | 712.94 / 717.20 / 658.03 | avx2 |
| 2048 | random | decompress | 55.93 / 56.01 / 56.32 | unresolved |
| 2048 | moderate | compress | 2106.72 / 2167.55 / 2031.11 | avx2 |
| 2048 | moderate | decompress | 368.81 / 375.56 / 359.92 | avx2 |
| 2048 | periodic | compress | 352.17 / 222.25 / 173.66 | avx2 |
| 2048 | periodic | decompress | 902.24 / 900.68 / 902.45 | unresolved |
| 4096 | random | compress | 1029.65 / 1036.99 / 946.34 | avx2 |
| 4096 | random | decompress | 113.64 / 113.62 / 114.34 | unresolved |
| 4096 | moderate | compress | 4193.40 / 4301.90 / 4053.43 | avx2 |
| 4096 | moderate | decompress | 758.01 / 774.39 / 740.51 | avx2 |
| 4096 | periodic | compress | 589.39 / 321.81 / 244.64 | avx2 |
| 4096 | periodic | decompress | 1811.93 / 1814.63 / 1812.58 | unresolved |
