# GZRAM continuation: local N100 word-path experiments

Branch: `feature/n100-gzram-astra-paths`, based on SOL's `e119f82`.
Latest: the third physical energy cohort confirms sparse scalar time and package
energy reductions, while retaining clustered-data and LZ4-relative regressions.
The fourth timing cohort now identifies a combined sparse/repeat candidate with
strong repeat-decode and size gains, retained regressions, and energy still unmeasured. This prototype
does not establish kernel, battery or production gains. [SOL's report](GZRAM-20261028.md) remains the historical baseline.

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
This correctness checkpoint was followed by the completed 22-variant,
20-corpus timing cohort reported below, from frozen commit `1ee0e34` after a fresh
native preflight. Its package energy is unavailable. A separate energy cohort
has now obtained read-only counter access and is collecting matched sessions.
No overall, kernel or production improvement is accepted.

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

## Current recovery review

The post-restart read-only review confirms ACPI restart, no recovery boot
arguments, all five panic/lockup runtime settings at zero and no exposed hardware
watchdog. The historical backup directory is absent at its documented location.
`grubby --default-kernel` returned `/boot` rather than a valid kernel image, so
its successful exit does not establish the current boot default. The
[exact observed state](validation/astra-recovery-review-20261028.json) and
[historical scope](../RECOVERY.md) are retained. Native kernel execution remains
gated; this does not prevent userspace experiments or isolated VM correctness.

## Third completed physical timing cohort

The [complete timing cohort](../benchmarks/results/native-gzram-astra-local-003-timing/summary.md)
contains 23,760 rows: 22 variants, 20 corpora, three sessions, nine recorded
rounds after two warm-ups, 8,192 calls per batch and 128 independent pages per
corpus. It uses frozen source `1ee0e34`, GCC 16.2.1, the physical N100's stock
7.2.11 kernel and unchanged powersave/700–800 MHz limits. It ran after the host
restart, with matched controls inside every session. Cross-cohort absolute
changes are not attributed to a codec. Package energy is unavailable in every
row; this is a timing/CPU/size checkpoint, not an energy confirmation.

The audit verified every expected row, artifact hashes and unchanged ZRAM/CPU
settings. All PMU groups ran fully scheduled. Maximum telemetry gap was 0.544 s;
thread occupancy ranged 82.112–100.009%, median 99.262%. The slight upper excess
reflects separately bracketed clock intervals. All rows remain, including
preemption. The approximately 4.50 kJ / 1.25 Wh battery integral spans the entire
1618.6-second experiment and background activity. It is neither per-codec energy
nor a comparable battery-efficiency result.

### Separate scalar encoder/decoder composition

Bitctz retains the bitpack encoder and original ctzunpack decoder in separate
objects. Against the matched scalar wordmixed control at 1024-byte blocks:

| Corpus | Compress ns/page, control → bitctz | Paired change | Decode ns/page, control → bitctz | Paired change |
|---|---:|---:|---:|---:|
| Sparse words | 8130.2 → 5930.1 | -26.75% | 5943.1 → 3917.4 | -34.34% |
| Words25 | 11465.9 → 6894.2 | -39.95% | 9596.6 → 4714.5 | -50.86% |
| Words50 | 16422.4 → 7781.6 | -52.61% | 14423.3 → 5454.6 | -62.01% |
| Mixed pages | 15984.6 → 15316.4 | -4.22% | 4088.8 → 3529.6 | -13.86% |
| Clusters50 | 7011.4 → 5394.8 | -23.21% | 4279.6 → 4354.1 | +1.81% |
| Clusters75 | 18257.5 → 16831.8 | -7.80% | 2902.7 → 3065.4 | +6.04% |

These paired changes are medians of three session changes, not ratios of the
pooled absolute medians. Thread CPU changes corroborate the listed gains/losses;
for sparse words they are -27.07% compression and -34.32% decoding. Bytes are
identical to wordmixed. The new clustered cases expose a real CTZ-decoder loss
that the earlier independent random-word densities did not reveal.

Against matched scalar LZ4, bitctz's sparse-word compression is 5930.1 versus
17037.3 ns (-65.25%), decoding 3917.4 versus 8034.2 ns (-51.26%), and output
660.844 versus 1081.359 bytes. Mixed pages improve 7.53% compression and 24.25%
decoding, with 2049.070 versus 2157.406 bytes. These wins do not generalize:
executable compression is 42738.2 versus 39507.8 ns (+8.00%), period127 is
5937.4 versus 3066.9 ns (+91.42%), and random compression regresses 67.78%.
Clusters75 regresses 4.99% compression and 9.94% decoding versus LZ4. Repeat16
and repeat32 still occupy 84/148 bytes versus LZ4's 42/58. All remaining absolute
results and [4,920 direct contrasts](../benchmarks/results/native-gzram-astra-local-003-timing/paired.md)
are retained. No workload-weighted overall improvement is established.

### Full masks and packing cutoffs

Bitfull adds the full-mask shortcut to bitctz's decoder. Clustered decoding
improves 17.59%, 26.83% and 11.75% for clusters25/50/75; clusters50 falls from
4354.1 to 3186.3 ns. The same change regresses ordinary sparse decoding 2.57%
(3917.4 → 4026.7 ns), words50 2.15%, and repeat16 8.21%. These losses occur in all
three sessions. The separately controlled ctzfull policy shows the same tradeoff.
The shortcut is useful for clustered masks, not a universally free fast path.

Per-mask scalar/vector selection is not accepted. Select2 improves sparse
compression 16.93% but regresses words25 10.27%; select3 improves sparse 18.23%
and words25 6.11% but regresses words50 5.41%. Select4 regresses words50 19.88%
(5788.4 → 6963.0 ns). All three regress clusters50 compression by 14.83–15.49%,
whereas unconditional mixed packing improves it 5.80%. This supports testing a
less frequent selection decision; it does not prove branch prediction is the
cause or establish a cutoff. A block-level decision using the scan's existing
population count is the next credible encoding experiment.

Repeatmergefast preserves repeatmerge's exact bytes and reduces its scalar
half-zero compression overhead by 3.68% (2846.5 → 2746.4 ns). Repeat16/32 scalar
compression improves only 1.21%/1.34%. It does not solve the scalar repeat decoder
or bitctz's short-repeat size loss. A separately controlled combination of the
bit-scan encoder, consolidated frames and a directly validated repeat decoder
is worth testing; no such combined policy is accepted by these measurements.

The first separate energy attempt completed two sessions before its outer
launcher deadline expired. Its standby resume was then rejected for mismatched
variant ordering. [All partial data and failure evidence](../benchmarks/results/native-gzram-astra-local-003-energy-interrupted/summary.md)
are retained. The fresh corrected cohort completed and passed its own audit (below). It does
not retroactively supply energy to this timing-only cohort.

## Full scalar hybrid kernel gate

The reference and bitpack/CTZ workspace ports now pass a full GHY1 exact-kernel
VM gate: two load/test/unload cycles, four workers and 207,818 assertions per
cycle. The [complete source, build/guest logs and limits](../benchmarks/results/gzram-hybrid-kernel-gate-001/summary.md)
include the initial attribute-macro failure and explicit normalization repair.
The unchanged scalar GZR1 gate also passes again. No host GZRAM module was loaded.
Native performance, energy, ZRAM integration and current recovery remain unproven.


## Completed third physical energy cohort

The [fresh energy cohort](../benchmarks/results/native-gzram-astra-local-003-energy/summary.md)
completed independently: 22 variants, 20 corpora, three sessions, nine recorded
rounds after two warm-ups, 128 pages/corpus and 8,192 calls/batch. Source remains
`1ee0e34`; hardware, compiler, CPU affinity and frequency limits match the
preceding timing cohort. Its own matched controls determine every comparison.
All 23,760 rows have RAPL package measurements, all PMU groups were fully
scheduled, and the artifact and unchanged CPU/ZRAM audit passed. No experimental
module was loaded and stock zstd ZRAM remains active.

The 1619.54-second run has a maximum telemetry gap of 0.555 seconds. Median
thread occupancy is 99.309%; the minimum is 30.124%, a preempted halfzero
repeatmergefast scalar decode in session 1, round 7. That row and every other
outlier remain in the data. The whole-experiment battery integral is about
6.81 kJ / 1.89 Wh, including desktop activity, validation and warm-ups. It is
not assigned to codecs or used to claim battery savings. RAPL likewise includes
background package activity during each batch; it is not isolated core energy.

### Sparse scalar gains confirmed, with the same limitations

Against matched scalar wordmixed at 1024-byte internal blocks, bitctz gives:

| Corpus / operation | Time ns/page, control → bitctz | Paired time change | Package µJ/page, control → bitctz | Paired energy change |
|---|---:|---:|---:|---:|
| Sparse / compress | 8134.1 → 5917.3 | -27.13% | 17.524 → 13.582 | -26.92% |
| Sparse / decode | 5938.6 → 3926.5 | -33.79% | 13.374 → 9.052 | -33.48% |
| Words25 / compress | 11457.8 → 6872.5 | -39.92% | 23.343 → 13.500 | -40.87% |
| Words25 / decode | 9606.3 → 4723.6 | -50.82% | 19.431 → 8.970 | -51.39% |
| Words50 / compress | 16417.5 → 7808.8 | -52.47% | 34.995 → 18.507 | -48.59% |
| Words50 / decode | 14412.9 → 5443.7 | -62.20% | 30.018 → 12.085 | -62.97% |

All six time and package-energy reductions have the same sign in all three
sessions. Thread CPU changes corroborate them: sparse compression/decode
-27.00%/-33.83%, words25 -39.95%/-50.83%, words50 -52.52%/-62.19%.
Output bytes remain identical to wordmixed. Absolute values are pooled medians;
percentage changes are medians of paired session effects, so they need not
equal ratios of those absolute medians. Session ranges and every contrast are
retained in [paired.json](../benchmarks/results/native-gzram-astra-local-003-energy/paired.json).

Mixed-page compression/decode improves 3.83%/14.03%, with package energy
-1.80%/-13.45%; the small compression-energy effect is not treated as a robust
standalone energy win. Clustered decoding still regresses: clusters50 1.87%
(4276.8 → 4353.7 ns), clusters75 5.72% (2901.3 → 3069.4 ns), all sessions.
Their energy changes have mixed signs, so no reliable energy direction is
established for those losses.

Matched LZ4 remains essential. On sparse words, bitctz uses 660.844 versus
1081.359 bytes (-38.89%), compresses in 5917.3 versus 17034.9 ns (-65.22%),
and decodes in 3926.5 versus 8026.2 ns (-50.77%). Package energy is 13.582
versus 37.759 µJ for compression (-64.50%) and 9.052 versus 18.016 µJ for
decoding (-49.02%). But executable compression regresses 8.00% and package
energy 4.90%, with 3250.602 versus 3242.602 bytes. Random compression regresses
67.15% and energy 58.99%; its 4104 versus 4114 bytes is still an expanded page.
Period127 compression regresses 92.32% and energy 88.50%, with 161 versus 153
bytes. These results do not establish an overall compressor or ZRAM improvement.

### Selection and repeat decisions

Bitfull's full-mask decoder shortcut again helps clusters25/50/75 decoding
17.15%/27.23%/12.32% versus bitctz, with package reductions
17.34%/31.27%/12.17%, all sessions. It still regresses words50 decoding 2.38%
and repeat16 decoding 6.96%; it is not a free general replacement.

Per-mask selection remains rejected as a default. Select2/3/4 regress
clusters50 compression 16.14%/15.20%/15.24%; select4 also regresses words50
19.98% and package energy 20.34%. Sparse benefits do not justify those losses.
The next block-level selection candidates use the already computed population
count once per independent block. Cutoffs two, three and four remain separate
experiments; none is assumed optimal.

Repeatmergefast's scalar repeat16/32 compression changes shrink to
-0.41%/-0.46% versus repeatmerge. Energy effects have mixed signs across sessions.
The earlier small speed differences remain provisional and no energy gain is
accepted. Longer repeat batches are still needed to assess measurement noise;
this means amortizing userspace measurement overhead, not a kernel batching
recommendation. New bitmerge and bitdirect candidates separately test composing
the sparse codec with consolidated repeat frames, then adding validated scalar
repeat expansion. Their correctness and size checks have passed (below); performance is unproven.

No queue, background compression worker or kernel SIMD path is introduced by
these candidates. Queue wait, scheduler overhead, kernel FPU state costs, cold
page access, memory-pressure responsiveness and actual ZRAM energy remain
unmeasured. The completed scalar kernel VM gate is correctness evidence only.


## Fourth candidate correctness checkpoint

All five follow-up policies passed [normal and ASan/UBSan validation](../benchmarks/results/gzram-astra-v4-validation-001/summary.md),
including independent decoding, guarded capacities, malformed/truncated input,
all masks, repeat tails and four-thread round trips. The full 521-variant
registry passed 1,333,760 round trips per build across all 20 corpora. Source
hashes remained unchanged during testing. All 30 preceding library text
sections and all 266,240 preceding per-page size records remain identical;
the [expanded size screen](../benchmarks/results/gzram-astra-v4-sizes-001/summary.md)
retains 317,440 records.

Blockpick2/3/4 preserve wordmixed's bytes and move scalar/vector packing selection
out of the per-mask loop. Bitmerge and bitdirect preserve repeatmergefast's bytes,
including 33-byte repeat16 and 49-byte repeat32 frames, while composing the
bitpack encoder and preserved CTZ decoder. Bitdirect alone adds validated scalar
repeat expansion. Those size reductions do not yet establish time or energy
gains, and nonrepeat decoding may regress.

The next physical cohort selects 21 variants at 1024-byte internal blocks,
including both entries of every new policy, LZ4, wordmixed, bitctz, the prior
repeat consolidation, mixpack, select3, bitfull and wordrepeat controls. All 20
corpora, three sessions and separate compression/decompression measurements
remain. This first matched comparison does not select a universal block size.
Current stock zstd ZRAM, CPU limits and boot configuration remain unchanged.

## Scalar syscall probe engineering checkpoint

The [isolated probe gate](../benchmarks/results/gzram-hybrid-probe-gate-001/summary.md)
now passes two exact-kernel VM cycles across all 20 preserved corpora, each with
101,071 client assertions and concurrent shared/private file contexts. The
original full scalar hybrid gate also passes again. The initial no_llseek build
failure and corrected source are retained. No host module was loaded.

The probe exposes one resident page per ioctl for matched private scalar LZ4,
wordmixed and bitpack/CTZ workspace ports, plus a mutex-protected no-op control.
It retains separate compressed buffers and validates cross-decoding outside
measurement. The fixture requests about 2.21 MB of payload/workspace per open,
plus context and allocator overhead; that is not a proposed ZRAM per-stream cost.
No queue, background worker, SIMD or FPU state management is introduced.
Native timing and energy have not been collected from this interface. A native
measurement client and current recovery verification remain required; the
userspace codec gains cannot be assigned to the adapted kernel implementation.

The [kernel measurement client](../benchmarks/results/gzram-hybrid-call-validation-001/summary.md)
now builds and passes two isolated cycles with all 20 corpus hashes and 26,444
assertions/cycle, including all-YMM preservation checks. Explicit VM timing is
rejected. Its native mode records separate compression/decompression, no-op
interface costs, thread CPU time, kernel-inclusive counters and package RAPL
under shuffled userspace vector conditions. No native measurements have yet
been collected; kernel FPU begin/end cost and real ZRAM remain outside this gate.

## Kernel FPU-state control gate

A separate [empty FPU-section control](../benchmarks/results/gzram-fpu-control-gate-001/summary.md)
now passes isolated interface/concurrency and register-state gates. Scalar codec
calls remain outside that section. Each of two interface cycles passes 101,073
assertions; each of two measurement-client cycles passes 29,084, covering all
20 corpus hashes, YMM registers, nondefault MXCSR and x87 control values. VM
timing is explicitly refused. All eight preceding codec object text sections
remain identical; only the probe interface/state-control code changes.

The opt-in control will allow matched native measurement of kernel FPU entry/
exit under cleared-before-loop, SSE-dirty and YMM-dirty userspace conditions.
No state-management latency, energy gain, batching benefit or SIMD crossover
has yet been measured. This adds no page queue and does not alter ZRAM.


## Fourth completed physical timing cohort

The [complete fourth timing cohort](../benchmarks/results/native-gzram-astra-local-004-timing/summary.md)
contains 22,680 rows: 21 variants, all 20 corpora, three sessions, two warm-ups
and nine recorded shuffled rounds, 128 pages/corpus and 8,192 calls/batch.
It uses frozen source `16803f6`, GCC 16.2.1, the physical N100's unchanged
7.2.11 kernel, powersave policy and 700–800 MHz limits. Codecs run on CPU0,
telemetry on CPU1, at nice 5 with UID 1000 and zero effective capabilities.
The artifact, complete-row and unchanged CPU/ZRAM audits passed. All PMU groups
were fully scheduled. No experimental host module was loaded.

The run lasted 1543.43 seconds, with maximum telemetry gap 0.545 seconds and
thread occupancy 91.984–100.406%, median 99.281%. Every row remains, including
preemption. The separately bracketed clocks can yield slightly over 100%.
Package energy is unavailable in every row. The approximate whole-experiment
battery integral is 4.07 kJ / 1.13 Wh, including desktop activity and setup;
it is neither per-codec energy nor a battery-efficiency comparison.

This separate unprivileged run proceeded while Fedora authentication for the
energy cohort remained pending. Both supervisors use the same exclusive lock.
The energy launcher's lock-wait limit was extended from 600 to 3600 seconds to
allow that serialization; its 2100-second measurement deadline still starts
after authentication and lock waiting. The change and original launcher are
retained privately, and the completed timing cohort records the queue decision.
The remote refresh after timing found no changed branch heads or newer SOL work.

### Combined scalar repeat handling is promising

Bitdirect retains bitpack encoding and the preserved CTZ decoder, consolidates
repeat frames, and directly expands fully validated scalar repeats. Against
matched bitctz at 1024-byte internal blocks:

| Corpus | Compress ns/page, bitctz → bitdirect | Paired change | Decode ns/page, bitctz → bitdirect | Paired change | Bytes/page |
|---|---:|---:|---:|---:|---:|
| Repeat16 | 1827.2 → 1844.4 | -0.38% (mixed signs) | 1866.8 → 410.6 | -78.02% | 84 → 33 |
| Repeat32 | 1810.1 → 1841.0 | +2.01% | 833.0 → 397.0 | -51.77% | 148 → 49 |
| Sparse words | 5926.0 → 5940.3 | +0.37% (mixed signs) | 3904.9 → 3945.8 | +0.30% | unchanged |
| Clusters50 | 5346.4 → 5288.4 | -1.10% | 4354.5 → 4398.2 | +1.10% | unchanged |
| Mixed pages | 15338.0 → 15344.1 | +0.10% (mixed signs) | 3517.0 → 3523.1 | +0.67% | unchanged |

Percentage changes are medians of paired session effects; absolute values are
pooled medians, so their ratios need not equal the percentages. Repeat16 decode
changes span -78.03..-78.01% across sessions, repeat32 -52.43..-51.67%.
Thread CPU changes corroborate those gains (-78.00%/-51.91%). Repeat32
compression CPU time regresses 1.79%; repeat16 compression has no accepted gain.
The small nonrepeat decode losses are retained, including all-session losses on
clusters50, mixed pages and sparse words. Energy for this candidate is unproven.

Bitmerge is the exact-byte control without direct expansion. Its repeat16/32
decoding regresses 14.13%/6.40% versus bitctz, despite the smaller frames.
Bitdirect improves decoding 80.76%/54.22% against that control, with identical
bytes. Against the earlier wordrepeat scalar decoder, bitdirect improves
repeat16/32 decoding 25.85%/21.87% (557.0 → 410.6 and 517.0 → 397.0 ns), but
compression regresses 0.97%/2.62%. This is a measured composition benefit with
tradeoffs, not a universally faster encoder.

Matched LZ4 comparisons remain mixed:

| Corpus / operation | LZ4 ns/page → bitdirect | Paired time change | LZ4 bytes → bitdirect |
|---|---:|---:|---:|
| Repeat16 / compress | 2581.1 → 1844.4 | -28.51% | 42 → 33 |
| Repeat16 / decode | 1990.8 → 410.6 | -79.39% | 42 → 33 |
| Repeat32 / compress | 2678.7 → 1841.0 | -31.06% | 58 → 49 |
| Repeat32 / decode | 1110.1 → 397.0 | -64.09% | 58 → 49 |
| Sparse / compress | 17129.7 → 5940.3 | -65.28% | 1081.359 → 660.844 |
| Sparse / decode | 8034.4 → 3945.8 | -51.02% | 1081.359 → 660.844 |
| Executable / compress | 39578.9 → 42793.5 | +8.06% | 3242.602 → 3250.602 |
| Random / compress | 4591.9 → 7764.1 | +68.97% | 4114 → 4104 |
| Period127 / compress | 3086.6 → 5881.3 | +94.02% | 153 → 161 |
| Clusters50 / decode | 3891.1 → 4398.2 | +13.11% | 2273.391 → 2205 |

Both random outputs exceed a page. Clusters75 also loses 4.76% compression and
10.41% decoding against LZ4. Smaller framed bytes do not establish smaller
zsmalloc allocation classes. Repeat8's large decoder gain is not a native swap
claim because ZRAM's same-filled-page bypass can avoid that codec operation.
No workload-weighted overall, native ZRAM or production improvement is accepted.

### Block-level population cutoffs remain a tradeoff

AVX2 compression changes against matched wordmixed, with identical bytes:

| Corpus | Blockpick2 | Blockpick3 | Blockpick4 |
|---|---:|---:|---:|
| Sparse words | -12.09% | -11.82% | -11.44% |
| Words25 | +2.94% | +2.38% | +2.84% |
| Words50 | +2.76% | +2.94% | +11.27% |
| Clusters25 | +9.46% | +7.27% | +7.19% |
| Clusters50 | +7.87% | +6.25% | +3.56% |

All listed effects have the same sign in all three sessions and corresponding
CPU-time changes. Blockpick3 reduces the earlier select3 clustered penalty by
7.17% on clusters50, but loses 8.37% on sparse words and 9.32% on words25 versus
select3. Against unconditional mixpack it loses 12.17% on sparse words and
13.87% on clusters50, while improving words50 9.21%. No cutoff is accepted as
a default. All [4,640 direct contrasts](../benchmarks/results/native-gzram-astra-local-004-timing/paired.md)
remain available, including unchanged paths and losses.

Disassembly confirms an indirect `call *%rbx` inside blockpick3's AVX2 packing
loop (object offset 0x11e5), despite selecting its target only once per block.
The mask read, call, popcount-derived byte advance and loop branch are retained
in the [object disassembly](../benchmarks/results/native-gzram-astra-local-004-timing/blockpick3-encoder.asm).
This does not prove the cause of the regressions. Direct scalar/vector loops
selected outside the group loop are the next credible encoding experiment;
code size, inlining and branch changes must be measured rather than assumed.

Bitdirect's AVX2 entry still beats its scalar entry on repeat16/32 decode by
37.70%/40.81% (410.6 → 263.3 and 397.0 → 235.0 ns), but loses 8.72% on sparse
decode and 9.52% on words50 decode. These are userspace differences. The kernel
FPU controls are intended to measure relevant costs, not to add a fixed historical
constant to these numbers. Bitdirect is a promising userspace candidate awaiting
energy confirmation and its own kernel-port validation; it is not a new default.

## Full scalar work inside kernel FPU handling: isolated gate

The [new correctness checkpoint](../benchmarks/results/gzram-full-fpu-control-gate-001/summary.md)
extends the empty FPU control to the same scalar LZ4, wordmixed and bitctz
operations inside a bounded one-page FPU section. All eight codec object text
sections are unchanged. Two load/test/unload cycles passed per client: 162,513
interface assertions and 44,924 measurement-client assertions per cycle across
all twenty corpora. Shared/private file concurrency, frame integrity and the
listed YMM/MXCSR/x87 preservation checks passed; VM timing remained prohibited.
The first client compilation failure and its source are preserved alongside the
successful second build. No native host module was loaded or stock settings
changed. This prepares matched whole-call FPU-cost measurements; it does not
establish a kernel speedup, batch crossover, recovery coverage or ZRAM gain.

## Fifth candidate set: direct scalar and AVX2 packing loops

The fourth run's indirect-call observation motivated three additive
`blockdirect2/3/4` policies. They retain the matching blockpick cutoff and
format while using separate direct scalar/vector block loops. The previous
implementations remain controls. This changes call placement, inlining and
potential vector transitions together; instruction count alone cannot establish
why any future performance difference occurs.

Normal and ASan/UBSan checks passed all 569 registry variants across twenty
corpora and 128 pages: 1,456,640 round trips per build. Each new cutoff passed
39,424 dedicated cross-path round trips, 39,376 guarded capacities, 72 cutoff
boundary pages, 71,680 independent mask cases, 48,576 repeat boundaries,
80,000 malformed/mutated decodes and 4,000 threaded round trips per build.
All 35 previous library text sections match. The new policies preserve their
controls' bytes; no format-version change or cross-page dependency is introduced.
The [fifth validation checkpoint](../benchmarks/results/gzram-astra-v5-validation-001/summary.md)
and [size matrix](../benchmarks/results/gzram-astra-v5-sizes-001/summary.md)
retain complete evidence. Timing and energy for these candidates remain pending.

## Bitdirect scalar workspace and kernel correctness checkpoints

The [workspace port](../benchmarks/results/gzram-bitdirect-scalar-port-001/summary.md)
passed normal and sanitizer checks against the measured fourth-cohort codecs,
including independent decoding, exact encoder bytes, old-decoder compatibility,
workspace poisoning/reuse/rejection and concurrent private owners. Workspace
remains 4,128 bytes aligned to eight bytes. The default wordmixed adapter's
machine-code text is unchanged; bitmerge remains the same-byte control.

The [exact-kernel gate](../benchmarks/results/gzram-bitdirect-kernel-gate-001/summary.md)
then passed two isolated load/test/unload cycles, each with four concurrent
workers and 321,855 total assertions. Independently constructed short/tail/full
repeat frames, truncations, capacity failures and every-bit header mutations
exercise the new shortcut against its old-decoder control. No SIMD instructions
occur in these scalar kernel objects. This remains a prototype correctness gate,
not native kernel timing, recovery validation, ZRAM performance or production
readiness. Host CPU/ZRAM hashes are unchanged; no host experimental module was
loaded. Current privileged recovery inspection and physical kernel tests remain
open while the next userspace packing cohort proceeds.
