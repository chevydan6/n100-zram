
/home/dan/n100-zram/build/astra-simd-kernel-002/selftest.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <intact-0x10>:
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

0000000000000010 <intact>:
      10:	e8 00 00 00 00       	call   15 <intact+0x5>
      15:	55                   	push   %rbp
      16:	ba 10 00 00 00       	mov    $0x10,%edx
      1b:	48 89 f5             	mov    %rsi,%rbp
      1e:	be a5 00 00 00       	mov    $0xa5,%esi
      23:	53                   	push   %rbx
      24:	48 89 fb             	mov    %rdi,%rbx
      27:	e8 00 00 00 00       	call   2c <intact+0x1c>
      2c:	48 85 c0             	test   %rax,%rax
      2f:	74 09                	je     3a <intact+0x2a>
      31:	31 c0                	xor    %eax,%eax
      33:	5b                   	pop    %rbx
      34:	5d                   	pop    %rbp
      35:	e9 00 00 00 00       	jmp    3a <intact+0x2a>
      3a:	ba 38 10 00 00       	mov    $0x1038,%edx
      3f:	48 8d 7c 2b 10       	lea    0x10(%rbx,%rbp,1),%rdi
      44:	be a5 00 00 00       	mov    $0xa5,%esi
      49:	48 29 ea             	sub    %rbp,%rdx
      4c:	e8 00 00 00 00       	call   51 <intact+0x41>
      51:	5b                   	pop    %rbx
      52:	5d                   	pop    %rbp
      53:	48 85 c0             	test   %rax,%rax
      56:	0f 94 c0             	sete   %al
      59:	e9 00 00 00 00       	jmp    5e <intact+0x4e>
      5e:	66 90                	xchg   %ax,%ax
      60:	90                   	nop
      61:	90                   	nop
      62:	90                   	nop
      63:	90                   	nop
      64:	90                   	nop
      65:	90                   	nop
      66:	90                   	nop
      67:	90                   	nop
      68:	90                   	nop
      69:	90                   	nop
      6a:	90                   	nop
      6b:	90                   	nop
      6c:	90                   	nop
      6d:	90                   	nop
      6e:	90                   	nop
      6f:	90                   	nop

0000000000000070 <intact.constprop.0>:
      70:	e8 00 00 00 00       	call   75 <intact.constprop.0+0x5>
      75:	53                   	push   %rbx
      76:	ba 10 00 00 00       	mov    $0x10,%edx
      7b:	be a5 00 00 00       	mov    $0xa5,%esi
      80:	48 89 fb             	mov    %rdi,%rbx
      83:	e8 00 00 00 00       	call   88 <intact.constprop.0+0x18>
      88:	48 85 c0             	test   %rax,%rax
      8b:	74 08                	je     95 <intact.constprop.0+0x25>
      8d:	31 c0                	xor    %eax,%eax
      8f:	5b                   	pop    %rbx
      90:	e9 00 00 00 00       	jmp    95 <intact.constprop.0+0x25>
      95:	48 8d bb 10 10 00 00 	lea    0x1010(%rbx),%rdi
      9c:	ba 38 00 00 00       	mov    $0x38,%edx
      a1:	be a5 00 00 00       	mov    $0xa5,%esi
      a6:	e8 00 00 00 00       	call   ab <intact.constprop.0+0x3b>
      ab:	5b                   	pop    %rbx
      ac:	48 85 c0             	test   %rax,%rax
      af:	0f 94 c0             	sete   %al
      b2:	e9 00 00 00 00       	jmp    b7 <intact.constprop.0+0x47>
      b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
      be:	00 00 
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

00000000000000d0 <intact.constprop.2>:
      d0:	e8 00 00 00 00       	call   d5 <intact.constprop.2+0x5>
      d5:	53                   	push   %rbx
      d6:	ba 10 00 00 00       	mov    $0x10,%edx
      db:	be a5 00 00 00       	mov    $0xa5,%esi
      e0:	48 89 fb             	mov    %rdi,%rbx
      e3:	e8 00 00 00 00       	call   e8 <intact.constprop.2+0x18>
      e8:	48 85 c0             	test   %rax,%rax
      eb:	74 08                	je     f5 <intact.constprop.2+0x25>
      ed:	31 c0                	xor    %eax,%eax
      ef:	5b                   	pop    %rbx
      f0:	e9 00 00 00 00       	jmp    f5 <intact.constprop.2+0x25>
      f5:	48 8d 7b 30          	lea    0x30(%rbx),%rdi
      f9:	ba 18 10 00 00       	mov    $0x1018,%edx
      fe:	be a5 00 00 00       	mov    $0xa5,%esi
     103:	e8 00 00 00 00       	call   108 <intact.constprop.2+0x38>
     108:	5b                   	pop    %rbx
     109:	48 85 c0             	test   %rax,%rax
     10c:	0f 94 c0             	sete   %al
     10f:	e9 00 00 00 00       	jmp    114 <intact.constprop.2+0x44>
     114:	90                   	nop
     115:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     11c:	00 00 00 00 
     120:	90                   	nop
     121:	90                   	nop
     122:	90                   	nop
     123:	90                   	nop
     124:	90                   	nop
     125:	90                   	nop
     126:	90                   	nop
     127:	90                   	nop
     128:	90                   	nop
     129:	90                   	nop
     12a:	90                   	nop
     12b:	90                   	nop
     12c:	90                   	nop
     12d:	90                   	nop
     12e:	90                   	nop
     12f:	90                   	nop

