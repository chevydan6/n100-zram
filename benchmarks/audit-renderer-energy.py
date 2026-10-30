#!/usr/bin/env python3
"""Recompute aggregate results and check randomized task completeness without page data."""
import argparse,json,math,pathlib,statistics
p=argparse.ArgumentParser();p.add_argument('input',type=pathlib.Path);p.add_argument('--output',type=pathlib.Path,required=True);a=p.parse_args()
if a.output.exists():p.error('refusing to overwrite audit')
s=json.loads(a.input.read_text());assert s['status']=='passed';t=s['codec_timing'];rows=t['raw_observations'];pages=t['pages'];codecs=set(t['metrics']);ops={'compress','decompress'};assert len(codecs)==4 and pages>0 and len(rows)==pages*8
index={};orders={}
for row in rows:
 k=(row['page_index'],row['codec'],row['operation']);assert k not in index and 0<=k[0]<pages and k[1] in codecs and k[2] in ops
 assert row['encoded_bytes']>0 and all(math.isfinite(row[x]) and row[x]>=0 for x in ('wall_ns','cpu_ns','package_uj'))
 index[k]=row;orders.setdefault(k[0],set()).add(row['position'])
assert all(v==set(range(8)) for v in orders.values()) and len(orders)==pages
for name in codecs:
 for op in ops:
  data=[index[(i,name,op)] for i in range(pages)];metrics=t['metrics'][name][op]
  for field,key in [('wall_ns','wall_ns_median'),('cpu_ns','cpu_ns_median'),('package_uj','package_uj_per_page_median')]:assert math.isclose(statistics.median(x[field] for x in data),metrics[key],rel_tol=1e-12)
  assert sum(x['package_uj']==0 for x in data)==t['package_zero_reading_counts'][name][op]
 assert sum(index[(i,name,'compress')]['encoded_bytes'] for i in range(pages))==t['metrics'][name]['encoded_bytes_total']
 assert all(index[(i,name,'compress')]['encoded_bytes']==index[(i,name,'decompress')]['encoded_bytes'] for i in range(pages))
for op in ops:
 for field,key in [('wall_ns','wall'),('cpu_ns','cpu'),('package_uj','package_uj')]:
  left=[index[(i,'ghy-sample16-avx2',op)][field] for i in range(pages)];right=[index[(i,'ghy-combined-avx2',op)][field] for i in range(pages)];expected=None if field=='package_uj' and (any(x<=0 for x in left) or any(x<=0 for x in right)) else statistics.median(100*(x/y-1) for x,y in zip(left,right));actual=t['candidate_vs_parent_percent'][op][key];assert actual is None if expected is None else math.isclose(expected,actual,rel_tol=1e-12,abs_tol=1e-12)
for group,control in [('paired_percent','table12-scalar'),('vs_zstd_percent','zstd-userspace-level3')]:
 for name,operations in t[group].items():
  for op in ops:
   for field,key in [('wall_ns','wall'),('cpu_ns','cpu'),('package_uj','package_uj')]:
    left=[index[(i,name,op)][field] for i in range(pages)];right=[index[(i,control,op)][field] for i in range(pages)]
    expected=None if field=='package_uj' and (any(x<=0 for x in left) or any(x<=0 for x in right)) else statistics.median(100*(x/y-1) for x,y in zip(left,right));actual=operations[op][key]
    assert actual is None if expected is None else math.isclose(expected,actual,rel_tol=1e-12,abs_tol=1e-12)
orderset={tuple(next(x['codec']+':'+x['operation'] for x in rows if x['page_index']==i and x['position']==j) for j in range(8)) for i in range(pages)}
result={'status':'passed','pages':pages,'records':len(rows),'distinct_task_orders':len(orderset),'zero_package_readings':sum(x['package_uj']==0 for x in rows),'scope':'Validates retained aggregate arithmetic, frame-size accounting and operation permutations; cannot prove lack of background load, representativeness, randomness quality or package energy accuracy'};a.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
