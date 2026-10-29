
/home/dan/n100-zram/build/astra-simd-kernel-002/vector-encoder/core.o:     file format elf64-x86-64


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
      23:	74 57                	je     7c <pack_scalar+0x6c>
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
      63:	55                   	push   %rbp
      64:	c5 fe 6f 07          	vmovdqu (%rdi),%ymm0
      68:	48 89 e5             	mov    %rsp,%rbp
      6b:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
      6f:	c5 fe 7f 06          	vmovdqu %ymm0,(%rsi)
      73:	c5 f8 77             	vzeroupper
      76:	c9                   	leave
      77:	e9 00 00 00 00       	jmp    7c <pack_scalar+0x6c>
      7c:	e9 00 00 00 00       	jmp    81 <pack_scalar+0x71>
      81:	0f 1f 40 00          	nopl   0x0(%rax)
      85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
      8c:	00 00 00 00 
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

00000000000001c0 <pack_avx2>:
     1c0:	f3 0f 1e fa          	endbr64
     1c4:	e8 00 00 00 00       	call   1c9 <pack_avx2+0x9>
     1c9:	55                   	push   %rbp
     1ca:	48 89 e5             	mov    %rsp,%rbp
     1cd:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
     1d1:	48 83 ec 60          	sub    $0x60,%rsp
     1d5:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 1dd <pack_avx2+0x1d>
     1dc:	00 
     1dd:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
     1e2:	31 c0                	xor    %eax,%eax
     1e4:	85 d2                	test   %edx,%edx
     1e6:	74 62                	je     24a <pack_avx2+0x8a>
     1e8:	c5 fe 6f 07          	vmovdqu (%rdi),%ymm0
     1ec:	48 89 f1             	mov    %rsi,%rcx
     1ef:	81 fa ff 00 00 00    	cmp    $0xff,%edx
     1f5:	74 68                	je     25f <pack_avx2+0x9f>
     1f7:	89 d0                	mov    %edx,%eax
     1f9:	81 fa 00 01 00 00    	cmp    $0x100,%edx
     1ff:	77 6c                	ja     26d <pack_avx2+0xad>
     201:	48 89 c2             	mov    %rax,%rdx
     204:	48 c1 e2 05          	shl    $0x5,%rdx
     208:	c5 fd 6f 8a 00 00 00 	vmovdqa 0x0(%rdx),%ymm1
     20f:	00 
     210:	c4 e2 75 36 c0       	vpermd %ymm0,%ymm1,%ymm0
     215:	c5 fe 7f 44 24 30    	vmovdqu %ymm0,0x30(%rsp)
     21b:	48 3d 00 01 00 00    	cmp    $0x100,%rax
     221:	73 7f                	jae    2a2 <pack_avx2+0xe2>
     223:	c5 f8 77             	vzeroupper
     226:	0f b6 80 00 00 00 00 	movzbl 0x0(%rax),%eax
     22d:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
     234:	83 fa 20             	cmp    $0x20,%edx
     237:	0f 87 00 00 00 00    	ja     23d <pack_avx2+0x7d>
     23d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
     242:	48 89 cf             	mov    %rcx,%rdi
     245:	e8 00 00 00 00       	call   24a <pack_avx2+0x8a>
     24a:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
     24f:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 257 <pack_avx2+0x97>
     256:	00 
     257:	75 0f                	jne    268 <pack_avx2+0xa8>
     259:	c9                   	leave
     25a:	e9 00 00 00 00       	jmp    25f <pack_avx2+0x9f>
     25f:	c5 fe 7f 06          	vmovdqu %ymm0,(%rsi)
     263:	c5 f8 77             	vzeroupper
     266:	eb e2                	jmp    24a <pack_avx2+0x8a>
     268:	e8 00 00 00 00       	call   26d <pack_avx2+0xad>
     26d:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
     272:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     279:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
     27e:	48 89 c6             	mov    %rax,%rsi
     281:	c5 fd 7f 04 24       	vmovdqa %ymm0,(%rsp)
     286:	c5 f8 77             	vzeroupper
     289:	e8 00 00 00 00       	call   28e <pack_avx2+0xce>
     28e:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
     293:	c5 fd 6f 04 24       	vmovdqa (%rsp),%ymm0
     298:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
     29d:	e9 5f ff ff ff       	jmp    201 <pack_avx2+0x41>
     2a2:	48 89 0c 24          	mov    %rcx,(%rsp)
     2a6:	48 89 c6             	mov    %rax,%rsi
     2a9:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     2b0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
     2b5:	c5 f8 77             	vzeroupper
     2b8:	e8 00 00 00 00       	call   2bd <pack_avx2+0xfd>
     2bd:	48 8b 0c 24          	mov    (%rsp),%rcx
     2c1:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
     2c6:	e9 5b ff ff ff       	jmp    226 <pack_avx2+0x66>
     2cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     2d0:	90                   	nop
     2d1:	90                   	nop
     2d2:	90                   	nop
     2d3:	90                   	nop
     2d4:	90                   	nop
     2d5:	90                   	nop
     2d6:	90                   	nop
     2d7:	90                   	nop
     2d8:	90                   	nop
     2d9:	90                   	nop
     2da:	90                   	nop
     2db:	90                   	nop
     2dc:	90                   	nop
     2dd:	90                   	nop
     2de:	90                   	nop
     2df:	90                   	nop

00000000000002e0 <encode>:
     2e0:	e8 00 00 00 00       	call   2e5 <encode+0x5>
     2e5:	55                   	push   %rbp
     2e6:	48 89 e5             	mov    %rsp,%rbp
     2e9:	41 57                	push   %r15
     2eb:	41 56                	push   %r14
     2ed:	41 55                	push   %r13
     2ef:	41 54                	push   %r12
     2f1:	53                   	push   %rbx
     2f2:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
     2f6:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
     2fd:	48 8b 45 10          	mov    0x10(%rbp),%rax
     301:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
     306:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 30e <encode+0x2e>
     30d:	00 
     30e:	48 89 84 24 08 01 00 	mov    %rax,0x108(%rsp)
     315:	00 
     316:	41 8d 40 fb          	lea    -0x5(%r8),%eax
     31a:	83 f8 07             	cmp    $0x7,%eax
     31d:	0f 87 aa 01 00 00    	ja     4cd <encode+0x1ed>
     323:	48 81 fe 00 10 00 00 	cmp    $0x1000,%rsi
     32a:	0f 87 9d 01 00 00    	ja     4cd <encode+0x1ed>
     330:	49 89 fc             	mov    %rdi,%r12
     333:	48 89 d7             	mov    %rdx,%rdi
     336:	48 85 d2             	test   %rdx,%rdx
     339:	0f 84 8e 01 00 00    	je     4cd <encode+0x1ed>
     33f:	4d 85 e4             	test   %r12,%r12
     342:	0f 94 c2             	sete   %dl
     345:	48 85 f6             	test   %rsi,%rsi
     348:	0f 95 c0             	setne  %al
     34b:	84 c2                	test   %al,%dl
     34d:	0f 85 7a 01 00 00    	jne    4cd <encode+0x1ed>
     353:	49 89 cb             	mov    %rcx,%r11
     356:	48 83 f9 07          	cmp    $0x7,%rcx
     35a:	0f 86 6d 01 00 00    	jbe    4cd <encode+0x1ed>
     360:	44 89 c1             	mov    %r8d,%ecx
     363:	b8 01 00 00 00       	mov    $0x1,%eax
     368:	48 d3 e0             	shl    %cl,%rax
     36b:	48 8d 5c 30 ff       	lea    -0x1(%rax,%rsi,1),%rbx
     370:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
     375:	48 d3 eb             	shr    %cl,%rbx
     378:	4c 8d 6b 08          	lea    0x8(%rbx),%r13
     37c:	4d 39 eb             	cmp    %r13,%r11
     37f:	0f 82 25 02 00 00    	jb     5aa <encode+0x2ca>
     385:	31 c9                	xor    %ecx,%ecx
     387:	44 89 c2             	mov    %r8d,%edx
     38a:	4c 89 5c 24 48       	mov    %r11,0x48(%rsp)
     38f:	44 89 44 24 50       	mov    %r8d,0x50(%rsp)
     394:	48 89 74 24 58       	mov    %rsi,0x58(%rsp)
     399:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
     39e:	4c 89 4c 24 38       	mov    %r9,0x38(%rsp)
     3a3:	e8 f8 fc ff ff       	call   a0 <header>
     3a8:	48 85 db             	test   %rbx,%rbx
     3ab:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
     3b0:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
     3b5:	44 8b 44 24 50       	mov    0x50(%rsp),%r8d
     3ba:	4c 8b 5c 24 48       	mov    0x48(%rsp),%r11
     3bf:	0f 84 c2 03 00 00    	je     787 <encode+0x4a7>
     3c5:	4c 8b 4c 24 38       	mov    0x38(%rsp),%r9
     3ca:	48 8d 44 1f 08       	lea    0x8(%rdi,%rbx,1),%rax
     3cf:	4d 89 ef             	mov    %r13,%r15
     3d2:	4d 89 e6             	mov    %r12,%r14
     3d5:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
     3da:	49 8d 04 34          	lea    (%r12,%rsi,1),%rax
     3de:	4c 8d 6f 08          	lea    0x8(%rdi),%r13
     3e2:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
     3e7:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
     3ec:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
     3f1:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
     3f6:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
     3fb:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
     400:	eb 44                	jmp    446 <encode+0x166>
     402:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
     407:	4c 29 f8             	sub    %r15,%rax
     40a:	48 39 d8             	cmp    %rbx,%rax
     40d:	0f 82 e2 01 00 00    	jb     5f5 <encode+0x315>
     413:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
     418:	c5 f8 77             	vzeroupper
     41b:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
     420:	4c 89 f6             	mov    %r14,%rsi
     423:	48 89 da             	mov    %rbx,%rdx
     426:	4a 8d 3c 38          	lea    (%rax,%r15,1),%rdi
     42a:	49 01 df             	add    %rbx,%r15
     42d:	e8 00 00 00 00       	call   432 <encode+0x152>
     432:	4c 03 74 24 60       	add    0x60(%rsp),%r14
     437:	49 83 c5 01          	add    $0x1,%r13
     43b:	4c 3b 6c 24 48       	cmp    0x48(%rsp),%r13
     440:	0f 84 38 01 00 00    	je     57e <encode+0x29e>
     446:	48 8b 5c 24 58       	mov    0x58(%rsp),%rbx
     44b:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     44f:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
     454:	48 c7 84 24 00 01 00 	movq   $0x0,0x100(%rsp)
     45b:	00 00 00 00 00 
     460:	c5 fe 7f 84 24 80 00 	vmovdqu %ymm0,0x80(%rsp)
     467:	00 00 
     469:	c5 fe 7f 84 24 a0 00 	vmovdqu %ymm0,0xa0(%rsp)
     470:	00 00 
     472:	4c 29 f3             	sub    %r14,%rbx
     475:	c5 fe 7f 84 24 c0 00 	vmovdqu %ymm0,0xc0(%rsp)
     47c:	00 00 
     47e:	48 39 c3             	cmp    %rax,%rbx
     481:	c5 fe 7f 84 24 e0 00 	vmovdqu %ymm0,0xe0(%rsp)
     488:	00 00 
     48a:	48 0f 47 d8          	cmova  %rax,%rbx
     48e:	49 89 dc             	mov    %rbx,%r12
     491:	41 83 e4 1f          	and    $0x1f,%r12d
     495:	0f 85 67 ff ff ff    	jne    402 <encode+0x122>
     49b:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
     4a0:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
     4a7:	00 
     4a8:	48 89 de             	mov    %rbx,%rsi
     4ab:	4c 89 f7             	mov    %r14,%rdi
     4ae:	c5 f8 77             	vzeroupper
     4b1:	e8 00 00 00 00       	call   4b6 <encode+0x1d6>
     4b6:	44 8b 94 24 00 01 00 	mov    0x100(%rsp),%r10d
     4bd:	00 
     4be:	45 85 d2             	test   %r10d,%r10d
     4c1:	75 35                	jne    4f8 <encode+0x218>
     4c3:	41 c6 45 00 01       	movb   $0x1,0x0(%r13)
     4c8:	e9 65 ff ff ff       	jmp    432 <encode+0x152>
     4cd:	31 c0                	xor    %eax,%eax
     4cf:	48 8b 94 24 08 01 00 	mov    0x108(%rsp),%rdx
     4d6:	00 
     4d7:	65 48 2b 15 00 00 00 	sub    %gs:0x0(%rip),%rdx        # 4df <encode+0x1ff>
     4de:	00 
     4df:	0f 85 ef 02 00 00    	jne    7d4 <encode+0x4f4>
     4e5:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     4e9:	5b                   	pop    %rbx
     4ea:	41 5c                	pop    %r12
     4ec:	41 5d                	pop    %r13
     4ee:	41 5e                	pop    %r14
     4f0:	41 5f                	pop    %r15
     4f2:	5d                   	pop    %rbp
     4f3:	e9 00 00 00 00       	jmp    4f8 <encode+0x218>
     4f8:	48 b8 02 00 00 00 03 	movabs $0x300000002,%rax
     4ff:	00 00 00 
     502:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
     507:	48 b8 05 00 00 00 06 	movabs $0x600000005,%rax
     50e:	00 00 00 
     511:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
     516:	8b 84 24 04 01 00 00 	mov    0x104(%rsp),%eax
     51d:	a8 01                	test   $0x1,%al
     51f:	74 14                	je     535 <encode+0x255>
     521:	48 83 fb 04          	cmp    $0x4,%rbx
     525:	0f 87 67 02 00 00    	ja     792 <encode+0x4b2>
     52b:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
     530:	e9 e6 fe ff ff       	jmp    41b <encode+0x13b>
     535:	a8 02                	test   $0x2,%al
     537:	0f 85 9f 00 00 00    	jne    5dc <encode+0x2fc>
     53d:	a8 04                	test   $0x4,%al
     53f:	0f 84 df 00 00 00    	je     624 <encode+0x344>
     545:	48 83 fb 10          	cmp    $0x10,%rbx
     549:	76 e0                	jbe    52b <encode+0x24b>
     54b:	be 02 00 00 00       	mov    $0x2,%esi
     550:	bb 10 00 00 00       	mov    $0x10,%ebx
     555:	44 8b 64 b4 70       	mov    0x70(%rsp,%rsi,4),%r12d
     55a:	48 83 fe 04          	cmp    $0x4,%rsi
     55e:	0f 83 75 02 00 00    	jae    7d9 <encode+0x4f9>
     564:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
     569:	4c 29 f8             	sub    %r15,%rax
     56c:	48 39 d8             	cmp    %rbx,%rax
     56f:	0f 82 41 02 00 00    	jb     7b6 <encode+0x4d6>
     575:	45 88 65 00          	mov    %r12b,0x0(%r13)
     579:	e9 9d fe ff ff       	jmp    41b <encode+0x13b>
     57e:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
     583:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     588:	4d 89 fd             	mov    %r15,%r13
     58b:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
     590:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
     595:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
     59a:	48 8d 56 08          	lea    0x8(%rsi),%rdx
     59e:	44 89 e8             	mov    %r13d,%eax
     5a1:	49 39 d5             	cmp    %rdx,%r13
     5a4:	0f 82 25 ff ff ff    	jb     4cf <encode+0x1ef>
     5aa:	48 8b 84 24 08 01 00 	mov    0x108(%rsp),%rax
     5b1:	00 
     5b2:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 5ba <encode+0x2da>
     5b9:	00 
     5ba:	0f 85 14 02 00 00    	jne    7d4 <encode+0x4f4>
     5c0:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     5c4:	48 89 fa             	mov    %rdi,%rdx
     5c7:	4c 89 d9             	mov    %r11,%rcx
     5ca:	4c 89 e7             	mov    %r12,%rdi
     5cd:	5b                   	pop    %rbx
     5ce:	41 5c                	pop    %r12
     5d0:	41 5d                	pop    %r13
     5d2:	41 5e                	pop    %r14
     5d4:	41 5f                	pop    %r15
     5d6:	5d                   	pop    %rbp
     5d7:	e9 f4 fa ff ff       	jmp    d0 <raw_page>
     5dc:	48 83 fb 08          	cmp    $0x8,%rbx
     5e0:	0f 86 45 ff ff ff    	jbe    52b <encode+0x24b>
     5e6:	be 01 00 00 00       	mov    $0x1,%esi
     5eb:	bb 08 00 00 00       	mov    $0x8,%ebx
     5f0:	e9 60 ff ff ff       	jmp    555 <encode+0x275>
     5f5:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
     5fa:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     5ff:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
     604:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
     609:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
     60e:	c5 f8 77             	vzeroupper
     611:	48 89 fa             	mov    %rdi,%rdx
     614:	4c 89 d9             	mov    %r11,%rcx
     617:	4c 89 e7             	mov    %r12,%rdi
     61a:	e8 b1 fa ff ff       	call   d0 <raw_page>
     61f:	e9 ab fe ff ff       	jmp    4cf <encode+0x1ef>
     624:	a8 08                	test   $0x8,%al
     626:	74 0a                	je     632 <encode+0x352>
     628:	48 83 fb 20          	cmp    $0x20,%rbx
     62c:	0f 87 6c 01 00 00    	ja     79e <encode+0x4be>
     632:	49 89 db             	mov    %rbx,%r11
     635:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
     63a:	42 8d 04 95 00 00 00 	lea    0x0(,%r10,4),%eax
     641:	00 
     642:	49 c1 eb 05          	shr    $0x5,%r11
     646:	4c 01 d8             	add    %r11,%rax
     649:	4c 29 fa             	sub    %r15,%rdx
     64c:	48 39 d8             	cmp    %rbx,%rax
     64f:	0f 83 58 01 00 00    	jae    7ad <encode+0x4cd>
     655:	48 39 c2             	cmp    %rax,%rdx
     658:	0f 82 58 01 00 00    	jb     7b6 <encode+0x4d6>
     65e:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
     663:	41 c6 45 00 04       	movb   $0x4,0x0(%r13)
     668:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
     66f:	00 
     670:	4c 89 da             	mov    %r11,%rdx
     673:	4c 89 5c 24 50       	mov    %r11,0x50(%rsp)
     678:	4a 8d 3c 38          	lea    (%rax,%r15,1),%rdi
     67c:	44 89 54 24 28       	mov    %r10d,0x28(%rsp)
     681:	e8 00 00 00 00       	call   686 <encode+0x3a6>
     686:	4c 8b 5c 24 50       	mov    0x50(%rsp),%r11
     68b:	4d 01 df             	add    %r11,%r15
     68e:	48 81 7c 24 40 00 00 	cmpq   $0x0,0x40(%rsp)
     695:	00 00 
     697:	74 0e                	je     6a7 <encode+0x3c7>
     699:	44 8b 54 24 28       	mov    0x28(%rsp),%r10d
     69e:	4b 8d 04 1b          	lea    (%r11,%r11,1),%rax
     6a2:	4c 39 d0             	cmp    %r10,%rax
     6a5:	72 79                	jb     720 <encode+0x440>
     6a7:	4a 8d 94 1c 80 00 00 	lea    0x80(%rsp,%r11,1),%rdx
     6ae:	00 
     6af:	4d 85 db             	test   %r11,%r11
     6b2:	0f 84 7a fd ff ff    	je     432 <encode+0x152>
     6b8:	48 89 54 24 50       	mov    %rdx,0x50(%rsp)
     6bd:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
     6c2:	4d 89 e5             	mov    %r12,%r13
     6c5:	4d 89 f4             	mov    %r14,%r12
     6c8:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
     6cd:	4c 8d b4 24 80 00 00 	lea    0x80(%rsp),%r14
     6d4:	00 
     6d5:	41 0f b6 1e          	movzbl (%r14),%ebx
     6d9:	4b 8d 34 2f          	lea    (%r15,%r13,1),%rsi
     6dd:	4c 89 e7             	mov    %r12,%rdi
     6e0:	48 03 74 24 68       	add    0x68(%rsp),%rsi
     6e5:	49 83 c6 01          	add    $0x1,%r14
     6e9:	49 83 c4 20          	add    $0x20,%r12
     6ed:	89 da                	mov    %ebx,%edx
     6ef:	e8 1c f9 ff ff       	call   10 <pack_scalar>
     6f4:	89 da                	mov    %ebx,%edx
     6f6:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
     6fd:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
     704:	49 01 d5             	add    %rdx,%r13
     707:	4c 39 74 24 50       	cmp    %r14,0x50(%rsp)
     70c:	75 c7                	jne    6d5 <encode+0x3f5>
     70e:	4d 01 ef             	add    %r13,%r15
     711:	4c 8b 74 24 20       	mov    0x20(%rsp),%r14
     716:	4c 8b 6c 24 28       	mov    0x28(%rsp),%r13
     71b:	e9 12 fd ff ff       	jmp    432 <encode+0x152>
     720:	4a 8d 94 1c 80 00 00 	lea    0x80(%rsp,%r11,1),%rdx
     727:	00 
     728:	4d 85 db             	test   %r11,%r11
     72b:	0f 84 01 fd ff ff    	je     432 <encode+0x152>
     731:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
     736:	48 89 54 24 50       	mov    %rdx,0x50(%rsp)
     73b:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
     740:	4d 89 e5             	mov    %r12,%r13
     743:	4c 8d a4 24 80 00 00 	lea    0x80(%rsp),%r12
     74a:	00 
     74b:	41 0f b6 1c 24       	movzbl (%r12),%ebx
     750:	4b 8d 34 2f          	lea    (%r15,%r13,1),%rsi
     754:	4c 89 f7             	mov    %r14,%rdi
     757:	49 83 c4 01          	add    $0x1,%r12
     75b:	48 03 74 24 68       	add    0x68(%rsp),%rsi
     760:	49 83 c6 20          	add    $0x20,%r14
     764:	89 da                	mov    %ebx,%edx
     766:	e8 55 fa ff ff       	call   1c0 <pack_avx2>
     76b:	89 da                	mov    %ebx,%edx
     76d:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
     774:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
     77b:	49 01 d5             	add    %rdx,%r13
     77e:	4c 39 64 24 50       	cmp    %r12,0x50(%rsp)
     783:	75 c6                	jne    74b <encode+0x46b>
     785:	eb 87                	jmp    70e <encode+0x42e>
     787:	41 bd 08 00 00 00    	mov    $0x8,%r13d
     78d:	e9 08 fe ff ff       	jmp    59a <encode+0x2ba>
     792:	31 f6                	xor    %esi,%esi
     794:	bb 04 00 00 00       	mov    $0x4,%ebx
     799:	e9 b7 fd ff ff       	jmp    555 <encode+0x275>
     79e:	be 03 00 00 00       	mov    $0x3,%esi
     7a3:	bb 20 00 00 00       	mov    $0x20,%ebx
     7a8:	e9 a8 fd ff ff       	jmp    555 <encode+0x275>
     7ad:	48 39 da             	cmp    %rbx,%rdx
     7b0:	0f 83 75 fd ff ff    	jae    52b <encode+0x24b>
     7b6:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
     7bb:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     7c0:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
     7c5:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
     7ca:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
     7cf:	e9 3d fe ff ff       	jmp    611 <encode+0x331>
     7d4:	e8 00 00 00 00       	call   7d9 <encode+0x4f9>
     7d9:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     7e0:	e8 00 00 00 00       	call   7e5 <encode+0x505>
     7e5:	e9 7a fd ff ff       	jmp    564 <encode+0x284>
     7ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     7f0:	90                   	nop
     7f1:	90                   	nop
     7f2:	90                   	nop
     7f3:	90                   	nop
     7f4:	90                   	nop
     7f5:	90                   	nop
     7f6:	90                   	nop
     7f7:	90                   	nop
     7f8:	90                   	nop
     7f9:	90                   	nop
     7fa:	90                   	nop
     7fb:	90                   	nop
     7fc:	90                   	nop
     7fd:	90                   	nop
     7fe:	90                   	nop
     7ff:	90                   	nop

