import fcntl,hashlib,json,os,pathlib,shutil,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);out=r/'build/terra-simd-device-path-001';out.mkdir();target=out/'module';status=out/'status.json';sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
def run(name,cmd,timeout=1200):
 with (out/(name+'.log')).open('w') as f:subprocess.run(cmd,cwd=r,stdout=f,stderr=subprocess.STDOUT,check=True,timeout=timeout)
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);save('building instrumented guest-only module')
  src=r/'build/terra-coexist-zram-001';original=src/'n100_zram.ko';expected=json.loads((r/'build/terra-coexist-gate-001/build-result.json').read_text())['module_sha256'];assert sha(original)==expected
  shutil.copytree(src,target,symlinks=True);f=target/'simd/dispatch.c';s=f.read_text();assert s.count('if(!n||!usable())return n100_ghy_encode(src,n,dst,cap,log,work,work_bytes);')==1
  s=s.replace('#include <linux/types.h>','#include <linux/types.h>\n#include <linux/printk.h>',1).replace('if(!n||!usable())return n100_ghy_encode(src,n,dst,cap,log,work,work_bytes);','if(!n||!usable()){pr_info_once("N100_DEVICE_SCALAR_ENCODE\\n");return n100_ghy_encode(src,n,dst,cap,log,work,work_bytes);}')
  s=s.replace('end_vector();\n return got?got:n100_lz4_fallback', 'end_vector();\n pr_info_once("N100_DEVICE_VECTOR_ENCODE\\n");\n return got?got:n100_lz4_fallback',1)
  s=s.replace('if(src[6]!=1||!usable())return n100_ghy_decode(src,size,dst,cap);','if(src[6]!=1||!usable()){if(src[6]==1)pr_info_once("N100_DEVICE_SCALAR_DECODE\\n");return n100_ghy_decode(src,size,dst,cap);}')
  s=s.replace('end_vector();\n return got==(int)n?got:-1;', 'end_vector();\n pr_info_once("N100_DEVICE_VECTOR_DECODE\\n");\n return got==(int)n?got:-1;',1);f.write_text(s)
  run('build',['make','-j1','-C',str(r/'build/astra-vm/root/usr/src/kernels/7.2.11-200.fc44.x86_64'),'M='+str(target),'CONFIG_ZRAM_BACKEND_GHY_BITDIRECT=y','modules']);assert sha(original)==expected
  (out/'build.json').write_text(json.dumps(dict(source_module_sha256=expected,instrumented_module_sha256=sha(target/'n100_zram.ko'),dispatch_sha256=sha(f),scope='Guest-only branch evidence; instrumentation changes timing'),indent=2)+'\n')
 vm=r/'build/astra-vm/root';stock=pathlib.Path(subprocess.check_output(['modinfo','-n','zram'],text=True).strip());results={}
 for avx in (False,True):
  name='avx2' if avx else 'fallback';dest=out/('vm-'+name);cmd=['python3','gzram/tools/vm-coexist-zram.py','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module',str(target/'n100_zram.ko'),'--stock-module',str(stock),'--client',str(r/'build/terra-coexist-gate-001/client'),'--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(dest),'--algorithms','ghy-bitdirect','ghy-simd','lz4-ghy','lz4','zstd']
  if avx:cmd.append('--guest-avx2')
  save('running instrumented diskless correctness guest',guest=name,completed=results);run(name,cmd,600)
  guest=json.loads((dest/'result.json').read_text());assert guest['status']=='passed';console=(dest/'console.log').read_text(errors='replace');markers={k:console.count(k) for k in ('N100_DEVICE_SCALAR_ENCODE','N100_DEVICE_SCALAR_DECODE','N100_DEVICE_VECTOR_ENCODE','N100_DEVICE_VECTOR_DECODE')}
  expected_markers=('N100_DEVICE_VECTOR_ENCODE','N100_DEVICE_VECTOR_DECODE') if avx else ('N100_DEVICE_SCALAR_ENCODE','N100_DEVICE_SCALAR_DECODE');assert all(markers[k]>0 for k in expected_markers),(name,markers);assert avx or not markers['N100_DEVICE_VECTOR_ENCODE'] and not markers['N100_DEVICE_VECTOR_DECODE'];results[name]=dict(markers=markers,guest=guest)
 save('passed; guest-only instrumented evidence, no native timing or recovery claim',results=results)
except BaseException as e:save('failed or deferred; preserve artifacts',error=repr(e));raise
