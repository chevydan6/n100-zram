
/home/dan/n100-zram/build/astra-simd-kernel-002/scalar/encoder/core.o:     file format elf64-x86-64


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
  19:	81 fa ff 00 00 00    	cmp    $0xff,%edx
  1f:	74 42                	je     63 <pack_scalar+0x53>
  21:	85 d2                	test   %edx,%edx
  23:	74 61                	je     86 <pack_scalar+0x76>
  25:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  2a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  31:	00 00 00 00 
  35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  3c:	00 00 00 00 
  40:	31 c9                	xor    %ecx,%ecx
  42:	8d 42 ff             	lea    -0x1(%rdx),%eax
  45:	48 83 c6 04          	add    $0x4,%rsi
  49:	f3 0f bc ca          	tzcnt  %edx,%ecx
  4d:	8d 0c 8d 00 00 00 00 	lea    0x0(,%rcx,4),%ecx
  54:	8b 0c 0f             	mov    (%rdi,%rcx,1),%ecx
  57:	89 4e fc             	mov    %ecx,-0x4(%rsi)
  5a:	21 c2                	and    %eax,%edx
  5c:	75 e2                	jne    40 <pack_scalar+0x30>
  5e:	e9 00 00 00 00       	jmp    63 <pack_scalar+0x53>
  63:	48 8b 07             	mov    (%rdi),%rax
  66:	48 89 06             	mov    %rax,(%rsi)
  69:	48 8b 47 08          	mov    0x8(%rdi),%rax
  6d:	48 89 46 08          	mov    %rax,0x8(%rsi)
  71:	48 8b 47 10          	mov    0x10(%rdi),%rax
  75:	48 89 46 10          	mov    %rax,0x10(%rsi)
  79:	48 8b 47 18          	mov    0x18(%rdi),%rax
  7d:	48 89 46 18          	mov    %rax,0x18(%rsi)
  81:	e9 00 00 00 00       	jmp    86 <pack_scalar+0x76>
  86:	e9 00 00 00 00       	jmp    8b <pack_scalar+0x7b>
  8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  90:	90                   	nop
  91:	90                   	nop
  92:	90                   	nop
  93:	90                   	nop
  94:	90                   	nop
  95:	90                   	nop
  96:	90                   	nop
  97:	90                   	nop
  98:	90                   	nop
  99:	90                   	nop
  9a:	90                   	nop
  9b:	90                   	nop
  9c:	90                   	nop
  9d:	90                   	nop
  9e:	90                   	nop
  9f:	90                   	nop

00000000000000a0 <header>:
  a0:	e8 00 00 00 00       	call   a5 <header+0x5>
  a5:	c7 07 47 5a 52 31    	movl   $0x31525a47,(%rdi)
  ab:	66 89 77 04          	mov    %si,0x4(%rdi)
  af:	88 57 06             	mov    %dl,0x6(%rdi)
  b2:	88 4f 07             	mov    %cl,0x7(%rdi)
  b5:	e9 00 00 00 00       	jmp    ba <header+0x1a>
  ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  c0:	90                   	nop
  c1:	90                   	nop
  c2:	90                   	nop
  c3:	90                   	nop
  c4:	90                   	nop
  c5:	90                   	nop
  c6:	90                   	nop
  c7:	90                   	nop
  c8:	90                   	nop
  c9:	90                   	nop
  ca:	90                   	nop
  cb:	90                   	nop
  cc:	90                   	nop
  cd:	90                   	nop
  ce:	90                   	nop
  cf:	90                   	nop

00000000000000d0 <raw_page>:
  d0:	e8 00 00 00 00       	call   d5 <raw_page+0x5>
  d5:	49 89 c9             	mov    %rcx,%r9
  d8:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
  dc:	49 39 c9             	cmp    %rcx,%r9
  df:	72 51                	jb     132 <raw_page+0x62>
  e1:	53                   	push   %rbx
  e2:	48 89 f3             	mov    %rsi,%rbx
  e5:	49 89 d1             	mov    %rdx,%r9
  e8:	48 89 fe             	mov    %rdi,%rsi
  eb:	48 83 ec 10          	sub    $0x10,%rsp
  ef:	48 85 db             	test   %rbx,%rbx
  f2:	74 1e                	je     112 <raw_page+0x42>
  f4:	49 8d 79 08          	lea    0x8(%r9),%rdi
  f8:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
  fd:	48 89 da             	mov    %rbx,%rdx
 100:	4c 89 0c 24          	mov    %r9,(%rsp)
 104:	e8 00 00 00 00       	call   109 <raw_page+0x39>
 109:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
 10e:	4c 8b 0c 24          	mov    (%rsp),%r9
 112:	48 89 de             	mov    %rbx,%rsi
 115:	b9 01 00 00 00       	mov    $0x1,%ecx
 11a:	44 89 c2             	mov    %r8d,%edx
 11d:	4c 89 cf             	mov    %r9,%rdi
 120:	e8 7b ff ff ff       	call   a0 <header>
 125:	8d 43 08             	lea    0x8(%rbx),%eax
 128:	48 83 c4 10          	add    $0x10,%rsp
 12c:	5b                   	pop    %rbx
 12d:	e9 00 00 00 00       	jmp    132 <raw_page+0x62>
 132:	31 c0                	xor    %eax,%eax
 134:	e9 00 00 00 00       	jmp    139 <raw_page+0x69>
 139:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 140:	90                   	nop
 141:	90                   	nop
 142:	90                   	nop
 143:	90                   	nop
 144:	90                   	nop
 145:	90                   	nop
 146:	90                   	nop
 147:	90                   	nop
 148:	90                   	nop
 149:	90                   	nop
 14a:	90                   	nop
 14b:	90                   	nop
 14c:	90                   	nop
 14d:	90                   	nop
 14e:	90                   	nop
 14f:	90                   	nop

0000000000000150 <repeat_scalar>:
 150:	f3 0f 1e fa          	endbr64
 154:	e8 00 00 00 00       	call   159 <repeat_scalar+0x9>
 159:	48 85 d2             	test   %rdx,%rdx
 15c:	74 41                	je     19f <repeat_scalar+0x4f>
 15e:	41 57                	push   %r15
 160:	41 56                	push   %r14
 162:	49 89 f6             	mov    %rsi,%r14
 165:	41 55                	push   %r13
 167:	49 89 fd             	mov    %rdi,%r13
 16a:	41 54                	push   %r12
 16c:	49 89 d4             	mov    %rdx,%r12
 16f:	55                   	push   %rbp
 170:	89 cd                	mov    %ecx,%ebp
 172:	53                   	push   %rbx
 173:	31 db                	xor    %ebx,%ebx
 175:	49 89 ef             	mov    %rbp,%r15
 178:	49 8d 7c 1d 00       	lea    0x0(%r13,%rbx,1),%rdi
 17d:	4c 89 fa             	mov    %r15,%rdx
 180:	4c 89 f6             	mov    %r14,%rsi
 183:	48 01 eb             	add    %rbp,%rbx
 186:	e8 00 00 00 00       	call   18b <repeat_scalar+0x3b>
 18b:	4c 39 e3             	cmp    %r12,%rbx
 18e:	72 e8                	jb     178 <repeat_scalar+0x28>
 190:	5b                   	pop    %rbx
 191:	5d                   	pop    %rbp
 192:	41 5c                	pop    %r12
 194:	41 5d                	pop    %r13
 196:	41 5e                	pop    %r14
 198:	41 5f                	pop    %r15
 19a:	e9 00 00 00 00       	jmp    19f <repeat_scalar+0x4f>
 19f:	e9 00 00 00 00       	jmp    1a4 <repeat_scalar+0x54>
 1a4:	90                   	nop
 1a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 1ac:	00 00 00 00 
 1b0:	90                   	nop
 1b1:	90                   	nop
 1b2:	90                   	nop
 1b3:	90                   	nop
 1b4:	90                   	nop
 1b5:	90                   	nop
 1b6:	90                   	nop
 1b7:	90                   	nop
 1b8:	90                   	nop
 1b9:	90                   	nop
 1ba:	90                   	nop
 1bb:	90                   	nop
 1bc:	90                   	nop
 1bd:	90                   	nop
 1be:	90                   	nop
 1bf:	90                   	nop

