# Physical N100 syscall-inclusive codec experiment

Experimental: stock 7.2.8-200.fc44.x86_64 versus the avx2-O2 probe. Each call processes one
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
| bash-elf | clean | 9401.7 / 9787.6 | +3.8% [+3.3, +4.0] | 1849.9 / 2248.6 | +21.6% [+21.2, +21.8] |
| bash-elf | sse-dirty | 9396.1 / 9772.2 | +3.9% [+3.4, +4.2] | 1852.8 / 2250.1 | +21.3% [+21.0, +21.6] |
| bash-elf | ymm-dirty | 9411.9 / 9810.5 | +3.9% [+3.7, +4.1] | 1858.9 / 2271.6 | +22.2% [+22.1, +22.5] |
| halfzero | clean | 1535.4 / 1641.1 | +6.9% [+6.9, +7.0] | 800.5 / 1153.7 | +44.1% [+43.8, +44.2] |
| halfzero | sse-dirty | 1534.7 / 1640.6 | +7.1% [+7.0, +7.1] | 801.6 / 1154.3 | +43.9% [+43.7, +44.3] |
| halfzero | ymm-dirty | 1538.0 / 1662.3 | +8.2% [+8.1, +8.2] | 806.2 / 1174.8 | +45.9% [+45.7, +46.2] |
| mixed | clean | 3320.8 / 3546.5 | +7.4% [+6.4, +8.1] | 556.5 / 930.5 | +67.0% [+65.9, +67.9] |
| mixed | sse-dirty | 3321.6 / 3543.5 | +7.4% [+6.3, +8.0] | 556.9 / 931.3 | +67.0% [+66.2, +67.9] |
| mixed | ymm-dirty | 3325.9 / 3566.1 | +7.9% [+6.9, +8.6] | 562.9 / 952.2 | +69.8% [+68.9, +70.8] |
| period127 | clean | 1290.8 / 1221.8 | -5.4% [-5.5, -5.2] | 448.5 / 854.1 | +89.8% [+87.5, +92.1] |
| period127 | sse-dirty | 1291.4 / 1221.1 | -5.4% [-5.6, -5.3] | 448.9 / 855.7 | +89.5% [+87.2, +92.1] |
| period127 | ymm-dirty | 1294.4 / 1242.0 | -4.0% [-4.1, -3.8] | 452.3 / 875.5 | +92.8% [+90.3, +95.4] |
| random | clean | 1454.1 / 1872.8 | +28.7% [+28.5, +28.8] | 321.6 / 740.0 | +129.5% [+128.2, +130.3] |
| random | sse-dirty | 1457.6 / 1872.4 | +28.5% [+28.5, +28.6] | 322.8 / 741.0 | +129.1% [+127.5, +130.0] |
| random | ymm-dirty | 1458.2 / 1894.1 | +29.9% [+29.7, +30.1] | 325.3 / 761.1 | +133.4% [+132.3, +134.3] |
| sparse | clean | 2025.3 / 2550.2 | +25.9% [+25.5, +26.7] | 769.3 / 1113.3 | +44.3% [+43.7, +45.0] |
| sparse | sse-dirty | 2026.1 / 2547.8 | +25.9% [+25.4, +26.6] | 769.4 / 1114.4 | +44.4% [+43.3, +45.1] |
| sparse | ymm-dirty | 2028.2 / 2568.7 | +26.8% [+26.2, +27.5] | 772.5 / 1134.0 | +46.7% [+46.1, +47.2] |
| word-tail508 | clean | 1551.1 / 1716.7 | +10.6% [+10.5, +10.7] | 455.4 / 739.7 | +62.6% [+62.3, +62.8] |
| word-tail508 | sse-dirty | 1552.3 / 1717.4 | +10.6% [+10.6, +10.6] | 455.6 / 741.3 | +62.6% [+62.3, +63.0] |
| word-tail508 | ymm-dirty | 1555.1 / 1738.2 | +11.7% [+11.6, +11.7] | 458.3 / 761.6 | +66.3% [+66.0, +66.5] |
| word-tail64 | clean | 1537.5 / 1655.8 | +7.7% [+7.6, +7.9] | 455.3 / 861.5 | +88.9% [+87.7, +90.1] |
| word-tail64 | sse-dirty | 1537.3 / 1656.5 | +7.7% [+7.5, +7.8] | 456.6 / 862.8 | +88.7% [+87.4, +89.9] |
| word-tail64 | ymm-dirty | 1541.0 / 1674.3 | +8.6% [+8.6, +8.7] | 460.0 / 882.4 | +91.8% [+90.6, +93.0] |

This is an experimental diagnostic comparison, not a production-selection
claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.
