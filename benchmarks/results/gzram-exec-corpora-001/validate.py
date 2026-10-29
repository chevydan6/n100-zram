import hashlib,json,pathlib,runpy,struct,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');out=root/'build/astra-exec-corpora-validation-001';out.mkdir();start=time.time()
try:
 script=root/'gzram/tools/make-exec-corpora.py';source_sha=hashlib.sha256(script.read_bytes()).hexdigest()
 module=runpy.run_path(str(script));parse=module['executable_offsets'];header=module['HEADER'];program=module['PROGRAM']
 data=bytearray((i*37)%256 for i in range(16384));ident=b'\x7fELF\x02\x01\x01'+bytes(9)
 h=[ident,3,62,1,0,64,0,0,64,56,1,0,0,0]
 segment=[1,5,4099,0x401003,0,5000,5000,4096]
 def make(hh=h,ss=segment):
  result=bytearray(data);header.pack_into(result,0,*hh);program.pack_into(result,64,*ss);return bytes(result)
 assert parse(make())[0]==[4096,8192]
 invalid=[b'',make()[:63]]
 for index,value in [(0,b'\x7fELF\x02\x02\x01'+bytes(9)),(1,1),(2,183),(3,0),(5,16380),(8,63),(9,55),(10,0),(10,1025)]:
  copy=list(h);copy[index]=value;invalid.append(make(copy))
 for index,value in [(0,0),(1,4),(2,16383),(3,0x401004),(5,0),(5,6000)]:
  copy=list(segment);copy[index]=value;invalid.append(make(ss=copy))
 for bad in invalid:
  try:parse(bad)
  except ValueError:pass
  else:raise AssertionError('Malformed fixture accepted')
 target=root/'build/astra-exec-corpora-001'
 subprocess.run(['python3',str(script),'--output',str(target)],check=True,cwd=root,stdout=(out/'generate.log').open('w'),timeout=30)
 manifest=json.loads((target/'manifest.json').read_text());checks=[]
 for name,record in manifest['corpora'].items():
  path=pathlib.Path(record['path']);raw=path.read_bytes()
  assert hashlib.sha256(raw).hexdigest()==record['file_sha256']
  text=subprocess.check_output(['readelf','-lW',str(path)],text=True);(out/(name+'-readelf.txt')).write_text(text)
  expected=set();segments=0
  for line in text.splitlines():
   fields=line.split()
   if not fields or fields[0]!='LOAD' or 'E' not in ''.join(fields[6:-1]):continue
   offset,size=int(fields[1],16),int(fields[4],16)
   if not size:continue
   segments+=1
   first,last=offset//4096,(offset+size-1)//4096
   expected.update(i*4096 for i in range(first,last+1))
  offsets,_=parse(raw);assert offsets==sorted(expected) and len(record['segments'])==segments
  chosen=[offsets[i*(len(offsets)-1)//127] for i in range(128)]
  assert chosen==record['selected_file_offsets']
  expected=b''.join(raw[x:x+4096]+bytes(max(0,4096-len(raw[x:x+4096]))) for x in chosen)
  actual=(target/(name+'.bin')).read_bytes();assert actual==expected and len(actual)==524288
  assert hashlib.sha256(actual).hexdigest()==record['corpus_sha256']
  checks.append(dict(name=name,readelf_program_headers_match=True,raw_bytes_match=True,selected_unique_pages=len(set(chosen))))
 before={str(f):hashlib.sha256(f.read_bytes()).hexdigest() for f in target.iterdir()}
 result=subprocess.run(['python3',str(script),'--output',str(target)],cwd=root,capture_output=True,text=True)
 assert result.returncode==2
 assert before=={str(f):hashlib.sha256(f.read_bytes()).hexdigest() for f in target.iterdir()}
 assert hashlib.sha256(script.read_bytes()).hexdigest()==source_sha
 (out/'result.json').write_text(json.dumps(dict(status='passed',source_sha256=source_sha,invalid_elf_cases=len(invalid),real_input_checks=checks,existing_output_preserved=True,elapsed_seconds=time.time()-start,scope='Fixture generation correctness; no new codec measurement or anonymous runtime-memory claim'),indent=2)+'\n')
except BaseException as e:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e)),indent=2)+'\n');raise