0000000000000800 <repeat_avx2>:
     800:	f3 0f 1e fa          	endbr64
     804:	e8 00 00 00 00       	call   809 <repeat_avx2+0x9>
     809:	55                   	push   %rbp
     80a:	48 89 e5             	mov    %rsp,%rbp
     80d:	41 57                	push   %r15
     80f:	41 56                	push   %r14
     811:	49 89 f6             	mov    %rsi,%r14
     814:	41 55                	push   %r13
     816:	41 54                	push   %r12
     818:	53                   	push   %rbx
     819:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
     81d:	48 83 ec 20          	sub    $0x20,%rsp
     821:	83 f9 04             	cmp    $0x4,%ecx
     824:	0f 84 e1 00 00 00    	je     90b <repeat_avx2+0x10b>
     82a:	83 f9 08             	cmp    $0x8,%ecx
     82d:	0f 84 e2 00 00 00    	je     915 <repeat_avx2+0x115>
     833:	83 f9 10             	cmp    $0x10,%ecx
     836:	0f 84 a2 00 00 00    	je     8de <repeat_avx2+0xde>
     83c:	c5 fe 6f 06          	vmovdqu (%rsi),%ymm0
     840:	48 83 fa 1f          	cmp    $0x1f,%rdx
     844:	0f 86 a3 00 00 00    	jbe    8ed <repeat_avx2+0xed>
     84a:	4c 8d 42 e0          	lea    -0x20(%rdx),%r8
     84e:	48 89 f8             	mov    %rdi,%rax
     851:	4c 89 c6             	mov    %r8,%rsi
     854:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
     858:	48 8d 74 37 20       	lea    0x20(%rdi,%rsi,1),%rsi
     85d:	49 89 f1             	mov    %rsi,%r9
     860:	49 29 f9             	sub    %rdi,%r9
     863:	41 83 e1 20          	and    $0x20,%r9d
     867:	74 17                	je     880 <repeat_avx2+0x80>
     869:	48 8d 47 20          	lea    0x20(%rdi),%rax
     86d:	c5 fe 7f 07          	vmovdqu %ymm0,(%rdi)
     871:	48 39 c6             	cmp    %rax,%rsi
     874:	74 1c                	je     892 <repeat_avx2+0x92>
     876:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
     87d:	00 00 00 
     880:	c5 fe 7f 00          	vmovdqu %ymm0,(%rax)
     884:	48 83 c0 40          	add    $0x40,%rax
     888:	c5 fe 7f 40 e0       	vmovdqu %ymm0,-0x20(%rax)
     88d:	48 39 c6             	cmp    %rax,%rsi
     890:	75 ee                	jne    880 <repeat_avx2+0x80>
     892:	49 83 e0 e0          	and    $0xffffffffffffffe0,%r8
     896:	4d 8d 78 20          	lea    0x20(%r8),%r15
     89a:	49 39 d7             	cmp    %rdx,%r15
     89d:	73 56                	jae    8f5 <repeat_avx2+0xf5>
     89f:	89 cb                	mov    %ecx,%ebx
     8a1:	49 89 d5             	mov    %rdx,%r13
     8a4:	49 89 fc             	mov    %rdi,%r12
     8a7:	48 89 d8             	mov    %rbx,%rax
     8aa:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     8af:	c5 f8 77             	vzeroupper
     8b2:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
     8b7:	4b 8d 3c 3c          	lea    (%r12,%r15,1),%rdi
     8bb:	4c 89 f6             	mov    %r14,%rsi
     8be:	49 01 df             	add    %rbx,%r15
     8c1:	e8 00 00 00 00       	call   8c6 <repeat_avx2+0xc6>
     8c6:	4d 39 ef             	cmp    %r13,%r15
     8c9:	72 e7                	jb     8b2 <repeat_avx2+0xb2>
     8cb:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     8cf:	5b                   	pop    %rbx
     8d0:	41 5c                	pop    %r12
     8d2:	41 5d                	pop    %r13
     8d4:	41 5e                	pop    %r14
     8d6:	41 5f                	pop    %r15
     8d8:	5d                   	pop    %rbp
     8d9:	e9 00 00 00 00       	jmp    8de <repeat_avx2+0xde>
     8de:	c4 e2 7d 5a 06       	vbroadcasti128 (%rsi),%ymm0
     8e3:	48 83 fa 1f          	cmp    $0x1f,%rdx
     8e7:	0f 87 5d ff ff ff    	ja     84a <repeat_avx2+0x4a>
     8ed:	45 31 ff             	xor    %r15d,%r15d
     8f0:	49 39 d7             	cmp    %rdx,%r15
     8f3:	72 aa                	jb     89f <repeat_avx2+0x9f>
     8f5:	c5 f8 77             	vzeroupper
     8f8:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
     8fc:	5b                   	pop    %rbx
     8fd:	41 5c                	pop    %r12
     8ff:	41 5d                	pop    %r13
     901:	41 5e                	pop    %r14
     903:	41 5f                	pop    %r15
     905:	5d                   	pop    %rbp
     906:	e9 00 00 00 00       	jmp    90b <repeat_avx2+0x10b>
     90b:	c4 e2 7d 58 06       	vpbroadcastd (%rsi),%ymm0
     910:	e9 2b ff ff ff       	jmp    840 <repeat_avx2+0x40>
     915:	c4 e2 7d 59 06       	vpbroadcastq (%rsi),%ymm0
     91a:	e9 21 ff ff ff       	jmp    840 <repeat_avx2+0x40>
     91f:	90                   	nop
     920:	90                   	nop
     921:	90                   	nop
     922:	90                   	nop
     923:	90                   	nop
     924:	90                   	nop
     925:	90                   	nop
     926:	90                   	nop
     927:	90                   	nop
     928:	90                   	nop
     929:	90                   	nop
     92a:	90                   	nop
     92b:	90                   	nop
     92c:	90                   	nop
     92d:	90                   	nop
     92e:	90                   	nop
     92f:	90                   	nop

