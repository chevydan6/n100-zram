#!/usr/bin/env python3
"""Differential userspace Zstandard 1.5.7 experiment; not a kernel test."""
import concurrent.futures,ctypes,hashlib,json,os,pathlib,random,time
P=pathlib.Path
base=P('/home/dan/n100-zram')
paths={'control':base/'build/terra-zstd-control-lib/libzstd.so.1.5.7','n100':base/'build/terra-zstd-n100-lib/libzstd.so.1.5.7','independent':P('/usr/lib64/libzstd.so.1')}
libs={}
for name,path in paths.items():
 l=ctypes.CDLL(str(path),mode=os.RTLD_LOCAL|os.RTLD_DEEPBIND|os.RTLD_NOW)
 for fn in ('ZSTD_createCCtx','ZSTD_createDCtx'):getattr(l,fn).restype=ctypes.c_void_p
 for fn in ('ZSTD_freeCCtx','ZSTD_freeDCtx'):getattr(l,fn).argtypes=[ctypes.c_void_p]
 l.ZSTD_compressCCtx.argtypes=[ctypes.c_void_p,ctypes.c_void_p,ctypes.c_size_t,ctypes.c_void_p,ctypes.c_size_t,ctypes.c_int];l.ZSTD_compressCCtx.restype=ctypes.c_size_t
 l.ZSTD_decompressDCtx.argtypes=[ctypes.c_void_p,ctypes.c_void_p,ctypes.c_size_t,ctypes.c_void_p,ctypes.c_size_t];l.ZSTD_decompressDCtx.restype=ctypes.c_size_t
 l.ZSTD_isError.argtypes=[ctypes.c_size_t];l.ZSTD_isError.restype=ctypes.c_uint
 libs[name]=l
names=['bash-elf','libc-elf','sparse-words','repeat8','period127','mixed-pages','clusters50','random']; corp={}
for n in names:
 data=(base/'build/astra-zram-corpora-001'/(n+'.bin')).read_bytes();assert len(data)==128*4096
 corp[n]=[ctypes.create_string_buffer(data[i:i+4096],4096) for i in range(0,len(data),4096)]
class Codec:
 def __init__(self,name):self.lib=libs[name];self.c=self.lib.ZSTD_createCCtx();self.d=self.lib.ZSTD_createDCtx();assert self.c and self.d
 def close(self):self.lib.ZSTD_freeCCtx(self.c);self.lib.ZSTD_freeDCtx(self.d)
 def compress(self,src):
  dst=ctypes.create_string_buffer(4224);ctypes.memset(ctypes.addressof(dst)+4160,0xa5,64)
  n=self.lib.ZSTD_compressCCtx(self.c,dst,4160,src,4096,3)
  assert not self.lib.ZSTD_isError(n) and n<=4160 and dst.raw[4160:]==b'\xa5'*64
  return dst.raw[:n]
 def decompress(self,src,sz,cap=4096):
  dst=ctypes.create_string_buffer(4160);ctypes.memset(ctypes.addressof(dst)+4096,0xa5,64)
  n=self.lib.ZSTD_decompressDCtx(self.d,dst,cap,src,sz)
  assert dst.raw[4096:]==b'\xa5'*64
  return n,dst.raw[:4096]
def verify_group(group):
 c=Codec('control');o=Codec('n100');ind=Codec('independent'); count=0
 try:
  for src in group:
   a=c.compress(src);b=o.compress(src);assert a==b
   buf=ctypes.create_string_buffer(b,len(b));size=len(b)
   for d in (c,o,ind):
    n,raw=d.decompress(buf,size);assert n==4096 and raw==src.raw
    n,_=d.decompress(buf,size-1);assert d.lib.ZSTD_isError(n)
    n,_=d.decompress(buf,size,4095);assert d.lib.ZSTD_isError(n)
   count+=1
 finally:c.close();o.close();ind.close()
 return count
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
 counts=list(pool.map(verify_group,[sum((corp[n] for n in names[i::4]),[]) for i in range(4)]))
result={'scope':'Userspace full-codec matched experiment; no kernel, energy or ZRAM claim',
        'library_sha256':{n:hashlib.sha256(p.read_bytes()).hexdigest() for n,p in paths.items()},'verified_pages':sum(counts),'trials':[],'seed':62140}
rng=random.Random(62140);cs={n:Codec(n) for n in ('control','n100')}
try:
 for round_ in range(9):
  order=names.copy();rng.shuffle(order)
  for name in order:
   variants=['control','n100'];rng.shuffle(variants)
   for variant in variants:
    c=cs[variant];srcs=corp[name]; compressed=[c.compress(s) for s in srcs];encoded=[ctypes.create_string_buffer(s,len(s)) for s in compressed]
    t=time.perf_counter_ns();cpu=time.thread_time_ns()
    for _ in range(8):
     for src in srcs:c.compress(src)
    cns=time.thread_time_ns()-cpu;ns=time.perf_counter_ns()-t
    t=time.perf_counter_ns();cpu=time.thread_time_ns()
    for _ in range(8):
     for buf,frame in zip(encoded,compressed):
      n,_=c.decompress(buf,len(frame));assert n==4096
    dns=time.thread_time_ns()-cpu;dwall=time.perf_counter_ns()-t
    result['trials'].append({'round':round_,'corpus':name,'variant':variant,'compress_wall_ns':ns,'compress_cpu_ns':cns,'decompress_wall_ns':dwall,'decompress_cpu_ns':dns,'calls':1024,'bytes':sum(map(len,compressed))})
finally:
 for c in cs.values():c.close()
print(json.dumps(result,sort_keys=True))
