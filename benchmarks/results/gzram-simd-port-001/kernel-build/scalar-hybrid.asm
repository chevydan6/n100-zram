
/home/dan/n100-zram/build/astra-simd-kernel-002/scalar/hybrid.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <lz4_encode-0x10>:
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

0000000000000010 <lz4_encode>:
  10:	e8 00 00 00 00       	call   15 <lz4_encode+0x5>
  15:	e9 00 00 00 00       	jmp    1a <lz4_encode+0xa>
  1a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
  2a:	90                   	nop
  2b:	90                   	nop
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop

0000000000000030 <header>:
  30:	e8 00 00 00 00       	call   35 <header+0x5>
  35:	c7 07 47 48 59 31    	movl   $0x31594847,(%rdi)
  3b:	66 89 77 04          	mov    %si,0x4(%rdi)
  3f:	88 57 06             	mov    %dl,0x6(%rdi)
  42:	c6 47 07 00          	movb   $0x0,0x7(%rdi)
  46:	e9 00 00 00 00       	jmp    4b <header+0x1b>
  4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
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

0000000000000060 <direct_repeat>:
  60:	e8 00 00 00 00       	call   65 <direct_repeat+0x5>
  65:	48 83 ec 30          	sub    $0x30,%rsp
  69:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 71 <direct_repeat+0x11>
  70:	00 
  71:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  76:	31 c0                	xor    %eax,%eax
  78:	48 83 fe 08          	cmp    $0x8,%rsi
  7c:	76 08                	jbe    86 <direct_repeat+0x26>
  7e:	81 3f 47 5a 52 31    	cmpl   $0x31525a47,(%rdi)
  84:	74 1e                	je     a4 <direct_repeat+0x44>
  86:	31 c0                	xor    %eax,%eax
  88:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
  8d:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # 95 <direct_repeat+0x35>
  94:	00 
  95:	0f 85 03 02 00 00    	jne    29e <direct_repeat+0x23e>
  9b:	48 83 c4 30          	add    $0x30,%rsp
  9f:	e9 00 00 00 00       	jmp    a4 <direct_repeat+0x44>
  a4:	80 7f 06 0c          	cmpb   $0xc,0x6(%rdi)
  a8:	75 dc                	jne    86 <direct_repeat+0x26>
  aa:	80 7f 07 00          	cmpb   $0x0,0x7(%rdi)
  ae:	75 d6                	jne    86 <direct_repeat+0x26>
  b0:	0f b7 47 04          	movzwl 0x4(%rdi),%eax
  b4:	48 39 c8             	cmp    %rcx,%rax
  b7:	75 cd                	jne    86 <direct_repeat+0x26>
  b9:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  bd:	3c 05                	cmp    $0x5,%al
  bf:	0f 84 a1 01 00 00    	je     266 <direct_repeat+0x206>
  c5:	0f 87 2a 01 00 00    	ja     1f5 <direct_repeat+0x195>
  cb:	3c 02                	cmp    $0x2,%al
  cd:	0f 84 51 01 00 00    	je     224 <direct_repeat+0x1c4>
  d3:	3c 03                	cmp    $0x3,%al
  d5:	75 af                	jne    86 <direct_repeat+0x26>
  d7:	48 83 f9 07          	cmp    $0x7,%rcx
  db:	76 a9                	jbe    86 <direct_repeat+0x26>
  dd:	f6 c1 07             	test   $0x7,%cl
  e0:	75 a4                	jne    86 <direct_repeat+0x26>
  e2:	b8 07 00 00 00       	mov    $0x7,%eax
  e7:	48 83 fe 11          	cmp    $0x11,%rsi
  eb:	75 99                	jne    86 <direct_repeat+0x26>
  ed:	48 8b 77 09          	mov    0x9(%rdi),%rsi
  f1:	48 89 34 24          	mov    %rsi,(%rsp)
  f5:	89 c6                	mov    %eax,%esi
  f7:	83 e6 08             	and    $0x8,%esi
  fa:	48 8b 74 37 09       	mov    0x9(%rdi,%rsi,1),%rsi
  ff:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
 104:	89 c6                	mov    %eax,%esi
 106:	83 e0 18             	and    $0x18,%eax
 109:	83 e6 10             	and    $0x10,%esi
 10c:	48 8b 44 07 09       	mov    0x9(%rdi,%rax,1),%rax
 111:	48 8b 74 37 09       	mov    0x9(%rdi,%rsi,1),%rsi
 116:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
 11b:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
 120:	48 83 f9 1f          	cmp    $0x1f,%rcx
 124:	0f 86 63 01 00 00    	jbe    28d <direct_repeat+0x22d>
 12a:	4c 8d 41 e0          	lea    -0x20(%rcx),%r8
 12e:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
 133:	48 8b 34 24          	mov    (%rsp),%rsi
 137:	48 89 d0             	mov    %rdx,%rax
 13a:	4c 89 c3             	mov    %r8,%rbx
 13d:	4c 8b 5c 24 08       	mov    0x8(%rsp),%r11
 142:	49 83 e0 e0          	and    $0xffffffffffffffe0,%r8
 146:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
 14b:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
 150:	4e 8d 44 02 20       	lea    0x20(%rdx,%r8,1),%r8
 155:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 15c:	00 00 00 00 
 160:	48 89 30             	mov    %rsi,(%rax)
 163:	48 83 c0 20          	add    $0x20,%rax
 167:	4c 89 58 e8          	mov    %r11,-0x18(%rax)
 16b:	4c 89 50 f0          	mov    %r10,-0x10(%rax)
 16f:	4c 89 48 f8          	mov    %r9,-0x8(%rax)
 173:	4c 39 c0             	cmp    %r8,%rax
 176:	75 e8                	jne    160 <direct_repeat+0x100>
 178:	48 89 de             	mov    %rbx,%rsi
 17b:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
 180:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
 184:	48 8d 46 20          	lea    0x20(%rsi),%rax
 188:	f6 c1 18             	test   $0x18,%cl
 18b:	74 56                	je     1e3 <direct_repeat+0x183>
 18d:	4c 8d 51 f8          	lea    -0x8(%rcx),%r10
 191:	48 8d 70 08          	lea    0x8(%rax),%rsi
 195:	49 29 c2             	sub    %rax,%r10
 198:	49 89 f3             	mov    %rsi,%r11
 19b:	4d 89 d1             	mov    %r10,%r9
 19e:	49 83 e1 f8          	and    $0xfffffffffffffff8,%r9
 1a2:	49 01 f1             	add    %rsi,%r9
 1a5:	eb 1d                	jmp    1c4 <direct_repeat+0x164>
 1a7:	0f 1f 00             	nopl   (%rax)
 1aa:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 1b1:	00 00 00 00 
 1b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 1bc:	00 00 00 00 
 1c0:	48 83 c6 08          	add    $0x8,%rsi
 1c4:	49 89 c0             	mov    %rax,%r8
 1c7:	41 83 e0 18          	and    $0x18,%r8d
 1cb:	4e 8b 04 04          	mov    (%rsp,%r8,1),%r8
 1cf:	4c 89 04 02          	mov    %r8,(%rdx,%rax,1)
 1d3:	48 89 f0             	mov    %rsi,%rax
 1d6:	4c 39 ce             	cmp    %r9,%rsi
 1d9:	75 e5                	jne    1c0 <direct_repeat+0x160>
 1db:	49 83 e2 f8          	and    $0xfffffffffffffff8,%r10
 1df:	4b 8d 04 1a          	lea    (%r10,%r11,1),%rax
 1e3:	48 39 c1             	cmp    %rax,%rcx
 1e6:	74 06                	je     1ee <direct_repeat+0x18e>
 1e8:	8b 77 09             	mov    0x9(%rdi),%esi
 1eb:	89 34 02             	mov    %esi,(%rdx,%rax,1)
 1ee:	89 c8                	mov    %ecx,%eax
 1f0:	e9 93 fe ff ff       	jmp    88 <direct_repeat+0x28>
 1f5:	3c 06                	cmp    $0x6,%al
 1f7:	0f 85 89 fe ff ff    	jne    86 <direct_repeat+0x26>
 1fd:	48 83 f9 1f          	cmp    $0x1f,%rcx
 201:	0f 86 7f fe ff ff    	jbe    86 <direct_repeat+0x26>
 207:	f6 c1 1f             	test   $0x1f,%cl
 20a:	0f 85 76 fe ff ff    	jne    86 <direct_repeat+0x26>
 210:	48 83 fe 29          	cmp    $0x29,%rsi
 214:	0f 85 6c fe ff ff    	jne    86 <direct_repeat+0x26>
 21a:	b8 1f 00 00 00       	mov    $0x1f,%eax
 21f:	e9 c9 fe ff ff       	jmp    ed <direct_repeat+0x8d>
 224:	48 83 f9 03          	cmp    $0x3,%rcx
 228:	0f 86 58 fe ff ff    	jbe    86 <direct_repeat+0x26>
 22e:	f6 c1 03             	test   $0x3,%cl
 231:	0f 85 4f fe ff ff    	jne    86 <direct_repeat+0x26>
 237:	48 83 fe 0d          	cmp    $0xd,%rsi
 23b:	0f 85 45 fe ff ff    	jne    86 <direct_repeat+0x26>
 241:	8b 77 09             	mov    0x9(%rdi),%esi
 244:	48 89 f0             	mov    %rsi,%rax
 247:	48 c1 e0 20          	shl    $0x20,%rax
 24b:	48 01 f0             	add    %rsi,%rax
 24e:	48 89 04 24          	mov    %rax,(%rsp)
 252:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
 257:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
 25c:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
 261:	e9 ba fe ff ff       	jmp    120 <direct_repeat+0xc0>
 266:	48 83 f9 0f          	cmp    $0xf,%rcx
 26a:	0f 86 16 fe ff ff    	jbe    86 <direct_repeat+0x26>
 270:	f6 c1 0f             	test   $0xf,%cl
 273:	0f 85 0d fe ff ff    	jne    86 <direct_repeat+0x26>
 279:	b8 0f 00 00 00       	mov    $0xf,%eax
 27e:	48 83 fe 19          	cmp    $0x19,%rsi
 282:	0f 84 65 fe ff ff    	je     ed <direct_repeat+0x8d>
 288:	e9 f9 fd ff ff       	jmp    86 <direct_repeat+0x26>
 28d:	31 c0                	xor    %eax,%eax
 28f:	48 83 f9 07          	cmp    $0x7,%rcx
 293:	0f 87 f4 fe ff ff    	ja     18d <direct_repeat+0x12d>
 299:	e9 4a ff ff ff       	jmp    1e8 <direct_repeat+0x188>
 29e:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
 2a3:	e8 00 00 00 00       	call   2a8 <direct_repeat+0x248>
 2a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 2af:	00 
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

