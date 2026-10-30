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
