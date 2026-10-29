# GZRAM composition continuation — 2026-10-29

Branch `feature/n100-gzram-astra-paths`, starting at `f430d05`. Remote branches
were refreshed before edits; no newer SOL or Astra checkpoint was found.
The [seventh findings](../benchmarks/results/native-gzram-astra-local-007-timing/findings.md)
remain the measured starting point. All previous candidates, raw data and
unsuccessful experiments are retained.

## Immediate composition experiment

Six additive policies combine direct block packing (cutoffs 2 and 3) with the
original scanner, grouped integer scanner, or grouped AVX-bitwise scanner.
Names are `bitdirectblock2/3`, with `pipe4` or `avxbits4` suffixes for the grouped
versions. All preserve bitdirect's CTZ decoder, direct scalar repeat expansion,
repeat merging and GHY1/GZR1 format. Neither cutoff is assumed optimal.
The standalone packing, scanning, scalar bitdirect, SOL wordmixed and matched
private scalar LZ4 paths remain controls. Separate component gains are not
assumed additive.

The normal and ASan/UBSan builds each passed 777 registered variants across
26 corpora × 128 pages (2,585,856 round trips per build). The six dedicated tests
also pass cutoff boundaries, pipeline positions, independent/old decoding,
malformed/truncated inputs, guarded capacities and concurrency. The direct scanner and isolated benchmark gates also passed in both builds.
All 545,792 old size/mode records remain unchanged; 79,872 new records match
bitdirect. All 45 audited old library text sections are unchanged. See the
[validation checkpoint](../benchmarks/results/gzram-astra-v8-validation-001/summary.md).
The [eighth physical cohort](../benchmarks/results/native-gzram-astra-local-008-retry-timing/findings.md)
now measures the combinations: cutoff 2 reduces compression time by 18.12% on
sparse words and 20.98% on clusters50 versus matched bitdirect AVX2, with
identical bytes. Repeat16/32 improve 10.54%/11.19%. Against the matching plain
combined packer, sparse words are tied and words25 regresses 1.04%; gains are
not uniformly additive. Period127-zero-tail regresses 3.56% versus bitdirect.
Against matched private LZ4, random and period127 compression still take
49.63% and 65.21% more time, and clusters50 decoding takes 21.48% more time.
These are userspace results, not a native ZRAM or energy improvement.

## Decoder measurement isolation

`gzram/bench-isolated.c` reuses the preserved fixture definitions and PMU helpers,
while leaving the legacy timing entry intact. It prepares immutable frames
before timing, restores them to identical buffer addresses, and randomly orders
all (variant, operation) tasks instead of always decoding after its encoder.
Promised bitdirect variants must match canonical compressed bytes on every page.

Own-entry, shared-entry and same-process alias modes passed validation.
An alias uses the same encoder and frame bytes but exactly one common decoder
address; the baseline's alias is an identical-entry negative control. All task
orders and resolved addresses are recorded. Frame-bank memory and restore costs
are harness overhead outside codec time, not proposed ZRAM memory/queue costs.
The shared-entry experiment reduces the old large repeat decoder anomaly to
small residual differences: pipe4 versus the common baseline changes repeat16/32
by +0.23%/+0.38%. The baseline's exact-entry negative control itself differs by
up to 2.11%. The large anomaly cannot be credited to a new decoder algorithm;
layout, cache, predictor and history contributions remain unisolated.

## Live state and unresolved kernel boundary

At inspection the actual N100 was on battery at 98%, with powersave and
700–800 MHz policy limits, despite the previous AC/700–3400 MHz experiment.
Stock ZRAM uses zstd, disksize 3,924,819,968 bytes. No experimental process or
native lock owner was active. The existing lock inode is retained and all heavy
validation/native jobs serialize through it. Fresh matched baselines are needed;
old absolute timings are not reused as controls.

Passwordless sudo is unavailable. Package RAPL is unreadable unprivileged.
Runtime panic, panic_on_oops, nmi_watchdog, hardlockup_panic and softlockup_panic
are all zero; no hardware watchdog appears. Protected current boot metadata
and a working current-kernel recovery path remain unverified. Historical PCI
reboot recovery on an older kernel does not establish current recovery.
No native module, boot setting or swap configuration has been changed.

The exact 7.2.11 source RPM was extracted and its spec/patches reviewed: the
Fedora patch has no ZRAM changes. Digest checks did not verify the publisher
signature. A default-off scalar bitdirect/private-LZ4 ZRAM adapter built against
the exact kernel, with no SIMD in audited experimental objects. Its guest-only
client correctly refuses to open host ZRAM. After available memory recovered above the unchanged 2 GiB gate, the diskless
guest passed 241,970 checks across two load/unload cycles and five algorithms.
An interleaved console marker caused the original parser to report failure;
the preserved raw run passed corrected strict parsing and separate parser tests.
See the [device gate record](../benchmarks/results/gzram-zram-device-001/summary.md).
This is scalar integration infrastructure, not a combined SIMD kernel result.

The scalar generator now explicitly excludes the unused vector scanner branch.
Three regenerated scalar objects match their previous text bytes exactly and
pass sanitizer/guard/oracle/malformed/concurrency checks. See the
[generator maintenance record](../benchmarks/results/gzram-scalar-generator-002/summary.md).

## Next credible follow-ups

