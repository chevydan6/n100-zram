# Experimental native ZRAM SIMD research for Intel N100

This branch investigates native kernel LZ4 acceleration on Gracemont. It currently
contains a user-space research harness, an optional kernel ZRAM backend and a
namespaced kernel test module built from the existing custom kernel's LZ4 sources,
plus independently written SSE2/AVX2 comparisons and bounded copies.
Native experimental backends have been tested and restored to stock afterward.
No broad end-to-end performance improvement has been established; see BENCHMARKS.md.

Experimental GZRAM development is in [`gzram/`](gzram/). The
[latest local N100 checkpoint](docs/GZRAM-ASTRA-20261028.md) records measured
scalar/SIMD tradeoffs, raw results and correctness gates; [SOL's baseline](docs/GZRAM-20261028.md)
remains intact. GZRAM is a prototype and is not the laptop's active ZRAM codec.

Requirements: x86-64 Linux, Python 3, GCC, glibc development headers. AVX2 and OS
YMM state support are required for the full suite. No external Python packages.

```sh
git clone https://github.com/chevydan6/n100-zram.git
cd n100-zram
python3 tools/build.py
python3 tests/check.py
python3 tests/guard.py
gcc -O2 -Wall -Wextra benchmarks/native.c -ldl -o build/native
./build/native build --validate-only
./build/native build > measurements.csv
```

The benchmark verifies CPUID AVX2 and XGETBV, pins to one allowed CPU and shuffles
variant order. The test scripts currently require AVX2-capable hardware too.
The user-space harness does not manage kernel SIMD state. Use only the separate
kernel integration for kernel tests. Compile and diskless validation steps are below.

See [STATUS](STATUS.md), [BENCHMARKS](BENCHMARKS.md),
[ARCHITECTURE](ARCHITECTURE.md), [RECOVERY](RECOVERY.md), and [CHANGELOG](CHANGELOG.md).
Generated binaries stay outside version control. Raw host logs and credentials
are excluded from publication. All performance conclusions must use the N100.

### Kernel compile and isolated validation

These are experimental instructions. PCI reboot and panic recovery were tested
on the dedicated N100; arbitrary hangs are not recoverable without an external
mechanism. Use source and headers matching the test kernel exactly.

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

Native syscall and swap tests are recorded in BENCHMARKS.md, including regressions.
Recovery limitations and the subsequently verified PCI reset are in RECOVERY.md.

### Reproduce matched kernel controls

After `tools/build.py`, generate each diagnostic into its own directory:

```sh
python3 tools/prepare-kernel.py --variant scalar-control --output build/kernel-scalar-control
python3 tools/prepare-kernel.py --variant scalar-fpu --output build/kernel-scalar-fpu
python3 tools/prepare-kernel.py --variant sse-guard --output build/kernel-sse-guard
python3 tools/prepare-kernel.py --variant scalar-rep8 --output build/kernel-scalar-rep8
```

Build each against the exact target kernel-devel ABI using the external-module
command above, then run `tests/vm.py --probe-only` with that exact kernel image,
probe and matching LZ4 dependencies. `kernel-call.c` builds with `-O2 -mno-avx
-fno-tree-vectorize -Ikernel`; execute it against the loaded probe's root-only
misc device. `tools/run-kernel-call.py` records three sessions and cleanup, and
`tools/summarize-kernel-call.py --label NAME` exports the public CSV/summary.
Keep private kernel logs outside Git. Recovery and SELinux module-file placement
are documented in RECOVERY.md. These probe modes do not change active ZRAM.

For a separate scalar `lz4-rep8` backend, first generate the normal optional
AVX2 backend tree, then add the scalar decoder into a fresh output:

```sh
python3 tools/prepare-rep8-backend.py --source /fresh/avx2-zram-tree --output /fresh/combined-zram-tree
make -j2 -C /usr/src/kernels/EXACT-RELEASE M=/fresh/combined-zram-tree CONFIG_ZRAM_BACKEND_LZ4_N100=y CONFIG_ZRAM_BACKEND_LZ4_REP8=y 'KCFLAGS=-DCONFIG_ZRAM_BACKEND_LZ4_N100=1 -DCONFIG_ZRAM_BACKEND_LZ4_REP8=1' modules
```

This keeps `lz4`, `lz4-n100` and `lz4-rep8` available for comparison in one driver;
`lz4-rep8` retains stock compression and changes only decoding. The manifest
records generated-source hashes. The long-copy prototype has measured sparse
regressions and remains experimental. `--decoder scalar-matchrep8` selects the
subsequent match-only experiment after generating its kernel source directory.
`scalar-selectrep8` is the unsuccessful first-match selector;
`scalar-branchrep8` is the later short-offset branch experiment. Each requires
its corresponding `prepare-kernel.py --variant NAME --output build/kernel-NAME`
source before backend generation.
Use `tests/vm.py --algorithms lz4 lz4-n100 lz4-rep8` before physical loading.

### Controlled native pressure comparison

`benchmarks/kernel-pressure.py` allocates its own temporary ZRAM device, uses a
bounded systemd cgroup and checks every byte in three permuted passes. It tests
both the original periodic-tail corpus and a mixed corpus including zero tails
and incompressible pages. Four concurrent helpers check all YMM registers on the
four physical CPUs before each trial. The cgroup health record must show no OOM.

Compile `benchmarks/pressure.c` and `tests/fpu-state.c` with `-O2 -Wall -Wextra
-Werror` (also `-mno-avx` for the register helper). Stage the binaries under
`/usr/local/libexec/n100-zram-lab/` and restore normal labels. Native orchestration
requires exact-ABI VM validation and the recovery procedure in RECOVERY.md.
`tools/run-kernel-zram.py --mode pressure --pressure-binary PATH --state-helper PATH
--benchmark /path/to/kernel-pressure.py --repeats 5` uses the same module/hash/output
arguments as its I/O mode, temporarily replaces the driver and verifies stock
restoration. It compares all four backends in one driver build.

Run the controller independently with `systemd-run --user --no-block` and
`tools/watch-kernel-job.py`, using the existing native-validation lock. The root
job and watcher must both have bounded timeouts long enough for all trials.
`benchmarks/summarize-kernel-pressure.py INPUT OUTPUT` exports completed results
and continuous CPU/thermal telemetry while excluding private swap paths.
The 768 MiB / 384 MiB cgroup test is real controlled reclaim on the installed
4 GiB system; it does not claim whole-machine memory exhaustion.

## Independent project

This repository contains the extracted ZRAM development history from
`chevydan6/fedora-gracemont`. No checkout, script, artifact, issue tracker or CI
workflow from that repository is required. See [migration](docs/MIGRATION.md),
[licensing](docs/LICENSING.md), and [release policy](docs/RELEASES.md).

Install GCC, Python 3, libc headers and the liblz4 runtime for interoperability
tests (`sudo dnf install gcc python3 glibc-devel lz4-libs` on Fedora). Native
kernel tests additionally require exact matching kernel-devel, make, perf, fio,
root access, and a verified recovery path. Configure SSH hosts and private output
directories explicitly; no host credentials ship with the project.

For workspace-reuse experiments, after the ordinary build:

```sh
python3 tools/prepare-reuse.py
python3 tests/reuse.py
```

These prototypes expose a private initialized-workspace API for 4 KiB pages.
They have not been integrated into ZRAM. User-space measurements exclude kernel
FPU costs and cannot establish native swap improvements.

Smaller full-reset hash-table experiments (different compressed bytes are
permitted, standard LZ4 compatibility is required):

```sh
python3 tools/prepare-small-table.py
python3 tests/small-table.py
```

The 8, 4 and 2 KiB arrays are private-ABI prototypes; changing hash-table size
can affect compression ratio. Compare retained compressed-size measurements
and fixed-page controls before considering any native kernel integration.
