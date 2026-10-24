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
