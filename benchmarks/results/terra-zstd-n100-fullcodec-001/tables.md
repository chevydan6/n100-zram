# Full-codec userspace matched comparison

| Corpus | Control/candidate compression µs per page | Paired compression change | Paired decompression change | Bytes per 128 pages |
|---|---:|---:|---:|---:|
| bash-elf | 37.400/37.321 | +0.1% | +0.9% | 336038 |
| clusters50 | 24.355/25.076 | +2.3% | +1.7% | 279728 |
| libc-elf | 35.558/35.477 | +0.1% | -8.4% | 320878 |
| mixed-pages | 21.244/21.091 | -0.7% | +0.4% | 246470 |
| period127 | 10.322/9.982 | -3.1% | +0.7% | 18816 |
| random | 13.422/13.500 | +1.0% | -1.3% | 525568 |
| repeat8 | 9.309/9.199 | -1.2% | -1.2% | 3200 |
| sparse-words | 23.798/23.812 | +1.7% | -1.3% | 103498 |