0000000000000130 <exercise>:
     130:	f3 0f 1e fa          	endbr64
     134:	e8 00 00 00 00       	call   139 <exercise+0x9>
     139:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
     140:	be c0 0c 00 00       	mov    $0xcc0,%esi
     145:	48 89 9c 24 28 01 00 	mov    %rbx,0x128(%rsp)
     14c:	00 
     14d:	4c 89 b4 24 48 01 00 	mov    %r14,0x148(%rsp)
     154:	00 
     155:	4c 89 bc 24 50 01 00 	mov    %r15,0x150(%rsp)
     15c:	00 
     15d:	65 4c 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%r15        # 165 <exercise+0x35>
     164:	00 
     165:	4c 89 bc 24 20 01 00 	mov    %r15,0x120(%rsp)
     16c:	00 
     16d:	49 89 ff             	mov    %rdi,%r15
     170:	bf a0 71 00 00       	mov    $0x71a0,%edi
     175:	e8 00 00 00 00       	call   17a <exercise+0x4a>
     17a:	48 89 04 24          	mov    %rax,(%rsp)
     17e:	48 85 c0             	test   %rax,%rax
     181:	0f 84 d0 1c 00 00    	je     1e57 <exercise+0x1d27>
     187:	49 83 47 28 01       	addq   $0x1,0x28(%r15)
     18c:	41 8b 47 20          	mov    0x20(%r15),%eax
     190:	89 44 24 64          	mov    %eax,0x64(%rsp)
     194:	e8 00 00 00 00       	call   199 <exercise+0x69>
     199:	48 3d 20 10 00 00    	cmp    $0x1020,%rax
     19f:	0f 85 00 00 00 00    	jne    1a5 <exercise+0x75>
     1a5:	e8 00 00 00 00       	call   1aa <exercise+0x7a>
     1aa:	49 8b 4f 28          	mov    0x28(%r15),%rcx
     1ae:	48 3d 20 10 00 00    	cmp    $0x1020,%rax
     1b4:	0f 85 00 00 00 00    	jne    1ba <exercise+0x8a>
     1ba:	48 83 c1 01          	add    $0x1,%rcx
     1be:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     1c2:	e8 00 00 00 00       	call   1c7 <exercise+0x97>
     1c7:	48 83 f8 08          	cmp    $0x8,%rax
     1cb:	0f 85 00 00 00 00    	jne    1d1 <exercise+0xa1>
     1d1:	e8 00 00 00 00       	call   1d6 <exercise+0xa6>
     1d6:	48 83 f8 08          	cmp    $0x8,%rax
     1da:	0f 85 00 00 00 00    	jne    1e0 <exercise+0xb0>
     1e0:	48 8b 1c 24          	mov    (%rsp),%rbx
     1e4:	48 89 ac 24 30 01 00 	mov    %rbp,0x130(%rsp)
     1eb:	00 
     1ec:	45 31 f6             	xor    %r14d,%r14d
     1ef:	ba 80 20 00 00       	mov    $0x2080,%edx
     1f4:	be a5 00 00 00       	mov    $0xa5,%esi
     1f9:	4c 89 a4 24 38 01 00 	mov    %r12,0x138(%rsp)
     200:	00 
     201:	48 8d ab 20 51 00 00 	lea    0x5120(%rbx),%rbp
     208:	4c 89 ac 24 40 01 00 	mov    %r13,0x140(%rsp)
     20f:	00 
     210:	4c 8d a3 00 10 00 00 	lea    0x1000(%rbx),%r12
     217:	48 89 ef             	mov    %rbp,%rdi
     21a:	e8 00 00 00 00       	call   21f <exercise+0xef>
     21f:	44 89 f3             	mov    %r14d,%ebx
     222:	48 83 fb 03          	cmp    $0x3,%rbx
     226:	0f 83 17 1c 00 00    	jae    1e43 <exercise+0x1d13>
     22c:	ba 48 10 00 00       	mov    $0x1048,%edx
     231:	be a5 00 00 00       	mov    $0xa5,%esi
     236:	4c 89 e7             	mov    %r12,%rdi
     239:	e8 00 00 00 00       	call   23e <exercise+0x10e>
     23e:	49 83 47 28 01       	addq   $0x1,0x28(%r15)
     243:	48 83 fb 02          	cmp    $0x2,%rbx
     247:	0f 83 e2 1b 00 00    	jae    1e2f <exercise+0x1cff>
     24d:	4e 8b 2c f5 00 00 00 	mov    0x0(,%r14,8),%r13
     254:	00 
     255:	48 83 fb 03          	cmp    $0x3,%rbx
     259:	0f 83 bc 1b 00 00    	jae    1e1b <exercise+0x1ceb>
     25f:	49 8d 44 24 10       	lea    0x10(%r12),%rax
     264:	45 31 c9             	xor    %r9d,%r9d
     267:	b9 08 00 00 00       	mov    $0x8,%ecx
     26c:	31 f6                	xor    %esi,%esi
     26e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     273:	41 b8 0a 00 00 00    	mov    $0xa,%r8d
     279:	48 89 c2             	mov    %rax,%rdx
     27c:	68 20 10 00 00       	push   $0x1020
     281:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
     286:	2e e8 00 00 00 00    	cs call 28c <exercise+0x15c>
     28c:	49 8b 4f 28          	mov    0x28(%r15),%rcx
     290:	41 59                	pop    %r9
     292:	85 c0                	test   %eax,%eax
     294:	0f 85 00 00 00 00    	jne    29a <exercise+0x16a>
     29a:	48 83 c1 01          	add    $0x1,%rcx
     29e:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     2a2:	48 83 fb 02          	cmp    $0x2,%rbx
     2a6:	0f 83 42 1b 00 00    	jae    1dee <exercise+0x1cbe>
     2ac:	4c 8d 4d 10          	lea    0x10(%rbp),%r9
     2b0:	48 83 fb 03          	cmp    $0x3,%rbx
     2b4:	0f 83 16 1b 00 00    	jae    1dd0 <exercise+0x1ca0>
     2ba:	68 1f 10 00 00       	push   $0x101f
     2bf:	41 b8 0a 00 00 00    	mov    $0xa,%r8d
     2c5:	b9 08 00 00 00       	mov    $0x8,%ecx
     2ca:	31 f6                	xor    %esi,%esi
     2cc:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
     2d1:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
     2d6:	2e e8 00 00 00 00    	cs call 2dc <exercise+0x1ac>
     2dc:	49 8b 4f 28          	mov    0x28(%r15),%rcx
     2e0:	41 58                	pop    %r8
     2e2:	85 c0                	test   %eax,%eax
     2e4:	0f 85 00 00 00 00    	jne    2ea <exercise+0x1ba>
     2ea:	48 83 c1 01          	add    $0x1,%rcx
     2ee:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     2f2:	48 83 fb 02          	cmp    $0x2,%rbx
     2f6:	0f 83 1b 1a 00 00    	jae    1d17 <exercise+0x1be7>
     2fc:	4c 8d 4d 11          	lea    0x11(%rbp),%r9
     300:	48 83 fb 03          	cmp    $0x3,%rbx
     304:	0f 83 ef 19 00 00    	jae    1cf9 <exercise+0x1bc9>
     30a:	68 20 10 00 00       	push   $0x1020
     30f:	b9 08 00 00 00       	mov    $0x8,%ecx
     314:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
     319:	31 f6                	xor    %esi,%esi
     31b:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
     320:	41 b8 0a 00 00 00    	mov    $0xa,%r8d
     326:	2e e8 00 00 00 00    	cs call 32c <exercise+0x1fc>
     32c:	49 8b 4f 28          	mov    0x28(%r15),%rcx
     330:	5f                   	pop    %rdi
     331:	85 c0                	test   %eax,%eax
     333:	0f 85 00 00 00 00    	jne    339 <exercise+0x209>
     339:	48 83 c1 01          	add    $0x1,%rcx
     33d:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     341:	48 83 fb 03          	cmp    $0x3,%rbx
     345:	0f 83 9a 19 00 00    	jae    1ce5 <exercise+0x1bb5>
     34b:	ba 48 10 00 00       	mov    $0x1048,%edx
     350:	be a5 00 00 00       	mov    $0xa5,%esi
     355:	4c 89 e7             	mov    %r12,%rdi
     358:	e8 00 00 00 00       	call   35d <exercise+0x22d>
     35d:	49 8b 4f 28          	mov    0x28(%r15),%rcx
     361:	48 85 c0             	test   %rax,%rax
     364:	0f 85 00 00 00 00    	jne    36a <exercise+0x23a>
     36a:	48 83 c1 01          	add    $0x1,%rcx
     36e:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     372:	48 83 fb 03          	cmp    $0x3,%rbx
     376:	0f 83 55 19 00 00    	jae    1cd1 <exercise+0x1ba1>
     37c:	ba 40 10 00 00       	mov    $0x1040,%edx
     381:	be a5 00 00 00       	mov    $0xa5,%esi
     386:	48 89 ef             	mov    %rbp,%rdi
     389:	e8 00 00 00 00       	call   38e <exercise+0x25e>
     38e:	48 85 c0             	test   %rax,%rax
     391:	0f 85 00 00 00 00    	jne    397 <exercise+0x267>
     397:	49 81 c4 48 10 00 00 	add    $0x1048,%r12
     39e:	48 81 c5 40 10 00 00 	add    $0x1040,%rbp
     3a5:	49 83 fe 01          	cmp    $0x1,%r14
     3a9:	0f 85 b8 0a 00 00    	jne    e67 <exercise+0xd37>
     3af:	48 b8 47 48 59 31 20 	movabs $0x2031594847,%rax
     3b6:	00 00 00 
     3b9:	31 db                	xor    %ebx,%ebx
     3bb:	48 c7 84 24 0e 01 00 	movq   $0x0,0x10e(%rsp)
     3c2:	00 00 00 00 00 
     3c7:	41 bd 08 00 00 00    	mov    $0x8,%r13d
     3cd:	48 89 84 24 ee 00 00 	mov    %rax,0xee(%rsp)
     3d4:	00 
     3d5:	48 8b 04 24          	mov    (%rsp),%rax
     3d9:	48 c7 84 24 f6 00 00 	movq   $0x0,0xf6(%rsp)
     3e0:	00 00 00 00 00 
     3e5:	48 05 a0 30 00 00    	add    $0x30a0,%rax
     3eb:	c6 44 24 28 01       	movb   $0x1,0x28(%rsp)
     3f0:	48 c7 84 24 fe 00 00 	movq   $0x0,0xfe(%rsp)
     3f7:	00 00 00 00 00 
     3fc:	48 c7 84 24 06 01 00 	movq   $0x0,0x106(%rsp)
     403:	00 00 00 00 00 
     408:	c7 84 24 15 01 00 00 	movl   $0x0,0x115(%rsp)
     40f:	00 00 00 00 
     413:	48 c7 44 24 08 28 00 	movq   $0x28,0x8(%rsp)
     41a:	00 00 
     41c:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
     421:	4c 8b 04 24          	mov    (%rsp),%r8
     425:	31 ed                	xor    %ebp,%ebp
     427:	4e 8d b4 2c ee 00 00 	lea    0xee(%rsp,%r13,1),%r14
     42e:	00 
     42f:	49 8d 74 2d 00       	lea    0x0(%r13,%rbp,1),%rsi
     434:	48 83 fe 2b          	cmp    $0x2b,%rsi
     438:	0f 83 91 14 00 00    	jae    18cf <exercise+0x179f>
     43e:	44 8d 65 01          	lea    0x1(%rbp),%r12d
     442:	45 88 24 2e          	mov    %r12b,(%r14,%rbp,1)
     446:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
     44d:	0f 83 dd 14 00 00    	jae    1930 <exercise+0x1800>
     453:	45 88 24 28          	mov    %r12b,(%r8,%rbp,1)
     457:	48 83 c5 01          	add    $0x1,%rbp
     45b:	48 83 fd 20          	cmp    $0x20,%rbp
     45f:	75 ce                	jne    42f <exercise+0x2ff>
     461:	4c 8b 74 24 20       	mov    0x20(%rsp),%r14
     466:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
     46b:	89 5c 24 30          	mov    %ebx,0x30(%rsp)
     46f:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
     476:	00 00 
     478:	80 7c 24 28 01       	cmpb   $0x1,0x28(%rsp)
     47d:	4d 8d 66 f0          	lea    -0x10(%r14),%r12
     481:	48 19 c0             	sbb    %rax,%rax
     484:	31 db                	xor    %ebx,%ebx
     486:	83 e0 02             	and    $0x2,%eax
     489:	48 83 c0 2a          	add    $0x2a,%rax
     48d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
     492:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     497:	48 89 c5             	mov    %rax,%rbp
     49a:	48 8b 04 c5 00 00 00 	mov    0x0(,%rax,8),%rax
     4a1:	00 
     4a2:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     4a7:	48 83 fd 03          	cmp    $0x3,%rbp
     4ab:	0f 83 d9 18 00 00    	jae    1d8a <exercise+0x1c5a>
     4b1:	ba 48 10 00 00       	mov    $0x1048,%edx
     4b6:	be a5 00 00 00       	mov    $0xa5,%esi
     4bb:	4c 89 e7             	mov    %r12,%rdi
     4be:	e8 00 00 00 00       	call   4c3 <exercise+0x393>
     4c3:	48 83 fd 02          	cmp    $0x2,%rbp
     4c7:	0f 83 db 19 00 00    	jae    1ea8 <exercise+0x1d78>
     4cd:	48 83 fd 03          	cmp    $0x3,%rbp
     4d1:	0f 83 bd 19 00 00    	jae    1e94 <exercise+0x1d64>
     4d7:	b9 20 00 00 00       	mov    $0x20,%ecx
     4dc:	4c 89 f2             	mov    %r14,%rdx
     4df:	48 89 de             	mov    %rbx,%rsi
     4e2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
     4e7:	48 8d bc 24 ee 00 00 	lea    0xee(%rsp),%rdi
     4ee:	00 
     4ef:	e8 00 00 00 00       	call   4f4 <exercise+0x3c4>
     4f4:	49 39 dd             	cmp    %rbx,%r13
     4f7:	ba 20 00 00 00       	mov    $0x20,%edx
     4fc:	bf ff ff ff ff       	mov    $0xffffffff,%edi
     501:	89 c6                	mov    %eax,%esi
     503:	49 8b 47 28          	mov    0x28(%r15),%rax
     507:	0f 45 d7             	cmovne %edi,%edx
     50a:	48 8d 48 01          	lea    0x1(%rax),%rcx
     50e:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     512:	39 f2                	cmp    %esi,%edx
     514:	0f 85 00 00 00 00    	jne    51a <exercise+0x3ea>
     51a:	48 83 c0 02          	add    $0x2,%rax
     51e:	49 89 47 28          	mov    %rax,0x28(%r15)
     522:	48 83 fd 03          	cmp    $0x3,%rbp
     526:	0f 83 54 19 00 00    	jae    1e80 <exercise+0x1d50>
     52c:	4c 89 e7             	mov    %r12,%rdi
     52f:	e8 9c fb ff ff       	call   d0 <intact.constprop.2>
     534:	84 c0                	test   %al,%al
     536:	0f 84 00 00 00 00    	je     53c <exercise+0x40c>
     53c:	49 39 dd             	cmp    %rbx,%r13
     53f:	74 2c                	je     56d <exercise+0x43d>
     541:	48 83 c3 01          	add    $0x1,%rbx
     545:	48 3b 5c 24 10       	cmp    0x10(%rsp),%rbx
     54a:	0f 85 57 ff ff ff    	jne    4a7 <exercise+0x377>
     550:	49 81 c6 48 10 00 00 	add    $0x1048,%r14
     557:	48 83 7c 24 18 01    	cmpq   $0x1,0x18(%rsp)
     55d:	74 67                	je     5c6 <exercise+0x496>
     55f:	48 c7 44 24 18 01 00 	movq   $0x1,0x18(%rsp)
     566:	00 00 
     568:	e9 0b ff ff ff       	jmp    478 <exercise+0x348>
     56d:	49 8b 47 28          	mov    0x28(%r15),%rax
     571:	48 8d 48 01          	lea    0x1(%rax),%rcx
     575:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     579:	48 83 fd 03          	cmp    $0x3,%rbp
     57d:	0f 83 df 18 00 00    	jae    1e62 <exercise+0x1d32>
     583:	48 8b 04 24          	mov    (%rsp),%rax
     587:	49 8b 36             	mov    (%r14),%rsi
     58a:	48 39 30             	cmp    %rsi,(%rax)
     58d:	0f 85 00 00 00 00    	jne    593 <exercise+0x463>
     593:	49 8b 76 08          	mov    0x8(%r14),%rsi
     597:	48 39 70 08          	cmp    %rsi,0x8(%rax)
     59b:	0f 85 00 00 00 00    	jne    5a1 <exercise+0x471>
     5a1:	49 8b 76 10          	mov    0x10(%r14),%rsi
     5a5:	48 39 70 10          	cmp    %rsi,0x10(%rax)
     5a9:	0f 85 00 00 00 00    	jne    5af <exercise+0x47f>
     5af:	49 8b 76 18          	mov    0x18(%r14),%rsi
     5b3:	48 39 70 18          	cmp    %rsi,0x18(%rax)
     5b7:	0f 85 00 00 00 00    	jne    5bd <exercise+0x48d>
     5bd:	48 83 c3 01          	add    $0x1,%rbx
     5c1:	e9 e1 fe ff ff       	jmp    4a7 <exercise+0x377>
     5c6:	83 7c 24 30 01       	cmpl   $0x1,0x30(%rsp)
     5cb:	0f 85 00 08 00 00    	jne    dd1 <exercise+0xca1>
     5d1:	45 31 f6             	xor    %r14d,%r14d
     5d4:	48 b8 47 48 59 31 20 	movabs $0x1002031594847,%rax
     5db:	00 01 00 
     5de:	31 c9                	xor    %ecx,%ecx
     5e0:	48 c7 84 24 fe 00 00 	movq   $0x4,0xfe(%rsp)
     5e7:	00 04 00 00 00 
     5ec:	41 bc 12 00 00 00    	mov    $0x12,%r12d
     5f2:	48 89 84 24 ee 00 00 	mov    %rax,0xee(%rsp)
     5f9:	00 
     5fa:	48 b8 47 5a 52 31 20 	movabs $0x5002031525a47,%rax
     601:	00 05 00 
     604:	48 89 84 24 f6 00 00 	mov    %rax,0xf6(%rsp)
     60b:	00 
     60c:	48 8b 04 24          	mov    (%rsp),%rax
     610:	48 c7 84 24 06 01 00 	movq   $0x0,0x106(%rsp)
     617:	00 00 00 00 00 
     61c:	48 c7 84 24 0e 01 00 	movq   $0x0,0x10e(%rsp)
     623:	00 00 00 00 00 
     628:	48 c7 84 24 16 01 00 	movq   $0x0,0x116(%rsp)
     62f:	00 00 00 00 00 
     634:	66 89 8c 24 1e 01 00 	mov    %cx,0x11e(%rsp)
     63b:	00 
     63c:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
     643:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
     64a:	00 
     64b:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
     652:	00 
     653:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
     65a:	00 
     65b:	44 88 b4 24 ff 00 00 	mov    %r14b,0xff(%rsp)
     662:	00 
     663:	41 f6 c6 01          	test   $0x1,%r14b
     667:	74 17                	je     680 <exercise+0x550>
     669:	c7 84 24 00 01 00 00 	movl   $0x12340000,0x100(%rsp)
     670:	00 00 34 12 
     674:	41 bc 16 00 00 00    	mov    $0x16,%r12d
     67a:	c7 00 00 00 34 12    	movl   $0x12340000,(%rax)
     680:	41 f6 c6 02          	test   $0x2,%r14b
     684:	74 1b                	je     6a1 <exercise+0x571>
     686:	42 c7 84 24 ee 00 00 	movl   $0x12340001,0xee(%rsp,%r12,1)
     68d:	00 01 00 34 12 
     692:	48 8b 04 24          	mov    (%rsp),%rax
     696:	49 83 c4 04          	add    $0x4,%r12
     69a:	c7 40 04 01 00 34 12 	movl   $0x12340001,0x4(%rax)
     6a1:	41 f6 c6 04          	test   $0x4,%r14b
     6a5:	74 1b                	je     6c2 <exercise+0x592>
     6a7:	42 c7 84 24 ee 00 00 	movl   $0x12340002,0xee(%rsp,%r12,1)
     6ae:	00 02 00 34 12 
     6b3:	48 8b 04 24          	mov    (%rsp),%rax
     6b7:	49 83 c4 04          	add    $0x4,%r12
     6bb:	c7 40 08 02 00 34 12 	movl   $0x12340002,0x8(%rax)
     6c2:	41 f6 c6 08          	test   $0x8,%r14b
     6c6:	74 1b                	je     6e3 <exercise+0x5b3>
     6c8:	42 c7 84 24 ee 00 00 	movl   $0x12340003,0xee(%rsp,%r12,1)
     6cf:	00 03 00 34 12 
     6d4:	48 8b 04 24          	mov    (%rsp),%rax
     6d8:	49 83 c4 04          	add    $0x4,%r12
     6dc:	c7 40 0c 03 00 34 12 	movl   $0x12340003,0xc(%rax)
     6e3:	41 f6 c6 10          	test   $0x10,%r14b
     6e7:	74 1b                	je     704 <exercise+0x5d4>
     6e9:	42 c7 84 24 ee 00 00 	movl   $0x12340004,0xee(%rsp,%r12,1)
     6f0:	00 04 00 34 12 
     6f5:	48 8b 04 24          	mov    (%rsp),%rax
     6f9:	49 83 c4 04          	add    $0x4,%r12
     6fd:	c7 40 10 04 00 34 12 	movl   $0x12340004,0x10(%rax)
     704:	41 f6 c6 20          	test   $0x20,%r14b
     708:	74 1b                	je     725 <exercise+0x5f5>
     70a:	42 c7 84 24 ee 00 00 	movl   $0x12340005,0xee(%rsp,%r12,1)
     711:	00 05 00 34 12 
     716:	48 8b 04 24          	mov    (%rsp),%rax
     71a:	49 83 c4 04          	add    $0x4,%r12
     71e:	c7 40 14 05 00 34 12 	movl   $0x12340005,0x14(%rax)
     725:	41 f6 c6 40          	test   $0x40,%r14b
     729:	74 1b                	je     746 <exercise+0x616>
     72b:	42 c7 84 24 ee 00 00 	movl   $0x12340006,0xee(%rsp,%r12,1)
     732:	00 06 00 34 12 
     737:	48 8b 04 24          	mov    (%rsp),%rax
     73b:	49 83 c4 04          	add    $0x4,%r12
     73f:	c7 40 18 06 00 34 12 	movl   $0x12340006,0x18(%rax)
     746:	41 f6 c6 80          	test   $0x80,%r14b
     74a:	74 1b                	je     767 <exercise+0x637>
     74c:	42 c7 84 24 ee 00 00 	movl   $0x12340007,0xee(%rsp,%r12,1)
     753:	00 07 00 34 12 
     758:	48 8b 04 24          	mov    (%rsp),%rax
     75c:	49 83 c4 04          	add    $0x4,%r12
     760:	c7 40 1c 07 00 34 12 	movl   $0x12340007,0x1c(%rax)
     767:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
     76c:	44 89 74 24 18       	mov    %r14d,0x18(%rsp)
     771:	4c 89 fd             	mov    %r15,%rbp
     774:	45 31 c0             	xor    %r8d,%r8d
     777:	49 89 cf             	mov    %rcx,%r15
     77a:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
     77f:	4d 8d 77 f0          	lea    -0x10(%r15),%r14
     783:	31 db                	xor    %ebx,%ebx
     785:	4d 89 c5             	mov    %r8,%r13
     788:	4a 8b 04 c5 00 00 00 	mov    0x0(,%r8,8),%rax
     78f:	00 
     790:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     795:	eb 04                	jmp    79b <exercise+0x66b>
     797:	48 83 c3 01          	add    $0x1,%rbx
     79b:	49 83 fd 03          	cmp    $0x3,%r13
     79f:	0f 83 45 11 00 00    	jae    18ea <exercise+0x17ba>
     7a5:	ba 48 10 00 00       	mov    $0x1048,%edx
     7aa:	be a5 00 00 00       	mov    $0xa5,%esi
     7af:	4c 89 f7             	mov    %r14,%rdi
     7b2:	e8 00 00 00 00       	call   7b7 <exercise+0x687>
     7b7:	49 83 fd 02          	cmp    $0x2,%r13
     7bb:	0f 83 b5 11 00 00    	jae    1976 <exercise+0x1846>
     7c1:	49 83 fd 03          	cmp    $0x3,%r13
     7c5:	0f 83 97 11 00 00    	jae    1962 <exercise+0x1832>
     7cb:	b9 20 00 00 00       	mov    $0x20,%ecx
     7d0:	4c 89 fa             	mov    %r15,%rdx
     7d3:	48 89 de             	mov    %rbx,%rsi
     7d6:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
     7db:	48 8d bc 24 ee 00 00 	lea    0xee(%rsp),%rdi
     7e2:	00 
     7e3:	e8 00 00 00 00       	call   7e8 <exercise+0x6b8>
     7e8:	49 39 dc             	cmp    %rbx,%r12
     7eb:	ba 20 00 00 00       	mov    $0x20,%edx
     7f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     7f5:	89 c1                	mov    %eax,%ecx
     7f7:	48 8b 45 28          	mov    0x28(%rbp),%rax
     7fb:	0f 45 d6             	cmovne %esi,%edx
     7fe:	48 8d 78 01          	lea    0x1(%rax),%rdi
     802:	48 89 7d 28          	mov    %rdi,0x28(%rbp)
     806:	39 ca                	cmp    %ecx,%edx
     808:	0f 85 00 00 00 00    	jne    80e <exercise+0x6de>
     80e:	48 83 c0 02          	add    $0x2,%rax
     812:	48 89 45 28          	mov    %rax,0x28(%rbp)
     816:	49 83 fd 03          	cmp    $0x3,%r13
     81a:	0f 83 2e 11 00 00    	jae    194e <exercise+0x181e>
     820:	4c 89 f7             	mov    %r14,%rdi
     823:	e8 a8 f8 ff ff       	call   d0 <intact.constprop.2>
     828:	84 c0                	test   %al,%al
     82a:	0f 84 00 00 00 00    	je     830 <exercise+0x700>
     830:	49 39 dc             	cmp    %rbx,%r12
     833:	0f 85 5e ff ff ff    	jne    797 <exercise+0x667>
     839:	48 8b 45 28          	mov    0x28(%rbp),%rax
     83d:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
     842:	48 8d 58 01          	lea    0x1(%rax),%rbx
     846:	48 89 5d 28          	mov    %rbx,0x28(%rbp)
     84a:	49 83 fd 03          	cmp    $0x3,%r13
     84e:	0f 83 26 14 00 00    	jae    1c7a <exercise+0x1b4a>
     854:	48 8b 04 24          	mov    (%rsp),%rax
     858:	49 8b 0f             	mov    (%r15),%rcx
     85b:	48 39 08             	cmp    %rcx,(%rax)
     85e:	0f 85 00 00 00 00    	jne    864 <exercise+0x734>
     864:	49 8b 4f 08          	mov    0x8(%r15),%rcx
     868:	48 39 48 08          	cmp    %rcx,0x8(%rax)
     86c:	0f 85 00 00 00 00    	jne    872 <exercise+0x742>
     872:	49 8b 4f 10          	mov    0x10(%r15),%rcx
     876:	48 39 48 10          	cmp    %rcx,0x10(%rax)
     87a:	0f 85 00 00 00 00    	jne    880 <exercise+0x750>
     880:	49 8b 4f 18          	mov    0x18(%r15),%rcx
     884:	48 39 48 18          	cmp    %rcx,0x18(%rax)
     888:	0f 85 00 00 00 00    	jne    88e <exercise+0x75e>
     88e:	49 81 c7 48 10 00 00 	add    $0x1048,%r15
     895:	49 83 f8 01          	cmp    $0x1,%r8
     899:	0f 85 b2 05 00 00    	jne    e51 <exercise+0xd21>
     89f:	44 8b 74 24 18       	mov    0x18(%rsp),%r14d
     8a4:	49 89 ef             	mov    %rbp,%r15
     8a7:	48 8d 98 90 30 00 00 	lea    0x3090(%rax),%rbx
     8ae:	45 31 ed             	xor    %r13d,%r13d
     8b1:	44 89 ed             	mov    %r13d,%ebp
     8b4:	48 83 fd 03          	cmp    $0x3,%rbp
     8b8:	0f 83 86 14 00 00    	jae    1d44 <exercise+0x1c14>
     8be:	ba 48 10 00 00       	mov    $0x1048,%edx
     8c3:	be a5 00 00 00       	mov    $0xa5,%esi
     8c8:	48 89 df             	mov    %rbx,%rdi
     8cb:	e8 00 00 00 00       	call   8d0 <exercise+0x7a0>
     8d0:	49 83 47 28 01       	addq   $0x1,0x28(%r15)
     8d5:	48 83 fd 02          	cmp    $0x2,%rbp
     8d9:	0f 83 79 14 00 00    	jae    1d58 <exercise+0x1c28>
     8df:	4a 8b 04 ed 00 00 00 	mov    0x0(,%r13,8),%rax
     8e6:	00 
     8e7:	48 83 fd 03          	cmp    $0x3,%rbp
     8eb:	0f 83 7b 14 00 00    	jae    1d6c <exercise+0x1c3c>
     8f1:	b9 1f 00 00 00       	mov    $0x1f,%ecx
     8f6:	48 8d 53 10          	lea    0x10(%rbx),%rdx
     8fa:	4c 89 e6             	mov    %r12,%rsi
     8fd:	48 8d bc 24 ee 00 00 	lea    0xee(%rsp),%rdi
     904:	00 
     905:	e8 00 00 00 00       	call   90a <exercise+0x7da>
     90a:	49 8b 4f 28          	mov    0x28(%r15),%rcx
     90e:	83 f8 ff             	cmp    $0xffffffff,%eax
     911:	0f 85 00 00 00 00    	jne    917 <exercise+0x7e7>
     917:	48 83 c1 01          	add    $0x1,%rcx
     91b:	49 89 4f 28          	mov    %rcx,0x28(%r15)
     91f:	48 83 fd 03          	cmp    $0x3,%rbp
     923:	0f 83 6f 13 00 00    	jae    1c98 <exercise+0x1b68>
     929:	ba 10 00 00 00       	mov    $0x10,%edx
     92e:	be a5 00 00 00       	mov    $0xa5,%esi
     933:	48 89 df             	mov    %rbx,%rdi
     936:	e8 00 00 00 00       	call   93b <exercise+0x80b>
     93b:	48 85 c0             	test   %rax,%rax
     93e:	0f 85 00 00 00 00    	jne    944 <exercise+0x814>
     944:	48 8d 7b 2f          	lea    0x2f(%rbx),%rdi
     948:	ba 19 10 00 00       	mov    $0x1019,%edx
     94d:	be a5 00 00 00       	mov    $0xa5,%esi
     952:	e8 00 00 00 00       	call   957 <exercise+0x827>
     957:	48 85 c0             	test   %rax,%rax
     95a:	0f 85 00 00 00 00    	jne    960 <exercise+0x830>
     960:	48 81 c3 48 10 00 00 	add    $0x1048,%rbx
     967:	49 83 fd 01          	cmp    $0x1,%r13
     96b:	0f 85 eb 04 00 00    	jne    e5c <exercise+0xd2c>
     971:	41 83 c6 01          	add    $0x1,%r14d
     975:	41 81 fe 00 01 00 00 	cmp    $0x100,%r14d
     97c:	0f 85 52 fc ff ff    	jne    5d4 <exercise+0x4a4>
     982:	45 31 ed             	xor    %r13d,%r13d
     985:	4d 89 fc             	mov    %r15,%r12
     988:	48 b8 04 00 00 00 08 	movabs $0x800000004,%rax
     98f:	00 00 00 
     992:	44 89 ed             	mov    %r13d,%ebp
     995:	48 be 02 00 00 00 03 	movabs $0x300000002,%rsi
     99c:	00 00 00 
     99f:	48 b9 10 00 00 00 20 	movabs $0x2000000010,%rcx
     9a6:	00 00 00 
     9a9:	48 89 84 24 84 00 00 	mov    %rax,0x84(%rsp)
     9b0:	00 
     9b1:	48 89 84 24 a4 00 00 	mov    %rax,0xa4(%rsp)
     9b8:	00 
     9b9:	48 b8 24 00 00 00 28 	movabs $0x2800000024,%rax
     9c0:	00 00 00 
     9c3:	48 89 84 24 b4 00 00 	mov    %rax,0xb4(%rsp)
     9ca:	00 
     9cb:	48 b8 30 00 00 00 40 	movabs $0x4000000030,%rax
     9d2:	00 00 00 
     9d5:	48 89 84 24 bc 00 00 	mov    %rax,0xbc(%rsp)
     9dc:	00 
     9dd:	48 b8 60 00 00 00 80 	movabs $0x8000000060,%rax
     9e4:	00 00 00 
     9e7:	48 89 84 24 c4 00 00 	mov    %rax,0xc4(%rsp)
     9ee:	00 
     9ef:	48 b8 00 04 00 00 04 	movabs $0x40400000400,%rax
     9f6:	04 00 00 
     9f9:	48 89 84 24 cc 00 00 	mov    %rax,0xcc(%rsp)
     a00:	00 
     a01:	48 b8 08 04 00 00 10 	movabs $0x41000000408,%rax
     a08:	04 00 00 
     a0b:	48 89 84 24 d4 00 00 	mov    %rax,0xd4(%rsp)
     a12:	00 
     a13:	48 b8 20 04 00 00 00 	movabs $0x80000000420,%rax
     a1a:	08 00 00 
     a1d:	48 89 b4 24 94 00 00 	mov    %rsi,0x94(%rsp)
     a24:	00 
     a25:	48 be 05 00 00 00 06 	movabs $0x600000005,%rsi
     a2c:	00 00 00 
     a2f:	48 89 84 24 dc 00 00 	mov    %rax,0xdc(%rsp)
     a36:	00 
     a37:	48 b8 f0 0f 00 00 00 	movabs $0x100000000ff0,%rax
     a3e:	10 00 00 
     a41:	48 89 b4 24 9c 00 00 	mov    %rsi,0x9c(%rsp)
     a48:	00 
     a49:	44 89 ee             	mov    %r13d,%esi
     a4c:	48 89 8c 24 8c 00 00 	mov    %rcx,0x8c(%rsp)
     a53:	00 
     a54:	48 89 8c 24 ac 00 00 	mov    %rcx,0xac(%rsp)
     a5b:	00 
     a5c:	48 89 84 24 e4 00 00 	mov    %rax,0xe4(%rsp)
     a63:	00 
     a64:	41 83 fd 03          	cmp    $0x3,%r13d
     a68:	0f 87 af 14 00 00    	ja     1f1d <exercise+0x1ded>
     a6e:	48 b8 47 48 59 31 00 	movabs $0x1000031594847,%rax
     a75:	00 01 00 
     a78:	31 d2                	xor    %edx,%edx
     a7a:	89 ee                	mov    %ebp,%esi
     a7c:	42 8b 9c ac 84 00 00 	mov    0x84(%rsp,%r13,4),%ebx
     a83:	00 
     a84:	48 89 84 24 ee 00 00 	mov    %rax,0xee(%rsp)
     a8b:	00 
     a8c:	48 b8 47 5a 52 31 00 	movabs $0xc000031525a47,%rax
     a93:	00 0c 00 
     a96:	48 89 84 24 f6 00 00 	mov    %rax,0xf6(%rsp)
     a9d:	00 
     a9e:	8d 43 11             	lea    0x11(%rbx),%eax
     aa1:	48 c7 84 24 fe 00 00 	movq   $0x0,0xfe(%rsp)
     aa8:	00 00 00 00 00 
     aad:	48 c7 84 24 06 01 00 	movq   $0x0,0x106(%rsp)
     ab4:	00 00 00 00 00 
     ab9:	48 c7 84 24 0e 01 00 	movq   $0x0,0x10e(%rsp)
     ac0:	00 00 00 00 00 
     ac5:	48 c7 84 24 16 01 00 	movq   $0x0,0x116(%rsp)
     acc:	00 00 00 00 00 
     ad1:	66 89 94 24 1e 01 00 	mov    %dx,0x11e(%rsp)
     ad8:	00 
     ad9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
     ade:	83 fd 03             	cmp    $0x3,%ebp
     ae1:	0f 87 25 14 00 00    	ja     1f0c <exercise+0x1ddc>
     ae7:	42 8b 84 ac 94 00 00 	mov    0x94(%rsp,%r13,4),%eax
     aee:	00 
     aef:	41 89 d9             	mov    %ebx,%r9d
     af2:	88 84 24 fe 00 00 00 	mov    %al,0xfe(%rsp)
     af9:	4d 85 c9             	test   %r9,%r9
     afc:	74 2c                	je     b2a <exercise+0x9fa>
     afe:	49 8d 69 11          	lea    0x11(%r9),%rbp
     b02:	bb 11 00 00 00       	mov    $0x11,%ebx
     b07:	4d 89 ce             	mov    %r9,%r14
     b0a:	48 83 fb 32          	cmp    $0x32,%rbx
     b0e:	0f 83 a8 13 00 00    	jae    1ebc <exercise+0x1d8c>
     b14:	8d 43 f0             	lea    -0x10(%rbx),%eax
     b17:	88 84 1c ee 00 00 00 	mov    %al,0xee(%rsp,%rbx,1)
     b1e:	48 83 c3 01          	add    $0x1,%rbx
     b22:	48 39 eb             	cmp    %rbp,%rbx
     b25:	75 e3                	jne    b0a <exercise+0x9da>
     b27:	4d 89 f1             	mov    %r14,%r9
     b2a:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
     b2f:	31 db                	xor    %ebx,%ebx
     b31:	4c 89 4c 24 50       	mov    %r9,0x50(%rsp)
     b36:	eb 0e                	jmp    b46 <exercise+0xa16>
     b38:	48 83 c3 01          	add    $0x1,%rbx
     b3c:	48 83 fb 12          	cmp    $0x12,%rbx
     b40:	0f 84 7c 05 00 00    	je     10c2 <exercise+0xf92>
     b46:	89 de                	mov    %ebx,%esi
     b48:	83 fb 11             	cmp    $0x11,%ebx
     b4b:	0f 87 5f 14 00 00    	ja     1fb0 <exercise+0x1e80>
     b51:	8b ac 9c a4 00 00 00 	mov    0xa4(%rsp,%rbx,4),%ebp
     b58:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
     b5d:	31 d2                	xor    %edx,%edx
     b5f:	48 89 e8             	mov    %rbp,%rax
     b62:	89 6c 24 28          	mov    %ebp,0x28(%rsp)
     b66:	49 f7 f7             	div    %r15
     b69:	48 85 d2             	test   %rdx,%rdx
     b6c:	75 ca                	jne    b38 <exercise+0xa08>
     b6e:	66 89 ac 24 fa 00 00 	mov    %bp,0xfa(%rsp)
     b75:	00 
     b76:	66 89 ac 24 f2 00 00 	mov    %bp,0xf2(%rsp)
     b7d:	00 
     b7e:	48 85 ed             	test   %rbp,%rbp
     b81:	74 4c                	je     bcf <exercise+0xa9f>
     b83:	4c 89 e1             	mov    %r12,%rcx
     b86:	49 89 dc             	mov    %rbx,%r12
     b89:	48 8b 1c 24          	mov    (%rsp),%rbx
     b8d:	45 31 ed             	xor    %r13d,%r13d
     b90:	4c 89 e8             	mov    %r13,%rax
     b93:	31 d2                	xor    %edx,%edx
     b95:	49 f7 f7             	div    %r15
     b98:	4c 8d 72 11          	lea    0x11(%rdx),%r14
     b9c:	49 83 fe 32          	cmp    $0x32,%r14
     ba0:	0f 83 48 13 00 00    	jae    1eee <exercise+0x1dbe>
     ba6:	49 81 fd 00 10 00 00 	cmp    $0x1000,%r13
     bad:	0f 83 1d 13 00 00    	jae    1ed0 <exercise+0x1da0>
     bb3:	42 0f b6 84 34 ee 00 	movzbl 0xee(%rsp,%r14,1),%eax
     bba:	00 00 
     bbc:	42 88 04 2b          	mov    %al,(%rbx,%r13,1)
     bc0:	49 83 c5 01          	add    $0x1,%r13
     bc4:	4c 39 ed             	cmp    %r13,%rbp
     bc7:	75 c7                	jne    b90 <exercise+0xa60>
     bc9:	4c 89 e3             	mov    %r12,%rbx
     bcc:	49 89 cc             	mov    %rcx,%r12
     bcf:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
     bd4:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
     bd9:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
     be0:	00 00 
     be2:	48 c7 44 24 48 00 41 	movq   $0x4100,0x48(%rsp)
     be9:	00 00 
     beb:	49 8d 45 01          	lea    0x1(%r13),%rax
     bef:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
     bf4:	48 8b 04 24          	mov    (%rsp),%rax
     bf8:	4c 8d b0 90 30 00 00 	lea    0x3090(%rax),%r14
     bff:	49 8d 46 10          	lea    0x10(%r14),%rax
     c03:	31 db                	xor    %ebx,%ebx
     c05:	48 39 6c 24 48       	cmp    %rbp,0x48(%rsp)
     c0a:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
     c0f:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
     c14:	41 89 c7             	mov    %eax,%r15d
     c17:	48 8b 04 c5 00 00 00 	mov    0x0(,%rax,8),%rax
     c1e:	00 
     c1f:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     c24:	73 14                	jae    c3a <exercise+0xb0a>
     c26:	e9 00 00 00 00       	jmp    c2b <exercise+0xafb>
     c2b:	48 83 c3 01          	add    $0x1,%rbx
     c2f:	48 39 5c 24 30       	cmp    %rbx,0x30(%rsp)
     c34:	0f 82 e2 00 00 00    	jb     d1c <exercise+0xbec>
     c3a:	49 83 ff 03          	cmp    $0x3,%r15
     c3e:	0f 83 b9 13 00 00    	jae    1ffd <exercise+0x1ecd>
     c44:	ba 48 10 00 00       	mov    $0x1048,%edx
     c49:	be a5 00 00 00       	mov    $0xa5,%esi
     c4e:	4c 89 f7             	mov    %r14,%rdi
     c51:	e8 00 00 00 00       	call   c56 <exercise+0xb26>
     c56:	49 83 ff 02          	cmp    $0x2,%r15
     c5a:	0f 83 89 13 00 00    	jae    1fe9 <exercise+0x1eb9>
     c60:	49 83 ff 03          	cmp    $0x3,%r15
     c64:	0f 83 6b 13 00 00    	jae    1fd5 <exercise+0x1ea5>
     c6a:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
     c6f:	48 89 e9             	mov    %rbp,%rcx
     c72:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     c77:	48 89 de             	mov    %rbx,%rsi
     c7a:	48 8d bc 24 ee 00 00 	lea    0xee(%rsp),%rdi
     c81:	00 
     c82:	e8 00 00 00 00       	call   c87 <exercise+0xb57>
     c87:	4c 39 eb             	cmp    %r13,%rbx
     c8a:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
     c8f:	0f 44 4c 24 28       	cmove  0x28(%rsp),%ecx
     c94:	89 c2                	mov    %eax,%edx
     c96:	49 8b 44 24 28       	mov    0x28(%r12),%rax
     c9b:	39 d1                	cmp    %edx,%ecx
     c9d:	0f 85 00 00 00 00    	jne    ca3 <exercise+0xb73>
     ca3:	48 83 c0 02          	add    $0x2,%rax
     ca7:	49 89 44 24 28       	mov    %rax,0x28(%r12)
     cac:	49 83 ff 03          	cmp    $0x3,%r15
     cb0:	0f 83 0b 13 00 00    	jae    1fc1 <exercise+0x1e91>
     cb6:	48 89 ee             	mov    %rbp,%rsi
     cb9:	4c 89 f7             	mov    %r14,%rdi
     cbc:	e8 4f f3 ff ff       	call   10 <intact>
     cc1:	84 c0                	test   %al,%al
     cc3:	0f 84 98 13 00 00    	je     2061 <exercise+0x1f31>
     cc9:	4c 39 eb             	cmp    %r13,%rbx
     ccc:	0f 85 59 ff ff ff    	jne    c2b <exercise+0xafb>
     cd2:	49 8b 44 24 28       	mov    0x28(%r12),%rax
     cd7:	48 8d 48 01          	lea    0x1(%rax),%rcx
     cdb:	49 89 4c 24 28       	mov    %rcx,0x28(%r12)
     ce0:	49 83 ff 03          	cmp    $0x3,%r15
     ce4:	0f 83 59 13 00 00    	jae    2043 <exercise+0x1f13>
     cea:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     cef:	48 8b 3c 24          	mov    (%rsp),%rdi
     cf3:	48 89 ea             	mov    %rbp,%rdx
     cf6:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
     cfb:	e8 00 00 00 00       	call   d00 <exercise+0xbd0>
     d00:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
     d05:	85 c0                	test   %eax,%eax
     d07:	0f 85 00 00 00 00    	jne    d0d <exercise+0xbdd>
     d0d:	48 83 c3 01          	add    $0x1,%rbx
     d11:	48 39 5c 24 30       	cmp    %rbx,0x30(%rsp)
     d16:	0f 83 1e ff ff ff    	jae    c3a <exercise+0xb0a>
     d1c:	49 83 ff 03          	cmp    $0x3,%r15
     d20:	0f 83 44 12 00 00    	jae    1f6a <exercise+0x1e3a>
     d26:	ba 48 10 00 00       	mov    $0x1048,%edx
     d2b:	be a5 00 00 00       	mov    $0xa5,%esi
     d30:	4c 89 f7             	mov    %r14,%rdi
     d33:	e8 00 00 00 00       	call   d38 <exercise+0xc08>
     d38:	49 83 44 24 28 01    	addq   $0x1,0x28(%r12)
     d3e:	49 83 ff 02          	cmp    $0x2,%r15
     d42:	0f 83 0e 12 00 00    	jae    1f56 <exercise+0x1e26>
     d48:	48 8d 5d ff          	lea    -0x1(%rbp),%rbx
     d4c:	49 83 ff 03          	cmp    $0x3,%r15
     d50:	0f 83 ec 11 00 00    	jae    1f42 <exercise+0x1e12>
     d56:	48 89 d9             	mov    %rbx,%rcx
     d59:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
     d5e:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     d63:	4c 89 ee             	mov    %r13,%rsi
     d66:	48 8d bc 24 ee 00 00 	lea    0xee(%rsp),%rdi
     d6d:	00 
     d6e:	e8 00 00 00 00       	call   d73 <exercise+0xc43>
     d73:	49 8b 4c 24 28       	mov    0x28(%r12),%rcx
     d78:	83 f8 ff             	cmp    $0xffffffff,%eax
     d7b:	0f 85 00 00 00 00    	jne    d81 <exercise+0xc51>
     d81:	48 83 c1 01          	add    $0x1,%rcx
     d85:	49 89 4c 24 28       	mov    %rcx,0x28(%r12)
     d8a:	49 83 ff 03          	cmp    $0x3,%r15
     d8e:	0f 83 9a 11 00 00    	jae    1f2e <exercise+0x1dfe>
     d94:	48 89 de             	mov    %rbx,%rsi
     d97:	4c 89 f7             	mov    %r14,%rdi
     d9a:	e8 71 f2 ff ff       	call   10 <intact>
     d9f:	84 c0                	test   %al,%al
     da1:	0f 84 00 00 00 00    	je     da7 <exercise+0xc77>
     da7:	48 81 6c 24 48 48 10 	subq   $0x1048,0x48(%rsp)
     dae:	00 00 
     db0:	49 81 c6 48 10 00 00 	add    $0x1048,%r14
     db7:	48 83 7c 24 40 01    	cmpq   $0x1,0x40(%rsp)
     dbd:	0f 84 af 00 00 00    	je     e72 <exercise+0xd42>
     dc3:	48 c7 44 24 40 01 00 	movq   $0x1,0x40(%rsp)
     dca:	00 00 
     dcc:	e9 2e fe ff ff       	jmp    bff <exercise+0xacf>
     dd1:	be f0 11 00 00       	mov    $0x11f0,%esi
     dd6:	48 b8 47 48 59 31 20 	movabs $0x2031594847,%rax
     ddd:	00 00 00 
     de0:	48 c7 84 24 f6 00 00 	movq   $0x0,0xf6(%rsp)
     de7:	00 00 00 00 00 
     dec:	bb 01 00 00 00       	mov    $0x1,%ebx
     df1:	48 89 84 24 ee 00 00 	mov    %rax,0xee(%rsp)
     df8:	00 
     df9:	41 bd 0a 00 00 00    	mov    $0xa,%r13d
     dff:	48 c7 84 24 0e 01 00 	movq   $0x0,0x10e(%rsp)
     e06:	00 00 00 00 00 
     e0b:	48 c7 84 24 fe 00 00 	movq   $0x0,0xfe(%rsp)
     e12:	00 00 00 00 00 
     e17:	48 c7 84 24 06 01 00 	movq   $0x0,0x106(%rsp)
     e1e:	00 00 00 00 00 
     e23:	c7 84 24 15 01 00 00 	movl   $0x0,0x115(%rsp)
     e2a:	00 00 00 00 
     e2e:	c6 84 24 f4 00 00 00 	movb   $0x2,0xf4(%rsp)
     e35:	02 
     e36:	66 89 b4 24 f6 00 00 	mov    %si,0xf6(%rsp)
     e3d:	00 
     e3e:	c6 44 24 28 00       	movb   $0x0,0x28(%rsp)
     e43:	48 c7 44 24 08 2a 00 	movq   $0x2a,0x8(%rsp)
     e4a:	00 00 
     e4c:	e9 d0 f5 ff ff       	jmp    421 <exercise+0x2f1>
     e51:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     e57:	e9 1e f9 ff ff       	jmp    77a <exercise+0x64a>
     e5c:	41 bd 01 00 00 00    	mov    $0x1,%r13d
     e62:	e9 4a fa ff ff       	jmp    8b1 <exercise+0x781>
     e67:	41 be 01 00 00 00    	mov    $0x1,%r14d
     e6d:	e9 ad f3 ff ff       	jmp    21f <exercise+0xef>
     e72:	48 8b 5c 24 58       	mov    0x58(%rsp),%rbx
     e77:	4c 8d b4 24 ee 00 00 	lea    0xee(%rsp),%r14
     e7e:	00 
     e7f:	45 31 ff             	xor    %r15d,%r15d
     e82:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
     e87:	48 c7 44 24 7c 00 00 	movq   $0x0,0x7c(%rsp)
     e8e:	00 00 
     e90:	4d 89 f1             	mov    %r14,%r9
     e93:	45 31 f6             	xor    %r14d,%r14d
     e96:	e9 a3 00 00 00       	jmp    f3e <exercise+0xe0e>
     e9b:	49 8b 5c 24 28       	mov    0x28(%r12),%rbx
     ea0:	44 8b 6c 24 10       	mov    0x10(%rsp),%r13d
     ea5:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
     eaa:	8b 44 24 7c          	mov    0x7c(%rsp),%eax
     eae:	48 8d 53 01          	lea    0x1(%rbx),%rdx
     eb2:	49 89 54 24 28       	mov    %rdx,0x28(%r12)
     eb7:	3b 84 24 80 00 00 00 	cmp    0x80(%rsp),%eax
     ebe:	0f 85 00 00 00 00    	jne    ec4 <exercise+0xd94>
     ec4:	85 c0                	test   %eax,%eax
     ec6:	78 4a                	js     f12 <exercise+0xde2>
     ec8:	48 8b 0c 24          	mov    (%rsp),%rcx
     ecc:	48 83 c3 02          	add    $0x2,%rbx
     ed0:	89 c2                	mov    %eax,%edx
     ed2:	49 89 5c 24 28       	mov    %rbx,0x28(%r12)
     ed7:	48 8d b1 e8 40 00 00 	lea    0x40e8(%rcx),%rsi
     ede:	3d 00 41 00 00       	cmp    $0x4100,%eax
     ee3:	0f 87 00 00 00 00    	ja     ee9 <exercise+0xdb9>
     ee9:	48 81 fa b8 30 00 00 	cmp    $0x30b8,%rdx
     ef0:	0f 87 00 00 00 00    	ja     ef6 <exercise+0xdc6>
     ef6:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
     efb:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
     f00:	e8 00 00 00 00       	call   f05 <exercise+0xdd5>
     f05:	85 c0                	test   %eax,%eax
     f07:	0f 85 00 00 00 00    	jne    f0d <exercise+0xddd>
     f0d:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
     f12:	49 83 ff 32          	cmp    $0x32,%r15
     f16:	0f 83 37 09 00 00    	jae    1853 <exercise+0x1723>
     f1c:	41 0f b6 19          	movzbl (%r9),%ebx
     f20:	49 83 ff 32          	cmp    $0x32,%r15
     f24:	0f 83 0b 09 00 00    	jae    1835 <exercise+0x1705>
     f2a:	44 31 eb             	xor    %r13d,%ebx
     f2d:	41 83 c6 01          	add    $0x1,%r14d
     f31:	41 88 19             	mov    %bl,(%r9)
     f34:	41 83 fe 08          	cmp    $0x8,%r14d
     f38:	0f 84 f8 00 00 00    	je     1036 <exercise+0xf06>
     f3e:	41 bd 01 00 00 00    	mov    $0x1,%r13d
     f44:	44 89 f1             	mov    %r14d,%ecx
     f47:	41 d3 e5             	shl    %cl,%r13d
     f4a:	49 83 ff 32          	cmp    $0x32,%r15
     f4e:	0f 83 1d 09 00 00    	jae    1871 <exercise+0x1741>
     f54:	41 0f b6 19          	movzbl (%r9),%ebx
     f58:	49 83 ff 32          	cmp    $0x32,%r15
     f5c:	0f 83 41 09 00 00    	jae    18a3 <exercise+0x1773>
     f62:	48 8b 04 24          	mov    (%rsp),%rax
     f66:	31 ed                	xor    %ebp,%ebp
     f68:	44 31 eb             	xor    %r13d,%ebx
     f6b:	44 89 6c 24 10       	mov    %r13d,0x10(%rsp)
     f70:	41 89 ed             	mov    %ebp,%r13d
     f73:	41 88 19             	mov    %bl,(%r9)
     f76:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
     f7b:	48 8d 98 90 30 00 00 	lea    0x3090(%rax),%rbx
     f82:	49 83 fd 03          	cmp    $0x3,%r13
     f86:	0f 83 96 00 00 00    	jae    1022 <exercise+0xef2>
     f8c:	ba 48 10 00 00       	mov    $0x1048,%edx
     f91:	be a5 00 00 00       	mov    $0xa5,%esi
     f96:	48 89 df             	mov    %rbx,%rdi
     f99:	e8 00 00 00 00       	call   f9e <exercise+0xe6e>
     f9e:	49 83 fd 02          	cmp    $0x2,%r13
     fa2:	0f 83 06 01 00 00    	jae    10ae <exercise+0xf7e>
     fa8:	48 8b 04 ed 00 00 00 	mov    0x0(,%rbp,8),%rax
     faf:	00 
     fb0:	49 83 fd 03          	cmp    $0x3,%r13
     fb4:	0f 83 d6 00 00 00    	jae    1090 <exercise+0xf60>
     fba:	48 8d 53 10          	lea    0x10(%rbx),%rdx
     fbe:	49 83 fd 02          	cmp    $0x2,%r13
     fc2:	0f 83 a0 00 00 00    	jae    1068 <exercise+0xf38>
     fc8:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
     fcd:	b9 00 10 00 00       	mov    $0x1000,%ecx
     fd2:	48 8d bc 24 ee 00 00 	lea    0xee(%rsp),%rdi
     fd9:	00 
     fda:	e8 00 00 00 00       	call   fdf <exercise+0xeaf>
     fdf:	49 83 44 24 28 01    	addq   $0x1,0x28(%r12)
     fe5:	89 44 ac 7c          	mov    %eax,0x7c(%rsp,%rbp,4)
     fe9:	49 83 fd 03          	cmp    $0x3,%r13
     fed:	73 68                	jae    1057 <exercise+0xf27>
     fef:	48 89 df             	mov    %rbx,%rdi
     ff2:	e8 79 f0 ff ff       	call   70 <intact.constprop.0>
     ff7:	84 c0                	test   %al,%al
     ff9:	0f 84 00 00 00 00    	je     fff <exercise+0xecf>
     fff:	48 81 c3 48 10 00 00 	add    $0x1048,%rbx
    1006:	48 83 fd 01          	cmp    $0x1,%rbp
    100a:	0f 84 8b fe ff ff    	je     e9b <exercise+0xd6b>
    1010:	bd 01 00 00 00       	mov    $0x1,%ebp
    1015:	41 89 ed             	mov    %ebp,%r13d
    1018:	49 83 fd 03          	cmp    $0x3,%r13
    101c:	0f 82 6a ff ff ff    	jb     f8c <exercise+0xe5c>
    1022:	4c 89 ee             	mov    %r13,%rsi
    1025:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    102c:	e8 00 00 00 00       	call   1031 <exercise+0xf01>
    1031:	e9 56 ff ff ff       	jmp    f8c <exercise+0xe5c>
    1036:	49 83 c7 01          	add    $0x1,%r15
    103a:	4d 8d 71 01          	lea    0x1(%r9),%r14
    103e:	49 83 ff 11          	cmp    $0x11,%r15
    1042:	0f 85 3f fe ff ff    	jne    e87 <exercise+0xd57>
    1048:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
    104d:	e8 00 00 00 00       	call   1052 <exercise+0xf22>
    1052:	e9 e1 fa ff ff       	jmp    b38 <exercise+0xa08>
    1057:	4c 89 ee             	mov    %r13,%rsi
    105a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1061:	e8 00 00 00 00       	call   1066 <exercise+0xf36>
    1066:	eb 87                	jmp    fef <exercise+0xebf>
    1068:	4c 89 ee             	mov    %r13,%rsi
    106b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1072:	48 89 54 24 38       	mov    %rdx,0x38(%rsp)
    1077:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    107c:	e8 00 00 00 00       	call   1081 <exercise+0xf51>
    1081:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
    1086:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    108b:	e9 38 ff ff ff       	jmp    fc8 <exercise+0xe98>
    1090:	4c 89 ee             	mov    %r13,%rsi
    1093:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    109a:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    109f:	e8 00 00 00 00       	call   10a4 <exercise+0xf74>
    10a4:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    10a9:	e9 0c ff ff ff       	jmp    fba <exercise+0xe8a>
    10ae:	4c 89 ee             	mov    %r13,%rsi
    10b1:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    10b8:	e8 00 00 00 00       	call   10bd <exercise+0xf8d>
    10bd:	e9 e6 fe ff ff       	jmp    fa8 <exercise+0xe78>
    10c2:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    10c7:	49 83 c5 01          	add    $0x1,%r13
    10cb:	49 83 fd 04          	cmp    $0x4,%r13
    10cf:	0f 85 b3 f8 ff ff    	jne    988 <exercise+0x858>
    10d5:	48 8b 04 24          	mov    (%rsp),%rax
    10d9:	44 8b 7c 24 64       	mov    0x64(%rsp),%r15d
    10de:	4d 89 e6             	mov    %r12,%r14
    10e1:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    10e8:	00 00 
    10ea:	48 05 30 51 00 00    	add    $0x5130,%rax
    10f0:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
    10f5:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    10fa:	89 c5                	mov    %eax,%ebp
    10fc:	83 e5 07             	and    $0x7,%ebp
    10ff:	8d 4d 05             	lea    0x5(%rbp),%ecx
    1102:	89 4c 24 64          	mov    %ecx,0x64(%rsp)
    1106:	48 83 f8 3f          	cmp    $0x3f,%rax
    110a:	0f 86 69 0a 00 00    	jbe    1b79 <exercise+0x1a49>
    1110:	a8 01                	test   $0x1,%al
    1112:	0f 84 a0 00 00 00    	je     11b8 <exercise+0x1088>
    1118:	48 c7 44 24 08 08 10 	movq   $0x1008,0x8(%rsp)
    111f:	00 00 
    1121:	41 bd 00 10 00 00    	mov    $0x1000,%r13d
    1127:	48 c7 84 24 a4 00 00 	movq   $0x0,0xa4(%rsp)
    112e:	00 00 00 00 00 
    1133:	83 fd 01             	cmp    $0x1,%ebp
    1136:	0f 84 6b 0a 00 00    	je     1ba7 <exercise+0x1a77>
    113c:	31 db                	xor    %ebx,%ebx
    113e:	eb 35                	jmp    1175 <exercise+0x1045>
    1140:	89 d8                	mov    %ebx,%eax
    1142:	41 89 dc             	mov    %ebx,%r12d
    1145:	83 e0 1f             	and    $0x1f,%eax
    1148:	41 83 e4 0f          	and    $0xf,%r12d
    114c:	83 fd 02             	cmp    $0x2,%ebp
    114f:	44 0f 45 e0          	cmovne %eax,%r12d
    1153:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    115a:	0f 83 05 0a 00 00    	jae    1b65 <exercise+0x1a35>
    1160:	48 8b 04 24          	mov    (%rsp),%rax
    1164:	44 88 24 18          	mov    %r12b,(%rax,%rbx,1)
    1168:	48 83 c3 01          	add    $0x1,%rbx
    116c:	4c 39 eb             	cmp    %r13,%rbx
    116f:	0f 84 d4 00 00 00    	je     1249 <exercise+0x1119>
    1175:	44 89 fa             	mov    %r15d,%edx
    1178:	c1 e2 0d             	shl    $0xd,%edx
    117b:	44 31 fa             	xor    %r15d,%edx
    117e:	89 d0                	mov    %edx,%eax
    1180:	c1 e8 11             	shr    $0x11,%eax
    1183:	31 d0                	xor    %edx,%eax
    1185:	41 89 c7             	mov    %eax,%r15d
    1188:	41 c1 e7 05          	shl    $0x5,%r15d
    118c:	41 31 c7             	xor    %eax,%r15d
    118f:	83 fd 04             	cmp    $0x4,%ebp
    1192:	0f 84 f7 06 00 00    	je     188f <exercise+0x175f>
    1198:	76 a6                	jbe    1140 <exercise+0x1010>
    119a:	83 fd 05             	cmp    $0x5,%ebp
    119d:	74 0f                	je     11ae <exercise+0x107e>
    119f:	83 fd 06             	cmp    $0x6,%ebp
    11a2:	75 0f                	jne    11b3 <exercise+0x1083>
    11a4:	f6 c3 20             	test   $0x20,%bl
    11a7:	74 0a                	je     11b3 <exercise+0x1083>
    11a9:	45 31 e4             	xor    %r12d,%r12d
    11ac:	eb a5                	jmp    1153 <exercise+0x1023>
    11ae:	f6 c3 1c             	test   $0x1c,%bl
    11b1:	75 f6                	jne    11a9 <exercise+0x1079>
    11b3:	45 89 fc             	mov    %r15d,%r12d
    11b6:	eb 9b                	jmp    1153 <exercise+0x1023>
    11b8:	48 c7 84 24 a4 00 00 	movq   $0x0,0xa4(%rsp)
    11bf:	00 00 00 00 00 
    11c4:	44 89 fa             	mov    %r15d,%edx
    11c7:	c1 e2 0d             	shl    $0xd,%edx
    11ca:	44 31 fa             	xor    %r15d,%edx
    11cd:	89 d0                	mov    %edx,%eax
    11cf:	c1 e8 11             	shr    $0x11,%eax
    11d2:	31 d0                	xor    %edx,%eax
    11d4:	89 c2                	mov    %eax,%edx
    11d6:	c1 e2 05             	shl    $0x5,%edx
    11d9:	31 c2                	xor    %eax,%edx
    11db:	41 89 d7             	mov    %edx,%r15d
    11de:	48 69 d2 01 f0 ff 00 	imul   $0xfff001,%rdx,%rdx
    11e5:	48 c1 ea 24          	shr    $0x24,%rdx
    11e9:	89 d0                	mov    %edx,%eax
    11eb:	c1 e0 0c             	shl    $0xc,%eax
    11ee:	01 d0                	add    %edx,%eax
    11f0:	44 89 fa             	mov    %r15d,%edx
    11f3:	29 c2                	sub    %eax,%edx
    11f5:	0f 84 b1 0a 00 00    	je     1cac <exercise+0x1b7c>
    11fb:	41 89 d5             	mov    %edx,%r13d
    11fe:	49 8d 45 08          	lea    0x8(%r13),%rax
    1202:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1207:	85 ed                	test   %ebp,%ebp
    1209:	0f 85 2d ff ff ff    	jne    113c <exercise+0x100c>
    120f:	31 db                	xor    %ebx,%ebx
    1211:	44 89 f8             	mov    %r15d,%eax
    1214:	c1 e0 0d             	shl    $0xd,%eax
    1217:	44 31 f8             	xor    %r15d,%eax
    121a:	89 c2                	mov    %eax,%edx
    121c:	c1 ea 11             	shr    $0x11,%edx
    121f:	31 d0                	xor    %edx,%eax
    1221:	41 89 c7             	mov    %eax,%r15d
    1224:	41 c1 e7 05          	shl    $0x5,%r15d
    1228:	41 31 c7             	xor    %eax,%r15d
    122b:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    1232:	0f 83 85 0a 00 00    	jae    1cbd <exercise+0x1b8d>
    1238:	48 8b 04 24          	mov    (%rsp),%rax
    123c:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    1240:	48 83 c3 01          	add    $0x1,%rbx
    1244:	4c 39 eb             	cmp    %r13,%rbx
    1247:	75 c8                	jne    1211 <exercise+0x10e1>
    1249:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
    124e:	44 89 7c 24 70       	mov    %r15d,0x70(%rsp)
    1253:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
    125a:	00 00 
    125c:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    1261:	48 8b 04 24          	mov    (%rsp),%rax
    1265:	48 05 00 10 00 00    	add    $0x1000,%rax
    126b:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1270:	8b 5c 24 28          	mov    0x28(%rsp),%ebx
    1274:	48 83 fb 03          	cmp    $0x3,%rbx
    1278:	0f 83 d3 08 00 00    	jae    1b51 <exercise+0x1a21>
    127e:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    1283:	ba 48 10 00 00       	mov    $0x1048,%edx
    1288:	be a5 00 00 00       	mov    $0xa5,%esi
    128d:	e8 00 00 00 00       	call   1292 <exercise+0x1162>
    1292:	48 83 fb 02          	cmp    $0x2,%rbx
    1296:	0f 83 a1 08 00 00    	jae    1b3d <exercise+0x1a0d>
    129c:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    12a1:	4c 8b 24 c5 00 00 00 	mov    0x0(,%rax,8),%r12
    12a8:	00 
    12a9:	48 83 fb 02          	cmp    $0x2,%rbx
    12ad:	0f 83 76 08 00 00    	jae    1b29 <exercise+0x19f9>
    12b3:	48 83 fb 03          	cmp    $0x3,%rbx
    12b7:	0f 83 58 08 00 00    	jae    1b15 <exercise+0x19e5>
    12bd:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    12c2:	48 83 c0 10          	add    $0x10,%rax
    12c6:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    12cb:	48 83 fb 02          	cmp    $0x2,%rbx
    12cf:	0f 83 2c 08 00 00    	jae    1b01 <exercise+0x19d1>
    12d5:	68 20 10 00 00       	push   $0x1020
    12da:	4c 89 ee             	mov    %r13,%rsi
    12dd:	4c 8b 4c 24 38       	mov    0x38(%rsp),%r9
    12e2:	44 8b 44 24 6c       	mov    0x6c(%rsp),%r8d
    12e7:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    12ec:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    12f1:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    12f6:	2e e8 00 00 00 00    	cs call 12fc <exercise+0x11cc>
    12fc:	41 89 c7             	mov    %eax,%r15d
    12ff:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    1304:	44 89 bc 84 ac 00 00 	mov    %r15d,0xac(%rsp,%rax,4)
    130b:	00 
    130c:	4d 8b 66 28          	mov    0x28(%r14),%r12
    1310:	49 8d 44 24 01       	lea    0x1(%r12),%rax
    1315:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    131a:	49 89 46 28          	mov    %rax,0x28(%r14)
    131e:	58                   	pop    %rax
    131f:	48 83 fb 02          	cmp    $0x2,%rbx
    1323:	0f 83 c4 07 00 00    	jae    1aed <exercise+0x19bd>
    1329:	45 85 ff             	test   %r15d,%r15d
    132c:	0f 8e 00 00 00 00    	jle    1332 <exercise+0x1202>
    1332:	48 83 fb 02          	cmp    $0x2,%rbx
    1336:	0f 83 9d 07 00 00    	jae    1ad9 <exercise+0x19a9>
    133c:	44 89 f8             	mov    %r15d,%eax
    133f:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    1344:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
    1349:	0f 82 00 00 00 00    	jb     134f <exercise+0x121f>
    134f:	49 83 c4 02          	add    $0x2,%r12
    1353:	4d 89 66 28          	mov    %r12,0x28(%r14)
    1357:	48 83 fb 03          	cmp    $0x3,%rbx
    135b:	0f 83 64 07 00 00    	jae    1ac5 <exercise+0x1995>
    1361:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    1366:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    136b:	e8 a0 ec ff ff       	call   10 <intact>
    1370:	49 8b 4e 28          	mov    0x28(%r14),%rcx
    1374:	84 c0                	test   %al,%al
    1376:	0f 84 00 00 00 00    	je     137c <exercise+0x124c>
    137c:	48 83 c1 01          	add    $0x1,%rcx
    1380:	49 89 4e 28          	mov    %rcx,0x28(%r14)
    1384:	48 83 fb 02          	cmp    $0x2,%rbx
    1388:	0f 83 23 07 00 00    	jae    1ab1 <exercise+0x1981>
    138e:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    1393:	ba 10 00 00 00       	mov    $0x10,%edx
    1398:	be a5 00 00 00       	mov    $0xa5,%esi
    139d:	48 8d 78 f0          	lea    -0x10(%rax),%rdi
    13a1:	e8 00 00 00 00       	call   13a6 <exercise+0x1276>
    13a6:	49 8b 4e 28          	mov    0x28(%r14),%rcx
    13aa:	48 85 c0             	test   %rax,%rax
    13ad:	0f 85 00 00 00 00    	jne    13b3 <exercise+0x1283>
    13b3:	48 83 c1 01          	add    $0x1,%rcx
    13b7:	49 89 4e 28          	mov    %rcx,0x28(%r14)
    13bb:	48 83 fb 02          	cmp    $0x2,%rbx
    13bf:	0f 83 d8 06 00 00    	jae    1a9d <exercise+0x196d>
    13c5:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    13ca:	ba 10 00 00 00       	mov    $0x10,%edx
    13cf:	be a5 00 00 00       	mov    $0xa5,%esi
    13d4:	48 8d b8 20 10 00 00 	lea    0x1020(%rax),%rdi
    13db:	e8 00 00 00 00       	call   13e0 <exercise+0x12b0>
    13e0:	49 8b 4e 28          	mov    0x28(%r14),%rcx
    13e4:	48 85 c0             	test   %rax,%rax
    13e7:	0f 85 00 00 00 00    	jne    13ed <exercise+0x12bd>
    13ed:	4c 8d 61 01          	lea    0x1(%rcx),%r12
    13f1:	4d 89 66 28          	mov    %r12,0x28(%r14)
    13f5:	48 83 fb 02          	cmp    $0x2,%rbx
    13f9:	0f 83 8a 06 00 00    	jae    1a89 <exercise+0x1959>
    13ff:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    1404:	44 0f b6 78 16       	movzbl 0x16(%rax),%r15d
    1409:	41 80 ff 02          	cmp    $0x2,%r15b
    140d:	0f 87 00 00 00 00    	ja     1413 <exercise+0x12e3>
    1413:	48 83 fb 02          	cmp    $0x2,%rbx
    1417:	0f 83 e5 05 00 00    	jae    1a02 <exercise+0x18d2>
    141d:	b8 01 00 00 00       	mov    $0x1,%eax
    1422:	44 89 f9             	mov    %r15d,%ecx
    1425:	89 6c 24 74          	mov    %ebp,0x74(%rsp)
    1429:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
    1430:	00 00 
    1432:	d3 e0                	shl    %cl,%eax
    1434:	41 09 46 30          	or     %eax,0x30(%r14)
    1438:	48 8b 04 24          	mov    (%rsp),%rax
    143c:	4c 8d a0 90 30 00 00 	lea    0x3090(%rax),%r12
    1443:	8b 6c 24 38          	mov    0x38(%rsp),%ebp
    1447:	48 83 fd 03          	cmp    $0x3,%rbp
    144b:	0f 83 9d 05 00 00    	jae    19ee <exercise+0x18be>
    1451:	ba 48 10 00 00       	mov    $0x1048,%edx
    1456:	be a5 00 00 00       	mov    $0xa5,%esi
    145b:	4c 89 e7             	mov    %r12,%rdi
    145e:	e8 00 00 00 00       	call   1463 <exercise+0x1333>
    1463:	49 83 46 28 01       	addq   $0x1,0x28(%r14)
    1468:	48 83 fd 02          	cmp    $0x2,%rbp
    146c:	0f 83 68 05 00 00    	jae    19da <exercise+0x18aa>
    1472:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    1477:	4c 8b 3c c5 00 00 00 	mov    0x0(,%rax,8),%r15
    147e:	00 
    147f:	48 83 fd 03          	cmp    $0x3,%rbp
    1483:	0f 83 3d 05 00 00    	jae    19c6 <exercise+0x1896>
    1489:	49 8d 44 24 10       	lea    0x10(%r12),%rax
    148e:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    1493:	48 83 fb 02          	cmp    $0x2,%rbx
    1497:	0f 83 15 05 00 00    	jae    19b2 <exercise+0x1882>
    149d:	48 83 fb 03          	cmp    $0x3,%rbx
    14a1:	0f 83 f7 04 00 00    	jae    199e <exercise+0x186e>
    14a7:	4c 89 e9             	mov    %r13,%rcx
    14aa:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    14af:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
    14b4:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
    14b9:	2e e8 00 00 00 00    	cs call 14bf <exercise+0x138f>
    14bf:	49 8b 4e 28          	mov    0x28(%r14),%rcx
    14c3:	48 98                	cltq
    14c5:	4c 39 e8             	cmp    %r13,%rax
    14c8:	0f 85 00 00 00 00    	jne    14ce <exercise+0x139e>
    14ce:	48 83 c1 01          	add    $0x1,%rcx
    14d2:	49 89 4e 28          	mov    %rcx,0x28(%r14)
    14d6:	48 83 fd 03          	cmp    $0x3,%rbp
    14da:	0f 83 4a 05 00 00    	jae    1a2a <exercise+0x18fa>
    14e0:	4c 89 ee             	mov    %r13,%rsi
    14e3:	4c 89 e7             	mov    %r12,%rdi
    14e6:	e8 25 eb ff ff       	call   10 <intact>
    14eb:	4d 8b 7e 28          	mov    0x28(%r14),%r15
    14ef:	84 c0                	test   %al,%al
    14f1:	0f 84 00 00 00 00    	je     14f7 <exercise+0x13c7>
    14f7:	49 8d 47 01          	lea    0x1(%r15),%rax
    14fb:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    1500:	49 89 46 28          	mov    %rax,0x28(%r14)
    1504:	48 83 fd 03          	cmp    $0x3,%rbp
    1508:	0f 83 08 05 00 00    	jae    1a16 <exercise+0x18e6>
    150e:	48 8b 74 24 48       	mov    0x48(%rsp),%rsi
    1513:	48 8b 3c 24          	mov    (%rsp),%rdi
    1517:	4c 89 ea             	mov    %r13,%rdx
    151a:	e8 00 00 00 00       	call   151f <exercise+0x13ef>
    151f:	85 c0                	test   %eax,%eax
    1521:	0f 85 00 00 00 00    	jne    1527 <exercise+0x13f7>
    1527:	49 81 c4 48 10 00 00 	add    $0x1048,%r12
    152e:	48 83 7c 24 38 01    	cmpq   $0x1,0x38(%rsp)
    1534:	0f 85 e3 02 00 00    	jne    181d <exercise+0x16ed>
    153a:	48 81 44 24 18 48 10 	addq   $0x1048,0x18(%rsp)
    1541:	00 00 
    1543:	8b 6c 24 74          	mov    0x74(%rsp),%ebp
    1547:	48 81 44 24 30 40 10 	addq   $0x1040,0x30(%rsp)
    154e:	00 00 
    1550:	48 83 7c 24 28 01    	cmpq   $0x1,0x28(%rsp)
    1556:	0f 85 65 03 00 00    	jne    18c1 <exercise+0x1791>
    155c:	4c 89 f9             	mov    %r15,%rcx
    155f:	44 8b 7c 24 70       	mov    0x70(%rsp),%r15d
    1564:	48 8d 41 02          	lea    0x2(%rcx),%rax
    1568:	49 89 46 28          	mov    %rax,0x28(%r14)
    156c:	44 8b a4 24 a4 00 00 	mov    0xa4(%rsp),%r12d
    1573:	00 
    1574:	44 3b a4 24 a8 00 00 	cmp    0xa8(%rsp),%r12d
    157b:	00 
    157c:	0f 85 00 00 00 00    	jne    1582 <exercise+0x1452>
    1582:	48 8b 04 24          	mov    (%rsp),%rax
    1586:	48 8d 59 03          	lea    0x3(%rcx),%rbx
    158a:	4d 63 ec             	movslq %r12d,%r13
    158d:	49 89 5e 28          	mov    %rbx,0x28(%r14)
    1591:	48 8d b0 58 20 00 00 	lea    0x2058(%rax),%rsi
    1598:	48 05 10 10 00 00    	add    $0x1010,%rax
    159e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    15a3:	49 81 fd 90 61 00 00 	cmp    $0x6190,%r13
    15aa:	0f 87 00 00 00 00    	ja     15b0 <exercise+0x1480>
    15b0:	49 81 fd 48 51 00 00 	cmp    $0x5148,%r13
    15b7:	0f 87 00 00 00 00    	ja     15bd <exercise+0x148d>
    15bd:	48 89 c7             	mov    %rax,%rdi
    15c0:	4c 89 ea             	mov    %r13,%rdx
    15c3:	e8 00 00 00 00       	call   15c8 <exercise+0x1498>
    15c8:	89 44 24 18          	mov    %eax,0x18(%rsp)
    15cc:	85 c0                	test   %eax,%eax
    15ce:	0f 85 00 00 00 00    	jne    15d4 <exercise+0x14a4>
    15d4:	89 e9                	mov    %ebp,%ecx
    15d6:	b8 01 00 00 00       	mov    $0x1,%eax
    15db:	d3 e0                	shl    %cl,%eax
    15dd:	89 c5                	mov    %eax,%ebp
    15df:	44 89 f8             	mov    %r15d,%eax
    15e2:	c1 e0 0d             	shl    $0xd,%eax
    15e5:	44 31 f8             	xor    %r15d,%eax
    15e8:	89 c2                	mov    %eax,%edx
    15ea:	c1 ea 11             	shr    $0x11,%edx
    15ed:	31 d0                	xor    %edx,%eax
    15ef:	89 c2                	mov    %eax,%edx
    15f1:	c1 e2 05             	shl    $0x5,%edx
    15f4:	31 d0                	xor    %edx,%eax
    15f6:	31 d2                	xor    %edx,%edx
    15f8:	41 89 c7             	mov    %eax,%r15d
    15fb:	41 f7 f4             	div    %r12d
    15fe:	44 8d 62 10          	lea    0x10(%rdx),%r12d
    1602:	49 81 fc 48 10 00 00 	cmp    $0x1048,%r12
    1609:	0f 83 43 06 00 00    	jae    1c52 <exercise+0x1b22>
    160f:	48 8b 04 24          	mov    (%rsp),%rax
    1613:	42 0f b6 9c 20 00 10 	movzbl 0x1000(%rax,%r12,1),%ebx
    161a:	00 00 
    161c:	49 81 fc 48 10 00 00 	cmp    $0x1048,%r12
    1623:	0f 83 c4 05 00 00    	jae    1bed <exercise+0x1abd>
    1629:	48 8b 04 24          	mov    (%rsp),%rax
    162d:	44 89 7c 24 28       	mov    %r15d,0x28(%rsp)
    1632:	31 eb                	xor    %ebp,%ebx
    1634:	31 ed                	xor    %ebp,%ebp
    1636:	42 88 9c 20 00 10 00 	mov    %bl,0x1000(%rax,%r12,1)
    163d:	00 
    163e:	4c 8d a0 90 30 00 00 	lea    0x3090(%rax),%r12
    1645:	89 eb                	mov    %ebp,%ebx
    1647:	48 83 fb 03          	cmp    $0x3,%rbx
    164b:	0f 83 c4 05 00 00    	jae    1c15 <exercise+0x1ae5>
    1651:	ba 48 10 00 00       	mov    $0x1048,%edx
    1656:	be a5 00 00 00       	mov    $0xa5,%esi
    165b:	4c 89 e7             	mov    %r12,%rdi
    165e:	e8 00 00 00 00       	call   1663 <exercise+0x1533>
    1663:	48 83 fb 02          	cmp    $0x2,%rbx
    1667:	0f 83 94 05 00 00    	jae    1c01 <exercise+0x1ad1>
    166d:	4c 8b 3c ed 00 00 00 	mov    0x0(,%rbp,8),%r15
    1674:	00 
    1675:	48 83 fb 03          	cmp    $0x3,%rbx
    1679:	0f 83 f6 03 00 00    	jae    1a75 <exercise+0x1945>
    167f:	49 8d 54 24 10       	lea    0x10(%r12),%rdx
    1684:	48 83 fb 02          	cmp    $0x2,%rbx
    1688:	0f 83 c9 03 00 00    	jae    1a57 <exercise+0x1927>
    168e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    1693:	b9 00 10 00 00       	mov    $0x1000,%ecx
    1698:	4c 89 ee             	mov    %r13,%rsi
    169b:	2e e8 00 00 00 00    	cs call 16a1 <exercise+0x1571>
    16a1:	89 84 ac a4 00 00 00 	mov    %eax,0xa4(%rsp,%rbp,4)
    16a8:	49 83 46 28 01       	addq   $0x1,0x28(%r14)
    16ad:	48 83 fb 03          	cmp    $0x3,%rbx
    16b1:	0f 83 d3 02 00 00    	jae    198a <exercise+0x185a>
    16b7:	4c 89 e7             	mov    %r12,%rdi
    16ba:	e8 b1 e9 ff ff       	call   70 <intact.constprop.0>
    16bf:	84 c0                	test   %al,%al
    16c1:	0f 84 00 00 00 00    	je     16c7 <exercise+0x1597>
    16c7:	49 81 c4 48 10 00 00 	add    $0x1048,%r12
    16ce:	48 83 fd 01          	cmp    $0x1,%rbp
    16d2:	0f 85 53 01 00 00    	jne    182b <exercise+0x16fb>
    16d8:	49 8b 46 28          	mov    0x28(%r14),%rax
    16dc:	44 8b 7c 24 28       	mov    0x28(%rsp),%r15d
    16e1:	48 8d 48 01          	lea    0x1(%rax),%rcx
    16e5:	49 89 4e 28          	mov    %rcx,0x28(%r14)
    16e9:	8b b4 24 a4 00 00 00 	mov    0xa4(%rsp),%esi
    16f0:	3b b4 24 a8 00 00 00 	cmp    0xa8(%rsp),%esi
    16f7:	0f 85 00 00 00 00    	jne    16fd <exercise+0x15cd>
    16fd:	85 f6                	test   %esi,%esi
    16ff:	78 40                	js     1741 <exercise+0x1611>
    1701:	48 8d 58 02          	lea    0x2(%rax),%rbx
    1705:	89 f2                	mov    %esi,%edx
    1707:	48 8b 04 24          	mov    (%rsp),%rax
    170b:	49 89 5e 28          	mov    %rbx,0x28(%r14)
    170f:	81 fe 00 41 00 00    	cmp    $0x4100,%esi
    1715:	0f 87 00 00 00 00    	ja     171b <exercise+0x15eb>
    171b:	48 81 fa b8 30 00 00 	cmp    $0x30b8,%rdx
    1722:	0f 87 00 00 00 00    	ja     1728 <exercise+0x15f8>
    1728:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    172d:	48 8d b0 e8 40 00 00 	lea    0x40e8(%rax),%rsi
    1734:	e8 00 00 00 00       	call   1739 <exercise+0x1609>
    1739:	85 c0                	test   %eax,%eax
    173b:	0f 85 00 00 00 00    	jne    1741 <exercise+0x1611>
    1741:	e8 00 00 00 00       	call   1746 <exercise+0x1616>
    1746:	48 83 44 24 10 01    	addq   $0x1,0x10(%rsp)
    174c:	48 81 7c 24 10 00 02 	cmpq   $0x200,0x10(%rsp)
    1753:	00 00 
    1755:	0f 85 9a f9 ff ff    	jne    10f5 <exercise+0xfc5>
    175b:	4d 89 f7             	mov    %r14,%r15
    175e:	44 8b 74 24 18       	mov    0x18(%rsp),%r14d
    1763:	49 8b 47 28          	mov    0x28(%r15),%rax
    1767:	48 8d 48 01          	lea    0x1(%rax),%rcx
    176b:	49 89 4f 28          	mov    %rcx,0x28(%r15)
    176f:	41 83 7f 30 07       	cmpl   $0x7,0x30(%r15)
    1774:	0f 85 00 00 00 00    	jne    177a <exercise+0x164a>
    177a:	48 8b ac 24 30 01 00 	mov    0x130(%rsp),%rbp
    1781:	00 
    1782:	4c 8b a4 24 38 01 00 	mov    0x138(%rsp),%r12
    1789:	00 
    178a:	4c 8b ac 24 40 01 00 	mov    0x140(%rsp),%r13
    1791:	00 
    1792:	48 8b 3c 24          	mov    (%rsp),%rdi
    1796:	e8 00 00 00 00       	call   179b <exercise+0x166b>
    179b:	45 89 77 24          	mov    %r14d,0x24(%r15)
    179f:	4c 89 ff             	mov    %r15,%rdi
    17a2:	e8 00 00 00 00       	call   17a7 <exercise+0x1677>
    17a7:	65 48 8b 1d 00 00 00 	mov    %gs:0x0(%rip),%rbx        # 17af <exercise+0x167f>
    17ae:	00 
    17af:	eb 1a                	jmp    17cb <exercise+0x169b>
    17b1:	e9 92 02 00 00       	jmp    1a48 <exercise+0x1918>
    17b6:	b8 01 00 00 00       	mov    $0x1,%eax
    17bb:	87 43 18             	xchg   %eax,0x18(%rbx)
    17be:	e8 00 00 00 00       	call   17c3 <exercise+0x1693>
    17c3:	84 c0                	test   %al,%al
    17c5:	0f 84 73 02 00 00    	je     1a3e <exercise+0x190e>
    17cb:	e8 00 00 00 00       	call   17d0 <exercise+0x16a0>
    17d0:	84 c0                	test   %al,%al
    17d2:	74 dd                	je     17b1 <exercise+0x1681>
    17d4:	e9 6d 04 00 00       	jmp    1c46 <exercise+0x1b16>
    17d9:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%rbx)
    17e0:	48 8b 84 24 20 01 00 	mov    0x120(%rsp),%rax
    17e7:	00 
    17e8:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 17f0 <exercise+0x16c0>
    17ef:	00 
    17f0:	0f 85 33 04 00 00    	jne    1c29 <exercise+0x1af9>
    17f6:	44 89 f0             	mov    %r14d,%eax
    17f9:	48 8b 9c 24 28 01 00 	mov    0x128(%rsp),%rbx
    1800:	00 
    1801:	4c 8b b4 24 48 01 00 	mov    0x148(%rsp),%r14
    1808:	00 
    1809:	4c 8b bc 24 50 01 00 	mov    0x150(%rsp),%r15
    1810:	00 
    1811:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    1818:	e9 00 00 00 00       	jmp    181d <exercise+0x16ed>
    181d:	48 c7 44 24 38 01 00 	movq   $0x1,0x38(%rsp)
    1824:	00 00 
    1826:	e9 18 fc ff ff       	jmp    1443 <exercise+0x1313>
    182b:	bd 01 00 00 00       	mov    $0x1,%ebp
    1830:	e9 10 fe ff ff       	jmp    1645 <exercise+0x1515>
    1835:	4c 89 fe             	mov    %r15,%rsi
    1838:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    183f:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    1844:	e8 00 00 00 00       	call   1849 <exercise+0x1719>
    1849:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    184e:	e9 d7 f6 ff ff       	jmp    f2a <exercise+0xdfa>
    1853:	4c 89 fe             	mov    %r15,%rsi
    1856:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    185d:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    1862:	e8 00 00 00 00       	call   1867 <exercise+0x1737>
    1867:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    186c:	e9 ab f6 ff ff       	jmp    f1c <exercise+0xdec>
    1871:	4c 89 fe             	mov    %r15,%rsi
    1874:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    187b:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    1880:	e8 00 00 00 00       	call   1885 <exercise+0x1755>
    1885:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    188a:	e9 c5 f6 ff ff       	jmp    f54 <exercise+0xe24>
    188f:	4c 89 e8             	mov    %r13,%rax
    1892:	48 d1 e8             	shr    $1,%rax
    1895:	48 39 c3             	cmp    %rax,%rbx
    1898:	0f 83 15 f9 ff ff    	jae    11b3 <exercise+0x1083>
    189e:	e9 06 f9 ff ff       	jmp    11a9 <exercise+0x1079>
    18a3:	4c 89 fe             	mov    %r15,%rsi
    18a6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    18ad:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    18b2:	e8 00 00 00 00       	call   18b7 <exercise+0x1787>
    18b7:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    18bc:	e9 a1 f6 ff ff       	jmp    f62 <exercise+0xe32>
    18c1:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    18c8:	00 00 
    18ca:	e9 a1 f9 ff ff       	jmp    1270 <exercise+0x1140>
    18cf:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    18d6:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    18db:	e8 00 00 00 00       	call   18e0 <exercise+0x17b0>
    18e0:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    18e5:	e9 54 eb ff ff       	jmp    43e <exercise+0x30e>
    18ea:	4c 89 ee             	mov    %r13,%rsi
    18ed:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    18f4:	e8 00 00 00 00       	call   18f9 <exercise+0x17c9>
    18f9:	49 83 fd 03          	cmp    $0x3,%r13
    18fd:	0f 82 a2 ee ff ff    	jb     7a5 <exercise+0x675>
    1903:	4c 89 ee             	mov    %r13,%rsi
    1906:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    190d:	e8 00 00 00 00       	call   1912 <exercise+0x17e2>
    1912:	49 83 fd 03          	cmp    $0x3,%r13
    1916:	0f 82 89 ee ff ff    	jb     7a5 <exercise+0x675>
    191c:	4c 89 ee             	mov    %r13,%rsi
    191f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1926:	e8 00 00 00 00       	call   192b <exercise+0x17fb>
    192b:	e9 75 ee ff ff       	jmp    7a5 <exercise+0x675>
    1930:	48 89 ee             	mov    %rbp,%rsi
    1933:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    193a:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    193f:	e8 00 00 00 00       	call   1944 <exercise+0x1814>
    1944:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    1949:	e9 05 eb ff ff       	jmp    453 <exercise+0x323>
    194e:	4c 89 ee             	mov    %r13,%rsi
    1951:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1958:	e8 00 00 00 00       	call   195d <exercise+0x182d>
    195d:	e9 be ee ff ff       	jmp    820 <exercise+0x6f0>
    1962:	4c 89 ee             	mov    %r13,%rsi
    1965:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    196c:	e8 00 00 00 00       	call   1971 <exercise+0x1841>
    1971:	e9 55 ee ff ff       	jmp    7cb <exercise+0x69b>
    1976:	4c 89 ee             	mov    %r13,%rsi
    1979:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1980:	e8 00 00 00 00       	call   1985 <exercise+0x1855>
    1985:	e9 37 ee ff ff       	jmp    7c1 <exercise+0x691>
    198a:	48 89 de             	mov    %rbx,%rsi
    198d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1994:	e8 00 00 00 00       	call   1999 <exercise+0x1869>
    1999:	e9 19 fd ff ff       	jmp    16b7 <exercise+0x1587>
    199e:	48 89 de             	mov    %rbx,%rsi
    19a1:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    19a8:	e8 00 00 00 00       	call   19ad <exercise+0x187d>
    19ad:	e9 f5 fa ff ff       	jmp    14a7 <exercise+0x1377>
    19b2:	48 89 de             	mov    %rbx,%rsi
    19b5:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    19bc:	e8 00 00 00 00       	call   19c1 <exercise+0x1891>
    19c1:	e9 d7 fa ff ff       	jmp    149d <exercise+0x136d>
    19c6:	48 89 ee             	mov    %rbp,%rsi
    19c9:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    19d0:	e8 00 00 00 00       	call   19d5 <exercise+0x18a5>
    19d5:	e9 af fa ff ff       	jmp    1489 <exercise+0x1359>
    19da:	48 89 ee             	mov    %rbp,%rsi
    19dd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    19e4:	e8 00 00 00 00       	call   19e9 <exercise+0x18b9>
    19e9:	e9 84 fa ff ff       	jmp    1472 <exercise+0x1342>
    19ee:	48 89 ee             	mov    %rbp,%rsi
    19f1:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    19f8:	e8 00 00 00 00       	call   19fd <exercise+0x18cd>
    19fd:	e9 4f fa ff ff       	jmp    1451 <exercise+0x1321>
    1a02:	48 89 de             	mov    %rbx,%rsi
    1a05:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a0c:	e8 00 00 00 00       	call   1a11 <exercise+0x18e1>
    1a11:	e9 07 fa ff ff       	jmp    141d <exercise+0x12ed>
    1a16:	48 89 ee             	mov    %rbp,%rsi
    1a19:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a20:	e8 00 00 00 00       	call   1a25 <exercise+0x18f5>
    1a25:	e9 e4 fa ff ff       	jmp    150e <exercise+0x13de>
    1a2a:	48 89 ee             	mov    %rbp,%rsi
    1a2d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a34:	e8 00 00 00 00       	call   1a39 <exercise+0x1909>
    1a39:	e9 a2 fa ff ff       	jmp    14e0 <exercise+0x13b0>
    1a3e:	e8 00 00 00 00       	call   1a43 <exercise+0x1913>
    1a43:	e9 83 fd ff ff       	jmp    17cb <exercise+0x169b>
    1a48:	bf 01 00 00 00       	mov    $0x1,%edi
    1a4d:	e8 00 00 00 00       	call   1a52 <exercise+0x1922>
    1a52:	e9 5f fd ff ff       	jmp    17b6 <exercise+0x1686>
    1a57:	48 89 de             	mov    %rbx,%rsi
    1a5a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a61:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    1a66:	e8 00 00 00 00       	call   1a6b <exercise+0x193b>
    1a6b:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
    1a70:	e9 19 fc ff ff       	jmp    168e <exercise+0x155e>
    1a75:	48 89 de             	mov    %rbx,%rsi
    1a78:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a7f:	e8 00 00 00 00       	call   1a84 <exercise+0x1954>
    1a84:	e9 f6 fb ff ff       	jmp    167f <exercise+0x154f>
    1a89:	48 89 de             	mov    %rbx,%rsi
    1a8c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1a93:	e8 00 00 00 00       	call   1a98 <exercise+0x1968>
    1a98:	e9 62 f9 ff ff       	jmp    13ff <exercise+0x12cf>
    1a9d:	48 89 de             	mov    %rbx,%rsi
    1aa0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1aa7:	e8 00 00 00 00       	call   1aac <exercise+0x197c>
    1aac:	e9 14 f9 ff ff       	jmp    13c5 <exercise+0x1295>
    1ab1:	48 89 de             	mov    %rbx,%rsi
    1ab4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1abb:	e8 00 00 00 00       	call   1ac0 <exercise+0x1990>
    1ac0:	e9 c9 f8 ff ff       	jmp    138e <exercise+0x125e>
    1ac5:	48 89 de             	mov    %rbx,%rsi
    1ac8:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1acf:	e8 00 00 00 00       	call   1ad4 <exercise+0x19a4>
    1ad4:	e9 88 f8 ff ff       	jmp    1361 <exercise+0x1231>
    1ad9:	48 89 de             	mov    %rbx,%rsi
    1adc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ae3:	e8 00 00 00 00       	call   1ae8 <exercise+0x19b8>
    1ae8:	e9 4f f8 ff ff       	jmp    133c <exercise+0x120c>
    1aed:	48 89 de             	mov    %rbx,%rsi
    1af0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1af7:	e8 00 00 00 00       	call   1afc <exercise+0x19cc>
    1afc:	e9 28 f8 ff ff       	jmp    1329 <exercise+0x11f9>
    1b01:	48 89 de             	mov    %rbx,%rsi
    1b04:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b0b:	e8 00 00 00 00       	call   1b10 <exercise+0x19e0>
    1b10:	e9 c0 f7 ff ff       	jmp    12d5 <exercise+0x11a5>
    1b15:	48 89 de             	mov    %rbx,%rsi
    1b18:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b1f:	e8 00 00 00 00       	call   1b24 <exercise+0x19f4>
    1b24:	e9 94 f7 ff ff       	jmp    12bd <exercise+0x118d>
    1b29:	48 89 de             	mov    %rbx,%rsi
    1b2c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b33:	e8 00 00 00 00       	call   1b38 <exercise+0x1a08>
    1b38:	e9 76 f7 ff ff       	jmp    12b3 <exercise+0x1183>
    1b3d:	48 89 de             	mov    %rbx,%rsi
    1b40:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b47:	e8 00 00 00 00       	call   1b4c <exercise+0x1a1c>
    1b4c:	e9 4b f7 ff ff       	jmp    129c <exercise+0x116c>
    1b51:	48 89 de             	mov    %rbx,%rsi
    1b54:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b5b:	e8 00 00 00 00       	call   1b60 <exercise+0x1a30>
    1b60:	e9 19 f7 ff ff       	jmp    127e <exercise+0x114e>
    1b65:	48 89 de             	mov    %rbx,%rsi
    1b68:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b6f:	e8 00 00 00 00       	call   1b74 <exercise+0x1a44>
    1b74:	e9 e7 f5 ff ff       	jmp    1160 <exercise+0x1030>
    1b79:	48 c7 84 24 a4 00 00 	movq   $0x0,0xa4(%rsp)
    1b80:	00 00 00 00 00 
    1b85:	49 89 c5             	mov    %rax,%r13
    1b88:	48 85 c0             	test   %rax,%rax
    1b8b:	0f 84 1b 01 00 00    	je     1cac <exercise+0x1b7c>
    1b91:	48 8d 40 08          	lea    0x8(%rax),%rax
    1b95:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1b9a:	85 ed                	test   %ebp,%ebp
    1b9c:	0f 85 91 f5 ff ff    	jne    1133 <exercise+0x1003>
    1ba2:	e9 68 f6 ff ff       	jmp    120f <exercise+0x10df>
    1ba7:	45 31 e4             	xor    %r12d,%r12d
    1baa:	44 89 fa             	mov    %r15d,%edx
    1bad:	44 89 e3             	mov    %r12d,%ebx
    1bb0:	c1 e2 0d             	shl    $0xd,%edx
    1bb3:	83 e3 03             	and    $0x3,%ebx
    1bb6:	44 31 fa             	xor    %r15d,%edx
    1bb9:	89 d0                	mov    %edx,%eax
    1bbb:	c1 e8 11             	shr    $0x11,%eax
    1bbe:	31 d0                	xor    %edx,%eax
    1bc0:	41 89 c7             	mov    %eax,%r15d
    1bc3:	41 c1 e7 05          	shl    $0x5,%r15d
    1bc7:	41 31 c7             	xor    %eax,%r15d
    1bca:	49 81 fc 00 10 00 00 	cmp    $0x1000,%r12
    1bd1:	0f 83 8f 00 00 00    	jae    1c66 <exercise+0x1b36>
    1bd7:	48 8b 04 24          	mov    (%rsp),%rax
    1bdb:	42 88 1c 20          	mov    %bl,(%rax,%r12,1)
    1bdf:	49 83 c4 01          	add    $0x1,%r12
    1be3:	4d 39 ec             	cmp    %r13,%r12
    1be6:	75 c2                	jne    1baa <exercise+0x1a7a>
    1be8:	e9 5c f6 ff ff       	jmp    1249 <exercise+0x1119>
    1bed:	4c 89 e6             	mov    %r12,%rsi
    1bf0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1bf7:	e8 00 00 00 00       	call   1bfc <exercise+0x1acc>
    1bfc:	e9 28 fa ff ff       	jmp    1629 <exercise+0x14f9>
    1c01:	48 89 de             	mov    %rbx,%rsi
    1c04:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1c0b:	e8 00 00 00 00       	call   1c10 <exercise+0x1ae0>
    1c10:	e9 58 fa ff ff       	jmp    166d <exercise+0x153d>
    1c15:	48 89 de             	mov    %rbx,%rsi
    1c18:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1c1f:	e8 00 00 00 00       	call   1c24 <exercise+0x1af4>
    1c24:	e9 28 fa ff ff       	jmp    1651 <exercise+0x1521>
    1c29:	48 89 ac 24 30 01 00 	mov    %rbp,0x130(%rsp)
    1c30:	00 
    1c31:	4c 89 a4 24 38 01 00 	mov    %r12,0x138(%rsp)
    1c38:	00 
    1c39:	4c 89 ac 24 40 01 00 	mov    %r13,0x140(%rsp)
    1c40:	00 
    1c41:	e8 00 00 00 00       	call   1c46 <exercise+0x1b16>
    1c46:	31 ff                	xor    %edi,%edi
    1c48:	e8 00 00 00 00       	call   1c4d <exercise+0x1b1d>
    1c4d:	e9 87 fb ff ff       	jmp    17d9 <exercise+0x16a9>
    1c52:	4c 89 e6             	mov    %r12,%rsi
    1c55:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1c5c:	e8 00 00 00 00       	call   1c61 <exercise+0x1b31>
    1c61:	e9 a9 f9 ff ff       	jmp    160f <exercise+0x14df>
    1c66:	4c 89 e6             	mov    %r12,%rsi
    1c69:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1c70:	e8 00 00 00 00       	call   1c75 <exercise+0x1b45>
    1c75:	e9 5d ff ff ff       	jmp    1bd7 <exercise+0x1aa7>
    1c7a:	4c 89 ee             	mov    %r13,%rsi
    1c7d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1c84:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
    1c89:	e8 00 00 00 00       	call   1c8e <exercise+0x1b5e>
    1c8e:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    1c93:	e9 bc eb ff ff       	jmp    854 <exercise+0x724>
    1c98:	48 89 ee             	mov    %rbp,%rsi
    1c9b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ca2:	e8 00 00 00 00       	call   1ca7 <exercise+0x1b77>
    1ca7:	e9 7d ec ff ff       	jmp    929 <exercise+0x7f9>
    1cac:	48 c7 44 24 08 08 00 	movq   $0x8,0x8(%rsp)
    1cb3:	00 00 
    1cb5:	45 31 ed             	xor    %r13d,%r13d
    1cb8:	e9 8c f5 ff ff       	jmp    1249 <exercise+0x1119>
    1cbd:	48 89 de             	mov    %rbx,%rsi
    1cc0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1cc7:	e8 00 00 00 00       	call   1ccc <exercise+0x1b9c>
    1ccc:	e9 67 f5 ff ff       	jmp    1238 <exercise+0x1108>
    1cd1:	48 89 de             	mov    %rbx,%rsi
    1cd4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1cdb:	e8 00 00 00 00       	call   1ce0 <exercise+0x1bb0>
    1ce0:	e9 97 e6 ff ff       	jmp    37c <exercise+0x24c>
    1ce5:	48 89 de             	mov    %rbx,%rsi
    1ce8:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1cef:	e8 00 00 00 00       	call   1cf4 <exercise+0x1bc4>
    1cf4:	e9 52 e6 ff ff       	jmp    34b <exercise+0x21b>
    1cf9:	48 89 de             	mov    %rbx,%rsi
    1cfc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d03:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    1d08:	e8 00 00 00 00       	call   1d0d <exercise+0x1bdd>
    1d0d:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    1d12:	e9 f3 e5 ff ff       	jmp    30a <exercise+0x1da>
    1d17:	48 89 de             	mov    %rbx,%rsi
    1d1a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d21:	e8 00 00 00 00       	call   1d26 <exercise+0x1bf6>
    1d26:	48 83 fb 02          	cmp    $0x2,%rbx
    1d2a:	0f 82 cc e5 ff ff    	jb     2fc <exercise+0x1cc>
    1d30:	48 89 de             	mov    %rbx,%rsi
    1d33:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d3a:	e8 00 00 00 00       	call   1d3f <exercise+0x1c0f>
    1d3f:	e9 b8 e5 ff ff       	jmp    2fc <exercise+0x1cc>
    1d44:	48 89 ee             	mov    %rbp,%rsi
    1d47:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d4e:	e8 00 00 00 00       	call   1d53 <exercise+0x1c23>
    1d53:	e9 66 eb ff ff       	jmp    8be <exercise+0x78e>
    1d58:	48 89 ee             	mov    %rbp,%rsi
    1d5b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d62:	e8 00 00 00 00       	call   1d67 <exercise+0x1c37>
    1d67:	e9 73 eb ff ff       	jmp    8df <exercise+0x7af>
    1d6c:	48 89 ee             	mov    %rbp,%rsi
    1d6f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d76:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1d7b:	e8 00 00 00 00       	call   1d80 <exercise+0x1c50>
    1d80:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    1d85:	e9 67 eb ff ff       	jmp    8f1 <exercise+0x7c1>
    1d8a:	48 89 ee             	mov    %rbp,%rsi
    1d8d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1d94:	e8 00 00 00 00       	call   1d99 <exercise+0x1c69>
    1d99:	48 83 fd 03          	cmp    $0x3,%rbp
    1d9d:	0f 82 0e e7 ff ff    	jb     4b1 <exercise+0x381>
    1da3:	48 89 ee             	mov    %rbp,%rsi
    1da6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1dad:	e8 00 00 00 00       	call   1db2 <exercise+0x1c82>
    1db2:	48 83 fd 03          	cmp    $0x3,%rbp
    1db6:	0f 82 f5 e6 ff ff    	jb     4b1 <exercise+0x381>
    1dbc:	48 89 ee             	mov    %rbp,%rsi
    1dbf:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1dc6:	e8 00 00 00 00       	call   1dcb <exercise+0x1c9b>
    1dcb:	e9 e1 e6 ff ff       	jmp    4b1 <exercise+0x381>
    1dd0:	48 89 de             	mov    %rbx,%rsi
    1dd3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1dda:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    1ddf:	e8 00 00 00 00       	call   1de4 <exercise+0x1cb4>
    1de4:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    1de9:	e9 cc e4 ff ff       	jmp    2ba <exercise+0x18a>
    1dee:	48 89 de             	mov    %rbx,%rsi
    1df1:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1df8:	e8 00 00 00 00       	call   1dfd <exercise+0x1ccd>
    1dfd:	48 83 fb 02          	cmp    $0x2,%rbx
    1e01:	0f 82 a5 e4 ff ff    	jb     2ac <exercise+0x17c>
    1e07:	48 89 de             	mov    %rbx,%rsi
    1e0a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e11:	e8 00 00 00 00       	call   1e16 <exercise+0x1ce6>
    1e16:	e9 91 e4 ff ff       	jmp    2ac <exercise+0x17c>
    1e1b:	48 89 de             	mov    %rbx,%rsi
    1e1e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e25:	e8 00 00 00 00       	call   1e2a <exercise+0x1cfa>
    1e2a:	e9 30 e4 ff ff       	jmp    25f <exercise+0x12f>
    1e2f:	48 89 de             	mov    %rbx,%rsi
    1e32:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e39:	e8 00 00 00 00       	call   1e3e <exercise+0x1d0e>
    1e3e:	e9 0a e4 ff ff       	jmp    24d <exercise+0x11d>
    1e43:	48 89 de             	mov    %rbx,%rsi
    1e46:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e4d:	e8 00 00 00 00       	call   1e52 <exercise+0x1d22>
    1e52:	e9 d5 e3 ff ff       	jmp    22c <exercise+0xfc>
    1e57:	41 be f4 ff ff ff    	mov    $0xfffffff4,%r14d
    1e5d:	e9 30 f9 ff ff       	jmp    1792 <exercise+0x1662>
    1e62:	48 89 ee             	mov    %rbp,%rsi
    1e65:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e6c:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    1e71:	e8 00 00 00 00       	call   1e76 <exercise+0x1d46>
    1e76:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    1e7b:	e9 03 e7 ff ff       	jmp    583 <exercise+0x453>
    1e80:	48 89 ee             	mov    %rbp,%rsi
    1e83:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e8a:	e8 00 00 00 00       	call   1e8f <exercise+0x1d5f>
    1e8f:	e9 98 e6 ff ff       	jmp    52c <exercise+0x3fc>
    1e94:	48 89 ee             	mov    %rbp,%rsi
    1e97:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1e9e:	e8 00 00 00 00       	call   1ea3 <exercise+0x1d73>
    1ea3:	e9 2f e6 ff ff       	jmp    4d7 <exercise+0x3a7>
    1ea8:	48 89 ee             	mov    %rbp,%rsi
    1eab:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1eb2:	e8 00 00 00 00       	call   1eb7 <exercise+0x1d87>
    1eb7:	e9 11 e6 ff ff       	jmp    4cd <exercise+0x39d>
    1ebc:	48 89 de             	mov    %rbx,%rsi
    1ebf:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ec6:	e8 00 00 00 00       	call   1ecb <exercise+0x1d9b>
    1ecb:	e9 44 ec ff ff       	jmp    b14 <exercise+0x9e4>
    1ed0:	4c 89 ee             	mov    %r13,%rsi
    1ed3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1eda:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    1edf:	e8 00 00 00 00       	call   1ee4 <exercise+0x1db4>
    1ee4:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    1ee9:	e9 c5 ec ff ff       	jmp    bb3 <exercise+0xa83>
    1eee:	4c 89 f6             	mov    %r14,%rsi
    1ef1:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ef8:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    1efd:	e8 00 00 00 00       	call   1f02 <exercise+0x1dd2>
    1f02:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    1f07:	e9 9a ec ff ff       	jmp    ba6 <exercise+0xa76>
    1f0c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1f13:	e8 00 00 00 00       	call   1f18 <exercise+0x1de8>
    1f18:	e9 ca eb ff ff       	jmp    ae7 <exercise+0x9b7>
    1f1d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1f24:	e8 00 00 00 00       	call   1f29 <exercise+0x1df9>
    1f29:	e9 40 eb ff ff       	jmp    a6e <exercise+0x93e>
    1f2e:	4c 89 fe             	mov    %r15,%rsi
    1f31:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1f38:	e8 00 00 00 00       	call   1f3d <exercise+0x1e0d>
    1f3d:	e9 52 ee ff ff       	jmp    d94 <exercise+0xc64>
    1f42:	4c 89 fe             	mov    %r15,%rsi
    1f45:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1f4c:	e8 00 00 00 00       	call   1f51 <exercise+0x1e21>
    1f51:	e9 00 ee ff ff       	jmp    d56 <exercise+0xc26>
    1f56:	4c 89 fe             	mov    %r15,%rsi
    1f59:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1f60:	e8 00 00 00 00       	call   1f65 <exercise+0x1e35>
    1f65:	e9 de ed ff ff       	jmp    d48 <exercise+0xc18>
    1f6a:	4c 89 fe             	mov    %r15,%rsi
    1f6d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1f74:	e8 00 00 00 00       	call   1f79 <exercise+0x1e49>
    1f79:	49 83 ff 03          	cmp    $0x3,%r15
    1f7d:	0f 82 a3 ed ff ff    	jb     d26 <exercise+0xbf6>
    1f83:	4c 89 fe             	mov    %r15,%rsi
    1f86:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1f8d:	e8 00 00 00 00       	call   1f92 <exercise+0x1e62>
    1f92:	49 83 ff 03          	cmp    $0x3,%r15
    1f96:	0f 82 8a ed ff ff    	jb     d26 <exercise+0xbf6>
    1f9c:	4c 89 fe             	mov    %r15,%rsi
    1f9f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1fa6:	e8 00 00 00 00       	call   1fab <exercise+0x1e7b>
    1fab:	e9 76 ed ff ff       	jmp    d26 <exercise+0xbf6>
    1fb0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1fb7:	e8 00 00 00 00       	call   1fbc <exercise+0x1e8c>
    1fbc:	e9 90 eb ff ff       	jmp    b51 <exercise+0xa21>
    1fc1:	4c 89 fe             	mov    %r15,%rsi
    1fc4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1fcb:	e8 00 00 00 00       	call   1fd0 <exercise+0x1ea0>
    1fd0:	e9 e1 ec ff ff       	jmp    cb6 <exercise+0xb86>
    1fd5:	4c 89 fe             	mov    %r15,%rsi
    1fd8:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1fdf:	e8 00 00 00 00       	call   1fe4 <exercise+0x1eb4>
    1fe4:	e9 81 ec ff ff       	jmp    c6a <exercise+0xb3a>
    1fe9:	4c 89 fe             	mov    %r15,%rsi
    1fec:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ff3:	e8 00 00 00 00       	call   1ff8 <exercise+0x1ec8>
    1ff8:	e9 63 ec ff ff       	jmp    c60 <exercise+0xb30>
    1ffd:	4c 89 fe             	mov    %r15,%rsi
    2000:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    2007:	e8 00 00 00 00       	call   200c <exercise+0x1edc>
    200c:	49 83 ff 03          	cmp    $0x3,%r15
    2010:	0f 82 2e ec ff ff    	jb     c44 <exercise+0xb14>
    2016:	4c 89 fe             	mov    %r15,%rsi
    2019:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    2020:	e8 00 00 00 00       	call   2025 <exercise+0x1ef5>
    2025:	49 83 ff 03          	cmp    $0x3,%r15
    2029:	0f 82 15 ec ff ff    	jb     c44 <exercise+0xb14>
    202f:	4c 89 fe             	mov    %r15,%rsi
    2032:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    2039:	e8 00 00 00 00       	call   203e <exercise+0x1f0e>
    203e:	e9 01 ec ff ff       	jmp    c44 <exercise+0xb14>
    2043:	4c 89 fe             	mov    %r15,%rsi
    2046:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    204d:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    2052:	e8 00 00 00 00       	call   2057 <exercise+0x1f27>
    2057:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    205c:	e9 89 ec ff ff       	jmp    cea <exercise+0xbba>
    2061:	4d 89 e7             	mov    %r12,%r15
    2064:	e9 00 00 00 00       	jmp    2069 <encoders+0x16a9>

