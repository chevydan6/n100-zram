# Guest per-page allocation trace

This follow-up investigates the clustered fixture's surprising allocation result in the [shuffled guest experiment](../terra-vm-zram-corpus-random-001/findings.md). A diskless, networkless exact Fedora 7.2.11 kernel KVM guest wrote 128 pages sequentially to the experimental ZRAM device, recorded all nine `mm_stat` fields after each write, and read the full corpus back byte-for-byte. The three existing synthetic fixtures and their hashes are recorded in `guest.json`. The four tested implementations were the earlier guarded `ghy-simd`, scalar `ghy-bitdirect`, private `lz4-ghy`, and stock kernel zstd; `lz4-ghy` is not the stock LZ4 control. Two sequential module-load cycles were run in a fixed algorithm order; they are not independent randomized trials.

All 24 traces and 3,072 page records passed the strict analyzer, along with the existing concurrent guest correctness, CPU hotplug, stock-device coexistence and unload checks. The analyzer additionally rejected a removed record, a duplicated record and an incorrect original-size record. Guest ZRAM settings and CPU-frequency setting hashes matched on the host before and after, and no experimental host module was loaded. The new trace does not establish recovery from a native hang. Raw console output, the modified launcher, the original launcher result, and every compressed-length histogram are retained here. The launcher is a diagnostic copy of `gzram/tools/vm-zram-corpus-random.py`; its parser dependencies are the unchanged files in that directory. `analyze.py` accepts a directory containing `result.json` and decompressed `serial.log`.

| Fixture, implementation | Compressed bytes | Allocated bytes | Distinct per-page compressed lengths | Allocation-increase events |
|---|---:|---:|---:|---:|
| clustered 25%, GHY SIMD | 150,016 | 471,040 | 25 | 29 |
| clustered 25%, zstd | 144,733 | 741,376 | 117 | 37 |
| sparse words, GHY SIMD | 84,588 | 274,432 | 45 | 17 |
| sparse words, zstd | 103,498 | 425,984 | 98 | 22 |
| random, both | 524,288 | 524,288 | 1 | 128 |

The two cycles gave the same values in this table. For this particular clustered sequence, GHY's compressed total was 3.65% larger but its allocation was 36.46% smaller than zstd's; for sparse words it was 18.27% smaller compressed and 35.58% smaller allocated. GHY produced fewer distinct lengths and fewer separate allocation-increase events, consistent with the possibility of greater packing efficiency. Distinct byte lengths do not identify allocator classes, and the stock kernel has `CONFIG_ZSMALLOC_STAT` disabled, so this does not establish the class-level mechanism. Allocation events can include more than one physical page, and do not directly count classes. The different 128-page sequential-write protocol is not numerically identical to the previous 127-page, concurrent-write-and-discard protocol.

These deliberately selected small synthetic fixtures do not measure a representative workload, speed, CPU time, energy, tail latency, native FPU overhead, or battery life. The observations do not establish the 10% real-world acceptance target. A statistics-enabled diagnostic kernel might directly examine class occupancy, while a recovery-verified native study remains necessary for real ZRAM conclusions.
