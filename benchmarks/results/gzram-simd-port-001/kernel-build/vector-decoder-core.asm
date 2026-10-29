
/home/dan/n100-zram/build/astra-simd-kernel-002/vector-decoder/core.o:     file format elf64-x86-64


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

0000000000000160 <encode>:
     160:	e8 00 00 00 00       	call   165 <encode+0x5>
     165:	55                   	push   %rbp
     166:	48 89 e5             	mov    %rsp,%rbp
     169:	41 57                	push   %r15
     16b:	49 89 ff             	mov    %rdi,%r15
     16e:	48 89 d7             	mov    %rdx,%rdi
     171:	41 56                	push   %r14
     173:	41 8d 50 fb          	lea    -0x5(%r8),%edx
     177:	41 55                	push   %r13
     179:	41 54                	push   %r12
     17b:	53                   	push   %rbx
     17c:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
     180:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
     187:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 18f <encode+0x2f>
     18e:	00 
     18f:	48 89 84 24 f8 00 00 	mov    %rax,0xf8(%rsp)
     196:	00 
     197:	48 8b 45 10          	mov    0x10(%rbp),%rax
     19b:	83 fa 07             	cmp    $0x7,%edx
     19e:	0f 87 b6 01 00 00    	ja     35a <encode+0x1fa>
     1a4:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
     1ab:	0f 87 a9 01 00 00    	ja     35a <encode+0x1fa>
     1b1:	48 85 ff             	test   %rdi,%rdi
     1b4:	0f 84 a0 01 00 00    	je     35a <encode+0x1fa>
     1ba:	4d 85 ff             	test   %r15,%r15
     1bd:	49 89 ca             	mov    %rcx,%r10
     1c0:	0f 94 c1             	sete   %cl
     1c3:	48 85 f6             	test   %rsi,%rsi
     1c6:	0f 95 c2             	setne  %dl
     1c9:	84 d1                	test   %dl,%cl
     1cb:	0f 85 89 01 00 00    	jne    35a <encode+0x1fa>
     1d1:	49 83 fa 07          	cmp    $0x7,%r10
     1d5:	0f 86 7f 01 00 00    	jbe    35a <encode+0x1fa>
     1db:	44 89 c1             	mov    %r8d,%ecx
     1de:	4d 89 cb             	mov    %r9,%r11
     1e1:	41 b9 01 00 00 00    	mov    $0x1,%r9d
     1e7:	49 d3 e1             	shl    %cl,%r9
     1ea:	49 8d 5c 31 ff       	lea    -0x1(%r9,%rsi,1),%rbx
     1ef:	48 d3 eb             	shr    %cl,%rbx
     1f2:	4c 8d 63 08          	lea    0x8(%rbx),%r12
     1f6:	4d 39 e2             	cmp    %r12,%r10
     1f9:	0f 82 35 02 00 00    	jb     434 <encode+0x2d4>
     1ff:	31 c9                	xor    %ecx,%ecx
     201:	44 89 c2             	mov    %r8d,%edx
     204:	4c 89 54 24 40       	mov    %r10,0x40(%rsp)
     209:	44 89 44 24 48       	mov    %r8d,0x48(%rsp)
     20e:	48 89 74 24 50       	mov    %rsi,0x50(%rsp)
     213:	48 89 7c 24 58       	mov    %rdi,0x58(%rsp)
     218:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
     21d:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
     222:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
     227:	e8 84 fe ff ff       	call   b0 <header>
     22c:	48 85 db             	test   %rbx,%rbx
     22f:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
     234:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
     239:	44 8b 44 24 48       	mov    0x48(%rsp),%r8d
     23e:	4c 8b 54 24 40       	mov    0x40(%rsp),%r10
     243:	0f 84 58 03 00 00    	je     5a1 <encode+0x441>
     249:	4c 8d 77 08          	lea    0x8(%rdi),%r14
     24d:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
     252:	4c 8b 6c 24 30       	mov    0x30(%rsp),%r13
     257:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
     25c:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
     260:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
     265:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     269:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
     26e:	49 8d 04 37          	lea    (%r15,%rsi,1),%rax
     272:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
     277:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
     27c:	4c 89 5c 24 28       	mov    %r11,0x28(%rsp)
     281:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
     286:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
     28b:	44 89 44 24 14       	mov    %r8d,0x14(%rsp)
     290:	eb 45                	jmp    2d7 <encode+0x177>
     292:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
     297:	4c 29 e0             	sub    %r12,%rax
     29a:	48 39 d8             	cmp    %rbx,%rax
     29d:	0f 82 dc 01 00 00    	jb     47f <encode+0x31f>
     2a3:	41 c6 06 00          	movb   $0x0,(%r14)
     2a7:	c5 f8 77             	vzeroupper
     2aa:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
     2af:	4c 89 fe             	mov    %r15,%rsi
     2b2:	48 89 da             	mov    %rbx,%rdx
     2b5:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
     2b9:	49 01 dc             	add    %rbx,%r12
     2bc:	e8 00 00 00 00       	call   2c1 <encode+0x161>
     2c1:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     2c5:	4d 01 ef             	add    %r13,%r15
     2c8:	49 83 c6 01          	add    $0x1,%r14
     2cc:	4c 39 74 24 48       	cmp    %r14,0x48(%rsp)
     2d1:	0f 84 34 01 00 00    	je     40b <encode+0x2ab>
     2d7:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
     2dc:	c5 fe 7f 44 24 70    	vmovdqu %ymm0,0x70(%rsp)
     2e2:	48 c7 84 24 f0 00 00 	movq   $0x0,0xf0(%rsp)
     2e9:	00 00 00 00 00 
     2ee:	c5 fe 7f 84 24 90 00 	vmovdqu %ymm0,0x90(%rsp)
     2f5:	00 00 
     2f7:	4c 29 fb             	sub    %r15,%rbx
     2fa:	c5 fe 7f 84 24 b0 00 	vmovdqu %ymm0,0xb0(%rsp)
     301:	00 00 
     303:	4c 39 eb             	cmp    %r13,%rbx
     306:	c5 fe 7f 84 24 d0 00 	vmovdqu %ymm0,0xd0(%rsp)
     30d:	00 00 
     30f:	49 0f 47 dd          	cmova  %r13,%rbx
     313:	49 89 d8             	mov    %rbx,%r8
     316:	41 83 e0 1f          	and    $0x1f,%r8d
     31a:	0f 85 72 ff ff ff    	jne    292 <encode+0x132>
     320:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
     325:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
     32a:	48 89 de             	mov    %rbx,%rsi
     32d:	4c 89 ff             	mov    %r15,%rdi
     330:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
     335:	c5 f8 77             	vzeroupper
     338:	e8 00 00 00 00       	call   33d <encode+0x1dd>
     33d:	8b 84 24 f0 00 00 00 	mov    0xf0(%rsp),%eax
     344:	4c 8b 44 24 40       	mov    0x40(%rsp),%r8
     349:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     34d:	85 c0                	test   %eax,%eax
     34f:	75 34                	jne    385 <encode+0x225>
     351:	41 c6 06 01          	movb   $0x1,(%r14)
     355:	e9 6b ff ff ff       	jmp    2c5 <encode+0x165>
     35a:	31 c0                	xor    %eax,%eax
     35c:	48 8b 94 24 f8 00 00 	mov    0xf8(%rsp),%rdx
     363:	00 
     364:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # 36c <encode+0x20c>
     36b:	00 
     36c:	0f 85 7c 02 00 00    	jne    5ee <encode+0x48e>
     372:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     376:	5b                   	pop    %rbx
     377:	41 5c                	pop    %r12
     379:	41 5d                	pop    %r13
     37b:	41 5e                	pop    %r14
     37d:	41 5f                	pop    %r15
     37f:	5d                   	pop    %rbp
     380:	e9 00 00 00 00       	jmp    385 <encode+0x225>
     385:	48 b9 02 00 00 00 03 	movabs $0x300000002,%rcx
     38c:	00 00 00 
     38f:	8b 94 24 f4 00 00 00 	mov    0xf4(%rsp),%edx
     396:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
     39b:	48 b9 05 00 00 00 06 	movabs $0x600000005,%rcx
     3a2:	00 00 00 
     3a5:	48 89 4c 24 68       	mov    %rcx,0x68(%rsp)
     3aa:	f6 c2 01             	test   $0x1,%dl
     3ad:	74 13                	je     3c2 <encode+0x262>
     3af:	48 83 fb 04          	cmp    $0x4,%rbx
     3b3:	0f 87 f3 01 00 00    	ja     5ac <encode+0x44c>
     3b9:	41 c6 06 00          	movb   $0x0,(%r14)
     3bd:	e9 e8 fe ff ff       	jmp    2aa <encode+0x14a>
     3c2:	f6 c2 02             	test   $0x2,%dl
     3c5:	0f 85 9b 00 00 00    	jne    466 <encode+0x306>
     3cb:	f6 c2 04             	test   $0x4,%dl
     3ce:	0f 84 da 00 00 00    	je     4ae <encode+0x34e>
     3d4:	48 83 fb 10          	cmp    $0x10,%rbx
     3d8:	76 df                	jbe    3b9 <encode+0x259>
     3da:	be 02 00 00 00       	mov    $0x2,%esi
     3df:	bb 10 00 00 00       	mov    $0x10,%ebx
     3e4:	8b 44 b4 60          	mov    0x60(%rsp,%rsi,4),%eax
     3e8:	48 83 fe 04          	cmp    $0x4,%rsi
     3ec:	0f 83 15 02 00 00    	jae    607 <encode+0x4a7>
     3f2:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
     3f7:	4c 29 e2             	sub    %r12,%rdx
     3fa:	48 39 da             	cmp    %rbx,%rdx
     3fd:	0f 82 cd 01 00 00    	jb     5d0 <encode+0x470>
     403:	41 88 06             	mov    %al,(%r14)
     406:	e9 9f fe ff ff       	jmp    2aa <encode+0x14a>
     40b:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
     410:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
     415:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
     41a:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
     41f:	44 8b 44 24 14       	mov    0x14(%rsp),%r8d
     424:	48 8d 56 08          	lea    0x8(%rsi),%rdx
     428:	44 89 e0             	mov    %r12d,%eax
     42b:	49 39 d4             	cmp    %rdx,%r12
     42e:	0f 82 28 ff ff ff    	jb     35c <encode+0x1fc>
     434:	48 8b 84 24 f8 00 00 	mov    0xf8(%rsp),%rax
     43b:	00 
     43c:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 444 <encode+0x2e4>
     443:	00 
     444:	0f 85 a4 01 00 00    	jne    5ee <encode+0x48e>
     44a:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     44e:	48 89 fa             	mov    %rdi,%rdx
     451:	4c 89 d1             	mov    %r10,%rcx
     454:	4c 89 ff             	mov    %r15,%rdi
     457:	5b                   	pop    %rbx
     458:	41 5c                	pop    %r12
     45a:	41 5d                	pop    %r13
     45c:	41 5e                	pop    %r14
     45e:	41 5f                	pop    %r15
     460:	5d                   	pop    %rbp
     461:	e9 7a fc ff ff       	jmp    e0 <raw_page>
     466:	48 83 fb 08          	cmp    $0x8,%rbx
     46a:	0f 86 49 ff ff ff    	jbe    3b9 <encode+0x259>
     470:	be 01 00 00 00       	mov    $0x1,%esi
     475:	bb 08 00 00 00       	mov    $0x8,%ebx
     47a:	e9 65 ff ff ff       	jmp    3e4 <encode+0x284>
     47f:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
     484:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
     489:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
     48e:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
     493:	44 8b 44 24 14       	mov    0x14(%rsp),%r8d
     498:	c5 f8 77             	vzeroupper
     49b:	48 89 fa             	mov    %rdi,%rdx
     49e:	4c 89 d1             	mov    %r10,%rcx
     4a1:	4c 89 ff             	mov    %r15,%rdi
     4a4:	e8 37 fc ff ff       	call   e0 <raw_page>
     4a9:	e9 ae fe ff ff       	jmp    35c <encode+0x1fc>
     4ae:	83 e2 08             	and    $0x8,%edx
     4b1:	74 0a                	je     4bd <encode+0x35d>
     4b3:	48 83 fb 20          	cmp    $0x20,%rbx
     4b7:	0f 87 fb 00 00 00    	ja     5b8 <encode+0x458>
     4bd:	49 89 db             	mov    %rbx,%r11
     4c0:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
     4c5:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
     4cc:	49 c1 eb 05          	shr    $0x5,%r11
     4d0:	4c 01 d8             	add    %r11,%rax
     4d3:	4c 29 e2             	sub    %r12,%rdx
     4d6:	48 39 d8             	cmp    %rbx,%rax
     4d9:	0f 83 e8 00 00 00    	jae    5c7 <encode+0x467>
     4df:	48 39 c2             	cmp    %rax,%rdx
     4e2:	0f 82 e8 00 00 00    	jb     5d0 <encode+0x470>
     4e8:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
     4ed:	41 c6 06 04          	movb   $0x4,(%r14)
     4f1:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
     4f6:	4c 89 da             	mov    %r11,%rdx
     4f9:	4c 89 5c 24 40       	mov    %r11,0x40(%rsp)
     4fe:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
     502:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
     507:	e8 00 00 00 00       	call   50c <encode+0x3ac>
     50c:	4c 8b 5c 24 40       	mov    0x40(%rsp),%r11
     511:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     515:	4d 01 dc             	add    %r11,%r12
     518:	4d 85 db             	test   %r11,%r11
     51b:	0f 84 a4 fd ff ff    	je     2c5 <encode+0x165>
     521:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
     526:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
     52b:	4c 89 6c 24 40       	mov    %r13,0x40(%rsp)
     530:	4d 89 dd             	mov    %r11,%r13
     533:	4c 89 34 24          	mov    %r14,(%rsp)
     537:	4d 89 e6             	mov    %r12,%r14
     53a:	48 81 fb 80 00 00 00 	cmp    $0x80,%rbx
     541:	0f 83 ac 00 00 00    	jae    5f3 <encode+0x493>
     547:	44 0f b6 64 1c 70    	movzbl 0x70(%rsp,%rbx,1),%r12d
     54d:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
     552:	4c 89 ff             	mov    %r15,%rdi
     555:	48 83 c3 01          	add    $0x1,%rbx
     559:	49 83 c7 20          	add    $0x20,%r15
     55d:	4a 8d 34 30          	lea    (%rax,%r14,1),%rsi
     561:	44 89 e2             	mov    %r12d,%edx
     564:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
     569:	e8 00 00 00 00       	call   56e <encode+0x40e>
     56e:	44 89 e0             	mov    %r12d,%eax
     571:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     575:	0f b6 80 00 00 00 00 	movzbl 0x0(%rax),%eax
     57c:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
     583:	49 01 c6             	add    %rax,%r14
     586:	49 39 dd             	cmp    %rbx,%r13
     589:	75 af                	jne    53a <encode+0x3da>
     58b:	4d 89 f4             	mov    %r14,%r12
     58e:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
     593:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
     598:	4c 8b 34 24          	mov    (%rsp),%r14
     59c:	e9 24 fd ff ff       	jmp    2c5 <encode+0x165>
     5a1:	41 bc 08 00 00 00    	mov    $0x8,%r12d
     5a7:	e9 78 fe ff ff       	jmp    424 <encode+0x2c4>
     5ac:	31 f6                	xor    %esi,%esi
     5ae:	bb 04 00 00 00       	mov    $0x4,%ebx
     5b3:	e9 2c fe ff ff       	jmp    3e4 <encode+0x284>
     5b8:	be 03 00 00 00       	mov    $0x3,%esi
     5bd:	bb 20 00 00 00       	mov    $0x20,%ebx
     5c2:	e9 1d fe ff ff       	jmp    3e4 <encode+0x284>
     5c7:	48 39 da             	cmp    %rbx,%rdx
     5ca:	0f 83 e9 fd ff ff    	jae    3b9 <encode+0x259>
     5d0:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
     5d5:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
     5da:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
     5df:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
     5e4:	44 8b 44 24 14       	mov    0x14(%rsp),%r8d
     5e9:	e9 ad fe ff ff       	jmp    49b <encode+0x33b>
     5ee:	e8 00 00 00 00       	call   5f3 <encode+0x493>
     5f3:	48 89 de             	mov    %rbx,%rsi
     5f6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     5fd:	e8 00 00 00 00       	call   602 <encode+0x4a2>
     602:	e9 40 ff ff ff       	jmp    547 <encode+0x3e7>
     607:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     60e:	89 44 24 40          	mov    %eax,0x40(%rsp)
     612:	e8 00 00 00 00       	call   617 <encode+0x4b7>
     617:	8b 44 24 40          	mov    0x40(%rsp),%eax
     61b:	e9 d2 fd ff ff       	jmp    3f2 <encode+0x292>
     620:	90                   	nop
     621:	90                   	nop
     622:	90                   	nop
     623:	90                   	nop
     624:	90                   	nop
     625:	90                   	nop
     626:	90                   	nop
     627:	90                   	nop
     628:	90                   	nop
     629:	90                   	nop
     62a:	90                   	nop
     62b:	90                   	nop
     62c:	90                   	nop
     62d:	90                   	nop
     62e:	90                   	nop
     62f:	90                   	nop

