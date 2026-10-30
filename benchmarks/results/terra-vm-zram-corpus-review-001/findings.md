# Exact-kernel guest ZRAM allocation by corpus

The prior [mixed-corpus guest observation](../terra-vm-zram-allocation-001/findings.md) could hide workload-specific differences. This follow-up reset the namespaced guest ZRAM device after each of the same 26 retained synthetic/executable corpora and collected `mm_stat` after the four-worker client independently wrote, read and verified each corpus and discarded one page. Each record therefore covers 127 source pages. Two sequential module-load cycles tested scalar GHY, the earlier guarded SIMD GHY prototype, private LZ4, standard LZ4, LZO-RLE and zstd. The guest also ran the existing combined-corpus CPU1 hotplug, stock-device preservation and unload checks. There were no guest disks or network, no host experimental module load, and recorded host ZRAM/frequency settings matched before and after.

The guest reached its success marker and completed all device checks, but the first report was **failed**: three of 312 allocation markers were split by timestamped kernel printk messages, so a strict line matcher parsed only 309. The original failure record and serial output remain intact. A separate parser reconstructs only timestamp-interleaved markers, checks owning algorithm boundaries, exact unique corpus/cycle coverage and page counts, and rejects malformed/duplicate records. It passed 78 split positions and four negative cases. The [reanalysis](review-result.json) rechecked the preserved console, guest protocol, stock-data checks, all inputs and binary hashes, and recovered all 312 records. This is a corrected analysis of the original run, not a new run or an alteration of its failed report. The launcher now uses the tested parser for future runs.

Examples below show first / second cycle values, in bytes. `mem_used_total` reflects guest zsmalloc page allocation including class fragmentation, not just compressed payload. **Only two sequential, fixed-order cycles** were measured; individual corpora have only 127 pages and results can vary substantially with allocator history.

| Corpus | Algorithm | Compressed bytes | Allocated bytes |
|---|---|---:|---:|
| sparse words | SIMD GHY | 83,912 / 83,912 | 286,720 / 286,720 |
| sparse words | LZ4 | 137,076 / 137,076 | 524,288 / 532,480 |
| sparse words | zstd | 102,664 / 102,664 | 438,272 / 438,272 |
| Bash ELF | SIMD GHY | 413,560 / 413,560 | 684,032 / 716,800 |
| Bash ELF | LZ4 | 409,221 / 409,221 | 667,648 / 651,264 |
| Bash ELF | zstd | 334,180 / 334,180 | 606,208 / 593,920 |
| random | all four listed codecs | 520,192 / 520,192 | 520,192 / 520,192 |

The four codecs in the random row are SIMD GHY, LZ4, LZO-RLE and zstd; all 127 pages were stored as huge/raw. All-zero pages were recognized as same-filled and allocated zero bytes across all algorithms. For period127, SIMD GHY's identical 20,447 compressed bytes occupied 49,152 / 32,768 allocated bytes across the two cycles, illustrating why small allocations and class fragmentation resist simple percentage claims. The complete table—including LZO-RLE, scalar GHY, private LZ4 and every corpus—is [per-corpus.csv](per-corpus.csv); the full nine-field observations and source hashes are in `review-result.json` and the compressed original serial log.

These are actual **guest** device allocation counters for synthetic fixtures, not a physical-laptop memory-pressure test, a workload-weighted result, CPU/energy measurement, or production readiness evidence. The earlier SIMD prototype is not the newer userspace sampling candidate. Real swap behavior, allocator history at scale, application responsiveness and native SIMD costs remain unproven. Boot recovery remains unverified; no experimental host module should be loaded on this evidence.
