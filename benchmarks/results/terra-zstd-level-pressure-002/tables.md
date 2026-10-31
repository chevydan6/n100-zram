# Zstd level pressure comparison

| Codec | Workload s | Browser interaction ms | Compile ms | Package J | Cgroup swap MiB | Sampled allocation MiB | Paired work/interaction/energy vs default |
|---|---:|---:|---:|---:|---:|---:|---:|
| zstd-default | 24.532 | 1.196 | 224.5 | 67.01 | 189.0 | 71.4 | +0.0% / +0.0% / +0.0% |
| zstd-2 | 24.516 | 1.226 | 222.6 | 62.82 | 191.7 | 72.4 | -0.1% / +4.1% / -4.6% |
| lz4 | 24.124 | 1.185 | 211.1 | 60.52 | 190.4 | 86.4 | -1.6% / -3.3% / -8.8% |
