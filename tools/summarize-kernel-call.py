#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Export public syscall measurements; exclude private kernel logs and host IDs."""
import argparse,csv,json,statistics,random,shutil
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--label',default='AVX2-guard');p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert not a.output.exists(),'Preserve existing results';a.output.mkdir(parents=True)
checkpoint=json.loads((a.input/'checkpoint.json').read_text());assert checkpoint['status']=='complete'
rows=[]
for f in sorted(a.input.glob('session-*.csv')):
 data=list(csv.DictReader(f.open()));assert len(data)==648
 for row in data:row['session']=f.stem;rows.append(row)
 shutil.copy2(f,a.output/f.name)
assert len(rows)==1944
meta={k:checkpoint[k] for k in ['kernel','module_sha256','binary_sha256','before','after','completed']}
# Do not publish wall-clock timestamps or raw kernel messages.
for name in ['before','after']:meta[name].pop('time',None)
(a.output/'metadata.json').write_text(json.dumps(meta,indent=2)+'\n')
lines=['# Physical N100 syscall-inclusive codec experiment','',
f'Experimental: stock 7.0.10 versus the {a.label} probe. Each call processes one',
'4 KiB page, including syscall, dispatch and FPU state handling. Three sessions,',
'nine randomized recorded rounds per corpus/state/session; 4,096 calls per batch.',
'Warm-up rounds are excluded. Lower times are better. These are codec measurements,',
'not optimized ZRAM block-I/O or swap measurements. Stock and candidate compiler',
'builds differ; matched controls are needed before attributing all cost to FPU.',
'',
'Every state/operation batch checked all sixteen YMM sentinels. Corpus setup and',
'post-batch checks compared compressed bytes and both decoders against stock,',
'and checked retained input. Module initialization also passed 2,048 malformed',
'blocks and nested-FPU scalar fallback. The module/device unloaded afterward.',
'',
'Intervals below resample the three session median paired ratios (10,000 seeded',
'bootstrap draws), not individual calls. With only three sessions they are',
'descriptive repeatability checks, not a population or workload guarantee. Raw',
'CSV retains all recorded batches, including regressions. No confidence claim',
'is inferred from this small sample alone. Times are medians of all 27 batches.',
'',
'| Corpus | User state | Compress stock / candidate ns | Change [session bootstrap 95%] | Decode stock / candidate ns | Change [session bootstrap 95%] |',
'|---|---|---:|---:|---:|---:|']
rng=random.Random(100)
for corpus in sorted({r['corpus'] for r in rows}):
 for state in ['clean','sse-dirty','ymm-dirty']:
  group=[r for r in rows if r['corpus']==corpus and r['state']==state]
  times=[statistics.median(float(r['ns_per_page']) for r in group if int(r['operation'])==op) for op in range(4)]
  effects=[]
  for base in [0,2]:
   ratios=[]
   for session in checkpoint['completed']:
    paired=[]
    for round in range(9):
     pair={int(r['operation']):float(r['ns_per_page']) for r in group if r['session']==session and int(r['round'])==round}
     paired.append(pair[base+1]/pair[base]-1)
    ratios.append(statistics.median(paired)*100)
   boot=sorted(statistics.mean(rng.choices(ratios,k=len(ratios))) for _ in range(10000))
   effects.append(f'{statistics.mean(ratios):+.1f}% [{boot[249]:+.1f}, {boot[9749]:+.1f}]')
  lines.append(f'| {corpus} | {state} | {times[0]:.1f} / {times[1]:.1f} | {effects[0]} | {times[2]:.1f} / {times[3]:.1f} | {effects[1]} |')
lines+=['','This is an experimental diagnostic comparison, not a production-selection',
'claim. Primary lzo-rle ZRAM remained active and unchanged throughout this probe.']
(a.output/'summary.md').write_text('\n'.join(lines)+'\n')
print(a.output/'summary.md')
