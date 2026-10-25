# Current status

Native AVX2 LZ4 compression/decompression and a separate scalar repeated-store
backend are implemented. Physical N100 codec and experimental ZRAM I/O results
are available, including regressions. **No overall production improvement is
accepted yet.** Stock modules, lzo-rle configuration and boot default are preserved.

## Measured target and environment

- Intel N100, four Gracemont cores, approximately 3.7 GiB usable RAM.
- Fedora, active stock `7.2.8-200.fc44.x86_64`, Xfce desktop; saved default stock 7.0.10.
- Normal ZRAM configuration uses lzo-rle; controlled module comparisons temporarily drain it with disk swap available.
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
register tests; the first native experimental ZRAM I/O comparison has completed its data checks.

Next: finish the narrower scalar experiment and compare candidate/stock native
ZRAM I/O on the same driver/compiler build. Extended native stability,
matched custom-kernel comparison and optimized energy results remain incomplete.

## Native ZRAM checkpoint

Twenty direct-I/O trials (five per backend) completed full CRC32C verification.
Within the same driver build, AVX2 reduced read throughput by 16.7% versus LZ4;
scalar long-match decoding increased it by 24.7%, with about 18% lower whole-job
package energy per I/O. It reaches approximately the same read speed as lzo-rle
but retains slower writes. The rebuilt driver controls also trail the separate
installed-stock baseline; that difference is not attributed to a codec change.

The first controller failed at restoration because systemd reactivated primary
swap after module insertion. Stock was subsequently restored and its live GNU
build-id note matched the installed signed module. A second attempt stopped
before experimental loading on a transient device reference; primary stock swap
was restored. The current repeat uses temporary runtime unit masks, explicit
drained-device reset, bounded unload retries and build-id verification. It
completed all twenty trials and verified automated stock restoration. No failed cleanup is reported as a successful run.

A selective first-match hint retains the roughly 49% half-zero codec decode gain
while removing the measured sparse regression. Three native 7.2.8 sessions passed
all byte/register checks. Guarded selection tests passed 28,279 cases, and VM
ZRAM tests passed all three backends with concurrent helpers. The first-match hint did not retain its gain on fio blocks and is rejected for
selection. The short-offset branch implementation completed forty pressure trials (five
per corpus/backend), with full byte/register checks, no OOM and verified stock
restoration. No broad speed/energy improvement is accepted.

The stock 7.2.8 pressure smoke check passed full byte verification, about 569k
swap-ins / 685k swap-outs, four concurrent CPU/register helpers and zero OOM
events. The new harness uses normal system log/executable locations with
SELinux enforcing; bounded hotplug retries handle transient udev probes.

## Latest completed pressure comparison

All forty native trials passed (160 concurrent helper processes; three full
768 MiB verification passes per trial), with telemetry and cgroup health records.
The candidates do not establish a reliable broad improvement. Lzo-rle finishes
faster on these corpora, while LZ4 substantially reduces peak allocated ZRAM
memory. All raw results and paired descriptive intervals are published.
Next: match scalar compiler settings, include the pressure word patterns in
codec controls, profile compression, and test a larger working set relevant to
the 4 GiB target. Normal lzo-rle swap and installed stock code remain active.

## Independent repository checkpoint

ZRAM history was extracted into chevydan6/n100-zram; subsequent development
is independent of fedora-gracemont. Eight prior commits plus the migration
checkpoint preserve source, measurements, regressions and authorship.
Latest O2 controls and initialized-workspace reuse prototypes are experimental.
Correction: the kernel LZ4 Makefile explicitly selects -O3 even when global
kernel configuration selects -O2. O2 probes are alternative-codegen experiments,
not stock-matched optimization controls. No broad native gain is established.

### Latest experiment: initialized workspace epochs

Three physical N100 sessions completed, all eight variants/corpora validated.
Large regressions on mixed/executable pages reject unconditional table-epoch
reuse. Keep prototypes and all measurements; investigate lookup/code generation
or another compression bottleneck before any kernel integration. No experimental
backend is the production default.

### Smaller-table follow-up

Initial three-session native screening is preserved with every ratio tradeoff.
Matched private-API table14 controls and eight codec variants passed 64,864 guarded
capacity cases and 32,000 concurrent independent decodes. A bounded follow-up
will compare all table sizes with these controls before any kernel integration.
A persistent collector preserves completed sessions and audits the committed
results before pushing; interruptions retain raw checkpoints outside Git.

### Native experiment collection

