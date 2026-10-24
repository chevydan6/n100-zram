# Experimental native ZRAM SIMD research for Intel N100

This branch investigates native kernel LZ4 acceleration on Gracemont. It currently
contains a user-space research harness, an optional kernel ZRAM backend and a
namespaced kernel test module built from the existing custom kernel's LZ4 sources,
plus independently written SSE2/AVX2 comparisons and bounded copies.
It has **not** yet improved or replaced the running kernel ZRAM backend.

Requirements: x86-64 Linux, Python 3, GCC, glibc development headers. AVX2 and OS
YMM state support are required for the full suite. No external Python packages.

```sh
cd zram
python3 tools/build.py
python3 tests/check.py
python3 tests/guard.py
gcc -O2 -Wall -Wextra benchmarks/native.c -ldl -o build/native
./build/native build --validate-only
./build/native build > measurements.csv
```

The benchmark verifies CPUID AVX2 and XGETBV, pins to one allowed CPU and shuffles
variant order. The test scripts currently require AVX2-capable hardware too.
Do not run this research harness as a kernel module. Kernel deployment instructions remain pending verified physical recovery and
native kernel testing. Compile and diskless validation steps are provided below.

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

### Native kernel I/O baseline

Administrator access now permits a dynamically allocated test ZRAM device. The
harness rejects an existing output directory, checks that its new device is not
swap, verifies complete-device CRC32C after every trial, and removes its own test
device. The active swap device is preserved.

```sh
sudo dnf install --setopt=install_weak_deps=False perf fio
sudo python3 benchmarks/kernel-io.py --output /fresh/private/lab-results --profile
python3 benchmarks/summarize-kernel-io.py /fresh/private/lab-results benchmarks/results/local-run
```

The exact running-kernel development package was obtained from Fedora's
[signed archive](https://kojipkgs.fedoraproject.org/packages/kernel/7.0.10/201.fc44/data/signed/6d9f90a6/x86_64/kernel-devel-7.0.10-201.fc44.x86_64.rpm)
and installed with local package signature checking enabled. No kernel package
was replaced. See BENCHMARKS.md for the actual native baseline and its limitations.

`kernel/bench.c` and `benchmarks/kernel-call.c` add a benchmark-only misc interface
for one-page scalar/SIMD calls. Build the module with `tools/prepare-kernel.py`
against exact matching kernel-devel, and build its user harness with:

```sh
gcc -O2 -Wall -Wextra -Werror -mno-avx -fno-tree-vectorize -Ikernel benchmarks/kernel-call.c -o build/kernel-call
```

Its physical execution is gated on verified recovery. The current controlled
stock reboot did not restore SSH; see RECOVERY.md. Source and VM validation do
not constitute a successful native kernel experiment.