00000000000001c0 <unpack_scalar>:
 1c0:	f3 0f 1e fa          	endbr64
 1c4:	e8 00 00 00 00       	call   1c9 <unpack_scalar+0x9>
 1c9:	f6 c2 01             	test   $0x1,%dl
 1cc:	0f 85 bc 00 00 00    	jne    28e <unpack_scalar+0xce>
 1d2:	c7 06 00 00 00 00    	movl   $0x0,(%rsi)
 1d8:	f6 c2 02             	test   $0x2,%dl
 1db:	0f 85 9f 00 00 00    	jne    280 <unpack_scalar+0xc0>
 1e1:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%rsi)
 1e8:	f6 c2 04             	test   $0x4,%dl
 1eb:	0f 85 81 00 00 00    	jne    272 <unpack_scalar+0xb2>
 1f1:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%rsi)
 1f8:	f6 c2 08             	test   $0x8,%dl
 1fb:	75 6a                	jne    267 <unpack_scalar+0xa7>
 1fd:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%rsi)
 204:	f6 c2 10             	test   $0x10,%dl
 207:	75 53                	jne    25c <unpack_scalar+0x9c>
 209:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%rsi)
 210:	f6 c2 20             	test   $0x20,%dl
 213:	75 3c                	jne    251 <unpack_scalar+0x91>
 215:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%rsi)
 21c:	f6 c2 40             	test   $0x40,%dl
 21f:	75 25                	jne    246 <unpack_scalar+0x86>
 221:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%rsi)
 228:	81 e2 80 00 00 00    	and    $0x80,%edx
 22e:	74 0a                	je     23a <unpack_scalar+0x7a>
 230:	8b 07                	mov    (%rdi),%eax
 232:	89 46 1c             	mov    %eax,0x1c(%rsi)
 235:	e9 00 00 00 00       	jmp    23a <unpack_scalar+0x7a>
 23a:	c7 46 1c 00 00 00 00 	movl   $0x0,0x1c(%rsi)
 241:	e9 00 00 00 00       	jmp    246 <unpack_scalar+0x86>
 246:	8b 07                	mov    (%rdi),%eax
 248:	48 83 c7 04          	add    $0x4,%rdi
 24c:	89 46 18             	mov    %eax,0x18(%rsi)
 24f:	eb d7                	jmp    228 <unpack_scalar+0x68>
 251:	8b 07                	mov    (%rdi),%eax
 253:	48 83 c7 04          	add    $0x4,%rdi
 257:	89 46 14             	mov    %eax,0x14(%rsi)
 25a:	eb c0                	jmp    21c <unpack_scalar+0x5c>
 25c:	8b 07                	mov    (%rdi),%eax
 25e:	48 83 c7 04          	add    $0x4,%rdi
 262:	89 46 10             	mov    %eax,0x10(%rsi)
 265:	eb a9                	jmp    210 <unpack_scalar+0x50>
 267:	8b 07                	mov    (%rdi),%eax
 269:	48 83 c7 04          	add    $0x4,%rdi
 26d:	89 46 0c             	mov    %eax,0xc(%rsi)
 270:	eb 92                	jmp    204 <unpack_scalar+0x44>
 272:	8b 07                	mov    (%rdi),%eax
 274:	48 83 c7 04          	add    $0x4,%rdi
 278:	89 46 08             	mov    %eax,0x8(%rsi)
 27b:	e9 78 ff ff ff       	jmp    1f8 <unpack_scalar+0x38>
 280:	8b 07                	mov    (%rdi),%eax
 282:	48 83 c7 04          	add    $0x4,%rdi
 286:	89 46 04             	mov    %eax,0x4(%rsi)
 289:	e9 5a ff ff ff       	jmp    1e8 <unpack_scalar+0x28>
 28e:	8b 07                	mov    (%rdi),%eax
 290:	48 83 c7 04          	add    $0x4,%rdi
 294:	89 06                	mov    %eax,(%rsi)
 296:	e9 3d ff ff ff       	jmp    1d8 <unpack_scalar+0x18>
 29b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
 2a0:	90                   	nop
 2a1:	90                   	nop
 2a2:	90                   	nop
 2a3:	90                   	nop
 2a4:	90                   	nop
 2a5:	90                   	nop
 2a6:	90                   	nop
 2a7:	90                   	nop
 2a8:	90                   	nop
 2a9:	90                   	nop
 2aa:	90                   	nop
 2ab:	90                   	nop
 2ac:	90                   	nop
 2ad:	90                   	nop
 2ae:	90                   	nop
 2af:	90                   	nop

