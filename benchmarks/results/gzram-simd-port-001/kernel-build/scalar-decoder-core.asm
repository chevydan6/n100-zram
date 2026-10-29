
/home/dan/n100-zram/build/astra-simd-kernel-002/scalar/decoder/core.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <pack_scalar-0x10>:
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

0000000000000010 <pack_scalar>:
  10:	f3 0f 1e fa          	endbr64
  14:	e8 00 00 00 00       	call   19 <pack_scalar+0x9>
  19:	f6 c2 01             	test   $0x1,%dl
  1c:	74 09                	je     27 <pack_scalar+0x17>
  1e:	8b 07                	mov    (%rdi),%eax
  20:	48 83 c6 04          	add    $0x4,%rsi
  24:	89 46 fc             	mov    %eax,-0x4(%rsi)
  27:	f6 c2 02             	test   $0x2,%dl
  2a:	74 0a                	je     36 <pack_scalar+0x26>
  2c:	8b 47 04             	mov    0x4(%rdi),%eax
  2f:	48 83 c6 04          	add    $0x4,%rsi
  33:	89 46 fc             	mov    %eax,-0x4(%rsi)
  36:	f6 c2 04             	test   $0x4,%dl
  39:	74 0a                	je     45 <pack_scalar+0x35>
  3b:	8b 47 08             	mov    0x8(%rdi),%eax
  3e:	48 83 c6 04          	add    $0x4,%rsi
  42:	89 46 fc             	mov    %eax,-0x4(%rsi)
  45:	f6 c2 08             	test   $0x8,%dl
  48:	74 0a                	je     54 <pack_scalar+0x44>
  4a:	8b 47 0c             	mov    0xc(%rdi),%eax
  4d:	48 83 c6 04          	add    $0x4,%rsi
  51:	89 46 fc             	mov    %eax,-0x4(%rsi)
  54:	f6 c2 10             	test   $0x10,%dl
  57:	74 0a                	je     63 <pack_scalar+0x53>
  59:	8b 47 10             	mov    0x10(%rdi),%eax
  5c:	48 83 c6 04          	add    $0x4,%rsi
  60:	89 46 fc             	mov    %eax,-0x4(%rsi)
  63:	f6 c2 20             	test   $0x20,%dl
  66:	74 0a                	je     72 <pack_scalar+0x62>
  68:	8b 47 14             	mov    0x14(%rdi),%eax
  6b:	48 83 c6 04          	add    $0x4,%rsi
  6f:	89 46 fc             	mov    %eax,-0x4(%rsi)
  72:	f6 c2 40             	test   $0x40,%dl
  75:	74 0a                	je     81 <pack_scalar+0x71>
  77:	8b 47 18             	mov    0x18(%rdi),%eax
  7a:	48 83 c6 04          	add    $0x4,%rsi
  7e:	89 46 fc             	mov    %eax,-0x4(%rsi)
  81:	81 e2 80 00 00 00    	and    $0x80,%edx
  87:	74 05                	je     8e <pack_scalar+0x7e>
  89:	8b 47 1c             	mov    0x1c(%rdi),%eax
  8c:	89 06                	mov    %eax,(%rsi)
  8e:	e9 00 00 00 00       	jmp    93 <pack_scalar+0x83>
  93:	66 90                	xchg   %ax,%ax
  95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  9c:	00 00 00 00 
  a0:	90                   	nop
  a1:	90                   	nop
  a2:	90                   	nop
  a3:	90                   	nop
  a4:	90                   	nop
  a5:	90                   	nop
  a6:	90                   	nop
  a7:	90                   	nop
  a8:	90                   	nop
  a9:	90                   	nop
  aa:	90                   	nop
  ab:	90                   	nop
  ac:	90                   	nop
  ad:	90                   	nop
  ae:	90                   	nop
  af:	90                   	nop

00000000000000b0 <header>:
  b0:	e8 00 00 00 00       	call   b5 <header+0x5>
  b5:	c7 07 47 5a 52 31    	movl   $0x31525a47,(%rdi)
  bb:	66 89 77 04          	mov    %si,0x4(%rdi)
  bf:	88 57 06             	mov    %dl,0x6(%rdi)
  c2:	88 4f 07             	mov    %cl,0x7(%rdi)
  c5:	e9 00 00 00 00       	jmp    ca <header+0x1a>
  ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  d0:	90                   	nop
  d1:	90                   	nop
  d2:	90                   	nop
  d3:	90                   	nop
  d4:	90                   	nop
  d5:	90                   	nop
  d6:	90                   	nop
  d7:	90                   	nop
  d8:	90                   	nop
  d9:	90                   	nop
  da:	90                   	nop
  db:	90                   	nop
  dc:	90                   	nop
  dd:	90                   	nop
  de:	90                   	nop
  df:	90                   	nop

00000000000000e0 <raw_page>:
  e0:	e8 00 00 00 00       	call   e5 <raw_page+0x5>
  e5:	49 89 c9             	mov    %rcx,%r9
  e8:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
  ec:	49 39 c9             	cmp    %rcx,%r9
  ef:	72 51                	jb     142 <raw_page+0x62>
  f1:	53                   	push   %rbx
  f2:	48 89 f3             	mov    %rsi,%rbx
  f5:	49 89 d1             	mov    %rdx,%r9
  f8:	48 89 fe             	mov    %rdi,%rsi
  fb:	48 83 ec 10          	sub    $0x10,%rsp
  ff:	48 85 db             	test   %rbx,%rbx
 102:	74 1e                	je     122 <raw_page+0x42>
 104:	49 8d 79 08          	lea    0x8(%r9),%rdi
 108:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
 10d:	48 89 da             	mov    %rbx,%rdx
 110:	4c 89 0c 24          	mov    %r9,(%rsp)
 114:	e8 00 00 00 00       	call   119 <raw_page+0x39>
 119:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
 11e:	4c 8b 0c 24          	mov    (%rsp),%r9
 122:	48 89 de             	mov    %rbx,%rsi
 125:	b9 01 00 00 00       	mov    $0x1,%ecx
 12a:	44 89 c2             	mov    %r8d,%edx
 12d:	4c 89 cf             	mov    %r9,%rdi
 130:	e8 7b ff ff ff       	call   b0 <header>
 135:	8d 43 08             	lea    0x8(%rbx),%eax
 138:	48 83 c4 10          	add    $0x10,%rsp
 13c:	5b                   	pop    %rbx
 13d:	e9 00 00 00 00       	jmp    142 <raw_page+0x62>
 142:	31 c0                	xor    %eax,%eax
 144:	e9 00 00 00 00       	jmp    149 <raw_page+0x69>
 149:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 150:	90                   	nop
 151:	90                   	nop
 152:	90                   	nop
 153:	90                   	nop
 154:	90                   	nop
 155:	90                   	nop
 156:	90                   	nop
 157:	90                   	nop
 158:	90                   	nop
 159:	90                   	nop
 15a:	90                   	nop
 15b:	90                   	nop
 15c:	90                   	nop
 15d:	90                   	nop
 15e:	90                   	nop
 15f:	90                   	nop

