# Uninstrumented SIMD syscall probe: guest correctness

The exact-kernel guest-only probe builds without adding counters to the validated
SIMD dispatcher. It rejects the old outer FPU wrapper to prevent nesting the
codec's own FPU state section. Its module refuses to load on bare metal. In an
AVX2-exposed diskless KVM guest the existing client completed two cycles, each
covering 26 corpora and 34,376 checks, including YMM and floating-point control
state preservation and cross-codec round trips. The client refused VM timing.
Raw console, build logs and hashes are retained. SIMD code execution was verified
by the earlier instrumented probe; this uninstrumented run has no path counter.

This is not native timing, a ZRAM comparison or a recovery validation. A native
measurement variant would require explicit engineering and its own validation;
no host module was loaded. The current-kernel recovery path and privileged native
access remain unverified. Kernel build lacks matching vmlinux for BTF.
