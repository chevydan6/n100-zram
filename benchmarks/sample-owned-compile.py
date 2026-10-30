#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Sample resident pages only from compiler children launched by this process.

Read-only, private userspace pilot. No raw pages, addresses, contents of
unrelated processes, browser profiles or process maps are written. Reported
sizes are logical payload sizes, not ZRAM allocator usage. Sampling perturbs
work and these snapshots do not represent pages selected by kernel reclaim.
"""
import argparse
import ctypes as C
import hashlib
import json
import os
import pathlib
import random
import struct
import subprocess
import tempfile
import time

ROOT = pathlib.Path(__file__).resolve().parents[1]
PAGE = 4096
BOUND = 4352
SOURCES = ['src/kernel-lz4/lz4_compress.c', 'src/kernel-lz4/lz4_decompress.c', 'gzram/src/gzram.c']

class Iovec(C.Structure):
    _fields_ = [('base', C.c_void_p), ('length', C.c_size_t)]

libc = C.CDLL(None, use_errno=True)
read_process = libc.process_vm_readv
read_process.argtypes = [C.c_int, C.POINTER(Iovec), C.c_ulong, C.POINTER(Iovec), C.c_ulong, C.c_ulong]
read_process.restype = C.c_ssize_t


def available_kib():
    return int(next(x.split()[1] for x in pathlib.Path('/proc/meminfo').read_text().splitlines() if x.startswith('MemAvailable:')))


def maps_for_child(pid, expected_parent):
    """Return eligible mappings only if the process is still our GCC child."""
    proc = pathlib.Path('/proc') / str(pid)
    lines = (proc / 'status').read_text().splitlines()
    if next(x.split(':', 1)[1].strip() for x in lines if x.startswith('Name:')) != 'cc1':
        return []
    if int(next(x.split()[1] for x in lines if x.startswith('PPid:'))) != expected_parent:
        return []
    mappings = []
    for line in (proc / 'maps').read_text().splitlines():
        fields = line.split(maxsplit=5)
        if len(fields) < 5 or fields[1][0] != 'r' or fields[1][3] != 'p':
            continue
        start, end = (int(x, 16) for x in fields[0].split('-'))
        name = fields[5] if len(fields) > 5 else ''
        if not name or name in ['[heap]', '[stack]']:
            kind = 'anonymous_private'
        elif 'x' in fields[1] and name.startswith('/'):
            kind = 'file_executable'
        else:
            continue
        if end - start >= PAGE:
            mappings.append((start, (end-start)//PAGE, kind))
    return mappings


def sample_page(pid, address, pagemap, buffer):
    """Check only pagemap present bit, then copy one page; do not fault known absent pages."""
    raw = os.pread(pagemap, 8, (address//PAGE)*8)
    if len(raw) != 8 or not (struct.unpack('<Q', raw)[0] & (1 << 63)):
        return 'not_present'
    local = Iovec(C.addressof(buffer), PAGE)
    remote = Iovec(address, PAGE)
    got = read_process(pid, C.byref(local), 1, C.byref(remote), 1, 0)
    return 'read' if got == PAGE else 'read_failed'


def zero_prefix_recurrence(data, scan_bytes=64, search_bytes=1024):
    """Hypothetical bounded guard: seek a repeated nonzero word after zero prefix.

    This Python diagnostic is untimed and does not change codec selection.
    It proposes only logical-size behavior; timing needs a separate C candidate.
    """
    if len(data)<16 or data[:8]!=bytes(8): return False
    for start in range(8,min(scan_bytes,len(data)-8)+1,8):
        key=data[start:start+8]
        if key != bytes(8):
            limit=min(len(data)-8,start+search_bytes)
            return data.find(key,start+1,limit+8)>=0
    return False


class Codecs:
    def __init__(self, directory, hybrid):
        self.entries = []
        for bits in [14, 13, 12]:
            lib = C.CDLL(str(directory / f'table{bits}-scalar.so'))
            lib.n100_reuse_worksize.restype = C.c_ulong
            lib.n100_reuse_init.argtypes = [C.c_void_p]
            enc = lib.n100_reuse_compress
            enc.argtypes = [C.c_void_p,C.c_void_p,C.c_int,C.c_int,C.c_void_p]; enc.restype = C.c_int
            work = C.create_string_buffer(lib.n100_reuse_worksize())
            lib.n100_reuse_init(work)
            self.entries.append((f'table{bits}-scalar',enc,work,None))
        self.lz4 = C.CDLL('liblz4.so.1').LZ4_decompress_safe
        self.lz4.argtypes = [C.c_void_p,C.c_void_p,C.c_int,C.c_int]; self.lz4.restype = C.c_int
        lib = C.CDLL(str(hybrid))
        lib.gzram_avx2_available.restype = C.c_int
        if not lib.gzram_avx2_available(): raise RuntimeError('AVX2/OS state unavailable')
        for isa in ['scalar','avx2']:
            enc = getattr(lib, 'gzram_encode_'+isa)
            enc.argtypes = [C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint]; enc.restype = C.c_int
            dec = getattr(lib, 'gzram_decode_'+isa)
            dec.argtypes = [C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t]; dec.restype = C.c_int
            self.entries.append(('ghy-combined-'+isa,enc,None,dec))
        self.dst = C.create_string_buffer(BOUND)
        self.decoded = C.create_string_buffer(PAGE)

    def classify(self, page):
        data = page.raw
        if data == data[:8] * (PAGE//8):
            return {'same_word': True}
        output = {}
        for name, enc, work, dec in self.entries:
            if work is None:
                size = enc(page,PAGE,self.dst,BOUND,10)
                got = dec(self.dst,size,self.decoded,PAGE) if size > 0 else -1
            else:
                size = enc(page,self.dst,PAGE,BOUND,work)
                got = self.lz4(self.dst,self.decoded,size,PAGE) if size > 0 else -1
            if size <= 0 or size > BOUND or got != PAGE or self.decoded.raw != data:
                raise RuntimeError('codec round-trip failure: '+name)
            output[name] = {'encoded_bytes':size,'logical_stored_bytes':min(size,PAGE),'raw':size>=PAGE}
            if work is None:
                header = self.dst.raw[:8]
                if header[:4] != b'GHY1' or header[6] > 2:
                    raise RuntimeError('invalid hybrid frame header: '+name)
                output[name]['mode'] = int(header[6])
        # Only a diagnostic feature, never stored payload or an encoding decision.
        output['zero_prefix_recurrence'] = zero_prefix_recurrence(data)
        return output


def add_sample(bucket, classified):
    bucket['pages'] += 1
    if classified.get('same_word'):
        bucket['same_word'] += 1
        return
    for name, values in classified.items():
        if name == 'zero_prefix_recurrence': continue
        dest = bucket['codecs'].setdefault(name, {'pages':0,'encoded_bytes':0,'logical_stored_bytes':0,'raw_pages':0})
        dest['pages'] += 1
        dest['encoded_bytes'] += values['encoded_bytes']
        dest['logical_stored_bytes'] += values['logical_stored_bytes']
        dest['raw_pages'] += int(values['raw'])
    # Compare the hybrid mode with LZ4 on the same non-same-word sample. Only
    # aggregate sizes/counts are retained; never store bytes or addresses.
    hybrid=classified['ghy-combined-avx2'];lz4=classified['table12-scalar']
    mode=str(hybrid['mode'])
    pair=bucket.setdefault('hybrid_mode_comparison',{}).setdefault(mode,{'pages':0,'ghy_logical_bytes':0,'lz4_logical_bytes':0,'ghy_larger':0,'equal':0,'ghy_smaller':0})
    a,b=hybrid['logical_stored_bytes'],lz4['logical_stored_bytes']
    pair['pages']+=1;pair['ghy_logical_bytes']+=a;pair['lz4_logical_bytes']+=b
    pair['ghy_larger']+=int(a>b);pair['equal']+=int(a==b);pair['ghy_smaller']+=int(a<b)
    # Existing guard only consults recurrence for accepted GZR payloads > n/4.
    # Simulate replacing such a frame with a GHY-wrapped table12 LZ4 frame.
    if hybrid['mode']==1 and hybrid['encoded_bytes']-8 > PAGE//4:
        probe=bucket.setdefault('zero_prefix_probe',{'eligible':0,'fired':0,'smaller':0,'equal':0,'larger':0,'existing_bytes':0,'hypothetical_bytes':0})
        probe['eligible']+=1
        if classified['zero_prefix_recurrence']:
            alternative=min(PAGE,lz4['encoded_bytes']+8)
            probe['fired']+=1;probe['existing_bytes']+=a;probe['hypothetical_bytes']+=alternative
            probe['smaller']+=int(alternative<a);probe['equal']+=int(alternative==a);probe['larger']+=int(alternative>a)


def run_job(source, target, codecs, rng, per_class, target_dir):
    result = {'source':source,'classes':{kind:{'pages':0,'same_word':0,'codecs':{}} for kind in ['anonymous_private','file_executable']},
              'attempts':0,'not_present':0,'read_failed':0,'pagemap_denied':0,'sampled_processes':0,
              'eligible_read':{'anonymous_private':0,'file_executable':0},'sampling_rounds':0}
    # Avoid inheriting credentials, user profiles or unrelated environment.
    env = {'PATH':'/usr/bin:/bin','LANG':'C','LC_ALL':'C','TMPDIR':str(target_dir)}
    cmd = ['/usr/bin/gcc','-O3','-fno-tree-vectorize','-I'+str(ROOT/'include'),
           '-I'+str(ROOT/'build/astra-v9'),'-c',str(ROOT/source),'-o',str(target)]
    child = subprocess.Popen(cmd, env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, start_new_session=True)
    seen = set(); observed_pids=set(); buffer=C.create_string_buffer(PAGE)
    reservoir={kind:[] for kind in result['classes']}
    try:
        deadline=time.monotonic()+180
        while child.poll() is None and time.monotonic()<deadline:
            if available_kib() < 1536*1024:
                raise RuntimeError('Available memory below 1.5 GiB; stopping owned workload')
            try:
                ids = (pathlib.Path('/proc')/str(child.pid)/'task'/str(child.pid)/'children').read_text().split()
            except (OSError, ProcessLookupError):
                ids=[]
            result['sampling_rounds']+=1
            for token in ids:
                pid=int(token)
                try:
                    mappings=maps_for_child(pid,child.pid)
                    if not mappings: continue
                    observed_pids.add(pid)
                    try: fd=os.open(f'/proc/{pid}/pagemap',os.O_RDONLY|os.O_CLOEXEC)
                    except OSError: result['pagemap_denied']+=1; continue
                    try:
                        for kind in result['classes']:
                            if result['eligible_read'][kind] >= 2048: continue
                            pool=[x for x in mappings if x[2]==kind]
                            if not pool: continue
                            weights=[x[1] for x in pool]
                            for _ in range(16):
                                if result['eligible_read'][kind] >= 2048: break
                                start,count,_=rng.choices(pool,weights=weights,k=1)[0]
                                address=start+rng.randrange(count)*PAGE
                                key=(pid,address)
                                if key in seen: continue
                                result['attempts']+=1
                                outcome=sample_page(pid,address,fd,buffer)
                                if outcome=='read':
                                    seen.add(key)
                                    result['eligible_read'][kind]+=1
                                    classified=codecs.classify(buffer)
                                    pool_result=reservoir[kind]
                                    if len(pool_result)<per_class:pool_result.append(classified)
                                    else:
                                        choice=rng.randrange(result['eligible_read'][kind])
                                        if choice<per_class:pool_result[choice]=classified
                                else:result[outcome]+=1
                    finally: os.close(fd)
                except (OSError,ProcessLookupError,StopIteration):
                    result['read_failed']+=1
            time.sleep(.20)
        if child.poll() is None:
            try: child.wait(timeout=max(1,deadline-time.monotonic()))
            except subprocess.TimeoutExpired: raise RuntimeError('Compiler exceeded deadline')
        result['returncode']=child.returncode
        if child.returncode:raise RuntimeError('Owned compiler workload failed for '+source)
    finally:
        if child.poll() is None:
            child.terminate()
            try:child.wait(timeout=5)
            except subprocess.TimeoutExpired:child.kill();child.wait()
    for kind,samples in reservoir.items():
        for sample in samples:add_sample(result['classes'][kind],sample)
    result['sampled_processes']=len(observed_pids)
    return result


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--lz4-directory',type=pathlib.Path,required=True)
    parser.add_argument('--hybrid',type=pathlib.Path,required=True)
    parser.add_argument('--output',type=pathlib.Path,required=True)
    parser.add_argument('--pages-per-class',type=int,default=64)
    parser.add_argument('--seed',type=int,default=418)
    args=parser.parse_args()
    if not 1<=args.pages_per_class<=128:parser.error('pages-per-class must be 1..128')
    if args.output.exists():parser.error('Output already exists')
    if os.sysconf('SC_PAGE_SIZE')!=PAGE:parser.error('4 KiB pages required')
    if available_kib()<2*1024**2:parser.error('Need at least 2 GiB available before launch')
    os.umask(0o077);args.output.mkdir(parents=True)
    sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
    files=[ROOT/s for s in SOURCES]+[args.lz4_directory/f'table{x}-scalar.so' for x in [14,13,12]]+[args.hybrid,ROOT/'build/astra-v9/tables.h',pathlib.Path(__file__).resolve()]
    before={str(p.relative_to(ROOT) if p.is_relative_to(ROOT) else p):sha(p) for p in files}
    state={'status':'running','scope':'Only owned compiler child processes; reservoir of eligible present-page reads over lifetime, no page data persisted; no reclaim population, timing or energy claim',
           'hardware':next(line.split(':',1)[1].strip() for line in pathlib.Path('/proc/cpuinfo').read_text().splitlines() if line.startswith('model name')),
           'kernel':os.uname().release,'compiler':subprocess.check_output(['/usr/bin/gcc','--version'],text=True).splitlines()[0],
           'source_and_library_sha256':before,'pages_per_class_per_job':args.pages_per_class,'seed':args.seed,'jobs':[]}
    def save(): (args.output/'result.json').write_text(json.dumps(state,indent=2)+'\n')
    try:
        if 'N100' not in state['hardware']:raise RuntimeError('Physical N100 required')
        codecs=Codecs(args.lz4_directory,args.hybrid);rng=random.Random(args.seed);save()
        with tempfile.TemporaryDirectory(prefix='n100-owned-compile-') as tmp:
            for index,source in enumerate(SOURCES):
                state['jobs'].append(run_job(source,pathlib.Path(tmp)/f'{index}.o',codecs,rng,args.pages_per_class,pathlib.Path(tmp)));save()
        if before!={str(p.relative_to(ROOT) if p.is_relative_to(ROOT) else p):sha(p) for p in files}:raise RuntimeError('Source or binary changed during sampling')
        if not sum(job['classes']['anonymous_private']['pages'] for job in state['jobs']):raise RuntimeError('No anonymous resident pages sampled')
        state['status']='passed';save()
    except BaseException as exc:
        state['status']='failed';state['error']=str(exc);save();raise

if __name__=='__main__':main()
