# SPDX-License-Identifier: GPL-2.0-only
"""Deterministic zero-tail pages and bounded aligned direct I/O controls."""
import hashlib,mmap,os
PAGE=4096
CHUNK=32*PAGE
def page(index,zero_percentage):
 assert zero_percentage in [0,25,50,75,100] and index>=0
 n=PAGE*(100-zero_percentage)//100
 return hashlib.shake_256(b'n100-fixed-page-v1'+index.to_bytes(8,'little')).digest(n)+bytes(PAGE-n)
def transfer(path,size,zero_percentage,*,verify=False,direct=True):
 assert size>0 and size%CHUNK==0
 flags=(os.O_RDONLY if verify else os.O_WRONLY)|(os.O_DIRECT if direct else 0)
 fd=os.open(path,flags);digest=hashlib.sha256()
 try:
  with mmap.mmap(-1,CHUNK) as buffer:
   for offset in range(0,size,CHUNK):
    expected=b''.join(page(i,zero_percentage) for i in range(offset//PAGE,(offset+CHUNK)//PAGE))
    if verify:
     assert os.readv(fd,[buffer])==CHUNK,'Short fixture read'
     assert buffer[:]==expected,'Identical-page fixture mismatch'
    else:
     buffer[:]=expected;assert os.write(fd,buffer)==CHUNK,'Short fixture write'
    digest.update(expected)
   if not verify:os.fsync(fd)
 finally:os.close(fd)
 return digest.hexdigest()
