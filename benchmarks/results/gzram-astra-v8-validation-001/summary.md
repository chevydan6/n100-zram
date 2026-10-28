# Eighth candidate correctness checkpoint

Six additive direct-packer/scanner compositions retain bitdirect's decoder and
compact repeats. This checkpoint establishes correctness and preservation, not
performance or native ZRAM acceptance.

- Normal and ASan/UBSan builds each pass 2,585,856 registry round trips
  (777 variants, 26 corpora, 128 pages).
- Each new policy in each build passes 64,384 cross-path round trips,
  64,336 guarded capacities, 72 cutoff cases, 390 pipeline fixtures,
  560 direct-repeat headers, 62 merge cases, 48,576 repeat boundaries,
  71,680 independent mask cases, 80,000 malformed/mutated cases and
  4,000 concurrent round trips.
- Direct scanner tests bypass hybrid selection: 2,866 inputs,
  275,136 vector encodes and 550,272 guarded capacities per build.
- All 45 old library text sections are unchanged. All 26 corpora and
  545,792 old size/mode records are unchanged; 79,872 new records match
  bitdirect. No format change.
- The isolated benchmark passes 24 checks spanning normal/sanitized own,
  shared and same-process alias modes. Smoke timings validate the protocol
  only. Exact common decoder addresses and frame sources are checked.

The upcoming physical cohort uses randomized operation order and identical
compressed inputs, including same-entry negative controls. It must establish
whether component gains combine and whether the earlier decoder anomaly
persists. Package energy is currently inaccessible; native SIMD state costs,
ZRAM allocator memory, responsiveness and battery life remain unmeasured.
