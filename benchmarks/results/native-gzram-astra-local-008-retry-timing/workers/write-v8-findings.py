import json,pathlib,statistics
root=pathlib.Path('/home/dan/n100-zram');dest=root/'benchmarks/results/native-gzram-astra-local-008-retry-timing'
review=json.loads((dest/'composition-review.json').read_text());audit=json.loads((dest/'audit.json').read_text())
rows={(r['corpus'],r['candidate']):r for r in review['compositions']}
corpora=sorted({c for c,p in rows})
def item(c,cut=2):return rows[c,f'bitdirectblock{cut}avxbits4']
def change(e,metric='ns_per_page'):return e[metric]['median_change_percent']
lines=['# Combined scanner/packer: eighth physical N100 cohort','',
'''The grouped scanner and direct block packer combine usefully, but their gains
are not uniformly additive. The cutoff-2 AVX-bitwise combination reduces
compression time versus matched bitdirect AVX2 by **18.12% on sparse words,
20.98% on clusters50, and 10.54%/11.19% on repeat16/32**, with identical bytes.
These are time reductions, not the numerically different throughput increases.
It retains the compact 33/49-byte repeat frames and bitdirect decoder.

Against the standalone direct packer, sparse-word compression is essentially
tied (−0.29%, mixed session signs); words50 improves 2.51% and clusters25/50
improve 5.70%/5.66% in all three sessions. Conversely, the deliberately aligned
sample16/64 sparse fixtures lose 2.80%/4.63% against that packer. Period127-zero-tail
also regresses 3.56% against bitdirect. Both cutoffs, all scalar/vector controls,
all corpora and all regressions remain in the raw results. Neither combination
is an overall ZRAM replacement or a selected normal configuration.

## Measurement and preservation

Frozen source commit: `d693248c442df110c5ffd2a091bc6e4e5d29f232`.
Intel N100 Lenovo 14e, four cores, approximately 4 GB RAM; Fedora kernel
7.2.11-200.fc44.x86_64; GCC 16.2.1. Exact compiler commands, definitions,
source/library hashes and corpus hashes accompany this report. Three fresh
processes use order seeds 100/101/102, nine recorded rounds and two warmups,
128 independently decodable pages per corpus, and 8,192 calls per batch.
23 entries × 26 corpora × 3 sessions × 9 rounds × 2 operations = 32,292 rows.
Codec CPU 0, telemetry CPU 1, nice 5, existing exclusive native lock.

This run was on battery throughout, powersave, 700–800 MHz policy limits;
CPU 0 samples were 799.789–800.842 MHz (median 800.000 MHz). These absolute
numbers must not be compared directly with the seventh AC/700–3400 MHz cohorts.
Fresh controls are used here. Elapsed time was 2,503.802 seconds, maximum telemetry
gap 0.860 seconds. Every PMU group ran fully. Median thread occupancy was 99.109%,
minimum 15.925%; interrupted/preempted batches are retained, not filtered out.
Thread occupancy is not whole-machine CPU usage.

The [earlier attempt](../native-gzram-astra-local-008-interrupted/summary.md)
was suspended for about 41 minutes and is excluded from performance acceptance.
This fresh attempt held a temporary idle/sleep inhibitor, released afterward.
The stock zstd ZRAM module identity, algorithm/disksize and CPU settings match
before/after. No experimental host module, swap or boot change was made.

Both direct RAPL and the system-wide package-energy PMU are permission-denied.
All package-energy rows are unavailable. Battery-gauge integration in audit.json
covers the entire multi-variant experiment and other laptop activity; it cannot
establish per-codec energy savings, package energy, or battery-life improvement.

This is warm-cache userspace codec screening. Kernel SIMD state management,
stream locking, allocation rounding, reclaim, application responsiveness and
native pressure stability remain unmeasured for these combinations. See the
[exact-kernel integration review](native-integration-notes.md).

## Whole-codec absolute times and paired changes

Absolute times are pooled medians in ns/page. Percentages are medians of the
three session median paired-round ratios, so they need not equal ratios of the
pooled medians. Session ranges and all CPU/PMU metrics remain in paired.json.
The own-entry decoder figures are retained observations; the unchanged decoder
algorithm and entry/layout effects discussed below prevent attributing their
small differences to a new decoding algorithm.

| Corpus | Bitdirect C ns | Cutoff 2 C ns (change) | Cutoff 3 C ns (change) | Bitdirect D ns | Cutoff 2 D ns (change) | Cutoff 3 D ns (change) | Bytes/page, all three |
|---|---:|---:|---:|---:|---:|---:|---:|''']
for c in corpora:
 a,b=item(c,2),item(c,3);ce=a['vs_bitdirect_compress'];de=a['vs_bitdirect_decompress']
 assert ce['compressed_bytes']['median_change_percent']==b['vs_bitdirect_compress']['compressed_bytes']['median_change_percent']==0
 def cell(row,key):
  t=row[key]['ns_per_page'];return f"{t['candidate_median']:.1f} ({t['median_change_percent']:+.2f}%)"
 lines.append(f"| {c} | {ce['ns_per_page']['control_median']:.1f} | {cell(a,'vs_bitdirect_compress')} | {cell(b,'vs_bitdirect_compress')} | {de['ns_per_page']['control_median']:.1f} | {cell(a,'vs_bitdirect_decompress')} | {cell(b,'vs_bitdirect_decompress')} | {ce['compressed_bytes']['candidate_median']:.3f} |")
