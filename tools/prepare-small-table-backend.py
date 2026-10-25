#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Create a default-off scalar ZRAM compressor in a fresh isolated source tree."""
import argparse,difflib,hashlib,json,re,shutil
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--control',action='store_true');p.add_argument('--reference',type=Path,required=True);p.add_argument('--lz4-header',type=Path,required=True);p.add_argument('--bits',type=int,choices=[11,12,13,14],default=12);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert not a.output.exists() and a.reference.resolve() not in a.output.resolve().parents
out=a.output;out.mkdir(parents=True)
def mapped(text):
 if not a.control:return text
 return text.replace('n100s_', 'n100c_').replace('backend_lz4_small','backend_lz4_control').replace('ZRAM_BACKEND_LZ4_SMALL','ZRAM_BACKEND_LZ4_CONTROL').replace('lz4-small','lz4-control')
def write_new(name,text):(out/mapped(name)).write_text(mapped(text))
for f in a.reference.iterdir():
 if f.is_file() and (f.suffix in ['.c','.h'] or f.name in ['Makefile','Kconfig']) and not f.name.endswith('.mod.c'):shutil.copy2(f,out/f.name)
# Older single-clone trees did not need to rename this unexported global.
# Repair that namespace before linking a second clone; codec logic is unchanged.
if a.control:
 existing=out/'n100s_rename.h'
 if existing.exists() and '#define LZ4_resetStream ' not in existing.read_text():
  existing.write_text(existing.read_text()+'#define LZ4_resetStream n100s_LZ4_resetStream\n')
 assert not (out/'backend_lz4_control.c').exists(),'Control already exists in reference'
def change(name,old,new):
 f=out/name;s=f.read_text();assert s.count(old)==1,(name,old);f.write_text(s.replace(old,mapped(new)))
change('Kconfig','config ZRAM_BACKEND_LZ4HC','''config ZRAM_BACKEND_LZ4_SMALL
	bool "Experimental scalar LZ4 with private small hash table"
	depends on ZRAM && X86_64
	select ZRAM_BACKEND_LZ4
	help
	  Default-off research backend. Scalar compression with a smaller hash
	  array; standard LZ4 decoding and dictionary fallback. No kernel SIMD.

config ZRAM_BACKEND_LZ4HC''')
change('zcomp.c','#include "backend_lz4.h"','#include "backend_lz4.h"\n#include "backend_lz4_small.h"')
change('zcomp.c','static const struct zcomp_ops *backends[] = {','''static const struct zcomp_ops *backends[] = {
#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4_SMALL)
	&backend_lz4_small,
#endif''')
with (out/'Makefile').open('a') as f:f.write(mapped('''
# Keep the normal kernel no-SIMD flags. The private table ABI never escapes.
zram-$(CONFIG_ZRAM_BACKEND_LZ4_SMALL) += backend_lz4_small.o n100s_lz4_compress.o
CFLAGS_n100s_lz4_compress.o += -O3 -fno-tree-vectorize -include $(src)/n100s_rename.h
'''))
s=(a.reference/'backend_lz4.c').read_text();s=s.replace('#include "backend_lz4.h"','''#include "backend_lz4_small.h"
extern unsigned long n100s_worksize(void);
extern int n100s_LZ4_compress_fast(const char *, char *, int, int, int, void *);''')
s=s.replace('vmalloc(LZ4_MEM_COMPRESS)','vmalloc(n100s_worksize())').replace('ret = LZ4_compress_fast(req->src','ret = n100s_LZ4_compress_fast(req->src').replace('backend_lz4 =','backend_lz4_small =').replace('"lz4",','"lz4-small",')
write_new('backend_lz4_small.c',s);write_new('backend_lz4_small.h','// SPDX-License-Identifier: GPL-2.0-only\n#include "zcomp.h"\nextern const struct zcomp_ops backend_lz4_small;\n')
s=(root/'src/kernel-lz4/lz4_compress.c').read_text();symbols=sorted(set(re.findall(r'EXPORT_SYMBOL\((\w+)\)',s)+re.findall(r'^(?:int|void|size_t)\s+(LZ4_\w+)\s*\(',s,re.M)))
s=re.sub(r'EXPORT_SYMBOL\([^\n]+\);','',s);s=re.sub(r'MODULE_(?:LICENSE|DESCRIPTION|AUTHOR)\([^\n]*\);','',s)
s=s.replace('#include "lz4defs.h"','#include "n100s_lz4defs.h"')+'\nunsigned long n100s_worksize(void);\nunsigned long n100s_worksize(void) { return sizeof(LZ4_stream_t); }\n'
write_new('n100s_lz4_compress.c',s);write_new('n100s_rename.h',''.join(f'#define {name} n100s_{name}\n' for name in symbols))
s=(root/'src/kernel-lz4/lz4defs.h').read_text().replace('#include <linux/lz4.h>','#include "n100s_lz4.h"');write_new('n100s_lz4defs.h',s)
s=a.lz4_header.read_text();s,count=re.subn(r'(#define LZ4_MEMORY_USAGE\s+)14\b',lambda m:m[1]+str(a.bits),s);assert count==1
write_new('n100s_lz4.h',s)
# No private LZ4 types are included by backend_lz4_small.c: its stock dictionary
# state remains allocated/reset by the original public kernel ABI.
patch=[]
for f in sorted(out.iterdir()):
 if not f.is_file():continue
 before=a.reference/f.name;old=before.read_text() if before.exists() else '';new=f.read_text()
 if old!=new:patch.extend(difflib.unified_diff(old.splitlines(True),new.splitlines(True),fromfile='a/drivers/block/zram/'+f.name if before.exists() else '/dev/null',tofile='b/drivers/block/zram/'+f.name))
(out/'scalar-small.patch').write_text(''.join(patch))
(out/'EXPERIMENT.json').write_text(json.dumps({'backend':mapped('lz4-small'),'hash_bits':a.bits,'hash_bytes':1<<a.bits,'optimization':'O3, kernel no-SIMD flags','reference_header_sha256':hashlib.sha256(a.lz4_header.read_bytes()).hexdigest(),'files':{f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in out.iterdir() if f.is_file()}},indent=2)+'\n');print(out)