00000000000002c0 <merge_repeats>:
 2c0:	e8 00 00 00 00       	call   2c5 <merge_repeats+0x5>
 2c5:	49 89 f1             	mov    %rsi,%r9
 2c8:	89 c8                	mov    %ecx,%eax
 2ca:	48 89 d6             	mov    %rdx,%rsi
 2cd:	80 7a 07 00          	cmpb   $0x0,0x7(%rdx)
 2d1:	75 58                	jne    32b <merge_repeats+0x6b>
 2d3:	0f b6 52 08          	movzbl 0x8(%rdx),%edx
 2d7:	80 fa 05             	cmp    $0x5,%dl
 2da:	0f 84 36 01 00 00    	je     416 <merge_repeats+0x156>
 2e0:	77 4e                	ja     330 <merge_repeats+0x70>
 2e2:	80 fa 02             	cmp    $0x2,%dl
 2e5:	0f 84 ec 00 00 00    	je     3d7 <merge_repeats+0x117>
 2eb:	80 fa 03             	cmp    $0x3,%dl
 2ee:	0f 85 6f 01 00 00    	jne    463 <merge_repeats+0x1a3>
 2f4:	44 89 c1             	mov    %r8d,%ecx
 2f7:	ba 01 00 00 00       	mov    $0x1,%edx
 2fc:	48 d3 e2             	shl    %cl,%rdx
 2ff:	49 89 d0             	mov    %rdx,%r8
 302:	4c 39 ca             	cmp    %r9,%rdx
 305:	73 24                	jae    32b <merge_repeats+0x6b>
 307:	48 8d 4e 09          	lea    0x9(%rsi),%rcx
 30b:	eb 10                	jmp    31d <merge_repeats+0x5d>
 30d:	4c 01 c2             	add    %r8,%rdx
 310:	48 83 c1 01          	add    $0x1,%rcx
 314:	4c 39 ca             	cmp    %r9,%rdx
 317:	0f 83 68 01 00 00    	jae    485 <merge_repeats+0x1c5>
 31d:	80 39 03             	cmpb   $0x3,(%rcx)
 320:	75 09                	jne    32b <merge_repeats+0x6b>
 322:	4c 8b 14 17          	mov    (%rdi,%rdx,1),%r10
 326:	4c 39 17             	cmp    %r10,(%rdi)
 329:	74 e2                	je     30d <merge_repeats+0x4d>
 32b:	e9 00 00 00 00       	jmp    330 <merge_repeats+0x70>
 330:	80 fa 06             	cmp    $0x6,%dl
 333:	0f 85 2f 01 00 00    	jne    468 <merge_repeats+0x1a8>
 339:	44 89 c1             	mov    %r8d,%ecx
 33c:	ba 01 00 00 00       	mov    $0x1,%edx
 341:	4c 8d 5e 09          	lea    0x9(%rsi),%r11
 345:	48 d3 e2             	shl    %cl,%rdx
 348:	49 89 d0             	mov    %rdx,%r8
 34b:	4c 39 ca             	cmp    %r9,%rdx
 34e:	0f 83 19 01 00 00    	jae    46d <merge_repeats+0x1ad>
 354:	41 80 3b 06          	cmpb   $0x6,(%r11)
 358:	75 d1                	jne    32b <merge_repeats+0x6b>
 35a:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
 35e:	4c 8b 17             	mov    (%rdi),%r10
 361:	4a 33 4c 07 08       	xor    0x8(%rdi,%r8,1),%rcx
 366:	4e 33 14 07          	xor    (%rdi,%r8,1),%r10
 36a:	4c 09 d1             	or     %r10,%rcx
 36d:	4c 8b 57 10          	mov    0x10(%rdi),%r10
 371:	4e 33 54 07 10       	xor    0x10(%rdi,%r8,1),%r10
 376:	4c 09 d1             	or     %r10,%rcx
 379:	4c 8b 57 18          	mov    0x18(%rdi),%r10
 37d:	4e 33 54 07 18       	xor    0x18(%rdi,%r8,1),%r10
 382:	49 09 ca             	or     %rcx,%r10
 385:	75 a4                	jne    32b <merge_repeats+0x6b>
 387:	49 01 d0             	add    %rdx,%r8
 38a:	49 83 c3 01          	add    $0x1,%r11
 38e:	4d 39 c8             	cmp    %r9,%r8
 391:	72 c1                	jb     354 <merge_repeats+0x94>
 393:	b8 29 00 00 00       	mov    $0x29,%eax
 398:	ba 20 00 00 00       	mov    $0x20,%edx
 39d:	c6 46 06 0c          	movb   $0xc,0x6(%rsi)
 3a1:	48 8b 0f             	mov    (%rdi),%rcx
 3a4:	48 89 4e 09          	mov    %rcx,0x9(%rsi)
 3a8:	83 fa 08             	cmp    $0x8,%edx
 3ab:	0f 84 e3 00 00 00    	je     494 <merge_repeats+0x1d4>
 3b1:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
 3b5:	48 89 4e 11          	mov    %rcx,0x11(%rsi)
 3b9:	83 fa 10             	cmp    $0x10,%edx
 3bc:	0f 84 69 ff ff ff    	je     32b <merge_repeats+0x6b>
 3c2:	48 8b 57 10          	mov    0x10(%rdi),%rdx
 3c6:	48 89 56 19          	mov    %rdx,0x19(%rsi)
 3ca:	48 8b 57 18          	mov    0x18(%rdi),%rdx
 3ce:	48 89 56 21          	mov    %rdx,0x21(%rsi)
 3d2:	e9 00 00 00 00       	jmp    3d7 <merge_repeats+0x117>
 3d7:	44 89 c1             	mov    %r8d,%ecx
 3da:	ba 01 00 00 00       	mov    $0x1,%edx
 3df:	48 d3 e2             	shl    %cl,%rdx
 3e2:	48 8d 4e 09          	lea    0x9(%rsi),%rcx
 3e6:	49 89 d0             	mov    %rdx,%r8
 3e9:	4c 39 ca             	cmp    %r9,%rdx
 3ec:	72 1e                	jb     40c <merge_repeats+0x14c>
 3ee:	e9 00 00 00 00       	jmp    3f3 <merge_repeats+0x133>
 3f3:	44 8b 1f             	mov    (%rdi),%r11d
 3f6:	44 39 1c 17          	cmp    %r11d,(%rdi,%rdx,1)
 3fa:	0f 85 2b ff ff ff    	jne    32b <merge_repeats+0x6b>
 400:	4c 01 c2             	add    %r8,%rdx
 403:	48 83 c1 01          	add    $0x1,%rcx
 407:	4c 39 ca             	cmp    %r9,%rdx
 40a:	73 66                	jae    472 <merge_repeats+0x1b2>
 40c:	80 39 02             	cmpb   $0x2,(%rcx)
 40f:	74 e2                	je     3f3 <merge_repeats+0x133>
 411:	e9 00 00 00 00       	jmp    416 <merge_repeats+0x156>
 416:	44 89 c1             	mov    %r8d,%ecx
 419:	41 ba 01 00 00 00    	mov    $0x1,%r10d
 41f:	4c 8d 5e 09          	lea    0x9(%rsi),%r11
 423:	49 d3 e2             	shl    %cl,%r10
 426:	4c 89 d1             	mov    %r10,%rcx
 429:	4d 39 ca             	cmp    %r9,%r10
 42c:	72 11                	jb     43f <merge_repeats+0x17f>
 42e:	e9 00 00 00 00       	jmp    433 <merge_repeats+0x173>
 433:	4c 01 d1             	add    %r10,%rcx
 436:	49 83 c3 01          	add    $0x1,%r11
 43a:	4c 39 c9             	cmp    %r9,%rcx
 43d:	73 5a                	jae    499 <merge_repeats+0x1d9>
 43f:	41 80 3b 05          	cmpb   $0x5,(%r11)
 443:	0f 85 e2 fe ff ff    	jne    32b <merge_repeats+0x6b>
 449:	4c 8b 07             	mov    (%rdi),%r8
 44c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
 450:	4c 33 04 0f          	xor    (%rdi,%rcx,1),%r8
 454:	48 33 54 0f 08       	xor    0x8(%rdi,%rcx,1),%rdx
 459:	4c 09 c2             	or     %r8,%rdx
 45c:	74 d5                	je     433 <merge_repeats+0x173>
 45e:	e9 00 00 00 00       	jmp    463 <merge_repeats+0x1a3>
 463:	e9 00 00 00 00       	jmp    468 <merge_repeats+0x1a8>
 468:	e9 00 00 00 00       	jmp    46d <merge_repeats+0x1ad>
 46d:	e9 00 00 00 00       	jmp    472 <merge_repeats+0x1b2>
 472:	c6 46 06 0c          	movb   $0xc,0x6(%rsi)
 476:	8b 07                	mov    (%rdi),%eax
 478:	89 46 09             	mov    %eax,0x9(%rsi)
 47b:	b8 0d 00 00 00       	mov    $0xd,%eax
 480:	e9 00 00 00 00       	jmp    485 <merge_repeats+0x1c5>
 485:	b8 11 00 00 00       	mov    $0x11,%eax
 48a:	ba 08 00 00 00       	mov    $0x8,%edx
 48f:	e9 09 ff ff ff       	jmp    39d <merge_repeats+0xdd>
 494:	e9 00 00 00 00       	jmp    499 <merge_repeats+0x1d9>
 499:	b8 19 00 00 00       	mov    $0x19,%eax
 49e:	ba 10 00 00 00       	mov    $0x10,%edx
 4a3:	e9 f5 fe ff ff       	jmp    39d <merge_repeats+0xdd>
 4a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 4af:	00 
 4b0:	90                   	nop
 4b1:	90                   	nop
 4b2:	90                   	nop
 4b3:	90                   	nop
 4b4:	90                   	nop
 4b5:	90                   	nop
 4b6:	90                   	nop
 4b7:	90                   	nop
 4b8:	90                   	nop
 4b9:	90                   	nop
 4ba:	90                   	nop
 4bb:	90                   	nop
 4bc:	90                   	nop
 4bd:	90                   	nop
 4be:	90                   	nop
 4bf:	90                   	nop