lines += ['', '## Compression against individual components', '',
'''Negative percentages mean less compression time. `scanner` is bitdirectavxbits4;
`packer` is the matching standalone blockdirect2/3. The final column compares
cutoff 2's AVX-bitwise scanner with its matching grouped integer scanner.''','',
'| Corpus | Cutoff 2 vs scanner | Cutoff 2 vs packer | Cutoff 3 vs scanner | Cutoff 3 vs packer | Cutoff 2 vs integer scanner |',
'|---|---:|---:|---:|---:|---:|']
for c in corpora:
 a,b=item(c,2),item(c,3)
 values=[change(a['vs_scanner_compress']),change(a['vs_packer_compress']),change(b['vs_scanner_compress']),change(b['vs_packer_compress']),change(a['vs_integer_compress'])]
 lines.append('| '+c+' | '+' | '.join(f'{x:+.2f}%' for x in values)+' |')
lines += ['', '''The explicit AVX-bitwise choice contributes about 1.39%/1.38% on repeat16/32
against the matching integer grouping, not the full 10–11% benefit. CPU time
and cycles show about 1.48% reductions for those contrasts. The choice also
changes instruction encoding/layout; execution-port overlap is not isolated.
Saved relocatable-object disassembly confirms identical parent scanner/packer
sequences in the combinations (including recorded padding, before relocation),
and no vector-stack operands in the audited scanner bodies. This does not prove
runtime causality or final kernel code layout. See component-identity.json.''', '',
'## CPU time and cycles for the cutoff-2 combination', '',
'Both metrics are per page; cycles are user-only. These corroborate the main encoding effects without establishing energy savings.', '',
'| Corpus | Thread CPU ns: bitdirect → combined | Paired CPU change | Cycles: bitdirect → combined | Paired cycle change |',
'|---|---:|---:|---:|---:|']
for c in ['sparse-words','words25','words50','clusters25','clusters50','repeat16','repeat32','bash-elf','random','period127','period127-zero-tail','mixed-pages']:
 e=item(c)['vs_bitdirect_compress'];u,v=e['cpu_ns_per_page'],e['cycles']
 lines.append(f"| {c} | {u['control_median']:.1f} → {u['candidate_median']:.1f} | {u['median_change_percent']:+.2f}% | {v['control_median']:.1f} → {v['candidate_median']:.1f} | {v['median_change_percent']:+.2f}% |")