0000000000000930 <unpack_scalar>:
     930:	f3 0f 1e fa          	endbr64
     934:	e8 00 00 00 00       	call   939 <unpack_scalar+0x9>
     939:	f6 c2 01             	test   $0x1,%dl
     93c:	0f 85 bc 00 00 00    	jne    9fe <unpack_scalar+0xce>
     942:	c7 06 00 00 00 00    	movl   $0x0,(%rsi)
     948:	f6 c2 02             	test   $0x2,%dl
     94b:	0f 85 9f 00 00 00    	jne    9f0 <unpack_scalar+0xc0>
     951:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%rsi)
     958:	f6 c2 04             	test   $0x4,%dl
     95b:	0f 85 81 00 00 00    	jne    9e2 <unpack_scalar+0xb2>
     961:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%rsi)
     968:	f6 c2 08             	test   $0x8,%dl
     96b:	75 6a                	jne    9d7 <unpack_scalar+0xa7>
     96d:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%rsi)
     974:	f6 c2 10             	test   $0x10,%dl
     977:	75 53                	jne    9cc <unpack_scalar+0x9c>
     979:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%rsi)
     980:	f6 c2 20             	test   $0x20,%dl
     983:	75 3c                	jne    9c1 <unpack_scalar+0x91>
     985:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%rsi)
     98c:	f6 c2 40             	test   $0x40,%dl
     98f:	75 25                	jne    9b6 <unpack_scalar+0x86>
     991:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%rsi)
     998:	81 e2 80 00 00 00    	and    $0x80,%edx
     99e:	74 0a                	je     9aa <unpack_scalar+0x7a>
     9a0:	8b 07                	mov    (%rdi),%eax
     9a2:	89 46 1c             	mov    %eax,0x1c(%rsi)
     9a5:	e9 00 00 00 00       	jmp    9aa <unpack_scalar+0x7a>
     9aa:	c7 46 1c 00 00 00 00 	movl   $0x0,0x1c(%rsi)
     9b1:	e9 00 00 00 00       	jmp    9b6 <unpack_scalar+0x86>
     9b6:	8b 07                	mov    (%rdi),%eax
     9b8:	48 83 c7 04          	add    $0x4,%rdi
     9bc:	89 46 18             	mov    %eax,0x18(%rsi)
     9bf:	eb d7                	jmp    998 <unpack_scalar+0x68>
     9c1:	8b 07                	mov    (%rdi),%eax
     9c3:	48 83 c7 04          	add    $0x4,%rdi
     9c7:	89 46 14             	mov    %eax,0x14(%rsi)
     9ca:	eb c0                	jmp    98c <unpack_scalar+0x5c>
     9cc:	8b 07                	mov    (%rdi),%eax
     9ce:	48 83 c7 04          	add    $0x4,%rdi
     9d2:	89 46 10             	mov    %eax,0x10(%rsi)
     9d5:	eb a9                	jmp    980 <unpack_scalar+0x50>
     9d7:	8b 07                	mov    (%rdi),%eax
     9d9:	48 83 c7 04          	add    $0x4,%rdi
     9dd:	89 46 0c             	mov    %eax,0xc(%rsi)
     9e0:	eb 92                	jmp    974 <unpack_scalar+0x44>
     9e2:	8b 07                	mov    (%rdi),%eax
     9e4:	48 83 c7 04          	add    $0x4,%rdi
     9e8:	89 46 08             	mov    %eax,0x8(%rsi)
     9eb:	e9 78 ff ff ff       	jmp    968 <unpack_scalar+0x38>
     9f0:	8b 07                	mov    (%rdi),%eax
     9f2:	48 83 c7 04          	add    $0x4,%rdi
     9f6:	89 46 04             	mov    %eax,0x4(%rsi)
     9f9:	e9 5a ff ff ff       	jmp    958 <unpack_scalar+0x28>
     9fe:	8b 07                	mov    (%rdi),%eax
     a00:	48 83 c7 04          	add    $0x4,%rdi
     a04:	89 06                	mov    %eax,(%rsi)
     a06:	e9 3d ff ff ff       	jmp    948 <unpack_scalar+0x18>
     a0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     a10:	90                   	nop
     a11:	90                   	nop
     a12:	90                   	nop
     a13:	90                   	nop
     a14:	90                   	nop
     a15:	90                   	nop
     a16:	90                   	nop
     a17:	90                   	nop
     a18:	90                   	nop
     a19:	90                   	nop
     a1a:	90                   	nop
     a1b:	90                   	nop
     a1c:	90                   	nop
     a1d:	90                   	nop
     a1e:	90                   	nop
     a1f:	90                   	nop

0000000000000a20 <decode>:
     a20:	e8 00 00 00 00       	call   a25 <decode+0x5>
     a25:	48 8d 46 f8          	lea    -0x8(%rsi),%rax
     a29:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
     a2f:	0f 87 c4 03 00 00    	ja     df9 <decode+0x3d9>
     a35:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
     a39:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
     a3e:	49 89 fc             	mov    %rdi,%r12
     a41:	48 85 ff             	test   %rdi,%rdi
     a44:	0f 84 9e 02 00 00    	je     ce8 <decode+0x2c8>
     a4a:	81 3f 47 5a 52 31    	cmpl   $0x31525a47,(%rdi)
     a50:	0f 85 92 02 00 00    	jne    ce8 <decode+0x2c8>
     a56:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
     a5b:	48 89 d5             	mov    %rdx,%rbp
     a5e:	48 89 ca             	mov    %rcx,%rdx
     a61:	0f b6 4f 06          	movzbl 0x6(%rdi),%ecx
     a65:	8d 41 fb             	lea    -0x5(%rcx),%eax
     a68:	3c 07                	cmp    $0x7,%al
     a6a:	0f 87 77 03 00 00    	ja     de7 <decode+0x3c7>
     a70:	4c 89 cf             	mov    %r9,%rdi
     a73:	45 0f b6 4c 24 07    	movzbl 0x7(%r12),%r9d
     a79:	41 80 f9 01          	cmp    $0x1,%r9b
     a7d:	0f 87 64 03 00 00    	ja     de7 <decode+0x3c7>
     a83:	41 ba 00 10 00 00    	mov    $0x1000,%r10d
     a89:	4c 89 7c 24 78       	mov    %r15,0x78(%rsp)
     a8e:	41 0f b7 44 24 04    	movzwl 0x4(%r12),%eax
     a94:	4c 39 d2             	cmp    %r10,%rdx
     a97:	49 0f 47 d2          	cmova  %r10,%rdx
     a9b:	49 89 c7             	mov    %rax,%r15
     a9e:	48 39 c2             	cmp    %rax,%rdx
     aa1:	0f 82 f3 02 00 00    	jb     d9a <decode+0x37a>
     aa7:	48 85 ed             	test   %rbp,%rbp
     aaa:	75 09                	jne    ab5 <decode+0x95>
     aac:	48 85 c0             	test   %rax,%rax
     aaf:	0f 85 e5 02 00 00    	jne    d9a <decode+0x37a>
     ab5:	45 84 c9             	test   %r9b,%r9b
     ab8:	0f 85 df 01 00 00    	jne    c9d <decode+0x27d>
     abe:	41 bb 01 00 00 00    	mov    $0x1,%r11d
     ac4:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
     ac9:	49 d3 e3             	shl    %cl,%r11
     acc:	48 89 5c 24 50       	mov    %rbx,0x50(%rsp)
     ad1:	4e 8d 6c 18 ff       	lea    -0x1(%rax,%r11,1),%r13
     ad6:	49 d3 ed             	shr    %cl,%r13
     ad9:	49 8d 5d 08          	lea    0x8(%r13),%rbx
     add:	48 39 de             	cmp    %rbx,%rsi
     ae0:	0f 82 24 03 00 00    	jb     e0a <decode+0x3ea>
     ae6:	4d 85 ed             	test   %r13,%r13
     ae9:	0f 84 14 03 00 00    	je     e03 <decode+0x3e3>
     aef:	48 01 e8             	add    %rbp,%rax
     af2:	4c 89 74 24 70       	mov    %r14,0x70(%rsp)
     af7:	4d 8d 74 24 08       	lea    0x8(%r12),%r14
     afc:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     b01:	4b 8d 0c 2e          	lea    (%r14,%r13,1),%rcx
     b05:	48 89 d8             	mov    %rbx,%rax
     b08:	48 89 eb             	mov    %rbp,%rbx
     b0b:	66 44 89 7c 24 4e    	mov    %r15w,0x4e(%rsp)
     b11:	48 89 c5             	mov    %rax,%rbp
     b14:	4d 89 df             	mov    %r11,%r15
     b17:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
     b1c:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
     b21:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
     b26:	4c 89 24 24          	mov    %r12,(%rsp)
     b2a:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
     b2f:	eb 49                	jmp    b7a <decode+0x15a>
     b31:	3c 01                	cmp    $0x1,%al
     b33:	0f 84 3a 02 00 00    	je     d73 <decode+0x353>
     b39:	3c 02                	cmp    $0x2,%al
     b3b:	0f 84 25 02 00 00    	je     d66 <decode+0x346>
     b41:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
     b46:	48 29 e8             	sub    %rbp,%rax
     b49:	4c 39 e8             	cmp    %r13,%rax
     b4c:	0f 82 7d 01 00 00    	jb     ccf <decode+0x2af>
     b52:	48 8b 04 24          	mov    (%rsp),%rax
     b56:	48 89 df             	mov    %rbx,%rdi
     b59:	4c 89 ea             	mov    %r13,%rdx
     b5c:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
     b60:	4c 01 ed             	add    %r13,%rbp
     b63:	e8 00 00 00 00       	call   b68 <decode+0x148>
     b68:	49 83 c6 01          	add    $0x1,%r14
     b6c:	4c 01 fb             	add    %r15,%rbx
     b6f:	4c 3b 74 24 18       	cmp    0x18(%rsp),%r14
     b74:	0f 84 2f 02 00 00    	je     da9 <decode+0x389>
     b7a:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
     b7f:	41 0f b6 06          	movzbl (%r14),%eax
     b83:	49 29 dd             	sub    %rbx,%r13
     b86:	4d 39 fd             	cmp    %r15,%r13
     b89:	4d 0f 47 ef          	cmova  %r15,%r13
     b8d:	3c 03                	cmp    $0x3,%al
     b8f:	0f 84 66 01 00 00    	je     cfb <decode+0x2db>
     b95:	76 9a                	jbe    b31 <decode+0x111>
     b97:	3c 05                	cmp    $0x5,%al
     b99:	0f 84 ba 01 00 00    	je     d59 <decode+0x339>
     b9f:	3c 06                	cmp    $0x6,%al
     ba1:	0f 84 a5 01 00 00    	je     d4c <decode+0x32c>
     ba7:	3c 04                	cmp    $0x4,%al
     ba9:	0f 85 20 01 00 00    	jne    ccf <decode+0x2af>
     baf:	4c 89 e9             	mov    %r13,%rcx
     bb2:	83 e1 1f             	and    $0x1f,%ecx
     bb5:	0f 85 14 01 00 00    	jne    ccf <decode+0x2af>
     bbb:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
     bc0:	49 c1 ed 05          	shr    $0x5,%r13
     bc4:	48 29 e8             	sub    %rbp,%rax
     bc7:	4c 39 e8             	cmp    %r13,%rax
     bca:	0f 82 ff 00 00 00    	jb     ccf <decode+0x2af>
     bd0:	4a 8d 74 2d 00       	lea    0x0(%rbp,%r13,1),%rsi
     bd5:	4d 85 ed             	test   %r13,%r13
     bd8:	0f 84 13 02 00 00    	je     df1 <decode+0x3d1>
     bde:	48 8b 04 24          	mov    (%rsp),%rax
     be2:	48 01 e8             	add    %rbp,%rax
     be5:	4a 8d 14 28          	lea    (%rax,%r13,1),%rdx
     be9:	49 89 c0             	mov    %rax,%r8
     bec:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     bf3:	00 00 
     bf5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     bfc:	00 00 00 00 
     c00:	41 0f b6 38          	movzbl (%r8),%edi
     c04:	49 83 c0 01          	add    $0x1,%r8
     c08:	0f b6 bf 00 00 00 00 	movzbl 0x0(%rdi),%edi
     c0f:	8d 3c bd 00 00 00 00 	lea    0x0(,%rdi,4),%edi
     c16:	48 01 f9             	add    %rdi,%rcx
     c19:	49 39 d0             	cmp    %rdx,%r8
     c1c:	75 e2                	jne    c00 <decode+0x1e0>
     c1e:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
     c23:	49 29 f0             	sub    %rsi,%r8
     c26:	49 39 c8             	cmp    %rcx,%r8
     c29:	0f 82 a0 00 00 00    	jb     ccf <decode+0x2af>
     c2f:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
     c34:	4c 8b 64 24 30       	mov    0x30(%rsp),%r12
     c39:	48 89 c5             	mov    %rax,%rbp
     c3c:	49 89 d5             	mov    %rdx,%r13
     c3f:	4c 89 74 24 38       	mov    %r14,0x38(%rsp)
     c44:	49 89 f6             	mov    %rsi,%r14
     c47:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
     c4c:	49 89 df             	mov    %rbx,%r15
     c4f:	0f b6 5d 00          	movzbl 0x0(%rbp),%ebx
     c53:	48 8b 04 24          	mov    (%rsp),%rax
     c57:	4c 89 fe             	mov    %r15,%rsi
     c5a:	48 83 c5 01          	add    $0x1,%rbp
     c5e:	49 83 c7 20          	add    $0x20,%r15
     c62:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
     c66:	89 da                	mov    %ebx,%edx
     c68:	2e e8 00 00 00 00    	cs call c6e <decode+0x24e>
     c6e:	89 da                	mov    %ebx,%edx
     c70:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
     c77:	8d 14 95 00 00 00 00 	lea    0x0(,%rdx,4),%edx
     c7e:	49 01 d6             	add    %rdx,%r14
     c81:	4c 39 ed             	cmp    %r13,%rbp
     c84:	75 c9                	jne    c4f <decode+0x22f>
     c86:	4c 89 f5             	mov    %r14,%rbp
     c89:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
     c8e:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
     c93:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
     c98:	e9 cb fe ff ff       	jmp    b68 <decode+0x148>
     c9d:	48 8d 50 08          	lea    0x8(%rax),%rdx
     ca1:	48 39 f2             	cmp    %rsi,%rdx
     ca4:	0f 85 f0 00 00 00    	jne    d9a <decode+0x37a>
     caa:	48 85 c0             	test   %rax,%rax
     cad:	0f 85 d2 00 00 00    	jne    d85 <decode+0x365>
     cb3:	41 0f b7 c7          	movzwl %r15w,%eax
     cb7:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     cbc:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     cc1:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
     cc6:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
     cca:	e9 00 00 00 00       	jmp    ccf <decode+0x2af>
     ccf:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
     cd4:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     cd9:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
     cde:	4c 8b 74 24 70       	mov    0x70(%rsp),%r14
     ce3:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     ce8:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
     ced:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     cf2:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
     cf6:	e9 00 00 00 00       	jmp    cfb <decode+0x2db>
     cfb:	41 ba 08 00 00 00    	mov    $0x8,%r10d
     d01:	b9 08 00 00 00       	mov    $0x8,%ecx
     d06:	4c 89 e8             	mov    %r13,%rax
     d09:	31 d2                	xor    %edx,%edx
     d0b:	49 f7 f2             	div    %r10
     d0e:	48 85 d2             	test   %rdx,%rdx
     d11:	75 bc                	jne    ccf <decode+0x2af>
     d13:	4d 39 d5             	cmp    %r10,%r13
     d16:	72 b7                	jb     ccf <decode+0x2af>
     d18:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
     d1d:	48 29 e8             	sub    %rbp,%rax
     d20:	4c 39 d0             	cmp    %r10,%rax
     d23:	72 aa                	jb     ccf <decode+0x2af>
     d25:	48 8b 04 24          	mov    (%rsp),%rax
     d29:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
     d2e:	4c 89 ea             	mov    %r13,%rdx
     d31:	48 89 df             	mov    %rbx,%rdi
     d34:	48 8d 34 28          	lea    (%rax,%rbp,1),%rsi
     d38:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
     d3d:	e8 00 00 00 00       	call   d42 <decode+0x322>
     d42:	48 03 6c 24 20       	add    0x20(%rsp),%rbp
     d47:	e9 1c fe ff ff       	jmp    b68 <decode+0x148>
     d4c:	41 ba 20 00 00 00    	mov    $0x20,%r10d
     d52:	b9 20 00 00 00       	mov    $0x20,%ecx
     d57:	eb ad                	jmp    d06 <decode+0x2e6>
     d59:	41 ba 10 00 00 00    	mov    $0x10,%r10d
     d5f:	b9 10 00 00 00       	mov    $0x10,%ecx
     d64:	eb a0                	jmp    d06 <decode+0x2e6>
     d66:	41 ba 04 00 00 00    	mov    $0x4,%r10d
     d6c:	b9 04 00 00 00       	mov    $0x4,%ecx
     d71:	eb 93                	jmp    d06 <decode+0x2e6>
     d73:	4c 89 ea             	mov    %r13,%rdx
     d76:	31 f6                	xor    %esi,%esi
     d78:	48 89 df             	mov    %rbx,%rdi
     d7b:	e8 00 00 00 00       	call   d80 <decode+0x360>
     d80:	e9 e3 fd ff ff       	jmp    b68 <decode+0x148>
     d85:	49 8d 74 24 08       	lea    0x8(%r12),%rsi
     d8a:	48 89 ef             	mov    %rbp,%rdi
     d8d:	48 89 c2             	mov    %rax,%rdx
     d90:	e8 00 00 00 00       	call   d95 <decode+0x375>
     d95:	e9 19 ff ff ff       	jmp    cb3 <decode+0x293>
     d9a:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     d9f:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     da4:	e9 3f ff ff ff       	jmp    ce8 <decode+0x2c8>
     da9:	44 0f b7 7c 24 4e    	movzwl 0x4e(%rsp),%r15d
     daf:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     db4:	48 89 eb             	mov    %rbp,%rbx
     db7:	4c 8b 74 24 70       	mov    0x70(%rsp),%r14
     dbc:	48 39 de             	cmp    %rbx,%rsi
     dbf:	75 49                	jne    e0a <decode+0x3ea>
     dc1:	41 0f b7 c7          	movzwl %r15w,%eax
     dc5:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
     dca:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     dcf:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
     dd4:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     dd9:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
     dde:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
     de2:	e9 00 00 00 00       	jmp    de7 <decode+0x3c7>
     de7:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     dec:	e9 f7 fe ff ff       	jmp    ce8 <decode+0x2c8>
     df1:	48 89 f5             	mov    %rsi,%rbp
     df4:	e9 6f fd ff ff       	jmp    b68 <decode+0x148>
     df9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     dfe:	e9 00 00 00 00       	jmp    e03 <decode+0x3e3>
     e03:	bb 08 00 00 00       	mov    $0x8,%ebx
     e08:	eb b2                	jmp    dbc <decode+0x39c>
     e0a:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
     e0f:	48 8b 6c 24 58       	mov    0x58(%rsp),%rbp
     e14:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
     e19:	4c 8b 7c 24 78       	mov    0x78(%rsp),%r15
     e1e:	e9 c5 fe ff ff       	jmp    ce8 <decode+0x2c8>
     e23:	66 90                	xchg   %ax,%ax
     e25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     e2c:	00 00 00 00 
     e30:	90                   	nop
     e31:	90                   	nop
     e32:	90                   	nop
     e33:	90                   	nop
     e34:	90                   	nop
     e35:	90                   	nop
     e36:	90                   	nop
     e37:	90                   	nop
     e38:	90                   	nop
     e39:	90                   	nop
     e3a:	90                   	nop
     e3b:	90                   	nop
     e3c:	90                   	nop
     e3d:	90                   	nop
     e3e:	90                   	nop
     e3f:	90                   	nop

