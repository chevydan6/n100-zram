#!/usr/bin/python3
import hashlib,os,pathlib,shutil,subprocess,sys
assert os.geteuid()==0
base=pathlib.Path('/home/dan/n100-zram/build/terra-custom-kernel-001');release='7.2.11-n100-gzram-btf';normal='/boot/vmlinuz-7.2.11-200.fc44.x86_64'
image=base/'out-n100-btf/arch/x86/boot/bzImage';initrd=base/'physical-prep/initramfs-7.2.11-n100-gzram-btf.img';source=base/'stage-btf/lib/modules'/release
kernel=pathlib.Path('/boot/vmlinuz-'+release);initout=pathlib.Path('/boot/initramfs-'+release+'.img');target=pathlib.Path('/lib/modules')/release
if any(x.exists() for x in (kernel,initout,target)):raise SystemExit('Experimental target already exists; refusing overwrite')
if subprocess.check_output(['uname','-r'],text=True).strip()!='7.2.11-200.fc44.x86_64':raise SystemExit('Unexpected running kernel')
if subprocess.check_output(['grubby','--default-kernel'],text=True).strip()!=normal:raise SystemExit('Unexpected current boot default')
assert image.is_file() and initrd.is_file() and (source/'modules.dep').is_file()
backup=base/'physical-prep/grubenv-before-btf.bin';assert not backup.exists();shutil.copy2('/boot/grub2/grubenv',backup)
created=[]
try:
 shutil.copytree(source,target,symlinks=True);created.append(target)
 link=target/'build'
 if link.is_symlink():link.unlink()
 # Copies from the user's home directory can retain user_home_t; restore the
 # distribution's module labels before system services attempt to load them.
 shutil.copyfile(image,kernel);os.chmod(kernel,0o644);created.append(kernel)
 shutil.copyfile(initrd,initout);os.chmod(initout,0o644);created.append(initout)
 subprocess.run(['depmod','-a',release],check=True)
 subprocess.run(['restorecon','-RF',str(target)],check=True)
 check=subprocess.run(['restorecon','-nRv',str(target)],check=True,text=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
 if check.stdout.strip():raise RuntimeError('Module label verification failed: '+check.stdout)
 subprocess.run(['grubby','--add-kernel='+str(kernel),'--initrd='+str(initout),'--copy-default','--title=Experimental N100 GZRAM ('+release+')'],check=True)
 info=subprocess.check_output(['grubby','--info='+str(kernel)],text=True)
 if str(initout) not in info:raise RuntimeError('new entry missing initramfs')
 if subprocess.check_output(['grubby','--default-kernel'],text=True).strip()!=normal:raise RuntimeError('default kernel changed unexpectedly')
 print(info);print('EXPERIMENTAL_ENTRY_READY default preserved; no reboot scheduled')
except BaseException:
 subprocess.run(['grubby','--remove-kernel='+str(kernel)],check=False)
 for p in reversed(created):
  try:
   if p.is_dir():shutil.rmtree(p)
   else:p.unlink()
  except OSError:pass
 if subprocess.check_output(['grubby','--default-kernel'],text=True).strip()!=normal:print('ERROR: original default needs manual recovery',file=sys.stderr)
 raise
