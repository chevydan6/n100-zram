#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Cross-variant byte identity, round trips, canaries and malformed inputs."""
import ctypes as C, random, pathlib, json
root=pathlib.Path(__file__).resolve().parents[1]
rng=random.Random(100)
def codecs():
    result={}
    for path in sorted((root/'build').glob('*.so')):
        lib=C.CDLL(str(path)); comp=lib.LZ4_compress_default; dec=lib.LZ4_decompress_safe
        comp.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int,C.c_void_p]; comp.restype=C.c_int
        dec.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int]; dec.restype=C.c_int
        result[path.stem]=(comp,dec)
    return result

def pages():
    for n in list(range(0,130))+list(range(130,4097,31))+[4096]:
        yield bytes(rng.getrandbits(8) for _ in range(n))
        for period in [1,2,3,4,7,8,15,16,31,32,33,64,127]:
            pattern=bytes(rng.getrandbits(8) for _ in range(period))
            yield (pattern*((n+period-1)//period))[:n]
    for _ in range(300):
        n=rng.randrange(4097)
        yield bytes(0 if rng.random()<.9 else rng.randrange(256) for _ in range(n))

def main():
    libs=codecs(); count=0
    for data in pages():
        src=C.create_string_buffer(data); expected=None
        for name,(comp,_) in libs.items():
            dst=C.create_string_buffer(4352); work=C.create_string_buffer(32768)
            size=comp(src,dst,len(data),4352,work)
            assert size>0,(name,len(data),size)
            encoded=dst.raw[:size]
            if expected is None: expected=encoded
            assert encoded==expected,(name,'format differs')
            for decname,(_,dec) in libs.items():
                output=C.create_string_buffer(b'Q'*(len(data)+32),len(data)+32)
                got=dec(encoded,output,size,len(data))
                assert got==len(data) and output.raw[:got]==data,(name,decname,len(data),got)
                assert output.raw[len(data):]==b'Q'*32,(decname,'canary')
        count+=1
    # Differential malformed-input behavior against the original kernel decoder.
    for _ in range(20000):
        n=rng.randrange(1,256); data=bytes(rng.randrange(256) for _ in range(n)); expected=None
        for name,(_,dec) in libs.items():
            output=C.create_string_buffer(b'Q'*4128,4128)
            got=dec(data,output,n,4096)
            assert output.raw[4096:]==b'Q'*32,(name,'malformed canary')
            value=(got,output.raw[:got]) if got>=0 else ('error',)
            if expected is None: expected=value
            assert value==expected,(name,'malformed mismatch',got)
    print(json.dumps({'roundtrip_inputs':count,'malformed_inputs':20000,'variants':list(libs),'status':'passed'}))
if __name__=='__main__': main()
