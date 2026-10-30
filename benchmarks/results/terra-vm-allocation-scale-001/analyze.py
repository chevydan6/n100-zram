#!/usr/bin/env python3
"""Validate guest ZRAM scaling records and produce accounting summaries."""
import csv,json,re,sys
from pathlib import Path
root=Path(sys.argv[1]); result=json.loads((root/'result.json').read_text()); assert result['status']=='passed'
text=re.sub(r'\[[ \t]*\d+\.\d+\][^\n]*(?:\n|$)','',(root/'serial.log').read_text().replace('\r',''))
pattern=re.compile(r'ZRAM_SCALE pass=(\d+) algorithm=([a-z0-9-]+) corpus=([A-Za-z0-9_-]+\.bin) copies=(\d+) ((?:\d+\s+){8}\d+)')
records={}
for line in text.splitlines():
 m=pattern.fullmatch(line)
 if m:
  cycle,alg,corpus,copies=m.group(1,2,3,4); copies=int(copies); key=(cycle,alg,corpus,copies)
  assert key not in records
  v=[int(x) for x in m[5].split()]; assert v[0]==copies*128*4096
  records[key]=v
 elif line.startswith('ZRAM_SCALE'): raise ValueError('Malformed record: '+line)
expected={(str(c),a,b,n) for c in (1,2) for a in result['algorithms'] for b in result['corpus_sha256'] for n in range(1,9)}
assert set(records)==expected
out=[]
for key,v in sorted(records.items()):
 cycle,alg,corpus,n=key; one=records[(cycle,alg,corpus,1)]
 assert v[1]==one[1]*n and v[5]==one[5]*n and v[7]==one[7]*n
 if n>1: assert v[2]>=records[(cycle,alg,corpus,n-1)][2]
 out.append(dict(cycle=cycle,algorithm=alg,corpus=corpus,copies=n,original=v[0],compressed=v[1],allocated=v[2],same_pages=v[5],huge_pages=v[7]))
with (Path(__file__).parent/'scaling.csv').open('w',newline='') as f:
 w=csv.DictWriter(f,fieldnames=out[0]);w.writeheader();w.writerows(out)
print('Validated',len(records),'scaling records.')
for x in out:
 if x['cycle']=='1' and x['copies'] in (1,8): print(x)
