# Physical N100 initialized-workspace screening

Physical N100 user-space screening only; kernel FPU overhead and ZRAM I/O excluded.
Three sessions, 21 recorded rounds, 128 generated/sample pages per corpus; 8,192 calls per timed batch.
CPU 0, CPUID/XGETBV checked; all eight variants passed initial round trips.
Compression batches checked all packed pages byte-for-byte against baseline outside timing.
All raw rows, including regressions, are retained. No kernel or swap gain is established.

Ratios compare scalar prototypes to reset4k-scalar and AVX2 prototypes to reset4k-avx2.
These fixed-page controls separate specialized API/code-generation changes from hash-table reuse.
Intervals bootstrap three session median paired round ratios (10,000 seeded draws).
Three sessions are descriptive repeatability evidence, not independent workload/population proof.
Virtual u16 positions retain the original workspace size; u32 positions add 16 KiB per stream.
No energy counter was recorded in this screening. Decompression is unchanged in these prototypes.

| Corpus | Variant | Compression ns/page | Change vs fixed-page control [95% session bootstrap] | Cycles/page |
|---|---|---:|---:|---:|
| bash-elf | scalar | 9475.4 | +0.1% [-0.1, +0.1] | 31158.9 |
| bash-elf | reset4k-scalar | 9474.8 | +0.0% [+0.0, +0.0] | 31154.1 |
| bash-elf | reuse-scalar | 14026.3 | +48.1% [+47.8, +48.2] | 46083.3 |
| bash-elf | reuse32-scalar | 14719.6 | +55.4% [+55.2, +55.4] | 48390.0 |
| bash-elf | avx2-guard | 9351.7 | +0.1% [-0.1, +0.2] | 30747.7 |
| bash-elf | reset4k-avx2 | 9344.7 | +0.0% [+0.0, +0.0] | 30722.8 |
| bash-elf | reuse-avx2 | 13972.2 | +49.6% [+49.3, +50.2] | 45919.8 |
| bash-elf | reuse32-avx2 | 14467.7 | +55.0% [+54.9, +55.5] | 47553.7 |
| halfzero | scalar | 1282.7 | +0.1% [-0.1, +0.1] | 4126.0 |
| halfzero | reset4k-scalar | 1267.2 | +0.0% [+0.0, +0.0] | 4126.0 |
| halfzero | reuse-scalar | 1280.1 | +0.9% [+0.8, +1.2] | 4162.5 |
| halfzero | reuse32-scalar | 1230.5 | -4.7% [-4.9, -4.7] | 3930.3 |
| halfzero | avx2-guard | 1022.2 | -0.0% [-0.0, +0.2] | 3333.5 |
| halfzero | reset4k-avx2 | 1027.0 | +0.0% [+0.0, +0.0] | 3334.9 |
| halfzero | reuse-avx2 | 972.6 | -6.7% [-6.9, -6.7] | 3109.2 |
| halfzero | reuse32-avx2 | 982.4 | -5.5% [-5.8, -5.2] | 3153.7 |
| mixed | scalar | 2918.8 | -0.1% [-0.2, +0.1] | 9871.4 |
| mixed | reset4k-scalar | 2921.8 | +0.0% [+0.0, +0.0] | 9875.7 |
| mixed | reuse-scalar | 4595.5 | +57.0% [+56.9, +57.3] | 15510.0 |
| mixed | reuse32-scalar | 4729.6 | +62.0% [+61.7, +62.1] | 15984.1 |
| mixed | avx2-guard | 2845.0 | -0.0% [-0.1, +0.2] | 9614.2 |
| mixed | reset4k-avx2 | 2841.8 | +0.0% [+0.0, +0.0] | 9615.6 |
| mixed | reuse-avx2 | 4348.0 | +53.0% [+53.0, +53.1] | 14717.8 |
| mixed | reuse32-avx2 | 4549.7 | +60.1% [+60.0, +60.4] | 15394.9 |
| period127 | scalar | 928.4 | -0.0% [-0.2, +0.0] | 3132.9 |
| period127 | reset4k-scalar | 926.7 | +0.0% [+0.0, +0.0] | 3134.2 |
| period127 | reuse-scalar | 795.1 | -14.1% [-14.1, -14.1] | 2693.1 |
| period127 | reuse32-scalar | 625.0 | -32.5% [-32.5, -32.5] | 2115.7 |
| period127 | avx2-guard | 589.3 | -0.2% [-0.3, -0.2] | 1994.3 |
| period127 | reset4k-avx2 | 590.9 | +0.0% [+0.0, +0.0] | 1997.9 |
| period127 | reuse-avx2 | 308.3 | -47.8% [-47.9, -47.8] | 1042.9 |
| period127 | reuse32-avx2 | 288.9 | -51.1% [-51.1, -51.0] | 977.9 |
| random | scalar | 1196.4 | -0.1% [-0.2, +1.0] | 4007.8 |
| random | reset4k-scalar | 1187.8 | +0.0% [+0.0, +0.0] | 4008.3 |
| random | reuse-scalar | 1295.8 | +9.0% [+8.5, +9.8] | 4363.3 |
| random | reuse32-scalar | 1336.3 | +12.8% [+12.4, +13.0] | 4518.0 |
| random | avx2-guard | 1188.3 | -0.1% [-0.2, -0.0] | 4014.9 |
| random | reset4k-avx2 | 1188.5 | +0.0% [+0.0, +0.0] | 4011.2 |
| random | reuse-avx2 | 1287.6 | +8.6% [+8.4, +8.6] | 4355.0 |
| random | reuse32-avx2 | 1336.5 | +12.6% [+12.4, +12.7] | 4516.5 |
| sparse | scalar | 1653.6 | -0.1% [-0.1, -0.0] | 5599.2 |
| sparse | reset4k-scalar | 1655.2 | +0.0% [+0.0, +0.0] | 5602.2 |
| sparse | reuse-scalar | 1739.3 | +5.1% [+4.1, +5.4] | 5890.2 |
| sparse | reuse32-scalar | 1759.5 | +2.0% [+1.3, +5.6] | 5737.2 |
| sparse | avx2-guard | 1645.0 | -0.0% [-0.1, +0.0] | 5570.1 |
| sparse | reset4k-avx2 | 1645.7 | +0.0% [+0.0, +0.0] | 5572.9 |
| sparse | reuse-avx2 | 1698.7 | -0.7% [-0.9, -0.1] | 5525.2 |
| sparse | reuse32-avx2 | 1694.6 | +1.7% [+1.5, +3.7] | 5663.1 |
| word-tail508 | scalar | 1332.4 | +0.0% [-0.1, +0.2] | 4247.7 |
| word-tail508 | reset4k-scalar | 1332.6 | +0.0% [+0.0, +0.0] | 4246.6 |
| word-tail508 | reuse-scalar | 1361.9 | +2.4% [+2.3, +2.4] | 4344.5 |
| word-tail508 | reuse32-scalar | 1313.5 | -1.5% [-1.5, -1.1] | 4184.4 |
| word-tail508 | avx2-guard | 1127.2 | +0.7% [+0.0, +0.8] | 3593.6 |
| word-tail508 | reset4k-avx2 | 1119.1 | +0.0% [+0.0, +0.0] | 3566.9 |
| word-tail508 | reuse-avx2 | 1090.4 | -2.6% [-2.6, -2.5] | 3476.1 |
| word-tail508 | reuse32-avx2 | 1108.0 | -1.1% [-1.1, -1.0] | 3529.3 |
| word-tail64 | scalar | 1267.7 | -0.0% [-0.0, +0.6] | 4153.4 |
| word-tail64 | reset4k-scalar | 1268.3 | +0.0% [+0.0, +0.0] | 4137.1 |
| word-tail64 | reuse-scalar | 1279.4 | +0.9% [+0.9, +0.9] | 4175.3 |
| word-tail64 | reuse32-scalar | 1237.1 | -4.3% [-4.6, -3.8] | 3953.3 |
| word-tail64 | avx2-guard | 1044.8 | +0.1% [+0.0, +0.1] | 3394.6 |
| word-tail64 | reset4k-avx2 | 1044.8 | +0.0% [+0.0, +0.0] | 3392.7 |
| word-tail64 | reuse-avx2 | 986.2 | -6.6% [-6.7, -6.3] | 3167.9 |
| word-tail64 | reuse32-avx2 | 1003.2 | -5.4% [-5.5, -5.3] | 3207.7 |
