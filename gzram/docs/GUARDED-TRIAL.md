# Guarded trial: preserve the strongest GZRAM path

The first native screen is preserved on feature/n100-gzram-avx2 under
benchmarks/results/native-gzram-hybrid-screen-001. Trial GHY1 kept half-zero
encoding close to original GZRAM (345.1 versus 333.1 ns pooled medians; +0.74%
by the paired-session-ratio estimator). Its simple ratio gate misses much better
LZ4 ratios on mixed repeating-prefix pages. Up-front recurrence classification
recovers those ratios but imposes about 68% half-zero encoding overhead.
These distinct estimators/scopes and every losing case remain published.

This isolated branch tests two additional GHY1 encoder policies without changing
decoder semantics or the earlier run:

1. Try the existing fast GZRAM implementation directly into the output payload.
2. Accept frames at most one quarter of original size without prefix searching.
3. For frames between one quarter and three quarters, check for an eight-byte
   prefix recurrence at candidate distances 1..min(1024, input_length-8).
4. A detected recurrence routes to scalar LZ4; otherwise accept GZRAM.
5. Frames larger than three quarters follow the original LZ4/raw fallback.

For a nonzero prefix, choose its first nonzero byte as the vector filter anchor.
This avoids producing mostly-set comparison masks while searching zero-heavy
data. Check the complete eight-byte key before selecting LZ4. This is codec
classification, not a claim that the remaining page repeats; the selected codec
must still preserve the complete input exactly.

Separate guard16 and guard32 libraries use SSE2 and AVX2 filters respectively
when called through the AVX2 GZRAM path on a supported CPU. Scalar entry points
use an independent scalar filter. Vector loads cover only complete bounded
candidate groups, including the anchor offset; scalar tails handle the remainder.
An all-zero prefix skips this heuristic. False positives/negatives can affect
latency or ratio and must be retained. The classifier does not define correctness.

Local disassembly confirms PCMPEQB/PMOVMSKB and VPCMPEQB/VPMOVMSKB. Both
libraries passed 14,624 guarded round trips, 29,200 capacity cases, 40,000
malformed/mutated decodes and 4,000 four-thread round trips, plus ASan/UBSan.
Tests cover all eight anchor positions, odd/short lengths, the final 1024-byte
candidate and cross-policy decoding. The GHY1 safe LZ4 decoder handles internal
overlapping matches; no new match-copy implementation is introduced here.

The native screen retains the previous 19 controls/policies and adds eight
scalar/SSE-filter/AVX-filter variants at the same requested block sizes, for 27
variants. Twelve corpora include the previous eleven and a zero-header/random
page that can expose classifier false positives. The full 137-variant matrix
remains available. No native guarded-trial performance is claimed before testing.
Kernel SIMD state costs remain excluded; no kernel integration is performed.

## Completed physical N100 screen

All three sessions completed, with fully scheduled PMU groups and measured
package RAPL; native validation and all timed byte checks passed. At 1024-byte
GZRAM blocks, pooled half-zero encode medians were about 452.8 ns for guard16
and 430.1 ns for guard32, versus about 352 ns for original GZRAM in that cohort.
Sparse-word encoding stayed close to original, while mixed-prefix pages used
LZ4 and recovered their ratio. Guarding still pays an extra GZRAM pass before
LZ4 on those mixed pages and on rejected near-raw inputs. No overall preferred
policy is selected. Both absolute and paired estimates, all codec mode counts
and regressions remain in native-gzram-guarded-trial-001/hybrid-contrasts.*.

The next tests investigate sharing prefix detection with the existing vector
scan and selecting sparse-word versus repeat decoders independently. These
are separate performance hypotheses; existing guard16/guard32 source is retained.
