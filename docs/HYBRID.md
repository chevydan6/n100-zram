# Hybrid scalar / AVX2 investigation

Status: proposed experiment, not an implemented or validated selection policy.
Both scalar and AVX2 codec implementations already exist. Current kernel dispatch
uses AVX2 for every eligible 4 KiB page; its fallback checks safety, not profit.

The first hybrid candidate keeps decompression scalar and uses a smaller,
fully reset compression table. Scalar and AVX2 emit standard LZ4 blocks, so a
scalar decoder needs no metadata indicating which compressor produced a block.
A smaller table changes compressed bytes/ratio and requires private workspace
layout, consistent hash parameters, and independent validation.

AVX2 selection must pay for page classification, dispatch and FPU state handling.
The matched user-space 4 KiB-table measurements show roughly 352 ns saved for
periodic pages, 246 ns for half-zero pages, 69 ns for mixed pages, and no material
saving for random pages. These are differences of aggregate medians, not native
kernel predictions. Earlier native scalar/FPU controls showed about 435 ns of
state-management overhead in their tested context. Comparing these different
measurement scopes cannot establish a universal threshold; it does warn that
choosing AVX2 for an entire apparently compressible page may still lose.

Prefer a cheap signal already encountered in scalar match searching over a new
full-page prepass. Investigate delayed SIMD entry only after enough long-match
work remains to amortize entry. Do not bracket every vector comparison or match
copy separately. If no robust break-even exists on 4 KiB pages, retain scalar.
Do not batch unrelated swap requests merely to create favorable SIMD timings.

Required comparisons on physical N100:

1. Matched small-table scalar baseline, unconditional AVX2, and hybrid candidate.
2. Charge classifier and FPU costs inside the timed kernel call; include clean,
   SSE-dirty and YMM-dirty caller states, concurrent tasks and fallback contexts.
3. Retain all corpora, compressed sizes and regressions; use held-out generated
   patterns rather than recognizing benchmark corpus identities.
4. Verify format interoperability, bounded accesses, malformed-input handling,
   all FPU exit paths, scalar fallback and concurrency before experimental ZRAM.
5. Require repeatable native swap/I/O, memory-pressure, CPU and energy results
   before accepting any policy or changing a production default.

An unsafe SIMD context must select scalar regardless of the profit estimate.
No zero-page scan should be added without checking ZRAM's existing same-element
page handling. Existing negative AVX2 decompression results remain evidence
against unconditional vector decoding; small-table user-space gains do not
invalidate them. Tested software recovery does not guarantee arbitrary hangs.
