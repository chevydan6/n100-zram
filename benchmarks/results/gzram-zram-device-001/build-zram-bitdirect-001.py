import hashlib,json,pathlib,re,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');out=root/'build/astra-zram-bitdirect-build-001';out.mkdir();steps=[]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(label,command,expected=0):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:r=subprocess.run(command,cwd=root,stdout=log,stderr=subprocess.STDOUT,timeout=600)
 steps.append(dict(label=label,command=command,status=r.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert r.returncode==expected,label
source_files=['gzram/tools/prepare-zram-backend.py','gzram/kernel/backend-ghy-bitdirect.c','gzram/kernel/backend-lz4-ghy.c','gzram/tests/zram-roundtrip.c']
hashes={name:sha(root/name) for name in source_files}
try:
 target=root/'build/astra-zram-bitdirect-001';kernel=root/'build/astra-vm/root/usr/src/kernels/7.2.11-200.fc44.x86_64'
 run('prepare',['python3','gzram/tools/prepare-zram-backend.py','--reference','build/astra-zram-reference-001/zram','--port','build/astra-bitdirect-port-001/bitdirect','--validation','build/astra-bitdirect-port-001/result.json','--source-record','build/astra-zram-reference-001/result.json','--output',str(target)])
 run('build',['make','-j1','-C',str(kernel),'M='+str(target),'CONFIG_ZRAM_BACKEND_GHY_BITDIRECT=y','modules'])
 module=target/'zram.ko';vermagic=subprocess.check_output(['modinfo','-F','vermagic',str(module)],text=True).strip();assert vermagic.split()[0]=='7.2.11-200.fc44.x86_64'
 for obj in ['backend_ghy_bitdirect.o','backend_lz4_ghy.o','ghy/encoder/core.o','ghy/decoder/core.o','ghy/hybrid.o','ghy/lz4_compress.o','ghy/lz4_decompress.o']:
  asm=subprocess.check_output(['objdump','-d',str(target/obj)],text=True);assert not re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm),obj
  (out/(obj.replace('/','_')+'.asm')).write_text(asm)
 client=out/'zram-roundtrip';runtime=root/'build/astra-vm/root/usr/lib64'
 run('client-build',['gcc','-O2','-g','-Wall','-Wextra','-Werror','-static','-fno-tree-vectorize','-pthread','-B'+str(runtime),'-L'+str(runtime),'gzram/tests/zram-roundtrip.c','-o',str(client)])
 run('client-host-refusal',[str(client),'/dev/zram0','not-opened.bin'],3)
 assert hashes=={name:sha(root/name) for name in source_files}
 record=dict(status='built; guest testing pending',scope='Default-off scalar bitdirect and matched private LZ4 ZRAM adapters; no SIMD, combined-codec kernel claim or host loading',source_hashes=hashes,source_reference_sha256=sha(root/'build/astra-zram-reference-001/result.json'),module_sha256=sha(module),vermagic=vermagic,client_sha256=sha(client),steps=steps,stack_usage={str(p.relative_to(target)):p.read_text().splitlines() for p in target.rglob('*.su')},kernel_config_sha256=sha(kernel/'.config'))
 (out/'result.json').write_text(json.dumps(record,indent=2)+'\n')
except BaseException as error:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(error),steps=steps,source_hashes=hashes),indent=2)+'\n');raise
