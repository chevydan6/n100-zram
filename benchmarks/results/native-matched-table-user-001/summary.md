# Physical N100 smaller-table screening

Physical N100 smaller-table user-space screening only; kernel FPU overhead and ZRAM I/O excluded.
Three sessions; 21 recorded rounds and two warm-ups; 128 pages/corpus and 8,192 calls/batch.
CPU 0, CPUID/XGETBV checked. Every compression batch checked all 128 packed buffers
outside timing; setup independently decoded every candidate block with the baseline decoder.
Guarded capacity and independent liblz4 concurrency tests passed before native execution.

Compression ratios may change: all measured bytes/page are retained. The decoder remains baseline.
Controls use 16 KiB hash arrays and the same specialized 4 KiB private API as candidates.
Private table14 controls were byte-identity checked against the baseline kernel encoder.
Results remain user-space only. No kernel integration or ZRAM gain is established.
Energy and responsiveness were not measured. User-space cycles exclude kernel and hypervisor.

Change intervals bootstrap the three session median paired round ratios (10,000 seeded draws).
These small-sample intervals describe repeatability, not general workload confidence.

| Corpus | Variant | Compress ns/page | Change [95% session bootstrap] | Bytes/page | Size change | Cycles/page |
|---|---|---:|---:|---:|---:|---:|
| bash-elf | table14-scalar | 9578.9 | +0.0% [+0.0, +0.0] | 3216.6 | +0.00% | 31131.0 |
| bash-elf | table13-scalar | 9403.9 | -1.9% [-2.0, -1.9] | 3224.2 | +0.24% | 30519.0 |
| bash-elf | table12-scalar | 9370.4 | -3.3% [-3.3, -3.0] | 3242.6 | +0.81% | 30109.6 |
| bash-elf | table11-scalar | 9010.6 | -5.1% [-5.2, -5.1] | 3279.3 | +1.95% | 29550.9 |
| bash-elf | table14-avx2 | 9430.3 | +0.0% [+0.0, +0.0] | 3216.6 | +0.00% | 30725.8 |
| bash-elf | table13-avx2 | 9256.8 | -1.9% [-2.3, -1.7] | 3224.2 | +0.24% | 30125.9 |
| bash-elf | table12-avx2 | 9195.3 | -3.2% [-3.3, -3.1] | 3242.6 | +0.81% | 29724.6 |
| bash-elf | table11-avx2 | 8988.9 | -4.6% [-4.9, -4.1] | 3279.3 | +1.95% | 29261.0 |
| halfzero | table14-scalar | 1293.2 | +0.0% [+0.0, +0.0] | 2082.0 | +0.00% | 4126.5 |
| halfzero | table13-scalar | 1128.9 | -12.7% [-12.7, -12.4] | 2082.0 | +0.00% | 3603.0 |
| halfzero | table12-scalar | 1048.7 | -18.9% [-18.9, -18.4] | 2082.0 | +0.00% | 3347.4 |
| halfzero | table11-scalar | 1009.4 | -21.9% [-21.9, -21.9] | 2082.0 | +0.00% | 3220.9 |
| halfzero | table14-avx2 | 1045.1 | +0.0% [+0.0, +0.0] | 2082.0 | +0.00% | 3337.0 |
| halfzero | table13-avx2 | 882.1 | -15.6% [-15.7, -15.3] | 2082.0 | +0.00% | 2814.5 |
| halfzero | table12-avx2 | 803.0 | -23.2% [-23.3, -22.8] | 2082.0 | +0.00% | 2561.6 |
| halfzero | table11-avx2 | 761.7 | -27.1% [-27.2, -26.8] | 2082.0 | +0.00% | 2429.8 |
| mixed | table14-scalar | 3013.9 | +0.0% [+0.0, +0.0] | 2237.4 | +0.00% | 9863.5 |
| mixed | table13-scalar | 2899.5 | -3.9% [-4.1, -3.5] | 2235.8 | -0.07% | 9477.5 |
| mixed | table12-scalar | 2897.5 | -4.1% [-4.2, -3.9] | 2233.9 | -0.16% | 9458.1 |
| mixed | table11-scalar | 2933.8 | -2.7% [-2.7, -2.6] | 2232.6 | -0.22% | 9599.9 |
| mixed | table14-avx2 | 2945.7 | +0.0% [+0.0, +0.0] | 2237.4 | +0.00% | 9611.5 |
| mixed | table13-avx2 | 2841.3 | -4.2% [-4.4, -3.5] | 2235.8 | -0.07% | 9195.2 |
| mixed | table12-avx2 | 2828.5 | -4.7% [-4.9, -4.0] | 2233.9 | -0.16% | 9141.3 |
| mixed | table11-avx2 | 2863.5 | -3.7% [-3.7, -3.1] | 2232.6 | -0.22% | 9239.4 |
| period127 | table14-scalar | 1014.3 | +0.0% [+0.0, +0.0] | 153.0 | +0.00% | 3137.2 |
| period127 | table13-scalar | 845.1 | -16.5% [-16.6, -16.5] | 153.0 | +0.00% | 2617.9 |
| period127 | table12-scalar | 740.2 | -24.9% [-25.0, -24.9] | 153.0 | +0.00% | 2354.6 |
| period127 | table11-scalar | 702.7 | -28.8% [-28.9, -28.8] | 153.0 | +0.00% | 2232.6 |
| period127 | table14-avx2 | 642.4 | +0.0% [+0.0, +0.0] | 153.0 | +0.00% | 1991.9 |
| period127 | table13-avx2 | 466.4 | -26.0% [-26.0, -25.9] | 153.0 | +0.00% | 1476.3 |
| period127 | table12-avx2 | 388.2 | -38.1% [-38.2, -38.1] | 153.0 | +0.00% | 1233.4 |
| period127 | table11-avx2 | 345.8 | -45.3% [-45.6, -45.2] | 153.0 | +0.00% | 1091.3 |
| random | table14-scalar | 1256.4 | +0.0% [+0.0, +0.0] | 4114.0 | +0.00% | 4007.2 |
| random | table13-scalar | 1089.5 | -13.2% [-13.3, -13.2] | 4114.0 | +0.00% | 3478.7 |
| random | table12-scalar | 1028.4 | -18.2% [-18.3, -17.9] | 4114.0 | +0.00% | 3279.7 |
| random | table11-scalar | 979.4 | -22.1% [-22.1, -22.0] | 4114.0 | +0.00% | 3123.8 |
| random | table14-avx2 | 1257.8 | +0.0% [+0.0, +0.0] | 4114.0 | +0.00% | 4012.7 |
| random | table13-avx2 | 1091.3 | -13.2% [-13.3, -13.0] | 4114.0 | +0.00% | 3484.3 |
| random | table12-avx2 | 1027.9 | -18.3% [-18.3, -17.9] | 4114.0 | +0.00% | 3279.8 |
| random | table11-avx2 | 970.1 | -22.9% [-22.9, -22.4] | 4114.0 | +0.00% | 3094.5 |
| sparse | table14-scalar | 1755.2 | +0.0% [+0.0, +0.0] | 767.7 | +0.00% | 5600.8 |
| sparse | table13-scalar | 1592.4 | -9.3% [-9.4, -9.2] | 768.0 | +0.04% | 5079.6 |
| sparse | table12-scalar | 1514.8 | -13.9% [-14.0, -7.0] | 767.4 | -0.04% | 4818.7 |
| sparse | table11-scalar | 1493.5 | -15.8% [-16.2, -9.2] | 768.3 | +0.08% | 4696.4 |
| sparse | table14-avx2 | 1748.2 | +0.0% [+0.0, +0.0] | 767.7 | +0.00% | 5573.7 |
| sparse | table13-avx2 | 1584.3 | -9.4% [-9.4, -9.3] | 768.0 | +0.04% | 5052.2 |
| sparse | table12-avx2 | 1499.8 | -14.1% [-14.2, -14.1] | 767.4 | -0.04% | 4782.4 |
| sparse | table11-avx2 | 1458.5 | -16.5% [-16.6, -16.5] | 768.3 | +0.08% | 4651.9 |
| word-tail508 | table14-scalar | 1337.8 | +0.0% [+0.0, +0.0] | 2581.0 | +0.00% | 4241.9 |
| word-tail508 | table13-scalar | 1179.7 | -12.1% [-12.3, -12.0] | 2581.0 | +0.00% | 3724.4 |
| word-tail508 | table12-scalar | 1112.1 | -18.0% [-18.2, -17.9] | 2581.0 | +0.00% | 3471.2 |
| word-tail508 | table11-scalar | 1066.2 | -20.0% [-20.0, -19.9] | 2581.0 | +0.00% | 3393.5 |
| word-tail508 | table14-avx2 | 1134.9 | +0.0% [+0.0, +0.0] | 2581.0 | +0.00% | 3572.6 |
| word-tail508 | table13-avx2 | 977.8 | -14.4% [-14.4, -14.4] | 2581.0 | +0.00% | 3055.9 |
| word-tail508 | table12-avx2 | 885.2 | -21.4% [-21.7, -21.3] | 2581.0 | +0.00% | 2806.8 |
| word-tail508 | table11-avx2 | 868.3 | -22.7% [-23.2, -22.7] | 2581.0 | +0.00% | 2757.4 |
| word-tail64 | table14-scalar | 1295.8 | +0.0% [+0.0, +0.0] | 2138.0 | +0.00% | 4133.7 |
| word-tail64 | table13-scalar | 1132.3 | -12.6% [-12.6, -12.1] | 2138.0 | +0.00% | 3613.9 |
| word-tail64 | table12-scalar | 1052.0 | -18.8% [-18.8, -18.3] | 2138.0 | +0.00% | 3357.0 |
| word-tail64 | table11-scalar | 1012.2 | -21.9% [-21.9, -21.9] | 2138.0 | +0.00% | 3228.7 |
| word-tail64 | table14-avx2 | 1063.4 | +0.0% [+0.0, +0.0] | 2138.0 | +0.00% | 3393.4 |
| word-tail64 | table13-avx2 | 900.3 | -15.4% [-15.4, -15.3] | 2138.0 | +0.00% | 2873.0 |
| word-tail64 | table12-avx2 | 821.7 | -22.8% [-22.9, -22.6] | 2138.0 | +0.00% | 2621.2 |
| word-tail64 | table11-avx2 | 780.4 | -26.6% [-26.6, -26.5] | 2138.0 | +0.00% | 2490.2 |