Disassembly of section .exit.text:

0000000000000000 <cleanup_module-0x10>:
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

0000000000000010 <cleanup_module>:
  10:	f3 0f 1e fa          	endbr64
  14:	e9 00 00 00 00       	jmp    19 <_entry_ptr.3+0x1>

Disassembly of section .init.text:

0000000000000000 <init_module-0x10>:
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

0000000000000010 <init_module>:
  10:	f3 0f 1e fa          	endbr64
  14:	e8 00 00 00 00       	call   19 <init_module+0x9>
  19:	41 57                	push   %r15
  1b:	b9 38 00 00 00       	mov    $0x38,%ecx
  20:	41 56                	push   %r14
  22:	41 55                	push   %r13
  24:	41 54                	push   %r12
  26:	55                   	push   %rbp
  27:	53                   	push   %rbx
  28:	48 81 ec 18 01 00 00 	sub    $0x118,%rsp
  2f:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax        # 37 <init_module+0x27>
  36:	00 
  37:	48 89 84 24 10 01 00 	mov    %rax,0x110(%rsp)
  3e:	00 
  3f:	31 c0                	xor    %eax,%eax
  41:	48 8d 6c 24 30       	lea    0x30(%rsp),%rbp
  46:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
  4b:	48 89 ef             	mov    %rbp,%rdi
  4e:	f3 ab                	rep stos %eax,(%rdi)
  50:	0f ba 25 00 00 00 00 	btl    $0x1f,0x0(%rip)        # 58 <init_module+0x48>
  57:	1f 
  58:	b9 08 00 00 00       	mov    $0x8,%ecx
  5d:	4c 89 ff             	mov    %r15,%rdi
  60:	f3 ab                	rep stos %eax,(%rdi)
  62:	0f 83 cb 01 00 00    	jae    233 <init_module+0x223>
  68:	48 89 eb             	mov    %rbp,%rbx
  6b:	45 31 ed             	xor    %r13d,%r13d
  6e:	45 89 ec             	mov    %r13d,%r12d
  71:	44 89 ee             	mov    %r13d,%esi
  74:	41 83 fd 03          	cmp    $0x3,%r13d
  78:	76 0c                	jbe    86 <init_module+0x76>
  7a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  81:	e8 00 00 00 00       	call   86 <init_module+0x76>
  86:	45 89 e6             	mov    %r12d,%r14d
  89:	b9 0e 00 00 00       	mov    $0xe,%ecx
  8e:	49 6b c6 38          	imul   $0x38,%r14,%rax
  92:	48 8d 7c 04 30       	lea    0x30(%rsp,%rax,1),%rdi
  97:	31 c0                	xor    %eax,%eax
  99:	f3 ab                	rep stos %eax,(%rdi)
  9b:	41 8d 44 24 64       	lea    0x64(%r12),%eax
  a0:	89 43 20             	mov    %eax,0x20(%rbx)
  a3:	49 83 fe 04          	cmp    $0x4,%r14
  a7:	72 0f                	jb     b8 <init_module+0xa8>
  a9:	4c 89 f6             	mov    %r14,%rsi
  ac:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  b3:	e8 00 00 00 00       	call   b8 <init_module+0xa8>
  b8:	31 d2                	xor    %edx,%edx
  ba:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  be:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
  c5:	89 13                	mov    %edx,(%rbx)
  c7:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
  ce:	e8 00 00 00 00       	call   d3 <init_module+0xc3>
  d3:	49 83 fe 05          	cmp    $0x5,%r14
  d7:	72 0f                	jb     e8 <init_module+0xd8>
  d9:	4c 89 f6             	mov    %r14,%rsi
  dc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  e3:	e8 00 00 00 00       	call   e8 <init_module+0xd8>
  e8:	45 89 e0             	mov    %r12d,%r8d
  eb:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx
  f2:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  f7:	48 89 de             	mov    %rbx,%rsi
  fa:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 101:	e8 00 00 00 00       	call   106 <init_module+0xf6>
 106:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
 10c:	0f 87 28 01 00 00    	ja     23a <init_module+0x22a>
 112:	48 89 c7             	mov    %rax,%rdi
 115:	48 89 04 24          	mov    %rax,(%rsp)
 119:	e8 00 00 00 00       	call   11e <init_module+0x10e>
 11e:	49 83 fe 04          	cmp    $0x4,%r14
 122:	48 8b 14 24          	mov    (%rsp),%rdx
 126:	72 13                	jb     13b <init_module+0x12b>
 128:	4c 89 f6             	mov    %r14,%rsi
 12b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 132:	e8 00 00 00 00       	call   137 <init_module+0x127>
 137:	48 8b 14 24          	mov    (%rsp),%rdx
 13b:	4b 89 14 ef          	mov    %rdx,(%r15,%r13,8)
 13f:	49 ff c5             	inc    %r13
 142:	48 83 c3 38          	add    $0x38,%rbx
 146:	49 83 fd 04          	cmp    $0x4,%r13
 14a:	0f 85 1e ff ff ff    	jne    6e <init_module+0x5e>
 150:	41 bc 04 00 00 00    	mov    $0x4,%r12d
 156:	31 db                	xor    %ebx,%ebx
 158:	31 c0                	xor    %eax,%eax
 15a:	45 31 ed             	xor    %r13d,%r13d
 15d:	48 89 04 24          	mov    %rax,(%rsp)
 161:	44 89 6c 24 0c       	mov    %r13d,0xc(%rsp)
 166:	44 89 ee             	mov    %r13d,%esi
 169:	41 83 fd 03          	cmp    $0x3,%r13d
 16d:	76 0c                	jbe    17b <init_module+0x16b>
 16f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 176:	e8 00 00 00 00       	call   17b <init_module+0x16b>
 17b:	48 89 ef             	mov    %rbp,%rdi
 17e:	e8 00 00 00 00       	call   183 <init_module+0x173>
 183:	44 8b 74 24 0c       	mov    0xc(%rsp),%r14d
 188:	83 7c 24 0c 03       	cmpl   $0x3,0xc(%rsp)
 18d:	76 0f                	jbe    19e <init_module+0x18e>
 18f:	4c 89 f6             	mov    %r14,%rsi
 192:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 199:	e8 00 00 00 00       	call   19e <init_module+0x18e>
 19e:	4b 8b 3c ef          	mov    (%r15,%r13,8),%rdi
 1a2:	e8 00 00 00 00       	call   1a7 <init_module+0x197>
 1a7:	49 83 fe 04          	cmp    $0x4,%r14
 1ab:	72 0f                	jb     1bc <init_module+0x1ac>
 1ad:	4c 89 f6             	mov    %r14,%rsi
 1b0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 1b7:	e8 00 00 00 00       	call   1bc <init_module+0x1ac>
 1bc:	8b 45 24             	mov    0x24(%rbp),%eax
 1bf:	85 c0                	test   %eax,%eax
 1c1:	74 1f                	je     1e2 <init_module+0x1d2>
 1c3:	49 83 fe 04          	cmp    $0x4,%r14
 1c7:	72 17                	jb     1e0 <init_module+0x1d0>
 1c9:	4c 89 f6             	mov    %r14,%rsi
 1cc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 1d3:	89 44 24 0c          	mov    %eax,0xc(%rsp)
 1d7:	e8 00 00 00 00       	call   1dc <init_module+0x1cc>
 1dc:	8b 44 24 0c          	mov    0xc(%rsp),%eax
 1e0:	89 c3                	mov    %eax,%ebx
 1e2:	49 83 fe 04          	cmp    $0x4,%r14
 1e6:	72 0f                	jb     1f7 <init_module+0x1e7>
 1e8:	4c 89 f6             	mov    %r14,%rsi
 1eb:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 1f2:	e8 00 00 00 00       	call   1f7 <init_module+0x1e7>
 1f7:	49 ff c5             	inc    %r13
 1fa:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
 1fe:	48 83 c5 38          	add    $0x38,%rbp
 202:	48 01 0c 24          	add    %rcx,(%rsp)
 206:	45 39 e5             	cmp    %r12d,%r13d
 209:	0f 82 52 ff ff ff    	jb     161 <init_module+0x151>
 20f:	85 db                	test   %ebx,%ebx
 211:	75 32                	jne    245 <init_module+0x235>
 213:	e8 00 00 00 00       	call   218 <init_module+0x208>
 218:	89 c3                	mov    %eax,%ebx
 21a:	85 c0                	test   %eax,%eax
 21c:	75 27                	jne    245 <init_module+0x235>
 21e:	48 8b 14 24          	mov    (%rsp),%rdx
 222:	44 89 e6             	mov    %r12d,%esi
 225:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 22c:	e8 00 00 00 00       	call   231 <init_module+0x221>
 231:	eb 12                	jmp    245 <init_module+0x235>
 233:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 238:	eb 0b                	jmp    245 <init_module+0x235>
 23a:	89 c3                	mov    %eax,%ebx
 23c:	45 85 e4             	test   %r12d,%r12d
 23f:	0f 85 13 ff ff ff    	jne    158 <init_module+0x148>
 245:	48 8b 84 24 10 01 00 	mov    0x110(%rsp),%rax
 24c:	00 
 24d:	65 48 2b 05 00 00 00 	sub    %gs:0x0(%rip),%rax        # 255 <init_module+0x245>
 254:	00 
 255:	74 05                	je     25c <init_module+0x24c>
 257:	e8 00 00 00 00       	call   25c <init_module+0x24c>
 25c:	48 81 c4 18 01 00 00 	add    $0x118,%rsp
 263:	89 d8                	mov    %ebx,%eax
 265:	5b                   	pop    %rbx
 266:	5d                   	pop    %rbp
 267:	41 5c                	pop    %r12
 269:	41 5d                	pop    %r13
 26b:	41 5e                	pop    %r14
 26d:	41 5f                	pop    %r15
 26f:	e9 00 00 00 00       	jmp    274 <_entry.71+0x14>

