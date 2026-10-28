# Full scalar GHY1 workspace kernel correctness gate

The explicit-workspace wordmixed control and bitpack/CTZ candidate compiled
against stock 7.2.11-200.fc44.x86_64 headers with matched integer-only flags and
a single identical private LZ4 implementation. The repaired build normalizes two
noinline attribute tokens per hybrid translation unit to the equivalent reserved
__noinline__ spelling, avoiding Linux macro expansion. Exact before/after hashes,
source copies, compiler flags and the earlier failed build are retained.

Disassembly found no SIMD register instructions in the module. Compiler stack
reports show at most 296 bytes for a codec function and 336 bytes for the test
initializer; these are per-function estimates, not measured call-chain peaks.
LZ4 workspace is 4,128 caller-owned bytes, aligned to eight bytes. Actual ZRAM
stream allocation and allocator rounding are not measured by this gate.

The exact-kernel diskless KVM guest passed two load/test/unload cycles. Each
cycle passed 207,818 assertions across four concurrent workers with separate
reference/candidate workspace and buffers. Coverage includes independent raw,
LZ4 literal-only and nested sparse-mask frames; truncation and trailing bytes;
workspace size/alignment rejection; workspace/output canaries; all three GHY1
modes; cross-decoding; byte identity; variable-length round trips; and mutation
differentials. Expected unsigned/out-of-tree module taint is visible. No guest
warning, oops or panic occurred. Canaries are not read guards, and the guest is
not KASAN-instrumented; separate userspace guard/sanitizer evidence still matters.

The updated VM runner also repeated the unchanged scalar GZR1 module's two
161,410-assertion cycles successfully. Both guests had 256 MiB RAM, two vCPUs,
AVX2 hidden, no host disks and no networking. Host postflight hashes match the
original ZRAM module, algorithm, size and CPU settings. No experimental GZRAM
module was loaded on the host.

This is full scalar container correctness evidence in a guest. It does not
establish native kernel speed, energy, SIMD state handling, ZRAM integration,
application responsiveness, host recovery or production readiness. The port
needs its own matched performance measurements because adaptation changes code
generation and adds explicit workspace validation.