00000000000002b0 <decode.constprop.0>:
 2b0:	e8 00 00 00 00       	call   2b5 <decode.constprop.0+0x5>
 2b5:	48 8d 46 f8          	lea    -0x8(%rsi),%rax
 2b9:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
 2bf:	0f 87 97 03 00 00    	ja     65c <decode.constprop.0+0x3ac>
 2c5:	48 85 ff             	test   %rdi,%rdi
 2c8:	0f 84 8e 03 00 00    	je     65c <decode.constprop.0+0x3ac>
 2ce:	81 3f 47 5a 52 31    	cmpl   $0x31525a47,(%rdi)
 2d4:	0f 85 82 03 00 00    	jne    65c <decode.constprop.0+0x3ac>
 2da:	48 83 ec 70          	sub    $0x70,%rsp
 2de:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
 2e3:	48 89 d5             	mov    %rdx,%rbp
 2e6:	48 89 ca             	mov    %rcx,%rdx
 2e9:	0f b6 4f 06          	movzbl 0x6(%rdi),%ecx
 2ed:	8d 41 fb             	lea    -0x5(%rcx),%eax
 2f0:	3c 07                	cmp    $0x7,%al
 2f2:	0f 87 69 02 00 00    	ja     561 <decode.constprop.0+0x2b1>
 2f8:	44 0f b6 47 07       	movzbl 0x7(%rdi),%r8d
 2fd:	41 80 f8 01          	cmp    $0x1,%r8b
 301:	0f 87 5a 02 00 00    	ja     561 <decode.constprop.0+0x2b1>
 307:	41 b9 00 10 00 00    	mov    $0x1000,%r9d
 30d:	0f b7 47 04          	movzwl 0x4(%rdi),%eax
 311:	4c 39 ca             	cmp    %r9,%rdx
 314:	49 0f 47 d1          	cmova  %r9,%rdx
 318:	49 89 c2             	mov    %rax,%r10
 31b:	48 39 c2             	cmp    %rax,%rdx
 31e:	0f 82 3d 02 00 00    	jb     561 <decode.constprop.0+0x2b1>
 324:	48 85 ed             	test   %rbp,%rbp
 327:	75 09                	jne    332 <decode.constprop.0+0x82>
 329:	48 85 c0             	test   %rax,%rax
 32c:	0f 85 2f 02 00 00    	jne    561 <decode.constprop.0+0x2b1>
 332:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
 337:	45 84 c0             	test   %r8b,%r8b
 33a:	0f 85 db 01 00 00    	jne    51b <decode.constprop.0+0x26b>
 340:	41 b9 01 00 00 00    	mov    $0x1,%r9d
 346:	4c 89 6c 24 58       	mov    %r13,0x58(%rsp)
 34b:	49 d3 e1             	shl    %cl,%r9
 34e:	48 89 5c 24 40       	mov    %rbx,0x40(%rsp)
 353:	4e 8d 6c 08 ff       	lea    -0x1(%rax,%r9,1),%r13
 358:	49 d3 ed             	shr    %cl,%r13
 35b:	49 8d 5d 08          	lea    0x8(%r13),%rbx
 35f:	48 39 de             	cmp    %rbx,%rsi
 362:	0f 82 0f 03 00 00    	jb     677 <decode.constprop.0+0x3c7>
 368:	4d 85 ed             	test   %r13,%r13
 36b:	0f 84 ff 02 00 00    	je     670 <decode.constprop.0+0x3c0>
 371:	48 01 e8             	add    %rbp,%rax
 374:	4a 8d 4c 2f 08       	lea    0x8(%rdi,%r13,1),%rcx
 379:	4c 89 74 24 60       	mov    %r14,0x60(%rsp)
 37e:	49 89 ee             	mov    %rbp,%r14
 381:	4c 89 7c 24 68       	mov    %r15,0x68(%rsp)
 386:	48 8d 6f 08          	lea    0x8(%rdi),%rbp
 38a:	49 89 df             	mov    %rbx,%r15
 38d:	4c 89 cb             	mov    %r9,%rbx
 390:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
 395:	48 89 04 24          	mov    %rax,(%rsp)
 399:	66 44 89 54 24 3e    	mov    %r10w,0x3e(%rsp)
 39f:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
 3a4:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
 3a9:	eb 4a                	jmp    3f5 <decode.constprop.0+0x145>
 3ab:	3c 01                	cmp    $0x1,%al
 3ad:	0f 84 0e 02 00 00    	je     5c1 <decode.constprop.0+0x311>
 3b3:	3c 02                	cmp    $0x2,%al
 3b5:	0f 84 b9 01 00 00    	je     574 <decode.constprop.0+0x2c4>
 3bb:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
 3c0:	4c 29 f8             	sub    %r15,%rax
 3c3:	4c 39 e8             	cmp    %r13,%rax
 3c6:	0f 82 7c 01 00 00    	jb     548 <decode.constprop.0+0x298>
 3cc:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 3d1:	4c 89 f7             	mov    %r14,%rdi
 3d4:	4c 89 ea             	mov    %r13,%rdx
 3d7:	4a 8d 34 38          	lea    (%rax,%r15,1),%rsi
 3db:	4d 01 ef             	add    %r13,%r15
 3de:	e8 00 00 00 00       	call   3e3 <decode.constprop.0+0x133>
 3e3:	48 83 c5 01          	add    $0x1,%rbp
 3e7:	49 01 de             	add    %rbx,%r14
 3ea:	48 39 6c 24 10       	cmp    %rbp,0x10(%rsp)
 3ef:	0f 84 21 02 00 00    	je     616 <decode.constprop.0+0x366>
 3f5:	4c 8b 2c 24          	mov    (%rsp),%r13
 3f9:	0f b6 45 00          	movzbl 0x0(%rbp),%eax
 3fd:	4d 29 f5             	sub    %r14,%r13
 400:	49 39 dd             	cmp    %rbx,%r13
 403:	4c 0f 47 eb          	cmova  %rbx,%r13
 407:	3c 03                	cmp    $0x3,%al
 409:	0f 84 c4 01 00 00    	je     5d3 <decode.constprop.0+0x323>
 40f:	76 9a                	jbe    3ab <decode.constprop.0+0xfb>
 411:	3c 05                	cmp    $0x5,%al
 413:	0f 84 d4 01 00 00    	je     5ed <decode.constprop.0+0x33d>
 419:	3c 06                	cmp    $0x6,%al
 41b:	0f 84 bf 01 00 00    	je     5e0 <decode.constprop.0+0x330>
 421:	3c 04                	cmp    $0x4,%al
 423:	0f 85 1f 01 00 00    	jne    548 <decode.constprop.0+0x298>
 429:	4c 89 ee             	mov    %r13,%rsi
 42c:	83 e6 1f             	and    $0x1f,%esi
 42f:	0f 85 13 01 00 00    	jne    548 <decode.constprop.0+0x298>
 435:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
 43a:	49 c1 ed 05          	shr    $0x5,%r13
 43e:	4c 29 f8             	sub    %r15,%rax
 441:	4c 39 e8             	cmp    %r13,%rax
 444:	0f 82 fe 00 00 00    	jb     548 <decode.constprop.0+0x298>
 44a:	4f 8d 54 3d 00       	lea    0x0(%r13,%r15,1),%r10
 44f:	4d 85 ed             	test   %r13,%r13
 452:	0f 84 fc 01 00 00    	je     654 <decode.constprop.0+0x3a4>
 458:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 45d:	4c 01 f8             	add    %r15,%rax
 460:	4a 8d 14 28          	lea    (%rax,%r13,1),%rdx
 464:	48 89 c1             	mov    %rax,%rcx
 467:	0f 1f 00             	nopl   (%rax)
 46a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 471:	00 00 00 00 
 475:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 47c:	00 00 00 00 
 480:	0f b6 39             	movzbl (%rcx),%edi
 483:	48 83 c1 01          	add    $0x1,%rcx
 487:	0f b6 bf 00 00 00 00 	movzbl 0x0(%rdi),%edi
 48e:	8d 3c bd 00 00 00 00 	lea    0x0(,%rdi,4),%edi
 495:	48 01 fe             	add    %rdi,%rsi
 498:	48 39 d1             	cmp    %rdx,%rcx
 49b:	75 e3                	jne    480 <decode.constprop.0+0x1d0>
 49d:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
 4a2:	4c 29 d1             	sub    %r10,%rcx
 4a5:	48 39 f1             	cmp    %rsi,%rcx
 4a8:	0f 82 9a 00 00 00    	jb     548 <decode.constprop.0+0x298>
 4ae:	4d 89 f4             	mov    %r14,%r12
 4b1:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
 4b6:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
 4bb:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
 4c0:	4d 89 e7             	mov    %r12,%r15
 4c3:	4d 89 d6             	mov    %r10,%r14
 4c6:	49 89 d4             	mov    %rdx,%r12
 4c9:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
 4ce:	48 89 c5             	mov    %rax,%rbp
 4d1:	44 0f b6 6d 00       	movzbl 0x0(%rbp),%r13d
 4d6:	4a 8d 3c 33          	lea    (%rbx,%r14,1),%rdi
 4da:	4c 89 fe             	mov    %r15,%rsi
 4dd:	48 83 c5 01          	add    $0x1,%rbp
 4e1:	49 83 c7 20          	add    $0x20,%r15
 4e5:	44 89 ea             	mov    %r13d,%edx
 4e8:	e8 d3 fc ff ff       	call   1c0 <unpack_scalar>
 4ed:	41 0f b6 95 00 00 00 	movzbl 0x0(%r13),%edx
 4f4:	00 
 4f5:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
 4fc:	49 01 d6             	add    %rdx,%r14
 4ff:	49 39 ec             	cmp    %rbp,%r12
 502:	75 cd                	jne    4d1 <decode.constprop.0+0x221>
 504:	4d 89 f7             	mov    %r14,%r15
 507:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
 50c:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
 511:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
 516:	e9 c8 fe ff ff       	jmp    3e3 <decode.constprop.0+0x133>
 51b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 51f:	48 39 d6             	cmp    %rdx,%rsi
 522:	0f 85 3e 01 00 00    	jne    666 <decode.constprop.0+0x3b6>
 528:	48 85 c0             	test   %rax,%rax
 52b:	0f 85 c9 00 00 00    	jne    5fa <decode.constprop.0+0x34a>
 531:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 536:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
 53b:	41 0f b7 c2          	movzwl %r10w,%eax
 53f:	48 83 c4 70          	add    $0x70,%rsp
 543:	e9 00 00 00 00       	jmp    548 <decode.constprop.0+0x298>
 548:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
 54d:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 552:	4c 8b 6c 24 58       	mov    0x58(%rsp),%r13
 557:	4c 8b 74 24 60       	mov    0x60(%rsp),%r14
 55c:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
 561:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
 566:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 56b:	48 83 c4 70          	add    $0x70,%rsp
 56f:	e9 00 00 00 00       	jmp    574 <decode.constprop.0+0x2c4>
 574:	41 ba 04 00 00 00    	mov    $0x4,%r10d
 57a:	b9 04 00 00 00       	mov    $0x4,%ecx
 57f:	4c 89 e8             	mov    %r13,%rax
 582:	31 d2                	xor    %edx,%edx
 584:	49 f7 f2             	div    %r10
 587:	48 85 d2             	test   %rdx,%rdx
 58a:	75 bc                	jne    548 <decode.constprop.0+0x298>
 58c:	4d 39 d5             	cmp    %r10,%r13
 58f:	72 b7                	jb     548 <decode.constprop.0+0x298>
 591:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
 596:	4c 29 f8             	sub    %r15,%rax
 599:	4c 39 d0             	cmp    %r10,%rax
 59c:	72 aa                	jb     548 <decode.constprop.0+0x298>
 59e:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 5a3:	4c 89 ea             	mov    %r13,%rdx
 5a6:	4c 89 f7             	mov    %r14,%rdi
 5a9:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
 5ae:	4a 8d 34 38          	lea    (%rax,%r15,1),%rsi
 5b2:	e8 99 fb ff ff       	call   150 <repeat_scalar>
 5b7:	4c 03 7c 24 20       	add    0x20(%rsp),%r15
 5bc:	e9 22 fe ff ff       	jmp    3e3 <decode.constprop.0+0x133>
 5c1:	4c 89 ea             	mov    %r13,%rdx
 5c4:	31 f6                	xor    %esi,%esi
 5c6:	4c 89 f7             	mov    %r14,%rdi
 5c9:	e8 00 00 00 00       	call   5ce <decode.constprop.0+0x31e>
 5ce:	e9 10 fe ff ff       	jmp    3e3 <decode.constprop.0+0x133>
 5d3:	41 ba 08 00 00 00    	mov    $0x8,%r10d
 5d9:	b9 08 00 00 00       	mov    $0x8,%ecx
 5de:	eb 9f                	jmp    57f <decode.constprop.0+0x2cf>
 5e0:	41 ba 20 00 00 00    	mov    $0x20,%r10d
 5e6:	b9 20 00 00 00       	mov    $0x20,%ecx
 5eb:	eb 92                	jmp    57f <decode.constprop.0+0x2cf>
 5ed:	41 ba 10 00 00 00    	mov    $0x10,%r10d
 5f3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5f8:	eb 85                	jmp    57f <decode.constprop.0+0x2cf>
 5fa:	48 8d 77 08          	lea    0x8(%rdi),%rsi
 5fe:	48 89 ef             	mov    %rbp,%rdi
 601:	44 89 14 24          	mov    %r10d,(%rsp)
 605:	48 89 c2             	mov    %rax,%rdx
 608:	e8 00 00 00 00       	call   60d <decode.constprop.0+0x35d>
 60d:	44 8b 14 24          	mov    (%rsp),%r10d
 611:	e9 1b ff ff ff       	jmp    531 <decode.constprop.0+0x281>
 616:	4c 89 fb             	mov    %r15,%rbx
 619:	44 0f b7 54 24 3e    	movzwl 0x3e(%rsp),%r10d
 61f:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 624:	4c 8b 74 24 60       	mov    0x60(%rsp),%r14
 629:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
 62e:	48 39 de             	cmp    %rbx,%rsi
 631:	75 44                	jne    677 <decode.constprop.0+0x3c7>
 633:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
 638:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 63d:	41 0f b7 c2          	movzwl %r10w,%eax
 641:	4c 8b 6c 24 58       	mov    0x58(%rsp),%r13
 646:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
 64b:	48 83 c4 70          	add    $0x70,%rsp
 64f:	e9 00 00 00 00       	jmp    654 <decode.constprop.0+0x3a4>
 654:	4d 89 d7             	mov    %r10,%r15
 657:	e9 87 fd ff ff       	jmp    3e3 <decode.constprop.0+0x133>
 65c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 661:	e9 00 00 00 00       	jmp    666 <decode.constprop.0+0x3b6>
 666:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 66b:	e9 f1 fe ff ff       	jmp    561 <decode.constprop.0+0x2b1>
 670:	bb 08 00 00 00       	mov    $0x8,%ebx
 675:	eb b7                	jmp    62e <decode.constprop.0+0x37e>
 677:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
 67c:	4c 8b 64 24 50       	mov    0x50(%rsp),%r12
 681:	4c 8b 6c 24 58       	mov    0x58(%rsp),%r13
 686:	e9 d6 fe ff ff       	jmp    561 <decode.constprop.0+0x2b1>
 68b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
 690:	90                   	nop
 691:	90                   	nop
 692:	90                   	nop
 693:	90                   	nop
 694:	90                   	nop
 695:	90                   	nop
 696:	90                   	nop
 697:	90                   	nop
 698:	90                   	nop
 699:	90                   	nop
 69a:	90                   	nop
 69b:	90                   	nop
 69c:	90                   	nop
 69d:	90                   	nop
 69e:	90                   	nop
 69f:	90                   	nop

