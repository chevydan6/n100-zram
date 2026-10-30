# Terra real-world validation checkpoint

Started from 74f1fc4 after refreshing remote branches. This branch preserves
both Astra's GZRAM work and the newer scalar LZ4 candidates. Acceptance requires
at least a repeatable 10% improvement in a meaningful real-world metric without
unacceptable regressions; userspace synthetic wins do not meet that bar.

Existing GZRAM userspace evidence includes sparse and clustered compression
gains but losses against LZ4 on executable, random and period127 pages; bounded
trials reduced rejected work without eliminating those losses. Matched package
energy for executable pages favored LZ4. The guarded SIMD prototype passed
exact-kernel guest correctness and user register checks, but native SIMD cost,
actual ZRAM memory pressure and application responsiveness remain unmeasured.
See GZRAM-ASTRA-20261029.md and the retained reports.

The current scalar LZ4 4 KiB and 8 KiB table candidates passed exact-kernel guest
ZRAM correctness. The randomized userspace confirmation measured lower package
energy and time with larger executable outputs; see LZ4-SCALAR-ASTRA-20261030.md.
Neither userspace result establishes real-world superiority over current zstd.

Initial live inspection: physical Intel N100, kernel 7.2.11-200.fc44, active zstd
ZRAM and hibernation swap; native validation lock was free. Available memory was
about 2 GiB; browser activity was present. Panic, panic_on_oops and nmi_watchdog
were zero and no /dev/watchdog was observed. Current-kernel recovery remains
unverified. Do not load experimental host modules or alter stock swap/boot
settings until live jobs, lock ownership and recovery are verified. Prior guest
checks are not native recovery evidence.

Next: examine representative workload and page-pattern capture feasibility without
exposing private content; build a matched kernel-inclusive comparison with scalar
and vector GZRAM plus scalar LZ4 controls, including actual FPU costs; retain stock
zstd/lzo-rle controls. Run isolated correctness first. If recovery and privileges
block native work, continue independent userspace and workload methodology work,
recording the blocker and avoiding production configuration changes.

The [guarded SIMD ZRAM guest gate](../benchmarks/results/terra-simd-zram-001/summary.md)
passed with AVX2 hidden and exposed, 241,970 client checks per guest. This is a
new device integration correctness result, not native timing; the device gate
has no direct SIMD-path counter. Host stock settings matched before/after.

An [uninstrumented guest-only SIMD syscall probe](../benchmarks/results/terra-simd-measure-probe-001/summary.md)
built and passed guest correctness and register checks across 26 corpora. It
refuses bare-metal loading and the client refuses VM timing. Native timing still
requires a separately validated measurement build and verified recovery.

A [native-capable, uninstrumented measurement prototype](../benchmarks/results/terra-native-probe-gate-002/summary.md)
was built without loading it on the host. Exact-kernel guest checks passed with
matched scalar/LZ4 FPU controls and explicit rejection of nested SIMD FPU sections.
Authenticated read-only inspection found current, older and rescue boot entries,
but no watchdog device and disabled panic/watchdog controls. Entry presence does
not establish working recovery; native timing remains gated.

The [read-only current recovery inspection](../benchmarks/results/terra-recovery-inspection-001/summary.md)
found ACPI reboot, disabled panic/watchdog controls, no pstore backend or watchdog
device, and an inconclusive EC capability query. Existing native runner safeguards
are not met. No runtime, boot or swap settings were changed; native tests remain
deferred until recovery is independently demonstrated.

## Manual recovery handoff

The user is physically present and agreed to a controlled boot-menu check. A
read-only local preflight was saved at `build/terra-recovery-manual-preflight-001.json`;
it contains machine-specific boot/swap identifiers and is intentionally not
published. No native test owned the exclusive lock at preflight. The running
kernel was 7.2.11-200.fc44.x86_64 and stock zstd ZRAM was active.

The planned manual action is a normal restart followed by a one-time selection of
6.19.10-300.fc44.x86_64 in the boot menu, without changing the default. When the
user returns, verify `uname -r`, boot ID, `/proc/swaps`, ZRAM algorithm and size,
lock ownership and live jobs; then guide a normal return to the current default
kernel and verify restoration. If the menu or older kernel does not work, stop and
record the observation. Do not infer automatic hard-hang recovery from a successful
alternate boot. The established native runner's reboot/panic/pstore safeguards
remain unmet until independently verified. No experimental host module, boot
setting or swap setting has been changed for this handoff.

