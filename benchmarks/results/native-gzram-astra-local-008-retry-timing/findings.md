# Combined scanner/packer: eighth physical N100 cohort

The grouped scanner and direct block packer combine usefully, but their gains
are not uniformly additive. The cutoff-2 AVX-bitwise combination reduces
compression time versus matched bitdirect AVX2 by **18.12% on sparse words,
20.98% on clusters50, and 10.54%/11.19% on repeat16/32**, with identical bytes.
These are time reductions, not the numerically different throughput increases.
It retains the compact 33/49-byte repeat frames and bitdirect decoder.

Against the standalone direct packer, sparse-word compression is essentially
tied (−0.29%, mixed session signs); words50 improves 2.51% and clusters25/50
improve 5.70%/5.66% in all three sessions. Conversely, the deliberately aligned
sample16/64 sparse fixtures lose 2.80%/4.63% against that packer. Period127-zero-tail
also regresses 3.56% against bitdirect. Both cutoffs, all scalar/vector controls,
all corpora and all regressions remain in the raw results. Neither combination
is an overall ZRAM replacement or a selected normal configuration.

## Measurement and preservation

Frozen source commit: `d693248c442df110c5ffd2a091bc6e4e5d29f232`.
Intel N100 Lenovo 14e, four cores, approximately 4 GB RAM; Fedora kernel
7.2.11-200.fc44.x86_64; GCC 16.2.1. Exact compiler commands, definitions,
source/library hashes and corpus hashes accompany this report. Three fresh
processes use order seeds 100/101/102, nine recorded rounds and two warmups,
128 independently decodable pages per corpus, and 8,192 calls per batch.
23 entries × 26 corpora × 3 sessions × 9 rounds × 2 operations = 32,292 rows.
Codec CPU 0, telemetry CPU 1, nice 5, existing exclusive native lock.

This run was on battery throughout, powersave, 700–800 MHz policy limits;
CPU 0 samples were 799.789–800.842 MHz (median 800.000 MHz). These absolute
numbers must not be compared directly with the seventh AC/700–3400 MHz cohorts.
Fresh controls are used here. Elapsed time was 2,503.802 seconds, maximum telemetry
gap 0.860 seconds. Every PMU group ran fully. Median thread occupancy was 99.109%,
minimum 15.925%; interrupted/preempted batches are retained, not filtered out.
Thread occupancy is not whole-machine CPU usage.

The [earlier attempt](../native-gzram-astra-local-008-interrupted/summary.md)
was suspended for about 41 minutes and is excluded from performance acceptance.
This fresh attempt held a temporary idle/sleep inhibitor, released afterward.
The stock zstd ZRAM module identity, algorithm/disksize and CPU settings match
before/after. No experimental host module, swap or boot change was made.

Both direct RAPL and the system-wide package-energy PMU are permission-denied.
All package-energy rows are unavailable. Battery-gauge integration in audit.json
covers the entire multi-variant experiment and other laptop activity; it cannot
establish per-codec energy savings, package energy, or battery-life improvement.

This is warm-cache userspace codec screening. Kernel SIMD state management,
stream locking, allocation rounding, reclaim, application responsiveness and
native pressure stability remain unmeasured for these combinations. See the
[exact-kernel integration review](native-integration-notes.md).

## Whole-codec absolute times and paired changes

Absolute times are pooled medians in ns/page. Percentages are medians of the
three session median paired-round ratios, so they need not equal ratios of the
pooled medians. Session ranges and all CPU/PMU metrics remain in paired.json.
The own-entry decoder figures are retained observations; the unchanged decoder
algorithm and entry/layout effects discussed below prevent attributing their
small differences to a new decoding algorithm.

