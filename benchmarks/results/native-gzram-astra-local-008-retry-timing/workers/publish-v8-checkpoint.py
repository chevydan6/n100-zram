import pathlib,shutil
r=pathlib.Path('/home/dan/n100-zram');d=r/'benchmarks/results/native-gzram-astra-local-008-retry-timing'
for p in (r/'build/astra-local-008-retry-timing').glob('*.stderr'):shutil.copy2(p,d/p.name)
shutil.copy2(r/'build/astra-audit/v8-retry-postflight.json',d/'postflight.json')
w=d/'workers';w.mkdir(exist_ok=True)
for name in ['freeze-v8.py','launch-v8-retry-timing.py','watch-v8-retry-timing-analysis.py','analyze-v8-retry-timing.py','analyze-v8-retry-decoder-controls.py','review-v8-retry.py','write-v8-findings.py','audit-v8-components.py','publish-v8-checkpoint.py']:
 shutil.copy2(r/'build/astra-audit'/name,w/name)
p=d/'findings.md';s=p.read_text();marker='## CPU time and cycles for the cutoff-2 combination'
assert '## Matching combined controls' not in s
rows=[]
for line in (d/'paired.md').open():
 fields=[x.strip() for x in line.split('|')][1:-1]
 if len(fields)!=8:continue
 corpus,op,candidate,control,*metrics=fields
 if op=='compress' and any(candidate==f'ghy-bitdirectblock{k}avxbits4-avx2-1024' and control==f'ghy-bitdirectblock{k}-avx2-1024' for k in [2,3]):rows.append((corpus,candidate,metrics[0],metrics[3]))
assert len(rows)==52
section='''## Matching combined controls

The plain combined controls (`bitdirectblock2/3`) retain the same decoder and
repeat handling as the grouped combinations. They isolate grouping more closely
than the older standalone packers. Compression effects below retain all corpora;
negative values mean less time. Session ranges are descriptive, not confidence
intervals. Sparse words are essentially tied, while words25 regresses with both
cutoffs. Thus the scanner and packer gains do not simply add across workloads.

| Corpus | Cutoff | Compression time change, % (session range) | Thread CPU change, % |
|---|---:|---:|---:|
'''
for corpus,candidate,t,cpu in rows:section+=f'| {corpus} | {2 if "block2" in candidate else 3} | {t} | {cpu} |\n'
p.write_text(s.replace(marker,section+'\n'+marker))
