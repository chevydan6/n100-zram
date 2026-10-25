# Separate codec work from kernel SIMD state handling

| Measurement | Included | Excluded / limitation |
|---|---|---|
| Userspace GZRAM/LZ4 codec | Search, classification, format work, vector/scalar instructions, dispatch and libc calls | Kernel FPU entry/exit, ZRAM allocation, swap and application contention |
| Kernel component probe | ioctl, mutex, dispatch, scalar/SSE/AVX2 primitive, loop and state handling | Complete codec parsing/search, ZRAM allocator and swap |
| Native ZRAM I/O / pressure | Actual compressor, allocator, I/O or reclaim; competing workload where explicitly enabled | Synthetic fixtures do not establish general application responsiveness |

Keep these scopes separate in source metadata, tables and acceptance claims.
The approximately 430 ns dirty-YMM matched-control delta is an observed probe
result, not an architectural constant. FPU-scalar versus scalar charges the
surrounding entry/exit and dispatch difference while retaining the scalar body.
Vector versus FPU-scalar compares the useful-work paths under FPU handling.
Neither subtraction is a cycle-exact decomposition independent of code layout,
caller xstate, frequency, scheduling and cache behavior. Do not add userspace
codec savings to a fixed 430 ns and call the result a measured kernel gain.

## Independent-operation batching probe

A new ioctl (legacy configuration remains supported) requests 1/2/4/8/16
independent operations. Each uses a distinct region and 32-byte canary; total
payload is bounded to 64 KiB. Buffers are allocated before execution. The FPU
section wraps the complete batch once, with scalar fallback when SIMD is unsafe.
No allocation, mutex acquisition or sleeping occurs within that FPU section.

Measure 4096 bytes per operation for equal/early/middle/late comparisons,
literal copies and repeated-eight-byte copies. Report both total time per ioctl
and time divided by independent-operation count. The matched FPU-scalar delta
per ioctl is an estimate within this probe, not an invariant machine property.
Use three caller-state fixtures, randomized session/batch order, repeated rounds,
PMU scheduling checks and package RAPL. Compare within the new matched probe;
its batching loop changes code layout relative to historical single-operation data.

This tests possible amortization, not a ZRAM batching implementation. Native
ZRAM still handles independent 4 KiB pages normally. Real batching would require
page-lifetime, locking, buffering and swap-latency analysis before integration.
Keep the module out of production defaults and unload it after measurements.

The exact-ABI module passed a diskless VM with legacy configuration, all five
batch sizes, invalid-configuration rejection, per-operation canaries, nested
fallback and all sixteen YMM sentinels (108 configurations / 432 sentinel calls).
The first VM helper lacked its dynamic loader; a static helper corrected the
test image. Both attempts are preserved privately. See the sanitized validation
record in adaptive/results/components-batch-vm/. Build the helper with:

```
gcc -static -O2 -Wall -Wextra -Werror -Iadaptive/kernel-components adaptive/components-bench.c -o components-bench
```

The normal runner's behavior remains available. The batching experiment uses:

```
python3 adaptive/run-components.py --module /absolute/probe.ko --validated-sha256 SHA256 --helper /absolute/components-bench --batches 1 2 4 8 16 --page-only --output /absolute/fresh-output
```

Run only under the shared native benchmark lock and preserve the exact module
hash, helper hash and complete row matrix. No batching performance claim is
accepted before measurements on the physical N100.

## First physical N100 batching result

native-component-batches-001 completed all 15 session/configuration batches.
All PMU groups were fully scheduled, RAPL was available, checks passed and the
probe was unloaded. For YMM-dirty equal 4 KiB comparisons, AVX2 was 63.2% slower
than scalar at one operation per entry, 4.3% slower at four, 21.8% faster at eight
and 33.5% faster at sixteen. The matched FPU-scalar delta was approximately
429–441 ns per ioctl for these comparisons; division over sixteen operations
reduces its effective share to about 27 ns per operation. This demonstrates
amortization in this probe, not removal of required state protection.

Literal and repeat-eight copies still lost to scalar at sixteen operations
(about 18.5% and 20.9% respectively). More batching does not make every vector
primitive profitable. The next refinement tests counts 4/5/6/7/8 in the same
validated module, with scalar and FPU-scalar controls retained. Neither result
constitutes a whole-codec or native ZRAM batching improvement.