0000000000000e40 <unpack_avx2>:
     e40:	f3 0f 1e fa          	endbr64
     e44:	e8 00 00 00 00       	call   e49 <unpack_avx2+0x9>
     e49:	55                   	push   %rbp
     e4a:	48 89 f9             	mov    %rdi,%rcx
     e4d:	48 89 e5             	mov    %rsp,%rbp
     e50:	41 55                	push   %r13
     e52:	49 89 f5             	mov    %rsi,%r13
     e55:	41 54                	push   %r12
     e57:	41 89 d4             	mov    %edx,%r12d
     e5a:	53                   	push   %rbx
     e5b:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
     e5f:	48 83 ec 60          	sub    $0x60,%rsp
     e63:	65 48 8b 1d 00 00 00 	mov    %gs:0x0(%rip),%rbx        # e6b <unpack_avx2+0x2b>
     e6a:	00 
     e6b:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
     e70:	4c 89 e3             	mov    %r12,%rbx
     e73:	41 81 fc ff 00 00 00 	cmp    $0xff,%r12d
     e7a:	0f 87 99 00 00 00    	ja     f19 <unpack_avx2+0xd9>
     e80:	41 0f b6 84 24 00 00 	movzbl 0x0(%r12),%eax
     e87:	00 00 
     e89:	8d 14 85 00 00 00 00 	lea    0x0(,%rax,4),%edx
     e90:	83 fa 20             	cmp    $0x20,%edx
     e93:	0f 87 00 00 00 00    	ja     e99 <unpack_avx2+0x59>
     e99:	c5 f9 ef c0          	vpxor  %xmm0,%xmm0,%xmm0
     e9d:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
     ea2:	48 89 ce             	mov    %rcx,%rsi
     ea5:	c5 fe 7f 44 24 30    	vmovdqu %ymm0,0x30(%rsp)
     eab:	c5 f8 77             	vzeroupper
     eae:	e8 00 00 00 00       	call   eb3 <unpack_avx2+0x73>
     eb3:	49 81 fc 01 01 00 00 	cmp    $0x101,%r12
     eba:	c5 fe 6f 54 24 30    	vmovdqu 0x30(%rsp),%ymm2
     ec0:	c5 f1 ef c9          	vpxor  %xmm1,%xmm1,%xmm1
     ec4:	73 6f                	jae    f35 <unpack_avx2+0xf5>
     ec6:	49 c1 e4 05          	shl    $0x5,%r12
     eca:	c4 c1 7d 6f 84 24 00 	vmovdqa 0x0(%r12),%ymm0
     ed1:	00 00 00 
     ed4:	c4 e2 7d 36 d2       	vpermd %ymm2,%ymm0,%ymm2
     ed9:	c5 f9 6e c3          	vmovd  %ebx,%xmm0
     edd:	c4 e2 7d 58 c0       	vpbroadcastd %xmm0,%ymm0
     ee2:	c5 fd db 05 00 00 00 	vpand  0x0(%rip),%ymm0,%ymm0        # eea <unpack_avx2+0xaa>
     ee9:	00 
     eea:	c5 fd 76 c1          	vpcmpeqd %ymm1,%ymm0,%ymm0
     eee:	c5 fd df c2          	vpandn %ymm2,%ymm0,%ymm0
     ef2:	c4 c1 7e 7f 45 00    	vmovdqu %ymm0,0x0(%r13)
     ef8:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
     efd:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # f05 <unpack_avx2+0xc5>
     f04:	00 
     f05:	75 53                	jne    f5a <unpack_avx2+0x11a>
     f07:	c5 f8 77             	vzeroupper
     f0a:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
     f0e:	5b                   	pop    %rbx
     f0f:	41 5c                	pop    %r12
     f11:	41 5d                	pop    %r13
     f13:	5d                   	pop    %rbp
     f14:	e9 00 00 00 00       	jmp    f19 <unpack_avx2+0xd9>
     f19:	48 89 3c 24          	mov    %rdi,(%rsp)
     f1d:	4c 89 e6             	mov    %r12,%rsi
     f20:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     f27:	e8 00 00 00 00       	call   f2c <unpack_avx2+0xec>
     f2c:	48 8b 0c 24          	mov    (%rsp),%rcx
     f30:	e9 4b ff ff ff       	jmp    e80 <unpack_avx2+0x40>
     f35:	c5 fd 7f 14 24       	vmovdqa %ymm2,(%rsp)
     f3a:	4c 89 e6             	mov    %r12,%rsi
     f3d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     f44:	c5 f8 77             	vzeroupper
     f47:	e8 00 00 00 00       	call   f4c <unpack_avx2+0x10c>
     f4c:	c5 f1 ef c9          	vpxor  %xmm1,%xmm1,%xmm1
     f50:	c5 fd 6f 14 24       	vmovdqa (%rsp),%ymm2
     f55:	e9 6c ff ff ff       	jmp    ec6 <unpack_avx2+0x86>
     f5a:	c5 f8 77             	vzeroupper
     f5d:	e8 00 00 00 00       	call   f62 <unpack_avx2+0x122>
     f62:	0f 1f 00             	nopl   (%rax)
     f65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     f6c:	00 00 00 00 
     f70:	90                   	nop
     f71:	90                   	nop
     f72:	90                   	nop
     f73:	90                   	nop
     f74:	90                   	nop
     f75:	90                   	nop
     f76:	90                   	nop
     f77:	90                   	nop
     f78:	90                   	nop
     f79:	90                   	nop
     f7a:	90                   	nop
     f7b:	90                   	nop
     f7c:	90                   	nop
     f7d:	90                   	nop
     f7e:	90                   	nop
     f7f:	90                   	nop

0000000000000f80 <scan_scalar>:
     f80:	f3 0f 1e fa          	endbr64
     f84:	e8 00 00 00 00       	call   f89 <scan_scalar+0x9>
     f89:	55                   	push   %rbp
     f8a:	48 89 e5             	mov    %rsp,%rbp
     f8d:	41 55                	push   %r13
     f8f:	41 54                	push   %r12
     f91:	53                   	push   %rbx
     f92:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
     f96:	48 83 ec 40          	sub    $0x40,%rsp
     f9a:	4c 8b 17             	mov    (%rdi),%r10
     f9d:	4c 8b 5f 08          	mov    0x8(%rdi),%r11
     fa1:	65 4c 8b 05 00 00 00 	mov    %gs:0x0(%rip),%r8        # fa9 <scan_scalar+0x29>
     fa8:	00 
     fa9:	4c 89 44 24 38       	mov    %r8,0x38(%rsp)
     fae:	49 89 d0             	mov    %rdx,%r8
     fb1:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
     fb5:	4c 8b 67 18          	mov    0x18(%rdi),%r12
     fb9:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
     fbe:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
     fc3:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
     fc8:	4c 89 64 24 28       	mov    %r12,0x28(%rsp)
     fcd:	4d 39 d3             	cmp    %r10,%r11
     fd0:	0f 84 e0 01 00 00    	je     11b6 <scan_scalar+0x236>
     fd6:	4c 39 d3             	cmp    %r10,%rbx
     fd9:	0f 84 e2 00 00 00    	je     10c1 <scan_scalar+0x141>
     fdf:	41 b9 1f 00 00 00    	mov    $0x1f,%r9d
     fe5:	b8 20 00 00 00       	mov    $0x20,%eax
     fea:	41 bd 20 00 00 00    	mov    $0x20,%r13d
     ff0:	48 39 f0             	cmp    %rsi,%rax
     ff3:	0f 83 33 02 00 00    	jae    122c <scan_scalar+0x2ac>
     ff9:	48 83 fe 20          	cmp    $0x20,%rsi
     ffd:	0f 86 20 02 00 00    	jbe    1223 <scan_scalar+0x2a3>
    1003:	b8 20 00 00 00       	mov    $0x20,%eax
    1008:	eb 3f                	jmp    1049 <scan_scalar+0xc9>
    100a:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    1011:	00 00 00 
    1014:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    101b:	00 00 00 00 
    101f:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1026:	00 00 00 00 
    102a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1031:	00 00 00 00 
    1035:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    103c:	00 00 00 00 
    1040:	48 39 ca             	cmp    %rcx,%rdx
    1043:	0f 85 97 00 00 00    	jne    10e0 <scan_scalar+0x160>
    1049:	48 89 c2             	mov    %rax,%rdx
    104c:	48 8b 0c 07          	mov    (%rdi,%rax,1),%rcx
    1050:	48 83 c0 08          	add    $0x8,%rax
    1054:	4c 21 ca             	and    %r9,%rdx
    1057:	48 c1 ea 03          	shr    $0x3,%rdx
    105b:	48 8b 54 d4 10       	mov    0x10(%rsp,%rdx,8),%rdx
    1060:	48 39 f0             	cmp    %rsi,%rax
    1063:	72 db                	jb     1040 <scan_scalar+0xc0>
    1065:	48 39 ca             	cmp    %rcx,%rdx
    1068:	75 76                	jne    10e0 <scan_scalar+0x160>
    106a:	4d 85 d2             	test   %r10,%r10
    106d:	0f 84 6b 01 00 00    	je     11de <scan_scalar+0x25e>
    1073:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
    107a:	01 00 00 00 
    107e:	41 83 fd 08          	cmp    $0x8,%r13d
    1082:	0f 84 c1 01 00 00    	je     1249 <scan_scalar+0x2c9>
    1088:	31 c0                	xor    %eax,%eax
    108a:	41 83 fd 10          	cmp    $0x10,%r13d
    108e:	0f 95 c0             	setne  %al
    1091:	8d 04 85 04 00 00 00 	lea    0x4(,%rax,4),%eax
    1098:	41 89 80 84 00 00 00 	mov    %eax,0x84(%r8)
    109f:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    10a4:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 10ac <scan_scalar+0x12c>
    10ab:	00 
    10ac:	0f 85 d3 01 00 00    	jne    1285 <scan_scalar+0x305>
    10b2:	48 8d 65 e8          	lea    -0x18(%rbp),%rsp
    10b6:	5b                   	pop    %rbx
    10b7:	41 5c                	pop    %r12
    10b9:	41 5d                	pop    %r13
    10bb:	5d                   	pop    %rbp
    10bc:	e9 00 00 00 00       	jmp    10c1 <scan_scalar+0x141>
    10c1:	4d 39 dc             	cmp    %r11,%r12
    10c4:	0f 85 15 ff ff ff    	jne    fdf <scan_scalar+0x5f>
    10ca:	41 b9 0f 00 00 00    	mov    $0xf,%r9d
    10d0:	b8 10 00 00 00       	mov    $0x10,%eax
    10d5:	41 bd 10 00 00 00    	mov    $0x10,%r13d
    10db:	e9 10 ff ff ff       	jmp    ff0 <scan_scalar+0x70>
    10e0:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
    10e7:	00 00 00 00 
    10eb:	48 89 f3             	mov    %rsi,%rbx
    10ee:	48 c1 eb 05          	shr    $0x5,%rbx
    10f2:	49 89 fd             	mov    %rdi,%r13
    10f5:	45 31 e4             	xor    %r12d,%r12d
    10f8:	41 8b 45 04          	mov    0x4(%r13),%eax
    10fc:	31 d2                	xor    %edx,%edx
    10fe:	41 8b 4d 08          	mov    0x8(%r13),%ecx
    1102:	41 8b 7d 00          	mov    0x0(%r13),%edi
    1106:	45 8b 4d 0c          	mov    0xc(%r13),%r9d
    110a:	85 c0                	test   %eax,%eax
    110c:	45 8b 55 10          	mov    0x10(%r13),%r10d
    1110:	45 8b 5d 14          	mov    0x14(%r13),%r11d
    1114:	0f 95 c2             	setne  %dl
    1117:	31 f6                	xor    %esi,%esi
    1119:	41 8b 45 18          	mov    0x18(%r13),%eax
    111d:	01 d2                	add    %edx,%edx
    111f:	85 c9                	test   %ecx,%ecx
    1121:	40 0f 95 c6          	setne  %sil
    1125:	c1 e6 02             	shl    $0x2,%esi
    1128:	09 f2                	or     %esi,%edx
    112a:	31 f6                	xor    %esi,%esi
    112c:	85 ff                	test   %edi,%edi
    112e:	40 0f 95 c6          	setne  %sil
    1132:	09 f2                	or     %esi,%edx
    1134:	31 f6                	xor    %esi,%esi
    1136:	45 85 c9             	test   %r9d,%r9d
    1139:	40 0f 95 c6          	setne  %sil
    113d:	c1 e6 03             	shl    $0x3,%esi
    1140:	09 f2                	or     %esi,%edx
    1142:	31 f6                	xor    %esi,%esi
    1144:	45 85 d2             	test   %r10d,%r10d
    1147:	40 0f 95 c6          	setne  %sil
    114b:	c1 e6 04             	shl    $0x4,%esi
    114e:	09 d6                	or     %edx,%esi
    1150:	31 d2                	xor    %edx,%edx
    1152:	45 85 db             	test   %r11d,%r11d
    1155:	0f 95 c2             	setne  %dl
    1158:	c1 e2 05             	shl    $0x5,%edx
    115b:	09 f2                	or     %esi,%edx
    115d:	31 f6                	xor    %esi,%esi
    115f:	85 c0                	test   %eax,%eax
    1161:	41 8b 45 1c          	mov    0x1c(%r13),%eax
    1165:	40 0f 95 c6          	setne  %sil
    1169:	c1 e6 06             	shl    $0x6,%esi
    116c:	09 d6                	or     %edx,%esi
    116e:	31 d2                	xor    %edx,%edx
    1170:	85 c0                	test   %eax,%eax
    1172:	0f 95 c2             	setne  %dl
    1175:	c1 e2 07             	shl    $0x7,%edx
    1178:	09 f2                	or     %esi,%edx
    117a:	49 81 fc 80 00 00 00 	cmp    $0x80,%r12
    1181:	0f 83 da 00 00 00    	jae    1261 <scan_scalar+0x2e1>
    1187:	43 88 14 20          	mov    %dl,(%r8,%r12,1)
    118b:	0f b6 92 00 00 00 00 	movzbl 0x0(%rdx),%edx
    1192:	49 83 c4 01          	add    $0x1,%r12
    1196:	49 83 c5 20          	add    $0x20,%r13
    119a:	41 03 90 80 00 00 00 	add    0x80(%r8),%edx
    11a1:	41 89 90 80 00 00 00 	mov    %edx,0x80(%r8)
    11a8:	49 39 dc             	cmp    %rbx,%r12
    11ab:	0f 85 47 ff ff ff    	jne    10f8 <scan_scalar+0x178>
    11b1:	e9 e9 fe ff ff       	jmp    109f <scan_scalar+0x11f>
    11b6:	4c 39 db             	cmp    %r11,%rbx
    11b9:	0f 85 20 fe ff ff    	jne    fdf <scan_scalar+0x5f>
    11bf:	49 39 dc             	cmp    %rbx,%r12
    11c2:	0f 85 17 fe ff ff    	jne    fdf <scan_scalar+0x5f>
    11c8:	41 b9 07 00 00 00    	mov    $0x7,%r9d
    11ce:	b8 08 00 00 00       	mov    $0x8,%eax
    11d3:	41 bd 08 00 00 00    	mov    $0x8,%r13d
    11d9:	e9 12 fe ff ff       	jmp    ff0 <scan_scalar+0x70>
    11de:	4d 85 db             	test   %r11,%r11
    11e1:	75 29                	jne    120c <scan_scalar+0x28c>
    11e3:	48 85 db             	test   %rbx,%rbx
    11e6:	75 24                	jne    120c <scan_scalar+0x28c>
    11e8:	4d 85 e4             	test   %r12,%r12
    11eb:	75 1f                	jne    120c <scan_scalar+0x28c>
    11ed:	41 c7 80 80 00 00 00 	movl   $0x0,0x80(%r8)
    11f4:	00 00 00 00 
    11f8:	41 83 fd 08          	cmp    $0x8,%r13d
    11fc:	0f 85 86 fe ff ff    	jne    1088 <scan_scalar+0x108>
    1202:	b8 01 00 00 00       	mov    $0x1,%eax
    1207:	e9 8c fe ff ff       	jmp    1098 <scan_scalar+0x118>
    120c:	41 c7 80 80 00 00 00 	movl   $0x1,0x80(%r8)
    1213:	01 00 00 00 
    1217:	41 83 fd 08          	cmp    $0x8,%r13d
    121b:	0f 85 67 fe ff ff    	jne    1088 <scan_scalar+0x108>
    1221:	eb df                	jmp    1202 <scan_scalar+0x282>
    1223:	48 39 f0             	cmp    %rsi,%rax
    1226:	0f 82 3e fe ff ff    	jb     106a <scan_scalar+0xea>
    122c:	49 c7 80 80 00 00 00 	movq   $0x0,0x80(%r8)
    1233:	00 00 00 00 
    1237:	48 89 f3             	mov    %rsi,%rbx
    123a:	48 c1 eb 05          	shr    $0x5,%rbx
    123e:	0f 84 5b fe ff ff    	je     109f <scan_scalar+0x11f>
    1244:	e9 a9 fe ff ff       	jmp    10f2 <scan_scalar+0x172>
    1249:	4c 89 d0             	mov    %r10,%rax
    124c:	48 c1 e8 20          	shr    $0x20,%rax
    1250:	41 39 c2             	cmp    %eax,%r10d
    1253:	0f 95 c0             	setne  %al
    1256:	0f b6 c0             	movzbl %al,%eax
    1259:	83 c0 01             	add    $0x1,%eax
    125c:	e9 37 fe ff ff       	jmp    1098 <scan_scalar+0x118>
    1261:	4c 89 e6             	mov    %r12,%rsi
    1264:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    126b:	4c 89 04 24          	mov    %r8,(%rsp)
    126f:	89 54 24 0c          	mov    %edx,0xc(%rsp)
    1273:	e8 00 00 00 00       	call   1278 <scan_scalar+0x2f8>
    1278:	4c 8b 04 24          	mov    (%rsp),%r8
    127c:	8b 54 24 0c          	mov    0xc(%rsp),%edx
    1280:	e9 02 ff ff ff       	jmp    1187 <scan_scalar+0x207>
    1285:	e8 00 00 00 00       	call   128a <scan_scalar+0x30a>
    128a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1290:	90                   	nop
    1291:	90                   	nop
    1292:	90                   	nop
    1293:	90                   	nop
    1294:	90                   	nop
    1295:	90                   	nop
    1296:	90                   	nop
    1297:	90                   	nop
    1298:	90                   	nop
    1299:	90                   	nop
    129a:	90                   	nop
    129b:	90                   	nop
    129c:	90                   	nop
    129d:	90                   	nop
    129e:	90                   	nop
    129f:	90                   	nop

