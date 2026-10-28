# Explicit-workspace scalar GHY1 userspace gate

Reference wordmixed, CTZ decode and combined bitpack/CTZ ports passed normal and
ASan/UBSan checks. Each policy/build passed 34,816 cross-decoder round trips,
34,768 guarded encoder capacities, 71,680 sparse-mask decoder checks, 48,576
repeat boundary cases, 80,000 malformed/mutated inputs and 4,000 four-thread
round trips. Frames match the preserved wordmixed scalar/AVX2 encoders exactly
and pass independent Python/system-LZ4 decoding.

The explicit API requires a separate 4,128-byte, eight-byte-aligned LZ4 workspace
per concurrent encoding call. No allocation or persistent dictionary is added.
Each policy/build additionally passed 1,176 identity, workspace-poison/reuse and
invalid-workspace rejection cases plus 1,000 four-thread round trips. The public
explicit API was tested directly; the compatibility adapter's thread-local
storage is userspace-only. Guard pages bound workspace/output ends, and invalid
workspace calls leave both workspace and output unchanged.

The new bitpack GZR1 component was separately checked normally and with
sanitizers before composing the hybrid ports. All generated source hashes,
commands, source copies and logs are retained. Scalar library disassembly has
no SIMD register references. These are userspace correctness results; adaptation
changes code generation and requires its own matched performance measurements.

The first exact-kernel build failed because Linux's noinline macro expands inside
an unqualified GCC attribute token. Its source, command and failure remain under
kernel-first-build. The planned repair uses the equivalent reserved __noinline__
attribute spelling and records that transformation. No full GHY1 kernel execution
or ZRAM integration is established by this checkpoint.
