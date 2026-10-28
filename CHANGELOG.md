# Changelog

## Additive GZRAM continuation, 2026-10-28

- Preserve SOL's latest checkpoint and all prior codec text and result files.
- Add isolated outlined-classifier and sparse bit-scan decoder experiments.
- Repair full-registry shuffle capacity and validate the benchmark with sanitizers.
- Add exhaustive mask/truncation cases, density/mixed corpora and thread CPU accounting.
- Retain normal/ASan/UBSan validation and 114,688 independently checked size records.
- Keep timing and kernel trials pending access to the existing native test lock
  and verification of the intended target's changed environment and recovery.

## Initial research and native harness

- Located existing custom kernel and actual active Fedora configuration.
- Inspected Trueno-ZRAM and Aprender LZ4 implementations and licenses.
- Added exact kernel LZ4 baseline and reproducible SIMD variant generator.
- Added native timing harness, differential correctness and guard-page tests.
- Preserved initial N100 timing results, including sparse compression regressions.
- Documented pending privileged access, kernel integration and recovery checks.

## Kernel integration and repeated native measurements

- Added scalar-first dispatch and copy-only experiments with three native sessions.
- Added cycle counters, real executable pages, checkpoints and thermal sampling.
- Added independent liblz4 concurrency, ASan and UBSan validation.
- Added namespaced kernel probe, scalar fallback and optional ZRAM backend patch.
- Compiled both modules and passed diskless VM ZRAM readback tests.
- Fixed patch generation to filter existing build artifacts from source inputs.

## State preservation and controlled native pressure baseline

- Verified all 16 YMM registers across concurrent direct kernel ZRAM I/O in SMP VM.
- Verified runtime scalar fallback with AVX2 disabled and inside an active FPU section.
- Added 2,048 in-kernel malformed/truncated differential checks with canaries.
- Added shared-lock supervision and three bounded native memory-pressure sessions.
- Retained longer-guard and scalar-unroll regressions from experiment 003.
- Started native Gracemont compiler-scheduling comparisons without changing ISA
  support in the scalar baseline.

## Compiler-tuning and reproducibility checkpoint

- Completed 14-variant native Gracemont scheduling comparisons; no universal win.
- Preserved historical benchmark/generator sources and all raw timing CSVs.
- Verified the current patch in a diskless SMP VM and its disabled build path.
- Recorded added code footprint without claiming resident-memory measurements.
- Native optimized-kernel acceptance remains pending administrator access and
  verified physical recovery; existing ZRAM and boot defaults remain intact.

## Overlap-copy evaluation and timed-corpus validation

- Completed 16-variant native comparisons and sanitizer/interoperability suites.
- Rejected short-overlap broadcasts for the kernel candidate after reproducible
  mixed-data regressions; kept source/results to avoid repeating the experiment.
- Added full byte-for-byte preflight checks for each timed corpus and a
  validation-only mode that preserves corpus PRNG advancement.
- Strengthened VM YMM sentinels so every vector register has a distinct pattern.
- Rechecked existing administrator routes: sudo and noninteractive PolicyKit both
  require authentication. Physical kernel acceptance remains externally blocked.

## Authenticated native kernel baseline and recovery preparation

- Verified administrator access and installed perf, fio and the exact running
  kernel-devel package from Fedora's signed archive with signature checking.
- Added isolated root ZRAM I/O tests, full-device CRC32C verification, package RAPL
  measurements and kernel-only profiles. Completed three trials for lzo-rle/LZ4.
- Added a benchmark-only misc interface for per-page calls with dirty user SIMD
  state; compiled on the exact 7.0.10 ABI and passed diskless VM validation.
- Added recovery backup/restore and reboot observation tools. The controlled stock
  reboot did not restore SSH within five minutes; physical screen state is needed
  before any further native experiment. No experimental module has been loaded.

## Physical recovery and kernel codec checkpoint

- Diagnosed the ACPI reboot powering off; observed PCI stock restart and deliberate
  panic return to the saved stock kernel, with archived EFI panic records.
- Preserved both stock BLS entries and default; documented recovery scope.
- Kept SELinux enforcing and used the normal module-file label after a denied
  attempt from the home directory.
- Passed three native exact-ABI codec sessions with dirty user SIMD state and
  full-register checks; recorded substantial regressions rather than deploying
  the initial candidate to ZRAM.
- Made the watcher reject units lost across a reboot and checkpoint cleanup.

## Matched SIMD-state controls and scalar copy experiments

- Measured rebuilt scalar, FPU-bracketed scalar and SSE2 in three N100 sessions
  each. Preserved raw data and all negative SIMD findings.
- Added isolated variant generation and integer-only long-match experiments.
- Tested distance-one memset (no useful measured gain), then eight-byte repeated
  stores (large half-zero gain with sparse regressions); neither is selected.
- Added a separate default-off scalar ZRAM backend generator and three-backend
  stock-7.2.8 VM validation. Extended the VM harness to verify each named backend.

## Native ZRAM I/O, recovery fixes and controlled pressure

- Published installed-stock 7.2.8 baseline and both five-trial experimental
  comparisons, including AVX2 regressions and unsuccessful first-match selection.
- Diagnosed automatic swap reactivation, transient block-device references and
  inherited-log SELinux denial; kept enforcement and restored signed stock code.
- Added bounded unload/reset retries, temporary runtime unit masks, live module
  build-id verification and a persistent controller retaining the native lock.
- Added byte-verified mixed/periodic pressure workloads, cgroup health counters,
  resumable trial checkpoints, four physical CPU/register helpers and telemetry.
- Passed the stock pressure smoke check; full backend pressure trials are running.

