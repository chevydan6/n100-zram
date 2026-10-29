
/home/dan/n100-zram/build/astra-simd-kernel-002/dispatch.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <n100_simd_available-0x10>:
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop

0000000000000010 <n100_simd_available>:
  10:	f3 0f 1e fa          	endbr64
  14:	e8 00 00 00 00       	call   19 <n100_simd_available+0x9>
  19:	31 c0                	xor    %eax,%eax
  1b:	48 0f ba 25 00 00 00 	btq    $0x25,0x0(%rip)        # 24 <n100_simd_available+0x14>
  22:	00 25 
  24:	72 05                	jb     2b <n100_simd_available+0x1b>
  26:	e9 00 00 00 00       	jmp    2b <n100_simd_available+0x1b>
  2b:	31 f6                	xor    %esi,%esi
  2d:	bf 06 00 00 00       	mov    $0x6,%edi
  32:	e8 00 00 00 00       	call   37 <n100_simd_available+0x27>
  37:	85 c0                	test   %eax,%eax
  39:	0f 95 c0             	setne  %al
  3c:	0f b6 c0             	movzbl %al,%eax
  3f:	e9 00 00 00 00       	jmp    44 <n100_simd_available+0x34>
  44:	90                   	nop
  45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4c:	00 00 00 00 
  50:	90                   	nop
  51:	90                   	nop
  52:	90                   	nop
  53:	90                   	nop
  54:	90                   	nop
  55:	90                   	nop
  56:	90                   	nop
  57:	90                   	nop
  58:	90                   	nop
  59:	90                   	nop
  5a:	90                   	nop
  5b:	90                   	nop
  5c:	90                   	nop
  5d:	90                   	nop
  5e:	90                   	nop
  5f:	90                   	nop

0000000000000060 <n100_simd_check_paths>:
  60:	f3 0f 1e fa          	endbr64
  64:	e8 00 00 00 00       	call   69 <n100_simd_check_paths+0x9>
  69:	48 83 ec 18          	sub    $0x18,%rsp
  6d:	48 0f ba 25 00 00 00 	btq    $0x25,0x0(%rip)        # 76 <n100_simd_check_paths+0x16>
  74:	00 25 
  76:	0f 83 00 00 00 00    	jae    7c <n100_simd_check_paths+0x1c>
  7c:	31 f6                	xor    %esi,%esi
  7e:	bf 06 00 00 00       	mov    $0x6,%edi
  83:	e8 00 00 00 00       	call   88 <n100_simd_check_paths+0x28>
  88:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 8f <n100_simd_check_paths+0x2f>
  8f:	48 8b 0d 00 00 00 00 	mov    0x0(%rip),%rcx        # 96 <n100_simd_check_paths+0x36>
  96:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  9d:	85 c0                	test   %eax,%eax
  9f:	89 44 24 14          	mov    %eax,0x14(%rsp)
  a3:	40 0f 95 c6          	setne  %sil
  a7:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  ac:	40 0f b6 f6          	movzbl %sil,%esi
  b0:	48 89 14 24          	mov    %rdx,(%rsp)
  b4:	e8 00 00 00 00       	call   b9 <n100_simd_check_paths+0x59>
  b9:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
  be:	48 8b 14 24          	mov    (%rsp),%rdx
  c2:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  c7:	0f 84 00 00 00 00    	je     cd <n100_simd_check_paths+0x6d>
  cd:	e9 00 00 00 00       	jmp    d2 <n100_simd_check_paths+0x72>
  d2:	0f 1f 00             	nopl   (%rax)
  d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  dc:	00 00 00 00 
  e0:	90                   	nop
  e1:	90                   	nop
  e2:	90                   	nop
  e3:	90                   	nop
  e4:	90                   	nop
  e5:	90                   	nop
  e6:	90                   	nop
  e7:	90                   	nop
  e8:	90                   	nop
  e9:	90                   	nop
  ea:	90                   	nop
  eb:	90                   	nop
  ec:	90                   	nop
  ed:	90                   	nop
  ee:	90                   	nop
  ef:	90                   	nop

