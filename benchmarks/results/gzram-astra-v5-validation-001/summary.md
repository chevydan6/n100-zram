# Direct packing loops: fifth userspace correctness checkpoint

Three additive policies, blockdirect2/3/4, choose a direct scalar or AVX2 block
helper once per block. Their corresponding blockpick controls retain the
indirect per-group call. Cutoffs and formats remain unchanged; no queue,
inter-page dictionary or batch is introduced. No default policy changes.

Normal and AddressSanitizer/UBSan builds both passed the full 569-variant,
20-corpus, 128-page registry (1,456,640 round trips per build). Each new policy
also passed 39,424 cross-path round trips, 39,376 guarded capacity cases,
72 aggregate cutoff boundary pages, 71,680 independent mask checks,
48,576 repeat boundary checks, 80,000 malformed/mutated decode cases and
4,000 threaded round trips per build. Reverse cross-decoding through the old
wordmixed encoder also passed. Independent decoding uses the Python GZR1
wire oracle and system liblz4 for LZ4 payloads.

All 35 existing library text sections match the fourth build. All twenty
corpus hashes and 317,440 preceding per-page size/mode records are preserved.
The enlarged size matrix contains 348,160 records; the new policies match
wordmixed sizes at both screened block sizes and both ISAs. Logs, source hashes,
compiler definitions, object disassembly and object-section sizes are retained.

These are userspace correctness and format-preservation results, not timing,
energy, kernel, ZRAM or production evidence. All earlier controls and failures
remain available. Physical measurements must decide whether direct loops help
and account for code size, inlining and vector-transition changes. The next
cohort retains all twenty corpora, including workloads where preceding cutoff
choices lost. Kernel FPU state costs and queued/batched scheduling are excluded.
