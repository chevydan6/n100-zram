# Scalar hybrid syscall probe: isolated correctness gate

The new probe passed two diskless VM load/test/unload cycles on the exact
7.2.11-200.fc44.x86_64 kernel. Each cycle used all 20 frozen physical-benchmark
corpora and passed 101,071 client assertions, including concurrent shared-file
and separate-file calls, unknown ioctls, invalid lengths, invalid pointers,
non-seekable behavior, rewrite after a failed write, size consistency and
cross-decoding. The unchanged full hybrid self-test also passed again through
the extended VM runner: two cycles, four workers and 207,818 assertions/cycle.
These are correctness results, not VM performance measurements.

The probe compares matched private scalar LZ4 (MEMORY_USAGE=12), the wordmixed
workspace port and the separate bitpack/CTZ workspace port. It uses the previously
validated explicit-workspace sources, with independent namespaced codec objects.
Each ioctl compresses or decodes one resident page. A no-op ioctl uses the same
per-file mutex to expose interface cost; no subtraction or overhead result has
yet been computed. The three codecs retain separate compressed buffers and
per-direction cursors. Validation checks every retained frame outside timing,
including both GHY1 decoders and byte identity between the scalar hybrid ports.

Each open requests 2,208,032 bytes of payload/workspace buffers plus the context,
allocator rounding and VM metadata. This deliberate 128-page resident fixture
is not ZRAM's per-stream memory requirement. Workspace is 4,128 bytes per open;
there is no queued/background work and no kernel FPU section or SIMD instruction.
The compiled probe's largest reported frame is 120 bytes; codec frame estimates
remain separately recorded. These are per-function compiler estimates, not a
measured maximum call-chain stack.

The first build failed because this kernel no longer defines no_llseek. The
failed source/log/result are preserved. The corrected interface uses
nonseekable_open and no llseek callback; the client explicitly verifies ESPIPE.
The successful module hash is
cf651898fea7f3400cad106310b49b5135778517d8378dfaa67d51ad0af8ca51.
No SIMD-register instructions were found. Exact copied codec source, Makefile,
stack reports and module/client hashes are retained; built executables are
reproducible local artifacts rather than committed binaries.

The guest had 256 MiB, two vCPUs, AVX2 hidden, no disks or network and a bounded
180-second lifetime. Only expected unsigned/out-of-tree taint messages appeared;
no warning, oops or panic occurred. This kernel is not KASAN-instrumented.
Existing userspace sanitizers/guards remain necessary for memory-access coverage.
The host's ZRAM and CPU setting hashes remained unchanged and no experimental
GZRAM module was loaded there.

Still missing: a controlled native performance client, current-kernel recovery
verification, native syscall/CPU/package measurements, SIMD-state controls,
actual ZRAM registration, memory-pressure/application responsiveness tests and
battery comparison. This prototype does not authorize a production rollout.
