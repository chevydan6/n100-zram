# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.0.10 versus the AVX2-guard probe. Each call processes one
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

| Corpus | User state | Compress stock / AVX2 ns | Change [session bootstrap 95%] | Decode stock / AVX2 ns | Change [session bootstrap 95%] |
|---|---|---:|---:|---:|---:|
| bash-elf | clean | 9413.1 / 9675.1 | +2.7% [+2.5, +2.9] | 1842.5 / 2258.7 | +22.9% [+22.6, +23.5] |
| bash-elf | sse-dirty | 9413.9 / 9680.6 | +2.8% [+2.8, +2.9] | 1847.5 / 2259.8 | +22.4% [+22.2, +22.5] |
| bash-elf | ymm-dirty | 9418.3 / 9705.9 | +3.0% [+2.9, +3.2] | 1848.0 / 2279.9 | +23.4% [+23.2, +23.5] |
| halfzero | clean | 1539.4 / 1651.9 | +7.3% [+7.1, +7.4] | 800.6 / 1159.1 | +44.8% [+44.7, +44.9] |
| halfzero | sse-dirty | 1539.4 / 1652.5 | +7.3% [+7.0, +7.4] | 801.3 / 1159.6 | +44.7% [+44.7, +44.8] |
| halfzero | ymm-dirty | 1542.3 / 1672.8 | +8.5% [+8.3, +8.6] | 804.4 / 1179.9 | +46.6% [+46.3, +46.8] |
| mixed | clean | 3261.2 / 3557.7 | +9.1% [+9.0, +9.1] | 559.1 / 937.0 | +67.5% [+67.4, +67.7] |
| mixed | sse-dirty | 3261.2 / 3558.0 | +9.1% [+9.1, +9.1] | 559.4 / 937.3 | +67.5% [+67.3, +67.6] |
| mixed | ymm-dirty | 3264.1 / 3580.0 | +9.7% [+9.7, +9.7] | 563.0 / 958.0 | +70.2% [+70.0, +70.3] |
| period127 | clean | 1293.6 / 1228.3 | -5.1% [-5.3, -5.0] | 447.1 / 859.2 | +92.3% [+92.0, +92.7] |
| period127 | sse-dirty | 1293.9 / 1227.4 | -5.2% [-5.3, -5.1] | 447.4 / 859.5 | +92.3% [+92.1, +92.7] |
| period127 | ymm-dirty | 1296.8 / 1246.8 | -3.7% [-3.9, -3.6] | 450.4 / 880.1 | +95.3% [+95.1, +95.8] |
| random | clean | 1462.5 / 1885.6 | +29.0% [+28.9, +29.1] | 327.9 / 746.4 | +127.9% [+127.4, +128.5] |
| random | sse-dirty | 1463.9 / 1887.2 | +28.9% [+28.9, +29.0] | 328.5 / 746.9 | +127.6% [+127.3, +128.1] |
| random | ymm-dirty | 1466.0 / 1907.0 | +30.1% [+30.0, +30.3] | 331.5 / 767.7 | +131.9% [+131.5, +132.6] |
| sparse | clean | 1982.2 / 2512.3 | +26.7% [+26.6, +26.8] | 766.6 / 1119.3 | +46.1% [+46.0, +46.2] |
| sparse | sse-dirty | 1982.8 / 2512.0 | +26.8% [+26.7, +26.8] | 767.1 / 1119.9 | +46.0% [+45.9, +46.1] |
| sparse | ymm-dirty | 1986.0 / 2534.9 | +27.7% [+27.6, +27.7] | 770.1 / 1140.4 | +48.0% [+47.9, +48.1] |

The initial candidate fails broad native performance acceptance and remains
experimental. Periodic-page compression is the sole consistent winning case in
this corpus set; selective deployment has not been justified. Primary lzo-rle
ZRAM remained active and unchanged throughout this probe.
