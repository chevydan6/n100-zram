# Compressed-size reporting correction

The measured harness failed to clear each variant's aggregate compressed-byte
total between corpora. The `compressed_bytes` field in the raw CSVs is therefore
cumulative, and must not be interpreted as page size after the first corpus.
The source at measurement commit aa6d103 and raw CSVs remain preserved. Codec
frames, return checks, task timing, CPU counters and energy do not use that total.

In paired.json, `compressed_bytes_cumulative_raw` preserves the raw statistics.
The corrected `compressed_bytes` subtracts the preceding corpus cumulative total
for the same variant, operation, session and round; sizes were constant across
rounds. A fixed-harness 128-call smoke test on random and Bash executable pages
reproduced the recovered table14/table12 sizes within 0.01 bytes/page. This smoke
is a correctness check, not a performance result. The source now resets totals
before every corpus; future runs should use that fixed version.

The first attempt to use the GZRAM-specific summary script failed because it
expects a GZRAM-named control. Its partial output is preserved in the sibling
`native-lz4-scalar-random-energy-001-summary-failed` directory. The original
measurement and its audit were unaffected; paired.json was calculated with the
actual table14 scalar control.