0000000000000160 <repeat_scalar>:
 160:	f3 0f 1e fa          	endbr64
 164:	e8 00 00 00 00       	call   169 <repeat_scalar+0x9>
 169:	48 85 d2             	test   %rdx,%rdx
 16c:	74 41                	je     1af <repeat_scalar+0x4f>
 16e:	41 57                	push   %r15
 170:	41 56                	push   %r14
 172:	49 89 f6             	mov    %rsi,%r14
 175:	41 55                	push   %r13
 177:	49 89 fd             	mov    %rdi,%r13
 17a:	41 54                	push   %r12
 17c:	49 89 d4             	mov    %rdx,%r12
 17f:	55                   	push   %rbp
 180:	89 cd                	mov    %ecx,%ebp
 182:	53                   	push   %rbx
 183:	31 db                	xor    %ebx,%ebx
 185:	49 89 ef             	mov    %rbp,%r15
 188:	49 8d 7c 1d 00       	lea    0x0(%r13,%rbx,1),%rdi
 18d:	4c 89 fa             	mov    %r15,%rdx
 190:	4c 89 f6             	mov    %r14,%rsi
 193:	48 01 eb             	add    %rbp,%rbx
 196:	e8 00 00 00 00       	call   19b <repeat_scalar+0x3b>
 19b:	4c 39 e3             	cmp    %r12,%rbx
 19e:	72 e8                	jb     188 <repeat_scalar+0x28>
 1a0:	5b                   	pop    %rbx
 1a1:	5d                   	pop    %rbp
 1a2:	41 5c                	pop    %r12
 1a4:	41 5d                	pop    %r13
 1a6:	41 5e                	pop    %r14
 1a8:	41 5f                	pop    %r15
 1aa:	e9 00 00 00 00       	jmp    1af <repeat_scalar+0x4f>
 1af:	e9 00 00 00 00       	jmp    1b4 <repeat_scalar+0x54>
 1b4:	90                   	nop
 1b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 1bc:	00 00 00 00 
 1c0:	90                   	nop
 1c1:	90                   	nop
 1c2:	90                   	nop
 1c3:	90                   	nop
 1c4:	90                   	nop
 1c5:	90                   	nop
 1c6:	90                   	nop
 1c7:	90                   	nop
 1c8:	90                   	nop
 1c9:	90                   	nop
 1ca:	90                   	nop
 1cb:	90                   	nop
 1cc:	90                   	nop
 1cd:	90                   	nop
 1ce:	90                   	nop
 1cf:	90                   	nop

00000000000001d0 <unpack_scalar>:
 1d0:	f3 0f 1e fa          	endbr64
 1d4:	e8 00 00 00 00       	call   1d9 <unpack_scalar+0x9>
 1d9:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
 1e0:	48 c7 46 08 00 00 00 	movq   $0x0,0x8(%rsi)
 1e7:	00 
 1e8:	48 c7 46 10 00 00 00 	movq   $0x0,0x10(%rsi)
 1ef:	00 
 1f0:	48 c7 46 18 00 00 00 	movq   $0x0,0x18(%rsi)
 1f7:	00 
 1f8:	85 d2                	test   %edx,%edx
 1fa:	74 23                	je     21f <unpack_scalar+0x4f>
 1fc:	0f 1f 40 00          	nopl   0x0(%rax)
 200:	31 c9                	xor    %ecx,%ecx
 202:	44 8b 07             	mov    (%rdi),%r8d
 205:	8d 42 ff             	lea    -0x1(%rdx),%eax
 208:	48 83 c7 04          	add    $0x4,%rdi
 20c:	f3 0f bc ca          	tzcnt  %edx,%ecx
 210:	8d 0c 8d 00 00 00 00 	lea    0x0(,%rcx,4),%ecx
 217:	44 89 04 0e          	mov    %r8d,(%rsi,%rcx,1)
 21b:	21 c2                	and    %eax,%edx
 21d:	75 e1                	jne    200 <unpack_scalar+0x30>
 21f:	e9 00 00 00 00       	jmp    224 <unpack_scalar+0x54>
 224:	90                   	nop
 225:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 22c:	00 00 00 00 
 230:	90                   	nop
 231:	90                   	nop
 232:	90                   	nop
 233:	90                   	nop
 234:	90                   	nop
 235:	90                   	nop
 236:	90                   	nop
 237:	90                   	nop
 238:	90                   	nop
 239:	90                   	nop
 23a:	90                   	nop
 23b:	90                   	nop
 23c:	90                   	nop
 23d:	90                   	nop
 23e:	90                   	nop
 23f:	90                   	nop

