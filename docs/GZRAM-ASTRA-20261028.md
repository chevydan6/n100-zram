# GZRAM continuation: outlined classification and sparse decoding

Branch: `feature/n100-gzram-astra-paths`, based on SOL's `e119f82`.
This is a prototype development checkpoint, not a new measured performance win.
The latest accepted measurement record remains [SOL's report](GZRAM-20261028.md).

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
handling are excluded. CPU use, speed, package energy, battery energy and
responsiveness of the additions are still unmeasured. A preliminary size export
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
comparing executable or mixed-page results across hosts. CPU-time collection is
implemented for the next timed cohort, not populated with synthetic values here.

## Next controlled experiment and kernel decision

First acquire the original exclusive lock and inspect live jobs, ownership,
kernel, CPU settings, swap, source fingerprints and recovery records. Confirm
whether the intended test target is the earlier lab or this differently
configured laptop. Preserve its actual baseline. Run a fresh matched cohort
with both candidates, wordmixed, splittail, guard32/mixed, fast GZRAM and scalar
LZ4 controls across all twelve existing corpora plus the new 25%, 50% and 75%
nonzero-word and interleaved mixed-page corpora. All twelve original corpus
hashes are unchanged; all sixteen are independent of variant selection and
shuffle seed. Use three sessions,
nine shuffled recorded rounds and separate encode/decode timing, bytes, CPU,
PMU scheduling fractions and available package energy. Retain every regression.
An expanded density sweep is needed before selecting any sparse/dense cutoff.

Kernel integration is conditional on whole-codec profitability. It requires
bounded per-stream workspace, kernel-safe copies, explicit scalar fallback,
separate vector translation units, and measured SIMD state handling for clean
and dirty register states. Follow isolated correctness, exact-ABI VM tests and
only then controlled native trials with current recovery verification. Lzo-rle
and matched LZ4 must be compared on real reclaim and response latency, memory
including allocator overhead, CPU, package energy and stability. The current
machine's zstd is an additional baseline to preserve if it becomes the target.

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
