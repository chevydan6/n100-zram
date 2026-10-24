# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.2.8-200.fc44.x86_64 versus the scalar-selectrep8 probe. Each call processes one
4 KiB page, including syscall, dispatch and FPU state handling. Three sessions,
nine randomized recorded rounds per corpus/state/session; 4,096 calls per batch.
Warm-up rounds are excluded. Lower times are better. These are codec measurements,
not optimized ZRAM block-I/O or swap measurements. Stock and candidate compiler
builds differ; matched controls are needed before attributing all cost to FPU.

Every state/operation batch checked all sixteen YMM sentinels. Corpus setup and
post-batch checks compared compressed bytes and both decoders against stock,
and checked retained input. Module initialization also passed 2,048 malformed
blocks and nested-FPU scalar fallback. The module/device unloaded afterward.

Intervals below resample the three session median paired ratios (10,000 seeded
bootstrap draws), not individual calls. With only three sessions they are
descriptive repeatability checks, not a population or workload guarantee. Raw
CSV retains all recorded batches, including regressions. No confidence claim
is inferred from this small sample alone. Times are medians of all 27 batches.

| Corpus | User state | Compress stock / candidate ns | Change [session bootstrap 95%] | Decode stock / candidate ns | Change [session bootstrap 95%] |
|---|---|---:|---:|---:|---:|
| bash-elf | clean | 9372.2 / 9381.6 | +0.2% [+0.2, +0.3] | 1811.9 / 1834.4 | +1.4% [+1.3, +1.5] |
| bash-elf | sse-dirty | 9375.4 / 9368.1 | -0.0% [-0.1, +0.0] | 1839.5 / 1819.6 | -0.8% [-1.1, -0.2] |
| bash-elf | ymm-dirty | 9380.1 / 9374.0 | -0.1% [-0.1, +0.0] | 1818.6 / 1841.6 | +1.4% [+1.3, +1.6] |
| halfzero | clean | 1539.3 / 1536.5 | -0.1% [-0.2, -0.1] | 798.5 / 405.5 | -49.2% [-49.5, -49.0] |
| halfzero | sse-dirty | 1537.8 / 1536.2 | -0.1% [-0.1, -0.1] | 798.8 / 406.0 | -49.2% [-49.3, -49.1] |
| halfzero | ymm-dirty | 1540.6 / 1538.7 | -0.1% [-0.1, -0.1] | 802.0 / 408.9 | -49.1% [-49.2, -49.0] |
| mixed | clean | 3258.7 / 3259.2 | +0.0% [-0.0, +0.1] | 552.6 / 558.3 | +0.9% [+0.9, +1.0] |
| mixed | sse-dirty | 3259.1 / 3259.2 | +0.0% [+0.0, +0.0] | 552.7 / 558.3 | +1.0% [+0.9, +1.0] |
| mixed | ymm-dirty | 3263.0 / 3262.7 | -0.0% [-0.0, +0.0] | 555.9 / 561.1 | +0.8% [+0.7, +0.9] |
| period127 | clean | 1288.2 / 1288.0 | +0.0% [-0.1, +0.1] | 442.1 / 441.9 | +0.1% [-0.1, +0.2] |
| period127 | sse-dirty | 1288.9 / 1288.9 | -0.0% [-0.1, -0.0] | 442.6 / 442.4 | +0.0% [-0.1, +0.1] |
| period127 | ymm-dirty | 1291.8 / 1291.9 | +0.0% [-0.0, +0.0] | 445.7 / 445.8 | +0.1% [-0.1, +0.2] |
| random | clean | 1460.6 / 1461.9 | +0.1% [+0.1, +0.2] | 320.0 / 320.3 | +0.1% [+0.0, +0.1] |
| random | sse-dirty | 1461.4 / 1462.2 | +0.1% [+0.0, +0.2] | 321.0 / 321.2 | +0.1% [+0.0, +0.2] |
| random | ymm-dirty | 1464.0 / 1464.6 | +0.1% [-0.0, +0.2] | 323.7 / 324.2 | +0.1% [-0.1, +0.2] |
| sparse | clean | 1987.7 / 1986.5 | -0.1% [-0.1, -0.0] | 763.8 / 764.8 | +0.3% [+0.2, +0.4] |
| sparse | sse-dirty | 1985.9 / 1984.7 | -0.1% [-0.1, -0.0] | 763.7 / 764.9 | +0.2% [+0.1, +0.4] |
| sparse | ymm-dirty | 1990.6 / 1989.7 | -0.0% [-0.1, +0.0] | 767.4 / 767.2 | +0.1% [+0.1, +0.2] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