00000000000004c0 <n100_ghy_workspace_size>:
 4c0:	f3 0f 1e fa          	endbr64
 4c4:	e8 00 00 00 00       	call   4c9 <n100_ghy_workspace_size+0x9>
 4c9:	b8 20 10 00 00       	mov    $0x1020,%eax
 4ce:	e9 00 00 00 00       	jmp    4d3 <n100_ghy_workspace_size+0x13>
 4d3:	66 90                	xchg   %ax,%ax
 4d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 4dc:	00 00 00 00 
 4e0:	90                   	nop
 4e1:	90                   	nop
 4e2:	90                   	nop
 4e3:	90                   	nop
 4e4:	90                   	nop
 4e5:	90                   	nop
 4e6:	90                   	nop
 4e7:	90                   	nop
 4e8:	90                   	nop
 4e9:	90                   	nop
 4ea:	90                   	nop
 4eb:	90                   	nop
 4ec:	90                   	nop
 4ed:	90                   	nop
 4ee:	90                   	nop
 4ef:	90                   	nop

00000000000004f0 <n100_ghy_workspace_alignment>:
 4f0:	f3 0f 1e fa          	endbr64
 4f4:	e8 00 00 00 00       	call   4f9 <n100_ghy_workspace_alignment+0x9>
 4f9:	b8 08 00 00 00       	mov    $0x8,%eax
 4fe:	e9 00 00 00 00       	jmp    503 <n100_ghy_workspace_alignment+0x13>
 503:	66 90                	xchg   %ax,%ax
 505:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 50c:	00 00 00 00 
 510:	90                   	nop
 511:	90                   	nop
 512:	90                   	nop
 513:	90                   	nop
 514:	90                   	nop
 515:	90                   	nop
 516:	90                   	nop
 517:	90                   	nop
 518:	90                   	nop
 519:	90                   	nop
 51a:	90                   	nop
 51b:	90                   	nop
 51c:	90                   	nop
 51d:	90                   	nop
 51e:	90                   	nop
 51f:	90                   	nop

