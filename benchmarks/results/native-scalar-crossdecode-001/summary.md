# Identical-page scalar LZ4 decoder matrix

Three physical N100 warm-cache userspace sessions, nine shuffled rounds after two warm-ups.
Every encoder processes identical pages; every decoder receives each encoder stream.
Full cross-path byte checks occur before timing, final-page checks after every batch.
Hash values are diagnostic stream fingerprints, not cryptographic integrity checks.
All cells are retained. Kernel context, allocator and end-to-end swap costs are excluded.
Cycles are user-only; interpret only fully scheduled measurements. RAPL covers package and batch bookkeeping/background activity, not whole-laptop energy.

| Corpus | Encoder table KiB | Decoder table KiB | Median ns/page | Bytes/page |
|---|---:|---:|---:|---:|
| 25pct-zero | 4 | 4 | 596.494 | 3108.000 |
| 25pct-zero | 4 | 8 | 596.412 | 3108.000 |
| 25pct-zero | 4 | 16 | 597.843 | 3108.000 |
| 25pct-zero | 8 | 4 | 596.205 | 3108.000 |
| 25pct-zero | 8 | 8 | 595.851 | 3108.000 |
| 25pct-zero | 8 | 16 | 597.419 | 3108.000 |
| 25pct-zero | 16 | 4 | 596.190 | 3108.000 |
| 25pct-zero | 16 | 8 | 596.503 | 3108.000 |
| 25pct-zero | 16 | 16 | 596.747 | 3108.000 |
| 50pct-zero | 4 | 4 | 233.030 | 2082.000 |
| 50pct-zero | 4 | 8 | 232.844 | 2082.000 |
| 50pct-zero | 4 | 16 | 240.703 | 2082.000 |
| 50pct-zero | 8 | 4 | 234.919 | 2082.000 |
| 50pct-zero | 8 | 8 | 232.899 | 2082.000 |
| 50pct-zero | 8 | 16 | 240.037 | 2082.000 |
| 50pct-zero | 16 | 4 | 232.485 | 2082.000 |
| 50pct-zero | 16 | 8 | 232.956 | 2082.000 |
| 50pct-zero | 16 | 16 | 239.805 | 2082.000 |
| 75pct-zero | 4 | 4 | 1415.892 | 1054.992 |
| 75pct-zero | 4 | 8 | 1416.412 | 1054.992 |
| 75pct-zero | 4 | 16 | 1415.760 | 1054.992 |
| 75pct-zero | 8 | 4 | 1415.767 | 1054.992 |
| 75pct-zero | 8 | 8 | 1416.309 | 1054.992 |
| 75pct-zero | 8 | 16 | 1415.886 | 1054.992 |
| 75pct-zero | 16 | 4 | 1416.040 | 1054.992 |
| 75pct-zero | 16 | 8 | 1415.839 | 1054.992 |
| 75pct-zero | 16 | 16 | 1416.392 | 1054.992 |
| bash-elf | 4 | 4 | 1613.421 | 3242.602 |
| bash-elf | 4 | 8 | 1610.616 | 3242.602 |
| bash-elf | 4 | 16 | 1612.179 | 3242.602 |
| bash-elf | 8 | 4 | 1599.909 | 3224.219 |
| bash-elf | 8 | 8 | 1588.064 | 3224.219 |
| bash-elf | 8 | 16 | 1598.861 | 3224.219 |
| bash-elf | 16 | 4 | 1584.813 | 3216.555 |
| bash-elf | 16 | 8 | 1597.729 | 3216.555 |
| bash-elf | 16 | 16 | 1595.933 | 3216.555 |
| period127 | 4 | 4 | 224.450 | 153.000 |
| period127 | 4 | 8 | 230.963 | 153.000 |
| period127 | 4 | 16 | 230.922 | 153.000 |
| period127 | 8 | 4 | 224.356 | 153.000 |
| period127 | 8 | 8 | 230.934 | 153.000 |
| period127 | 8 | 16 | 230.891 | 153.000 |
| period127 | 16 | 4 | 224.303 | 153.000 |
| period127 | 16 | 8 | 230.966 | 153.000 |
| period127 | 16 | 16 | 230.852 | 153.000 |
| random | 4 | 4 | 116.730 | 4114.000 |
| random | 4 | 8 | 116.841 | 4114.000 |
| random | 4 | 16 | 116.488 | 4114.000 |
| random | 8 | 4 | 116.446 | 4114.000 |
| random | 8 | 8 | 116.852 | 4114.000 |
| random | 8 | 16 | 116.924 | 4114.000 |
| random | 16 | 4 | 116.338 | 4114.000 |
| random | 16 | 8 | 116.503 | 4114.000 |
| random | 16 | 16 | 116.814 | 4114.000 |
