# GZRAM continuation: local N100 word-path experiments

Branch: `feature/n100-gzram-astra-paths`, based on SOL's `e119f82`.
This prototype now has a completed local userspace cohort with repeatable sparse
decode gains and retained regressions. It does not establish kernel, battery or
production gains. [SOL's report](GZRAM-20261028.md) remains the historical baseline.

Update: the user confirmed that this workspace is on the same Lenovo 14e that
SOL previously accessed over SSH. Local execution has resumed; a changed
kernel, desktop or ZRAM setting is not evidence of a different physical target.
The first local timed cohort completed all three sessions and its artifact,
telemetry and preserved-system-state audit passed. Results are below.

## Starting evidence and preservation

All five remote branch heads were checked before editing. The newest was
`feature/n100-gzram-guarded-trial` at `e119f82`, dated October 28. The separate
scalar and adaptive branches were inspected through their history and retained
reports; no newer published GZRAM checkpoint was found. Their code, SOL's
original policies, unsuccessful experiments, raw CSVs and summaries are intact.
Unpublished controller checkpoints have not yet been accessible in this workspace.

The clean wordmixed and splittail cohorts are the relevant controls. Wordmixed
has the better measured scalar half-zero encoder; splittail removes its AVX2
half-zero penalty but gives back some scalar speed. Mixed decoding helps the
AVX2 entry's sparse path. These are specific benefits, not a general winner.
Guarded classification recovers the repeated-prefix ratio but charges a second
search on middling GZRAM output. Executable pages still pay for a rejected GZRAM
attempt before LZ4, whereas sampled routing often avoids that work. Original
GZR1's short dictionary cannot represent arbitrary repeating patterns; its raw
copy speed is not a compression-ratio improvement. Existing lzo-rle pressure
results remain stronger than the candidates on elapsed time for their tested
workloads. None of those results can be replaced by a userspace best case.

## Current machine and native gate

The current workspace is physically on an Intel N100, four cores, about 3.7 GiB
usable memory, Fedora kernel `7.2.11-200.fc44.x86_64`, GCC
`16.2.1 20260819 (Red Hat 16.2.1-2)`, an LXQt desktop and active zstd ZRAM.
The initial CPU0 policy was powersave with a 700–800 MHz allowed range.
The prior measured target used kernel 7.2.8, lzo-rle and a separate controller.
The current workspace has no project SSH configuration, native-validation lock,
lab recovery directory, matching kernel development tree or passwordless sudo.
The RAPL counter file is root-readable. PMU availability is reported by the
harness rather than inferred from installation of the perf command.

Read-only inspection found no local GZRAM benchmark job or project lock owner.
That does not establish the state of the other controller or target. Access to
the existing controller/lock has been requested. Do not create a substitute
lock and assume it excludes SOL's jobs. No native timing cohort, module load,
swap reset, reboot or boot-policy change has been performed in this continuation.
Correctness tests and builds here are not performance evidence.

The preceding paragraph records the initial access block, now resolved by the
user's machine identification and instruction to use this computer. The old
exclusive lock was on the external controller and is not present locally. No
other native lab process or service was active on the target. Local GZRAM
execution now acquires `~/.cache/n100-zram/native-validation.lock` with exclusive,
nonblocking flock before validating artifacts or creating experiment output.
It never unlinks that inode. Held-lock rejection was tested; an existing remote
controller can additionally retain its original lock when used again. This does
not claim that a new local inode locks an unavailable controller's old file.

`n100-gzram-astra-local-001.service` is bounded to two hours and holds a sleep/idle
inhibitor for the runner lifetime. It runs at nice 5, with codecs on CPU0 and the
runner/telemetry on CPU1. The existing 700–800 MHz powersave limits, battery
operation, active zstd ZRAM and boot settings are preserved. The cohort selects
15 variants at 1024-byte internal blocks: scalar LZ4, fast scalar/AVX2 GZRAM,
and scalar/AVX2 guard32, guard32mixed, wordmixed, splittail, outlinetail and
ctzunpack. All sixteen corpora, three sessions, two warmups and nine recorded
rounds per direction are included. This is an initial matched screen, not a
claim that 1024-byte blocks are universally optimal.

Package RAPL is currently unreadable to the unprivileged runner. It records
missing values as -1, not zero. Battery current/voltage/charge/status, frequency
limits, CPU/memory pressure and load are retained as system telemetry; they are
not substituted for per-codec package energy. Thread CPU accounting is included
alongside wall time. New analysis supports both this schema and historical CSVs;
synthetic known-ratio fixtures verified CPU changes, absolute medians and missing
energy handling. Historical absolute timing is not used as this cohort's control.

## Additive candidates

`outlinetail` preserves splittail's byte tail, GHY1 selection, scalar word
classifier and mixed decoder. It applies GCC `noipa` to the scalar classifier,
keeping it out of the caller and disabling specialization. The same local GCC
version emits a separate 267-byte `prefix_scalar` in wordmixed but inlines that
scanner into splittail's scalar encoder. This is evidence of a code-generation
difference, not proof of the cause of SOL's measured regression. The candidate
tests that hypothesis while charging the function call and changed code layout.
It must be compared with both wordmixed and splittail on every corpus.

`ctzunpack` independently changes sparse MASK32 decoding. It clears one 32-byte
group with integer stores and iterates over set mask bits, copying only present
words. It retains wordmixed's encoding policy and mixed scalar/AVX2 repeat
dispatch. The hypothesis is fewer unpredictable branches for sparse words.
Dense masks pay extra clearing stores and bit scans; no density cutoff is
assumed. Both scalar and mixed decode entries use this decoder, while LZ4
payloads retain the existing safe LZ4 decoder. This is not combined with
outlinetail, so the two hypotheses can be measured separately.

Both candidates retain GHY1/GZR1 decoding semantics and independently framed
pages. Encoded bytes are required to match the preserved guarded controls.
They introduce no shared mutable codec state, cross-page dictionaries, heap
allocation or new wire version. The existing userspace stack LZ4 workspace is
still unsuitable for a direct kernel transplant.

## Benchmark repair and measurement scope

The old full registry contained 217 entries, but `order[185]` overflowed when
shuffling all entries, even in validation-only mode. The original source was
retained under build/ and UBSan reproduced an index-185 out-of-bounds error.
The recorded SOL screen/grid cohorts selected at most 81 entries, so this
finding does not invalidate those published runs. Registry and shuffle capacity
now derive from the same policy list (249 entries with both additions).
CI also instruments the benchmark itself and validates the complete registry.
Codec-only sanitizers would not detect this harness error.

The timing CSV now also records thread CPU nanoseconds per call and CPU-time /
wall-time percentage. Two CPU-clock reads bracket the wall-clock interval;
their small additional cost is included in the CPU and PMU accounting, but not
inside the wall interval. CPU percentage describes the benchmark thread's
occupancy, not total machine utilization or application responsiveness. Values
slightly over 100% are possible from boundary/clock differences and must not be
silently clamped. Changed instrumentation requires newly matched controls;
historical absolute timings are not interchangeable with new ones.

## Validation checkpoint

Normal and ASan/UBSan validation passed for both candidates. Each candidate in
each build passed 29,312 round trips, 29,264 guarded-capacity cases, 71,680
exhaustive mask checks, 80,000 malformed/mutated decodes and 4,000 four-thread
round trips. Checks include byte-identical encoding,
independent Python GZR1 and system liblz4 decoding, cross-policy decoding,
protected input/output boundaries, malformed/truncated frames, four concurrent
threads, all block sizes, and ASan/UBSan. New exhaustive decoder cases construct
all 256 legal MASK32 masks, including dense masks the encoder normally rejects,
then check every frame truncation at exact and undersized output boundaries.
Full-registry validation also checks every corpus, not just selected candidates.
Both normal and ASan/UBSan full-registry checks passed 249 variants across
sixteen corpora and 128 pages each: 509,952 round trips per build. The retained
[validation logs and manifests](../benchmarks/results/gzram-astra-v1-validation-001/summary.md)
record the scope and initial failure; no native timing rows were generated.

All sixteen preserved library `.text` sections match the clean SOL checkpoint
build, including LZ4. Whole artifacts still match their build manifests. An
initial test attempt was interrupted by SIGBUS while a concurrent `objcopy`
inspection rewrote an mmap'ed control library. The core identifies its PLT/GOT
mapping and the file timestamp matches that inspection. It is retained as a
failed infrastructure attempt, not counted as a passing test. The isolated
repeat passed. `gzram/tools/audit-codegen.py` now operates on private copies and
verifies original artifact hashes, avoiding that collision. Raw cores stay
private under ignored build/.

The system lacks sanitizer runtime packages. Matching Fedora libasan/libubsan
RPMs were downloaded, their signatures/digests verified with rpmkeys, and their
libraries extracted only under ignored build/. They are used by an explicit
compiler/library search path; no system package or security setting was changed.
No hosted workflow success is claimed merely because a workflow was updated.

## Compressed-size checkpoint

The [size-only dataset](../benchmarks/results/gzram-astra-v1-sizes-001/summary.md)
contains 114,688 independently decoded frames: 56 screened variants, sixteen
corpora and 128 pages each. It records every per-page byte count and actual
hybrid mode. Both additions match wordmixed's sizes on every screened page at
1024/4096-byte blocks, scalar and AVX2. These are inherited ratio tradeoffs,
not new compression-ratio gains:

| Corpus | LZ4 mean bytes | Each new hybrid, 1024-byte blocks | Change vs LZ4 |
|---|---:|---:|---:|
| Executable pages | 3242.602 | 3250.602 | +0.25% |
| Sparse words | 1081.359 | 660.844 | -38.89% |
| Period 127 | 153.000 | 161.000 | +5.23% |
| Half zero | 2082.000 | 2068.000 | -0.67% |
| 25% nonzero words | 1886.453 | 1174.531 | -37.74% |
| 50% nonzero words | 3085.586 | 2205.250 | -28.53% |
| 75% nonzero words | 3828.805 | 3831.609 | +0.07% |
| Interleaved mixed pages | 2157.406 | 2049.070 | -5.02% |

The full report retains zero, short repeats, incompressible and all other cases.
Framing is charged, but ZRAM allocation classes, zero-page bypass and raw-page
handling are excluded. At that size-only checkpoint, CPU use, speed, energy and responsiveness were
unmeasured. The later local timing results below supersede that timing status. A preliminary size export
stopped because its independent oracle did not enable the preserved GZR2 mode;
that failed attempt is retained privately and the corrected fresh export passed.

Reproduce without launching a timing job:

```sh
python3 gzram/tools/build.py --output build/astra-reproduce
gcc -O2 -Wall -Wextra -Werror gzram/bench.c -ldl -o build/astra-reproduce/benchmark
build/astra-reproduce/benchmark build/astra-reproduce --validate-only
python3 gzram/tools/measure-sizes.py --directory build/astra-reproduce \
  --benchmark build/astra-reproduce/benchmark --output build/astra-size-reproduce
python3 gzram/tools/summarize-sizes.py --input build/astra-size-reproduce
```

The size exporter uses the local Bash fixture; compare its recorded hash before
comparing executable or mixed-page results across hosts. Size records are not
timing measurements; the later cohort records actual thread CPU time separately.

## Completed local cohort 001

[All raw rows and LZ4 comparisons](../benchmarks/results/native-gzram-astra-local-001/summary.md),
[direct paired comparisons](../benchmarks/results/native-gzram-astra-local-001/paired.md),
and [audit](../benchmarks/results/native-gzram-astra-local-001/audit.json) retain
15 variants, sixteen corpora, three sessions and 12,960 timing rows. Each session
uses two warmups and nine shuffled recorded rounds, 128 pages per corpus, and
32,768 calls per direction per batch. Frozen codec/benchmark/runner sources are
identified by commit `50dee85` and the published provenance and hashes. Later
source edits were not used by this cohort. All initial sixteen corpus hashes
match the size-only checkpoint.

The physical N100 remained at its existing powersave 700–800 MHz limits, on
battery, under kernel 7.2.11 and GCC 16.2.1. Maximum telemetry gap was 0.908 s;
all user-only PMU groups were fully scheduled. Median thread CPU/wall occupancy
was 99.137%, but 494/12,960 rows were below 95% and 273 below 90%, mostly in the
first session. The minimum was 14.698%. No interrupted row was deleted. CPU time
and cycle changes corroborate the large decode improvements; tiny wall-time
changes on other paths should not be treated as established wins.

The scalar ctzunpack decoder improved these whole-codec decode times versus the
matched scalar wordmixed control, without changing any compressed bytes:

| Corpus | Wordmixed ns/page | ctzunpack ns/page | Paired wall change | Three session changes | Thread CPU change |
|---|---:|---:|---:|---|---:|
| Sparse words | 5738.7 | 3660.6 | -36.44% | -36.58 / -36.44 / -36.28% | -36.43% |
| 25% nonzero words | 9300.8 | 4518.6 | -51.50% | -51.63 / -51.50 / -51.29% | -51.47% |
| 50% nonzero words | 14023.5 | 5291.7 | -62.24% | -62.21 / -62.25 / -62.24% | -62.25% |
| Mixed pages | 3903.3 | 3338.4 | -13.82% | -14.71 / -13.78 / -13.82% | -13.80% |

Absolute values are pooled medians; percentages are median paired session
changes, so a ratio of the displayed medians need not equal the displayed change.
The AVX2 entry, which also uses scalar sparse unpacking, improved by 29.45%,
46.81%, 58.24% and 10.59% respectively. Its absolute sparse decode remained
slower than the scalar entry (4062.3 versus 3660.6 ns/page). The entry label
is not evidence that vector work improves that operation. On words50 the
scalar candidate executed 23.56% more instructions but 78.18% fewer branch
misses and 62.25% fewer cycles. Instruction count alone would mis-rank it.

Compared with matched scalar LZ4, the scalar ctzunpack candidate compressed
sparse words in 8116.7 versus 16924.0 ns (-52.26% paired), decoded in 3660.6
versus 7838.6 ns (-53.41%), and used 660.844 versus 1081.359 bytes (-38.89%).
On mixed pages those values were 15859.1 versus 16396.2 ns compression (-3.24%),
3338.4 versus 4427.6 ns decoding (-24.71%), and 2049.070 versus 2157.406 bytes
(-5.02%). Compression and size gains here are inherited from wordmixed; the
new change is sparse decoding. The complete report retains every LZ4 contrast.

The remaining losses rule out general replacement. Scalar ctzunpack executable
compression was 42809.2 versus LZ4's 39535.2 ns (+8.27%), with eight extra bytes.
Period127 compression was 6003.8 versus 3110.3 ns (+92.91%), with 161 versus 153
bytes. The words75 case took 47186.1 versus 36461.4 ns (+29.37%), with slightly
larger output. Repeat32 still used 148 versus 58 bytes (+155.17%) at 1024-byte
internal blocks. Zero/same-filled pages and raw fallback timings are not native
ZRAM wins. ctzunpack retains small non-sparse changes and regressions in the
paired files; it supplies no general encoding improvement.

Outlinetail reduced scalar half-zero encoding by 4.93% relative to splittail
(2924.8 versus 3086.9 ns), but remained 5.69% slower than wordmixed (2791.3 ns).
Its AVX2 half-zero change versus wordmixed was -0.38%, with one session positive.
This does not justify selecting the outlined classifier. Preserve it as a
negative/partial attribution experiment; no best-of-path combination is accepted.

Package energy was unavailable for all rows in this first cohort. Battery
current/voltage integration estimates 20.19 kJ (5.61 Wh) for the whole 3601.9 s
experiment, including validation, warmups, desktop/background work and telemetry.
The gauge is uncalibrated and this is not a per-codec or comparative energy
measurement. There is no energy-efficiency conclusion from cohort 001.

The timing service exited successfully and released its lock/inhibitor. The
next validation job then acquired the same lock. The original ZRAM module build
ID, active zstd algorithm, disk size and CPU policy match preflight; no swap,
module, boot or power-policy restoration operation was needed. No application
responsiveness or memory-pressure result is implied by codec timing.

## Completed word-path cohort 002

The [five word-path candidates](../gzram/docs/WORD-PATHS.md) passed
[normal and sanitizer validation](../benchmarks/results/gzram-astra-v2-validation-001/summary.md).
Each policy/build passed 34,240 cross-decoder round trips, 34,192 guarded
capacities, 71,680 exhaustive mask checks, 48,576 repeat-boundary checks, 80,000
malformed/mutated decodes and 4,000 concurrent round trips. Repeat consolidation
passed 62 additional direct checks and old/new decoding in both directions.
The complete 329-variant registry passed 715,904 round trips in each build.
All eighteen preceding library .text sections are identical. The
[size audit](../benchmarks/results/gzram-astra-v2-sizes-001/summary.md) independently
decoded 165,376 frames, preserving all 114,688 earlier records and all sixteen
old corpus hashes. Repeat16 was appended as the seventeenth corpus.

[Native cohort 002](../benchmarks/results/native-gzram-astra-local-002/summary.md)
contains 21 variants, seventeen corpora, three sessions and 19,278 rows, with
8192 calls per batch. All rows have RAPL readings and fully scheduled user PMUs.
The maximum telemetry gap was 0.758 s; median thread occupancy was 99.296%, with
102 rows below 95% and 35 below 90% (minimum 38.521%). All rows remain. Hardware,
kernel, compiler, 700–800 MHz limits, battery operation and zstd ZRAM match the
preceding setting. Fresh matched controls are used; absolute times/energy are
not compared across the different batch sizes or variant sets.

Scalar bitpack preserves wordmixed's encoded bytes and improves compression:

| Corpus | Wordmixed → bitpack ns/page | Paired wall change | Thread CPU change | Package uJ/page, control → candidate | Paired energy change (session range) |
|---|---:|---:|---:|---:|---:|
| Sparse words | 8131.7 → 5913.0 | -27.32% | -27.40% | 17.390 → 12.532 | -28.00% (-28.88..-21.49%) |
| 25% nonzero words | 11464.6 → 6902.4 | -39.87% | -39.85% | 23.015 → 14.149 | -37.94% (-42.18..-36.05%) |
| 50% nonzero words | 16454.4 → 7816.7 | -52.49% | -52.46% | 32.827 → 15.818 | -48.98% (-52.12..-44.33%) |

These are whole userspace codec calls and batch-scope package energy, including
bookkeeping and background activity. Bitpack also reduced words75 compression
7.88% and mixed-page compression 3.93%, but regressed scalar half-zero compression
2.37%. Its mixed-page energy result changed sign between sessions. No broad
energy or application gain is inferred. Its decoder retains the prior wordmixed
implementation; this is an encoding improvement, not the sparse-decoder fix.

Mixpack uses scalar bit-scan packing after an AVX2 scan. Its AVX2 entry improved
sparse compression 20.70% (5979.0 → 4754.1 ns; 12.480 → 9.514 uJ, -23.86% paired)
and words25 compression 7.03%, but regressed words50 by **13.21%** (5842.5 →
6586.2 ns; 12.398 → 14.074 uJ, +12.19% paired), and words75 by 4.68%. All three
sessions agree on those directions. Unconditionally replacing vector packing
with scalar packing is rejected. A measured per-group selection experiment may
be worthwhile, but no word-count cutoff has been selected.

Scalar wordrepeat improved repeat16 decoding 75.84% (2334.6 → 564.5 ns,
4.679 → 1.065 uJ, -78.56% paired energy) and repeat32 decoding 37.23%
(825.3 → 517.8 ns, 1.714 → 1.051 uJ, -36.00% paired energy). Repeat8 improved
86.50%, but same-filled ZRAM bypass prevents treating that as a swap gain.
Other paths remain in the report, including a 0.99% words50 decode regression.

Combining wordrepeat with the sparse decoder is not free: scalar ctzrepeat
regressed sparse-word decoding 5.02% (3881.1 → 4075.7 ns), words25 4.40%
(4709.1 → 4928.7 ns), and words50 5.57% (5489.1 → 5823.8 ns) versus ctzunpack.
CPU time corroborates the loss. The sparse algorithm is unchanged, but the
compiled decoder changes: ctzunpack's scalar decode is 1458 bytes with its old
repeat loop inlined; ctzrepeat has a 1026-byte scalar decode and a separate
378-byte repeat helper. This is a code-generation observation, not a proven
cause. Preserve the separate decoder control and investigate composition rather
than accepting the combination automatically.

Repeatmerge stores the same page-wide pattern once using existing GZR1 framing:

| Corpus | Wordmixed bytes at 1024 | Repeatmerge bytes | LZ4 bytes | Change vs wordmixed / LZ4 |
|---|---:|---:|---:|---:|
| Repeat16 | 84 | 33 | 42 | -60.71% / -21.43% |
| Repeat32 | 148 | 49 | 58 | -66.89% / -15.52% |

These are framed byte counts, not allocator-rounded ZRAM memory. Scalar
repeatmerge compression regressed 4.18% on repeat32 and 5.04% on half-zero.
Scalar repeat16 decoding regressed 11.25% (2334.6 → 2613.5 ns), and repeat32
6.65% (825.3 → 880.6 ns). Its AVX2 decoder improved repeat16 by 24.17%
(337.1 → 256.9 ns) and repeat32 by 28.44% (334.5 → 238.1 ns). Thus fixing the
ratio alone does not establish a better complete codec. Both 1024 and 4096
controls, both ISAs, all operations and every other corpus remain in the
[3434 direct comparisons](../benchmarks/results/native-gzram-astra-local-002/paired.md).

A global switch to 4096-byte blocks is particularly harmful on half-zero pages.
Against wordmixed's 1024-byte blocks, scalar compression takes 84.07% longer
and decompression 442.10% longer; AVX2 takes 47.39% and 420.14% longer,
respectively. Framed output grows from 2068 to 2193 bytes (+6.04%). A single
page-wide sparse block replaces the smaller blocks' separate raw and zero
regions. Conversely, 4096-byte repeat16/repeat32 frames save 60.71%/66.89%
and improve AVX2 decoding 23.56%/28.45%. These measured opposing effects
motivate selective repeat consolidation while retaining smaller blocks for
mixed pages; they do not establish a universal block size.

Short-batch energy remains a limitation. For example, unchanged AVX2 repeat
handling in ctzrepeat has roughly -1% repeat16 time but +38% paired package
energy versus ctzunpack; that is not evidence of an intrinsic 38% energy penalty.
Tiny decode batches need longer matched confirmation. Large scalar packing
energy reductions have the same sign in all three sessions, but remain scoped
to these userspace workloads. Whole-experiment battery integration was about
6.06 kJ (1.68 Wh) over 1304.6 s; gauge precision/lag is uncalibrated. Different
cohort durations and contents make this unsuitable for comparison with 001.

The read-only RAPL handoff ran the codec with UID 1000 and zero effective
capabilities. A first launch was rejected before any timing output because
systemd-inhibit closed/reused the descriptor; that failure is retained. The
successful run used a separate bounded sleep/idle inhibitor. The runner verified
the descriptor's exact sysfs target and read-only mode. No permissions, power
settings, swap, modules or boot configuration were changed. Postflight hashes
match the original ZRAM module, algorithm, size and CPU policy.

## Third candidate correctness checkpoint

[Seven new policies](../gzram/docs/WORD-PATHS.md) passed normal and ASan/UBSan
checks, including 1,128,960 full-registry round trips per build across 20 corpora.
The [raw validation record](../benchmarks/results/gzram-astra-v3-validation-001/summary.md)
preserves the host-shutdown interruption and successful hash-checked resumption.
All 23 preceding library text sections, 17 corpus hashes and 165,376 preceding
size records are unchanged. The expanded size screen has 266,240 records.
No third-cohort speed, energy, cutoff or overall improvement is accepted yet.
A 22-variant, 20-corpus timing run is now collecting three matched sessions from
frozen commit `1ee0e34`, after the restart and a fresh native preflight. Output
is `build/astra-local-003-timing`; package energy is unavailable. A separately
recorded energy run is waiting for desktop authentication and the same exclusive
lock. Partial rows are not accepted results. The earlier 001/002 measurements
remain the latest completed performance evidence.

## Next experiments and kernel decision

Next, test clustered full/zero mask groups, measured scalar/vector packing
selection, composition with the preserved sparse decoder, and the cost of repeat
consolidation. No density threshold or combined policy is accepted yet. The
current random-density corpora do not cover every clustered-memory layout.

A separate generated scalar GZR1 component passed userspace oracle, guard,
malformed-input, concurrency and sanitizer checks after this timing run ended.
It removes userspace SIMD dispatch without changing the scalar algorithm bodies.
It is not the GHY1/LZ4 container, a compiled kernel module, a VM result or a ZRAM
backend. Matching signed kernel development files and private VM tools are
prepared. A subsequent isolated component gate is recorded below. Scalar integration
can isolate the measured decoder gain before adding kernel SIMD state handling.

Kernel integration is conditional on whole-codec profitability. It requires
bounded per-stream workspace, kernel-safe copies, explicit scalar fallback,
separate vector translation units, and measured SIMD state handling for clean
and dirty register states. Follow isolated correctness, exact-ABI VM tests and
only then controlled native trials with current recovery verification. Lzo-rle
and matched LZ4 must be compared on real reclaim and response latency, memory
including allocator overhead, CPU, package energy and stability. The current
machine's zstd is an additional baseline to preserve in any future native trial.

Batching is not implemented or accepted. The upstream
[FPU API documentation](https://docs.kernel.org/core-api/floating-point.html)
warns that critical sections can disable preemption and should remain small.
Combining calls must therefore measure entry/exit cost, maximum critical-section
duration, queue residence, wakeups, contention, copying, extra buffers and tail
latency, including batch-size one and deadline-driven partial batches. Pages
must remain independently decodable. The older roughly 435 ns LZ4 FPU result
is a diagnostic precedent, not a transferable constant or a batching threshold.

For background processing, existing
[ZRAM idle recompression](https://docs.kernel.org/admin-guide/blockdev/zram.html#recompression)
is a concrete integration route to investigate after a codec earns a kernel
prototype. Measure total CPU/energy of initial compression plus recompression,
memory saved after allocator rounding, foreground interference and cancellation
on page reuse. Idle status alone does not prove a net energy benefit. Package
RAPL, whole-system wall energy and laptop battery energy remain separate scopes;
this checkpoint supplies no new measurements for any of them.

## Scalar kernel component gate

The checked reference/CTZ GZR1 ports now compile as a correctness-only module
against the current 7.2.11 headers. An exact-kernel diskless KVM guest passed two
load/test/unload cycles, each with four workers and 161,410 assertions. The
[source, commands, raw serial log and limitations](../benchmarks/results/gzram-scalar-kernel-gate-001/summary.md)
are retained. This is component correctness evidence, not physical N100 timing,
GHY1/LZ4 integration, ZRAM behavior, SIMD validation or native recovery evidence.
No experimental module was loaded on the host; stock ZRAM and CPU hashes match.
