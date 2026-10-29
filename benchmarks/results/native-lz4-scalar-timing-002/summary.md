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
| bash-elf | table14-scalar | 39414.6 | +0.0% [+0.0, +0.0] | 3216.6 | +0.00% | 31226.3 |
| bash-elf | table13-scalar | 38605.5 | -2.1% [-2.1, -2.0] | 3224.2 | +0.24% | 30589.6 |
| bash-elf | table12-scalar | 38092.6 | -3.4% [-3.4, -3.3] | 3242.6 | +0.81% | 30180.1 |
| bash-elf | table11-scalar | 37374.3 | -5.2% [-5.2, -5.1] | 3279.3 | +1.95% | 29614.2 |
| bash-elf | table14-avx2 | 38825.6 | +0.0% [+0.0, +0.0] | 3216.6 | +0.00% | 30757.4 |
| bash-elf | table13-avx2 | 38104.4 | -1.8% [-2.1, -1.7] | 3224.2 | +0.24% | 30192.0 |
| bash-elf | table12-avx2 | 37520.5 | -3.3% [-3.4, -3.3] | 3242.6 | +0.81% | 29729.5 |
| bash-elf | table11-avx2 | 36997.5 | -4.6% [-5.2, -4.6] | 3279.3 | +1.95% | 29317.4 |
| halfzero | table14-scalar | 5206.0 | +0.0% [+0.0, +0.0] | 2082.0 | +0.00% | 4127.4 |
| halfzero | table13-scalar | 4550.1 | -12.6% [-12.7, -12.5] | 2082.0 | +0.00% | 3606.4 |
| halfzero | table12-scalar | 4226.6 | -18.8% [-18.9, -18.8] | 2082.0 | +0.00% | 3350.7 |
| halfzero | table11-scalar | 4063.7 | -21.9% [-22.0, -21.9] | 2082.0 | +0.00% | 3221.9 |
| halfzero | table14-avx2 | 4210.8 | +0.0% [+0.0, +0.0] | 2082.0 | +0.00% | 3338.9 |
| halfzero | table13-avx2 | 3553.8 | -15.6% [-15.6, -15.6] | 2082.0 | +0.00% | 2817.8 |
| halfzero | table12-avx2 | 3236.5 | -23.2% [-23.2, -23.1] | 2082.0 | +0.00% | 2566.1 |
| halfzero | table11-avx2 | 3068.4 | -27.1% [-27.1, -27.1] | 2082.0 | +0.00% | 2433.7 |
| mixed | table14-scalar | 12462.9 | +0.0% [+0.0, +0.0] | 2237.4 | +0.00% | 9879.4 |
| mixed | table13-scalar | 11951.2 | -4.1% [-4.2, -4.1] | 2235.8 | -0.07% | 9474.6 |
| mixed | table12-scalar | 11950.5 | -4.1% [-4.2, -4.0] | 2233.9 | -0.16% | 9472.5 |
| mixed | table11-scalar | 12122.8 | -2.8% [-2.8, -2.7] | 2232.6 | -0.22% | 9608.0 |
| mixed | table14-avx2 | 12150.7 | +0.0% [+0.0, +0.0] | 2237.4 | +0.00% | 9626.8 |
| mixed | table13-avx2 | 11623.1 | -4.3% [-4.4, -4.3] | 2235.8 | -0.07% | 9213.2 |
| mixed | table12-avx2 | 11560.5 | -5.0% [-5.0, -4.7] | 2233.9 | -0.16% | 9164.6 |
| mixed | table11-avx2 | 11692.3 | -3.9% [-4.1, -3.3] | 2232.6 | -0.22% | 9261.3 |
| period127 | table14-scalar | 3985.5 | +0.0% [+0.0, +0.0] | 153.0 | +0.00% | 3150.8 |
| period127 | table13-scalar | 3330.1 | -16.6% [-16.8, -16.5] | 153.0 | +0.00% | 2631.5 |
| period127 | table12-scalar | 2983.6 | -25.0% [-25.5, -24.9] | 153.0 | +0.00% | 2363.5 |
| period127 | table11-scalar | 2841.5 | -28.9% [-28.9, -28.8] | 153.0 | +0.00% | 2244.0 |
| period127 | table14-avx2 | 2530.7 | +0.0% [+0.0, +0.0] | 153.0 | +0.00% | 2004.0 |
| period127 | table13-avx2 | 1871.5 | -25.9% [-25.9, -25.5] | 153.0 | +0.00% | 1483.9 |
| period127 | table12-avx2 | 1562.7 | -38.0% [-38.2, -38.0] | 153.0 | +0.00% | 1239.0 |
| period127 | table11-avx2 | 1376.2 | -45.9% [-46.0, -45.5] | 153.0 | +0.00% | 1088.4 |
| random | table14-scalar | 5080.2 | +0.0% [+0.0, +0.0] | 4114.0 | +0.00% | 4023.0 |
| random | table13-scalar | 4423.5 | -13.1% [-13.2, -12.8] | 4114.0 | +0.00% | 3501.8 |
| random | table12-scalar | 4146.9 | -18.4% [-18.4, -18.0] | 4114.0 | +0.00% | 3284.8 |
| random | table11-scalar | 3956.9 | -22.2% [-22.2, -21.8] | 4114.0 | +0.00% | 3134.6 |
| random | table14-avx2 | 5094.0 | +0.0% [+0.0, +0.0] | 4114.0 | +0.00% | 4032.9 |
| random | table13-avx2 | 4422.3 | -13.2% [-13.8, -13.1] | 4114.0 | +0.00% | 3501.3 |
| random | table12-avx2 | 4158.0 | -18.3% [-18.4, -18.1] | 4114.0 | +0.00% | 3292.5 |
| random | table11-avx2 | 3927.5 | -22.9% [-22.9, -22.8] | 4114.0 | +0.00% | 3109.3 |
| sparse | table14-scalar | 7076.5 | +0.0% [+0.0, +0.0] | 767.7 | +0.00% | 5609.3 |
| sparse | table13-scalar | 6417.8 | -9.4% [-9.4, -9.1] | 768.0 | +0.04% | 5087.3 |
| sparse | table12-scalar | 6082.6 | -14.0% [-14.0, -13.7] | 767.4 | -0.04% | 4821.8 |
| sparse | table11-scalar | 5925.4 | -16.3% [-16.6, -16.3] | 768.3 | +0.08% | 4697.4 |
| sparse | table14-avx2 | 7046.6 | +0.0% [+0.0, +0.0] | 767.7 | +0.00% | 5584.4 |
| sparse | table13-avx2 | 6392.3 | -9.3% [-9.4, -9.3] | 768.0 | +0.04% | 5064.5 |
| sparse | table12-avx2 | 6046.5 | -14.2% [-15.0, -14.2] | 767.4 | -0.04% | 4789.5 |
| sparse | table11-avx2 | 5884.1 | -16.5% [-16.6, -16.4] | 768.3 | +0.08% | 4662.7 |
| word-tail508 | table14-scalar | 5356.2 | +0.0% [+0.0, +0.0] | 2581.0 | +0.00% | 4246.6 |
| word-tail508 | table13-scalar | 4699.8 | -12.3% [-12.3, -12.2] | 2581.0 | +0.00% | 3726.0 |
| word-tail508 | table12-scalar | 4380.3 | -18.2% [-18.3, -18.2] | 2581.0 | +0.00% | 3472.5 |
| word-tail508 | table11-scalar | 4282.7 | -20.1% [-20.1, -20.0] | 2581.0 | +0.00% | 3394.4 |
| word-tail508 | table14-avx2 | 4506.2 | +0.0% [+0.0, +0.0] | 2581.0 | +0.00% | 3572.3 |
| word-tail508 | table13-avx2 | 3861.1 | -14.3% [-14.4, -14.3] | 2581.0 | +0.00% | 3060.4 |
| word-tail508 | table12-avx2 | 3541.7 | -21.4% [-21.5, -21.4] | 2581.0 | +0.00% | 2808.3 |
| word-tail508 | table11-avx2 | 3482.2 | -22.7% [-22.7, -22.6] | 2581.0 | +0.00% | 2760.8 |
| word-tail64 | table14-scalar | 5221.5 | +0.0% [+0.0, +0.0] | 2138.0 | +0.00% | 4138.0 |
| word-tail64 | table13-scalar | 4561.1 | -12.7% [-12.7, -12.6] | 2138.0 | +0.00% | 3615.3 |
| word-tail64 | table12-scalar | 4239.5 | -18.8% [-18.8, -18.8] | 2138.0 | +0.00% | 3359.3 |
| word-tail64 | table11-scalar | 4075.0 | -22.0% [-22.0, -21.9] | 2138.0 | +0.00% | 3230.8 |
| word-tail64 | table14-avx2 | 4283.8 | +0.0% [+0.0, +0.0] | 2138.0 | +0.00% | 3396.1 |
| word-tail64 | table13-avx2 | 3626.9 | -15.4% [-15.4, -15.3] | 2138.0 | +0.00% | 2875.7 |
| word-tail64 | table12-avx2 | 3309.4 | -22.7% [-22.8, -22.7] | 2138.0 | +0.00% | 2624.2 |
| word-tail64 | table11-avx2 | 3142.9 | -26.6% [-26.7, -26.6] | 2138.0 | +0.00% | 2491.7 |
