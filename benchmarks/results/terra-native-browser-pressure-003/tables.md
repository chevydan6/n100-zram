# Browser-pressure trial summary

Medians of eight trials per codec; paired changes compare the same randomized round.

| Codec | Workload s | Browser launch median s | Package energy J | Peak cgroup swap MiB | Sampled peak device allocation MiB | Workload/browser/energy vs LZ4 |
|---|---:|---:|---:|---:|---:|---:|
| ghy-bitdirect | 2.825 | 1.251 | 19.88 | 71.4 | 36.6 | +2.9% / +4.2% / +7.8% |
| lz4 | 2.634 | 1.125 | 20.19 | 69.6 | 36.3 | +0.0% / +0.0% / +0.0% |
| zstd | 3.096 | 1.343 | 21.26 | 71.9 | 32.4 | +10.8% / +13.5% / +12.1% |
| lzo-rle | 2.615 | 1.139 | 18.84 | 72.6 | 36.2 | +0.0% / -0.0% / +1.1% |
