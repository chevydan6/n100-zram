# Physical N100 independent-operation SIMD amortization experiment

Physical N100 kernel component experiment; syscall/dispatch/mutex/loop and kernel FPU handling included; normal ZRAM unchanged.
Three sessions per operation count; five shuffled recorded rounds plus one warm-up; 2,048 ioctl calls per timing batch.
Independent 4 KiB operations, counts [4, 5, 6, 7, 8]; six operation/pattern configurations and three caller-state fixtures.
All sixteen YMM sentinels checked before every batch; kernel verification and canaries
checked after each batch; nested kernel-FPU sections selected scalar fallback.
Probe unloaded successfully. No ZRAM compressor or boot default was replaced.

Lengths beyond 4096 bytes are diagnostics, not changes to MM page size or proof
of viable ZRAM batching. These primitives exclude hash search and format parsing.
Per-operation times divide the complete ioctl time by independent-operation count. Each ioctl enters the FPU context once, not once per page. Times include syscall, mutex, dispatch, checks/loop and state handling; FPU-scalar
uses the same scalar body and charges context-management overhead. Requested
clean/SSE-dirty/YMM-dirty states do not model every application xstate history.
PMU counts include user and kernel; RAPL includes batch bookkeeping/background.
Missing values remain -1; scheduling fraction is retained for rejecting multiplexing.

Intervals bootstrap three session median paired-round ratios (10,000 seeded draws).
These are descriptive small-sample intervals, not a universal crossover guarantee.

