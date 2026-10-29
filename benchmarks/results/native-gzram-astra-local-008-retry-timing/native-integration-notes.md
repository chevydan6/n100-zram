# Current-kernel integration review (no host experiment)

The exact 7.2.11 source reference, config and scalar module build are recorded
in `build/astra-zram-reference-001` and `build/astra-zram-bitdirect-build-001`.
The existing guest-only device prototype replaces ZRAM inside an isolated guest;
it must not be loaded over the laptop's active stock module.

A native coexistence variant still needs a separately named module, block disk,
control class and debugfs root. The reference uses `zram%d`, `zram-control` and
`zram` at those registration sites. A separate instance can preserve stock zstd
while exercising owned devices; first prove simultaneous stock/trial operation
and stock-data integrity in the exact-kernel diskless guest. Merely changing the
module filename is insufficient. No coexistence variant has been built yet.

The scalar adapter requests a 4,128-byte workspace per compression context.
That is a request size, not allocator-rounded memory consumption. `zcomp` also
allocates a one-page local copy and two-page output buffer per stream. Stock
LZ4 uses a separate backend context and vmalloc workspace. Native memory
accounting must include these costs and the zsmalloc pool: `mm_stat` alone does
not establish total compressor memory overhead. Do not infer zstd workspace
size or current compression level from historical defaults.

The existing `benchmarks/kernel-pressure.py` is historical LZ4 infrastructure.
Its algorithm allowlist does not include zstd or GHY1, and it obtains an owned
device through the stock driver's control class. It is not directly runnable
as the new acceptance test. Its 768 MiB / 384 MiB memcg stress test and page
comparison p50/p95/p99 are useful bounded reclaim controls, not measurements of
application UI responsiveness. It also enables a higher-priority swap device:
swap priority is global, so a cgroup does not route only that workload to the
owned device. This must be addressed explicitly in native trial design and
recovery/restoration checks, rather than described as application isolation.

Current zswap is disabled. Current stock ZRAM remains zstd. Root access and
protected recovery/boot inspection remain unavailable without authentication;
no watchdog/recovery coverage is inferred from older kernel experiments.
Package RAPL access also remains unavailable. Native module loading, native
SIMD state costs and pressure acceptance are therefore not established.

For SIMD, preserve a scalar fallback and keep vector instructions in separately
controlled entry regions. Test register preservation across all cores, rejection
paths, concurrency and CPU migration before native timing. Measure actual FPU
entry/exit in complete calls under clean and dirty user-vector state. Do not
add an old constant to the new userspace result. Per-page maximum nonpreemptible
duration remains part of the measurement; batching requires a separate queue,
wait/wakeup, memory and foreground-latency evaluation. No batch size is selected.