0000000000000520 <n100_ghy_encode>:
 520:	f3 0f 1e fa          	endbr64
 524:	e8 00 00 00 00       	call   529 <n100_ghy_encode+0x9>
 529:	4d 85 c9             	test   %r9,%r9
 52c:	0f 84 01 01 00 00    	je     633 <n100_ghy_encode+0x113>
 532:	48 83 ec 48          	sub    $0x48,%rsp
 536:	48 81 7c 24 50 1f 10 	cmpq   $0x101f,0x50(%rsp)
 53d:	00 00 
 53f:	76 06                	jbe    547 <n100_ghy_encode+0x27>
 541:	41 f6 c1 07          	test   $0x7,%r9b
 545:	74 0b                	je     552 <n100_ghy_encode+0x32>
 547:	31 c0                	xor    %eax,%eax
 549:	48 83 c4 48          	add    $0x48,%rsp
 54d:	e9 00 00 00 00       	jmp    552 <n100_ghy_encode+0x32>
 552:	41 8d 40 fb          	lea    -0x5(%r8),%eax
 556:	83 f8 07             	cmp    $0x7,%eax
 559:	77 ec                	ja     547 <n100_ghy_encode+0x27>
 55b:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
 562:	77 e3                	ja     547 <n100_ghy_encode+0x27>
 564:	48 85 d2             	test   %rdx,%rdx
 567:	74 de                	je     547 <n100_ghy_encode+0x27>
 569:	48 85 ff             	test   %rdi,%rdi
 56c:	41 0f 94 c2          	sete   %r10b
 570:	48 85 f6             	test   %rsi,%rsi
 573:	0f 95 c0             	setne  %al
 576:	41 84 c2             	test   %al,%r10b
 579:	75 cc                	jne    547 <n100_ghy_encode+0x27>
 57b:	48 83 f9 07          	cmp    $0x7,%rcx
 57f:	76 c6                	jbe    547 <n100_ghy_encode+0x27>
 581:	4c 89 6c 24 30       	mov    %r13,0x30(%rsp)
 586:	4d 89 cd             	mov    %r9,%r13
 589:	4c 89 74 24 38       	mov    %r14,0x38(%rsp)
 58e:	49 89 fe             	mov    %rdi,%r14
 591:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
 596:	49 89 d7             	mov    %rdx,%r15
 599:	48 85 f6             	test   %rsi,%rsi
 59c:	0f 84 df 02 00 00    	je     881 <n100_ghy_encode+0x361>
 5a2:	48 83 e9 08          	sub    $0x8,%rcx
 5a6:	48 8d 52 08          	lea    0x8(%rdx),%rdx
 5aa:	48 89 6c 24 20       	mov    %rbp,0x20(%rsp)
 5af:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
 5b4:	48 89 cd             	mov    %rcx,%rbp
 5b7:	48 89 34 24          	mov    %rsi,(%rsp)
 5bb:	e8 00 00 00 00       	call   5c0 <n100_ghy_encode+0xa0>
 5c0:	4c 8b 14 24          	mov    (%rsp),%r10
 5c4:	85 c0                	test   %eax,%eax
 5c6:	7e 76                	jle    63e <n100_ghy_encode+0x11e>
 5c8:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
 5cd:	41 83 f8 0c          	cmp    $0xc,%r8d
 5d1:	74 67                	je     63a <n100_ghy_encode+0x11a>
 5d3:	4c 89 d6             	mov    %r10,%rsi
 5d6:	89 c1                	mov    %eax,%ecx
 5d8:	49 8d 57 08          	lea    0x8(%r15),%rdx
 5dc:	4c 89 f7             	mov    %r14,%rdi
 5df:	e8 dc fc ff ff       	call   2c0 <merge_repeats>
 5e4:	4c 8b 14 24          	mov    (%rsp),%r10
 5e8:	4b 8d 14 52          	lea    (%r10,%r10,2),%rdx
 5ec:	89 c1                	mov    %eax,%ecx
 5ee:	48 c1 ea 02          	shr    $0x2,%rdx
 5f2:	48 39 ca             	cmp    %rcx,%rdx
 5f5:	72 47                	jb     63e <n100_ghy_encode+0x11e>
 5f7:	49 83 fa 0f          	cmp    $0xf,%r10
 5fb:	0f 87 be 00 00 00    	ja     6bf <n100_ghy_encode+0x19f>
 601:	89 04 24             	mov    %eax,(%rsp)
 604:	ba 01 00 00 00       	mov    $0x1,%edx
 609:	4c 89 ff             	mov    %r15,%rdi
 60c:	4c 89 d6             	mov    %r10,%rsi
 60f:	e8 1c fa ff ff       	call   30 <header>
 614:	8b 04 24             	mov    (%rsp),%eax
 617:	48 8b 6c 24 20       	mov    0x20(%rsp),%rbp
 61c:	4c 8b 6c 24 30       	mov    0x30(%rsp),%r13
 621:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
 626:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
 62b:	83 c0 08             	add    $0x8,%eax
 62e:	e9 16 ff ff ff       	jmp    549 <n100_ghy_encode+0x29>
 633:	31 c0                	xor    %eax,%eax
 635:	e9 00 00 00 00       	jmp    63a <n100_ghy_encode+0x11a>
 63a:	85 c0                	test   %eax,%eax
 63c:	7f aa                	jg     5e8 <n100_ghy_encode+0xc8>
 63e:	b9 20 10 00 00       	mov    $0x1020,%ecx
 643:	44 89 d2             	mov    %r10d,%edx
 646:	4d 89 e8             	mov    %r13,%r8
 649:	4c 89 f7             	mov    %r14,%rdi
 64c:	48 39 cd             	cmp    %rcx,%rbp
 64f:	49 8d 77 08          	lea    0x8(%r15),%rsi
 653:	4c 89 14 24          	mov    %r10,(%rsp)
 657:	48 0f 46 cd          	cmovbe %rbp,%rcx
 65b:	e8 b0 f9 ff ff       	call   10 <lz4_encode>
 660:	4c 8b 14 24          	mov    (%rsp),%r10
 664:	48 63 d0             	movslq %eax,%rdx
 667:	4c 39 d2             	cmp    %r10,%rdx
 66a:	73 08                	jae    674 <n100_ghy_encode+0x154>
 66c:	85 c0                	test   %eax,%eax
 66e:	0f 8f 32 02 00 00    	jg     8a6 <n100_ghy_encode+0x386>
 674:	4c 39 d5             	cmp    %r10,%rbp
 677:	0f 82 eb 01 00 00    	jb     868 <n100_ghy_encode+0x348>
 67d:	4c 89 f6             	mov    %r14,%rsi
 680:	49 8d 7f 08          	lea    0x8(%r15),%rdi
 684:	4c 89 d2             	mov    %r10,%rdx
 687:	4c 89 14 24          	mov    %r10,(%rsp)
 68b:	e8 00 00 00 00       	call   690 <n100_ghy_encode+0x170>
 690:	48 8b 34 24          	mov    (%rsp),%rsi
 694:	4c 89 ff             	mov    %r15,%rdi
 697:	31 d2                	xor    %edx,%edx
 699:	e8 92 f9 ff ff       	call   30 <header>
 69e:	4c 8b 14 24          	mov    (%rsp),%r10
 6a2:	48 8b 6c 24 20       	mov    0x20(%rsp),%rbp
 6a7:	4c 8b 6c 24 30       	mov    0x30(%rsp),%r13
 6ac:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
 6b1:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
 6b6:	41 8d 42 08          	lea    0x8(%r10),%eax
 6ba:	e9 8a fe ff ff       	jmp    549 <n100_ghy_encode+0x29>
 6bf:	4c 89 d2             	mov    %r10,%rdx
 6c2:	48 c1 ea 02          	shr    $0x2,%rdx
 6c6:	48 39 ca             	cmp    %rcx,%rdx
 6c9:	0f 83 32 ff ff ff    	jae    601 <n100_ghy_encode+0xe1>
 6cf:	49 8b 3e             	mov    (%r14),%rdi
 6d2:	48 85 ff             	test   %rdi,%rdi
 6d5:	0f 84 26 ff ff ff    	je     601 <n100_ghy_encode+0xe1>
 6db:	31 f6                	xor    %esi,%esi
 6dd:	49 8d 52 f8          	lea    -0x8(%r10),%rdx
 6e1:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
 6e6:	f3 48 0f bc f7       	tzcnt  %rdi,%rsi
 6eb:	c1 ee 03             	shr    $0x3,%esi
 6ee:	48 81 fa ff 03 00 00 	cmp    $0x3ff,%rdx
 6f5:	0f 87 b8 01 00 00    	ja     8b3 <n100_ghy_encode+0x393>
 6fb:	41 8d 5a f8          	lea    -0x8(%r10),%ebx
 6ff:	41 8d 52 f9          	lea    -0x7(%r10),%edx
 703:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
 707:	8d 0c f5 00 00 00 00 	lea    0x0(,%rsi,8),%ecx
 70e:	49 89 f9             	mov    %rdi,%r9
 711:	83 ea 01             	sub    $0x1,%edx
 714:	4c 89 d3             	mov    %r10,%rbx
 717:	49 d3 e9             	shr    %cl,%r9
 71a:	83 e2 f8             	and    $0xfffffff8,%edx
 71d:	89 74 24 14          	mov    %esi,0x14(%rsp)
 721:	48 b9 01 01 01 01 01 	movabs $0x101010101010101,%rcx
 728:	01 01 01 
 72b:	45 0f b6 c1          	movzbl %r9b,%r8d
 72f:	83 c2 01             	add    $0x1,%edx
 732:	4d 89 ca             	mov    %r9,%r10
 735:	49 89 d9             	mov    %rbx,%r9
 738:	4c 0f af c1          	imul   %rcx,%r8
 73c:	89 54 24 10          	mov    %edx,0x10(%rsp)
 740:	89 f1                	mov    %esi,%ecx
 742:	89 c6                	mov    %eax,%esi
 744:	4d 8d 5c 0e 01       	lea    0x1(%r14,%rcx,1),%r11
 749:	4c 89 04 24          	mov    %r8,(%rsp)
 74d:	41 b8 01 00 00 00    	mov    $0x1,%r8d
 753:	48 bb ff fe fe fe fe 	movabs $0xfefefefefefefeff,%rbx
 75a:	fe fe fe 
 75d:	48 8b 0c 24          	mov    (%rsp),%rcx
 761:	49 33 0b             	xor    (%r11),%rcx
 764:	48 8d 14 19          	lea    (%rcx,%rbx,1),%rdx
 768:	48 f7 d1             	not    %rcx
 76b:	48 bb 80 80 80 80 80 	movabs $0x8080808080808080,%rbx
 772:	80 80 80 
 775:	48 21 ca             	and    %rcx,%rdx
 778:	48 21 da             	and    %rbx,%rdx
 77b:	4c 89 db             	mov    %r11,%rbx
 77e:	4d 89 d3             	mov    %r10,%r11
 781:	41 89 f2             	mov    %esi,%r10d
 784:	eb 5a                	jmp    7e0 <n100_ghy_encode+0x2c0>
 786:	0f 1f 00             	nopl   (%rax)
 789:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 790:	00 00 00 00 
 794:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 79b:	00 00 00 00 
 79f:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 7a6:	00 00 00 00 
 7aa:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 7b1:	00 00 00 00 
 7b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 7bc:	00 00 00 00 
 7c0:	31 c9                	xor    %ecx,%ecx
 7c2:	48 8d 72 ff          	lea    -0x1(%rdx),%rsi
 7c6:	f3 48 0f bc ca       	tzcnt  %rdx,%rcx
 7cb:	48 21 f2             	and    %rsi,%rdx
 7ce:	c1 e9 03             	shr    $0x3,%ecx
 7d1:	44 01 c1             	add    %r8d,%ecx
 7d4:	89 c9                	mov    %ecx,%ecx
 7d6:	49 3b 3c 0e          	cmp    (%r14,%rcx,1),%rdi
 7da:	0f 84 e5 00 00 00    	je     8c5 <n100_ghy_encode+0x3a5>
 7e0:	48 85 d2             	test   %rdx,%rdx
 7e3:	75 db                	jne    7c0 <n100_ghy_encode+0x2a0>
 7e5:	44 89 d6             	mov    %r10d,%esi
 7e8:	41 83 c0 08          	add    $0x8,%r8d
 7ec:	4d 89 da             	mov    %r11,%r10
 7ef:	44 39 44 24 0c       	cmp    %r8d,0xc(%rsp)
 7f4:	0f 82 d8 00 00 00    	jb     8d2 <n100_ghy_encode+0x3b2>
 7fa:	4c 8d 5b 08          	lea    0x8(%rbx),%r11
 7fe:	44 3b 44 24 10       	cmp    0x10(%rsp),%r8d
 803:	0f 85 4a ff ff ff    	jne    753 <n100_ghy_encode+0x233>
 809:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
 80d:	89 f0                	mov    %esi,%eax
 80f:	8b 74 24 14          	mov    0x14(%rsp),%esi
 813:	45 89 c3             	mov    %r8d,%r11d
 816:	4b 8d 4c 1e 01       	lea    0x1(%r14,%r11,1),%rcx
 81b:	4d 87 d1             	xchg   %r10,%r9
 81e:	4b 8d 14 1e          	lea    (%r14,%r11,1),%rdx
 822:	44 29 c3             	sub    %r8d,%ebx
 825:	41 01 f0             	add    %esi,%r8d
 828:	48 01 d9             	add    %rbx,%rcx
 82b:	45 89 c0             	mov    %r8d,%r8d
 82e:	eb 1d                	jmp    84d <n100_ghy_encode+0x32d>
 830:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
 835:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 83c:	00 00 00 00 
 840:	48 83 c2 01          	add    $0x1,%rdx
 844:	48 39 ca             	cmp    %rcx,%rdx
 847:	0f 84 8a 00 00 00    	je     8d7 <n100_ghy_encode+0x3b7>
 84d:	48 89 d6             	mov    %rdx,%rsi
 850:	4c 29 de             	sub    %r11,%rsi
 853:	46 3a 0c 06          	cmp    (%rsi,%r8,1),%r9b
 857:	75 e7                	jne    840 <n100_ghy_encode+0x320>
 859:	48 3b 3a             	cmp    (%rdx),%rdi
 85c:	75 e2                	jne    840 <n100_ghy_encode+0x320>
 85e:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
 863:	e9 d6 fd ff ff       	jmp    63e <n100_ghy_encode+0x11e>
 868:	48 8b 6c 24 20       	mov    0x20(%rsp),%rbp
 86d:	4c 8b 6c 24 30       	mov    0x30(%rsp),%r13
 872:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
 877:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
 87c:	e9 c6 fc ff ff       	jmp    547 <n100_ghy_encode+0x27>
 881:	4c 89 ff             	mov    %r15,%rdi
 884:	31 d2                	xor    %edx,%edx
 886:	31 f6                	xor    %esi,%esi
 888:	e8 a3 f7 ff ff       	call   30 <header>
 88d:	b8 08 00 00 00       	mov    $0x8,%eax
 892:	4c 8b 6c 24 30       	mov    0x30(%rsp),%r13
 897:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
 89c:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
 8a1:	e9 a3 fc ff ff       	jmp    549 <n100_ghy_encode+0x29>
 8a6:	89 04 24             	mov    %eax,(%rsp)
 8a9:	ba 02 00 00 00       	mov    $0x2,%edx
 8ae:	e9 56 fd ff ff       	jmp    609 <n100_ghy_encode+0xe9>
 8b3:	c7 44 24 0c 00 04 00 	movl   $0x400,0xc(%rsp)
 8ba:	00 
 8bb:	ba 01 04 00 00       	mov    $0x401,%edx
 8c0:	e9 42 fe ff ff       	jmp    707 <n100_ghy_encode+0x1e7>
 8c5:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
 8ca:	4d 89 ca             	mov    %r9,%r10
 8cd:	e9 6c fd ff ff       	jmp    63e <n100_ghy_encode+0x11e>
 8d2:	89 f0                	mov    %esi,%eax
 8d4:	4d 89 ca             	mov    %r9,%r10
 8d7:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
 8dc:	e9 20 fd ff ff       	jmp    601 <n100_ghy_encode+0xe1>
 8e1:	0f 1f 40 00          	nopl   0x0(%rax)
 8e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 8ec:	00 00 00 00 
 8f0:	90                   	nop
 8f1:	90                   	nop
 8f2:	90                   	nop
 8f3:	90                   	nop
 8f4:	90                   	nop
 8f5:	90                   	nop
 8f6:	90                   	nop
 8f7:	90                   	nop
 8f8:	90                   	nop
 8f9:	90                   	nop
 8fa:	90                   	nop
 8fb:	90                   	nop
 8fc:	90                   	nop
 8fd:	90                   	nop
 8fe:	90                   	nop
 8ff:	90                   	nop

