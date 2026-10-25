# GHY1 experimental whole-page hybrid

This userspace-only container preserves the original fast GZR1 codec and the
matched private 4 KiB-table scalar LZ4 backend. No kernel driver is replaced.
It is a separate format; GZR1/GZR2 libraries, tests and results stay available.

Eight-byte header: ASCII GHY1, uint16 little-endian decoded length (0..4096),
uint8 codec (0=raw, 1=nested GZR1, 2=LZ4 block), uint8 reserved=0. The remaining
bytes are exactly one payload. Raw length must equal decoded length; compressed
payloads must decode to exactly the outer length. Empty frames must be raw.
Unknown flags/tags, invalid lengths, truncated data and output-capacity failures
are rejected. The decoder accepts at most LZ4_COMPRESSBOUND(4096)+8 bytes.
Failure may modify a bounded output prefix; discard failed output. Buffers must
not overlap. LZ4 internal overlapping matches use the existing safe decoder.

Encoder worst-case output is input+8; no hot-path heap allocation. GZRAM writes
directly into the caller's payload region. A separate noinline LZ4 helper owns
its userspace stack workspace only when used; a future kernel port would need
per-stream workspace rather than this stack design. All codec branches and the
eight-byte outer framing are charged in performance/ratio measurements.

Policies are separate libraries, with identical decoding semantics:

* trial: try fast GZRAM; accept when its complete nested frame is at most 75%
  of source size, otherwise try scalar LZ4 and then raw storage.
* sample: sample up to 64 evenly spaced four-byte words. At least one-eighth
  zero samples selects the GZRAM trial; otherwise go directly to LZ4/raw.
* recurrence: adds a bounded repeated-nonzero-prefix check to sample selection,
  routing matching pages to LZ4. The bounded search covers candidate distances
  1..1024; a repeated 32-byte prefix routes common fixed repeats to GZRAM early.
  This is classification, not proof of repetition.

These are hypotheses, not established winners. Zero density alone can select
GZRAM poorly for a periodic prefix followed by zeros. Tests explicitly include
that case; the recurrence policy recovers it through LZ4. Fixed block size affects
only nested GZRAM, so identical LZ4 paths at different requested block sizes are
controls, not different algorithms. AVX2 labels refer to GZRAM leaves; LZ4 stays
scalar and libc may perform its own CPU dispatch. Kernel SIMD costs are excluded.

Build with gzram/tools/build.py. Hybrid correctness needs independent liblz4.so.1:

```
python3 gzram/tests/hybrid.py --library build/gzram/libgzram-hybrid-trial.so --other-libraries build/gzram/libgzram-hybrid-sample.so build/gzram/libgzram-hybrid-recurrence.so
python3 gzram/tests/hybrid.py --library build/gzram/libgzram-hybrid-sample.so
python3 gzram/tests/hybrid.py --library build/gzram/libgzram-hybrid-recurrence.so
```

Guarded capacities, malformed/mutated inputs, an independent wire oracle,
cross-policy decoding, four-thread round trips and ASan/UBSan passed locally.
This is correctness evidence, not N100 performance. The native --screen option
records 19 explicit variants at 1024/4096-byte GZRAM block sizes, including scalar
LZ4 and original/filtered/repeated-pattern controls. All eleven corpora, including 127/509-byte repeating prefixes with zero tails, and
all recorded rounds are retained. Full all-block testing remains available.
The benchmark reports its own variant/corpus lists into metadata; historic
exporters still preserve old datasets. No preferred policy is selected yet.
