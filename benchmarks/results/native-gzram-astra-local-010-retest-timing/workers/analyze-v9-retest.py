import csv,json,pathlib,shutil,statistics,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');src=r/'build/astra-local-010-retest-timing';out=r/'build/astra-v9-retest-timing-analysis';out.mkdir();steps=[]
assert json.loads((src/'checkpoint.json').read_text())['status']=='complete'
dest=r/'benchmarks/results/native-gzram-astra-local-010-retest-timing'
def run(label,command):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:p=subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,timeout=900)
 steps.append(dict(label=label,command=command,status=p.returncode,seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==0,label
try:
 run('audit',['python3','gzram/tools/audit-native.py','--input',str(src),'--directory','build/astra-v9-isolated-aliases','--preflight','build/astra-local-010-retest-timing-preflight.json','--output',str(out/'audit.json')])
 run('summary',['python3','gzram/tools/summarize-native.py','--input',str(src),'--output',str(dest)])
 controls=['wordmixed','bitdirect','bitdirectbounded','bitdirectblock2avxbits4','bitdirectblock3avxbits4','bitdirectblock2avxbits4bounded','bitdirectblock3avxbits4bounded','bitdirectshared','bitdirectboundedshared','bitdirectblock2avxbits4boundedshared','bitdirectblock3avxbits4boundedshared']
 run('paired',['python3','gzram/tools/analyze-paired.py','--input',str(src),'--output',str(out/'paired'),'--controls',*controls])
 for name in ['paired.json','paired.md']:shutil.copy2(out/'paired'/name,dest/name)
 shutil.copy2(out/'audit.json',dest/'audit.json')
 for name in ['source-provenance.json']:shutil.copy2(r/'build/astra-v9/source-checkpoint'/name,dest/name)
 shutil.copy2(r/'build/astra-v9-isolated-aliases/benchmark-build.json',dest/'benchmark-build.json')
 for p in src.glob('*.stderr'):shutil.copy2(p,dest/p.name)
 for name in ['v9-retest-inhibitor.json','v9-retest-postflight.json','package-energy-access-20261029.json']:
  p=r/'build/astra-audit'/name
  if p.exists():shutil.copy2(p,dest/name)
 run('decoder-controls',['python3','build/astra-audit/analyze-v9-retest-decoder-controls.py'])
 rows={}
 for session in range(3):
  for row in csv.DictReader((src/f'session-{session}.csv').open()):rows[session,row['corpus'],row['variant'],row['operation'],int(row['round'])]=row
 corpora=sorted({k[1] for k in rows});contrasts=[]
 candidates=['ghy-bitdirectbounded-scalar-1024','ghy-bitdirectbounded-avx2-1024','ghy-bitdirectblock2avxbits4bounded-avx2-1024','ghy-bitdirectblock3avxbits4bounded-avx2-1024']
 for candidate in candidates:
  for control in [candidate.replace('bounded',''),'lz4-small-scalar']:
   for corpus in corpora:
    for operation in ['compress','decompress']:
     effects={}
     for metric in ['ns_per_page','cpu_ns_per_page','cycles','instructions','compressed_bytes','package_uj_per_page']:
      a=[float(rows[s,corpus,candidate,operation,i][metric]) for s in range(3) for i in range(9)]
      b=[float(rows[s,corpus,control,operation,i][metric]) for s in range(3) for i in range(9)]
      if min(a)<0 or min(b)<=0:effects[metric]=None;continue
      changes=[100*(statistics.median(a[s*9+i]/b[s*9+i] for i in range(9))-1) for s in range(3)]
      effects[metric]=dict(candidate_median=statistics.median(a),control_median=statistics.median(b),median_change_percent=statistics.median(changes),session_changes_percent=changes)
     contrasts.append(dict(candidate=candidate,control=control,corpus=corpus,operation=operation,effects=effects))
 (dest/'bounded-review.json').write_text(json.dumps(dict(scope='All bounded candidate/parent and private-LZ4 contrasts; interpretation pending',rows=contrasts),indent=2)+'\n')
 lines=['# Bounded-trial physical comparison','',
 'Three matched sessions, nine recorded rounds, 128 pages per corpus and 8192 calls per batch. All 26 corpora and both operations are retained. Absolute values are pooled medians; changes are medians of three session medians of paired ratios. Session ranges are descriptive, not confidence intervals. These are time changes, not throughput changes.', '',
 'Frozen source: 75caaebc71d29b440add033947eb98cd34581d72. Exact N100/kernel/compiler/settings and telemetry are in metadata.json and audit.json. Fresh controls are used; no direct comparison with earlier AC/frequency cohorts. Desktop activity was not stopped and preempted observations are retained. Thread CPU time and user-only cycles are separate from wall time. Package energy was unavailable at launch; whole-experiment battery readings cannot establish per-codec energy savings.', '',
 'Userspace codec results exclude kernel SIMD state management, allocation, reclaim, queue residence, responsiveness and native pressure. The unchanged decoder algorithm requires attention to the shared-entry and exact-entry negative controls in decoder-controls.json. No candidate is promoted automatically. All variants preserve independent pages and the existing format; correctness evidence is in ../gzram-astra-v9-validation-002/.', '']
 for candidate in candidates:
  for control in [candidate.replace('bounded',''),'lz4-small-scalar']:
   lines += [f'## {candidate} versus {control}','', '| Corpus | Operation | Control ns | Candidate ns | Time change % (session range) | CPU change % | Cycle change % | Control → candidate bytes |','|---|---|---:|---:|---:|---:|---:|---:|']
   for row in contrasts:
    if row['candidate']!=candidate or row['control']!=control:continue
    e=row['effects'];t=e['ns_per_page'];u=e['cpu_ns_per_page'];c=e['cycles'];b=e['compressed_bytes'];ss=t['session_changes_percent']
    def pct(x):return 'unavailable' if x is None else f"{x['median_change_percent']:+.2f}"
    lines.append(f"| {row['corpus']} | {row['operation']} | {t['control_median']:.1f} | {t['candidate_median']:.1f} | {pct(t)} ({min(ss):+.2f}..{max(ss):+.2f}) | {pct(u)} | {pct(c)} | {b['control_median']:.3f} → {b['candidate_median']:.3f} |")
   lines.append('')
 lines += ['## Decision pending','', 'This generated report preserves every direct contrast. Review the audit, decoder identity controls, cross-session signs, rejected-work cases and sparse/repeat regressions before selecting a next candidate. No overall speed, energy or ZRAM improvement is inferred automatically.']
 (dest/'findings.md').write_text('\n'.join(lines)+'\n')
 workers=dest/'workers';workers.mkdir()
 for name in ['freeze-v9.py','launch-v9-retest.py','analyze-v9-retest.py','analyze-v9-retest-decoder-controls.py','watch-v9-retest.py']:shutil.copy2(r/'build/astra-audit'/name,workers/name)
 (out/'result.json').write_text(json.dumps(dict(status='passed',scope='Raw results, audit and all direct contrasts saved; interpretation and commit pending'),indent=2)+'\n')
except BaseException as e:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e)),indent=2)+'\n');raise
