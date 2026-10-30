#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Validate owned-page sampling and codec aggregation on disposable synthetic data."""
import ctypes as C
import importlib.util
import os
import pathlib
import subprocess
import sys

root=pathlib.Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('owned_compile',root/'benchmarks/sample-owned-compile.py')
mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
program='''import ctypes,mmap,time
m=mmap.mmap(-1,4096);m[:]=bytes((i*37)%251 for i in range(4096))
print(ctypes.addressof(ctypes.c_char.from_buffer(m)),flush=True)
time.sleep(60)
'''
child=subprocess.Popen([sys.executable,'-c',program],stdout=subprocess.PIPE,text=True,env={'PATH':'/usr/bin:/bin','LANG':'C'})
try:
 address=int(child.stdout.readline().strip());buffer=C.create_string_buffer(4096)
 fd=os.open(f'/proc/{child.pid}/pagemap',os.O_RDONLY|os.O_CLOEXEC)
 try:assert mod.sample_page(child.pid,address,fd,buffer)=='read'
 finally:os.close(fd)
 assert buffer.raw==bytes((i*37)%251 for i in range(4096))
 assert mod.maps_for_child(child.pid,os.getpid())==[] # The sampler accepts cc1 only.
 codecs=mod.Codecs(root/'build/lz4-scalar-table-001',root/'build/astra-v9/libgzram-hybrid-bitdirectblock2avxbits4bounded.so')
 result=codecs.classify(buffer);assert set(result)=={'table14-scalar','table13-scalar','table12-scalar','ghy-combined-scalar','ghy-combined-avx2'}
 bucket={'pages':0,'same_word':0,'codecs':{}};mod.add_sample(bucket,result);assert bucket['pages']==1 and all(x['pages']==1 for x in bucket['codecs'].values())
 C.memset(buffer,0,4096);same=codecs.classify(buffer);assert same=={'same_word':True};mod.add_sample(bucket,same);assert bucket['pages']==2 and bucket['same_word']==1
 print('Owned child memory read, process-name restriction, five codec round trips, same-word handling and aggregate accounting passed')
finally:
 child.terminate();child.wait(timeout=5)