0000000000000240 <decode.constprop.0>:
 240:	e8 00 00 00 00       	call   245 <decode.constprop.0+0x5>
 245:	48 8d 46 f8          	lea    -0x8(%rsi),%rax
 249:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
 24f:	0f 87 87 03 00 00    	ja     5dc <decode.constprop.0+0x39c>
 255:	48 85 ff             	test   %rdi,%rdi
 258:	0f 84 7e 03 00 00    	je     5dc <decode.constprop.0+0x39c>
 25e:	81 3f 47 5a 52 31    	cmpl   $0x31525a47,(%rdi)
 264:	0f 85 72 03 00 00    	jne    5dc <decode.constprop.0+0x39c>
 26a:	48 83 ec 70          	sub    $0x70,%rsp
 26e:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
 273:	48 89 d5             	mov    %rdx,%rbp
 276:	48 89 ca             	mov    %rcx,%rdx
 279:	0f b6 4f 06          	movzbl 0x6(%rdi),%ecx
 27d:	8d 41 fb             	lea    -0x5(%rcx),%eax
 280:	3c 07                	cmp    $0x7,%al
 282:	0f 87 59 02 00 00    	ja     4e1 <decode.constprop.0+0x2a1>
 288:	44 0f b6 47 07       	movzbl 0x7(%rdi),%r8d
 28d:	41 80 f8 01          	cmp    $0x1,%r8b
 291:	0f 87 4a 02 00 00    	ja     4e1 <decode.constprop.0+0x2a1>
 297:	41 b9 00 10 00 00    	mov    $0x1000,%r9d
 29d:	0f b7 47 04          	movzwl 0x4(%rdi),%eax
 2a1:	4c 39 ca             	cmp    %r9,%rdx
 2a4:	49 0f 47 d1          	cmova  %r9,%rdx
 2a8:	49 89 c2             	mov    %rax,%r10
 2ab:	48 39 c2             	cmp    %rax,%rdx
 2ae:	0f 82 2d 02 00 00    	jb     4e1 <decode.constprop.0+0x2a1>
 2b4:	48 85 ed             	test   %rbp,%rbp
 2b7:	75 09                	jne    2c2 <decode.constprop.0+0x82>
 2b9:	48 85 c0             	test   %rax,%rax
 2bc:	0f 85 1f 02 00 00    	jne    4e1 <decode.constprop.0+0x2a1>
 2c2:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
 2c7:	45 84 c0             	test   %r8b,%r8b
 2ca:	0f 85 cb 01 00 00    	jne    49b <decode.constprop.0+0x25b>
 2d0:	41 b9 01 00 00 00    	mov    $0x1,%r9d
 2d6:	4c 89 6c 24 58       	mov    %r13,0x58(%rsp)
 2db:	49 d3 e1             	shl    %cl,%r9
 2de:	48 89 5c 24 40       	mov    %rbx,0x40(%rsp)
 2e3:	4e 8d 6c 08 ff       	lea    -0x1(%rax,%r9,1),%r13
 2e8:	49 d3 ed             	shr    %cl,%r13
 2eb:	49 8d 5d 08          	lea    0x8(%r13),%rbx
 2ef:	48 39 de             	cmp    %rbx,%rsi
 2f2:	0f 82 ff 02 00 00    	jb     5f7 <decode.constprop.0+0x3b7>
 2f8:	4d 85 ed             	test   %r13,%r13
 2fb:	0f 84 ef 02 00 00    	je     5f0 <decode.constprop.0+0x3b0>
 301:	48 01 e8             	add    %rbp,%rax
 304:	4a 8d 4c 2f 08       	lea    0x8(%rdi,%r13,1),%rcx
 309:	4c 89 74 24 60       	mov    %r14,0x60(%rsp)
 30e:	49 89 ee             	mov    %rbp,%r14
 311:	4c 89 7c 24 68       	mov    %r15,0x68(%rsp)
 316:	48 8d 6f 08          	lea    0x8(%rdi),%rbp
 31a:	49 89 df             	mov    %rbx,%r15
 31d:	4c 89 cb             	mov    %r9,%rbx
 320:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
 325:	48 89 04 24          	mov    %rax,(%rsp)
 329:	66 44 89 54 24 3e    	mov    %r10w,0x3e(%rsp)
 32f:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
 334:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
 339:	eb 4a                	jmp    385 <decode.constprop.0+0x145>
 33b:	3c 01                	cmp    $0x1,%al
 33d:	0f 84 fe 01 00 00    	je     541 <decode.constprop.0+0x301>
 343:	3c 02                	cmp    $0x2,%al
 345:	0f 84 a9 01 00 00    	je     4f4 <decode.constprop.0+0x2b4>
 34b:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
 350:	4c 29 f8             	sub    %r15,%rax
 353:	4c 39 e8             	cmp    %r13,%rax
 356:	0f 82 6c 01 00 00    	jb     4c8 <decode.constprop.0+0x288>
 35c:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 361:	4c 89 f7             	mov    %r14,%rdi
 364:	4c 89 ea             	mov    %r13,%rdx
 367:	4a 8d 34 38          	lea    (%rax,%r15,1),%rsi
 36b:	4d 01 ef             	add    %r13,%r15
 36e:	e8 00 00 00 00       	call   373 <decode.constprop.0+0x133>
 373:	48 83 c5 01          	add    $0x1,%rbp
 377:	49 01 de             	add    %rbx,%r14
 37a:	48 39 6c 24 10       	cmp    %rbp,0x10(%rsp)
 37f:	0f 84 11 02 00 00    	je     596 <decode.constprop.0+0x356>
 385:	4c 8b 2c 24          	mov    (%rsp),%r13
 389:	0f b6 45 00          	movzbl 0x0(%rbp),%eax
 38d:	4d 29 f5             	sub    %r14,%r13
 390:	49 39 dd             	cmp    %rbx,%r13
 393:	4c 0f 47 eb          	cmova  %rbx,%r13
 397:	3c 03                	cmp    $0x3,%al
 399:	0f 84 b4 01 00 00    	je     553 <decode.constprop.0+0x313>
 39f:	76 9a                	jbe    33b <decode.constprop.0+0xfb>
 3a1:	3c 05                	cmp    $0x5,%al
 3a3:	0f 84 c4 01 00 00    	je     56d <decode.constprop.0+0x32d>
 3a9:	3c 06                	cmp    $0x6,%al
 3ab:	0f 84 af 01 00 00    	je     560 <decode.constprop.0+0x320>
 3b1:	3c 04                	cmp    $0x4,%al
 3b3:	0f 85 0f 01 00 00    	jne    4c8 <decode.constprop.0+0x288>
 3b9:	4c 89 ee             	mov    %r13,%rsi
 3bc:	83 e6 1f             	and    $0x1f,%esi
 3bf:	0f 85 03 01 00 00    	jne    4c8 <decode.constprop.0+0x288>
 3c5:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
 3ca:	49 c1 ed 05          	shr    $0x5,%r13
 3ce:	4c 29 f8             	sub    %r15,%rax
 3d1:	4c 39 e8             	cmp    %r13,%rax
 3d4:	0f 82 ee 00 00 00    	jb     4c8 <decode.constprop.0+0x288>
 3da:	4f 8d 54 3d 00       	lea    0x0(%r13,%r15,1),%r10
 3df:	4d 85 ed             	test   %r13,%r13
 3e2:	0f 84 ec 01 00 00    	je     5d4 <decode.constprop.0+0x394>
 3e8:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 3ed:	4c 01 f8             	add    %r15,%rax
 3f0:	4a 8d 14 28          	lea    (%rax,%r13,1),%rdx
 3f4:	48 89 c1             	mov    %rax,%rcx
 3f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 3fe:	00 00 
 400:	0f b6 39             	movzbl (%rcx),%edi
 403:	48 83 c1 01          	add    $0x1,%rcx
 407:	0f b6 bf 00 00 00 00 	movzbl 0x0(%rdi),%edi
 40e:	8d 3c bd 00 00 00 00 	lea    0x0(,%rdi,4),%edi
 415:	48 01 fe             	add    %rdi,%rsi
 418:	48 39 d1             	cmp    %rdx,%rcx
 41b:	75 e3                	jne    400 <decode.constprop.0+0x1c0>
 41d:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
 422:	4c 29 d1             	sub    %r10,%rcx
 425:	48 39 f1             	cmp    %rsi,%rcx
 428:	0f 82 9a 00 00 00    	jb     4c8 <decode.constprop.0+0x288>
 42e:	4d 89 f4             	mov    %r14,%r12
 431:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
 436:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
 43b:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
 440:	4d 89 e7             	mov    %r12,%r15
 443:	4d 89 d6             	mov    %r10,%r14
 446:	49 89 d4             	mov    %rdx,%r12
 449:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
 44e:	48 89 c5             	mov    %rax,%rbp
 451:	44 0f b6 6d 00       	movzbl 0x0(%rbp),%r13d
 456:	4a 8d 3c 33          	lea    (%rbx,%r14,1),%rdi
 45a:	4c 89 fe             	mov    %r15,%rsi
 45d:	48 83 c5 01          	add    $0x1,%rbp
 461:	49 83 c7 20          	add    $0x20,%r15
 465:	44 89 ea             	mov    %r13d,%edx
 468:	e8 63 fd ff ff       	call   1d0 <unpack_scalar>
 46d:	41 0f b6 95 00 00 00 	movzbl 0x0(%r13),%edx
 474:	00 
 475:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
 47c:	49 01 d6             	add    %rdx,%r14
 47f:	49 39 ec             	cmp    %rbp,%r12
 482:	75 cd                	jne    451 <decode.constprop.0+0x211>
 484:	4d 89 f7             	mov    %r14,%r15
 487:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
 48c:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
 491:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
 496:	e9 d8 fe ff ff       	jmp    373 <decode.constprop.0+0x133>
 49b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 49f:	48 39 d6             	cmp    %rdx,%rsi
 4a2:	0f 85 3e 01 00 00    	jne    5e6 <decode.constprop.0+0x3a6>
 4a8:	48 85 c0             	test   %rax,%rax
 4ab:	0f 85 c9 00 00 00    	jne    57a <decode.constprop.0+0x33a>
 4b1:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 4b6:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
 4bb:	41 0f b7 c2          	movzwl %r10w,%eax
 4bf:	48 83 c4 70          	add    $0x70,%rsp
 4c3:	e9 00 00 00 00       	jmp    4c8 <decode.constprop.0+0x288>
 4c8:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
 4cd:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 4d2:	4c 8b 6c 24 58       	mov    0x58(%rsp),%r13
 4d7:	4c 8b 74 24 60       	mov    0x60(%rsp),%r14
 4dc:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
 4e1:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
 4e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4eb:	48 83 c4 70          	add    $0x70,%rsp
 4ef:	e9 00 00 00 00       	jmp    4f4 <decode.constprop.0+0x2b4>
 4f4:	41 ba 04 00 00 00    	mov    $0x4,%r10d
 4fa:	b9 04 00 00 00       	mov    $0x4,%ecx
 4ff:	4c 89 e8             	mov    %r13,%rax
 502:	31 d2                	xor    %edx,%edx
 504:	49 f7 f2             	div    %r10
 507:	48 85 d2             	test   %rdx,%rdx
 50a:	75 bc                	jne    4c8 <decode.constprop.0+0x288>
 50c:	4d 39 d5             	cmp    %r10,%r13
 50f:	72 b7                	jb     4c8 <decode.constprop.0+0x288>
 511:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
 516:	4c 29 f8             	sub    %r15,%rax
 519:	4c 39 d0             	cmp    %r10,%rax
 51c:	72 aa                	jb     4c8 <decode.constprop.0+0x288>
 51e:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 523:	4c 89 ea             	mov    %r13,%rdx
 526:	4c 89 f7             	mov    %r14,%rdi
 529:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
 52e:	4a 8d 34 38          	lea    (%rax,%r15,1),%rsi
 532:	e8 29 fc ff ff       	call   160 <repeat_scalar>
 537:	4c 03 7c 24 20       	add    0x20(%rsp),%r15
 53c:	e9 32 fe ff ff       	jmp    373 <decode.constprop.0+0x133>
 541:	4c 89 ea             	mov    %r13,%rdx
 544:	31 f6                	xor    %esi,%esi
 546:	4c 89 f7             	mov    %r14,%rdi
 549:	e8 00 00 00 00       	call   54e <decode.constprop.0+0x30e>
 54e:	e9 20 fe ff ff       	jmp    373 <decode.constprop.0+0x133>
 553:	41 ba 08 00 00 00    	mov    $0x8,%r10d
 559:	b9 08 00 00 00       	mov    $0x8,%ecx
 55e:	eb 9f                	jmp    4ff <decode.constprop.0+0x2bf>
 560:	41 ba 20 00 00 00    	mov    $0x20,%r10d
 566:	b9 20 00 00 00       	mov    $0x20,%ecx
 56b:	eb 92                	jmp    4ff <decode.constprop.0+0x2bf>
 56d:	41 ba 10 00 00 00    	mov    $0x10,%r10d
 573:	b9 10 00 00 00       	mov    $0x10,%ecx
 578:	eb 85                	jmp    4ff <decode.constprop.0+0x2bf>
 57a:	48 8d 77 08          	lea    0x8(%rdi),%rsi
 57e:	48 89 ef             	mov    %rbp,%rdi
 581:	44 89 14 24          	mov    %r10d,(%rsp)
 585:	48 89 c2             	mov    %rax,%rdx
 588:	e8 00 00 00 00       	call   58d <decode.constprop.0+0x34d>
 58d:	44 8b 14 24          	mov    (%rsp),%r10d
 591:	e9 1b ff ff ff       	jmp    4b1 <decode.constprop.0+0x271>
 596:	4c 89 fb             	mov    %r15,%rbx
 599:	44 0f b7 54 24 3e    	movzwl 0x3e(%rsp),%r10d
 59f:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 5a4:	4c 8b 74 24 60       	mov    0x60(%rsp),%r14
 5a9:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
 5ae:	48 39 de             	cmp    %rbx,%rsi
 5b1:	75 44                	jne    5f7 <decode.constprop.0+0x3b7>
 5b3:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
 5b8:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 5bd:	41 0f b7 c2          	movzwl %r10w,%eax
 5c1:	4c 8b 6c 24 58       	mov    0x58(%rsp),%r13
 5c6:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
 5cb:	48 83 c4 70          	add    $0x70,%rsp
 5cf:	e9 00 00 00 00       	jmp    5d4 <decode.constprop.0+0x394>
 5d4:	4d 89 d7             	mov    %r10,%r15
 5d7:	e9 97 fd ff ff       	jmp    373 <decode.constprop.0+0x133>
 5dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5e1:	e9 00 00 00 00       	jmp    5e6 <decode.constprop.0+0x3a6>
 5e6:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 5eb:	e9 f1 fe ff ff       	jmp    4e1 <decode.constprop.0+0x2a1>
 5f0:	bb 08 00 00 00       	mov    $0x8,%ebx
 5f5:	eb b7                	jmp    5ae <decode.constprop.0+0x36e>
 5f7:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
 5fc:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 601:	4c 8b 6c 24 58       	mov    0x58(%rsp),%r13
 606:	e9 d6 fe ff ff       	jmp    4e1 <decode.constprop.0+0x2a1>
 60b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
 610:	90                   	nop
 611:	90                   	nop
 612:	90                   	nop
 613:	90                   	nop
 614:	90                   	nop
 615:	90                   	nop
 616:	90                   	nop
 617:	90                   	nop
 618:	90                   	nop
 619:	90                   	nop
 61a:	90                   	nop
 61b:	90                   	nop
 61c:	90                   	nop
 61d:	90                   	nop
 61e:	90                   	nop
 61f:	90                   	nop

