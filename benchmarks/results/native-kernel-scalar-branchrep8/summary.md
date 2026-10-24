# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.2.8-200.fc44.x86_64 versus the scalar-branchrep8 probe. Each call processes one
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
| bash-elf | clean | 9395.8 / 9404.0 | +0.1% [+0.0, +0.2] | 1846.4 / 1872.7 | +1.5% [+1.3, +1.7] |
| bash-elf | sse-dirty | 9390.8 / 9403.5 | +0.1% [+0.1, +0.2] | 1849.1 / 1873.0 | +1.3% [+1.2, +1.4] |
| bash-elf | ymm-dirty | 9400.8 / 9402.4 | -0.0% [-0.1, +0.0] | 1851.6 / 1875.8 | +1.3% [+1.3, +1.3] |
| halfzero | clean | 1531.7 / 1532.9 | +0.1% [+0.0, +0.2] | 798.6 / 406.4 | -49.1% [-49.2, -49.0] |
| halfzero | sse-dirty | 1531.7 / 1532.8 | +0.1% [+0.1, +0.2] | 798.0 / 407.3 | -49.0% [-49.1, -48.9] |
| halfzero | ymm-dirty | 1535.0 / 1537.1 | +0.1% [+0.0, +0.2] | 801.7 / 410.1 | -48.9% [-49.1, -48.7] |
| mixed | clean | 3256.4 / 3258.9 | +0.1% [+0.0, +0.2] | 554.0 / 574.8 | +3.8% [+3.7, +4.0] |
| mixed | sse-dirty | 3257.0 / 3260.7 | +0.1% [+0.1, +0.1] | 554.6 / 575.2 | +3.8% [+3.7, +4.0] |
| mixed | ymm-dirty | 3259.4 / 3262.7 | +0.1% [+0.1, +0.2] | 557.1 / 577.8 | +3.8% [+3.7, +3.9] |
| period127 | clean | 1289.4 / 1291.9 | +0.3% [+0.2, +0.3] | 446.7 / 448.2 | +0.3% [+0.1, +0.6] |
| period127 | sse-dirty | 1289.3 / 1293.2 | +0.3% [+0.3, +0.4] | 447.2 / 447.9 | +0.3% [-0.1, +0.7] |
| period127 | ymm-dirty | 1292.2 / 1295.8 | +0.3% [+0.2, +0.3] | 450.5 / 451.4 | +0.3% [+0.1, +0.5] |
| random | clean | 1455.1 / 1459.1 | +0.3% [+0.1, +0.4] | 320.8 / 325.2 | +1.1% [+1.0, +1.3] |
| random | sse-dirty | 1453.8 / 1459.2 | +0.3% [+0.3, +0.4] | 321.5 / 325.5 | +1.1% [+1.0, +1.2] |
| random | ymm-dirty | 1457.4 / 1462.8 | +0.3% [+0.1, +0.5] | 324.7 / 328.6 | +1.2% [+1.0, +1.3] |
| sparse | clean | 1986.2 / 1989.0 | +0.1% [+0.1, +0.1] | 766.5 / 786.9 | +2.7% [+2.5, +2.8] |
| sparse | sse-dirty | 1985.4 / 1990.5 | +0.2% [+0.1, +0.3] | 767.3 / 787.2 | +2.6% [+2.5, +2.6] |
| sparse | ymm-dirty | 1988.2 / 1992.1 | +0.2% [+0.1, +0.2] | 769.0 / 790.1 | +2.7% [+2.6, +2.8] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
