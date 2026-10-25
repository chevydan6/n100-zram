# Fixed-window scalar CPU-availability comparison

Five paired trials per corpus/backend; bootstrap median trial ratios 10,000 times.
Lower pressure completion/energy is favorable; higher application throughput is favorable.
Energy covers the fixed application observation, both workloads and startup/background.
This is controlled CPU contention, not interactive responsiveness or whole-laptop energy.
All trials and frequency/background variation are retained. No general application gain is selected.

| Corpus | Metric | 8 KiB vs 16 KiB change [95% paired bootstrap] |
|---|---|---:|
| mixed-pages | pressure completion | -3.74% [-6.04, -1.53] |
| mixed-pages | application throughput | +2.08% [-0.10, +4.44] |
| mixed-pages | package energy | +2.04% [-0.17, +6.50] |
| period-tail | pressure completion | -2.54% [-2.94, -0.89] |
| period-tail | application throughput | +0.68% [-0.14, +1.06] |
| period-tail | package energy | +0.01% [-0.12, +0.34] |

Application-throughput intervals span zero on these corpora; a repeatable CPU-capacity gain is not established.
This does not negate the measured pressure completion changes; it limits what they demonstrate.
