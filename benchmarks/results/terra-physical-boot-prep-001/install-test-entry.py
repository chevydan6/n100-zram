#!/usr/bin/python3
import hashlib,os,pathlib,shutil,subprocess,sys
assert os.geteuid()==0
base=pathlib.Path('/home/dan/n100-zram/build/terra-custom-kernel-001');release='7.2.11-n100-gzram';normal='/boot/vmlinuz-7.2.11-200.fc44.x86_64'
image=base/'out-n100/arch/x86/boot/bzImage';initrd=base/'physical-prep/initramfs-7.2.11-n100-gzram.img';source=base/'stage/lib/modules'/release
kernel=pathlib.Path('/boot/vmlinuz-'+release);initout=pathlib.Path('/boot/initramfs-'+release+'.img');target=pathlib.Path('/lib/modules')/release
if any(x.exists() for x in (kernel,initout,target)):raise SystemExit('Experimental target already exists; refusing overwrite')
if subprocess.check_output(['uname','-r'],text=True).strip()!='7.2.11-200.fc44.x86_64':raise SystemExit('Unexpected running kernel')
if subprocess.check_output(['grubby','--default-kernel'],text=True).strip()!=normal:raise SystemExit('Unexpected current boot default')
assert image.is_file() and initrd.is_file() and (source/'modules.dep').is_file()
backup=base/'physical-prep/grubenv-original.bin';assert not backup.exists();shutil.copy2('/boot/grub2/grubenv',backup)
created=[]
try:
 shutil.copytree(source,target,symlinks=True);created.append(target)
 link=target/'build'
 if link.is_symlink():link.unlink()
 shutil.copyfile(image,kernel);os.chmod(kernel,0o644);created.append(kernel)
 shutil.copyfile(initrd,initout);os.chmod(initout,0o644);created.append(initout)
 subprocess.run(['depmod','-a',release],check=True)
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
