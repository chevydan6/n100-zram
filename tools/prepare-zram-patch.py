#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Create an isolated optional backend and patch; never edit the reference tree."""
from pathlib import Path
import argparse,shutil,difflib
root=Path(__file__).resolve().parents[1]
a=argparse.ArgumentParser();a.add_argument('--reference',type=Path,required=True);a.add_argument('--output',type=Path,required=True);args=a.parse_args()
reference=args.reference.resolve();dest=args.output.resolve()
if dest==reference or reference in dest.parents:raise SystemExit('Output must be outside the reference source tree')
if dest.exists():raise SystemExit('Output already exists; choose a fresh isolated output')
dest.mkdir(parents=True)
for source in reference.iterdir():
 if source.is_file() and (source.suffix in {'.c','.h'} or source.name in {'Makefile','Kconfig'}):
  shutil.copy2(source,dest/source.name)
def change(name,old,new):
 p=dest/name;text=p.read_text();assert old in text,(name,old);p.write_text(text.replace(old,new,1))
change('Kconfig','config ZRAM_BACKEND_LZ4HC','''config ZRAM_BACKEND_LZ4_N100
	bool "Experimental Intel N100 AVX2 LZ4 backend"
	depends on ZRAM && X86_64
	select ZRAM_BACKEND_LZ4
	help
	  Optional experimental lz4-n100 backend with runtime AVX2 detection
	  and scalar fallback. Keep the default compressor unchanged. Native
	  stability and end-to-end performance remain to be established.

config ZRAM_BACKEND_LZ4HC''')
with (dest/'Makefile').open('a') as f:f.write('''
# The dispatch and all existing ZRAM code retain the normal no-SIMD flags.
zram-$(CONFIG_ZRAM_BACKEND_LZ4_N100) += backend_lz4_n100.o n100_dispatch.o n100_lz4_compress.o n100_lz4_decompress.o
CFLAGS_n100_lz4_compress.o += -O3 -mavx2 -fno-tree-vectorize -include $(src)/n100_rename.h
CFLAGS_n100_lz4_decompress.o += -O3 -mavx2 -fno-tree-vectorize -include $(src)/n100_rename.h
''')
change('zcomp.c','#include "backend_lz4.h"','#include "backend_lz4.h"\n#include "backend_lz4_n100.h"')
change('zcomp.c','static const struct zcomp_ops *backends[] = {','''static const struct zcomp_ops *backends[] = {
#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4_N100)
	&backend_lz4_n100,
#endif''')
backend=(reference/'backend_lz4.c').read_text()
backend='// SPDX-License-Identifier: GPL-2.0-only\n'+backend
backend=backend.replace('#include "backend_lz4.h"','#include "backend_lz4_n100.h"\n#include "dispatch.h"')
backend=backend.replace('ret = LZ4_compress_fast(req->src, req->dst, req->src_len,','''if (params->level == LZ4_ACCELERATION_DEFAULT)
			ret = n100_lz4_compress(req->src, req->dst,
					req->src_len, req->dst_len, zctx->mem);
		else
			ret = LZ4_compress_fast(req->src, req->dst, req->src_len,''')
backend=backend.replace('ret = LZ4_decompress_safe(req->src, req->dst, req->src_len,','ret = n100_lz4_decompress(req->src, req->dst, req->src_len,')
backend=backend.replace('backend_lz4 =','backend_lz4_n100 =').replace('"lz4",','"lz4-n100",')
(dest/'backend_lz4_n100.c').write_text(backend)
(dest/'backend_lz4_n100.h').write_text('// SPDX-License-Identifier: GPL-2.0-only\n#include "zcomp.h"\nextern const struct zcomp_ops backend_lz4_n100;\n')
for src,target in [('dispatch.c','n100_dispatch.c'),('dispatch.h','dispatch.h'),('rename.h','n100_rename.h'),('lz4defs.h','n100_lz4defs.h'),('lz4_compress.c','n100_lz4_compress.c'),('lz4_decompress.c','n100_lz4_decompress.c')]:
 text=(root/'build/kernel'/src).read_text().replace('#include "lz4defs.h"','#include "n100_lz4defs.h"')
 (dest/target).write_text(text)
patch=[]
for name in sorted({p.name for p in dest.iterdir() if p.is_file()}):
 old=(reference/name).read_text() if (reference/name).exists() else ''
 new=(dest/name).read_text()
 if old!=new:patch.extend(difflib.unified_diff(old.splitlines(True),new.splitlines(True),fromfile='a/drivers/block/zram/'+name if old else '/dev/null',tofile='b/drivers/block/zram/'+name))
patchfile=root/'patches/0001-experimental-lz4-n100-backend.patch';patchfile.write_text(''.join(patch))
print(dest);print(patchfile)