0000000000000630 <repeat_scalar>:
     630:	f3 0f 1e fa          	endbr64
     634:	e8 00 00 00 00       	call   639 <repeat_scalar+0x9>
     639:	48 85 d2             	test   %rdx,%rdx
     63c:	74 41                	je     67f <repeat_scalar+0x4f>
     63e:	41 57                	push   %r15
     640:	41 56                	push   %r14
     642:	49 89 f6             	mov    %rsi,%r14
     645:	41 55                	push   %r13
     647:	49 89 fd             	mov    %rdi,%r13
     64a:	41 54                	push   %r12
     64c:	49 89 d4             	mov    %rdx,%r12
     64f:	55                   	push   %rbp
     650:	89 cd                	mov    %ecx,%ebp
     652:	53                   	push   %rbx
     653:	31 db                	xor    %ebx,%ebx
     655:	49 89 ef             	mov    %rbp,%r15
     658:	49 8d 7c 1d 00       	lea    0x0(%r13,%rbx,1),%rdi
     65d:	4c 89 fa             	mov    %r15,%rdx
     660:	4c 89 f6             	mov    %r14,%rsi
     663:	48 01 eb             	add    %rbp,%rbx
     666:	e8 00 00 00 00       	call   66b <repeat_scalar+0x3b>
     66b:	4c 39 e3             	cmp    %r12,%rbx
     66e:	72 e8                	jb     658 <repeat_scalar+0x28>
     670:	5b                   	pop    %rbx
     671:	5d                   	pop    %rbp
     672:	41 5c                	pop    %r12
     674:	41 5d                	pop    %r13
     676:	41 5e                	pop    %r14
     678:	41 5f                	pop    %r15
     67a:	e9 00 00 00 00       	jmp    67f <repeat_scalar+0x4f>
     67f:	e9 00 00 00 00       	jmp    684 <repeat_scalar+0x54>
     684:	90                   	nop
     685:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     68c:	00 00 00 00 
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

00000000000006a0 <pack_avx2>:
     6a0:	f3 0f 1e fa          	endbr64
     6a4:	e8 00 00 00 00       	call   6a9 <pack_avx2+0x9>
     6a9:	55                   	push   %rbp
     6aa:	48 89 e5             	mov    %rsp,%rbp
     6ad:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
     6b1:	48 83 ec 60          	sub    $0x60,%rsp
     6b5:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 6bd <pack_avx2+0x1d>
     6bc:	00 
     6bd:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
     6c2:	31 c0                	xor    %eax,%eax
     6c4:	85 d2                	test   %edx,%edx
     6c6:	74 62                	je     72a <pack_avx2+0x8a>
     6c8:	c5 fe 6f 07          	vmovdqu (%rdi),%ymm0
     6cc:	48 89 f1             	mov    %rsi,%rcx
     6cf:	81 fa ff 00 00 00    	cmp    $0xff,%edx
     6d5:	74 68                	je     73f <pack_avx2+0x9f>
     6d7:	89 d0                	mov    %edx,%eax
     6d9:	81 fa 00 01 00 00    	cmp    $0x100,%edx
     6df:	77 6c                	ja     74d <pack_avx2+0xad>
     6e1:	48 89 c2             	mov    %rax,%rdx
     6e4:	48 c1 e2 05          	shl    $0x5,%rdx
     6e8:	c5 fd 6f 8a 00 00 00 	vmovdqa 0x0(%rdx),%ymm1
     6ef:	00 
     6f0:	c4 e2 75 36 c0       	vpermd %ymm0,%ymm1,%ymm0
     6f5:	c5 fe 7f 44 24 30    	vmovdqu %ymm0,0x30(%rsp)
     6fb:	48 3d 00 01 00 00    	cmp    $0x100,%rax
     701:	73 7f                	jae    782 <pack_avx2+0xe2>
     703:	c5 f8 77             	vzeroupper
     706:	0f b6 80 00 00 00 00 	movzbl 0x0(%rax),%eax
     70d:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
     714:	83 fa 20             	cmp    $0x20,%edx
     717:	0f 87 00 00 00 00    	ja     71d <pack_avx2+0x7d>
     71d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
     722:	48 89 cf             	mov    %rcx,%rdi
     725:	e8 00 00 00 00       	call   72a <pack_avx2+0x8a>
     72a:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
     72f:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 737 <pack_avx2+0x97>
     736:	00 
     737:	75 0f                	jne    748 <pack_avx2+0xa8>
     739:	c9                   	leave
     73a:	e9 00 00 00 00       	jmp    73f <pack_avx2+0x9f>
     73f:	c5 fe 7f 06          	vmovdqu %ymm0,(%rsi)
     743:	c5 f8 77             	vzeroupper
     746:	eb e2                	jmp    72a <pack_avx2+0x8a>
     748:	e8 00 00 00 00       	call   74d <pack_avx2+0xad>
     74d:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
     752:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     759:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
     75e:	48 89 c6             	mov    %rax,%rsi
     761:	c5 fd 7f 04 24       	vmovdqa %ymm0,(%rsp)
     766:	c5 f8 77             	vzeroupper
     769:	e8 00 00 00 00       	call   76e <pack_avx2+0xce>
     76e:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
     773:	c5 fd 6f 04 24       	vmovdqa (%rsp),%ymm0
     778:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
     77d:	e9 5f ff ff ff       	jmp    6e1 <pack_avx2+0x41>
     782:	48 89 0c 24          	mov    %rcx,(%rsp)
     786:	48 89 c6             	mov    %rax,%rsi
     789:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     790:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
     795:	c5 f8 77             	vzeroupper
     798:	e8 00 00 00 00       	call   79d <pack_avx2+0xfd>
     79d:	48 8b 0c 24          	mov    (%rsp),%rcx
     7a1:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
     7a6:	e9 5b ff ff ff       	jmp    706 <pack_avx2+0x66>
     7ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     7b0:	90                   	nop
     7b1:	90                   	nop
     7b2:	90                   	nop
     7b3:	90                   	nop
     7b4:	90                   	nop
     7b5:	90                   	nop
     7b6:	90                   	nop
     7b7:	90                   	nop
     7b8:	90                   	nop
     7b9:	90                   	nop
     7ba:	90                   	nop
     7bb:	90                   	nop
     7bc:	90                   	nop
     7bd:	90                   	nop
     7be:	90                   	nop
     7bf:	90                   	nop

