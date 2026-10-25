# Matched scalar CPU-contention comparison

Five trials per corpus/backend. Paired trial IDs; 10,000 seeded bootstrap resamples of median ratios.
These descriptive intervals cover this experiment, not general application acceptance.
SHA256 is a controlled CPU competitor, not interactive responsiveness. Package energy includes both workloads.

| Corpus | Metric | 8 KiB vs 16 KiB change [95% paired bootstrap] |
|---|---|---:|
| mixed-pages | pressure elapsed | -4.92% [-5.53, -1.47] |
| mixed-pages | package energy | +0.20% [-2.03, +5.57] |
| mixed-pages | competing SHA256 throughput | +3.26% [-0.42, +4.37] |
| period-tail | pressure elapsed | -2.73% [-3.06, -2.10] |
| period-tail | package energy | -3.19% [-3.24, -1.97] |
| period-tail | competing SHA256 throughput | +0.12% [-0.85, +0.28] |

Lower elapsed/energy is favorable; higher competing throughput is favorable.
Retain startup/tails and frequency/background variability rather than excluding individual trials.
Every trial passed three full byte-verification passes, register checks, no-OOM checks and stock restoration.
