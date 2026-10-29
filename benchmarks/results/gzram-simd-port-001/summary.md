# Guarded SIMD workspace port: correctness and build checkpoint

The measured V8 cutoff-2 grouped AVX-bitwise scanner/direct packer now has an
explicit-workspace port. It retains the CTZ sparse decoder and AVX repeat
expansion. A scalar dispatcher checks CPU/OS support and kernel SIMD usability;
only the tentative GZRAM compression and mode-1 decode run inside kernel FPU
entry/exit. Rejected encoding uses private scalar LZ4 after FPU exit. Raw/LZ4
decode and feature-unavailable contexts use the validated scalar path. There is
no cross-page state, queue or format change, and no guessed SIMD crossover.

The general port gate passed normal and ASan/UBSan byte-identity, independent
mask/repeat decoding, truncation/malformed input, guarded boundaries, caller-owned
workspace misuse/reuse and four-thread tests. Both normal dispatch and a forced
feature-unavailable build were tested. Scalar dispatcher/fallback objects have
no SIMD register instructions; only the three designated vector objects do.
Additional runs under policy-specific library names enable the existing test
suite's cutoff/scanner/compact-repeat fixtures. Their exact counts and logs are
retained in policy/. This supplements the earlier general gate rather than
mistaking its generic-name coverage for the full policy suite.

The exact 7.2.11-200.fc44 kernel module builds and passes object isolation audits.
Kernel vector objects use CC_FLAGS_FPU plus AVX2; GCC intrinsic allocation helpers
are excluded, and compiler/header hashes are recorded. The build has no BTF
because matching vmlinux/pahole are unavailable; this does not establish BTF or
compiler portability. Per-function stack reports are not whole-call-chain peaks.
Vector object unresolved symbols contain no LZ4 or kernel FPU entry calls; the
scalar dispatcher owns the FPU boundary. Correctness-only atomic path counters
and a hypervisor gate are added by the builder: this module refuses bare-metal
execution and cannot serve as a native performance module.

Earlier generation/build attempts remain preserved: a source-split newline
assertion, a reviewed mixed-decoder entry correction, signed-pointer declarations
in the extracted LZ4 call, and missing kernel function prototypes. None is
represented as a successful test. Existing SOL/Astra codecs are unchanged.

See vm-status.json for the exact guest gate status. Native SIMD state cost,
user-register preservation across syscall/preemption, critical-section duration,
recovery, energy, allocator-rounded memory and real ZRAM pressure are unproven.
The current stock zstd configuration remains untouched. The next steps are
exact-kernel SIMD/fallback guest gates when headroom permits, a register-state
probe, and recovered native measurement with fresh controls. No speed or energy
claim is made for this generated kernel port.
