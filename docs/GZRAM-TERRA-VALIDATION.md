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