0000000000000620 <scan_scalar>:
 620:	f3 0f 1e fa          	endbr64
 624:	e8 00 00 00 00       	call   629 <scan_scalar+0x9>
 629:	41 54                	push   %r12
 62b:	55                   	push   %rbp
 62c:	53                   	push   %rbx
 62d:	48 83 ec 38          	sub    $0x38,%rsp
 631:	4c 8b 17             	mov    (%rdi),%r10
 634:	4c 8b 5f 08          	mov    0x8(%rdi),%r11
 638:	65 4c 8b 05 00 00 00 	mov    %gs:0x0(%rip),%r8        # 640 <scan_scalar+0x20>
 63f:	00 
 640:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
 645:	49 89 d0             	mov    %rdx,%r8
 648:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
 64c:	48 8b 6f 18          	mov    0x18(%rdi),%rbp
 650:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
 655:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
 65a:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
 65f:	48 89 6c 24 28       	mov    %rbp,0x28(%rsp)
 664:	4d 39 d3             	cmp    %r10,%r11
 667:	0f 84 cd 01 00 00    	je     83a <scan_scalar+0x21a>
 66d:	4c 39 d3             	cmp    %r10,%rbx
 670:	0f 84 c9 00 00 00    	je     73f <scan_scalar+0x11f>
 676:	41 b9 1f 00 00 00    	mov    $0x1f,%r9d
 67c:	b8 20 00 00 00       	mov    $0x20,%eax
 681:	41 bc 20 00 00 00    	mov    $0x20,%r12d
 687:	48 39 f0             	cmp    %rsi,%rax
 68a:	0f 83 20 02 00 00    	jae    8b0 <scan_scalar+0x290>
 690:	48 83 fe 20          	cmp    $0x20,%rsi
 694:	0f 86 0d 02 00 00    	jbe    8a7 <scan_scalar+0x287>
 69a:	b8 20 00 00 00       	mov    $0x20,%eax
 69f:	eb 28                	jmp    6c9 <scan_scalar+0xa9>
 6a1:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 6a8:	00 00 
 6aa:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 6b1:	00 00 00 00 
 6b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 6bc:	00 00 00 00 
 6c0:	48 39 ca             	cmp    %rcx,%rdx
 6c3:	0f 85 95 00 00 00    	jne    75e <scan_scalar+0x13e>
 6c9:	48 89 c2             	mov    %rax,%rdx
 6cc:	48 8b 0c 07          	mov    (%rdi,%rax,1),%rcx
 6d0:	48 83 c0 08          	add    $0x8,%rax
 6d4:	4c 21 ca             	and    %r9,%rdx
 6d7:	48 c1 ea 03          	shr    $0x3,%rdx
 6db:	48 8b 54 d4 10       	mov    0x10(%rsp,%rdx,8),%rdx
 6e0:	48 39 f0             	cmp    %rsi,%rax
 6e3:	72 db                	jb     6c0 <scan_scalar+0xa0>
 6e5:	48 39 ca             	cmp    %rcx,%rdx
 6e8:	75 74                	jne    75e <scan_scalar+0x13e>
 6ea:	4d 85 d2             	test   %r10,%r10
 6ed:	0f 84 6f 01 00 00    	je     862 <scan_scalar+0x242>
 6f3:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
 6fa:	01 00 00 00 
 6fe:	41 83 fc 08          	cmp    $0x8,%r12d
 702:	0f 84 c5 01 00 00    	je     8cd <scan_scalar+0x2ad>
 708:	31 c0                	xor    %eax,%eax
 70a:	41 83 fc 10          	cmp    $0x10,%r12d
 70e:	0f 95 c0             	setne  %al
 711:	8d 04 85 04 00 00 00 	lea    0x4(,%rax,4),%eax
 718:	41 89 80 84 00 00 00 	mov    %eax,0x84(%r8)
 71f:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
 724:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 72c <scan_scalar+0x10c>
 72b:	00 
 72c:	0f 85 d9 01 00 00    	jne    90b <scan_scalar+0x2eb>
 732:	48 83 c4 38          	add    $0x38,%rsp
 736:	5b                   	pop    %rbx
 737:	5d                   	pop    %rbp
 738:	41 5c                	pop    %r12
 73a:	e9 00 00 00 00       	jmp    73f <scan_scalar+0x11f>
 73f:	4c 39 dd             	cmp    %r11,%rbp
 742:	0f 85 2e ff ff ff    	jne    676 <scan_scalar+0x56>
 748:	41 b9 0f 00 00 00    	mov    $0xf,%r9d
 74e:	b8 10 00 00 00       	mov    $0x10,%eax
 753:	41 bc 10 00 00 00    	mov    $0x10,%r12d
 759:	e9 29 ff ff ff       	jmp    687 <scan_scalar+0x67>
 75e:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
 765:	00 00 00 00 
 769:	48 89 f3             	mov    %rsi,%rbx
 76c:	48 c1 eb 05          	shr    $0x5,%rbx
 770:	49 89 fc             	mov    %rdi,%r12
 773:	31 ed                	xor    %ebp,%ebp
 775:	41 8b 44 24 04       	mov    0x4(%r12),%eax
 77a:	31 d2                	xor    %edx,%edx
 77c:	41 8b 4c 24 08       	mov    0x8(%r12),%ecx
 781:	41 8b 3c 24          	mov    (%r12),%edi
 785:	45 8b 4c 24 0c       	mov    0xc(%r12),%r9d
 78a:	85 c0                	test   %eax,%eax
 78c:	45 8b 54 24 10       	mov    0x10(%r12),%r10d
 791:	45 8b 5c 24 14       	mov    0x14(%r12),%r11d
 796:	0f 95 c2             	setne  %dl
 799:	31 f6                	xor    %esi,%esi
 79b:	41 8b 44 24 18       	mov    0x18(%r12),%eax
 7a0:	01 d2                	add    %edx,%edx
 7a2:	85 c9                	test   %ecx,%ecx
 7a4:	40 0f 95 c6          	setne  %sil
 7a8:	c1 e6 02             	shl    $0x2,%esi
 7ab:	09 f2                	or     %esi,%edx
 7ad:	31 f6                	xor    %esi,%esi
 7af:	85 ff                	test   %edi,%edi
 7b1:	40 0f 95 c6          	setne  %sil
 7b5:	09 f2                	or     %esi,%edx
 7b7:	31 f6                	xor    %esi,%esi
 7b9:	45 85 c9             	test   %r9d,%r9d
 7bc:	40 0f 95 c6          	setne  %sil
 7c0:	c1 e6 03             	shl    $0x3,%esi
 7c3:	09 f2                	or     %esi,%edx
 7c5:	31 f6                	xor    %esi,%esi
 7c7:	45 85 d2             	test   %r10d,%r10d
 7ca:	40 0f 95 c6          	setne  %sil
 7ce:	c1 e6 04             	shl    $0x4,%esi
 7d1:	09 d6                	or     %edx,%esi
 7d3:	31 d2                	xor    %edx,%edx
 7d5:	45 85 db             	test   %r11d,%r11d
 7d8:	0f 95 c2             	setne  %dl
 7db:	c1 e2 05             	shl    $0x5,%edx
 7de:	09 f2                	or     %esi,%edx
 7e0:	31 f6                	xor    %esi,%esi
 7e2:	85 c0                	test   %eax,%eax
 7e4:	41 8b 44 24 1c       	mov    0x1c(%r12),%eax
 7e9:	40 0f 95 c6          	setne  %sil
 7ed:	c1 e6 06             	shl    $0x6,%esi
 7f0:	09 d6                	or     %edx,%esi
 7f2:	31 d2                	xor    %edx,%edx
 7f4:	85 c0                	test   %eax,%eax
 7f6:	0f 95 c2             	setne  %dl
 7f9:	c1 e2 07             	shl    $0x7,%edx
 7fc:	09 f2                	or     %esi,%edx
 7fe:	48 81 fd 80 00 00 00 	cmp    $0x80,%rbp
 805:	0f 83 da 00 00 00    	jae    8e5 <scan_scalar+0x2c5>
 80b:	41 88 14 28          	mov    %dl,(%r8,%rbp,1)
 80f:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
 816:	48 83 c5 01          	add    $0x1,%rbp
 81a:	49 83 c4 20          	add    $0x20,%r12
 81e:	41 03 90 80 00 00 00 	add    0x80(%r8),%edx
 825:	41 89 90 80 00 00 00 	mov    %edx,0x80(%r8)
 82c:	48 39 dd             	cmp    %rbx,%rbp
 82f:	0f 85 40 ff ff ff    	jne    775 <scan_scalar+0x155>
 835:	e9 e5 fe ff ff       	jmp    71f <scan_scalar+0xff>
 83a:	4c 39 db             	cmp    %r11,%rbx
 83d:	0f 85 33 fe ff ff    	jne    676 <scan_scalar+0x56>
 843:	48 39 dd             	cmp    %rbx,%rbp
 846:	0f 85 2a fe ff ff    	jne    676 <scan_scalar+0x56>
 84c:	41 b9 07 00 00 00    	mov    $0x7,%r9d
 852:	b8 08 00 00 00       	mov    $0x8,%eax
 857:	41 bc 08 00 00 00    	mov    $0x8,%r12d
 85d:	e9 25 fe ff ff       	jmp    687 <scan_scalar+0x67>
 862:	4d 85 db             	test   %r11,%r11
 865:	75 29                	jne    890 <scan_scalar+0x270>
 867:	48 85 db             	test   %rbx,%rbx
 86a:	75 24                	jne    890 <scan_scalar+0x270>
 86c:	48 85 ed             	test   %rbp,%rbp
 86f:	75 1f                	jne    890 <scan_scalar+0x270>
 871:	41 c7 80 80 00 00 00 	movl   $0x0,0x80(%r8)
 878:	00 00 00 00 
 87c:	41 83 fc 08          	cmp    $0x8,%r12d
 880:	0f 85 82 fe ff ff    	jne    708 <scan_scalar+0xe8>
 886:	b8 01 00 00 00       	mov    $0x1,%eax
 88b:	e9 88 fe ff ff       	jmp    718 <scan_scalar+0xf8>
 890:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
 897:	01 00 00 00 
 89b:	41 83 fc 08          	cmp    $0x8,%r12d
 89f:	0f 85 63 fe ff ff    	jne    708 <scan_scalar+0xe8>
 8a5:	eb df                	jmp    886 <scan_scalar+0x266>
 8a7:	48 39 f0             	cmp    %rsi,%rax
 8aa:	0f 82 3a fe ff ff    	jb     6ea <scan_scalar+0xca>
 8b0:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
 8b7:	00 00 00 00 
 8bb:	48 89 f3             	mov    %rsi,%rbx
 8be:	48 c1 eb 05          	shr    $0x5,%rbx
 8c2:	0f 84 57 fe ff ff    	je     71f <scan_scalar+0xff>
 8c8:	e9 a3 fe ff ff       	jmp    770 <scan_scalar+0x150>
 8cd:	4c 89 d0             	mov    %r10,%rax
 8d0:	48 c1 e8 20          	shr    $0x20,%rax
 8d4:	41 39 c2             	cmp    %eax,%r10d
 8d7:	0f 95 c0             	setne  %al
 8da:	0f b6 c0             	movzbl %al,%eax
 8dd:	83 c0 01             	add    $0x1,%eax
 8e0:	e9 33 fe ff ff       	jmp    718 <scan_scalar+0xf8>
 8e5:	48 89 ee             	mov    %rbp,%rsi
 8e8:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 8ef:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
 8f4:	89 54 24 04          	mov    %edx,0x4(%rsp)
 8f8:	e8 00 00 00 00       	call   8fd <scan_scalar+0x2dd>
 8fd:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
 902:	8b 54 24 04          	mov    0x4(%rsp),%edx
 906:	e9 00 ff ff ff       	jmp    80b <scan_scalar+0x1eb>
 90b:	e8 00 00 00 00       	call   910 <scan_scalar+0x2f0>
 910:	90                   	nop
 911:	90                   	nop
 912:	90                   	nop
 913:	90                   	nop
 914:	90                   	nop
 915:	90                   	nop
 916:	90                   	nop
 917:	90                   	nop
 918:	90                   	nop
 919:	90                   	nop
 91a:	90                   	nop
 91b:	90                   	nop
 91c:	90                   	nop
 91d:	90                   	nop
 91e:	90                   	nop
 91f:	90                   	nop

