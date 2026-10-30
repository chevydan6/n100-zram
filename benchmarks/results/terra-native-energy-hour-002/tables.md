# Sustained physical ZRAM energy comparison

Medians across 18 matched rounds (nine per independently shuffled run). Time is microseconds per page; energy is package mJ per MiB. Percentages are medians of same-round candidate/LZ4 changes. Package energy includes unrelated work.

### bash-elf

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 10.512/1.924 | 16.192/2.953 | 700416 | +5.3%/+1.7% | +5.7%/+1.7% |
| ghy-simd | 10.409/1.919 | 15.951/2.948 | 700416 | +4.3%/+2.0% | +3.7%/+2.0% |
| lz4-ghy | 9.599/1.907 | 14.760/2.926 | 733184 | -3.7%/+1.3% | -3.4%/+1.1% |
| lz4 | 9.938/1.891 | 15.316/2.901 | 667648 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 35.102/9.474 | 54.295/14.342 | 585728 | +253.0%/+401.2% | +252.3%/+394.3% |
| lzo-rle | 11.380/3.468 | 17.427/5.312 | 675840 | +14.7%/+83.3% | +13.1%/+83.8% |

### clusters50

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 1.829/1.322 | 2.840/2.038 | 520192 | -57.9%/+17.3% | -57.8%/+18.5% |
| ghy-simd | 1.638/2.133 | 2.518/3.232 | 520192 | -62.4%/+90.0% | -62.7%/+87.8% |
| lz4-ghy | 4.066/1.130 | 6.246/1.735 | 557056 | -6.5%/+0.2% | -7.2%/+0.2% |
| lz4 | 4.349/1.124 | 6.720/1.723 | 557056 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 21.317/1.631 | 33.366/2.471 | 593920 | +390.5%/+44.5% | +396.3%/+42.7% |
| lzo-rle | 4.990/1.230 | 7.670/1.884 | 536576 | +14.5%/+9.6% | +14.2%/+9.3% |

### libc-elf

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 10.501/1.901 | 16.164/2.922 | 606208 | +6.2%/+0.7% | +6.1%/+0.6% |
| ghy-simd | 10.360/1.904 | 15.966/2.912 | 606208 | +4.6%/+0.9% | +4.4%/+0.8% |
| lz4-ghy | 9.591/1.891 | 14.729/2.902 | 618496 | -3.1%/+0.3% | -2.8%/-0.2% |
| lz4 | 9.899/1.880 | 15.251/2.903 | 585728 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 34.388/9.352 | 53.505/14.156 | 630784 | +247.4%/+398.0% | +253.2%/+388.8% |
| lzo-rle | 11.587/3.654 | 17.650/5.592 | 712704 | +17.3%/+94.3% | +15.9%/+93.8% |

### mixed-pages

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 4.100/1.019 | 6.317/1.563 | 606208 | -9.9%/-16.1% | -9.9%/-15.9% |
| ghy-simd | 3.910/1.216 | 6.030/1.844 | 614400 | -14.0%/+0.2% | -14.0%/-1.0% |
| lz4-ghy | 4.210/1.213 | 6.540/1.864 | 655360 | -7.4%/-0.1% | -7.6%/-0.1% |
| lz4 | 4.544/1.213 | 7.023/1.862 | 651264 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 16.183/3.962 | 25.363/5.999 | 667648 | +255.7%/+225.9% | +262.2%/+222.1% |
| lzo-rle | 4.678/1.584 | 7.132/2.447 | 618496 | +3.0%/+30.8% | +1.7%/+30.6% |

### period127

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 1.947/0.430 | 2.951/0.675 | 32768 | +40.0%/+0.9% | +38.0%/+1.5% |
| ghy-simd | 1.763/0.430 | 2.693/0.672 | 32768 | +26.3%/+1.1% | +28.3%/+0.9% |
| lz4-ghy | 1.147/0.426 | 1.734/0.670 | 32768 | -17.7%/-0.7% | -17.9%/+0.3% |
| lz4 | 1.390/0.427 | 2.136/0.668 | 32768 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 3.102/0.504 | 4.720/0.777 | 40960 | +121.8%/+18.1% | +123.2%/+16.5% |
| lzo-rle | 1.101/4.881 | 1.673/7.280 | 36864 | -20.9%/+1046.4% | -20.8%/+983.5% |

### random

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 2.606/0.319 | 4.004/0.490 | 524288 | +29.9%/-0.7% | +30.2%/-0.8% |
| ghy-simd | 2.420/0.319 | 3.703/0.491 | 524288 | +20.8%/-0.1% | +20.6%/-0.3% |
| lz4-ghy | 1.725/0.318 | 2.650/0.489 | 524288 | -14.2%/+0.3% | -14.2%/+0.1% |
| lz4 | 1.996/0.321 | 3.065/0.493 | 524288 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 7.579/0.323 | 11.765/0.488 | 524288 | +278.6%/+0.3% | +282.2%/-1.4% |
| lzo-rle | 1.991/0.322 | 3.055/0.497 | 524288 | -0.5%/+0.2% | -1.2%/+0.3% |

### repeat8

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 0.357/0.242 | 0.555/0.372 | 0 | -0.1%/-0.4% | +0.4%/-0.3% |
| ghy-simd | 0.360/0.243 | 0.554/0.373 | 0 | +0.3%/+0.0% | +1.0%/-0.3% |
| lz4-ghy | 0.359/0.243 | 0.554/0.374 | 0 | +0.0%/-0.1% | +0.1%/-0.1% |
| lz4 | 0.361/0.243 | 0.552/0.374 | 0 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 0.361/0.244 | 0.556/0.374 | 0 | +0.0%/+0.3% | -0.1%/+0.4% |
| lzo-rle | 0.361/0.243 | 0.556/0.373 | 0 | +0.1%/-0.2% | -0.2%/-0.2% |

### sparse-words

| Codec | Write/read µs per page | Write/read package mJ per MiB | Allocated bytes | Paired time change vs LZ4 | Paired package energy change vs LZ4 |
|---|---:|---:|---:|---:|---:|
| ghy-bitdirect | 1.795/1.129 | 2.767/1.736 | 286720 | -60.5%/-44.1% | -60.7%/-44.2% |
| ghy-simd | 1.560/1.909 | 2.428/2.904 | 286720 | -65.9%/-4.8% | -65.8%/-6.4% |
| lz4-ghy | 4.277/1.975 | 6.592/3.038 | 495616 | -6.3%/-1.8% | -6.7%/-1.8% |
| lz4 | 4.566/2.009 | 7.025/3.099 | 524288 | +0.0%/+0.0% | +0.0%/+0.0% |
| zstd | 17.949/4.737 | 27.893/7.276 | 425984 | +293.8%/+136.1% | +297.2%/+134.6% |
| lzo-rle | 4.357/2.515 | 6.694/3.836 | 499712 | -4.8%/+24.8% | -5.6%/+23.4% |
