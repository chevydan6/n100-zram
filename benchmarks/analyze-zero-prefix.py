#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Evaluate a hypothetical guard on preserved corpora; no timed policy claim."""
import ctypes as C
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys

root=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('owned_sample',root/'benchmarks/sample-owned-compile.py')
module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
out=root/'build/terra-zero-prefix-corpus-001'
if out.exists():raise SystemExit('Existing output preserved')
out.mkdir();benchmark=root/'build/terra-matched-codecs-001/benchmark';directory=benchmark.parent
hybrid=root/'build/astra-v9/libgzram-hybrid-bitdirectblock2avxbits4bounded.so';lz4=root/'build/lz4-scalar-table-001'
env=dict(os.environ,GZRAM_EXEC_CORPUS_DIR=str(root/'build/astra-exec-corpora-001'));env.pop('GZRAM_CORPUS_LIST',None)
sha=lambda data:hashlib.sha256(data).hexdigest()
try:
 names=subprocess.check_output([str(benchmark),str(directory),'--list-corpora'],env=env,text=True).splitlines();assert len(names)==29 and len(set(names))==29
 old=json.loads((root/'build/astra-v9-sizes/metadata.json').read_text())['corpus_sha256']
 codecs=module.Codecs(lz4,hybrid);result={};hashes={}
 for name in names:
  data=subprocess.check_output([str(benchmark),str(directory),'--dump-corpus='+name],env=env);assert len(data)==128*4096
  hashes[name]=sha(data)
  if name in old:assert hashes[name]==old[name],name
  else:assert data==(root/'build/astra-exec-corpora-001'/f'{name}.bin').read_bytes(),name
  bucket={'pages':0,'same_word':0,'codecs':{}}
  for i in range(128):
   page=C.create_string_buffer(data[i*4096:(i+1)*4096],4096);module.add_sample(bucket,codecs.classify(page))
  result[name]=bucket
 record=dict(status='passed',scope='Untimed hypothetical recurrence guard; no algorithm selection, performance, energy or real-world claim; same-word pages bypassed',corpus_sha256=hashes,results=result,benchmark_sha256=sha(benchmark.read_bytes()),sampler_sha256=sha((root/'benchmarks/sample-owned-compile.py').read_bytes()),analyzer_sha256=sha(Path(__file__).read_bytes()))
 (out/'result.json').write_text(json.dumps(record,indent=2)+'\n')
 for name,x in result.items():
  q=x.get('zero_prefix_probe',{});print(name,'eligible',q.get('eligible',0),'fired',q.get('fired',0),'smaller',q.get('smaller',0),'equal',q.get('equal',0),'larger',q.get('larger',0),'net_bytes',q.get('hypothetical_bytes',0)-q.get('existing_bytes',0))
except BaseException as e:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=str(e)),indent=2)+'\n');raise
