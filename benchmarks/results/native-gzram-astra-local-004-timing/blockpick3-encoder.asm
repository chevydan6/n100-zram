
build/astra-v4/hybrid-block3base.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <pack_avx2>:
       0:	85 d2                	test   %edx,%edx
       2:	74 6c                	je     70 <pack_avx2+0x70>
       4:	c5 fe 6f 07          	vmovdqu (%rdi),%ymm0
       8:	81 fa ff 00 00 00    	cmp    $0xff,%edx
       e:	74 50                	je     60 <pack_avx2+0x60>
      10:	55                   	push   %rbp
      11:	89 d2                	mov    %edx,%edx
      13:	48 8d 0d 00 00 00 00 	lea    0x0(%rip),%rcx        # 1a <pack_avx2+0x1a>
      1a:	48 89 f7             	mov    %rsi,%rdi
      1d:	48 89 d0             	mov    %rdx,%rax
      20:	48 c1 e0 05          	shl    $0x5,%rax
      24:	48 89 e5             	mov    %rsp,%rbp
      27:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
      2b:	48 83 ec 20          	sub    $0x20,%rsp
      2f:	c5 fd 6f 0c 01       	vmovdqa (%rcx,%rax,1),%ymm1
      34:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 3b <pack_avx2+0x3b>
      3b:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
      3f:	48 89 e6             	mov    %rsp,%rsi
      42:	c4 e2 75 36 c0       	vpermd %ymm0,%ymm1,%ymm0
      47:	c5 fd 7f 04 24       	vmovdqa %ymm0,(%rsp)
      4c:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
      53:	c5 f8 77             	vzeroupper
      56:	e8 00 00 00 00       	call   5b <pack_avx2+0x5b>
      5b:	c9                   	leave
      5c:	c3                   	ret
      5d:	0f 1f 00             	nopl   (%rax)
      60:	c5 fe 7f 06          	vmovdqu %ymm0,(%rsi)
      64:	c5 f8 77             	vzeroupper
      67:	c3                   	ret
      68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
      6f:	00 
      70:	c3                   	ret
      71:	0f 1f 40 00          	nopl   0x0(%rax)
      75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
      7c:	00 00 00 00 

0000000000000080 <repeat_avx2>:
      80:	55                   	push   %rbp
      81:	48 89 e5             	mov    %rsp,%rbp
      84:	41 57                	push   %r15
      86:	49 89 f7             	mov    %rsi,%r15
      89:	41 56                	push   %r14
      8b:	41 55                	push   %r13
      8d:	41 54                	push   %r12
      8f:	53                   	push   %rbx
      90:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
      94:	83 f9 04             	cmp    $0x4,%ecx
      97:	0f 84 f3 00 00 00    	je     190 <repeat_avx2+0x110>
      9d:	83 f9 08             	cmp    $0x8,%ecx
      a0:	0f 84 ba 00 00 00    	je     160 <repeat_avx2+0xe0>
      a6:	83 f9 10             	cmp    $0x10,%ecx
      a9:	0f 84 f1 00 00 00    	je     1a0 <repeat_avx2+0x120>
      af:	c5 fe 6f 06          	vmovdqu (%rsi),%ymm0
      b3:	48 83 fa 1f          	cmp    $0x1f,%rdx
      b7:	0f 86 b2 00 00 00    	jbe    16f <repeat_avx2+0xef>
      bd:	48 8d 5a e0          	lea    -0x20(%rdx),%rbx
      c1:	48 89 f8             	mov    %rdi,%rax
      c4:	48 89 de             	mov    %rbx,%rsi
      c7:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
      cb:	48 8d 74 37 20       	lea    0x20(%rdi,%rsi,1),%rsi
      d0:	49 89 f0             	mov    %rsi,%r8
      d3:	49 29 f8             	sub    %rdi,%r8
      d6:	41 83 e0 20          	and    $0x20,%r8d
      da:	74 24                	je     100 <repeat_avx2+0x80>
      dc:	48 8d 47 20          	lea    0x20(%rdi),%rax
      e0:	c5 fe 7f 07          	vmovdqu %ymm0,(%rdi)
      e4:	48 39 f0             	cmp    %rsi,%rax
      e7:	74 29                	je     112 <repeat_avx2+0x92>
      e9:	90                   	nop
      ea:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
      f1:	00 00 00 00 
      f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
      fc:	00 00 00 00 
     100:	c5 fe 7f 00          	vmovdqu %ymm0,(%rax)
     104:	48 83 c0 40          	add    $0x40,%rax
     108:	c5 fe 7f 40 e0       	vmovdqu %ymm0,-0x20(%rax)
     10d:	48 39 f0             	cmp    %rsi,%rax
     110:	75 ee                	jne    100 <repeat_avx2+0x80>
     112:	48 83 e3 e0          	and    $0xffffffffffffffe0,%rbx
     116:	48 83 c3 20          	add    $0x20,%rbx
     11a:	48 39 d3             	cmp    %rdx,%rbx
     11d:	73 57                	jae    176 <repeat_avx2+0xf6>
     11f:	49 89 d6             	mov    %rdx,%r14
     122:	49 89 fd             	mov    %rdi,%r13
     125:	41 89 cc             	mov    %ecx,%r12d
     128:	c5 f8 77             	vzeroupper
     12b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     130:	49 8d 7c 1d 00       	lea    0x0(%r13,%rbx,1),%rdi
     135:	4c 89 e2             	mov    %r12,%rdx
     138:	4c 89 fe             	mov    %r15,%rsi
     13b:	4c 01 e3             	add    %r12,%rbx
     13e:	e8 00 00 00 00       	call   143 <repeat_avx2+0xc3>
     143:	4c 39 f3             	cmp    %r14,%rbx
     146:	72 e8                	jb     130 <repeat_avx2+0xb0>
     148:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     14c:	5b                   	pop    %rbx
     14d:	41 5c                	pop    %r12
     14f:	41 5d                	pop    %r13
     151:	41 5e                	pop    %r14
     153:	41 5f                	pop    %r15
     155:	5d                   	pop    %rbp
     156:	c3                   	ret
     157:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     15e:	00 00 
     160:	c4 e2 7d 59 06       	vpbroadcastq (%rsi),%ymm0
     165:	48 83 fa 1f          	cmp    $0x1f,%rdx
     169:	0f 87 4e ff ff ff    	ja     bd <repeat_avx2+0x3d>
     16f:	31 db                	xor    %ebx,%ebx
     171:	48 39 d3             	cmp    %rdx,%rbx
     174:	72 a9                	jb     11f <repeat_avx2+0x9f>
     176:	c5 f8 77             	vzeroupper
     179:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     17d:	5b                   	pop    %rbx
     17e:	41 5c                	pop    %r12
     180:	41 5d                	pop    %r13
     182:	41 5e                	pop    %r14
     184:	41 5f                	pop    %r15
     186:	5d                   	pop    %rbp
     187:	c3                   	ret
     188:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     18f:	00 
     190:	c4 e2 7d 58 06       	vpbroadcastd (%rsi),%ymm0
     195:	e9 19 ff ff ff       	jmp    b3 <repeat_avx2+0x33>
     19a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     1a0:	c4 e2 7d 5a 06       	vbroadcasti128 (%rsi),%ymm0
     1a5:	e9 09 ff ff ff       	jmp    b3 <repeat_avx2+0x33>
     1aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000001b0 <scan_avx2>:
     1b0:	49 89 f8             	mov    %rdi,%r8
     1b3:	48 c1 ee 05          	shr    $0x5,%rsi
     1b7:	c5 c9 ef f6          	vpxor  %xmm6,%xmm6,%xmm6
     1bb:	48 89 d7             	mov    %rdx,%rdi
     1be:	41 8b 00             	mov    (%r8),%eax
     1c1:	c4 41 7a 7e 00       	vmovq  (%r8),%xmm8
     1c6:	c4 c1 7a 6f 38       	vmovdqu (%r8),%xmm7
     1cb:	c4 41 7e 6f 10       	vmovdqu (%r8),%ymm10
     1d0:	c7 82 80 00 00 00 00 	movl   $0x0,0x80(%rdx)
     1d7:	00 00 00 
     1da:	0f 84 c8 00 00 00    	je     2a8 <scan_avx2+0xf8>
     1e0:	c5 79 6e c8          	vmovd  %eax,%xmm9
     1e4:	c4 e3 45 38 ff 01    	vinserti128 $0x1,%xmm7,%ymm7,%ymm7
     1ea:	31 c9                	xor    %ecx,%ecx
     1ec:	31 d2                	xor    %edx,%edx
     1ee:	c4 42 7d 58 c9       	vpbroadcastd %xmm9,%ymm9
     1f3:	c4 42 7d 59 c0       	vpbroadcastq %xmm8,%ymm8
     1f8:	c5 fd 6f ce          	vmovdqa %ymm6,%ymm1
     1fc:	c5 fd 6f d6          	vmovdqa %ymm6,%ymm2
     200:	c5 fd 6f de          	vmovdqa %ymm6,%ymm3
     204:	c5 fd 6f e6          	vmovdqa %ymm6,%ymm4
     208:	4c 8d 0d 00 00 00 00 	lea    0x0(%rip),%r9        # 20f <scan_avx2+0x5f>
     20f:	90                   	nop
     210:	48 89 d0             	mov    %rdx,%rax
     213:	48 c1 e0 05          	shl    $0x5,%rax
     217:	c4 c1 7e 6f 04 00    	vmovdqu (%r8,%rax,1),%ymm0
     21d:	c5 fd 76 ee          	vpcmpeqd %ymm6,%ymm0,%ymm5
     221:	c5 fc 50 c5          	vmovmskps %ymm5,%eax
     225:	c4 c1 7d ef e9       	vpxor  %ymm9,%ymm0,%ymm5
     22a:	34 ff                	xor    $0xff,%al
     22c:	c5 d5 eb e4          	vpor   %ymm4,%ymm5,%ymm4
     230:	c5 bd ef e8          	vpxor  %ymm0,%ymm8,%ymm5
     234:	88 04 17             	mov    %al,(%rdi,%rdx,1)
     237:	89 c0                	mov    %eax,%eax
     239:	c5 d5 eb db          	vpor   %ymm3,%ymm5,%ymm3
     23d:	48 83 c2 01          	add    $0x1,%rdx
     241:	41 0f b6 04 01       	movzbl (%r9,%rax,1),%eax
     246:	c5 c5 ef e8          	vpxor  %ymm0,%ymm7,%ymm5
     24a:	c5 ad ef c0          	vpxor  %ymm0,%ymm10,%ymm0
     24e:	c5 d5 eb d2          	vpor   %ymm2,%ymm5,%ymm2
     252:	c5 fd eb c9          	vpor   %ymm1,%ymm0,%ymm1
     256:	01 c1                	add    %eax,%ecx
     258:	89 8f 80 00 00 00    	mov    %ecx,0x80(%rdi)
     25e:	48 39 f2             	cmp    %rsi,%rdx
     261:	75 ad                	jne    210 <scan_avx2+0x60>
     263:	31 f6                	xor    %esi,%esi
     265:	c4 e2 7d 17 e4       	vptest %ymm4,%ymm4
     26a:	40 0f 94 c6          	sete   %sil
     26e:	31 c0                	xor    %eax,%eax
     270:	c4 e2 7d 17 db       	vptest %ymm3,%ymm3
     275:	0f 94 c0             	sete   %al
     278:	31 c9                	xor    %ecx,%ecx
     27a:	c4 e2 7d 17 d2       	vptest %ymm2,%ymm2
     27f:	0f 94 c1             	sete   %cl
     282:	31 d2                	xor    %edx,%edx
     284:	c4 e2 7d 17 c9       	vptest %ymm1,%ymm1
     289:	0f 94 c2             	sete   %dl
     28c:	01 c0                	add    %eax,%eax
     28e:	c1 e1 02             	shl    $0x2,%ecx
     291:	09 c8                	or     %ecx,%eax
     293:	c1 e2 03             	shl    $0x3,%edx
     296:	09 f0                	or     %esi,%eax
     298:	09 d0                	or     %edx,%eax
     29a:	89 87 84 00 00 00    	mov    %eax,0x84(%rdi)
     2a0:	c5 f8 77             	vzeroupper
     2a3:	c3                   	ret
     2a4:	0f 1f 40 00          	nopl   0x0(%rax)
     2a8:	c5 fd 6f ce          	vmovdqa %ymm6,%ymm1
     2ac:	c5 fd 6f d6          	vmovdqa %ymm6,%ymm2
     2b0:	c5 fd 6f de          	vmovdqa %ymm6,%ymm3
     2b4:	c5 fd 6f e6          	vmovdqa %ymm6,%ymm4
     2b8:	eb a9                	jmp    263 <scan_avx2+0xb3>
     2ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000002c0 <unpack_avx2>:
     2c0:	55                   	push   %rbp
     2c1:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     2c5:	48 89 e5             	mov    %rsp,%rbp
     2c8:	41 55                	push   %r13
     2ca:	49 89 f5             	mov    %rsi,%r13
     2cd:	48 89 fe             	mov    %rdi,%rsi
     2d0:	41 54                	push   %r12
     2d2:	41 89 d4             	mov    %edx,%r12d
     2d5:	48 8d 15 00 00 00 00 	lea    0x0(%rip),%rdx        # 2dc <unpack_avx2+0x1c>
     2dc:	53                   	push   %rbx
     2dd:	4c 89 e3             	mov    %r12,%rbx
     2e0:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
     2e4:	48 83 ec 20          	sub    $0x20,%rsp
     2e8:	42 0f b6 14 22       	movzbl (%rdx,%r12,1),%edx
     2ed:	c5 fd 7f 04 24       	vmovdqa %ymm0,(%rsp)
     2f2:	48 89 e7             	mov    %rsp,%rdi
     2f5:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
     2fc:	c5 f8 77             	vzeroupper
     2ff:	49 c1 e4 05          	shl    $0x5,%r12
     303:	e8 00 00 00 00       	call   308 <unpack_avx2+0x48>
     308:	c5 f9 6e c3          	vmovd  %ebx,%xmm0
     30c:	c5 f1 ef c9          	vpxor  %xmm1,%xmm1,%xmm1
     310:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 317 <unpack_avx2+0x57>
     317:	c4 e2 7d 58 c0       	vpbroadcastd %xmm0,%ymm0
     31c:	c5 fd db 05 00 00 00 	vpand  0x0(%rip),%ymm0,%ymm0        # 324 <unpack_avx2+0x64>
     323:	00 
     324:	c4 a1 7d 6f 14 20    	vmovdqa (%rax,%r12,1),%ymm2
     32a:	c4 e2 6d 36 14 24    	vpermd (%rsp),%ymm2,%ymm2
     330:	c5 fd 76 c1          	vpcmpeqd %ymm1,%ymm0,%ymm0
     334:	c5 fd df c2          	vpandn %ymm2,%ymm0,%ymm0
     338:	c4 c1 7e 7f 45 00    	vmovdqu %ymm0,0x0(%r13)
     33e:	c5 f8 77             	vzeroupper
     341:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
     345:	5b                   	pop    %rbx
     346:	41 5c                	pop    %r12
     348:	41 5d                	pop    %r13
     34a:	5d                   	pop    %rbp
     34b:	c3                   	ret
     34c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000350 <pack_scalar>:
     350:	81 fa ff 00 00 00    	cmp    $0xff,%edx
     356:	74 28                	je     380 <pack_scalar+0x30>
     358:	85 d2                	test   %edx,%edx
     35a:	74 44                	je     3a0 <pack_scalar+0x50>
     35c:	0f 1f 40 00          	nopl   0x0(%rax)
     360:	31 c9                	xor    %ecx,%ecx
     362:	8d 42 ff             	lea    -0x1(%rdx),%eax
     365:	48 83 c6 04          	add    $0x4,%rsi
     369:	f3 0f bc ca          	tzcnt  %edx,%ecx
     36d:	8d 0c 8d 00 00 00 00 	lea    0x0(,%rcx,4),%ecx
     374:	8b 0c 0f             	mov    (%rdi,%rcx,1),%ecx
     377:	89 4e fc             	mov    %ecx,-0x4(%rsi)
     37a:	21 c2                	and    %eax,%edx
     37c:	75 e2                	jne    360 <pack_scalar+0x10>
     37e:	c3                   	ret
     37f:	90                   	nop
     380:	48 8b 07             	mov    (%rdi),%rax
     383:	48 89 06             	mov    %rax,(%rsi)
     386:	48 8b 47 08          	mov    0x8(%rdi),%rax
     38a:	48 89 46 08          	mov    %rax,0x8(%rsi)
     38e:	48 8b 47 10          	mov    0x10(%rdi),%rax
     392:	48 89 46 10          	mov    %rax,0x10(%rsi)
     396:	48 8b 47 18          	mov    0x18(%rdi),%rax
     39a:	48 89 46 18          	mov    %rax,0x18(%rsi)
     39e:	c3                   	ret
     39f:	90                   	nop
     3a0:	c3                   	ret
     3a1:	0f 1f 40 00          	nopl   0x0(%rax)
     3a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     3ac:	00 00 00 00 

