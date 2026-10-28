#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Build preserved codecs and isolated hybrids with recorded compiler definitions."""
import argparse,hashlib,json,os,shlex,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,default=root/'build/gzram');a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
lines=['/* SPDX-License-Identifier: GPL-2.0-only */','/* Generated from mask bits by this project; no upstream table copied. */']
lines.append('static const unsigned char gz_count[256] = {'+','.join(str(m.bit_count()) for m in range(256))+'};')
for name in ['encode','decode']:
 lines.append(f'static const unsigned int gz_{name}_indices[256][8] = {{')
 for mask in range(256):
  present=[i for i in range(8) if mask&(1<<i)]
  row=present+[0]*(8-len(present)) if name=='encode' else [sum(bool(mask&(1<<j)) for j in range(i)) if mask&(1<<i) else 0 for i in range(8)]
  lines.append('{'+','.join(map(str,row))+'},')
 lines.append('};')
(a.output/'tables.h').write_text('\n'.join(lines)+'\n')
cc=os.environ.get('CC','gcc');extra=shlex.split(os.environ.get('EXTRA_CFLAGS',''))
flags=['-O3','-g','-fPIC','-Wall','-Wextra','-Werror','-fno-tree-vectorize','-fno-strict-aliasing','-mno-sse','-mno-mmx','-mno-avx']
def compile_files(sources,output,defines=(),includes=(),shared=True,bind=False):
 command=[cc,*flags,*extra,*defines,*('-I'+str(i) for i in includes)]
 command+=['-shared'] if shared else ['-c']
 if bind:command+=['-Wl,-Bsymbolic-functions']
 subprocess.run([*command,*map(str,sources),'-o',str(output)],check=True)
base_variants={
 'libgzram.so':[],
 'libgzram-fast.so':['-DGZRAM_SCALAR_FAST=1'],
 'libgzram-block.so':['-DGZRAM_BLOCK_UNPACK=1'],
 'libgzram-period.so':['-DGZRAM_VARIABLE_PERIOD=1','-DGZRAM_SCALAR_FAST=1'],
 'libgzram-filter.so':['-DGZRAM_VARIABLE_PERIOD=1','-DGZRAM_PERIOD_FILTER=1','-DGZRAM_SCALAR_FAST=1'],
}
for name,defines in base_variants.items():compile_files([root/'gzram/src/gzram.c'],a.output/name,defines,[a.output])
# Matched private scalar LZ4: source and attribution remain unchanged.
base=a.output/'lz4-small';private=base/'include/linux';private.mkdir(parents=True,exist_ok=True)
header=(root/'include/linux/lz4.h').read_text();assert header.count('#define LZ4_MEMORY_USAGE 14')==1
(private/'lz4.h').write_text(header.replace('#define LZ4_MEMORY_USAGE 14','#define LZ4_MEMORY_USAGE 12'))
lz4_sources=[root/'src/kernel-lz4/lz4_compress.c',root/'src/kernel-lz4/lz4_decompress.c']
lz4_includes=[base/'include',root/'include']
# These sources do not use any GZRAM policy definitions. Compile their identical
# PIC objects once per build, keeping link order and private symbol binding.
# The codegen audit must still prove that all preserved library .text is equal.
lz4_objects=[]
for source in lz4_sources:
 obj=a.output/('private-'+source.stem+'.o')
 compile_files([source],obj,includes=lz4_includes,shared=False);lz4_objects.append(obj)