| Corpus | Bitdirect C ns | Cutoff 2 C ns (change) | Cutoff 3 C ns (change) | Bitdirect D ns | Cutoff 2 D ns (change) | Cutoff 3 D ns (change) | Bytes/page, all three |
|---|---:|---:|---:|---:|---:|---:|---:|
| bash-elf | 42314.3 | 41912.9 (-0.38%) | 42080.2 (-0.48%) | 7190.2 | 7236.3 (+0.98%) | 7243.9 (+0.62%) | 3250.602 |
| clusters25 | 3549.7 | 2994.4 (-15.90%) | 3059.2 (-13.92%) | 3002.1 | 2985.5 (-0.39%) | 3009.2 (+0.53%) | 1172.000 |
| clusters50 | 4626.2 | 3626.0 (-20.98%) | 3675.6 (-20.31%) | 4816.2 | 4805.6 (+0.44%) | 4786.6 (-1.02%) | 2205.000 |
| clusters75 | 16284.7 | 15519.0 (-4.68%) | 15526.4 (-4.48%) | 3213.8 | 3196.7 (+0.44%) | 3215.3 (+0.13%) | 3237.242 |
| git-elf | 43053.4 | 42979.6 (-0.18%) | 42913.1 (-0.41%) | 7120.4 | 7192.5 (+0.67%) | 7171.1 (+0.52%) | 3198.492 |
| halfzero | 1775.4 | 1747.2 (-2.01%) | 1802.0 (-0.27%) | 375.0 | 372.6 (-0.47%) | 378.2 (+0.62%) | 2068.000 |
| libc-elf | 42157.5 | 42019.0 (-0.59%) | 41959.8 (-0.40%) | 7191.8 | 7241.6 (+1.09%) | 7210.8 (+0.96%) | 3113.102 |
| mixed-pages | 14873.2 | 14567.0 (-2.26%) | 14579.5 (-2.09%) | 3569.1 | 3626.8 (+2.65%) | 3631.4 (+1.43%) | 2049.070 |
| period127 | 5261.4 | 5251.4 (-0.29%) | 5257.3 (+0.39%) | 984.2 | 981.0 (+0.01%) | 986.2 (-0.24%) | 161.000 |
| period127-zero-tail | 4604.5 | 4658.5 (+3.56%) | 4700.8 (+1.22%) | 2792.3 | 2794.3 (-0.01%) | 2795.6 (+0.22%) | 165.000 |
| period509-zero-tail | 5355.5 | 5348.0 (+0.23%) | 5300.3 (-0.50%) | 2808.3 | 2789.1 (-0.89%) | 2792.0 (-0.71%) | 545.992 |
| random | 7029.5 | 7003.8 (-0.81%) | 6984.5 (-0.69%) | 480.3 | 483.9 (+0.99%) | 477.7 (-0.14%) | 4104.000 |
| repeat16 | 1391.5 | 1262.3 (-10.54%) | 1254.2 (-10.40%) | 244.5 | 239.9 (-2.81%) | 239.7 (-3.39%) | 33.000 |
| repeat32 | 1428.2 | 1263.4 (-11.19%) | 1274.5 (-10.73%) | 247.6 | 235.9 (-3.61%) | 244.6 (-2.65%) | 49.000 |
| repeat8 | 1357.2 | 1261.4 (-5.54%) | 1283.0 (-4.83%) | 253.2 | 244.4 (-2.01%) | 245.2 (-2.48%) | 25.000 |
| sample16-dense-hit | 8654.4 | 8609.4 (-0.15%) | 8609.3 (-0.42%) | 477.9 | 477.9 (+0.55%) | 475.2 (-0.23%) | 4104.000 |
| sample16-sparse-miss | 2505.4 | 2057.1 (-18.92%) | 2036.7 (-19.38%) | 1136.0 | 1127.4 (+0.04%) | 1122.5 (-1.34%) | 212.000 |
| sample64-dense-hit | 26386.6 | 26143.8 (-0.90%) | 26188.1 (-0.72%) | 1726.7 | 1759.8 (-0.34%) | 1766.5 (+1.95%) | 4101.578 |
| sample64-sparse-miss | 3298.6 | 2303.4 (-30.66%) | 2319.8 (-31.18%) | 1401.4 | 1408.3 (-0.20%) | 1380.6 (-2.05%) | 404.000 |
| sparse-words | 6136.2 | 4990.8 (-18.12%) | 5028.8 (-18.58%) | 4336.6 | 4376.1 (+0.97%) | 4351.0 (+1.55%) | 660.844 |
| word-tail64 | 6795.5 | 6683.4 (-2.33%) | 6661.2 (-1.34%) | 1021.8 | 1049.9 (+1.52%) | 1031.6 (-0.49%) | 2146.000 |
| words25 | 6015.9 | 5745.8 (-4.66%) | 6066.4 (+0.77%) | 5204.3 | 5259.0 (+1.03%) | 5198.5 (+1.20%) | 1174.531 |
| words50 | 5936.9 | 5272.2 (-10.96%) | 5313.9 (-11.03%) | 6064.4 | 6122.7 (+0.97%) | 6041.0 (-0.30%) | 2205.250 |
| words75 | 40850.7 | 40394.8 (-1.19%) | 40303.0 (-1.18%) | 10383.0 | 10428.9 (+0.13%) | 10419.4 (+0.35%) | 3831.609 |
| zero | 1271.6 | 1214.5 (-3.62%) | 1222.7 (-4.74%) | 234.9 | 231.2 (-0.02%) | 227.6 (-1.58%) | 20.000 |
| zerohead-random | 6471.4 | 6310.8 (-2.24%) | 6315.6 (-2.06%) | 601.2 | 582.9 (-4.45%) | 568.8 (-5.17%) | 4061.984 |

