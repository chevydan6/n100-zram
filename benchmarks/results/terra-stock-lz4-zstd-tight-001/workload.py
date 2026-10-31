#!/usr/bin/env python3
"""Two persistent disposable browser pages, compiler and bounded working set."""
import base64,hashlib,json,mmap,os,pathlib,socket,struct,subprocess,tempfile,threading,time,urllib.request
from urllib.parse import urlsplit
base=pathlib.Path('/home/dan/n100-zram/build/astra-zram-corpora-001')
names=['bash-elf','libc-elf','sparse-words','repeat8','period127','mixed-pages','clusters50','random']
data=[(base/(n+'.bin')).read_bytes() for n in names];size=96*1024*1024
class WS:
 def __init__(self,url):
  u=urlsplit(url);self.s=socket.create_connection((u.hostname,u.port),timeout=10);self.s.settimeout(15)
  key=base64.b64encode(os.urandom(16)).decode();request=f'GET {u.path} HTTP/1.1\r\nHost: {u.netloc}\r\nUpgrade: websocket\r\nConnection: Upgrade\r\nSec-WebSocket-Key: {key}\r\nSec-WebSocket-Version: 13\r\nOrigin: http://127.0.0.1\r\n\r\n';self.s.sendall(request.encode());resp=b''
  while b'\r\n\r\n' not in resp:resp+=self.s.recv(1)
  expected=base64.b64encode(hashlib.sha1((key+'258EAFA5-E914-47DA-95CA-C5AB0DC85B11').encode()).digest())
  if b' 101 ' not in resp or expected.lower() not in resp.lower():raise RuntimeError('websocket handshake failed')
 def exact(self,n):
  out=b''
  while len(out)<n:
   chunk=self.s.recv(n-len(out))
   if not chunk:raise RuntimeError('browser websocket closed')
   out+=chunk
  return out
 def call(self,ident):
  b=json.dumps({'id':ident,'method':'Runtime.evaluate','params':{'expression':'document.body.dataset.pulse=String((Number(document.body.dataset.pulse)||0)+1); document.title','returnByValue':True}}).encode(); mask=os.urandom(4);n=len(b)
  hdr=bytes([0x81,0x80|n]) if n<126 else bytes([0x81,0x80|126])+struct.pack('!H',n)
  self.s.sendall(hdr+mask+bytes(x^mask[i%4] for i,x in enumerate(b)))
  while True:
   h=self.exact(2); length=h[1]&127
   if length==126:length=struct.unpack('!H',self.exact(2))[0]
   elif length==127:length=struct.unpack('!Q',self.exact(8))[0]
   if length>2_000_000:raise RuntimeError('oversized browser response')
   payload=self.exact(length); opcode=h[0]&15
   if opcode==8:raise RuntimeError('browser closed connection')
   if opcode!=1:continue
   o=json.loads(payload)
   if o.get('id')==ident:
    if 'error' in o or o.get('result',{}).get('result',{}).get('value')!='GZRAM_READY':raise RuntimeError('browser response mismatch')
    return
 def close(self):self.s.close()
start=time.monotonic(); procs=[];sockets=[];logs=[]; checks=0; compile_ns=[]; interaction_ns=[]
with mmap.mmap(-1,size) as memory,tempfile.TemporaryDirectory(prefix='gzram-persistent-') as tmp:
 try:
  for offset in range(0,size,512*1024):memory[offset:offset+512*1024]=data[(offset//(512*1024))%len(data)]
  for index in range(2):
   page=pathlib.Path(tmp)/f'page-{index}.html';profile=pathlib.Path(tmp)/f'profile-{index}';profile.mkdir()
   page.write_text('<!doctype html><title>GZRAM_READY</title><body><div id="content"></div><script>window.keep=new Uint8Array(12*1024*1024);for(let i=0;i<window.keep.length;i+=4096)window.keep[i]=i%251;for(let i=0;i<3000;i++){let p=document.createElement("p");p.textContent="Generated local page "+i;document.getElementById("content").appendChild(p)}</script></body>')
   log=(pathlib.Path(tmp)/f'error-{index}').open('w+');logs.append(log)
   cmd=['/usr/bin/chromium-browser','--headless','--disable-gpu','--no-first-run','--no-default-browser-check','--disable-background-networking','--disable-breakpad','--host-resolver-rules=MAP * ~NOTFOUND','--remote-debugging-port=0','--remote-allow-origins=http://127.0.0.1','--user-data-dir='+str(profile),page.as_uri()]
   proc=subprocess.Popen(cmd,stdout=subprocess.DEVNULL,stderr=log);procs.append(proc)
   deadline=time.monotonic()+30;portfile=profile/'DevToolsActivePort'
   while not portfile.exists():
    if proc.poll() is not None or time.monotonic()>deadline:raise RuntimeError('browser startup failed')
    time.sleep(.1)
   port=int(portfile.read_text().splitlines()[0]); targets=json.load(urllib.request.urlopen(f'http://127.0.0.1:{port}/json',timeout=10));pages=[x for x in targets if x.get('type')=='page' and x.get('url','').startswith('file:')]
   if not pages:raise RuntimeError('browser page not found')
   ws=WS(pages[0]['webSocketDebuggerUrl']);sockets.append(ws)
  for cycle in range(6):
   t=time.monotonic_ns();subprocess.run(['/usr/bin/gcc','-O2','-c','/home/dan/n100-zram/gzram/tests/zram-roundtrip.c','-o',tmp+f'/compile-{cycle}.o'],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.PIPE,timeout=30);compile_ns.append(time.monotonic_ns()-t)
   for page in range(cycle,size//4096,37):
    pos=page*4096; source=(pos//(512*1024))%len(data);within=pos%(512*1024)
    if memory[pos:pos+32]!=data[source][within:within+32]:raise RuntimeError('working set mismatch')
    checks+=1
   for i,ws in enumerate(sockets):
    t=time.monotonic_ns();ws.call(cycle*2+i+1);interaction_ns.append(time.monotonic_ns()-t)
   time.sleep(2)
 finally:
  for ws in sockets:ws.close()
  for proc in procs:
   if proc.poll() is None:proc.terminate()
  for proc in procs:
   try:proc.wait(timeout=5)
   except subprocess.TimeoutExpired:proc.kill();proc.wait()
  for f in logs:f.close()
print(json.dumps({'elapsed_s':time.monotonic()-start,'checks':checks,'compile_ns':compile_ns,'interaction_ns':interaction_ns}))