0000000000000920 <encode.constprop.0>:
 920:	e8 00 00 00 00       	call   925 <encode.constprop.0+0x5>
 925:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
 92c:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 934 <encode.constprop.0+0x14>
 933:	00 
 934:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
 93b:	00 
 93c:	48 89 d0             	mov    %rdx,%rax
 93f:	41 8d 50 fb          	lea    -0x5(%r8),%edx
 943:	83 fa 07             	cmp    $0x7,%edx
 946:	0f 87 ea 01 00 00    	ja     b36 <encode.constprop.0+0x216>
 94c:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
 953:	0f 87 dd 01 00 00    	ja     b36 <encode.constprop.0+0x216>
 959:	48 85 c0             	test   %rax,%rax
 95c:	0f 84 d4 01 00 00    	je     b36 <encode.constprop.0+0x216>
 962:	48 85 ff             	test   %rdi,%rdi
 965:	49 89 c9             	mov    %rcx,%r9
 968:	4c 89 bc 24 18 01 00 	mov    %r15,0x118(%rsp)
 96f:	00 
 970:	49 89 ff             	mov    %rdi,%r15
 973:	0f 94 c1             	sete   %cl
 976:	48 85 f6             	test   %rsi,%rsi
 979:	0f 95 c2             	setne  %dl
 97c:	84 d1                	test   %dl,%cl
 97e:	0f 85 aa 01 00 00    	jne    b2e <encode.constprop.0+0x20e>
 984:	49 83 f9 07          	cmp    $0x7,%r9
 988:	0f 86 a0 01 00 00    	jbe    b2e <encode.constprop.0+0x20e>
 98e:	44 89 c1             	mov    %r8d,%ecx
 991:	4c 89 b4 24 10 01 00 	mov    %r14,0x110(%rsp)
 998:	00 
 999:	41 be 01 00 00 00    	mov    $0x1,%r14d
 99f:	49 d3 e6             	shl    %cl,%r14
 9a2:	48 89 9c 24 f0 00 00 	mov    %rbx,0xf0(%rsp)
 9a9:	00 
 9aa:	49 8d 5c 36 ff       	lea    -0x1(%r14,%rsi,1),%rbx
 9af:	48 89 ac 24 f8 00 00 	mov    %rbp,0xf8(%rsp)
 9b6:	00 
 9b7:	48 d3 eb             	shr    %cl,%rbx
 9ba:	48 8d 6b 08          	lea    0x8(%rbx),%rbp
 9be:	49 39 e9             	cmp    %rbp,%r9
 9c1:	0f 82 3f 02 00 00    	jb     c06 <encode.constprop.0+0x2e6>
 9c7:	31 c9                	xor    %ecx,%ecx
 9c9:	44 89 c2             	mov    %r8d,%edx
 9cc:	48 89 c7             	mov    %rax,%rdi
 9cf:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
 9d4:	44 89 44 24 10       	mov    %r8d,0x10(%rsp)
 9d9:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
 9de:	48 89 04 24          	mov    %rax,(%rsp)
 9e2:	e8 c9 f6 ff ff       	call   b0 <header>
 9e7:	48 85 db             	test   %rbx,%rbx
 9ea:	48 8b 04 24          	mov    (%rsp),%rax
 9ee:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 9f3:	44 8b 44 24 10       	mov    0x10(%rsp),%r8d
 9f8:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
 9fd:	0f 84 c2 03 00 00    	je     dc5 <encode.constprop.0+0x4a5>
 a03:	48 8d 4c 18 08       	lea    0x8(%rax,%rbx,1),%rcx
 a08:	4c 89 a4 24 00 01 00 	mov    %r12,0x100(%rsp)
 a0f:	00 
 a10:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
 a15:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
 a19:	48 89 0c 24          	mov    %rcx,(%rsp)
 a1d:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
 a22:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
 a27:	44 89 44 24 34       	mov    %r8d,0x34(%rsp)
 a2c:	4c 89 ac 24 08 01 00 	mov    %r13,0x108(%rsp)
 a33:	00 
 a34:	4d 89 fd             	mov    %r15,%r13
 a37:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
 a3c:	4c 8d 78 08          	lea    0x8(%rax),%r15
 a40:	48 8b 1c 24          	mov    (%rsp),%rbx
 a44:	4c 29 eb             	sub    %r13,%rbx
 a47:	4c 39 f3             	cmp    %r14,%rbx
 a4a:	49 0f 47 de          	cmova  %r14,%rbx
 a4e:	31 c0                	xor    %eax,%eax
 a50:	89 c2                	mov    %eax,%edx
 a52:	83 c0 20             	add    $0x20,%eax
 a55:	48 c7 44 14 60 00 00 	movq   $0x0,0x60(%rsp,%rdx,1)
 a5c:	00 00 
 a5e:	48 c7 44 14 68 00 00 	movq   $0x0,0x68(%rsp,%rdx,1)
 a65:	00 00 
 a67:	48 c7 44 14 70 00 00 	movq   $0x0,0x70(%rsp,%rdx,1)
 a6e:	00 00 
 a70:	48 c7 44 14 78 00 00 	movq   $0x0,0x78(%rsp,%rdx,1)
 a77:	00 00 
 a79:	3d 80 00 00 00       	cmp    $0x80,%eax
 a7e:	72 d0                	jb     a50 <encode.constprop.0+0x130>
 a80:	48 c7 44 04 60 00 00 	movq   $0x0,0x60(%rsp,%rax,1)
 a87:	00 00 
 a89:	49 89 dc             	mov    %rbx,%r12
 a8c:	41 83 e4 1f          	and    $0x1f,%r12d
 a90:	0f 84 c6 00 00 00    	je     b5c <encode.constprop.0+0x23c>
 a96:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 a9b:	48 29 e8             	sub    %rbp,%rax
 a9e:	48 39 d8             	cmp    %rbx,%rax
 aa1:	0f 82 cc 01 00 00    	jb     c73 <encode.constprop.0+0x353>
 aa7:	41 c6 07 00          	movb   $0x0,(%r15)
 aab:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 ab0:	4c 89 ee             	mov    %r13,%rsi
 ab3:	48 89 da             	mov    %rbx,%rdx
 ab6:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
 aba:	48 01 dd             	add    %rbx,%rbp
 abd:	e8 00 00 00 00       	call   ac2 <encode.constprop.0+0x1a2>
 ac2:	4d 01 f5             	add    %r14,%r13
 ac5:	49 83 c7 01          	add    $0x1,%r15
 ac9:	4c 39 7c 24 08       	cmp    %r15,0x8(%rsp)
 ace:	0f 85 6c ff ff ff    	jne    a40 <encode.constprop.0+0x120>
 ad4:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
 ad9:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
 ade:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 ae3:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
 ae8:	44 8b 44 24 34       	mov    0x34(%rsp),%r8d
 aed:	4c 8b a4 24 00 01 00 	mov    0x100(%rsp),%r12
 af4:	00 
 af5:	4c 8b ac 24 08 01 00 	mov    0x108(%rsp),%r13
 afc:	00 
 afd:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
 b01:	89 ea                	mov    %ebp,%edx
 b03:	48 39 cd             	cmp    %rcx,%rbp
 b06:	0f 83 fa 00 00 00    	jae    c06 <encode.constprop.0+0x2e6>
 b0c:	48 8b 9c 24 f0 00 00 	mov    0xf0(%rsp),%rbx
 b13:	00 
 b14:	48 8b ac 24 f8 00 00 	mov    0xf8(%rsp),%rbp
 b1b:	00 
 b1c:	4c 8b b4 24 10 01 00 	mov    0x110(%rsp),%r14
 b23:	00 
 b24:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 b2b:	00 
 b2c:	eb 0a                	jmp    b38 <encode.constprop.0+0x218>
 b2e:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 b35:	00 
 b36:	31 d2                	xor    %edx,%edx
 b38:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax
 b3f:	00 
 b40:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # b48 <encode.constprop.0+0x228>
 b47:	00 
 b48:	0f 85 a1 02 00 00    	jne    def <encode.constprop.0+0x4cf>
 b4e:	89 d0                	mov    %edx,%eax
 b50:	48 81 c4 20 01 00 00 	add    $0x120,%rsp
 b57:	e9 00 00 00 00       	jmp    b5c <encode.constprop.0+0x23c>
 b5c:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
 b61:	48 89 de             	mov    %rbx,%rsi
 b64:	4c 89 ef             	mov    %r13,%rdi
 b67:	e8 b4 fa ff ff       	call   620 <scan_scalar>
 b6c:	8b 84 24 e0 00 00 00 	mov    0xe0(%rsp),%eax
 b73:	85 c0                	test   %eax,%eax
 b75:	75 09                	jne    b80 <encode.constprop.0+0x260>
 b77:	41 c6 07 01          	movb   $0x1,(%r15)
 b7b:	e9 42 ff ff ff       	jmp    ac2 <encode.constprop.0+0x1a2>
 b80:	48 b9 02 00 00 00 03 	movabs $0x300000002,%rcx
 b87:	00 00 00 
 b8a:	8b 94 24 e4 00 00 00 	mov    0xe4(%rsp),%edx
 b91:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
 b96:	48 b9 05 00 00 00 06 	movabs $0x600000005,%rcx
 b9d:	00 00 00 
 ba0:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
 ba5:	f6 c2 01             	test   $0x1,%dl
 ba8:	74 13                	je     bbd <encode.constprop.0+0x29d>
 baa:	48 83 fb 04          	cmp    $0x4,%rbx
 bae:	0f 86 f3 fe ff ff    	jbe    aa7 <encode.constprop.0+0x187>
 bb4:	bb 04 00 00 00       	mov    $0x4,%ebx
 bb9:	31 f6                	xor    %esi,%esi
 bbb:	eb 26                	jmp    be3 <encode.constprop.0+0x2c3>
 bbd:	f6 c2 02             	test   $0x2,%dl
 bc0:	0f 85 8b 00 00 00    	jne    c51 <encode.constprop.0+0x331>
 bc6:	f6 c2 04             	test   $0x4,%dl
 bc9:	0f 84 18 01 00 00    	je     ce7 <encode.constprop.0+0x3c7>
 bcf:	48 83 fb 10          	cmp    $0x10,%rbx
 bd3:	0f 86 ce fe ff ff    	jbe    aa7 <encode.constprop.0+0x187>
 bd9:	bb 10 00 00 00       	mov    $0x10,%ebx
 bde:	be 02 00 00 00       	mov    $0x2,%esi
 be3:	8b 44 b4 50          	mov    0x50(%rsp,%rsi,4),%eax
 be7:	48 83 fe 04          	cmp    $0x4,%rsi
 beb:	0f 83 48 02 00 00    	jae    e39 <encode.constprop.0+0x519>
 bf1:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
 bf6:	48 29 ea             	sub    %rbp,%rdx
 bf9:	48 39 da             	cmp    %rbx,%rdx
 bfc:	72 75                	jb     c73 <encode.constprop.0+0x353>
 bfe:	41 88 07             	mov    %al,(%r15)
 c01:	e9 a5 fe ff ff       	jmp    aab <encode.constprop.0+0x18b>
 c06:	48 8b 94 24 e8 00 00 	mov    0xe8(%rsp),%rdx
 c0d:	00 
 c0e:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # c16 <encode.constprop.0+0x2f6>
 c15:	00 
 c16:	0f 85 08 02 00 00    	jne    e24 <encode.constprop.0+0x504>
 c1c:	48 8b 9c 24 f0 00 00 	mov    0xf0(%rsp),%rbx
 c23:	00 
 c24:	4c 89 ff             	mov    %r15,%rdi
 c27:	4c 89 c9             	mov    %r9,%rcx
 c2a:	48 89 c2             	mov    %rax,%rdx
 c2d:	48 8b ac 24 f8 00 00 	mov    0xf8(%rsp),%rbp
 c34:	00 
 c35:	4c 8b b4 24 10 01 00 	mov    0x110(%rsp),%r14
 c3c:	00 
 c3d:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 c44:	00 
 c45:	48 81 c4 20 01 00 00 	add    $0x120,%rsp
 c4c:	e9 8f f4 ff ff       	jmp    e0 <raw_page>
 c51:	48 83 fb 08          	cmp    $0x8,%rbx
 c55:	0f 86 4c fe ff ff    	jbe    aa7 <encode.constprop.0+0x187>
 c5b:	bb 08 00 00 00       	mov    $0x8,%ebx
 c60:	be 01 00 00 00       	mov    $0x1,%esi
 c65:	e9 79 ff ff ff       	jmp    be3 <encode.constprop.0+0x2c3>
 c6a:	48 39 da             	cmp    %rbx,%rdx
 c6d:	0f 83 34 fe ff ff    	jae    aa7 <encode.constprop.0+0x187>
 c73:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
 c78:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
 c7d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 c82:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
 c87:	44 8b 44 24 34       	mov    0x34(%rsp),%r8d
 c8c:	48 8b 94 24 e8 00 00 	mov    0xe8(%rsp),%rdx
 c93:	00 
 c94:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # c9c <encode.constprop.0+0x37c>
 c9b:	00 
 c9c:	0f 85 7d 01 00 00    	jne    e1f <encode.constprop.0+0x4ff>
 ca2:	48 8b 9c 24 f0 00 00 	mov    0xf0(%rsp),%rbx
 ca9:	00 
 caa:	48 8b ac 24 f8 00 00 	mov    0xf8(%rsp),%rbp
 cb1:	00 
 cb2:	4c 89 ff             	mov    %r15,%rdi
 cb5:	4c 89 c9             	mov    %r9,%rcx
 cb8:	4c 8b a4 24 00 01 00 	mov    0x100(%rsp),%r12
 cbf:	00 
 cc0:	4c 8b ac 24 08 01 00 	mov    0x108(%rsp),%r13
 cc7:	00 
 cc8:	48 89 c2             	mov    %rax,%rdx
 ccb:	4c 8b b4 24 10 01 00 	mov    0x110(%rsp),%r14
 cd2:	00 
 cd3:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 cda:	00 
 cdb:	48 81 c4 20 01 00 00 	add    $0x120,%rsp
 ce2:	e9 f9 f3 ff ff       	jmp    e0 <raw_page>
 ce7:	83 e2 08             	and    $0x8,%edx
 cea:	74 0a                	je     cf6 <encode.constprop.0+0x3d6>
 cec:	48 83 fb 20          	cmp    $0x20,%rbx
 cf0:	0f 87 d9 00 00 00    	ja     dcf <encode.constprop.0+0x4af>
 cf6:	49 89 db             	mov    %rbx,%r11
 cf9:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
 cfe:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
 d05:	49 c1 eb 05          	shr    $0x5,%r11
 d09:	4c 01 d8             	add    %r11,%rax
 d0c:	48 29 ea             	sub    %rbp,%rdx
 d0f:	48 39 d8             	cmp    %rbx,%rax
 d12:	0f 83 52 ff ff ff    	jae    c6a <encode.constprop.0+0x34a>
 d18:	48 39 c2             	cmp    %rax,%rdx
 d1b:	0f 82 52 ff ff ff    	jb     c73 <encode.constprop.0+0x353>
 d21:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 d26:	41 c6 07 04          	movb   $0x4,(%r15)
 d2a:	48 8d 74 24 60       	lea    0x60(%rsp),%rsi
 d2f:	4c 89 da             	mov    %r11,%rdx
 d32:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
 d37:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
 d3b:	e8 00 00 00 00       	call   d40 <encode.constprop.0+0x420>
 d40:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
 d45:	4c 01 dd             	add    %r11,%rbp
 d48:	4d 85 db             	test   %r11,%r11
 d4b:	0f 84 71 fd ff ff    	je     ac2 <encode.constprop.0+0x1a2>
 d51:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
 d56:	4c 89 db             	mov    %r11,%rbx
 d59:	4c 89 74 24 38       	mov    %r14,0x38(%rsp)
 d5e:	4d 89 ee             	mov    %r13,%r14
 d61:	4c 89 6c 24 40       	mov    %r13,0x40(%rsp)
 d66:	49 89 ed             	mov    %rbp,%r13
 d69:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
 d6e:	49 81 fc 80 00 00 00 	cmp    $0x80,%r12
 d75:	73 67                	jae    dde <encode.constprop.0+0x4be>
 d77:	46 0f b6 7c 24 60    	movzbl 0x60(%rsp,%r12,1),%r15d
 d7d:	4a 8d 74 2d 00       	lea    0x0(%rbp,%r13,1),%rsi
 d82:	4c 89 f7             	mov    %r14,%rdi
 d85:	49 83 c4 01          	add    $0x1,%r12
 d89:	49 83 c6 20          	add    $0x20,%r14
 d8d:	44 89 fa             	mov    %r15d,%edx
 d90:	e8 7b f2 ff ff       	call   10 <pack_scalar>
 d95:	44 89 f8             	mov    %r15d,%eax
 d98:	0f b6 80 00 00 00 00 	movzbl 0x0(%rax),%eax
 d9f:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
 da6:	49 01 c5             	add    %rax,%r13
 da9:	4c 39 e3             	cmp    %r12,%rbx
 dac:	75 c0                	jne    d6e <encode.constprop.0+0x44e>
 dae:	4c 89 ed             	mov    %r13,%rbp
 db1:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
 db6:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
 dbb:	4c 8b 7c 24 48       	mov    0x48(%rsp),%r15
 dc0:	e9 fd fc ff ff       	jmp    ac2 <encode.constprop.0+0x1a2>
 dc5:	bd 08 00 00 00       	mov    $0x8,%ebp
 dca:	e9 2e fd ff ff       	jmp    afd <encode.constprop.0+0x1dd>
 dcf:	bb 20 00 00 00       	mov    $0x20,%ebx
 dd4:	be 03 00 00 00       	mov    $0x3,%esi
 dd9:	e9 05 fe ff ff       	jmp    be3 <encode.constprop.0+0x2c3>
 dde:	4c 89 e6             	mov    %r12,%rsi
 de1:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 de8:	e8 00 00 00 00       	call   ded <encode.constprop.0+0x4cd>
 ded:	eb 88                	jmp    d77 <encode.constprop.0+0x457>
 def:	48 89 9c 24 f0 00 00 	mov    %rbx,0xf0(%rsp)
 df6:	00 
 df7:	48 89 ac 24 f8 00 00 	mov    %rbp,0xf8(%rsp)
 dfe:	00 
 dff:	4c 89 a4 24 00 01 00 	mov    %r12,0x100(%rsp)
 e06:	00 
 e07:	4c 89 ac 24 08 01 00 	mov    %r13,0x108(%rsp)
 e0e:	00 
 e0f:	4c 89 b4 24 10 01 00 	mov    %r14,0x110(%rsp)
 e16:	00 
 e17:	4c 89 bc 24 18 01 00 	mov    %r15,0x118(%rsp)
 e1e:	00 
 e1f:	e8 00 00 00 00       	call   e24 <encode.constprop.0+0x504>
 e24:	4c 89 a4 24 00 01 00 	mov    %r12,0x100(%rsp)
 e2b:	00 
 e2c:	4c 89 ac 24 08 01 00 	mov    %r13,0x108(%rsp)
 e33:	00 
 e34:	e8 00 00 00 00       	call   e39 <encode.constprop.0+0x519>
 e39:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 e40:	89 44 24 38          	mov    %eax,0x38(%rsp)
 e44:	e8 00 00 00 00       	call   e49 <encode.constprop.0+0x529>
 e49:	8b 44 24 38          	mov    0x38(%rsp),%eax
 e4d:	e9 9f fd ff ff       	jmp    bf1 <encode.constprop.0+0x2d1>
 e52:	0f 1f 00             	nopl   (%rax)
 e55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 e5c:	00 00 00 00 
 e60:	90                   	nop
 e61:	90                   	nop
 e62:	90                   	nop
 e63:	90                   	nop
 e64:	90                   	nop
 e65:	90                   	nop
 e66:	90                   	nop
 e67:	90                   	nop
 e68:	90                   	nop
 e69:	90                   	nop
 e6a:	90                   	nop
 e6b:	90                   	nop
 e6c:	90                   	nop
 e6d:	90                   	nop
 e6e:	90                   	nop
 e6f:	90                   	nop

