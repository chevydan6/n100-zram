# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.0.10 versus the scalar-matchrep8 probe. Each call processes one
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
| bash-elf | clean | 9413.7 / 9410.8 | -0.1% [-0.1, -0.0] | 1845.3 / 1870.5 | +1.5% [+1.3, +1.8] |
| bash-elf | sse-dirty | 9403.9 / 9412.2 | +0.1% [-0.0, +0.1] | 1843.8 / 1872.8 | +1.6% [+1.5, +1.7] |
| bash-elf | ymm-dirty | 9414.5 / 9412.3 | -0.1% [-0.3, -0.0] | 1848.7 / 1876.3 | +1.4% [+1.3, +1.5] |
| halfzero | clean | 1541.6 / 1544.1 | +0.2% [+0.1, +0.3] | 801.7 / 409.0 | -49.0% [-49.0, -49.0] |
| halfzero | sse-dirty | 1541.4 / 1544.5 | +0.3% [+0.2, +0.3] | 802.5 / 409.8 | -49.0% [-49.1, -48.9] |
| halfzero | ymm-dirty | 1544.7 / 1548.1 | +0.2% [+0.2, +0.3] | 805.1 / 412.4 | -48.8% [-48.8, -48.8] |
| mixed | clean | 3262.1 / 3265.8 | -0.2% [-0.9, +0.1] | 559.6 / 582.1 | +3.9% [+3.8, +4.0] |
| mixed | sse-dirty | 3260.2 / 3267.1 | -0.5% [-1.8, +0.2] | 560.0 / 582.3 | +4.0% [+3.9, +4.0] |
| mixed | ymm-dirty | 3266.2 / 3270.5 | -0.4% [-1.6, +0.2] | 563.7 / 585.5 | +3.8% [+3.8, +3.9] |
| period127 | clean | 1293.1 / 1296.0 | +0.2% [+0.2, +0.3] | 447.1 / 452.8 | +1.2% [+1.0, +1.3] |
| period127 | sse-dirty | 1293.5 / 1296.1 | +0.2% [+0.1, +0.2] | 447.6 / 452.7 | +1.2% [+1.0, +1.3] |
| period127 | ymm-dirty | 1296.6 / 1298.6 | +0.2% [+0.2, +0.2] | 450.8 / 455.7 | +1.1% [+0.9, +1.4] |
| random | clean | 1466.6 / 1469.2 | +0.2% [+0.2, +0.3] | 328.4 / 331.9 | +1.1% [+1.0, +1.3] |
| random | sse-dirty | 1466.4 / 1470.3 | +0.3% [+0.2, +0.4] | 328.6 / 332.0 | +1.1% [+1.0, +1.1] |
| random | ymm-dirty | 1469.8 / 1473.8 | +0.3% [+0.3, +0.3] | 332.0 / 335.4 | +1.0% [+0.7, +1.2] |
| sparse | clean | 1984.7 / 1989.1 | +3.3% [+0.1, +9.7] | 770.0 / 833.7 | +8.3% [+8.3, +8.4] |
| sparse | sse-dirty | 1985.1 / 1988.1 | +3.3% [+0.0, +9.7] | 770.1 / 834.2 | +8.3% [+8.3, +8.4] |
| sparse | ymm-dirty | 1988.3 / 1994.2 | +3.3% [+0.1, +9.7] | 772.7 / 837.5 | +8.4% [+8.3, +8.5] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
