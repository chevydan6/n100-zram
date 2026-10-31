#!/usr/bin/env python3
"""Concurrent disposable local browser pages and compilation in bounded cgroup."""
import concurrent.futures, json, mmap, pathlib, resource, subprocess, tempfile, time
base=pathlib.Path('/home/dan/n100-zram/build/astra-zram-corpora-001')
names=['bash-elf','libc-elf','sparse-words','repeat8','period127','mixed-pages','clusters50','random']
data=[(base/(n+'.bin')).read_bytes() for n in names]; size=128*1024*1024
start=time.monotonic(); cpu=time.process_time_ns(); checks=0; browsers=[]; compiles=[]; reads=[]
with mmap.mmap(-1,size) as memory, tempfile.TemporaryDirectory(prefix='gzram-multitask-') as tmp:
 for offset in range(0,size,512*1024):memory[offset:offset+512*1024]=data[(offset//(512*1024))%len(data)]
 for batch in range(4):
  children=[]; files=[]; pool=concurrent.futures.ThreadPoolExecutor(max_workers=2)
  try:
   for page in range(2):
    dest=pathlib.Path(tmp)/f'page-{batch}-{page}.html'
    dest.write_text('<!doctype html><title>Pressure test</title><div id="content"></div><script>for(let i=0;i<2000;i++){let p=document.createElement("p");p.textContent="Local generated page "+i;document.getElementById("content").appendChild(p)}document.title="GZRAM_READY"</script>')
    output=(pathlib.Path(tmp)/f'out-{batch}-{page}').open('w+');error=(pathlib.Path(tmp)/f'err-{batch}-{page}').open('w+');files.extend([output,error])
    cmd=['/usr/bin/chromium-browser','--headless','--disable-gpu','--no-first-run','--no-default-browser-check','--disable-background-networking','--disable-breakpad','--host-resolver-rules=MAP * ~NOTFOUND','--user-data-dir='+tmp+f'/profile-{batch}-{page}','--dump-dom',dest.as_uri()]
    t=time.monotonic_ns(); proc=subprocess.Popen(cmd,stdout=output,stderr=error,text=True); future=pool.submit(lambda child: (child.wait(),time.monotonic_ns()),proc);children.append((proc,t,output,error,future))
   t=time.monotonic_ns()
   subprocess.run(['/usr/bin/gcc','-fsyntax-only','/home/dan/n100-zram/gzram/tests/zram-roundtrip.c'],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.PIPE,timeout=30)
   compiles.append(time.monotonic_ns()-t)
   t=time.monotonic_ns()
   for page in range(batch,size//4096,37):
    pos=page*4096; corpus=(pos//(512*1024))%len(data); within=pos%(512*1024)
    if memory[pos:pos+32]!=data[corpus][within:within+32]:raise RuntimeError('working set mismatch')
    checks+=1
   reads.append(time.monotonic_ns()-t)
   for proc,t,output,error,future in children:
    try: rc,finished=future.result(timeout=45)
    except concurrent.futures.TimeoutError:
     proc.kill();proc.wait();error.seek(0);raise RuntimeError('browser timeout: '+error.read()[-1500:])
    browsers.append(finished-t);output.seek(0)
    if rc or 'GZRAM_READY' not in output.read():error.seek(0);raise RuntimeError('browser failed: '+error.read()[-1500:])
  finally:
   for proc,_,_,_,_ in children:
    if proc.poll() is None: proc.kill();proc.wait()
   pool.shutdown(wait=True)
   for f in files:f.close()
u=resource.getrusage(resource.RUSAGE_SELF); c=resource.getrusage(resource.RUSAGE_CHILDREN)
print(json.dumps({'elapsed_s':time.monotonic()-start,'self_cpu_ns':time.process_time_ns()-cpu,'checks':checks,'browser_ns':browsers,'compile_ns':compiles,'read_ns':reads,'minor_faults':u.ru_minflt+c.ru_minflt,'major_faults':u.ru_majflt+c.ru_majflt}))
