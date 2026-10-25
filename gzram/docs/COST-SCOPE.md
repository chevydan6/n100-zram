# Codec tuning cost and kernel SIMD cost are separate

GZRAM screening measures userspace codec calls: classification, repeat search,
format emission/parsing, scalar or vector instructions, dispatch and libc calls.
It does not enter a kernel FPU section per page. The half-zero encoding change
from about 342 to 444 ns/page in native-gzram-filter-001 is therefore a codec
search/selection regression, not a measurement of kernel SIMD state overhead.

Kernel component experiments use separate scalar, scalar-with-FPU, SSE and AVX2
controls, with caller-state fixtures and complete ioctl timing. Their historical
approximately 430 ns dirty-YMM delta is a workload/context-specific observation.
Do not add it as a universal fixed constant to userspace codec results and label
the sum a measured kernel performance result. Independent-operation batching
is tested separately on feature/n100-adaptive-simd-zram under
adaptive/COST-ACCOUNTING.md; it does not change kernel page size or implement
ZRAM batching. Complete codec and end-to-end ZRAM tests remain necessary.

Keep compression ratio, useful codec work, state/dispatch controls and end-to-end
measurements in separate tables. RAPL reports package energy over the documented
batch/workload, including bookkeeping/background work; it is not laptop energy.
Original fast paths and all unsuccessful candidates remain available. No hybrid
codec or kernel backend is preferred solely from these component observations.