00000000000012a0 <scan_avx2>:
    12a0:	f3 0f 1e fa          	endbr64
    12a4:	e8 00 00 00 00       	call   12a9 <scan_avx2+0x9>
    12a9:	55                   	push   %rbp
    12aa:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    12af:	48 89 e5             	mov    %rsp,%rbp
    12b2:	41 57                	push   %r15
    12b4:	41 56                	push   %r14
    12b6:	41 55                	push   %r13
    12b8:	41 54                	push   %r12
    12ba:	53                   	push   %rbx
    12bb:	48 89 f3             	mov    %rsi,%rbx
    12be:	48 c1 eb 05          	shr    $0x5,%rbx
    12c2:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
    12c6:	48 81 ec 60 02 00 00 	sub    $0x260,%rsp
    12cd:	c4 62 7d 58 0f       	vpbroadcastd (%rdi),%ymm9
    12d2:	c4 e2 7d 59 37       	vpbroadcastq (%rdi),%ymm6
    12d7:	c4 e2 7d 5a 3f       	vbroadcasti128 (%rdi),%ymm7
    12dc:	c5 7e 6f 07          	vmovdqu (%rdi),%ymm8
    12e0:	48 89 bc 24 58 02 00 	mov    %rdi,0x258(%rsp)
    12e7:	00 
    12e8:	c7 82 80 00 00 00 00 	movl   $0x0,0x80(%rdx)
    12ef:	00 00 00 
    12f2:	48 83 fe 7f          	cmp    $0x7f,%rsi
    12f6:	0f 86 d5 02 00 00    	jbe    15d1 <scan_avx2+0x331>
    12fc:	48 89 f9             	mov    %rdi,%rcx
    12ff:	c4 41 7d 6f eb       	vmovdqa %ymm11,%ymm13
    1304:	c5 7d 7f dc          	vmovdqa %ymm11,%ymm4
    1308:	31 c0                	xor    %eax,%eax
    130a:	c5 7d 7f dd          	vmovdqa %ymm11,%ymm5
    130e:	c4 41 7d 6f e3       	vmovdqa %ymm11,%ymm12
    1313:	c4 41 7d 6f d3       	vmovdqa %ymm11,%ymm10
    1318:	c5 fe 6f 19          	vmovdqu (%rcx),%ymm3
    131c:	c5 fe 6f 51 40       	vmovdqu 0x40(%rcx),%ymm2
    1321:	4c 8d 70 01          	lea    0x1(%rax),%r14
    1325:	4c 8d 68 02          	lea    0x2(%rax),%r13
    1329:	4c 8d 60 03          	lea    0x3(%rax),%r12
    132d:	c4 c1 65 76 c2       	vpcmpeqd %ymm10,%ymm3,%ymm0
    1332:	c5 7c 50 d8          	vmovmskps %ymm0,%r11d
    1336:	c5 fe 6f 41 20       	vmovdqu 0x20(%rcx),%ymm0
    133b:	41 80 f3 ff          	xor    $0xff,%r11b
    133f:	c4 c1 7d 76 ca       	vpcmpeqd %ymm10,%ymm0,%ymm1
    1344:	c5 7c 50 d1          	vmovmskps %ymm1,%r10d
    1348:	c4 c1 6d 76 ca       	vpcmpeqd %ymm10,%ymm2,%ymm1
    134d:	41 80 f2 ff          	xor    $0xff,%r10b
    1351:	c5 7c 50 c9          	vmovmskps %ymm1,%r9d
    1355:	c5 fe 6f 49 60       	vmovdqu 0x60(%rcx),%ymm1
    135a:	41 80 f1 ff          	xor    $0xff,%r9b
    135e:	c4 41 75 76 f2       	vpcmpeqd %ymm10,%ymm1,%ymm14
    1363:	c4 41 7c 50 c6       	vmovmskps %ymm14,%r8d
    1368:	41 80 f0 ff          	xor    $0xff,%r8b
    136c:	48 3d 80 00 00 00    	cmp    $0x80,%rax
    1372:	0f 83 73 02 00 00    	jae    15eb <scan_avx2+0x34b>
    1378:	44 88 1c 02          	mov    %r11b,(%rdx,%rax,1)
    137c:	44 89 de             	mov    %r11d,%esi
    137f:	44 8b ba 80 00 00 00 	mov    0x80(%rdx),%r15d
    1386:	41 81 fb ff 00 00 00 	cmp    $0xff,%r11d
    138d:	0f 87 30 0c 00 00    	ja     1fc3 <scan_avx2+0xd23>
    1393:	c5 34 57 f3          	vxorps %ymm3,%ymm9,%ymm14
    1397:	0f b6 b6 00 00 00 00 	movzbl 0x0(%rsi),%esi
    139e:	c4 41 1c 56 e6       	vorps  %ymm14,%ymm12,%ymm12
    13a3:	c5 4c 57 f3          	vxorps %ymm3,%ymm6,%ymm14
    13a7:	41 01 f7             	add    %esi,%r15d
    13aa:	c4 c1 54 56 ee       	vorps  %ymm14,%ymm5,%ymm5
    13af:	c5 44 57 f3          	vxorps %ymm3,%ymm7,%ymm14
    13b3:	c5 bc 57 db          	vxorps %ymm3,%ymm8,%ymm3
    13b7:	44 89 ba 80 00 00 00 	mov    %r15d,0x80(%rdx)
    13be:	c4 c1 5c 56 e6       	vorps  %ymm14,%ymm4,%ymm4
    13c3:	c5 94 56 db          	vorps  %ymm3,%ymm13,%ymm3
    13c7:	49 81 fe 80 00 00 00 	cmp    $0x80,%r14
    13ce:	0f 83 ad 0a 00 00    	jae    1e81 <scan_avx2+0xbe1>
    13d4:	44 88 54 02 01       	mov    %r10b,0x1(%rdx,%rax,1)
    13d9:	45 89 d6             	mov    %r10d,%r14d
    13dc:	41 81 fa ff 00 00 00 	cmp    $0xff,%r10d
    13e3:	0f 87 66 09 00 00    	ja     1d4f <scan_avx2+0xaaf>
    13e9:	45 0f b6 b6 00 00 00 	movzbl 0x0(%r14),%r14d
    13f0:	00 
    13f1:	c5 34 57 f0          	vxorps %ymm0,%ymm9,%ymm14
    13f5:	c5 4c 57 f8          	vxorps %ymm0,%ymm6,%ymm15
    13f9:	c5 44 57 e8          	vxorps %ymm0,%ymm7,%ymm13
    13fd:	c5 bc 57 c0          	vxorps %ymm0,%ymm8,%ymm0
    1401:	c4 41 1c 56 f6       	vorps  %ymm14,%ymm12,%ymm14
    1406:	c4 41 54 56 ff       	vorps  %ymm15,%ymm5,%ymm15
    140b:	45 01 fe             	add    %r15d,%r14d
    140e:	c4 41 5c 56 ed       	vorps  %ymm13,%ymm4,%ymm13
    1413:	c5 e4 56 c0          	vorps  %ymm0,%ymm3,%ymm0
    1417:	44 89 b2 80 00 00 00 	mov    %r14d,0x80(%rdx)
    141e:	49 81 fd 80 00 00 00 	cmp    $0x80,%r13
    1425:	0f 83 fe 07 00 00    	jae    1c29 <scan_avx2+0x989>
    142b:	44 88 4c 02 02       	mov    %r9b,0x2(%rdx,%rax,1)
    1430:	45 89 cd             	mov    %r9d,%r13d
    1433:	41 81 f9 ff 00 00 00 	cmp    $0xff,%r9d
    143a:	0f 87 cd 06 00 00    	ja     1b0d <scan_avx2+0x86d>
    1440:	45 0f b6 ad 00 00 00 	movzbl 0x0(%r13),%r13d
    1447:	00 
    1448:	c5 34 57 e2          	vxorps %ymm2,%ymm9,%ymm12
    144c:	c5 cc 57 ea          	vxorps %ymm2,%ymm6,%ymm5
    1450:	c5 c4 57 e2          	vxorps %ymm2,%ymm7,%ymm4
    1454:	c5 bc 57 d2          	vxorps %ymm2,%ymm8,%ymm2
    1458:	c4 41 0c 56 e4       	vorps  %ymm12,%ymm14,%ymm12
    145d:	c5 84 56 ed          	vorps  %ymm5,%ymm15,%ymm5
    1461:	45 01 f5             	add    %r14d,%r13d
    1464:	c5 94 56 e4          	vorps  %ymm4,%ymm13,%ymm4
    1468:	c5 fc 56 c2          	vorps  %ymm2,%ymm0,%ymm0
    146c:	44 89 aa 80 00 00 00 	mov    %r13d,0x80(%rdx)
    1473:	49 81 fc 80 00 00 00 	cmp    $0x80,%r12
    147a:	0f 83 7d 05 00 00    	jae    19fd <scan_avx2+0x75d>
    1480:	44 88 44 02 03       	mov    %r8b,0x3(%rdx,%rax,1)
    1485:	45 89 c4             	mov    %r8d,%r12d
    1488:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    148f:	0f 87 68 04 00 00    	ja     18fd <scan_avx2+0x65d>
    1495:	c5 b4 57 d1          	vxorps %ymm1,%ymm9,%ymm2
    1499:	48 83 c0 04          	add    $0x4,%rax
    149d:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
    14a1:	41 0f b6 b4 24 00 00 	movzbl 0x0(%r12),%esi
    14a8:	00 00 
    14aa:	c5 1c 56 e2          	vorps  %ymm2,%ymm12,%ymm12
    14ae:	c5 cc 57 d1          	vxorps %ymm1,%ymm6,%ymm2
    14b2:	44 01 ee             	add    %r13d,%esi
    14b5:	c5 d4 56 ea          	vorps  %ymm2,%ymm5,%ymm5
    14b9:	c5 c4 57 d1          	vxorps %ymm1,%ymm7,%ymm2
    14bd:	89 b2 80 00 00 00    	mov    %esi,0x80(%rdx)
    14c3:	48 89 de             	mov    %rbx,%rsi
    14c6:	c5 bc 57 c9          	vxorps %ymm1,%ymm8,%ymm1
    14ca:	c5 dc 56 e2          	vorps  %ymm2,%ymm4,%ymm4
    14ce:	48 29 c6             	sub    %rax,%rsi
    14d1:	c5 7c 56 e9          	vorps  %ymm1,%ymm0,%ymm13
    14d5:	48 83 fe 03          	cmp    $0x3,%rsi
    14d9:	0f 87 39 fe ff ff    	ja     1318 <scan_avx2+0x78>
    14df:	4c 8d 63 fc          	lea    -0x4(%rbx),%r12
    14e3:	49 83 e4 fc          	and    $0xfffffffffffffffc,%r12
    14e7:	49 83 c4 04          	add    $0x4,%r12
    14eb:	49 39 dc             	cmp    %rbx,%r12
    14ee:	0f 83 89 00 00 00    	jae    157d <scan_avx2+0x2dd>
    14f4:	48 8b bc 24 58 02 00 	mov    0x258(%rsp),%rdi
    14fb:	00 
    14fc:	4c 89 e0             	mov    %r12,%rax
    14ff:	48 c1 e0 05          	shl    $0x5,%rax
    1503:	c5 fe 6f 04 07       	vmovdqu (%rdi,%rax,1),%ymm0
    1508:	c4 c1 7d 76 cb       	vpcmpeqd %ymm11,%ymm0,%ymm1
    150d:	c5 7c 50 e9          	vmovmskps %ymm1,%r13d
    1511:	41 80 f5 ff          	xor    $0xff,%r13b
    1515:	49 81 fc 80 00 00 00 	cmp    $0x80,%r12
    151c:	0f 83 00 03 00 00    	jae    1822 <scan_avx2+0x582>
    1522:	46 88 2c 22          	mov    %r13b,(%rdx,%r12,1)
    1526:	45 89 ee             	mov    %r13d,%r14d
    1529:	44 8b ba 80 00 00 00 	mov    0x80(%rdx),%r15d
    1530:	41 81 fd ff 00 00 00 	cmp    $0xff,%r13d
    1537:	0f 87 0a 02 00 00    	ja     1747 <scan_avx2+0x4a7>
    153d:	c5 b4 57 c8          	vxorps %ymm0,%ymm9,%ymm1
    1541:	41 0f b6 86 00 00 00 	movzbl 0x0(%r14),%eax
    1548:	00 
    1549:	49 83 c4 01          	add    $0x1,%r12
    154d:	c4 41 74 56 e4       	vorps  %ymm12,%ymm1,%ymm12
    1552:	c5 cc 57 c8          	vxorps %ymm0,%ymm6,%ymm1
    1556:	44 01 f8             	add    %r15d,%eax
    1559:	c5 f4 56 ed          	vorps  %ymm5,%ymm1,%ymm5
    155d:	c5 c4 57 c8          	vxorps %ymm0,%ymm7,%ymm1
    1561:	c5 bc 57 c0          	vxorps %ymm0,%ymm8,%ymm0
    1565:	89 82 80 00 00 00    	mov    %eax,0x80(%rdx)
    156b:	c5 f4 56 e4          	vorps  %ymm4,%ymm1,%ymm4
    156f:	c4 41 7c 56 ed       	vorps  %ymm13,%ymm0,%ymm13
    1574:	4c 39 e3             	cmp    %r12,%rbx
    1577:	0f 85 77 ff ff ff    	jne    14f4 <scan_avx2+0x254>
    157d:	31 ff                	xor    %edi,%edi
    157f:	c4 42 7d 17 e4       	vptest %ymm12,%ymm12
    1584:	40 0f 94 c7          	sete   %dil
    1588:	31 c0                	xor    %eax,%eax
    158a:	c4 e2 7d 17 ed       	vptest %ymm5,%ymm5
    158f:	0f 94 c0             	sete   %al
    1592:	31 f6                	xor    %esi,%esi
    1594:	c4 e2 7d 17 e4       	vptest %ymm4,%ymm4
    1599:	40 0f 94 c6          	sete   %sil
    159d:	31 c9                	xor    %ecx,%ecx
    159f:	c4 42 7d 17 ed       	vptest %ymm13,%ymm13
    15a4:	0f 94 c1             	sete   %cl
    15a7:	01 c0                	add    %eax,%eax
    15a9:	c1 e6 02             	shl    $0x2,%esi
    15ac:	09 f0                	or     %esi,%eax
    15ae:	c1 e1 03             	shl    $0x3,%ecx
    15b1:	09 f8                	or     %edi,%eax
    15b3:	09 c8                	or     %ecx,%eax
    15b5:	89 82 84 00 00 00    	mov    %eax,0x84(%rdx)
    15bb:	c5 f8 77             	vzeroupper
    15be:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    15c2:	5b                   	pop    %rbx
    15c3:	41 5c                	pop    %r12
    15c5:	41 5d                	pop    %r13
    15c7:	41 5e                	pop    %r14
    15c9:	41 5f                	pop    %r15
    15cb:	5d                   	pop    %rbp
    15cc:	e9 00 00 00 00       	jmp    15d1 <scan_avx2+0x331>
    15d1:	c4 41 7d 6f eb       	vmovdqa %ymm11,%ymm13
    15d6:	c5 7d 7f dc          	vmovdqa %ymm11,%ymm4
    15da:	c5 7d 7f dd          	vmovdqa %ymm11,%ymm5
    15de:	45 31 e4             	xor    %r12d,%r12d
    15e1:	c4 41 7d 6f e3       	vmovdqa %ymm11,%ymm12
    15e6:	e9 00 ff ff ff       	jmp    14eb <scan_avx2+0x24b>
    15eb:	44 89 4c 24 40       	mov    %r9d,0x40(%rsp)
    15f0:	48 89 c6             	mov    %rax,%rsi
    15f3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    15fa:	48 89 94 24 48 02 00 	mov    %rdx,0x248(%rsp)
    1601:	00 
    1602:	44 89 84 24 50 02 00 	mov    %r8d,0x250(%rsp)
    1609:	00 
    160a:	44 89 94 24 80 00 00 	mov    %r10d,0x80(%rsp)
    1611:	00 
    1612:	48 89 8c 24 c0 00 00 	mov    %rcx,0xc0(%rsp)
    1619:	00 
    161a:	44 89 9c 24 e0 00 00 	mov    %r11d,0xe0(%rsp)
    1621:	00 
    1622:	48 89 84 24 20 02 00 	mov    %rax,0x220(%rsp)
    1629:	00 
    162a:	c5 7d 7f 14 24       	vmovdqa %ymm10,(%rsp)
    162f:	c5 fd 7f 4c 24 20    	vmovdqa %ymm1,0x20(%rsp)
    1635:	c5 fd 7f 54 24 60    	vmovdqa %ymm2,0x60(%rsp)
    163b:	c5 fd 7f 84 24 a0 00 	vmovdqa %ymm0,0xa0(%rsp)
    1642:	00 00 
    1644:	c5 fd 7f 9c 24 00 01 	vmovdqa %ymm3,0x100(%rsp)
    164b:	00 00 
    164d:	c5 fd 7f ac 24 20 01 	vmovdqa %ymm5,0x120(%rsp)
    1654:	00 00 
    1656:	c5 7d 7f ac 24 40 01 	vmovdqa %ymm13,0x140(%rsp)
    165d:	00 00 
    165f:	c5 fd 7f a4 24 60 01 	vmovdqa %ymm4,0x160(%rsp)
    1666:	00 00 
    1668:	c5 7d 7f a4 24 80 01 	vmovdqa %ymm12,0x180(%rsp)
    166f:	00 00 
    1671:	c5 7d 7f 8c 24 a0 01 	vmovdqa %ymm9,0x1a0(%rsp)
    1678:	00 00 
    167a:	c5 7d 7f 84 24 c0 01 	vmovdqa %ymm8,0x1c0(%rsp)
    1681:	00 00 
    1683:	c5 fd 7f bc 24 e0 01 	vmovdqa %ymm7,0x1e0(%rsp)
    168a:	00 00 
    168c:	c5 fd 7f b4 24 00 02 	vmovdqa %ymm6,0x200(%rsp)
    1693:	00 00 
    1695:	c5 f8 77             	vzeroupper
    1698:	e8 00 00 00 00       	call   169d <scan_avx2+0x3fd>
    169d:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    16a2:	48 8b 94 24 48 02 00 	mov    0x248(%rsp),%rdx
    16a9:	00 
    16aa:	c5 7d 6f 14 24       	vmovdqa (%rsp),%ymm10
    16af:	44 8b 84 24 50 02 00 	mov    0x250(%rsp),%r8d
    16b6:	00 
    16b7:	c5 fd 6f 4c 24 20    	vmovdqa 0x20(%rsp),%ymm1
    16bd:	44 8b 4c 24 40       	mov    0x40(%rsp),%r9d
    16c2:	c5 fd 6f 54 24 60    	vmovdqa 0x60(%rsp),%ymm2
    16c8:	44 8b 94 24 80 00 00 	mov    0x80(%rsp),%r10d
    16cf:	00 
    16d0:	48 8b 8c 24 c0 00 00 	mov    0xc0(%rsp),%rcx
    16d7:	00 
    16d8:	c5 fd 6f 84 24 a0 00 	vmovdqa 0xa0(%rsp),%ymm0
    16df:	00 00 
    16e1:	44 8b 9c 24 e0 00 00 	mov    0xe0(%rsp),%r11d
    16e8:	00 
    16e9:	c5 fd 6f 9c 24 00 01 	vmovdqa 0x100(%rsp),%ymm3
    16f0:	00 00 
    16f2:	c5 fd 6f ac 24 20 01 	vmovdqa 0x120(%rsp),%ymm5
    16f9:	00 00 
    16fb:	c5 7d 6f ac 24 40 01 	vmovdqa 0x140(%rsp),%ymm13
    1702:	00 00 
    1704:	c5 fd 6f a4 24 60 01 	vmovdqa 0x160(%rsp),%ymm4
    170b:	00 00 
    170d:	c5 7d 6f a4 24 80 01 	vmovdqa 0x180(%rsp),%ymm12
    1714:	00 00 
    1716:	c5 7d 6f 8c 24 a0 01 	vmovdqa 0x1a0(%rsp),%ymm9
    171d:	00 00 
    171f:	c5 7d 6f 84 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm8
    1726:	00 00 
    1728:	c5 fd 6f bc 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm7
    172f:	00 00 
    1731:	48 8b 84 24 20 02 00 	mov    0x220(%rsp),%rax
    1738:	00 
    1739:	c5 fd 6f b4 24 00 02 	vmovdqa 0x200(%rsp),%ymm6
    1740:	00 00 
    1742:	e9 31 fc ff ff       	jmp    1378 <scan_avx2+0xd8>
    1747:	48 89 94 24 e0 00 00 	mov    %rdx,0xe0(%rsp)
    174e:	00 
    174f:	4c 89 f6             	mov    %r14,%rsi
    1752:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1759:	c5 7d 7f 9c 24 00 01 	vmovdqa %ymm11,0x100(%rsp)
    1760:	00 00 
    1762:	c5 fd 7f ac 24 20 01 	vmovdqa %ymm5,0x120(%rsp)
    1769:	00 00 
    176b:	c5 7d 7f ac 24 40 01 	vmovdqa %ymm13,0x140(%rsp)
    1772:	00 00 
    1774:	c5 fd 7f a4 24 60 01 	vmovdqa %ymm4,0x160(%rsp)
    177b:	00 00 
    177d:	c5 fd 7f 84 24 80 01 	vmovdqa %ymm0,0x180(%rsp)
    1784:	00 00 
    1786:	c5 7d 7f a4 24 a0 01 	vmovdqa %ymm12,0x1a0(%rsp)
    178d:	00 00 
    178f:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    1796:	00 00 
    1798:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    179f:	00 00 
    17a1:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    17a8:	00 00 
    17aa:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    17b1:	00 00 
    17b3:	c5 f8 77             	vzeroupper
    17b6:	e8 00 00 00 00       	call   17bb <scan_avx2+0x51b>
    17bb:	48 8b 94 24 e0 00 00 	mov    0xe0(%rsp),%rdx
    17c2:	00 
    17c3:	c5 7d 6f 9c 24 00 01 	vmovdqa 0x100(%rsp),%ymm11
    17ca:	00 00 
    17cc:	c5 fd 6f ac 24 20 01 	vmovdqa 0x120(%rsp),%ymm5
    17d3:	00 00 
    17d5:	c5 7d 6f ac 24 40 01 	vmovdqa 0x140(%rsp),%ymm13
    17dc:	00 00 
    17de:	c5 fd 6f a4 24 60 01 	vmovdqa 0x160(%rsp),%ymm4
    17e5:	00 00 
    17e7:	c5 fd 6f 84 24 80 01 	vmovdqa 0x180(%rsp),%ymm0
    17ee:	00 00 
    17f0:	c5 7d 6f a4 24 a0 01 	vmovdqa 0x1a0(%rsp),%ymm12
    17f7:	00 00 
    17f9:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    1800:	00 00 
    1802:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    1809:	00 00 
    180b:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    1812:	00 00 
    1814:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    181b:	00 00 
    181d:	e9 1b fd ff ff       	jmp    153d <scan_avx2+0x29d>
    1822:	48 89 94 24 e0 00 00 	mov    %rdx,0xe0(%rsp)
    1829:	00 
    182a:	4c 89 e6             	mov    %r12,%rsi
    182d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1834:	c5 7d 7f 9c 24 00 01 	vmovdqa %ymm11,0x100(%rsp)
    183b:	00 00 
    183d:	c5 fd 7f ac 24 20 01 	vmovdqa %ymm5,0x120(%rsp)
    1844:	00 00 
    1846:	c5 7d 7f ac 24 40 01 	vmovdqa %ymm13,0x140(%rsp)
    184d:	00 00 
    184f:	c5 fd 7f a4 24 60 01 	vmovdqa %ymm4,0x160(%rsp)
    1856:	00 00 
    1858:	c5 fd 7f 84 24 80 01 	vmovdqa %ymm0,0x180(%rsp)
    185f:	00 00 
    1861:	c5 7d 7f a4 24 a0 01 	vmovdqa %ymm12,0x1a0(%rsp)
    1868:	00 00 
    186a:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    1871:	00 00 
    1873:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    187a:	00 00 
    187c:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    1883:	00 00 
    1885:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    188c:	00 00 
    188e:	c5 f8 77             	vzeroupper
    1891:	e8 00 00 00 00       	call   1896 <scan_avx2+0x5f6>
    1896:	48 8b 94 24 e0 00 00 	mov    0xe0(%rsp),%rdx
    189d:	00 
    189e:	c5 7d 6f 9c 24 00 01 	vmovdqa 0x100(%rsp),%ymm11
    18a5:	00 00 
    18a7:	c5 fd 6f ac 24 20 01 	vmovdqa 0x120(%rsp),%ymm5
    18ae:	00 00 
    18b0:	c5 7d 6f ac 24 40 01 	vmovdqa 0x140(%rsp),%ymm13
    18b7:	00 00 
    18b9:	c5 fd 6f a4 24 60 01 	vmovdqa 0x160(%rsp),%ymm4
    18c0:	00 00 
    18c2:	c5 fd 6f 84 24 80 01 	vmovdqa 0x180(%rsp),%ymm0
    18c9:	00 00 
    18cb:	c5 7d 6f a4 24 a0 01 	vmovdqa 0x1a0(%rsp),%ymm12
    18d2:	00 00 
    18d4:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    18db:	00 00 
    18dd:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    18e4:	00 00 
    18e6:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    18ed:	00 00 
    18ef:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    18f6:	00 00 
    18f8:	e9 25 fc ff ff       	jmp    1522 <scan_avx2+0x282>
    18fd:	48 89 94 24 a0 00 00 	mov    %rdx,0xa0(%rsp)
    1904:	00 
    1905:	4c 89 e6             	mov    %r12,%rsi
    1908:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    190f:	48 89 8c 24 00 01 00 	mov    %rcx,0x100(%rsp)
    1916:	00 
    1917:	48 89 84 24 a0 01 00 	mov    %rax,0x1a0(%rsp)
    191e:	00 
    191f:	c5 7d 7f 94 24 c0 00 	vmovdqa %ymm10,0xc0(%rsp)
    1926:	00 00 
    1928:	c5 fd 7f 8c 24 e0 00 	vmovdqa %ymm1,0xe0(%rsp)
    192f:	00 00 
    1931:	c5 fc 29 84 24 20 01 	vmovaps %ymm0,0x120(%rsp)
    1938:	00 00 
    193a:	c5 fc 29 a4 24 40 01 	vmovaps %ymm4,0x140(%rsp)
    1941:	00 00 
    1943:	c5 fc 29 ac 24 60 01 	vmovaps %ymm5,0x160(%rsp)
    194a:	00 00 
    194c:	c5 7c 29 a4 24 80 01 	vmovaps %ymm12,0x180(%rsp)
    1953:	00 00 
    1955:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    195c:	00 00 
    195e:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    1965:	00 00 
    1967:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    196e:	00 00 
    1970:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    1977:	00 00 
    1979:	c5 f8 77             	vzeroupper
    197c:	e8 00 00 00 00       	call   1981 <scan_avx2+0x6e1>
    1981:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    1986:	48 8b 94 24 a0 00 00 	mov    0xa0(%rsp),%rdx
    198d:	00 
    198e:	48 8b 8c 24 00 01 00 	mov    0x100(%rsp),%rcx
    1995:	00 
    1996:	c5 7d 6f 94 24 c0 00 	vmovdqa 0xc0(%rsp),%ymm10
    199d:	00 00 
    199f:	c5 fd 6f 8c 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm1
    19a6:	00 00 
    19a8:	c5 fc 28 84 24 20 01 	vmovaps 0x120(%rsp),%ymm0
    19af:	00 00 
    19b1:	c5 fc 28 a4 24 40 01 	vmovaps 0x140(%rsp),%ymm4
    19b8:	00 00 
    19ba:	48 8b 84 24 a0 01 00 	mov    0x1a0(%rsp),%rax
    19c1:	00 
    19c2:	c5 fc 28 ac 24 60 01 	vmovaps 0x160(%rsp),%ymm5
    19c9:	00 00 
    19cb:	c5 7c 28 a4 24 80 01 	vmovaps 0x180(%rsp),%ymm12
    19d2:	00 00 
    19d4:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    19db:	00 00 
    19dd:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    19e4:	00 00 
    19e6:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    19ed:	00 00 
    19ef:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    19f6:	00 00 
    19f8:	e9 98 fa ff ff       	jmp    1495 <scan_avx2+0x1f5>
    19fd:	48 89 94 24 80 00 00 	mov    %rdx,0x80(%rsp)
    1a04:	00 
    1a05:	4c 89 e6             	mov    %r12,%rsi
    1a08:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a0f:	44 89 84 24 c0 00 00 	mov    %r8d,0xc0(%rsp)
    1a16:	00 
    1a17:	48 89 8c 24 00 01 00 	mov    %rcx,0x100(%rsp)
    1a1e:	00 
    1a1f:	48 89 84 24 a0 01 00 	mov    %rax,0x1a0(%rsp)
    1a26:	00 
    1a27:	c5 7d 7f 94 24 a0 00 	vmovdqa %ymm10,0xa0(%rsp)
    1a2e:	00 00 
    1a30:	c5 fd 7f 8c 24 e0 00 	vmovdqa %ymm1,0xe0(%rsp)
    1a37:	00 00 
    1a39:	c5 fc 29 84 24 20 01 	vmovaps %ymm0,0x120(%rsp)
    1a40:	00 00 
    1a42:	c5 fc 29 a4 24 40 01 	vmovaps %ymm4,0x140(%rsp)
    1a49:	00 00 
    1a4b:	c5 fc 29 ac 24 60 01 	vmovaps %ymm5,0x160(%rsp)
    1a52:	00 00 
    1a54:	c5 7c 29 a4 24 80 01 	vmovaps %ymm12,0x180(%rsp)
    1a5b:	00 00 
    1a5d:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    1a64:	00 00 
    1a66:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    1a6d:	00 00 
    1a6f:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    1a76:	00 00 
    1a78:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    1a7f:	00 00 
    1a81:	c5 f8 77             	vzeroupper
    1a84:	e8 00 00 00 00       	call   1a89 <scan_avx2+0x7e9>
    1a89:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    1a8e:	48 8b 94 24 80 00 00 	mov    0x80(%rsp),%rdx
    1a95:	00 
    1a96:	44 8b 84 24 c0 00 00 	mov    0xc0(%rsp),%r8d
    1a9d:	00 
    1a9e:	48 8b 8c 24 00 01 00 	mov    0x100(%rsp),%rcx
    1aa5:	00 
    1aa6:	c5 7d 6f 94 24 a0 00 	vmovdqa 0xa0(%rsp),%ymm10
    1aad:	00 00 
    1aaf:	c5 fd 6f 8c 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm1
    1ab6:	00 00 
    1ab8:	c5 fc 28 84 24 20 01 	vmovaps 0x120(%rsp),%ymm0
    1abf:	00 00 
    1ac1:	c5 fc 28 a4 24 40 01 	vmovaps 0x140(%rsp),%ymm4
    1ac8:	00 00 
    1aca:	c5 fc 28 ac 24 60 01 	vmovaps 0x160(%rsp),%ymm5
    1ad1:	00 00 
    1ad3:	c5 7c 28 a4 24 80 01 	vmovaps 0x180(%rsp),%ymm12
    1ada:	00 00 
    1adc:	48 8b 84 24 a0 01 00 	mov    0x1a0(%rsp),%rax
    1ae3:	00 
    1ae4:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    1aeb:	00 00 
    1aed:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    1af4:	00 00 
    1af6:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    1afd:	00 00 
    1aff:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    1b06:	00 00 
    1b08:	e9 73 f9 ff ff       	jmp    1480 <scan_avx2+0x1e0>
    1b0d:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
    1b12:	4c 89 ee             	mov    %r13,%rsi
    1b15:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b1c:	44 89 84 24 a0 00 00 	mov    %r8d,0xa0(%rsp)
    1b23:	00 
    1b24:	48 89 8c 24 00 01 00 	mov    %rcx,0x100(%rsp)
    1b2b:	00 
    1b2c:	48 89 84 24 a0 01 00 	mov    %rax,0x1a0(%rsp)
    1b33:	00 
    1b34:	c5 7d 7f 94 24 80 00 	vmovdqa %ymm10,0x80(%rsp)
    1b3b:	00 00 
    1b3d:	c5 fd 7f 8c 24 c0 00 	vmovdqa %ymm1,0xc0(%rsp)
    1b44:	00 00 
    1b46:	c5 fd 7f 94 24 e0 00 	vmovdqa %ymm2,0xe0(%rsp)
    1b4d:	00 00 
    1b4f:	c5 fc 29 84 24 20 01 	vmovaps %ymm0,0x120(%rsp)
    1b56:	00 00 
    1b58:	c5 7c 29 ac 24 40 01 	vmovaps %ymm13,0x140(%rsp)
    1b5f:	00 00 
    1b61:	c5 7c 29 bc 24 60 01 	vmovaps %ymm15,0x160(%rsp)
    1b68:	00 00 
    1b6a:	c5 7c 29 b4 24 80 01 	vmovaps %ymm14,0x180(%rsp)
    1b71:	00 00 
    1b73:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    1b7a:	00 00 
    1b7c:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    1b83:	00 00 
    1b85:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    1b8c:	00 00 
    1b8e:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    1b95:	00 00 
    1b97:	c5 f8 77             	vzeroupper
    1b9a:	e8 00 00 00 00       	call   1b9f <scan_avx2+0x8ff>
    1b9f:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    1ba4:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
    1ba9:	44 8b 84 24 a0 00 00 	mov    0xa0(%rsp),%r8d
    1bb0:	00 
    1bb1:	c5 7d 6f 94 24 80 00 	vmovdqa 0x80(%rsp),%ymm10
    1bb8:	00 00 
    1bba:	48 8b 8c 24 00 01 00 	mov    0x100(%rsp),%rcx
    1bc1:	00 
    1bc2:	c5 fd 6f 8c 24 c0 00 	vmovdqa 0xc0(%rsp),%ymm1
    1bc9:	00 00 
    1bcb:	c5 fd 6f 94 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm2
    1bd2:	00 00 
    1bd4:	c5 fc 28 84 24 20 01 	vmovaps 0x120(%rsp),%ymm0
    1bdb:	00 00 
    1bdd:	c5 7c 28 ac 24 40 01 	vmovaps 0x140(%rsp),%ymm13
    1be4:	00 00 
    1be6:	48 8b 84 24 a0 01 00 	mov    0x1a0(%rsp),%rax
    1bed:	00 
    1bee:	c5 7c 28 bc 24 60 01 	vmovaps 0x160(%rsp),%ymm15
    1bf5:	00 00 
    1bf7:	c5 7c 28 b4 24 80 01 	vmovaps 0x180(%rsp),%ymm14
    1bfe:	00 00 
    1c00:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    1c07:	00 00 
    1c09:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    1c10:	00 00 
    1c12:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    1c19:	00 00 
    1c1b:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    1c22:	00 00 
    1c24:	e9 17 f8 ff ff       	jmp    1440 <scan_avx2+0x1a0>
    1c29:	48 89 54 24 40       	mov    %rdx,0x40(%rsp)
    1c2e:	4c 89 ee             	mov    %r13,%rsi
    1c31:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1c38:	44 89 84 24 80 00 00 	mov    %r8d,0x80(%rsp)
    1c3f:	00 
    1c40:	44 89 8c 24 c0 00 00 	mov    %r9d,0xc0(%rsp)
    1c47:	00 
    1c48:	48 89 8c 24 00 01 00 	mov    %rcx,0x100(%rsp)
    1c4f:	00 
    1c50:	48 89 84 24 a0 01 00 	mov    %rax,0x1a0(%rsp)
    1c57:	00 
    1c58:	c5 7d 7f 54 24 60    	vmovdqa %ymm10,0x60(%rsp)
    1c5e:	c5 fd 7f 8c 24 a0 00 	vmovdqa %ymm1,0xa0(%rsp)
    1c65:	00 00 
    1c67:	c5 fd 7f 94 24 e0 00 	vmovdqa %ymm2,0xe0(%rsp)
    1c6e:	00 00 
    1c70:	c5 fc 29 84 24 20 01 	vmovaps %ymm0,0x120(%rsp)
    1c77:	00 00 
    1c79:	c5 7c 29 ac 24 40 01 	vmovaps %ymm13,0x140(%rsp)
    1c80:	00 00 
    1c82:	c5 7c 29 bc 24 60 01 	vmovaps %ymm15,0x160(%rsp)
    1c89:	00 00 
    1c8b:	c5 7c 29 b4 24 80 01 	vmovaps %ymm14,0x180(%rsp)
    1c92:	00 00 
    1c94:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    1c9b:	00 00 
    1c9d:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    1ca4:	00 00 
    1ca6:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    1cad:	00 00 
    1caf:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    1cb6:	00 00 
    1cb8:	c5 f8 77             	vzeroupper
    1cbb:	e8 00 00 00 00       	call   1cc0 <scan_avx2+0xa20>
    1cc0:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    1cc5:	48 8b 54 24 40       	mov    0x40(%rsp),%rdx
    1cca:	c5 7d 6f 54 24 60    	vmovdqa 0x60(%rsp),%ymm10
    1cd0:	44 8b 84 24 80 00 00 	mov    0x80(%rsp),%r8d
    1cd7:	00 
    1cd8:	44 8b 8c 24 c0 00 00 	mov    0xc0(%rsp),%r9d
    1cdf:	00 
    1ce0:	48 8b 8c 24 00 01 00 	mov    0x100(%rsp),%rcx
    1ce7:	00 
    1ce8:	c5 fd 6f 8c 24 a0 00 	vmovdqa 0xa0(%rsp),%ymm1
    1cef:	00 00 
    1cf1:	c5 fd 6f 94 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm2
    1cf8:	00 00 
    1cfa:	c5 fc 28 84 24 20 01 	vmovaps 0x120(%rsp),%ymm0
    1d01:	00 00 
    1d03:	c5 7c 28 ac 24 40 01 	vmovaps 0x140(%rsp),%ymm13
    1d0a:	00 00 
    1d0c:	c5 7c 28 bc 24 60 01 	vmovaps 0x160(%rsp),%ymm15
    1d13:	00 00 
    1d15:	c5 7c 28 b4 24 80 01 	vmovaps 0x180(%rsp),%ymm14
    1d1c:	00 00 
    1d1e:	48 8b 84 24 a0 01 00 	mov    0x1a0(%rsp),%rax
    1d25:	00 
    1d26:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    1d2d:	00 00 
    1d2f:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    1d36:	00 00 
    1d38:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    1d3f:	00 00 
    1d41:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    1d48:	00 00 
    1d4a:	e9 dc f6 ff ff       	jmp    142b <scan_avx2+0x18b>
    1d4f:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    1d54:	4c 89 f6             	mov    %r14,%rsi
    1d57:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d5e:	44 89 44 24 60       	mov    %r8d,0x60(%rsp)
    1d63:	44 89 8c 24 a0 00 00 	mov    %r9d,0xa0(%rsp)
    1d6a:	00 
    1d6b:	48 89 8c 24 00 01 00 	mov    %rcx,0x100(%rsp)
    1d72:	00 
    1d73:	48 89 84 24 a0 01 00 	mov    %rax,0x1a0(%rsp)
    1d7a:	00 
    1d7b:	c5 7d 7f 54 24 40    	vmovdqa %ymm10,0x40(%rsp)
    1d81:	c5 fd 7f 8c 24 80 00 	vmovdqa %ymm1,0x80(%rsp)
    1d88:	00 00 
    1d8a:	c5 fd 7f 94 24 c0 00 	vmovdqa %ymm2,0xc0(%rsp)
    1d91:	00 00 
    1d93:	c5 fd 7f 84 24 e0 00 	vmovdqa %ymm0,0xe0(%rsp)
    1d9a:	00 00 
    1d9c:	c5 fc 29 9c 24 20 01 	vmovaps %ymm3,0x120(%rsp)
    1da3:	00 00 
    1da5:	c5 fc 29 a4 24 40 01 	vmovaps %ymm4,0x140(%rsp)
    1dac:	00 00 
    1dae:	c5 fc 29 ac 24 60 01 	vmovaps %ymm5,0x160(%rsp)
    1db5:	00 00 
    1db7:	c5 7c 29 a4 24 80 01 	vmovaps %ymm12,0x180(%rsp)
    1dbe:	00 00 
    1dc0:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    1dc7:	00 00 
    1dc9:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    1dd0:	00 00 
    1dd2:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    1dd9:	00 00 
    1ddb:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    1de2:	00 00 
    1de4:	c5 f8 77             	vzeroupper
    1de7:	e8 00 00 00 00       	call   1dec <scan_avx2+0xb4c>
    1dec:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    1df1:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    1df6:	c5 7d 6f 54 24 40    	vmovdqa 0x40(%rsp),%ymm10
    1dfc:	44 8b 44 24 60       	mov    0x60(%rsp),%r8d
    1e01:	44 8b 8c 24 a0 00 00 	mov    0xa0(%rsp),%r9d
    1e08:	00 
    1e09:	c5 fd 6f 8c 24 80 00 	vmovdqa 0x80(%rsp),%ymm1
    1e10:	00 00 
    1e12:	48 8b 8c 24 00 01 00 	mov    0x100(%rsp),%rcx
    1e19:	00 
    1e1a:	c5 fd 6f 94 24 c0 00 	vmovdqa 0xc0(%rsp),%ymm2
    1e21:	00 00 
    1e23:	c5 fd 6f 84 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm0
    1e2a:	00 00 
    1e2c:	c5 fc 28 9c 24 20 01 	vmovaps 0x120(%rsp),%ymm3
    1e33:	00 00 
    1e35:	c5 fc 28 a4 24 40 01 	vmovaps 0x140(%rsp),%ymm4
    1e3c:	00 00 
    1e3e:	48 8b 84 24 a0 01 00 	mov    0x1a0(%rsp),%rax
    1e45:	00 
    1e46:	c5 fc 28 ac 24 60 01 	vmovaps 0x160(%rsp),%ymm5
    1e4d:	00 00 
    1e4f:	c5 7c 28 a4 24 80 01 	vmovaps 0x180(%rsp),%ymm12
    1e56:	00 00 
    1e58:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    1e5f:	00 00 
    1e61:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    1e68:	00 00 
    1e6a:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    1e71:	00 00 
    1e73:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    1e7a:	00 00 
    1e7c:	e9 68 f5 ff ff       	jmp    13e9 <scan_avx2+0x149>
    1e81:	44 89 44 24 40       	mov    %r8d,0x40(%rsp)
    1e86:	4c 89 f6             	mov    %r14,%rsi
    1e89:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e90:	48 89 94 24 50 02 00 	mov    %rdx,0x250(%rsp)
    1e97:	00 
    1e98:	44 89 8c 24 80 00 00 	mov    %r9d,0x80(%rsp)
    1e9f:	00 
    1ea0:	44 89 94 24 c0 00 00 	mov    %r10d,0xc0(%rsp)
    1ea7:	00 
    1ea8:	48 89 8c 24 00 01 00 	mov    %rcx,0x100(%rsp)
    1eaf:	00 
    1eb0:	48 89 84 24 a0 01 00 	mov    %rax,0x1a0(%rsp)
    1eb7:	00 
    1eb8:	c5 7d 7f 54 24 20    	vmovdqa %ymm10,0x20(%rsp)
    1ebe:	c5 fd 7f 4c 24 60    	vmovdqa %ymm1,0x60(%rsp)
    1ec4:	c5 fd 7f 94 24 a0 00 	vmovdqa %ymm2,0xa0(%rsp)
    1ecb:	00 00 
    1ecd:	c5 fd 7f 84 24 e0 00 	vmovdqa %ymm0,0xe0(%rsp)
    1ed4:	00 00 
    1ed6:	c5 fc 29 9c 24 20 01 	vmovaps %ymm3,0x120(%rsp)
    1edd:	00 00 
    1edf:	c5 fc 29 a4 24 40 01 	vmovaps %ymm4,0x140(%rsp)
    1ee6:	00 00 
    1ee8:	c5 fc 29 ac 24 60 01 	vmovaps %ymm5,0x160(%rsp)
    1eef:	00 00 
    1ef1:	c5 7c 29 a4 24 80 01 	vmovaps %ymm12,0x180(%rsp)
    1ef8:	00 00 
    1efa:	c5 7d 7f 8c 24 c0 01 	vmovdqa %ymm9,0x1c0(%rsp)
    1f01:	00 00 
    1f03:	c5 7d 7f 84 24 e0 01 	vmovdqa %ymm8,0x1e0(%rsp)
    1f0a:	00 00 
    1f0c:	c5 fd 7f bc 24 00 02 	vmovdqa %ymm7,0x200(%rsp)
    1f13:	00 00 
    1f15:	c5 fd 7f b4 24 20 02 	vmovdqa %ymm6,0x220(%rsp)
    1f1c:	00 00 
    1f1e:	c5 f8 77             	vzeroupper
    1f21:	e8 00 00 00 00       	call   1f26 <scan_avx2+0xc86>
    1f26:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    1f2b:	48 8b 94 24 50 02 00 	mov    0x250(%rsp),%rdx
    1f32:	00 
    1f33:	c5 7d 6f 54 24 20    	vmovdqa 0x20(%rsp),%ymm10
    1f39:	44 8b 44 24 40       	mov    0x40(%rsp),%r8d
    1f3e:	c5 fd 6f 4c 24 60    	vmovdqa 0x60(%rsp),%ymm1
    1f44:	44 8b 8c 24 80 00 00 	mov    0x80(%rsp),%r9d
    1f4b:	00 
    1f4c:	44 8b 94 24 c0 00 00 	mov    0xc0(%rsp),%r10d
    1f53:	00 
    1f54:	48 8b 8c 24 00 01 00 	mov    0x100(%rsp),%rcx
    1f5b:	00 
    1f5c:	c5 fd 6f 94 24 a0 00 	vmovdqa 0xa0(%rsp),%ymm2
    1f63:	00 00 
    1f65:	c5 fd 6f 84 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm0
    1f6c:	00 00 
    1f6e:	c5 fc 28 9c 24 20 01 	vmovaps 0x120(%rsp),%ymm3
    1f75:	00 00 
    1f77:	c5 fc 28 a4 24 40 01 	vmovaps 0x140(%rsp),%ymm4
    1f7e:	00 00 
    1f80:	c5 fc 28 ac 24 60 01 	vmovaps 0x160(%rsp),%ymm5
    1f87:	00 00 
    1f89:	c5 7c 28 a4 24 80 01 	vmovaps 0x180(%rsp),%ymm12
    1f90:	00 00 
    1f92:	48 8b 84 24 a0 01 00 	mov    0x1a0(%rsp),%rax
    1f99:	00 
    1f9a:	c5 7d 6f 8c 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm9
    1fa1:	00 00 
    1fa3:	c5 7d 6f 84 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm8
    1faa:	00 00 
    1fac:	c5 fd 6f bc 24 00 02 	vmovdqa 0x200(%rsp),%ymm7
    1fb3:	00 00 
    1fb5:	c5 fd 6f b4 24 20 02 	vmovdqa 0x220(%rsp),%ymm6
    1fbc:	00 00 
    1fbe:	e9 11 f4 ff ff       	jmp    13d4 <scan_avx2+0x134>
    1fc3:	48 89 94 24 48 02 00 	mov    %rdx,0x248(%rsp)
    1fca:	00 
    1fcb:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1fd2:	44 89 84 24 50 02 00 	mov    %r8d,0x250(%rsp)
    1fd9:	00 
    1fda:	44 89 4c 24 40       	mov    %r9d,0x40(%rsp)
    1fdf:	44 89 94 24 80 00 00 	mov    %r10d,0x80(%rsp)
    1fe6:	00 
    1fe7:	48 89 8c 24 c0 00 00 	mov    %rcx,0xc0(%rsp)
    1fee:	00 
    1fef:	48 89 84 24 60 01 00 	mov    %rax,0x160(%rsp)
    1ff6:	00 
    1ff7:	48 89 b4 24 20 02 00 	mov    %rsi,0x220(%rsp)
    1ffe:	00 
    1fff:	c5 7d 7f 14 24       	vmovdqa %ymm10,(%rsp)
    2004:	c5 fd 7f 4c 24 20    	vmovdqa %ymm1,0x20(%rsp)
    200a:	c5 fd 7f 54 24 60    	vmovdqa %ymm2,0x60(%rsp)
    2010:	c5 fd 7f 84 24 a0 00 	vmovdqa %ymm0,0xa0(%rsp)
    2017:	00 00 
    2019:	c5 fd 7f 9c 24 e0 00 	vmovdqa %ymm3,0xe0(%rsp)
    2020:	00 00 
    2022:	c5 fd 7f ac 24 00 01 	vmovdqa %ymm5,0x100(%rsp)
    2029:	00 00 
    202b:	c5 7d 7f ac 24 20 01 	vmovdqa %ymm13,0x120(%rsp)
    2032:	00 00 
    2034:	c5 fd 7f a4 24 40 01 	vmovdqa %ymm4,0x140(%rsp)
    203b:	00 00 
    203d:	c5 7d 7f a4 24 80 01 	vmovdqa %ymm12,0x180(%rsp)
    2044:	00 00 
    2046:	c5 7d 7f 8c 24 a0 01 	vmovdqa %ymm9,0x1a0(%rsp)
    204d:	00 00 
    204f:	c5 7d 7f 84 24 c0 01 	vmovdqa %ymm8,0x1c0(%rsp)
    2056:	00 00 
    2058:	c5 fd 7f bc 24 e0 01 	vmovdqa %ymm7,0x1e0(%rsp)
    205f:	00 00 
    2061:	c5 fd 7f b4 24 00 02 	vmovdqa %ymm6,0x200(%rsp)
    2068:	00 00 
    206a:	c5 f8 77             	vzeroupper
    206d:	e8 00 00 00 00       	call   2072 <scan_avx2+0xdd2>
    2072:	c4 41 21 ef db       	vpxor  %xmm11,%xmm11,%xmm11
    2077:	48 8b 94 24 48 02 00 	mov    0x248(%rsp),%rdx
    207e:	00 
    207f:	c5 7d 6f 14 24       	vmovdqa (%rsp),%ymm10
    2084:	44 8b 84 24 50 02 00 	mov    0x250(%rsp),%r8d
    208b:	00 
    208c:	c5 fd 6f 4c 24 20    	vmovdqa 0x20(%rsp),%ymm1
    2092:	44 8b 4c 24 40       	mov    0x40(%rsp),%r9d
    2097:	c5 fd 6f 54 24 60    	vmovdqa 0x60(%rsp),%ymm2
    209d:	44 8b 94 24 80 00 00 	mov    0x80(%rsp),%r10d
    20a4:	00 
    20a5:	48 8b 8c 24 c0 00 00 	mov    0xc0(%rsp),%rcx
    20ac:	00 
    20ad:	c5 fd 6f 84 24 a0 00 	vmovdqa 0xa0(%rsp),%ymm0
    20b4:	00 00 
    20b6:	c5 fd 6f 9c 24 e0 00 	vmovdqa 0xe0(%rsp),%ymm3
    20bd:	00 00 
    20bf:	c5 fd 6f ac 24 00 01 	vmovdqa 0x100(%rsp),%ymm5
    20c6:	00 00 
    20c8:	48 8b 84 24 60 01 00 	mov    0x160(%rsp),%rax
    20cf:	00 
    20d0:	c5 7d 6f ac 24 20 01 	vmovdqa 0x120(%rsp),%ymm13
    20d7:	00 00 
    20d9:	c5 fd 6f a4 24 40 01 	vmovdqa 0x140(%rsp),%ymm4
    20e0:	00 00 
    20e2:	c5 7d 6f a4 24 80 01 	vmovdqa 0x180(%rsp),%ymm12
    20e9:	00 00 
    20eb:	c5 7d 6f 8c 24 a0 01 	vmovdqa 0x1a0(%rsp),%ymm9
    20f2:	00 00 
    20f4:	c5 7d 6f 84 24 c0 01 	vmovdqa 0x1c0(%rsp),%ymm8
    20fb:	00 00 
    20fd:	c5 fd 6f bc 24 e0 01 	vmovdqa 0x1e0(%rsp),%ymm7
    2104:	00 00 
    2106:	48 8b b4 24 20 02 00 	mov    0x220(%rsp),%rsi
    210d:	00 
    210e:	c5 fd 6f b4 24 00 02 	vmovdqa 0x200(%rsp),%ymm6
    2115:	00 00 
    2117:	e9 77 f2 ff ff       	jmp    1393 <scan_avx2+0xf3>
    211c:	0f 1f 40 00          	nopl   0x0(%rax)
    2120:	90                   	nop
    2121:	90                   	nop
    2122:	90                   	nop
    2123:	90                   	nop
    2124:	90                   	nop
    2125:	90                   	nop
    2126:	90                   	nop
    2127:	90                   	nop
    2128:	90                   	nop
    2129:	90                   	nop
    212a:	90                   	nop
    212b:	90                   	nop
    212c:	90                   	nop
    212d:	90                   	nop
    212e:	90                   	nop
    212f:	90                   	nop

