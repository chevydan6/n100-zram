# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.0.10 versus the scalar-fpu probe. Each call processes one
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
| bash-elf | clean | 9416.4 / 9831.9 | +4.4% [+4.3, +4.5] | 1843.0 / 2261.9 | +23.0% [+22.5, +23.3] |
| bash-elf | sse-dirty | 9404.3 / 9831.7 | +4.6% [+4.6, +4.6] | 1844.3 / 2262.7 | +22.7% [+22.5, +22.8] |
| bash-elf | ymm-dirty | 9414.8 / 9851.8 | +4.7% [+4.6, +4.8] | 1848.8 / 2285.1 | +23.6% [+23.5, +23.6] |
| halfzero | clean | 1535.9 / 1954.3 | +27.2% [+27.2, +27.3] | 800.0 / 1219.7 | +52.5% [+52.3, +52.7] |
| halfzero | sse-dirty | 1536.1 / 1954.7 | +27.3% [+27.2, +27.4] | 799.9 / 1220.0 | +52.4% [+52.3, +52.5] |
| halfzero | ymm-dirty | 1538.5 / 1975.5 | +28.4% [+28.3, +28.4] | 803.9 / 1240.8 | +54.3% [+54.2, +54.4] |
| mixed | clean | 3261.0 / 3681.1 | +13.0% [+12.8, +13.4] | 559.7 / 976.9 | +74.7% [+74.5, +74.9] |
| mixed | sse-dirty | 3261.1 / 3685.2 | +13.4% [+12.8, +14.6] | 559.1 / 977.2 | +74.7% [+74.4, +74.9] |
| mixed | ymm-dirty | 3262.9 / 3699.2 | +13.5% [+13.3, +13.8] | 562.9 / 997.7 | +77.4% [+77.0, +77.6] |
| period127 | clean | 1292.3 / 1708.0 | +32.3% [+32.2, +32.3] | 445.7 / 867.9 | +94.5% [+93.9, +94.9] |
| period127 | sse-dirty | 1292.7 / 1708.6 | +32.2% [+32.1, +32.4] | 445.7 / 867.1 | +94.4% [+93.7, +94.7] |
| period127 | ymm-dirty | 1294.8 / 1728.7 | +33.5% [+33.5, +33.6] | 449.4 / 888.8 | +97.8% [+97.4, +98.1] |
| random | clean | 1463.3 / 1884.0 | +28.7% [+28.6, +28.8] | 326.1 / 744.8 | +128.1% [+127.5, +128.5] |
| random | sse-dirty | 1463.2 / 1884.4 | +28.8% [+28.8, +28.9] | 326.4 / 744.7 | +128.0% [+127.2, +128.4] |
| random | ymm-dirty | 1467.5 / 1905.0 | +29.8% [+29.6, +30.0] | 329.7 / 766.0 | +132.2% [+131.4, +132.7] |
| sparse | clean | 1982.0 / 2404.0 | +19.7% [+16.5, +21.3] | 768.1 / 1170.3 | +52.4% [+52.3, +52.4] |
| sparse | sse-dirty | 1982.5 / 2404.1 | +19.7% [+16.5, +21.3] | 768.2 / 1170.8 | +52.3% [+52.0, +52.5] |
| sparse | ymm-dirty | 1985.7 / 2424.9 | +20.6% [+17.3, +22.3] | 772.1 / 1191.2 | +54.2% [+54.0, +54.3] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
