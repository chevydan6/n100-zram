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
| 40 | random | compress | 137.90 / 137.26 / 136.26 | unresolved |
| 40 | random | decompress | 7.79 / 7.79 / 7.98 | unresolved |
| 40 | moderate | compress | 137.84 / 137.35 / 135.91 | unresolved |
| 40 | moderate | decompress | 7.80 / 7.78 / 7.98 | unresolved |
| 40 | periodic | compress | 119.05 / 119.60 / 117.11 | unresolved |
| 40 | periodic | decompress | 20.35 / 20.65 / 20.95 | unresolved |
| 48 | random | compress | 148.77 / 147.43 / 145.85 | unresolved |
| 48 | random | decompress | 7.42 / 7.41 / 7.97 | unresolved |
| 48 | moderate | compress | 148.79 / 147.35 / 145.95 | unresolved |
| 48 | moderate | decompress | 7.81 / 7.41 / 7.98 | unresolved |
| 48 | periodic | compress | 119.33 / 118.62 / 117.52 | unresolved |
| 48 | periodic | decompress | 24.11 / 24.62 / 24.70 | unresolved |
| 56 | random | compress | 156.63 / 156.29 / 152.71 | unresolved |
| 56 | random | decompress | 7.42 / 7.41 / 7.99 | unresolved |
| 56 | moderate | compress | 157.12 / 157.09 / 154.53 | unresolved |
| 56 | moderate | decompress | 19.34 / 16.86 / 15.71 | avx2 |
| 56 | periodic | compress | 119.80 / 119.64 / 118.76 | unresolved |
| 56 | periodic | decompress | 27.57 / 28.02 / 28.17 | unresolved |
| 320 | random | compress | 318.82 / 319.46 / 300.37 | avx2 |
| 320 | random | decompress | 15.17 / 15.16 / 18.57 | unresolved |
| 320 | moderate | compress | 367.12 / 369.98 / 347.59 | avx2 |
| 320 | moderate | decompress | 58.71 / 57.46 / 56.32 | unresolved |
| 320 | periodic | compress | 148.40 / 128.76 / 126.79 | unresolved |
| 320 | periodic | decompress | 141.60 / 143.04 / 143.16 | unresolved |
| 384 | random | compress | 343.87 / 344.96 / 322.20 | avx2 |
| 384 | random | decompress | 15.94 / 15.91 / 19.06 | unresolved |
| 384 | moderate | compress | 423.59 / 427.05 / 399.48 | avx2 |
| 384 | moderate | decompress | 68.88 / 69.92 / 68.09 | unresolved |
| 384 | periodic | compress | 155.71 / 130.98 / 128.75 | unresolved |
| 384 | periodic | decompress | 169.96 / 171.05 / 170.86 | unresolved |
| 448 | random | compress | 366.11 / 367.64 / 342.45 | avx2 |
| 448 | random | decompress | 19.74 / 19.49 / 23.64 | unresolved |
| 448 | moderate | compress | 481.77 / 484.80 / 453.36 | avx2 |
| 448 | moderate | decompress | 81.16 / 81.26 / 79.75 | unresolved |
| 448 | periodic | compress | 168.76 / 134.00 / 129.84 | avx2 |
| 448 | periodic | decompress | 198.63 / 199.21 / 200.56 | unresolved |
| 1280 | random | compress | 575.47 / 577.74 / 531.86 | avx2 |
| 1280 | random | decompress | 37.16 / 35.93 / 36.81 | unresolved |
| 1280 | moderate | compress | 1296.13 / 1304.97 / 1216.48 | avx2 |
| 1280 | moderate | decompress | 233.41 / 239.84 / 230.40 | unresolved |
| 1280 | periodic | compress | 264.65 / 171.17 / 152.33 | avx2 |
| 1280 | periodic | decompress | 565.27 / 570.84 / 565.39 | unresolved |
| 1536 | random | compress | 625.95 / 629.08 / 577.97 | avx2 |
| 1536 | random | decompress | 42.47 / 42.43 / 45.45 | unresolved |
| 1536 | moderate | compress | 1523.90 / 1547.40 / 1442.93 | avx2 |
| 1536 | moderate | decompress | 275.39 / 282.74 / 270.39 | unresolved |
| 1536 | periodic | compress | 293.78 / 193.10 / 159.99 | avx2 |
| 1536 | periodic | decompress | 676.92 / 677.75 / 674.01 | unresolved |
| 1792 | random | compress | 673.35 / 676.82 / 621.13 | avx2 |
| 1792 | random | decompress | 46.60 / 46.58 / 47.61 | unresolved |
| 1792 | moderate | compress | 1778.37 / 1814.73 / 1690.81 | avx2 |
| 1792 | moderate | decompress | 321.42 / 327.19 / 311.80 | avx2 |
| 1792 | periodic | compress | 323.43 / 209.64 / 167.06 | avx2 |
| 1792 | periodic | decompress | 790.15 / 792.13 / 790.35 | unresolved |
