# Hybrid selection, batching and instruction choices

These are engineering hypotheses and measurement requirements, not accepted
native ZRAM improvements. The physical fifth cohort supports direct block
packing as an encoder component; bitdirect retains the stronger sparse/repeat
decoder. The sixth cohort tests sampled selection and preserves known aligned
sparse size regressions. The current kernel integration draft starts with the
validated scalar bitdirect port and a matched private LZ4 control.

## Instruction sets can be mixed

An AVX2-capable CPU can execute scalar, SSE, AVX and AVX2 operations in the same
codec. AVX2 adds the 256-bit integer comparison/permutation operations used by
these GZRAM scan/packing paths. AVX has useful wide loads/stores and bitwise
operations too; an AVX2 label does not mean that every instruction requires AVX2.
An AVX-only copy/repeat helper and a 128-bit alternative are credible controls,
not automatic lower-power choices. AVX and AVX2 can use the same YMM registers,
so choosing AVX alone does not remove kernel SIMD state-management obligations.
Scalar/vector transitions and generated instructions must be audited and timed.

References: [Intel instruction-set overview](https://www.intel.com/content/www/us/en/support/articles/000005779/processors.html)
and [Intel architecture manuals](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html).
The exact local 7.2.11 kernel's arch/x86/include/asm/fpu/api.h requires the kernel
FPU begin/end API for such use. No N100 power or frequency effect is inferred
from an instruction-set label or another processor's measurements.

## Batch already-ready pages before introducing a waiting queue

A batch could amortize function calls and kernel FPU entry/exit across multiple
independently encoded pages. It must not create an inter-page dictionary or
require reading/decompressing neighboring pages to recover one faulted page.
SOL's component experiments demonstrate that batching can change some SIMD
crossovers; they do not establish a whole-codec batch size or ZRAM queue policy.

The first meaningful control is a set of already-ready, resident pages: compare
one-page and multi-page calls, both scalar and SIMD, with matched scalar work
inside/outside the FPU section. Report total time and per-page time separately,
including interface, state handling and CPU time. Vary page count and data; do
not add an old fixed FPU-cost estimate to a new userspace result. Empty-section
controls remain separate; subtracting them does not create measured codec time.

A resident fixture has zero collection wait by construction. It cannot justify
production throughput claims that assume such a batch is always available. An
actual queued design must additionally account for page arrival/collection time,
queue memory, page ownership/lifetime, mapping, wakeups, scheduling, cancellation,
backpressure and whether the batch consumes a worker or blocks a requesting task.
Locks, allocation, waiting and faultable access must stay outside a kernel FPU
section. Preemption-disabled duration must be bounded and measured, not simply
increased until a throughput curve looks better.

Bulk reclaim or background recompression may have ready compression work.
Demand decompression usually serves a waiting page fault: delaying it to fill a
batch can hurt responsiveness. Speculative decompression can waste CPU, memory
and energy if the other pages are not used. A ready-page batch with immediate
single-page fallback is therefore a credible first investigation; no collection
threshold, timeout or crossover is accepted without physical measurements.

Native ZRAM evaluation must measure scheduling/page-fault latency distributions,
application responsiveness, memory use, CPU and available energy alongside
throughput and bytes. The current scalar ZRAM integration draft introduces no
queue, batch or SIMD section, so its correctness gate cannot establish any of
these batching benefits.

## Parallel-execution experiment

The seventh cohort tests independent scan groups within a single page, with
AVX `VXORPS/VORPS`, AVX2 `VPCMPEQD`, and scalar mask bookkeeping in the same
loop. Matched variants retain integer `VPXOR/VPOR`; one-, two- and four-group
loops separate scheduling width from instruction selection. No arithmetic
conversion to floating point occurs. Source intrinsics are checked against
machine-code disassembly. This creates opportunities for concurrent execution
but does not establish which execution ports are used or prove that overlap
caused a measured whole-codec speed difference. It adds no queue, background
thread, cross-page dependency, or extra kernel FPU transition. Userspace results
still exclude the FPU entry/exit that kernel integration would require.