00000000000006a0 <scan_scalar>:
 6a0:	f3 0f 1e fa          	endbr64
 6a4:	e8 00 00 00 00       	call   6a9 <scan_scalar+0x9>
 6a9:	41 54                	push   %r12
 6ab:	55                   	push   %rbp
 6ac:	53                   	push   %rbx
 6ad:	48 83 ec 38          	sub    $0x38,%rsp
 6b1:	4c 8b 17             	mov    (%rdi),%r10
 6b4:	4c 8b 5f 08          	mov    0x8(%rdi),%r11
 6b8:	65 4c 8b 05 00 00 00 	mov    %gs:0x0(%rip),%r8        # 6c0 <scan_scalar+0x20>
 6bf:	00 
 6c0:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
 6c5:	49 89 d0             	mov    %rdx,%r8
 6c8:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
 6cc:	48 8b 6f 18          	mov    0x18(%rdi),%rbp
 6d0:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
 6d5:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
 6da:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
 6df:	48 89 6c 24 28       	mov    %rbp,0x28(%rsp)
 6e4:	4d 39 d3             	cmp    %r10,%r11
 6e7:	0f 84 cd 01 00 00    	je     8ba <scan_scalar+0x21a>
 6ed:	4c 39 d3             	cmp    %r10,%rbx
 6f0:	0f 84 c9 00 00 00    	je     7bf <scan_scalar+0x11f>
 6f6:	41 b9 1f 00 00 00    	mov    $0x1f,%r9d
 6fc:	b8 20 00 00 00       	mov    $0x20,%eax
 701:	41 bc 20 00 00 00    	mov    $0x20,%r12d
 707:	48 39 f0             	cmp    %rsi,%rax
 70a:	0f 83 20 02 00 00    	jae    930 <scan_scalar+0x290>
 710:	48 83 fe 20          	cmp    $0x20,%rsi
 714:	0f 86 0d 02 00 00    	jbe    927 <scan_scalar+0x287>
 71a:	b8 20 00 00 00       	mov    $0x20,%eax
 71f:	eb 28                	jmp    749 <scan_scalar+0xa9>
 721:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 728:	00 00 
 72a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 731:	00 00 00 00 
 735:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 73c:	00 00 00 00 
 740:	48 39 ca             	cmp    %rcx,%rdx
 743:	0f 85 95 00 00 00    	jne    7de <scan_scalar+0x13e>
 749:	48 89 c2             	mov    %rax,%rdx
 74c:	48 8b 0c 07          	mov    (%rdi,%rax,1),%rcx
 750:	48 83 c0 08          	add    $0x8,%rax
 754:	4c 21 ca             	and    %r9,%rdx
 757:	48 c1 ea 03          	shr    $0x3,%rdx
 75b:	48 8b 54 d4 10       	mov    0x10(%rsp,%rdx,8),%rdx
 760:	48 39 f0             	cmp    %rsi,%rax
 763:	72 db                	jb     740 <scan_scalar+0xa0>
 765:	48 39 ca             	cmp    %rcx,%rdx
 768:	75 74                	jne    7de <scan_scalar+0x13e>
 76a:	4d 85 d2             	test   %r10,%r10
 76d:	0f 84 6f 01 00 00    	je     8e2 <scan_scalar+0x242>
 773:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
 77a:	01 00 00 00 
 77e:	41 83 fc 08          	cmp    $0x8,%r12d
 782:	0f 84 c5 01 00 00    	je     94d <scan_scalar+0x2ad>
 788:	31 c0                	xor    %eax,%eax
 78a:	41 83 fc 10          	cmp    $0x10,%r12d
 78e:	0f 95 c0             	setne  %al
 791:	8d 04 85 04 00 00 00 	lea    0x4(,%rax,4),%eax
 798:	41 89 80 84 00 00 00 	mov    %eax,0x84(%r8)
 79f:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
 7a4:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 7ac <scan_scalar+0x10c>
 7ab:	00 
 7ac:	0f 85 d9 01 00 00    	jne    98b <scan_scalar+0x2eb>
 7b2:	48 83 c4 38          	add    $0x38,%rsp
 7b6:	5b                   	pop    %rbx
 7b7:	5d                   	pop    %rbp
 7b8:	41 5c                	pop    %r12
 7ba:	e9 00 00 00 00       	jmp    7bf <scan_scalar+0x11f>
 7bf:	4c 39 dd             	cmp    %r11,%rbp
 7c2:	0f 85 2e ff ff ff    	jne    6f6 <scan_scalar+0x56>
 7c8:	41 b9 0f 00 00 00    	mov    $0xf,%r9d
 7ce:	b8 10 00 00 00       	mov    $0x10,%eax
 7d3:	41 bc 10 00 00 00    	mov    $0x10,%r12d
 7d9:	e9 29 ff ff ff       	jmp    707 <scan_scalar+0x67>
 7de:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
 7e5:	00 00 00 00 
 7e9:	48 89 f3             	mov    %rsi,%rbx
 7ec:	48 c1 eb 05          	shr    $0x5,%rbx
 7f0:	49 89 fc             	mov    %rdi,%r12
 7f3:	31 ed                	xor    %ebp,%ebp
 7f5:	41 8b 44 24 04       	mov    0x4(%r12),%eax
 7fa:	31 d2                	xor    %edx,%edx
 7fc:	41 8b 4c 24 08       	mov    0x8(%r12),%ecx
 801:	41 8b 3c 24          	mov    (%r12),%edi
 805:	45 8b 4c 24 0c       	mov    0xc(%r12),%r9d
 80a:	85 c0                	test   %eax,%eax
 80c:	45 8b 54 24 10       	mov    0x10(%r12),%r10d
 811:	45 8b 5c 24 14       	mov    0x14(%r12),%r11d
 816:	0f 95 c2             	setne  %dl
 819:	31 f6                	xor    %esi,%esi
 81b:	41 8b 44 24 18       	mov    0x18(%r12),%eax
 820:	01 d2                	add    %edx,%edx
 822:	85 c9                	test   %ecx,%ecx
 824:	40 0f 95 c6          	setne  %sil
 828:	c1 e6 02             	shl    $0x2,%esi
 82b:	09 f2                	or     %esi,%edx
 82d:	31 f6                	xor    %esi,%esi
 82f:	85 ff                	test   %edi,%edi
 831:	40 0f 95 c6          	setne  %sil
 835:	09 f2                	or     %esi,%edx
 837:	31 f6                	xor    %esi,%esi
 839:	45 85 c9             	test   %r9d,%r9d
 83c:	40 0f 95 c6          	setne  %sil
 840:	c1 e6 03             	shl    $0x3,%esi
 843:	09 f2                	or     %esi,%edx
 845:	31 f6                	xor    %esi,%esi
 847:	45 85 d2             	test   %r10d,%r10d
 84a:	40 0f 95 c6          	setne  %sil
 84e:	c1 e6 04             	shl    $0x4,%esi
 851:	09 d6                	or     %edx,%esi
 853:	31 d2                	xor    %edx,%edx
 855:	45 85 db             	test   %r11d,%r11d
 858:	0f 95 c2             	setne  %dl
 85b:	c1 e2 05             	shl    $0x5,%edx
 85e:	09 f2                	or     %esi,%edx
 860:	31 f6                	xor    %esi,%esi
 862:	85 c0                	test   %eax,%eax
 864:	41 8b 44 24 1c       	mov    0x1c(%r12),%eax
 869:	40 0f 95 c6          	setne  %sil
 86d:	c1 e6 06             	shl    $0x6,%esi
 870:	09 d6                	or     %edx,%esi
 872:	31 d2                	xor    %edx,%edx
 874:	85 c0                	test   %eax,%eax
 876:	0f 95 c2             	setne  %dl
 879:	c1 e2 07             	shl    $0x7,%edx
 87c:	09 f2                	or     %esi,%edx
 87e:	48 81 fd 80 00 00 00 	cmp    $0x80,%rbp
 885:	0f 83 da 00 00 00    	jae    965 <scan_scalar+0x2c5>
 88b:	41 88 14 28          	mov    %dl,(%r8,%rbp,1)
 88f:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
 896:	48 83 c5 01          	add    $0x1,%rbp
 89a:	49 83 c4 20          	add    $0x20,%r12
 89e:	41 03 90 80 00 00 00 	add    0x80(%r8),%edx
 8a5:	41 89 90 80 00 00 00 	mov    %edx,0x80(%r8)
 8ac:	48 39 dd             	cmp    %rbx,%rbp
 8af:	0f 85 40 ff ff ff    	jne    7f5 <scan_scalar+0x155>
 8b5:	e9 e5 fe ff ff       	jmp    79f <scan_scalar+0xff>
 8ba:	4c 39 db             	cmp    %r11,%rbx
 8bd:	0f 85 33 fe ff ff    	jne    6f6 <scan_scalar+0x56>
 8c3:	48 39 dd             	cmp    %rbx,%rbp
 8c6:	0f 85 2a fe ff ff    	jne    6f6 <scan_scalar+0x56>
 8cc:	41 b9 07 00 00 00    	mov    $0x7,%r9d
 8d2:	b8 08 00 00 00       	mov    $0x8,%eax
 8d7:	41 bc 08 00 00 00    	mov    $0x8,%r12d
 8dd:	e9 25 fe ff ff       	jmp    707 <scan_scalar+0x67>
 8e2:	4d 85 db             	test   %r11,%r11
 8e5:	75 29                	jne    910 <scan_scalar+0x270>
 8e7:	48 85 db             	test   %rbx,%rbx
 8ea:	75 24                	jne    910 <scan_scalar+0x270>
 8ec:	48 85 ed             	test   %rbp,%rbp
 8ef:	75 1f                	jne    910 <scan_scalar+0x270>
 8f1:	41 c7 80 80 00 00 00 	movl   $0x0,0x80(%r8)
 8f8:	00 00 00 00 
 8fc:	41 83 fc 08          	cmp    $0x8,%r12d
 900:	0f 85 82 fe ff ff    	jne    788 <scan_scalar+0xe8>
 906:	b8 01 00 00 00       	mov    $0x1,%eax
 90b:	e9 88 fe ff ff       	jmp    798 <scan_scalar+0xf8>
 910:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
 917:	01 00 00 00 
 91b:	41 83 fc 08          	cmp    $0x8,%r12d
 91f:	0f 85 63 fe ff ff    	jne    788 <scan_scalar+0xe8>
 925:	eb df                	jmp    906 <scan_scalar+0x266>
 927:	48 39 f0             	cmp    %rsi,%rax
 92a:	0f 82 3a fe ff ff    	jb     76a <scan_scalar+0xca>
 930:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
 937:	00 00 00 00 
 93b:	48 89 f3             	mov    %rsi,%rbx
 93e:	48 c1 eb 05          	shr    $0x5,%rbx
 942:	0f 84 57 fe ff ff    	je     79f <scan_scalar+0xff>
 948:	e9 a3 fe ff ff       	jmp    7f0 <scan_scalar+0x150>
 94d:	4c 89 d0             	mov    %r10,%rax
 950:	48 c1 e8 20          	shr    $0x20,%rax
 954:	41 39 c2             	cmp    %eax,%r10d
 957:	0f 95 c0             	setne  %al
 95a:	0f b6 c0             	movzbl %al,%eax
 95d:	83 c0 01             	add    $0x1,%eax
 960:	e9 33 fe ff ff       	jmp    798 <scan_scalar+0xf8>
 965:	48 89 ee             	mov    %rbp,%rsi
 968:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 96f:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
 974:	89 54 24 04          	mov    %edx,0x4(%rsp)
 978:	e8 00 00 00 00       	call   97d <scan_scalar+0x2dd>
 97d:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
 982:	8b 54 24 04          	mov    0x4(%rsp),%edx
 986:	e9 00 ff ff ff       	jmp    88b <scan_scalar+0x1eb>
 98b:	e8 00 00 00 00       	call   990 <scan_scalar+0x2f0>
 990:	90                   	nop
 991:	90                   	nop
 992:	90                   	nop
 993:	90                   	nop
 994:	90                   	nop
 995:	90                   	nop
 996:	90                   	nop
 997:	90                   	nop
 998:	90                   	nop
 999:	90                   	nop
 99a:	90                   	nop
 99b:	90                   	nop
 99c:	90                   	nop
 99d:	90                   	nop
 99e:	90                   	nop
 99f:	90                   	nop