## Compression against individual components

Negative percentages mean less compression time. `scanner` is bitdirectavxbits4;
`packer` is the matching standalone blockdirect2/3. The final column compares
cutoff 2's AVX-bitwise scanner with its matching grouped integer scanner.

| Corpus | Cutoff 2 vs scanner | Cutoff 2 vs packer | Cutoff 3 vs scanner | Cutoff 3 vs packer | Cutoff 2 vs integer scanner |
|---|---:|---:|---:|---:|---:|
| bash-elf | -0.12% | -0.23% | -0.01% | -0.32% | -0.08% |
| clusters25 | -11.76% | -5.70% | -9.39% | -3.29% | -0.23% |
| clusters50 | -18.41% | -5.66% | -17.54% | -5.39% | -1.66% |
| clusters75 | -3.27% | -1.16% | -3.28% | -1.00% | -0.04% |
| git-elf | +0.04% | -0.23% | -0.03% | -0.42% | +0.10% |
| halfzero | +0.45% | -1.37% | +1.10% | -0.88% | -0.67% |
| libc-elf | -0.04% | -0.56% | -0.02% | -0.34% | -0.12% |
| mixed-pages | -1.65% | -0.37% | -1.69% | -0.30% | -0.27% |
| period127 | +0.58% | -0.51% | +3.16% | -0.95% | -1.16% |
| period127-zero-tail | +1.50% | +2.98% | +0.55% | +0.82% | -0.54% |
| period509-zero-tail | -0.22% | -0.07% | -0.03% | -0.56% | -0.13% |
| random | +0.29% | -1.02% | +0.70% | +0.85% | -0.44% |
| repeat16 | -0.03% | -7.34% | +0.49% | -6.55% | -1.39% |
| repeat32 | -0.18% | -8.17% | +0.01% | -7.70% | -1.38% |
| repeat8 | -1.83% | -4.65% | -0.37% | -2.34% | -2.32% |
| sample16-dense-hit | +0.23% | -0.23% | +0.12% | +0.31% | -0.85% |
| sample16-sparse-miss | -18.85% | +2.80% | -18.62% | +4.37% | +0.34% |
| sample64-dense-hit | -0.61% | -0.05% | -0.49% | +0.16% | +0.00% |
| sample64-sparse-miss | -29.19% | +4.63% | -28.47% | +9.66% | -0.26% |
| sparse-words | -15.59% | -0.29% | -15.96% | -0.64% | -2.11% |
| word-tail64 | -1.20% | +0.60% | -0.11% | -0.14% | -1.11% |
| words25 | -2.80% | +0.09% | +2.57% | +3.75% | -1.12% |
| words50 | -8.70% | -2.51% | -9.09% | -1.71% | +0.38% |
| words75 | -0.80% | -0.60% | -0.69% | -0.41% | +0.02% |
| zero | +0.32% | -2.90% | +1.19% | -2.27% | -1.32% |
| zerohead-random | -1.24% | -0.75% | -1.16% | -0.64% | -0.77% |

