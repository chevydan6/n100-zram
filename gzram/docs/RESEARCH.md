# Research references and provenance

No code or lookup tables from these projects were copied. GZRAM implementation
and mask-derived lookup-table generator are independently written, GPL-2.0-only.

- Intel ISA-L, commit 96be77353d6823fc394916652784d3cf85f73e39:
  https://github.com/intel/isa-l . BSD-3-Clause. Inspected compare macros and
  x86 compressor organization; its compare code also illustrates why scalar
  comparisons remain useful. ISA-L's DEFLATE machinery is not adopted here.
- Stream VByte, commit edc6105b24e150cd109ece75e6e37f54291635b0:
  https://github.com/fast-pack/streamvbyte . Apache-2.0. Its separate control/data
  streams and shuffle-based integer decode motivate investigating separate masks
  and word payloads. GZRAM is a different format, not Stream VByte compatibility.
- FastPFor, commit ae4e62db4de1ce6904e278f94afb56a87a36b32c:
  https://github.com/fast-pack/FastPFor . Apache-2.0. Inspected integer block
  packing organization; arbitrary page bytes are not necessarily narrow integers.
  No FastPFor bitpacking implementation is transplanted into this prototype.
- Current Aprender crates were checked via the GitHub API. The LZ4 compression
  SIMD entry still calls scalar; the inspected AVX2 decoder wrapper delegates
  to scalar with target-feature annotation. These are not measured N100 gains.
  https://github.com/paiml/aprender/tree/main/crates/aprender-zram-core/src/lz4
- Archived Trueno-ZRAM remains a historical research reference:
  https://github.com/paiml/trueno-zram ; https://paiml.github.io/trueno-zram/introduction.html
- Existing kernel LZ4 reference, attribution and GPL/BSD notices remain intact.
  https://github.com/torvalds/linux

Stream VByte and FastPFor's Apache-2.0 code is not a drop-in dependency for a
GPL-2.0-only kernel implementation. See the primary licensing guidance:
https://www.gnu.org/licenses/license-list.html#apache2 and
https://docs.kernel.org/process/license-rules.html . This research uses concepts,
not copied Apache-licensed implementation. Retain original licenses if separately
vendoring upstream benchmarks later; do not silently relicense source.

Claims about SIMD throughput, patents or kernel suitability in upstream projects
are not accepted as measurements of this codec or of the N100.
