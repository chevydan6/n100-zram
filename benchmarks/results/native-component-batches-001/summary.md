# Physical N100 independent-operation SIMD amortization experiment

Physical N100 kernel component experiment; syscall/dispatch/mutex/loop and kernel FPU handling included; normal ZRAM unchanged.
Three sessions per operation count; five shuffled recorded rounds plus one warm-up; 2,048 ioctl calls per timing batch.
Independent 4 KiB operations, counts 1/2/4/8/16; six operation/pattern configurations and three caller-state fixtures.
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
| 1 | 4096 | literal-copy | equal | clean | 303.9 / 715.9 / 723.4 / 700.6 | +138.5% [+129.4, +138.7] | +130.9% [+123.7, +131.2] | 412.5 |
| 1 | 4096 | literal-copy | equal | sse-dirty | 304.3 / 716.4 / 724.0 / 698.9 | +137.9% [+129.4, +139.4] | +130.0% [+121.3, +131.7] | 411.2 |
| 1 | 4096 | literal-copy | equal | ymm-dirty | 307.6 / 736.0 / 745.4 / 720.2 | +142.6% [+135.8, +143.3] | +134.4% [+127.0, +135.1] | 427.9 |
| 1 | 4096 | match-count | early | clean | 212.1 / 626.9 / 626.0 / 627.2 | +195.1% [+193.9, +197.6] | +195.3% [+194.2, +197.7] | 415.0 |
| 1 | 4096 | match-count | early | sse-dirty | 212.5 / 627.1 / 626.2 / 628.7 | +194.8% [+194.6, +195.7] | +195.6% [+195.4, +197.7] | 413.9 |
| 1 | 4096 | match-count | early | ymm-dirty | 215.3 / 647.7 / 646.7 / 648.3 | +200.5% [+199.8, +201.2] | +200.5% [+200.4, +203.6] | 432.0 |
| 1 | 4096 | match-count | equal | clean | 476.8 / 894.1 / 833.9 / 764.3 | +76.7% [+71.5, +77.5] | +60.7% [+59.3, +61.5] | 419.2 |
| 1 | 4096 | match-count | equal | sse-dirty | 472.1 / 887.0 / 834.8 / 755.6 | +76.2% [+75.9, +81.1] | +61.0% [+60.7, +61.2] | 416.2 |
| 1 | 4096 | match-count | equal | ymm-dirty | 481.0 / 912.2 / 858.6 / 781.5 | +79.4% [+78.8, +80.6] | +63.2% [+60.8, +63.5] | 440.7 |
| 1 | 4096 | match-count | late | clean | 469.3 / 884.0 / 821.2 / 750.2 | +75.3% [+74.7, +75.5] | +60.1% [+59.8, +60.2] | 417.0 |
| 1 | 4096 | match-count | late | sse-dirty | 468.9 / 884.5 / 821.9 / 751.4 | +75.2% [+75.0, +75.8] | +59.9% [+59.8, +60.1] | 416.2 |
| 1 | 4096 | match-count | late | ymm-dirty | 471.6 / 905.4 / 843.1 / 771.7 | +78.5% [+78.4, +78.9] | +63.3% [+63.2, +63.6] | 435.1 |
| 1 | 4096 | match-count | middle | clean | 341.4 / 756.9 / 730.1 / 686.2 | +113.8% [+113.6, +116.3] | +101.0% [+100.9, +103.8] | 415.3 |
| 1 | 4096 | match-count | middle | sse-dirty | 341.8 / 758.2 / 730.7 / 686.4 | +113.9% [+113.4, +114.5] | +100.5% [+100.2, +100.5] | 415.3 |
| 1 | 4096 | match-count | middle | ymm-dirty | 344.8 / 777.7 / 751.7 / 706.7 | +117.7% [+117.3, +119.7] | +104.8% [+104.4, +106.8] | 432.8 |
| 1 | 4096 | repeat8-copy | equal | clean | 311.7 / 722.2 / 690.3 / 684.0 | +122.4% [+120.7, +122.6] | +119.6% [+118.8, +122.2] | 411.7 |
| 1 | 4096 | repeat8-copy | equal | sse-dirty | 311.7 / 723.6 / 691.2 / 685.4 | +121.5% [+120.6, +122.1] | +119.5% [+118.9, +120.7] | 410.8 |
| 1 | 4096 | repeat8-copy | equal | ymm-dirty | 314.9 / 743.4 / 709.5 / 705.2 | +125.4% [+125.4, +126.9] | +123.5% [+123.0, +125.3] | 429.9 |
| 2 | 4096 | literal-copy | equal | clean | 197.0 / 402.9 / 417.3 / 391.7 | +111.5% [+110.3, +113.3] | +98.1% [+97.6, +99.8] | 412.1 |
| 2 | 4096 | literal-copy | equal | sse-dirty | 197.3 / 402.1 / 417.8 / 391.3 | +111.3% [+110.8, +112.8] | +98.2% [+96.9, +99.2] | 410.4 |
| 2 | 4096 | literal-copy | equal | ymm-dirty | 199.0 / 413.6 / 428.2 / 401.8 | +113.7% [+113.5, +115.5] | +101.3% [+100.4, +102.5] | 428.8 |
| 2 | 4096 | match-count | early | clean | 108.3 / 315.3 / 315.5 / 315.6 | +192.0% [+189.6, +192.8] | +191.5% [+189.4, +193.1] | 413.8 |
| 2 | 4096 | match-count | early | sse-dirty | 108.4 / 315.5 / 315.6 / 315.7 | +191.2% [+190.3, +192.2] | +191.5% [+190.8, +191.6] | 413.9 |
| 2 | 4096 | match-count | early | ymm-dirty | 109.8 / 325.9 / 326.0 / 325.5 | +196.7% [+196.4, +197.4] | +196.4% [+196.2, +196.8] | 431.9 |
| 2 | 4096 | match-count | equal | clean | 370.3 / 574.5 / 522.3 / 451.6 | +41.3% [+40.3, +41.8] | +22.0% [+21.3, +22.2] | 412.6 |
| 2 | 4096 | match-count | equal | sse-dirty | 368.7 / 574.4 / 520.5 / 449.7 | +41.3% [+40.4, +41.9] | +22.2% [+22.1, +22.6] | 408.1 |
| 2 | 4096 | match-count | equal | ymm-dirty | 367.6 / 584.9 / 528.1 / 457.7 | +43.9% [+43.3, +43.9] | +24.8% [+24.8, +25.4] | 428.9 |
| 2 | 4096 | match-count | late | clean | 379.0 / 577.2 / 512.1 / 445.9 | +36.1% [+34.7, +37.0] | +17.5% [+17.0, +19.0] | 397.5 |
| 2 | 4096 | match-count | late | sse-dirty | 375.2 / 577.7 / 512.4 / 444.8 | +36.7% [+36.6, +38.3] | +18.5% [+17.3, +20.3] | 404.7 |
| 2 | 4096 | match-count | late | ymm-dirty | 376.2 / 587.6 / 522.4 / 457.1 | +39.5% [+38.9, +41.6] | +21.0% [+20.3, +23.4] | 422.6 |
| 2 | 4096 | match-count | middle | clean | 241.3 / 449.5 / 422.5 / 370.5 | +75.6% [+74.9, +76.1] | +54.0% [+51.8, +54.0] | 416.8 |
| 2 | 4096 | match-count | middle | sse-dirty | 240.8 / 450.6 / 422.4 / 370.8 | +74.5% [+74.3, +75.8] | +53.9% [+47.9, +54.0] | 418.3 |
| 2 | 4096 | match-count | middle | ymm-dirty | 242.5 / 460.4 / 432.9 / 381.7 | +78.2% [+77.8, +78.7] | +57.7% [+57.0, +66.1] | 435.4 |
| 2 | 4096 | repeat8-copy | equal | clean | 207.8 / 413.1 / 404.9 / 400.8 | +94.7% [+92.9, +96.8] | +92.6% [+89.9, +95.6] | 412.0 |
| 2 | 4096 | repeat8-copy | equal | sse-dirty | 207.9 / 413.6 / 405.7 / 401.1 | +95.3% [+93.5, +97.8] | +91.0% [+90.7, +91.2] | 411.7 |
| 2 | 4096 | repeat8-copy | equal | ymm-dirty | 208.5 / 423.5 / 416.2 / 411.7 | +100.1% [+99.4, +101.2] | +98.2% [+94.4, +100.4] | 431.2 |
| 4 | 4096 | literal-copy | equal | clean | 150.0 / 253.7 / 271.8 / 246.3 | +82.8% [+77.1, +82.8] | +63.9% [+60.8, +66.0] | 414.0 |
| 4 | 4096 | literal-copy | equal | sse-dirty | 150.2 / 254.3 / 272.4 / 247.2 | +80.4% [+77.9, +82.8] | +64.8% [+61.7, +65.5] | 415.9 |
| 4 | 4096 | literal-copy | equal | ymm-dirty | 152.5 / 260.2 / 278.2 / 253.6 | +83.5% [+79.6, +85.9] | +66.3% [+63.1, +69.6] | 435.0 |
| 4 | 4096 | match-count | early | clean | 56.1 / 159.6 / 159.7 / 159.4 | +184.2% [+178.8, +185.1] | +184.4% [+178.5, +185.9] | 411.3 |
| 4 | 4096 | match-count | early | sse-dirty | 56.0 / 160.3 / 159.9 / 160.7 | +184.9% [+179.0, +185.5] | +186.0% [+180.5, +186.7] | 414.0 |
| 4 | 4096 | match-count | early | ymm-dirty | 56.8 / 165.2 / 165.2 / 165.1 | +189.7% [+182.1, +192.2] | +191.0% [+183.4, +191.4] | 431.1 |
| 4 | 4096 | match-count | equal | clean | 315.1 / 419.4 / 370.3 / 324.4 | +17.0% [+17.0, +17.7] | +2.7% [+1.3, +3.1] | 415.9 |
| 4 | 4096 | match-count | equal | sse-dirty | 313.8 / 417.5 / 370.2 / 321.8 | +17.2% [+17.1, +17.3] | +2.7% [+1.1, +3.0] | 414.4 |
| 4 | 4096 | match-count | equal | ymm-dirty | 313.3 / 424.6 / 372.9 / 327.6 | +18.8% [+18.7, +18.8] | +4.3% [+2.9, +4.5] | 434.1 |
| 4 | 4096 | match-count | late | clean | 323.4 / 425.9 / 365.6 / 321.3 | +13.1% [+12.7, +13.3] | -0.9% [-2.1, -0.3] | 412.9 |
| 4 | 4096 | match-count | late | sse-dirty | 322.5 / 425.8 / 365.8 / 321.2 | +13.1% [+12.9, +13.4] | -0.8% [-2.2, -0.4] | 412.9 |
| 4 | 4096 | match-count | late | ymm-dirty | 323.7 / 431.5 / 371.0 / 326.2 | +14.6% [+14.4, +14.7] | +0.7% [-0.6, +0.9] | 431.6 |
| 4 | 4096 | match-count | middle | clean | 188.3 / 293.1 / 268.8 / 235.8 | +42.2% [+41.6, +42.8] | +24.1% [+23.0, +25.4] | 416.3 |
| 4 | 4096 | match-count | middle | sse-dirty | 188.8 / 293.4 / 268.4 / 236.2 | +41.8% [+40.9, +42.7] | +24.5% [+23.1, +25.4] | 415.9 |
| 4 | 4096 | match-count | middle | ymm-dirty | 188.9 / 298.6 / 274.3 / 241.1 | +44.0% [+43.6, +45.7] | +26.1% [+25.1, +28.0] | 432.9 |
| 4 | 4096 | repeat8-copy | equal | clean | 155.0 / 257.4 / 255.5 / 255.4 | +64.6% [+61.4, +67.8] | +63.5% [+60.9, +69.4] | 409.7 |
| 4 | 4096 | repeat8-copy | equal | sse-dirty | 155.0 / 256.9 / 255.7 / 253.7 | +64.8% [+64.3, +65.1] | +64.6% [+61.5, +64.6] | 409.4 |
| 4 | 4096 | repeat8-copy | equal | ymm-dirty | 156.5 / 262.2 / 259.5 / 259.9 | +66.7% [+65.3, +66.8] | +66.6% [+65.5, +70.6] | 423.5 |
| 8 | 4096 | literal-copy | equal | clean | 170.2 / 223.4 / 227.0 / 222.0 | +33.4% [+33.2, +33.5] | +30.7% [+30.2, +30.8] | 425.4 |
| 8 | 4096 | literal-copy | equal | sse-dirty | 170.3 / 223.4 / 227.2 / 222.2 | +33.6% [+33.2, +33.7] | +30.5% [+30.4, +30.7] | 424.2 |
| 8 | 4096 | literal-copy | equal | ymm-dirty | 170.6 / 226.8 / 230.3 / 225.5 | +34.9% [+34.8, +35.2] | +32.2% [+32.0, +32.3] | 449.2 |
| 8 | 4096 | match-count | early | clean | 29.2 / 80.8 / 81.0 / 81.2 | +177.8% [+176.9, +181.3] | +179.3% [+176.9, +181.8] | 414.2 |
| 8 | 4096 | match-count | early | sse-dirty | 29.1 / 80.8 / 81.1 / 81.2 | +178.8% [+177.3, +183.5] | +178.3% [+178.1, +183.1] | 414.0 |
| 8 | 4096 | match-count | early | ymm-dirty | 29.6 / 83.7 / 83.6 / 83.7 | +183.2% [+182.9, +187.6] | +183.8% [+182.3, +188.0] | 434.0 |
| 8 | 4096 | match-count | equal | clean | 288.4 / 340.2 / 286.6 / 223.4 | -0.6% [-0.7, -0.6] | -22.6% [-22.9, -22.5] | 411.2 |
| 8 | 4096 | match-count | equal | sse-dirty | 288.5 / 339.7 / 286.6 / 223.3 | -0.7% [-0.7, -0.6] | -22.5% [-22.9, -22.5] | 405.7 |
| 8 | 4096 | match-count | equal | ymm-dirty | 288.7 / 342.5 / 289.4 / 225.8 | +0.3% [+0.1, +0.3] | -21.8% [-22.1, -21.8] | 427.4 |
| 8 | 4096 | match-count | late | clean | 294.2 / 345.3 / 286.2 / 222.9 | -2.8% [-2.8, -2.5] | -24.2% [-24.4, -24.0] | 409.4 |
| 8 | 4096 | match-count | late | sse-dirty | 293.7 / 345.4 / 286.1 / 223.0 | -2.4% [-2.8, -2.3] | -24.2% [-24.3, -23.9] | 417.4 |
| 8 | 4096 | match-count | late | ymm-dirty | 294.9 / 347.5 / 288.9 / 225.3 | -1.8% [-2.1, -1.6] | -23.5% [-23.9, -23.4] | 424.8 |
| 8 | 4096 | match-count | middle | clean | 164.9 / 216.7 / 193.3 / 152.9 | +17.3% [+17.0, +17.9] | -7.4% [-7.5, -7.3] | 413.3 |
| 8 | 4096 | match-count | middle | sse-dirty | 165.1 / 217.3 / 193.4 / 153.0 | +17.3% [+17.2, +17.8] | -7.4% [-7.6, -7.3] | 414.3 |
| 8 | 4096 | match-count | middle | ymm-dirty | 165.6 / 219.2 / 196.0 / 155.5 | +18.4% [+18.4, +19.2] | -6.2% [-6.4, -6.1] | 430.3 |
| 8 | 4096 | repeat8-copy | equal | clean | 135.7 / 186.1 / 194.2 / 190.9 | +40.0% [+38.1, +45.9] | +43.2% [+36.3, +45.0] | 404.1 |
| 8 | 4096 | repeat8-copy | equal | sse-dirty | 135.4 / 185.6 / 191.4 / 192.9 | +42.8% [+39.5, +45.0] | +41.9% [+40.7, +44.8] | 396.1 |
| 8 | 4096 | repeat8-copy | equal | ymm-dirty | 135.8 / 186.3 / 196.4 / 194.3 | +44.7% [+37.1, +47.6] | +43.9% [+40.7, +45.3] | 409.5 |
| 16 | 4096 | literal-copy | equal | clean | 160.4 / 186.8 / 188.1 / 188.8 | +17.3% [+14.6, +17.4] | +17.8% [+14.1, +17.9] | 423.5 |
| 16 | 4096 | literal-copy | equal | sse-dirty | 160.2 / 186.9 / 187.9 / 188.8 | +17.4% [+14.5, +17.4] | +17.9% [+13.9, +17.9] | 424.7 |
| 16 | 4096 | literal-copy | equal | ymm-dirty | 160.6 / 188.4 / 189.4 / 190.2 | +17.7% [+15.8, +18.2] | +18.5% [+14.9, +18.6] | 444.9 |
| 16 | 4096 | match-count | early | clean | 15.7 / 41.7 / 41.8 / 42.0 | +165.9% [+163.8, +167.6] | +167.4% [+164.1, +167.6] | 414.1 |
| 16 | 4096 | match-count | early | sse-dirty | 15.8 / 41.7 / 41.9 / 42.0 | +165.9% [+162.2, +168.3] | +167.2% [+163.4, +167.3] | 414.2 |
| 16 | 4096 | match-count | early | ymm-dirty | 16.0 / 42.9 / 43.1 / 43.3 | +170.9% [+168.7, +171.4] | +172.1% [+168.2, +172.3] | 432.8 |
| 16 | 4096 | match-count | equal | clean | 270.9 / 296.7 / 246.6 / 178.5 | -9.0% [-9.2, -8.9] | -34.0% [-34.3, -33.8] | 413.0 |
| 16 | 4096 | match-count | equal | sse-dirty | 270.8 / 296.7 / 246.6 / 178.5 | -9.0% [-9.1, -8.9] | -34.0% [-34.2, -33.9] | 411.8 |
| 16 | 4096 | match-count | equal | ymm-dirty | 271.0 / 298.0 / 247.8 / 180.2 | -8.6% [-8.6, -8.4] | -33.5% [-33.7, -33.3] | 433.2 |
| 16 | 4096 | match-count | late | clean | 275.8 / 301.8 / 246.2 / 178.4 | -10.5% [-10.9, -10.0] | -35.3% [-35.5, -33.9] | 419.0 |
| 16 | 4096 | match-count | late | sse-dirty | 275.4 / 301.8 / 246.1 / 178.3 | -10.5% [-11.1, -9.9] | -35.2% [-35.2, -35.1] | 432.3 |
| 16 | 4096 | match-count | late | ymm-dirty | 276.1 / 304.2 / 247.6 / 180.4 | -10.2% [-10.3, -9.5] | -34.6% [-34.7, -34.1] | 448.0 |
| 16 | 4096 | match-count | middle | clean | 148.8 / 174.9 / 152.4 / 112.6 | +2.4% [+2.3, +2.7] | -24.3% [-24.8, -24.1] | 420.4 |
| 16 | 4096 | match-count | middle | sse-dirty | 148.5 / 174.9 / 152.6 / 112.3 | +2.6% [+2.5, +2.8] | -24.4% [-24.8, -24.1] | 420.6 |
| 16 | 4096 | match-count | middle | ymm-dirty | 148.9 / 176.1 / 153.7 / 113.6 | +3.1% [+3.0, +3.2] | -23.5% [-24.1, -23.3] | 436.6 |
| 16 | 4096 | repeat8-copy | equal | clean | 132.6 / 156.4 / 162.5 / 159.8 | +22.7% [+21.4, +24.6] | +20.5% [+17.9, +23.8] | 364.3 |
| 16 | 4096 | repeat8-copy | equal | sse-dirty | 131.6 / 157.0 / 162.0 / 158.8 | +21.8% [+21.3, +24.7] | +22.1% [+19.7, +27.1] | 425.5 |
| 16 | 4096 | repeat8-copy | equal | ymm-dirty | 132.6 / 157.9 / 163.0 / 159.7 | +21.8% [+21.8, +25.5] | +20.9% [+19.5, +23.6] | 402.0 |
