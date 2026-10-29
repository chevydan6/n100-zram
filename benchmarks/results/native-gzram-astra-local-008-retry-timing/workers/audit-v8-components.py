import hashlib,json,pathlib,re
root=pathlib.Path('/home/dan/n100-zram');source=root/'build/astra-v8-assembly'
functions={}
for path in sorted(source.glob('*.asm')):
 current=None;parts=[];instructions=[]
 def save():
  if current in ['scan_avx2','pack_block_avx2']:
   functions[path.stem,current]=dict(bytes=bytes(parts),instructions=list(instructions))
 for line in path.read_text().splitlines():
  m=re.match(r'^[0-9a-f]+ <([^>]+)>:$',line)
  if m:save();current=m[1];parts=[];instructions=[];continue
  m=re.match(r'^\s*[0-9a-f]+:\s+((?:[0-9a-f]{2} )*[0-9a-f]{2})(?:\s+(.+))?$',line)
  if m and current:
   parts.extend(bytes.fromhex(m[1]));instructions.append(m[2] or '')
 save()
rows=[]
for kind,control,targets in [
 ('scan_avx2','bitpackbase',['blockdirect2base','blockdirect3base']),
 ('scan_avx2','pipe4base',['block2pipe4base','block3pipe4base']),
 ('scan_avx2','avxbits4base',['block2avxbits4base','block3avxbits4base']),
 ('pack_block_avx2','blockdirect2base',['blockdirect3base','block2pipe4base','block3pipe4base','block2avxbits4base','block3avxbits4base'])]:
 for target in targets:
  a,b=functions[control,kind]['bytes'],functions[target,kind]['bytes']
  # Alignment padding belongs to the subsequent symbol's layout, not the body.
  # Record literal disassembly equality; do not normalize a failure away.
  rows.append(dict(function=kind,control=control,candidate=target,control_disassembly_bytes=len(a),candidate_disassembly_bytes=len(b),literal_bytes_equal=a==b,control_sha256=hashlib.sha256(a).hexdigest(),candidate_sha256=hashlib.sha256(b).hexdigest()))
record=dict(scope='Read-only comparison of previously saved relocatable-object disassembly, including symbol-gap padding. Unresolved relocations are not final library addresses. This is code-identity evidence, not a measurement of execution ports or a proof of runtime causality.',rows=rows,
 scanners={name:dict(bytes=len(v['bytes']),vector_stack_operands=[line for line in v['instructions'] if re.search(r'\b[xyz]mm\d+\b',line) and re.search(r'\[(?:r[bs]p)',line)]) for (name,kind),v in functions.items() if kind=='scan_avx2'})
out=root/'build/astra-v8-assembly/component-identity.json'
with out.open('x') as f:json.dump(record,f,indent=2);f.write('\n')
print(json.dumps(record,indent=2))