00000000000009a0 <encode.constprop.0>:
 9a0:	e8 00 00 00 00       	call   9a5 <encode.constprop.0+0x5>
 9a5:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
 9ac:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 9b4 <encode.constprop.0+0x14>
 9b3:	00 
 9b4:	48 89 84 24 e8 00 00 	mov    %rax,0xe8(%rsp)
 9bb:	00 
 9bc:	48 89 d0             	mov    %rdx,%rax
 9bf:	41 8d 50 fb          	lea    -0x5(%r8),%edx
 9c3:	83 fa 07             	cmp    $0x7,%edx
 9c6:	0f 87 ea 01 00 00    	ja     bb6 <encode.constprop.0+0x216>
 9cc:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
 9d3:	0f 87 dd 01 00 00    	ja     bb6 <encode.constprop.0+0x216>
 9d9:	48 85 c0             	test   %rax,%rax
 9dc:	0f 84 d4 01 00 00    	je     bb6 <encode.constprop.0+0x216>
 9e2:	48 85 ff             	test   %rdi,%rdi
 9e5:	49 89 c9             	mov    %rcx,%r9
 9e8:	4c 89 bc 24 18 01 00 	mov    %r15,0x118(%rsp)
 9ef:	00 
 9f0:	49 89 ff             	mov    %rdi,%r15
 9f3:	0f 94 c1             	sete   %cl
 9f6:	48 85 f6             	test   %rsi,%rsi
 9f9:	0f 95 c2             	setne  %dl
 9fc:	84 d1                	test   %dl,%cl
 9fe:	0f 85 aa 01 00 00    	jne    bae <encode.constprop.0+0x20e>
 a04:	49 83 f9 07          	cmp    $0x7,%r9
 a08:	0f 86 a0 01 00 00    	jbe    bae <encode.constprop.0+0x20e>
 a0e:	44 89 c1             	mov    %r8d,%ecx
 a11:	4c 89 b4 24 10 01 00 	mov    %r14,0x110(%rsp)
 a18:	00 
 a19:	41 be 01 00 00 00    	mov    $0x1,%r14d
 a1f:	49 d3 e6             	shl    %cl,%r14
 a22:	48 89 9c 24 f0 00 00 	mov    %rbx,0xf0(%rsp)
 a29:	00 
 a2a:	49 8d 5c 36 ff       	lea    -0x1(%r14,%rsi,1),%rbx
 a2f:	48 89 ac 24 f8 00 00 	mov    %rbp,0xf8(%rsp)
 a36:	00 
 a37:	48 d3 eb             	shr    %cl,%rbx
 a3a:	48 8d 6b 08          	lea    0x8(%rbx),%rbp
 a3e:	49 39 e9             	cmp    %rbp,%r9
 a41:	0f 82 3f 02 00 00    	jb     c86 <encode.constprop.0+0x2e6>
 a47:	31 c9                	xor    %ecx,%ecx
 a49:	44 89 c2             	mov    %r8d,%edx
 a4c:	48 89 c7             	mov    %rax,%rdi
 a4f:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
 a54:	44 89 44 24 10       	mov    %r8d,0x10(%rsp)
 a59:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
 a5e:	48 89 04 24          	mov    %rax,(%rsp)
 a62:	e8 39 f6 ff ff       	call   a0 <header>
 a67:	48 85 db             	test   %rbx,%rbx
 a6a:	48 8b 04 24          	mov    (%rsp),%rax
 a6e:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 a73:	44 8b 44 24 10       	mov    0x10(%rsp),%r8d
 a78:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
 a7d:	0f 84 c2 03 00 00    	je     e45 <encode.constprop.0+0x4a5>
 a83:	48 8d 4c 18 08       	lea    0x8(%rax,%rbx,1),%rcx
 a88:	4c 89 a4 24 00 01 00 	mov    %r12,0x100(%rsp)
 a8f:	00 
 a90:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
 a95:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
 a99:	48 89 0c 24          	mov    %rcx,(%rsp)
 a9d:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
 aa2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
 aa7:	44 89 44 24 34       	mov    %r8d,0x34(%rsp)
 aac:	4c 89 ac 24 08 01 00 	mov    %r13,0x108(%rsp)
 ab3:	00 
 ab4:	4d 89 fd             	mov    %r15,%r13
 ab7:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
 abc:	4c 8d 78 08          	lea    0x8(%rax),%r15
 ac0:	48 8b 1c 24          	mov    (%rsp),%rbx
 ac4:	4c 29 eb             	sub    %r13,%rbx
 ac7:	4c 39 f3             	cmp    %r14,%rbx
 aca:	49 0f 47 de          	cmova  %r14,%rbx
 ace:	31 c0                	xor    %eax,%eax
 ad0:	89 c2                	mov    %eax,%edx
 ad2:	83 c0 20             	add    $0x20,%eax
 ad5:	48 c7 44 14 60 00 00 	movq   $0x0,0x60(%rsp,%rdx,1)
 adc:	00 00 
 ade:	48 c7 44 14 68 00 00 	movq   $0x0,0x68(%rsp,%rdx,1)
 ae5:	00 00 
 ae7:	48 c7 44 14 70 00 00 	movq   $0x0,0x70(%rsp,%rdx,1)
 aee:	00 00 
 af0:	48 c7 44 14 78 00 00 	movq   $0x0,0x78(%rsp,%rdx,1)
 af7:	00 00 
 af9:	3d 80 00 00 00       	cmp    $0x80,%eax
 afe:	72 d0                	jb     ad0 <encode.constprop.0+0x130>
 b00:	48 c7 44 04 60 00 00 	movq   $0x0,0x60(%rsp,%rax,1)
 b07:	00 00 
 b09:	49 89 dc             	mov    %rbx,%r12
 b0c:	41 83 e4 1f          	and    $0x1f,%r12d
 b10:	0f 84 c6 00 00 00    	je     bdc <encode.constprop.0+0x23c>
 b16:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 b1b:	48 29 e8             	sub    %rbp,%rax
 b1e:	48 39 d8             	cmp    %rbx,%rax
 b21:	0f 82 cc 01 00 00    	jb     cf3 <encode.constprop.0+0x353>
 b27:	41 c6 07 00          	movb   $0x0,(%r15)
 b2b:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 b30:	4c 89 ee             	mov    %r13,%rsi
 b33:	48 89 da             	mov    %rbx,%rdx
 b36:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
 b3a:	48 01 dd             	add    %rbx,%rbp
 b3d:	e8 00 00 00 00       	call   b42 <encode.constprop.0+0x1a2>
 b42:	4d 01 f5             	add    %r14,%r13
 b45:	49 83 c7 01          	add    $0x1,%r15
 b49:	4c 39 7c 24 08       	cmp    %r15,0x8(%rsp)
 b4e:	0f 85 6c ff ff ff    	jne    ac0 <encode.constprop.0+0x120>
 b54:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
 b59:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
 b5e:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 b63:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
 b68:	44 8b 44 24 34       	mov    0x34(%rsp),%r8d
 b6d:	4c 8b a4 24 00 01 00 	mov    0x100(%rsp),%r12
 b74:	00 
 b75:	4c 8b ac 24 08 01 00 	mov    0x108(%rsp),%r13
 b7c:	00 
 b7d:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
 b81:	89 ea                	mov    %ebp,%edx
 b83:	48 39 cd             	cmp    %rcx,%rbp
 b86:	0f 83 fa 00 00 00    	jae    c86 <encode.constprop.0+0x2e6>
 b8c:	48 8b 9c 24 f0 00 00 	mov    0xf0(%rsp),%rbx
 b93:	00 
 b94:	48 8b ac 24 f8 00 00 	mov    0xf8(%rsp),%rbp
 b9b:	00 
 b9c:	4c 8b b4 24 10 01 00 	mov    0x110(%rsp),%r14
 ba3:	00 
 ba4:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 bab:	00 
 bac:	eb 0a                	jmp    bb8 <encode.constprop.0+0x218>
 bae:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 bb5:	00 
 bb6:	31 d2                	xor    %edx,%edx
 bb8:	48 8b 84 24 e8 00 00 	mov    0xe8(%rsp),%rax
 bbf:	00 
 bc0:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # bc8 <encode.constprop.0+0x228>
 bc7:	00 
 bc8:	0f 85 a1 02 00 00    	jne    e6f <encode.constprop.0+0x4cf>
 bce:	89 d0                	mov    %edx,%eax
 bd0:	48 81 c4 20 01 00 00 	add    $0x120,%rsp
 bd7:	e9 00 00 00 00       	jmp    bdc <encode.constprop.0+0x23c>
 bdc:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
 be1:	48 89 de             	mov    %rbx,%rsi
 be4:	4c 89 ef             	mov    %r13,%rdi
 be7:	e8 b4 fa ff ff       	call   6a0 <scan_scalar>
 bec:	8b 84 24 e0 00 00 00 	mov    0xe0(%rsp),%eax
 bf3:	85 c0                	test   %eax,%eax
 bf5:	75 09                	jne    c00 <encode.constprop.0+0x260>
 bf7:	41 c6 07 01          	movb   $0x1,(%r15)
 bfb:	e9 42 ff ff ff       	jmp    b42 <encode.constprop.0+0x1a2>
 c00:	48 b9 02 00 00 00 03 	movabs $0x300000002,%rcx
 c07:	00 00 00 
 c0a:	8b 94 24 e4 00 00 00 	mov    0xe4(%rsp),%edx
 c11:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
 c16:	48 b9 05 00 00 00 06 	movabs $0x600000005,%rcx
 c1d:	00 00 00 
 c20:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
 c25:	f6 c2 01             	test   $0x1,%dl
 c28:	74 13                	je     c3d <encode.constprop.0+0x29d>
 c2a:	48 83 fb 04          	cmp    $0x4,%rbx
 c2e:	0f 86 f3 fe ff ff    	jbe    b27 <encode.constprop.0+0x187>
 c34:	bb 04 00 00 00       	mov    $0x4,%ebx
 c39:	31 f6                	xor    %esi,%esi
 c3b:	eb 26                	jmp    c63 <encode.constprop.0+0x2c3>
 c3d:	f6 c2 02             	test   $0x2,%dl
 c40:	0f 85 8b 00 00 00    	jne    cd1 <encode.constprop.0+0x331>
 c46:	f6 c2 04             	test   $0x4,%dl
 c49:	0f 84 18 01 00 00    	je     d67 <encode.constprop.0+0x3c7>
 c4f:	48 83 fb 10          	cmp    $0x10,%rbx
 c53:	0f 86 ce fe ff ff    	jbe    b27 <encode.constprop.0+0x187>
 c59:	bb 10 00 00 00       	mov    $0x10,%ebx
 c5e:	be 02 00 00 00       	mov    $0x2,%esi
 c63:	8b 44 b4 50          	mov    0x50(%rsp,%rsi,4),%eax
 c67:	48 83 fe 04          	cmp    $0x4,%rsi
 c6b:	0f 83 48 02 00 00    	jae    eb9 <encode.constprop.0+0x519>
 c71:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
 c76:	48 29 ea             	sub    %rbp,%rdx
 c79:	48 39 da             	cmp    %rbx,%rdx
 c7c:	72 75                	jb     cf3 <encode.constprop.0+0x353>
 c7e:	41 88 07             	mov    %al,(%r15)
 c81:	e9 a5 fe ff ff       	jmp    b2b <encode.constprop.0+0x18b>
 c86:	48 8b 94 24 e8 00 00 	mov    0xe8(%rsp),%rdx
 c8d:	00 
 c8e:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # c96 <encode.constprop.0+0x2f6>
 c95:	00 
 c96:	0f 85 08 02 00 00    	jne    ea4 <encode.constprop.0+0x504>
 c9c:	48 8b 9c 24 f0 00 00 	mov    0xf0(%rsp),%rbx
 ca3:	00 
 ca4:	4c 89 ff             	mov    %r15,%rdi
 ca7:	4c 89 c9             	mov    %r9,%rcx
 caa:	48 89 c2             	mov    %rax,%rdx
 cad:	48 8b ac 24 f8 00 00 	mov    0xf8(%rsp),%rbp
 cb4:	00 
 cb5:	4c 8b b4 24 10 01 00 	mov    0x110(%rsp),%r14
 cbc:	00 
 cbd:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 cc4:	00 
 cc5:	48 81 c4 20 01 00 00 	add    $0x120,%rsp
 ccc:	e9 ff f3 ff ff       	jmp    d0 <raw_page>
 cd1:	48 83 fb 08          	cmp    $0x8,%rbx
 cd5:	0f 86 4c fe ff ff    	jbe    b27 <encode.constprop.0+0x187>
 cdb:	bb 08 00 00 00       	mov    $0x8,%ebx
 ce0:	be 01 00 00 00       	mov    $0x1,%esi
 ce5:	e9 79 ff ff ff       	jmp    c63 <encode.constprop.0+0x2c3>
 cea:	48 39 da             	cmp    %rbx,%rdx
 ced:	0f 83 34 fe ff ff    	jae    b27 <encode.constprop.0+0x187>
 cf3:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
 cf8:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
 cfd:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 d02:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
 d07:	44 8b 44 24 34       	mov    0x34(%rsp),%r8d
 d0c:	48 8b 94 24 e8 00 00 	mov    0xe8(%rsp),%rdx
 d13:	00 
 d14:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # d1c <encode.constprop.0+0x37c>
 d1b:	00 
 d1c:	0f 85 7d 01 00 00    	jne    e9f <encode.constprop.0+0x4ff>
 d22:	48 8b 9c 24 f0 00 00 	mov    0xf0(%rsp),%rbx
 d29:	00 
 d2a:	48 8b ac 24 f8 00 00 	mov    0xf8(%rsp),%rbp
 d31:	00 
 d32:	4c 89 ff             	mov    %r15,%rdi
 d35:	4c 89 c9             	mov    %r9,%rcx
 d38:	4c 8b a4 24 00 01 00 	mov    0x100(%rsp),%r12
 d3f:	00 
 d40:	4c 8b ac 24 08 01 00 	mov    0x108(%rsp),%r13
 d47:	00 
 d48:	48 89 c2             	mov    %rax,%rdx
 d4b:	4c 8b b4 24 10 01 00 	mov    0x110(%rsp),%r14
 d52:	00 
 d53:	4c 8b bc 24 18 01 00 	mov    0x118(%rsp),%r15
 d5a:	00 
 d5b:	48 81 c4 20 01 00 00 	add    $0x120,%rsp
 d62:	e9 69 f3 ff ff       	jmp    d0 <raw_page>
 d67:	83 e2 08             	and    $0x8,%edx
 d6a:	74 0a                	je     d76 <encode.constprop.0+0x3d6>
 d6c:	48 83 fb 20          	cmp    $0x20,%rbx
 d70:	0f 87 d9 00 00 00    	ja     e4f <encode.constprop.0+0x4af>
 d76:	49 89 db             	mov    %rbx,%r11
 d79:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
 d7e:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
 d85:	49 c1 eb 05          	shr    $0x5,%r11
 d89:	4c 01 d8             	add    %r11,%rax
 d8c:	48 29 ea             	sub    %rbp,%rdx
 d8f:	48 39 d8             	cmp    %rbx,%rax
 d92:	0f 83 52 ff ff ff    	jae    cea <encode.constprop.0+0x34a>
 d98:	48 39 c2             	cmp    %rax,%rdx
 d9b:	0f 82 52 ff ff ff    	jb     cf3 <encode.constprop.0+0x353>
 da1:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
 da6:	41 c6 07 04          	movb   $0x4,(%r15)
 daa:	48 8d 74 24 60       	lea    0x60(%rsp),%rsi
 daf:	4c 89 da             	mov    %r11,%rdx
 db2:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
 db7:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
 dbb:	e8 00 00 00 00       	call   dc0 <encode.constprop.0+0x420>
 dc0:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
 dc5:	4c 01 dd             	add    %r11,%rbp
 dc8:	4d 85 db             	test   %r11,%r11
 dcb:	0f 84 71 fd ff ff    	je     b42 <encode.constprop.0+0x1a2>
 dd1:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
 dd6:	4c 89 db             	mov    %r11,%rbx
 dd9:	4c 89 74 24 38       	mov    %r14,0x38(%rsp)
 dde:	4d 89 ee             	mov    %r13,%r14
 de1:	4c 89 6c 24 40       	mov    %r13,0x40(%rsp)
 de6:	49 89 ed             	mov    %rbp,%r13
 de9:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
 dee:	49 81 fc 80 00 00 00 	cmp    $0x80,%r12
 df5:	73 67                	jae    e5e <encode.constprop.0+0x4be>
 df7:	46 0f b6 7c 24 60    	movzbl 0x60(%rsp,%r12,1),%r15d
 dfd:	4a 8d 74 2d 00       	lea    0x0(%rbp,%r13,1),%rsi
 e02:	4c 89 f7             	mov    %r14,%rdi
 e05:	49 83 c4 01          	add    $0x1,%r12
 e09:	49 83 c6 20          	add    $0x20,%r14
 e0d:	44 89 fa             	mov    %r15d,%edx
 e10:	e8 fb f1 ff ff       	call   10 <pack_scalar>
 e15:	44 89 f8             	mov    %r15d,%eax
 e18:	0f b6 80 00 00 00 00 	movzbl 0x0(%rax),%eax
 e1f:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
 e26:	49 01 c5             	add    %rax,%r13
 e29:	4c 39 e3             	cmp    %r12,%rbx
 e2c:	75 c0                	jne    dee <encode.constprop.0+0x44e>
 e2e:	4c 89 ed             	mov    %r13,%rbp
 e31:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
 e36:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
 e3b:	4c 8b 7c 24 48       	mov    0x48(%rsp),%r15
 e40:	e9 fd fc ff ff       	jmp    b42 <encode.constprop.0+0x1a2>
 e45:	bd 08 00 00 00       	mov    $0x8,%ebp
 e4a:	e9 2e fd ff ff       	jmp    b7d <encode.constprop.0+0x1dd>
 e4f:	bb 20 00 00 00       	mov    $0x20,%ebx
 e54:	be 03 00 00 00       	mov    $0x3,%esi
 e59:	e9 05 fe ff ff       	jmp    c63 <encode.constprop.0+0x2c3>
 e5e:	4c 89 e6             	mov    %r12,%rsi
 e61:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 e68:	e8 00 00 00 00       	call   e6d <encode.constprop.0+0x4cd>
 e6d:	eb 88                	jmp    df7 <encode.constprop.0+0x457>
 e6f:	48 89 9c 24 f0 00 00 	mov    %rbx,0xf0(%rsp)
 e76:	00 
 e77:	48 89 ac 24 f8 00 00 	mov    %rbp,0xf8(%rsp)
 e7e:	00 
 e7f:	4c 89 a4 24 00 01 00 	mov    %r12,0x100(%rsp)
 e86:	00 
 e87:	4c 89 ac 24 08 01 00 	mov    %r13,0x108(%rsp)
 e8e:	00 
 e8f:	4c 89 b4 24 10 01 00 	mov    %r14,0x110(%rsp)
 e96:	00 
 e97:	4c 89 bc 24 18 01 00 	mov    %r15,0x118(%rsp)
 e9e:	00 
 e9f:	e8 00 00 00 00       	call   ea4 <encode.constprop.0+0x504>
 ea4:	4c 89 a4 24 00 01 00 	mov    %r12,0x100(%rsp)
 eab:	00 
 eac:	4c 89 ac 24 08 01 00 	mov    %r13,0x108(%rsp)
 eb3:	00 
 eb4:	e8 00 00 00 00       	call   eb9 <encode.constprop.0+0x519>
 eb9:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 ec0:	89 44 24 38          	mov    %eax,0x38(%rsp)
 ec4:	e8 00 00 00 00       	call   ec9 <encode.constprop.0+0x529>
 ec9:	8b 44 24 38          	mov    0x38(%rsp),%eax
 ecd:	e9 9f fd ff ff       	jmp    c71 <encode.constprop.0+0x2d1>
 ed2:	0f 1f 00             	nopl   (%rax)
 ed5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 edc:	00 00 00 00 
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