Three matched-control user-space sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-matched-table-user-001/summary.md](benchmarks/results/native-matched-table-user-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

### Scalar kernel integration and adaptive branch

The independent scalar small-table backend compiled for the running 7.2.8 ABI
and passed diskless kernel validation with eight concurrent YMM-state checks.
Its compressor object contains no explicit SIMD registers. Native I/O comparison
is in progress with CPU counters, package energy, thermal/frequency telemetry,
full CRC verification and automatic stock-module restoration. The first attempt
stopped before timing on a bracketed-algorithm parser error and restored stock;
the corrected attempt preserves separate evidence.

Adaptive size sweeps live on feature/n100-adaptive-simd-zram. The first physical
N100 three-session scalar/SSE2/AVX2 sweep completed all nine requested sizes.
All PMU groups were fully scheduled. Whole-codec winners vary by data/direction;
no universal threshold, component threshold or native hybrid policy is accepted.
Scalar work continues independently; no adaptive SIMD changes were merged here.

### Completed native scalar checkpoint

Five shuffled I/O trials per backend passed full CRC32C verification and stock
restoration. Small-table writes improved 8.20% by paired IOPS ratios and whole-job
package energy/I/O decreased 9.70%; reads showed no clear improvement. Thirty
subsequent controlled-reclaim trials passed every byte check, 120 concurrent
register/helper runs and stock restoration. Paired whole-workload elapsed-time
intervals include zero; system CPU time was about 2% lower and package energy was
lower in this one experiment. See retained raw rows and paired-analysis.json.
Do not treat these as general application responsiveness or production acceptance.
A matched original-table-size kernel build is the next causal control.

### Consolidated mission continuation

Continue in independent chevydan6/n100-zram; the Fedora project remains separate.
Track A retains feature/n100-avx2-zram for scalar continuity. Track B's AVX2 LZ4
and crossover research remains on feature/n100-adaptive-simd-zram. Track C starts
on feature/n100-gzram-avx2 with independent userspace format research; no native
integration or performance claim is implied. All N100 benchmarks share one lock.

The second matched scalar session completed and restored stock. Its write gain
remained positive, but a slow original-table-control read trial inflated variability
and energy intervals. Preserve it and investigate rather than silently excluding
it. Next scalar comparison varies nominal compressibility with explicit metadata,
starting at 25%, to test whether the write advantage generalizes beyond 50%.

### Three-track native checkpoint

The 8 KiB scalar table completed its first 25% nominal fixture, passed CRC checks
and restored stock. Against the private original-size control, paired write IOPS
were +5.81% [+2.76%, +11.31%]; reads showed no clear change (+0.69%, interval
[-0.28%, +1.40%]). Package energy/I/O was inconclusive (-3.08%, interval crossing
zero). The 4 KiB variant retained a read penalty in this session. No default is
selected. A 75% fixture is queued after the new-codec candidate comparison.

Adaptive research now includes actual kernel component/state-cost measurements;
representative 4 KiB SIMD paths lost after roughly 430 ns context/dispatch cost.
Long comparison crossover outside the normal page does not establish usable ZRAM
batching. GZRAM v1 has native userspace results, including severe ratio losses on
unrecognized periodic data; it is not a native kernel backend or general winner.
A faster scalar GZRAM scanner is being compared with preserved original/AVX2
paths. All tracks retain separate branches and share the N100 hardware lock.

## Scalar 75% fixture follow-up

Five shuffled trials per backend completed on the physical N100, with all CRC32C
checks and verified stock restoration. Relative to the private 16 KiB control,
the 8 KiB table improved write IOPS by 6.75% (95% paired bootstrap 4.67 to 11.76%)
but reduced read IOPS by 1.08% (-2.13 to -0.36%). Whole-job package energy per
write I/O fell 6.12% (-10.51 to -3.71%). The 4 KiB table retained a larger write
gain and larger read loss. These synthetic results reject a regression-free
claim for either smaller table. Existing scalar source and all experiments remain
available; normal lzo-rle swap remains restored. Next: distinguish input/encoded
stream differences from decoder/code-layout effects using identical page corpora,
then evaluate competing application CPU availability under controlled pressure.
Full data: benchmarks/results/native-scalar-mid8k-75pct-001/summary.md.

## Identical-page scalar attribution

Three physical N100 cross-decoding sessions completed and were published in
native-scalar-crossdecode-001. All nine encoder/decoder combinations and six
corpora are retained; PMU batches were fully scheduled. Deterministic zero-tail
controls do not reproduce a consistent smaller-table decoder penalty. Executable
pages have stream differences, and these userspace controls cannot attribute the
previous kernel fio regression. The next experiment uses identical fixed pages
and read-only native ZRAM I/O, with full-device byte/SHA256 verification.