00000000000007c0 <repeat_avx2>:
     7c0:	f3 0f 1e fa          	endbr64
     7c4:	e8 00 00 00 00       	call   7c9 <repeat_avx2+0x9>
     7c9:	55                   	push   %rbp
     7ca:	48 89 e5             	mov    %rsp,%rbp
     7cd:	41 57                	push   %r15
     7cf:	41 56                	push   %r14
     7d1:	49 89 f6             	mov    %rsi,%r14
     7d4:	41 55                	push   %r13
     7d6:	41 54                	push   %r12
     7d8:	53                   	push   %rbx
     7d9:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
     7dd:	48 83 ec 20          	sub    $0x20,%rsp
     7e1:	83 f9 04             	cmp    $0x4,%ecx
     7e4:	0f 84 e1 00 00 00    	je     8cb <repeat_avx2+0x10b>
     7ea:	83 f9 08             	cmp    $0x8,%ecx
     7ed:	0f 84 e2 00 00 00    	je     8d5 <repeat_avx2+0x115>
     7f3:	83 f9 10             	cmp    $0x10,%ecx
     7f6:	0f 84 a2 00 00 00    	je     89e <repeat_avx2+0xde>
     7fc:	c5 fe 6f 06          	vmovdqu (%rsi),%ymm0
     800:	48 83 fa 1f          	cmp    $0x1f,%rdx
     804:	0f 86 a3 00 00 00    	jbe    8ad <repeat_avx2+0xed>
     80a:	4c 8d 42 e0          	lea    -0x20(%rdx),%r8
     80e:	48 89 f8             	mov    %rdi,%rax
     811:	4c 89 c6             	mov    %r8,%rsi
     814:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
     818:	48 8d 74 37 20       	lea    0x20(%rdi,%rsi,1),%rsi
     81d:	49 89 f1             	mov    %rsi,%r9
     820:	49 29 f9             	sub    %rdi,%r9
     823:	41 83 e1 20          	and    $0x20,%r9d
     827:	74 17                	je     840 <repeat_avx2+0x80>
     829:	48 8d 47 20          	lea    0x20(%rdi),%rax
     82d:	c5 fe 7f 07          	vmovdqu %ymm0,(%rdi)
     831:	48 39 c6             	cmp    %rax,%rsi
     834:	74 1c                	je     852 <repeat_avx2+0x92>
     836:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
     83d:	00 00 00 
     840:	c5 fe 7f 00          	vmovdqu %ymm0,(%rax)
     844:	48 83 c0 40          	add    $0x40,%rax
     848:	c5 fe 7f 40 e0       	vmovdqu %ymm0,-0x20(%rax)
     84d:	48 39 c6             	cmp    %rax,%rsi
     850:	75 ee                	jne    840 <repeat_avx2+0x80>
     852:	49 83 e0 e0          	and    $0xffffffffffffffe0,%r8
     856:	4d 8d 78 20          	lea    0x20(%r8),%r15
     85a:	49 39 d7             	cmp    %rdx,%r15
     85d:	73 56                	jae    8b5 <repeat_avx2+0xf5>
     85f:	89 cb                	mov    %ecx,%ebx
     861:	49 89 d5             	mov    %rdx,%r13
     864:	49 89 fc             	mov    %rdi,%r12
     867:	48 89 d8             	mov    %rbx,%rax
     86a:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     86f:	c5 f8 77             	vzeroupper
     872:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
     877:	4b 8d 3c 3c          	lea    (%r12,%r15,1),%rdi
     87b:	4c 89 f6             	mov    %r14,%rsi
     87e:	49 01 df             	add    %rbx,%r15
     881:	e8 00 00 00 00       	call   886 <repeat_avx2+0xc6>
     886:	4d 39 ef             	cmp    %r13,%r15
     889:	72 e7                	jb     872 <repeat_avx2+0xb2>
     88b:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     88f:	5b                   	pop    %rbx
     890:	41 5c                	pop    %r12
     892:	41 5d                	pop    %r13
     894:	41 5e                	pop    %r14
     896:	41 5f                	pop    %r15
     898:	5d                   	pop    %rbp
     899:	e9 00 00 00 00       	jmp    89e <repeat_avx2+0xde>
     89e:	c4 e2 7d 5a 06       	vbroadcasti128 (%rsi),%ymm0
     8a3:	48 83 fa 1f          	cmp    $0x1f,%rdx
     8a7:	0f 87 5d ff ff ff    	ja     80a <repeat_avx2+0x4a>
     8ad:	45 31 ff             	xor    %r15d,%r15d
     8b0:	49 39 d7             	cmp    %rdx,%r15
     8b3:	72 aa                	jb     85f <repeat_avx2+0x9f>
     8b5:	c5 f8 77             	vzeroupper
     8b8:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     8bc:	5b                   	pop    %rbx
     8bd:	41 5c                	pop    %r12
     8bf:	41 5d                	pop    %r13
     8c1:	41 5e                	pop    %r14
     8c3:	41 5f                	pop    %r15
     8c5:	5d                   	pop    %rbp
     8c6:	e9 00 00 00 00       	jmp    8cb <repeat_avx2+0x10b>
     8cb:	c4 e2 7d 58 06       	vpbroadcastd (%rsi),%ymm0
     8d0:	e9 2b ff ff ff       	jmp    800 <repeat_avx2+0x40>
     8d5:	c4 e2 7d 59 06       	vpbroadcastq (%rsi),%ymm0
     8da:	e9 21 ff ff ff       	jmp    800 <repeat_avx2+0x40>
     8df:	90                   	nop
     8e0:	90                   	nop
     8e1:	90                   	nop
     8e2:	90                   	nop
     8e3:	90                   	nop
     8e4:	90                   	nop
     8e5:	90                   	nop
     8e6:	90                   	nop
     8e7:	90                   	nop
     8e8:	90                   	nop
     8e9:	90                   	nop
     8ea:	90                   	nop
     8eb:	90                   	nop
     8ec:	90                   	nop
     8ed:	90                   	nop
     8ee:	90                   	nop
     8ef:	90                   	nop

00000000000008f0 <unpack_scalar>:
     8f0:	f3 0f 1e fa          	endbr64
     8f4:	e8 00 00 00 00       	call   8f9 <unpack_scalar+0x9>
     8f9:	55                   	push   %rbp
     8fa:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     8fe:	c5 fe 7f 06          	vmovdqu %ymm0,(%rsi)
     902:	48 89 e5             	mov    %rsp,%rbp
     905:	85 d2                	test   %edx,%edx
     907:	74 36                	je     93f <unpack_scalar+0x4f>
     909:	90                   	nop
     90a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     911:	00 00 00 00 
     915:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     91c:	00 00 00 00 
     920:	31 c9                	xor    %ecx,%ecx
     922:	44 8b 07             	mov    (%rdi),%r8d
     925:	8d 42 ff             	lea    -0x1(%rdx),%eax
     928:	48 83 c7 04          	add    $0x4,%rdi
     92c:	f3 0f bc ca          	tzcnt  %edx,%ecx
     930:	8d 0c 8d 00 00 00 00 	lea    0x0(,%rcx,4),%ecx
     937:	44 89 04 0e          	mov    %r8d,(%rsi,%rcx,1)
     93b:	21 c2                	and    %eax,%edx
     93d:	75 e1                	jne    920 <unpack_scalar+0x30>
     93f:	c5 f8 77             	vzeroupper
     942:	5d                   	pop    %rbp
     943:	e9 00 00 00 00       	jmp    948 <unpack_scalar+0x58>
     948:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     94f:	00 
     950:	90                   	nop
     951:	90                   	nop
     952:	90                   	nop
     953:	90                   	nop
     954:	90                   	nop
     955:	90                   	nop
     956:	90                   	nop
     957:	90                   	nop
     958:	90                   	nop
     959:	90                   	nop
     95a:	90                   	nop
     95b:	90                   	nop
     95c:	90                   	nop
     95d:	90                   	nop
     95e:	90                   	nop
     95f:	90                   	nop

