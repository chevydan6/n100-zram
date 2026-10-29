# Fresh matched scalar LZ4 table-size screen

On the physical N100 at approximately 800 MHz, the 4 KiB table reduced median
compression time versus its 16 KiB matched private-API control: random 5,080.2
→ 4,146.9 ns/page (−18.4%); period127 3,985.5 → 2,983.6 ns/page (−25.0%);
mixed 12,462.9 → 11,950.5 ns/page (−4.1%); Bash executable pages 39,414.6 →
38,092.6 ns/page (−3.4%). Random and period output sizes matched; mixed fell
0.16%, while Bash rose from 3,216.6 to 3,242.6 bytes/page (+0.81%).

The 8 KiB table reduced Bash time 2.1% with a 0.24% size increase, a potentially
useful tradeoff to evaluate alongside 4 KiB. The 2 KiB table reduced Bash time
5.2% but increased its output 1.95%. All eight corpora, scalar and vector controls,
individual rounds, compressed bytes, cycles and unchanged decoder observations
remain in summary.md and the raw CSVs. No overall workload weighting is implied.

Audit verified 8,064 rows and current binary/library hashes. Three sessions had
21 rounds each, 128 pages per corpus, 8,192 calls per batch; CPU0 telemetry was
799.872–800.064 MHz, powersave, and max sample gap was 1.031 s. The launcher
recorded battery at 98% and AC offline. Task order was fixed; per-batch CPU
occupancy and PMU scheduling fraction were not recorded. Session bootstrap
intervals based on only three sessions are descriptive, not a reliability proof.

These are warm-cache userspace measurements on kernel 7.2.11-200.fc44, not
native ZRAM, application responsiveness, CPU package energy or battery life.
There was no dedicated ZRAM preflight record. Scalar candidates passed normal
and sanitizer correctness gates; kernel integration and recovery are not yet
revalidated on the current machine. The next experiment should randomize task
order, add diverse executable pages and measure matched package energy, then
progress through exact-kernel and representative pressure comparisons against
current stock zstd, LZ4 and lzo-rle before considering routine use.
