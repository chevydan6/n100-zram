#!/usr/bin/env python3
"""Recompute paired medians and descriptive page-resampling intervals."""
import hashlib,json,pathlib,random,statistics
root=pathlib.Path(__file__).resolve().parents[3];rng=random.Random(470);results=[]
for trial in (1,2,3):
 path=root/f'benchmarks/results/terra-renderer-energy-audited-001/trial-00{trial}.json';d=json.loads(path.read_text());t=d['codec_timing'];rows=t['raw_observations'];idx={(x['page_index'],x['codec'],x['operation']):x for x in rows};n=t['pages']
 for candidate,control in [('ghy-combined-avx2','table12-scalar'),('ghy-sample16-avx2','ghy-combined-avx2'),('ghy-combined-avx2','zstd-userspace-level3')]:
  for op in ('compress','decompress'):
   for field in ('wall_ns','cpu_ns','package_uj'):
    vals=[100*(idx[i,candidate,op][field]/idx[i,control,op][field]-1) for i in range(n)];boot=sorted(statistics.median(vals[rng.randrange(n)] for _ in range(n)) for _ in range(2000));results.append(dict(trial=trial,candidate=candidate,control=control,operation=op,metric=field,median_percent=statistics.median(vals),page_bootstrap_95_percent=[boot[49],boot[1949]]))
print(json.dumps(dict(scope='Descriptive page-resampling intervals conditional on biased samples; not confidence intervals for real reclaim workloads',resamples=2000,seed=470,inputs={f'trial-00{i}.json':hashlib.sha256((root/f'benchmarks/results/terra-renderer-energy-audited-001/trial-00{i}.json').read_bytes()).hexdigest() for i in (1,2,3)},results=results),indent=2))