0000000000000960 <decode>:
     960:	e8 00 00 00 00       	call   965 <decode+0x5>
     965:	48 8d 46 f8          	lea    -0x8(%rsi),%rax
     969:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
     96f:	0f 87 c4 03 00 00    	ja     d39 <decode+0x3d9>
     975:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
     979:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
     97e:	49 89 fc             	mov    %rdi,%r12
     981:	48 85 ff             	test   %rdi,%rdi
     984:	0f 84 9e 02 00 00    	je     c28 <decode+0x2c8>
     98a:	81 3f 47 5a 52 31    	cmpl   $0x31525a47,(%rdi)
     990:	0f 85 92 02 00 00    	jne    c28 <decode+0x2c8>
     996:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
     99b:	48 89 d5             	mov    %rdx,%rbp
     99e:	48 89 ca             	mov    %rcx,%rdx
     9a1:	0f b6 4f 06          	movzbl 0x6(%rdi),%ecx
     9a5:	8d 41 fb             	lea    -0x5(%rcx),%eax
     9a8:	3c 07                	cmp    $0x7,%al
     9aa:	0f 87 77 03 00 00    	ja     d27 <decode+0x3c7>
     9b0:	4c 89 cf             	mov    %r9,%rdi
     9b3:	45 0f b6 4c 24 07    	movzbl 0x7(%r12),%r9d
     9b9:	41 80 f9 01          	cmp    $0x1,%r9b
     9bd:	0f 87 64 03 00 00    	ja     d27 <decode+0x3c7>
     9c3:	41 ba 00 10 00 00    	mov    $0x1000,%r10d
     9c9:	4c 89 7c 24 78       	mov    %r15,0x78(%rsp)
     9ce:	41 0f b7 44 24 04    	movzwl 0x4(%r12),%eax
     9d4:	4c 39 d2             	cmp    %r10,%rdx
     9d7:	49 0f 47 d2          	cmova  %r10,%rdx
     9db:	49 89 c7             	mov    %rax,%r15
     9de:	48 39 c2             	cmp    %rax,%rdx
     9e1:	0f 82 f3 02 00 00    	jb     cda <decode+0x37a>
     9e7:	48 85 ed             	test   %rbp,%rbp
     9ea:	75 09                	jne    9f5 <decode+0x95>
     9ec:	48 85 c0             	test   %rax,%rax
     9ef:	0f 85 e5 02 00 00    	jne    cda <decode+0x37a>
     9f5:	45 84 c9             	test   %r9b,%r9b
     9f8:	0f 85 df 01 00 00    	jne    bdd <decode+0x27d>
     9fe:	41 bb 01 00 00 00    	mov    $0x1,%r11d
     a04:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
     a09:	49 d3 e3             	shl    %cl,%r11
     a0c:	48 89 5c 24 50       	mov    %rbx,0x50(%rsp)
     a11:	4e 8d 6c 18 ff       	lea    -0x1(%rax,%r11,1),%r13
     a16:	49 d3 ed             	shr    %cl,%r13
     a19:	49 8d 5d 08          	lea    0x8(%r13),%rbx
     a1d:	48 39 de             	cmp    %rbx,%rsi
     a20:	0f 82 24 03 00 00    	jb     d4a <decode+0x3ea>
     a26:	4d 85 ed             	test   %r13,%r13
     a29:	0f 84 14 03 00 00    	je     d43 <decode+0x3e3>
     a2f:	48 01 e8             	add    %rbp,%rax
     a32:	4c 89 74 24 70       	mov    %r14,0x70(%rsp)
     a37:	4d 8d 74 24 08       	lea    0x8(%r12),%r14
     a3c:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     a41:	4b 8d 0c 2e          	lea    (%r14,%r13,1),%rcx
     a45:	48 89 d8             	mov    %rbx,%rax
     a48:	48 89 eb             	mov    %rbp,%rbx
     a4b:	66 44 89 7c 24 4e    	mov    %r15w,0x4e(%rsp)
     a51:	48 89 c5             	mov    %rax,%rbp
     a54:	4d 89 df             	mov    %r11,%r15
     a57:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
     a5c:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
     a61:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
     a66:	4c 89 24 24          	mov    %r12,(%rsp)
     a6a:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
     a6f:	eb 49                	jmp    aba <decode+0x15a>
     a71:	3c 01                	cmp    $0x1,%al
     a73:	0f 84 3a 02 00 00    	je     cb3 <decode+0x353>
     a79:	3c 02                	cmp    $0x2,%al
     a7b:	0f 84 25 02 00 00    	je     ca6 <decode+0x346>
     a81:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
     a86:	48 29 e8             	sub    %rbp,%rax
     a89:	4c 39 e8             	cmp    %r13,%rax
     a8c:	0f 82 7d 01 00 00    	jb     c0f <decode+0x2af>
     a92:	48 8b 04 24          	mov    (%rsp),%rax
     a96:	48 89 df             	mov    %rbx,%rdi
     a99:	4c 89 ea             	mov    %r13,%rdx
     a9c:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
     aa0:	4c 01 ed             	add    %r13,%rbp
     aa3:	e8 00 00 00 00       	call   aa8 <decode+0x148>
     aa8:	49 83 c6 01          	add    $0x1,%r14
     aac:	4c 01 fb             	add    %r15,%rbx
     aaf:	4c 3b 74 24 18       	cmp    0x18(%rsp),%r14
     ab4:	0f 84 2f 02 00 00    	je     ce9 <decode+0x389>
     aba:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
     abf:	41 0f b6 06          	movzbl (%r14),%eax
     ac3:	49 29 dd             	sub    %rbx,%r13
     ac6:	4d 39 fd             	cmp    %r15,%r13
     ac9:	4d 0f 47 ef          	cmova  %r15,%r13
     acd:	3c 03                	cmp    $0x3,%al
     acf:	0f 84 66 01 00 00    	je     c3b <decode+0x2db>
     ad5:	76 9a                	jbe    a71 <decode+0x111>
     ad7:	3c 05                	cmp    $0x5,%al
     ad9:	0f 84 ba 01 00 00    	je     c99 <decode+0x339>
     adf:	3c 06                	cmp    $0x6,%al
     ae1:	0f 84 a5 01 00 00    	je     c8c <decode+0x32c>
     ae7:	3c 04                	cmp    $0x4,%al
     ae9:	0f 85 20 01 00 00    	jne    c0f <decode+0x2af>
     aef:	4c 89 e9             	mov    %r13,%rcx
     af2:	83 e1 1f             	and    $0x1f,%ecx
     af5:	0f 85 14 01 00 00    	jne    c0f <decode+0x2af>
     afb:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
     b00:	49 c1 ed 05          	shr    $0x5,%r13
     b04:	48 29 e8             	sub    %rbp,%rax
     b07:	4c 39 e8             	cmp    %r13,%rax
     b0a:	0f 82 ff 00 00 00    	jb     c0f <decode+0x2af>
     b10:	4a 8d 74 2d 00       	lea    0x0(%rbp,%r13,1),%rsi
     b15:	4d 85 ed             	test   %r13,%r13
     b18:	0f 84 13 02 00 00    	je     d31 <decode+0x3d1>
     b1e:	48 8b 04 24          	mov    (%rsp),%rax
     b22:	48 01 e8             	add    %rbp,%rax
     b25:	4a 8d 14 28          	lea    (%rax,%r13,1),%rdx
     b29:	49 89 c0             	mov    %rax,%r8
     b2c:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     b33:	00 00 
     b35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     b3c:	00 00 00 00 
     b40:	41 0f b6 38          	movzbl (%r8),%edi
     b44:	49 83 c0 01          	add    $0x1,%r8
     b48:	0f b6 bf 00 00 00 00 	movzbl 0x0(%rdi),%edi
     b4f:	8d 3c bd 00 00 00 00 	lea    0x0(,%rdi,4),%edi
     b56:	48 01 f9             	add    %rdi,%rcx
     b59:	49 39 d0             	cmp    %rdx,%r8
     b5c:	75 e2                	jne    b40 <decode+0x1e0>
     b5e:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
     b63:	49 29 f0             	sub    %rsi,%r8
     b66:	49 39 c8             	cmp    %rcx,%r8
     b69:	0f 82 a0 00 00 00    	jb     c0f <decode+0x2af>
     b6f:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
     b74:	4c 8b 64 24 30       	mov    0x30(%rsp),%r12
     b79:	48 89 c5             	mov    %rax,%rbp
     b7c:	49 89 d5             	mov    %rdx,%r13
     b7f:	4c 89 74 24 38       	mov    %r14,0x38(%rsp)
     b84:	49 89 f6             	mov    %rsi,%r14
     b87:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
     b8c:	49 89 df             	mov    %rbx,%r15
     b8f:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
     b93:	48 8b 04 24          	mov    (%rsp),%rax
     b97:	4c 89 fe             	mov    %r15,%rsi
     b9a:	48 83 c5 01          	add    $0x1,%rbp
     b9e:	49 83 c7 20          	add    $0x20,%r15
     ba2:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
     ba6:	89 da                	mov    %ebx,%edx
     ba8:	2e e8 00 00 00 00    	cs call bae <decode+0x24e>
     bae:	89 da                	mov    %ebx,%edx
     bb0:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
     bb7:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
     bbe:	49 01 d6             	add    %rdx,%r14
     bc1:	4c 39 ed             	cmp    %r13,%rbp
     bc4:	75 c9                	jne    b8f <decode+0x22f>
     bc6:	4c 89 f5             	mov    %r14,%rbp
     bc9:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
     bce:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
     bd3:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
     bd8:	e9 cb fe ff ff       	jmp    aa8 <decode+0x148>
     bdd:	48 8d 50 08          	lea    0x8(%rax),%rdx
     be1:	48 39 f2             	cmp    %rsi,%rdx
     be4:	0f 85 f0 00 00 00    	jne    cda <decode+0x37a>
     bea:	48 85 c0             	test   %rax,%rax
     bed:	0f 85 d2 00 00 00    	jne    cc5 <decode+0x365>
     bf3:	41 0f b7 c7          	movzwl %r15w,%eax
     bf7:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     bfc:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     c01:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
     c06:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
     c0a:	e9 00 00 00 00       	jmp    c0f <decode+0x2af>
     c0f:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
     c14:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     c19:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
     c1e:	4c 8b 74 24 70       	mov    0x70(%rsp),%r14
     c23:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     c28:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
     c2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c32:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
     c36:	e9 00 00 00 00       	jmp    c3b <decode+0x2db>
     c3b:	41 ba 08 00 00 00    	mov    $0x8,%r10d
     c41:	b9 08 00 00 00       	mov    $0x8,%ecx
     c46:	4c 89 e8             	mov    %r13,%rax
     c49:	31 d2                	xor    %edx,%edx
     c4b:	49 f7 f2             	div    %r10
     c4e:	48 85 d2             	test   %rdx,%rdx
     c51:	75 bc                	jne    c0f <decode+0x2af>
     c53:	4d 39 d5             	cmp    %r10,%r13
     c56:	72 b7                	jb     c0f <decode+0x2af>
     c58:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
     c5d:	48 29 e8             	sub    %rbp,%rax
     c60:	4c 39 d0             	cmp    %r10,%rax
     c63:	72 aa                	jb     c0f <decode+0x2af>
     c65:	48 8b 04 24          	mov    (%rsp),%rax
     c69:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
     c6e:	4c 89 ea             	mov    %r13,%rdx
     c71:	48 89 df             	mov    %rbx,%rdi
     c74:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
     c78:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
     c7d:	e8 00 00 00 00       	call   c82 <decode+0x322>
     c82:	48 03 6c 24 20       	add    0x20(%rsp),%rbp
     c87:	e9 1c fe ff ff       	jmp    aa8 <decode+0x148>
     c8c:	41 ba 20 00 00 00    	mov    $0x20,%r10d
     c92:	b9 20 00 00 00       	mov    $0x20,%ecx
     c97:	eb ad                	jmp    c46 <decode+0x2e6>
     c99:	41 ba 10 00 00 00    	mov    $0x10,%r10d
     c9f:	b9 10 00 00 00       	mov    $0x10,%ecx
     ca4:	eb a0                	jmp    c46 <decode+0x2e6>
     ca6:	41 ba 04 00 00 00    	mov    $0x4,%r10d
     cac:	b9 04 00 00 00       	mov    $0x4,%ecx
     cb1:	eb 93                	jmp    c46 <decode+0x2e6>
     cb3:	4c 89 ea             	mov    %r13,%rdx
     cb6:	31 f6                	xor    %esi,%esi
     cb8:	48 89 df             	mov    %rbx,%rdi
     cbb:	e8 00 00 00 00       	call   cc0 <decode+0x360>
     cc0:	e9 e3 fd ff ff       	jmp    aa8 <decode+0x148>
     cc5:	49 8d 74 24 08       	lea    0x8(%r12),%rsi
     cca:	48 89 ef             	mov    %rbp,%rdi
     ccd:	48 89 c2             	mov    %rax,%rdx
     cd0:	e8 00 00 00 00       	call   cd5 <decode+0x375>
     cd5:	e9 19 ff ff ff       	jmp    bf3 <decode+0x293>
     cda:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     cdf:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     ce4:	e9 3f ff ff ff       	jmp    c28 <decode+0x2c8>
     ce9:	44 0f b7 7c 24 4e    	movzwl 0x4e(%rsp),%r15d
     cef:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     cf4:	48 89 eb             	mov    %rbp,%rbx
     cf7:	4c 8b 74 24 70       	mov    0x70(%rsp),%r14
     cfc:	48 39 de             	cmp    %rbx,%rsi
     cff:	75 49                	jne    d4a <decode+0x3ea>
     d01:	41 0f b7 c7          	movzwl %r15w,%eax
     d05:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
     d0a:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     d0f:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
     d14:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     d19:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
     d1e:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
     d22:	e9 00 00 00 00       	jmp    d27 <decode+0x3c7>
     d27:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     d2c:	e9 f7 fe ff ff       	jmp    c28 <decode+0x2c8>
     d31:	48 89 f5             	mov    %rsi,%rbp
     d34:	e9 6f fd ff ff       	jmp    aa8 <decode+0x148>
     d39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d3e:	e9 00 00 00 00       	jmp    d43 <decode+0x3e3>
     d43:	bb 08 00 00 00       	mov    $0x8,%ebx
     d48:	eb b2                	jmp    cfc <decode+0x39c>
     d4a:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
     d4f:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     d54:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
     d59:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     d5e:	e9 c5 fe ff ff       	jmp    c28 <decode+0x2c8>
     d63:	66 90                	xchg   %ax,%ax
     d65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     d6c:	00 00 00 00 
     d70:	90                   	nop
     d71:	90                   	nop
     d72:	90                   	nop
     d73:	90                   	nop
     d74:	90                   	nop
     d75:	90                   	nop
     d76:	90                   	nop
     d77:	90                   	nop
     d78:	90                   	nop
     d79:	90                   	nop
     d7a:	90                   	nop
     d7b:	90                   	nop
     d7c:	90                   	nop
     d7d:	90                   	nop
     d7e:	90                   	nop
     d7f:	90                   	nop

