import csv,hashlib,json,pathlib,statistics,shutil
r=pathlib.Path('/home/dan/n100-zram');src=r/'build/astra-exec-timing-001';b=r/'build/astra-exec-timing-binaries';out=r/'benchmarks/results/native-gzram-exec-timing-001';out.mkdir()
s=json.loads((src/'checkpoint.json').read_text());assert s['status']=='complete' and set(s['completed'])=={'validation','session-0','session-1','session-2'};i=s['inputs'];sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();assert sha(b/'benchmark')==i['binary_sha256']
for n,h in i['libraries'].items():assert sha(b/n)==h==i['manifest']['artifacts'][n]
rows={}
for session in range(3):
 data=list(csv.DictReader((src/f'session-{session}.csv').open()));expected={(c,v,o,k) for c in i['corpora'] for v in i['variant_names'] for o in ['compress','decompress'] for k in range(9)}
 assert len(data)==len(expected) and {(x['corpus'],x['variant'],x['operation'],int(x['round'])) for x in data}==expected
 for x in data:rows[session,x['corpus'],x['variant'],x['operation'],int(x['round'])]=x
samples=[json.loads(x) for x in (src/'telemetry.jsonl').read_text().splitlines()];gaps=[b['time']-a['time'] for a,b in zip(samples,samples[1:])];assert min(gaps)>0 and max(gaps)<10 and samples[0]['time']-s['started']<10 and s['finished']-samples[-1]['time']<10
allrows=list(rows.values());audit=dict(status='passed with limitation',rows=len(allrows),max_telemetry_gap_seconds=max(gaps),elapsed_seconds=s['finished']-s['started'],pmu_fraction_range=[min(float(x['pmu_running_fraction']) for x in allrows),max(float(x['pmu_running_fraction']) for x in allrows)],thread_occupancy_min=min(float(x['cpu_utilization_percent']) for x in allrows),thread_occupancy_median=statistics.median(float(x['cpu_utilization_percent']) for x in allrows),package_energy_rows=sum(float(x['package_uj_per_page'])>=0 for x in allrows),preflight='Not captured at launch; before/after ZRAM and settings restoration cannot be verified by this audit',scope='Physical N100 userspace codec only')
(out/'audit.json').write_text(json.dumps(audit,indent=2)+'\n');controls=['lz4-small-scalar','ghy-bitdirectblock2avxbits4-avx2-1024'];candidate='ghy-bitdirectblock2avxbits4bounded-avx2-1024';result=[]
for c in i['corpora']:
 for op in ['compress','decompress']:
  for control in controls:
   metrics={}
   for m in ['ns_per_page','cpu_ns_per_page','cycles','compressed_bytes']:
    a=[float(rows[k,c,candidate,op,j][m]) for k in range(3) for j in range(9)];b0=[float(rows[k,c,control,op,j][m]) for k in range(3) for j in range(9)];changes=[100*(statistics.median(a[k*9+j]/b0[k*9+j] for j in range(9))-1) for k in range(3)];metrics[m]=dict(candidate=statistics.median(a),control=statistics.median(b0),change_percent=statistics.median(changes),sessions=changes)
   result.append(dict(corpus=c,operation=op,control=control,metrics=metrics))
(out/'comparisons.json').write_text(json.dumps(result,indent=2)+'\n')
for f in src.iterdir():
 if f.is_file():shutil.copy2(f,out/f.name)
shutil.copy2('/tmp/gzram-exec-audit.py',out/'audit.py')
print(json.dumps(audit,indent=2))
for x in result:
 m=x['metrics'];t=m['ns_per_page'];z=m['compressed_bytes'];print(x['corpus'],x['operation'],x['control'],round(t['control'],1),round(t['candidate'],1),round(t['change_percent'],2),round(z['control'],1),round(z['candidate'],1),[round(q,2) for q in t['sessions']])
