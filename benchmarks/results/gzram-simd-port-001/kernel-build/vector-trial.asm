
/home/dan/n100-zram/build/astra-simd-kernel-002/vector-trial.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <header-0x10>:
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

0000000000000010 <header>:
  10:	e8 00 00 00 00       	call   15 <header+0x5>
  15:	c7 07 47 48 59 31    	movl   $0x31594847,(%rdi)
  1b:	66 89 77 04          	mov    %si,0x4(%rdi)
  1f:	88 57 06             	mov    %dl,0x6(%rdi)
  22:	c6 47 07 00          	movb   $0x0,0x7(%rdi)
  26:	e9 00 00 00 00       	jmp    2b <header+0x1b>
  2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

0000000000000040 <prefix_scalar>:
  40:	e8 00 00 00 00       	call   45 <prefix_scalar+0x5>
  45:	39 f2                	cmp    %esi,%edx
  47:	0f 82 1f 01 00 00    	jb     16c <prefix_scalar+0x12c>
  4d:	49 89 f9             	mov    %rdi,%r9
  50:	48 89 cf             	mov    %rcx,%rdi
  53:	41 56                	push   %r14
  55:	42 8d 0c c5 00 00 00 	lea    0x0(,%r8,8),%ecx
  5c:	00 
  5d:	48 b8 01 01 01 01 01 	movabs $0x101010101010101,%rax
  64:	01 01 01 
  67:	41 55                	push   %r13
  69:	41 89 f2             	mov    %esi,%r10d
  6c:	49 bd ff fe fe fe fe 	movabs $0xfefefefefefefeff,%r13
  73:	fe fe fe 
  76:	41 54                	push   %r12
  78:	4d 01 ca             	add    %r9,%r10
  7b:	49 bc 80 80 80 80 80 	movabs $0x8080808080808080,%r12
  82:	80 80 80 
  85:	55                   	push   %rbp
  86:	44 89 c5             	mov    %r8d,%ebp
  89:	49 89 f8             	mov    %rdi,%r8
  8c:	49 d3 e8             	shr    %cl,%r8
  8f:	8d 4a 01             	lea    0x1(%rdx),%ecx
  92:	53                   	push   %rbx
  93:	89 d3                	mov    %edx,%ebx
  95:	45 0f b6 d8          	movzbl %r8b,%r11d
  99:	29 f1                	sub    %esi,%ecx
  9b:	4c 0f af d8          	imul   %rax,%r11
  9f:	83 e1 f8             	and    $0xfffffff8,%ecx
  a2:	89 e8                	mov    %ebp,%eax
  a4:	49 01 c2             	add    %rax,%r10
  a7:	01 f1                	add    %esi,%ecx
  a9:	39 f1                	cmp    %esi,%ecx
  ab:	74 6d                	je     11a <prefix_scalar+0xda>
  ad:	49 8b 12             	mov    (%r10),%rdx
  b0:	4c 31 da             	xor    %r11,%rdx
  b3:	4a 8d 04 2a          	lea    (%rdx,%r13,1),%rax
  b7:	48 f7 d2             	not    %rdx
  ba:	48 21 d0             	and    %rdx,%rax
  bd:	4c 21 e0             	and    %r12,%rax
  c0:	eb 39                	jmp    fb <prefix_scalar+0xbb>
  c2:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  c9:	00 
  ca:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  d1:	00 00 00 00 
  d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  dc:	00 00 00 00 
  e0:	31 d2                	xor    %edx,%edx
  e2:	4c 8d 70 ff          	lea    -0x1(%rax),%r14
  e6:	f3 48 0f bc d0       	tzcnt  %rax,%rdx
  eb:	4c 21 f0             	and    %r14,%rax
  ee:	c1 ea 03             	shr    $0x3,%edx
  f1:	01 f2                	add    %esi,%edx
  f3:	89 d2                	mov    %edx,%edx
  f5:	49 3b 3c 11          	cmp    (%r9,%rdx,1),%rdi
  f9:	74 5f                	je     15a <prefix_scalar+0x11a>
  fb:	48 85 c0             	test   %rax,%rax
  fe:	75 e0                	jne    e0 <prefix_scalar+0xa0>
 100:	83 c6 08             	add    $0x8,%esi
 103:	49 83 c2 08          	add    $0x8,%r10
 107:	39 f3                	cmp    %esi,%ebx
 109:	73 9e                	jae    a9 <prefix_scalar+0x69>
 10b:	5b                   	pop    %rbx
 10c:	31 c0                	xor    %eax,%eax
 10e:	5d                   	pop    %rbp
 10f:	41 5c                	pop    %r12
 111:	41 5d                	pop    %r13
 113:	41 5e                	pop    %r14
 115:	e9 00 00 00 00       	jmp    11a <prefix_scalar+0xda>
 11a:	39 cb                	cmp    %ecx,%ebx
 11c:	72 ed                	jb     10b <prefix_scalar+0xcb>
 11e:	89 ce                	mov    %ecx,%esi
 120:	29 cb                	sub    %ecx,%ebx
 122:	01 e9                	add    %ebp,%ecx
 124:	49 8d 04 31          	lea    (%r9,%rsi,1),%rax
 128:	4d 8d 4c 31 01       	lea    0x1(%r9,%rsi,1),%r9
 12d:	89 c9                	mov    %ecx,%ecx
 12f:	49 01 d9             	add    %rbx,%r9
 132:	eb 15                	jmp    149 <prefix_scalar+0x109>
 134:	90                   	nop
 135:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 13c:	00 00 00 00 
 140:	48 83 c0 01          	add    $0x1,%rax
 144:	49 39 c1             	cmp    %rax,%r9
 147:	74 c2                	je     10b <prefix_scalar+0xcb>
 149:	48 89 c2             	mov    %rax,%rdx
 14c:	48 29 f2             	sub    %rsi,%rdx
 14f:	44 38 04 0a          	cmp    %r8b,(%rdx,%rcx,1)
 153:	75 eb                	jne    140 <prefix_scalar+0x100>
 155:	48 3b 38             	cmp    (%rax),%rdi
 158:	75 e6                	jne    140 <prefix_scalar+0x100>
 15a:	5b                   	pop    %rbx
 15b:	b8 01 00 00 00       	mov    $0x1,%eax
 160:	5d                   	pop    %rbp
 161:	41 5c                	pop    %r12
 163:	41 5d                	pop    %r13
 165:	41 5e                	pop    %r14
 167:	e9 00 00 00 00       	jmp    16c <prefix_scalar+0x12c>
 16c:	31 c0                	xor    %eax,%eax
 16e:	e9 00 00 00 00       	jmp    173 <prefix_scalar+0x133>
 173:	66 90                	xchg   %ax,%ax
 175:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 17c:	00 00 00 00 
 180:	90                   	nop
 181:	90                   	nop
 182:	90                   	nop
 183:	90                   	nop
 184:	90                   	nop
 185:	90                   	nop
 186:	90                   	nop
 187:	90                   	nop
 188:	90                   	nop
 189:	90                   	nop
 18a:	90                   	nop
 18b:	90                   	nop
 18c:	90                   	nop
 18d:	90                   	nop
 18e:	90                   	nop
 18f:	90                   	nop

