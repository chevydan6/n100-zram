#!/usr/bin/env python3
"""Construct pages whose zero words are hidden from both sampled lattices."""
import ctypes as C,hashlib,importlib.util,json,pathlib,random
root=pathlib.Path(__file__).resolve().parents[3];spec=importlib.util.spec_from_file_location('owned',root/'benchmarks/sample-owned-compile.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
codec=m.Codecs(root/'build/lz4-scalar-table-001',root/'build/astra-v9/libgzram-hybrid-bitdirectblock2avxbits4bounded.so');rng=random.Random(441);bucket={'pages':0,'same_word':0,'codecs':{}};h=hashlib.sha256()
for _ in range(128):
 data=bytearray(4096)
 for i in range(16):
  for offset in (0,4): data[i*256+offset:i*256+offset+4]=(rng.getrandbits(32)|1).to_bytes(4,'little')
 for j in rng.sample([i for i in range(1024) if i%64 not in (0,1)],64): data[j*4:j*4+4]=(rng.getrandbits(32)|1).to_bytes(4,'little')
 h.update(data);m.add_sample(bucket,codec.classify(C.create_string_buffer(bytes(data),4096)))
print(json.dumps(dict(scope='Synthetic untimed two-lattice adversary; no speed or energy claim',seed=441,pages_sha256=h.hexdigest(),result=bucket),indent=2))