0000000000000ef0 <n100_encoder_avx2_available>:
 ef0:	f3 0f 1e fa          	endbr64
 ef4:	e8 00 00 00 00       	call   ef9 <n100_encoder_avx2_available+0x9>
 ef9:	31 c0                	xor    %eax,%eax
 efb:	e9 00 00 00 00       	jmp    f00 <n100_encoder_avx2_available+0x10>
 f00:	90                   	nop
 f01:	90                   	nop
 f02:	90                   	nop
 f03:	90                   	nop
 f04:	90                   	nop
 f05:	90                   	nop
 f06:	90                   	nop
 f07:	90                   	nop
 f08:	90                   	nop
 f09:	90                   	nop
 f0a:	90                   	nop
 f0b:	90                   	nop
 f0c:	90                   	nop
 f0d:	90                   	nop
 f0e:	90                   	nop
 f0f:	90                   	nop

0000000000000f10 <n100_encoder_encode_scalar>:
 f10:	f3 0f 1e fa          	endbr64
 f14:	e8 00 00 00 00       	call   f19 <n100_encoder_encode_scalar+0x9>
 f19:	e9 82 fa ff ff       	jmp    9a0 <encode.constprop.0>
 f1e:	66 90                	xchg   %ax,%ax
 f20:	90                   	nop
 f21:	90                   	nop
 f22:	90                   	nop
 f23:	90                   	nop
 f24:	90                   	nop
 f25:	90                   	nop
 f26:	90                   	nop
 f27:	90                   	nop
 f28:	90                   	nop
 f29:	90                   	nop
 f2a:	90                   	nop
 f2b:	90                   	nop
 f2c:	90                   	nop
 f2d:	90                   	nop
 f2e:	90                   	nop
 f2f:	90                   	nop

