# Kernel-inclusive scalar measurement client correctness

The static client compiled with GCC 16.2.1 and -Wall -Wextra -Werror. In two
isolated exact-kernel VM load/test/unload cycles, all 20 preserved corpus files
passed 26,444 assertions per cycle, including preservation of all sixteen YMM
registers around each codec ioctl and the no-op ioctl. AVX2 was exposed to the
client in this guest; the scalar kernel module itself contains no SIMD-register
instructions. Both attempts to use --measure inside the VM were rejected before
opening the device or collecting timing. No native timing result is supplied.
The previous device-interface concurrency/invalid-buffer gate remains separate.

Default invocation validates only. Explicit --measure additionally requires a
physical N100 with OS AVX2 support and pins the client to CPU0. Each batch issues
one page per syscall to matched private scalar LZ4, wordmixed or bitpack/CTZ, or
issues no-op controls. Compression and decoding are separate. Three userspace
vector conditions are shuffled with all seven operations in every round: vectors
cleared before the loop, SSE dirtied immediately before each syscall, or YMM
dirtied immediately before each syscall. Clearing before clock calls does not
prove a pristine kernel FPU state; the label deliberately describes the action.

Measurements include wall time, thread CPU time/occupancy, compressed bytes,
user-plus-kernel PMU groups and available package RAPL. Hypervisor counters are
excluded, PMU scheduled fractions are reported, and unavailable metrics are -1.
Two warm-up rounds precede nine recorded rounds. --seed and --ops are recorded;
ops must be a positive multiple of 128. The default 8192 is a measurement batch,
not a kernel batch or accepted crossover. The kernel still handles one independent
page per ioctl, with no queue or background worker. Longer/shorter call batches
can assess counter/bookkeeping noise, but have not yet been measured here.

Every retained page is checked before/after each batch outside timing. Timed
loops include the syscall, kernel mutex/cursor handling, codec and return-value
check. PMU and package intervals also include counter/clock bookkeeping; package
energy includes other activity. No-op costs are reported separately, never
subtracted to manufacture a codec-only result. These are warm resident fixtures,
not swap latency, application responsiveness, cold-cache behavior, FPU begin/end
cost or whole-laptop energy. See the preceding probe gate for memory accounting.

The binary and module hashes, compiler command, corpus hashes and complete guest
logs are retained. Current-kernel recovery verification and a bounded native
load/measure/unload/restoration controller remain necessary. Stock host ZRAM and
boot settings were not changed, and no host GZRAM module was loaded.
