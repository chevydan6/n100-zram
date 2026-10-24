| Corpus | Operation | Variant | Median ns/page | Paired ratio | Round bootstrap 95% CI | Session ratios |
|---|---|---|---:|---:|---:|---|
| bash-elf | compress | avx2-copy-overlap | 10213.3 | 1.005 | 0.997–1.012 | 1.009, 1.010, 0.997 |
| bash-elf | decompress | avx2-copy-overlap | 1732.7 | 0.988 | 0.977–0.999 | 0.991, 0.994, 0.980 |
| mixed | compress | avx2-copy-overlap | 3283.9 | 1.001 | 0.996–1.005 | 1.001, 0.999, 1.003 |
| mixed | decompress | avx2-copy-overlap | 316.3 | 1.027 | 1.019–1.034 | 1.029, 1.024, 1.027 |
| period127 | compress | avx2-copy-overlap | 842.0 | 0.999 | 0.995–1.003 | 0.996, 1.000, 1.001 |
| period127 | decompress | avx2-copy-overlap | 229.7 | 0.985 | 0.981–0.989 | 0.983, 0.988, 0.984 |
| random | compress | avx2-copy-overlap | 1268.8 | 0.988 | 0.974–1.001 | 1.000, 1.000, 0.964 |
| random | decompress | avx2-copy-overlap | 117.7 | 0.990 | 0.975–1.006 | 0.995, 1.003, 0.973 |
| sparse | compress | avx2-copy-overlap | 1843.9 | 0.995 | 0.986–1.003 | 0.994, 0.983, 1.007 |
| sparse | decompress | avx2-copy-overlap | 481.0 | 0.974 | 0.967–0.981 | 0.976, 0.964, 0.982 |