00000000000000f0 <n100_simd_encode>:
  f0:	f3 0f 1e fa          	endbr64
  f4:	e8 00 00 00 00       	call   f9 <n100_simd_encode+0x9>
  f9:	48 83 ec 40          	sub    $0x40,%rsp
  fd:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
 102:	48 8b 5c 24 48       	mov    0x48(%rsp),%rbx
 107:	4d 85 c9             	test   %r9,%r9
 10a:	74 4f                	je     15b <n100_simd_encode+0x6b>
 10c:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
 111:	4c 89 cd             	mov    %r9,%rbp
 114:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
 119:	49 89 d4             	mov    %rdx,%r12
 11c:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
 121:	49 89 fd             	mov    %rdi,%r13
 124:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
 129:	49 89 f6             	mov    %rsi,%r14
 12c:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
 131:	45 89 c7             	mov    %r8d,%r15d
 134:	48 89 0c 24          	mov    %rcx,(%rsp)
 138:	e8 00 00 00 00       	call   13d <n100_simd_encode+0x4d>
 13d:	48 39 c3             	cmp    %rax,%rbx
 140:	73 29                	jae    16b <n100_simd_encode+0x7b>
 142:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
 147:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
 14c:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
 151:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
 156:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
 15b:	31 c0                	xor    %eax,%eax
 15d:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
 162:	48 83 c4 40          	add    $0x40,%rsp
 166:	e9 00 00 00 00       	jmp    16b <n100_simd_encode+0x7b>
 16b:	e8 00 00 00 00       	call   170 <n100_simd_encode+0x80>
 170:	31 d2                	xor    %edx,%edx
 172:	48 89 c1             	mov    %rax,%rcx
 175:	48 89 e8             	mov    %rbp,%rax
 178:	48 f7 f1             	div    %rcx
 17b:	48 85 d2             	test   %rdx,%rdx
 17e:	75 c2                	jne    142 <n100_simd_encode+0x52>
 180:	41 8d 47 fb          	lea    -0x5(%r15),%eax
 184:	83 f8 07             	cmp    $0x7,%eax
 187:	77 b9                	ja     142 <n100_simd_encode+0x52>
 189:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
 190:	77 b0                	ja     142 <n100_simd_encode+0x52>
 192:	4d 85 e4             	test   %r12,%r12
 195:	74 ab                	je     142 <n100_simd_encode+0x52>
 197:	4d 85 ed             	test   %r13,%r13
 19a:	0f 94 c2             	sete   %dl
 19d:	4d 85 f6             	test   %r14,%r14
 1a0:	0f 95 c0             	setne  %al
 1a3:	84 c2                	test   %al,%dl
 1a5:	75 9b                	jne    142 <n100_simd_encode+0x52>
 1a7:	48 83 3c 24 07       	cmpq   $0x7,(%rsp)
 1ac:	76 94                	jbe    142 <n100_simd_encode+0x52>
 1ae:	4d 85 f6             	test   %r14,%r14
 1b1:	74 0b                	je     1be <n100_simd_encode+0xce>
 1b3:	48 0f ba 25 00 00 00 	btq    $0x25,0x0(%rip)        # 1bc <n100_simd_encode+0xcc>
 1ba:	00 25 
 1bc:	72 3f                	jb     1fd <n100_simd_encode+0x10d>
 1be:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
 1c3:	48 8b 0c 24          	mov    (%rsp),%rcx
 1c7:	49 89 e9             	mov    %rbp,%r9
 1ca:	45 89 f8             	mov    %r15d,%r8d
 1cd:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
 1d2:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
 1d7:	4c 89 e2             	mov    %r12,%rdx
 1da:	4c 89 f6             	mov    %r14,%rsi
 1dd:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
 1e2:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
 1e7:	4c 89 ef             	mov    %r13,%rdi
 1ea:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
 1ef:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
 1f4:	48 83 c4 40          	add    $0x40,%rsp
 1f8:	e9 00 00 00 00       	jmp    1fd <n100_simd_encode+0x10d>
 1fd:	31 f6                	xor    %esi,%esi
 1ff:	bf 06 00 00 00       	mov    $0x6,%edi
 204:	e8 00 00 00 00       	call   209 <n100_simd_encode+0x119>
 209:	85 c0                	test   %eax,%eax
 20b:	74 b1                	je     1be <n100_simd_encode+0xce>
 20d:	e8 00 00 00 00       	call   212 <n100_simd_encode+0x122>
 212:	84 c0                	test   %al,%al
 214:	74 a8                	je     1be <n100_simd_encode+0xce>
 216:	bf 02 00 00 00       	mov    $0x2,%edi
 21b:	e8 00 00 00 00       	call   220 <n100_simd_encode+0x130>
 220:	48 8b 0c 24          	mov    (%rsp),%rcx
 224:	45 89 f8             	mov    %r15d,%r8d
 227:	4c 89 e2             	mov    %r12,%rdx
 22a:	4c 89 f6             	mov    %r14,%rsi
 22d:	4c 89 ef             	mov    %r13,%rdi
 230:	e8 00 00 00 00       	call   235 <n100_simd_encode+0x145>
 235:	89 44 24 0c          	mov    %eax,0xc(%rsp)
 239:	e8 00 00 00 00       	call   23e <n100_simd_encode+0x14e>
 23e:	f0 48 ff 05 00 00 00 	lock incq 0x0(%rip)        # 246 <n100_simd_encode+0x156>
 245:	00 
 246:	8b 44 24 0c          	mov    0xc(%rsp),%eax
 24a:	85 c0                	test   %eax,%eax
 24c:	74 1e                	je     26c <n100_simd_encode+0x17c>
 24e:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
 253:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
 258:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
 25d:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
 262:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
 267:	e9 f1 fe ff ff       	jmp    15d <n100_simd_encode+0x6d>
 26c:	48 8b 0c 24          	mov    (%rsp),%rcx
 270:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
 275:	49 89 e8             	mov    %rbp,%r8
 278:	4c 89 e2             	mov    %r12,%rdx
 27b:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
 280:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
 285:	4c 89 f6             	mov    %r14,%rsi
 288:	4c 89 ef             	mov    %r13,%rdi
 28b:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
 290:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
 295:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
 29a:	48 83 c4 40          	add    $0x40,%rsp
 29e:	e9 00 00 00 00       	jmp    2a3 <n100_simd_encode+0x1b3>
 2a3:	66 90                	xchg   %ax,%ax
 2a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 2ac:	00 00 00 00 
 2b0:	90                   	nop
 2b1:	90                   	nop
 2b2:	90                   	nop
 2b3:	90                   	nop
 2b4:	90                   	nop
 2b5:	90                   	nop
 2b6:	90                   	nop
 2b7:	90                   	nop
 2b8:	90                   	nop
 2b9:	90                   	nop
 2ba:	90                   	nop
 2bb:	90                   	nop
 2bc:	90                   	nop
 2bd:	90                   	nop
 2be:	90                   	nop
 2bf:	90                   	nop