00000000000003b0 <gzram_avx2_available>:
     3b0:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 3b7 <gzram_avx2_available+0x7>
     3b7:	0f b6 40 0d          	movzbl 0xd(%rax),%eax
     3bb:	c0 e8 02             	shr    $0x2,%al
     3be:	83 e0 01             	and    $0x1,%eax
     3c1:	c3                   	ret
     3c2:	0f 1f 00             	nopl   (%rax)
     3c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     3cc:	00 00 00 00 

00000000000003d0 <gzram_base_encode_scalar>:
     3d0:	41 8d 40 fb          	lea    -0x5(%r8),%eax
     3d4:	83 f8 07             	cmp    $0x7,%eax
     3d7:	0f 87 eb 00 00 00    	ja     4c8 <gzram_base_encode_scalar+0xf8>
     3dd:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
     3e4:	0f 87 de 00 00 00    	ja     4c8 <gzram_base_encode_scalar+0xf8>
     3ea:	48 85 d2             	test   %rdx,%rdx
     3ed:	0f 84 d5 00 00 00    	je     4c8 <gzram_base_encode_scalar+0xf8>
     3f3:	48 85 ff             	test   %rdi,%rdi
     3f6:	41 0f 94 c1          	sete   %r9b
     3fa:	48 85 f6             	test   %rsi,%rsi
     3fd:	0f 95 c0             	setne  %al
     400:	41 84 c1             	test   %al,%r9b
     403:	0f 85 bf 00 00 00    	jne    4c8 <gzram_base_encode_scalar+0xf8>
     409:	48 83 f9 07          	cmp    $0x7,%rcx
     40d:	0f 86 b5 00 00 00    	jbe    4c8 <gzram_base_encode_scalar+0xf8>
     413:	48 81 ec 38 01 00 00 	sub    $0x138,%rsp
     41a:	49 89 cb             	mov    %rcx,%r11
     41d:	41 ba 01 00 00 00    	mov    $0x1,%r10d
     423:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
     428:	44 89 c1             	mov    %r8d,%ecx
     42b:	49 d3 e2             	shl    %cl,%r10
     42e:	4c 89 a4 24 18 01 00 	mov    %r12,0x118(%rsp)
     435:	00 
     436:	49 89 f4             	mov    %rsi,%r12
     439:	48 89 fe             	mov    %rdi,%rsi
     43c:	4b 8d 44 22 ff       	lea    -0x1(%r10,%r12,1),%rax
     441:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
     448:	00 
     449:	48 d3 e8             	shr    %cl,%rax
     44c:	4c 89 b4 24 28 01 00 	mov    %r14,0x128(%rsp)
     453:	00 
     454:	45 89 c6             	mov    %r8d,%r14d
     457:	49 8d 4c 24 08       	lea    0x8(%r12),%rcx
     45c:	48 8d 58 08          	lea    0x8(%rax),%rbx
     460:	4c 89 bc 24 30 01 00 	mov    %r15,0x130(%rsp)
     467:	00 
     468:	49 89 d7             	mov    %rdx,%r15
     46b:	49 39 db             	cmp    %rbx,%r11
     46e:	73 5f                	jae    4cf <gzram_base_encode_scalar+0xff>
     470:	49 39 cb             	cmp    %rcx,%r11
     473:	72 56                	jb     4cb <gzram_base_encode_scalar+0xfb>
     475:	4d 85 e4             	test   %r12,%r12
     478:	0f 85 8f 04 00 00    	jne    90d <gzram_base_encode_scalar+0x53d>
     47e:	41 c7 07 47 5a 52 31 	movl   $0x31525a47,(%r15)
     485:	41 8d 44 24 08       	lea    0x8(%r12),%eax
     48a:	45 88 67 04          	mov    %r12b,0x4(%r15)
     48e:	41 c6 47 05 00       	movb   $0x0,0x5(%r15)
     493:	45 88 77 06          	mov    %r14b,0x6(%r15)
     497:	41 c6 47 07 01       	movb   $0x1,0x7(%r15)
     49c:	48 8b 9c 24 08 01 00 	mov    0x108(%rsp),%rbx
     4a3:	00 
     4a4:	4c 8b a4 24 18 01 00 	mov    0x118(%rsp),%r12
     4ab:	00 
     4ac:	4c 8b b4 24 28 01 00 	mov    0x128(%rsp),%r14
     4b3:	00 
     4b4:	4c 8b bc 24 30 01 00 	mov    0x130(%rsp),%r15
     4bb:	00 
     4bc:	48 81 c4 38 01 00 00 	add    $0x138,%rsp
     4c3:	c3                   	ret
     4c4:	0f 1f 40 00          	nopl   0x0(%rax)
     4c8:	31 c0                	xor    %eax,%eax
     4ca:	c3                   	ret
     4cb:	31 c0                	xor    %eax,%eax
     4cd:	eb cd                	jmp    49c <gzram_base_encode_scalar+0xcc>
     4cf:	c7 02 47 5a 52 31    	movl   $0x31525a47,(%rdx)
     4d5:	66 44 89 62 04       	mov    %r12w,0x4(%rdx)
     4da:	44 88 42 06          	mov    %r8b,0x6(%rdx)
     4de:	c6 42 07 00          	movb   $0x0,0x7(%rdx)
     4e2:	48 85 c0             	test   %rax,%rax
     4e5:	0f 84 ed 06 00 00    	je     bd8 <gzram_base_encode_scalar+0x808>
     4eb:	48 8d 7a 08          	lea    0x8(%rdx),%rdi
     4ef:	48 89 ac 24 10 01 00 	mov    %rbp,0x110(%rsp)
     4f6:	00 
     4f7:	4d 89 d7             	mov    %r10,%r15
     4fa:	48 8d 2d 00 00 00 00 	lea    0x0(%rip),%rbp        # 501 <gzram_base_encode_scalar+0x131>
     501:	48 01 f8             	add    %rdi,%rax
     504:	4c 89 ac 24 20 01 00 	mov    %r13,0x120(%rsp)
     50b:	00 
     50c:	49 89 fe             	mov    %rdi,%r14
     50f:	49 89 f5             	mov    %rsi,%r13
     512:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
     517:	4a 8d 04 26          	lea    (%rsi,%r12,1),%rax
     51b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     520:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
     525:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
     52a:	48 89 74 24 30       	mov    %rsi,0x30(%rsp)
     52f:	4c 89 64 24 38       	mov    %r12,0x38(%rsp)
     534:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
     539:	44 89 44 24 44       	mov    %r8d,0x44(%rsp)
     53e:	eb 3e                	jmp    57e <gzram_base_encode_scalar+0x1ae>
     540:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
     545:	48 29 d8             	sub    %rbx,%rax
     548:	4c 39 e0             	cmp    %r12,%rax
     54b:	0f 82 5e 01 00 00    	jb     6af <gzram_base_encode_scalar+0x2df>
     551:	41 c6 06 00          	movb   $0x0,(%r14)
     555:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     55a:	4c 89 e2             	mov    %r12,%rdx
     55d:	4c 89 ee             	mov    %r13,%rsi
     560:	48 8d 3c 18          	lea    (%rax,%rbx,1),%rdi
     564:	4c 01 e3             	add    %r12,%rbx
     567:	e8 00 00 00 00       	call   56c <gzram_base_encode_scalar+0x19c>
     56c:	4d 01 fd             	add    %r15,%r13
     56f:	49 83 c6 01          	add    $0x1,%r14
     573:	4c 39 74 24 10       	cmp    %r14,0x10(%rsp)
     578:	0f 84 5a 03 00 00    	je     8d8 <gzram_base_encode_scalar+0x508>
     57e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
     583:	4d 29 ec             	sub    %r13,%r12
     586:	4d 39 fc             	cmp    %r15,%r12
     589:	4d 0f 47 e7          	cmova  %r15,%r12
     58d:	41 f6 c4 1f          	test   $0x1f,%r12b
     591:	75 ad                	jne    540 <gzram_base_encode_scalar+0x170>
     593:	49 8b 7d 00          	mov    0x0(%r13),%rdi
     597:	4d 8b 55 10          	mov    0x10(%r13),%r10
     59b:	4d 8b 45 08          	mov    0x8(%r13),%r8
     59f:	4d 8b 4d 18          	mov    0x18(%r13),%r9
     5a3:	4c 39 d7             	cmp    %r10,%rdi
     5a6:	48 89 7c 24 58       	mov    %rdi,0x58(%rsp)
     5ab:	4c 89 44 24 60       	mov    %r8,0x60(%rsp)
     5b0:	0f 94 c0             	sete   %al
     5b3:	4c 89 54 24 68       	mov    %r10,0x68(%rsp)
     5b8:	4c 89 4c 24 70       	mov    %r9,0x70(%rsp)
     5bd:	4c 39 c7             	cmp    %r8,%rdi
     5c0:	0f 84 4c 02 00 00    	je     812 <gzram_base_encode_scalar+0x442>
     5c6:	4d 39 c8             	cmp    %r9,%r8
     5c9:	75 08                	jne    5d3 <gzram_base_encode_scalar+0x203>
     5cb:	84 c0                	test   %al,%al
     5cd:	0f 85 f0 02 00 00    	jne    8c3 <gzram_base_encode_scalar+0x4f3>
     5d3:	be 1f 00 00 00       	mov    $0x1f,%esi
     5d8:	b8 20 00 00 00       	mov    $0x20,%eax
     5dd:	41 bb 20 00 00 00    	mov    $0x20,%r11d
     5e3:	4c 39 e0             	cmp    %r12,%rax
     5e6:	0f 83 ec 03 00 00    	jae    9d8 <gzram_base_encode_scalar+0x608>
     5ec:	49 83 fc 20          	cmp    $0x20,%r12
     5f0:	0f 86 d9 03 00 00    	jbe    9cf <gzram_base_encode_scalar+0x5ff>
     5f6:	48 89 f9             	mov    %rdi,%rcx
     5f9:	b8 20 00 00 00       	mov    $0x20,%eax
     5fe:	eb 0f                	jmp    60f <gzram_base_encode_scalar+0x23f>
     600:	48 89 c2             	mov    %rax,%rdx
     603:	48 21 f2             	and    %rsi,%rdx
     606:	48 c1 ea 03          	shr    $0x3,%rdx
     60a:	48 8b 4c d4 58       	mov    0x58(%rsp,%rdx,8),%rcx
     60f:	49 8b 54 05 00       	mov    0x0(%r13,%rax,1),%rdx
     614:	48 83 c0 08          	add    $0x8,%rax
     618:	48 39 ca             	cmp    %rcx,%rdx
     61b:	0f 85 0f 01 00 00    	jne    730 <gzram_base_encode_scalar+0x360>
     621:	4c 39 e0             	cmp    %r12,%rax
     624:	72 da                	jb     600 <gzram_base_encode_scalar+0x230>
     626:	48 39 ca             	cmp    %rcx,%rdx
     629:	0f 85 01 01 00 00    	jne    730 <gzram_base_encode_scalar+0x360>
     62f:	48 85 ff             	test   %rdi,%rdi
     632:	0f 85 00 02 00 00    	jne    838 <gzram_base_encode_scalar+0x468>
     638:	4d 85 c0             	test   %r8,%r8
     63b:	75 0e                	jne    64b <gzram_base_encode_scalar+0x27b>
     63d:	4d 85 d2             	test   %r10,%r10
     640:	75 09                	jne    64b <gzram_base_encode_scalar+0x27b>
     642:	4d 85 c9             	test   %r9,%r9
     645:	0f 84 be 01 00 00    	je     809 <gzram_base_encode_scalar+0x439>
     64b:	c7 84 24 f8 00 00 00 	movl   $0x1,0xf8(%rsp)
     652:	01 00 00 00 
     656:	41 83 fb 08          	cmp    $0x8,%r11d
     65a:	0f 84 b2 00 00 00    	je     712 <gzram_base_encode_scalar+0x342>
     660:	41 83 fb 10          	cmp    $0x10,%r11d
     664:	0f 84 f8 04 00 00    	je     b62 <gzram_base_encode_scalar+0x792>
     66a:	c7 84 24 fc 00 00 00 	movl   $0x8,0xfc(%rsp)
     671:	08 00 00 00 
     675:	49 83 fc 20          	cmp    $0x20,%r12
     679:	0f 87 d2 02 00 00    	ja     951 <gzram_base_encode_scalar+0x581>
     67f:	bf 01 00 00 00       	mov    $0x1,%edi
     684:	4d 89 e0             	mov    %r12,%r8
     687:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
     68c:	8d 04 bd 00 00 00 00 	lea    0x0(,%rdi,4),%eax
     693:	49 c1 e8 05          	shr    $0x5,%r8
     697:	4c 01 c0             	add    %r8,%rax
     69a:	48 29 da             	sub    %rbx,%rdx
     69d:	4c 39 e0             	cmp    %r12,%rax
     6a0:	0f 82 52 03 00 00    	jb     9f8 <gzram_base_encode_scalar+0x628>
     6a6:	4c 39 e2             	cmp    %r12,%rdx
     6a9:	0f 83 a2 fe ff ff    	jae    551 <gzram_base_encode_scalar+0x181>
     6af:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
     6b4:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
     6b9:	31 c0                	xor    %eax,%eax
     6bb:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
     6c0:	4c 8b 64 24 38       	mov    0x38(%rsp),%r12
     6c5:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
     6ca:	44 8b 74 24 44       	mov    0x44(%rsp),%r14d
     6cf:	48 39 4c 24 20       	cmp    %rcx,0x20(%rsp)
     6d4:	0f 82 cb 04 00 00    	jb     ba5 <gzram_base_encode_scalar+0x7d5>
     6da:	4d 85 e4             	test   %r12,%r12
     6dd:	0f 85 d7 04 00 00    	jne    bba <gzram_base_encode_scalar+0x7ea>
     6e3:	41 c7 07 47 5a 52 31 	movl   $0x31525a47,(%r15)
     6ea:	41 8d 44 24 08       	lea    0x8(%r12),%eax
     6ef:	66 45 89 67 04       	mov    %r12w,0x4(%r15)
     6f4:	45 88 77 06          	mov    %r14b,0x6(%r15)
     6f8:	41 c6 47 07 01       	movb   $0x1,0x7(%r15)
     6fd:	48 8b ac 24 10 01 00 	mov    0x110(%rsp),%rbp
     704:	00 
     705:	4c 8b ac 24 20 01 00 	mov    0x120(%rsp),%r13
     70c:	00 
     70d:	e9 8a fd ff ff       	jmp    49c <gzram_base_encode_scalar+0xcc>
     712:	49 83 fc 04          	cmp    $0x4,%r12
     716:	0f 86 35 fe ff ff    	jbe    551 <gzram_base_encode_scalar+0x181>
     71c:	ba 02 00 00 00       	mov    $0x2,%edx
     721:	b8 04 00 00 00       	mov    $0x4,%eax
     726:	e9 45 01 00 00       	jmp    870 <gzram_base_encode_scalar+0x4a0>
     72b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     730:	c7 84 24 fc 00 00 00 	movl   $0x0,0xfc(%rsp)
     737:	00 00 00 00 
     73b:	4d 89 e0             	mov    %r12,%r8
     73e:	49 c1 e8 05          	shr    $0x5,%r8
     742:	49 c1 e0 05          	shl    $0x5,%r8
     746:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
     74b:	4c 89 e8             	mov    %r13,%rax
     74e:	31 ff                	xor    %edi,%edi
     750:	4d 01 e8             	add    %r13,%r8
     753:	66 90                	xchg   %ax,%ax
     755:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     75c:	00 00 00 00 
     760:	8b 48 04             	mov    0x4(%rax),%ecx
     763:	44 8b 48 08          	mov    0x8(%rax),%r9d
     767:	31 d2                	xor    %edx,%edx
     769:	44 8b 10             	mov    (%rax),%r10d
     76c:	44 8b 58 0c          	mov    0xc(%rax),%r11d
     770:	85 c9                	test   %ecx,%ecx
     772:	0f 95 c2             	setne  %dl
     775:	31 c9                	xor    %ecx,%ecx
     777:	01 d2                	add    %edx,%edx
     779:	45 85 c9             	test   %r9d,%r9d
     77c:	44 8b 48 10          	mov    0x10(%rax),%r9d
     780:	0f 95 c1             	setne  %cl
     783:	c1 e1 02             	shl    $0x2,%ecx
     786:	09 ca                	or     %ecx,%edx
     788:	31 c9                	xor    %ecx,%ecx
     78a:	45 85 d2             	test   %r10d,%r10d
     78d:	44 8b 50 14          	mov    0x14(%rax),%r10d
     791:	0f 95 c1             	setne  %cl
     794:	09 ca                	or     %ecx,%edx
     796:	31 c9                	xor    %ecx,%ecx
     798:	45 85 db             	test   %r11d,%r11d
     79b:	44 8b 58 18          	mov    0x18(%rax),%r11d
     79f:	0f 95 c1             	setne  %cl
     7a2:	c1 e1 03             	shl    $0x3,%ecx
     7a5:	09 ca                	or     %ecx,%edx
     7a7:	31 c9                	xor    %ecx,%ecx
     7a9:	45 85 c9             	test   %r9d,%r9d
     7ac:	44 8b 48 1c          	mov    0x1c(%rax),%r9d
     7b0:	0f 95 c1             	setne  %cl
     7b3:	c1 e1 04             	shl    $0x4,%ecx
     7b6:	09 d1                	or     %edx,%ecx
     7b8:	31 d2                	xor    %edx,%edx
     7ba:	45 85 d2             	test   %r10d,%r10d
     7bd:	0f 95 c2             	setne  %dl
     7c0:	c1 e2 05             	shl    $0x5,%edx
     7c3:	09 ca                	or     %ecx,%edx
     7c5:	31 c9                	xor    %ecx,%ecx
     7c7:	45 85 db             	test   %r11d,%r11d
     7ca:	0f 95 c1             	setne  %cl
     7cd:	c1 e1 06             	shl    $0x6,%ecx
     7d0:	09 d1                	or     %edx,%ecx
     7d2:	31 d2                	xor    %edx,%edx
     7d4:	45 85 c9             	test   %r9d,%r9d
     7d7:	0f 95 c2             	setne  %dl
     7da:	48 83 c0 20          	add    $0x20,%rax
     7de:	48 83 c6 01          	add    $0x1,%rsi
     7e2:	c1 e2 07             	shl    $0x7,%edx
     7e5:	09 ca                	or     %ecx,%edx
     7e7:	88 56 ff             	mov    %dl,-0x1(%rsi)
     7ea:	0f b6 54 15 00       	movzbl 0x0(%rbp,%rdx,1),%edx
     7ef:	01 d7                	add    %edx,%edi
     7f1:	49 39 c0             	cmp    %rax,%r8
     7f4:	0f 85 66 ff ff ff    	jne    760 <gzram_base_encode_scalar+0x390>
     7fa:	89 bc 24 f8 00 00 00 	mov    %edi,0xf8(%rsp)
     801:	85 ff                	test   %edi,%edi
     803:	0f 85 7b fe ff ff    	jne    684 <gzram_base_encode_scalar+0x2b4>
     809:	41 c6 06 01          	movb   $0x1,(%r14)
     80d:	e9 5a fd ff ff       	jmp    56c <gzram_base_encode_scalar+0x19c>
     812:	4c 39 cf             	cmp    %r9,%rdi
     815:	0f 85 b8 fd ff ff    	jne    5d3 <gzram_base_encode_scalar+0x203>
     81b:	84 c0                	test   %al,%al
     81d:	0f 84 b0 fd ff ff    	je     5d3 <gzram_base_encode_scalar+0x203>
     823:	be 07 00 00 00       	mov    $0x7,%esi
     828:	b8 08 00 00 00       	mov    $0x8,%eax
     82d:	41 bb 08 00 00 00    	mov    $0x8,%r11d
     833:	e9 ab fd ff ff       	jmp    5e3 <gzram_base_encode_scalar+0x213>
     838:	c7 84 24 f8 00 00 00 	movl   $0x1,0xf8(%rsp)
     83f:	01 00 00 00 
     843:	41 83 fb 08          	cmp    $0x8,%r11d
     847:	0f 85 13 fe ff ff    	jne    660 <gzram_base_encode_scalar+0x290>
     84d:	48 89 f8             	mov    %rdi,%rax
     850:	48 c1 e8 20          	shr    $0x20,%rax
     854:	39 c7                	cmp    %eax,%edi
     856:	0f 84 b6 fe ff ff    	je     712 <gzram_base_encode_scalar+0x342>
     85c:	49 83 fc 08          	cmp    $0x8,%r12
     860:	0f 86 eb fc ff ff    	jbe    551 <gzram_base_encode_scalar+0x181>
     866:	ba 03 00 00 00       	mov    $0x3,%edx
     86b:	b8 08 00 00 00       	mov    $0x8,%eax
     870:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
     875:	48 29 d9             	sub    %rbx,%rcx
     878:	48 39 c1             	cmp    %rax,%rcx
     87b:	0f 82 2e fe ff ff    	jb     6af <gzram_base_encode_scalar+0x2df>
     881:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
     886:	41 88 16             	mov    %dl,(%r14)
     889:	89 c2                	mov    %eax,%edx
     88b:	48 8d 0c 1f          	lea    (%rdi,%rbx,1),%rcx
     88f:	83 f8 20             	cmp    $0x20,%eax
     892:	0f 83 c8 00 00 00    	jae    960 <gzram_base_encode_scalar+0x590>
     898:	a8 10                	test   $0x10,%al
     89a:	0f 85 94 02 00 00    	jne    b34 <gzram_base_encode_scalar+0x764>
     8a0:	a8 08                	test   $0x8,%al
     8a2:	0f 85 d3 02 00 00    	jne    b7b <gzram_base_encode_scalar+0x7ab>
     8a8:	a8 04                	test   $0x4,%al
     8aa:	0f 85 e1 02 00 00    	jne    b91 <gzram_base_encode_scalar+0x7c1>
     8b0:	85 c0                	test   %eax,%eax
     8b2:	74 07                	je     8bb <gzram_base_encode_scalar+0x4eb>
     8b4:	41 0f b6 55 00       	movzbl 0x0(%r13),%edx
     8b9:	88 11                	mov    %dl,(%rcx)
     8bb:	48 01 c3             	add    %rax,%rbx
     8be:	e9 a9 fc ff ff       	jmp    56c <gzram_base_encode_scalar+0x19c>
     8c3:	be 0f 00 00 00       	mov    $0xf,%esi
     8c8:	b8 10 00 00 00       	mov    $0x10,%eax
     8cd:	41 bb 10 00 00 00    	mov    $0x10,%r11d
     8d3:	e9 0b fd ff ff       	jmp    5e3 <gzram_base_encode_scalar+0x213>
     8d8:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
     8dd:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
     8e2:	4c 8b 64 24 38       	mov    0x38(%rsp),%r12
     8e7:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
     8ec:	44 8b 74 24 44       	mov    0x44(%rsp),%r14d
     8f1:	48 8b ac 24 10 01 00 	mov    0x110(%rsp),%rbp
     8f8:	00 
     8f9:	4c 8b ac 24 20 01 00 	mov    0x120(%rsp),%r13
     900:	00 
     901:	48 39 cb             	cmp    %rcx,%rbx
     904:	73 18                	jae    91e <gzram_base_encode_scalar+0x54e>
     906:	89 d8                	mov    %ebx,%eax
     908:	e9 8f fb ff ff       	jmp    49c <gzram_base_encode_scalar+0xcc>
     90d:	48 8d 7a 08          	lea    0x8(%rdx),%rdi
     911:	4c 89 e2             	mov    %r12,%rdx
     914:	e8 00 00 00 00       	call   919 <gzram_base_encode_scalar+0x549>
     919:	e9 60 fb ff ff       	jmp    47e <gzram_base_encode_scalar+0xae>
     91e:	48 39 4c 24 20       	cmp    %rcx,0x20(%rsp)
     923:	0f 82 a2 fb ff ff    	jb     4cb <gzram_base_encode_scalar+0xfb>
     929:	4d 85 e4             	test   %r12,%r12
     92c:	0f 85 95 02 00 00    	jne    bc7 <gzram_base_encode_scalar+0x7f7>
     932:	41 c7 07 47 5a 52 31 	movl   $0x31525a47,(%r15)
     939:	41 8d 44 24 08       	lea    0x8(%r12),%eax
     93e:	66 45 89 67 04       	mov    %r12w,0x4(%r15)
     943:	45 88 77 06          	mov    %r14b,0x6(%r15)
     947:	41 c6 47 07 01       	movb   $0x1,0x7(%r15)
     94c:	e9 4b fb ff ff       	jmp    49c <gzram_base_encode_scalar+0xcc>
     951:	ba 06 00 00 00       	mov    $0x6,%edx
     956:	b8 20 00 00 00       	mov    $0x20,%eax
     95b:	e9 10 ff ff ff       	jmp    870 <gzram_base_encode_scalar+0x4a0>
     960:	49 8d 74 05 00       	lea    0x0(%r13,%rax,1),%rsi
     965:	8d 50 ff             	lea    -0x1(%rax),%edx
     968:	48 8b 7e e0          	mov    -0x20(%rsi),%rdi
     96c:	48 89 7c 08 e0       	mov    %rdi,-0x20(%rax,%rcx,1)
     971:	48 8b 7e e8          	mov    -0x18(%rsi),%rdi
     975:	48 89 7c 08 e8       	mov    %rdi,-0x18(%rax,%rcx,1)
     97a:	48 8b 7e f0          	mov    -0x10(%rsi),%rdi
     97e:	48 89 7c 08 f0       	mov    %rdi,-0x10(%rax,%rcx,1)
     983:	48 8b 76 f8          	mov    -0x8(%rsi),%rsi
     987:	48 89 74 08 f8       	mov    %rsi,-0x8(%rax,%rcx,1)
     98c:	83 fa 20             	cmp    $0x20,%edx
     98f:	0f 82 26 ff ff ff    	jb     8bb <gzram_base_encode_scalar+0x4eb>
     995:	83 e2 e0             	and    $0xffffffe0,%edx
     998:	31 ff                	xor    %edi,%edi
     99a:	89 fe                	mov    %edi,%esi
     99c:	83 c7 20             	add    $0x20,%edi
     99f:	4d 8b 5c 35 00       	mov    0x0(%r13,%rsi,1),%r11
     9a4:	4d 8b 54 35 08       	mov    0x8(%r13,%rsi,1),%r10
     9a9:	4d 8b 4c 35 10       	mov    0x10(%r13,%rsi,1),%r9
     9ae:	4d 8b 44 35 18       	mov    0x18(%r13,%rsi,1),%r8
     9b3:	4c 89 1c 31          	mov    %r11,(%rcx,%rsi,1)
     9b7:	4c 89 54 31 08       	mov    %r10,0x8(%rcx,%rsi,1)
     9bc:	4c 89 4c 31 10       	mov    %r9,0x10(%rcx,%rsi,1)
     9c1:	4c 89 44 31 18       	mov    %r8,0x18(%rcx,%rsi,1)
     9c6:	39 d7                	cmp    %edx,%edi
     9c8:	72 d0                	jb     99a <gzram_base_encode_scalar+0x5ca>
     9ca:	e9 ec fe ff ff       	jmp    8bb <gzram_base_encode_scalar+0x4eb>
     9cf:	4c 39 e0             	cmp    %r12,%rax
     9d2:	0f 82 57 fc ff ff    	jb     62f <gzram_base_encode_scalar+0x25f>
     9d8:	c7 84 24 fc 00 00 00 	movl   $0x0,0xfc(%rsp)
     9df:	00 00 00 00 
     9e3:	4d 89 e0             	mov    %r12,%r8
     9e6:	49 c1 e8 05          	shr    $0x5,%r8
     9ea:	0f 84 19 fe ff ff    	je     809 <gzram_base_encode_scalar+0x439>
     9f0:	e9 4d fd ff ff       	jmp    742 <gzram_base_encode_scalar+0x372>
     9f5:	0f 1f 00             	nopl   (%rax)
     9f8:	48 39 c2             	cmp    %rax,%rdx
     9fb:	0f 82 ae fc ff ff    	jb     6af <gzram_base_encode_scalar+0x2df>
     a01:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     a06:	41 c6 06 04          	movb   $0x4,(%r14)
     a0a:	48 01 d8             	add    %rbx,%rax
     a0d:	41 83 f8 20          	cmp    $0x20,%r8d
     a11:	0f 83 9a 00 00 00    	jae    ab1 <gzram_base_encode_scalar+0x6e1>
     a17:	41 f6 c0 10          	test   $0x10,%r8b
     a1b:	0f 85 cd 01 00 00    	jne    bee <gzram_base_encode_scalar+0x81e>
     a21:	41 f6 c0 08          	test   $0x8,%r8b
     a25:	0f 85 12 02 00 00    	jne    c3d <gzram_base_encode_scalar+0x86d>
     a2b:	41 f6 c0 04          	test   $0x4,%r8b
     a2f:	0f 85 f2 01 00 00    	jne    c27 <gzram_base_encode_scalar+0x857>
     a35:	45 85 c0             	test   %r8d,%r8d
     a38:	74 11                	je     a4b <gzram_base_encode_scalar+0x67b>
     a3a:	0f b6 54 24 78       	movzbl 0x78(%rsp),%edx
     a3f:	88 10                	mov    %dl,(%rax)
     a41:	41 f6 c0 02          	test   $0x2,%r8b
     a45:	0f 85 0c 02 00 00    	jne    c57 <gzram_base_encode_scalar+0x887>
     a4b:	4c 01 c3             	add    %r8,%rbx
     a4e:	4d 85 c0             	test   %r8,%r8
     a51:	0f 84 15 fb ff ff    	je     56c <gzram_base_encode_scalar+0x19c>
     a57:	49 c1 e0 05          	shl    $0x5,%r8
     a5b:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
     a60:	4c 8d 54 24 78       	lea    0x78(%rsp),%r10
     a65:	4c 89 ef             	mov    %r13,%rdi
     a68:	4d 01 e8             	add    %r13,%r8
     a6b:	4c 8d 0d 00 00 00 00 	lea    0x0(%rip),%r9        # a72 <gzram_base_encode_scalar+0x6a2>
     a72:	0f 1f 00             	nopl   (%rax)
     a75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     a7c:	00 00 00 00 
     a80:	45 0f b6 1a          	movzbl (%r10),%r11d
     a84:	49 8d 34 1c          	lea    (%r12,%rbx,1),%rsi
     a88:	49 83 c2 01          	add    $0x1,%r10
     a8c:	44 89 da             	mov    %r11d,%edx
     a8f:	e8 bc f8 ff ff       	call   350 <pack_scalar>
     a94:	43 0f b6 04 19       	movzbl (%r9,%r11,1),%eax
     a99:	48 83 c7 20          	add    $0x20,%rdi
     a9d:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
     aa4:	48 01 c3             	add    %rax,%rbx
     aa7:	4c 39 c7             	cmp    %r8,%rdi
     aaa:	75 d4                	jne    a80 <gzram_base_encode_scalar+0x6b0>
     aac:	e9 bb fa ff ff       	jmp    56c <gzram_base_encode_scalar+0x19c>
     ab1:	44 89 c1             	mov    %r8d,%ecx
     ab4:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
     ab8:	48 8d 4c 0c 78       	lea    0x78(%rsp,%rcx,1),%rcx
     abd:	48 8b 71 e0          	mov    -0x20(%rcx),%rsi
     ac1:	48 89 72 e0          	mov    %rsi,-0x20(%rdx)
     ac5:	48 8b 71 e8          	mov    -0x18(%rcx),%rsi
     ac9:	48 89 72 e8          	mov    %rsi,-0x18(%rdx)
     acd:	48 8b 71 f0          	mov    -0x10(%rcx),%rsi
     ad1:	48 89 72 f0          	mov    %rsi,-0x10(%rdx)
     ad5:	48 8b 49 f8          	mov    -0x8(%rcx),%rcx
     ad9:	48 89 4a f8          	mov    %rcx,-0x8(%rdx)
     add:	41 8d 50 ff          	lea    -0x1(%r8),%edx
     ae1:	83 fa 20             	cmp    $0x20,%edx
     ae4:	0f 82 61 ff ff ff    	jb     a4b <gzram_base_encode_scalar+0x67b>
     aea:	83 e2 e0             	and    $0xffffffe0,%edx
     aed:	45 31 c9             	xor    %r9d,%r9d
     af0:	41 89 d2             	mov    %edx,%r10d
     af3:	44 89 ca             	mov    %r9d,%edx
     af6:	41 83 c1 20          	add    $0x20,%r9d
     afa:	4c 8b 5c 14 78       	mov    0x78(%rsp,%rdx,1),%r11
     aff:	48 8b bc 14 80 00 00 	mov    0x80(%rsp,%rdx,1),%rdi
     b06:	00 
     b07:	48 8b b4 14 88 00 00 	mov    0x88(%rsp,%rdx,1),%rsi
     b0e:	00 
     b0f:	48 8b 8c 14 90 00 00 	mov    0x90(%rsp,%rdx,1),%rcx
     b16:	00 
     b17:	4c 89 1c 10          	mov    %r11,(%rax,%rdx,1)
     b1b:	48 89 7c 10 08       	mov    %rdi,0x8(%rax,%rdx,1)
     b20:	48 89 74 10 10       	mov    %rsi,0x10(%rax,%rdx,1)
     b25:	48 89 4c 10 18       	mov    %rcx,0x18(%rax,%rdx,1)
     b2a:	45 39 d1             	cmp    %r10d,%r9d
     b2d:	72 c4                	jb     af3 <gzram_base_encode_scalar+0x723>
     b2f:	e9 17 ff ff ff       	jmp    a4b <gzram_base_encode_scalar+0x67b>
     b34:	49 8b 75 00          	mov    0x0(%r13),%rsi
     b38:	48 89 31             	mov    %rsi,(%rcx)
     b3b:	49 8b 75 08          	mov    0x8(%r13),%rsi
     b3f:	48 89 71 08          	mov    %rsi,0x8(%rcx)
     b43:	48 8d 4c 11 10       	lea    0x10(%rcx,%rdx,1),%rcx
     b48:	49 8d 54 15 10       	lea    0x10(%r13,%rdx,1),%rdx
     b4d:	48 8b 72 e0          	mov    -0x20(%rdx),%rsi
     b51:	48 89 71 e0          	mov    %rsi,-0x20(%rcx)
     b55:	48 8b 52 e8          	mov    -0x18(%rdx),%rdx
     b59:	48 89 51 e8          	mov    %rdx,-0x18(%rcx)
     b5d:	e9 59 fd ff ff       	jmp    8bb <gzram_base_encode_scalar+0x4eb>
     b62:	49 83 fc 10          	cmp    $0x10,%r12
     b66:	0f 86 e5 f9 ff ff    	jbe    551 <gzram_base_encode_scalar+0x181>
     b6c:	ba 05 00 00 00       	mov    $0x5,%edx
     b71:	b8 10 00 00 00       	mov    $0x10,%eax
     b76:	e9 f5 fc ff ff       	jmp    870 <gzram_base_encode_scalar+0x4a0>
     b7b:	49 8b 75 00          	mov    0x0(%r13),%rsi
     b7f:	48 89 31             	mov    %rsi,(%rcx)
     b82:	49 8b 74 15 f8       	mov    -0x8(%r13,%rdx,1),%rsi
     b87:	48 89 74 11 f8       	mov    %rsi,-0x8(%rcx,%rdx,1)
     b8c:	e9 2a fd ff ff       	jmp    8bb <gzram_base_encode_scalar+0x4eb>
     b91:	41 8b 75 00          	mov    0x0(%r13),%esi
     b95:	89 31                	mov    %esi,(%rcx)
     b97:	41 8b 74 15 fc       	mov    -0x4(%r13,%rdx,1),%esi
     b9c:	89 74 11 fc          	mov    %esi,-0x4(%rcx,%rdx,1)
     ba0:	e9 16 fd ff ff       	jmp    8bb <gzram_base_encode_scalar+0x4eb>
     ba5:	48 8b ac 24 10 01 00 	mov    0x110(%rsp),%rbp
     bac:	00 
     bad:	4c 8b ac 24 20 01 00 	mov    0x120(%rsp),%r13
     bb4:	00 
     bb5:	e9 e2 f8 ff ff       	jmp    49c <gzram_base_encode_scalar+0xcc>
     bba:	4c 89 e2             	mov    %r12,%rdx
     bbd:	e8 00 00 00 00       	call   bc2 <gzram_base_encode_scalar+0x7f2>
     bc2:	e9 1c fb ff ff       	jmp    6e3 <gzram_base_encode_scalar+0x313>
     bc7:	49 8d 7f 08          	lea    0x8(%r15),%rdi
     bcb:	4c 89 e2             	mov    %r12,%rdx
     bce:	e8 00 00 00 00       	call   bd3 <gzram_base_encode_scalar+0x803>
     bd3:	e9 5a fd ff ff       	jmp    932 <gzram_base_encode_scalar+0x562>
     bd8:	bb 08 00 00 00       	mov    $0x8,%ebx
     bdd:	48 83 f9 08          	cmp    $0x8,%rcx
     be1:	0f 84 42 fd ff ff    	je     929 <gzram_base_encode_scalar+0x559>
     be7:	89 d8                	mov    %ebx,%eax
     be9:	e9 ae f8 ff ff       	jmp    49c <gzram_base_encode_scalar+0xcc>
     bee:	48 8b 54 24 78       	mov    0x78(%rsp),%rdx
     bf3:	48 89 10             	mov    %rdx,(%rax)
     bf6:	48 8b 94 24 80 00 00 	mov    0x80(%rsp),%rdx
     bfd:	00 
     bfe:	48 89 50 08          	mov    %rdx,0x8(%rax)
     c02:	44 89 c2             	mov    %r8d,%edx
     c05:	48 8d 44 10 10       	lea    0x10(%rax,%rdx,1),%rax
     c0a:	48 8d 94 14 88 00 00 	lea    0x88(%rsp,%rdx,1),%rdx
     c11:	00 
     c12:	48 8b 4a e0          	mov    -0x20(%rdx),%rcx
     c16:	48 89 48 e0          	mov    %rcx,-0x20(%rax)
     c1a:	48 8b 52 e8          	mov    -0x18(%rdx),%rdx
     c1e:	48 89 50 e8          	mov    %rdx,-0x18(%rax)
     c22:	e9 24 fe ff ff       	jmp    a4b <gzram_base_encode_scalar+0x67b>
     c27:	8b 54 24 78          	mov    0x78(%rsp),%edx
     c2b:	89 10                	mov    %edx,(%rax)
     c2d:	44 89 c2             	mov    %r8d,%edx
     c30:	8b 4c 14 74          	mov    0x74(%rsp,%rdx,1),%ecx
     c34:	89 4c 10 fc          	mov    %ecx,-0x4(%rax,%rdx,1)
     c38:	e9 0e fe ff ff       	jmp    a4b <gzram_base_encode_scalar+0x67b>
     c3d:	48 8b 54 24 78       	mov    0x78(%rsp),%rdx
     c42:	48 89 10             	mov    %rdx,(%rax)
     c45:	44 89 c2             	mov    %r8d,%edx
     c48:	48 8b 4c 14 70       	mov    0x70(%rsp,%rdx,1),%rcx
     c4d:	48 89 4c 10 f8       	mov    %rcx,-0x8(%rax,%rdx,1)
     c52:	e9 f4 fd ff ff       	jmp    a4b <gzram_base_encode_scalar+0x67b>
     c57:	44 89 c2             	mov    %r8d,%edx
     c5a:	0f b7 4c 14 76       	movzwl 0x76(%rsp,%rdx,1),%ecx
     c5f:	66 89 4c 10 fe       	mov    %cx,-0x2(%rax,%rdx,1)
     c64:	e9 e2 fd ff ff       	jmp    a4b <gzram_base_encode_scalar+0x67b>
     c69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000000c70 <gzram_base_encode_avx2>:
     c70:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
     c77:	48 89 ac 24 00 01 00 	mov    %rbp,0x100(%rsp)
     c7e:	00 
     c7f:	48 89 d5             	mov    %rdx,%rbp
     c82:	4c 89 a4 24 08 01 00 	mov    %r12,0x108(%rsp)
     c89:	00 
     c8a:	49 89 f4             	mov    %rsi,%r12
     c8d:	4c 89 b4 24 18 01 00 	mov    %r14,0x118(%rsp)
     c94:	00 
     c95:	49 89 ce             	mov    %rcx,%r14
     c98:	4c 89 bc 24 20 01 00 	mov    %r15,0x120(%rsp)
     c9f:	00 
     ca0:	49 89 ff             	mov    %rdi,%r15
     ca3:	44 89 04 24          	mov    %r8d,(%rsp)
     ca7:	e8 00 00 00 00       	call   cac <gzram_base_encode_avx2+0x3c>
     cac:	44 8b 04 24          	mov    (%rsp),%r8d
     cb0:	85 c0                	test   %eax,%eax
     cb2:	0f 84 b8 00 00 00    	je     d70 <gzram_base_encode_avx2+0x100>
     cb8:	41 8d 40 fb          	lea    -0x5(%r8),%eax
     cbc:	83 f8 07             	cmp    $0x7,%eax
     cbf:	0f 87 fb 00 00 00    	ja     dc0 <gzram_base_encode_avx2+0x150>
     cc5:	49 81 fc 00 10 00 00 	cmp    $0x1000,%r12
     ccc:	0f 87 ee 00 00 00    	ja     dc0 <gzram_base_encode_avx2+0x150>
     cd2:	48 85 ed             	test   %rbp,%rbp
     cd5:	0f 84 e5 00 00 00    	je     dc0 <gzram_base_encode_avx2+0x150>
     cdb:	4d 85 ff             	test   %r15,%r15
     cde:	0f 94 c2             	sete   %dl
     ce1:	4d 85 e4             	test   %r12,%r12
     ce4:	0f 95 c0             	setne  %al
     ce7:	84 c2                	test   %al,%dl
     ce9:	0f 85 d1 00 00 00    	jne    dc0 <gzram_base_encode_avx2+0x150>
     cef:	49 83 fe 07          	cmp    $0x7,%r14
     cf3:	0f 86 c7 00 00 00    	jbe    dc0 <gzram_base_encode_avx2+0x150>
     cf9:	44 89 c1             	mov    %r8d,%ecx
     cfc:	b8 01 00 00 00       	mov    $0x1,%eax
     d01:	4c 89 ac 24 10 01 00 	mov    %r13,0x110(%rsp)
     d08:	00 
     d09:	4d 8d 54 24 08       	lea    0x8(%r12),%r10
     d0e:	48 d3 e0             	shl    %cl,%rax
     d11:	48 89 9c 24 f8 00 00 	mov    %rbx,0xf8(%rsp)
     d18:	00 
     d19:	49 89 c5             	mov    %rax,%r13
     d1c:	4a 8d 44 20 ff       	lea    -0x1(%rax,%r12,1),%rax
     d21:	48 d3 e8             	shr    %cl,%rax
     d24:	48 8d 58 08          	lea    0x8(%rax),%rbx
     d28:	49 39 de             	cmp    %rbx,%r14
     d2b:	0f 83 bf 00 00 00    	jae    df0 <gzram_base_encode_avx2+0x180>
     d31:	4d 39 d6             	cmp    %r10,%r14
     d34:	72 7a                	jb     db0 <gzram_base_encode_avx2+0x140>
     d36:	4d 85 e4             	test   %r12,%r12
     d39:	0f 85 41 03 00 00    	jne    1080 <gzram_base_encode_avx2+0x410>
     d3f:	c7 45 00 47 5a 52 31 	movl   $0x31525a47,0x0(%rbp)
     d46:	44 88 65 04          	mov    %r12b,0x4(%rbp)
     d4a:	c6 45 05 00          	movb   $0x0,0x5(%rbp)
     d4e:	44 88 45 06          	mov    %r8b,0x6(%rbp)
     d52:	41 8d 44 24 08       	lea    0x8(%r12),%eax
     d57:	c6 45 07 01          	movb   $0x1,0x7(%rbp)
     d5b:	48 8b 9c 24 f8 00 00 	mov    0xf8(%rsp),%rbx
     d62:	00 
     d63:	4c 8b ac 24 10 01 00 	mov    0x110(%rsp),%r13
     d6a:	00 
     d6b:	eb 55                	jmp    dc2 <gzram_base_encode_avx2+0x152>
     d6d:	0f 1f 00             	nopl   (%rax)
     d70:	4c 89 f1             	mov    %r14,%rcx
     d73:	48 89 ea             	mov    %rbp,%rdx
     d76:	4c 89 e6             	mov    %r12,%rsi
     d79:	4c 89 ff             	mov    %r15,%rdi
     d7c:	48 8b ac 24 00 01 00 	mov    0x100(%rsp),%rbp
     d83:	00 
     d84:	4c 8b a4 24 08 01 00 	mov    0x108(%rsp),%r12
     d8b:	00 
     d8c:	4c 8b b4 24 18 01 00 	mov    0x118(%rsp),%r14
     d93:	00 
     d94:	4c 8b bc 24 20 01 00 	mov    0x120(%rsp),%r15
     d9b:	00 
     d9c:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
     da3:	e9 00 00 00 00       	jmp    da8 <gzram_base_encode_avx2+0x138>
     da8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     daf:	00 
     db0:	48 8b 9c 24 f8 00 00 	mov    0xf8(%rsp),%rbx
     db7:	00 
     db8:	4c 8b ac 24 10 01 00 	mov    0x110(%rsp),%r13
     dbf:	00 
     dc0:	31 c0                	xor    %eax,%eax
     dc2:	48 8b ac 24 00 01 00 	mov    0x100(%rsp),%rbp
     dc9:	00 
     dca:	4c 8b a4 24 08 01 00 	mov    0x108(%rsp),%r12
     dd1:	00 
     dd2:	4c 8b b4 24 18 01 00 	mov    0x118(%rsp),%r14
     dd9:	00 
     dda:	4c 8b bc 24 20 01 00 	mov    0x120(%rsp),%r15
     de1:	00 
     de2:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
     de9:	c3                   	ret
     dea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     df0:	c7 45 00 47 5a 52 31 	movl   $0x31525a47,0x0(%rbp)
     df7:	66 44 89 65 04       	mov    %r12w,0x4(%rbp)
     dfc:	44 88 45 06          	mov    %r8b,0x6(%rbp)
     e00:	c6 45 07 00          	movb   $0x0,0x7(%rbp)
     e04:	48 85 c0             	test   %rax,%rax
     e07:	0f 84 e5 04 00 00    	je     12f2 <gzram_base_encode_avx2+0x682>
     e0d:	4c 8d 5d 08          	lea    0x8(%rbp),%r11
     e11:	4c 89 f9             	mov    %r15,%rcx
     e14:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
     e19:	4c 01 d8             	add    %r11,%rax
     e1c:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
     e21:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     e26:	4b 8d 04 27          	lea    (%r15,%r12,1),%rax
     e2a:	4d 89 df             	mov    %r11,%r15
     e2d:	49 89 cc             	mov    %rcx,%r12
     e30:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
     e35:	4d 89 ee             	mov    %r13,%r14
     e38:	49 89 dd             	mov    %rbx,%r13
     e3b:	48 89 04 24          	mov    %rax,(%rsp)
     e3f:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
     e44:	4c 89 5c 24 40       	mov    %r11,0x40(%rsp)
     e49:	44 89 44 24 3c       	mov    %r8d,0x3c(%rsp)
     e4e:	eb 3a                	jmp    e8a <gzram_base_encode_avx2+0x21a>
     e50:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
     e55:	4c 29 e8             	sub    %r13,%rax
     e58:	48 39 d8             	cmp    %rbx,%rax
     e5b:	0f 82 af 01 00 00    	jb     1010 <gzram_base_encode_avx2+0x3a0>
     e61:	41 c6 07 00          	movb   $0x0,(%r15)
     e65:	4a 8d 7c 2d 00       	lea    0x0(%rbp,%r13,1),%rdi
     e6a:	48 89 da             	mov    %rbx,%rdx
     e6d:	4c 89 e6             	mov    %r12,%rsi
     e70:	49 01 dd             	add    %rbx,%r13
     e73:	e8 00 00 00 00       	call   e78 <gzram_base_encode_avx2+0x208>
     e78:	4d 01 f4             	add    %r14,%r12
     e7b:	49 83 c7 01          	add    $0x1,%r15
     e7f:	4c 39 7c 24 08       	cmp    %r15,0x8(%rsp)
     e84:	0f 84 3e 01 00 00    	je     fc8 <gzram_base_encode_avx2+0x358>
     e8a:	48 8b 1c 24          	mov    (%rsp),%rbx
     e8e:	4c 29 e3             	sub    %r12,%rbx
     e91:	4c 39 f3             	cmp    %r14,%rbx
     e94:	49 0f 47 de          	cmova  %r14,%rbx
     e98:	f6 c3 1f             	test   $0x1f,%bl
     e9b:	75 b3                	jne    e50 <gzram_base_encode_avx2+0x1e0>
     e9d:	48 8d 54 24 68       	lea    0x68(%rsp),%rdx
     ea2:	48 89 de             	mov    %rbx,%rsi
     ea5:	4c 89 e7             	mov    %r12,%rdi
     ea8:	e8 03 f3 ff ff       	call   1b0 <scan_avx2>
     ead:	8b 84 24 e8 00 00 00 	mov    0xe8(%rsp),%eax
     eb4:	85 c0                	test   %eax,%eax
     eb6:	75 08                	jne    ec0 <gzram_base_encode_avx2+0x250>
     eb8:	41 c6 07 01          	movb   $0x1,(%r15)
     ebc:	eb ba                	jmp    e78 <gzram_base_encode_avx2+0x208>
     ebe:	66 90                	xchg   %ax,%ax
     ec0:	8b 94 24 ec 00 00 00 	mov    0xec(%rsp),%edx
     ec7:	f6 c2 01             	test   $0x1,%dl
     eca:	0f 84 d0 00 00 00    	je     fa0 <gzram_base_encode_avx2+0x330>
     ed0:	48 83 fb 04          	cmp    $0x4,%rbx
     ed4:	76 8b                	jbe    e61 <gzram_base_encode_avx2+0x1f1>
     ed6:	ba 02 00 00 00       	mov    $0x2,%edx
     edb:	b8 04 00 00 00       	mov    $0x4,%eax
     ee0:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     ee5:	4c 29 ee             	sub    %r13,%rsi
     ee8:	48 39 c6             	cmp    %rax,%rsi
     eeb:	0f 82 1f 01 00 00    	jb     1010 <gzram_base_encode_avx2+0x3a0>
     ef1:	41 88 17             	mov    %dl,(%r15)
     ef4:	4a 8d 7c 2d 00       	lea    0x0(%rbp,%r13,1),%rdi
     ef9:	89 c2                	mov    %eax,%edx
     efb:	83 f8 20             	cmp    $0x20,%eax
     efe:	73 30                	jae    f30 <gzram_base_encode_avx2+0x2c0>
     f00:	a8 10                	test   $0x10,%al
     f02:	0f 85 94 01 00 00    	jne    109c <gzram_base_encode_avx2+0x42c>
     f08:	a8 08                	test   $0x8,%al
     f0a:	0f 85 88 03 00 00    	jne    1298 <gzram_base_encode_avx2+0x628>
     f10:	a8 04                	test   $0x4,%al
     f12:	0f 85 96 03 00 00    	jne    12ae <gzram_base_encode_avx2+0x63e>
     f18:	85 c0                	test   %eax,%eax
     f1a:	74 07                	je     f23 <gzram_base_encode_avx2+0x2b3>
     f1c:	41 0f b6 14 24       	movzbl (%r12),%edx
     f21:	88 17                	mov    %dl,(%rdi)
     f23:	49 01 c5             	add    %rax,%r13
     f26:	e9 4d ff ff ff       	jmp    e78 <gzram_base_encode_avx2+0x208>
     f2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     f30:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
     f34:	8d 50 ff             	lea    -0x1(%rax),%edx
     f37:	4c 8b 56 e0          	mov    -0x20(%rsi),%r10
     f3b:	4c 89 54 38 e0       	mov    %r10,-0x20(%rax,%rdi,1)
     f40:	4c 8b 56 e8          	mov    -0x18(%rsi),%r10
     f44:	4c 89 54 38 e8       	mov    %r10,-0x18(%rax,%rdi,1)
     f49:	4c 8b 56 f0          	mov    -0x10(%rsi),%r10
     f4d:	4c 89 54 38 f0       	mov    %r10,-0x10(%rax,%rdi,1)
     f52:	48 8b 76 f8          	mov    -0x8(%rsi),%rsi
     f56:	48 89 74 38 f8       	mov    %rsi,-0x8(%rax,%rdi,1)
     f5b:	83 fa 20             	cmp    $0x20,%edx
     f5e:	72 c3                	jb     f23 <gzram_base_encode_avx2+0x2b3>
     f60:	83 e2 e0             	and    $0xffffffe0,%edx
     f63:	45 31 d2             	xor    %r10d,%r10d
     f66:	44 89 d1             	mov    %r10d,%ecx
     f69:	41 83 c2 20          	add    $0x20,%r10d
     f6d:	4d 8b 1c 0c          	mov    (%r12,%rcx,1),%r11
     f71:	4d 8b 4c 0c 08       	mov    0x8(%r12,%rcx,1),%r9
     f76:	4d 8b 44 0c 10       	mov    0x10(%r12,%rcx,1),%r8
     f7b:	49 8b 74 0c 18       	mov    0x18(%r12,%rcx,1),%rsi
     f80:	4c 89 1c 0f          	mov    %r11,(%rdi,%rcx,1)
     f84:	4c 89 4c 0f 08       	mov    %r9,0x8(%rdi,%rcx,1)
     f89:	4c 89 44 0f 10       	mov    %r8,0x10(%rdi,%rcx,1)
     f8e:	48 89 74 0f 18       	mov    %rsi,0x18(%rdi,%rcx,1)
     f93:	41 39 d2             	cmp    %edx,%r10d
     f96:	72 ce                	jb     f66 <gzram_base_encode_avx2+0x2f6>
     f98:	eb 89                	jmp    f23 <gzram_base_encode_avx2+0x2b3>
     f9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     fa0:	f6 c2 02             	test   $0x2,%dl
     fa3:	0f 84 af 00 00 00    	je     1058 <gzram_base_encode_avx2+0x3e8>
     fa9:	48 83 fb 08          	cmp    $0x8,%rbx
     fad:	0f 86 ae fe ff ff    	jbe    e61 <gzram_base_encode_avx2+0x1f1>
     fb3:	ba 03 00 00 00       	mov    $0x3,%edx
     fb8:	b8 08 00 00 00       	mov    $0x8,%eax
     fbd:	e9 1e ff ff ff       	jmp    ee0 <gzram_base_encode_avx2+0x270>
     fc2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     fc8:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
     fcd:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
     fd2:	4c 89 eb             	mov    %r13,%rbx
     fd5:	4c 8b 64 24 30       	mov    0x30(%rsp),%r12
     fda:	44 8b 44 24 3c       	mov    0x3c(%rsp),%r8d
     fdf:	4d 39 d5             	cmp    %r10,%r13
     fe2:	0f 83 e3 00 00 00    	jae    10cb <gzram_base_encode_avx2+0x45b>
     fe8:	89 d8                	mov    %ebx,%eax
     fea:	4c 8b ac 24 10 01 00 	mov    0x110(%rsp),%r13
     ff1:	00 
     ff2:	48 8b 9c 24 f8 00 00 	mov    0xf8(%rsp),%rbx
     ff9:	00 
     ffa:	e9 c3 fd ff ff       	jmp    dc2 <gzram_base_encode_avx2+0x152>
     fff:	48 39 de             	cmp    %rbx,%rsi
    1002:	0f 83 59 fe ff ff    	jae    e61 <gzram_base_encode_avx2+0x1f1>
    1008:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    100f:	00 
    1010:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
    1015:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    101a:	31 c0                	xor    %eax,%eax
    101c:	4c 8b 5c 24 40       	mov    0x40(%rsp),%r11
    1021:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    1026:	4c 8b 64 24 30       	mov    0x30(%rsp),%r12
    102b:	44 8b 44 24 3c       	mov    0x3c(%rsp),%r8d
    1030:	4d 39 d6             	cmp    %r10,%r14
    1033:	0f 82 89 02 00 00    	jb     12c2 <gzram_base_encode_avx2+0x652>
    1039:	4d 85 e4             	test   %r12,%r12
    103c:	0f 85 95 02 00 00    	jne    12d7 <gzram_base_encode_avx2+0x667>
    1042:	c7 45 00 47 5a 52 31 	movl   $0x31525a47,0x0(%rbp)
    1049:	66 44 89 65 04       	mov    %r12w,0x4(%rbp)
    104e:	e9 fb fc ff ff       	jmp    d4e <gzram_base_encode_avx2+0xde>
    1053:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1058:	f6 c2 04             	test   $0x4,%dl
    105b:	0f 84 9a 00 00 00    	je     10fb <gzram_base_encode_avx2+0x48b>
    1061:	48 83 fb 10          	cmp    $0x10,%rbx
    1065:	0f 86 f6 fd ff ff    	jbe    e61 <gzram_base_encode_avx2+0x1f1>
    106b:	ba 05 00 00 00       	mov    $0x5,%edx
    1070:	b8 10 00 00 00       	mov    $0x10,%eax
    1075:	e9 66 fe ff ff       	jmp    ee0 <gzram_base_encode_avx2+0x270>
    107a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1080:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
    1084:	4c 89 e2             	mov    %r12,%rdx
    1087:	4c 89 fe             	mov    %r15,%rsi
    108a:	44 89 04 24          	mov    %r8d,(%rsp)
    108e:	e8 00 00 00 00       	call   1093 <gzram_base_encode_avx2+0x423>
    1093:	44 8b 04 24          	mov    (%rsp),%r8d
    1097:	e9 a3 fc ff ff       	jmp    d3f <gzram_base_encode_avx2+0xcf>
    109c:	49 8b 34 24          	mov    (%r12),%rsi
    10a0:	48 89 37             	mov    %rsi,(%rdi)
    10a3:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    10a8:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    10ac:	48 8d 74 17 10       	lea    0x10(%rdi,%rdx,1),%rsi
    10b1:	49 8d 54 14 10       	lea    0x10(%r12,%rdx,1),%rdx
    10b6:	48 8b 7a e0          	mov    -0x20(%rdx),%rdi
    10ba:	48 89 7e e0          	mov    %rdi,-0x20(%rsi)
    10be:	48 8b 52 e8          	mov    -0x18(%rdx),%rdx
    10c2:	48 89 56 e8          	mov    %rdx,-0x18(%rsi)
    10c6:	e9 58 fe ff ff       	jmp    f23 <gzram_base_encode_avx2+0x2b3>
    10cb:	4c 39 54 24 10       	cmp    %r10,0x10(%rsp)
    10d0:	0f 82 da fc ff ff    	jb     db0 <gzram_base_encode_avx2+0x140>
    10d6:	4d 85 e4             	test   %r12,%r12
    10d9:	0f 84 63 ff ff ff    	je     1042 <gzram_base_encode_avx2+0x3d2>
    10df:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
    10e3:	4c 89 e2             	mov    %r12,%rdx
    10e6:	4c 89 fe             	mov    %r15,%rsi
    10e9:	44 89 04 24          	mov    %r8d,(%rsp)
    10ed:	e8 00 00 00 00       	call   10f2 <gzram_base_encode_avx2+0x482>
    10f2:	44 8b 04 24          	mov    (%rsp),%r8d
    10f6:	e9 47 ff ff ff       	jmp    1042 <gzram_base_encode_avx2+0x3d2>
    10fb:	83 e2 08             	and    $0x8,%edx
    10fe:	74 0a                	je     110a <gzram_base_encode_avx2+0x49a>
    1100:	48 83 fb 20          	cmp    $0x20,%rbx
    1104:	0f 87 fc 01 00 00    	ja     1306 <gzram_base_encode_avx2+0x696>
    110a:	48 89 d9             	mov    %rbx,%rcx
    110d:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    1112:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
    1119:	48 c1 e9 05          	shr    $0x5,%rcx
    111d:	48 01 ca             	add    %rcx,%rdx
    1120:	4c 29 ee             	sub    %r13,%rsi
    1123:	48 39 da             	cmp    %rbx,%rdx
    1126:	0f 83 d3 fe ff ff    	jae    fff <gzram_base_encode_avx2+0x38f>
    112c:	48 39 d6             	cmp    %rdx,%rsi
    112f:	0f 82 db fe ff ff    	jb     1010 <gzram_base_encode_avx2+0x3a0>
    1135:	41 c6 07 04          	movb   $0x4,(%r15)
    1139:	4a 8d 5c 2d 00       	lea    0x0(%rbp,%r13,1),%rbx
    113e:	83 f9 20             	cmp    $0x20,%ecx
    1141:	0f 83 d9 00 00 00    	jae    1220 <gzram_base_encode_avx2+0x5b0>
    1147:	f6 c1 10             	test   $0x10,%cl
    114a:	0f 85 c5 01 00 00    	jne    1315 <gzram_base_encode_avx2+0x6a5>
    1150:	f6 c1 08             	test   $0x8,%cl
    1153:	0f 85 ee 01 00 00    	jne    1347 <gzram_base_encode_avx2+0x6d7>
    1159:	f6 c1 04             	test   $0x4,%cl
    115c:	0f 85 fe 01 00 00    	jne    1360 <gzram_base_encode_avx2+0x6f0>
    1162:	85 c9                	test   %ecx,%ecx
    1164:	74 10                	je     1176 <gzram_base_encode_avx2+0x506>
    1166:	0f b6 54 24 68       	movzbl 0x68(%rsp),%edx
    116b:	88 13                	mov    %dl,(%rbx)
    116d:	f6 c1 02             	test   $0x2,%cl
    1170:	0f 85 ff 01 00 00    	jne    1375 <gzram_base_encode_avx2+0x705>
    1176:	89 c0                	mov    %eax,%eax
    1178:	48 8d 34 49          	lea    (%rcx,%rcx,2),%rsi
    117c:	48 8d 15 7d ee ff ff 	lea    -0x1183(%rip),%rdx        # 0 <pack_avx2>
    1183:	49 01 cd             	add    %rcx,%r13
    1186:	48 39 c6             	cmp    %rax,%rsi
    1189:	48 8d 05 c0 f1 ff ff 	lea    -0xe40(%rip),%rax        # 350 <pack_scalar>
    1190:	48 0f 43 d0          	cmovae %rax,%rdx
    1194:	48 85 c9             	test   %rcx,%rcx
    1197:	0f 84 db fc ff ff    	je     e78 <gzram_base_encode_avx2+0x208>
    119d:	48 c1 e1 05          	shl    $0x5,%rcx
    11a1:	4c 89 74 24 48       	mov    %r14,0x48(%rsp)
    11a6:	48 89 d3             	mov    %rdx,%rbx
    11a9:	4d 89 ee             	mov    %r13,%r14
    11ac:	4c 01 e1             	add    %r12,%rcx
    11af:	4c 89 7c 24 50       	mov    %r15,0x50(%rsp)
    11b4:	4d 89 e5             	mov    %r12,%r13
    11b7:	4c 8d 7c 24 68       	lea    0x68(%rsp),%r15
    11bc:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
    11c1:	4c 89 64 24 58       	mov    %r12,0x58(%rsp)
    11c6:	49 89 ec             	mov    %rbp,%r12
    11c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    11d0:	41 0f b6 2f          	movzbl (%r15),%ebp
    11d4:	4b 8d 34 34          	lea    (%r12,%r14,1),%rsi
    11d8:	4c 89 ef             	mov    %r13,%rdi
    11db:	49 83 c7 01          	add    $0x1,%r15
    11df:	49 83 c5 20          	add    $0x20,%r13
    11e3:	89 ea                	mov    %ebp,%edx
    11e5:	ff d3                	call   *%rbx
    11e7:	89 ea                	mov    %ebp,%edx
    11e9:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 11f0 <gzram_base_encode_avx2+0x580>
    11f0:	0f b6 14 10          	movzbl (%rax,%rdx,1),%edx
    11f4:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
    11fb:	49 01 d6             	add    %rdx,%r14
    11fe:	4c 3b 6c 24 18       	cmp    0x18(%rsp),%r13
    1203:	75 cb                	jne    11d0 <gzram_base_encode_avx2+0x560>
    1205:	4d 89 f5             	mov    %r14,%r13
    1208:	4c 89 e5             	mov    %r12,%rbp
    120b:	4c 8b 74 24 48       	mov    0x48(%rsp),%r14
    1210:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    1215:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
    121a:	e9 59 fc ff ff       	jmp    e78 <gzram_base_encode_avx2+0x208>
    121f:	90                   	nop
    1220:	89 ca                	mov    %ecx,%edx
    1222:	48 8d 34 13          	lea    (%rbx,%rdx,1),%rsi
    1226:	48 8d 54 14 68       	lea    0x68(%rsp,%rdx,1),%rdx
    122b:	48 8b 7a e0          	mov    -0x20(%rdx),%rdi
    122f:	48 89 7e e0          	mov    %rdi,-0x20(%rsi)
    1233:	48 8b 7a e8          	mov    -0x18(%rdx),%rdi
    1237:	48 89 7e e8          	mov    %rdi,-0x18(%rsi)
    123b:	48 8b 7a f0          	mov    -0x10(%rdx),%rdi
    123f:	48 89 7e f0          	mov    %rdi,-0x10(%rsi)
    1243:	48 8b 52 f8          	mov    -0x8(%rdx),%rdx
    1247:	48 89 56 f8          	mov    %rdx,-0x8(%rsi)
    124b:	8d 51 ff             	lea    -0x1(%rcx),%edx
    124e:	83 fa 20             	cmp    $0x20,%edx
    1251:	0f 82 1f ff ff ff    	jb     1176 <gzram_base_encode_avx2+0x506>
    1257:	83 e2 e0             	and    $0xffffffe0,%edx
    125a:	31 f6                	xor    %esi,%esi
    125c:	41 89 d0             	mov    %edx,%r8d
    125f:	89 f2                	mov    %esi,%edx
    1261:	83 c6 20             	add    $0x20,%esi
    1264:	4c 8b 5c 14 68       	mov    0x68(%rsp,%rdx,1),%r11
    1269:	4c 8b 54 14 70       	mov    0x70(%rsp,%rdx,1),%r10
    126e:	4c 8b 4c 14 78       	mov    0x78(%rsp,%rdx,1),%r9
    1273:	48 8b bc 14 80 00 00 	mov    0x80(%rsp,%rdx,1),%rdi
    127a:	00 
    127b:	4c 89 1c 13          	mov    %r11,(%rbx,%rdx,1)
    127f:	4c 89 54 13 08       	mov    %r10,0x8(%rbx,%rdx,1)
    1284:	4c 89 4c 13 10       	mov    %r9,0x10(%rbx,%rdx,1)
    1289:	48 89 7c 13 18       	mov    %rdi,0x18(%rbx,%rdx,1)
    128e:	44 39 c6             	cmp    %r8d,%esi
    1291:	72 cc                	jb     125f <gzram_base_encode_avx2+0x5ef>
    1293:	e9 de fe ff ff       	jmp    1176 <gzram_base_encode_avx2+0x506>
    1298:	49 8b 34 24          	mov    (%r12),%rsi
    129c:	48 89 37             	mov    %rsi,(%rdi)
    129f:	49 8b 74 14 f8       	mov    -0x8(%r12,%rdx,1),%rsi
    12a4:	48 89 74 17 f8       	mov    %rsi,-0x8(%rdi,%rdx,1)
    12a9:	e9 75 fc ff ff       	jmp    f23 <gzram_base_encode_avx2+0x2b3>
    12ae:	41 8b 34 24          	mov    (%r12),%esi
    12b2:	89 37                	mov    %esi,(%rdi)
    12b4:	41 8b 74 14 fc       	mov    -0x4(%r12,%rdx,1),%esi
    12b9:	89 74 17 fc          	mov    %esi,-0x4(%rdi,%rdx,1)
    12bd:	e9 61 fc ff ff       	jmp    f23 <gzram_base_encode_avx2+0x2b3>
    12c2:	48 8b 9c 24 f8 00 00 	mov    0xf8(%rsp),%rbx
    12c9:	00 
    12ca:	4c 8b ac 24 10 01 00 	mov    0x110(%rsp),%r13
    12d1:	00 
    12d2:	e9 eb fa ff ff       	jmp    dc2 <gzram_base_encode_avx2+0x152>
    12d7:	4c 89 e2             	mov    %r12,%rdx
    12da:	4c 89 fe             	mov    %r15,%rsi
    12dd:	4c 89 df             	mov    %r11,%rdi
    12e0:	44 89 04 24          	mov    %r8d,(%rsp)
    12e4:	e8 00 00 00 00       	call   12e9 <gzram_base_encode_avx2+0x679>
    12e9:	44 8b 04 24          	mov    (%rsp),%r8d
    12ed:	e9 50 fd ff ff       	jmp    1042 <gzram_base_encode_avx2+0x3d2>
    12f2:	bb 08 00 00 00       	mov    $0x8,%ebx
    12f7:	49 83 fa 08          	cmp    $0x8,%r10
    12fb:	0f 85 e7 fc ff ff    	jne    fe8 <gzram_base_encode_avx2+0x378>
    1301:	e9 d0 fd ff ff       	jmp    10d6 <gzram_base_encode_avx2+0x466>
    1306:	ba 06 00 00 00       	mov    $0x6,%edx
    130b:	b8 20 00 00 00       	mov    $0x20,%eax
    1310:	e9 cb fb ff ff       	jmp    ee0 <gzram_base_encode_avx2+0x270>
    1315:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
    131a:	89 ce                	mov    %ecx,%esi
    131c:	48 89 13             	mov    %rdx,(%rbx)
    131f:	48 8b 54 24 70       	mov    0x70(%rsp),%rdx
    1324:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    1328:	48 8d 54 33 10       	lea    0x10(%rbx,%rsi,1),%rdx
    132d:	48 8d 74 34 78       	lea    0x78(%rsp,%rsi,1),%rsi
    1332:	48 8b 7e e0          	mov    -0x20(%rsi),%rdi
    1336:	48 89 7a e0          	mov    %rdi,-0x20(%rdx)
    133a:	48 8b 76 e8          	mov    -0x18(%rsi),%rsi
    133e:	48 89 72 e8          	mov    %rsi,-0x18(%rdx)
    1342:	e9 2f fe ff ff       	jmp    1176 <gzram_base_encode_avx2+0x506>
    1347:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
    134c:	48 89 13             	mov    %rdx,(%rbx)
    134f:	89 ca                	mov    %ecx,%edx
    1351:	48 8b 74 14 60       	mov    0x60(%rsp,%rdx,1),%rsi
    1356:	48 89 74 13 f8       	mov    %rsi,-0x8(%rbx,%rdx,1)
    135b:	e9 16 fe ff ff       	jmp    1176 <gzram_base_encode_avx2+0x506>
    1360:	8b 54 24 68          	mov    0x68(%rsp),%edx
    1364:	89 13                	mov    %edx,(%rbx)
    1366:	89 ca                	mov    %ecx,%edx
    1368:	8b 74 14 64          	mov    0x64(%rsp,%rdx,1),%esi
    136c:	89 74 13 fc          	mov    %esi,-0x4(%rbx,%rdx,1)
    1370:	e9 01 fe ff ff       	jmp    1176 <gzram_base_encode_avx2+0x506>
    1375:	89 ca                	mov    %ecx,%edx
    1377:	0f b7 74 14 66       	movzwl 0x66(%rsp,%rdx,1),%esi
    137c:	66 89 74 13 fe       	mov    %si,-0x2(%rbx,%rdx,1)
    1381:	e9 f0 fd ff ff       	jmp    1176 <gzram_base_encode_avx2+0x506>
    1386:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    138d:	00 00 00 