An acceptance-bounded GZRAM trial could avoid scanning/copying data that the
hybrid's existing 75% size rule will reject. This is distinct from sampling:
it should preserve accepted frames and must be checked for repeat-merging and
capacity edge cases before claiming byte identity. Clustered-mask decoding is
another target: reuse validation's mask walk to identify blocks consisting only
of zero/full groups, then compare a direct copy/zero loop with the existing CTZ
path. Retain sparse and partially populated blocks as regression controls.

Final acceptance still requires current-stock zstd, matched LZ4 and supported
lzo-rle comparisons under representative native ZRAM pressure, with allocator
memory, CPU, energy, responsiveness, latency tails and stability. Userspace wins,
shared decoder controls and VM correctness do not establish that result.

## Physical timing interruption and retry

The first eighth-cohort attempt was interrupted by host suspend for about
41 minutes (2,470.700 seconds between telemetry samples). Its raw data is
preserved in [the interrupted cohort](../benchmarks/results/native-gzram-astra-local-008-interrupted/summary.md)
and excluded from controlled performance conclusions. Omitting the temporary
sleep inhibitor was an experiment-launcher error. The fresh retry retains the
same frozen sources/binaries and sample counts, with a temporary logind idle/sleep
inhibitor scoped to the bounded run. No persistent power setting was changed.

The fresh eighth retry completed 32,292 rows across three sessions, with a
maximum telemetry gap of 0.860 seconds. It remained on battery at 700–800 MHz;
these absolute timings must not be compared directly with the seventh AC run.
Package RAPL and the package-energy perf event are both permission-denied.
Whole-experiment battery readings do not establish per-codec energy savings.

Three bounded-trial candidates now pass normal and ASan/UBSan validation,
including 2,745,600 registry round trips per build, dedicated bounds/malformed/
concurrency checks and the isolated measurement harness. All 625,664 prior
size records are unchanged; 39,936 new records match their parent. They cap
only tentative GZRAM output at the acceptance threshold, leaving LZ4 capacity
unchanged. The first attempt's test-script failure is preserved. See the
[corrected validation](../benchmarks/results/gzram-astra-v9-validation-002/summary.md).
Physical timing is pending; cluster classification remains an unapplied draft.

## SIMD integration and additional fixtures

A generated SIMD workspace port separates the measured grouped/direct encoder
and CTZ-plus-vector-repeat decoder from the scalar dispatcher and LZ4 fallback.
The fallback runs after FPU exit; raw and LZ4 decoding avoid vector entry. CPU/OS
feature checks and unusable kernel SIMD contexts select the preserved scalar
path. Userspace normal/sanitizer tests and forced scalar fallback have passed;
additional policy-specific fixtures passed for both SIMD and forced-fallback
builds, normal and sanitized. The exact-kernel module builds with vector objects
isolated from scalar dispatch/fallback. The guest gate deferred at 2,078,960 KiB
available memory, below the unchanged 2 GiB requirement; no SIMD guest was started.
See the [SIMD port checkpoint](../benchmarks/results/gzram-simd-port-001/summary.md).
This is a new integration prototype, not a native performance result.

An [executable-page fixture generator](../benchmarks/results/gzram-exec-corpora-001/summary.md)
passed independent ELF header/byte checks and invalid-input tests. It selects
128 distributed executable-segment pages each from Bash, Git and libc, preserving
all old fixtures. These file-backed pages are not runtime anonymous memory or a
representative reclaim distribution; no codec timing has used them yet.

## Bounded-trial timing and independent retest

Two fresh physical userspace cohorts each used three sessions and nine paired
rounds, with 128 pages per corpus and 8,192 calls per batch. Both audits passed;
raw results and all comparisons are in the [first cohort](../benchmarks/results/native-gzram-astra-local-009-timing/findings.md)
and [retest](../benchmarks/results/native-gzram-astra-local-010-retest-timing/findings.md).
They ran on battery with 700–800 MHz settings; package energy was unavailable.
The retest analysis launcher initially named a nonexistent script; the raw data
was preserved and the corrected analysis passed without rerunning measurements.

Cutoff-2 bounded versus its unbounded parent reduced compression time 12.15% and
12.13% for random pages and 18.23% and 17.93% for period127 in the two cohorts.
Bash improved 1.68% and 1.77%. Repeat16 regressed 0.13% and 0.25%; sparse and
cluster effects were small or inconsistent. Output size and format remain the
same on the validated fixtures. These are time reductions, not throughput gains.

The retest still shows important losses versus matched private scalar LZ4:
random compression 4,495.0 → 5,993.4 ns/page (+32.76%), period127 3,024.3 →
4,054.0 ns/page (+33.99%), Bash 39,150.3 → 40,677.4 ns/page (+3.87%), and
clusters50 decoding 3,904.5 → 4,620.6 ns/page (+18.41%). Sparse-word compression
improved from 16,944.4 to 4,859.9 ns/page (−71.36%). These are userspace codec
results; shared decoder-entry controls limit attribution of small decode deltas.
No native ZRAM, energy or overall workload improvement is established.

The [SIMD register-preservation guest gate](../benchmarks/results/gzram-simd-register-001/summary.md)
passed two cycles with all YMM registers and floating-point control state checked;
vector-path counters confirmed encoding and decoding executed. This does not
measure native SIMD overhead or establish preemption coverage.
