| Corpus | Operation | Variant | Median ns/page | Paired ratio | Round bootstrap 95% CI | Session ratios |
|---|---|---|---:|---:|---:|---|
| bash-elf | compress | avx2-guard-overlap | 9493.9 | 0.990 | 0.982–0.997 | 1.000, 0.988, 0.981 |
| bash-elf | decompress | avx2-guard-overlap | 1715.5 | 0.986 | 0.977–0.994 | 0.993, 0.987, 0.978 |
| mixed | compress | avx2-guard-overlap | 3062.1 | 1.002 | 0.998–1.007 | 1.007, 1.002, 0.998 |
| mixed | decompress | avx2-guard-overlap | 317.8 | 1.039 | 1.031–1.048 | 1.040, 1.040, 1.038 |
| period127 | compress | avx2-guard-overlap | 627.7 | 1.001 | 0.994–1.007 | 1.005, 1.000, 0.997 |
| period127 | decompress | avx2-guard-overlap | 229.6 | 0.991 | 0.985–0.996 | 0.998, 0.987, 0.987 |
| random | compress | avx2-guard-overlap | 1185.7 | 0.995 | 0.984–1.005 | 0.989, 0.995, 1.000 |
| random | decompress | avx2-guard-overlap | 117.8 | 1.002 | 0.990–1.014 | 0.993, 1.011, 1.002 |
| sparse | compress | avx2-guard-overlap | 1939.7 | 0.999 | 0.992–1.007 | 0.990, 1.014, 0.995 |
| sparse | decompress | avx2-guard-overlap | 481.5 | 0.980 | 0.972–0.989 | 0.973, 0.984, 0.984 |
