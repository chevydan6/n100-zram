# Bounded-trial correctness checkpoint

Three additive policies bound tentative GZRAM output at the existing 75% size
acceptance threshold: bitdirectbounded, bitdirectblock2avxbits4bounded and
bitdirectblock3avxbits4bounded. LZ4 capacity is unchanged. Accepted repeat frames
remain compact; pages remain independent, with no intended format change.

Normal and ASan/UBSan builds each passed 825 variants × 26 corpora × 128 pages
(2,745,600 registered round trips). Each dedicated candidate test also checks
independent masks, old decoding, guarded capacities, malformed/truncated input,
repeat boundaries and four-thread concurrency. Extra dense-leading and short
repeat cases cover the bounded trial and repeat-merging assumptions. Plain
bitdirectbounded passed 88,640 cross-path round trips; each grouped combination
passed 118,208, including 72 cutoff and 390 scanner-pipeline fixtures.

All 625,664 previous size/mode records and 26 corpus hashes are unchanged;
39,936 new records match the corresponding parent. All 51 previous library
text sections are unchanged. Normal and sanitized isolated benchmark validation
passed for the 16-entry measurement cohort, including shared-decoder aliases
and exact-entry negative controls. Smoke timing only validates bookkeeping;
it is not performance evidence.

The first validation attempt hit a Python fixture variable collision after
successful compilation. Its source, traceback and partial results remain in
../gzram-astra-v9-validation-001-failed/. The corrected attempt reused only
hash-verified normal binaries, then repeated complete validation. No failed
attempt is relabeled successful.

Physical timing and package-energy measurement remain pending. Rejected-output
work is the target; fewer operations do not establish faster execution, lower
energy, or better ZRAM behavior.
