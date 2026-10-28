# Independent scan scheduling: physical N100 findings

The four-group AVX-bitwise candidate has repeatable **compression** gains over
matched bitdirect AVX2 on sparse/repeated/clustered inputs, with identical bytes.
It is a useful encoder component, not an overall ZRAM replacement. Explicit AVX
bitwise operations add about 1.1–1.3% on repeat16/32 versus the same-width integer
variant; most of the larger improvement is already present in the grouped scan.
Instruction scheduling, loop overhead, branch behavior and code layout change
together. These measurements do not establish a separate AVX execution engine
or prove that simultaneous execution caused the gain.

## Experimental scope

Sources: commit `425ba5bff8c89a602a62c4584381f74e4b079d1a`, frozen hashes in
source-provenance.json. Intel N100 Lenovo 14e, four cores, approximately 4 GB RAM,
Fedora kernel 7.2.11-200.fc44.x86_64, GCC 16.2.1; exact commands/flags and hashes
are in metadata.json, benchmark-build.json and the validation manifests.
Each cohort has ten variants × 26 corpora × three sessions × nine recorded
rounds × two operations = 14,040 rows. Two warmups per session; 128 pages/corpus,
8,192 calls per measured batch; codec CPU 0, telemetry runner CPU 1, nice 5.
The second cohort uses the same frozen binaries, corpora and three order seeds
100/101/102 in fresh processes. It is a repeatability check, not three new random
orders or independent real-world workloads. Both complete raw cohorts are kept.

The existing exclusive native lock serialized validation and timing. AC stayed
connected; powersave and the 700–3400 MHz policy remained unchanged. Frequency
was dynamic: CPU 0 sampled 2.600–3.402 GHz (median 3.077 GHz) in the first run,
and 1.400–3.400 GHz (median 3.100 GHz) in the repeat. Do not compare absolute
numbers against earlier 800 MHz battery cohorts. Settings and stock zstd ZRAM
algorithm/disksize/module identity match before and after. No experimental host
module, swap change, queue, background compressor or boot change was introduced.

First/repeat elapsed times were 282.534/297.631 seconds. All PMU groups ran fully.
Median thread occupancy was 99.829%/99.833%; minima were 96.765%/51.495%. The low
repeat sample is retained, not discarded. Values slightly above 100% arise from
clock boundaries. Thread CPU and occupancy are not whole-machine CPU usage.
No RAPL energy was available in either run; AC battery readings cannot establish
energy savings. No comparative energy or battery-life conclusion is possible.

These are warm-cache userspace codec measurements. Kernel FPU state handling,
ZRAM stream locking/allocation, reclaim/swap, faults, application responsiveness,
whole-system energy and native stability under memory pressure remain unmeasured
for these candidates. Historical lzo-rle is not today's stock zstd configuration.

## Compression against the existing vector path

Times below are pooled absolute medians; percentages are the median of three
session median paired-round ratios. They are different statistics, so percentage
changes need not equal ratios of pooled medians, especially with dynamic clocks.
All listed effects are negative in all six sessions across both cohorts.

| Corpus | First control → candidate ns/page | First paired change | Repeat control → candidate ns/page | Repeat paired change | Bytes/page |
|---|---:|---:|---:|---:|---:|
| sparse-words | 1534.7 → 1493.8 | -2.95% | 1488.5 → 1486.8 | -2.90% | 660.844 |
| words25 | 1532.7 → 1485.5 | -2.51% | 1476.4 → 1443.4 | -2.45% | 1174.531 |
| words50 | 1484.5 → 1451.7 | -2.84% | 1481.5 → 1536.6 | -1.73% | 2205.250 |
| clusters25 | 910.8 → 856.9 | -5.02% | 923.9 → 881.1 | -5.07% | 1172.000 |
| clusters50 | 1158.6 → 1109.6 | -4.28% | 1186.8 → 1170.6 | -4.05% | 2205.000 |
| repeat16 | 365.1 → 326.8 | -9.81% | 353.5 → 316.1 | -9.64% | 33.000 |
| repeat32 | 375.4 → 331.7 | -10.93% | 355.8 → 315.9 | -9.76% | 49.000 |
| libc-elf | 10844.8 → 10751.0 | -0.44% | 10323.9 → 10268.1 | -0.49% | 3113.102 |

CPU-time changes corroborate these main gains: sparse words −3.02%/−3.05%,
clusters25 −5.00%/−5.12%, clusters50 −4.22%/−4.05%, repeat16 −9.77%/−10.44%,
repeat32 −10.95%/−9.77%. Cycles also fall in both cohorts: sparse −3.23%/−2.87%,
clusters25 −4.28%/−5.06%, clusters50 −4.21%/−3.95%, repeat16 −9.76%/−10.11%,
repeat32 −10.91%/−9.77%. Instructions fall about 6% on sparse and 15% on repeat
pages; this supports less CPU work, without proving a specific execution-port
explanation or an energy saving.