0000000000000d80 <unpack_avx2>:
     d80:	f3 0f 1e fa          	endbr64
     d84:	e8 00 00 00 00       	call   d89 <unpack_avx2+0x9>
     d89:	55                   	push   %rbp
     d8a:	48 89 f9             	mov    %rdi,%rcx
     d8d:	48 89 e5             	mov    %rsp,%rbp
     d90:	41 55                	push   %r13
     d92:	49 89 f5             	mov    %rsi,%r13
     d95:	41 54                	push   %r12
     d97:	41 89 d4             	mov    %edx,%r12d
     d9a:	53                   	push   %rbx
     d9b:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
     d9f:	48 83 ec 60          	sub    $0x60,%rsp
     da3:	65 48 8b 1d 00 00 00 	mov    %gs:0x0(%rip),%rbx        # dab <unpack_avx2+0x2b>
     daa:	00 
     dab:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
     db0:	4c 89 e3             	mov    %r12,%rbx
     db3:	41 81 fc ff 00 00 00 	cmp    $0xff,%r12d
     dba:	0f 87 99 00 00 00    	ja     e59 <unpack_avx2+0xd9>
     dc0:	41 0f b6 84 24 00 00 	movzbl 0x0(%r12),%eax
     dc7:	00 00 
     dc9:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
     dd0:	83 fa 20             	cmp    $0x20,%edx
     dd3:	0f 87 00 00 00 00    	ja     dd9 <unpack_avx2+0x59>
     dd9:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     ddd:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
     de2:	48 89 ce             	mov    %rcx,%rsi
     de5:	c5 fe 7f 44 24 30    	vmovdqu %ymm0,0x30(%rsp)
     deb:	c5 f8 77             	vzeroupper
     dee:	e8 00 00 00 00       	call   df3 <unpack_avx2+0x73>
     df3:	49 81 fc 01 01 00 00 	cmp    $0x101,%r12
     dfa:	c5 fe 6f 54 24 30    	vmovdqu 0x30(%rsp),%ymm2
     e00:	c5 f1 ef c9          	vpxor  %xmm1,%xmm1,%xmm1
     e04:	73 6f                	jae    e75 <unpack_avx2+0xf5>
     e06:	49 c1 e4 05          	shl    $0x5,%r12
     e0a:	c4 c1 7d 6f 84 24 00 	vmovdqa 0x0(%r12),%ymm0
     e11:	00 00 00 
     e14:	c4 e2 7d 36 d2       	vpermd %ymm2,%ymm0,%ymm2
     e19:	c5 f9 6e c3          	vmovd  %ebx,%xmm0
     e1d:	c4 e2 7d 58 c0       	vpbroadcastd %xmm0,%ymm0
     e22:	c5 fd db 05 00 00 00 	vpand  0x0(%rip),%ymm0,%ymm0        # e2a <unpack_avx2+0xaa>
     e29:	00 
     e2a:	c5 fd 76 c1          	vpcmpeqd %ymm1,%ymm0,%ymm0
     e2e:	c5 fd df c2          	vpandn %ymm2,%ymm0,%ymm0
     e32:	c4 c1 7e 7f 45 00    	vmovdqu %ymm0,0x0(%r13)
     e38:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
     e3d:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # e45 <unpack_avx2+0xc5>
     e44:	00 
     e45:	75 53                	jne    e9a <unpack_avx2+0x11a>
     e47:	c5 f8 77             	vzeroupper
     e4a:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
     e4e:	5b                   	pop    %rbx
     e4f:	41 5c                	pop    %r12
     e51:	41 5d                	pop    %r13
     e53:	5d                   	pop    %rbp
     e54:	e9 00 00 00 00       	jmp    e59 <unpack_avx2+0xd9>
     e59:	48 89 3c 24          	mov    %rdi,(%rsp)
     e5d:	4c 89 e6             	mov    %r12,%rsi
     e60:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     e67:	e8 00 00 00 00       	call   e6c <unpack_avx2+0xec>
     e6c:	48 8b 0c 24          	mov    (%rsp),%rcx
     e70:	e9 4b ff ff ff       	jmp    dc0 <unpack_avx2+0x40>
     e75:	c5 fd 7f 14 24       	vmovdqa %ymm2,(%rsp)
     e7a:	4c 89 e6             	mov    %r12,%rsi
     e7d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     e84:	c5 f8 77             	vzeroupper
     e87:	e8 00 00 00 00       	call   e8c <unpack_avx2+0x10c>
     e8c:	c5 f1 ef c9          	vpxor  %xmm1,%xmm1,%xmm1
     e90:	c5 fd 6f 14 24       	vmovdqa (%rsp),%ymm2
     e95:	e9 6c ff ff ff       	jmp    e06 <unpack_avx2+0x86>
     e9a:	c5 f8 77             	vzeroupper
     e9d:	e8 00 00 00 00       	call   ea2 <unpack_avx2+0x122>
     ea2:	0f 1f 00             	nopl   (%rax)
     ea5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     eac:	00 00 00 00 
     eb0:	90                   	nop
     eb1:	90                   	nop
     eb2:	90                   	nop
     eb3:	90                   	nop
     eb4:	90                   	nop
     eb5:	90                   	nop
     eb6:	90                   	nop
     eb7:	90                   	nop
     eb8:	90                   	nop
     eb9:	90                   	nop
     eba:	90                   	nop
     ebb:	90                   	nop
     ebc:	90                   	nop
     ebd:	90                   	nop
     ebe:	90                   	nop
     ebf:	90                   	nop

