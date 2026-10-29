import csv,json,pathlib,shutil
root=pathlib.Path('/home/dan/n100-zram');src=root/'build/astra-v9-validation-002'
assert json.loads((src/'result.json').read_text())['status']=='passed'
assert json.loads((root/'build/astra-v9-isolated-validation/result.json').read_text())['status']=='passed'
old=root/'benchmarks/results/gzram-astra-v8-sizes-001';new=root/'build/astra-v9-sizes'
a=json.loads((old/'metadata.json').read_text());b=json.loads((new/'metadata.json').read_text());assert a['corpus_sha256']==b['corpus_sha256']
with (old/'sizes.csv').open() as f:x={(r['corpus'],r['variant'],r['page']):(r['compressed_bytes'],r['hybrid_mode']) for r in csv.DictReader(f)}
old_matches=new_matches=total=0
with (new/'sizes.csv').open() as f:
 for r in csv.DictReader(f):
  key=(r['corpus'],r['variant'],r['page']);value=(r['compressed_bytes'],r['hybrid_mode']);total+=1
  if key in x:assert x[key]==value;old_matches+=1
  else:
   parts=r['variant'].split('-');assert parts[1] in ['bitdirectbounded','bitdirectblock2avxbits4bounded','bitdirectblock3avxbits4bounded'];parts[1]=parts[1].removesuffix('bounded')
   assert x[(r['corpus'],'-'.join(parts),r['page'])]==value;new_matches+=1
assert old_matches==len(x) and new_matches==3*2*2*26*128
record=dict(original_corpora_identical=26,original_size_records_identical=old_matches,new_candidate_records_identical_to_parent=new_matches,total_size_records=total)
(src/'preserved-sizes.json').write_text(json.dumps(record,indent=2)+'\n')
dest=root/'benchmarks/results/gzram-astra-v9-validation-002';shutil.copytree(src,dest)
shutil.copytree(root/'build/astra-v9-isolated-validation',dest/'isolated-harness',ignore=shutil.ignore_patterns('*-smoke'))
for worker in ['validate-v9-002.py','validate-v9-isolated.py','publish-v9.py']:shutil.copy2(root/'build/astra-audit'/worker,dest/worker)
for name in ['astra-v9-isolated-aliases','astra-v9-isolated-asan-aliases']:
 shutil.copy2(root/'build'/name/'benchmark-build.json',dest/(name+'-benchmark-build.json'))
for name in ['astra-v9','astra-v9-asan']:
 for file in ['manifest.json','benchmark-build.json']:shutil.copy2(root/'build'/name/file,dest/(name+'-'+file))
shutil.copytree(new,root/'benchmarks/results/gzram-astra-v9-sizes-001')
(dest/'summary.md').write_text('''# Bounded-trial correctness checkpoint

Three additive policies bound tentative GZRAM output at the existing 75% size
acceptance threshold: bitdirectbounded, bitdirectblock2avxbits4bounded and
bitdirectblock3avxbits4bounded. LZ4 capacity is unchanged. Accepted repeat frames
remain compact; pages remain independent, with no intended format change.

Normal and ASan/UBSan builds each passed 825 variants × 26 corpora × 128 pages
(2,745,600 registered round trips). Each dedicated candidate test also checks
independent masks, old decoding, guarded capacities, malformed/truncated input,
repeat boundaries and four-thread concurrency. Extra dense-leading and short
repeat cases cover the bounded trial and repeat-merging assumptions. Plain
bitdirectbounded passed 88,640 cross-path round trips; each grouped combination
passed 118,208, including 72 cutoff and 390 scanner-pipeline fixtures.

All 625,664 previous size/mode records and 26 corpus hashes are unchanged;
39,936 new records match the corresponding parent. All 51 previous library
text sections are unchanged. Normal and sanitized isolated benchmark validation
passed for the 16-entry measurement cohort, including shared-decoder aliases
and exact-entry negative controls. Smoke timing only validates bookkeeping;
it is not performance evidence.

The first validation attempt hit a Python fixture variable collision after
successful compilation. Its source, traceback and partial results remain in
../gzram-astra-v9-validation-001-failed/. The corrected attempt reused only
hash-verified normal binaries, then repeated complete validation. No failed
attempt is relabeled successful.

Physical timing and package-energy measurement remain pending. Rejected-output
work is the target; fewer operations do not establish faster execution, lower
energy, or better ZRAM behavior.
''')
print(json.dumps(record))
