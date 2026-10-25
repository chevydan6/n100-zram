# Ratio failure diagnosis and next experiment

The GZR1 source scans each independent block for zero, repeated 4/8/16/32-byte
patterns, and nonzero 32-bit word masks, then emits literals/raw framing.
There are no LZ offsets, variable-length matches or page dictionaries. A
period-127 page has none of the recognized periods and is not sparse enough
for masks: its result is the 4104-byte raw frame. Increasing match distance
alone cannot fix a format with no representation for the match. Eight bytes
of raw metadata are not the main failure. Independent blocks compound the cost
of storing an arbitrary repeat pattern separately in every block.

The preserved first GZR2 candidate adds an independent block-local dictionary
for periods 1..255. Three physical N100 sessions (native-gzram-period-001)
measure 138 bytes at a 4096-byte block versus 153 for LZ4 and 4104 for GZR1.
Encoding/decoding medians are 490.8/212.5 ns/page versus 758.8/238.3 for scalar
LZ4 on this particular corpus. At 1024-byte blocks the same candidate needs
528 bytes, showing repeated dictionary metadata and block independence matter.

The naive search also imposes substantial cost when it finds nothing useful.
At 1024-byte blocks, half-zero encoding rises from 340.2 to 686.0 ns/page and
sparse-word encoding from 1482.0 to 3119.3 ns/page. Ratios do not improve there.
Executable pages remain poor: about 4091 bytes versus about 3243 for LZ4.
This rejects the naive search as a preferred general encoder despite its
periodic-page result. All paths, cycles, instructions, energy and losses remain
in the complete dataset; these userspace results exclude kernel SIMD costs.

The next isolated candidate will search only blocks otherwise emitted as raw
literals. It will preserve zero/sparse/fixed-repeat paths and compare a scalar
prefix filter with explicit AVX2 byte equality/movemask candidate filtering.
Full bounded comparisons must prove each repeat; sampling never establishes
correctness. Both paths must select the same candidate and emit identical bytes.
Skipping sparse blocks can miss profitable repeats and must be measured as a
classification tradeoff, not described as universally better.

This remains a block-local repeated-pattern mode, not arbitrary LZ matching.
Further candidates should compare a simple literal/distance/length representation
with a versioned whole-page LZ4 fallback. Each needs independent bounds/overlap
and malformed-input tests before measurement. No kernel integration is justified.