0000000000000f30 <n100_encoder_encode_avx2>:
 f30:	f3 0f 1e fa          	endbr64
 f34:	e8 00 00 00 00       	call   f39 <n100_encoder_encode_avx2+0x9>
 f39:	e9 62 fa ff ff       	jmp    9a0 <encode.constprop.0>
 f3e:	66 90                	xchg   %ax,%ax
 f40:	90                   	nop
 f41:	90                   	nop
 f42:	90                   	nop
 f43:	90                   	nop
 f44:	90                   	nop
 f45:	90                   	nop
 f46:	90                   	nop
 f47:	90                   	nop
 f48:	90                   	nop
 f49:	90                   	nop
 f4a:	90                   	nop
 f4b:	90                   	nop
 f4c:	90                   	nop
 f4d:	90                   	nop
 f4e:	90                   	nop
 f4f:	90                   	nop

0000000000000f50 <n100_encoder_decode_scalar>:
 f50:	f3 0f 1e fa          	endbr64
 f54:	e8 00 00 00 00       	call   f59 <n100_encoder_decode_scalar+0x9>
 f59:	e9 52 f3 ff ff       	jmp    2b0 <decode.constprop.0>
 f5e:	66 90                	xchg   %ax,%ax
 f60:	90                   	nop
 f61:	90                   	nop
 f62:	90                   	nop
 f63:	90                   	nop
 f64:	90                   	nop
 f65:	90                   	nop
 f66:	90                   	nop
 f67:	90                   	nop
 f68:	90                   	nop
 f69:	90                   	nop
 f6a:	90                   	nop
 f6b:	90                   	nop
 f6c:	90                   	nop
 f6d:	90                   	nop
 f6e:	90                   	nop
 f6f:	90                   	nop

0000000000000f70 <n100_encoder_decode_avx2>:
 f70:	f3 0f 1e fa          	endbr64
 f74:	e8 00 00 00 00       	call   f79 <n100_encoder_decode_avx2+0x9>
 f79:	e9 32 f3 ff ff       	jmp    2b0 <decode.constprop.0>
