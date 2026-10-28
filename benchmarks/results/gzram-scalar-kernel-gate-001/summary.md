# Scalar GZR1 component kernel correctness gate

The independently userspace-validated reference and CTZ scalar ports compiled
against 7.2.11-200.fc44.x86_64 headers with matched integer-only flags. The module
contains no SIMD register instructions in disassembly. GCC was 16.2.1; BTF was
skipped because a matching vmlinux was unavailable. Exact flags, input port
manifests, source copies, compiler, module hash and vermagic are retained.

A diskless KVM guest booted the matching kernel image with 256 MiB RAM, two vCPUs,
AVX2 hidden, no host disks and no network. Two load/test/unload cycles each passed
161,410 assertions across four workers. Coverage includes independent mask
frames, all mask-frame truncations, capacity canaries, cross-decoding, byte
identity, variable-length round trips and mutation differentials. The guest
reported no warning/oops/panic; expected unsigned/out-of-tree module taint is
visible in the raw serial log. Output canaries do not detect out-of-bounds reads;
this is not a KASAN kernel or exhaustive kernel verification.

This tests only the scalar GZR1 component, not GHY1/LZ4, SIMD state handling,
ZRAM behavior, native kernel performance, host recovery or production readiness.
No experimental module was loaded on the host. The native validation lock kept
this gate separate from physical codec measurements. Postflight hashes confirm
unchanged stock ZRAM and CPU settings. The VM's boot/test duration is not a codec
benchmark and must not be compared with native timing.
