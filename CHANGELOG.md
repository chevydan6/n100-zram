# Changelog

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
