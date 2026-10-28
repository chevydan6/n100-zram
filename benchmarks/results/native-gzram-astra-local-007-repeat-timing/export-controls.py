import csv,json,statistics as st
from pathlib import Path
root=Path('/home/dan/n100-zram')
for cohort in ['native-gzram-astra-local-007-timing','native-gzram-astra-local-007-repeat-timing']:
 out=root/'benchmarks/results'/cohort
 assert json.loads((out/'audit.json').read_text())['status']=='passed'
 groups={}
 for s in range(3):
  for row in csv.DictReader((out/f'session-{s}.csv').open()):
   key=(row['corpus'],row['variant'],row['operation']);groups.setdefault(key,{})[(s,int(row['round']))]=row
 records=[]
 for (corpus,variant,operation),data in sorted(groups.items()):
  for control in ['lz4-small-scalar','ghy-bitdirect-scalar-1024']:
   if control==variant:continue
   base=groups[corpus,control,operation];assert data.keys()==base.keys() and len(data)==27
   effects={}
   for metric in ['ns_per_page','cpu_ns_per_page','compressed_bytes','cycles','instructions','branch_misses','cache_misses','package_uj_per_page']:
    if any(float(base[k][metric])<=0 or float(data[k][metric])<0 for k in data):effects[metric]=None;continue
    if metric in ['cycles','instructions','branch_misses','cache_misses'] and any(float(d[k]['pmu_running_fraction'])<.99 for d in [data,base] for k in data):effects[metric]=None;continue
    sessions=[100*(st.median(float(data[k][metric])/float(base[k][metric]) for k in data if k[0]==s)-1) for s in range(3)]
    effects[metric]=dict(control_median=st.median(float(x[metric]) for x in base.values()),candidate_median=st.median(float(x[metric]) for x in data.values()),median_change_percent=st.median(sessions),session_changes_percent=sessions)
   records.append(dict(corpus=corpus,candidate=variant,control=control,operation=operation,effects=effects))
 result=dict(scope='All direct LZ4 and best-scalar controls, three sessions per cohort. Absolute values are pooled medians; percentages are median of session paired-round effects, not ratios of pooled medians. Missing or invalid metrics remain null. No kernel, energy or default promotion claim.',rows=records)
 (out/'external-controls.json').write_text(json.dumps(result,indent=2)+'\n')
 lines=['# LZ4 and scalar controls','',result['scope'],'','| Corpus | Operation | Candidate | Control | ns/page control → candidate | Paired time change % (session range) | CPU time change % | Bytes change % |','|---|---|---|---|---:|---:|---:|---:|']
 for row in records:
  e=row['effects'];t=e['ns_per_page'];sessions=t['session_changes_percent']
  lines.append(f"| {row['corpus']} | {row['operation']} | {row['candidate']} | {row['control']} | {t['control_median']:.1f} → {t['candidate_median']:.1f} | {t['median_change_percent']:+.2f} ({min(sessions):+.2f}..{max(sessions):+.2f}) | {e['cpu_ns_per_page']['median_change_percent']:+.2f} | {e['compressed_bytes']['median_change_percent']:+.2f} |")
 (out/'external-controls.md').write_text('\n'.join(lines)+'\n')
 print(cohort,len(records))
