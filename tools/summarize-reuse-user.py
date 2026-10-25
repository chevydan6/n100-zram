#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Export complete native user-space screening, without private host logs."""
import argparse,csv,json,random,shutil,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
state=json.loads((a.input/'checkpoint.json').read_text());assert state['status']=='complete' and len(state['completed'])==3
assert not a.output.exists();a.output.mkdir(parents=True)
rows=[]
for session in state['completed']:
 path=a.input/(session+'.csv');data=list(csv.DictReader(path.open()));assert len(data)==2688
 assert len({(r['corpus'],r['round'],r['variant'],r['operation']) for r in data})==2688
 for r in data:r['session']=session;rows.append(r)
 shutil.copy2(path,a.output/path.name)
meta={key:state[key] for key in ['scope','kernel','binary_sha256','libraries','bash_sha256','completed']}
for name in ['before','after']:meta[name]={k:v for k,v in state[name].items() if k!='time'}
(a.output/'metadata.json').write_text(json.dumps(meta,indent=2)+'\n')
shutil.copy2(a.input/'validation.log',a.output/'validation.log')
samples=[json.loads(line) for line in (a.input/'telemetry.jsonl').read_text().splitlines()]
if samples:
 start=samples[0]['time']
 for sample in samples:sample['elapsed_seconds']=round(sample.pop('time')-start,3)
(a.output/'telemetry.jsonl').write_text(''.join(json.dumps(s)+'\n' for s in samples))
lines=['# Physical N100 initialized-workspace screening','',state['scope']+'.',
'Three sessions, 21 recorded rounds, 128 generated/sample pages per corpus; 8,192 calls per timed batch.',
'CPU 0, CPUID/XGETBV checked; all eight variants passed initial round trips.',
'Compression batches checked all packed pages byte-for-byte against baseline outside timing.',
'All raw rows, including regressions, are retained. No kernel or swap gain is established.',
'',
'Ratios compare scalar prototypes to reset4k-scalar and AVX2 prototypes to reset4k-avx2.',
'These fixed-page controls separate specialized API/code-generation changes from hash-table reuse.',
'Intervals bootstrap three session median paired round ratios (10,000 seeded draws).',
'Three sessions are descriptive repeatability evidence, not independent workload/population proof.',
'Virtual u16 positions retain the original workspace size; u32 positions add 16 KiB per stream.',
'No energy counter was recorded in this screening. Decompression is unchanged in these prototypes.',
'', '| Corpus | Variant | Compression ns/page | Change vs fixed-page control [95% session bootstrap] | Cycles/page |',
'|---|---|---:|---:|---:|']
rng=random.Random(100)
for corpus in sorted({r['corpus'] for r in rows}):
 for variant in ['scalar','reset4k-scalar','reuse-scalar','reuse32-scalar','avx2-guard','reset4k-avx2','reuse-avx2','reuse32-avx2']:
  group=[r for r in rows if r['corpus']==corpus and r['variant']==variant and r['operation']=='compress']
  control='reset4k-avx2' if 'avx2' in variant else 'reset4k-scalar'
  ratios=[]
  for session in state['completed']:
   b={r['round']:float(r['ns_per_page']) for r in rows if r['session']==session and r['corpus']==corpus and r['variant']==control and r['operation']=='compress'}
   ratios.append(statistics.median(float(r['ns_per_page'])/b[r['round']] for r in group if r['session']==session))
  boot=sorted(100*(statistics.median(rng.choices(ratios,k=3))-1) for _ in range(10000))
  lines.append(f"| {corpus} | {variant} | {statistics.median(float(r['ns_per_page']) for r in group):.1f} | {100*(statistics.median(ratios)-1):+.1f}% [{boot[250]:+.1f}, {boot[9749]:+.1f}] | {statistics.median(float(r['user_core_cycles_per_page']) for r in group):.1f} |")
(a.output/'summary.md').write_text('\n'.join(lines)+'\n')
print(a.output/'summary.md')