0000000000000e70 <n100_decoder_avx2_available>:
 e70:	f3 0f 1e fa          	endbr64
 e74:	e8 00 00 00 00       	call   e79 <n100_decoder_avx2_available+0x9>
 e79:	31 c0                	xor    %eax,%eax
 e7b:	e9 00 00 00 00       	jmp    e80 <n100_decoder_avx2_available+0x10>
 e80:	90                   	nop
 e81:	90                   	nop
 e82:	90                   	nop
 e83:	90                   	nop
 e84:	90                   	nop
 e85:	90                   	nop
 e86:	90                   	nop
 e87:	90                   	nop
 e88:	90                   	nop
 e89:	90                   	nop
 e8a:	90                   	nop
 e8b:	90                   	nop
 e8c:	90                   	nop
 e8d:	90                   	nop
 e8e:	90                   	nop
 e8f:	90                   	nop

0000000000000e90 <n100_decoder_encode_scalar>:
 e90:	f3 0f 1e fa          	endbr64
 e94:	e8 00 00 00 00       	call   e99 <n100_decoder_encode_scalar+0x9>
 e99:	e9 82 fa ff ff       	jmp    920 <encode.constprop.0>
 e9e:	66 90                	xchg   %ax,%ax
 ea0:	90                   	nop
 ea1:	90                   	nop
 ea2:	90                   	nop
 ea3:	90                   	nop
 ea4:	90                   	nop
 ea5:	90                   	nop
 ea6:	90                   	nop
 ea7:	90                   	nop
 ea8:	90                   	nop
 ea9:	90                   	nop
 eaa:	90                   	nop
 eab:	90                   	nop
 eac:	90                   	nop
 ead:	90                   	nop
 eae:	90                   	nop
 eaf:	90                   	nop

