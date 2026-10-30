#!/usr/bin/env python3
"""Optimistic lower bound on logical bytes for per-page selection; no new measurements."""
import hashlib,json
from pathlib import Path
r=Path(__file__).resolve().parents[3]; source=r/'benchmarks/results/terra-renderer-energy-audited-001'
codecs=['table12-scalar','ghy-combined-avx2','zstd-userspace-level3']; out=[]; hashes={}
for i in (1,2,3):
 p=source/f'trial-{i:03}.json'; audit=source/f'audit-full-{i:03}.json'
 for f in (p,audit):hashes[str(f.relative_to(r))]=hashlib.sha256(f.read_bytes()).hexdigest()
 trial=json.loads(p.read_text()); audited=json.loads(audit.read_text()); assert trial['status']=='passed' and audited['status']=='passed'
 timing=trial['codec_timing']; pages=timing['pages']; data={}; seen=set()
 for row in timing['raw_observations']:
  if row['operation']!='compress' or row['codec'] not in codecs: continue
  key=(row['page_index'],row['codec']); assert key not in seen;seen.add(key)
  assert isinstance(row['encoded_bytes'],int) and row['encoded_bytes']>0
  data[key]=min(4096,row['encoded_bytes'])
 assert seen=={(page,codec) for page in range(pages) for codec in codecs}
 for base in ('table12-scalar','zstd-userspace-level3'):
  g=[data[(n,'ghy-combined-avx2')] for n in range(pages)];b=[data[(n,base)] for n in range(pages)]
  total=sum(b); ideal=sum(min(x,y) for x,y in zip(g,b))
  out.append(dict(trial=i,pages=pages,baseline=base,baseline_capped_bytes=total,ghy_capped_bytes=sum(g),ideal_capped_bytes=ideal,ideal_saved_bytes=total-ideal,ideal_saving_pct=100*(total-ideal)/total,ghy_smaller=sum(x<y for x,y in zip(g,b)),baseline_smaller=sum(x>y for x,y in zip(g,b)),tie=sum(x==y for x,y in zip(g,b))))
result=dict(scope='Hypothetical zero-cost perfect selection using observed userspace logical sizes, 4096-byte cap; excludes allocation, hybrid tags, selection cost and any unmeasured algorithms',inputs_sha256=hashes,comparisons=out)
print(json.dumps(result,indent=2))
