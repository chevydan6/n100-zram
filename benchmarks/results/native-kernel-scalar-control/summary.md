# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.0.10 versus the scalar-control probe. Each call processes one
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
| bash-elf | clean | 9411.3 / 9411.1 | +0.0% [-0.0, +0.0] | 1841.9 / 1848.0 | +0.5% [+0.3, +0.6] |
| bash-elf | sse-dirty | 9405.5 / 9411.4 | +0.1% [+0.0, +0.2] | 1845.6 / 1846.0 | +0.0% [-0.1, +0.2] |
| bash-elf | ymm-dirty | 9412.2 / 9411.5 | -0.1% [-0.1, -0.0] | 1849.1 / 1849.5 | -0.0% [-0.1, +0.1] |
| halfzero | clean | 1538.2 / 1541.0 | +0.2% [+0.1, +0.2] | 800.1 / 803.3 | +0.5% [+0.4, +0.5] |
| halfzero | sse-dirty | 1538.1 / 1541.0 | +0.2% [+0.1, +0.2] | 801.1 / 803.6 | +0.4% [+0.3, +0.5] |
| halfzero | ymm-dirty | 1540.7 / 1544.0 | +0.1% [-0.0, +0.2] | 802.8 / 806.8 | +0.6% [+0.5, +0.8] |
| mixed | clean | 3260.8 / 3264.4 | +0.1% [+0.0, +0.1] | 558.7 / 561.8 | +0.4% [+0.2, +0.6] |
| mixed | sse-dirty | 3261.1 / 3265.1 | +0.1% [+0.1, +0.1] | 559.4 / 562.1 | +0.4% [+0.1, +0.6] |
| mixed | ymm-dirty | 3264.3 / 3267.4 | +0.1% [+0.0, +0.2] | 562.0 / 565.2 | +0.4% [+0.2, +0.6] |
| period127 | clean | 1292.4 / 1295.7 | +0.2% [+0.2, +0.2] | 446.1 / 450.2 | +0.9% [+0.8, +1.1] |
| period127 | sse-dirty | 1292.5 / 1294.9 | +0.2% [+0.1, +0.2] | 447.2 / 450.7 | +0.8% [+0.6, +0.9] |
| period127 | ymm-dirty | 1295.6 / 1297.5 | +0.1% [+0.1, +0.1] | 450.2 / 453.7 | +0.9% [+0.8, +1.0] |
| random | clean | 1464.6 / 1469.0 | +0.3% [+0.3, +0.4] | 326.2 / 329.4 | +1.0% [+0.9, +1.1] |
| random | sse-dirty | 1464.3 / 1468.1 | +0.3% [+0.2, +0.3] | 326.6 / 329.7 | +1.0% [+0.9, +1.0] |
| random | ymm-dirty | 1467.7 / 1471.6 | +0.2% [+0.0, +0.4] | 329.7 / 332.8 | +0.9% [+0.7, +1.1] |
| sparse | clean | 1983.2 / 1986.4 | +0.2% [+0.1, +0.2] | 766.2 / 754.1 | -1.5% [-1.6, -1.5] |
| sparse | sse-dirty | 1983.9 / 1985.9 | +0.2% [+0.1, +0.2] | 766.6 / 754.2 | -1.5% [-1.6, -1.5] |
| sparse | ymm-dirty | 1986.4 / 1989.3 | +0.1% [+0.1, +0.2] | 770.0 / 757.3 | -1.6% [-1.7, -1.6] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
