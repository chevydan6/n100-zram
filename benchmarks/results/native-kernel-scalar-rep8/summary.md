# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.0.10 versus the scalar-rep8 probe. Each call processes one
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
| bash-elf | clean | 9411.5 / 9329.6 | -1.0% [-1.1, -0.8] | 1843.2 / 1888.3 | +2.7% [+2.6, +2.7] |
| bash-elf | sse-dirty | 9407.8 / 9334.5 | -0.7% [-0.8, -0.7] | 1844.6 / 1887.8 | +2.4% [+2.3, +2.4] |
| bash-elf | ymm-dirty | 9418.8 / 9335.4 | -0.9% [-0.9, -0.8] | 1849.0 / 1891.4 | +2.2% [+2.1, +2.3] |
| halfzero | clean | 1532.8 / 1462.2 | -4.6% [-4.7, -4.5] | 801.1 / 409.7 | -48.9% [-48.9, -48.8] |
| halfzero | sse-dirty | 1532.6 / 1462.5 | -4.6% [-4.6, -4.5] | 801.4 / 410.5 | -48.8% [-48.8, -48.7] |
| halfzero | ymm-dirty | 1535.6 / 1465.8 | -4.5% [-4.5, -4.5] | 805.0 / 412.9 | -48.7% [-48.7, -48.7] |
| mixed | clean | 3259.3 / 3214.1 | -1.4% [-1.5, -1.3] | 560.1 / 583.8 | +4.3% [+3.7, +5.1] |
| mixed | sse-dirty | 3259.2 / 3215.4 | -1.3% [-1.5, -1.2] | 559.3 / 584.1 | +4.3% [+3.7, +5.1] |
| mixed | ymm-dirty | 3263.4 / 3215.9 | -1.4% [-1.5, -1.4] | 562.9 / 587.1 | +4.2% [+3.7, +5.0] |
| period127 | clean | 1292.7 / 1150.0 | -11.1% [-11.1, -11.0] | 446.6 / 450.9 | +0.9% [+0.5, +1.2] |
| period127 | sse-dirty | 1293.5 / 1150.3 | -11.1% [-11.1, -11.1] | 447.5 / 451.6 | +1.0% [+0.8, +1.2] |
| period127 | ymm-dirty | 1296.2 / 1152.7 | -11.0% [-11.1, -11.0] | 450.3 / 454.1 | +1.0% [+0.6, +1.3] |
| random | clean | 1453.7 / 1460.3 | +0.4% [+0.4, +0.5] | 328.0 / 331.4 | +1.1% [+1.1, +1.1] |
| random | sse-dirty | 1460.1 / 1461.5 | +0.3% [+0.3, +0.3] | 328.0 / 332.0 | +1.1% [+1.0, +1.2] |
| random | ymm-dirty | 1458.7 / 1464.0 | +0.4% [+0.3, +0.4] | 331.3 / 335.1 | +1.0% [+1.0, +1.0] |
| sparse | clean | 1981.1 / 1968.5 | -0.7% [-0.7, -0.6] | 768.7 / 831.1 | +8.2% [+8.2, +8.3] |
| sparse | sse-dirty | 1982.3 / 1969.1 | -0.7% [-0.7, -0.6] | 768.3 / 832.4 | +8.3% [+8.3, +8.4] |
| sparse | ymm-dirty | 1986.6 / 1971.3 | -0.7% [-0.7, -0.7] | 772.0 / 835.8 | +8.2% [+8.1, +8.2] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