0000000000002130 <n100_vector_encoder_avx2_available>:
    2130:	f3 0f 1e fa          	endbr64
    2134:	e8 00 00 00 00       	call   2139 <n100_vector_encoder_avx2_available+0x9>
    2139:	b8 01 00 00 00       	mov    $0x1,%eax
    213e:	e9 00 00 00 00       	jmp    2143 <n100_vector_encoder_avx2_available+0x13>
    2143:	66 90                	xchg   %ax,%ax
    2145:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    214c:	00 00 00 00 
    2150:	90                   	nop
    2151:	90                   	nop
    2152:	90                   	nop
    2153:	90                   	nop
    2154:	90                   	nop
    2155:	90                   	nop
    2156:	90                   	nop
    2157:	90                   	nop
    2158:	90                   	nop
    2159:	90                   	nop
    215a:	90                   	nop
    215b:	90                   	nop
    215c:	90                   	nop
    215d:	90                   	nop
    215e:	90                   	nop
    215f:	90                   	nop

0000000000002160 <n100_vector_encoder_encode_scalar>:
    2160:	f3 0f 1e fa          	endbr64
    2164:	e8 00 00 00 00       	call   2169 <n100_vector_encoder_encode_scalar+0x9>
    2169:	68 00 00 00 00       	push   $0x0
    216e:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    2175:	e8 66 e1 ff ff       	call   2e0 <encode>
    217a:	5a                   	pop    %rdx
    217b:	e9 00 00 00 00       	jmp    2180 <n100_vector_encoder_encode_scalar+0x20>
    2180:	90                   	nop
    2181:	90                   	nop
    2182:	90                   	nop
    2183:	90                   	nop
    2184:	90                   	nop
    2185:	90                   	nop
    2186:	90                   	nop
    2187:	90                   	nop
    2188:	90                   	nop
    2189:	90                   	nop
    218a:	90                   	nop
    218b:	90                   	nop
    218c:	90                   	nop
    218d:	90                   	nop
    218e:	90                   	nop
    218f:	90                   	nop

