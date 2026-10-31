# ZSTD level physical direct-device screen

Times are µs/page; package energy is mJ/MiB. Paired percentages compare same-round zstd default.

### bash-elf

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 38.501/9.793 | 61.790/15.468 | 336038/585728 | +0.0%/+0.0% |
| zstd-1 | 27.467/9.064 | 43.562/14.097 | 345398/647168 | -28.5%/-7.6% |
| zstd-2 | 30.028/10.150 | 46.075/15.777 | 337623/585728 | -22.8%/+3.0% |
| zstd-3 | 36.908/9.956 | 60.126/15.029 | 336038/585728 | -4.1%/+1.4% |
| lz4 | 11.144/1.989 | 16.281/3.199 | 411719/667648 | -71.1%/-79.6% |

### clusters50

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 22.367/1.735 | 36.417/2.675 | 279728/593920 | +0.0%/+0.0% |
| zstd-1 | 18.024/1.659 | 29.906/2.583 | 280387/561152 | -21.2%/-4.4% |
| zstd-2 | 18.379/1.690 | 29.761/2.530 | 280422/589824 | -19.0%/-1.8% |
| zstd-3 | 22.904/1.750 | 36.057/2.727 | 279728/593920 | +0.9%/+0.8% |
| lz4 | 4.615/1.179 | 7.021/2.045 | 290911/557056 | -79.2%/-31.7% |

### libc-elf

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 36.660/9.657 | 57.766/15.072 | 320878/630784 | +0.0%/+0.0% |
| zstd-1 | 27.999/8.896 | 43.518/14.709 | 328907/614400 | -23.6%/-8.5% |
| zstd-2 | 30.399/9.744 | 47.920/15.729 | 322550/618496 | -18.6%/+0.8% |
| zstd-3 | 35.941/9.804 | 57.562/15.310 | 320878/630784 | -0.7%/+0.9% |
| lz4 | 10.830/1.981 | 16.637/3.207 | 394428/585728 | -70.1%/-79.6% |

### mixed-pages

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 17.316/4.157 | 27.187/6.517 | 246150/667648 | +0.0%/+0.0% |
| zstd-1 | 13.758/4.186 | 22.050/6.588 | 249655/737280 | -19.1%/+0.5% |
| zstd-2 | 14.046/4.153 | 22.384/6.352 | 247875/716800 | -18.2%/-0.1% |
| zstd-3 | 17.772/4.194 | 27.683/6.487 | 246150/667648 | +1.6%/+0.9% |
| lz4 | 4.874/1.301 | 7.319/2.049 | 274760/651264 | -71.4%/-69.2% |

### period127

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 3.404/0.526 | 5.048/0.849 | 18816/40960 | +0.0%/+0.0% |
| zstd-1 | 3.252/0.529 | 4.765/0.865 | 18816/40960 | -4.7%/+0.3% |
| zstd-2 | 3.098/0.529 | 4.678/0.877 | 18816/40960 | -5.8%/+0.6% |
| zstd-3 | 3.471/0.530 | 5.045/0.843 | 18816/40960 | +0.3%/+0.4% |
| lz4 | 1.573/0.448 | 2.274/0.723 | 19584/32768 | -54.5%/-14.1% |

### random

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 8.196/0.344 | 13.135/0.532 | 524288/524288 | +0.0%/+0.0% |
| zstd-1 | 5.992/0.348 | 9.497/0.531 | 524288/524288 | -26.9%/+1.1% |
| zstd-2 | 5.943/0.347 | 9.272/0.527 | 524288/524288 | -27.3%/+0.9% |
| zstd-3 | 8.121/0.348 | 12.884/0.517 | 524288/524288 | -2.2%/-0.2% |
| lz4 | 2.156/0.348 | 3.306/0.542 | 524288/524288 | -73.5%/+0.9% |

### repeat8

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 0.380/0.253 | 0.591/0.396 | 0/0 | +0.0%/+0.0% |
| zstd-1 | 0.375/0.255 | 0.596/0.388 | 0/0 | -0.4%/+0.5% |
| zstd-2 | 0.400/0.254 | 0.594/0.404 | 0/0 | +5.1%/+1.2% |
| zstd-3 | 0.391/0.256 | 0.594/0.404 | 0/0 | -0.3%/+0.3% |
| lz4 | 0.397/0.253 | 0.597/0.401 | 0/0 | +0.9%/+0.1% |

### sparse-words

| Codec | Write/read µs per page | Write/read package mJ/MiB | Compressed/allocated bytes | Paired write/read vs default |
|---|---:|---:|---:|---:|
| zstd-default | 19.399/4.939 | 29.596/7.673 | 103498/425984 | +0.0%/+0.0% |
| zstd-1 | 17.585/6.089 | 26.268/9.470 | 107515/454656 | -10.7%/+23.4% |
| zstd-2 | 17.522/5.257 | 25.636/8.390 | 107602/454656 | -12.4%/+5.8% |
| zstd-3 | 18.971/5.045 | 29.622/7.801 | 103498/425984 | -0.0%/+1.6% |
| lz4 | 4.940/2.134 | 7.434/3.288 | 138194/524288 | -73.3%/-57.4% |
