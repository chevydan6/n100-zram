# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.0.10 versus the scalar-runfill probe. Each call processes one
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
| bash-elf | clean | 9413.2 / 9413.2 | -0.0% [-0.1, +0.0] | 1842.5 / 1830.3 | -0.4% [-0.6, -0.0] |
| bash-elf | sse-dirty | 9409.8 / 9414.6 | +0.1% [-0.0, +0.1] | 1844.7 / 1832.6 | -0.7% [-0.8, -0.5] |
| bash-elf | ymm-dirty | 9418.8 / 9413.7 | -0.2% [-0.4, -0.0] | 1848.4 / 1834.8 | -0.8% [-0.9, -0.6] |
| halfzero | clean | 1534.7 / 1536.5 | +0.2% [+0.1, +0.2] | 801.7 / 803.7 | +0.3% [+0.2, +0.4] |
| halfzero | sse-dirty | 1534.2 / 1536.8 | +0.2% [+0.2, +0.2] | 801.9 / 804.0 | +0.2% [+0.2, +0.3] |
| halfzero | ymm-dirty | 1537.6 / 1540.3 | +0.2% [+0.2, +0.3] | 804.5 / 807.5 | +0.4% [+0.4, +0.5] |
| mixed | clean | 3261.6 / 3266.7 | +0.1% [-0.1, +0.3] | 559.9 / 561.1 | +0.2% [+0.1, +0.3] |
| mixed | sse-dirty | 3261.5 / 3267.2 | +0.2% [+0.2, +0.2] | 560.0 / 561.4 | +0.2% [+0.1, +0.3] |
| mixed | ymm-dirty | 3263.8 / 3269.8 | +0.1% [+0.1, +0.2] | 563.3 / 564.2 | +0.2% [+0.1, +0.3] |
| period127 | clean | 1292.6 / 1295.0 | +0.2% [+0.2, +0.2] | 447.6 / 450.5 | +0.6% [+0.4, +0.7] |
| period127 | sse-dirty | 1293.2 / 1294.8 | +0.1% [+0.1, +0.2] | 447.7 / 450.3 | +0.6% [+0.4, +0.7] |
| period127 | ymm-dirty | 1296.6 / 1298.5 | +0.1% [+0.1, +0.2] | 450.7 / 453.9 | +0.7% [+0.5, +0.9] |
| random | clean | 1458.8 / 1462.6 | +0.3% [+0.2, +0.3] | 328.0 / 332.0 | +1.2% [+1.1, +1.2] |
| random | sse-dirty | 1459.3 / 1463.1 | +0.3% [+0.2, +0.3] | 328.5 / 332.0 | +1.1% [+1.0, +1.1] |
| random | ymm-dirty | 1462.3 / 1465.9 | +0.2% [+0.1, +0.3] | 331.7 / 335.2 | +1.1% [+1.0, +1.2] |
| sparse | clean | 1982.9 / 1986.6 | +0.2% [+0.2, +0.3] | 767.6 / 769.8 | +0.3% [+0.2, +0.3] |
| sparse | sse-dirty | 1983.1 / 1987.2 | +0.2% [+0.2, +0.3] | 767.9 / 770.3 | +0.3% [+0.2, +0.3] |
| sparse | ymm-dirty | 1986.4 / 1990.1 | +0.2% [+0.1, +0.3] | 771.4 / 772.6 | +0.1% [+0.1, +0.2] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
