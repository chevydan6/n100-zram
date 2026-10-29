# SIMD codec user register preservation in an exact-kernel guest

The guest-only SIMD syscall probe passed two load/unload cycles on the exact
7.2.11-200.fc44 kernel, with AVX2 exposed. For each cycle the preserved client
validated 26 corpora and 34,376 checks, including all sixteen YMM registers,
MXCSR and x87 control word across codec calls. Instrumented path counters
confirmed 36,634 vector encodes and 30,337 vector decodes per cycle. The client
explicitly refused timing inside a VM. See raw serial and result records.

The guest module is unsigned, which tainted the guest kernel; it was never
loaded on the host. This is a correctness gate, not native timing, energy,
preemption coverage, ZRAM behavior or a production readiness claim. The probe
rejects the legacy outer FPU wrapper to avoid nesting the SIMD codec's own FPU
state section. Its path counters make it unsuitable as a performance module.
