# Scalar bitmerge/bitdirect workspace ports: userspace correctness

The generator adds explicit bitmerge and bitdirect policies with the preserved
CTZ encoder/decoder components. Normal and ASan/UBSan builds passed all 28
recorded steps. Each policy matches its corresponding measured fourth-cohort
encoder byte for byte. The default wordmixed adapter's machine-code text is
unchanged. Every compiled adapter was scanned for SIMD register instructions;
none were found. No performance result follows from these port checks.

For bitdirect, each normal/sanitized container check passed 34,816 round trips,
34,768 capacity cases, 62 repeat-merge checks, 560 nested-header mutations,
48,576 repeat boundary checks, 71,680 independent mask cases, 80,000 malformed
or mutated decode cases and 4,000 four-thread round trips. A separate run used
the old wordmixed decoder to validate compatibility. Independent wire/liblz4
oracles remain in use; the format is still GHY1 with nested GZR1 or LZ4.

Explicit workspace remains 4,128 bytes with eight-byte alignment. Each normal
and sanitized policy passed 1,176 workspace identity/reuse/rejection cases and
1,000 round trips with four independent concurrent workspace owners. Poisoned
previous contents did not create cross-page state. The thread-local compatibility
adapter is userspace-test-only; kernel integration must own workspace per stream.
Caller workspace, kernel stack and scheduling costs require later measurement.

Generated sources, source manifests, compiler commands, full logs and validation
worker are retained. This directory covers userspace correctness only; the
separate kernel-gate directory records the subsequent exact-kernel VM checks.
No host module, ZRAM change, performance or production promotion occurred here.
