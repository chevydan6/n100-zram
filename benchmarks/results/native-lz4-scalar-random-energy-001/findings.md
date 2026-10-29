# Randomized scalar LZ4 package-energy screen

The physical N100 ran three sessions with nine shuffled rounds per corpus,
128 independent pages and 8,192 calls per batch. All four table sizes use a
common decoder entry; encoder and decoder tasks were randomized independently.
Three executable file-page sets plus random, period127, sparse words and mixed
pages were tested. The audit passed all 1,512 rows, library hashes and exact
preflight/restoration checks. CPU package energy was available for every row,
all PMU groups were fully scheduled, max telemetry gap was 0.535 s, and median
thread occupancy was 99.50% (minimum 95.79%). The system was on battery with
700–800 MHz CPU limits. No experimental host module or configuration change was
requested by this userspace run.

The measured harness accumulated its reported compressed-byte totals across
corpora; corrected sizes in paired.json subtract the prior corpus for the same
variant and round and were checked against a fixed-harness smoke test. Raw CSVs
are untouched. See size-recovery.md. Timing and energy loops do not use the
aggregate byte total. Package energy includes shared/background package activity
and benchmark bookkeeping; it is not whole-laptop energy or battery life.

| Corpus | 4 KiB vs 16 KiB compression time | Package energy | 16 KiB → 4 KiB bytes/page |
|---|---:|---:|---:|
| Bash executable | −3.55% | −3.09% | 3,239.09 → 3,266.32 |
| Git executable | −3.29% | −3.83% | 3,207.45 → 3,234.09 |
| libc executable | −2.81% | −3.15% | 2,982.82 → 3,004.23 |
| Mixed pages | −6.58% | −5.28% | 2,151.06 → 2,157.41 |
| Period127 | −24.31% | −24.89% | 153 → 153 |
| Random | −18.33% | −15.50% | 4,114 → 4,114 |
| Sparse words | −6.05% | −6.17% | 1,079.64 → 1,081.36 |

Percentages are medians of the three session medians of paired round ratios;
all three session energy changes for these compression comparisons were negative.
These are time reductions, not throughput increases. Full 8, 4 and 2 KiB results,
CPU time, cycles, session variation, decompression and raw rows remain available.
The common decoder and identical-address setup reduce entry-layout ambiguity,
but differing compressed streams can affect decoding. Executable fixtures are
file-backed pages, not a representative memory-reclaim mix. Native ZRAM behavior,
allocator-rounded memory, responsiveness and stability are unproven.