The explicit AVX-bitwise choice contributes about 1.39%/1.38% on repeat16/32
against the matching integer grouping, not the full 10–11% benefit. CPU time
and cycles show about 1.48% reductions for those contrasts. The choice also
changes instruction encoding/layout; execution-port overlap is not isolated.
Saved relocatable-object disassembly confirms identical parent scanner/packer
sequences in the combinations (including recorded padding, before relocation),
and no vector-stack operands in the audited scanner bodies. This does not prove
runtime causality or final kernel code layout. See component-identity.json.

## Matching combined controls

The plain combined controls (`bitdirectblock2/3`) retain the same decoder and
repeat handling as the grouped combinations. They isolate grouping more closely
than the older standalone packers. Compression effects below retain all corpora;
negative values mean less time. Session ranges are descriptive, not confidence
intervals. Sparse words are essentially tied, while words25 regresses with both
cutoffs. Thus the scanner and packer gains do not simply add across workloads.

| Corpus | Cutoff | Compression time change, % (session range) | Thread CPU change, % |
|---|---:|---:|---:|
| bash-elf | 2 | -0.26 (-0.46..-0.23) | -0.23 |
| clusters25 | 2 | -5.11 (-6.52..-4.30) | -5.44 |
| clusters50 | 2 | -7.31 (-7.40..-5.60) | -7.11 |
| clusters75 | 2 | -1.15 (-1.28..-0.74) | -1.13 |
| git-elf | 2 | +0.04 (-0.06..+0.14) | +0.04 |
| halfzero | 2 | -1.92 (-3.20..-0.99) | -2.01 |
| libc-elf | 2 | -0.08 (-0.60..+0.00) | -0.12 |
| mixed-pages | 2 | -0.40 (-0.45..+0.13) | -0.40 |
| period127 | 2 | +1.65 (-2.05..+2.09) | +1.67 |
| period127-zero-tail | 2 | +1.85 (-1.35..+2.88) | +1.82 |
| period509-zero-tail | 2 | -0.97 (-1.50..+0.15) | -0.96 |
| random | 2 | -1.07 (-1.48..-0.31) | -0.99 |
| repeat16 | 2 | -9.54 (-10.00..-8.75) | -9.84 |
| repeat32 | 2 | -10.63 (-11.24..-10.30) | -10.48 |
| repeat8 | 2 | -6.57 (-6.90..-5.56) | -5.80 |
| sample16-dense-hit | 2 | +0.07 (+0.05..+0.09) | +0.13 |
| sample16-sparse-miss | 2 | +4.61 (+4.22..+5.45) | +4.57 |
| sample64-dense-hit | 2 | -0.03 (-0.11..+0.05) | -0.00 |
| sample64-sparse-miss | 2 | +8.30 (+4.30..+8.79) | +8.55 |
| sparse-words | 2 | +0.09 (-0.46..+0.54) | +0.16 |
| word-tail64 | 2 | -0.28 (-0.78..-0.14) | -0.29 |
| words25 | 2 | +1.04 (+0.34..+1.25) | +1.07 |
| words50 | 2 | -2.16 (-3.04..-2.15) | -2.30 |
| words75 | 2 | -0.55 (-1.67..-0.27) | -0.58 |
| zero | 2 | -3.02 (-4.84..-2.10) | -2.88 |
| zerohead-random | 2 | -0.15 (-0.58..+1.99) | -0.24 |
| bash-elf | 3 | -0.09 (-0.28..+0.07) | -0.10 |
| clusters25 | 3 | -3.35 (-4.02..-1.98) | -3.34 |
| clusters50 | 3 | -6.47 (-8.78..-3.07) | -6.38 |
| clusters75 | 3 | -1.28 (-1.57..-0.97) | -1.21 |
| git-elf | 3 | -0.12 (-0.19..-0.08) | -0.15 |
| halfzero | 3 | -1.09 (-1.58..+2.74) | -1.30 |
| libc-elf | 3 | -0.07 (-0.38..-0.02) | -0.12 |
| mixed-pages | 3 | -0.30 (-1.23..+0.12) | -0.28 |
| period127 | 3 | -0.23 (-2.35..+3.79) | -0.24 |
| period127-zero-tail | 3 | +0.86 (+0.48..+2.75) | +0.80 |
| period509-zero-tail | 3 | -0.34 (-0.89..+2.42) | -0.22 |
| random | 3 | +0.13 (-0.45..+0.13) | -0.00 |
| repeat16 | 3 | -10.17 (-10.75..-9.86) | -10.28 |
| repeat32 | 3 | -9.83 (-9.84..-8.44) | -9.72 |
| repeat8 | 3 | -5.11 (-5.91..-5.02) | -5.64 |
| sample16-dense-hit | 3 | +0.73 (+0.35..+1.16) | +0.65 |
| sample16-sparse-miss | 3 | +3.84 (+3.52..+8.07) | +4.13 |
| sample64-dense-hit | 3 | +0.09 (-0.04..+0.18) | +0.10 |
| sample64-sparse-miss | 3 | +8.01 (+7.60..+8.78) | +7.97 |
| sparse-words | 3 | +0.20 (-0.71..+1.39) | +0.41 |
| word-tail64 | 3 | +0.97 (+0.29..+2.01) | +0.74 |
| words25 | 3 | +3.63 (+2.97..+5.27) | +3.66 |
| words50 | 3 | -1.74 (-2.30..-0.79) | -2.33 |
| words75 | 3 | -0.27 (-0.41..+0.17) | -0.29 |
| zero | 3 | -4.64 (-5.38..-4.23) | -4.26 |
| zerohead-random | 3 | -0.86 (-1.99..+0.44) | -0.73 |

