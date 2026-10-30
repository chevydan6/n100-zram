#!/usr/bin/env python3
"""Deterministic pages above the candidate zero-density threshold."""
import ctypes as C,hashlib,importlib.util,json,pathlib,random
root=pathlib.Path(__file__).resolve().parents[3];spec=importlib.util.spec_from_file_location('owned',root/'benchmarks/sample-owned-compile.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
codec=m.Codecs(root/'build/lz4-scalar-table-001',root/'build/astra-v9/libgzram-hybrid-bitdirectblock2avxbits4bounded.so');rng=random.Random(449);bucket={'pages':0,'same_word':0,'codecs':{}};h=hashlib.sha256()
for _ in range(128):
 data=bytearray(4096);indices=list(range(0,1024,64))+rng.sample([i for i in range(1024) if i%64],534)
 for j in indices:data[j*4:j*4+4]=(rng.getrandbits(32)|1).to_bytes(4,'little')
 h.update(data);m.add_sample(bucket,codec.classify(C.create_string_buffer(bytes(data),4096)))
print(json.dumps(dict(scope='Untimed synthetic density-threshold adversary; no speed or energy claim',seed=449,pages_sha256=h.hexdigest(),result=bucket),indent=2))