0000000000002190 <n100_vector_encoder_encode_avx2>:
    2190:	f3 0f 1e fa          	endbr64
    2194:	e8 00 00 00 00       	call   2199 <n100_vector_encoder_encode_avx2+0x9>
    2199:	68 00 00 00 00       	push   $0x0
    219e:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    21a5:	e8 36 e1 ff ff       	call   2e0 <encode>
    21aa:	5a                   	pop    %rdx
    21ab:	e9 00 00 00 00       	jmp    21b0 <n100_vector_encoder_encode_avx2+0x20>
    21b0:	90                   	nop
    21b1:	90                   	nop
    21b2:	90                   	nop
    21b3:	90                   	nop
    21b4:	90                   	nop
    21b5:	90                   	nop
    21b6:	90                   	nop
    21b7:	90                   	nop
    21b8:	90                   	nop
    21b9:	90                   	nop
    21ba:	90                   	nop
    21bb:	90                   	nop
    21bc:	90                   	nop
    21bd:	90                   	nop
    21be:	90                   	nop
    21bf:	90                   	nop

00000000000021c0 <n100_vector_encoder_decode_scalar>:
    21c0:	f3 0f 1e fa          	endbr64
    21c4:	e8 00 00 00 00       	call   21c9 <n100_vector_encoder_decode_scalar+0x9>
    21c9:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    21d0:	49 c7 c0 00 00 00 00 	mov    $0x0,%r8
    21d7:	e9 44 e8 ff ff       	jmp    a20 <decode>
    21dc:	0f 1f 40 00          	nopl   0x0(%rax)
    21e0:	90                   	nop
    21e1:	90                   	nop
    21e2:	90                   	nop
    21e3:	90                   	nop
    21e4:	90                   	nop
    21e5:	90                   	nop
    21e6:	90                   	nop
    21e7:	90                   	nop
    21e8:	90                   	nop
    21e9:	90                   	nop
    21ea:	90                   	nop
    21eb:	90                   	nop
    21ec:	90                   	nop
    21ed:	90                   	nop
    21ee:	90                   	nop
    21ef:	90                   	nop

00000000000021f0 <n100_vector_encoder_decode_avx2>:
    21f0:	f3 0f 1e fa          	endbr64
    21f4:	e8 00 00 00 00       	call   21f9 <n100_vector_encoder_decode_avx2+0x9>
    21f9:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9
    2200:	49 c7 c0 00 00 00 00 	mov    $0x0,%r8
    2207:	e9 14 e8 ff ff       	jmp    a20 <decode>

Disassembly of section .text.unlikely:

0000000000000000 <pack_avx2.cold>:
   0:	be 20 00 00 00       	mov    $0x20,%esi
   5:	bf 0e 00 00 00       	mov    $0xe,%edi
   a:	e8 00 00 00 00       	call   f <unpack_avx2.cold>

000000000000000f <unpack_avx2.cold>:
   f:	be 20 00 00 00       	mov    $0x20,%esi
  14:	bf 0f 00 00 00       	mov    $0xf,%edi
  19:	e8 00 00 00 00       	call   1e <pack_scalar+0xe>
