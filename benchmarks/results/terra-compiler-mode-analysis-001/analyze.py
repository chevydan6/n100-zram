#!/usr/bin/env python3
"""Aggregate already published compiler sample counts; no extra page reads."""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[3]
sources=[root/f'benchmarks/results/terra-zero-prefix-guard-001/owned-sample-00{x}.json' for x in (5,6,7)]
keys=('pages','ghy_larger','ghy_smaller','equal','ghy_logical_bytes','lz4_logical_bytes')
results=[]
for path in sources:
 d=json.loads(path.read_text()); assert d['status']=='passed'
 r={'sample':path.stem,'seed':d['seed'],'classes':{}}
 for cls in ('anonymous_private','file_executable'):
  groups=[j['classes'][cls] for j in d['jobs']]
  r['classes'][cls]={'pages':sum(x['pages'] for x in groups),'same_word':sum(x['same_word'] for x in groups),'mode':{}}
  for mode in ('0','1','2'):
   values=[x.get('hybrid_mode_comparison',{}).get(mode,{}) for x in groups]
   r['classes'][cls]['mode'][mode]={k:sum(v.get(k,0) for v in values) for k in keys}
 results.append(r)
print(json.dumps({'scope':'Retrospective aggregate of already published small owned-compiler samples; no new measurements, no population or timing inference', 'samples':results},indent=2))
