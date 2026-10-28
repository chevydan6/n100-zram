# Full scalar codec inside kernel FPU handling: correctness gate

The opt-in probe now brackets the same scalar LZ4, wordmixed and bitctz
compression/decompression calls with kernel_fpu_begin()/kernel_fpu_end().
The ordinary scalar calls and empty FPU/no-op controls remain. Resident buffers
and private workspaces are allocated beforehand; each section processes one
bounded page without allocation, sleeping or locking. The per-file mutex stays
outside the section. No codec vector instructions, batching or ZRAM registration
are introduced. All eight codec object text sections match the previous gate.

Two exact-kernel diskless VM gates passed twice each on kernel 7.2.11:

- Interface: 20 corpora, 162,513 assertions per cycle, including plain and FPU
  operations under shared/separate file concurrency and integrity checks.
- Measurement client: 20 corpora, 44,924 assertions per cycle. All sixteen YMM
  registers, nondefault MXCSR and x87 control values survived each operation;
  original controls were restored. VM timing requests were rejected.

The optional --fpu-control matrix now has fourteen operations: six plain codec
calls, six matched FPU-bracketed scalar calls and two interface controls, each
under three userspace vector conditions. The default remains seven operations.
This enables empirical whole-call comparisons; do not subtract an empty-section
constant and treat the difference as a measured SIMD codec. Scheduling and
preemption effects belong in the later physical results. No native timing,
energy, crossover or batching result is established here.

The first measurement-client build failed -Werror=misleading-indentation on a
for loop followed by shuffle on the same line. Its exact source/logs are retained
in clients-001. Splitting those statements fixed compilation. The successful
module was unchanged and reused for the second attempt after source-hash checks.
The successful clients and complete guest logs/results are retained separately.
The result JSON's inherited scope string conservatively says no SIMD-state
result; these logs do establish the specifically listed userspace state checks,
not every CPU state or recovery failure mode. No KASAN kernel was used.

Host ZRAM and CPU-setting hashes still match the previous checkpoint. No
experimental module was loaded on the host. Current privileged recovery review,
controlled physical kernel measurements and native ZRAM validation remain open.
