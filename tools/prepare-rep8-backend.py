#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Add a separate scalar lz4-rep8 backend to an isolated experimental ZRAM tree."""
import argparse,hashlib,json,shutil
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--optimization',choices=['O2','O3'],default='O3');p.add_argument('--kernel-source',type=Path);p.add_argument('--decoder',choices=['scalar-rep8','scalar-matchrep8','scalar-selectrep8','scalar-branchrep8'],default='scalar-rep8');p.add_argument('--source',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert a.source.resolve()!=a.output.resolve() and not a.output.exists()
a.output.mkdir(parents=True)
for src in a.source.iterdir():
 if src.is_file() and (src.suffix in {'.c','.h'} or src.name in {'Makefile','Kconfig'}) and not src.name.endswith('.mod.c'):shutil.copy2(src,a.output/src.name)
def change(name,old,new):
 f=a.output/name;t=f.read_text();assert old in t;f.write_text(t.replace(old,new,1))
change('Kconfig','config ZRAM_BACKEND_LZ4HC','''config ZRAM_BACKEND_LZ4_REP8
	bool "Experimental long-period LZ4 repeated stores"
	depends on ZRAM && X86_64
	select ZRAM_BACKEND_LZ4
	help
	  Optional scalar LZ4 decoder using integer repeated stores for long
	  eight-byte overlapping copies. No SIMD or FPU state changes.

config ZRAM_BACKEND_LZ4HC''')
change('zcomp.c','#include "backend_lz4.h"','#include "backend_lz4.h"\n#include "backend_lz4_rep8.h"')
change('zcomp.c','static const struct zcomp_ops *backends[] = {','''static const struct zcomp_ops *backends[] = {
#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4_REP8)
	&backend_lz4_rep8,
#endif''')
with (a.output/'Makefile').open('a') as f:f.write('''
# Integer-only decoder; retains the kernel no-SIMD flags.
zram-$(CONFIG_ZRAM_BACKEND_LZ4_REP8) += backend_lz4_rep8.o n100r_lz4_decompress.o
CFLAGS_n100r_lz4_decompress.o += N100_SCALAR_OPT -fno-tree-vectorize -include $(src)/n100r_rename.h
''')
make=a.output/'Makefile';make.write_text(make.read_text().replace('N100_SCALAR_OPT','-'+a.optimization))
backend=(a.source/'backend_lz4.c').read_text()
backend=backend.replace('backend_lz4 =','backend_lz4_rep8 =').replace('"lz4",','"lz4-rep8",').replace('LZ4_decompress_safe(','n100r_LZ4_decompress_safe(')
backend=backend.replace('#include "backend_lz4.h"','#include "backend_lz4_rep8.h"\nextern int n100r_LZ4_decompress_safe(const char *, char *, int, int);')
if a.decoder=='scalar-selectrep8':
 backend=backend.replace('n100r_LZ4_decompress_safe(req->src','n100_select_decompress(req->src')
 marker='#include "backend_lz4_rep8.h"'
 helper="""
#include "select.h"
extern int n100r_LZ4_decompress_safe(const char *, char *, int, int);
static int n100_select_decompress(const char *src,char *dst,int size,int capacity)
{
 if (capacity == 4096 && n100_first_long_period(src,size))
  return n100r_LZ4_decompress_safe(src,dst,size,capacity);
 return LZ4_decompress_safe(src,dst,size,capacity);
}
"""
 backend=backend.replace(marker,marker+helper)
 shutil.copy2(root/'kernel/select.h',a.output/'select.h')
(a.output/'backend_lz4_rep8.c').write_text(backend)
(a.output/'backend_lz4_rep8.h').write_text('// SPDX-License-Identifier: GPL-2.0-only\n#include "zcomp.h"\nextern const struct zcomp_ops backend_lz4_rep8;\n')
for src,dest in [('lz4_decompress.c','n100r_lz4_decompress.c'),('lz4defs.h','n100r_lz4defs.h'),('rename.h','n100r_rename.h')]:
 text=((a.kernel_source or root/'build'/('kernel-'+a.decoder))/src).read_text().replace('n100v_','n100r_').replace('#include "lz4defs.h"','#include "n100r_lz4defs.h"')
 (a.output/dest).write_text(text)
(a.output/'EXPERIMENT.json').write_text(json.dumps({'decoder':a.decoder,'optimization':a.optimization,'files':{f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in a.output.iterdir() if f.is_file()}},indent=2)+'\n')
print(a.output)
