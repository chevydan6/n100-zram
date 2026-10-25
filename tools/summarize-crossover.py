#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Retain every size-sweep batch and report workload-specific candidate winners."""
import argparse,csv,json,random,shutil,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
s=json.loads((a.input/'checkpoint.json').read_text());assert s['status']=='complete' and len(s['completed'])==3
assert not a.output.exists();a.output.mkdir(parents=True);rows=[]
for session in s['completed']:
 path=a.input/(session+'.csv');data=list(csv.DictReader(path.open()));assert len(data)==len(s.get("sizes",[16,32,64,128,256,512,1024,2048,4096]))*162
 assert len({(r['bytes'],r['corpus'],r['round'],r['variant'],r['operation']) for r in data})==len(s.get('sizes',[16,32,64,128,256,512,1024,2048,4096]))*162
 for r in data:r['session']=session;rows.append(r)
 shutil.copy2(path,a.output/path.name)
metadata={k:s[k] for k in ['scope','kernel','binary_sha256','libraries','compiler','completed']}
for name in ['before','after']:metadata[name]={k:v for k,v in s[name].items() if k!='time'}
metadata['sizes']=s.get('sizes',[16,32,64,128,256,512,1024,2048,4096])
metadata['pmu_all_batches_fully_scheduled']=all(float(r['pmu_running_fraction'])>=.99 for r in rows)
(a.output/'metadata.json').write_text(json.dumps(metadata,indent=2)+'\n');shutil.copy2(a.input/'validation.log',a.output/'validation.log')
samples=[json.loads(line) for line in (a.input/'telemetry.jsonl').read_text().splitlines()]
if samples:
 start=samples[0]['time']
 for r in samples:r['elapsed_seconds']=round(r.pop('time')-start,3)
(a.output/'telemetry.jsonl').write_text(''.join(json.dumps(r)+'\n' for r in samples))
lines=['# Native N100 scalar/SSE2/AVX2 whole-codec size sweep','',s['scope']+'.',
'Three consecutive sessions, nine shuffled recorded rounds and two warm-ups; 128 independent blocks/corpus, 8,192 calls/batch.',
'All variants use a 4 KiB hash array. Linux page size is unchanged. Byte identity and cross-decoding passed.',
'Every recorded batch, user-only cycles/instructions/branch/cache counters and scheduling fractions are retained.',
'CPU 0; no energy counter or kernel FPU entry/exit measurement is included.',
'Costs include codec calls, loop/checks and timer bookkeeping. Cache conditions are synthetic.',
'Compression and decompression are analyzed separately; these are not component-operation thresholds.',
'',
'A candidate winner must beat both other paths by at least 2% in every session, using',
'median ratios paired by round. Otherwise the row says unresolved. This is a screening',
'rule, not a population confidence claim. Isolated wins and nonmonotonic changes must',
'not be turned into a universal threshold. Scalar improvements require remeasurement.',
'',
'| Bytes | Corpus | Operation | Scalar / SSE2 / AVX2 ns | Candidate winner |',
'|---:|---|---|---:|---|'];winners=[]
for size in sorted({int(r['bytes']) for r in rows}):
 for corpus in ['random','moderate','periodic']:
  for op in ['compress','decompress']:
   g=[r for r in rows if int(r['bytes'])==size and r['corpus']==corpus and r['operation']==op]
   lookup={(r['session'],r['round'],r['variant']):float(r['ns_per_op']) for r in g}
   median={v:statistics.median(float(r['ns_per_op']) for r in g if r['variant']==v) for v in ['scalar','sse','avx2']}
   best=min(median,key=median.get)
   good=all(statistics.median(lookup[(session,str(round),best)]/lookup[(session,str(round),other)] for round in range(9))<.98 for session in s['completed'] for other in median if other!=best)
   winner=best if good else 'unresolved'
   winners.append({'bytes':size,'corpus':corpus,'operation':op,'winner':winner,'medians_ns':median})
   lines.append(f"| {size} | {corpus} | {op} | {median['scalar']:.2f} / {median['sse']:.2f} / {median['avx2']:.2f} | {winner} |")
refine=set()
for corpus in ['random','moderate','periodic']:
 for op in ['compress','decompress']:
  g=[r for r in winners if r['corpus']==corpus and r['operation']==op]
  for before,after in zip(g,g[1:]):
   if before['winner']!=after['winner']:
    step=max(8,(after['bytes']-before['bytes'])//4)
    refine.update(range(before['bytes']+step,after['bytes'],step))
(a.output/'analysis.json').write_text(json.dumps({'screening_winners':winners,'suggested_refinement_sizes':sorted(refine),'kernel_policy_selected':False},indent=2)+'\n')
(a.output/'summary.md').write_text('\n'.join(lines)+'\n');print('Suggested refinement sizes:',sorted(refine));print(a.output/'summary.md')
