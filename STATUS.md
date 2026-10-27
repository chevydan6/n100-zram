# Current status

The additive [Astra continuation](docs/GZRAM-ASTRA-20261028.md) investigates
scalar classifier outlining and sparse bit-scan decoding, and repairs a
full-registry benchmark shuffle overflow. New candidate performance remains
unmeasured; original controller/lock access and the changed local environment
must be resolved before a native timing cohort.

For the latest GZRAM experiments, measured gains, regressions and reproduction
commands, see [the 2026-10-28 GZRAM report](docs/GZRAM-20261028.md).
The entries below also retain historical experiment states; later completion
entries and the linked report supersede their earlier pending-work notes.

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

## GZRAM-AVX2 research branch

This branch preserves the existing scalar history and adds an independent
userspace format prototype under gzram/. Feature-gated AVX2 and scalar references
share one explicit format; mask shuffle tables are generated independently.
Guarded oracle-based correctness, malformed frames and concurrency tests passed,
including ASan/UBSan. Native performance, ratio/energy comparisons and kernel
integration have not yet been established. Scalar development continues on
feature/n100-avx2-zram and adaptive LZ4 on feature/n100-adaptive-simd-zram.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-user-001/summary.md](benchmarks/results/native-gzram-user-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-fast-scalar-001/summary.md](benchmarks/results/native-gzram-fast-scalar-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

## Faster scalar GZRAM checkpoint

Three N100 sessions completed the 25-path comparison, including the original
scalar reference and all ratio regressions. Prefix-derived repeat detection and
branchless sparse masks reduce encoding latency substantially on selected pages.
Sparse-word decoding still favors scalar over AVX2. The unchanged format's ratio
losses prevent accepting it as a general ZRAM compressor; no kernel backend or
adaptive threshold is selected. See gzram/README.md and the complete
native-gzram-fast-scalar-001 dataset. Existing scalar LZ4 work remains independent
and active on its original development branch.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-block-unpack-001/summary.md](benchmarks/results/native-gzram-block-unpack-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-period-001/summary.md](benchmarks/results/native-gzram-period-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-filter-001/summary.md](benchmarks/results/native-gzram-filter-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

## GZRAM hybrid development resumed

Three independent GHY1 policies now combine the preserved fast GZRAM path,
private scalar LZ4 backreferences and raw fallback: trial, sampled zero density,
and sampled density with repeated-prefix classification. The original GZR1/GZR2
paths and all losses remain available. Guarded capacities, independent decoding,
malformed/mutated frames, cross-policy decoding, concurrency and ASan/UBSan passed.
The next physical N100 experiment measures the complete policy/format costs,
including a mixed repeated-prefix/zero-tail corpus that defeats zero density
alone. No performance improvement or kernel integration is claimed before that run.

## Guarded GHY1 trial experiment

This isolated feature/n100-gzram-guarded-trial branch preserves the completed
first hybrid screen on the original GZRAM branch. guard16/guard32 accept the
best GZRAM ratios directly and use bounded nonzero-anchor SSE/AVX2 prefix filters
only for middling ratios. Scalar variants remain separate. Format bounds,
malformed inputs, cross-policy decoding, concurrency, vector-edge tests and
ASan/UBSan passed locally. The next native screen measures 27 variants and
12 corpora, retaining all previous controls and a new false-positive stress case.
No policy is selected and no kernel codec is replaced.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-guarded-trial-001/summary.md](benchmarks/results/native-gzram-guarded-trial-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

## Guarded hybrid screen completed

All three N100 sessions completed. The guarded policies protect the sparse
encoding path and recover mixed-prefix ratios, but still add half-zero search
cost; AVX2 filtering beats SSE filtering on that tested path. Neither is an
overall winner. Both pooled and paired timing estimates, codec selection counts
and every regression are published in native-gzram-guarded-trial-001 contrasts.
Local prototypes now investigate fused prefix scans and independent sparse/repeat
decoder selection before the next native experiment.

## Fused-prefix and mixed-decoder candidates validated locally

The fused prototype reuses AVX2 scan loads to record bounded prefix hints, with
caller-owned state and partial-block checks. guard32mixed retains encoding while
using scalar sparse unpacking and AVX2 repeat expansion. Both passed guarded,
cross-policy, malformed-input, concurrency and sanitizer checks. The preserved
fast GZRAM and guard32 controls retain identical local .text hashes. The next
N100 experiment measures all 40 selected variants and 12 corpora; no performance
claim is accepted before that run. Neither candidate replaces kernel ZRAM.

## Integer-only classifier added to the next GZRAM cohort

wordguard checks eight anchor candidates per 64-bit integer load and confirms
complete keys. It preserves the guard32 encoding policy while avoiding SIMD in
the classifier itself. Exact cross-implementation output, bounds, all-anchor,
partial-block, concurrency, malformed-input and sanitizer checks passed locally.
This keeps scalar optimization active alongside fused AVX2 scanning and mixed
mode decoding. The next N100 screen has 40 variants and 12 corpora, including both fast-scalar block-size controls.

## Continued GZRAM test queue

The next finite queue runs a 40-variant screen for fused scanning, independent
decoder dispatch and integer word-at-a-time classification. A guarded follow-up
covers all eight internal processing lengths with 81 explicit variants, only
when the preceding screen and artifact fingerprints validate. Data, kernel
SIMD costs and preferred-policy acceptance remain separate. GitHub hosted
workflows currently report disabled_manually; their setting was left unchanged.
Local/native automated tests provide the stated validation; no hosted CI pass
is claimed.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-fused-scalar-001/summary.md](benchmarks/results/native-gzram-fused-scalar-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

### Native experiment collection

Three native user-space screening sessions completed; all raw rows and sanitized
telemetry are in [benchmarks/results/native-gzram-block-sweep-001/summary.md](benchmarks/results/native-gzram-block-sweep-001/summary.md). These measurements
exclude kernel FPU cost and establish no end-to-end ZRAM improvement.

## Controller crash recovery, 2026-10-26

Both latest cohorts were already complete and committed. Recovery verified all
private/committed CSVs and current source fingerprints, then added complete
direct policy and block comparisons. See [recovery findings](docs/RECOVERY-20261026.md).
The N100 endpoint is unreachable; remote service state is unknown. No new native
run was launched and the separate GPU campaign was untouched.

## Independent classifier/decoder candidate, 2026-10-26

N100 connectivity recovered; kernel 7.2.8, stock ZRAM build-id and lzo-rle
verified. Both preceding GZRAM native services exited successfully. The additive
wordmixed policy uses integer word filtering in the scalar classifier, preserves
AVX2 filtering and selects mixed sparse/repeat decoding. All fourteen existing
codec .text sections match the previous local build. Original controls remain.
Normal and ASan/UBSan checks each passed 29,312 cross-path round trips, 29,264
guarded-capacity cases, 80,000 malformed/mutated decodes and 4,000 concurrent
round trips. Native fixture validation passed 44 variants across all 12 corpora.
These establish correctness only; no wordmixed timing result exists yet.
The isolated native cohort and bounded lock-holding collector are staged; root
service launch requires sudo authentication on the target for PMU/RAPL access.

## Wordmixed screening collected

All three sessions completed: 44 variants, 12 corpora, 28,512 timing rows.
Results and 1,632 direct comparisons are in native-gzram-wordmixed-001.
All PMU fractions were 1.0. A 32,279-second telemetry gap and suspend journal
confirm interruption during session-1. All rows remain; clean replication is
required before acceptance, especially for energy. At 1024-byte blocks,
preliminary paired medians versus matching guard32 are -43.25% scalar half-zero
encode time, +1.68% AVX2 half-zero encode time, and -12.66% AVX2 sparse-word
decode time, with unchanged sizes in these contrasts. No production policy or
end-to-end kernel gain is accepted. Collection completed, the lock was released,
and the temporary target sleep inhibitor exited automatically.

## Clean wordmixed replication started

A separate gzram-wordmixed-repeat-001 cohort is running on the N100 with
identical benchmark fingerprints, 44 variants and all twelve corpora. Validation
passed and session-0 started. A sleep/idle inhibitor encloses the entire native
service and exits with it; the controller holds the exclusive benchmark lock
through collection. The collector rejects telemetry gaps of ten seconds or more.
The suspend-affected original remains intact. No repeat timing result is claimed
until all three sessions complete and the recorded measurements are reviewed.

## Clean wordmixed replication completed

All three repeat sessions completed and were collected in
benchmarks/results/native-gzram-wordmixed-repeat-001: 44 variants, twelve corpora,
28,512 timing rows and 1,632 direct comparisons. Maximum telemetry gap was
0.505 seconds; all PMU batches were fully scheduled and energy was available.
The sleep inhibitor exited and the benchmark lock was released. At 1024-byte
blocks, paired median changes versus matching guard32 were -43.14% scalar
half-zero encoding time, -13.11% AVX2 sparse-word decoding time, and +2.73% AVX2
half-zero encoding time. Encoded sizes were unchanged in these comparisons.
This reproduces the path-specific benefits and remaining AVX2 encoding loss in
a continuous run. All other cases and regressions remain in paired.md/json.
These are warm-cache userspace results; no general codec or kernel gain is
accepted, and no production default was changed.

## Vector-tail attribution experiment started

Direct paired analysis of the clean cohort found wordmixed AVX2 half-zero
encoding +1.92% relative to guard32mixed at 1024-byte blocks. The wordmixed
vector classifier tail-calls the integer scanner even after a full vector scan;
this is a code-generation hypothesis, not a measured causal attribution.
The additive splittail policy keeps the scalar word scanner and mixed decoder
while providing an independent byte tail to the vector classifier. Normal and
ASan/UBSan validation each passed 29,312 round trips, 29,264 guarded capacity
cases, 80,000 malformed/mutated decodes and 4,000 concurrent round trips.
Physical N100 correctness passed and all 15 prior codec .text hashes match.
A new 48-variant native screen retains all 44 preceding controls and identical
twelve corpus hashes. Validation passed and session-0 started with sleep/idle
inhibited from the start and exclusive locking through collection. The analyzer
now supports explicit matched policy controls for guard32, guard32mixed and
wordmixed. Original data and source paths remain preserved. No splittail
performance result or kernel acceptance is claimed before completion.

## Vector-tail experiment completed

Three sessions completed and were collected in native-gzram-splittail-001:
48 variants, twelve corpora, 31,104 timing rows and 3,552 direct comparisons.
Maximum telemetry gap was 0.504 seconds; PMU batches were fully scheduled and
energy was available. At 1024-byte blocks, splitting the vector tail reduced
AVX2 half-zero encoding time 1.77% versus wordmixed, putting it within +0.02%
of guard32mixed (-0.69% versus guard32). Sparse-word AVX2 decoding remained
12.90% faster than guard32. However scalar half-zero encoding was 10.30%
slower than wordmixed, leaving a 37.18% gain versus guard32. Encoded sizes in
these comparisons were unchanged. This is a tradeoff, not acceptance of an
overall replacement. Preserve both policies and investigate scalar code
generation/layout before combining the best paths or attempting kernel work.
All regressions and direct session estimates remain in the result files.