0000000000001390 <gzram_base_decode_scalar>:
    1390:	48 89 c8             	mov    %rcx,%rax
    1393:	48 8d 4e f8          	lea    -0x8(%rsi),%rcx
    1397:	48 81 f9 00 10 00 00 	cmp    $0x1000,%rcx
    139e:	0f 87 9b 06 00 00    	ja     1a3f <gzram_base_decode_scalar+0x6af>
    13a4:	48 85 ff             	test   %rdi,%rdi
    13a7:	0f 84 92 06 00 00    	je     1a3f <gzram_base_decode_scalar+0x6af>
    13ad:	81 3f 47 5a 52 31    	cmpl   $0x31525a47,(%rdi)
    13b3:	0f 85 86 06 00 00    	jne    1a3f <gzram_base_decode_scalar+0x6af>
    13b9:	0f b6 4f 06          	movzbl 0x6(%rdi),%ecx
    13bd:	44 8d 41 fb          	lea    -0x5(%rcx),%r8d
    13c1:	41 80 f8 07          	cmp    $0x7,%r8b
    13c5:	0f 87 74 06 00 00    	ja     1a3f <gzram_base_decode_scalar+0x6af>
    13cb:	44 0f b6 4f 07       	movzbl 0x7(%rdi),%r9d
    13d0:	41 80 f9 01          	cmp    $0x1,%r9b
    13d4:	0f 87 65 06 00 00    	ja     1a3f <gzram_base_decode_scalar+0x6af>
    13da:	41 ba 00 10 00 00    	mov    $0x1000,%r10d
    13e0:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
    13e7:	4c 39 d0             	cmp    %r10,%rax
    13ea:	48 89 5c 24 78       	mov    %rbx,0x78(%rsp)
    13ef:	44 0f b7 47 04       	movzwl 0x4(%rdi),%r8d
    13f4:	49 0f 47 c2          	cmova  %r10,%rax
    13f8:	4c 89 c3             	mov    %r8,%rbx
    13fb:	4c 39 c0             	cmp    %r8,%rax
    13fe:	0f 82 d6 04 00 00    	jb     18da <gzram_base_decode_scalar+0x54a>
    1404:	48 85 d2             	test   %rdx,%rdx
    1407:	75 09                	jne    1412 <gzram_base_decode_scalar+0x82>
    1409:	4d 85 c0             	test   %r8,%r8
    140c:	0f 85 c8 04 00 00    	jne    18da <gzram_base_decode_scalar+0x54a>
    1412:	4c 89 b4 24 98 00 00 	mov    %r14,0x98(%rsp)
    1419:	00 
    141a:	49 89 d6             	mov    %rdx,%r14
    141d:	4c 89 a4 24 88 00 00 	mov    %r12,0x88(%rsp)
    1424:	00 
    1425:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
    142a:	45 84 c9             	test   %r9b,%r9b
    142d:	0f 85 9d 00 00 00    	jne    14d0 <gzram_base_decode_scalar+0x140>
    1433:	ba 01 00 00 00       	mov    $0x1,%edx
    1438:	4c 89 bc 24 a0 00 00 	mov    %r15,0xa0(%rsp)
    143f:	00 
    1440:	48 d3 e2             	shl    %cl,%rdx
    1443:	49 89 d7             	mov    %rdx,%r15
    1446:	49 8d 54 10 ff       	lea    -0x1(%r8,%rdx,1),%rdx
    144b:	48 d3 ea             	shr    %cl,%rdx
    144e:	4c 8d 52 08          	lea    0x8(%rdx),%r10
    1452:	4c 39 54 24 38       	cmp    %r10,0x38(%rsp)
    1457:	0f 82 f3 05 00 00    	jb     1a50 <gzram_base_decode_scalar+0x6c0>
    145d:	48 85 d2             	test   %rdx,%rdx
    1460:	0f 84 df 05 00 00    	je     1a45 <gzram_base_decode_scalar+0x6b5>
    1466:	4c 89 ac 24 90 00 00 	mov    %r13,0x90(%rsp)
    146d:	00 
    146e:	4c 8d 6f 08          	lea    0x8(%rdi),%r13
    1472:	4d 89 f9             	mov    %r15,%r9
    1475:	4a 8d 04 2a          	lea    (%rdx,%r13,1),%rax
    1479:	66 89 5c 24 6e       	mov    %bx,0x6e(%rsp)
    147e:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    1483:	4b 8d 04 06          	lea    (%r14,%r8,1),%rax
    1487:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    148c:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    1491:	48 89 ac 24 80 00 00 	mov    %rbp,0x80(%rsp)
    1498:	00 
    1499:	4c 89 d5             	mov    %r10,%rbp
    149c:	0f 1f 40 00          	nopl   0x0(%rax)
    14a0:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
    14a5:	4c 29 f3             	sub    %r14,%rbx
    14a8:	4c 39 cb             	cmp    %r9,%rbx
    14ab:	49 0f 47 d9          	cmova  %r9,%rbx
    14af:	41 80 7d 00 06       	cmpb   $0x6,0x0(%r13)
    14b4:	0f 87 f8 03 00 00    	ja     18b2 <gzram_base_decode_scalar+0x522>
    14ba:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
    14bf:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 14c6 <gzram_base_decode_scalar+0x136>
    14c6:	48 63 04 87          	movslq (%rdi,%rax,4),%rax
    14ca:	48 01 f8             	add    %rdi,%rax
    14cd:	ff e0                	jmp    *%rax
    14cf:	90                   	nop
    14d0:	49 8d 50 08          	lea    0x8(%r8),%rdx
    14d4:	48 39 d6             	cmp    %rdx,%rsi
    14d7:	0f 85 4d 05 00 00    	jne    1a2a <gzram_base_decode_scalar+0x69a>
    14dd:	4d 85 c0             	test   %r8,%r8
    14e0:	0f 85 30 05 00 00    	jne    1a16 <gzram_base_decode_scalar+0x686>
    14e6:	0f b7 c3             	movzwl %bx,%eax
    14e9:	4c 8b a4 24 88 00 00 	mov    0x88(%rsp),%r12
    14f0:	00 
    14f1:	4c 8b b4 24 98 00 00 	mov    0x98(%rsp),%r14
    14f8:	00 
    14f9:	48 8b 5c 24 78       	mov    0x78(%rsp),%rbx
    14fe:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
    1505:	c3                   	ret
    1506:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    150d:	00 00 00 
    1510:	b9 08 00 00 00       	mov    $0x8,%ecx
    1515:	48 89 d8             	mov    %rbx,%rax
    1518:	31 d2                	xor    %edx,%edx
    151a:	48 f7 f1             	div    %rcx
    151d:	48 85 d2             	test   %rdx,%rdx
    1520:	0f 85 8c 03 00 00    	jne    18b2 <gzram_base_decode_scalar+0x522>
    1526:	48 39 cb             	cmp    %rcx,%rbx
    1529:	0f 82 83 03 00 00    	jb     18b2 <gzram_base_decode_scalar+0x522>
    152f:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    1534:	48 29 e8             	sub    %rbp,%rax
    1537:	48 39 c8             	cmp    %rcx,%rax
    153a:	0f 82 72 03 00 00    	jb     18b2 <gzram_base_decode_scalar+0x522>
    1540:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    1545:	44 8d 51 ff          	lea    -0x1(%rcx),%r10d
    1549:	89 ce                	mov    %ecx,%esi
    154b:	89 4c 24 68          	mov    %ecx,0x68(%rsp)
    154f:	4c 89 4c 24 58       	mov    %r9,0x58(%rsp)
    1554:	41 89 cb             	mov    %ecx,%r11d
    1557:	41 89 cf             	mov    %ecx,%r15d
    155a:	83 e6 04             	and    $0x4,%esi
    155d:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
    1561:	44 89 d0             	mov    %r10d,%eax
    1564:	48 89 6c 24 60       	mov    %rbp,0x60(%rsp)
    1569:	41 89 cc             	mov    %ecx,%r12d
    156c:	83 e0 e0             	and    $0xffffffe0,%eax
    156f:	4c 8d 04 0f          	lea    (%rdi,%rcx,1),%r8
    1573:	41 83 e3 10          	and    $0x10,%r11d
    1577:	41 83 e7 08          	and    $0x8,%r15d
    157b:	89 44 24 08          	mov    %eax,0x8(%rsp)
    157f:	89 c8                	mov    %ecx,%eax
    1581:	89 f5                	mov    %esi,%ebp
    1583:	83 e0 02             	and    $0x2,%eax
    1586:	89 44 24 4c          	mov    %eax,0x4c(%rsp)
    158a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1590:	49 8d 04 16          	lea    (%r14,%rdx,1),%rax
    1594:	83 f9 20             	cmp    $0x20,%ecx
    1597:	0f 83 53 03 00 00    	jae    18f0 <gzram_base_decode_scalar+0x560>
    159d:	45 85 db             	test   %r11d,%r11d
    15a0:	0f 85 f2 03 00 00    	jne    1998 <gzram_base_decode_scalar+0x608>
    15a6:	45 85 ff             	test   %r15d,%r15d
    15a9:	0f 85 21 04 00 00    	jne    19d0 <gzram_base_decode_scalar+0x640>
    15af:	85 ed                	test   %ebp,%ebp
    15b1:	0f 85 39 04 00 00    	jne    19f0 <gzram_base_decode_scalar+0x660>
    15b7:	85 c9                	test   %ecx,%ecx
    15b9:	74 12                	je     15cd <gzram_base_decode_scalar+0x23d>
    15bb:	0f b6 37             	movzbl (%rdi),%esi
    15be:	40 88 30             	mov    %sil,(%rax)
    15c1:	8b 74 24 4c          	mov    0x4c(%rsp),%esi
    15c5:	85 f6                	test   %esi,%esi
    15c7:	0f 85 3a 04 00 00    	jne    1a07 <gzram_base_decode_scalar+0x677>
    15cd:	48 01 ca             	add    %rcx,%rdx
    15d0:	48 39 da             	cmp    %rbx,%rdx
    15d3:	72 bb                	jb     1590 <gzram_base_decode_scalar+0x200>
    15d5:	48 8b 6c 24 60       	mov    0x60(%rsp),%rbp
    15da:	4c 8b 4c 24 58       	mov    0x58(%rsp),%r9
    15df:	48 01 cd             	add    %rcx,%rbp
    15e2:	49 83 c5 01          	add    $0x1,%r13
    15e6:	4d 01 ce             	add    %r9,%r14
    15e9:	4c 39 6c 24 50       	cmp    %r13,0x50(%rsp)
    15ee:	0f 85 ac fe ff ff    	jne    14a0 <gzram_base_decode_scalar+0x110>
    15f4:	49 89 ea             	mov    %rbp,%r10
    15f7:	0f b7 5c 24 6e       	movzwl 0x6e(%rsp),%ebx
    15fc:	48 8b ac 24 80 00 00 	mov    0x80(%rsp),%rbp
    1603:	00 
    1604:	4c 8b ac 24 90 00 00 	mov    0x90(%rsp),%r13
    160b:	00 
    160c:	4c 39 54 24 38       	cmp    %r10,0x38(%rsp)
    1611:	0f 85 39 04 00 00    	jne    1a50 <gzram_base_decode_scalar+0x6c0>
    1617:	0f b7 c3             	movzwl %bx,%eax
    161a:	4c 8b a4 24 88 00 00 	mov    0x88(%rsp),%r12
    1621:	00 
    1622:	4c 8b b4 24 98 00 00 	mov    0x98(%rsp),%r14
    1629:	00 
    162a:	4c 8b bc 24 a0 00 00 	mov    0xa0(%rsp),%r15
    1631:	00 
    1632:	48 8b 5c 24 78       	mov    0x78(%rsp),%rbx
    1637:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
    163e:	c3                   	ret
    163f:	90                   	nop
    1640:	b9 04 00 00 00       	mov    $0x4,%ecx
    1645:	e9 cb fe ff ff       	jmp    1515 <gzram_base_decode_scalar+0x185>
    164a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1650:	48 89 da             	mov    %rbx,%rdx
    1653:	31 f6                	xor    %esi,%esi
    1655:	4c 89 f7             	mov    %r14,%rdi
    1658:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    165d:	e8 00 00 00 00       	call   1662 <gzram_base_decode_scalar+0x2d2>
    1662:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    1667:	e9 76 ff ff ff       	jmp    15e2 <gzram_base_decode_scalar+0x252>
    166c:	0f 1f 40 00          	nopl   0x0(%rax)
    1670:	b9 10 00 00 00       	mov    $0x10,%ecx
    1675:	e9 9b fe ff ff       	jmp    1515 <gzram_base_decode_scalar+0x185>
    167a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1680:	48 89 d8             	mov    %rbx,%rax
    1683:	83 e0 1f             	and    $0x1f,%eax
    1686:	0f 85 26 02 00 00    	jne    18b2 <gzram_base_decode_scalar+0x522>
    168c:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
    1691:	48 c1 eb 05          	shr    $0x5,%rbx
    1695:	48 29 ea             	sub    %rbp,%rdx
    1698:	48 39 da             	cmp    %rbx,%rdx
    169b:	0f 82 11 02 00 00    	jb     18b2 <gzram_base_decode_scalar+0x522>
    16a1:	48 8d 34 2b          	lea    (%rbx,%rbp,1),%rsi
    16a5:	48 85 db             	test   %rbx,%rbx
    16a8:	0f 84 b0 01 00 00    	je     185e <gzram_base_decode_scalar+0x4ce>
    16ae:	48 03 6c 24 10       	add    0x10(%rsp),%rbp
    16b3:	4c 8d 05 00 00 00 00 	lea    0x0(%rip),%r8        # 16ba <gzram_base_decode_scalar+0x32a>
    16ba:	48 8d 3c 2b          	lea    (%rbx,%rbp,1),%rdi
    16be:	48 89 ea             	mov    %rbp,%rdx
    16c1:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    16c8:	00 00 
    16ca:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    16d1:	00 00 00 00 
    16d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    16dc:	00 00 00 00 
    16e0:	0f b6 0a             	movzbl (%rdx),%ecx
    16e3:	48 83 c2 01          	add    $0x1,%rdx
    16e7:	41 0f b6 0c 08       	movzbl (%r8,%rcx,1),%ecx
    16ec:	8d 0c 8d 00 00 00 00 	lea    0x0(,%rcx,4),%ecx
    16f3:	48 01 c8             	add    %rcx,%rax
    16f6:	48 39 d7             	cmp    %rdx,%rdi
    16f9:	75 e5                	jne    16e0 <gzram_base_decode_scalar+0x350>
    16fb:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
    1700:	48 29 f2             	sub    %rsi,%rdx
    1703:	48 39 c2             	cmp    %rax,%rdx
    1706:	0f 82 a6 01 00 00    	jb     18b2 <gzram_base_decode_scalar+0x522>
    170c:	4c 89 f1             	mov    %r14,%rcx
    170f:	e9 a0 00 00 00       	jmp    17b4 <gzram_base_decode_scalar+0x424>
    1714:	0f 1f 40 00          	nopl   0x0(%rax)
    1718:	44 8b 10             	mov    (%rax),%r10d
    171b:	48 83 c0 04          	add    $0x4,%rax
    171f:	44 89 51 04          	mov    %r10d,0x4(%rcx)
    1723:	f6 c2 04             	test   $0x4,%dl
    1726:	0f 84 c0 00 00 00    	je     17ec <gzram_base_decode_scalar+0x45c>
    172c:	44 8b 10             	mov    (%rax),%r10d
    172f:	48 83 c0 04          	add    $0x4,%rax
    1733:	44 89 51 08          	mov    %r10d,0x8(%rcx)
    1737:	f6 c2 08             	test   $0x8,%dl
    173a:	0f 84 bc 00 00 00    	je     17fc <gzram_base_decode_scalar+0x46c>
    1740:	44 8b 10             	mov    (%rax),%r10d
    1743:	48 83 c0 04          	add    $0x4,%rax
    1747:	44 89 51 0c          	mov    %r10d,0xc(%rcx)
    174b:	f6 c2 10             	test   $0x10,%dl
    174e:	0f 84 b8 00 00 00    	je     180c <gzram_base_decode_scalar+0x47c>
    1754:	44 8b 10             	mov    (%rax),%r10d
    1757:	48 83 c0 04          	add    $0x4,%rax
    175b:	44 89 51 10          	mov    %r10d,0x10(%rcx)
    175f:	f6 c2 20             	test   $0x20,%dl
    1762:	0f 84 b4 00 00 00    	je     181c <gzram_base_decode_scalar+0x48c>
    1768:	44 8b 10             	mov    (%rax),%r10d
    176b:	48 83 c0 04          	add    $0x4,%rax
    176f:	44 89 51 14          	mov    %r10d,0x14(%rcx)
    1773:	f6 c2 40             	test   $0x40,%dl
    1776:	0f 84 b0 00 00 00    	je     182c <gzram_base_decode_scalar+0x49c>
    177c:	44 8b 10             	mov    (%rax),%r10d
    177f:	48 83 c0 04          	add    $0x4,%rax
    1783:	44 89 51 18          	mov    %r10d,0x18(%rcx)
    1787:	84 d2                	test   %dl,%dl
    1789:	0f 89 ac 00 00 00    	jns    183b <gzram_base_decode_scalar+0x4ab>
    178f:	8b 00                	mov    (%rax),%eax
    1791:	48 83 c5 01          	add    $0x1,%rbp
    1795:	89 41 1c             	mov    %eax,0x1c(%rcx)
    1798:	41 0f b6 04 10       	movzbl (%r8,%rdx,1),%eax
    179d:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
    17a4:	48 01 c6             	add    %rax,%rsi
    17a7:	48 39 ef             	cmp    %rbp,%rdi
    17aa:	0f 84 ae 00 00 00    	je     185e <gzram_base_decode_scalar+0x4ce>
    17b0:	48 83 c1 20          	add    $0x20,%rcx
    17b4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    17b9:	0f b6 55 00          	movzbl 0x0(%rbp),%edx
    17bd:	48 01 f0             	add    %rsi,%rax
    17c0:	f6 c2 01             	test   $0x1,%dl
    17c3:	0f 84 bf 01 00 00    	je     1988 <gzram_base_decode_scalar+0x5f8>
    17c9:	44 8b 10             	mov    (%rax),%r10d
    17cc:	48 83 c0 04          	add    $0x4,%rax
    17d0:	44 89 11             	mov    %r10d,(%rcx)
    17d3:	f6 c2 02             	test   $0x2,%dl
    17d6:	0f 85 3c ff ff ff    	jne    1718 <gzram_base_decode_scalar+0x388>
    17dc:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%rcx)
    17e3:	f6 c2 04             	test   $0x4,%dl
    17e6:	0f 85 40 ff ff ff    	jne    172c <gzram_base_decode_scalar+0x39c>
    17ec:	c7 41 08 00 00 00 00 	movl   $0x0,0x8(%rcx)
    17f3:	f6 c2 08             	test   $0x8,%dl
    17f6:	0f 85 44 ff ff ff    	jne    1740 <gzram_base_decode_scalar+0x3b0>
    17fc:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%rcx)
    1803:	f6 c2 10             	test   $0x10,%dl
    1806:	0f 85 48 ff ff ff    	jne    1754 <gzram_base_decode_scalar+0x3c4>
    180c:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%rcx)
    1813:	f6 c2 20             	test   $0x20,%dl
    1816:	0f 85 4c ff ff ff    	jne    1768 <gzram_base_decode_scalar+0x3d8>
    181c:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%rcx)
    1823:	f6 c2 40             	test   $0x40,%dl
    1826:	0f 85 50 ff ff ff    	jne    177c <gzram_base_decode_scalar+0x3ec>
    182c:	c7 41 18 00 00 00 00 	movl   $0x0,0x18(%rcx)
    1833:	84 d2                	test   %dl,%dl
    1835:	0f 88 54 ff ff ff    	js     178f <gzram_base_decode_scalar+0x3ff>
    183b:	41 0f b6 04 10       	movzbl (%r8,%rdx,1),%eax
    1840:	48 83 c5 01          	add    $0x1,%rbp
    1844:	c7 41 1c 00 00 00 00 	movl   $0x0,0x1c(%rcx)
    184b:	8d 04 85 00 00 00 00 	lea    0x0(,%rax,4),%eax
    1852:	48 01 c6             	add    %rax,%rsi
    1855:	48 39 fd             	cmp    %rdi,%rbp
    1858:	0f 85 52 ff ff ff    	jne    17b0 <gzram_base_decode_scalar+0x420>
    185e:	48 89 f5             	mov    %rsi,%rbp
    1861:	e9 7c fd ff ff       	jmp    15e2 <gzram_base_decode_scalar+0x252>
    1866:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    186d:	00 00 00 
    1870:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    1875:	48 29 e8             	sub    %rbp,%rax
    1878:	48 39 d8             	cmp    %rbx,%rax
    187b:	72 35                	jb     18b2 <gzram_base_decode_scalar+0x522>
    187d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    1882:	48 89 da             	mov    %rbx,%rdx
    1885:	4c 89 f7             	mov    %r14,%rdi
    1888:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    188d:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
    1891:	48 01 dd             	add    %rbx,%rbp
    1894:	e8 00 00 00 00       	call   1899 <gzram_base_decode_scalar+0x509>
    1899:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    189e:	e9 3f fd ff ff       	jmp    15e2 <gzram_base_decode_scalar+0x252>
    18a3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    18a8:	b9 20 00 00 00       	mov    $0x20,%ecx
    18ad:	e9 63 fc ff ff       	jmp    1515 <gzram_base_decode_scalar+0x185>
    18b2:	48 8b ac 24 80 00 00 	mov    0x80(%rsp),%rbp
    18b9:	00 
    18ba:	4c 8b a4 24 88 00 00 	mov    0x88(%rsp),%r12
    18c1:	00 
    18c2:	4c 8b ac 24 90 00 00 	mov    0x90(%rsp),%r13
    18c9:	00 
    18ca:	4c 8b b4 24 98 00 00 	mov    0x98(%rsp),%r14
    18d1:	00 
    18d2:	4c 8b bc 24 a0 00 00 	mov    0xa0(%rsp),%r15
    18d9:	00 
    18da:	48 8b 5c 24 78       	mov    0x78(%rsp),%rbx
    18df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    18e4:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
    18eb:	c3                   	ret
    18ec:	0f 1f 40 00          	nopl   0x0(%rax)
    18f0:	4d 8b 48 e0          	mov    -0x20(%r8),%r9
    18f4:	4e 89 4c 20 e0       	mov    %r9,-0x20(%rax,%r12,1)
    18f9:	4d 8b 48 e8          	mov    -0x18(%r8),%r9
    18fd:	4e 89 4c 20 e8       	mov    %r9,-0x18(%rax,%r12,1)
    1902:	4d 8b 48 f0          	mov    -0x10(%r8),%r9
    1906:	4e 89 4c 20 f0       	mov    %r9,-0x10(%rax,%r12,1)
    190b:	4d 8b 48 f8          	mov    -0x8(%r8),%r9
    190f:	4e 89 4c 20 f8       	mov    %r9,-0x8(%rax,%r12,1)
    1914:	41 83 fa 20          	cmp    $0x20,%r10d
    1918:	0f 82 af fc ff ff    	jb     15cd <gzram_base_decode_scalar+0x23d>
    191e:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    1923:	45 31 c9             	xor    %r9d,%r9d
    1926:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    192b:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    1930:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    1935:	44 89 c9             	mov    %r9d,%ecx
    1938:	41 83 c1 20          	add    $0x20,%r9d
    193c:	4c 8b 74 0f 08       	mov    0x8(%rdi,%rcx,1),%r14
    1941:	48 8b 5c 0f 10       	mov    0x10(%rdi,%rcx,1),%rbx
    1946:	48 8b 74 0f 18       	mov    0x18(%rdi,%rcx,1),%rsi
    194b:	48 8b 14 0f          	mov    (%rdi,%rcx,1),%rdx
    194f:	4c 89 74 08 08       	mov    %r14,0x8(%rax,%rcx,1)
    1954:	48 89 14 08          	mov    %rdx,(%rax,%rcx,1)
    1958:	48 89 5c 08 10       	mov    %rbx,0x10(%rax,%rcx,1)
    195d:	48 89 74 08 18       	mov    %rsi,0x18(%rax,%rcx,1)
    1962:	44 3b 4c 24 08       	cmp    0x8(%rsp),%r9d
    1967:	72 cc                	jb     1935 <gzram_base_decode_scalar+0x5a5>
    1969:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    196e:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    1973:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    1978:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
    197d:	e9 4b fc ff ff       	jmp    15cd <gzram_base_decode_scalar+0x23d>
    1982:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1988:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    198e:	e9 40 fe ff ff       	jmp    17d3 <gzram_base_decode_scalar+0x443>
    1993:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1998:	48 8b 37             	mov    (%rdi),%rsi
    199b:	48 89 30             	mov    %rsi,(%rax)
    199e:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    19a2:	48 89 70 08          	mov    %rsi,0x8(%rax)
    19a6:	8b 74 24 68          	mov    0x68(%rsp),%esi
    19aa:	48 8d 44 30 10       	lea    0x10(%rax,%rsi,1),%rax
    19af:	48 8d 74 37 10       	lea    0x10(%rdi,%rsi,1),%rsi
    19b4:	4c 8b 4e e0          	mov    -0x20(%rsi),%r9
    19b8:	4c 89 48 e0          	mov    %r9,-0x20(%rax)
    19bc:	48 8b 76 e8          	mov    -0x18(%rsi),%rsi
    19c0:	48 89 70 e8          	mov    %rsi,-0x18(%rax)
    19c4:	e9 04 fc ff ff       	jmp    15cd <gzram_base_decode_scalar+0x23d>
    19c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    19d0:	48 8b 37             	mov    (%rdi),%rsi
    19d3:	48 89 30             	mov    %rsi,(%rax)
    19d6:	8b 74 24 68          	mov    0x68(%rsp),%esi
    19da:	4c 8b 4c 37 f8       	mov    -0x8(%rdi,%rsi,1),%r9
    19df:	4c 89 4c 30 f8       	mov    %r9,-0x8(%rax,%rsi,1)
    19e4:	e9 e4 fb ff ff       	jmp    15cd <gzram_base_decode_scalar+0x23d>
    19e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    19f0:	8b 37                	mov    (%rdi),%esi
    19f2:	89 30                	mov    %esi,(%rax)
    19f4:	8b 74 24 68          	mov    0x68(%rsp),%esi
    19f8:	44 8b 4c 37 fc       	mov    -0x4(%rdi,%rsi,1),%r9d
    19fd:	44 89 4c 30 fc       	mov    %r9d,-0x4(%rax,%rsi,1)
    1a02:	e9 c6 fb ff ff       	jmp    15cd <gzram_base_decode_scalar+0x23d>
    1a07:	0f b7 74 0f fe       	movzwl -0x2(%rdi,%rcx,1),%esi
    1a0c:	66 89 74 01 fe       	mov    %si,-0x2(%rcx,%rax,1)
    1a11:	e9 b7 fb ff ff       	jmp    15cd <gzram_base_decode_scalar+0x23d>
    1a16:	48 8d 77 08          	lea    0x8(%rdi),%rsi
    1a1a:	4c 89 c2             	mov    %r8,%rdx
    1a1d:	4c 89 f7             	mov    %r14,%rdi
    1a20:	e8 00 00 00 00       	call   1a25 <gzram_base_decode_scalar+0x695>
    1a25:	e9 bc fa ff ff       	jmp    14e6 <gzram_base_decode_scalar+0x156>
    1a2a:	4c 8b a4 24 88 00 00 	mov    0x88(%rsp),%r12
    1a31:	00 
    1a32:	4c 8b b4 24 98 00 00 	mov    0x98(%rsp),%r14
    1a39:	00 
    1a3a:	e9 9b fe ff ff       	jmp    18da <gzram_base_decode_scalar+0x54a>
    1a3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1a44:	c3                   	ret
    1a45:	41 ba 08 00 00 00    	mov    $0x8,%r10d
    1a4b:	e9 bc fb ff ff       	jmp    160c <gzram_base_decode_scalar+0x27c>
    1a50:	4c 8b a4 24 88 00 00 	mov    0x88(%rsp),%r12
    1a57:	00 
    1a58:	4c 8b b4 24 98 00 00 	mov    0x98(%rsp),%r14
    1a5f:	00 
    1a60:	4c 8b bc 24 a0 00 00 	mov    0xa0(%rsp),%r15
    1a67:	00 
    1a68:	e9 6d fe ff ff       	jmp    18da <gzram_base_decode_scalar+0x54a>
    1a6d:	0f 1f 00             	nopl   (%rax)