0000000000000190 <merge_repeats>:
 190:	e8 00 00 00 00       	call   195 <merge_repeats+0x5>
 195:	49 89 f1             	mov    %rsi,%r9
 198:	89 c8                	mov    %ecx,%eax
 19a:	48 89 d6             	mov    %rdx,%rsi
 19d:	80 7a 07 00          	cmpb   $0x0,0x7(%rdx)
 1a1:	75 58                	jne    1fb <merge_repeats+0x6b>
 1a3:	0f b6 52 08          	movzbl 0x8(%rdx),%edx
 1a7:	80 fa 05             	cmp    $0x5,%dl
 1aa:	0f 84 36 01 00 00    	je     2e6 <merge_repeats+0x156>
 1b0:	77 4e                	ja     200 <merge_repeats+0x70>
 1b2:	80 fa 02             	cmp    $0x2,%dl
 1b5:	0f 84 ec 00 00 00    	je     2a7 <merge_repeats+0x117>
 1bb:	80 fa 03             	cmp    $0x3,%dl
 1be:	0f 85 6f 01 00 00    	jne    333 <merge_repeats+0x1a3>
 1c4:	44 89 c1             	mov    %r8d,%ecx
 1c7:	ba 01 00 00 00       	mov    $0x1,%edx
 1cc:	48 d3 e2             	shl    %cl,%rdx
 1cf:	49 89 d0             	mov    %rdx,%r8
 1d2:	4c 39 ca             	cmp    %r9,%rdx
 1d5:	73 24                	jae    1fb <merge_repeats+0x6b>
 1d7:	48 8d 4e 09          	lea    0x9(%rsi),%rcx
 1db:	eb 10                	jmp    1ed <merge_repeats+0x5d>
 1dd:	4c 01 c2             	add    %r8,%rdx
 1e0:	48 83 c1 01          	add    $0x1,%rcx
 1e4:	4c 39 ca             	cmp    %r9,%rdx
 1e7:	0f 83 68 01 00 00    	jae    355 <merge_repeats+0x1c5>
 1ed:	80 39 03             	cmpb   $0x3,(%rcx)
 1f0:	75 09                	jne    1fb <merge_repeats+0x6b>
 1f2:	4c 8b 14 17          	mov    (%rdi,%rdx,1),%r10
 1f6:	4c 39 17             	cmp    %r10,(%rdi)
 1f9:	74 e2                	je     1dd <merge_repeats+0x4d>
 1fb:	e9 00 00 00 00       	jmp    200 <merge_repeats+0x70>
 200:	80 fa 06             	cmp    $0x6,%dl
 203:	0f 85 2f 01 00 00    	jne    338 <merge_repeats+0x1a8>
 209:	44 89 c1             	mov    %r8d,%ecx
 20c:	ba 01 00 00 00       	mov    $0x1,%edx
 211:	4c 8d 5e 09          	lea    0x9(%rsi),%r11
 215:	48 d3 e2             	shl    %cl,%rdx
 218:	49 89 d0             	mov    %rdx,%r8
 21b:	4c 39 ca             	cmp    %r9,%rdx
 21e:	0f 83 19 01 00 00    	jae    33d <merge_repeats+0x1ad>
 224:	41 80 3b 06          	cmpb   $0x6,(%r11)
 228:	75 d1                	jne    1fb <merge_repeats+0x6b>
 22a:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
 22e:	4c 8b 17             	mov    (%rdi),%r10
 231:	4a 33 4c 07 08       	xor    0x8(%rdi,%r8,1),%rcx
 236:	4e 33 14 07          	xor    (%rdi,%r8,1),%r10
 23a:	4c 09 d1             	or     %r10,%rcx
 23d:	4c 8b 57 10          	mov    0x10(%rdi),%r10
 241:	4e 33 54 07 10       	xor    0x10(%rdi,%r8,1),%r10
 246:	4c 09 d1             	or     %r10,%rcx
 249:	4c 8b 57 18          	mov    0x18(%rdi),%r10
 24d:	4e 33 54 07 18       	xor    0x18(%rdi,%r8,1),%r10
 252:	49 09 ca             	or     %rcx,%r10
 255:	75 a4                	jne    1fb <merge_repeats+0x6b>
 257:	49 01 d0             	add    %rdx,%r8
 25a:	49 83 c3 01          	add    $0x1,%r11
 25e:	4d 39 c8             	cmp    %r9,%r8
 261:	72 c1                	jb     224 <merge_repeats+0x94>
 263:	b8 29 00 00 00       	mov    $0x29,%eax
 268:	ba 20 00 00 00       	mov    $0x20,%edx
 26d:	c6 46 06 0c          	movb   $0xc,0x6(%rsi)
 271:	48 8b 0f             	mov    (%rdi),%rcx
 274:	48 89 4e 09          	mov    %rcx,0x9(%rsi)
 278:	83 fa 08             	cmp    $0x8,%edx
 27b:	0f 84 e3 00 00 00    	je     364 <merge_repeats+0x1d4>
 281:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
 285:	48 89 4e 11          	mov    %rcx,0x11(%rsi)
 289:	83 fa 10             	cmp    $0x10,%edx
 28c:	0f 84 69 ff ff ff    	je     1fb <merge_repeats+0x6b>
 292:	48 8b 57 10          	mov    0x10(%rdi),%rdx
 296:	48 89 56 19          	mov    %rdx,0x19(%rsi)
 29a:	48 8b 57 18          	mov    0x18(%rdi),%rdx
 29e:	48 89 56 21          	mov    %rdx,0x21(%rsi)
 2a2:	e9 00 00 00 00       	jmp    2a7 <merge_repeats+0x117>
 2a7:	44 89 c1             	mov    %r8d,%ecx
 2aa:	ba 01 00 00 00       	mov    $0x1,%edx
 2af:	48 d3 e2             	shl    %cl,%rdx
 2b2:	48 8d 4e 09          	lea    0x9(%rsi),%rcx
 2b6:	49 89 d0             	mov    %rdx,%r8
 2b9:	4c 39 ca             	cmp    %r9,%rdx
 2bc:	72 1e                	jb     2dc <merge_repeats+0x14c>
 2be:	e9 00 00 00 00       	jmp    2c3 <merge_repeats+0x133>
 2c3:	44 8b 1f             	mov    (%rdi),%r11d
 2c6:	44 39 1c 17          	cmp    %r11d,(%rdi,%rdx,1)
 2ca:	0f 85 2b ff ff ff    	jne    1fb <merge_repeats+0x6b>
 2d0:	4c 01 c2             	add    %r8,%rdx
 2d3:	48 83 c1 01          	add    $0x1,%rcx
 2d7:	4c 39 ca             	cmp    %r9,%rdx
 2da:	73 66                	jae    342 <merge_repeats+0x1b2>
 2dc:	80 39 02             	cmpb   $0x2,(%rcx)
 2df:	74 e2                	je     2c3 <merge_repeats+0x133>
 2e1:	e9 00 00 00 00       	jmp    2e6 <merge_repeats+0x156>
 2e6:	44 89 c1             	mov    %r8d,%ecx
 2e9:	41 ba 01 00 00 00    	mov    $0x1,%r10d
 2ef:	4c 8d 5e 09          	lea    0x9(%rsi),%r11
 2f3:	49 d3 e2             	shl    %cl,%r10
 2f6:	4c 89 d1             	mov    %r10,%rcx
 2f9:	4d 39 ca             	cmp    %r9,%r10
 2fc:	72 11                	jb     30f <merge_repeats+0x17f>
 2fe:	e9 00 00 00 00       	jmp    303 <merge_repeats+0x173>
 303:	4c 01 d1             	add    %r10,%rcx
 306:	49 83 c3 01          	add    $0x1,%r11
 30a:	4c 39 c9             	cmp    %r9,%rcx
 30d:	73 5a                	jae    369 <merge_repeats+0x1d9>
 30f:	41 80 3b 05          	cmpb   $0x5,(%r11)
 313:	0f 85 e2 fe ff ff    	jne    1fb <merge_repeats+0x6b>
 319:	4c 8b 07             	mov    (%rdi),%r8
 31c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
 320:	4c 33 04 0f          	xor    (%rdi,%rcx,1),%r8
 324:	48 33 54 0f 08       	xor    0x8(%rdi,%rcx,1),%rdx
 329:	4c 09 c2             	or     %r8,%rdx
 32c:	74 d5                	je     303 <merge_repeats+0x173>
 32e:	e9 00 00 00 00       	jmp    333 <merge_repeats+0x1a3>
 333:	e9 00 00 00 00       	jmp    338 <merge_repeats+0x1a8>
 338:	e9 00 00 00 00       	jmp    33d <merge_repeats+0x1ad>
 33d:	e9 00 00 00 00       	jmp    342 <merge_repeats+0x1b2>
 342:	c6 46 06 0c          	movb   $0xc,0x6(%rsi)
 346:	8b 07                	mov    (%rdi),%eax
 348:	89 46 09             	mov    %eax,0x9(%rsi)
 34b:	b8 0d 00 00 00       	mov    $0xd,%eax
 350:	e9 00 00 00 00       	jmp    355 <merge_repeats+0x1c5>
 355:	b8 11 00 00 00       	mov    $0x11,%eax
 35a:	ba 08 00 00 00       	mov    $0x8,%edx
 35f:	e9 09 ff ff ff       	jmp    26d <merge_repeats+0xdd>
 364:	e9 00 00 00 00       	jmp    369 <merge_repeats+0x1d9>
 369:	b8 19 00 00 00       	mov    $0x19,%eax
 36e:	ba 10 00 00 00       	mov    $0x10,%edx
 373:	e9 f5 fe ff ff       	jmp    26d <merge_repeats+0xdd>
 378:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 37f:	00 
 380:	90                   	nop
 381:	90                   	nop
 382:	90                   	nop
 383:	90                   	nop
 384:	90                   	nop
 385:	90                   	nop
 386:	90                   	nop
 387:	90                   	nop
 388:	90                   	nop
 389:	90                   	nop
 38a:	90                   	nop
 38b:	90                   	nop
 38c:	90                   	nop
 38d:	90                   	nop
 38e:	90                   	nop
 38f:	90                   	nop

