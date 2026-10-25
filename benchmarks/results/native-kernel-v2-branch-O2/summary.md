# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.2.8-200.fc44.x86_64 versus the branch-O2 probe. Each call processes one
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
| bash-elf | clean | 9401.1 / 9628.8 | +2.4% [+2.4, +2.6] | 1844.0 / 1874.7 | +1.9% [+1.6, +2.1] |
| bash-elf | sse-dirty | 9394.7 / 9631.7 | +2.5% [+2.5, +2.5] | 1848.6 / 1875.5 | +1.5% [+1.3, +1.7] |
| bash-elf | ymm-dirty | 9407.0 / 9630.5 | +2.2% [+2.1, +2.4] | 1852.8 / 1876.9 | +1.4% [+1.3, +1.5] |
| halfzero | clean | 1533.9 / 1518.4 | -1.0% [-1.0, -0.9] | 796.3 / 405.7 | -49.1% [-49.1, -49.0] |
| halfzero | sse-dirty | 1533.3 / 1519.1 | -0.9% [-0.9, -0.9] | 797.3 / 406.1 | -49.1% [-49.2, -48.9] |
| halfzero | ymm-dirty | 1536.2 / 1521.5 | -1.0% [-1.0, -0.9] | 800.1 / 408.5 | -49.1% [-49.3, -48.9] |
| mixed | clean | 3322.4 / 3391.8 | +3.3% [+2.0, +5.1] | 556.0 / 575.0 | +3.5% [+3.3, +3.7] |
| mixed | sse-dirty | 3294.7 / 3392.4 | +3.5% [+1.9, +5.1] | 556.4 / 575.2 | +3.5% [+3.3, +3.8] |
| mixed | ymm-dirty | 3297.2 / 3400.2 | +3.5% [+2.0, +5.1] | 559.4 / 577.8 | +3.5% [+3.2, +3.7] |
| period127 | clean | 1290.8 / 1161.3 | -10.1% [-10.1, -10.0] | 447.0 / 447.7 | +0.3% [+0.1, +0.7] |
| period127 | sse-dirty | 1292.1 / 1164.2 | -10.0% [-10.1, -10.0] | 447.3 / 447.4 | +0.3% [+0.0, +0.6] |
| period127 | ymm-dirty | 1293.5 / 1165.1 | -10.0% [-10.1, -10.0] | 450.1 / 450.8 | +0.3% [+0.1, +0.5] |
| random | clean | 1457.3 / 1544.3 | +5.9% [+5.9, +6.1] | 321.5 / 325.3 | +1.1% [+1.0, +1.3] |
| random | sse-dirty | 1457.5 / 1544.4 | +5.9% [+5.8, +6.1] | 322.2 / 326.1 | +1.3% [+1.0, +1.5] |
| random | ymm-dirty | 1460.4 / 1547.5 | +5.9% [+5.7, +6.0] | 325.2 / 329.3 | +1.4% [+1.1, +1.5] |
| sparse | clean | 1991.1 / 2040.5 | -0.4% [-6.1, +2.5] | 766.2 / 786.7 | +2.6% [+2.5, +2.6] |
| sparse | sse-dirty | 1991.7 / 2041.2 | -0.4% [-6.1, +2.5] | 767.3 / 787.2 | +2.6% [+2.5, +2.6] |
| sparse | ymm-dirty | 1994.8 / 2043.9 | -0.4% [-6.1, +2.5] | 769.7 / 790.3 | +2.6% [+2.5, +2.7] |
| word-tail508 | clean | 1550.7 / 1560.0 | +0.6% [+0.6, +0.7] | 452.4 / 455.2 | +0.7% [+0.5, +1.1] |
| word-tail508 | sse-dirty | 1551.0 / 1560.6 | +0.6% [+0.6, +0.7] | 452.5 / 456.2 | +0.9% [+0.9, +1.0] |
| word-tail508 | ymm-dirty | 1554.4 / 1563.4 | +0.6% [+0.6, +0.7] | 455.4 / 458.4 | +0.8% [+0.7, +0.9] |
| word-tail64 | clean | 1536.7 / 1523.8 | -0.8% [-0.9, -0.8] | 451.9 / 455.0 | +0.6% [+0.3, +0.9] |
| word-tail64 | sse-dirty | 1536.9 / 1524.2 | -0.8% [-0.9, -0.8] | 452.7 / 455.2 | +0.5% [+0.3, +0.7] |
| word-tail64 | ymm-dirty | 1540.0 / 1526.6 | -0.9% [-0.9, -0.8] | 455.1 / 458.0 | +0.8% [+0.6, +1.0] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
