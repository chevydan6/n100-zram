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

## Actual external dependencies

N100 SSH works as the normal user, but sudo requires authentication and root SSH
public-key access is unavailable. Noninteractive PolicyKit also reports that
authentication is required. Administrator access is required to load kernel
modules, prepare controlled ZRAM devices and install/boot test kernels.
The previous NanoKVM address is unreachable from the controller, and no current
physical boot rollback/recovery path is verified. No experimental native boot,
active swap replacement or unsupported privileged workaround has been attempted.

After access and recovery are established: compare matched stock/custom kernels,
measure FPU-inclusive native codec latency and direct ZRAM I/O, then run the
bounded pressure workload on each candidate. Energy counters and extended native
stability remain pending. A user-space or host-VM speedup is not acceptance.

No benchmark or build from this checkpoint remains running. The next substantive
step is native kernel measurement after those access/recovery dependencies are
resolved; further unprivileged synthetic tuning would not establish acceptance.
