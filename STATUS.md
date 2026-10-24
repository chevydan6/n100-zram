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

A per-page syscall probe now models clean and dirty user SIMD state. The exact
running-kernel ABI compiled successfully and passed diskless VM validation with
all-register sentinels and full retained-input checks. It has not been loaded on
the physical N100.

Recovery preparation backed up the stock boot entry and retained the stock
7.0.10 default. It enabled panic/lockup recovery policy and EFI crash logging.
The controlled stock reboot then failed to restore SSH within the five-minute
observation window. LAN discovery found no matching SSH host; no CCD/serial
recovery device is attached. The reason is not yet known: physical screen state
is required to distinguish a boot problem from missing network/login access.

The user has been asked for that screen state. NanoKVM is not a blanket
requirement; a working physical console or another verified recovery mechanism
is sufficient. No further native module load or reboot is appropriate until this
recovery test is resolved. Source, host-side results and VM checks are preserved.

Next: restore SSH, inspect the actual boot/kernel/network state, verify recovery,
then run FPU-inclusive native codec tests and controlled experimental ZRAM I/O.
Matched custom-kernel comparison, extended native stability and optimized energy
results remain incomplete. A user-space or host-VM speedup is not acceptance.
