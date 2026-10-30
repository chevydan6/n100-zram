# Guest ZRAM allocation as the pool grows

This follow-up tests whether the allocation difference in the [per-page trace](../terra-page-allocation-trace-001/findings.md) persists as the pool fills. In a diskless, networkless KVM guest using the running Fedora 7.2.11 kernel, each algorithm wrote one to eight copies of the same 128-page fixture to a fresh experimental ZRAM device. Each copy was immediately read back and compared byte-for-byte. `mm_stat` was recorded at every 128-page increment. The existing client also ran its independent concurrent correctness, discard, CPU-hotplug, coexistence and unload checks. Two sequential module-load cycles used fixed algorithm and corpus order; they are not independent randomized trials.

All 384 scaling records were present and passed validation, including expected original sizes, linearly repeated compressed totals, and nondecreasing allocation. The analyzer rejected removed, duplicated and invalid-copy records. Host ZRAM and CPU settings hashes were unchanged and no experimental module was loaded on the host. The tested GHY SIMD is the earlier guarded kernel prototype; the private `lz4-ghy` is a separate hybrid, not stock LZ4. Raw guest logs, hashes, runner and all results are retained. Values below were identical in both cycles.

| Fixture | Pages | GHY SIMD allocation | zstd allocation | Stock LZ4 allocation | LZO-RLE allocation | GHY vs zstd |
|---|---:|---:|---:|---:|---:|---:|
| clustered 25% | 128 | 471,040 | 741,376 | 815,104 | 778,240 | −36.46% |
| clustered 25% | 1,024 | 1,417,216 | 1,609,728 | 1,601,536 | 1,568,768 | −11.96% |
| sparse words | 128 | 274,432 | 425,984 | 520,192 | 491,520 | −35.58% |
| sparse words | 1,024 | 802,816 | 1,093,632 | 1,392,640 | 1,380,352 | −26.59% |
| Bash ELF | 128 | 667,648 | 577,536 | 630,784 | 663,552 | +15.60% |
| Bash ELF | 1,024 | 3,518,464 | 2,940,928 | 3,493,888 | 3,502,080 | +19.64% |
| random | 1,024 | 4,194,304 | 4,194,304 | 4,194,304 | 4,194,304 | 0% |

On the 1,024-page clustered case GHY compressed 1,200,128 bytes versus zstd's 1,157,864 bytes, a 3.65% larger compressed total despite 11.96% less allocated memory. The large 128-page allocation gap shrank considerably as identical page patterns were repeated, showing that small-pool allocation overhead cannot be extrapolated directly. Sparse-word savings persisted for this repeated fixture, while Bash allocation was substantially worse than zstd. The numbers include allocator rounding and fragmentation but do not isolate their mechanisms: `CONFIG_ZSMALLOC_STAT` is disabled in this kernel.

Repeating the same 128 pages does not recreate a diverse or dynamically changing real workload. This is neither a performance nor energy test and does not measure pressure, latency, actual native SIMD overhead or battery life. No general improvement or 10% real-world acceptance is established. Native experiments remain gated on a verified recovery path.