The user restarted and reported no kernel entry in GRUB. A changed boot ID
confirmed a restart into the current 7.2.11 kernel; stock zstd ZRAM, disk size
and swap devices matched preflight. Read-only grubby enumerated current, older
and rescue entries on disk, but visibility and bootability remain unproven.
See the [restart record](../benchmarks/results/terra-recovery-restart-001/summary.md).
No default or boot settings were changed; native experimental testing remains gated.

A [matched userspace GZRAM and scalar LZ4 cohort](../benchmarks/results/terra-matched-codecs-energy-001/findings.md) now compares both bounded GHY entries with four scalar LZ4 table sizes in randomized operation order. It retains CPU, package-energy, compressed-byte and decompression tradeoffs; it is not native ZRAM or a representative workload result. The manual boot-menu recovery check remains incomplete.

A [namespaced ZRAM coexistence experiment](../benchmarks/results/terra-coexist-gate-001/summary.md) records the CPU-hotplug state collision and the actual guest-gate outcome. This is not native performance or a verified hard-hang recovery path.

The [corrected coexistence guest gate](../benchmarks/results/terra-coexist-gate-002/summary.md) records the actual retry outcome; the initial missing-/tmp failure remains preserved. Native recovery and performance remain unproven.

The [strict coexistence console reanalysis](../benchmarks/results/terra-coexist-review-003/summary.md)
accepted both preserved guest runs after identifying a printk-split unload marker;
the original reported failure remains intact. Both guests checked stock-data
preservation and CPU1 hotplug/pinned I/O across all ten algorithm/cycle records.
This is guest correctness only and does not verify native recovery or performance.

An [owned compiler resident-page pilot](../benchmarks/results/terra-owned-compile-sampling-001/summary.md)
sampled only compiler children without persisting page contents. In one time-spread
sample, 71 of 78 non-same-word anonymous pages encoded as GZRAM frames had larger
logical payloads than the 4 KiB LZ4 control. A later sample found a hypothetical
zero-prefix recurrence guard would improve five eligible pages, but fired on none
of 29 retained fixtures. These are small selected samples, not a reclaim trace,
allocator measurement, performance or overall workload result. The cost and
adversarial size regressions of any candidate remain to be measured.

The [zero-prefix fallback experiment](../benchmarks/results/terra-zerotwo-energy-001/findings.md) has completed matched N100 userspace timing and package-energy measurements. Both one- and two-recurrence policies are rejected as general defaults: adversarial sparse fixtures exposed severe time, energy and compressed-size regressions, despite size improvements on a small owned compiler-page sample. The results do not establish a native ZRAM outcome; GRUB recovery remains unverified.

The [combined sampling-gate comparison](../benchmarks/results/terra-combined-sampling-energy-001/findings.md) measured userspace compression, decompression and package energy against the current bounded parent and scalar LZ4. The 16-word gate reduced time on several controls but produced a severe adversarial sparse-page time, energy and size regression. Both gates remain research prototypes; this does not establish a native ZRAM gain.

A [guest-only instrumented device-path check](../benchmarks/results/terra-simd-device-path-001/findings.md) observed both vector encode and decode through the namespaced ZRAM device with AVX2 exposed, and scalar fallback with AVX2 hidden. It closes a narrow prior observation gap; instrumentation and guest execution do not establish native performance or recovery.

The [current evidence checkpoint](../benchmarks/results/terra-evidence-checkpoint-001/findings.md) collects the audited renderer results and records the present decision: retain experimental candidates, do not promote a compressor, and prioritize verified recovery and representative native comparison over further fixed-sampling heuristics. The 10% real-world acceptance target remains unmet.

The [guest allocation scaling experiment](../benchmarks/results/terra-vm-allocation-scale-001/findings.md) found that the clustered-fixture allocation advantage shrank as repeated pages filled the pool, while the Bash executable fixture remained worse than zstd. This is controlled synthetic guest accounting, not a native performance or energy result.

An [ideal per-page size selector analysis](../benchmarks/results/terra-renderer-oracle-001/findings.md) found at most 0.241% logical-byte savings over LZ4 and 0.001% over userspace zstd in any of three biased renderer samples, even before selection or format costs. This bounds only the observed userspace frame sizes, not allocator-rounded memory, timing, other candidates or representative workloads.
