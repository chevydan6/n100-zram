# Exact-kernel scalar ZRAM device correctness checkpoint

The completed diskless, networkless KVM guest passed 241,970 checks: two
module load/unload cycles, five algorithms (lzo-rle, lz4, zstd, private lz4-ghy,
and scalar ghy-bitdirect), 26 corpora, four workers and 24,197 checks per run.
The client exercised write/read, shuffled access, zero/same-word pages,
rotated data and discard. Kernel 7.2.11-200.fc44.x86_64 matches the host;
256 MiB guest, two vCPUs, AVX2 hidden. This validates scalar device integration,
not SIMD performance, representative pressure, native energy or responsiveness.

The original launcher reported failure because a kernel printk split an end
marker across lines. Its result and console remain unchanged in original-guest/.
The corrected parser reconstructs protocol lines while scanning the untouched
console for every failure token. Its unit tests cover 180 interleaving positions,
five failure tokens and five negative protocol cases. Review of the same run
verified ten complete ordered results, exit zero, one VM_PASS, no failure tokens,
and exact module, kernel, runner-input and corpus hashes. No duplicate VM run was
needed. See review/result.json and review/parser-tests.log.

The source RPM digest was checked; publisher signature was not verified.
Experimental scalar objects contain no SIMD register instructions in the saved
object audit. Caller-owned private LZ4 workspace is 4,128 bytes before allocator
rounding. Guest memory-pool statistics are diagnostic, not a native comparison
or a representative workload weighting; they exclude codec workspace.

Host available memory had recovered above the existing 2 GiB headroom gate
before launch. The exclusive native testing lock was held. No experimental host
module was loaded, and stock zstd ZRAM, boot and CPU settings were preserved.
Current native recovery and privileged package-energy access remain unverified.
The next integration task is a separately guarded SIMD codec with scalar LZ4
fallback outside the FPU critical section, followed by isolated and VM gates.