0000000000000390 <n100_vector_trial>:
 390:	f3 0f 1e fa          	endbr64
 394:	e8 00 00 00 00       	call   399 <n100_vector_trial+0x9>
 399:	41 8d 40 fb          	lea    -0x5(%r8),%eax
 39d:	83 f8 07             	cmp    $0x7,%eax
 3a0:	0f 87 e7 00 00 00    	ja     48d <n100_vector_trial+0xfd>
 3a6:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
 3ad:	0f 87 da 00 00 00    	ja     48d <n100_vector_trial+0xfd>
 3b3:	48 85 d2             	test   %rdx,%rdx
 3b6:	0f 84 d1 00 00 00    	je     48d <n100_vector_trial+0xfd>
 3bc:	48 85 ff             	test   %rdi,%rdi
 3bf:	41 0f 94 c1          	sete   %r9b
 3c3:	48 85 f6             	test   %rsi,%rsi
 3c6:	0f 95 c0             	setne  %al
 3c9:	41 84 c1             	test   %al,%r9b
 3cc:	0f 85 bb 00 00 00    	jne    48d <n100_vector_trial+0xfd>
 3d2:	48 83 f9 07          	cmp    $0x7,%rcx
 3d6:	0f 86 b1 00 00 00    	jbe    48d <n100_vector_trial+0xfd>
 3dc:	55                   	push   %rbp
 3dd:	48 89 e5             	mov    %rsp,%rbp
 3e0:	41 57                	push   %r15
 3e2:	41 56                	push   %r14
 3e4:	49 89 d6             	mov    %rdx,%r14
 3e7:	41 54                	push   %r12
 3e9:	53                   	push   %rbx
 3ea:	48 89 fb             	mov    %rdi,%rbx
 3ed:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
 3f1:	48 83 ec 20          	sub    $0x20,%rsp
 3f5:	48 85 f6             	test   %rsi,%rsi
 3f8:	0f 84 3f 01 00 00    	je     53d <n100_vector_trial+0x1ad>
 3fe:	48 8d 52 08          	lea    0x8(%rdx),%rdx
 402:	48 83 e9 08          	sub    $0x8,%rcx
 406:	44 89 44 24 10       	mov    %r8d,0x10(%rsp)
 40b:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
 410:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
 415:	e8 00 00 00 00       	call   41a <n100_vector_trial+0x8a>
 41a:	41 89 c1             	mov    %eax,%r9d
 41d:	85 c0                	test   %eax,%eax
 41f:	7e 77                	jle    498 <n100_vector_trial+0x108>
 421:	44 8b 44 24 10       	mov    0x10(%rsp),%r8d
 426:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
 42b:	41 83 f8 0c          	cmp    $0xc,%r8d
 42f:	74 63                	je     494 <n100_vector_trial+0x104>
 431:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
 436:	4c 89 d6             	mov    %r10,%rsi
 439:	89 c1                	mov    %eax,%ecx
 43b:	48 89 df             	mov    %rbx,%rdi
 43e:	e8 4d fd ff ff       	call   190 <merge_repeats>
 443:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
 448:	41 89 c1             	mov    %eax,%r9d
 44b:	4b 8d 04 52          	lea    (%r10,%r10,2),%rax
 44f:	44 89 ca             	mov    %r9d,%edx
 452:	48 c1 e8 02          	shr    $0x2,%rax
 456:	48 39 d0             	cmp    %rdx,%rax
 459:	72 3d                	jb     498 <n100_vector_trial+0x108>
 45b:	49 83 fa 0f          	cmp    $0xf,%r10
 45f:	76 0c                	jbe    46d <n100_vector_trial+0xdd>
 461:	4c 89 d0             	mov    %r10,%rax
 464:	48 c1 e8 02          	shr    $0x2,%rax
 468:	48 39 d0             	cmp    %rdx,%rax
 46b:	72 3e                	jb     4ab <n100_vector_trial+0x11b>
 46d:	ba 01 00 00 00       	mov    $0x1,%edx
 472:	4c 89 d6             	mov    %r10,%rsi
 475:	4c 89 f7             	mov    %r14,%rdi
 478:	44 89 4c 24 18       	mov    %r9d,0x18(%rsp)
 47d:	e8 8e fb ff ff       	call   10 <header>
 482:	44 8b 4c 24 18       	mov    0x18(%rsp),%r9d
 487:	41 8d 41 08          	lea    0x8(%r9),%eax
 48b:	eb 0d                	jmp    49a <n100_vector_trial+0x10a>
 48d:	31 c0                	xor    %eax,%eax
 48f:	e9 00 00 00 00       	jmp    494 <n100_vector_trial+0x104>
 494:	85 c0                	test   %eax,%eax
 496:	7f b3                	jg     44b <n100_vector_trial+0xbb>
 498:	31 c0                	xor    %eax,%eax
 49a:	48 8d 65 e0          	lea    -0x20(%rbp),%rsp
 49e:	5b                   	pop    %rbx
 49f:	41 5c                	pop    %r12
 4a1:	41 5e                	pop    %r14
 4a3:	41 5f                	pop    %r15
 4a5:	5d                   	pop    %rbp
 4a6:	e9 00 00 00 00       	jmp    4ab <n100_vector_trial+0x11b>
 4ab:	48 8b 33             	mov    (%rbx),%rsi
 4ae:	48 85 f6             	test   %rsi,%rsi
 4b1:	74 ba                	je     46d <n100_vector_trial+0xdd>
 4b3:	45 31 c0             	xor    %r8d,%r8d
 4b6:	49 8d 42 f8          	lea    -0x8(%r10),%rax
 4ba:	41 8d 52 f8          	lea    -0x8(%r10),%edx
 4be:	44 89 4c 24 04       	mov    %r9d,0x4(%rsp)
 4c3:	f3 4c 0f bc c6       	tzcnt  %rsi,%r8
 4c8:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
 4cd:	41 c1 e8 03          	shr    $0x3,%r8d
 4d1:	48 3d 00 04 00 00    	cmp    $0x400,%rax
 4d7:	b8 00 04 00 00       	mov    $0x400,%eax
 4dc:	4c 89 54 24 18       	mov    %r10,0x18(%rsp)
 4e1:	0f 42 c2             	cmovb  %edx,%eax
 4e4:	44 89 44 24 10       	mov    %r8d,0x10(%rsp)
 4e9:	41 89 c7             	mov    %eax,%r15d
 4ec:	e8 00 00 00 00       	call   4f1 <n100_vector_trial+0x161>
 4f1:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
 4f6:	44 8b 44 24 10       	mov    0x10(%rsp),%r8d
 4fb:	85 c0                	test   %eax,%eax
 4fd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 502:	44 8b 4c 24 04       	mov    0x4(%rsp),%r9d
 507:	75 4a                	jne    553 <n100_vector_trial+0x1c3>
 509:	48 89 f1             	mov    %rsi,%rcx
 50c:	44 89 fa             	mov    %r15d,%edx
 50f:	be 01 00 00 00       	mov    $0x1,%esi
 514:	48 89 df             	mov    %rbx,%rdi
 517:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
 51c:	44 89 4c 24 18       	mov    %r9d,0x18(%rsp)
 521:	e8 1a fb ff ff       	call   40 <prefix_scalar>
 526:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
 52b:	44 8b 4c 24 18       	mov    0x18(%rsp),%r9d
 530:	85 c0                	test   %eax,%eax
 532:	0f 85 60 ff ff ff    	jne    498 <n100_vector_trial+0x108>
 538:	e9 30 ff ff ff       	jmp    46d <n100_vector_trial+0xdd>
 53d:	31 d2                	xor    %edx,%edx
 53f:	31 f6                	xor    %esi,%esi
 541:	4c 89 f7             	mov    %r14,%rdi
 544:	e8 c7 fa ff ff       	call   10 <header>
 549:	b8 08 00 00 00       	mov    $0x8,%eax
 54e:	e9 47 ff ff ff       	jmp    49a <n100_vector_trial+0x10a>
 553:	42 8d 0c c5 00 00 00 	lea    0x0(,%r8,8),%ecx
 55a:	00 
 55b:	48 89 f0             	mov    %rsi,%rax
 55e:	bf 01 00 00 00       	mov    $0x1,%edi
 563:	48 d3 e8             	shr    %cl,%rax
 566:	c5 f9 6e c0          	vmovd  %eax,%xmm0
 56a:	44 89 c0             	mov    %r8d,%eax
 56d:	48 8d 54 03 01       	lea    0x1(%rbx,%rax,1),%rdx
 572:	44 89 f8             	mov    %r15d,%eax
 575:	c4 e2 7d 78 c0       	vpbroadcastb %xmm0,%ymm0
 57a:	83 e0 e0             	and    $0xffffffe0,%eax
 57d:	44 8d 60 01          	lea    0x1(%rax),%r12d
 581:	44 39 e7             	cmp    %r12d,%edi
 584:	74 41                	je     5c7 <n100_vector_trial+0x237>
 586:	c5 fd 74 0a          	vpcmpeqb (%rdx),%ymm0,%ymm1
 58a:	c5 fd d7 c1          	vpmovmskb %ymm1,%eax
 58e:	eb 27                	jmp    5b7 <n100_vector_trial+0x227>
 590:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
 595:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 59c:	00 00 00 00 
 5a0:	31 c9                	xor    %ecx,%ecx
 5a2:	44 8d 58 ff          	lea    -0x1(%rax),%r11d
 5a6:	f3 0f bc c8          	tzcnt  %eax,%ecx
 5aa:	44 21 d8             	and    %r11d,%eax
 5ad:	01 f9                	add    %edi,%ecx
 5af:	89 c9                	mov    %ecx,%ecx
 5b1:	48 3b 34 0b          	cmp    (%rbx,%rcx,1),%rsi
 5b5:	74 3c                	je     5f3 <n100_vector_trial+0x263>
 5b7:	85 c0                	test   %eax,%eax
 5b9:	75 e5                	jne    5a0 <n100_vector_trial+0x210>
 5bb:	83 c7 20             	add    $0x20,%edi
 5be:	48 83 c2 20          	add    $0x20,%rdx
 5c2:	41 39 ff             	cmp    %edi,%r15d
 5c5:	73 ba                	jae    581 <n100_vector_trial+0x1f1>
 5c7:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
 5cc:	48 89 f1             	mov    %rsi,%rcx
 5cf:	44 89 fa             	mov    %r15d,%edx
 5d2:	89 fe                	mov    %edi,%esi
 5d4:	44 89 4c 24 18       	mov    %r9d,0x18(%rsp)
 5d9:	48 89 df             	mov    %rbx,%rdi
 5dc:	c5 f8 77             	vzeroupper
 5df:	e8 5c fa ff ff       	call   40 <prefix_scalar>
 5e4:	44 8b 4c 24 18       	mov    0x18(%rsp),%r9d
 5e9:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
 5ee:	e9 3d ff ff ff       	jmp    530 <n100_vector_trial+0x1a0>
 5f3:	c5 f8 77             	vzeroupper
 5f6:	e9 9d fe ff ff       	jmp    498 <n100_vector_trial+0x108>