0000000000000ec0 <scan_scalar>:
     ec0:	f3 0f 1e fa          	endbr64
     ec4:	e8 00 00 00 00       	call   ec9 <scan_scalar+0x9>
     ec9:	55                   	push   %rbp
     eca:	48 89 e5             	mov    %rsp,%rbp
     ecd:	41 55                	push   %r13
     ecf:	41 54                	push   %r12
     ed1:	53                   	push   %rbx
     ed2:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
     ed6:	48 83 ec 40          	sub    $0x40,%rsp
     eda:	4c 8b 17             	mov    (%rdi),%r10
     edd:	4c 8b 5f 08          	mov    0x8(%rdi),%r11
     ee1:	65 4c 8b 05 00 00 00 	mov    %gs:0x0(%rip),%r8        # ee9 <scan_scalar+0x29>
     ee8:	00 
     ee9:	4c 89 44 24 38       	mov    %r8,0x38(%rsp)
     eee:	49 89 d0             	mov    %rdx,%r8
     ef1:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
     ef5:	4c 8b 67 18          	mov    0x18(%rdi),%r12
     ef9:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
     efe:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
     f03:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
     f08:	4c 89 64 24 28       	mov    %r12,0x28(%rsp)
     f0d:	4d 39 d3             	cmp    %r10,%r11
     f10:	0f 84 e0 01 00 00    	je     10f6 <scan_scalar+0x236>
     f16:	4c 39 d3             	cmp    %r10,%rbx
     f19:	0f 84 e2 00 00 00    	je     1001 <scan_scalar+0x141>
     f1f:	41 b9 1f 00 00 00    	mov    $0x1f,%r9d
     f25:	b8 20 00 00 00       	mov    $0x20,%eax
     f2a:	41 bd 20 00 00 00    	mov    $0x20,%r13d
     f30:	48 39 f0             	cmp    %rsi,%rax
     f33:	0f 83 33 02 00 00    	jae    116c <scan_scalar+0x2ac>
     f39:	48 83 fe 20          	cmp    $0x20,%rsi
     f3d:	0f 86 20 02 00 00    	jbe    1163 <scan_scalar+0x2a3>
     f43:	b8 20 00 00 00       	mov    $0x20,%eax
     f48:	eb 3f                	jmp    f89 <scan_scalar+0xc9>
     f4a:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
     f51:	00 00 00 
     f54:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     f5b:	00 00 00 00 
     f5f:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     f66:	00 00 00 00 
     f6a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     f71:	00 00 00 00 
     f75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     f7c:	00 00 00 00 
     f80:	48 39 ca             	cmp    %rcx,%rdx
     f83:	0f 85 97 00 00 00    	jne    1020 <scan_scalar+0x160>
     f89:	48 89 c2             	mov    %rax,%rdx
     f8c:	48 8b 0c 07          	mov    (%rdi,%rax,1),%rcx
     f90:	48 83 c0 08          	add    $0x8,%rax
     f94:	4c 21 ca             	and    %r9,%rdx
     f97:	48 c1 ea 03          	shr    $0x3,%rdx
     f9b:	48 8b 54 d4 10       	mov    0x10(%rsp,%rdx,8),%rdx
     fa0:	48 39 f0             	cmp    %rsi,%rax
     fa3:	72 db                	jb     f80 <scan_scalar+0xc0>
     fa5:	48 39 ca             	cmp    %rcx,%rdx
     fa8:	75 76                	jne    1020 <scan_scalar+0x160>
     faa:	4d 85 d2             	test   %r10,%r10
     fad:	0f 84 6b 01 00 00    	je     111e <scan_scalar+0x25e>
     fb3:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
     fba:	01 00 00 00 
     fbe:	41 83 fd 08          	cmp    $0x8,%r13d
     fc2:	0f 84 c1 01 00 00    	je     1189 <scan_scalar+0x2c9>
     fc8:	31 c0                	xor    %eax,%eax
     fca:	41 83 fd 10          	cmp    $0x10,%r13d
     fce:	0f 95 c0             	setne  %al
     fd1:	8d 04 85 04 00 00 00 	lea    0x4(,%rax,4),%eax
     fd8:	41 89 80 84 00 00 00 	mov    %eax,0x84(%r8)
     fdf:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
     fe4:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # fec <scan_scalar+0x12c>
     feb:	00 
     fec:	0f 85 d3 01 00 00    	jne    11c5 <scan_scalar+0x305>
     ff2:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
     ff6:	5b                   	pop    %rbx
     ff7:	41 5c                	pop    %r12
     ff9:	41 5d                	pop    %r13
     ffb:	5d                   	pop    %rbp
     ffc:	e9 00 00 00 00       	jmp    1001 <scan_scalar+0x141>
    1001:	4d 39 dc             	cmp    %r11,%r12
    1004:	0f 85 15 ff ff ff    	jne    f1f <scan_scalar+0x5f>
    100a:	41 b9 0f 00 00 00    	mov    $0xf,%r9d
    1010:	b8 10 00 00 00       	mov    $0x10,%eax
    1015:	41 bd 10 00 00 00    	mov    $0x10,%r13d
    101b:	e9 10 ff ff ff       	jmp    f30 <scan_scalar+0x70>
    1020:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
    1027:	00 00 00 00 
    102b:	48 89 f3             	mov    %rsi,%rbx
    102e:	48 c1 eb 05          	shr    $0x5,%rbx
    1032:	49 89 fd             	mov    %rdi,%r13
    1035:	45 31 e4             	xor    %r12d,%r12d
    1038:	41 8b 45 04          	mov    0x4(%r13),%eax
    103c:	31 d2                	xor    %edx,%edx
    103e:	41 8b 4d 08          	mov    0x8(%r13),%ecx
    1042:	41 8b 7d 00          	mov    0x0(%r13),%edi
    1046:	45 8b 4d 0c          	mov    0xc(%r13),%r9d
    104a:	85 c0                	test   %eax,%eax
    104c:	45 8b 55 10          	mov    0x10(%r13),%r10d
    1050:	45 8b 5d 14          	mov    0x14(%r13),%r11d
    1054:	0f 95 c2             	setne  %dl
    1057:	31 f6                	xor    %esi,%esi
    1059:	41 8b 45 18          	mov    0x18(%r13),%eax
    105d:	01 d2                	add    %edx,%edx
    105f:	85 c9                	test   %ecx,%ecx
    1061:	40 0f 95 c6          	setne  %sil
    1065:	c1 e6 02             	shl    $0x2,%esi
    1068:	09 f2                	or     %esi,%edx
    106a:	31 f6                	xor    %esi,%esi
    106c:	85 ff                	test   %edi,%edi
    106e:	40 0f 95 c6          	setne  %sil
    1072:	09 f2                	or     %esi,%edx
    1074:	31 f6                	xor    %esi,%esi
    1076:	45 85 c9             	test   %r9d,%r9d
    1079:	40 0f 95 c6          	setne  %sil
    107d:	c1 e6 03             	shl    $0x3,%esi
    1080:	09 f2                	or     %esi,%edx
    1082:	31 f6                	xor    %esi,%esi
    1084:	45 85 d2             	test   %r10d,%r10d
    1087:	40 0f 95 c6          	setne  %sil
    108b:	c1 e6 04             	shl    $0x4,%esi
    108e:	09 d6                	or     %edx,%esi
    1090:	31 d2                	xor    %edx,%edx
    1092:	45 85 db             	test   %r11d,%r11d
    1095:	0f 95 c2             	setne  %dl
    1098:	c1 e2 05             	shl    $0x5,%edx
    109b:	09 f2                	or     %esi,%edx
    109d:	31 f6                	xor    %esi,%esi
    109f:	85 c0                	test   %eax,%eax
    10a1:	41 8b 45 1c          	mov    0x1c(%r13),%eax
    10a5:	40 0f 95 c6          	setne  %sil
    10a9:	c1 e6 06             	shl    $0x6,%esi
    10ac:	09 d6                	or     %edx,%esi
    10ae:	31 d2                	xor    %edx,%edx
    10b0:	85 c0                	test   %eax,%eax
    10b2:	0f 95 c2             	setne  %dl
    10b5:	c1 e2 07             	shl    $0x7,%edx
    10b8:	09 f2                	or     %esi,%edx
    10ba:	49 81 fc 80 00 00 00 	cmp    $0x80,%r12
    10c1:	0f 83 da 00 00 00    	jae    11a1 <scan_scalar+0x2e1>
    10c7:	43 88 14 20          	mov    %dl,(%r8,%r12,1)
    10cb:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
    10d2:	49 83 c4 01          	add    $0x1,%r12
    10d6:	49 83 c5 20          	add    $0x20,%r13
    10da:	41 03 90 80 00 00 00 	add    0x80(%r8),%edx
    10e1:	41 89 90 80 00 00 00 	mov    %edx,0x80(%r8)
    10e8:	49 39 dc             	cmp    %rbx,%r12
    10eb:	0f 85 47 ff ff ff    	jne    1038 <scan_scalar+0x178>
    10f1:	e9 e9 fe ff ff       	jmp    fdf <scan_scalar+0x11f>
    10f6:	4c 39 db             	cmp    %r11,%rbx
    10f9:	0f 85 20 fe ff ff    	jne    f1f <scan_scalar+0x5f>
    10ff:	49 39 dc             	cmp    %rbx,%r12
    1102:	0f 85 17 fe ff ff    	jne    f1f <scan_scalar+0x5f>
    1108:	41 b9 07 00 00 00    	mov    $0x7,%r9d
    110e:	b8 08 00 00 00       	mov    $0x8,%eax
    1113:	41 bd 08 00 00 00    	mov    $0x8,%r13d
    1119:	e9 12 fe ff ff       	jmp    f30 <scan_scalar+0x70>
    111e:	4d 85 db             	test   %r11,%r11
    1121:	75 29                	jne    114c <scan_scalar+0x28c>
    1123:	48 85 db             	test   %rbx,%rbx
    1126:	75 24                	jne    114c <scan_scalar+0x28c>
    1128:	4d 85 e4             	test   %r12,%r12
    112b:	75 1f                	jne    114c <scan_scalar+0x28c>
    112d:	41 c7 80 80 00 00 00 	movl   $0x0,0x80(%r8)
    1134:	00 00 00 00 
    1138:	41 83 fd 08          	cmp    $0x8,%r13d
    113c:	0f 85 86 fe ff ff    	jne    fc8 <scan_scalar+0x108>
    1142:	b8 01 00 00 00       	mov    $0x1,%eax
    1147:	e9 8c fe ff ff       	jmp    fd8 <scan_scalar+0x118>
    114c:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
    1153:	01 00 00 00 
    1157:	41 83 fd 08          	cmp    $0x8,%r13d
    115b:	0f 85 67 fe ff ff    	jne    fc8 <scan_scalar+0x108>
    1161:	eb df                	jmp    1142 <scan_scalar+0x282>
    1163:	48 39 f0             	cmp    %rsi,%rax
    1166:	0f 82 3e fe ff ff    	jb     faa <scan_scalar+0xea>
    116c:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
    1173:	00 00 00 00 
    1177:	48 89 f3             	mov    %rsi,%rbx
    117a:	48 c1 eb 05          	shr    $0x5,%rbx
    117e:	0f 84 5b fe ff ff    	je     fdf <scan_scalar+0x11f>
    1184:	e9 a9 fe ff ff       	jmp    1032 <scan_scalar+0x172>
    1189:	4c 89 d0             	mov    %r10,%rax
    118c:	48 c1 e8 20          	shr    $0x20,%rax
    1190:	41 39 c2             	cmp    %eax,%r10d
    1193:	0f 95 c0             	setne  %al
    1196:	0f b6 c0             	movzbl %al,%eax
    1199:	83 c0 01             	add    $0x1,%eax
    119c:	e9 37 fe ff ff       	jmp    fd8 <scan_scalar+0x118>
    11a1:	4c 89 e6             	mov    %r12,%rsi
    11a4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    11ab:	4c 89 04 24          	mov    %r8,(%rsp)
    11af:	89 54 24 0c          	mov    %edx,0xc(%rsp)
    11b3:	e8 00 00 00 00       	call   11b8 <scan_scalar+0x2f8>
    11b8:	4c 8b 04 24          	mov    (%rsp),%r8
    11bc:	8b 54 24 0c          	mov    0xc(%rsp),%edx
    11c0:	e9 02 ff ff ff       	jmp    10c7 <scan_scalar+0x207>
    11c5:	e8 00 00 00 00       	call   11ca <scan_scalar+0x30a>
    11ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    11d0:	90                   	nop
    11d1:	90                   	nop
    11d2:	90                   	nop
    11d3:	90                   	nop
    11d4:	90                   	nop
    11d5:	90                   	nop
    11d6:	90                   	nop
    11d7:	90                   	nop
    11d8:	90                   	nop
    11d9:	90                   	nop
    11da:	90                   	nop
    11db:	90                   	nop
    11dc:	90                   	nop
    11dd:	90                   	nop
    11de:	90                   	nop
    11df:	90                   	nop

