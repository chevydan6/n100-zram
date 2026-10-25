#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Compare complete hybrid cohorts without merging codec and kernel-state costs."""
import argparse,csv,json,random,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert not a.output.exists();rows=[]
for session in range(3):
 f=a.input/f'session-{session}.csv';assert f.exists(),'Require all three completed sessions'
 for r in csv.DictReader(f.open()):r['session']=session;rows.append(r)
variants=sorted({r['variant'] for r in rows if r['variant'].startswith('ghy-')});corpora=sorted({r['corpus'] for r in rows});rng=random.Random(100)
def effect(selected,base,metric):
 lookup={(r['session'],r['round']):float(r[metric]) for r in base};per_session=[]
 assert len(selected)==len(base)==27
 for session in range(3):
  per_session.append(statistics.median(float(r[metric])/lookup[(session,r['round'])] for r in selected if r['session']==session))
 draws=sorted(100*(statistics.median(rng.choices(per_session,k=3))-1) for _ in range(10000))
 return {'change_percent':100*(statistics.median(per_session)-1),'interval_95_percent':[draws[250],draws[9749]],'session_change_percent':[100*(r-1) for r in per_session]}
lines=['# GHY1 screening contrasts','','Three sessions; nine paired recorded rounds per corpus/variant. Intervals bootstrap', 'three session median ratios (10,000 seeded draws). They are descriptive screening', 'intervals, not general workload confidence or kernel acceptance. No policy is selected.', 'Codec/dispatch/classification costs are included; kernel SIMD entry/exit is excluded.', 'Package energy covers the full batch plus bookkeeping/background work.', 'Absolute pooled medians are also reported; paired-ratio and pooled-median estimates can differ.', 'Mode counts describe the 128 input pages; all outcomes and losing cases are retained.', '', '| Corpus | Variant | Encoded bytes | Encode ns median | Raw / GZRAM / LZ4 pages | Encode change vs LZ4 [95%] | Decode change vs LZ4 [95%] | Encode change vs original GZRAM path [95% paired] | Pooled median change vs original |', '|---|---|---:|---:|---|---:|---:|---:|---:|'];analysis=[]
def fmt(e):return 'NA' if e is None else f"{e['change_percent']:+.1f}% [{e['interval_95_percent'][0]:+.1f}, {e['interval_95_percent'][1]:+.1f}]"
for corpus in corpora:
 for variant in variants:
  g=[r for r in rows if r['corpus']==corpus and r['variant']==variant];assert len(g)==54
  enc=[r for r in g if r['operation']=='compress'];dec=[r for r in g if r['operation']=='decompress'];modes={tuple(int(r[k]) for k in ['hybrid_raw_pages','hybrid_gzram_pages','hybrid_lz4_pages']) for r in enc};assert all(sum(m)==128 for m in modes)
  baseline=[r for r in rows if r['corpus']==corpus and r['variant']=='lz4-small-scalar']
  ec=effect(enc,[r for r in baseline if r['operation']=='compress'],'ns_per_page');dc=effect(dec,[r for r in baseline if r['operation']=='decompress'],'ns_per_page')
  size=variant.rsplit('-',1)[1];old=f'gz-avx2-{size}' if '-avx2-' in variant else f'gz-fast-scalar-{size}'
  oldrows=[r for r in rows if r['corpus']==corpus and r['variant']==old and r['operation']=='compress'];oc=effect(enc,oldrows,'ns_per_page') if oldrows else None
  energy=effect(enc,[r for r in baseline if r['operation']=='compress'],'package_uj_per_page') if all(float(r['package_uj_per_page'])>0 for r in enc+baseline) else None
  encoded=statistics.median(float(r['compressed_bytes']) for r in enc);ratio=encoded/statistics.median(float(r['compressed_bytes']) for r in baseline)
  enc_ns=statistics.median(float(r['ns_per_page']) for r in enc);dec_ns=statistics.median(float(r['ns_per_page']) for r in dec)
  original_ns=statistics.median(float(r['ns_per_page']) for r in oldrows) if oldrows else None
  pooled=100*(enc_ns/original_ns-1) if original_ns else None
  pooled_text='NA' if pooled is None else f'{pooled:+.1f}%'
  mode_text='; '.join('/'.join(map(str,m)) for m in sorted(modes))
  lines.append(f'| {corpus} | {variant} | {encoded:.1f} | {enc_ns:.1f} | {mode_text} | {fmt(ec)} | {fmt(dc)} | {fmt(oc)} | {pooled_text} |')
  analysis.append({'corpus':corpus,'variant':variant,'bytes_per_page':encoded,'encode_ns_median':enc_ns,'decode_ns_median':dec_ns,'original_gzram_encode_ns_median':original_ns,'pooled_encode_change_vs_original_gzram_percent':pooled,'bytes_ratio_vs_lz4':ratio,'mode_counts':sorted(modes),'encode_vs_lz4':ec,'decode_vs_lz4':dc,'encode_vs_matching_original_gzram':oc,'package_energy_encode_vs_lz4':energy})
a.output.mkdir(parents=True);(a.output/'analysis.json').write_text(json.dumps({'scope':'physical N100 userspace codec screening only','preferred_policy_selected':False,'rows':analysis},indent=2)+'\n');(a.output/'analysis.md').write_text('\n'.join(lines)+'\n')
print(a.output/'analysis.md')