## CPU time and cycles for the cutoff-2 combination

Both metrics are per page; cycles are user-only. These corroborate the main encoding effects without establishing energy savings.

| Corpus | Thread CPU ns: bitdirect → combined | Paired CPU change | Cycles: bitdirect → combined | Paired cycle change |
|---|---:|---:|---:|---:|
| sparse-words | 6077.7 → 4947.2 | -18.12% | 4843.0 → 3942.2 | -18.18% |
| words25 | 5966.8 → 5696.9 | -4.52% | 4752.6 → 4535.0 | -4.54% |
| words50 | 5875.1 → 5225.4 | -10.92% | 4681.3 → 4162.7 | -10.92% |
| clusters25 | 3520.2 → 2963.1 | -16.05% | 2805.2 → 2358.8 | -16.06% |
| clusters50 | 4575.0 → 3589.3 | -20.93% | 3645.1 → 2860.0 | -20.94% |
| repeat16 | 1379.2 → 1251.1 | -10.50% | 1098.8 → 996.7 | -10.50% |
| repeat32 | 1409.0 → 1252.5 | -11.08% | 1122.5 → 997.9 | -11.10% |
| bash-elf | 41797.0 → 41589.5 | -0.42% | 33312.8 → 33137.7 | -0.38% |
| random | 6958.2 → 6925.6 | -0.75% | 5544.5 → 5515.6 | -0.74% |
| period127 | 5207.8 → 5196.1 | +0.01% | 4149.5 → 4140.3 | -0.05% |
| period127-zero-tail | 4565.7 → 4606.8 | +3.22% | 3635.9 → 3667.9 | +3.01% |
| mixed-pages | 14739.1 → 14435.5 | -2.24% | 11743.8 → 11501.5 | -2.20% |

