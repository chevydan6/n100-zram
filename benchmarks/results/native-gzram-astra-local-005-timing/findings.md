# Fifth physical cohort: direct block packing helps, composition still needed

This is a completed physical Intel N100 userspace timing cohort, not a kernel
or ZRAM measurement. All 22,680 rows passed the audit: 21 variants, 20 corpora,
three sessions, nine recorded rounds plus two warmups and 8,192 calls per batch.
Source checkpoint de6e0fa, GCC 16 build flags and exact artifacts are recorded.
Kernel 7.2.11, powersave and the existing 700–800 MHz cap were preserved. Codec
work ran on CPU 0; the collector ran on CPU 1, serialized by the native lock.

All PMU groups ran at fraction 1. Thread occupancy ranged 82.759–99.976%, median
99.347%. Elapsed time was 1,530.953 seconds, with maximum telemetry gap 0.5492 s.
CPU/ZRAM setting hashes and artifacts match. Package energy is unavailable in
all rows. Integrated battery telemetry is approximately 4,986.84 J (1.39 Wh) for
the entire experiment, including validation, warmups and unrelated laptop work;
it is not attributable to a codec or evidence of an energy improvement.

## Compression gains and retained losses

Direct scalar/vector block loops improve AVX2 compression versus the old
blockpick loops with the same cutoff. For cutoff 2, sparse words improve 8.12%,
words25 7.39%, words50 10.01%, clusters25 15.70% and clusters50 19.70%. Each of
these improvements has the same sign in all three sessions, with matching CPU
time reductions. All encoded bytes are identical to those controls.

Against matched wordmixed, cutoff 2 gives:

| Corpus | Wordmixed → blockdirect2 ns/page | Paired wall-time change | Paired CPU-time change |
|---|---:|---:|---:|
| Sparse words | 5960.9 → 4826.5 | -18.95% | -18.95% |
| Words25 | 5942.5 → 5628.7 | -5.45% | -5.41% |
| Words50 | 5782.9 → 5333.6 | -7.76% | -7.82% |
| Clusters25 | 3343.3 → 3079.6 | -7.86% | -7.86% |
| Clusters50 | 4411.4 → 3762.4 | -14.94% | -14.93% |
| Mixed pages | 14714.4 → 14385.7 | -2.10% | -2.09% |

Absolute times are pooled medians; percentages are medians of paired-session
changes, so their ratios need not agree. Session ranges are descriptive, not
confidence bounds for arbitrary application workloads. All 5,480 direct contrasts
are retained in paired.json/paired.md, including unchanged paths and losses.

Cutoff 3 also improves sparse words 19.52%, words25 3.50%, words50 7.88% and
clusters50 14.32% against wordmixed, but adds 0.78% half-zero compression time
in all sessions. Cutoff 4 improves sparse words 18.72% but regresses words50
3.40% in all sessions. It is not selected as the general replacement.

Unconditional mixpack remains faster than blockdirect2 on sparse words by a
paired 1.65% and words25 by 1.58% (both losses in all sessions). Blockdirect2
instead improves words50 18.29% and clusters50 9.52% against mixpack. No single
cutoff or scalar/vector packing policy wins across all these distributions.

The LZ4 comparisons remain mixed. Blockdirect2's AVX2 compression is 71.6%
faster on sparse words, but 5.9% slower on bash ELF, 52.1% slower on random and
65.9% slower on period127. Corresponding mean bytes are 660.844 versus LZ4's
1081.359 for sparse words, 3250.602 versus 3242.602 for bash, 4104 versus 4114
for random (both expanded), and 161 versus 153 for period127. Full LZ4 controls,
absolute results and all decode/size regressions remain in summary.md.

## These encoding candidates are not the best combined codecs

Blockdirect2 retains wordmixed's decoder and unconsolidated repeated frames.
Relative to bitdirect's scalar entry, it decodes sparse pages 52.16% slower,
words25 103.46% slower, words50 164.82% slower and mixed pages 16.00% slower.
Repeat16/32 bytes grow from 33/49 to 84/148, and scalar decoding is 460.25%/
105.68% slower. The AVX2 entries also lose 39.61%, 85.40% and 140.24% on sparse,
words25 and words50 decoding, respectively. These regressions disqualify a
blanket switch to blockdirect2 despite its improved encoder.

Even against wordmixed's same decoder design, small decode differences remain:
blockdirect2 scalar clusters25 +1.53%, clusters50 +0.60%, sparse +0.48% and
words50 +0.31%; AVX2 clusters25 +0.82%, clusters50 +0.47%, clusters75 +0.97%
and word-tail64 +1.07%. All have positive session signs. Code layout and sampling
variation may matter; no cause is established and these are not erased as noise.

## Interpretation and next experiments

Disassembly confirms separate direct packing loops. Object .text grows from
7,826 to 8,082 bytes (+256, 3.27%) for each cutoff. The vector loop still includes
vzeroupper and a direct copy call for partial masks. The experiment changes
inlining, calls and layout together; it does not isolate the indirect branch as
the sole cause, eliminate kernel FPU costs or establish cold-cache behavior.

Cutoffs 2/3 are promising encoder components to compose with the preserved CTZ
and direct-repeat decoder, retaining bitdirect and blockdirect controls. That
composition has not been implemented or measured in this cohort. Separately,
upfront sampled selection may avoid rejected GZRAM work on dense pages, but
requires adversarial sampling cases, ratio accounting and full-domain controls.
No new default, workload-weighted gain, energy win, kernel crossover, queueing
policy, native ZRAM improvement or production readiness is accepted here.