0000000000000eb0 <n100_decoder_encode_avx2>:
 eb0:	f3 0f 1e fa          	endbr64
 eb4:	e8 00 00 00 00       	call   eb9 <n100_decoder_encode_avx2+0x9>
 eb9:	e9 62 fa ff ff       	jmp    920 <encode.constprop.0>
 ebe:	66 90                	xchg   %ax,%ax
 ec0:	90                   	nop
 ec1:	90                   	nop
 ec2:	90                   	nop
 ec3:	90                   	nop
 ec4:	90                   	nop
 ec5:	90                   	nop
 ec6:	90                   	nop
 ec7:	90                   	nop
 ec8:	90                   	nop
 ec9:	90                   	nop
 eca:	90                   	nop
 ecb:	90                   	nop
 ecc:	90                   	nop
 ecd:	90                   	nop
 ece:	90                   	nop
 ecf:	90                   	nop

0000000000000ed0 <n100_decoder_decode_scalar>:
 ed0:	f3 0f 1e fa          	endbr64
 ed4:	e8 00 00 00 00       	call   ed9 <n100_decoder_decode_scalar+0x9>
 ed9:	e9 62 f3 ff ff       	jmp    240 <decode.constprop.0>
 ede:	66 90                	xchg   %ax,%ax
 ee0:	90                   	nop
 ee1:	90                   	nop
 ee2:	90                   	nop
 ee3:	90                   	nop
 ee4:	90                   	nop
 ee5:	90                   	nop
 ee6:	90                   	nop
 ee7:	90                   	nop
 ee8:	90                   	nop
 ee9:	90                   	nop
 eea:	90                   	nop
 eeb:	90                   	nop
 eec:	90                   	nop
 eed:	90                   	nop
 eee:	90                   	nop
 eef:	90                   	nop

0000000000000ef0 <n100_decoder_decode_avx2>:
 ef0:	f3 0f 1e fa          	endbr64
 ef4:	e8 00 00 00 00       	call   ef9 <n100_decoder_decode_avx2+0x9>
 ef9:	e9 42 f3 ff ff       	jmp    240 <decode.constprop.0>
