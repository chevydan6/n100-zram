# Scalar LZ4 physical multitasking pilot

| Codec | Workload s | Browser median s | Package J | Peak cgroup swap MiB | Sampled device allocation MiB | Scheduler p95 lateness ms | Paired work/browser/energy vs matched control |
|---|---:|---:|---:|---:|---:|---:|---:|
| lz4-small | 7.628 | 1.821 | 48.70 | 152.6 | 73.8 | 0.718 | +0.4% / +0.4% / -1.3% |
| lz4-control | 7.573 | 1.813 | 48.53 | 152.1 | 71.4 | 0.732 | +0.0% / +0.0% / +0.0% |
| lz4 | 7.611 | 1.844 | 49.26 | 154.1 | 73.8 | 1.018 | +2.0% / +2.8% / +0.8% |
| zstd | 7.883 | 1.916 | 50.72 | 154.8 | 63.2 | 0.604 | +4.1% / +3.4% / +6.9% |