0000000000001a70 <gzram_base_decode_avx2>:
    1a70:	48 83 ec 78          	sub    $0x78,%rsp
    1a74:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
    1a79:	48 89 cb             	mov    %rcx,%rbx
    1a7c:	48 89 6c 24 50       	mov    %rbp,0x50(%rsp)
    1a81:	48 89 d5             	mov    %rdx,%rbp
    1a84:	4c 89 64 24 58       	mov    %r12,0x58(%rsp)
    1a89:	49 89 fc             	mov    %rdi,%r12
    1a8c:	4c 89 74 24 68       	mov    %r14,0x68(%rsp)
    1a91:	49 89 f6             	mov    %rsi,%r14
    1a94:	e8 00 00 00 00       	call   1a99 <gzram_base_decode_avx2+0x29>
    1a99:	85 c0                	test   %eax,%eax
    1a9b:	0f 84 af 00 00 00    	je     1b50 <gzram_base_decode_avx2+0xe0>
    1aa1:	49 8d 46 f8          	lea    -0x8(%r14),%rax
    1aa5:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
    1aab:	0f 87 ff 01 00 00    	ja     1cb0 <gzram_base_decode_avx2+0x240>
    1ab1:	4d 85 e4             	test   %r12,%r12
    1ab4:	0f 84 f6 01 00 00    	je     1cb0 <gzram_base_decode_avx2+0x240>
    1aba:	41 81 3c 24 47 5a 52 	cmpl   $0x31525a47,(%r12)
    1ac1:	31 
    1ac2:	0f 85 e8 01 00 00    	jne    1cb0 <gzram_base_decode_avx2+0x240>
    1ac8:	41 0f b6 4c 24 06    	movzbl 0x6(%r12),%ecx
    1ace:	8d 41 fb             	lea    -0x5(%rcx),%eax
    1ad1:	3c 07                	cmp    $0x7,%al
    1ad3:	0f 87 d7 01 00 00    	ja     1cb0 <gzram_base_decode_avx2+0x240>
    1ad9:	41 0f b6 7c 24 07    	movzbl 0x7(%r12),%edi
    1adf:	40 80 ff 01          	cmp    $0x1,%dil
    1ae3:	0f 87 c7 01 00 00    	ja     1cb0 <gzram_base_decode_avx2+0x240>
    1ae9:	b8 00 10 00 00       	mov    $0x1000,%eax
    1aee:	41 0f b7 54 24 04    	movzwl 0x4(%r12),%edx
    1af4:	48 39 c3             	cmp    %rax,%rbx
    1af7:	48 0f 46 c3          	cmovbe %rbx,%rax
    1afb:	49 89 d2             	mov    %rdx,%r10
    1afe:	48 39 d0             	cmp    %rdx,%rax
    1b01:	0f 82 a9 01 00 00    	jb     1cb0 <gzram_base_decode_avx2+0x240>
    1b07:	48 85 ed             	test   %rbp,%rbp
    1b0a:	75 09                	jne    1b15 <gzram_base_decode_avx2+0xa5>
    1b0c:	48 85 d2             	test   %rdx,%rdx
    1b0f:	0f 85 9b 01 00 00    	jne    1cb0 <gzram_base_decode_avx2+0x240>
    1b15:	40 84 ff             	test   %dil,%dil
    1b18:	74 66                	je     1b80 <gzram_base_decode_avx2+0x110>
    1b1a:	48 8d 42 08          	lea    0x8(%rdx),%rax
    1b1e:	49 39 c6             	cmp    %rax,%r14
    1b21:	0f 85 89 01 00 00    	jne    1cb0 <gzram_base_decode_avx2+0x240>
    1b27:	48 85 d2             	test   %rdx,%rdx
    1b2a:	0f 85 18 03 00 00    	jne    1e48 <gzram_base_decode_avx2+0x3d8>
    1b30:	41 0f b7 c2          	movzwl %r10w,%eax
    1b34:	48 8b 5c 24 48       	mov    0x48(%rsp),%rbx
    1b39:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
    1b3e:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
    1b43:	4c 8b 74 24 68       	mov    0x68(%rsp),%r14
    1b48:	48 83 c4 78          	add    $0x78,%rsp
    1b4c:	c3                   	ret
    1b4d:	0f 1f 00             	nopl   (%rax)
    1b50:	48 89 d9             	mov    %rbx,%rcx
    1b53:	48 89 ea             	mov    %rbp,%rdx
    1b56:	48 8b 5c 24 48       	mov    0x48(%rsp),%rbx
    1b5b:	48 8b 6c 24 50       	mov    0x50(%rsp),%rbp
    1b60:	4c 89 f6             	mov    %r14,%rsi
    1b63:	4c 89 e7             	mov    %r12,%rdi
    1b66:	4c 8b 74 24 68       	mov    0x68(%rsp),%r14
    1b6b:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
    1b70:	48 83 c4 78          	add    $0x78,%rsp
    1b74:	e9 00 00 00 00       	jmp    1b79 <gzram_base_decode_avx2+0x109>
    1b79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1b80:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    1b86:	49 d3 e1             	shl    %cl,%r9
    1b89:	4a 8d 44 0a ff       	lea    -0x1(%rdx,%r9,1),%rax
    1b8e:	48 d3 e8             	shr    %cl,%rax
    1b91:	48 8d 58 08          	lea    0x8(%rax),%rbx
    1b95:	49 39 de             	cmp    %rbx,%r14
    1b98:	0f 82 12 01 00 00    	jb     1cb0 <gzram_base_decode_avx2+0x240>
    1b9e:	48 85 c0             	test   %rax,%rax
    1ba1:	0f 84 e1 02 00 00    	je     1e88 <gzram_base_decode_avx2+0x418>
    1ba7:	49 8d 44 04 08       	lea    0x8(%r12,%rax,1),%rax
    1bac:	66 44 89 54 24 3e    	mov    %r10w,0x3e(%rsp)
    1bb2:	4d 8d 44 24 08       	lea    0x8(%r12),%r8
    1bb7:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1bbc:	48 8d 44 15 00       	lea    0x0(%rbp,%rdx,1),%rax
    1bc1:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1bc6:	4c 89 24 24          	mov    %r12,(%rsp)
    1bca:	4c 89 6c 24 60       	mov    %r13,0x60(%rsp)
    1bcf:	4c 8d 2d 00 00 00 00 	lea    0x0(%rip),%r13        # 1bd6 <gzram_base_decode_avx2+0x166>
    1bd6:	4c 89 7c 24 70       	mov    %r15,0x70(%rsp)
    1bdb:	4d 89 cf             	mov    %r9,%r15
    1bde:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    1be3:	49 89 ee             	mov    %rbp,%r14
    1be6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    1bed:	00 00 00 
    1bf0:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    1bf5:	4c 29 f5             	sub    %r14,%rbp
    1bf8:	4c 39 fd             	cmp    %r15,%rbp
    1bfb:	49 0f 47 ef          	cmova  %r15,%rbp
    1bff:	41 80 38 06          	cmpb   $0x6,(%r8)
    1c03:	0f 87 5f 02 00 00    	ja     1e68 <gzram_base_decode_avx2+0x3f8>
    1c09:	41 0f b6 00          	movzbl (%r8),%eax
    1c0d:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    1c12:	4c 01 e8             	add    %r13,%rax
    1c15:	ff e0                	jmp    *%rax
    1c17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    1c1e:	00 00 
    1c20:	41 ba 08 00 00 00    	mov    $0x8,%r10d
    1c26:	b9 08 00 00 00       	mov    $0x8,%ecx
    1c2b:	48 89 e8             	mov    %rbp,%rax
    1c2e:	31 d2                	xor    %edx,%edx
    1c30:	49 f7 f2             	div    %r10
    1c33:	48 85 d2             	test   %rdx,%rdx
    1c36:	0f 85 2c 02 00 00    	jne    1e68 <gzram_base_decode_avx2+0x3f8>
    1c3c:	4c 39 d5             	cmp    %r10,%rbp
    1c3f:	0f 82 23 02 00 00    	jb     1e68 <gzram_base_decode_avx2+0x3f8>
    1c45:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    1c4a:	48 29 d8             	sub    %rbx,%rax
    1c4d:	4c 39 d0             	cmp    %r10,%rax
    1c50:	0f 82 12 02 00 00    	jb     1e68 <gzram_base_decode_avx2+0x3f8>
    1c56:	48 8b 04 24          	mov    (%rsp),%rax
    1c5a:	48 89 ea             	mov    %rbp,%rdx
    1c5d:	4c 89 f7             	mov    %r14,%rdi
    1c60:	4c 89 44 24 28       	mov    %r8,0x28(%rsp)
    1c65:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    1c6a:	48 8d 34 18          	lea    (%rax,%rbx,1),%rsi
    1c6e:	e8 0d e4 ff ff       	call   80 <repeat_avx2>
    1c73:	4c 8b 44 24 28       	mov    0x28(%rsp),%r8
    1c78:	48 03 5c 24 20       	add    0x20(%rsp),%rbx
    1c7d:	49 83 c0 01          	add    $0x1,%r8
    1c81:	4d 01 fe             	add    %r15,%r14
    1c84:	4c 39 44 24 18       	cmp    %r8,0x18(%rsp)
    1c89:	0f 85 61 ff ff ff    	jne    1bf0 <gzram_base_decode_avx2+0x180>
    1c8f:	44 0f b7 54 24 3e    	movzwl 0x3e(%rsp),%r10d
    1c95:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    1c9a:	4c 8b 6c 24 60       	mov    0x60(%rsp),%r13
    1c9f:	4c 8b 7c 24 70       	mov    0x70(%rsp),%r15
    1ca4:	49 39 de             	cmp    %rbx,%r14
    1ca7:	0f 84 83 fe ff ff    	je     1b30 <gzram_base_decode_avx2+0xc0>
    1cad:	0f 1f 00             	nopl   (%rax)
    1cb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1cb5:	e9 7a fe ff ff       	jmp    1b34 <gzram_base_decode_avx2+0xc4>
    1cba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1cc0:	41 ba 04 00 00 00    	mov    $0x4,%r10d
    1cc6:	b9 04 00 00 00       	mov    $0x4,%ecx
    1ccb:	e9 5b ff ff ff       	jmp    1c2b <gzram_base_decode_avx2+0x1bb>
    1cd0:	48 89 ea             	mov    %rbp,%rdx
    1cd3:	31 f6                	xor    %esi,%esi
    1cd5:	4c 89 f7             	mov    %r14,%rdi
    1cd8:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    1cdd:	e8 00 00 00 00       	call   1ce2 <gzram_base_decode_avx2+0x272>
    1ce2:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    1ce7:	eb 94                	jmp    1c7d <gzram_base_decode_avx2+0x20d>
    1ce9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1cf0:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    1cf5:	48 29 d8             	sub    %rbx,%rax
    1cf8:	48 39 e8             	cmp    %rbp,%rax
    1cfb:	0f 82 67 01 00 00    	jb     1e68 <gzram_base_decode_avx2+0x3f8>
    1d01:	48 8b 04 24          	mov    (%rsp),%rax
    1d05:	48 89 ea             	mov    %rbp,%rdx
    1d08:	4c 89 f7             	mov    %r14,%rdi
    1d0b:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    1d10:	48 8d 34 18          	lea    (%rax,%rbx,1),%rsi
    1d14:	48 01 eb             	add    %rbp,%rbx
    1d17:	e8 00 00 00 00       	call   1d1c <gzram_base_decode_avx2+0x2ac>
    1d1c:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    1d21:	e9 57 ff ff ff       	jmp    1c7d <gzram_base_decode_avx2+0x20d>
    1d26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    1d2d:	00 00 00 
    1d30:	41 ba 20 00 00 00    	mov    $0x20,%r10d
    1d36:	b9 20 00 00 00       	mov    $0x20,%ecx
    1d3b:	e9 eb fe ff ff       	jmp    1c2b <gzram_base_decode_avx2+0x1bb>
    1d40:	41 ba 10 00 00 00    	mov    $0x10,%r10d
    1d46:	b9 10 00 00 00       	mov    $0x10,%ecx
    1d4b:	e9 db fe ff ff       	jmp    1c2b <gzram_base_decode_avx2+0x1bb>
    1d50:	48 89 e9             	mov    %rbp,%rcx
    1d53:	83 e1 1f             	and    $0x1f,%ecx
    1d56:	0f 85 0c 01 00 00    	jne    1e68 <gzram_base_decode_avx2+0x3f8>
    1d5c:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    1d61:	48 c1 ed 05          	shr    $0x5,%rbp
    1d65:	48 29 d8             	sub    %rbx,%rax
    1d68:	48 39 e8             	cmp    %rbp,%rax
    1d6b:	0f 82 f7 00 00 00    	jb     1e68 <gzram_base_decode_avx2+0x3f8>
    1d71:	48 8d 74 1d 00       	lea    0x0(%rbp,%rbx,1),%rsi
    1d76:	48 85 ed             	test   %rbp,%rbp
    1d79:	0f 84 01 01 00 00    	je     1e80 <gzram_base_decode_avx2+0x410>
    1d7f:	48 8b 04 24          	mov    (%rsp),%rax
    1d83:	4c 8d 15 00 00 00 00 	lea    0x0(%rip),%r10        # 1d8a <gzram_base_decode_avx2+0x31a>
    1d8a:	48 01 d8             	add    %rbx,%rax
    1d8d:	48 8d 14 28          	lea    (%rax,%rbp,1),%rdx
    1d91:	49 89 c3             	mov    %rax,%r11
    1d94:	90                   	nop
    1d95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1d9c:	00 00 00 00 
    1da0:	41 0f b6 3b          	movzbl (%r11),%edi
    1da4:	49 83 c3 01          	add    $0x1,%r11
    1da8:	41 0f b6 3c 3a       	movzbl (%r10,%rdi,1),%edi
    1dad:	8d 3c bd 00 00 00 00 	lea    0x0(,%rdi,4),%edi
    1db4:	48 01 f9             	add    %rdi,%rcx
    1db7:	49 39 d3             	cmp    %rdx,%r11
    1dba:	75 e4                	jne    1da0 <gzram_base_decode_avx2+0x330>
    1dbc:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
    1dc1:	49 29 f3             	sub    %rsi,%r11
    1dc4:	49 39 cb             	cmp    %rcx,%r11
    1dc7:	0f 82 9b 00 00 00    	jb     1e68 <gzram_base_decode_avx2+0x3f8>
    1dcd:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
    1dd2:	48 89 c3             	mov    %rax,%rbx
    1dd5:	48 89 d5             	mov    %rdx,%rbp
    1dd8:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
    1ddd:	4d 89 f7             	mov    %r14,%r15
    1de0:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    1de5:	49 89 f6             	mov    %rsi,%r14
    1de8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    1def:	00 
    1df0:	44 0f b6 23          	movzbl (%rbx),%r12d
    1df4:	48 8b 04 24          	mov    (%rsp),%rax
    1df8:	4c 89 fe             	mov    %r15,%rsi
    1dfb:	48 83 c3 01          	add    $0x1,%rbx
    1dff:	49 83 c7 20          	add    $0x20,%r15
    1e03:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
    1e07:	44 89 e2             	mov    %r12d,%edx
    1e0a:	e8 b1 e4 ff ff       	call   2c0 <unpack_avx2>
    1e0f:	44 89 e2             	mov    %r12d,%edx
    1e12:	4c 8d 15 00 00 00 00 	lea    0x0(%rip),%r10        # 1e19 <gzram_base_decode_avx2+0x3a9>
    1e19:	41 0f b6 14 12       	movzbl (%r10,%rdx,1),%edx
    1e1e:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
    1e25:	49 01 d6             	add    %rdx,%r14
    1e28:	48 39 eb             	cmp    %rbp,%rbx
    1e2b:	75 c3                	jne    1df0 <gzram_base_decode_avx2+0x380>
    1e2d:	4c 89 f3             	mov    %r14,%rbx
    1e30:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
    1e35:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    1e3a:	4c 8b 44 24 30       	mov    0x30(%rsp),%r8
    1e3f:	e9 39 fe ff ff       	jmp    1c7d <gzram_base_decode_avx2+0x20d>
    1e44:	0f 1f 40 00          	nopl   0x0(%rax)
    1e48:	49 8d 74 24 08       	lea    0x8(%r12),%rsi
    1e4d:	48 89 ef             	mov    %rbp,%rdi
    1e50:	44 89 14 24          	mov    %r10d,(%rsp)
    1e54:	e8 00 00 00 00       	call   1e59 <gzram_base_decode_avx2+0x3e9>
    1e59:	44 8b 14 24          	mov    (%rsp),%r10d
    1e5d:	e9 ce fc ff ff       	jmp    1b30 <gzram_base_decode_avx2+0xc0>
    1e62:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1e68:	4c 8b 6c 24 60       	mov    0x60(%rsp),%r13
    1e6d:	4c 8b 7c 24 70       	mov    0x70(%rsp),%r15
    1e72:	e9 39 fe ff ff       	jmp    1cb0 <gzram_base_decode_avx2+0x240>
    1e77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    1e7e:	00 00 
    1e80:	48 89 f3             	mov    %rsi,%rbx
    1e83:	e9 f5 fd ff ff       	jmp    1c7d <gzram_base_decode_avx2+0x20d>
    1e88:	bb 08 00 00 00       	mov    $0x8,%ebx
    1e8d:	e9 12 fe ff ff       	jmp    1ca4 <gzram_base_decode_avx2+0x234>