0000000000000900 <n100_ghy_decode>:
 900:	f3 0f 1e fa          	endbr64
 904:	e8 00 00 00 00       	call   909 <n100_ghy_decode+0x9>
 909:	48 85 ff             	test   %rdi,%rdi
 90c:	0f 84 fa 00 00 00    	je     a0c <n100_ghy_decode+0x10c>
 912:	4c 8d 56 f8          	lea    -0x8(%rsi),%r10
 916:	49 81 fa 20 10 00 00 	cmp    $0x1020,%r10
 91d:	0f 87 e9 00 00 00    	ja     a0c <n100_ghy_decode+0x10c>
 923:	81 3f 47 48 59 31    	cmpl   $0x31594847,(%rdi)
 929:	0f 85 dd 00 00 00    	jne    a0c <n100_ghy_decode+0x10c>
 92f:	0f b6 47 06          	movzbl 0x6(%rdi),%eax
 933:	3c 02                	cmp    $0x2,%al
 935:	0f 87 d1 00 00 00    	ja     a0c <n100_ghy_decode+0x10c>
 93b:	80 7f 07 00          	cmpb   $0x0,0x7(%rdi)
 93f:	0f 85 c7 00 00 00    	jne    a0c <n100_ghy_decode+0x10c>
 945:	41 bb 00 10 00 00    	mov    $0x1000,%r11d
 94b:	49 89 d0             	mov    %rdx,%r8
 94e:	48 89 ca             	mov    %rcx,%rdx
 951:	0f b7 4f 04          	movzwl 0x4(%rdi),%ecx
 955:	4c 39 da             	cmp    %r11,%rdx
 958:	49 0f 47 d3          	cmova  %r11,%rdx
 95c:	49 89 c9             	mov    %rcx,%r9
 95f:	48 39 ca             	cmp    %rcx,%rdx
 962:	0f 82 a4 00 00 00    	jb     a0c <n100_ghy_decode+0x10c>
 968:	4d 85 c0             	test   %r8,%r8
 96b:	75 09                	jne    976 <n100_ghy_decode+0x76>
 96d:	48 85 c9             	test   %rcx,%rcx
 970:	0f 85 96 00 00 00    	jne    a0c <n100_ghy_decode+0x10c>
 976:	48 83 ec 28          	sub    $0x28,%rsp
 97a:	85 c0                	test   %eax,%eax
 97c:	75 23                	jne    9a1 <n100_ghy_decode+0xa1>
 97e:	48 8d 41 08          	lea    0x8(%rcx),%rax
 982:	48 39 c6             	cmp    %rax,%rsi
 985:	0f 85 bf 00 00 00    	jne    a4a <n100_ghy_decode+0x14a>
 98b:	48 85 c9             	test   %rcx,%rcx
 98e:	0f 85 82 00 00 00    	jne    a16 <n100_ghy_decode+0x116>
 994:	41 0f b7 c1          	movzwl %r9w,%eax
 998:	48 83 c4 28          	add    $0x28,%rsp
 99c:	e9 00 00 00 00       	jmp    9a1 <n100_ghy_decode+0xa1>
 9a1:	48 85 c9             	test   %rcx,%rcx
 9a4:	0f 84 a0 00 00 00    	je     a4a <n100_ghy_decode+0x14a>
 9aa:	48 83 c7 08          	add    $0x8,%rdi
 9ae:	83 f8 01             	cmp    $0x1,%eax
 9b1:	75 7f                	jne    a32 <n100_ghy_decode+0x132>
 9b3:	4c 89 c2             	mov    %r8,%rdx
 9b6:	4c 89 d6             	mov    %r10,%rsi
 9b9:	44 89 4c 24 24       	mov    %r9d,0x24(%rsp)
 9be:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
 9c3:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
 9c8:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
 9cd:	48 89 3c 24          	mov    %rdi,(%rsp)
 9d1:	e8 8a f6 ff ff       	call   60 <direct_repeat>
 9d6:	85 c0                	test   %eax,%eax
 9d8:	75 be                	jne    998 <n100_ghy_decode+0x98>
 9da:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
 9df:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
 9e4:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 9e9:	48 8b 3c 24          	mov    (%rsp),%rdi
 9ed:	e8 00 00 00 00       	call   9f2 <n100_ghy_decode+0xf2>
 9f2:	44 0f b7 4c 24 24    	movzwl 0x24(%rsp),%r9d
 9f8:	41 39 c1             	cmp    %eax,%r9d
 9fb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 a00:	0f 45 c2             	cmovne %edx,%eax
 a03:	48 83 c4 28          	add    $0x28,%rsp
 a07:	e9 00 00 00 00       	jmp    a0c <n100_ghy_decode+0x10c>
 a0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a11:	e9 00 00 00 00       	jmp    a16 <n100_ghy_decode+0x116>
 a16:	48 8d 77 08          	lea    0x8(%rdi),%rsi
 a1a:	4c 89 c7             	mov    %r8,%rdi
 a1d:	44 89 0c 24          	mov    %r9d,(%rsp)
 a21:	48 89 ca             	mov    %rcx,%rdx
 a24:	e8 00 00 00 00       	call   a29 <n100_ghy_decode+0x129>
 a29:	44 8b 0c 24          	mov    (%rsp),%r9d
 a2d:	e9 62 ff ff ff       	jmp    994 <n100_ghy_decode+0x94>
 a32:	8d 56 f8             	lea    -0x8(%rsi),%edx
 a35:	44 89 c9             	mov    %r9d,%ecx
 a38:	4c 89 c6             	mov    %r8,%rsi
 a3b:	44 89 0c 24          	mov    %r9d,(%rsp)
 a3f:	e8 00 00 00 00       	call   a44 <n100_ghy_decode+0x144>
 a44:	44 8b 0c 24          	mov    (%rsp),%r9d
 a48:	eb ae                	jmp    9f8 <n100_ghy_decode+0xf8>
 a4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a4f:	e9 44 ff ff ff       	jmp    998 <n100_ghy_decode+0x98>
