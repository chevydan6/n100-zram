#!/usr/bin/env python3
"""Check staged signed-source components and reference ZRAM files against the recorded manifest."""
import hashlib,json,tarfile
from pathlib import Path
root=Path(__file__).resolve().parents[3]
manifest=json.loads((root/'benchmarks/results/terra-simd-zram-001/manifest.json').read_text())
components=manifest['source_record']['source_review']['files']; expected=manifest['source_record']['files']
folder=root/'build/terra-signed-components-001';reference=root/'build/astra-zram-reference-001/zram'
for name,want in components.items():
 assert hashlib.sha256((folder/name).read_bytes()).hexdigest()==want,name
found={};prefix='linux-7.2.11/drivers/block/zram/'
with tarfile.open(folder/'linux-7.2.11.tar.xz','r|xz') as archive:
 for member in archive:
  if member.isfile() and member.name.startswith(prefix):
   name=member.name[len(prefix):]
   if name in expected:
    assert name not in found
    found[name]=hashlib.sha256(archive.extractfile(member).read()).hexdigest()
assert found==expected
for name,want in expected.items():assert hashlib.sha256((reference/name).read_bytes()).hexdigest()==want,name
print(f'{len(components)} signed source components and {len(found)} reference files match recorded hashes')
