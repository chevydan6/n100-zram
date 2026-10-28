# Sixth correctness checkpoint: sampled bitdirect selection

Two additive policies combine the existing guarded bitdirect codec with 16/64
sampled words and SOL's fixed-repeat prefix shortcut. They omit SOL recurrence's
upfront memmem search; the existing post-encode guard remains. No wire-format,
decoder, cross-page state, queue, default compressor or kernel behavior changes.

Both normal and ASan/UBSan builds passed all 15 validation stages. The complete
601-variant registry covered 26 corpora and 128 pages per corpus: 2,000,128 round
trips per build. Each new sampler additionally passed 82,176 cross-path round
trips, 54,736 protected capacity cases, 312 sampling-boundary pages, 840 direct
repeat header mutations, 62 repeat-merge cases, 72,864 repeat boundary checks,
107,520 independent mask checks, 120,000 malformed/mutated decode cases and
4,000 four-thread round trips per build. Old decoders decode new frames and the
old wordmixed encoder was checked against both new decoders. Independent Python
wire and system liblz4 oracles remain in use.

All 38 preceding library text sections match. Every one of the twenty old corpus
hashes and 348,160 old size/mode records is preserved. The enlarged matrix has
479,232 independent size/decode records. Four new synthetic inputs deliberately
mislead fixed-position sampling; two additional ELF inputs contain the first
512 KiB of /usr/bin/git and /usr/lib64/libc.so.6, including headers/data. These
are file-page fixtures, not resident application snapshots or workload weights.

The size tradeoffs are retained in sampling-size-changes.json in the size report:

- Both samplers enlarge every sample64-sparse-miss page: mean 404 → 521.875 bytes,
  +29.17698%. This disqualifies a blanket size-preservation claim.
- Sample16 improves every sample16-sparse-miss page: 212 → 143.453125 bytes,
  -32.33343%; sample64 retains 212 bytes. Routing to LZ4 can help or hurt.
- Sample16 enlarges one of 128 clusters75 pages by 47 bytes, raising the mean
  from 3237.2421875 to 3237.609375 bytes (+0.01134%). Sample64 preserves it.
- All remaining original corpus sizes and both new ELF corpus sizes match
  bitdirect at the compared scalar 1024-byte setting. Other sizes/ISAs remain
  fully recorded; this is not a general sampling-ratio guarantee.

Timing, CPU/PMU and energy consequences require matched physical measurements.
The planned cohort retains both SOL sample/recurrence controls and bitdirect,
wordmixed, blockdirect2 and LZ4. No default promotion follows from correctness.
The observed aligned sparse loss motivates testing less alignment-sensitive
sample positions, preserving these static-position controls and their failures.
