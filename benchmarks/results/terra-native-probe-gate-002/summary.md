# Native-capable SIMD measurement prototype: isolated gates

A separate uninstrumented native-capable module was built but not loaded on the
host. The exact-kernel AVX2 guest passed its existing codec, buffer and user
register checks. A second guest passed 51,588 checks per cycle across 26 corpora
with matched scalar and LZ4 outer FPU controls enabled. Both SIMD compression
and decompression commands explicitly rejected a nested outer FPU section; the
candidate owns its own FPU boundary. The client refused timing inside the VM.
Two load/unload cycles were exercised. The guest module was unsigned and tainted
only the guest kernel; matching vmlinux was unavailable for BTF.

The client retains per-call kernel-inclusive timing, CPU time, PMU and optional
CPU package-energy instrumentation, but no native timing was run. Existing
register and decoder correctness checks do not prove arbitrary preemption safety.

Authenticated read-only metadata found current, older and rescue boot entries;
those entries do not verify actual recovery. Panic and watchdog settings remained
zero and no watchdog device was observed. This is not an approval to load the
module or alter stock zstd ZRAM. A working recovery mechanism, live safety checks
and the exclusive lock remain necessary before a native experiment. No host
module, boot configuration or swap setting was changed.
