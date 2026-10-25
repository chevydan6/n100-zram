#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Instrumented path coverage only: no latency, threshold or hardware performance claim."""
import argparse,ctypes as C,hashlib,json,random
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--directory',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();assert not a.output.exists()
libs=[];rng=random.Random(100);rows=[]
for name in ['scalar','sse','avx2']:
 path=a.directory/(name+'.so');lib=C.CDLL(str(path));lib.LZ4_compress_default.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int,C.c_void_p];lib.LZ4_decompress_safe.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int];lib.n100_trace_matches.restype=C.c_ulong;lib.n100_trace_copies.restype=C.c_ulong;libs.append((name,lib,hashlib.sha256(path.read_bytes()).hexdigest()))
independent=C.CDLL('liblz4.so.1').LZ4_decompress_safe;independent.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int]
for size in [16,32,40,48,56,64,128,256,320,384,448,512,1024,1280,1536,1792,2048,4096]:
 for corpus in ['random','moderate','periodic']:
  inputs=[bytes(rng.randrange(256) if corpus=='random' or (corpus=='moderate' and i%64<32) else i%7+(page if corpus=='periodic' else 0) for i in range(size)) for page in range(128)]
  reference=[]
  for name,lib,_ in libs:
   work=C.create_string_buffer(32768);packed=[];lib.n100_trace_reset()
   for page,data in enumerate(inputs):
    output=C.create_string_buffer(4352);n=lib.LZ4_compress_default(data,output,size,4352,work);assert n>0
    block=output.raw[:n];packed.append(block)
    if name=='scalar':reference.append(block)
    else:assert block==reference[page]
   rows.append({'bytes':size,'corpus':corpus,'variant':name,'operation':'compress','blocks':128,'match_vector_iterations':lib.n100_trace_matches(),'copy_vector_iterations':lib.n100_trace_copies()})
   lib.n100_trace_reset()
   for data,block in zip(inputs,packed):
    output=C.create_string_buffer(size);assert lib.LZ4_decompress_safe(block,output,len(block),size)==size and output.raw==data
    assert independent(block,output,len(block),size)==size and output.raw==data
   rows.append({'bytes':size,'corpus':corpus,'variant':name,'operation':'decompress','blocks':128,'match_vector_iterations':lib.n100_trace_matches(),'copy_vector_iterations':lib.n100_trace_copies()})
a.output.write_text(json.dumps({'scope':'Instrumented source-path coverage only; trace builds alter code generation, libc SIMD is not counted; no performance or kernel threshold claim','libraries':{name:sha for name,_,sha in libs},'rows':rows},indent=2)+'\n')
print('Instrumented byte-identity and independent decode checks passed;',len(rows),'path-coverage rows')
