# Physical multitasking swap pilot

| Codec | Workload s | Browser median s | Package J | Peak cgroup swap MiB | Sampled device allocation MiB | Scheduler p95 lateness ms | Paired work/browser/energy vs LZ4 |
|---|---:|---:|---:|---:|---:|---:|---:|
| ghy-bitdirect | 7.605 | 1.822 | 48.62 | 153.9 | 71.7 | 0.608 | +1.4% / +1.5% / +0.3% |
| lz4 | 7.566 | 1.804 | 48.12 | 146.7 | 70.8 | 0.664 | +0.0% / +0.0% / +0.0% |
| zstd | 8.206 | 1.956 | 51.89 | 156.5 | 63.7 | 0.969 | +8.3% / +8.1% / +7.6% |
| lzo-rle | 7.653 | 1.816 | 48.31 | 146.0 | 70.2 | 0.876 | +0.8% / +0.1% / +0.6% |
