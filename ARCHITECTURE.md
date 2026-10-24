# Architecture and source provenance

## Research references

- [Trueno-ZRAM](https://github.com/paiml/trueno-zram), commit
  `a0b9ab5ef5eb914edcd08c7bc5e90ea46557a231`.
- [Aprender](https://github.com/paiml/aprender), commit
  `9b1a24e537a14921ba1e3f91a442483c0ecd4242`.
  The current tree has `crates/aprender-zram`, `aprender-zram-core`,
  `aprender-zram-adaptive`, CLI and generator crates. The LZ4 code resides in
  `crates/aprender-zram-core/src/lz4/`.
- [Trueno documentation](https://paiml.github.io/trueno-zram/introduction.html).
  Its userspace block-device overhead and AVX-512 results cannot establish an
  N100 native-kernel benefit.

At these commits the AVX2 LZ4 compression wrapper calls scalar compression;
AVX2 decompression calls the scalar decoder with a target-feature annotation.
These wrappers do not supply dedicated intrinsic LZ4 kernels. The scalar Rust
implementation also uses allocations and a large hash table unsuitable for
literal transplantation into the kernel swap path. No Rust source is copied.

## Prototype

The reference C files were copied from the existing Fedora custom kernel
`linux-7.2.8` source tree, not fetched from an unrelated upstream revision.
Their SHA-256 values are in `docs/SOURCES.sha256`. Original copyright/license
notices remain. Kernel LZ4 implementation files are BSD-2-Clause; the Linux
interface header includes GPL version 2 terms. New harness code is GPL-2.0-only.
Trueno's workspace declares MIT OR Apache-2.0 with an MIT license file; any future
copy must preserve the selected compatible license and attribution. Independent
C implementations currently avoid that issue.

`tools/build.py` copies reference files into ignored build directories, then
injects small experimental loops. SSE2 compares 16 bytes, AVX2 compares 32 bytes;
movemask and trailing-zero count identify the first mismatch. Loads are bounded
by the original input limit. The scalar tail is preserved. Compression token
choices and wire format are unchanged.

Vector wild copies require a complete vector before the logical destination end
and an overlap distance at least the vector width. Short overlaps retain the
original sequential 8-byte copying behavior. The original maximum 7-byte wild
copy overrun contract remains intact. A count-only AVX2 variant isolates copying.

The scalar build disables compiler SIMD, and all variants disable loop automatic
vectorization. Intrinsic variants enable their ISA explicitly. Builtin memcpy
may still call glibc, unlike the real kernel; user-space timing therefore cannot
predict kernel results by itself. Separate shared libraries bind internal calls
locally to avoid accidental symbol interposition between variants.

## Kernel integration requirements

Linux 7.2's ZRAM LZ4 backend calls the LZ4 library directly; registering a crypto
algorithm alone will not change its compression path. Prefer a separate optional
backend and vector translation unit, preserving the existing scalar backend.

Consult [kernel floating-point guidance](https://docs.kernel.org/core-api/floating-point.html)
and [x86 state management](https://docs.kernel.org/arch/x86/xstate.html).
A kernel implementation must check CPU features and `irq_fpu_usable()`, bracket
vector work with the supported `kernel_fpu_begin/end` facilities, and use scalar
fallback in disallowed execution contexts. SIMD compiler flags must remain
limited to the vector translation unit. Preemption, ZRAM stream locking and
concurrency must be reviewed against the exact target source. Reuse existing
per-stream workspaces; no allocation in the hot swap operation. Measure one
SIMD entry/exit pair per page, including its overhead, before selecting dispatch.

This user-space prototype does not implement kernel state management and must
not be linked into the running kernel as-is.

Intel's [Optimization Reference Manual, revision 049](https://cdrdv2-public.intel.com/814198/248966-Optimization-Reference-Manual-V1-049.pdf)
describes Gracemont's native 128-bit vector data paths and splitting of most
256-bit operations into 128-bit micro-operations. This motivates measuring SSE2
and AVX2 separately; it does not predict which complete codec wins. The N100
benchmarks, rather than vector width alone, determine dispatch choices.

## State preservation and unsupported contexts

The kernel probe also enters an outer kernel FPU section before calling each
wrapper. `irq_fpu_usable()` must then reject nested SIMD use, and both operations
must still round-trip correctly through scalar fallback. The SMP diskless fixture
runs four processes doing direct ZRAM writes and reads on disjoint pages. A raw
syscall helper fills all 16 YMM registers with sentinels, performs pwrite64 or
pread64, and stores the register contents immediately after returning from the
kernel. This checks user SIMD state across compression, decompression and task
switches. The helper has a baseline main function and a separately targeted AVX2
function, so unsupported CPUs can skip the register test safely.

The same kernel and modules also passed with guest AVX2 disabled; the optional
backend continued using scalar functions. VM success is correctness evidence on
the host CPU only. Physical N100 stress, interrupts, suspend/resume, long-running
memory pressure and boot recovery remain pending.

## Rejected short-overlap broadcast experiment

The user-space generator also retains avx2-guard-overlap and avx2-copy-overlap.
For source distances exactly 8 or 16, an already initialized period can be
broadcast and reused because both distances divide 32. The loop still writes
only complete vectors within its logical copy interval, then uses the scalar
tail. This passed guard/sanitizer/interoperability tests, but extra branches
regressed mixed-data decoding more than they improved sparse decoding in the
native paired comparison. The kernel preparation tool deliberately keeps the
simpler avx2-guard implementation. Further dispatch or overlap expansion should
wait for native kernel profiles rather than fitting synthetic corpora.
