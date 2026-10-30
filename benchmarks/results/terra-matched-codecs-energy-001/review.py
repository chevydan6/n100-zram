import csv,fcntl,json,pathlib,shutil,statistics,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');src=r/'build/terra-matched-codecs-energy-001';status=r/'build/astra-audit/terra-matched-codecs-review-001.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 save('waiting for physical userspace cohort');deadline=time.monotonic()+4200
 while True:
  p=src/'checkpoint.json'
  if p.exists():
   state=json.loads(p.read_text())
   if state['status']=='complete':break
   if state['status']=='failed':raise RuntimeError('Benchmark failed; retain raw evidence')
  unit=subprocess.check_output(['systemctl','--user','show','n100-terra-matched-codecs-energy-001.service','-p','ActiveState','--value'],text=True).strip()
  if unit in ['failed','inactive'] and not p.exists():raise RuntimeError('Launcher ended without checkpoint; inspect authentication')
  if time.monotonic()>deadline:raise TimeoutError('Benchmark still pending')
  time.sleep(5)
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);save('auditing completed cohort')
  analysis=r/'build/terra-matched-codecs-analysis-001';analysis.mkdir()
  command=['python3','gzram/tools/audit-native.py','--input',str(src),'--directory','build/terra-matched-codecs-001','--preflight','build/terra-matched-codecs-energy-001-preflight.json','--output',str(analysis/'audit.json')]
  with (analysis/'audit.log').open('w') as log:subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=600)
  audit=json.loads((analysis/'audit.json').read_text());assert audit['status']=='passed'
  rows={}
  for session in range(3):
   for x in csv.DictReader((src/f'session-{session}.csv').open()):rows[session,x['corpus'],x['variant'],x['operation'],int(x['round'])]=x
   log=(src/f'session-{session}.attempt-0.stderr').read_text().splitlines();tasks=[x.split() for x in log if x.startswith('Task ')]
   assert len(tasks)==7*9*12
   for corpus in state['inputs']['corpora']:
    for n in range(9):assert {int(x[3]) for x in tasks if x[1]==corpus and int(x[2])==n}==set(range(12))
  metrics=['ns_per_page','cpu_ns_per_page','cycles','instructions','compressed_bytes','package_uj_per_page'];comparisons=[]
  for corpus in sorted({k[1] for k in rows}):
   for op in ['compress','decompress']:
    for candidate in ['ghy-combined-scalar','ghy-combined-avx2']:
     for control in ['table14-scalar','table13-scalar','table12-scalar','table11-scalar']:
      effect={}
      for m in metrics:
       a=[float(rows[s,corpus,candidate,op,j][m]) for s in range(3) for j in range(9)];b=[float(rows[s,corpus,control,op,j][m]) for s in range(3) for j in range(9)]
       if min(a)<0 or min(b)<=0:effect[m]=None;continue
       changes=[100*(statistics.median(a[s*9+j]/b[s*9+j] for j in range(9))-1) for s in range(3)]
       effect[m]=dict(control_median=statistics.median(b),candidate_median=statistics.median(a),median_change_percent=statistics.median(changes),session_changes_percent=changes)
      comparisons.append(dict(corpus=corpus,operation=op,candidate=candidate,control=control,metrics=effect))
  out=r/'benchmarks/results/terra-matched-codecs-energy-001';out.mkdir()
  for p in src.iterdir():
   if p.is_file():shutil.copy2(p,out/p.name)
  for path,name in [(analysis/'audit.json','audit.json'),(analysis/'audit.log','audit.log'),(r/'build/terra-matched-codecs-energy-001-preflight.json','preflight.json'),(r/'build/terra-matched-codecs-001/manifest.json','build-manifest.json'),(r/'build/astra-audit/terra-matched-codecs-review-001.py','review.py')]:shutil.copy2(path,out/name)
  (out/'paired.json').write_text(json.dumps(comparisons,indent=2)+'\n')
  lines=['# Matched GZRAM and scalar LZ4: physical N100 userspace cohort','', 'The same-run comparison randomizes compression and decompression tasks across scalar and AVX2 bounded GHY1 and four scalar LZ4 table sizes. Each of three sessions has nine rounds, 128 independently recoverable pages per corpus and 8,192 calls per batch. This is userspace screening; no native ZRAM, kernel FPU cost, application responsiveness or real-world acceptance result. GHY1 framing is included while direct LZ4 has no GHY1 container. Allocator-rounded ZRAM usage is not derived from bytes.','', 'Absolute values are pooled medians; percentages are medians of the three session median paired-round ratios, and do not necessarily equal the ratios of pooled medians. Negative time changes mean less time, not the same percentage increase in throughput. Session ranges are descriptive, not confidence intervals. Package energy, when available, includes background package activity and harness bookkeeping; it is not whole-laptop energy or battery life. See audit.json for telemetry, occupancy, PMU and restoration evidence.','', '| Corpus | Operation | GHY candidate | LZ4 control | Control → GHY ns/page | Paired time change | Control → GHY µJ/page | Paired energy change | Control → GHY bytes/page |','|---|---|---|---|---:|---:|---:|---:|---:|']
  for z in comparisons:
   if z['control'] not in ['table14-scalar','table12-scalar']:continue
   m=z['metrics'];t=m['ns_per_page'];e=m['package_uj_per_page'];b=m['compressed_bytes'];energy='unavailable' if e is None else f"{e['control_median']:.2f} → {e['candidate_median']:.2f}";ep='unavailable' if e is None else f"{e['median_change_percent']:+.2f}%"
   lines.append(f"| {z['corpus']} | {z['operation']} | {z['candidate']} | {z['control']} | {t['control_median']:.1f} → {t['candidate_median']:.1f} | {t['median_change_percent']:+.2f}% | {energy} | {ep} | {b['control_median']:.2f} → {b['candidate_median']:.2f} |")
  lines+=['','All controls, decompression, CPU time, cycles, instructions and session changes are retained in paired.json and raw CSVs. The LZ4 variants use one decoder entry; scalar and AVX2 GHY use distinct entries, so small decode differences may reflect code layout and setup. The executable fixtures are distributed file-backed pages, not an observed reclaim distribution. No overall improvement is claimed.']
  (out/'findings.md').write_text('\n'.join(lines)+'\n')
 save('complete; interpretation and commit pending',output=str(out))
except BaseException as e:save('failed; preserve artifacts',error=repr(e));raise
