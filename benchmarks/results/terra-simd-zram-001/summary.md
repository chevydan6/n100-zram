# Guarded SIMD and scalar GHY1 ZRAM guest correctness

Two separate diskless, networkless KVM guests used the host's exact kernel
7.2.11-200.fc44.x86_64, 256 MiB RAM and two vCPUs. One hid AVX2 and one exposed
it. Each ran two module load/unload cycles for five algorithms: scalar GHY1,
guarded SIMD GHY1, matched private LZ4, stock LZ4 and zstd. Each algorithm/cycle
completed 24,197 client checks across 26 corpora and four workers, totaling
241,970 checks per guest. Both passed; raw console and result records are retained.
The client exercised independent page reads/writes, randomized reads, discard,
zeros and same-word pages. Host settings matched before/after each run and no
experimental module was loaded on the host.

The scalar dispatcher and fallback objects contain no vector-register references;
three designated vector objects do. The AVX2-exposed ZRAM test does not contain
per-path execution counters and cannot alone prove the SIMD branch was exercised.
The earlier separate SIMD syscall probe confirmed vector-path calls and user YMM
register preservation; its scope is not ZRAM device performance. This test is
correctness only: it does not measure FPU state overhead, native ZRAM performance,
pressure, energy, responsiveness or recovery. Publisher signature of the source
RPM had not been verified; module BTF was unavailable. The normal boot and ZRAM
configuration remain unchanged.