Bash changes −0.48%/−0.51%, but one repeat session loses; Git +0.14%/−1.21% and
mixed pages +0.78%/−0.92% also lack a consistent benefit. Period127-zero-tail
changes +0.11%/+0.33% with mixed signs. These and every other regression remain
in paired.json/paired.md. Zero and repeat8 codec gains are not equivalent ZRAM
gains: same-filled pages can bypass the compressor in ZRAM.

## Does explicitly mixing AVX and AVX2 add value?

Relative to four-group integer pipe4, avxbits4 reduces repeat16 time by
1.30%/1.25% and repeat32 by 1.24%/1.12%, with the same sign in all six sessions.
The much larger ~10% gains above include grouping and loop changes; they must
not be attributed entirely to the ISA substitution. Other effects are small or
inconsistent: clusters50 −0.70%/+0.60%, Bash +0.44%/−0.13%, and words50
+0.07%/+0.39%. The two-group AVX variant and one-group scheduling control are
retained in every table. No universal instruction-choice rule is established.

Generated scanner code confirms VXORPS/VORPS alongside VPCMPEQD and scalar
bookkeeping. The baseline scanner is 266 bytes; pipe1/2/4 are 264/495/665 bytes;
avxbits2/4 are 478/650. No vector stack references appear in these scanners.
Code-size/register-pressure costs remain even where time improves. There is
no queue or inter-page dependency; every page stays independently decodable.

## Decoding, scalar controls, and the unresolved repeat anomaly

No decoder algorithm was changed. Most effects are small and several change
sign across sessions. For avxbits4 versus bitdirect, mixed decoding loses
1.27%/+0.21%, words25 +0.45%/+0.98%, and words50 +0.08%/+0.78%. In the repeat,
words25 and words75 lose in every session. There is no accepted broad decode
improvement from an encoder-only change.

The integer pipe4 variant's repeat16 decoding loses 16.17% in the first cohort
(67.3 → 78.4 ns/page) and 15.60% in the repeat (65.7 → 75.8 ns/page), although
one repeat session reverses sign. Repeat32 has a +14.6% session outlier in the
repeat. These results are preserved. Exact linked decoder bytes and virtual
offsets match between pipe4 and avxbits4, including the public and CTZ decoders;
see decoder-layout/decoder-byte-hashes.json. This excludes a different decoder
implementation between those two libraries, but does not isolate runtime
mapping, predictor/cache state, prior encoder effects, or another cause. Do not
claim the scan's AVX substitution made decoding faster.

Against scalar bitdirect in the first cohort, avxbits4 compresses words50
27.18% faster and clusters50 17.72% faster, but sparse compression is inconclusive
(−0.48%, signs mixed). Scalar decoding wins: avxbits4 takes 7.66% more time on
sparse, 9.25% on words50 and 7.18% on clusters50; repeat decoding favors the
vector route. All 936 LZ4/scalar contrasts per cohort, both operations, absolute
values, CPU times and all session effects are in external-controls.json/.md.
Scalar remains an essential candidate, especially after kernel FPU costs.

## LZ4 and actual ZRAM

First-cohort avxbits4 versus matched private scalar LZ4: sparse compression
4295.9 → 1493.8 ns/page (−65.24%), decode 2041.7 → 1081.7 (−46.86%), bytes
1081.359 → 660.844. Repeat16 compression 678.8 → 326.8 (−51.86%), decode
527.7 → 67.4 (−87.22%), bytes 42 → 33. These are useful strengths.

Losses remain: Bash compression 10119.0 → 10738.9 (+6.01%), bytes 3242.602 →
3250.602; random compression 1204.2 → 1868.0 (+51.85%); period127 compression
789.1 → 1302.3 (+65.09%), bytes 153 → 161; clusters50 decode 994.8 → 1215.8
(+21.33%). Raw random framed output exceeds 4096 bytes for both codecs; actual
ZRAM's incompressible-page handling is outside this microbenchmark. Relative
to blockdirect2, avxbits4 still loses sparse/words50/clusters50 compression
20.22%/6.40%/17.12%, while retaining the much stronger sparse/repeat decoder and
smaller repeat frames. It is not the best encoder component for every input.

ZRAM is the system using a compressor. Current stock ZRAM uses zstd, and no
matched native pressure comparison against zstd or lzo-rle was performed here.
Neither userspace LZ4 wins nor VM correctness tests establish a ZRAM improvement.
No default change or production promotion follows.

## Checkpoint decision and next experiment

Retain avxbits4 and the integer controls as validated encoder prototypes. All
40 earlier library code sections and baseline data remain preserved; normal
and ASan/UBSan correctness, guarded boundaries, independent decoding, malformed
inputs and concurrency passed before timing. Size/mode identity holds for all
66,560 new size records. Full counts and failures/regressions are retained in
the adjacent validation and size checkpoints.

Next, compose the grouped scanner with the faster direct block packer while
preserving the bitdirect decoder and repeat format, then compare against each
component separately. Isolate decoder measurement with a shared decoder entry
and randomized operation order before interpreting the repeat anomaly. Any
kernel SIMD candidate still needs bounded FPU handling and controlled native
recovery checks; no batch size, queue threshold or ZRAM benefit is assumed.
