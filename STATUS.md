# Current status

Experimental native-kernel LZ4 SIMD code and an optional `lz4-n100` ZRAM backend
are implemented and compiled. Correctness passed in a diskless SMP VM; physical
N100 user-space codec tests and stock lzo-rle pressure baselines also passed.
**No native optimized-kernel ZRAM improvement is established.**

## Measured target and environment

- Intel N100, four Gracemont cores, approximately 3.7 GiB usable RAM.
- Fedora, active stock `7.0.10-201.fc44.x86_64`, Xfce desktop.
- Current ZRAM uses lzo-rle; disk swap is secondary.
- Custom `7.2.8-n100v1.fc44` is installed but not natively boot-validated.
- Existing infrastructure also rebuilt 7.2.11; its audit records generic target
  flags and no native tuning approval. None is assumed to be an active optimized
  baseline. Preserve existing work and the stock default.

## Completed and preserved

- Inspected Trueno-ZRAM and Aprender; their AVX2 LZ4 wrappers call scalar code.
- Added explicit SSE2/AVX2 comparisons and bounded copies with format identity.
- Added default-off kernel integration, feature/FPU checks, scalar fallback and
  per-stream workspace reuse. Dictionary/non-default acceleration stays scalar.
- Compiled probe and complete ZRAM module against exact custom kernel headers.
- Passed diskless SMP VM round trips, direct block I/O, YMM preservation, nested
  FPU fallback and 2,048 malformed/truncated blocks. AVX2-disabled VM also passed.
- Native experiment 003: 10 variants, three timing sessions; 79,150 guard checks,
  20,000 malformed inputs and 12,000 independent cross-decoding cases passed.
- Local ASan/UBSan passed the same 10-variant suites.
- Three native 768 MiB pressure sessions passed on current lzo-rle ZRAM with
  bounded cgroup limits and no recorded OOM kills.
- Source, patches, tests and results are on `feature/n100-avx2-zram`.

## Findings and latest experiments

Direct vector match checks regress executable-page compression. Scalar-first
checks recover that loss, but sparse-page regressions remain. SSE2 can outperform
AVX2 on some decompression cases. Scalar unrolling is also workload-dependent.
All results, including regressions, are retained in BENCHMARKS.md.

Experiment 004 completed three native sessions comparing explicit
`-mtune=gracemont` with generic scheduling across 14 variants. It found no broad
improvement; all 110,810 guard checks and 16,800 independent cross-decoding cases
passed. Experiment 005 completed another three sessions across 16 variants.
Short-overlap broadcasts gained about 2% on sparse decoding but regressed mixed
decoding by 3.9%; they remain rejected research variants outside the kernel
candidate. All 126,640 guard checks, 19,200 independent cross-decoding cases and
full timed-corpus byte comparisons passed. The controllers held the existing
native test lock. Historical source
snapshots and all timing data are preserved. Earlier initial exploratory sessions
did not hold that lock and retain that limitation.

## Current native checkpoint and recovery dependency

Administrator access is now authenticated. Perf, fio and exact signed Fedora
7.0.10 kernel-devel are installed. An isolated 64 MiB test device completed three
randomized lzo-rle/LZ4 trials with full CRC32C verification, RAPL package energy
and kernel profiles. Stock LZ4 trails lzo-rle on this workload. The active swap
device was preserved, and temporary devices were removed.

The exact-ABI syscall codec probe now passed three physical N100 sessions,
including full retained-input checks, all-YMM preservation and 2,048 malformed
blocks. The initial AVX2 candidate regressed most syscall-inclusive cases;
only periodic-page compression improved. It is not selected for routine ZRAM use.
See BENCHMARKS.md for complete results and scope.

The initial ACPI reboot powered off the machine, as confirmed by the user.
After manual power-on, a PCI restart returned to stock 7.2.8, and a deliberate
SysRq panic returned to the saved stock 7.0.10 default. Sixteen EFI crash records
were archived privately; the panic signature was verified. Both stock entries
now request reboot=pci, with panic/lockup monitoring. This verifies these tested
reset/panic cases, not every hardware hang or an untested-kernel boot timeout.

SELinux remains enforcing. The first module-load attempt was denied because the
module had user_home_t. The unchanged VM-tested binary loaded from a dedicated
matching-kernel extra directory with modules_object_t; no policy was weakened.
The module and benchmark device were removed after successful measurements.

Matched native controls isolate approximately 435 ns/call of dirty-YMM FPU
bracketing cost; SSE2 also regresses decoding. A distance-one scalar experiment
did not help the timed workloads. Long eight-byte repeated stores improve
half-zero decoding by 48.7% but regress sparse decoding by 8.3%, so a narrower
match-only path is being tested. All measured versions and unsuccessful results
are retained. A three-backend stock-7.2.8 module passed diskless VM block I/O and
register tests; native experimental ZRAM loading is still pending.

Next: finish the narrower scalar experiment and compare candidate/stock native
ZRAM I/O on the same driver/compiler build. Extended native stability,
matched custom-kernel comparison and optimized energy results remain incomplete.