00000000000011e0 <scan_avx2>:
    11e0:	f3 0f 1e fa          	endbr64
    11e4:	e8 00 00 00 00       	call   11e9 <scan_avx2+0x9>
    11e9:	55                   	push   %rbp
    11ea:	c5 c9 ef f6          	vpxor  %xmm6,%xmm6,%xmm6
    11ee:	48 89 d1             	mov    %rdx,%rcx
    11f1:	48 89 e5             	mov    %rsp,%rbp
    11f4:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    11f8:	48 81 ec c0 01 00 00 	sub    $0x1c0,%rsp
    11ff:	48 c1 ee 05          	shr    $0x5,%rsi
    1203:	8b 07                	mov    (%rdi),%eax
    1205:	c5 7a 7e 0f          	vmovq  (%rdi),%xmm9
    1209:	c5 fa 6f 3f          	vmovdqu (%rdi),%xmm7
    120d:	c5 7e 6f 17          	vmovdqu (%rdi),%ymm10
    1211:	c7 82 80 00 00 00 00 	movl   $0x0,0x80(%rdx)
    1218:	00 00 00 
    121b:	0f 84 eb 00 00 00    	je     130c <scan_avx2+0x12c>
    1221:	c5 79 6e c0          	vmovd  %eax,%xmm8
    1225:	49 89 f9             	mov    %rdi,%r9
    1228:	49 89 f2             	mov    %rsi,%r10
    122b:	31 c0                	xor    %eax,%eax
    122d:	c4 e3 45 38 ff 01    	vinserti128 $0x1,%xmm7,%ymm7,%ymm7
    1233:	c4 42 7d 59 c9       	vpbroadcastq %xmm9,%ymm9
    1238:	c4 42 7d 58 c0       	vpbroadcastd %xmm8,%ymm8
    123d:	c5 fd 6f ce          	vmovdqa %ymm6,%ymm1
    1241:	c5 fd 6f d6          	vmovdqa %ymm6,%ymm2
    1245:	c5 fd 6f de          	vmovdqa %ymm6,%ymm3
    1249:	c5 fd 6f e6          	vmovdqa %ymm6,%ymm4
    124d:	48 89 c2             	mov    %rax,%rdx
    1250:	48 c1 e2 05          	shl    $0x5,%rdx
    1254:	c4 c1 7e 6f 04 11    	vmovdqu (%r9,%rdx,1),%ymm0
    125a:	c5 fd 76 ee          	vpcmpeqd %ymm6,%ymm0,%ymm5
    125e:	c5 fc 50 d5          	vmovmskps %ymm5,%edx
    1262:	80 f2 ff             	xor    $0xff,%dl
    1265:	48 3d 80 00 00 00    	cmp    $0x80,%rax
    126b:	0f 83 ad 00 00 00    	jae    131e <scan_avx2+0x13e>
    1271:	88 14 01             	mov    %dl,(%rcx,%rax,1)
    1274:	89 d6                	mov    %edx,%esi
    1276:	44 8b 81 80 00 00 00 	mov    0x80(%rcx),%r8d
    127d:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    1283:	0f 87 94 01 00 00    	ja     141d <scan_avx2+0x23d>
    1289:	c4 c1 7d ef e8       	vpxor  %ymm8,%ymm0,%ymm5
    128e:	0f b6 96 00 00 00 00 	movzbl 0x0(%rsi),%edx
    1295:	48 83 c0 01          	add    $0x1,%rax
    1299:	c5 d5 eb e4          	vpor   %ymm4,%ymm5,%ymm4
    129d:	c4 c1 7d ef e9       	vpxor  %ymm9,%ymm0,%ymm5
    12a2:	44 01 c2             	add    %r8d,%edx
    12a5:	c5 d5 eb db          	vpor   %ymm3,%ymm5,%ymm3
    12a9:	c5 fd ef ef          	vpxor  %ymm7,%ymm0,%ymm5
    12ad:	c4 c1 7d ef c2       	vpxor  %ymm10,%ymm0,%ymm0
    12b2:	89 91 80 00 00 00    	mov    %edx,0x80(%rcx)
    12b8:	c5 d5 eb d2          	vpor   %ymm2,%ymm5,%ymm2
    12bc:	c5 fd eb c9          	vpor   %ymm1,%ymm0,%ymm1
    12c0:	4c 39 d0             	cmp    %r10,%rax
    12c3:	75 88                	jne    124d <scan_avx2+0x6d>
    12c5:	31 ff                	xor    %edi,%edi
    12c7:	c4 e2 7d 17 e4       	vptest %ymm4,%ymm4
    12cc:	40 0f 94 c7          	sete   %dil
    12d0:	31 c0                	xor    %eax,%eax
    12d2:	c4 e2 7d 17 db       	vptest %ymm3,%ymm3
    12d7:	0f 94 c0             	sete   %al
    12da:	31 f6                	xor    %esi,%esi
    12dc:	c4 e2 7d 17 d2       	vptest %ymm2,%ymm2
    12e1:	40 0f 94 c6          	sete   %sil
    12e5:	31 d2                	xor    %edx,%edx
    12e7:	c4 e2 7d 17 c9       	vptest %ymm1,%ymm1
    12ec:	0f 94 c2             	sete   %dl
    12ef:	01 c0                	add    %eax,%eax
    12f1:	c1 e6 02             	shl    $0x2,%esi
    12f4:	09 f0                	or     %esi,%eax
    12f6:	c1 e2 03             	shl    $0x3,%edx
    12f9:	09 f8                	or     %edi,%eax
    12fb:	09 d0                	or     %edx,%eax
    12fd:	89 81 84 00 00 00    	mov    %eax,0x84(%rcx)
    1303:	c5 f8 77             	vzeroupper
    1306:	c9                   	leave
    1307:	e9 00 00 00 00       	jmp    130c <scan_avx2+0x12c>
    130c:	c5 fd 6f ce          	vmovdqa %ymm6,%ymm1
    1310:	c5 fd 6f d6          	vmovdqa %ymm6,%ymm2
    1314:	c5 fd 6f de          	vmovdqa %ymm6,%ymm3
    1318:	c5 fd 6f e6          	vmovdqa %ymm6,%ymm4
    131c:	eb a7                	jmp    12c5 <scan_avx2+0xe5>
    131e:	4c 89 0c 24          	mov    %r9,(%rsp)
    1322:	48 89 c6             	mov    %rax,%rsi
    1325:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    132c:	48 89 8c 24 b0 01 00 	mov    %rcx,0x1b0(%rsp)
    1333:	00 
    1334:	4c 89 94 24 c0 00 00 	mov    %r10,0xc0(%rsp)
    133b:	00 
    133c:	89 94 24 e0 00 00 00 	mov    %edx,0xe0(%rsp)
    1343:	48 89 84 24 b8 01 00 	mov    %rax,0x1b8(%rsp)
    134a:	00 
    134b:	c5 fd 7f 74 24 20    	vmovdqa %ymm6,0x20(%rsp)
    1351:	c5 fd 7f 7c 24 40    	vmovdqa %ymm7,0x40(%rsp)
    1357:	c5 7d 7f 54 24 60    	vmovdqa %ymm10,0x60(%rsp)
    135d:	c5 7d 7f 84 24 80 00 	vmovdqa %ymm8,0x80(%rsp)
    1364:	00 00 
    1366:	c5 7d 7f 8c 24 a0 00 	vmovdqa %ymm9,0xa0(%rsp)
    136d:	00 00 
    136f:	c5 fd 7f 84 24 00 01 	vmovdqa %ymm0,0x100(%rsp)
    1376:	00 00 
    1378:	c5 fd 7f a4 24 20 01 	vmovdqa %ymm4,0x120(%rsp)
    137f:	00 00 
    1381:	c5 fd 7f 9c 24 40 01 	vmovdqa %ymm3,0x140(%rsp)
    1388:	00 00 
    138a:	c5 fd 7f 8c 24 60 01 	vmovdqa %ymm1,0x160(%rsp)
    1391:	00 00 
    1393:	c5 fd 7f 94 24 80 01 	vmovdqa %ymm2,0x180(%rsp)
    139a:	00 00 
    139c:	c5 f8 77             	vzeroupper
    139f:	e8 00 00 00 00       	call   13a4 <scan_avx2+0x1c4>
    13a4:	48 8b 8c 24 b0 01 00 	mov    0x1b0(%rsp),%rcx
    13ab:	00 
    13ac:	4c 8b 0c 24          	mov    (%rsp),%r9
    13b0:	c5 fd 6f 74 24 20    	vmovdqa 0x20(%rsp),%ymm6
    13b6:	c5 fd 6f 7c 24 40    	vmovdqa 0x40(%rsp),%ymm7
    13bc:	c5 7d 6f 54 24 60    	vmovdqa 0x60(%rsp),%ymm10
    13c2:	4c 8b 94 24 c0 00 00 	mov    0xc0(%rsp),%r10
    13c9:	00 
    13ca:	c5 7d 6f 84 24 80 00 	vmovdqa 0x80(%rsp),%ymm8
    13d1:	00 00 
    13d3:	8b 94 24 e0 00 00 00 	mov    0xe0(%rsp),%edx
    13da:	c5 7d 6f 8c 24 a0 00 	vmovdqa 0xa0(%rsp),%ymm9
    13e1:	00 00 
    13e3:	c5 fd 6f 84 24 00 01 	vmovdqa 0x100(%rsp),%ymm0
    13ea:	00 00 
    13ec:	c5 fd 6f a4 24 20 01 	vmovdqa 0x120(%rsp),%ymm4
    13f3:	00 00 
    13f5:	c5 fd 6f 9c 24 40 01 	vmovdqa 0x140(%rsp),%ymm3
    13fc:	00 00 
    13fe:	c5 fd 6f 8c 24 60 01 	vmovdqa 0x160(%rsp),%ymm1
    1405:	00 00 
    1407:	48 8b 84 24 b8 01 00 	mov    0x1b8(%rsp),%rax
    140e:	00 
    140f:	c5 fd 6f 94 24 80 01 	vmovdqa 0x180(%rsp),%ymm2
    1416:	00 00 
    1418:	e9 54 fe ff ff       	jmp    1271 <scan_avx2+0x91>
    141d:	48 89 8c 24 a8 01 00 	mov    %rcx,0x1a8(%rsp)
    1424:	00 
    1425:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    142c:	4c 89 8c 24 b0 01 00 	mov    %r9,0x1b0(%rsp)
    1433:	00 
    1434:	4c 89 94 24 a0 00 00 	mov    %r10,0xa0(%rsp)
    143b:	00 
    143c:	48 89 84 24 20 01 00 	mov    %rax,0x120(%rsp)
    1443:	00 
    1444:	44 89 84 24 80 01 00 	mov    %r8d,0x180(%rsp)
    144b:	00 
    144c:	48 89 b4 24 b8 01 00 	mov    %rsi,0x1b8(%rsp)
    1453:	00 
    1454:	c5 fd 7f 34 24       	vmovdqa %ymm6,(%rsp)
    1459:	c5 fd 7f 7c 24 20    	vmovdqa %ymm7,0x20(%rsp)
    145f:	c5 7d 7f 54 24 40    	vmovdqa %ymm10,0x40(%rsp)
    1465:	c5 7d 7f 44 24 60    	vmovdqa %ymm8,0x60(%rsp)
    146b:	c5 7d 7f 8c 24 80 00 	vmovdqa %ymm9,0x80(%rsp)
    1472:	00 00 
    1474:	c5 fd 7f 84 24 c0 00 	vmovdqa %ymm0,0xc0(%rsp)
    147b:	00 00 
    147d:	c5 fd 7f a4 24 e0 00 	vmovdqa %ymm4,0xe0(%rsp)
    1484:	00 00 
    1486:	c5 fd 7f 9c 24 00 01 	vmovdqa %ymm3,0x100(%rsp)
    148d:	00 00 
    148f:	c5 fd 7f 8c 24 40 01 	vmovdqa %ymm1,0x140(%rsp)
    1496:	00 00 
    1498:	c5 fd 7f 94 24 60 01 	vmovdqa %ymm2,0x160(%rsp)
    149f:	00 00 
    14a1:	c5 f8 77             	vzeroupper
    14a4:	e8 00 00 00 00       	call   14a9 <scan_avx2+0x2c9>
    14a9:	48 8b 8c 24 a8 01 00 	mov    0x1a8(%rsp),%rcx
    14b0:	00 
    14b1:	4c 8b 8c 24 b0 01 00 	mov    0x1b0(%rsp),%r9
    14b8:	00 
    14b9:	c5 fd 6f 34 24       	vmovdqa (%rsp),%ymm6
    14be:	c5 fd 6f 7c 24 20    	vmovdqa 0x20(%rsp),%ymm7
    14c4:	c5 7d 6f 54 24 40    	vmovdqa 0x40(%rsp),%ymm10
    14ca:	c5 7d 6f 44 24 60    	vmovdqa 0x60(%rsp),%ymm8
    14d0:	4c 8b 94 24 a0 00 00 	mov    0xa0(%rsp),%r10
    14d7:	00 
    14d8:	c5 7d 6f 8c 24 80 00 	vmovdqa 0x80(%rsp),%ymm9
    14df:	00 00 
    14e1:	48 8b 84 24 20 01 00 	mov    0x120(%rsp),%rax
    14e8:	00 
    14e9:	44 8b 84 24 80 01 00 	mov    0x180(%rsp),%r8d
    14f0:	00 
    14f1:	c5 fd 6f 84 24 c0 00 	vmovdqa 0xc0(%rsp),%ymm0
    14f8:	00 00 
    14fa:	c5 fd 6f a4 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm4
    1501:	00 00 
    1503:	c5 fd 6f 9c 24 00 01 	vmovdqa 0x100(%rsp),%ymm3
    150a:	00 00 
    150c:	48 8b b4 24 b8 01 00 	mov    0x1b8(%rsp),%rsi
    1513:	00 
    1514:	c5 fd 6f 8c 24 40 01 	vmovdqa 0x140(%rsp),%ymm1
    151b:	00 00 
    151d:	c5 fd 6f 94 24 60 01 	vmovdqa 0x160(%rsp),%ymm2
    1524:	00 00 
    1526:	e9 5e fd ff ff       	jmp    1289 <scan_avx2+0xa9>
    152b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1530:	90                   	nop
    1531:	90                   	nop
    1532:	90                   	nop
    1533:	90                   	nop
    1534:	90                   	nop
    1535:	90                   	nop
    1536:	90                   	nop
    1537:	90                   	nop
    1538:	90                   	nop
    1539:	90                   	nop
    153a:	90                   	nop
    153b:	90                   	nop
    153c:	90                   	nop
    153d:	90                   	nop
    153e:	90                   	nop
    153f:	90                   	nop

