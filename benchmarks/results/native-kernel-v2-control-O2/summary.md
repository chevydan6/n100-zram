# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.2.8-200.fc44.x86_64 versus the control-O2 probe. Each call processes one
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
| bash-elf | clean | 9397.2 / 9624.6 | +2.6% [+2.4, +3.0] | 1843.7 / 1846.0 | +0.3% [+0.2, +0.3] |
| bash-elf | sse-dirty | 9395.0 / 9626.2 | +2.4% [+2.4, +2.5] | 1847.8 / 1848.0 | -0.1% [-0.1, -0.0] |
| bash-elf | ymm-dirty | 9400.9 / 9626.5 | +2.3% [+2.2, +2.4] | 1851.4 / 1848.0 | -0.2% [-0.2, -0.1] |
| halfzero | clean | 1530.6 / 1515.0 | -0.9% [-1.0, -0.9] | 799.7 / 802.0 | +0.4% [+0.3, +0.5] |
| halfzero | sse-dirty | 1530.2 / 1515.8 | -1.0% [-1.0, -0.9] | 800.8 / 801.7 | +0.4% [-0.0, +0.7] |
| halfzero | ymm-dirty | 1533.4 / 1518.9 | -0.9% [-1.0, -0.9] | 802.7 / 805.1 | +0.6% [+0.5, +0.7] |
| mixed | clean | 3258.3 / 3391.7 | +3.3% [+1.9, +4.0] | 554.5 / 558.2 | +0.7% [+0.6, +0.8] |
| mixed | sse-dirty | 3266.5 / 3392.2 | +3.2% [+1.7, +4.0] | 557.3 / 558.1 | +0.7% [+0.6, +0.8] |
| mixed | ymm-dirty | 3262.1 / 3394.9 | +3.3% [+1.9, +4.0] | 557.4 / 561.5 | +0.7% [+0.6, +0.8] |
| period127 | clean | 1291.3 / 1160.7 | -10.1% [-10.1, -10.1] | 445.4 / 446.7 | +1.2% [+0.1, +2.4] |
| period127 | sse-dirty | 1293.1 / 1159.1 | -10.1% [-10.2, -10.0] | 446.7 / 445.4 | +1.1% [+0.0, +2.3] |
| period127 | ymm-dirty | 1294.9 / 1162.3 | -10.1% [-10.2, -10.0] | 449.4 / 448.3 | +1.2% [+0.3, +2.6] |
| random | clean | 1451.4 / 1541.2 | +6.0% [+5.9, +6.1] | 320.9 / 323.6 | +1.3% [+1.1, +1.7] |
| random | sse-dirty | 1454.0 / 1540.4 | +5.9% [+5.8, +6.0] | 321.2 / 324.3 | +1.2% [+1.0, +1.5] |
| random | ymm-dirty | 1456.8 / 1544.5 | +6.0% [+6.0, +6.1] | 323.8 / 327.1 | +1.4% [+1.0, +1.9] |
| sparse | clean | 1986.0 / 2036.5 | +2.5% [+2.5, +2.6] | 765.8 / 754.3 | -1.7% [-1.8, -1.5] |
| sparse | sse-dirty | 1986.4 / 2037.8 | +2.6% [+2.6, +2.6] | 766.5 / 754.9 | -1.7% [-2.0, -1.5] |
| sparse | ymm-dirty | 1989.2 / 2040.3 | +2.5% [+2.5, +2.6] | 768.7 / 757.2 | -1.6% [-1.8, -1.5] |
| word-tail508 | clean | 1547.2 / 1559.3 | +0.6% [+0.5, +0.7] | 451.0 / 453.3 | +0.8% [+0.5, +1.0] |
| word-tail508 | sse-dirty | 1547.0 / 1557.1 | +0.7% [+0.6, +0.7] | 451.1 / 453.9 | +0.7% [+0.5, +0.8] |
| word-tail508 | ymm-dirty | 1550.3 / 1560.5 | +0.6% [+0.6, +0.7] | 453.8 / 456.5 | +0.8% [+0.5, +1.2] |
| word-tail64 | clean | 1533.5 / 1521.5 | -0.8% [-0.8, -0.8] | 452.1 / 454.2 | +0.5% [+0.4, +0.6] |
| word-tail64 | sse-dirty | 1535.8 / 1521.8 | -0.9% [-1.1, -0.8] | 452.0 / 454.7 | +0.7% [+0.5, +0.9] |
| word-tail64 | ymm-dirty | 1536.5 / 1523.4 | -0.9% [-0.9, -0.8] | 455.3 / 457.8 | +0.5% [+0.5, +0.5] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
