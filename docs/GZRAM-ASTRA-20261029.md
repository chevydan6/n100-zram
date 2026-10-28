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
Physical composition timings remain pending; these are correctness results.

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
This design can test algorithm/entry identity without claiming that a particular
cache, predictor or execution-port effect explains the old anomaly.

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
client correctly refuses to open host ZRAM. Device guest tests remain pending:
current MemAvailable (about 1.6 GiB) is below the existing 2 GiB headroom gate.
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
