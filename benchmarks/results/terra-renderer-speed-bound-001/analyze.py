#!/usr/bin/env python3
"""Optimistic fractional speed/size frontier from retained paired userspace data."""
import hashlib,json
from pathlib import Path

def bound(pairs, budget):
 # Grant the savings from every size-reducing choice for free even when it is
 # slower, then fractionally select the remaining speedups. Both relaxations
 # make this an upper bound, not an implementable page-selection policy.
 credit=sum(max(0,bsize-gsize) for bsize,gsize,bt,gt in pairs)
 available=budget+credit
 gain=sum(max(0,bt-gt) for bsize,gsize,bt,gt in pairs if gsize<=bsize)
 items=sorted(((bt-gt)/(gsize-bsize),bt-gt,gsize-bsize) for bsize,gsize,bt,gt in pairs if gt<bt and gsize>bsize)
 for _,saved,cost in reversed(items):
  fraction=min(1.0,available/cost);gain+=saved*fraction;available-=cost*fraction
 return gain

root=Path(__file__).resolve().parents[3]; source=root/'benchmarks/results/terra-renderer-energy-audited-001'; hashes={};results=[]
for n in (1,2,3):
 p=source/f'trial-{n:03}.json'; a=source/f'audit-full-{n:03}.json'
 for f in (p,a):hashes[str(f.relative_to(root))]=hashlib.sha256(f.read_bytes()).hexdigest()
 j=json.loads(p.read_text()); audit=json.loads(a.read_text()); assert j['status']==audit['status']=='passed'; timing=j['codec_timing']; pages=timing['pages'];rows={}
 for row in timing['raw_observations']:
  if row['operation']!='compress' or row['codec'] not in ('table12-scalar','ghy-combined-avx2'):continue
  key=(row['page_index'],row['codec']);assert key not in rows and row['wall_ns']>0 and row['encoded_bytes']>0;rows[key]=row
 assert set(rows)=={(i,c) for i in range(pages) for c in ('table12-scalar','ghy-combined-avx2')}
 pairs=[]
 for i in range(pages):
  b=rows[i,'table12-scalar'];g=rows[i,'ghy-combined-avx2'];pairs.append((min(b['encoded_bytes'],4096),min(g['encoded_bytes'],4096),b['wall_ns'],g['wall_ns']))
 total_bytes=sum(x[0] for x in pairs);total_time=sum(x[2] for x in pairs);independent=sum(min(x[2],x[3]) for x in pairs);selected_bytes=sum(g if gt<bt else b for b,g,bt,gt in pairs)
 results.append(dict(trial=n,pages=pages,baseline_bytes=total_bytes,baseline_wall_ns_sum=total_time,unconstrained_speed_bound_pct=100*(total_time-independent)/total_time,unconstrained_selected_bytes=selected_bytes,unconstrained_size_increase_pct=100*(selected_bytes/total_bytes-1),fractional_size_budget_bounds=[dict(allowed_extra_bytes_pct=pct,optimistic_wall_time_reduction_pct=100*bound(pairs,total_bytes*pct/100)/total_time) for pct in (0,1,5,10)]))
print(json.dumps(dict(scope='After-the-fact upper bounds on summed warm userspace wall times; 4096-byte logical size cap; no selector or tag costs; fractional and free-credit relaxation is not implementable',input_sha256=hashes,results=results),indent=2))
