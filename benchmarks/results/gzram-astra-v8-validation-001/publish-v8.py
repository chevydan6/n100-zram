import csv,json,pathlib,shutil
root=pathlib.Path('/home/dan/n100-zram');src=root/'build/astra-v8-validation';scans=root/'build/astra-v8-scans-validation'
assert json.loads((src/'result.json').read_text())['status']=='passed'
assert json.loads((scans/'result.json').read_text())['status']=='passed'
assert json.loads((root/'build/astra-v8-isolated-validation/result.json').read_text())['status']=='passed'
old=root/'benchmarks/results/gzram-astra-v7-sizes-001';new=root/'build/astra-v8-sizes'
a=json.loads((old/'metadata.json').read_text());b=json.loads((new/'metadata.json').read_text())
assert a['corpus_sha256']==b['corpus_sha256']
with (old/'sizes.csv').open() as f:x={(r['corpus'],r['variant'],r['page']):(r['compressed_bytes'],r['hybrid_mode']) for r in csv.DictReader(f)}
old_matches=new_matches=total=0
with (new/'sizes.csv').open() as f:
 for r in csv.DictReader(f):
  key=(r['corpus'],r['variant'],r['page']);value=(r['compressed_bytes'],r['hybrid_mode']);total+=1
  if key in x:assert x[key]==value;old_matches+=1
  else:
   parts=r['variant'].split('-');assert parts[1] in ['bitdirectblock2', 'bitdirectblock2pipe4', 'bitdirectblock2avxbits4', 'bitdirectblock3', 'bitdirectblock3pipe4', 'bitdirectblock3avxbits4'];parts[1]='bitdirect'
   assert x[(r['corpus'],'-'.join(parts),r['page'])]==value;new_matches+=1
assert old_matches==len(x) and new_matches==6*2*2*26*128
record=dict(original_corpora_identical=26,original_size_records_identical=old_matches,new_candidate_records_identical_to_bitdirect=new_matches,total_size_records=total)
(src/'preserved-sizes.json').write_text(json.dumps(record,indent=2)+'\n')
dest=root/'benchmarks/results/gzram-astra-v8-validation-001';shutil.copytree(src,dest)
shutil.copytree(scans,dest/'direct-scanners');shutil.copytree(root/'build/astra-v8-assembly',dest/'assembly')
shutil.copytree(root/'build/astra-v8-isolated-validation',dest/'isolated-harness',ignore=shutil.ignore_patterns('*-smoke'))
for worker in ['validate-v8.py','validate-v8-scans.py','validate-v8-isolated.py','publish-v8.py']:shutil.copy2(root/'build/astra-audit'/worker,dest/worker)
for name in ['astra-v8-isolated-own','astra-v8-isolated-shared','astra-v8-isolated-aliases','astra-v8-isolated-asan-own','astra-v8-isolated-asan-shared','astra-v8-isolated-asan-aliases']:
 shutil.copy2(root/'build'/name/'benchmark-build.json',dest/(name+'-benchmark-build.json'))
for name in ['astra-v8','astra-v8-asan']:
 for file in ['manifest.json','benchmark-build.json']:shutil.copy2(root/'build'/name/file,dest/(name+'-'+file))
shutil.copytree(new,root/'benchmarks/results/gzram-astra-v8-sizes-001')
print(json.dumps(record))