Disassembly of section .text.unlikely:

0000000000000000 <exercise.cold>:
   0:	41 8b 74 24 20       	mov    0x20(%r12),%esi
   5:	4d 89 e7             	mov    %r12,%r15
   8:	ba 80 00 00 00       	mov    $0x80,%edx
   d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  14:	e8 00 00 00 00       	call   19 <exercise.cold+0x19>
  19:	48 8b ac 24 30 01 00 	mov    0x130(%rsp),%rbp
  20:	00 
  21:	4c 8b a4 24 38 01 00 	mov    0x138(%rsp),%r12
  28:	00 
  29:	4c 8b ac 24 40 01 00 	mov    0x140(%rsp),%r13
  30:	00 
  31:	41 be ea ff ff ff    	mov    $0xffffffea,%r14d
  37:	e9 00 00 00 00       	jmp    3c <exercise.cold+0x3c>
  3c:	41 8b 74 24 20       	mov    0x20(%r12),%esi
  41:	4d 89 e7             	mov    %r12,%r15
  44:	ba 83 00 00 00       	mov    $0x83,%edx
  49:	eb c2                	jmp    d <exercise.cold+0xd>
  4b:	48 83 c0 02          	add    $0x2,%rax
  4f:	49 89 44 24 28       	mov    %rax,0x28(%r12)
  54:	49 83 ff 03          	cmp    $0x3,%r15
  58:	72 0f                	jb     69 <exercise.cold+0x69>
  5a:	4c 89 fe             	mov    %r15,%rsi
  5d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  64:	e8 00 00 00 00       	call   69 <exercise.cold+0x69>
  69:	48 89 ee             	mov    %rbp,%rsi
  6c:	4c 89 f7             	mov    %r14,%rdi
  6f:	e8 00 00 00 00       	call   74 <exercise.cold+0x74>
  74:	84 c0                	test   %al,%al
  76:	0f 84 ea 00 00 00    	je     166 <exercise.cold+0x166>
  7c:	49 39 dd             	cmp    %rbx,%r13
  7f:	0f 84 c4 03 00 00    	je     449 <exercise.cold+0x449>
  85:	48 83 c3 01          	add    $0x1,%rbx
  89:	48 39 5c 24 30       	cmp    %rbx,0x30(%rsp)
  8e:	0f 82 ee 03 00 00    	jb     482 <exercise.cold+0x482>
  94:	49 83 ff 03          	cmp    $0x3,%r15
  98:	72 39                	jb     d3 <exercise.cold+0xd3>
  9a:	4c 89 fe             	mov    %r15,%rsi
  9d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  a4:	e8 00 00 00 00       	call   a9 <exercise.cold+0xa9>
  a9:	49 83 ff 03          	cmp    $0x3,%r15
  ad:	72 24                	jb     d3 <exercise.cold+0xd3>
  af:	4c 89 fe             	mov    %r15,%rsi
  b2:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  b9:	e8 00 00 00 00       	call   be <exercise.cold+0xbe>
  be:	49 83 ff 03          	cmp    $0x3,%r15
  c2:	72 0f                	jb     d3 <exercise.cold+0xd3>
  c4:	4c 89 fe             	mov    %r15,%rsi
  c7:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  ce:	e8 00 00 00 00       	call   d3 <exercise.cold+0xd3>
  d3:	ba 48 10 00 00       	mov    $0x1048,%edx
  d8:	be a5 00 00 00       	mov    $0xa5,%esi
  dd:	4c 89 f7             	mov    %r14,%rdi
  e0:	e8 00 00 00 00       	call   e5 <exercise.cold+0xe5>
  e5:	49 83 ff 02          	cmp    $0x2,%r15
  e9:	72 0f                	jb     fa <exercise.cold+0xfa>
  eb:	4c 89 fe             	mov    %r15,%rsi
  ee:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  f5:	e8 00 00 00 00       	call   fa <exercise.cold+0xfa>
  fa:	49 83 ff 03          	cmp    $0x3,%r15
  fe:	72 0f                	jb     10f <exercise.cold+0x10f>
 100:	4c 89 fe             	mov    %r15,%rsi
 103:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 10a:	e8 00 00 00 00       	call   10f <exercise.cold+0x10f>
 10f:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
 114:	48 89 e9             	mov    %rbp,%rcx
 117:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 11c:	48 89 de             	mov    %rbx,%rsi
 11f:	48 8d bc 24 ee 00 00 	lea    0xee(%rsp),%rdi
 126:	00 
 127:	e8 00 00 00 00       	call   12c <exercise.cold+0x12c>
 12c:	49 39 dd             	cmp    %rbx,%r13
 12f:	ba ff ff ff ff       	mov    $0xffffffff,%edx
 134:	0f 44 54 24 28       	cmove  0x28(%rsp),%edx
 139:	89 c1                	mov    %eax,%ecx
 13b:	49 8b 44 24 28       	mov    0x28(%r12),%rax
 140:	39 d1                	cmp    %edx,%ecx
 142:	0f 84 03 ff ff ff    	je     4b <exercise.cold+0x4b>
 148:	48 83 c0 01          	add    $0x1,%rax
 14c:	41 8b 74 24 20       	mov    0x20(%r12),%esi
 151:	4d 89 e7             	mov    %r12,%r15
 154:	ba 7e 00 00 00       	mov    $0x7e,%edx
 159:	49 89 44 24 28       	mov    %rax,0x28(%r12)
 15e:	48 89 c1             	mov    %rax,%rcx
 161:	e9 a7 fe ff ff       	jmp    d <exercise.cold+0xd>
 166:	4d 89 e7             	mov    %r12,%r15
 169:	49 8b 4f 28          	mov    0x28(%r15),%rcx
 16d:	41 8b 77 20          	mov    0x20(%r15),%esi
 171:	ba 7f 00 00 00       	mov    $0x7f,%edx
 176:	e9 92 fe ff ff       	jmp    d <exercise.cold+0xd>
 17b:	4c 89 ea             	mov    %r13,%rdx
 17e:	be 90 61 00 00       	mov    $0x6190,%esi
 183:	bf 14 00 00 00       	mov    $0x14,%edi
 188:	e8 00 00 00 00       	call   18d <exercise.cold+0x18d>
 18d:	8b 75 20             	mov    0x20(%rbp),%esi
 190:	49 89 ef             	mov    %rbp,%r15
 193:	48 89 d9             	mov    %rbx,%rcx
 196:	ba 61 00 00 00       	mov    $0x61,%edx
 19b:	e9 6d fe ff ff       	jmp    d <exercise.cold+0xd>
 1a0:	41 8b 77 20          	mov    0x20(%r15),%esi
 1a4:	ba 3b 00 00 00       	mov    $0x3b,%edx
 1a9:	e9 5f fe ff ff       	jmp    d <exercise.cold+0xd>
 1ae:	41 8b 76 20          	mov    0x20(%r14),%esi
 1b2:	4d 89 f7             	mov    %r14,%r15
 1b5:	ba c2 00 00 00       	mov    $0xc2,%edx
 1ba:	e9 4e fe ff ff       	jmp    d <exercise.cold+0xd>
 1bf:	49 8b 4c 24 28       	mov    0x28(%r12),%rcx
 1c4:	41 8b 74 24 20       	mov    0x20(%r12),%esi
 1c9:	4d 89 e7             	mov    %r12,%r15
 1cc:	ba 84 00 00 00       	mov    $0x84,%edx
 1d1:	e9 37 fe ff ff       	jmp    d <exercise.cold+0xd>
 1d6:	48 89 d1             	mov    %rdx,%rcx
 1d9:	41 8b 74 24 20       	mov    0x20(%r12),%esi
 1de:	4d 89 e7             	mov    %r12,%r15
 1e1:	ba 8f 00 00 00       	mov    $0x8f,%edx
 1e6:	e9 22 fe ff ff       	jmp    d <exercise.cold+0xd>
 1eb:	49 8b 4c 24 28       	mov    0x28(%r12),%rcx
 1f0:	41 8b 74 24 20       	mov    0x20(%r12),%esi
 1f5:	4d 89 e7             	mov    %r12,%r15
 1f8:	ba 8d 00 00 00       	mov    $0x8d,%edx
 1fd:	e9 0b fe ff ff       	jmp    d <exercise.cold+0xd>
 202:	41 8b 76 20          	mov    0x20(%r14),%esi
 206:	4d 89 f7             	mov    %r14,%r15
 209:	48 89 c1             	mov    %rax,%rcx
 20c:	ba b8 00 00 00       	mov    $0xb8,%edx
 211:	e9 f7 fd ff ff       	jmp    d <exercise.cold+0xd>
 216:	49 8b 4e 28          	mov    0x28(%r14),%rcx
 21a:	41 8b 76 20          	mov    0x20(%r14),%esi
 21e:	4d 89 f7             	mov    %r14,%r15
 221:	ba c0 00 00 00       	mov    $0xc0,%edx
 226:	e9 e2 fd ff ff       	jmp    d <exercise.cold+0xd>
 22b:	41 8b 76 20          	mov    0x20(%r14),%esi
 22f:	4d 89 f7             	mov    %r14,%r15
 232:	ba b3 00 00 00       	mov    $0xb3,%edx
 237:	e9 d1 fd ff ff       	jmp    d <exercise.cold+0xd>
 23c:	41 8b 76 20          	mov    0x20(%r14),%esi
 240:	4d 89 f7             	mov    %r14,%r15
 243:	48 89 d9             	mov    %rbx,%rcx
 246:	ba b9 00 00 00       	mov    $0xb9,%edx
 24b:	e9 bd fd ff ff       	jmp    d <exercise.cold+0xd>
 250:	4c 89 ea             	mov    %r13,%rdx
 253:	be 48 51 00 00       	mov    $0x5148,%esi
 258:	bf 14 00 00 00       	mov    $0x14,%edi
 25d:	e8 00 00 00 00       	call   262 <exercise.cold+0x262>
 262:	49 8b 4f 28          	mov    0x28(%r15),%rcx
 266:	41 8b 77 20          	mov    0x20(%r15),%esi
 26a:	ba 3e 00 00 00       	mov    $0x3e,%edx
 26f:	e9 99 fd ff ff       	jmp    d <exercise.cold+0xd>
 274:	41 8b 77 20          	mov    0x20(%r15),%esi
 278:	ba 3d 00 00 00       	mov    $0x3d,%edx
 27d:	e9 8b fd ff ff       	jmp    d <exercise.cold+0xd>
 282:	41 8b 77 20          	mov    0x20(%r15),%esi
 286:	ba 3c 00 00 00       	mov    $0x3c,%edx
 28b:	e9 7d fd ff ff       	jmp    d <exercise.cold+0xd>
 290:	41 8b 77 20          	mov    0x20(%r15),%esi
 294:	ba 65 00 00 00       	mov    $0x65,%edx
 299:	e9 6f fd ff ff       	jmp    d <exercise.cold+0xd>
 29e:	49 8b 4f 28          	mov    0x28(%r15),%rcx
 2a2:	41 8b 77 20          	mov    0x20(%r15),%esi
 2a6:	ba 66 00 00 00       	mov    $0x66,%edx
 2ab:	e9 5d fd ff ff       	jmp    d <exercise.cold+0xd>
 2b0:	41 8b 77 20          	mov    0x20(%r15),%esi
 2b4:	ba 4c 00 00 00       	mov    $0x4c,%edx
 2b9:	e9 4f fd ff ff       	jmp    d <exercise.cold+0xd>
 2be:	41 8b 77 20          	mov    0x20(%r15),%esi
 2c2:	ba 3a 00 00 00       	mov    $0x3a,%edx
 2c7:	e9 41 fd ff ff       	jmp    d <exercise.cold+0xd>
 2cc:	49 8b 4f 28          	mov    0x28(%r15),%rcx
 2d0:	41 8b 77 20          	mov    0x20(%r15),%esi
 2d4:	ba 36 00 00 00       	mov    $0x36,%edx
 2d9:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 2e0:	e8 00 00 00 00       	call   2e5 <exercise.cold+0x2e5>
 2e5:	e9 47 fd ff ff       	jmp    31 <exercise.cold+0x31>
 2ea:	49 8b 4f 28          	mov    0x28(%r15),%rcx
 2ee:	41 8b 77 20          	mov    0x20(%r15),%esi
 2f2:	ba 35 00 00 00       	mov    $0x35,%edx
 2f7:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 2fe:	e8 00 00 00 00       	call   303 <exercise.cold+0x303>
 303:	e9 29 fd ff ff       	jmp    31 <exercise.cold+0x31>
 308:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
 30c:	8b 75 20             	mov    0x20(%rbp),%esi
 30f:	49 89 ef             	mov    %rbp,%r15
 312:	ba 60 00 00 00       	mov    $0x60,%edx
 317:	e9 f1 fc ff ff       	jmp    d <exercise.cold+0xd>
 31c:	49 8b 4f 28          	mov    0x28(%r15),%rcx
 320:	41 8b 77 20          	mov    0x20(%r15),%esi
 324:	ba 4d 00 00 00       	mov    $0x4d,%edx
 329:	e9 df fc ff ff       	jmp    d <exercise.cold+0xd>
 32e:	8b 75 20             	mov    0x20(%rbp),%esi
 331:	49 89 ef             	mov    %rbp,%r15
 334:	48 89 f9             	mov    %rdi,%rcx
 337:	ba 5f 00 00 00       	mov    $0x5f,%edx
 33c:	e9 cc fc ff ff       	jmp    d <exercise.cold+0xd>
 341:	41 8b 77 20          	mov    0x20(%r15),%esi
 345:	ba 4e 00 00 00       	mov    $0x4e,%edx
 34a:	e9 be fc ff ff       	jmp    d <exercise.cold+0xd>
 34f:	41 8b 76 20          	mov    0x20(%r14),%esi
 353:	4d 89 f7             	mov    %r14,%r15
 356:	ba ac 00 00 00       	mov    $0xac,%edx
 35b:	e9 ad fc ff ff       	jmp    d <exercise.cold+0xd>
 360:	41 8b 76 20          	mov    0x20(%r14),%esi
 364:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
 369:	4d 89 f7             	mov    %r14,%r15
 36c:	ba ab 00 00 00       	mov    $0xab,%edx
 371:	e9 97 fc ff ff       	jmp    d <exercise.cold+0xd>
 376:	41 8b 76 20          	mov    0x20(%r14),%esi
 37a:	4d 89 f7             	mov    %r14,%r15
 37d:	48 89 d9             	mov    %rbx,%rcx
 380:	ba c3 00 00 00       	mov    $0xc3,%edx
 385:	e9 83 fc ff ff       	jmp    d <exercise.cold+0xd>
 38a:	41 8b 74 24 20       	mov    0x20(%r12),%esi
 38f:	4d 89 e7             	mov    %r12,%r15
 392:	48 89 d9             	mov    %rbx,%rcx
 395:	ba 90 00 00 00       	mov    $0x90,%edx
 39a:	e9 6e fc ff ff       	jmp    d <exercise.cold+0xd>
 39f:	be b8 30 00 00       	mov    $0x30b8,%esi
 3a4:	bf 14 00 00 00       	mov    $0x14,%edi
 3a9:	e8 00 00 00 00       	call   3ae <exercise.cold+0x3ae>
 3ae:	be 00 41 00 00       	mov    $0x4100,%esi
 3b3:	bf 14 00 00 00       	mov    $0x14,%edi
 3b8:	e8 00 00 00 00       	call   3bd <exercise.cold+0x3bd>
 3bd:	be b8 30 00 00       	mov    $0x30b8,%esi
 3c2:	bf 14 00 00 00       	mov    $0x14,%edi
 3c7:	e8 00 00 00 00       	call   3cc <exercise.cold+0x3cc>
 3cc:	be 00 41 00 00       	mov    $0x4100,%esi
 3d1:	bf 14 00 00 00       	mov    $0x14,%edi
 3d6:	e8 00 00 00 00       	call   3db <exercise.cold+0x3db>
 3db:	41 8b 76 20          	mov    0x20(%r14),%esi
 3df:	4d 89 f7             	mov    %r14,%r15
 3e2:	ba ae 00 00 00       	mov    $0xae,%edx
 3e7:	e9 21 fc ff ff       	jmp    d <exercise.cold+0xd>
 3ec:	41 8b 76 20          	mov    0x20(%r14),%esi
 3f0:	4d 89 f7             	mov    %r14,%r15
 3f3:	ba ad 00 00 00       	mov    $0xad,%edx
 3f8:	e9 10 fc ff ff       	jmp    d <exercise.cold+0xd>
 3fd:	4c 89 f9             	mov    %r15,%rcx
 400:	41 8b 76 20          	mov    0x20(%r14),%esi
 404:	4d 89 f7             	mov    %r14,%r15
 407:	ba b4 00 00 00       	mov    $0xb4,%edx
 40c:	e9 fc fb ff ff       	jmp    d <exercise.cold+0xd>
 411:	41 8b 77 20          	mov    0x20(%r15),%esi
 415:	ba c6 00 00 00       	mov    $0xc6,%edx
 41a:	e9 ee fb ff ff       	jmp    d <exercise.cold+0xd>
 41f:	41 8b 76 20          	mov    0x20(%r14),%esi
 423:	4d 89 f7             	mov    %r14,%r15
 426:	4c 89 e1             	mov    %r12,%rcx
 429:	ba af 00 00 00       	mov    $0xaf,%edx
 42e:	e9 da fb ff ff       	jmp    d <exercise.cold+0xd>
 433:	41 8b 76 20          	mov    0x20(%r14),%esi
 437:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
 43c:	4d 89 f7             	mov    %r14,%r15
 43f:	ba b5 00 00 00       	mov    $0xb5,%edx
 444:	e9 c4 fb ff ff       	jmp    d <exercise.cold+0xd>
 449:	49 83 44 24 28 01    	addq   $0x1,0x28(%r12)
 44f:	49 89 ee             	mov    %rbp,%r14
 452:	49 83 ff 03          	cmp    $0x3,%r15
 456:	72 0f                	jb     467 <exercise.cold+0x467>
 458:	4c 89 fe             	mov    %r15,%rsi
 45b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 462:	e8 00 00 00 00       	call   467 <exercise.cold+0x467>
 467:	4c 89 f2             	mov    %r14,%rdx
 46a:	49 81 fe a0 71 00 00 	cmp    $0x71a0,%r14
 471:	77 14                	ja     487 <exercise.cold+0x487>
 473:	48 8b 74 24 48       	mov    0x48(%rsp),%rsi
 478:	bf 14 00 00 00       	mov    $0x14,%edi
 47d:	e8 00 00 00 00       	call   482 <exercise.cold+0x482>
 482:	e9 00 00 00 00       	jmp    487 <exercise.cold+0x487>
 487:	be a0 71 00 00       	mov    $0x71a0,%esi
 48c:	bf 14 00 00 00       	mov    $0x14,%edi
 491:	e8 00 00 00 00       	call   496 <_entry.63+0x36>
