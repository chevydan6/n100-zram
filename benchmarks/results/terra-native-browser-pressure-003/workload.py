#!/usr/bin/env python3
"""Bounded synthetic working set plus repeated compiler launch under a cgroup."""
import json, mmap, os, pathlib, subprocess, tempfile, time, resource
base=pathlib.Path('/home/dan/n100-zram/build/astra-zram-corpora-001')
names=['bash-elf','libc-elf','sparse-words','repeat8','period127','mixed-pages','clusters50','random']
data=[(base/(n+'.bin')).read_bytes() for n in names]
size=128*1024*1024
start=time.monotonic(); cpu=time.process_time_ns(); durations=[]; checks=0; browser_ns=[]
with mmap.mmap(-1,size) as memory:
    for offset in range(0,size,512*1024): memory[offset:offset+512*1024]=data[(offset//(512*1024))%len(data)]
    for phase in range(2):
        t=time.monotonic_ns()
        for page in range(0,size//4096,37):
            pos=page*4096; corpus=(pos//(512*1024))%len(data); within=pos%(512*1024)
            if memory[pos:pos+32] != data[corpus][within:within+32]: raise RuntimeError('working set mismatch')
            checks+=1
        durations.append(time.monotonic_ns()-t)
        t=time.monotonic_ns()
        subprocess.run(['/usr/bin/gcc','-fsyntax-only','/home/dan/n100-zram/gzram/tests/zram-roundtrip.c'],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.PIPE,timeout=30)
        durations.append(time.monotonic_ns()-t)
        with tempfile.TemporaryDirectory(prefix='gzram-pressure-browser-') as tmp:
            page=pathlib.Path(tmp)/'page.html'
            page.write_text('<!doctype html><title>Pressure test</title><div id="content"></div><script>for(let i=0;i<1000;i++){let p=document.createElement("p");p.textContent="Local generated page "+i;document.getElementById("content").appendChild(p)}document.title="GZRAM_READY"</script>')
            cmd=['/usr/bin/chromium-browser','--headless','--disable-gpu','--no-first-run','--no-default-browser-check','--disable-background-networking','--disable-breakpad','--host-resolver-rules=MAP * ~NOTFOUND','--user-data-dir='+tmp+'/profile','--dump-dom',page.as_uri()]
            t=time.monotonic_ns()
            with (pathlib.Path(tmp)/'output').open('w+') as output, (pathlib.Path(tmp)/'error').open('w+') as error:
                try:
                    browser=subprocess.run(cmd,stdout=output,stderr=error,text=True,timeout=25,check=True)
                except (subprocess.TimeoutExpired, subprocess.CalledProcessError) as failure:
                    error.seek(0); raise RuntimeError('Chromium launch failed; diagnostic tail: '+error.read()[-2000:]) from failure
                browser_ns.append(time.monotonic_ns()-t); output.seek(0)
                if 'GZRAM_READY' not in output.read(): raise RuntimeError('browser output missing completion marker')
u=resource.getrusage(resource.RUSAGE_SELF); c=resource.getrusage(resource.RUSAGE_CHILDREN)
print(json.dumps({'elapsed_s':time.monotonic()-start,'self_cpu_ns':time.process_time_ns()-cpu,'checks':checks,'phase_ns':durations,'browser_ns':browser_ns,'minor_faults':u.ru_minflt+c.ru_minflt,'major_faults':u.ru_majflt+c.ru_majflt}))
