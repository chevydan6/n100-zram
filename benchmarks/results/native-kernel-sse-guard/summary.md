# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.0.10 versus the SSE2-guard probe. Each call processes one
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
| bash-elf | clean | 9410.0 / 9649.3 | +2.6% [+2.5, +2.7] | 1836.9 / 2291.2 | +25.1% [+24.5, +25.5] |
| bash-elf | sse-dirty | 9399.0 / 9654.6 | +2.8% [+2.8, +2.8] | 1844.7 / 2289.7 | +24.0% [+23.9, +24.2] |
| bash-elf | ymm-dirty | 9411.5 / 9667.3 | +2.7% [+2.6, +2.8] | 1846.2 / 2311.0 | +25.3% [+25.3, +25.4] |
| halfzero | clean | 1537.0 / 1707.0 | +11.0% [+10.8, +11.1] | 800.2 / 1183.0 | +47.9% [+47.8, +48.0] |
| halfzero | sse-dirty | 1536.8 / 1707.8 | +11.1% [+10.9, +11.3] | 800.9 / 1183.7 | +47.9% [+47.7, +48.0] |
| halfzero | ymm-dirty | 1540.3 / 1728.4 | +12.2% [+12.1, +12.3] | 804.6 / 1204.3 | +49.8% [+49.5, +50.0] |
| mixed | clean | 3260.1 / 3563.5 | +9.3% [+9.3, +9.4] | 559.6 / 981.9 | +75.7% [+75.4, +76.1] |
| mixed | sse-dirty | 3260.3 / 3563.0 | +9.3% [+9.3, +9.4] | 559.3 / 982.2 | +75.8% [+75.5, +76.0] |
| mixed | ymm-dirty | 3263.1 / 3585.5 | +9.9% [+9.8, +9.9] | 562.5 / 1002.7 | +78.4% [+78.2, +78.7] |
| period127 | clean | 1293.6 / 1284.5 | -0.7% [-0.7, -0.6] | 447.1 / 820.6 | +83.8% [+83.2, +84.2] |
| period127 | sse-dirty | 1294.9 / 1286.1 | -0.7% [-0.9, -0.5] | 447.8 / 821.2 | +83.7% [+83.4, +84.1] |
| period127 | ymm-dirty | 1297.7 / 1306.2 | +0.7% [+0.6, +0.8] | 450.4 / 842.0 | +87.7% [+86.9, +88.4] |
| random | clean | 1464.1 / 1886.8 | +28.8% [+28.6, +29.0] | 326.8 / 745.6 | +128.1% [+127.6, +128.6] |
| random | sse-dirty | 1463.9 / 1887.4 | +28.9% [+28.7, +29.1] | 327.0 / 745.2 | +127.9% [+127.5, +128.1] |
| random | ymm-dirty | 1466.8 / 1909.2 | +30.0% [+29.7, +30.3] | 330.5 / 766.5 | +131.9% [+131.2, +132.5] |
| sparse | clean | 1981.6 / 2424.2 | +22.3% [+22.1, +22.6] | 766.7 / 1154.3 | +50.6% [+50.5, +50.6] |
| sparse | sse-dirty | 1981.3 / 2424.2 | +22.3% [+22.1, +22.4] | 766.7 / 1154.8 | +50.6% [+50.5, +50.7] |
| sparse | ymm-dirty | 1985.6 / 2446.1 | +23.2% [+23.1, +23.2] | 770.6 / 1175.7 | +52.6% [+52.5, +52.6] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