compile_files(lz4_objects,a.output/'lz4-small.so',includes=lz4_includes,bind=True)
public_names=['encode_scalar','encode_avx2','decode_scalar','decode_avx2']
def rename(prefix):return [f'-Dgzram_{name}=gzram_{prefix}_{name}' for name in public_names]
core_objects={
 'base':['-DGZRAM_SCALAR_FAST=1',*rename('base')],
 'bitpackbase':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1',*rename('base')],
 'mixpackbase':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1','-DGZRAM_MIXED_ENCODE=1',*rename('base')],
 'select2base':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1','-DGZRAM_SELECT_PACK=2',*rename('base')],
 'select3base':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1','-DGZRAM_SELECT_PACK=3',*rename('base')],
 'select4base':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1','-DGZRAM_SELECT_PACK=4',*rename('base')],
 'block2base':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1','-DGZRAM_BLOCK_PACK_LIMIT=2',*rename('base')],
 'block3base':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1','-DGZRAM_BLOCK_PACK_LIMIT=3',*rename('base')],
 'block4base':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1','-DGZRAM_BLOCK_PACK_LIMIT=4',*rename('base')],
 'fused':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_EMBED_PREFIX=1',*rename('fused'),'-Dgzram_avx2_available=gzram_fused_avx2_available','-Dgzram_encode_hint_avx2=gzram_fused_encode_hint_avx2'],
 'mixed':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_MIXED_DECODE=1',*rename('mixed'),'-Dgzram_avx2_available=gzram_mixed_avx2_available','-Dgzram_decode_mixed=gzram_mixed_decode'],
 'ctz':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_MIXED_DECODE=1','-DGZRAM_CTZ_UNPACK=1',*rename('ctz'),'-Dgzram_avx2_available=gzram_ctz_avx2_available','-Dgzram_decode_mixed=gzram_ctz_decode'],
 'ctzfull':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_MIXED_DECODE=1','-DGZRAM_CTZ_UNPACK=1','-DGZRAM_CTZ_UNPACK_FULL=1',*rename('ctzfull'),'-Dgzram_avx2_available=gzram_ctzfull_avx2_available','-Dgzram_decode_mixed=gzram_ctzfull_decode'],
 'repeat':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_MIXED_DECODE=1','-DGZRAM_WORD_REPEAT=1',*rename('repeat'),'-Dgzram_avx2_available=gzram_repeat_avx2_available','-Dgzram_decode_mixed=gzram_repeat_decode'],
 'ctzrepeat':['-DGZRAM_SCALAR_FAST=1','-DGZRAM_MIXED_DECODE=1','-DGZRAM_WORD_REPEAT=1','-DGZRAM_CTZ_UNPACK=1',*rename('repeat'),'-Dgzram_avx2_available=gzram_repeat_avx2_available','-Dgzram_decode_mixed=gzram_repeat_decode'],
}
for cutoff in [2,3,4]:
 core_objects[f'blockdirect{cutoff}base']=['-DGZRAM_SCALAR_FAST=1','-DGZRAM_CTZ_PACK=1',f'-DGZRAM_BLOCK_PACK_LIMIT={cutoff}','-DGZRAM_BLOCK_PACK_DIRECT=1',*rename('base')]