| Operations/ioctl | Bytes/operation | Operation | Pattern | Caller state | Scalar / FPU-scalar / SSE / AVX2 ns per operation | SSE change [95% session interval] | AVX2 change [interval] | Matched FPU-scalar delta ns/ioctl |
|---:|---:|---|---|---|---:|---:|---:|---:|
| 4 | 4096 | literal-copy | equal | clean | 149.9 / 254.6 / 272.5 / 247.1 | +82.1% [+79.3, +82.6] | +64.5% [+62.8, +67.6] | 420.3 |
| 4 | 4096 | literal-copy | equal | sse-dirty | 150.1 / 254.2 / 271.9 / 247.3 | +81.6% [+81.0, +81.8] | +65.0% [+65.0, +65.1] | 416.6 |
| 4 | 4096 | literal-copy | equal | ymm-dirty | 152.3 / 260.9 / 277.6 / 253.4 | +82.3% [+80.3, +85.4] | +66.0% [+65.4, +70.3] | 435.1 |
| 4 | 4096 | match-count | early | clean | 56.2 / 160.1 / 159.8 / 160.2 | +184.5% [+182.7, +184.6] | +184.2% [+183.2, +185.3] | 415.5 |
| 4 | 4096 | match-count | early | sse-dirty | 56.3 / 160.8 / 159.3 / 160.0 | +183.2% [+183.2, +184.2] | +184.9% [+184.8, +185.0] | 419.3 |
| 4 | 4096 | match-count | early | ymm-dirty | 56.9 / 165.6 / 164.9 / 165.4 | +191.7% [+188.9, +192.6] | +190.7% [+189.7, +191.2] | 435.7 |
| 4 | 4096 | match-count | equal | clean | 312.7 / 416.3 / 366.5 / 322.1 | +17.1% [+17.0, +17.7] | +2.8% [+2.7, +3.1] | 413.0 |
| 4 | 4096 | match-count | equal | sse-dirty | 312.6 / 416.4 / 366.4 / 321.8 | +17.2% [+17.1, +17.4] | +3.0% [+2.8, +3.2] | 415.0 |
| 4 | 4096 | match-count | equal | ymm-dirty | 313.3 / 421.0 / 371.9 / 327.0 | +18.7% [+18.5, +18.7] | +4.4% [+4.3, +4.6] | 431.1 |
| 4 | 4096 | match-count | late | clean | 322.9 / 425.8 / 365.4 / 321.6 | +13.2% [+13.0, +13.2] | -0.5% [-0.8, -0.2] | 410.8 |
| 4 | 4096 | match-count | late | sse-dirty | 323.0 / 426.0 / 365.4 / 321.5 | +13.2% [+12.7, +13.2] | -0.4% [-0.8, -0.4] | 411.6 |
| 4 | 4096 | match-count | late | ymm-dirty | 323.8 / 431.0 / 370.6 / 326.6 | +14.5% [+14.2, +14.7] | +1.0% [+0.8, +1.1] | 430.5 |
| 4 | 4096 | match-count | middle | clean | 187.9 / 292.7 / 267.4 / 231.0 | +42.4% [+42.1, +42.6] | +22.8% [+22.7, +23.7] | 419.5 |
| 4 | 4096 | match-count | middle | sse-dirty | 187.9 / 292.9 / 267.4 / 231.7 | +42.4% [+42.3, +42.7] | +23.3% [+23.0, +23.9] | 420.3 |
| 4 | 4096 | match-count | middle | ymm-dirty | 188.6 / 298.1 / 273.0 / 236.6 | +44.6% [+44.6, +44.8] | +25.3% [+25.2, +26.2] | 437.2 |
| 4 | 4096 | repeat8-copy | equal | clean | 154.8 / 256.8 / 254.7 / 254.9 | +66.0% [+60.9, +69.4] | +64.9% [+59.8, +64.9] | 406.3 |
| 4 | 4096 | repeat8-copy | equal | sse-dirty | 154.6 / 256.8 / 251.0 / 252.1 | +62.5% [+59.0, +62.9] | +63.1% [+60.3, +65.6] | 408.5 |
| 4 | 4096 | repeat8-copy | equal | ymm-dirty | 155.4 / 261.9 / 258.4 / 257.9 | +67.5% [+63.4, +67.7] | +64.9% [+63.6, +65.8] | 425.8 |
| 5 | 4096 | literal-copy | equal | clean | 154.9 / 240.9 / 249.8 / 239.8 | +61.5% [+60.9, +62.6] | +54.7% [+53.7, +55.0] | 430.0 |
| 5 | 4096 | literal-copy | equal | sse-dirty | 155.1 / 240.9 / 250.3 / 240.0 | +62.2% [+61.3, +62.2] | +54.8% [+54.5, +55.2] | 431.7 |
| 5 | 4096 | literal-copy | equal | ymm-dirty | 156.0 / 246.4 / 255.2 / 245.5 | +63.6% [+63.3, +64.5] | +57.3% [+57.1, +57.5] | 452.3 |
| 5 | 4096 | match-count | early | clean | 45.3 / 128.7 / 128.1 / 127.8 | +182.8% [+179.6, +184.9] | +182.3% [+178.5, +185.1] | 415.6 |
| 5 | 4096 | match-count | early | sse-dirty | 45.3 / 127.7 / 128.1 / 128.8 | +182.6% [+175.6, +182.8] | +184.8% [+176.5, +185.5] | 412.7 |
| 5 | 4096 | match-count | early | ymm-dirty | 46.0 / 132.1 / 132.3 / 132.8 | +186.5% [+181.8, +189.6] | +189.0% [+184.2, +189.7] | 430.6 |
| 5 | 4096 | match-count | equal | clean | 305.0 / 388.2 / 344.0 / 290.0 | +13.1% [+12.8, +13.2] | -4.6% [-4.9, -4.6] | 416.4 |
| 5 | 4096 | match-count | equal | sse-dirty | 304.9 / 388.3 / 343.9 / 289.8 | +13.0% [+12.3, +13.0] | -4.6% [-5.3, -4.5] | 414.9 |
| 5 | 4096 | match-count | equal | ymm-dirty | 305.5 / 392.4 / 348.4 / 293.8 | +14.1% [+14.0, +15.1] | -3.5% [-3.8, -3.5] | 434.5 |
| 5 | 4096 | match-count | late | clean | 314.3 / 396.4 / 342.6 / 289.3 | +9.0% [+8.9, +9.0] | -8.0% [-8.2, -7.9] | 410.9 |
| 5 | 4096 | match-count | late | sse-dirty | 314.4 / 396.7 / 342.7 / 289.5 | +9.0% [+8.8, +9.0] | -8.0% [-8.2, -7.9] | 412.5 |
| 5 | 4096 | match-count | late | ymm-dirty | 314.8 / 400.6 / 346.8 / 293.2 | +10.1% [+10.1, +10.2] | -6.9% [-7.1, -6.8] | 429.6 |
| 5 | 4096 | match-count | middle | clean | 179.1 / 262.7 / 245.6 / 207.2 | +37.2% [+35.6, +37.6] | +15.5% [+14.6, +16.1] | 417.7 |
| 5 | 4096 | match-count | middle | sse-dirty | 179.2 / 263.2 / 245.7 / 207.5 | +36.9% [+35.4, +37.5] | +15.8% [+14.5, +15.9] | 415.2 |
| 5 | 4096 | match-count | middle | ymm-dirty | 179.5 / 267.3 / 249.6 / 211.9 | +38.9% [+37.4, +39.1] | +17.7% [+16.8, +18.0] | 436.0 |
| 5 | 4096 | repeat8-copy | equal | clean | 144.6 / 226.5 / 233.9 / 229.9 | +58.7% [+58.7, +65.9] | +60.4% [+55.4, +61.2] | 411.4 |
| 5 | 4096 | repeat8-copy | equal | sse-dirty | 145.1 / 226.7 / 230.4 / 231.3 | +62.3% [+54.1, +62.4] | +59.7% [+56.6, +61.4] | 409.4 |
| 5 | 4096 | repeat8-copy | equal | ymm-dirty | 144.8 / 230.8 / 234.3 / 230.8 | +59.8% [+59.6, +63.1] | +59.0% [+57.6, +60.8] | 426.0 |
| 6 | 4096 | literal-copy | equal | clean | 167.5 / 238.3 / 241.3 / 234.5 | +44.0% [+42.6, +44.5] | +39.9% [+39.7, +41.2] | 423.5 |
| 6 | 4096 | literal-copy | equal | sse-dirty | 167.8 / 238.2 / 241.7 / 237.1 | +44.0% [+42.9, +44.3] | +41.4% [+39.4, +41.5] | 422.8 |
| 6 | 4096 | literal-copy | equal | ymm-dirty | 168.2 / 242.3 / 245.3 / 240.6 | +45.8% [+44.7, +46.9] | +42.7% [+41.5, +44.0] | 445.8 |
| 6 | 4096 | match-count | early | clean | 37.5 / 106.6 / 106.4 / 106.9 | +183.6% [+178.7, +185.1] | +185.5% [+179.5, +186.5] | 414.1 |
| 6 | 4096 | match-count | early | sse-dirty | 37.5 / 106.7 / 106.7 / 107.0 | +183.9% [+178.5, +184.9] | +185.4% [+179.8, +186.1] | 414.8 |
| 6 | 4096 | match-count | early | ymm-dirty | 38.0 / 110.2 / 109.9 / 110.4 | +189.7% [+186.0, +189.7] | +190.4% [+186.4, +190.7] | 432.9 |
| 6 | 4096 | match-count | equal | clean | 298.8 / 369.6 / 319.2 / 257.4 | +6.9% [+6.8, +8.7] | -13.9% [-14.0, -12.1] | 414.4 |
| 6 | 4096 | match-count | equal | sse-dirty | 298.8 / 367.7 / 318.9 / 257.1 | +6.9% [+6.8, +6.9] | -13.7% [-13.9, -13.3] | 415.0 |
| 6 | 4096 | match-count | equal | ymm-dirty | 299.1 / 371.1 / 322.3 / 260.0 | +7.7% [+7.7, +7.9] | -13.1% [-13.4, -13.1] | 432.5 |
| 6 | 4096 | match-count | late | clean | 307.4 / 376.4 / 319.0 / 256.8 | +3.6% [+3.6, +3.8] | -16.5% [-16.8, -16.4] | 413.4 |
| 6 | 4096 | match-count | late | sse-dirty | 307.2 / 376.2 / 318.1 / 256.8 | +3.6% [+3.5, +3.6] | -16.6% [-16.8, -16.3] | 413.4 |
| 6 | 4096 | match-count | late | ymm-dirty | 307.6 / 379.8 / 321.7 / 259.6 | +4.5% [+4.5, +4.7] | -15.7% [-16.0, -15.5] | 434.3 |
| 6 | 4096 | match-count | middle | clean | 174.0 / 243.4 / 224.0 / 181.5 | +28.5% [+28.2, +28.8] | +4.3% [+3.5, +4.3] | 416.9 |
| 6 | 4096 | match-count | middle | sse-dirty | 174.1 / 243.6 / 223.6 / 181.3 | +28.4% [+28.4, +28.5] | +4.1% [+3.6, +4.1] | 417.7 |
| 6 | 4096 | match-count | middle | ymm-dirty | 174.5 / 247.1 / 227.0 / 184.5 | +30.0% [+29.8, +30.1] | +5.8% [+5.0, +5.8] | 436.0 |
| 6 | 4096 | repeat8-copy | equal | clean | 139.0 / 208.2 / 209.0 / 205.0 | +48.4% [+48.2, +53.4] | +47.2% [+44.6, +49.3] | 414.1 |
| 6 | 4096 | repeat8-copy | equal | sse-dirty | 140.1 / 207.7 / 207.2 / 206.5 | +47.4% [+45.7, +50.7] | +46.6% [+44.8, +47.6] | 400.6 |
| 6 | 4096 | repeat8-copy | equal | ymm-dirty | 139.6 / 210.5 / 210.5 / 209.1 | +51.5% [+50.2, +53.1] | +47.9% [+47.9, +52.1] | 426.5 |
| 7 | 4096 | literal-copy | equal | clean | 170.9 / 230.9 / 234.6 / 228.7 | +37.4% [+36.8, +37.7] | +33.9% [+33.6, +34.1] | 419.6 |
| 7 | 4096 | literal-copy | equal | sse-dirty | 170.9 / 230.7 / 234.9 / 228.9 | +37.6% [+37.3, +37.6] | +33.6% [+32.1, +33.8] | 418.9 |
| 7 | 4096 | literal-copy | equal | ymm-dirty | 171.5 / 234.5 / 238.2 / 232.5 | +38.7% [+37.5, +39.2] | +35.2% [+33.6, +35.9] | 440.8 |
| 7 | 4096 | match-count | early | clean | 32.7 / 91.8 / 92.0 / 92.1 | +180.9% [+179.3, +181.2] | +182.3% [+180.4, +182.6] | 413.7 |
| 7 | 4096 | match-count | early | sse-dirty | 32.8 / 91.9 / 91.8 / 92.4 | +180.0% [+179.3, +180.9] | +180.9% [+180.8, +181.8] | 413.6 |
| 7 | 4096 | match-count | early | ymm-dirty | 33.3 / 94.8 / 94.7 / 95.0 | +184.6% [+183.3, +187.9] | +184.9% [+184.3, +188.9] | 431.2 |
| 7 | 4096 | match-count | equal | clean | 292.9 / 352.4 / 300.5 / 236.6 | +2.5% [+2.5, +2.6] | -19.4% [-19.5, -19.0] | 413.7 |
| 7 | 4096 | match-count | equal | sse-dirty | 293.0 / 352.5 / 300.8 / 237.5 | +2.4% [+2.3, +2.7] | -19.1% [-19.5, -18.9] | 415.7 |
| 7 | 4096 | match-count | equal | ymm-dirty | 293.6 / 355.3 / 303.7 / 239.9 | +3.3% [+3.2, +3.5] | -18.1% [-18.7, -18.1] | 431.9 |
| 7 | 4096 | match-count | late | clean | 300.4 / 359.9 / 299.9 / 236.2 | -0.2% [-0.2, -0.1] | -21.4% [-21.6, -21.2] | 415.1 |
| 7 | 4096 | match-count | late | sse-dirty | 300.6 / 359.8 / 300.1 / 236.3 | -0.3% [-0.5, -0.2] | -21.3% [-21.8, -21.2] | 410.7 |
| 7 | 4096 | match-count | late | ymm-dirty | 300.8 / 362.7 / 302.7 / 238.9 | +0.6% [+0.6, +0.7] | -20.6% [-20.7, -20.2] | 431.2 |
| 7 | 4096 | match-count | middle | clean | 168.9 / 228.0 / 206.6 / 163.8 | +22.1% [+22.0, +22.5] | -2.9% [-3.0, -2.4] | 415.4 |
| 7 | 4096 | match-count | middle | sse-dirty | 169.2 / 228.3 / 206.9 / 163.9 | +22.5% [+22.4, +23.2] | -2.8% [-3.2, -2.2] | 416.6 |
| 7 | 4096 | match-count | middle | ymm-dirty | 169.3 / 230.7 / 209.4 / 166.9 | +23.8% [+23.7, +23.9] | -1.5% [-1.5, -0.8] | 431.7 |
| 7 | 4096 | repeat8-copy | equal | clean | 136.6 / 195.7 / 201.1 / 195.4 | +46.9% [+45.5, +50.7] | +43.2% [+42.9, +43.3] | 411.3 |
| 7 | 4096 | repeat8-copy | equal | sse-dirty | 136.4 / 194.9 / 197.9 / 196.2 | +46.4% [+42.1, +48.5] | +43.0% [+39.5, +49.1] | 409.4 |
| 7 | 4096 | repeat8-copy | equal | ymm-dirty | 136.7 / 197.2 / 199.2 / 198.8 | +47.6% [+44.6, +51.2] | +45.3% [+41.5, +45.6] | 419.4 |
| 8 | 4096 | literal-copy | equal | clean | 170.1 / 223.0 / 226.9 / 222.1 | +33.3% [+31.9, +33.4] | +30.3% [+28.8, +30.5] | 424.7 |
| 8 | 4096 | literal-copy | equal | sse-dirty | 170.3 / 223.1 / 226.9 / 222.0 | +33.4% [+31.1, +33.4] | +30.5% [+28.4, +30.7] | 423.7 |
| 8 | 4096 | literal-copy | equal | ymm-dirty | 170.6 / 226.3 / 230.3 / 225.3 | +35.0% [+33.5, +35.1] | +31.8% [+29.9, +32.4] | 445.2 |
| 8 | 4096 | match-count | early | clean | 29.2 / 80.9 / 80.9 / 80.9 | +176.1% [+176.0, +176.6] | +176.8% [+176.5, +177.6] | 413.0 |
| 8 | 4096 | match-count | early | sse-dirty | 29.3 / 80.7 / 80.8 / 81.2 | +175.1% [+174.5, +175.8] | +176.3% [+176.3, +176.9] | 411.0 |
| 8 | 4096 | match-count | early | ymm-dirty | 29.6 / 83.4 / 83.4 / 83.6 | +182.1% [+181.1, +182.5] | +182.8% [+181.4, +183.3] | 430.4 |
| 8 | 4096 | match-count | equal | clean | 288.6 / 339.7 / 287.1 / 223.8 | -0.5% [-0.9, -0.5] | -22.7% [-22.8, -22.3] | 410.4 |
| 8 | 4096 | match-count | equal | sse-dirty | 288.6 / 340.0 / 287.0 / 223.8 | -0.5% [-0.6, -0.4] | -22.4% [-22.7, -22.4] | 409.6 |
| 8 | 4096 | match-count | equal | ymm-dirty | 288.8 / 342.5 / 289.5 / 226.0 | +0.3% [+0.1, +0.3] | -21.6% [-22.0, -21.6] | 429.2 |
| 8 | 4096 | match-count | late | clean | 294.1 / 345.5 / 286.5 / 223.5 | -2.7% [-2.7, -2.6] | -24.0% [-24.5, -23.9] | 408.1 |
| 8 | 4096 | match-count | late | sse-dirty | 294.8 / 345.6 / 286.7 / 223.6 | -2.8% [-2.9, -2.6] | -24.2% [-24.4, -23.9] | 409.6 |
| 8 | 4096 | match-count | late | ymm-dirty | 294.7 / 348.3 / 289.2 / 226.2 | -1.9% [-2.1, -1.7] | -23.3% [-23.6, -23.1] | 428.4 |
| 8 | 4096 | match-count | middle | clean | 165.2 / 217.0 / 193.7 / 153.4 | +17.2% [+16.1, +17.4] | -7.3% [-7.4, -7.2] | 414.2 |
| 8 | 4096 | match-count | middle | sse-dirty | 164.7 / 216.8 / 193.7 / 153.3 | +17.1% [+14.5, +17.9] | -7.2% [-7.3, -6.9] | 418.3 |
| 8 | 4096 | match-count | middle | ymm-dirty | 165.2 / 219.4 / 196.3 / 155.8 | +18.9% [+18.8, +19.2] | -5.7% [-6.0, -5.7] | 434.7 |
| 8 | 4096 | repeat8-copy | equal | clean | 136.1 / 187.8 / 188.5 / 181.3 | +38.5% [+36.2, +39.1] | +32.4% [+29.9, +37.2] | 405.7 |
| 8 | 4096 | repeat8-copy | equal | sse-dirty | 137.4 / 186.3 / 189.5 / 183.8 | +37.6% [+37.6, +42.3] | +37.4% [+32.2, +38.1] | 403.8 |
| 8 | 4096 | repeat8-copy | equal | ymm-dirty | 135.6 / 186.8 / 191.0 / 187.0 | +40.8% [+39.9, +42.1] | +36.9% [+36.5, +39.2] | 408.7 |
