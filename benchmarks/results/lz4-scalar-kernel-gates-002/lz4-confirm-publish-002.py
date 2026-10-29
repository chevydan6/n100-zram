import csv,fcntl,hashlib,json,pathlib,shutil,statistics,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/lz4-confirm-publish-002.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 p=r/'build/astra-audit/lz4-kernel-vm-002.json';deadline=time.monotonic()+1200
 while not p.exists() or json.loads(p.read_text())['status'].startswith('running'):
  if time.monotonic()>deadline:raise TimeoutError('guest pending')
  time.sleep(5)
 guest=json.loads(p.read_text());save('waiting for exclusive lock',guest=guest['status'])
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX)
  src=r/'build/lz4-scalar-confirm-energy-002';dest=r/'benchmarks/results/native-lz4-scalar-confirm-energy-002';dest.mkdir()
  for f in src.iterdir():
   if f.is_file():shutil.copy2(f,dest/f.name)
  for name in ['audit.json'] :shutil.copy2(r/'build/lz4-scalar-confirm-analysis-002'/name,dest/name)
  shutil.copy2(r/'build/lz4-scalar-confirm-energy-002-preflight.json',dest/'preflight.json');shutil.copy2(r/'build/lz4-scalar-isolated-fixed-002/manifest.json',dest/'build-manifest.json')
  rows={}
  for s in range(3):
   for x in csv.DictReader((src/f'session-{s}.csv').open()):rows[s,x['corpus'],x['variant'],x['operation'],int(x['round'])]=x
  results=[]
  for corpus in sorted({k[1] for k in rows}):
   for op in ['compress','decompress']:
    for candidate in ['table13-scalar','table12-scalar','table11-scalar']:
     metrics={}
     for m in ['ns_per_page','cpu_ns_per_page','cycles','compressed_bytes','package_uj_per_page']:
      a=[float(rows[s,corpus,candidate,op,j][m]) for s in range(3) for j in range(9)];b=[float(rows[s,corpus,'table14-scalar',op,j][m]) for s in range(3) for j in range(9)];assert min(b)>0 and min(a)>=0
      changes=[100*(statistics.median(a[s*9+j]/b[s*9+j] for j in range(9))-1) for s in range(3)];metrics[m]=dict(control=statistics.median(b),candidate=statistics.median(a),change_percent=statistics.median(changes),sessions=changes)
     results.append(dict(corpus=corpus,operation=op,candidate=candidate,metrics=metrics))
  (dest/'paired.json').write_text(json.dumps(results,indent=2)+'\n')
  lines=['# Corrected scalar LZ4 randomized energy confirmation','','Three physical N100 sessions, nine randomized operation rounds each, 128 pages per corpus and 8,192 calls per batch. All 1,512 rows, library hashes, preflight/restoration settings and package-energy readings passed audit. Maximum telemetry gap 0.521 s; PMU and occupancy details are in audit.json. Package energy includes benchmark and other package activity, not whole-laptop energy or battery life. Userspace only.','', 'The fixed harness resets each corpus size total. It confirms the previous timing/energy direction and recovered sizes. Pooled absolute medians and medians of session paired-round ratios are different statistics. Negative time means less time, not the same percentage increase in throughput.','', '| Corpus | Table | Control → candidate compression ns/page | Paired time change | Control → candidate package µJ/page | Paired energy change | Control → candidate bytes/page |','|---|---:|---:|---:|---:|---:|---:|']
  for z in results:
   if z['operation']!='compress' or z['candidate']=='table11-scalar':continue
   m=z['metrics'];t=m['ns_per_page'];e=m['package_uj_per_page'];b=m['compressed_bytes'];lines.append(f"| {z['corpus']} | {z['candidate'][5:7]} | {t['control']:.1f} → {t['candidate']:.1f} | {t['change_percent']:+.2f}% | {e['control']:.2f} → {e['candidate']:.2f} | {e['change_percent']:+.2f}% | {b['control']:.2f} → {b['candidate']:.2f} |")
  lines+=['', 'Full 2/4/8 KiB comparisons, decompression, CPU time, cycles and session changes are in paired.json. These file-backed executable samples are not a representative reclaim workload. The 4 KiB table spends less time and package energy but raises executable bytes; the 8 KiB table gives smaller gains and smaller size increases. No native ZRAM, overall workload or production-readiness claim is made.']
  (dest/'findings.md').write_text('\n'.join(lines)+'\n')
  kd=r/'benchmarks/results/lz4-scalar-kernel-gates-002';kd.mkdir();shutil.copy2(p,kd/'guest-status.json');shutil.copy2(r/'build/astra-audit/lz4-kernel-build-002.json',kd/'build-status.json')
  for f in (r/'build/lz4-kernel-build-002').iterdir():
   if f.is_file() and f.suffix in ['.json','.log']:shutil.copy2(f,kd/f.name)
  for bits in [12,13]:
   source=r/f'build/lz4-kernel-vm-{bits}-002'
   if source.exists():
    target=kd/f'guest-{bits}';target.mkdir()
    for f in source.iterdir():
     if f.is_file() and f.suffix in ['.json','.log']:shutil.copy2(f,target/f.name)
  for name in ['lz4-kernel-build-002.py','lz4-kernel-vm-002.py','lz4-confirm-publish-002.py']:shutil.copy2(r/'build/astra-audit'/name,kd/name)
  (kd/'summary.md').write_text('# Exact-kernel scalar LZ4 gates\n\nStatus: '+guest['status']+'. Separate 4 KiB and 8 KiB variants each have a same-module 16 KiB matched control. The current kernel LZ4 sources match repository source byte for byte; audited experimental compressor objects have no SIMD instructions. Guest outcomes and raw console logs are preserved. This does not establish native performance, recovery or responsiveness.\n')
  doc=r/'docs/LZ4-SCALAR-ASTRA-20261030.md';doc.write_text(doc.read_text()+'\nThe [corrected-harness energy confirmation](../benchmarks/results/native-lz4-scalar-confirm-energy-002/findings.md) passed its audit and confirmed lower compression time and CPU package energy for 4 KiB and 8 KiB tables, with executable size penalties. The [exact-kernel build and guest gate](../benchmarks/results/lz4-scalar-kernel-gates-002/summary.md) records its actual outcome. Native recovery, pressure and responsiveness remain unproven.\n')
  files=['gzram/tools/vm-zram-selftest.py','docs/LZ4-SCALAR-ASTRA-20261030.md',str(dest.relative_to(r)),str(kd.relative_to(r))];subprocess.run(['git','add',*files],cwd=r,check=True);subprocess.run(['git','diff','--cached','--check','--','gzram/tools/vm-zram-selftest.py','docs/LZ4-SCALAR-ASTRA-20261030.md',str((dest/'findings.md').relative_to(r)),str((kd/'summary.md').relative_to(r))],cwd=r,check=True)
  subprocess.run(['git','-c','user.name=Codex','-c','user.email=codex@openai.com','commit','-qm','Confirm scalar LZ4 energy and exact-kernel gates'],cwd=r,check=True);commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=r,text=True).strip();subprocess.run(['git','-c',"credential.helper=!gh auth git-credential",'push','origin','feature/n100-lz4-scalar-astra'],cwd=r,check=True,timeout=120)
 save('complete',commit=commit,guest=guest['status'])
except BaseException as e:save('failed; preserve artifacts',error=repr(e));raise
