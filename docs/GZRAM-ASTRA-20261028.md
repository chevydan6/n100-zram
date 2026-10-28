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

## Follow-up candidates and kernel decision

[Five isolated word-path candidates](../gzram/docs/WORD-PATHS.md) investigate
integer repeat expansion, sparse packing, mixed AVX2-scan/scalar-pack encoding,
and consolidation of identical repeated blocks. Consolidation reuses GZR1's
existing 4096-byte block representation; old decoders remain applicable. New
normal/sanitizer tests and an independent per-page size audit are queued before
any timing. A fresh 21-variant, seventeen-corpus cohort includes repeat16,
matched wordmixed/ctzunpack/LZ4 controls and 1024/4096-byte repeat contrasts.
Its 8192-call measurement batches are explicitly recorded, not assumed equivalent
to historical absolute timing. Small effects and short-batch energy need longer
matched confirmation.

A read-only RAPL descriptor handoff passed a live access check: real/effective/
saved UID and GID were all 1000, effective capabilities were zero, and the child
read the counter successfully after privilege was dropped. It changes no sysfs
permissions. The next codec run can measure package energy as the normal user;
authentication and validation are outside its timing. This is access evidence,
not yet a candidate energy measurement.

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
