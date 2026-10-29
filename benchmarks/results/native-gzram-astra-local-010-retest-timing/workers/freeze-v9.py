import hashlib,io,json,pathlib,subprocess,tarfile
root=pathlib.Path('/home/dan/n100-zram');directory=root/'build/astra-v9';validation=root/'build/astra-v9-validation-002'
assert json.loads((validation/'result.json').read_text())['status']=='passed'
validated=json.loads((validation/'source-hashes.json').read_text())
for name,digest in validated.items():assert hashlib.sha256((root/name).read_bytes()).hexdigest()==digest,name
assert not subprocess.check_output(['git','diff','HEAD','--','gzram','src/kernel-lz4','include'],cwd=root)
for gate in ['build/astra-v9-isolated-validation/source-hashes.json']:
 for name,digest in json.loads((root/gate).read_text()).items():
  assert hashlib.sha256((root/name).read_bytes()).hexdigest()==digest,name
commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip()
snapshot=directory/'source-checkpoint';snapshot.mkdir()
archive=subprocess.check_output(['git','archive',commit,'gzram','src/kernel-lz4','include'],cwd=root)
with tarfile.open(fileobj=io.BytesIO(archive)) as source:source.extractall(snapshot,filter='data')
hashes={str(p.relative_to(snapshot)):hashlib.sha256(p.read_bytes()).hexdigest() for p in snapshot.rglob('*') if p.is_file()}
for name,digest in validated.items():assert hashes[name]==digest,name
(snapshot/'source-provenance.json').write_text(json.dumps(dict(source_commit=commit,source_hashes=hashes),indent=2)+'\n')
print(commit,len(hashes),'frozen source files')
