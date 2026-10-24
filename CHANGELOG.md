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