## Decoder anomaly: identity controls

The harness prepares immutable frames outside timing, verifies canonical byte
identity, restores equal streams from the same bank into the same addresses,
and shuffles all (variant, operation) tasks. Decode setup does not call the
candidate encoder immediately beforehand. Same-process aliases select exactly
one bitdirect decoder address per ISA; bitdirect's own aliases are exact-entry
negative controls for both encoder and decoder. All addresses/order logs are
retained and audited in decoder-controls.json.

With a common AVX2 decoder and identical inputs, pipe4 versus the baseline alias
changes repeat16 decode time by only **+0.23%** (sessions +0.23,+0.63,−0.06), and
repeat32 by **+0.38%** (+0.02,+2.13,+0.38). The cutoff-2 common alias changes them
+0.03% and +1.33%. The baseline's own exact-entry AVX2 alias changes repeat32 by
−2.11%, despite executing the same decoder on the same input addresses. Across
all corpora, its median absolute paired effect is 0.34%; the scalar negative
control is 0.31%, with a maximum of 2.03%.

Separate own-library entries still show process/session effects: for example,
pipe4's shared-vs-own repeat16 contrast ranges from −11.74% to +18.65% across
sessions, while its common-entry comparison is near zero. This rules out a new
decoder algorithm or changed compressed input as the explanation for the old
large anomaly. The exact layout/cache/predictor/history contribution remains
unisolated. Do not promote the own-entry repeat deltas, or small residual
same-entry differences, into algorithm improvements or regressions. Future
changes to the decoder itself need fresh common-input and identity controls.

## Matched private LZ4 comparison

The combination retains substantial sparse/repeat benefits, but rejected work
remains: cutoff 2 needs 49.63% more compression time on random data, 65.21% more
on period127, and 5.75% more on Bash ELF. Clusters50 decoding still needs 21.48%
more time. Conversely, its mixed-pages fixture takes 12.47% less compression
time and 21.76% less decoding time. That synthetic mixture is not a measured
application mix or an overall workload weighting.

