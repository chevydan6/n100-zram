# Physical N100 smaller-table screening

Physical N100 smaller-table user-space screening only; kernel FPU overhead and ZRAM I/O excluded.
Three sessions; 21 recorded rounds and two warm-ups; 128 pages/corpus and 8,192 calls/batch.
CPU 0, CPUID/XGETBV checked. Every compression batch checked all 128 packed buffers
outside timing; setup independently decoded every candidate block with the baseline decoder.
Guarded capacity and independent liblz4 concurrency tests passed before native execution.

Compression ratios may change: all measured bytes/page are retained. The decoder remains baseline.
Controls are full baseline scalar/AVX2-guard APIs; candidates have a specialized 4 KiB private API.
API/code-generation differences are a confounder. Matched table14 private controls are required
before attributing gains exclusively to table size. No kernel integration or ZRAM gain is established.
Energy and responsiveness were not measured. User-space cycles exclude kernel and hypervisor.

Change intervals bootstrap the three session median paired round ratios (10,000 seeded draws).
These small-sample intervals describe repeatability, not general workload confidence.

| Corpus | Variant | Compress ns/page | Change [95% session bootstrap] | Bytes/page | Size change | Cycles/page |
|---|---|---:|---:|---:|---:|---:|
| bash-elf | scalar | 9704.8 | +0.0% [+0.0, +0.0] | 3216.6 | +0.00% | 31901.3 |
| bash-elf | table13-scalar | 9287.3 | -4.3% [-4.4, -4.1] | 3224.2 | +0.24% | 30531.4 |
| bash-elf | table12-scalar | 9159.4 | -5.6% [-5.7, -5.5] | 3242.6 | +0.81% | 30108.9 |
| bash-elf | table11-scalar | 8993.3 | -7.3% [-7.4, -7.3] | 3279.3 | +1.95% | 29558.1 |
| bash-elf | avx2-guard | 9344.0 | +0.0% [+0.0, +0.0] | 3216.6 | +0.00% | 30713.4 |
| bash-elf | table13-avx2 | 9161.1 | -1.9% [-2.0, -1.8] | 3224.2 | +0.24% | 30107.7 |
| bash-elf | table12-avx2 | 9053.8 | -3.1% [-3.2, -2.7] | 3242.6 | +0.81% | 29729.6 |
| bash-elf | table11-avx2 | 8884.8 | -4.8% [-4.9, -4.7] | 3279.3 | +1.95% | 29189.7 |
| halfzero | scalar | 1321.1 | +0.0% [+0.0, +0.0] | 2082.0 | +0.00% | 4322.6 |
| halfzero | table13-scalar | 1097.5 | -16.6% [-16.7, -16.5] | 2082.0 | +0.00% | 3604.6 |
| halfzero | table12-scalar | 1023.0 | -22.5% [-22.6, -22.5] | 2082.0 | +0.00% | 3347.5 |
| halfzero | table11-scalar | 980.7 | -25.5% [-25.6, -24.9] | 2082.0 | +0.00% | 3223.0 |
| halfzero | avx2-guard | 1021.5 | +0.0% [+0.0, +0.0] | 2082.0 | +0.00% | 3335.1 |
| halfzero | table13-avx2 | 863.0 | -15.6% [-15.7, -15.5] | 2082.0 | +0.00% | 2815.7 |
| halfzero | table12-avx2 | 784.5 | -23.2% [-23.5, -23.0] | 2082.0 | +0.00% | 2562.2 |
| halfzero | table11-avx2 | 755.1 | -27.1% [-27.5, -27.0] | 2082.0 | +0.00% | 2431.8 |
| mixed | scalar | 3215.1 | +0.0% [+0.0, +0.0] | 2237.4 | +0.00% | 10495.8 |
| mixed | table13-scalar | 2902.0 | -9.8% [-9.8, -9.6] | 2235.8 | -0.07% | 9473.6 |
| mixed | table12-scalar | 2926.3 | -9.9% [-9.9, -9.8] | 2233.9 | -0.16% | 9459.9 |
| mixed | table11-scalar | 3007.6 | -8.5% [-8.6, -8.3] | 2232.6 | -0.22% | 9599.3 |
| mixed | avx2-guard | 2954.8 | +0.0% [+0.0, +0.0] | 2237.4 | +0.00% | 9564.6 |
| mixed | table13-avx2 | 2880.4 | -3.7% [-3.8, -3.6] | 2235.8 | -0.07% | 9206.4 |
| mixed | table12-avx2 | 2834.3 | -4.2% [-4.4, -4.1] | 2233.9 | -0.16% | 9152.7 |
| mixed | table11-avx2 | 2855.5 | -3.5% [-3.6, -3.3] | 2232.6 | -0.22% | 9229.0 |
| period127 | scalar | 962.2 | +0.0% [+0.0, +0.0] | 153.0 | +0.00% | 3167.6 |
| period127 | table13-scalar | 779.7 | -17.3% [-17.7, -17.3] | 153.0 | +0.00% | 2621.1 |
| period127 | table12-scalar | 711.4 | -25.6% [-26.0, -25.6] | 153.0 | +0.00% | 2355.7 |
| period127 | table11-scalar | 678.0 | -29.6% [-29.8, -29.5] | 153.0 | +0.00% | 2232.5 |
| period127 | avx2-guard | 604.5 | +0.0% [+0.0, +0.0] | 153.0 | +0.00% | 1990.1 |
| period127 | table13-avx2 | 449.2 | -25.6% [-25.7, -25.1] | 153.0 | +0.00% | 1480.6 |
| period127 | table12-avx2 | 369.2 | -38.0% [-38.1, -37.7] | 153.0 | +0.00% | 1232.6 |
| period127 | table11-avx2 | 327.7 | -45.1% [-45.3, -44.8] | 153.0 | +0.00% | 1092.1 |
| random | scalar | 1265.7 | +0.0% [+0.0, +0.0] | 4114.0 | +0.00% | 4287.6 |
| random | table13-scalar | 1026.9 | -18.9% [-18.9, -18.9] | 4114.0 | +0.00% | 3478.1 |
| random | table12-scalar | 966.6 | -23.7% [-23.7, -23.7] | 4114.0 | +0.00% | 3272.1 |
| random | table11-scalar | 921.6 | -27.2% [-27.3, -27.2] | 4114.0 | +0.00% | 3120.2 |
| random | avx2-guard | 1184.5 | +0.0% [+0.0, +0.0] | 4114.0 | +0.00% | 4007.3 |
| random | table13-avx2 | 1028.8 | -13.1% [-13.1, -13.1] | 4114.0 | +0.00% | 3482.9 |
| random | table12-avx2 | 969.1 | -18.1% [-18.2, -18.1] | 4114.0 | +0.00% | 3280.9 |
| random | table11-avx2 | 914.6 | -22.7% [-22.8, -22.7] | 4114.0 | +0.00% | 3096.2 |
| sparse | scalar | 1761.3 | +0.0% [+0.0, +0.0] | 767.7 | +0.00% | 5949.6 |
| sparse | table13-scalar | 1500.7 | -14.6% [-14.8, -14.4] | 768.0 | +0.04% | 5078.8 |
| sparse | table12-scalar | 1424.2 | -19.0% [-19.2, -18.4] | 767.4 | -0.04% | 4816.6 |
| sparse | table11-scalar | 1386.4 | -21.0% [-21.3, -20.5] | 768.3 | +0.08% | 4692.2 |
| sparse | avx2-guard | 1646.1 | +0.0% [+0.0, +0.0] | 767.7 | +0.00% | 5569.1 |
| sparse | table13-avx2 | 1491.3 | -9.3% [-9.4, -9.1] | 768.0 | +0.04% | 5049.6 |
| sparse | table12-avx2 | 1417.0 | -14.1% [-14.2, -13.8] | 767.4 | -0.04% | 4782.8 |
| sparse | table11-avx2 | 1374.4 | -16.5% [-16.5, -15.9] | 768.3 | +0.08% | 4651.1 |
| word-tail508 | scalar | 1369.5 | +0.0% [+0.0, +0.0] | 2581.0 | +0.00% | 4465.8 |
| word-tail508 | table13-scalar | 1161.0 | -16.5% [-16.6, -16.4] | 2581.0 | +0.00% | 3727.0 |
| word-tail508 | table12-scalar | 1085.4 | -22.2% [-22.2, -22.0] | 2581.0 | +0.00% | 3470.7 |
| word-tail508 | table11-scalar | 1062.0 | -23.9% [-24.0, -23.6] | 2581.0 | +0.00% | 3396.5 |
| word-tail508 | avx2-guard | 1105.1 | +0.0% [+0.0, +0.0] | 2581.0 | +0.00% | 3583.8 |
| word-tail508 | table13-avx2 | 947.9 | -14.6% [-15.1, -14.5] | 2581.0 | +0.00% | 3055.5 |
| word-tail508 | table12-avx2 | 879.3 | -21.6% [-22.1, -21.3] | 2581.0 | +0.00% | 2804.6 |
| word-tail508 | table11-avx2 | 862.3 | -22.9% [-23.1, -22.3] | 2581.0 | +0.00% | 2758.2 |
| word-tail64 | scalar | 1358.9 | +0.0% [+0.0, +0.0] | 2138.0 | +0.00% | 4334.0 |
| word-tail64 | table13-scalar | 1132.8 | -16.6% [-16.6, -16.6] | 2138.0 | +0.00% | 3613.5 |
| word-tail64 | table12-scalar | 1051.8 | -22.6% [-22.6, -22.6] | 2138.0 | +0.00% | 3356.4 |
| word-tail64 | table11-scalar | 1012.1 | -25.5% [-25.5, -25.3] | 2138.0 | +0.00% | 3230.9 |
| word-tail64 | avx2-guard | 1060.0 | +0.0% [+0.0, +0.0] | 2138.0 | +0.00% | 3382.0 |
| word-tail64 | table13-avx2 | 900.7 | -15.0% [-15.1, -15.0] | 2138.0 | +0.00% | 2872.8 |
| word-tail64 | table12-avx2 | 821.7 | -22.5% [-22.5, -22.4] | 2138.0 | +0.00% | 2621.3 |
| word-tail64 | table11-avx2 | 781.3 | -26.3% [-26.3, -26.2] | 2138.0 | +0.00% | 2491.6 |
