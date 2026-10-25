# Fused prefix scan and independent decoder dispatch

Both are isolated GHY1 policies; the existing GZR1/GZR2 and hybrid controls
remain available. The format and decoder compatibility rules do not change.

## Fused encoding hypothesis

The separate guarded classifier rereads up to 1 KiB after GZRAM encodes the page.
The fused policy records the same prefix-recurrence hint during the existing
AVX2 scan, using its already-loaded vectors. It retains the nonzero-byte anchor,
full eight-byte key comparison, bounded candidate range and exact final codec.
Hints travel through caller-owned stack state; there is no shared mutable state.
Candidates crossing a GZRAM block boundary are checked against the original
page. A final partial block uses bounded scalar checks. The hint never changes
GZR1 output bytes by itself; it only controls the hybrid's existing LZ4 fallback.

The fused internal API checks AVX2 availability. The outer hybrid uses the
unchanged scalar path if SIMD is unavailable. Normal base objects are linked
separately from the fused object, preserving the original fast path/control.
Local .text hashes for original fast GZRAM and guard32 controls match their
pre-fusion builds. Local assembly confirms byte comparison/movemask instructions
in the fused scan and no YMM stack spills in that inspected function.

This may add work on pages where the separate guard would skip searching.
Register pressure, branches and context fields can erase the saved loads.
Treat it as an experiment until actual N100 cycles, latency and energy are known.

## Independent decoder hypothesis

The guard32mixed policy keeps guard32 encoding and changes only nested GZR1
AVX2-entry decoding: sparse-word unpacking uses the scalar callback; recognized
fixed-repeat expansion uses AVX2. This uses the format's existing dispatch,
without an extra upfront classifier. Unsupported CPUs use scalar callbacks.
LZ4 payloads continue to use the preserved scalar safe LZ4 decoder.

The rationale comes from earlier N100 results where scalar sparse unpack beat
AVX2, while repeated-pattern expansion favored AVX2. This combination needs its
own measurement; component wins are not assumed to sum into a codec gain.
Kernel SIMD state handling is still excluded and would need separate integration.

Both candidates passed 14,656 normal guarded round trips, 29,264 capacity cases,
40,000 malformed/mutated decodes and 4,000 four-thread round trips, plus ASan/UBSan.
The cross-policy fused suite also passed 43,968 cross-decoder round trips and
120,000 mutated/malformed decode cases. Tests cover all anchor positions, odd
lengths, the final 1024-byte candidate and a partial block at that boundary.

The new native screen includes 40 variants and the same 12 corpora as the prior
guarded run. Full all-block testing provides 185 variants. Compiler definitions,
source/table hashes, selected variants/corpora and actual codec-mode counts are
recorded. No preferred policy or native kernel integration is selected.

## Scalar word-at-a-time classifier

The same cohort also adds wordguard, an integer-only prefix filter. It checks
eight candidate anchor bytes per 64-bit load using a zero-byte mask, then
verifies every candidate's complete eight-byte key. Borrow propagation can add
mask bits but cannot establish a match by itself. Remaining candidates use a
bounded scalar tail. This aims to reduce the costly byte-at-a-time scalar search
without paying kernel SIMD entry costs in a future scalar port.

wordguard uses this classifier with both scalar and AVX2 GZRAM encoding, so it
can be compared independently with the SSE/AVX2 prefix filters. Guarded-capacity,
all-anchor, partial-block, malformed-input, concurrency and ASan/UBSan tests pass.
Its encoded output is checked exactly against guard32 for every test input/log.
The native screen is therefore 40 variants, including matching 4096-byte fast-scalar control; full testing contains 185 variants.
No scalar speed improvement is assumed before physical N100 measurement.

## Bounded follow-up processing-length grid

After the screen completes, run-block-sweep.py can continue with the same
verified artifacts, runner, kernel and ELF corpus. It refuses incomplete or
changed predecessors. The grid includes original fast scalar/AVX2 GZRAM,
matched guard32, fused scanning, mixed decoding and wordguard at all eight
32..4096-byte internal block sizes, plus scalar LZ4 (81 variants). It records
all 12 corpora and all losses; it does not automatically select a preferred
codec. Kernel memory-page size remains unchanged.

The native runner accepts explicit --variants names and records the exact
selected list. Unknown/missing names fail before timing. A two-name selection,
the 40-variant screen and the 81-name grid were checked against the compiled
registry. Use the shared exclusive hardware lock through result collection and
publication for each finite stage. These jobs do not generate code after the
agent runtime ends.

## Dataset/order separation

The new harness resets dataset generation per corpus and uses a separate shuffle
RNG with session seeds 100/101/102. Raw corpus export is hashed with SHA256 into
native metadata. All twelve hashes were checked unchanged across different
selected codec lists and shuffle seeds. This keeps the 40-variant screen and
81-variant grid on identical input bytes. Older cohorts retain their original
harness/source and within-cohort controls; do not compare unmatched historical
absolute timings as if only the algorithm changed.
