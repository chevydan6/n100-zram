# Ideal per-page selection on retained renderer samples

This is a new analysis of the already-audited [renderer energy records](../terra-renderer-energy-audited-001/findings.md), not a new benchmark. For each page, an imaginary selector picks whichever of the measured parent GHY hybrid and the baseline has fewer logical bytes, capping either result at the 4,096-byte raw-page size. It has perfect advance knowledge, zero selection cost and no added format tag. Thus its byte saving is an optimistic upper bound for choosing between these recorded outputs on these particular pages. GHY already includes its existing hybrid framing and fallback; the LZ4 and userspace zstd baselines do not receive an additional selector tag. The cap is a logical raw-storage model, not actual kernel ZRAM accounting.

| Trial | Pages | Baseline | Baseline capped bytes | Ideal bytes | Ideal saving | Pages where GHY is smaller |
|---|---:|---|---:|---:|---:|---:|
| 1 | 123 | scalar LZ4 | 163,660 | 163,265 | 0.241% | 1 |
| 2 | 119 | scalar LZ4 | 159,899 | 159,899 | 0% | 0 |
| 3 | 124 | scalar LZ4 | 169,337 | 169,248 | 0.053% | 1 |
| 1 | 123 | userspace zstd level 3 | 102,918 | 102,917 | 0.001% | 1 |
| 2 | 119 | userspace zstd level 3 | 98,592 | 98,592 | 0% | 0 |
| 3 | 124 | userspace zstd level 3 | 104,529 | 104,529 | 0% | 0 |

For these selected pages, even a free perfect size selector has almost no logical-byte headroom over either baseline. This argues against further size-based GHY selection tuned to these samples, while not ruling out speed-based selection or other data. It does not bound allocator-rounded memory savings, time, energy, native kernel behavior or performance of a different GZRAM candidate. The 128-page synthetic guest experiments show that logical bytes and allocated memory can differ sharply, so this is specifically a logical-byte bound.

The source trials sampled present anonymous pages of disposable Chromium renderers with generated content; thousands of attempts were unavailable or nonresident, and the document renderer was not independently identified. They are not representative browser pages or actual swap/reclaim traffic. The zstd control is userspace libzstd 1.5.7 level 3, not the stock kernel codec. No general 10% acceptance claim follows. `analyze.py` validates source audit status and exact page/codec coverage, retains source SHA-256 hashes, and regenerates `oracle.json`. For trial 2, raw output can exceed a page, so capping changes the baseline total from the unbounded number in the earlier report.
