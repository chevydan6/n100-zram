# Experimental native ZRAM SIMD research for Intel N100

This branch investigates native kernel LZ4 acceleration on Gracemont. It currently
contains a user-space research harness built from the existing custom kernel's
LZ4 sources, plus independently written SSE2/AVX2 comparisons and bounded copies.
It has **not** yet improved or replaced the running kernel ZRAM backend.

Requirements: x86-64 Linux, Python 3, GCC, glibc development headers. AVX2 and OS
YMM state support are required for the full suite. No external Python packages.

```sh
cd zram
python3 tools/build.py
python3 tests/check.py
python3 tests/guard.py
gcc -O2 -Wall -Wextra benchmarks/native.c -ldl -o build/native
./build/native build > measurements.csv
```

The benchmark verifies CPUID AVX2 and XGETBV, pins to one allowed CPU and shuffles
variant order. The test scripts currently require AVX2-capable hardware too.
Do not run this research harness as a kernel module. Kernel installation and
integration instructions will follow verified recovery and kernel testing.

See [STATUS](STATUS.md), [BENCHMARKS](BENCHMARKS.md),
[ARCHITECTURE](ARCHITECTURE.md), [RECOVERY](RECOVERY.md), and [CHANGELOG](CHANGELOG.md).
Generated binaries stay outside version control. Raw host logs and credentials
are excluded from publication. All performance conclusions must use the N100.

### Kernel compile and isolated validation

These are experimental instructions; deployment is pending native recovery and
administrator access. Use the exact existing custom kernel source and headers.

```sh
python3 tools/build.py
python3 tools/prepare-kernel.py
make -j2 -C /usr/src/kernels/7.2.8-n100v1.fc44 M="$PWD/build/kernel" modules
python3 tools/prepare-zram-patch.py --reference /path/to/linux-7.2.8/drivers/block/zram --output /fresh/isolated/zram-source
make -j2 -C /usr/src/kernels/7.2.8-n100v1.fc44 M=/fresh/isolated/zram-source CONFIG_ZRAM_BACKEND_LZ4_N100=y KCFLAGS=-DCONFIG_ZRAM_BACKEND_LZ4_N100=1 modules
```

The compile-only Kconfig override above enables the optional code against existing
headers. For a full kernel build apply `patches/0001-experimental-lz4-n100-backend.patch`
and enable `CONFIG_ZRAM_BACKEND_LZ4_N100` through the normal configuration process.
Do not replace the active swap module. Keep the existing default compressor.
The backend is named `lz4-n100`; it is not added as a default-compressor choice.
The probe has no ZRAM registration and must be unloaded before the integrated
module, which defines the same namespaced routines. `tests/vm.py --help` describes
the diskless correctness fixture inputs; no native performance claim is made.

Additional validation: `python3 tests/interop.py`, `python3 tools/sanitize.py`.
`tools/run-native.py` runs bounded tests and three benchmark sessions with atomic
checkpoints in `build/run`; archive that directory before changing sources.
Launch it through a systemd user service to survive SSH disconnection.
