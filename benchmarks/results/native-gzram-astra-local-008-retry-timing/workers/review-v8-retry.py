import csv,json,pathlib,statistics
root=pathlib.Path('/home/dan/n100-zram');dest=root/'benchmarks/results/native-gzram-astra-local-008-retry-timing';source=root/'build/astra-local-008-retry-timing'
assert json.loads((source/'checkpoint.json').read_text())['status']=='complete'
paired=json.loads((dest/'paired.json').read_text())['rows']
index={(r['corpus'],r['candidate'],r['control'],r['operation']):r['effects'] for r in paired}
corpora=sorted({r['corpus'] for r in paired})
def name(policy,isa='avx2'):return f'ghy-{policy}-{isa}-1024'
def effects(corpus,candidate,control,operation):return index[corpus,name(candidate),name(control),operation]
compact=[]
for cutoff in [2,3]:
 candidate=f'bitdirectblock{cutoff}avxbits4'
 for corpus in corpora:
  compact.append(dict(corpus=corpus,candidate=candidate,
   vs_bitdirect_compress=effects(corpus,candidate,'bitdirect','compress'),
   vs_bitdirect_decompress=effects(corpus,candidate,'bitdirect','decompress'),
   vs_scanner_compress=effects(corpus,candidate,'bitdirectavxbits4','compress'),
   vs_packer_compress=effects(corpus,candidate,f'blockdirect{cutoff}','compress'),
   vs_integer_compress=effects(corpus,candidate,f'bitdirectblock{cutoff}pipe4','compress')))
# Keep matched scalar-LZ4 comparisons explicit, without implying kernel LZ4 ABI.
rows={}
for session in range(3):
 for r in csv.DictReader((source/f'session-{session}.csv').open()):
  rows[session,r['corpus'],r['variant'],r['operation'],int(r['round'])]=r
lz4=[]
for cutoff in [2,3]:
 candidate=name(f'bitdirectblock{cutoff}avxbits4')
 for corpus in corpora:
  for operation in ['compress','decompress']:
   e={}
   for metric in ['ns_per_page','cpu_ns_per_page','cycles','instructions','compressed_bytes','package_uj_per_page']:
    a=[float(rows[s,corpus,candidate,operation,r][metric]) for s in range(3) for r in range(9)]
    b=[float(rows[s,corpus,'lz4-small-scalar',operation,r][metric]) for s in range(3) for r in range(9)]
    if min(b)<=0 or min(a)<0:e[metric]=None;continue
    changes=[100*(statistics.median(a[s*9+r]/b[s*9+r] for r in range(9))-1) for s in range(3)]
    e[metric]=dict(candidate_median=statistics.median(a),control_median=statistics.median(b),median_change_percent=statistics.median(changes),session_changes_percent=changes)
   lz4.append(dict(candidate=candidate,corpus=corpus,operation=operation,effects=e))
record=dict(scope='Review aid retaining both main compositions across all corpora, plus matched LZ4. No cross-cohort absolute comparisons or overall acceptance implied.',compositions=compact,lz4=lz4)
with (dest/'composition-review.json').open('x') as f:json.dump(record,f,indent=2);f.write('\n')
for cutoff in [2,3]:
 selected=[r for r in compact if r['candidate']==f'bitdirectblock{cutoff}avxbits4']
 for metric in ['vs_bitdirect_compress','vs_scanner_compress','vs_packer_compress','vs_bitdirect_decompress']:
  down=sum(all(v<0 for v in r[metric]['ns_per_page']['session_changes_percent']) for r in selected)
  up=sum(all(v>0 for v in r[metric]['ns_per_page']['session_changes_percent']) for r in selected)
  print(cutoff,metric,'consistent time decreases',down,'increases',up,'mixed',len(selected)-down-up)
 for r in selected:
  if r['corpus'] in ['sparse-words','repeat16','repeat32','words50','clusters50','bash-elf','random','period127','mixed-pages']:
   print(cutoff,r['corpus'],*[round(r[k]['ns_per_page']['median_change_percent'],2) for k in ['vs_bitdirect_compress','vs_scanner_compress','vs_packer_compress','vs_bitdirect_decompress']])