lines += ['', '## Decoder anomaly: identity controls', '',
'''The harness prepares immutable frames outside timing, verifies canonical byte
identity, restores equal streams from the same bank into the same addresses,
and shuffles all (variant, operation) tasks. Decode setup does not call the
candidate encoder immediately beforehand. Same-process aliases select exactly
one bitdirect decoder address per ISA; bitdirect's own aliases are exact-entry
negative controls for both encoder and decoder. All addresses/order logs are
retained and audited in decoder-controls.json.

With a common AVX2 decoder and identical inputs, pipe4 versus the baseline alias
changes repeat16 decode time by only **+0.23%** (sessions +0.23,+0.63,−0.06), and
repeat32 by **+0.38%** (+0.02,+2.13,+0.38). The cutoff-2 common alias changes them
+0.03% and +1.33%. The baseline's own exact-entry AVX2 alias changes repeat32 by
−2.11%, despite executing the same decoder on the same input addresses. Across
all corpora, its median absolute paired effect is 0.34%; the scalar negative
control is 0.31%, with a maximum of 2.03%.

Separate own-library entries still show process/session effects: for example,
pipe4's shared-vs-own repeat16 contrast ranges from −11.74% to +18.65% across
sessions, while its common-entry comparison is near zero. This rules out a new
decoder algorithm or changed compressed input as the explanation for the old
large anomaly. The exact layout/cache/predictor/history contribution remains
unisolated. Do not promote the own-entry repeat deltas, or small residual
same-entry differences, into algorithm improvements or regressions. Future
changes to the decoder itself need fresh common-input and identity controls.

## Matched private LZ4 comparison

The combination retains substantial sparse/repeat benefits, but rejected work
remains: cutoff 2 needs 49.63% more compression time on random data, 65.21% more
on period127, and 5.75% more on Bash ELF. Clusters50 decoding still needs 21.48%
more time. Conversely, its mixed-pages fixture takes 12.47% less compression
time and 21.76% less decoding time. That synthetic mixture is not a measured
application mix or an overall workload weighting.

| Corpus | LZ4 C → combined C ns | C paired change | LZ4 D → combined D ns | D paired change | LZ4 → combined bytes/page |
|---|---:|---:|---:|---:|---:|''']
lz={(r['corpus'],r['operation']):r['effects'] for r in review['lz4'] if r['candidate']=='ghy-bitdirectblock2avxbits4-avx2-1024'}
for c in corpora:
 ce,de=lz[c,'compress'],lz[c,'decompress'];a,b=ce['ns_per_page'],de['ns_per_page'];z=ce['compressed_bytes']
 lines.append(f"| {c} | {a['control_median']:.1f} → {a['candidate_median']:.1f} | {a['median_change_percent']:+.2f}% | {b['control_median']:.1f} → {b['candidate_median']:.1f} | {b['median_change_percent']:+.2f}% | {z['control_median']:.3f} → {z['candidate_median']:.3f} |")
lines += ['', '''Raw framing differences on incompressible pages do not imply ZRAM memory
savings: ZRAM can store the original page without invoking this decoder.
Zero/same-word pages can bypass compression. Even genuine compressed-byte
savings need allocator-rounded native measurement. The private LZ4 control is
not assumed identical to the current kernel's stock LZ4 workspace/backend.

## Correctness, decision and next experiment

All six new compositions passed normal and ASan/UBSan registry, independent
oracle/cross-decoding, guarded capacities, malformed/truncated input, repeat and
mask boundaries, alignment/scanner tests and four-thread concurrency checks.
All 45 old library text sections, 26 corpora and 545,792 old size/mode records
are unchanged; 79,872 new records match bitdirect. No GHY1/GZR1 format change.
See the [validation checkpoint](../gzram-astra-v8-validation-001/summary.md).

Keep both cutoffs as prototypes. Cutoff 2 has the stronger broad showing here,
including words25 and clusters25; cutoff 3 is not universally worse, and both
retain tradeoffs. The next three additive candidates bound tentative GZRAM
output by the existing acceptance threshold, to stop provably rejected work
without a new sampling heuristic. They must preserve byte identity even at
small output capacities. Then test a separate clustered-mask decoder path,
including partial-mask adversaries, and broader executable-load-segment fixtures.

An exact-kernel scalar ZRAM adapter has built, but device guest tests and native
recovery remain separate gates. No combined SIMD kernel, native pressure,
comparative package energy, application responsiveness or production-readiness
claim follows from this cohort. Stock zstd remains the normal configuration.
''']
(dest/'findings.md').write_text('\n'.join(lines).rstrip()+'\n')
print(dest/'findings.md')