0000000000001540 <n100_vector_decoder_avx2_available>:
    1540:	f3 0f 1e fa          	endbr64
    1544:	e8 00 00 00 00       	call   1549 <n100_vector_decoder_avx2_available+0x9>
    1549:	b8 01 00 00 00       	mov    $0x1,%eax
    154e:	e9 00 00 00 00       	jmp    1553 <n100_vector_decoder_avx2_available+0x13>
    1553:	66 90                	xchg   %ax,%ax
    1555:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    155c:	00 00 00 00 
    1560:	90                   	nop
    1561:	90                   	nop
    1562:	90                   	nop
    1563:	90                   	nop
    1564:	90                   	nop
    1565:	90                   	nop
    1566:	90                   	nop
    1567:	90                   	nop
    1568:	90                   	nop
    1569:	90                   	nop
    156a:	90                   	nop
    156b:	90                   	nop
    156c:	90                   	nop
    156d:	90                   	nop
    156e:	90                   	nop
    156f:	90                   	nop

0000000000001570 <n100_vector_decoder_encode_scalar>:
    1570:	f3 0f 1e fa          	endbr64
    1574:	e8 00 00 00 00       	call   1579 <n100_vector_decoder_encode_scalar+0x9>
    1579:	68 00 00 00 00       	push   $0x0
    157e:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    1585:	e8 d6 eb ff ff       	call   160 <encode>
    158a:	5a                   	pop    %rdx
    158b:	e9 00 00 00 00       	jmp    1590 <n100_vector_decoder_encode_scalar+0x20>
    1590:	90                   	nop
    1591:	90                   	nop
    1592:	90                   	nop
    1593:	90                   	nop
    1594:	90                   	nop
    1595:	90                   	nop
    1596:	90                   	nop
    1597:	90                   	nop
    1598:	90                   	nop
    1599:	90                   	nop
    159a:	90                   	nop
    159b:	90                   	nop
    159c:	90                   	nop
    159d:	90                   	nop
    159e:	90                   	nop
    159f:	90                   	nop

00000000000015a0 <n100_vector_decoder_encode_avx2>:
    15a0:	f3 0f 1e fa          	endbr64
    15a4:	e8 00 00 00 00       	call   15a9 <n100_vector_decoder_encode_avx2+0x9>
    15a9:	68 00 00 00 00       	push   $0x0
    15ae:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    15b5:	e8 a6 eb ff ff       	call   160 <encode>
    15ba:	5a                   	pop    %rdx
    15bb:	e9 00 00 00 00       	jmp    15c0 <n100_vector_decoder_encode_avx2+0x20>
    15c0:	90                   	nop
    15c1:	90                   	nop
    15c2:	90                   	nop
    15c3:	90                   	nop
    15c4:	90                   	nop
    15c5:	90                   	nop
    15c6:	90                   	nop
    15c7:	90                   	nop
    15c8:	90                   	nop
    15c9:	90                   	nop
    15ca:	90                   	nop
    15cb:	90                   	nop
    15cc:	90                   	nop
    15cd:	90                   	nop
    15ce:	90                   	nop
    15cf:	90                   	nop

00000000000015d0 <n100_vector_decoder_decode_scalar>:
    15d0:	f3 0f 1e fa          	endbr64
    15d4:	e8 00 00 00 00       	call   15d9 <n100_vector_decoder_decode_scalar+0x9>
    15d9:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    15e0:	49 c7 c0 00 00 00 00 	mov    $0x0,%r8
    15e7:	e9 74 f3 ff ff       	jmp    960 <decode>
    15ec:	0f 1f 40 00          	nopl   0x0(%rax)
    15f0:	90                   	nop
    15f1:	90                   	nop
    15f2:	90                   	nop
    15f3:	90                   	nop
    15f4:	90                   	nop
    15f5:	90                   	nop
    15f6:	90                   	nop
    15f7:	90                   	nop
    15f8:	90                   	nop
    15f9:	90                   	nop
    15fa:	90                   	nop
    15fb:	90                   	nop
    15fc:	90                   	nop
    15fd:	90                   	nop
    15fe:	90                   	nop
    15ff:	90                   	nop

0000000000001600 <n100_vector_decoder_decode_avx2>:
    1600:	f3 0f 1e fa          	endbr64
    1604:	e8 00 00 00 00       	call   1609 <n100_vector_decoder_decode_avx2+0x9>
    1609:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    1610:	49 c7 c0 00 00 00 00 	mov    $0x0,%r8
    1617:	e9 44 f3 ff ff       	jmp    960 <decode>
    161c:	0f 1f 40 00          	nopl   0x0(%rax)
    1620:	90                   	nop
    1621:	90                   	nop
    1622:	90                   	nop
    1623:	90                   	nop
    1624:	90                   	nop
    1625:	90                   	nop
    1626:	90                   	nop
    1627:	90                   	nop
    1628:	90                   	nop
    1629:	90                   	nop
    162a:	90                   	nop
    162b:	90                   	nop
    162c:	90                   	nop
    162d:	90                   	nop
    162e:	90                   	nop
    162f:	90                   	nop

0000000000001630 <n100_vector_decoder_decode_mixed>:
    1630:	f3 0f 1e fa          	endbr64
    1634:	e8 00 00 00 00       	call   1639 <n100_vector_decoder_decode_mixed+0x9>
    1639:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    1640:	49 c7 c0 00 00 00 00 	mov    $0x0,%r8
    1647:	e9 14 f3 ff ff       	jmp    960 <decode>

Disassembly of section .text.unlikely:

0000000000000000 <pack_avx2.cold>:
   0:	be 20 00 00 00       	mov    $0x20,%esi
   5:	bf 0e 00 00 00       	mov    $0xe,%edi
   a:	e8 00 00 00 00       	call   f <unpack_avx2.cold>

000000000000000f <unpack_avx2.cold>:
   f:	be 20 00 00 00       	mov    $0x20,%esi
  14:	bf 0f 00 00 00       	mov    $0xf,%edi
  19:	e8 00 00 00 00       	call   1e <pack_scalar+0xe>