00000000000002c0 <n100_simd_decode>:
 2c0:	f3 0f 1e fa          	endbr64
 2c4:	e8 00 00 00 00       	call   2c9 <n100_simd_decode+0x9>
 2c9:	48 85 ff             	test   %rdi,%rdi
 2cc:	0f 84 84 01 00 00    	je     456 <n100_simd_decode+0x196>
 2d2:	4c 8d 56 f8          	lea    -0x8(%rsi),%r10
 2d6:	49 81 fa 20 10 00 00 	cmp    $0x1020,%r10
 2dd:	0f 87 73 01 00 00    	ja     456 <n100_simd_decode+0x196>
 2e3:	81 3f 47 48 59 31    	cmpl   $0x31594847,(%rdi)
 2e9:	0f 85 67 01 00 00    	jne    456 <n100_simd_decode+0x196>
 2ef:	48 83 ec 40          	sub    $0x40,%rsp
 2f3:	48 89 6c 24 38       	mov    %rbp,0x38(%rsp)
 2f8:	0f b6 6f 06          	movzbl 0x6(%rdi),%ebp
 2fc:	40 80 fd 02          	cmp    $0x2,%bpl
 300:	0f 87 49 01 00 00    	ja     44f <n100_simd_decode+0x18f>
 306:	80 7f 07 00          	cmpb   $0x0,0x7(%rdi)
 30a:	0f 85 3f 01 00 00    	jne    44f <n100_simd_decode+0x18f>
 310:	b8 00 10 00 00       	mov    $0x1000,%eax
 315:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
 31a:	48 89 d3             	mov    %rdx,%rbx
 31d:	0f b7 57 04          	movzwl 0x4(%rdi),%edx
 321:	48 39 c1             	cmp    %rax,%rcx
 324:	48 0f 46 c1          	cmovbe %rcx,%rax
 328:	49 89 d1             	mov    %rdx,%r9
 32b:	48 39 d0             	cmp    %rdx,%rax
 32e:	0f 82 16 01 00 00    	jb     44a <n100_simd_decode+0x18a>
 334:	48 85 db             	test   %rbx,%rbx
 337:	75 09                	jne    342 <n100_simd_decode+0x82>
 339:	48 85 d2             	test   %rdx,%rdx
 33c:	0f 85 08 01 00 00    	jne    44a <n100_simd_decode+0x18a>
 342:	49 89 f3             	mov    %rsi,%r11
 345:	49 89 f8             	mov    %rdi,%r8
 348:	40 80 fd 01          	cmp    $0x1,%bpl
 34c:	74 1c                	je     36a <n100_simd_decode+0xaa>
 34e:	48 8b 6c 24 38       	mov    0x38(%rsp),%rbp
 353:	48 89 da             	mov    %rbx,%rdx
 356:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
 35b:	4c 89 de             	mov    %r11,%rsi
 35e:	4c 89 c7             	mov    %r8,%rdi
 361:	48 83 c4 40          	add    $0x40,%rsp
 365:	e9 00 00 00 00       	jmp    36a <n100_simd_decode+0xaa>
 36a:	48 0f ba 25 00 00 00 	btq    $0x25,0x0(%rip)        # 373 <n100_simd_decode+0xb3>
 371:	00 25 
 373:	73 d9                	jae    34e <n100_simd_decode+0x8e>
 375:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
 37a:	31 f6                	xor    %esi,%esi
 37c:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
 381:	bf 06 00 00 00       	mov    $0x6,%edi
 386:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
 38b:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
 390:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
 395:	44 89 4c 24 04       	mov    %r9d,0x4(%rsp)
 39a:	e8 00 00 00 00       	call   39f <n100_simd_decode+0xdf>
 39f:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
 3a4:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
 3a9:	85 c0                	test   %eax,%eax
 3ab:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 3b0:	74 9c                	je     34e <n100_simd_decode+0x8e>
 3b2:	e8 00 00 00 00       	call   3b7 <n100_simd_decode+0xf7>
 3b7:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
 3bc:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
 3c1:	84 c0                	test   %al,%al
 3c3:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 3c8:	74 84                	je     34e <n100_simd_decode+0x8e>
 3ca:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
 3cf:	44 8b 4c 24 04       	mov    0x4(%rsp),%r9d
 3d4:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
 3d9:	48 85 d2             	test   %rdx,%rdx
 3dc:	74 6c                	je     44a <n100_simd_decode+0x18a>
 3de:	bf 02 00 00 00       	mov    $0x2,%edi
 3e3:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
 3e8:	44 89 4c 24 04       	mov    %r9d,0x4(%rsp)
 3ed:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
 3f2:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
 3f7:	e8 00 00 00 00       	call   3fc <n100_simd_decode+0x13c>
 3fc:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
 401:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
 406:	48 89 da             	mov    %rbx,%rdx
 409:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
 40e:	49 8d 78 08          	lea    0x8(%r8),%rdi
 412:	e8 00 00 00 00       	call   417 <n100_simd_decode+0x157>
 417:	89 c3                	mov    %eax,%ebx
 419:	e8 00 00 00 00       	call   41e <n100_simd_decode+0x15e>
 41e:	f0 48 ff 05 00 00 00 	lock incq 0x0(%rip)        # 426 <n100_simd_decode+0x166>
 425:	00 
 426:	44 0f b7 4c 24 04    	movzwl 0x4(%rsp),%r9d
 42c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 431:	41 39 d9             	cmp    %ebx,%r9d
 434:	0f 44 c3             	cmove  %ebx,%eax
 437:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
 43c:	48 8b 6c 24 38       	mov    0x38(%rsp),%rbp
 441:	48 83 c4 40          	add    $0x40,%rsp
 445:	e9 00 00 00 00       	jmp    44a <n100_simd_decode+0x18a>
 44a:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
 44f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 454:	eb e6                	jmp    43c <n100_simd_decode+0x17c>
 456:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 45b:	e9 00 00 00 00       	jmp    460 <n100_simd_decode+0x1a0>