for name,defines in core_objects.items():compile_files([root/'gzram/src/gzram.c'],a.output/f'hybrid-{name}.o',defines,[a.output],shared=False)
policies={
 'trial':[],
 'sample':['-DGZRAM_HYBRID_SAMPLE=1'],
 'recurrence':['-DGZRAM_HYBRID_SAMPLE=1','-DGZRAM_HYBRID_RECURRENCE=1'],
 'guard16':['-DGZRAM_HYBRID_GUARD=16'],
 'guard32':['-DGZRAM_HYBRID_GUARD=32'],
 'fused':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_FUSED_HINT=1'],
 'guard32mixed':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'wordguard':['-DGZRAM_HYBRID_GUARD=8'],
 'wordmixed':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'splittail':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1','-DGZRAM_HYBRID_SPLIT_TAIL=1'],
 'outlinetail':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1','-DGZRAM_HYBRID_SPLIT_TAIL=1','-DGZRAM_HYBRID_OUTLINE_WORD=1'],
 'ctzunpack':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_CTZ_DECODE=1'],
 'wordrepeat':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_REPEAT_DECODE=1'],
 'ctzrepeat':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_REPEAT_DECODE=1'],
 'bitpack':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'mixpack':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'repeatmerge':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1','-DGZRAM_HYBRID_MERGE_REPEAT=1'],
 'ctzfull':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_CTZFULL_DECODE=1'],
 'bitctz':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_CTZ_DECODE=1'],
 'bitfull':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_CTZFULL_DECODE=1'],
 'select2':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'select3':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'select4':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'repeatmergefast':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1','-DGZRAM_HYBRID_MERGE_REPEAT=1','-DGZRAM_HYBRID_MERGE_REPEAT_FAST=1'],
 'blockpick2':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'blockpick3':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'blockpick4':['-DGZRAM_HYBRID_GUARD=32','-DGZRAM_HYBRID_WORD_SCALAR=1','-DGZRAM_HYBRID_MIXED_DECODE=1'],
 'bitmerge':['-DGZRAM_HYBRID_GUARD=32', '-DGZRAM_HYBRID_WORD_SCALAR=1', '-DGZRAM_HYBRID_CTZ_DECODE=1', '-DGZRAM_HYBRID_MERGE_REPEAT=1', '-DGZRAM_HYBRID_MERGE_REPEAT_FAST=1'],
 'bitdirect':['-DGZRAM_HYBRID_GUARD=32', '-DGZRAM_HYBRID_WORD_SCALAR=1', '-DGZRAM_HYBRID_CTZ_DECODE=1', '-DGZRAM_HYBRID_MERGE_REPEAT=1', '-DGZRAM_HYBRID_MERGE_REPEAT_FAST=1', '-DGZRAM_HYBRID_DIRECT_REPEAT=1'],
}
additional={'fused':'fused','guard32mixed':'mixed','wordmixed':'mixed','splittail':'mixed','outlinetail':'mixed','ctzunpack':'ctz','wordrepeat':'repeat','ctzrepeat':'ctzrepeat','bitpack':'mixed','mixpack':'mixed','repeatmerge':'mixed','ctzfull':'ctzfull','bitctz':'ctz','bitfull':'ctzfull','select2':'mixed','select3':'mixed','select4':'mixed','repeatmergefast':'mixed','blockpick2':'mixed','blockpick3':'mixed','blockpick4':'mixed','bitmerge':'ctz','bitdirect':'ctz'}
for cutoff in [2,3,4]:
 policies[f'blockdirect{cutoff}']=list(policies['blockpick'+str(cutoff)])
 additional[f'blockdirect{cutoff}']='mixed'
for samples in [16,64]:
 policies[f'bitdirectsample{samples}']=[*policies['bitdirect'],'-DGZRAM_HYBRID_SAMPLE=1','-DGZRAM_HYBRID_SAMPLE_REPEAT=1',f'-DGZRAM_HYBRID_SAMPLE_WORDS={samples}']
 additional[f'bitdirectsample{samples}']='ctz'
for policy,defines in policies.items():
 base_object={'bitpack':'bitpackbase','mixpack':'mixpackbase','bitctz':'bitpackbase','bitfull':'bitpackbase','select2':'select2base','select3':'select3base','select4':'select4base','blockpick2':'block2base','blockpick3':'block3base','blockpick4':'block4base','bitmerge':'bitpackbase','bitdirect':'bitpackbase'}.get(policy,'base')
 if policy.startswith('blockdirect'):base_object=policy+'base'
 if policy.startswith('bitdirectsample'):base_object='bitpackbase'
 sources=[root/'gzram/src/hybrid.c',a.output/f'hybrid-{base_object}.o']
 if policy in additional:sources.append(a.output/f'hybrid-{additional[policy]}.o')
 compile_files([*sources,*lz4_objects],a.output/f'libgzram-hybrid-{policy}.so',defines,[*lz4_includes,root/'gzram/src'],bind=True)
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
source_files=[root/'gzram/src/gzram.c',root/'gzram/src/gzram.h',root/'gzram/src/hybrid.c',Path(__file__).resolve(),*lz4_sources,root/'src/kernel-lz4/lz4defs.h',root/'include/linux/lz4.h']
manifest={
 'hybrid_candidates':list(policies),'period_filter_candidate':True,'variable_period_candidate':True,'block_unpack_candidate':True,'fast_scalar_candidate':True,
 'candidate_extra_flags':{'base_variants':base_variants,'core_objects':core_objects,'hybrid_policies':policies},
 'compiler':subprocess.check_output([cc,'--version'],text=True).splitlines()[0],'flags':flags+extra,
 'lz4_pic_objects_reused':True,
 'source_sha256':{str(f.relative_to(root)):sha(f) for f in source_files},
 'generated_tables_sha256':sha(a.output/'tables.h'),
 'artifacts':{f.name:sha(f) for f in a.output.glob('*.so')},
}
(a.output/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n');print(a.output)
