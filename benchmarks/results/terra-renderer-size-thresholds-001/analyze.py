#!/usr/bin/env python3
"""Apply hypothetical raw cutoffs to retained encoded-length observations."""
import hashlib,json,pathlib
root=pathlib.Path(__file__).resolve().parents[3];base=root/'benchmarks/results/terra-renderer-energy-audited-001';out=[];inputs={}
for n in (1,2,3):
 p=base/f'trial-00{n}.json';data=p.read_bytes();inputs[p.name]=hashlib.sha256(data).hexdigest();s=json.loads(data);assert s['status']=='passed';t=s['codec_timing'];rows=[x for x in t['raw_observations'] if x['operation']=='compress'];assert len(rows)==t['pages']*4
 for cutoff in (2048,3072,4096):
  codecs={}
  for name in t['metrics']:
   rr=[x for x in rows if x['codec']==name];assert len(rr)==t['pages']
   total=sum(x['encoded_bytes'] if x['encoded_bytes']<cutoff else 4096 for x in rr);raw=sum(x['encoded_bytes']>=cutoff for x in rr)
   codecs[name]={'payload_bytes':total,'raw_pages':raw,'bytes_per_page':total/t['pages']}
  out.append(dict(trial=n,pages=t['pages'],hypothetical_cutoff_bytes=cutoff,codecs=codecs))
print(json.dumps(dict(status='passed',scope='Hypothetical payload sensitivity only; not ZRAM cutoff, allocator-rounded memory, swap, energy or representative workload',inputs_sha256=inputs,results=out),indent=2))