| Corpus | LZ4 C → combined C ns | C paired change | LZ4 D → combined D ns | D paired change | LZ4 → combined bytes/page |
|---|---:|---:|---:|---:|---:|
| bash-elf | 39759.7 → 41912.9 | +5.75% | 7248.2 → 7236.3 | +0.23% | 3242.602 → 3250.602 |
| clusters25 | 10365.5 → 2994.4 | -71.30% | 3617.3 → 2985.5 | -17.60% | 1200.484 → 1172.000 |
| clusters50 | 16060.5 → 3626.0 | -77.62% | 3968.0 → 4805.6 | +21.48% | 2273.391 → 2205.000 |
| clusters75 | 16081.7 → 15519.0 | -3.50% | 2848.0 → 3196.7 | +12.42% | 3239.133 → 3237.242 |
| git-elf | 40979.9 → 42979.6 | +4.87% | 7193.8 → 7192.5 | -0.08% | 3190.492 → 3198.492 |
| halfzero | 4579.4 → 1747.2 | -61.60% | 2423.2 → 372.6 | -84.51% | 2082.000 → 2068.000 |
| libc-elf | 39658.0 → 42019.0 | +5.80% | 7232.1 → 7241.6 | +0.04% | 3105.102 → 3113.102 |
| mixed-pages | 16670.9 → 14567.0 | -12.47% | 4671.5 → 3626.8 | -21.76% | 2157.406 → 2049.070 |
| period127 | 3175.4 → 5251.4 | +65.21% | 965.0 → 981.0 | +1.51% | 153.000 → 161.000 |
| period127-zero-tail | 3251.8 → 4658.5 | +47.11% | 2781.2 → 2794.3 | +0.32% | 157.000 → 165.000 |
| period509-zero-tail | 3759.4 → 5348.0 | +42.03% | 2777.3 → 2789.1 | +0.40% | 537.992 → 545.992 |
| random | 4642.0 → 7003.8 | +49.63% | 505.8 → 483.9 | -4.70% | 4114.000 → 4104.000 |
| repeat16 | 2669.0 → 1262.3 | -52.92% | 1998.9 → 239.9 | -88.12% | 42.000 → 33.000 |
| repeat32 | 2792.5 → 1263.4 | -54.86% | 1081.9 → 235.9 | -77.89% | 58.000 → 49.000 |
| repeat8 | 2644.0 → 1261.4 | -52.25% | 2380.7 → 244.4 | -93.59% | 33.000 → 25.000 |
| sample16-dense-hit | 6167.8 → 8609.4 | +40.33% | 708.6 → 477.9 | -32.42% | 4111.953 → 4104.000 |
| sample16-sparse-miss | 3395.3 → 2057.1 | -39.05% | 1362.3 → 1127.4 | -17.63% | 135.453 → 212.000 |
| sample64-dense-hit | 23033.4 → 26143.8 | +13.90% | 2024.2 → 1759.8 | -12.68% | 4093.648 → 4101.578 |
| sample64-sparse-miss | 5978.7 → 2303.4 | -62.00% | 2382.2 → 1408.3 | -41.38% | 513.875 → 404.000 |
| sparse-words | 17227.0 → 4990.8 | -71.18% | 8107.0 → 4376.1 | -46.33% | 1081.359 → 660.844 |
| word-tail64 | 4647.3 → 6683.4 | +42.23% | 1012.6 → 1049.9 | +2.91% | 2138.000 → 2146.000 |
| words25 | 30660.8 → 5745.8 | -81.34% | 9944.0 → 5259.0 | -47.18% | 1886.453 → 1174.531 |
| words50 | 41173.3 → 5272.2 | -87.20% | 11144.7 → 6122.7 | -45.74% | 3085.586 → 2205.250 |
| words75 | 36551.3 → 40394.8 | +10.34% | 10466.1 → 10428.9 | -0.66% | 3828.805 → 3831.609 |
| zero | 2591.8 → 1214.5 | -53.06% | 4542.5 → 231.2 | -94.95% | 26.000 → 20.000 |
| zerohead-random | 4678.7 → 6310.8 | +35.30% | 562.0 → 582.9 | +1.46% | 4053.984 → 4061.984 |

Raw framing differences on incompressible pages do not imply ZRAM memory
savings: ZRAM can store the original page without invoking this decoder.
Zero/same-word pages can bypass compression. Even genuine compressed-byte
savings need allocator-rounded native measurement. The private LZ4 control is
not assumed identical to the current kernel's stock LZ4 workspace/backend.

## Correctness, decision and next experiment

All six new compositions passed normal and ASan/UBSan registry, independent
oracle/cross-decoding, guarded capacities, malformed/truncated input, repeat and
mask boundaries, alignment/scanner tests and four-thread concurrency checks.
All 45 old library text sections, 26 corpora and 545,792 old size/mode records
are unchanged; 79,872 new records match bitdirect. No GHY1/GZR1 format change.
See the [validation checkpoint](../gzram-astra-v8-validation-001/summary.md).

Keep both cutoffs as prototypes. Cutoff 2 has the stronger broad showing here,
including words25 and clusters25; cutoff 3 is not universally worse, and both
retain tradeoffs. The next three additive candidates bound tentative GZRAM
output by the existing acceptance threshold, to stop provably rejected work
without a new sampling heuristic. They must preserve byte identity even at
small output capacities. Then test a separate clustered-mask decoder path,
including partial-mask adversaries, and broader executable-load-segment fixtures.

An exact-kernel scalar ZRAM adapter has built, but device guest tests and native
recovery remain separate gates. No combined SIMD kernel, native pressure,
comparative package energy, application responsiveness or production-readiness
claim follows from this cohort. Stock zstd remains the normal configuration.