- Completed all forty pressure trials with 160 physical-CPU helper processes,
  no OOM or detected corruption, and verified restoration. Published all timing,
  energy, CPU, memory and telemetry results, including inconclusive/regressing
  cases. No candidate is promoted to routine use.

## Independent repository checkpoint

ZRAM history was extracted into chevydan6/n100-zram; subsequent development
is independent of fedora-gracemont. Eight prior commits plus the migration
checkpoint preserve source, measurements, regressions and authorship.
Latest O2 controls and initialized-workspace reuse prototypes are experimental.
Correction: the kernel LZ4 Makefile explicitly selects -O3 even when global
kernel configuration selects -O2. O2 probes are alternative-codegen experiments,
not stock-matched optimization controls. No broad native gain is established.

### Smaller-table experiment preparation

Added private 4 KiB full-reset compression variants with 8, 4 and 2 KiB hash
arrays, retaining standard LZ4 block compatibility and the baseline decoder.
The benchmark permits changed compressed encodings only in this explicit mode,
checks independent baseline decoding and preserves measured compressed sizes.
No performance or compression-ratio improvement is claimed before native runs.

### Native scalar backend / adaptive SIMD investigation

Added reproducible default-off scalar small-table kernel patch and isolated build
manifest; exact-ABI diskless validation passed. Corrected default-algorithm parsing
in the native runner and retained the failed attempt with verified restoration.
A separate adaptive branch records the initial native scalar/SSE2/AVX2 size sweep
and PMU counters. Further refinement and kernel-context costs remain experimental.

## GZRAM-AVX2 prototype checkpoint

Added versioned userspace format, raw framing, eight internal block sizes,
independent scalar/AVX2 encoders/decoders, guarded Python-oracle tests, sanitizer
CI, native comparison fixture and resumable sessions. No kernel deployment or
performance improvement is claimed. Upstream projects are research references;
no upstream code or generated shuffle tables were copied into the new codec.

## 2026-10-25 — GZRAM hybrid ratio recovery iterations

- Preserved the original codecs and added versioned GHY1 GZRAM/LZ4/raw policies.
- Published 19-variant and 27-variant three-session N100 screens, including
  mixed-pattern ratio failures, classifier overhead and all codec-mode counts.
- Reported both absolute pooled and paired timing estimates.
- Validated fused-prefix and independent sparse/repeat decoder prototypes with
  normal, guarded, concurrent, malformed-input and sanitizer checks.
- Kept userspace codec costs separate from kernel SIMD state measurements.

## 2026-10-28 — Astra local matched codec results

- Published three physical-N100 sessions, all 12,960 rows and 1,472 direct
  contrasts, with thread CPU time, user PMUs and continuous system telemetry.
- Confirmed substantial sparse-decode gains at identical bytes; retained the
  outlined-classifier regression and every LZ4 speed/size loss.
- Audited frozen artifact hashes and unchanged live zstd ZRAM/CPU policy.
- Preserved missing package energy and whole-experiment battery scope explicitly.
- Added known-ratio analysis fixtures and local cohort auditing; no kernel
  deployment, application responsiveness or production acceptance is claimed.

## 2026-10-28 — Word paths, repeat consolidation and package-energy screening

- Added five independently selectable candidates, preserving all eighteen prior
  library code sections and all preceding size records/corpus hashes.
- Passed normal and sanitizer boundary, independent-decoder, malformed, concurrent
  and complete-registry tests; published 165,376 independently decoded size rows.
- Published 19,278 native timing/CPU/RAPL rows and 3434 direct comparisons, with
  scalar packing/repeat wins and mixed-packing/composition/consolidation losses.
- Added a privilege-dropping read-only RAPL descriptor helper; retained the
  rejected launch caused by an inhibitor closing that descriptor.
- Prepared and userspace-validated an isolated scalar GZR1 component adapter;
  no kernel build, VM execution, native module load or ZRAM replacement is claimed.

## Clustered-mask candidates, 2026-10-28

- Add full-mask decoding, separate-object encoder/decoder composition, three
  scalar/vector packing cutoffs, and earlier repeat-consolidation rejection.
- Preserve all prior library text, corpus hashes and size records.
- Pass normal/sanitizer, independent decoding, boundary, mutation and concurrency
  checks; retain the interrupted validation and its verified resumption.
- Record the measured half-zero regression from globally increasing block size.
- Keep performance acceptance pending the next matched physical N100 cohort.

## Scalar kernel component gate, 2026-10-28

- Compile separately namespaced, matched reference/CTZ GZR1 scalar components.
- Pass two four-worker load/test/unload cycles in an exact-kernel diskless guest.
- Preserve source hashes, build/guest logs, canary limitations and host postflight.
- Leave native recovery, GHY1/LZ4, SIMD and ZRAM integration unproven.

## Third physical timing cohort, 2026-10-28

- Complete and audit 23,760 rows across 22 variants and 20 corpora.
- Measure separate scalar bitpack/CTZ composition gains and clustered losses.
- Retain full-mask tradeoffs, failed per-mask cutoffs and consolidation overhead.
- Preserve every row and 4,920 direct contrasts; package energy is unavailable.
- Keep the separately running energy cohort and kernel gates distinct.

## Full scalar hybrid kernel gate and retained energy interruption

- Pass two 207,818-assertion GHY1 VM cycles with explicit private workspace.
- Preserve the first kernel build failure and the attribute-token repair.
- Recheck the original scalar VM gate; keep host ZRAM unchanged.
- Preserve two complete energy sessions, a partial third and controller errors;
  no accepted energy claim is derived from this interrupted cohort.
