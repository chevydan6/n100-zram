#!/usr/bin/env python3
"""Check and summarize the guest's sequential per-page ZRAM accounting trace."""
import csv, json, re, sys
from collections import Counter, defaultdict
from pathlib import Path

root=Path(sys.argv[1]); result=json.loads((root/'result.json').read_text())
assert result['status']=='passed', result['status']
text=re.sub(r'\[[ \t]*\d+\.\d+\][^\n]*(?:\n|$)', '', (root/'serial.log').read_text().replace('\r',''))
pat=re.compile(r'PAGE_ALLOC pass=(\d+) algorithm=([a-z0-9-]+) corpus=([A-Za-z0-9_-]+\.bin) page=(\d+) ((?:\d+\s+){8}\d+)')
roundtrip=re.compile(r'PAGE_ALLOC_ROUNDTRIP pass=(\d+) algorithm=([a-z0-9-]+) corpus=([A-Za-z0-9_-]+\.bin)')
records=defaultdict(dict); done=set()
for line in text.splitlines():
 m=pat.fullmatch(line); t=roundtrip.fullmatch(line)
 if m:
  key=m.group(1,2,3); page=int(m[4]); assert page not in records[key] and 0<=page<128
  v=[int(x) for x in m[5].split()]; assert v[0]==4096*(page+1)
  records[key][page]=v
 elif t:
  key=t.group(1,2,3); assert key not in done;done.add(key)
 elif line.startswith('PAGE_ALLOC'): raise ValueError('Malformed marker: '+line)
expected={(str(p),a,c) for p in (1,2) for a in result['algorithms'] for c in result['corpus_sha256']}
assert set(records)==done==expected
out=[]
for key,pages in sorted(records.items()):
 assert set(pages)==set(range(128))
 previous=[0]*9; lengths=[]; allocation_steps=[]
 for i in range(128):
  current=pages[i]; delta=current[1]-previous[1]; alloc=current[2]-previous[2]
  assert 0<=delta<=4096 and alloc>=0
  lengths.append(delta);allocation_steps.append(alloc);previous=current
 counts=Counter(lengths)
 out.append(dict(cycle=key[0],algorithm=key[1],corpus=key[2],total_compressed=previous[1],allocated=previous[2],distinct_lengths=len(counts),min_length=min(lengths),max_length=max(lengths),median_length=sorted(lengths)[64],allocation_events=sum(x>0 for x in allocation_steps),same_pages=previous[5],huge_pages=previous[7],length_histogram=json.dumps(dict(sorted(counts.items())),separators=(',',':'))))
with (Path(__file__).parent/'page-summary.csv').open('w',newline='') as f:
 writer=csv.DictWriter(f,fieldnames=out[0].keys());writer.writeheader();writer.writerows(out)
print('Validated',len(records),'traces and',sum(len(x) for x in records.values()),'page records')
for row in out:
 print(row['cycle'],row['algorithm'],row['corpus'],row['total_compressed'],row['allocated'],row['distinct_lengths'],row['allocation_events'])
