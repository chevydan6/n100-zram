import csv,json,pathlib,statistics,shutil,hashlib
r=pathlib.Path('/home/dan/n100-zram');source=r/'build/lz4-scalar-random-energy-001';failed=r/'benchmarks/results/native-lz4-scalar-random-energy-001';failed.rename(r/'benchmarks/results/native-lz4-scalar-random-energy-001-summary-failed');out=r/'benchmarks/results/native-lz4-scalar-random-energy-001';out.mkdir()
for p in source.iterdir():
 if p.is_file():shutil.copy2(p,out/p.name)
shutil.copy2(r/'build/lz4-scalar-random-energy-analysis-001/audit.json',out/'audit.json');shutil.copy2(r/'build/lz4-scalar-random-energy-001-preflight.json',out/'preflight.json');shutil.copy2(r/'build/lz4-scalar-isolated-001/manifest.json',out/'build-manifest.json')
rows={}
for s in range(3):
 for x in csv.DictReader((source/f'session-{s}.csv').open()):rows[s,x['corpus'],x['variant'],x['operation'],int(x['round'])]=x
results=[]
for corpus in sorted({k[1] for k in rows}):
 for op in ['compress','decompress']:
  for candidate in ['table13-scalar','table12-scalar','table11-scalar']:
   met={}
   for metric in ['ns_per_page','cpu_ns_per_page','cycles','compressed_bytes','package_uj_per_page']:
    a=[float(rows[s,corpus,candidate,op,j][metric]) for s in range(3) for j in range(9)];b=[float(rows[s,corpus,'table14-scalar',op,j][metric]) for s in range(3) for j in range(9)];assert min(b)>0 and min(a)>=0
    v=[100*(statistics.median(a[s*9+j]/b[s*9+j] for j in range(9))-1) for s in range(3)];met[metric]=dict(control=statistics.median(b),candidate=statistics.median(a),change_percent=statistics.median(v),sessions=v)
   results.append(dict(corpus=corpus,operation=op,candidate=candidate,metrics=met))
(out/'paired.json').write_text(json.dumps(results,indent=2)+'\n')
for z in results:
 if z['candidate']=='table12-scalar' and z['operation']=='compress':
  a=z['metrics'];print(z['corpus'], 'time',round(a['ns_per_page']['change_percent'],2),'energy',round(a['package_uj_per_page']['change_percent'],2),'bytes',round(a['compressed_bytes']['control'],2),round(a['compressed_bytes']['candidate'],2),'energy_sessions',[round(x,2) for x in a['package_uj_per_page']['sessions']])
