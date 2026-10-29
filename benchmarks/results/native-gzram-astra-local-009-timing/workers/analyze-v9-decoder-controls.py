import csv,json,pathlib,statistics
root=pathlib.Path('/home/dan/n100-zram');source=root/'build/astra-local-009-timing'
assert json.loads((source/'checkpoint.json').read_text())['status']=='complete'
rows={};identities=[]
for session in range(3):
 log=(source/f'session-{session}.attempt-0.stderr').read_text().splitlines()
 entries={line.split()[1]:dict(x.split('=',1) for x in line.split()[2:]) for line in log if line.startswith('Entry ')}
 sources={}
 for line in log:
  if line.startswith('Frames '):
   _,corpus,variant,bank=line.split();sources[corpus,variant]=bank
 for isa in ['scalar','avx2']:
  base=f'ghy-bitdirect-{isa}-1024';alias=f'ghy-bitdirectshared-{isa}-1024'
  assert entries[base]==entries[alias]
  for variant in entries:
   if f'shared-{isa}-' not in variant:continue
   assert entries[variant]['decoder']==entries[base]['decoder']
   for corpus in {c for c,v in sources}:assert sources[corpus,variant]==sources[corpus,base]
 identities.append(dict(session=session,entries=entries,common_entry_and_frame_sources_verified=True))
 for row in csv.DictReader((source/f'session-{session}.csv').open()):
  rows[session,row['corpus'],row['variant'],row['operation'],int(row['round'])]=row
variants=sorted({k[2] for k in rows});corpora=sorted({k[1] for k in rows});out=[]
for alias in variants:
 if 'shared-' not in alias:continue
 own=alias.replace('shared-','-');isa=alias.split('-')[2];common=f'ghy-bitdirectshared-{isa}-1024'
 for control,kind in [(own,'same encoder, own versus shared decoder entry'),(common,'exact common decoder and input address')]:
  if alias==control:continue
  for corpus in corpora:
   for op in ['compress','decompress']:
    effects={}
    for metric in ['ns_per_page','cpu_ns_per_page','cycles','instructions','compressed_bytes','package_uj_per_page']:
     values=[float(rows[s,corpus,alias,op,r][metric]) for s in range(3) for r in range(9)]
     controls=[float(rows[s,corpus,control,op,r][metric]) for s in range(3) for r in range(9)]
     if min(controls)<=0 or min(values)<0:effects[metric]=None;continue
     effects[metric]=dict(candidate_median=statistics.median(values),control_median=statistics.median(controls),session_changes_percent=[100*(statistics.median(values[s*9+r]/controls[s*9+r] for r in range(9))-1) for s in range(3)])
    out.append(dict(candidate=alias,control=control,kind=kind,corpus=corpus,operation=op,effects=effects))
dest=root/'benchmarks/results/native-gzram-astra-local-009-timing/decoder-controls.json'
with dest.open('x') as f:json.dump(dict(scope='Same-process entry and input-address controls. Differences between exact-entry decodes are measurement/setup effects, not an algorithm change; no specific microarchitectural cause isolated.',identities=identities,rows=out),f,indent=2);f.write('\n')
print(len(out),'decoder/encoder control contrasts')