Disassembly of section .text.unlikely:

0000000000000000 <n100_simd_check_paths.cold>:
   0:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 7 <n100_simd_check_paths.cold+0x7>
   7:	48 8b 0d 00 00 00 00 	mov    0x0(%rip),%rcx        # e <n100_simd_check_paths.cold+0xe>
   e:	31 f6                	xor    %esi,%esi
  10:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  17:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  1c:	48 89 14 24          	mov    %rdx,(%rsp)
  20:	e8 00 00 00 00       	call   25 <n100_simd_check_paths.cold+0x25>
  25:	48 8b 14 24          	mov    (%rsp),%rdx
  29:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  2e:	48 09 d1             	or     %rdx,%rcx
  31:	48 f7 d9             	neg    %rcx
  34:	19 c0                	sbb    %eax,%eax
  36:	83 e0 ea             	and    $0xffffffea,%eax
  39:	48 83 c4 18          	add    $0x18,%rsp
  3d:	e9 00 00 00 00       	jmp    42 <n100_simd_check_paths.cold+0x42>
  42:	48 85 d2             	test   %rdx,%rdx
  45:	7e 07                	jle    4e <n100_simd_check_paths.cold+0x4e>
  47:	31 c0                	xor    %eax,%eax
  49:	48 85 c9             	test   %rcx,%rcx
  4c:	7f eb                	jg     39 <n100_simd_check_paths.cold+0x39>
  4e:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
  53:	eb e4                	jmp    39 <n100_simd_check_paths.cold+0x39>
