
/home/dan/n100-zram/build/astra-simd-kernel-002/scalar/lz4_compress.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <n100_private_lz4_compress_destSize_generic-0x10>:
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

0000000000000010 <n100_private_lz4_compress_destSize_generic>:
      10:	e8 00 00 00 00       	call   15 <n100_private_lz4_compress_destSize_generic+0x5>
      15:	8b 01                	mov    (%rcx),%eax
      17:	45 85 c0             	test   %r8d,%r8d
      1a:	0f 8e 51 01 00 00    	jle    171 <n100_private_lz4_compress_destSize_generic+0x161>
      20:	3d 00 00 00 7e       	cmp    $0x7e000000,%eax
      25:	0f 87 46 01 00 00    	ja     171 <n100_private_lz4_compress_destSize_generic+0x161>
      2b:	41 57                	push   %r15
      2d:	49 89 fa             	mov    %rdi,%r10
      30:	49 89 d3             	mov    %rdx,%r11
      33:	44 89 c7             	mov    %r8d,%edi
      36:	41 56                	push   %r14
      38:	89 c2                	mov    %eax,%edx
      3a:	45 89 ce             	mov    %r9d,%r14d
      3d:	41 55                	push   %r13
      3f:	4c 8d 3c 16          	lea    (%rsi,%rdx,1),%r15
      43:	41 54                	push   %r12
      45:	49 89 cc             	mov    %rcx,%r12
      48:	55                   	push   %rbp
      49:	53                   	push   %rbx
      4a:	48 83 ec 48          	sub    $0x48,%rsp
      4e:	48 89 3c 24          	mov    %rdi,(%rsp)
      52:	41 83 f9 02          	cmp    $0x2,%r9d
      56:	0f 84 f6 03 00 00    	je     452 <n100_private_lz4_compress_destSize_generic+0x442>
      5c:	83 f8 0c             	cmp    $0xc,%eax
      5f:	0f 8e 7c 05 00 00    	jle    5e1 <n100_private_lz4_compress_destSize_generic+0x5d1>
      65:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
      6b:	48 8b 16             	mov    (%rsi),%rdx
      6e:	4d 8d 47 f4          	lea    -0xc(%r15),%r8
      72:	48 8d 5e 02          	lea    0x2(%rsi),%rbx
      76:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
      7d:	bc 1b cf 
      80:	48 0f af d0          	imul   %rax,%rdx
      84:	48 c1 ea 36          	shr    $0x36,%rdx
      88:	41 c7 04 92 00 00 00 	movl   $0x0,(%r10,%rdx,4)
      8f:	00 
      90:	49 39 d8             	cmp    %rbx,%r8
      93:	0f 83 df 00 00 00    	jae    178 <n100_private_lz4_compress_destSize_generic+0x168>
      99:	4c 89 df             	mov    %r11,%rdi
      9c:	49 89 f1             	mov    %rsi,%r9
      9f:	48 8d 5f 01          	lea    0x1(%rdi),%rbx
      a3:	4d 89 fd             	mov    %r15,%r13
      a6:	48 8b 0c 24          	mov    (%rsp),%rcx
      aa:	49 b8 81 80 80 80 80 	movabs $0x8080808080808081,%r8
      b1:	80 80 80 
      b4:	4d 29 cd             	sub    %r9,%r13
      b7:	49 8d 85 f0 00 00 00 	lea    0xf0(%r13),%rax
      be:	4c 01 d9             	add    %r11,%rcx
      c1:	49 f7 e0             	mul    %r8
      c4:	48 c1 ea 07          	shr    $0x7,%rdx
      c8:	49 8d 44 15 01       	lea    0x1(%r13,%rdx,1),%rax
      cd:	48 01 f8             	add    %rdi,%rax
      d0:	48 39 c1             	cmp    %rax,%rcx
      d3:	73 1c                	jae    f1 <n100_private_lz4_compress_destSize_generic+0xe1>
      d5:	48 29 f9             	sub    %rdi,%rcx
      d8:	48 8d 81 ef 00 00 00 	lea    0xef(%rcx),%rax
      df:	4c 8d 69 ff          	lea    -0x1(%rcx),%r13
      e3:	49 f7 e0             	mul    %r8
      e6:	48 c1 ea 07          	shr    $0x7,%rdx
      ea:	49 29 d5             	sub    %rdx,%r13
      ed:	4f 8d 3c 29          	lea    (%r9,%r13,1),%r15
      f1:	49 83 fd 0e          	cmp    $0xe,%r13
      f5:	0f 86 4a 03 00 00    	jbe    445 <n100_private_lz4_compress_destSize_generic+0x435>
      fb:	49 8d 45 f1          	lea    -0xf(%r13),%rax
      ff:	c6 07 f0             	movb   $0xf0,(%rdi)
     102:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     108:	76 2c                	jbe    136 <n100_private_lz4_compress_destSize_generic+0x126>
     10a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     111:	00 00 00 00 
     115:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     11c:	00 00 00 00 
     120:	48 2d ff 00 00 00    	sub    $0xff,%rax
     126:	48 83 c3 01          	add    $0x1,%rbx
     12a:	c6 43 ff ff          	movb   $0xff,-0x1(%rbx)
     12e:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     134:	77 ea                	ja     120 <n100_private_lz4_compress_destSize_generic+0x110>
     136:	88 03                	mov    %al,(%rbx)
     138:	48 83 c3 01          	add    $0x1,%rbx
     13c:	48 89 f5             	mov    %rsi,%rbp
     13f:	4c 89 ea             	mov    %r13,%rdx
     142:	48 89 df             	mov    %rbx,%rdi
     145:	4c 89 ce             	mov    %r9,%rsi
     148:	4d 89 de             	mov    %r11,%r14
     14b:	49 29 ef             	sub    %rbp,%r15
     14e:	e8 00 00 00 00       	call   153 <n100_private_lz4_compress_destSize_generic+0x143>
     153:	45 89 3c 24          	mov    %r15d,(%r12)
     157:	4a 8d 04 2b          	lea    (%rbx,%r13,1),%rax
     15b:	48 83 c4 48          	add    $0x48,%rsp
     15f:	44 29 f0             	sub    %r14d,%eax
     162:	5b                   	pop    %rbx
     163:	5d                   	pop    %rbp
     164:	41 5c                	pop    %r12
     166:	41 5d                	pop    %r13
     168:	41 5e                	pop    %r14
     16a:	41 5f                	pop    %r15
     16c:	e9 00 00 00 00       	jmp    171 <n100_private_lz4_compress_destSize_generic+0x161>
     171:	31 c0                	xor    %eax,%eax
     173:	e9 00 00 00 00       	jmp    178 <n100_private_lz4_compress_destSize_generic+0x168>
     178:	49 8d 7f fb          	lea    -0x5(%r15),%rdi
     17c:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
     180:	49 89 f1             	mov    %rsi,%r9
     183:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
     188:	48 8b 3c 24          	mov    (%rsp),%rdi
     18c:	48 0f af 46 01       	imul   0x1(%rsi),%rax
     191:	49 8d 54 3b f5       	lea    -0xb(%r11,%rdi,1),%rdx
     196:	49 8d 7c 3b fa       	lea    -0x6(%r11,%rdi,1),%rdi
     19b:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
     1a0:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
     1a5:	48 8d 7a ff          	lea    -0x1(%rdx),%rdi
     1a9:	48 c1 e8 36          	shr    $0x36,%rax
     1ad:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
     1b2:	4c 89 df             	mov    %r11,%rdi
     1b5:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
     1ba:	bd 41 00 00 00       	mov    $0x41,%ebp
     1bf:	41 bf 01 00 00 00    	mov    $0x1,%r15d
     1c5:	44 89 74 24 10       	mov    %r14d,0x10(%rsp)
     1ca:	eb 06                	jmp    1d2 <n100_private_lz4_compress_destSize_generic+0x1c2>
     1cc:	83 c5 01             	add    $0x1,%ebp
     1cf:	48 89 d3             	mov    %rdx,%rbx
     1d2:	89 c0                	mov    %eax,%eax
     1d4:	49 89 ce             	mov    %rcx,%r14
     1d7:	4d 8d 2c 82          	lea    (%r10,%rax,4),%r13
     1db:	49 29 f6             	sub    %rsi,%r14
     1de:	48 8b 03             	mov    (%rbx),%rax
     1e1:	41 8b 55 00          	mov    0x0(%r13),%edx
     1e5:	45 89 75 00          	mov    %r14d,0x0(%r13)
     1e9:	48 01 f2             	add    %rsi,%rdx
     1ec:	4c 8d aa ff ff 00 00 	lea    0xffff(%rdx),%r13
     1f3:	49 39 cd             	cmp    %rcx,%r13
     1f6:	72 08                	jb     200 <n100_private_lz4_compress_destSize_generic+0x1f0>
     1f8:	44 8b 32             	mov    (%rdx),%r14d
     1fb:	44 39 31             	cmp    %r14d,(%rcx)
     1fe:	74 31                	je     231 <n100_private_lz4_compress_destSize_generic+0x221>
     200:	48 b9 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rcx
     207:	bc 1b cf 
     20a:	44 89 fa             	mov    %r15d,%edx
     20d:	41 89 ef             	mov    %ebp,%r15d
     210:	48 0f af c1          	imul   %rcx,%rax
     214:	48 01 da             	add    %rbx,%rdx
     217:	41 c1 ef 06          	shr    $0x6,%r15d
     21b:	48 89 d9             	mov    %rbx,%rcx
     21e:	48 c1 e8 36          	shr    $0x36,%rax
     222:	49 39 d0             	cmp    %rdx,%r8
     225:	73 a5                	jae    1cc <n100_private_lz4_compress_destSize_generic+0x1bc>
     227:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
     22c:	e9 6e fe ff ff       	jmp    9f <n100_private_lz4_compress_destSize_generic+0x8f>
     231:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
     236:	44 8b 74 24 10       	mov    0x10(%rsp),%r14d
     23b:	48 39 d6             	cmp    %rdx,%rsi
     23e:	73 12                	jae    252 <n100_private_lz4_compress_destSize_generic+0x242>
     240:	49 39 c9             	cmp    %rcx,%r9
     243:	73 0d                	jae    252 <n100_private_lz4_compress_destSize_generic+0x242>
     245:	0f b6 42 ff          	movzbl -0x1(%rdx),%eax
     249:	38 41 ff             	cmp    %al,-0x1(%rcx)
     24c:	0f 84 32 04 00 00    	je     684 <n100_private_lz4_compress_destSize_generic+0x674>
     252:	48 89 c8             	mov    %rcx,%rax
     255:	48 8d 5f 01          	lea    0x1(%rdi),%rbx
     259:	4c 29 c8             	sub    %r9,%rax
     25c:	41 89 c5             	mov    %eax,%r13d
     25f:	8d a8 f0 00 00 00    	lea    0xf0(%rax),%ebp
     265:	4c 89 6c 24 08       	mov    %r13,0x8(%rsp)
     26a:	41 bd 81 80 80 80    	mov    $0x80808081,%r13d
     270:	49 0f af ed          	imul   %r13,%rbp
     274:	41 89 c5             	mov    %eax,%r13d
     277:	48 c1 ed 27          	shr    $0x27,%rbp
     27b:	4c 01 ed             	add    %r13,%rbp
     27e:	48 01 dd             	add    %rbx,%rbp
     281:	48 39 6c 24 20       	cmp    %rbp,0x20(%rsp)
     286:	0f 82 17 fe ff ff    	jb     a3 <n100_private_lz4_compress_destSize_generic+0x93>
     28c:	83 f8 0e             	cmp    $0xe,%eax
     28f:	0f 87 ab 03 00 00    	ja     640 <n100_private_lz4_compress_destSize_generic+0x630>
     295:	c1 e0 04             	shl    $0x4,%eax
     298:	88 07                	mov    %al,(%rdi)
     29a:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
     29f:	48 01 d8             	add    %rbx,%rax
     2a2:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     2a9:	00 
     2aa:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     2b1:	00 00 00 00 
     2b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     2bc:	00 00 00 00 
     2c0:	49 8b 29             	mov    (%r9),%rbp
     2c3:	48 83 c3 08          	add    $0x8,%rbx
     2c7:	49 83 c1 08          	add    $0x8,%r9
     2cb:	48 89 6b f8          	mov    %rbp,-0x8(%rbx)
     2cf:	48 39 c3             	cmp    %rax,%rbx
     2d2:	72 ec                	jb     2c0 <n100_private_lz4_compress_destSize_generic+0x2b0>
     2d4:	49 8d 5f f8          	lea    -0x8(%r15),%rbx
     2d8:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
     2dd:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
     2e2:	49 89 c1             	mov    %rax,%r9
     2e5:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
     2ea:	49 8d 5f fa          	lea    -0x6(%r15),%rbx
     2ee:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
     2f3:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
     2f8:	4c 89 5c 24 40       	mov    %r11,0x40(%rsp)
     2fd:	eb 77                	jmp    376 <n100_private_lz4_compress_destSize_generic+0x366>
     2ff:	44 01 d8             	add    %r11d,%eax
     302:	88 07                	mov    %al,(%rdi)
     304:	4c 89 cf             	mov    %r9,%rdi
     307:	49 39 c8             	cmp    %rcx,%r8
     30a:	0f 82 e0 02 00 00    	jb     5f0 <n100_private_lz4_compress_destSize_generic+0x5e0>
     310:	48 39 fd             	cmp    %rdi,%rbp
     313:	0f 82 d7 02 00 00    	jb     5f0 <n100_private_lz4_compress_destSize_generic+0x5e0>
     319:	49 89 c9             	mov    %rcx,%r9
     31c:	48 8d 41 fe          	lea    -0x2(%rcx),%rax
     320:	49 29 f1             	sub    %rsi,%r9
     323:	48 29 f0             	sub    %rsi,%rax
     326:	41 83 fe 01          	cmp    $0x1,%r14d
     32a:	0f 84 18 02 00 00    	je     548 <n100_private_lz4_compress_destSize_generic+0x538>
     330:	69 51 fe b1 79 37 9e 	imul   $0x9e3779b1,-0x2(%rcx),%edx
     337:	c1 ea 15             	shr    $0x15,%edx
     33a:	66 41 89 04 52       	mov    %ax,(%r10,%rdx,2)
     33f:	69 01 b1 79 37 9e    	imul   $0x9e3779b1,(%rcx),%eax
     345:	c1 e8 15             	shr    $0x15,%eax
     348:	41 0f b7 14 42       	movzwl (%r10,%rax,2),%edx
     34d:	66 45 89 0c 42       	mov    %r9w,(%r10,%rax,2)
     352:	48 01 f2             	add    %rsi,%rdx
     355:	48 8d 82 ff ff 00 00 	lea    0xffff(%rdx),%rax
     35c:	48 39 c8             	cmp    %rcx,%rax
     35f:	0f 82 a1 02 00 00    	jb     606 <n100_private_lz4_compress_destSize_generic+0x5f6>
     365:	8b 02                	mov    (%rdx),%eax
     367:	39 01                	cmp    %eax,(%rcx)
     369:	0f 85 97 02 00 00    	jne    606 <n100_private_lz4_compress_destSize_generic+0x5f6>
     36f:	c6 07 00             	movb   $0x0,(%rdi)
     372:	4c 8d 4f 01          	lea    0x1(%rdi),%r9
     376:	48 89 c8             	mov    %rcx,%rax
     379:	4c 8d 69 04          	lea    0x4(%rcx),%r13
     37d:	49 83 c1 02          	add    $0x2,%r9
     381:	48 29 d0             	sub    %rdx,%rax
     384:	48 83 c2 04          	add    $0x4,%rdx
     388:	66 41 89 41 fe       	mov    %ax,-0x2(%r9)
     38d:	4c 89 e8             	mov    %r13,%rax
     390:	4d 39 c5             	cmp    %r8,%r13
     393:	0f 83 f9 01 00 00    	jae    592 <n100_private_lz4_compress_destSize_generic+0x582>
     399:	4c 8b 1a             	mov    (%rdx),%r11
     39c:	4c 8b 38             	mov    (%rax),%r15
     39f:	4d 39 fb             	cmp    %r15,%r11
     3a2:	0f 84 d9 01 00 00    	je     581 <n100_private_lz4_compress_destSize_generic+0x571>
     3a8:	4d 31 fb             	xor    %r15,%r11
     3ab:	f3 4d 0f bc db       	tzcnt  %r11,%r11
     3b0:	49 c1 eb 03          	shr    $0x3,%r11
     3b4:	44 01 d8             	add    %r11d,%eax
     3b7:	44 29 e8             	sub    %r13d,%eax
     3ba:	41 89 c3             	mov    %eax,%r11d
     3bd:	49 89 dd             	mov    %rbx,%r13
     3c0:	48 b8 81 80 80 80 80 	movabs $0x8080808080808081,%rax
     3c7:	80 80 80 
     3ca:	49 8d 93 f0 00 00 00 	lea    0xf0(%r11),%rdx
     3d1:	4d 29 cd             	sub    %r9,%r13
     3d4:	48 f7 e2             	mul    %rdx
     3d7:	4c 89 e8             	mov    %r13,%rax
     3da:	48 c1 e0 08          	shl    $0x8,%rax
     3de:	4c 29 e8             	sub    %r13,%rax
     3e1:	48 c1 ea 07          	shr    $0x7,%rdx
     3e5:	48 83 c0 0e          	add    $0xe,%rax
     3e9:	4c 01 ca             	add    %r9,%rdx
     3ec:	48 39 d3             	cmp    %rdx,%rbx
     3ef:	4c 0f 42 d8          	cmovb  %rax,%r11
     3f3:	0f b6 07             	movzbl (%rdi),%eax
     3f6:	4a 8d 4c 19 04       	lea    0x4(%rcx,%r11,1),%rcx
     3fb:	49 83 fb 0e          	cmp    $0xe,%r11
     3ff:	0f 86 fa fe ff ff    	jbe    2ff <n100_private_lz4_compress_destSize_generic+0x2ef>
     405:	83 c0 0f             	add    $0xf,%eax
     408:	49 83 eb 0f          	sub    $0xf,%r11
     40c:	88 07                	mov    %al,(%rdi)
     40e:	49 81 fb fe 00 00 00 	cmp    $0xfe,%r11
     415:	76 22                	jbe    439 <n100_private_lz4_compress_destSize_generic+0x429>
     417:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     41e:	00 00 
     420:	49 81 eb ff 00 00 00 	sub    $0xff,%r11
     427:	49 83 c1 01          	add    $0x1,%r9
     42b:	41 c6 41 ff ff       	movb   $0xff,-0x1(%r9)
     430:	49 81 fb fe 00 00 00 	cmp    $0xfe,%r11
     437:	77 e7                	ja     420 <n100_private_lz4_compress_destSize_generic+0x410>
     439:	45 88 19             	mov    %r11b,(%r9)
     43c:	49 8d 79 01          	lea    0x1(%r9),%rdi
     440:	e9 c2 fe ff ff       	jmp    307 <n100_private_lz4_compress_destSize_generic+0x2f7>
     445:	44 89 e8             	mov    %r13d,%eax
     448:	c1 e0 04             	shl    $0x4,%eax
     44b:	88 07                	mov    %al,(%rdi)
     44d:	e9 ea fc ff ff       	jmp    13c <n100_private_lz4_compress_destSize_generic+0x12c>
     452:	3d 0a 00 01 00       	cmp    $0x1000a,%eax
     457:	0f 8f d6 00 00 00    	jg     533 <n100_private_lz4_compress_destSize_generic+0x523>
     45d:	83 f8 0c             	cmp    $0xc,%eax
     460:	0f 8e 7b 01 00 00    	jle    5e1 <n100_private_lz4_compress_destSize_generic+0x5d1>
     466:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
     46c:	49 8d 7f fb          	lea    -0x5(%r15),%rdi
     470:	31 d2                	xor    %edx,%edx
     472:	4d 8d 47 f4          	lea    -0xc(%r15),%r8
     476:	69 06 b1 79 37 9e    	imul   $0x9e3779b1,(%rsi),%eax
     47c:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
     481:	48 8d 6e 02          	lea    0x2(%rsi),%rbp
     485:	48 8b 3c 24          	mov    (%rsp),%rdi
     489:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
     48d:	c1 e8 15             	shr    $0x15,%eax
     490:	49 8d 5c 3b f5       	lea    -0xb(%r11,%rdi,1),%rbx
     495:	49 8d 7c 3b fa       	lea    -0x6(%r11,%rdi,1),%rdi
     49a:	66 41 89 14 42       	mov    %dx,(%r10,%rax,2)
     49f:	69 46 01 b1 79 37 9e 	imul   $0x9e3779b1,0x1(%rsi),%eax
     4a6:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
     4ab:	48 8d 7b ff          	lea    -0x1(%rbx),%rdi
     4af:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
     4b4:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
     4b9:	c1 e8 15             	shr    $0x15,%eax
     4bc:	49 39 e8             	cmp    %rbp,%r8
     4bf:	0f 82 d4 fb ff ff    	jb     99 <n100_private_lz4_compress_destSize_generic+0x89>
     4c5:	4c 89 df             	mov    %r11,%rdi
     4c8:	49 89 f1             	mov    %rsi,%r9
     4cb:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
     4d0:	bb 01 00 00 00       	mov    $0x1,%ebx
     4d5:	41 bd 41 00 00 00    	mov    $0x41,%r13d
     4db:	44 89 74 24 10       	mov    %r14d,0x10(%rsp)
     4e0:	eb 07                	jmp    4e9 <n100_private_lz4_compress_destSize_generic+0x4d9>
     4e2:	41 83 c5 01          	add    $0x1,%r13d
     4e6:	48 89 d5             	mov    %rdx,%rbp
     4e9:	4d 8d 34 42          	lea    (%r10,%rax,2),%r14
     4ed:	49 89 cf             	mov    %rcx,%r15
     4f0:	8b 45 00             	mov    0x0(%rbp),%eax
     4f3:	41 0f b7 16          	movzwl (%r14),%edx
     4f7:	49 29 f7             	sub    %rsi,%r15
     4fa:	66 45 89 3e          	mov    %r15w,(%r14)
     4fe:	48 01 f2             	add    %rsi,%rdx
     501:	44 8b 32             	mov    (%rdx),%r14d
     504:	44 39 31             	cmp    %r14d,(%rcx)
     507:	0f 84 24 fd ff ff    	je     231 <n100_private_lz4_compress_destSize_generic+0x221>
     50d:	69 c0 b1 79 37 9e    	imul   $0x9e3779b1,%eax,%eax
     513:	89 da                	mov    %ebx,%edx
     515:	44 89 eb             	mov    %r13d,%ebx
     518:	48 89 e9             	mov    %rbp,%rcx
     51b:	48 01 ea             	add    %rbp,%rdx
     51e:	c1 eb 06             	shr    $0x6,%ebx
     521:	c1 e8 15             	shr    $0x15,%eax
     524:	49 39 d0             	cmp    %rdx,%r8
     527:	73 b9                	jae    4e2 <n100_private_lz4_compress_destSize_generic+0x4d2>
     529:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
     52e:	e9 6c fb ff ff       	jmp    9f <n100_private_lz4_compress_destSize_generic+0x8f>
     533:	48 83 c4 48          	add    $0x48,%rsp
     537:	31 c0                	xor    %eax,%eax
     539:	5b                   	pop    %rbx
     53a:	5d                   	pop    %rbp
     53b:	41 5c                	pop    %r12
     53d:	41 5d                	pop    %r13
     53f:	41 5e                	pop    %r14
     541:	41 5f                	pop    %r15
     543:	e9 00 00 00 00       	jmp    548 <n100_private_lz4_compress_destSize_generic+0x538>
     548:	48 ba 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rdx
     54f:	bc 1b cf 
     552:	48 0f af 51 fe       	imul   -0x2(%rcx),%rdx
     557:	48 c1 ea 36          	shr    $0x36,%rdx
     55b:	41 89 04 92          	mov    %eax,(%r10,%rdx,4)
     55f:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
     566:	bc 1b cf 
     569:	48 0f af 01          	imul   (%rcx),%rax
     56d:	48 c1 e8 36          	shr    $0x36,%rax
     571:	41 8b 14 82          	mov    (%r10,%rax,4),%edx
     575:	45 89 0c 82          	mov    %r9d,(%r10,%rax,4)
     579:	48 01 f2             	add    %rsi,%rdx
     57c:	e9 d4 fd ff ff       	jmp    355 <n100_private_lz4_compress_destSize_generic+0x345>
     581:	48 83 c0 08          	add    $0x8,%rax
     585:	48 83 c2 08          	add    $0x8,%rdx
     589:	4c 39 c0             	cmp    %r8,%rax
     58c:	0f 82 07 fe ff ff    	jb     399 <n100_private_lz4_compress_destSize_generic+0x389>
     592:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
     597:	73 10                	jae    5a9 <n100_private_lz4_compress_destSize_generic+0x599>
     599:	44 8b 38             	mov    (%rax),%r15d
     59c:	44 39 3a             	cmp    %r15d,(%rdx)
     59f:	75 08                	jne    5a9 <n100_private_lz4_compress_destSize_generic+0x599>
     5a1:	48 83 c0 04          	add    $0x4,%rax
     5a5:	48 83 c2 04          	add    $0x4,%rdx
     5a9:	48 3b 44 24 10       	cmp    0x10(%rsp),%rax
     5ae:	73 12                	jae    5c2 <n100_private_lz4_compress_destSize_generic+0x5b2>
     5b0:	44 0f b7 38          	movzwl (%rax),%r15d
     5b4:	66 44 39 3a          	cmp    %r15w,(%rdx)
     5b8:	75 08                	jne    5c2 <n100_private_lz4_compress_destSize_generic+0x5b2>
     5ba:	48 83 c0 02          	add    $0x2,%rax
     5be:	48 83 c2 02          	add    $0x2,%rdx
     5c2:	48 3b 44 24 18       	cmp    0x18(%rsp),%rax
     5c7:	73 10                	jae    5d9 <n100_private_lz4_compress_destSize_generic+0x5c9>
     5c9:	44 0f b6 38          	movzbl (%rax),%r15d
     5cd:	44 38 3a             	cmp    %r15b,(%rdx)
     5d0:	0f 94 c2             	sete   %dl
     5d3:	0f b6 d2             	movzbl %dl,%edx
     5d6:	48 01 d0             	add    %rdx,%rax
     5d9:	44 29 e8             	sub    %r13d,%eax
     5dc:	e9 d9 fd ff ff       	jmp    3ba <n100_private_lz4_compress_destSize_generic+0x3aa>
     5e1:	49 8d 5b 01          	lea    0x1(%r11),%rbx
     5e5:	4c 89 df             	mov    %r11,%rdi
     5e8:	49 89 f1             	mov    %rsi,%r9
     5eb:	e9 b3 fa ff ff       	jmp    a3 <n100_private_lz4_compress_destSize_generic+0x93>
     5f0:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
     5f5:	4c 8b 5c 24 40       	mov    0x40(%rsp),%r11
     5fa:	48 8d 5f 01          	lea    0x1(%rdi),%rbx
     5fe:	49 89 c9             	mov    %rcx,%r9
     601:	e9 9d fa ff ff       	jmp    a3 <n100_private_lz4_compress_destSize_generic+0x93>
     606:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
     60b:	4c 8b 5c 24 40       	mov    0x40(%rsp),%r11
     610:	48 8d 51 01          	lea    0x1(%rcx),%rdx
     614:	41 83 fe 01          	cmp    $0x1,%r14d
     618:	0f 84 85 00 00 00    	je     6a3 <n100_private_lz4_compress_destSize_generic+0x693>
     61e:	48 8d 69 02          	lea    0x2(%rcx),%rbp
     622:	49 39 e8             	cmp    %rbp,%r8
     625:	0f 82 9f 00 00 00    	jb     6ca <n100_private_lz4_compress_destSize_generic+0x6ba>
     62b:	69 41 01 b1 79 37 9e 	imul   $0x9e3779b1,0x1(%rcx),%eax
     632:	49 89 c9             	mov    %rcx,%r9
     635:	48 89 d1             	mov    %rdx,%rcx
     638:	c1 e8 15             	shr    $0x15,%eax
     63b:	e9 8b fe ff ff       	jmp    4cb <n100_private_lz4_compress_destSize_generic+0x4bb>
     640:	83 e8 0f             	sub    $0xf,%eax
     643:	c6 07 f0             	movb   $0xf0,(%rdi)
     646:	3d fe 00 00 00       	cmp    $0xfe,%eax
     64b:	76 2c                	jbe    679 <n100_private_lz4_compress_destSize_generic+0x669>
     64d:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     654:	00 
     655:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     65c:	00 00 00 00 
     660:	2d ff 00 00 00       	sub    $0xff,%eax
     665:	48 83 c3 01          	add    $0x1,%rbx
     669:	c6 43 ff ff          	movb   $0xff,-0x1(%rbx)
     66d:	3d fe 00 00 00       	cmp    $0xfe,%eax
     672:	77 ec                	ja     660 <n100_private_lz4_compress_destSize_generic+0x650>
     674:	4c 89 6c 24 08       	mov    %r13,0x8(%rsp)
     679:	88 03                	mov    %al,(%rbx)
     67b:	48 83 c3 01          	add    $0x1,%rbx
     67f:	e9 16 fc ff ff       	jmp    29a <n100_private_lz4_compress_destSize_generic+0x28a>
     684:	48 83 e9 01          	sub    $0x1,%rcx
     688:	48 83 ea 01          	sub    $0x1,%rdx
     68c:	49 39 c9             	cmp    %rcx,%r9
     68f:	0f 83 bd fb ff ff    	jae    252 <n100_private_lz4_compress_destSize_generic+0x242>
     695:	48 39 d6             	cmp    %rdx,%rsi
     698:	0f 82 a7 fb ff ff    	jb     245 <n100_private_lz4_compress_destSize_generic+0x235>
     69e:	e9 af fb ff ff       	jmp    252 <n100_private_lz4_compress_destSize_generic+0x242>
     6a3:	48 8d 59 02          	lea    0x2(%rcx),%rbx
     6a7:	49 39 d8             	cmp    %rbx,%r8
     6aa:	72 1e                	jb     6ca <n100_private_lz4_compress_destSize_generic+0x6ba>
     6ac:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
     6b3:	bc 1b cf 
     6b6:	48 0f af 41 01       	imul   0x1(%rcx),%rax
     6bb:	49 89 c9             	mov    %rcx,%r9
     6be:	48 89 d1             	mov    %rdx,%rcx
     6c1:	48 c1 e8 36          	shr    $0x36,%rax
     6c5:	e9 eb fa ff ff       	jmp    1b5 <n100_private_lz4_compress_destSize_generic+0x1a5>
     6ca:	49 89 c9             	mov    %rcx,%r9
     6cd:	e9 cd f9 ff ff       	jmp    9f <n100_private_lz4_compress_destSize_generic+0x8f>
     6d2:	0f 1f 00             	nopl   (%rax)
     6d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     6dc:	00 00 00 00 
     6e0:	90                   	nop
     6e1:	90                   	nop
     6e2:	90                   	nop
     6e3:	90                   	nop
     6e4:	90                   	nop
     6e5:	90                   	nop
     6e6:	90                   	nop
     6e7:	90                   	nop
     6e8:	90                   	nop
     6e9:	90                   	nop
     6ea:	90                   	nop
     6eb:	90                   	nop
     6ec:	90                   	nop
     6ed:	90                   	nop
     6ee:	90                   	nop
     6ef:	90                   	nop

00000000000006f0 <n100_private_lz4_compress_fast_extState>:
     6f0:	e8 00 00 00 00       	call   6f5 <n100_private_lz4_compress_fast_extState+0x5>
     6f5:	48 83 ec 60          	sub    $0x60,%rsp
     6f9:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
     6fe:	48 89 f3             	mov    %rsi,%rbx
     701:	31 f6                	xor    %esi,%esi
     703:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
     708:	49 89 d4             	mov    %rdx,%r12
     70b:	ba 20 10 00 00       	mov    $0x1020,%edx
     710:	4c 89 74 24 50       	mov    %r14,0x50(%rsp)
     715:	41 89 ce             	mov    %ecx,%r14d
     718:	48 89 6c 24 38       	mov    %rbp,0x38(%rsp)
     71d:	44 89 c5             	mov    %r8d,%ebp
     720:	4c 89 6c 24 48       	mov    %r13,0x48(%rsp)
     725:	45 89 cd             	mov    %r9d,%r13d
     728:	e8 00 00 00 00       	call   72d <n100_private_lz4_compress_fast_extState+0x3d>
     72d:	41 81 fe 00 00 00 7e 	cmp    $0x7e000000,%r14d
     734:	0f 87 82 01 00 00    	ja     8bc <n100_private_lz4_compress_fast_extState+0x1cc>
     73a:	45 85 ed             	test   %r13d,%r13d
     73d:	48 89 c7             	mov    %rax,%rdi
     740:	b8 01 00 00 00       	mov    $0x1,%eax
     745:	ba 81 80 80 80       	mov    $0x80808081,%edx
     74a:	41 0f 4f c5          	cmovg  %r13d,%eax
     74e:	4c 89 7c 24 58       	mov    %r15,0x58(%rsp)
     753:	89 44 24 04          	mov    %eax,0x4(%rsp)
     757:	44 89 f0             	mov    %r14d,%eax
     75a:	4c 8d 3c 03          	lea    (%rbx,%rax,1),%r15
     75e:	48 0f af c2          	imul   %rdx,%rax
     762:	49 8d 77 fb          	lea    -0x5(%r15),%rsi
     766:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
     76b:	4d 8d 6f f4          	lea    -0xc(%r15),%r13
     76f:	48 c1 e8 27          	shr    $0x27,%rax
     773:	42 8d 44 30 10       	lea    0x10(%rax,%r14,1),%eax
     778:	39 e8                	cmp    %ebp,%eax
     77a:	0f 8f 60 01 00 00    	jg     8e0 <n100_private_lz4_compress_fast_extState+0x1f0>
     780:	41 81 fe 0a 00 01 00 	cmp    $0x1000a,%r14d
     787:	0f 8e 74 02 00 00    	jle    a01 <n100_private_lz4_compress_fast_extState+0x311>
     78d:	48 8b 03             	mov    (%rbx),%rax
     790:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
     795:	48 8d 53 01          	lea    0x1(%rbx),%rdx
     799:	4d 89 e1             	mov    %r12,%r9
     79c:	49 be 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r14
     7a3:	bc 1b cf 
     7a6:	49 89 db             	mov    %rbx,%r11
     7a9:	49 0f af c6          	imul   %r14,%rax
     7ad:	48 c1 e8 36          	shr    $0x36,%rax
     7b1:	c7 04 87 00 00 00 00 	movl   $0x0,(%rdi,%rax,4)
     7b8:	8b 44 24 04          	mov    0x4(%rsp),%eax
     7bc:	48 8b 4b 01          	mov    0x1(%rbx),%rcx
     7c0:	c1 e0 06             	shl    $0x6,%eax
     7c3:	49 0f af ce          	imul   %r14,%rcx
     7c7:	89 44 24 10          	mov    %eax,0x10(%rsp)
     7cb:	48 c1 e9 36          	shr    $0x36,%rcx
     7cf:	4c 8d 42 01          	lea    0x1(%rdx),%r8
     7d3:	4d 39 c5             	cmp    %r8,%r13
     7d6:	72 63                	jb     83b <n100_private_lz4_compress_fast_extState+0x14b>
     7d8:	8b 74 24 04          	mov    0x4(%rsp),%esi
     7dc:	8b 44 24 10          	mov    0x10(%rsp),%eax
     7e0:	81 e6 ff ff ff 03    	and    $0x3ffffff,%esi
     7e6:	8d 68 01             	lea    0x1(%rax),%ebp
     7e9:	eb 06                	jmp    7f1 <n100_private_lz4_compress_fast_extState+0x101>
     7eb:	83 c5 01             	add    $0x1,%ebp
     7ee:	49 89 c0             	mov    %rax,%r8
     7f1:	89 c9                	mov    %ecx,%ecx
     7f3:	49 89 d4             	mov    %rdx,%r12
     7f6:	4c 8d 14 8f          	lea    (%rdi,%rcx,4),%r10
     7fa:	49 29 dc             	sub    %rbx,%r12
     7fd:	49 8b 08             	mov    (%r8),%rcx
     800:	41 8b 02             	mov    (%r10),%eax
     803:	45 89 22             	mov    %r12d,(%r10)
     806:	48 01 d8             	add    %rbx,%rax
     809:	4c 8d 90 ff ff 00 00 	lea    0xffff(%rax),%r10
     810:	49 39 d2             	cmp    %rdx,%r10
     813:	72 0c                	jb     821 <n100_private_lz4_compress_fast_extState+0x131>
     815:	44 8b 12             	mov    (%rdx),%r10d
     818:	44 39 10             	cmp    %r10d,(%rax)
     81b:	0f 84 47 08 00 00    	je     1068 <n100_private_lz4_compress_fast_extState+0x978>
     821:	49 0f af ce          	imul   %r14,%rcx
     825:	89 f0                	mov    %esi,%eax
     827:	89 ee                	mov    %ebp,%esi
     829:	4c 89 c2             	mov    %r8,%rdx
     82c:	4c 01 c0             	add    %r8,%rax
     82f:	c1 ee 06             	shr    $0x6,%esi
     832:	48 c1 e9 36          	shr    $0x36,%rcx
     836:	49 39 c5             	cmp    %rax,%r13
     839:	73 b0                	jae    7eb <n100_private_lz4_compress_fast_extState+0xfb>
     83b:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
     840:	4d 29 df             	sub    %r11,%r15
     843:	49 8d 49 01          	lea    0x1(%r9),%rcx
     847:	49 83 ff 0e          	cmp    $0xe,%r15
     84b:	0f 86 ea 03 00 00    	jbe    c3b <n100_private_lz4_compress_fast_extState+0x54b>
     851:	49 8d 47 f1          	lea    -0xf(%r15),%rax
     855:	41 c6 01 f0          	movb   $0xf0,(%r9)
     859:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     85f:	76 35                	jbe    896 <n100_private_lz4_compress_fast_extState+0x1a6>
     861:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     868:	00 00 
     86a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     871:	00 00 00 00 
     875:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     87c:	00 00 00 00 
     880:	48 2d ff 00 00 00    	sub    $0xff,%rax
     886:	48 83 c1 01          	add    $0x1,%rcx
     88a:	c6 41 ff ff          	movb   $0xff,-0x1(%rcx)
     88e:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     894:	77 ea                	ja     880 <n100_private_lz4_compress_fast_extState+0x190>
     896:	88 01                	mov    %al,(%rcx)
     898:	48 83 c1 01          	add    $0x1,%rcx
     89c:	4c 89 fa             	mov    %r15,%rdx
     89f:	4c 89 de             	mov    %r11,%rsi
     8a2:	48 89 cf             	mov    %rcx,%rdi
     8a5:	e8 00 00 00 00       	call   8aa <n100_private_lz4_compress_fast_extState+0x1ba>
     8aa:	4c 01 f8             	add    %r15,%rax
     8ad:	4c 8b 7c 24 58       	mov    0x58(%rsp),%r15
     8b2:	44 29 e0             	sub    %r12d,%eax
     8b5:	eb 07                	jmp    8be <n100_private_lz4_compress_fast_extState+0x1ce>
     8b7:	4c 8b 7c 24 58       	mov    0x58(%rsp),%r15
     8bc:	31 c0                	xor    %eax,%eax
     8be:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
     8c3:	48 8b 6c 24 38       	mov    0x38(%rsp),%rbp
     8c8:	4c 8b 64 24 40       	mov    0x40(%rsp),%r12
     8cd:	4c 8b 6c 24 48       	mov    0x48(%rsp),%r13
     8d2:	4c 8b 74 24 50       	mov    0x50(%rsp),%r14
     8d7:	48 83 c4 60          	add    $0x60,%rsp
     8db:	e9 00 00 00 00       	jmp    8e0 <n100_private_lz4_compress_fast_extState+0x1f0>
     8e0:	41 81 fe 0a 00 01 00 	cmp    $0x1000a,%r14d
     8e7:	0f 8f ee 01 00 00    	jg     adb <n100_private_lz4_compress_fast_extState+0x3eb>
     8ed:	41 83 fe 0c          	cmp    $0xc,%r14d
     8f1:	0f 8e 5d 03 00 00    	jle    c54 <n100_private_lz4_compress_fast_extState+0x564>
     8f7:	48 63 c5             	movslq %ebp,%rax
     8fa:	31 d2                	xor    %edx,%edx
     8fc:	4d 89 e2             	mov    %r12,%r10
     8ff:	49 89 db             	mov    %rbx,%r11
     902:	4d 8d 34 04          	lea    (%r12,%rax,1),%r14
     906:	41 89 e9             	mov    %ebp,%r9d
     909:	69 03 b1 79 37 9e    	imul   $0x9e3779b1,(%rbx),%eax
     90f:	c1 e8 15             	shr    $0x15,%eax
     912:	66 89 14 47          	mov    %dx,(%rdi,%rax,2)
     916:	44 69 43 01 b1 79 37 	imul   $0x9e3779b1,0x1(%rbx),%r8d
     91d:	9e 
     91e:	48 8d 43 01          	lea    0x1(%rbx),%rax
     922:	41 c1 e8 15          	shr    $0x15,%r8d
     926:	8b 74 24 04          	mov    0x4(%rsp),%esi
     92a:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
     92f:	bd 01 00 00 00       	mov    $0x1,%ebp
     934:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
     939:	c1 e6 06             	shl    $0x6,%esi
     93c:	eb 36                	jmp    974 <n100_private_lz4_compress_fast_extState+0x284>
     93e:	66 90                	xchg   %ax,%ax
     940:	4e 8d 14 47          	lea    (%rdi,%r8,2),%r10
     944:	49 89 ce             	mov    %rcx,%r14
     947:	89 f5                	mov    %esi,%ebp
     949:	44 69 00 b1 79 37 9e 	imul   $0x9e3779b1,(%rax),%r8d
     950:	41 0f b7 12          	movzwl (%r10),%edx
     954:	49 29 de             	sub    %rbx,%r14
     957:	c1 ed 06             	shr    $0x6,%ebp
     95a:	66 45 89 32          	mov    %r14w,(%r10)
     95e:	44 8b 31             	mov    (%rcx),%r14d
     961:	48 01 da             	add    %rbx,%rdx
     964:	41 c1 e8 15          	shr    $0x15,%r8d
     968:	44 39 32             	cmp    %r14d,(%rdx)
     96b:	0f 84 ed 04 00 00    	je     e5e <n100_private_lz4_compress_fast_extState+0x76e>
     971:	83 c6 01             	add    $0x1,%esi
     974:	48 89 c1             	mov    %rax,%rcx
     977:	48 8d 04 28          	lea    (%rax,%rbp,1),%rax
     97b:	49 39 c5             	cmp    %rax,%r13
     97e:	73 c0                	jae    940 <n100_private_lz4_compress_fast_extState+0x250>
     980:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
     985:	44 89 cd             	mov    %r9d,%ebp
     988:	4c 89 db             	mov    %r11,%rbx
     98b:	4c 89 d6             	mov    %r10,%rsi
     98e:	4c 29 e6             	sub    %r12,%rsi
     991:	48 b9 81 80 80 80 80 	movabs $0x8080808080808081,%rcx
     998:	80 80 80 
     99b:	49 29 df             	sub    %rbx,%r15
     99e:	89 ed                	mov    %ebp,%ebp
     9a0:	49 8d 87 f0 00 00 00 	lea    0xf0(%r15),%rax
     9a7:	48 f7 e1             	mul    %rcx
     9aa:	49 8d 44 37 01       	lea    0x1(%r15,%rsi,1),%rax
     9af:	48 c1 ea 07          	shr    $0x7,%rdx
     9b3:	48 01 c2             	add    %rax,%rdx
     9b6:	48 39 d5             	cmp    %rdx,%rbp
     9b9:	0f 82 f8 fe ff ff    	jb     8b7 <n100_private_lz4_compress_fast_extState+0x1c7>
     9bf:	49 8d 4a 01          	lea    0x1(%r10),%rcx
     9c3:	49 83 ff 0e          	cmp    $0xe,%r15
     9c7:	0f 86 91 02 00 00    	jbe    c5e <n100_private_lz4_compress_fast_extState+0x56e>
     9cd:	49 8d 47 f1          	lea    -0xf(%r15),%rax
     9d1:	41 c6 02 f0          	movb   $0xf0,(%r10)
     9d5:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     9db:	76 19                	jbe    9f6 <n100_private_lz4_compress_fast_extState+0x306>
     9dd:	0f 1f 00             	nopl   (%rax)
     9e0:	48 2d ff 00 00 00    	sub    $0xff,%rax
     9e6:	48 83 c1 01          	add    $0x1,%rcx
     9ea:	c6 41 ff ff          	movb   $0xff,-0x1(%rcx)
     9ee:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     9f4:	77 ea                	ja     9e0 <n100_private_lz4_compress_fast_extState+0x2f0>
     9f6:	88 01                	mov    %al,(%rcx)
     9f8:	48 83 c1 01          	add    $0x1,%rcx
     9fc:	e9 66 02 00 00       	jmp    c67 <n100_private_lz4_compress_fast_extState+0x577>
     a01:	41 83 fe 0c          	cmp    $0xc,%r14d
     a05:	0f 8e 3e 02 00 00    	jle    c49 <n100_private_lz4_compress_fast_extState+0x559>
     a0b:	69 03 b1 79 37 9e    	imul   $0x9e3779b1,(%rbx),%eax
     a11:	31 c9                	xor    %ecx,%ecx
     a13:	4d 89 e1             	mov    %r12,%r9
     a16:	49 89 db             	mov    %rbx,%r11
     a19:	c1 e8 15             	shr    $0x15,%eax
     a1c:	66 89 0c 47          	mov    %cx,(%rdi,%rax,2)
     a20:	44 69 43 01 b1 79 37 	imul   $0x9e3779b1,0x1(%rbx),%r8d
     a27:	9e 
     a28:	48 8d 43 01          	lea    0x1(%rbx),%rax
     a2c:	41 c1 e8 15          	shr    $0x15,%r8d
     a30:	8b 74 24 04          	mov    0x4(%rsp),%esi
     a34:	bd 01 00 00 00       	mov    $0x1,%ebp
     a39:	c1 e6 06             	shl    $0x6,%esi
     a3c:	eb 36                	jmp    a74 <n100_private_lz4_compress_fast_extState+0x384>
     a3e:	66 90                	xchg   %ax,%ax
     a40:	4e 8d 14 47          	lea    (%rdi,%r8,2),%r10
     a44:	49 89 d6             	mov    %rdx,%r14
     a47:	89 f5                	mov    %esi,%ebp
     a49:	44 69 00 b1 79 37 9e 	imul   $0x9e3779b1,(%rax),%r8d
     a50:	41 0f b7 0a          	movzwl (%r10),%ecx
     a54:	49 29 de             	sub    %rbx,%r14
     a57:	c1 ed 06             	shr    $0x6,%ebp
     a5a:	66 45 89 32          	mov    %r14w,(%r10)
     a5e:	44 8b 32             	mov    (%rdx),%r14d
     a61:	48 01 d9             	add    %rbx,%rcx
     a64:	41 c1 e8 15          	shr    $0x15,%r8d
     a68:	44 39 31             	cmp    %r14d,(%rcx)
     a6b:	0f 84 01 02 00 00    	je     c72 <n100_private_lz4_compress_fast_extState+0x582>
     a71:	83 c6 01             	add    $0x1,%esi
     a74:	48 89 c2             	mov    %rax,%rdx
     a77:	48 8d 04 28          	lea    (%rax,%rbp,1),%rax
     a7b:	49 39 c5             	cmp    %rax,%r13
     a7e:	73 c0                	jae    a40 <n100_private_lz4_compress_fast_extState+0x350>
     a80:	4d 29 df             	sub    %r11,%r15
     a83:	49 8d 49 01          	lea    0x1(%r9),%rcx
     a87:	49 83 ff 0e          	cmp    $0xe,%r15
     a8b:	0f 86 aa 01 00 00    	jbe    c3b <n100_private_lz4_compress_fast_extState+0x54b>
     a91:	49 8d 47 f1          	lea    -0xf(%r15),%rax
     a95:	41 c6 01 f0          	movb   $0xf0,(%r9)
     a99:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     a9f:	0f 86 f1 fd ff ff    	jbe    896 <n100_private_lz4_compress_fast_extState+0x1a6>
     aa5:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     aaa:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     ab1:	00 00 00 00 
     ab5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     abc:	00 00 00 00 
     ac0:	48 2d ff 00 00 00    	sub    $0xff,%rax
     ac6:	48 83 c1 01          	add    $0x1,%rcx
     aca:	c6 41 ff ff          	movb   $0xff,-0x1(%rcx)
     ace:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     ad4:	77 ea                	ja     ac0 <n100_private_lz4_compress_fast_extState+0x3d0>
     ad6:	e9 bb fd ff ff       	jmp    896 <n100_private_lz4_compress_fast_extState+0x1a6>
     adb:	48 63 c5             	movslq %ebp,%rax
     ade:	48 8b 13             	mov    (%rbx),%rdx
     ae1:	48 8d 73 01          	lea    0x1(%rbx),%rsi
     ae5:	4d 89 e1             	mov    %r12,%r9
     ae8:	4c 01 e0             	add    %r12,%rax
     aeb:	49 89 db             	mov    %rbx,%r11
     aee:	41 89 ea             	mov    %ebp,%r10d
     af1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
     af6:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
     afd:	bc 1b cf 
     b00:	48 0f af d0          	imul   %rax,%rdx
     b04:	48 c1 ea 36          	shr    $0x36,%rdx
     b08:	c7 04 97 00 00 00 00 	movl   $0x0,(%rdi,%rdx,4)
     b0f:	8b 54 24 04          	mov    0x4(%rsp),%edx
     b13:	48 0f af 43 01       	imul   0x1(%rbx),%rax
     b18:	c1 e2 06             	shl    $0x6,%edx
     b1b:	89 54 24 10          	mov    %edx,0x10(%rsp)
     b1f:	48 c1 e8 36          	shr    $0x36,%rax
     b23:	4c 8d 46 01          	lea    0x1(%rsi),%r8
     b27:	4d 39 c5             	cmp    %r8,%r13
     b2a:	0f 82 81 00 00 00    	jb     bb1 <n100_private_lz4_compress_fast_extState+0x4c1>
     b30:	8b 54 24 04          	mov    0x4(%rsp),%edx
     b34:	8b 4c 24 10          	mov    0x10(%rsp),%ecx
     b38:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
     b3d:	49 be 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r14
     b44:	bc 1b cf 
     b47:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
     b4c:	81 e2 ff ff ff 03    	and    $0x3ffffff,%edx
     b52:	8d 69 01             	lea    0x1(%rcx),%ebp
     b55:	eb 06                	jmp    b5d <n100_private_lz4_compress_fast_extState+0x46d>
     b57:	83 c5 01             	add    $0x1,%ebp
     b5a:	49 89 c8             	mov    %rcx,%r8
     b5d:	89 c0                	mov    %eax,%eax
     b5f:	49 89 f3             	mov    %rsi,%r11
     b62:	4c 8d 0c 87          	lea    (%rdi,%rax,4),%r9
     b66:	49 29 db             	sub    %rbx,%r11
     b69:	49 8b 00             	mov    (%r8),%rax
     b6c:	41 8b 09             	mov    (%r9),%ecx
     b6f:	45 89 19             	mov    %r11d,(%r9)
     b72:	48 01 d9             	add    %rbx,%rcx
     b75:	4c 8d 89 ff ff 00 00 	lea    0xffff(%rcx),%r9
     b7c:	49 39 f1             	cmp    %rsi,%r9
     b7f:	72 0c                	jb     b8d <n100_private_lz4_compress_fast_extState+0x49d>
     b81:	44 8b 0e             	mov    (%rsi),%r9d
     b84:	44 39 09             	cmp    %r9d,(%rcx)
     b87:	0f 84 f7 06 00 00    	je     1284 <n100_private_lz4_compress_fast_extState+0xb94>
     b8d:	49 0f af c6          	imul   %r14,%rax
     b91:	89 d1                	mov    %edx,%ecx
     b93:	89 ea                	mov    %ebp,%edx
     b95:	4c 89 c6             	mov    %r8,%rsi
     b98:	4c 01 c1             	add    %r8,%rcx
     b9b:	c1 ea 06             	shr    $0x6,%edx
     b9e:	48 c1 e8 36          	shr    $0x36,%rax
     ba2:	49 39 cd             	cmp    %rcx,%r13
     ba5:	73 b0                	jae    b57 <n100_private_lz4_compress_fast_extState+0x467>
     ba7:	4c 8b 5c 24 18       	mov    0x18(%rsp),%r11
     bac:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
     bb1:	44 89 d5             	mov    %r10d,%ebp
     bb4:	48 be 81 80 80 80 80 	movabs $0x8080808080808081,%rsi
     bbb:	80 80 80 
     bbe:	4c 89 c8             	mov    %r9,%rax
     bc1:	4d 29 df             	sub    %r11,%r15
     bc4:	4c 29 e0             	sub    %r12,%rax
     bc7:	49 8d 4c 07 01       	lea    0x1(%r15,%rax,1),%rcx
     bcc:	49 8d 87 f0 00 00 00 	lea    0xf0(%r15),%rax
     bd3:	48 f7 e6             	mul    %rsi
     bd6:	48 c1 ea 07          	shr    $0x7,%rdx
     bda:	48 01 d1             	add    %rdx,%rcx
     bdd:	48 39 cd             	cmp    %rcx,%rbp
     be0:	0f 82 d1 fc ff ff    	jb     8b7 <n100_private_lz4_compress_fast_extState+0x1c7>
     be6:	49 8d 49 01          	lea    0x1(%r9),%rcx
     bea:	49 83 ff 0e          	cmp    $0xe,%r15
     bee:	76 4b                	jbe    c3b <n100_private_lz4_compress_fast_extState+0x54b>
     bf0:	49 8d 47 f1          	lea    -0xf(%r15),%rax
     bf4:	41 c6 01 f0          	movb   $0xf0,(%r9)
     bf8:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     bfe:	0f 86 92 fc ff ff    	jbe    896 <n100_private_lz4_compress_fast_extState+0x1a6>
     c04:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     c0a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     c11:	00 00 00 00 
     c15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     c1c:	00 00 00 00 
     c20:	48 2d ff 00 00 00    	sub    $0xff,%rax
     c26:	48 83 c1 01          	add    $0x1,%rcx
     c2a:	c6 41 ff ff          	movb   $0xff,-0x1(%rcx)
     c2e:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
     c34:	77 ea                	ja     c20 <n100_private_lz4_compress_fast_extState+0x530>
     c36:	e9 5b fc ff ff       	jmp    896 <n100_private_lz4_compress_fast_extState+0x1a6>
     c3b:	44 89 f8             	mov    %r15d,%eax
     c3e:	c1 e0 04             	shl    $0x4,%eax
     c41:	41 88 01             	mov    %al,(%r9)
     c44:	e9 53 fc ff ff       	jmp    89c <n100_private_lz4_compress_fast_extState+0x1ac>
     c49:	4d 89 e1             	mov    %r12,%r9
     c4c:	49 89 db             	mov    %rbx,%r11
     c4f:	e9 2c fe ff ff       	jmp    a80 <n100_private_lz4_compress_fast_extState+0x390>
     c54:	4d 89 e2             	mov    %r12,%r10
     c57:	31 f6                	xor    %esi,%esi
     c59:	e9 33 fd ff ff       	jmp    991 <n100_private_lz4_compress_fast_extState+0x2a1>
     c5e:	44 89 f8             	mov    %r15d,%eax
     c61:	c1 e0 04             	shl    $0x4,%eax
     c64:	41 88 02             	mov    %al,(%r10)
     c67:	4c 89 fa             	mov    %r15,%rdx
     c6a:	48 89 de             	mov    %rbx,%rsi
     c6d:	e9 30 fc ff ff       	jmp    8a2 <n100_private_lz4_compress_fast_extState+0x1b2>
     c72:	48 39 cb             	cmp    %rcx,%rbx
     c75:	73 12                	jae    c89 <n100_private_lz4_compress_fast_extState+0x599>
     c77:	49 39 d3             	cmp    %rdx,%r11
     c7a:	73 0d                	jae    c89 <n100_private_lz4_compress_fast_extState+0x599>
     c7c:	0f b6 41 ff          	movzbl -0x1(%rcx),%eax
     c80:	38 42 ff             	cmp    %al,-0x1(%rdx)
     c83:	0f 84 bc 09 00 00    	je     1645 <n100_private_lz4_compress_fast_extState+0xf55>
     c89:	49 89 d2             	mov    %rdx,%r10
     c8c:	49 8d 41 01          	lea    0x1(%r9),%rax
     c90:	4d 29 da             	sub    %r11,%r10
     c93:	41 83 fa 0e          	cmp    $0xe,%r10d
     c97:	0f 87 70 08 00 00    	ja     150d <n100_private_lz4_compress_fast_extState+0xe1d>
     c9d:	44 89 d6             	mov    %r10d,%esi
     ca0:	c1 e6 04             	shl    $0x4,%esi
     ca3:	41 88 31             	mov    %sil,(%r9)
     ca6:	45 89 d2             	mov    %r10d,%r10d
     ca9:	49 01 c2             	add    %rax,%r10
     cac:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     cb3:	00 00 
     cb5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     cbc:	00 00 00 00 
     cc0:	49 8b 33             	mov    (%r11),%rsi
     cc3:	48 83 c0 08          	add    $0x8,%rax
     cc7:	49 83 c3 08          	add    $0x8,%r11
     ccb:	48 89 70 f8          	mov    %rsi,-0x8(%rax)
     ccf:	4c 39 d0             	cmp    %r10,%rax
     cd2:	72 ec                	jb     cc0 <n100_private_lz4_compress_fast_extState+0x5d0>
     cd4:	49 8d 47 f8          	lea    -0x8(%r15),%rax
     cd8:	41 be 81 80 80 80    	mov    $0x80808081,%r14d
     cde:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
     ce3:	49 8d 47 fa          	lea    -0x6(%r15),%rax
     ce7:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     cec:	eb 62                	jmp    d50 <n100_private_lz4_compress_fast_extState+0x660>
     cee:	01 c1                	add    %eax,%ecx
     cf0:	41 88 09             	mov    %cl,(%r9)
     cf3:	49 89 f1             	mov    %rsi,%r9
     cf6:	49 39 d5             	cmp    %rdx,%r13
     cf9:	0f 82 f9 07 00 00    	jb     14f8 <n100_private_lz4_compress_fast_extState+0xe08>
     cff:	69 42 fe b1 79 37 9e 	imul   $0x9e3779b1,-0x2(%rdx),%eax
     d06:	48 8d 4a fe          	lea    -0x2(%rdx),%rcx
     d0a:	48 89 d6             	mov    %rdx,%rsi
     d0d:	48 29 d9             	sub    %rbx,%rcx
     d10:	48 29 de             	sub    %rbx,%rsi
     d13:	c1 e8 15             	shr    $0x15,%eax
     d16:	66 89 0c 47          	mov    %cx,(%rdi,%rax,2)
     d1a:	69 02 b1 79 37 9e    	imul   $0x9e3779b1,(%rdx),%eax
     d20:	c1 e8 15             	shr    $0x15,%eax
     d23:	0f b7 0c 47          	movzwl (%rdi,%rax,2),%ecx
     d27:	66 89 34 47          	mov    %si,(%rdi,%rax,2)
     d2b:	48 01 d9             	add    %rbx,%rcx
     d2e:	48 8d 81 ff ff 00 00 	lea    0xffff(%rcx),%rax
     d35:	48 39 d0             	cmp    %rdx,%rax
     d38:	0f 82 83 07 00 00    	jb     14c1 <n100_private_lz4_compress_fast_extState+0xdd1>
     d3e:	8b 02                	mov    (%rdx),%eax
     d40:	39 01                	cmp    %eax,(%rcx)
     d42:	0f 85 79 07 00 00    	jne    14c1 <n100_private_lz4_compress_fast_extState+0xdd1>
     d48:	41 c6 01 00          	movb   $0x0,(%r9)
     d4c:	4d 8d 51 01          	lea    0x1(%r9),%r10
     d50:	48 89 d0             	mov    %rdx,%rax
     d53:	4c 8d 5a 04          	lea    0x4(%rdx),%r11
     d57:	49 8d 72 02          	lea    0x2(%r10),%rsi
     d5b:	48 29 c8             	sub    %rcx,%rax
     d5e:	48 83 c1 04          	add    $0x4,%rcx
     d62:	66 41 89 02          	mov    %ax,(%r10)
     d66:	4c 89 d8             	mov    %r11,%rax
     d69:	4d 39 eb             	cmp    %r13,%r11
     d6c:	0f 83 9d 00 00 00    	jae    e0f <n100_private_lz4_compress_fast_extState+0x71f>
     d72:	4c 8b 01             	mov    (%rcx),%r8
     d75:	48 8b 28             	mov    (%rax),%rbp
     d78:	49 39 e8             	cmp    %rbp,%r8
     d7b:	0f 84 7d 00 00 00    	je     dfe <n100_private_lz4_compress_fast_extState+0x70e>
     d81:	49 31 e8             	xor    %rbp,%r8
     d84:	f3 4d 0f bc c0       	tzcnt  %r8,%r8
     d89:	49 c1 e8 03          	shr    $0x3,%r8
     d8d:	44 01 c0             	add    %r8d,%eax
     d90:	44 29 d8             	sub    %r11d,%eax
     d93:	8d 48 04             	lea    0x4(%rax),%ecx
     d96:	48 01 ca             	add    %rcx,%rdx
     d99:	41 0f b6 09          	movzbl (%r9),%ecx
     d9d:	83 f8 0e             	cmp    $0xe,%eax
     da0:	0f 86 48 ff ff ff    	jbe    cee <n100_private_lz4_compress_fast_extState+0x5fe>
     da6:	83 c1 0f             	add    $0xf,%ecx
     da9:	83 e8 0f             	sub    $0xf,%eax
     dac:	41 88 09             	mov    %cl,(%r9)
     daf:	41 c7 42 02 ff ff ff 	movl   $0xffffffff,0x2(%r10)
     db6:	ff 
     db7:	3d fb 03 00 00       	cmp    $0x3fb,%eax
     dbc:	76 18                	jbe    dd6 <n100_private_lz4_compress_fast_extState+0x6e6>
     dbe:	66 90                	xchg   %ax,%ax
     dc0:	2d fc 03 00 00       	sub    $0x3fc,%eax
     dc5:	48 83 c6 04          	add    $0x4,%rsi
     dc9:	c7 06 ff ff ff ff    	movl   $0xffffffff,(%rsi)
     dcf:	3d fb 03 00 00       	cmp    $0x3fb,%eax
     dd4:	77 ea                	ja     dc0 <n100_private_lz4_compress_fast_extState+0x6d0>
     dd6:	89 c1                	mov    %eax,%ecx
     dd8:	49 0f af ce          	imul   %r14,%rcx
     ddc:	48 c1 e9 27          	shr    $0x27,%rcx
     de0:	41 89 c8             	mov    %ecx,%r8d
     de3:	4c 01 c6             	add    %r8,%rsi
     de6:	41 89 c8             	mov    %ecx,%r8d
     de9:	41 c1 e0 08          	shl    $0x8,%r8d
     ded:	4c 8d 4e 01          	lea    0x1(%rsi),%r9
     df1:	41 29 c8             	sub    %ecx,%r8d
     df4:	44 29 c0             	sub    %r8d,%eax
     df7:	88 06                	mov    %al,(%rsi)
     df9:	e9 f8 fe ff ff       	jmp    cf6 <n100_private_lz4_compress_fast_extState+0x606>
     dfe:	48 83 c0 08          	add    $0x8,%rax
     e02:	48 83 c1 08          	add    $0x8,%rcx
     e06:	4c 39 e8             	cmp    %r13,%rax
     e09:	0f 82 63 ff ff ff    	jb     d72 <n100_private_lz4_compress_fast_extState+0x682>
     e0f:	48 3b 44 24 10       	cmp    0x10(%rsp),%rax
     e14:	73 10                	jae    e26 <n100_private_lz4_compress_fast_extState+0x736>
     e16:	44 8b 00             	mov    (%rax),%r8d
     e19:	44 39 01             	cmp    %r8d,(%rcx)
     e1c:	75 08                	jne    e26 <n100_private_lz4_compress_fast_extState+0x736>
     e1e:	48 83 c0 04          	add    $0x4,%rax
     e22:	48 83 c1 04          	add    $0x4,%rcx
     e26:	48 3b 44 24 18       	cmp    0x18(%rsp),%rax
     e2b:	73 12                	jae    e3f <n100_private_lz4_compress_fast_extState+0x74f>
     e2d:	44 0f b7 00          	movzwl (%rax),%r8d
     e31:	66 44 39 01          	cmp    %r8w,(%rcx)
     e35:	75 08                	jne    e3f <n100_private_lz4_compress_fast_extState+0x74f>
     e37:	48 83 c0 02          	add    $0x2,%rax
     e3b:	48 83 c1 02          	add    $0x2,%rcx
     e3f:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
     e44:	73 10                	jae    e56 <n100_private_lz4_compress_fast_extState+0x766>
     e46:	44 0f b6 00          	movzbl (%rax),%r8d
     e4a:	44 38 01             	cmp    %r8b,(%rcx)
     e4d:	0f 94 c1             	sete   %cl
     e50:	0f b6 c9             	movzbl %cl,%ecx
     e53:	48 01 c8             	add    %rcx,%rax
     e56:	44 29 d8             	sub    %r11d,%eax
     e59:	e9 35 ff ff ff       	jmp    d93 <n100_private_lz4_compress_fast_extState+0x6a3>
     e5e:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
     e63:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
     e68:	48 39 d3             	cmp    %rdx,%rbx
     e6b:	73 12                	jae    e7f <n100_private_lz4_compress_fast_extState+0x78f>
     e6d:	49 39 cb             	cmp    %rcx,%r11
     e70:	73 0d                	jae    e7f <n100_private_lz4_compress_fast_extState+0x78f>
     e72:	0f b6 42 ff          	movzbl -0x1(%rdx),%eax
     e76:	38 41 ff             	cmp    %al,-0x1(%rcx)
     e79:	0f 84 fb 07 00 00    	je     167a <n100_private_lz4_compress_fast_extState+0xf8a>
     e7f:	48 89 ce             	mov    %rcx,%rsi
     e82:	41 b8 81 80 80 80    	mov    $0x80808081,%r8d
     e88:	49 8d 42 01          	lea    0x1(%r10),%rax
     e8c:	4c 29 de             	sub    %r11,%rsi
     e8f:	89 f5                	mov    %esi,%ebp
     e91:	4c 0f af c5          	imul   %rbp,%r8
     e95:	49 c1 e8 27          	shr    $0x27,%r8
     e99:	4e 8d 44 05 08       	lea    0x8(%rbp,%r8,1),%r8
     e9e:	49 01 c0             	add    %rax,%r8
     ea1:	4d 39 c6             	cmp    %r8,%r14
     ea4:	0f 82 0d fa ff ff    	jb     8b7 <n100_private_lz4_compress_fast_extState+0x1c7>
     eaa:	83 fe 0e             	cmp    $0xe,%esi
     ead:	0f 87 cf 06 00 00    	ja     1582 <n100_private_lz4_compress_fast_extState+0xe92>
     eb3:	c1 e6 04             	shl    $0x4,%esi
     eb6:	41 88 32             	mov    %sil,(%r10)
     eb9:	48 01 c5             	add    %rax,%rbp
     ebc:	0f 1f 40 00          	nopl   0x0(%rax)
     ec0:	49 8b 33             	mov    (%r11),%rsi
     ec3:	48 83 c0 08          	add    $0x8,%rax
     ec7:	49 83 c3 08          	add    $0x8,%r11
     ecb:	48 89 70 f8          	mov    %rsi,-0x8(%rax)
     ecf:	48 39 e8             	cmp    %rbp,%rax
     ed2:	72 ec                	jb     ec0 <n100_private_lz4_compress_fast_extState+0x7d0>
     ed4:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
     ed9:	eb 62                	jmp    f3d <n100_private_lz4_compress_fast_extState+0x84d>
     edb:	01 c2                	add    %eax,%edx
     edd:	41 88 12             	mov    %dl,(%r10)
     ee0:	49 89 f2             	mov    %rsi,%r10
     ee3:	49 39 cd             	cmp    %rcx,%r13
     ee6:	0f 82 78 07 00 00    	jb     1664 <n100_private_lz4_compress_fast_extState+0xf74>
     eec:	69 41 fe b1 79 37 9e 	imul   $0x9e3779b1,-0x2(%rcx),%eax
     ef3:	48 8d 51 fe          	lea    -0x2(%rcx),%rdx
     ef7:	48 89 ce             	mov    %rcx,%rsi
     efa:	48 29 da             	sub    %rbx,%rdx
     efd:	48 29 de             	sub    %rbx,%rsi
     f00:	c1 e8 15             	shr    $0x15,%eax
     f03:	66 89 14 47          	mov    %dx,(%rdi,%rax,2)
     f07:	69 01 b1 79 37 9e    	imul   $0x9e3779b1,(%rcx),%eax
     f0d:	c1 e8 15             	shr    $0x15,%eax
     f10:	0f b7 14 47          	movzwl (%rdi,%rax,2),%edx
     f14:	66 89 34 47          	mov    %si,(%rdi,%rax,2)
     f18:	48 01 da             	add    %rbx,%rdx
     f1b:	48 8d 82 ff ff 00 00 	lea    0xffff(%rdx),%rax
     f22:	48 39 c8             	cmp    %rcx,%rax
     f25:	0f 82 97 06 00 00    	jb     15c2 <n100_private_lz4_compress_fast_extState+0xed2>
     f2b:	8b 01                	mov    (%rcx),%eax
     f2d:	39 02                	cmp    %eax,(%rdx)
     f2f:	0f 85 8d 06 00 00    	jne    15c2 <n100_private_lz4_compress_fast_extState+0xed2>
     f35:	41 c6 02 00          	movb   $0x0,(%r10)
     f39:	49 8d 6a 01          	lea    0x1(%r10),%rbp
     f3d:	48 89 c8             	mov    %rcx,%rax
     f40:	4c 8d 59 04          	lea    0x4(%rcx),%r11
     f44:	48 8d 75 02          	lea    0x2(%rbp),%rsi
     f48:	48 29 d0             	sub    %rdx,%rax
     f4b:	48 83 c2 04          	add    $0x4,%rdx
     f4f:	66 89 45 00          	mov    %ax,0x0(%rbp)
     f53:	4c 89 d8             	mov    %r11,%rax
     f56:	4d 39 eb             	cmp    %r13,%r11
     f59:	0f 83 b6 00 00 00    	jae    1015 <n100_private_lz4_compress_fast_extState+0x925>
     f5f:	4c 8b 02             	mov    (%rdx),%r8
     f62:	4c 8b 20             	mov    (%rax),%r12
     f65:	4d 39 e0             	cmp    %r12,%r8
     f68:	0f 84 96 00 00 00    	je     1004 <n100_private_lz4_compress_fast_extState+0x914>
     f6e:	4d 31 e0             	xor    %r12,%r8
     f71:	f3 4d 0f bc c0       	tzcnt  %r8,%r8
     f76:	49 c1 e8 03          	shr    $0x3,%r8
     f7a:	44 01 c0             	add    %r8d,%eax
     f7d:	44 29 d8             	sub    %r11d,%eax
     f80:	89 c2                	mov    %eax,%edx
     f82:	c1 ea 08             	shr    $0x8,%edx
     f85:	83 c2 06             	add    $0x6,%edx
     f88:	48 01 f2             	add    %rsi,%rdx
     f8b:	49 39 d6             	cmp    %rdx,%r14
     f8e:	0f 82 23 f9 ff ff    	jb     8b7 <n100_private_lz4_compress_fast_extState+0x1c7>
     f94:	8d 50 04             	lea    0x4(%rax),%edx
     f97:	48 01 d1             	add    %rdx,%rcx
     f9a:	41 0f b6 12          	movzbl (%r10),%edx
     f9e:	83 f8 0e             	cmp    $0xe,%eax
     fa1:	0f 86 34 ff ff ff    	jbe    edb <n100_private_lz4_compress_fast_extState+0x7eb>
     fa7:	83 c2 0f             	add    $0xf,%edx
     faa:	83 e8 0f             	sub    $0xf,%eax
     fad:	41 88 12             	mov    %dl,(%r10)
     fb0:	c7 45 02 ff ff ff ff 	movl   $0xffffffff,0x2(%rbp)
     fb7:	3d fb 03 00 00       	cmp    $0x3fb,%eax
     fbc:	76 18                	jbe    fd6 <n100_private_lz4_compress_fast_extState+0x8e6>
     fbe:	66 90                	xchg   %ax,%ax
     fc0:	2d fc 03 00 00       	sub    $0x3fc,%eax
     fc5:	48 83 c6 04          	add    $0x4,%rsi
     fc9:	c7 06 ff ff ff ff    	movl   $0xffffffff,(%rsi)
     fcf:	3d fb 03 00 00       	cmp    $0x3fb,%eax
     fd4:	77 ea                	ja     fc0 <n100_private_lz4_compress_fast_extState+0x8d0>
     fd6:	89 c2                	mov    %eax,%edx
     fd8:	41 ba 81 80 80 80    	mov    $0x80808081,%r10d
     fde:	49 0f af d2          	imul   %r10,%rdx
     fe2:	48 c1 ea 27          	shr    $0x27,%rdx
     fe6:	41 89 d0             	mov    %edx,%r8d
     fe9:	4c 01 c6             	add    %r8,%rsi
     fec:	41 89 d0             	mov    %edx,%r8d
     fef:	41 c1 e0 08          	shl    $0x8,%r8d
     ff3:	4c 8d 56 01          	lea    0x1(%rsi),%r10
     ff7:	41 29 d0             	sub    %edx,%r8d
     ffa:	44 29 c0             	sub    %r8d,%eax
     ffd:	88 06                	mov    %al,(%rsi)
     fff:	e9 df fe ff ff       	jmp    ee3 <n100_private_lz4_compress_fast_extState+0x7f3>
    1004:	48 83 c0 08          	add    $0x8,%rax
    1008:	48 83 c2 08          	add    $0x8,%rdx
    100c:	4c 39 e8             	cmp    %r13,%rax
    100f:	0f 82 4a ff ff ff    	jb     f5f <n100_private_lz4_compress_fast_extState+0x86f>
    1015:	4d 8d 47 f8          	lea    -0x8(%r15),%r8
    1019:	4c 39 c0             	cmp    %r8,%rax
    101c:	73 10                	jae    102e <n100_private_lz4_compress_fast_extState+0x93e>
    101e:	44 8b 00             	mov    (%rax),%r8d
    1021:	44 39 02             	cmp    %r8d,(%rdx)
    1024:	75 08                	jne    102e <n100_private_lz4_compress_fast_extState+0x93e>
    1026:	48 83 c0 04          	add    $0x4,%rax
    102a:	48 83 c2 04          	add    $0x4,%rdx
    102e:	4d 8d 47 fa          	lea    -0x6(%r15),%r8
    1032:	4c 39 c0             	cmp    %r8,%rax
    1035:	73 12                	jae    1049 <n100_private_lz4_compress_fast_extState+0x959>
    1037:	44 0f b7 00          	movzwl (%rax),%r8d
    103b:	66 44 39 02          	cmp    %r8w,(%rdx)
    103f:	75 08                	jne    1049 <n100_private_lz4_compress_fast_extState+0x959>
    1041:	48 83 c0 02          	add    $0x2,%rax
    1045:	48 83 c2 02          	add    $0x2,%rdx
    1049:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
    104e:	73 10                	jae    1060 <n100_private_lz4_compress_fast_extState+0x970>
    1050:	44 0f b6 00          	movzbl (%rax),%r8d
    1054:	44 38 02             	cmp    %r8b,(%rdx)
    1057:	0f 94 c2             	sete   %dl
    105a:	0f b6 d2             	movzbl %dl,%edx
    105d:	48 01 d0             	add    %rdx,%rax
    1060:	44 29 d8             	sub    %r11d,%eax
    1063:	e9 18 ff ff ff       	jmp    f80 <n100_private_lz4_compress_fast_extState+0x890>
    1068:	48 39 c3             	cmp    %rax,%rbx
    106b:	73 13                	jae    1080 <n100_private_lz4_compress_fast_extState+0x990>
    106d:	49 39 d3             	cmp    %rdx,%r11
    1070:	73 0e                	jae    1080 <n100_private_lz4_compress_fast_extState+0x990>
    1072:	0f b6 70 ff          	movzbl -0x1(%rax),%esi
    1076:	40 38 72 ff          	cmp    %sil,-0x1(%rdx)
    107a:	0f 84 19 06 00 00    	je     1699 <n100_private_lz4_compress_fast_extState+0xfa9>
    1080:	49 89 d2             	mov    %rdx,%r10
    1083:	49 8d 49 01          	lea    0x1(%r9),%rcx
    1087:	4d 29 da             	sub    %r11,%r10
    108a:	41 83 fa 0e          	cmp    $0xe,%r10d
    108e:	0f 87 ae 04 00 00    	ja     1542 <n100_private_lz4_compress_fast_extState+0xe52>
    1094:	44 89 d6             	mov    %r10d,%esi
    1097:	c1 e6 04             	shl    $0x4,%esi
    109a:	41 88 31             	mov    %sil,(%r9)
    109d:	45 89 d2             	mov    %r10d,%r10d
    10a0:	49 01 ca             	add    %rcx,%r10
    10a3:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    10aa:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    10b1:	00 00 00 00 
    10b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    10bc:	00 00 00 00 
    10c0:	49 8b 33             	mov    (%r11),%rsi
    10c3:	48 83 c1 08          	add    $0x8,%rcx
    10c7:	49 83 c3 08          	add    $0x8,%r11
    10cb:	48 89 71 f8          	mov    %rsi,-0x8(%rcx)
    10cf:	4c 39 d1             	cmp    %r10,%rcx
    10d2:	72 ec                	jb     10c0 <n100_private_lz4_compress_fast_extState+0x9d0>
    10d4:	49 8d 77 f8          	lea    -0x8(%r15),%rsi
    10d8:	48 89 c1             	mov    %rax,%rcx
    10db:	49 bc 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r12
    10e2:	bc 1b cf 
    10e5:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
    10ea:	49 8d 77 fa          	lea    -0x6(%r15),%rsi
    10ee:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    10f3:	eb 63                	jmp    1158 <n100_private_lz4_compress_fast_extState+0xa68>
    10f5:	01 c1                	add    %eax,%ecx
    10f7:	41 88 09             	mov    %cl,(%r9)
    10fa:	49 89 f1             	mov    %rsi,%r9
    10fd:	49 39 d5             	cmp    %rdx,%r13
    1100:	0f 82 fa 03 00 00    	jb     1500 <n100_private_lz4_compress_fast_extState+0xe10>
    1106:	48 8b 42 fe          	mov    -0x2(%rdx),%rax
    110a:	48 8d 4a fe          	lea    -0x2(%rdx),%rcx
    110e:	48 89 d6             	mov    %rdx,%rsi
    1111:	48 29 d9             	sub    %rbx,%rcx
    1114:	48 29 de             	sub    %rbx,%rsi
    1117:	49 0f af c4          	imul   %r12,%rax
    111b:	48 c1 e8 36          	shr    $0x36,%rax
    111f:	89 0c 87             	mov    %ecx,(%rdi,%rax,4)
    1122:	48 8b 02             	mov    (%rdx),%rax
    1125:	49 0f af c4          	imul   %r12,%rax
    1129:	48 c1 e8 36          	shr    $0x36,%rax
    112d:	8b 0c 87             	mov    (%rdi,%rax,4),%ecx
    1130:	89 34 87             	mov    %esi,(%rdi,%rax,4)
    1133:	48 01 d9             	add    %rbx,%rcx
    1136:	48 8d 81 ff ff 00 00 	lea    0xffff(%rcx),%rax
    113d:	48 39 d0             	cmp    %rdx,%rax
    1140:	0f 82 93 03 00 00    	jb     14d9 <n100_private_lz4_compress_fast_extState+0xde9>
    1146:	8b 02                	mov    (%rdx),%eax
    1148:	39 01                	cmp    %eax,(%rcx)
    114a:	0f 85 89 03 00 00    	jne    14d9 <n100_private_lz4_compress_fast_extState+0xde9>
    1150:	41 c6 01 00          	movb   $0x0,(%r9)
    1154:	4d 8d 51 01          	lea    0x1(%r9),%r10
    1158:	48 89 d0             	mov    %rdx,%rax
    115b:	4c 8d 5a 04          	lea    0x4(%rdx),%r11
    115f:	49 8d 72 02          	lea    0x2(%r10),%rsi
    1163:	48 29 c8             	sub    %rcx,%rax
    1166:	48 83 c1 04          	add    $0x4,%rcx
    116a:	66 41 89 02          	mov    %ax,(%r10)
    116e:	4c 89 d8             	mov    %r11,%rax
    1171:	4d 39 eb             	cmp    %r13,%r11
    1174:	0f 83 bb 00 00 00    	jae    1235 <n100_private_lz4_compress_fast_extState+0xb45>
    117a:	4c 8b 01             	mov    (%rcx),%r8
    117d:	48 8b 28             	mov    (%rax),%rbp
    1180:	49 39 e8             	cmp    %rbp,%r8
    1183:	0f 84 9b 00 00 00    	je     1224 <n100_private_lz4_compress_fast_extState+0xb34>
    1189:	49 31 e8             	xor    %rbp,%r8
    118c:	f3 4d 0f bc c0       	tzcnt  %r8,%r8
    1191:	49 c1 e8 03          	shr    $0x3,%r8
    1195:	44 01 c0             	add    %r8d,%eax
    1198:	44 29 d8             	sub    %r11d,%eax
    119b:	8d 48 04             	lea    0x4(%rax),%ecx
    119e:	48 01 ca             	add    %rcx,%rdx
    11a1:	41 0f b6 09          	movzbl (%r9),%ecx
    11a5:	83 f8 0e             	cmp    $0xe,%eax
    11a8:	0f 86 47 ff ff ff    	jbe    10f5 <n100_private_lz4_compress_fast_extState+0xa05>
    11ae:	83 c1 0f             	add    $0xf,%ecx
    11b1:	83 e8 0f             	sub    $0xf,%eax
    11b4:	41 88 09             	mov    %cl,(%r9)
    11b7:	41 c7 42 02 ff ff ff 	movl   $0xffffffff,0x2(%r10)
    11be:	ff 
    11bf:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    11c4:	76 30                	jbe    11f6 <n100_private_lz4_compress_fast_extState+0xb06>
    11c6:	0f 1f 40 00          	nopl   0x0(%rax)
    11ca:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    11d1:	00 00 00 00 
    11d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    11dc:	00 00 00 00 
    11e0:	2d fc 03 00 00       	sub    $0x3fc,%eax
    11e5:	48 83 c6 04          	add    $0x4,%rsi
    11e9:	c7 06 ff ff ff ff    	movl   $0xffffffff,(%rsi)
    11ef:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    11f4:	77 ea                	ja     11e0 <n100_private_lz4_compress_fast_extState+0xaf0>
    11f6:	89 c1                	mov    %eax,%ecx
    11f8:	41 b9 81 80 80 80    	mov    $0x80808081,%r9d
    11fe:	49 0f af c9          	imul   %r9,%rcx
    1202:	48 c1 e9 27          	shr    $0x27,%rcx
    1206:	41 89 c8             	mov    %ecx,%r8d
    1209:	4c 01 c6             	add    %r8,%rsi
    120c:	41 89 c8             	mov    %ecx,%r8d
    120f:	41 c1 e0 08          	shl    $0x8,%r8d
    1213:	4c 8d 4e 01          	lea    0x1(%rsi),%r9
    1217:	41 29 c8             	sub    %ecx,%r8d
    121a:	44 29 c0             	sub    %r8d,%eax
    121d:	88 06                	mov    %al,(%rsi)
    121f:	e9 d9 fe ff ff       	jmp    10fd <n100_private_lz4_compress_fast_extState+0xa0d>
    1224:	48 83 c0 08          	add    $0x8,%rax
    1228:	48 83 c1 08          	add    $0x8,%rcx
    122c:	4c 39 e8             	cmp    %r13,%rax
    122f:	0f 82 45 ff ff ff    	jb     117a <n100_private_lz4_compress_fast_extState+0xa8a>
    1235:	48 3b 44 24 20       	cmp    0x20(%rsp),%rax
    123a:	73 10                	jae    124c <n100_private_lz4_compress_fast_extState+0xb5c>
    123c:	44 8b 00             	mov    (%rax),%r8d
    123f:	44 39 01             	cmp    %r8d,(%rcx)
    1242:	75 08                	jne    124c <n100_private_lz4_compress_fast_extState+0xb5c>
    1244:	48 83 c0 04          	add    $0x4,%rax
    1248:	48 83 c1 04          	add    $0x4,%rcx
    124c:	48 3b 44 24 28       	cmp    0x28(%rsp),%rax
    1251:	73 12                	jae    1265 <n100_private_lz4_compress_fast_extState+0xb75>
    1253:	44 0f b7 00          	movzwl (%rax),%r8d
    1257:	66 44 39 01          	cmp    %r8w,(%rcx)
    125b:	75 08                	jne    1265 <n100_private_lz4_compress_fast_extState+0xb75>
    125d:	48 83 c0 02          	add    $0x2,%rax
    1261:	48 83 c1 02          	add    $0x2,%rcx
    1265:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
    126a:	73 10                	jae    127c <n100_private_lz4_compress_fast_extState+0xb8c>
    126c:	44 0f b6 00          	movzbl (%rax),%r8d
    1270:	44 38 01             	cmp    %r8b,(%rcx)
    1273:	0f 94 c1             	sete   %cl
    1276:	0f b6 c9             	movzbl %cl,%ecx
    1279:	48 01 c8             	add    %rcx,%rax
    127c:	44 29 d8             	sub    %r11d,%eax
    127f:	e9 17 ff ff ff       	jmp    119b <n100_private_lz4_compress_fast_extState+0xaab>
    1284:	4c 8b 5c 24 18       	mov    0x18(%rsp),%r11
    1289:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
    128e:	49 39 f3             	cmp    %rsi,%r11
    1291:	73 12                	jae    12a5 <n100_private_lz4_compress_fast_extState+0xbb5>
    1293:	48 39 cb             	cmp    %rcx,%rbx
    1296:	73 0d                	jae    12a5 <n100_private_lz4_compress_fast_extState+0xbb5>
    1298:	0f b6 41 ff          	movzbl -0x1(%rcx),%eax
    129c:	38 46 ff             	cmp    %al,-0x1(%rsi)
    129f:	0f 84 23 04 00 00    	je     16c8 <n100_private_lz4_compress_fast_extState+0xfd8>
    12a5:	48 89 f2             	mov    %rsi,%rdx
    12a8:	41 b8 81 80 80 80    	mov    $0x80808081,%r8d
    12ae:	49 8d 41 01          	lea    0x1(%r9),%rax
    12b2:	4c 29 da             	sub    %r11,%rdx
    12b5:	89 d5                	mov    %edx,%ebp
    12b7:	4c 0f af c5          	imul   %rbp,%r8
    12bb:	49 c1 e8 27          	shr    $0x27,%r8
    12bf:	4e 8d 44 05 08       	lea    0x8(%rbp,%r8,1),%r8
    12c4:	49 01 c0             	add    %rax,%r8
    12c7:	4c 39 44 24 28       	cmp    %r8,0x28(%rsp)
    12cc:	0f 82 e5 f5 ff ff    	jb     8b7 <n100_private_lz4_compress_fast_extState+0x1c7>
    12d2:	83 fa 0e             	cmp    $0xe,%edx
    12d5:	0f 87 04 03 00 00    	ja     15df <n100_private_lz4_compress_fast_extState+0xeef>
    12db:	c1 e2 04             	shl    $0x4,%edx
    12de:	41 88 11             	mov    %dl,(%r9)
    12e1:	48 01 c5             	add    %rax,%rbp
    12e4:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    12ea:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    12f1:	00 00 00 00 
    12f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    12fc:	00 00 00 00 
    1300:	49 8b 13             	mov    (%r11),%rdx
    1303:	48 83 c0 08          	add    $0x8,%rax
    1307:	49 83 c3 08          	add    $0x8,%r11
    130b:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
    130f:	48 39 e8             	cmp    %rbp,%rax
    1312:	72 ec                	jb     1300 <n100_private_lz4_compress_fast_extState+0xc10>
    1314:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
    1319:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    131e:	eb 72                	jmp    1392 <n100_private_lz4_compress_fast_extState+0xca2>
    1320:	01 c2                	add    %eax,%edx
    1322:	41 88 11             	mov    %dl,(%r9)
    1325:	4d 89 c1             	mov    %r8,%r9
    1328:	49 39 f5             	cmp    %rsi,%r13
    132b:	0f 82 87 03 00 00    	jb     16b8 <n100_private_lz4_compress_fast_extState+0xfc8>
    1331:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    1338:	bc 1b cf 
    133b:	48 0f af 46 fe       	imul   -0x2(%rsi),%rax
    1340:	48 8d 56 fe          	lea    -0x2(%rsi),%rdx
    1344:	48 29 da             	sub    %rbx,%rdx
    1347:	48 c1 e8 36          	shr    $0x36,%rax
    134b:	89 14 87             	mov    %edx,(%rdi,%rax,4)
    134e:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    1355:	bc 1b cf 
    1358:	48 0f af 06          	imul   (%rsi),%rax
    135c:	48 c1 e8 36          	shr    $0x36,%rax
    1360:	8b 14 87             	mov    (%rdi,%rax,4),%edx
    1363:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    1367:	48 89 f2             	mov    %rsi,%rdx
    136a:	48 29 da             	sub    %rbx,%rdx
    136d:	89 14 87             	mov    %edx,(%rdi,%rax,4)
    1370:	48 8d 81 ff ff 00 00 	lea    0xffff(%rcx),%rax
    1377:	48 39 f0             	cmp    %rsi,%rax
    137a:	0f 82 a1 02 00 00    	jb     1621 <n100_private_lz4_compress_fast_extState+0xf31>
    1380:	8b 06                	mov    (%rsi),%eax
    1382:	39 01                	cmp    %eax,(%rcx)
    1384:	0f 85 97 02 00 00    	jne    1621 <n100_private_lz4_compress_fast_extState+0xf31>
    138a:	41 c6 01 00          	movb   $0x0,(%r9)
    138e:	49 8d 69 01          	lea    0x1(%r9),%rbp
    1392:	48 89 f0             	mov    %rsi,%rax
    1395:	4c 8d 5e 04          	lea    0x4(%rsi),%r11
    1399:	4c 8d 45 02          	lea    0x2(%rbp),%r8
    139d:	48 29 c8             	sub    %rcx,%rax
    13a0:	48 8d 51 04          	lea    0x4(%rcx),%rdx
    13a4:	66 89 45 00          	mov    %ax,0x0(%rbp)
    13a8:	4c 89 d8             	mov    %r11,%rax
    13ab:	4d 39 eb             	cmp    %r13,%r11
    13ae:	0f 83 c0 00 00 00    	jae    1474 <n100_private_lz4_compress_fast_extState+0xd84>
    13b4:	48 8b 0a             	mov    (%rdx),%rcx
    13b7:	4c 8b 20             	mov    (%rax),%r12
    13ba:	4c 39 e1             	cmp    %r12,%rcx
    13bd:	0f 84 a0 00 00 00    	je     1463 <n100_private_lz4_compress_fast_extState+0xd73>
    13c3:	4c 31 e1             	xor    %r12,%rcx
    13c6:	f3 48 0f bc c9       	tzcnt  %rcx,%rcx
    13cb:	48 c1 e9 03          	shr    $0x3,%rcx
    13cf:	01 c8                	add    %ecx,%eax
    13d1:	44 29 d8             	sub    %r11d,%eax
    13d4:	89 c2                	mov    %eax,%edx
    13d6:	c1 ea 08             	shr    $0x8,%edx
    13d9:	83 c2 06             	add    $0x6,%edx
    13dc:	4c 01 c2             	add    %r8,%rdx
    13df:	49 39 d6             	cmp    %rdx,%r14
    13e2:	0f 82 cf f4 ff ff    	jb     8b7 <n100_private_lz4_compress_fast_extState+0x1c7>
    13e8:	8d 50 04             	lea    0x4(%rax),%edx
    13eb:	48 01 d6             	add    %rdx,%rsi
    13ee:	41 0f b6 11          	movzbl (%r9),%edx
    13f2:	83 f8 0e             	cmp    $0xe,%eax
    13f5:	0f 86 25 ff ff ff    	jbe    1320 <n100_private_lz4_compress_fast_extState+0xc30>
    13fb:	83 c2 0f             	add    $0xf,%edx
    13fe:	83 e8 0f             	sub    $0xf,%eax
    1401:	41 88 11             	mov    %dl,(%r9)
    1404:	c7 45 02 ff ff ff ff 	movl   $0xffffffff,0x2(%rbp)
    140b:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    1410:	76 25                	jbe    1437 <n100_private_lz4_compress_fast_extState+0xd47>
    1412:	0f 1f 00             	nopl   (%rax)
    1415:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    141c:	00 00 00 00 
    1420:	2d fc 03 00 00       	sub    $0x3fc,%eax
    1425:	49 83 c0 04          	add    $0x4,%r8
    1429:	41 c7 00 ff ff ff ff 	movl   $0xffffffff,(%r8)
    1430:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    1435:	77 e9                	ja     1420 <n100_private_lz4_compress_fast_extState+0xd30>
    1437:	89 c2                	mov    %eax,%edx
    1439:	b9 81 80 80 80       	mov    $0x80808081,%ecx
    143e:	48 0f af d1          	imul   %rcx,%rdx
    1442:	48 c1 ea 27          	shr    $0x27,%rdx
    1446:	89 d1                	mov    %edx,%ecx
    1448:	4c 01 c1             	add    %r8,%rcx
    144b:	41 89 d0             	mov    %edx,%r8d
    144e:	41 c1 e0 08          	shl    $0x8,%r8d
    1452:	4c 8d 49 01          	lea    0x1(%rcx),%r9
    1456:	41 29 d0             	sub    %edx,%r8d
    1459:	44 29 c0             	sub    %r8d,%eax
    145c:	88 01                	mov    %al,(%rcx)
    145e:	e9 c5 fe ff ff       	jmp    1328 <n100_private_lz4_compress_fast_extState+0xc38>
    1463:	48 83 c0 08          	add    $0x8,%rax
    1467:	48 83 c2 08          	add    $0x8,%rdx
    146b:	4c 39 e8             	cmp    %r13,%rax
    146e:	0f 82 40 ff ff ff    	jb     13b4 <n100_private_lz4_compress_fast_extState+0xcc4>
    1474:	49 8d 4f f8          	lea    -0x8(%r15),%rcx
    1478:	48 39 c8             	cmp    %rcx,%rax
    147b:	73 0e                	jae    148b <n100_private_lz4_compress_fast_extState+0xd9b>
    147d:	8b 08                	mov    (%rax),%ecx
    147f:	39 0a                	cmp    %ecx,(%rdx)
    1481:	75 08                	jne    148b <n100_private_lz4_compress_fast_extState+0xd9b>
    1483:	48 83 c0 04          	add    $0x4,%rax
    1487:	48 83 c2 04          	add    $0x4,%rdx
    148b:	49 8d 4f fa          	lea    -0x6(%r15),%rcx
    148f:	48 39 c8             	cmp    %rcx,%rax
    1492:	73 10                	jae    14a4 <n100_private_lz4_compress_fast_extState+0xdb4>
    1494:	0f b7 08             	movzwl (%rax),%ecx
    1497:	66 39 0a             	cmp    %cx,(%rdx)
    149a:	75 08                	jne    14a4 <n100_private_lz4_compress_fast_extState+0xdb4>
    149c:	48 83 c0 02          	add    $0x2,%rax
    14a0:	48 83 c2 02          	add    $0x2,%rdx
    14a4:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
    14a9:	73 0e                	jae    14b9 <n100_private_lz4_compress_fast_extState+0xdc9>
    14ab:	0f b6 08             	movzbl (%rax),%ecx
    14ae:	38 0a                	cmp    %cl,(%rdx)
    14b0:	0f 94 c2             	sete   %dl
    14b3:	0f b6 d2             	movzbl %dl,%edx
    14b6:	48 01 d0             	add    %rdx,%rax
    14b9:	44 29 d8             	sub    %r11d,%eax
    14bc:	e9 13 ff ff ff       	jmp    13d4 <n100_private_lz4_compress_fast_extState+0xce4>
    14c1:	44 69 42 01 b1 79 37 	imul   $0x9e3779b1,0x1(%rdx),%r8d
    14c8:	9e 
    14c9:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14cd:	49 89 d3             	mov    %rdx,%r11
    14d0:	41 c1 e8 15          	shr    $0x15,%r8d
    14d4:	e9 57 f5 ff ff       	jmp    a30 <n100_private_lz4_compress_fast_extState+0x340>
    14d9:	48 b9 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rcx
    14e0:	bc 1b cf 
    14e3:	48 0f af 4a 01       	imul   0x1(%rdx),%rcx
    14e8:	49 89 d3             	mov    %rdx,%r11
    14eb:	48 83 c2 01          	add    $0x1,%rdx
    14ef:	48 c1 e9 36          	shr    $0x36,%rcx
    14f3:	e9 d7 f2 ff ff       	jmp    7cf <n100_private_lz4_compress_fast_extState+0xdf>
    14f8:	49 89 d3             	mov    %rdx,%r11
    14fb:	e9 80 f5 ff ff       	jmp    a80 <n100_private_lz4_compress_fast_extState+0x390>
    1500:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    1505:	49 89 d3             	mov    %rdx,%r11
    1508:	e9 33 f3 ff ff       	jmp    840 <n100_private_lz4_compress_fast_extState+0x150>
    150d:	41 8d 72 f1          	lea    -0xf(%r10),%esi
    1511:	41 c6 01 f0          	movb   $0xf0,(%r9)
    1515:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    151b:	7e 19                	jle    1536 <n100_private_lz4_compress_fast_extState+0xe46>
    151d:	0f 1f 00             	nopl   (%rax)
    1520:	81 ee ff 00 00 00    	sub    $0xff,%esi
    1526:	48 83 c0 01          	add    $0x1,%rax
    152a:	c6 40 ff ff          	movb   $0xff,-0x1(%rax)
    152e:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    1534:	7f ea                	jg     1520 <n100_private_lz4_compress_fast_extState+0xe30>
    1536:	40 88 30             	mov    %sil,(%rax)
    1539:	48 83 c0 01          	add    $0x1,%rax
    153d:	e9 64 f7 ff ff       	jmp    ca6 <n100_private_lz4_compress_fast_extState+0x5b6>
    1542:	41 8d 72 f1          	lea    -0xf(%r10),%esi
    1546:	41 c6 01 f0          	movb   $0xf0,(%r9)
    154a:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    1550:	7e 24                	jle    1576 <n100_private_lz4_compress_fast_extState+0xe86>
    1552:	0f 1f 00             	nopl   (%rax)
    1555:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    155c:	00 00 00 00 
    1560:	81 ee ff 00 00 00    	sub    $0xff,%esi
    1566:	48 83 c1 01          	add    $0x1,%rcx
    156a:	c6 41 ff ff          	movb   $0xff,-0x1(%rcx)
    156e:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    1574:	7f ea                	jg     1560 <n100_private_lz4_compress_fast_extState+0xe70>
    1576:	40 88 31             	mov    %sil,(%rcx)
    1579:	48 83 c1 01          	add    $0x1,%rcx
    157d:	e9 1b fb ff ff       	jmp    109d <n100_private_lz4_compress_fast_extState+0x9ad>
    1582:	83 ee 0f             	sub    $0xf,%esi
    1585:	41 c6 02 f0          	movb   $0xf0,(%r10)
    1589:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    158f:	7e 25                	jle    15b6 <n100_private_lz4_compress_fast_extState+0xec6>
    1591:	0f 1f 40 00          	nopl   0x0(%rax)
    1595:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    159c:	00 00 00 00 
    15a0:	81 ee ff 00 00 00    	sub    $0xff,%esi
    15a6:	48 83 c0 01          	add    $0x1,%rax
    15aa:	c6 40 ff ff          	movb   $0xff,-0x1(%rax)
    15ae:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    15b4:	7f ea                	jg     15a0 <n100_private_lz4_compress_fast_extState+0xeb0>
    15b6:	40 88 30             	mov    %sil,(%rax)
    15b9:	48 83 c0 01          	add    $0x1,%rax
    15bd:	e9 f7 f8 ff ff       	jmp    eb9 <n100_private_lz4_compress_fast_extState+0x7c9>
    15c2:	44 69 41 01 b1 79 37 	imul   $0x9e3779b1,0x1(%rcx),%r8d
    15c9:	9e 
    15ca:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    15cf:	48 8d 41 01          	lea    0x1(%rcx),%rax
    15d3:	49 89 cb             	mov    %rcx,%r11
    15d6:	41 c1 e8 15          	shr    $0x15,%r8d
    15da:	e9 47 f3 ff ff       	jmp    926 <n100_private_lz4_compress_fast_extState+0x236>
    15df:	83 ea 0f             	sub    $0xf,%edx
    15e2:	41 c6 01 f0          	movb   $0xf0,(%r9)
    15e6:	81 fa fe 00 00 00    	cmp    $0xfe,%edx
    15ec:	7e 28                	jle    1616 <n100_private_lz4_compress_fast_extState+0xf26>
    15ee:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    15f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    15fc:	00 00 00 00 
    1600:	81 ea ff 00 00 00    	sub    $0xff,%edx
    1606:	48 83 c0 01          	add    $0x1,%rax
    160a:	c6 40 ff ff          	movb   $0xff,-0x1(%rax)
    160e:	81 fa fe 00 00 00    	cmp    $0xfe,%edx
    1614:	7f ea                	jg     1600 <n100_private_lz4_compress_fast_extState+0xf10>
    1616:	88 10                	mov    %dl,(%rax)
    1618:	48 83 c0 01          	add    $0x1,%rax
    161c:	e9 c0 fc ff ff       	jmp    12e1 <n100_private_lz4_compress_fast_extState+0xbf1>
    1621:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    1628:	bc 1b cf 
    162b:	48 0f af 46 01       	imul   0x1(%rsi),%rax
    1630:	49 89 f3             	mov    %rsi,%r11
    1633:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    1638:	48 83 c6 01          	add    $0x1,%rsi
    163c:	48 c1 e8 36          	shr    $0x36,%rax
    1640:	e9 de f4 ff ff       	jmp    b23 <n100_private_lz4_compress_fast_extState+0x433>
    1645:	48 83 ea 01          	sub    $0x1,%rdx
    1649:	48 83 e9 01          	sub    $0x1,%rcx
    164d:	49 39 d3             	cmp    %rdx,%r11
    1650:	0f 83 33 f6 ff ff    	jae    c89 <n100_private_lz4_compress_fast_extState+0x599>
    1656:	48 39 cb             	cmp    %rcx,%rbx
    1659:	0f 82 1d f6 ff ff    	jb     c7c <n100_private_lz4_compress_fast_extState+0x58c>
    165f:	e9 25 f6 ff ff       	jmp    c89 <n100_private_lz4_compress_fast_extState+0x599>
    1664:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    1669:	4c 89 d6             	mov    %r10,%rsi
    166c:	44 89 cd             	mov    %r9d,%ebp
    166f:	48 89 cb             	mov    %rcx,%rbx
    1672:	4c 29 e6             	sub    %r12,%rsi
    1675:	e9 17 f3 ff ff       	jmp    991 <n100_private_lz4_compress_fast_extState+0x2a1>
    167a:	48 83 e9 01          	sub    $0x1,%rcx
    167e:	48 83 ea 01          	sub    $0x1,%rdx
    1682:	49 39 cb             	cmp    %rcx,%r11
    1685:	0f 83 f4 f7 ff ff    	jae    e7f <n100_private_lz4_compress_fast_extState+0x78f>
    168b:	48 39 d3             	cmp    %rdx,%rbx
    168e:	0f 82 de f7 ff ff    	jb     e72 <n100_private_lz4_compress_fast_extState+0x782>
    1694:	e9 e6 f7 ff ff       	jmp    e7f <n100_private_lz4_compress_fast_extState+0x78f>
    1699:	48 83 ea 01          	sub    $0x1,%rdx
    169d:	48 83 e8 01          	sub    $0x1,%rax
    16a1:	49 39 d3             	cmp    %rdx,%r11
    16a4:	0f 83 d6 f9 ff ff    	jae    1080 <n100_private_lz4_compress_fast_extState+0x990>
    16aa:	48 39 c3             	cmp    %rax,%rbx
    16ad:	0f 82 bf f9 ff ff    	jb     1072 <n100_private_lz4_compress_fast_extState+0x982>
    16b3:	e9 c8 f9 ff ff       	jmp    1080 <n100_private_lz4_compress_fast_extState+0x990>
    16b8:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    16bd:	44 89 d5             	mov    %r10d,%ebp
    16c0:	49 89 f3             	mov    %rsi,%r11
    16c3:	e9 ec f4 ff ff       	jmp    bb4 <n100_private_lz4_compress_fast_extState+0x4c4>
    16c8:	48 83 ee 01          	sub    $0x1,%rsi
    16cc:	48 83 e9 01          	sub    $0x1,%rcx
    16d0:	49 39 f3             	cmp    %rsi,%r11
    16d3:	0f 82 ba fb ff ff    	jb     1293 <n100_private_lz4_compress_fast_extState+0xba3>
    16d9:	e9 c7 fb ff ff       	jmp    12a5 <n100_private_lz4_compress_fast_extState+0xbb5>
    16de:	66 90                	xchg   %ax,%ax
    16e0:	90                   	nop
    16e1:	90                   	nop
    16e2:	90                   	nop
    16e3:	90                   	nop
    16e4:	90                   	nop
    16e5:	90                   	nop
    16e6:	90                   	nop
    16e7:	90                   	nop
    16e8:	90                   	nop
    16e9:	90                   	nop
    16ea:	90                   	nop
    16eb:	90                   	nop
    16ec:	90                   	nop
    16ed:	90                   	nop
    16ee:	90                   	nop
    16ef:	90                   	nop

00000000000016f0 <n100_private_lz4_compress_fast>:
    16f0:	f3 0f 1e fa          	endbr64
    16f4:	e8 00 00 00 00       	call   16f9 <n100_private_lz4_compress_fast+0x9>
    16f9:	48 89 f8             	mov    %rdi,%rax
    16fc:	4c 89 cf             	mov    %r9,%rdi
    16ff:	45 89 c1             	mov    %r8d,%r9d
    1702:	41 89 c8             	mov    %ecx,%r8d
    1705:	89 d1                	mov    %edx,%ecx
    1707:	48 89 f2             	mov    %rsi,%rdx
    170a:	48 89 c6             	mov    %rax,%rsi
    170d:	e9 de ef ff ff       	jmp    6f0 <n100_private_lz4_compress_fast_extState>
    1712:	0f 1f 00             	nopl   (%rax)
    1715:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    171c:	00 00 00 00 
    1720:	90                   	nop
    1721:	90                   	nop
    1722:	90                   	nop
    1723:	90                   	nop
    1724:	90                   	nop
    1725:	90                   	nop
    1726:	90                   	nop
    1727:	90                   	nop
    1728:	90                   	nop
    1729:	90                   	nop
    172a:	90                   	nop
    172b:	90                   	nop
    172c:	90                   	nop
    172d:	90                   	nop
    172e:	90                   	nop
    172f:	90                   	nop

0000000000001730 <n100_private_lz4_compress_default>:
    1730:	f3 0f 1e fa          	endbr64
    1734:	e8 00 00 00 00       	call   1739 <n100_private_lz4_compress_default+0x9>
    1739:	48 89 f8             	mov    %rdi,%rax
    173c:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    1742:	4c 89 c7             	mov    %r8,%rdi
    1745:	41 89 c8             	mov    %ecx,%r8d
    1748:	89 d1                	mov    %edx,%ecx
    174a:	48 89 f2             	mov    %rsi,%rdx
    174d:	48 89 c6             	mov    %rax,%rsi
    1750:	e9 9b ef ff ff       	jmp    6f0 <n100_private_lz4_compress_fast_extState>
    1755:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    175c:	00 00 00 00 
    1760:	90                   	nop
    1761:	90                   	nop
    1762:	90                   	nop
    1763:	90                   	nop
    1764:	90                   	nop
    1765:	90                   	nop
    1766:	90                   	nop
    1767:	90                   	nop
    1768:	90                   	nop
    1769:	90                   	nop
    176a:	90                   	nop
    176b:	90                   	nop
    176c:	90                   	nop
    176d:	90                   	nop
    176e:	90                   	nop
    176f:	90                   	nop

0000000000001770 <n100_private_lz4_compress_destSize>:
    1770:	f3 0f 1e fa          	endbr64
    1774:	e8 00 00 00 00       	call   1779 <n100_private_lz4_compress_destSize+0x9>
    1779:	41 55                	push   %r13
    177b:	41 89 cd             	mov    %ecx,%r13d
    177e:	41 54                	push   %r12
    1780:	49 89 d4             	mov    %rdx,%r12
    1783:	ba 20 10 00 00       	mov    $0x1020,%edx
    1788:	55                   	push   %rbp
    1789:	48 89 f5             	mov    %rsi,%rbp
    178c:	31 f6                	xor    %esi,%esi
    178e:	53                   	push   %rbx
    178f:	48 89 fb             	mov    %rdi,%rbx
    1792:	4c 89 c7             	mov    %r8,%rdi
    1795:	e8 00 00 00 00       	call   179a <n100_private_lz4_compress_destSize+0x2a>
    179a:	be 81 80 80 80       	mov    $0x80808081,%esi
    179f:	31 c9                	xor    %ecx,%ecx
    17a1:	48 89 c7             	mov    %rax,%rdi
    17a4:	41 8b 04 24          	mov    (%r12),%eax
    17a8:	48 89 c2             	mov    %rax,%rdx
    17ab:	48 0f af c6          	imul   %rsi,%rax
    17af:	48 c1 e8 27          	shr    $0x27,%rax
    17b3:	81 fa 00 00 00 7e    	cmp    $0x7e000000,%edx
    17b9:	8d 44 02 10          	lea    0x10(%rdx,%rax,1),%eax
    17bd:	0f 46 c8             	cmovbe %eax,%ecx
    17c0:	41 39 cd             	cmp    %ecx,%r13d
    17c3:	7d 2b                	jge    17f0 <n100_private_lz4_compress_destSize+0x80>
    17c5:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    17cb:	81 fa 0a 00 01 00    	cmp    $0x1000a,%edx
    17d1:	7e 06                	jle    17d9 <n100_private_lz4_compress_destSize+0x69>
    17d3:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    17d9:	45 89 e8             	mov    %r13d,%r8d
    17dc:	4c 89 e1             	mov    %r12,%rcx
    17df:	48 89 ea             	mov    %rbp,%rdx
    17e2:	48 89 de             	mov    %rbx,%rsi
    17e5:	5b                   	pop    %rbx
    17e6:	5d                   	pop    %rbp
    17e7:	41 5c                	pop    %r12
    17e9:	41 5d                	pop    %r13
    17eb:	e9 20 e8 ff ff       	jmp    10 <n100_private_lz4_compress_destSize_generic>
    17f0:	45 89 e8             	mov    %r13d,%r8d
    17f3:	89 d1                	mov    %edx,%ecx
    17f5:	48 89 de             	mov    %rbx,%rsi
    17f8:	48 89 ea             	mov    %rbp,%rdx
    17fb:	5b                   	pop    %rbx
    17fc:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    1802:	5d                   	pop    %rbp
    1803:	41 5c                	pop    %r12
    1805:	41 5d                	pop    %r13
    1807:	e9 e4 ee ff ff       	jmp    6f0 <n100_private_lz4_compress_fast_extState>
    180c:	0f 1f 40 00          	nopl   0x0(%rax)
    1810:	90                   	nop
    1811:	90                   	nop
    1812:	90                   	nop
    1813:	90                   	nop
    1814:	90                   	nop
    1815:	90                   	nop
    1816:	90                   	nop
    1817:	90                   	nop
    1818:	90                   	nop
    1819:	90                   	nop
    181a:	90                   	nop
    181b:	90                   	nop
    181c:	90                   	nop
    181d:	90                   	nop
    181e:	90                   	nop
    181f:	90                   	nop

0000000000001820 <n100_private_lz4_resetStream>:
    1820:	f3 0f 1e fa          	endbr64
    1824:	e8 00 00 00 00       	call   1829 <n100_private_lz4_resetStream+0x9>
    1829:	ba 20 10 00 00       	mov    $0x1020,%edx
    182e:	31 f6                	xor    %esi,%esi
    1830:	e9 00 00 00 00       	jmp    1835 <n100_private_lz4_resetStream+0x15>
    1835:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    183c:	00 00 00 00 
    1840:	90                   	nop
    1841:	90                   	nop
    1842:	90                   	nop
    1843:	90                   	nop
    1844:	90                   	nop
    1845:	90                   	nop
    1846:	90                   	nop
    1847:	90                   	nop
    1848:	90                   	nop
    1849:	90                   	nop
    184a:	90                   	nop
    184b:	90                   	nop
    184c:	90                   	nop
    184d:	90                   	nop
    184e:	90                   	nop
    184f:	90                   	nop

0000000000001850 <n100_private_lz4_loadDict>:
    1850:	f3 0f 1e fa          	endbr64
    1854:	e8 00 00 00 00       	call   1859 <n100_private_lz4_loadDict+0x9>
    1859:	55                   	push   %rbp
    185a:	89 d5                	mov    %edx,%ebp
    185c:	53                   	push   %rbx
    185d:	8b 87 04 10 00 00    	mov    0x1004(%rdi),%eax
    1863:	48 89 f3             	mov    %rsi,%rbx
    1866:	85 c0                	test   %eax,%eax
    1868:	0f 85 9b 00 00 00    	jne    1909 <n100_private_lz4_loadDict+0xb9>
    186e:	8b 97 00 10 00 00    	mov    0x1000(%rdi),%edx
    1874:	81 fa 00 00 00 40    	cmp    $0x40000000,%edx
    187a:	0f 87 89 00 00 00    	ja     1909 <n100_private_lz4_loadDict+0xb9>
    1880:	83 fd 07             	cmp    $0x7,%ebp
    1883:	0f 8e 9a 00 00 00    	jle    1923 <n100_private_lz4_loadDict+0xd3>
    1889:	89 e9                	mov    %ebp,%ecx
    188b:	48 01 d9             	add    %rbx,%rcx
    188e:	81 fd 00 00 01 00    	cmp    $0x10000,%ebp
    1894:	0f 8f a7 00 00 00    	jg     1941 <n100_private_lz4_loadDict+0xf1>
    189a:	81 c2 00 00 01 00    	add    $0x10000,%edx
    18a0:	48 83 e9 08          	sub    $0x8,%rcx
    18a4:	48 89 9f 08 10 00 00 	mov    %rbx,0x1008(%rdi)
    18ab:	8d 04 2a             	lea    (%rdx,%rbp,1),%eax
    18ae:	89 af 18 10 00 00    	mov    %ebp,0x1018(%rdi)
    18b4:	89 87 00 10 00 00    	mov    %eax,0x1000(%rdi)
    18ba:	48 39 d9             	cmp    %rbx,%rcx
    18bd:	72 41                	jb     1900 <n100_private_lz4_loadDict+0xb0>
    18bf:	48 be 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rsi
    18c6:	bc 1b cf 
    18c9:	90                   	nop
    18ca:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    18d1:	00 00 00 00 
    18d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    18dc:	00 00 00 00 
    18e0:	48 8b 03             	mov    (%rbx),%rax
    18e3:	48 83 c3 03          	add    $0x3,%rbx
    18e7:	48 0f af c6          	imul   %rsi,%rax
    18eb:	48 c1 e8 36          	shr    $0x36,%rax
    18ef:	89 14 87             	mov    %edx,(%rdi,%rax,4)
    18f2:	83 c2 03             	add    $0x3,%edx
    18f5:	48 39 d9             	cmp    %rbx,%rcx
    18f8:	73 e6                	jae    18e0 <n100_private_lz4_loadDict+0x90>
    18fa:	8b af 18 10 00 00    	mov    0x1018(%rdi),%ebp
    1900:	89 e8                	mov    %ebp,%eax
    1902:	5b                   	pop    %rbx
    1903:	5d                   	pop    %rbp
    1904:	e9 00 00 00 00       	jmp    1909 <n100_private_lz4_loadDict+0xb9>
    1909:	ba 20 10 00 00       	mov    $0x1020,%edx
    190e:	31 f6                	xor    %esi,%esi
    1910:	e8 00 00 00 00       	call   1915 <n100_private_lz4_loadDict+0xc5>
    1915:	31 d2                	xor    %edx,%edx
    1917:	48 89 c7             	mov    %rax,%rdi
    191a:	83 fd 07             	cmp    $0x7,%ebp
    191d:	0f 8f 66 ff ff ff    	jg     1889 <n100_private_lz4_loadDict+0x39>
    1923:	48 c7 87 08 10 00 00 	movq   $0x0,0x1008(%rdi)
    192a:	00 00 00 00 
    192e:	31 c0                	xor    %eax,%eax
    1930:	c7 87 18 10 00 00 00 	movl   $0x0,0x1018(%rdi)
    1937:	00 00 00 
    193a:	5b                   	pop    %rbx
    193b:	5d                   	pop    %rbp
    193c:	e9 00 00 00 00       	jmp    1941 <n100_private_lz4_loadDict+0xf1>
    1941:	48 8d 99 00 00 ff ff 	lea    -0x10000(%rcx),%rbx
    1948:	bd 00 00 01 00       	mov    $0x10000,%ebp
    194d:	e9 48 ff ff ff       	jmp    189a <n100_private_lz4_loadDict+0x4a>
    1952:	0f 1f 00             	nopl   (%rax)
    1955:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    195c:	00 00 00 00 
    1960:	90                   	nop
    1961:	90                   	nop
    1962:	90                   	nop
    1963:	90                   	nop
    1964:	90                   	nop
    1965:	90                   	nop
    1966:	90                   	nop
    1967:	90                   	nop
    1968:	90                   	nop
    1969:	90                   	nop
    196a:	90                   	nop
    196b:	90                   	nop
    196c:	90                   	nop
    196d:	90                   	nop
    196e:	90                   	nop
    196f:	90                   	nop

0000000000001970 <n100_private_lz4_saveDict>:
    1970:	f3 0f 1e fa          	endbr64
    1974:	e8 00 00 00 00       	call   1979 <n100_private_lz4_saveDict+0x9>
    1979:	48 83 ec 18          	sub    $0x18,%rsp
    197d:	48 89 f1             	mov    %rsi,%rcx
    1980:	48 89 1c 24          	mov    %rbx,(%rsp)
    1984:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    1989:	48 89 fd             	mov    %rdi,%rbp
    198c:	8b b7 18 10 00 00    	mov    0x1018(%rdi),%esi
    1992:	bf 00 00 01 00       	mov    $0x10000,%edi
    1997:	39 fa                	cmp    %edi,%edx
    1999:	0f 46 fa             	cmovbe %edx,%edi
    199c:	39 fe                	cmp    %edi,%esi
    199e:	89 fb                	mov    %edi,%ebx
    19a0:	48 89 cf             	mov    %rcx,%rdi
    19a3:	0f 42 de             	cmovb  %esi,%ebx
    19a6:	89 da                	mov    %ebx,%edx
    19a8:	48 29 d6             	sub    %rdx,%rsi
    19ab:	48 03 b5 08 10 00 00 	add    0x1008(%rbp),%rsi
    19b2:	e8 00 00 00 00       	call   19b7 <n100_private_lz4_saveDict+0x47>
    19b7:	89 9d 18 10 00 00    	mov    %ebx,0x1018(%rbp)
    19bd:	48 89 85 08 10 00 00 	mov    %rax,0x1008(%rbp)
    19c4:	89 d8                	mov    %ebx,%eax
    19c6:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    19cb:	48 8b 1c 24          	mov    (%rsp),%rbx
    19cf:	48 83 c4 18          	add    $0x18,%rsp
    19d3:	e9 00 00 00 00       	jmp    19d8 <n100_private_lz4_saveDict+0x68>
    19d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    19df:	00 
    19e0:	90                   	nop
    19e1:	90                   	nop
    19e2:	90                   	nop
    19e3:	90                   	nop
    19e4:	90                   	nop
    19e5:	90                   	nop
    19e6:	90                   	nop
    19e7:	90                   	nop
    19e8:	90                   	nop
    19e9:	90                   	nop
    19ea:	90                   	nop
    19eb:	90                   	nop
    19ec:	90                   	nop
    19ed:	90                   	nop
    19ee:	90                   	nop
    19ef:	90                   	nop

00000000000019f0 <n100_private_lz4_compress_fast_continue>:
    19f0:	f3 0f 1e fa          	endbr64
    19f4:	e8 00 00 00 00       	call   19f9 <n100_private_lz4_compress_fast_continue+0x9>
    19f9:	49 89 f2             	mov    %rsi,%r10
    19fc:	44 89 c6             	mov    %r8d,%esi
    19ff:	44 8b 87 04 10 00 00 	mov    0x1004(%rdi),%r8d
    1a06:	31 c0                	xor    %eax,%eax
    1a08:	45 85 c0             	test   %r8d,%r8d
    1a0b:	0f 85 a5 04 00 00    	jne    1eb6 <n100_private_lz4_compress_fast_continue+0x4c6>
    1a11:	41 57                	push   %r15
    1a13:	45 89 cf             	mov    %r9d,%r15d
    1a16:	41 56                	push   %r14
    1a18:	41 55                	push   %r13
    1a1a:	41 54                	push   %r12
    1a1c:	55                   	push   %rbp
    1a1d:	53                   	push   %rbx
    1a1e:	48 83 ec 70          	sub    $0x70,%rsp
    1a22:	4c 8b 9f 08 10 00 00 	mov    0x1008(%rdi),%r11
    1a29:	44 8b af 00 10 00 00 	mov    0x1000(%rdi),%r13d
    1a30:	48 89 14 24          	mov    %rdx,(%rsp)
    1a34:	8b 97 18 10 00 00    	mov    0x1018(%rdi),%edx
    1a3a:	89 74 24 10          	mov    %esi,0x10(%rsp)
    1a3e:	4c 89 d6             	mov    %r10,%rsi
    1a41:	49 8d 04 13          	lea    (%r11,%rdx,1),%rax
    1a45:	89 4c 24 68          	mov    %ecx,0x68(%rsp)
    1a49:	49 89 d6             	mov    %rdx,%r14
    1a4c:	48 89 f9             	mov    %rdi,%rcx
    1a4f:	4c 39 d0             	cmp    %r10,%rax
    1a52:	48 0f 46 f0          	cmovbe %rax,%rsi
    1a56:	85 d2                	test   %edx,%edx
    1a58:	49 0f 44 f2          	cmove  %r10,%rsi
    1a5c:	41 81 fd 00 00 00 80 	cmp    $0x80000000,%r13d
    1a63:	77 0c                	ja     1a71 <n100_private_lz4_compress_fast_continue+0x81>
    1a65:	44 89 ef             	mov    %r13d,%edi
    1a68:	48 39 fe             	cmp    %rdi,%rsi
    1a6b:	0f 83 82 00 00 00    	jae    1af3 <n100_private_lz4_compress_fast_continue+0x103>
    1a71:	41 81 ed 00 00 01 00 	sub    $0x10000,%r13d
    1a78:	31 db                	xor    %ebx,%ebx
    1a7a:	41 89 dc             	mov    %ebx,%r12d
    1a7d:	81 fb ff 03 00 00    	cmp    $0x3ff,%ebx
    1a83:	0f 87 03 0b 00 00    	ja     258c <n100_private_lz4_compress_fast_continue+0xb9c>
    1a89:	8b 2c 99             	mov    (%rcx,%rbx,4),%ebp
    1a8c:	44 39 ed             	cmp    %r13d,%ebp
    1a8f:	0f 83 0d 03 00 00    	jae    1da2 <n100_private_lz4_compress_fast_continue+0x3b2>
    1a95:	41 81 fc ff 03 00 00 	cmp    $0x3ff,%r12d
    1a9c:	0f 87 4a 0c 00 00    	ja     26ec <n100_private_lz4_compress_fast_continue+0xcfc>
    1aa2:	c7 04 99 00 00 00 00 	movl   $0x0,(%rcx,%rbx,4)
    1aa9:	48 83 c3 01          	add    $0x1,%rbx
    1aad:	48 81 fb 00 04 00 00 	cmp    $0x400,%rbx
    1ab4:	75 c4                	jne    1a7a <n100_private_lz4_compress_fast_continue+0x8a>
    1ab6:	c7 81 00 10 00 00 00 	movl   $0x10000,0x1000(%rcx)
    1abd:	00 01 00 
    1ac0:	41 81 fe 00 00 01 00 	cmp    $0x10000,%r14d
    1ac7:	76 1d                	jbe    1ae6 <n100_private_lz4_compress_fast_continue+0xf6>
    1ac9:	c7 81 18 10 00 00 00 	movl   $0x10000,0x1018(%rcx)
    1ad0:	00 01 00 
    1ad3:	4d 8d 9c 13 00 00 ff 	lea    -0x10000(%r11,%rdx,1),%r11
    1ada:	ff 
    1adb:	41 be 00 00 01 00    	mov    $0x10000,%r14d
    1ae1:	ba 00 00 01 00       	mov    $0x10000,%edx
    1ae6:	4c 89 99 08 10 00 00 	mov    %r11,0x1008(%rcx)
    1aed:	41 bd 00 00 01 00    	mov    $0x10000,%r13d
    1af3:	45 85 ff             	test   %r15d,%r15d
    1af6:	be 01 00 00 00       	mov    $0x1,%esi
    1afb:	41 0f 4f f7          	cmovg  %r15d,%esi
    1aff:	89 74 24 20          	mov    %esi,0x20(%rsp)
    1b03:	48 63 74 24 68       	movslq 0x68(%rsp),%rsi
    1b08:	4d 8d 3c 32          	lea    (%r10,%rsi,1),%r15
    1b0c:	4d 39 fb             	cmp    %r15,%r11
    1b0f:	73 09                	jae    1b1a <n100_private_lz4_compress_fast_continue+0x12a>
    1b11:	49 39 c7             	cmp    %rax,%r15
    1b14:	0f 82 a1 03 00 00    	jb     1ebb <n100_private_lz4_compress_fast_continue+0x4cb>
    1b1a:	49 8d 7f f4          	lea    -0xc(%r15),%rdi
    1b1e:	48 63 74 24 10       	movslq 0x10(%rsp),%rsi
    1b23:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    1b28:	49 8d 7f fb          	lea    -0x5(%r15),%rdi
    1b2c:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    1b31:	48 8b 3c 24          	mov    (%rsp),%rdi
    1b35:	48 01 f7             	add    %rsi,%rdi
    1b38:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    1b3d:	4c 39 d0             	cmp    %r10,%rax
    1b40:	0f 84 ce 03 00 00    	je     1f14 <n100_private_lz4_compress_fast_continue+0x524>
    1b46:	49 8d 04 13          	lea    (%r11,%rdx,1),%rax
    1b4a:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    1b4f:	4c 29 d0             	sub    %r10,%rax
    1b52:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1b57:	31 c0                	xor    %eax,%eax
    1b59:	41 81 fe ff ff 00 00 	cmp    $0xffff,%r14d
    1b60:	0f 87 31 01 00 00    	ja     1c97 <n100_private_lz4_compress_fast_continue+0x2a7>
    1b66:	45 39 ee             	cmp    %r13d,%r14d
    1b69:	0f 83 28 01 00 00    	jae    1c97 <n100_private_lz4_compress_fast_continue+0x2a7>
    1b6f:	8b 7c 24 68          	mov    0x68(%rsp),%edi
    1b73:	81 ff 00 00 00 7e    	cmp    $0x7e000000,%edi
    1b79:	0f 87 09 03 00 00    	ja     1e88 <n100_private_lz4_compress_fast_continue+0x498>
    1b7f:	83 ff 0c             	cmp    $0xc,%edi
    1b82:	0f 8e e2 09 00 00    	jle    256a <n100_private_lz4_compress_fast_continue+0xb7a>
    1b88:	4c 89 d0             	mov    %r10,%rax
    1b8b:	4d 89 d6             	mov    %r10,%r14
    1b8e:	8b 74 24 20          	mov    0x20(%rsp),%esi
    1b92:	4c 89 5c 24 40       	mov    %r11,0x40(%rsp)
    1b97:	48 29 d0             	sub    %rdx,%rax
    1b9a:	49 8b 12             	mov    (%r10),%rdx
    1b9d:	4d 89 d4             	mov    %r10,%r12
    1ba0:	4d 89 fb             	mov    %r15,%r11
    1ba3:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    1ba8:	44 89 e8             	mov    %r13d,%eax
    1bab:	c1 e6 06             	shl    $0x6,%esi
    1bae:	49 29 c6             	sub    %rax,%r14
    1bb1:	89 74 24 6c          	mov    %esi,0x6c(%rsp)
    1bb5:	48 8b 34 24          	mov    (%rsp),%rsi
    1bb9:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    1bc0:	bc 1b cf 
    1bc3:	48 0f af d0          	imul   %rax,%rdx
    1bc7:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
    1bcc:	48 c1 ea 36          	shr    $0x36,%rdx
    1bd0:	44 89 2c 91          	mov    %r13d,(%rcx,%rdx,4)
    1bd4:	49 0f af 42 01       	imul   0x1(%r10),%rax
    1bd9:	4d 8d 6a 01          	lea    0x1(%r10),%r13
    1bdd:	48 c1 e8 36          	shr    $0x36,%rax
    1be1:	89 c2                	mov    %eax,%edx
    1be3:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    1be7:	48 39 7c 24 08       	cmp    %rdi,0x8(%rsp)
    1bec:	0f 82 5c 0e 00 00    	jb     2a4e <n100_private_lz4_compress_fast_continue+0x105e>
    1bf2:	8b 74 24 20          	mov    0x20(%rsp),%esi
    1bf6:	8b 44 24 6c          	mov    0x6c(%rsp),%eax
    1bfa:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
    1bff:	49 bf 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r15
    1c06:	bc 1b cf 
    1c09:	4c 89 5c 24 50       	mov    %r11,0x50(%rsp)
    1c0e:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
    1c13:	81 e6 ff ff ff 03    	and    $0x3ffffff,%esi
    1c19:	44 8d 48 01          	lea    0x1(%rax),%r9d
    1c1d:	eb 60                	jmp    1c7f <n100_private_lz4_compress_fast_continue+0x28f>
    1c1f:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    1c24:	48 8b 6c 24 40       	mov    0x40(%rsp),%rbp
    1c29:	4d 89 eb             	mov    %r13,%r11
    1c2c:	48 8b 17             	mov    (%rdi),%rdx
    1c2f:	4d 29 f3             	sub    %r14,%r11
    1c32:	45 89 18             	mov    %r11d,(%r8)
    1c35:	4c 39 e0             	cmp    %r12,%rax
    1c38:	72 1d                	jb     1c57 <n100_private_lz4_compress_fast_continue+0x267>
    1c3a:	4c 8d 80 ff ff 00 00 	lea    0xffff(%rax),%r8
    1c41:	4d 39 e8             	cmp    %r13,%r8
    1c44:	72 11                	jb     1c57 <n100_private_lz4_compress_fast_continue+0x267>
    1c46:	4c 8d 04 18          	lea    (%rax,%rbx,1),%r8
    1c4a:	45 8b 5d 00          	mov    0x0(%r13),%r11d
    1c4e:	45 39 18             	cmp    %r11d,(%r8)
    1c51:	0f 84 ff 0d 00 00    	je     2a56 <n100_private_lz4_compress_fast_continue+0x1066>
    1c57:	49 0f af d7          	imul   %r15,%rdx
    1c5b:	89 f0                	mov    %esi,%eax
    1c5d:	44 89 ce             	mov    %r9d,%esi
    1c60:	49 89 fd             	mov    %rdi,%r13
    1c63:	48 01 f8             	add    %rdi,%rax
    1c66:	c1 ee 06             	shr    $0x6,%esi
    1c69:	48 c1 ea 36          	shr    $0x36,%rdx
    1c6d:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
    1c72:	0f 82 e0 05 00 00    	jb     2258 <n100_private_lz4_compress_fast_continue+0x868>
    1c78:	41 83 c1 01          	add    $0x1,%r9d
    1c7c:	48 89 c7             	mov    %rax,%rdi
    1c7f:	89 d2                	mov    %edx,%edx
    1c81:	4c 8d 04 91          	lea    (%rcx,%rdx,4),%r8
    1c85:	41 8b 00             	mov    (%r8),%eax
    1c88:	4c 01 f0             	add    %r14,%rax
    1c8b:	4c 39 d0             	cmp    %r10,%rax
    1c8e:	72 8f                	jb     1c1f <n100_private_lz4_compress_fast_continue+0x22f>
    1c90:	4c 89 d5             	mov    %r10,%rbp
    1c93:	31 db                	xor    %ebx,%ebx
    1c95:	eb 92                	jmp    1c29 <n100_private_lz4_compress_fast_continue+0x239>
    1c97:	8b 74 24 68          	mov    0x68(%rsp),%esi
    1c9b:	81 fe 00 00 00 7e    	cmp    $0x7e000000,%esi
    1ca1:	0f 87 e1 01 00 00    	ja     1e88 <n100_private_lz4_compress_fast_continue+0x498>
    1ca7:	83 fe 0c             	cmp    $0xc,%esi
    1caa:	0f 8e 2b 01 00 00    	jle    1ddb <n100_private_lz4_compress_fast_continue+0x3eb>
    1cb0:	49 8b 12             	mov    (%r10),%rdx
    1cb3:	44 89 e8             	mov    %r13d,%eax
    1cb6:	4d 89 d6             	mov    %r10,%r14
    1cb9:	8b 74 24 20          	mov    0x20(%rsp),%esi
    1cbd:	49 29 c6             	sub    %rax,%r14
    1cc0:	4c 89 7c 24 50       	mov    %r15,0x50(%rsp)
    1cc5:	49 8d 7a 01          	lea    0x1(%r10),%rdi
    1cc9:	4d 89 d1             	mov    %r10,%r9
    1ccc:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    1cd3:	bc 1b cf 
    1cd6:	c1 e6 06             	shl    $0x6,%esi
    1cd9:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
    1cde:	48 0f af d0          	imul   %rax,%rdx
    1ce2:	89 74 24 58          	mov    %esi,0x58(%rsp)
    1ce6:	48 8b 34 24          	mov    (%rsp),%rsi
    1cea:	48 89 74 24 40       	mov    %rsi,0x40(%rsp)
    1cef:	48 c1 ea 36          	shr    $0x36,%rdx
    1cf3:	44 89 2c 91          	mov    %r13d,(%rcx,%rdx,4)
    1cf7:	49 0f af 42 01       	imul   0x1(%r10),%rax
    1cfc:	48 c1 e8 36          	shr    $0x36,%rax
    1d00:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
    1d05:	4c 8d 47 01          	lea    0x1(%rdi),%r8
    1d09:	4d 39 c4             	cmp    %r8,%r12
    1d0c:	0f 82 97 09 00 00    	jb     26a9 <n100_private_lz4_compress_fast_continue+0xcb9>
    1d12:	8b 74 24 20          	mov    0x20(%rsp),%esi
    1d16:	8b 54 24 58          	mov    0x58(%rsp),%edx
    1d1a:	4c 89 4c 24 60       	mov    %r9,0x60(%rsp)
    1d1f:	49 bf 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r15
    1d26:	bc 1b cf 
    1d29:	81 e6 ff ff ff 03    	and    $0x3ffffff,%esi
    1d2f:	8d 5a 01             	lea    0x1(%rdx),%ebx
    1d32:	eb 56                	jmp    1d8a <n100_private_lz4_compress_fast_continue+0x39a>
    1d34:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
    1d39:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    1d3e:	49 89 fb             	mov    %rdi,%r11
    1d41:	49 8b 00             	mov    (%r8),%rax
    1d44:	4d 29 f3             	sub    %r14,%r11
    1d47:	45 89 19             	mov    %r11d,(%r9)
    1d4a:	4c 8d 8a ff ff 00 00 	lea    0xffff(%rdx),%r9
    1d51:	49 39 f9             	cmp    %rdi,%r9
    1d54:	72 10                	jb     1d66 <n100_private_lz4_compress_fast_continue+0x376>
    1d56:	4c 8d 1c 2a          	lea    (%rdx,%rbp,1),%r11
    1d5a:	44 8b 0f             	mov    (%rdi),%r9d
    1d5d:	45 39 0b             	cmp    %r9d,(%r11)
    1d60:	0f 84 8b 05 00 00    	je     22f1 <n100_private_lz4_compress_fast_continue+0x901>
    1d66:	49 0f af c7          	imul   %r15,%rax
    1d6a:	89 f2                	mov    %esi,%edx
    1d6c:	89 de                	mov    %ebx,%esi
    1d6e:	4c 89 c7             	mov    %r8,%rdi
    1d71:	4c 01 c2             	add    %r8,%rdx
    1d74:	c1 ee 06             	shr    $0x6,%esi
    1d77:	48 c1 e8 36          	shr    $0x36,%rax
    1d7b:	49 39 d4             	cmp    %rdx,%r12
    1d7e:	0f 82 78 01 00 00    	jb     1efc <n100_private_lz4_compress_fast_continue+0x50c>
    1d84:	83 c3 01             	add    $0x1,%ebx
    1d87:	49 89 d0             	mov    %rdx,%r8
    1d8a:	89 c0                	mov    %eax,%eax
    1d8c:	4c 8d 0c 81          	lea    (%rcx,%rax,4),%r9
    1d90:	41 8b 11             	mov    (%r9),%edx
    1d93:	4c 01 f2             	add    %r14,%rdx
    1d96:	4c 39 d2             	cmp    %r10,%rdx
    1d99:	72 99                	jb     1d34 <n100_private_lz4_compress_fast_continue+0x344>
    1d9b:	4d 89 d5             	mov    %r10,%r13
    1d9e:	31 ed                	xor    %ebp,%ebp
    1da0:	eb 9c                	jmp    1d3e <n100_private_lz4_compress_fast_continue+0x34e>
    1da2:	45 89 e1             	mov    %r12d,%r9d
    1da5:	41 81 fc ff 03 00 00 	cmp    $0x3ff,%r12d
    1dac:	0f 87 f2 0b 00 00    	ja     29a4 <n100_private_lz4_compress_fast_continue+0xfb4>
    1db2:	49 81 f9 00 04 00 00 	cmp    $0x400,%r9
    1db9:	0f 83 3f 0c 00 00    	jae    29fe <n100_private_lz4_compress_fast_continue+0x100e>
    1dbf:	44 29 ed             	sub    %r13d,%ebp
    1dc2:	89 2c 99             	mov    %ebp,(%rcx,%rbx,4)
    1dc5:	48 83 c3 01          	add    $0x1,%rbx
    1dc9:	48 81 fb 00 04 00 00 	cmp    $0x400,%rbx
    1dd0:	0f 85 a4 fc ff ff    	jne    1a7a <n100_private_lz4_compress_fast_continue+0x8a>
    1dd6:	e9 db fc ff ff       	jmp    1ab6 <n100_private_lz4_compress_fast_continue+0xc6>
    1ddb:	48 8b 04 24          	mov    (%rsp),%rax
    1ddf:	4d 89 d1             	mov    %r10,%r9
    1de2:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    1de7:	31 c0                	xor    %eax,%eax
    1de9:	48 bf 81 80 80 80 80 	movabs $0x8080808080808081,%rdi
    1df0:	80 80 80 
    1df3:	4d 29 cf             	sub    %r9,%r15
    1df6:	49 8d 74 07 01       	lea    0x1(%r15,%rax,1),%rsi
    1dfb:	49 8d 87 f0 00 00 00 	lea    0xf0(%r15),%rax
    1e02:	48 f7 e7             	mul    %rdi
    1e05:	8b 44 24 10          	mov    0x10(%rsp),%eax
    1e09:	48 c1 ea 07          	shr    $0x7,%rdx
    1e0d:	48 01 d6             	add    %rdx,%rsi
    1e10:	48 39 f0             	cmp    %rsi,%rax
    1e13:	0f 82 d8 00 00 00    	jb     1ef1 <n100_private_lz4_compress_fast_continue+0x501>
    1e19:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
    1e1e:	48 8d 7e 01          	lea    0x1(%rsi),%rdi
    1e22:	49 83 ff 0e          	cmp    $0xe,%r15
    1e26:	0f 86 14 04 00 00    	jbe    2240 <n100_private_lz4_compress_fast_continue+0x850>
    1e2c:	49 8d 47 f1          	lea    -0xf(%r15),%rax
    1e30:	c6 06 f0             	movb   $0xf0,(%rsi)
    1e33:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    1e39:	76 1b                	jbe    1e56 <n100_private_lz4_compress_fast_continue+0x466>
    1e3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1e40:	48 2d ff 00 00 00    	sub    $0xff,%rax
    1e46:	48 83 c7 01          	add    $0x1,%rdi
    1e4a:	c6 47 ff ff          	movb   $0xff,-0x1(%rdi)
    1e4e:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    1e54:	77 ea                	ja     1e40 <n100_private_lz4_compress_fast_continue+0x450>
    1e56:	88 07                	mov    %al,(%rdi)
    1e58:	48 83 c7 01          	add    $0x1,%rdi
    1e5c:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    1e61:	4c 89 fa             	mov    %r15,%rdx
    1e64:	4c 89 ce             	mov    %r9,%rsi
    1e67:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
    1e6c:	e8 00 00 00 00       	call   1e71 <n100_private_lz4_compress_fast_continue+0x481>
    1e71:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    1e76:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
    1e7b:	4c 01 f8             	add    %r15,%rax
    1e7e:	2b 04 24             	sub    (%rsp),%eax
    1e81:	44 8b a9 00 10 00 00 	mov    0x1000(%rcx),%r13d
    1e88:	8b 7c 24 68          	mov    0x68(%rsp),%edi
    1e8c:	4c 89 91 08 10 00 00 	mov    %r10,0x1008(%rcx)
    1e93:	41 01 fd             	add    %edi,%r13d
    1e96:	89 b9 18 10 00 00    	mov    %edi,0x1018(%rcx)
    1e9c:	44 89 a9 00 10 00 00 	mov    %r13d,0x1000(%rcx)
    1ea3:	48 83 c4 70          	add    $0x70,%rsp
    1ea7:	5b                   	pop    %rbx
    1ea8:	5d                   	pop    %rbp
    1ea9:	41 5c                	pop    %r12
    1eab:	41 5d                	pop    %r13
    1ead:	41 5e                	pop    %r14
    1eaf:	41 5f                	pop    %r15
    1eb1:	e9 00 00 00 00       	jmp    1eb6 <n100_private_lz4_compress_fast_continue+0x4c6>
    1eb6:	e9 00 00 00 00       	jmp    1ebb <n100_private_lz4_compress_fast_continue+0x4cb>
    1ebb:	48 89 c6             	mov    %rax,%rsi
    1ebe:	4c 29 fe             	sub    %r15,%rsi
    1ec1:	81 fe 00 00 01 00    	cmp    $0x10000,%esi
    1ec7:	0f 87 59 03 00 00    	ja     2226 <n100_private_lz4_compress_fast_continue+0x836>
    1ecd:	83 fe 03             	cmp    $0x3,%esi
    1ed0:	0f 87 62 10 00 00    	ja     2f38 <n100_private_lz4_compress_fast_continue+0x1548>
    1ed6:	49 89 c3             	mov    %rax,%r11
    1ed9:	31 d2                	xor    %edx,%edx
    1edb:	44 89 81 18 10 00 00 	mov    %r8d,0x1018(%rcx)
    1ee2:	45 89 c6             	mov    %r8d,%r14d
    1ee5:	4c 89 99 08 10 00 00 	mov    %r11,0x1008(%rcx)
    1eec:	e9 29 fc ff ff       	jmp    1b1a <n100_private_lz4_compress_fast_continue+0x12a>
    1ef1:	44 8b a9 00 10 00 00 	mov    0x1000(%rcx),%r13d
    1ef8:	31 c0                	xor    %eax,%eax
    1efa:	eb 8c                	jmp    1e88 <n100_private_lz4_compress_fast_continue+0x498>
    1efc:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    1f01:	4c 8b 4c 24 60       	mov    0x60(%rsp),%r9
    1f06:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    1f0b:	48 2b 04 24          	sub    (%rsp),%rax
    1f0f:	e9 d5 fe ff ff       	jmp    1de9 <n100_private_lz4_compress_fast_continue+0x3f9>
    1f14:	4c 89 d0             	mov    %r10,%rax
    1f17:	8b 7c 24 68          	mov    0x68(%rsp),%edi
    1f1b:	48 29 d0             	sub    %rdx,%rax
    1f1e:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1f23:	31 c0                	xor    %eax,%eax
    1f25:	41 81 fe ff ff 00 00 	cmp    $0xffff,%r14d
    1f2c:	0f 87 a6 01 00 00    	ja     20d8 <n100_private_lz4_compress_fast_continue+0x6e8>
    1f32:	45 39 ee             	cmp    %r13d,%r14d
    1f35:	0f 83 9d 01 00 00    	jae    20d8 <n100_private_lz4_compress_fast_continue+0x6e8>
    1f3b:	81 ff 00 00 00 7e    	cmp    $0x7e000000,%edi
    1f41:	0f 87 66 01 00 00    	ja     20ad <n100_private_lz4_compress_fast_continue+0x6bd>
    1f47:	83 ff 0c             	cmp    $0xc,%edi
    1f4a:	0f 8e 6a 0d 00 00    	jle    2cba <n100_private_lz4_compress_fast_continue+0x12ca>
    1f50:	44 89 e8             	mov    %r13d,%eax
    1f53:	49 8b 12             	mov    (%r10),%rdx
    1f56:	4d 89 d6             	mov    %r10,%r14
    1f59:	4c 8b 24 24          	mov    (%rsp),%r12
    1f5d:	49 29 c6             	sub    %rax,%r14
    1f60:	49 8d 6a 01          	lea    0x1(%r10),%rbp
    1f64:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    1f6b:	bc 1b cf 
    1f6e:	48 0f af d0          	imul   %rax,%rdx
    1f72:	48 c1 ea 36          	shr    $0x36,%rdx
    1f76:	44 89 2c 91          	mov    %r13d,(%rcx,%rdx,4)
    1f7a:	49 0f af 42 01       	imul   0x1(%r10),%rax
    1f7f:	44 8b 6c 24 20       	mov    0x20(%rsp),%r13d
    1f84:	48 c1 e8 36          	shr    $0x36,%rax
    1f88:	41 c1 e5 06          	shl    $0x6,%r13d
    1f8c:	48 89 c7             	mov    %rax,%rdi
    1f8f:	4c 8d 45 01          	lea    0x1(%rbp),%r8
    1f93:	4c 39 44 24 08       	cmp    %r8,0x8(%rsp)
    1f98:	72 74                	jb     200e <n100_private_lz4_compress_fast_continue+0x61e>
    1f9a:	8b 74 24 20          	mov    0x20(%rsp),%esi
    1f9e:	45 8d 4d 01          	lea    0x1(%r13),%r9d
    1fa2:	48 bb 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rbx
    1fa9:	bc 1b cf 
    1fac:	81 e6 ff ff ff 03    	and    $0x3ffffff,%esi
    1fb2:	eb 07                	jmp    1fbb <n100_private_lz4_compress_fast_continue+0x5cb>
    1fb4:	41 83 c1 01          	add    $0x1,%r9d
    1fb8:	49 89 c0             	mov    %rax,%r8
    1fbb:	89 ff                	mov    %edi,%edi
    1fbd:	49 89 eb             	mov    %rbp,%r11
    1fc0:	49 8b 10             	mov    (%r8),%rdx
    1fc3:	8b 04 b9             	mov    (%rcx,%rdi,4),%eax
    1fc6:	4d 29 f3             	sub    %r14,%r11
    1fc9:	44 89 1c b9          	mov    %r11d,(%rcx,%rdi,4)
    1fcd:	4c 01 f0             	add    %r14,%rax
    1fd0:	48 3b 44 24 18       	cmp    0x18(%rsp),%rax
    1fd5:	72 17                	jb     1fee <n100_private_lz4_compress_fast_continue+0x5fe>
    1fd7:	48 8d b8 ff ff 00 00 	lea    0xffff(%rax),%rdi
    1fde:	48 39 ef             	cmp    %rbp,%rdi
    1fe1:	72 0b                	jb     1fee <n100_private_lz4_compress_fast_continue+0x5fe>
    1fe3:	8b 7d 00             	mov    0x0(%rbp),%edi
    1fe6:	39 38                	cmp    %edi,(%rax)
    1fe8:	0f 84 cc 0f 00 00    	je     2fba <n100_private_lz4_compress_fast_continue+0x15ca>
    1fee:	48 0f af d3          	imul   %rbx,%rdx
    1ff2:	89 f0                	mov    %esi,%eax
    1ff4:	44 89 ce             	mov    %r9d,%esi
    1ff7:	4c 89 c5             	mov    %r8,%rbp
    1ffa:	4c 01 c0             	add    %r8,%rax
    1ffd:	c1 ee 06             	shr    $0x6,%esi
    2000:	48 c1 ea 36          	shr    $0x36,%rdx
    2004:	48 89 d7             	mov    %rdx,%rdi
    2007:	48 39 44 24 08       	cmp    %rax,0x8(%rsp)
    200c:	73 a6                	jae    1fb4 <n100_private_lz4_compress_fast_continue+0x5c4>
    200e:	4c 89 e6             	mov    %r12,%rsi
    2011:	48 2b 34 24          	sub    (%rsp),%rsi
    2015:	48 bf 81 80 80 80 80 	movabs $0x8080808080808081,%rdi
    201c:	80 80 80 
    201f:	4d 29 d7             	sub    %r10,%r15
    2022:	49 8d 87 f0 00 00 00 	lea    0xf0(%r15),%rax
    2029:	48 f7 e7             	mul    %rdi
    202c:	48 89 d0             	mov    %rdx,%rax
    202f:	49 8d 54 37 01       	lea    0x1(%r15,%rsi,1),%rdx
    2034:	48 c1 e8 07          	shr    $0x7,%rax
    2038:	48 01 d0             	add    %rdx,%rax
    203b:	8b 54 24 10          	mov    0x10(%rsp),%edx
    203f:	48 39 c2             	cmp    %rax,%rdx
    2042:	0f 82 0d 05 00 00    	jb     2555 <n100_private_lz4_compress_fast_continue+0xb65>
    2048:	49 8d 7c 24 01       	lea    0x1(%r12),%rdi
    204d:	49 83 ff 0e          	cmp    $0xe,%r15
    2051:	0f 86 26 05 00 00    	jbe    257d <n100_private_lz4_compress_fast_continue+0xb8d>
    2057:	49 8d 47 f1          	lea    -0xf(%r15),%rax
    205b:	41 c6 04 24 f0       	movb   $0xf0,(%r12)
    2060:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    2066:	76 16                	jbe    207e <n100_private_lz4_compress_fast_continue+0x68e>
    2068:	48 2d ff 00 00 00    	sub    $0xff,%rax
    206e:	48 83 c7 01          	add    $0x1,%rdi
    2072:	c6 47 ff ff          	movb   $0xff,-0x1(%rdi)
    2076:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    207c:	77 ea                	ja     2068 <n100_private_lz4_compress_fast_continue+0x678>
    207e:	88 07                	mov    %al,(%rdi)
    2080:	48 83 c7 01          	add    $0x1,%rdi
    2084:	4c 89 fa             	mov    %r15,%rdx
    2087:	4c 89 d6             	mov    %r10,%rsi
    208a:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
    208f:	e8 00 00 00 00       	call   2094 <n100_private_lz4_compress_fast_continue+0x6a4>
    2094:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    2099:	4c 01 f8             	add    %r15,%rax
    209c:	2b 04 24             	sub    (%rsp),%eax
    209f:	44 8b b1 18 10 00 00 	mov    0x1018(%rcx),%r14d
    20a6:	44 8b a9 00 10 00 00 	mov    0x1000(%rcx),%r13d
    20ad:	8b 7c 24 68          	mov    0x68(%rsp),%edi
    20b1:	41 01 fe             	add    %edi,%r14d
    20b4:	41 01 fd             	add    %edi,%r13d
    20b7:	44 89 b1 18 10 00 00 	mov    %r14d,0x1018(%rcx)
    20be:	44 89 a9 00 10 00 00 	mov    %r13d,0x1000(%rcx)
    20c5:	48 83 c4 70          	add    $0x70,%rsp
    20c9:	5b                   	pop    %rbx
    20ca:	5d                   	pop    %rbp
    20cb:	41 5c                	pop    %r12
    20cd:	41 5d                	pop    %r13
    20cf:	41 5e                	pop    %r14
    20d1:	41 5f                	pop    %r15
    20d3:	e9 00 00 00 00       	jmp    20d8 <n100_private_lz4_compress_fast_continue+0x6e8>
    20d8:	81 ff 00 00 00 7e    	cmp    $0x7e000000,%edi
    20de:	77 cd                	ja     20ad <n100_private_lz4_compress_fast_continue+0x6bd>
    20e0:	83 ff 0c             	cmp    $0xc,%edi
    20e3:	0f 8e 64 01 00 00    	jle    224d <n100_private_lz4_compress_fast_continue+0x85d>
    20e9:	49 8b 12             	mov    (%r10),%rdx
    20ec:	44 89 e8             	mov    %r13d,%eax
    20ef:	4d 89 d6             	mov    %r10,%r14
    20f2:	44 8b 4c 24 20       	mov    0x20(%rsp),%r9d
    20f7:	49 29 c6             	sub    %rax,%r14
    20fa:	4c 8b 24 24          	mov    (%rsp),%r12
    20fe:	4d 8d 5a 01          	lea    0x1(%r10),%r11
    2102:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    2109:	bc 1b cf 
    210c:	48 0f af d0          	imul   %rax,%rdx
    2110:	41 c1 e1 06          	shl    $0x6,%r9d
    2114:	44 89 cd             	mov    %r9d,%ebp
    2117:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    211c:	48 c1 ea 36          	shr    $0x36,%rdx
    2120:	44 89 2c 91          	mov    %r13d,(%rcx,%rdx,4)
    2124:	49 0f af 42 01       	imul   0x1(%r10),%rax
    2129:	48 c1 e8 36          	shr    $0x36,%rax
    212d:	49 8d 7b 01          	lea    0x1(%r11),%rdi
    2131:	49 39 f9             	cmp    %rdi,%r9
    2134:	72 77                	jb     21ad <n100_private_lz4_compress_fast_continue+0x7bd>
    2136:	8b 74 24 20          	mov    0x20(%rsp),%esi
    213a:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    213f:	44 8d 45 01          	lea    0x1(%rbp),%r8d
    2143:	49 bd 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r13
    214a:	bc 1b cf 
    214d:	81 e6 ff ff ff 03    	and    $0x3ffffff,%esi
    2153:	eb 07                	jmp    215c <n100_private_lz4_compress_fast_continue+0x76c>
    2155:	41 83 c0 01          	add    $0x1,%r8d
    2159:	48 89 d7             	mov    %rdx,%rdi
    215c:	89 c0                	mov    %eax,%eax
    215e:	4d 89 df             	mov    %r11,%r15
    2161:	48 8b 17             	mov    (%rdi),%rdx
    2164:	48 8d 1c 81          	lea    (%rcx,%rax,4),%rbx
    2168:	4d 29 f7             	sub    %r14,%r15
    216b:	8b 03                	mov    (%rbx),%eax
    216d:	44 89 3b             	mov    %r15d,(%rbx)
    2170:	4c 01 f0             	add    %r14,%rax
    2173:	48 8d 98 ff ff 00 00 	lea    0xffff(%rax),%rbx
    217a:	4c 39 db             	cmp    %r11,%rbx
    217d:	72 0b                	jb     218a <n100_private_lz4_compress_fast_continue+0x79a>
    217f:	41 8b 1b             	mov    (%r11),%ebx
    2182:	39 18                	cmp    %ebx,(%rax)
    2184:	0f 84 b2 05 00 00    	je     273c <n100_private_lz4_compress_fast_continue+0xd4c>
    218a:	49 0f af d5          	imul   %r13,%rdx
    218e:	49 89 fb             	mov    %rdi,%r11
    2191:	48 c1 ea 36          	shr    $0x36,%rdx
    2195:	48 89 d0             	mov    %rdx,%rax
    2198:	89 f2                	mov    %esi,%edx
    219a:	44 89 c6             	mov    %r8d,%esi
    219d:	48 01 fa             	add    %rdi,%rdx
    21a0:	c1 ee 06             	shr    $0x6,%esi
    21a3:	49 39 d1             	cmp    %rdx,%r9
    21a6:	73 ad                	jae    2155 <n100_private_lz4_compress_fast_continue+0x765>
    21a8:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    21ad:	4c 89 e6             	mov    %r12,%rsi
    21b0:	48 2b 34 24          	sub    (%rsp),%rsi
    21b4:	48 bf 81 80 80 80 80 	movabs $0x8080808080808081,%rdi
    21bb:	80 80 80 
    21be:	4d 29 d7             	sub    %r10,%r15
    21c1:	49 8d 87 f0 00 00 00 	lea    0xf0(%r15),%rax
    21c8:	48 f7 e7             	mul    %rdi
    21cb:	48 89 d0             	mov    %rdx,%rax
    21ce:	49 8d 54 37 01       	lea    0x1(%r15,%rsi,1),%rdx
    21d3:	48 c1 e8 07          	shr    $0x7,%rax
    21d7:	48 01 d0             	add    %rdx,%rax
    21da:	8b 54 24 10          	mov    0x10(%rsp),%edx
    21de:	48 39 c2             	cmp    %rax,%rdx
    21e1:	0f 82 6e 03 00 00    	jb     2555 <n100_private_lz4_compress_fast_continue+0xb65>
    21e7:	49 8d 7c 24 01       	lea    0x1(%r12),%rdi
    21ec:	49 83 ff 0e          	cmp    $0xe,%r15
    21f0:	0f 86 87 03 00 00    	jbe    257d <n100_private_lz4_compress_fast_continue+0xb8d>
    21f6:	49 8d 47 f1          	lea    -0xf(%r15),%rax
    21fa:	41 c6 04 24 f0       	movb   $0xf0,(%r12)
    21ff:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    2205:	0f 86 73 fe ff ff    	jbe    207e <n100_private_lz4_compress_fast_continue+0x68e>
    220b:	48 2d ff 00 00 00    	sub    $0xff,%rax
    2211:	48 83 c7 01          	add    $0x1,%rdi
    2215:	c6 47 ff ff          	movb   $0xff,-0x1(%rdi)
    2219:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    221f:	77 ea                	ja     220b <n100_private_lz4_compress_fast_continue+0x81b>
    2221:	e9 58 fe ff ff       	jmp    207e <n100_private_lz4_compress_fast_continue+0x68e>
    2226:	49 c7 c3 00 00 ff ff 	mov    $0xffffffffffff0000,%r11
    222d:	ba 00 00 01 00       	mov    $0x10000,%edx
    2232:	41 b8 00 00 01 00    	mov    $0x10000,%r8d
    2238:	49 01 c3             	add    %rax,%r11
    223b:	e9 9b fc ff ff       	jmp    1edb <n100_private_lz4_compress_fast_continue+0x4eb>
    2240:	44 89 f8             	mov    %r15d,%eax
    2243:	c1 e0 04             	shl    $0x4,%eax
    2246:	88 06                	mov    %al,(%rsi)
    2248:	e9 0f fc ff ff       	jmp    1e5c <n100_private_lz4_compress_fast_continue+0x46c>
    224d:	4c 8b 24 24          	mov    (%rsp),%r12
    2251:	31 f6                	xor    %esi,%esi
    2253:	e9 5c ff ff ff       	jmp    21b4 <n100_private_lz4_compress_fast_continue+0x7c4>
    2258:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    225d:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
    2262:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    2267:	48 2b 34 24          	sub    (%rsp),%rsi
    226b:	48 bf 81 80 80 80 80 	movabs $0x8080808080808081,%rdi
    2272:	80 80 80 
    2275:	4d 29 e7             	sub    %r12,%r15
    2278:	49 8d 87 f0 00 00 00 	lea    0xf0(%r15),%rax
    227f:	48 f7 e7             	mul    %rdi
    2282:	48 89 d0             	mov    %rdx,%rax
    2285:	49 8d 54 37 01       	lea    0x1(%r15,%rsi,1),%rdx
    228a:	48 c1 e8 07          	shr    $0x7,%rax
    228e:	48 01 d0             	add    %rdx,%rax
    2291:	8b 54 24 10          	mov    0x10(%rsp),%edx
    2295:	48 39 c2             	cmp    %rax,%rdx
    2298:	0f 82 53 fc ff ff    	jb     1ef1 <n100_private_lz4_compress_fast_continue+0x501>
    229e:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    22a3:	48 8d 7e 01          	lea    0x1(%rsi),%rdi
    22a7:	49 83 ff 0e          	cmp    $0xe,%r15
    22ab:	0f 86 97 02 00 00    	jbe    2548 <n100_private_lz4_compress_fast_continue+0xb58>
    22b1:	49 8d 47 f1          	lea    -0xf(%r15),%rax
    22b5:	c6 06 f0             	movb   $0xf0,(%rsi)
    22b8:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    22be:	76 16                	jbe    22d6 <n100_private_lz4_compress_fast_continue+0x8e6>
    22c0:	48 2d ff 00 00 00    	sub    $0xff,%rax
    22c6:	48 83 c7 01          	add    $0x1,%rdi
    22ca:	c6 47 ff ff          	movb   $0xff,-0x1(%rdi)
    22ce:	48 3d fe 00 00 00    	cmp    $0xfe,%rax
    22d4:	77 ea                	ja     22c0 <n100_private_lz4_compress_fast_continue+0x8d0>
    22d6:	88 07                	mov    %al,(%rdi)
    22d8:	48 83 c7 01          	add    $0x1,%rdi
    22dc:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    22e1:	4c 89 fa             	mov    %r15,%rdx
    22e4:	4c 89 e6             	mov    %r12,%rsi
    22e7:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
    22ec:	e9 7b fb ff ff       	jmp    1e6c <n100_private_lz4_compress_fast_continue+0x47c>
    22f1:	4c 8b 4c 24 60       	mov    0x60(%rsp),%r9
    22f6:	49 39 f9             	cmp    %rdi,%r9
    22f9:	73 13                	jae    230e <n100_private_lz4_compress_fast_continue+0x91e>
    22fb:	4d 39 dd             	cmp    %r11,%r13
    22fe:	73 0e                	jae    230e <n100_private_lz4_compress_fast_continue+0x91e>
    2300:	0f b6 44 2a ff       	movzbl -0x1(%rdx,%rbp,1),%eax
    2305:	38 47 ff             	cmp    %al,-0x1(%rdi)
    2308:	0f 84 06 0b 00 00    	je     2e14 <n100_private_lz4_compress_fast_continue+0x1424>
    230e:	48 89 fe             	mov    %rdi,%rsi
    2311:	41 b8 81 80 80 80    	mov    $0x80808081,%r8d
    2317:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    231c:	4c 29 ce             	sub    %r9,%rsi
    231f:	41 89 f3             	mov    %esi,%r11d
    2322:	48 83 c0 01          	add    $0x1,%rax
    2326:	4d 0f af c3          	imul   %r11,%r8
    232a:	49 c1 e8 27          	shr    $0x27,%r8
    232e:	4f 8d 44 03 08       	lea    0x8(%r11,%r8,1),%r8
    2333:	49 01 c0             	add    %rax,%r8
    2336:	4c 39 44 24 28       	cmp    %r8,0x28(%rsp)
    233b:	0f 82 b0 fb ff ff    	jb     1ef1 <n100_private_lz4_compress_fast_continue+0x501>
    2341:	83 fe 0e             	cmp    $0xe,%esi
    2344:	0f 87 01 06 00 00    	ja     294b <n100_private_lz4_compress_fast_continue+0xf5b>
    234a:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
    234f:	c1 e6 04             	shl    $0x4,%esi
    2352:	40 88 33             	mov    %sil,(%rbx)
    2355:	4e 8d 04 18          	lea    (%rax,%r11,1),%r8
    2359:	49 8b 31             	mov    (%r9),%rsi
    235c:	48 83 c0 08          	add    $0x8,%rax
    2360:	49 83 c1 08          	add    $0x8,%r9
    2364:	48 89 70 f8          	mov    %rsi,-0x8(%rax)
    2368:	4c 39 c0             	cmp    %r8,%rax
    236b:	72 ec                	jb     2359 <n100_private_lz4_compress_fast_continue+0x969>
    236d:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
    2372:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
    2377:	49 bf 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r15
    237e:	bc 1b cf 
    2381:	e9 03 01 00 00       	jmp    2489 <n100_private_lz4_compress_fast_continue+0xa99>
    2386:	4c 8b 4c 24 48       	mov    0x48(%rsp),%r9
    238b:	48 01 ea             	add    %rbp,%rdx
    238e:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    2393:	49 29 d1             	sub    %rdx,%r9
    2396:	49 01 f9             	add    %rdi,%r9
    2399:	4c 39 c8             	cmp    %r9,%rax
    239c:	4c 0f 46 c8          	cmovbe %rax,%r9
    23a0:	48 83 c2 04          	add    $0x4,%rdx
    23a4:	4c 89 d8             	mov    %r11,%rax
    23a7:	4d 8d 69 f9          	lea    -0x7(%r9),%r13
    23ab:	4d 39 eb             	cmp    %r13,%r11
    23ae:	0f 83 39 02 00 00    	jae    25ed <n100_private_lz4_compress_fast_continue+0xbfd>
    23b4:	48 8b 2a             	mov    (%rdx),%rbp
    23b7:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
    23bc:	48 8b 28             	mov    (%rax),%rbp
    23bf:	48 39 6c 24 40       	cmp    %rbp,0x40(%rsp)
    23c4:	0f 84 12 02 00 00    	je     25dc <n100_private_lz4_compress_fast_continue+0xbec>
    23ca:	48 8b 54 24 40       	mov    0x40(%rsp),%rdx
    23cf:	48 31 ea             	xor    %rbp,%rdx
    23d2:	f3 48 0f bc d2       	tzcnt  %rdx,%rdx
    23d7:	48 c1 ea 03          	shr    $0x3,%rdx
    23db:	01 d0                	add    %edx,%eax
    23dd:	44 29 d8             	sub    %r11d,%eax
    23e0:	8d 50 04             	lea    0x4(%rax),%edx
    23e3:	48 01 d7             	add    %rdx,%rdi
    23e6:	49 39 f9             	cmp    %rdi,%r9
    23e9:	0f 84 c4 02 00 00    	je     26b3 <n100_private_lz4_compress_fast_continue+0xcc3>
    23ef:	89 c2                	mov    %eax,%edx
    23f1:	c1 ea 08             	shr    $0x8,%edx
    23f4:	83 c2 06             	add    $0x6,%edx
    23f7:	48 01 f2             	add    %rsi,%rdx
    23fa:	48 39 54 24 28       	cmp    %rdx,0x28(%rsp)
    23ff:	0f 82 ec fa ff ff    	jb     1ef1 <n100_private_lz4_compress_fast_continue+0x501>
    2405:	0f b6 13             	movzbl (%rbx),%edx
    2408:	83 f8 0e             	cmp    $0xe,%eax
    240b:	0f 87 dd 00 00 00    	ja     24ee <n100_private_lz4_compress_fast_continue+0xafe>
    2411:	01 c2                	add    %eax,%edx
    2413:	88 13                	mov    %dl,(%rbx)
    2415:	48 89 f3             	mov    %rsi,%rbx
    2418:	49 39 fc             	cmp    %rdi,%r12
    241b:	0f 82 74 09 00 00    	jb     2d95 <n100_private_lz4_compress_fast_continue+0x13a5>
    2421:	48 8b 47 fe          	mov    -0x2(%rdi),%rax
    2425:	48 8d 57 fe          	lea    -0x2(%rdi),%rdx
    2429:	4c 29 f2             	sub    %r14,%rdx
    242c:	49 0f af c7          	imul   %r15,%rax
    2430:	48 c1 e8 36          	shr    $0x36,%rax
    2434:	89 14 81             	mov    %edx,(%rcx,%rax,4)
    2437:	48 8b 07             	mov    (%rdi),%rax
    243a:	49 0f af c7          	imul   %r15,%rax
    243e:	48 c1 e8 36          	shr    $0x36,%rax
    2442:	48 8d 34 81          	lea    (%rcx,%rax,4),%rsi
    2446:	8b 06                	mov    (%rsi),%eax
    2448:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    244c:	4c 39 d2             	cmp    %r10,%rdx
    244f:	0f 83 8f 00 00 00    	jae    24e4 <n100_private_lz4_compress_fast_continue+0xaf4>
    2455:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
    245a:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    245f:	48 89 f8             	mov    %rdi,%rax
    2462:	4c 29 f0             	sub    %r14,%rax
    2465:	89 06                	mov    %eax,(%rsi)
    2467:	48 8d 82 ff ff 00 00 	lea    0xffff(%rdx),%rax
    246e:	48 39 f8             	cmp    %rdi,%rax
    2471:	0f 82 09 05 00 00    	jb     2980 <n100_private_lz4_compress_fast_continue+0xf90>
    2477:	8b 07                	mov    (%rdi),%eax
    2479:	39 04 2a             	cmp    %eax,(%rdx,%rbp,1)
    247c:	0f 85 fe 04 00 00    	jne    2980 <n100_private_lz4_compress_fast_continue+0xf90>
    2482:	c6 03 00             	movb   $0x0,(%rbx)
    2485:	4c 8d 43 01          	lea    0x1(%rbx),%r8
    2489:	48 89 f8             	mov    %rdi,%rax
    248c:	49 8d 70 02          	lea    0x2(%r8),%rsi
    2490:	4c 8d 5f 04          	lea    0x4(%rdi),%r11
    2494:	48 29 d0             	sub    %rdx,%rax
    2497:	66 41 89 00          	mov    %ax,(%r8)
    249b:	4c 3b 6c 24 38       	cmp    0x38(%rsp),%r13
    24a0:	0f 84 e0 fe ff ff    	je     2386 <n100_private_lz4_compress_fast_continue+0x996>
    24a6:	48 8d 42 04          	lea    0x4(%rdx),%rax
    24aa:	4c 89 da             	mov    %r11,%rdx
    24ad:	4d 39 e3             	cmp    %r12,%r11
    24b0:	0f 83 94 01 00 00    	jae    264a <n100_private_lz4_compress_fast_continue+0xc5a>
    24b6:	4c 8b 08             	mov    (%rax),%r9
    24b9:	48 8b 2a             	mov    (%rdx),%rbp
    24bc:	49 39 e9             	cmp    %rbp,%r9
    24bf:	0f 84 74 01 00 00    	je     2639 <n100_private_lz4_compress_fast_continue+0xc49>
    24c5:	4c 89 c8             	mov    %r9,%rax
    24c8:	48 31 e8             	xor    %rbp,%rax
    24cb:	f3 48 0f bc c0       	tzcnt  %rax,%rax
    24d0:	48 c1 e8 03          	shr    $0x3,%rax
    24d4:	01 d0                	add    %edx,%eax
    24d6:	44 29 d8             	sub    %r11d,%eax
    24d9:	8d 50 04             	lea    0x4(%rax),%edx
    24dc:	48 01 d7             	add    %rdx,%rdi
    24df:	e9 0b ff ff ff       	jmp    23ef <n100_private_lz4_compress_fast_continue+0x9ff>
    24e4:	4d 89 d5             	mov    %r10,%r13
    24e7:	31 ed                	xor    %ebp,%ebp
    24e9:	e9 71 ff ff ff       	jmp    245f <n100_private_lz4_compress_fast_continue+0xa6f>
    24ee:	83 c2 0f             	add    $0xf,%edx
    24f1:	83 e8 0f             	sub    $0xf,%eax
    24f4:	88 13                	mov    %dl,(%rbx)
    24f6:	41 c7 40 02 ff ff ff 	movl   $0xffffffff,0x2(%r8)
    24fd:	ff 
    24fe:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    2503:	76 16                	jbe    251b <n100_private_lz4_compress_fast_continue+0xb2b>
    2505:	2d fc 03 00 00       	sub    $0x3fc,%eax
    250a:	48 83 c6 04          	add    $0x4,%rsi
    250e:	c7 06 ff ff ff ff    	movl   $0xffffffff,(%rsi)
    2514:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    2519:	77 ea                	ja     2505 <n100_private_lz4_compress_fast_continue+0xb15>
    251b:	89 c2                	mov    %eax,%edx
    251d:	bb 81 80 80 80       	mov    $0x80808081,%ebx
    2522:	48 0f af d3          	imul   %rbx,%rdx
    2526:	48 c1 ea 27          	shr    $0x27,%rdx
    252a:	41 89 d0             	mov    %edx,%r8d
    252d:	4c 01 c6             	add    %r8,%rsi
    2530:	41 89 d0             	mov    %edx,%r8d
    2533:	41 c1 e0 08          	shl    $0x8,%r8d
    2537:	48 8d 5e 01          	lea    0x1(%rsi),%rbx
    253b:	41 29 d0             	sub    %edx,%r8d
    253e:	44 29 c0             	sub    %r8d,%eax
    2541:	88 06                	mov    %al,(%rsi)
    2543:	e9 d0 fe ff ff       	jmp    2418 <n100_private_lz4_compress_fast_continue+0xa28>
    2548:	44 89 f8             	mov    %r15d,%eax
    254b:	c1 e0 04             	shl    $0x4,%eax
    254e:	88 06                	mov    %al,(%rsi)
    2550:	e9 87 fd ff ff       	jmp    22dc <n100_private_lz4_compress_fast_continue+0x8ec>
    2555:	44 8b b1 18 10 00 00 	mov    0x1018(%rcx),%r14d
    255c:	44 8b a9 00 10 00 00 	mov    0x1000(%rcx),%r13d
    2563:	31 c0                	xor    %eax,%eax
    2565:	e9 43 fb ff ff       	jmp    20ad <n100_private_lz4_compress_fast_continue+0x6bd>
    256a:	48 8b 04 24          	mov    (%rsp),%rax
    256e:	4d 89 d4             	mov    %r10,%r12
    2571:	31 f6                	xor    %esi,%esi
    2573:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    2578:	e9 ee fc ff ff       	jmp    226b <n100_private_lz4_compress_fast_continue+0x87b>
    257d:	44 89 f8             	mov    %r15d,%eax
    2580:	c1 e0 04             	shl    $0x4,%eax
    2583:	41 88 04 24          	mov    %al,(%r12)
    2587:	e9 f8 fa ff ff       	jmp    2084 <n100_private_lz4_compress_fast_continue+0x694>
    258c:	48 63 f3             	movslq %ebx,%rsi
    258f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    2596:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    259b:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    25a0:	4c 89 5c 24 28       	mov    %r11,0x28(%rsp)
    25a5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    25aa:	44 89 44 24 18       	mov    %r8d,0x18(%rsp)
    25af:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    25b4:	e8 00 00 00 00       	call   25b9 <n100_private_lz4_compress_fast_continue+0xbc9>
    25b9:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    25be:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    25c3:	4c 8b 5c 24 28       	mov    0x28(%rsp),%r11
    25c8:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    25cd:	44 8b 44 24 18       	mov    0x18(%rsp),%r8d
    25d2:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    25d7:	e9 ad f4 ff ff       	jmp    1a89 <n100_private_lz4_compress_fast_continue+0x99>
    25dc:	48 83 c0 08          	add    $0x8,%rax
    25e0:	48 83 c2 08          	add    $0x8,%rdx
    25e4:	4c 39 e8             	cmp    %r13,%rax
    25e7:	0f 82 c7 fd ff ff    	jb     23b4 <n100_private_lz4_compress_fast_continue+0x9c4>
    25ed:	49 8d 69 fd          	lea    -0x3(%r9),%rbp
    25f1:	48 39 e8             	cmp    %rbp,%rax
    25f4:	73 0e                	jae    2604 <n100_private_lz4_compress_fast_continue+0xc14>
    25f6:	8b 28                	mov    (%rax),%ebp
    25f8:	39 2a                	cmp    %ebp,(%rdx)
    25fa:	75 08                	jne    2604 <n100_private_lz4_compress_fast_continue+0xc14>
    25fc:	48 83 c0 04          	add    $0x4,%rax
    2600:	48 83 c2 04          	add    $0x4,%rdx
    2604:	49 8d 69 ff          	lea    -0x1(%r9),%rbp
    2608:	48 39 e8             	cmp    %rbp,%rax
    260b:	73 10                	jae    261d <n100_private_lz4_compress_fast_continue+0xc2d>
    260d:	0f b7 28             	movzwl (%rax),%ebp
    2610:	66 39 2a             	cmp    %bp,(%rdx)
    2613:	75 08                	jne    261d <n100_private_lz4_compress_fast_continue+0xc2d>
    2615:	48 83 c0 02          	add    $0x2,%rax
    2619:	48 83 c2 02          	add    $0x2,%rdx
    261d:	4c 39 c8             	cmp    %r9,%rax
    2620:	73 0f                	jae    2631 <n100_private_lz4_compress_fast_continue+0xc41>
    2622:	0f b6 28             	movzbl (%rax),%ebp
    2625:	40 38 2a             	cmp    %bpl,(%rdx)
    2628:	0f 94 c2             	sete   %dl
    262b:	0f b6 d2             	movzbl %dl,%edx
    262e:	48 01 d0             	add    %rdx,%rax
    2631:	44 29 d8             	sub    %r11d,%eax
    2634:	e9 a7 fd ff ff       	jmp    23e0 <n100_private_lz4_compress_fast_continue+0x9f0>
    2639:	48 83 c2 08          	add    $0x8,%rdx
    263d:	48 83 c0 08          	add    $0x8,%rax
    2641:	4c 39 e2             	cmp    %r12,%rdx
    2644:	0f 82 6c fe ff ff    	jb     24b6 <n100_private_lz4_compress_fast_continue+0xac6>
    264a:	4c 8b 4c 24 50       	mov    0x50(%rsp),%r9
    264f:	49 83 e9 08          	sub    $0x8,%r9
    2653:	4c 39 ca             	cmp    %r9,%rdx
    2656:	73 10                	jae    2668 <n100_private_lz4_compress_fast_continue+0xc78>
    2658:	44 8b 0a             	mov    (%rdx),%r9d
    265b:	44 39 08             	cmp    %r9d,(%rax)
    265e:	75 08                	jne    2668 <n100_private_lz4_compress_fast_continue+0xc78>
    2660:	48 83 c2 04          	add    $0x4,%rdx
    2664:	48 83 c0 04          	add    $0x4,%rax
    2668:	4c 8b 4c 24 50       	mov    0x50(%rsp),%r9
    266d:	49 83 e9 06          	sub    $0x6,%r9
    2671:	4c 39 ca             	cmp    %r9,%rdx
    2674:	73 12                	jae    2688 <n100_private_lz4_compress_fast_continue+0xc98>
    2676:	44 0f b7 0a          	movzwl (%rdx),%r9d
    267a:	66 44 39 08          	cmp    %r9w,(%rax)
    267e:	75 08                	jne    2688 <n100_private_lz4_compress_fast_continue+0xc98>
    2680:	48 83 c2 02          	add    $0x2,%rdx
    2684:	48 83 c0 02          	add    $0x2,%rax
    2688:	48 3b 54 24 30       	cmp    0x30(%rsp),%rdx
    268d:	73 10                	jae    269f <n100_private_lz4_compress_fast_continue+0xcaf>
    268f:	44 0f b6 0a          	movzbl (%rdx),%r9d
    2693:	44 38 08             	cmp    %r9b,(%rax)
    2696:	0f 94 c0             	sete   %al
    2699:	0f b6 c0             	movzbl %al,%eax
    269c:	48 01 c2             	add    %rax,%rdx
    269f:	89 d0                	mov    %edx,%eax
    26a1:	44 29 d8             	sub    %r11d,%eax
    26a4:	e9 30 fe ff ff       	jmp    24d9 <n100_private_lz4_compress_fast_continue+0xae9>
    26a9:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    26ae:	e9 53 f8 ff ff       	jmp    1f06 <n100_private_lz4_compress_fast_continue+0x516>
    26b3:	48 89 fa             	mov    %rdi,%rdx
    26b6:	4d 89 d1             	mov    %r10,%r9
    26b9:	4c 39 e7             	cmp    %r12,%rdi
    26bc:	0f 83 fd 06 00 00    	jae    2dbf <n100_private_lz4_compress_fast_continue+0x13cf>
    26c2:	4d 8b 19             	mov    (%r9),%r11
    26c5:	48 8b 2a             	mov    (%rdx),%rbp
    26c8:	49 39 eb             	cmp    %rbp,%r11
    26cb:	0f 84 dd 06 00 00    	je     2dae <n100_private_lz4_compress_fast_continue+0x13be>
    26d1:	49 31 eb             	xor    %rbp,%r11
    26d4:	f3 4d 0f bc cb       	tzcnt  %r11,%r9
    26d9:	49 c1 e9 03          	shr    $0x3,%r9
    26dd:	44 01 ca             	add    %r9d,%edx
    26e0:	29 fa                	sub    %edi,%edx
    26e2:	01 d0                	add    %edx,%eax
    26e4:	48 01 d7             	add    %rdx,%rdi
    26e7:	e9 03 fd ff ff       	jmp    23ef <n100_private_lz4_compress_fast_continue+0x9ff>
    26ec:	49 63 f4             	movslq %r12d,%rsi
    26ef:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    26f6:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    26fb:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    2700:	4c 89 5c 24 28       	mov    %r11,0x28(%rsp)
    2705:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    270a:	44 89 44 24 18       	mov    %r8d,0x18(%rsp)
    270f:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    2714:	e8 00 00 00 00       	call   2719 <n100_private_lz4_compress_fast_continue+0xd29>
    2719:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    271e:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    2723:	4c 8b 5c 24 28       	mov    0x28(%rsp),%r11
    2728:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    272d:	44 8b 44 24 18       	mov    0x18(%rsp),%r8d
    2732:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    2737:	e9 66 f3 ff ff       	jmp    1aa2 <n100_private_lz4_compress_fast_continue+0xb2>
    273c:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    2741:	48 39 44 24 18       	cmp    %rax,0x18(%rsp)
    2746:	73 13                	jae    275b <n100_private_lz4_compress_fast_continue+0xd6b>
    2748:	4d 39 da             	cmp    %r11,%r10
    274b:	73 0e                	jae    275b <n100_private_lz4_compress_fast_continue+0xd6b>
    274d:	0f b6 70 ff          	movzbl -0x1(%rax),%esi
    2751:	41 38 73 ff          	cmp    %sil,-0x1(%r11)
    2755:	0f 84 ed 07 00 00    	je     2f48 <n100_private_lz4_compress_fast_continue+0x1558>
    275b:	4c 89 df             	mov    %r11,%rdi
    275e:	41 b8 81 80 80 80    	mov    $0x80808081,%r8d
    2764:	49 8d 54 24 01       	lea    0x1(%r12),%rdx
    2769:	4c 29 d7             	sub    %r10,%rdi
    276c:	89 fe                	mov    %edi,%esi
    276e:	4c 0f af c6          	imul   %rsi,%r8
    2772:	49 c1 e8 27          	shr    $0x27,%r8
    2776:	4e 8d 44 06 08       	lea    0x8(%rsi,%r8,1),%r8
    277b:	49 01 d0             	add    %rdx,%r8
    277e:	4c 39 44 24 28       	cmp    %r8,0x28(%rsp)
    2783:	0f 82 cc fd ff ff    	jb     2555 <n100_private_lz4_compress_fast_continue+0xb65>
    2789:	83 ff 0e             	cmp    $0xe,%edi
    278c:	0f 87 be 0a 00 00    	ja     3250 <n100_private_lz4_compress_fast_continue+0x1860>
    2792:	c1 e7 04             	shl    $0x4,%edi
    2795:	41 88 3c 24          	mov    %dil,(%r12)
    2799:	48 01 d6             	add    %rdx,%rsi
    279c:	49 8b 3a             	mov    (%r10),%rdi
    279f:	48 83 c2 08          	add    $0x8,%rdx
    27a3:	49 83 c2 08          	add    $0x8,%r10
    27a7:	48 89 7a f8          	mov    %rdi,-0x8(%rdx)
    27ab:	48 39 f2             	cmp    %rsi,%rdx
    27ae:	72 ec                	jb     279c <n100_private_lz4_compress_fast_continue+0xdac>
    27b0:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    27b4:	41 bd 81 80 80 80    	mov    $0x80808081,%r13d
    27ba:	48 bb 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rbx
    27c1:	bc 1b cf 
    27c4:	eb 69                	jmp    282f <n100_private_lz4_compress_fast_continue+0xe3f>
    27c6:	01 c2                	add    %eax,%edx
    27c8:	41 88 14 24          	mov    %dl,(%r12)
    27cc:	4d 89 c4             	mov    %r8,%r12
    27cf:	4d 39 d9             	cmp    %r11,%r9
    27d2:	0f 82 b4 07 00 00    	jb     2f8c <n100_private_lz4_compress_fast_continue+0x159c>
    27d8:	49 8b 43 fe          	mov    -0x2(%r11),%rax
    27dc:	49 8d 53 fe          	lea    -0x2(%r11),%rdx
    27e0:	4c 29 f2             	sub    %r14,%rdx
    27e3:	48 0f af c3          	imul   %rbx,%rax
    27e7:	48 c1 e8 36          	shr    $0x36,%rax
    27eb:	89 14 81             	mov    %edx,(%rcx,%rax,4)
    27ee:	49 8b 03             	mov    (%r11),%rax
    27f1:	4c 89 da             	mov    %r11,%rdx
    27f4:	4c 29 f2             	sub    %r14,%rdx
    27f7:	48 0f af c3          	imul   %rbx,%rax
    27fb:	48 c1 e8 36          	shr    $0x36,%rax
    27ff:	48 8d 34 81          	lea    (%rcx,%rax,4),%rsi
    2803:	8b 06                	mov    (%rsi),%eax
    2805:	89 16                	mov    %edx,(%rsi)
    2807:	4c 01 f0             	add    %r14,%rax
    280a:	48 8d 90 ff ff 00 00 	lea    0xffff(%rax),%rdx
    2811:	4c 39 da             	cmp    %r11,%rdx
    2814:	0f 82 4f 07 00 00    	jb     2f69 <n100_private_lz4_compress_fast_continue+0x1579>
    281a:	41 8b 33             	mov    (%r11),%esi
    281d:	39 30                	cmp    %esi,(%rax)
    281f:	0f 85 44 07 00 00    	jne    2f69 <n100_private_lz4_compress_fast_continue+0x1579>
    2825:	41 c6 04 24 00       	movb   $0x0,(%r12)
    282a:	49 8d 74 24 01       	lea    0x1(%r12),%rsi
    282f:	4c 89 da             	mov    %r11,%rdx
    2832:	4d 8d 53 04          	lea    0x4(%r11),%r10
    2836:	4c 8d 46 02          	lea    0x2(%rsi),%r8
    283a:	48 29 c2             	sub    %rax,%rdx
    283d:	66 89 16             	mov    %dx,(%rsi)
    2840:	48 8d 50 04          	lea    0x4(%rax),%rdx
    2844:	4c 89 d0             	mov    %r10,%rax
    2847:	4d 39 ca             	cmp    %r9,%r10
    284a:	0f 83 ad 00 00 00    	jae    28fd <n100_private_lz4_compress_fast_continue+0xf0d>
    2850:	48 8b 3a             	mov    (%rdx),%rdi
    2853:	48 8b 28             	mov    (%rax),%rbp
    2856:	48 39 ef             	cmp    %rbp,%rdi
    2859:	0f 84 8d 00 00 00    	je     28ec <n100_private_lz4_compress_fast_continue+0xefc>
    285f:	48 31 ef             	xor    %rbp,%rdi
    2862:	f3 48 0f bc d7       	tzcnt  %rdi,%rdx
    2867:	48 c1 ea 03          	shr    $0x3,%rdx
    286b:	01 d0                	add    %edx,%eax
    286d:	44 29 d0             	sub    %r10d,%eax
    2870:	89 c2                	mov    %eax,%edx
    2872:	c1 ea 08             	shr    $0x8,%edx
    2875:	83 c2 06             	add    $0x6,%edx
    2878:	4c 01 c2             	add    %r8,%rdx
    287b:	48 39 54 24 28       	cmp    %rdx,0x28(%rsp)
    2880:	0f 82 cf fc ff ff    	jb     2555 <n100_private_lz4_compress_fast_continue+0xb65>
    2886:	8d 50 04             	lea    0x4(%rax),%edx
    2889:	49 01 d3             	add    %rdx,%r11
    288c:	41 0f b6 14 24       	movzbl (%r12),%edx
    2891:	83 f8 0e             	cmp    $0xe,%eax
    2894:	0f 86 2c ff ff ff    	jbe    27c6 <n100_private_lz4_compress_fast_continue+0xdd6>
    289a:	83 c2 0f             	add    $0xf,%edx
    289d:	83 e8 0f             	sub    $0xf,%eax
    28a0:	41 88 14 24          	mov    %dl,(%r12)
    28a4:	c7 46 02 ff ff ff ff 	movl   $0xffffffff,0x2(%rsi)
    28ab:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    28b0:	76 17                	jbe    28c9 <n100_private_lz4_compress_fast_continue+0xed9>
    28b2:	2d fc 03 00 00       	sub    $0x3fc,%eax
    28b7:	49 83 c0 04          	add    $0x4,%r8
    28bb:	41 c7 00 ff ff ff ff 	movl   $0xffffffff,(%r8)
    28c2:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    28c7:	77 e9                	ja     28b2 <n100_private_lz4_compress_fast_continue+0xec2>
    28c9:	89 c2                	mov    %eax,%edx
    28cb:	49 0f af d5          	imul   %r13,%rdx
    28cf:	48 c1 ea 27          	shr    $0x27,%rdx
    28d3:	89 d7                	mov    %edx,%edi
    28d5:	89 d6                	mov    %edx,%esi
    28d7:	c1 e7 08             	shl    $0x8,%edi
    28da:	4d 8d 64 30 01       	lea    0x1(%r8,%rsi,1),%r12
    28df:	29 d7                	sub    %edx,%edi
    28e1:	29 f8                	sub    %edi,%eax
    28e3:	41 88 04 30          	mov    %al,(%r8,%rsi,1)
    28e7:	e9 e3 fe ff ff       	jmp    27cf <n100_private_lz4_compress_fast_continue+0xddf>
    28ec:	48 83 c0 08          	add    $0x8,%rax
    28f0:	48 83 c2 08          	add    $0x8,%rdx
    28f4:	4c 39 c8             	cmp    %r9,%rax
    28f7:	0f 82 53 ff ff ff    	jb     2850 <n100_private_lz4_compress_fast_continue+0xe60>
    28fd:	49 8d 7f f8          	lea    -0x8(%r15),%rdi
    2901:	48 39 f8             	cmp    %rdi,%rax
    2904:	73 0e                	jae    2914 <n100_private_lz4_compress_fast_continue+0xf24>
    2906:	8b 38                	mov    (%rax),%edi
    2908:	39 3a                	cmp    %edi,(%rdx)
    290a:	75 08                	jne    2914 <n100_private_lz4_compress_fast_continue+0xf24>
    290c:	48 83 c0 04          	add    $0x4,%rax
    2910:	48 83 c2 04          	add    $0x4,%rdx
    2914:	49 8d 7f fa          	lea    -0x6(%r15),%rdi
    2918:	48 39 f8             	cmp    %rdi,%rax
    291b:	73 10                	jae    292d <n100_private_lz4_compress_fast_continue+0xf3d>
    291d:	0f b7 38             	movzwl (%rax),%edi
    2920:	66 39 3a             	cmp    %di,(%rdx)
    2923:	75 08                	jne    292d <n100_private_lz4_compress_fast_continue+0xf3d>
    2925:	48 83 c0 02          	add    $0x2,%rax
    2929:	48 83 c2 02          	add    $0x2,%rdx
    292d:	48 3b 44 24 30       	cmp    0x30(%rsp),%rax
    2932:	73 0f                	jae    2943 <n100_private_lz4_compress_fast_continue+0xf53>
    2934:	0f b6 38             	movzbl (%rax),%edi
    2937:	40 38 3a             	cmp    %dil,(%rdx)
    293a:	0f 94 c2             	sete   %dl
    293d:	0f b6 d2             	movzbl %dl,%edx
    2940:	48 01 d0             	add    %rdx,%rax
    2943:	44 29 d0             	sub    %r10d,%eax
    2946:	e9 25 ff ff ff       	jmp    2870 <n100_private_lz4_compress_fast_continue+0xe80>
    294b:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
    2950:	83 ee 0f             	sub    $0xf,%esi
    2953:	c6 03 f0             	movb   $0xf0,(%rbx)
    2956:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    295c:	7e 16                	jle    2974 <n100_private_lz4_compress_fast_continue+0xf84>
    295e:	81 ee ff 00 00 00    	sub    $0xff,%esi
    2964:	48 83 c0 01          	add    $0x1,%rax
    2968:	c6 40 ff ff          	movb   $0xff,-0x1(%rax)
    296c:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    2972:	7f ea                	jg     295e <n100_private_lz4_compress_fast_continue+0xf6e>
    2974:	40 88 30             	mov    %sil,(%rax)
    2977:	48 83 c0 01          	add    $0x1,%rax
    297b:	e9 d5 f9 ff ff       	jmp    2355 <n100_private_lz4_compress_fast_continue+0x965>
    2980:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    2987:	bc 1b cf 
    298a:	48 0f af 47 01       	imul   0x1(%rdi),%rax
    298f:	49 89 f9             	mov    %rdi,%r9
    2992:	48 89 5c 24 40       	mov    %rbx,0x40(%rsp)
    2997:	48 83 c7 01          	add    $0x1,%rdi
    299b:	48 c1 e8 36          	shr    $0x36,%rax
    299f:	e9 5c f3 ff ff       	jmp    1d00 <n100_private_lz4_compress_fast_continue+0x310>
    29a4:	49 63 f4             	movslq %r12d,%rsi
    29a7:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    29ae:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
    29b3:	4c 89 54 24 38       	mov    %r10,0x38(%rsp)
    29b8:	4c 89 5c 24 30       	mov    %r11,0x30(%rsp)
    29bd:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    29c2:	44 89 44 24 20       	mov    %r8d,0x20(%rsp)
    29c7:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    29cc:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    29d1:	e8 00 00 00 00       	call   29d6 <n100_private_lz4_compress_fast_continue+0xfe6>
    29d6:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
    29db:	4c 8b 54 24 38       	mov    0x38(%rsp),%r10
    29e0:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
    29e5:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    29ea:	44 8b 44 24 20       	mov    0x20(%rsp),%r8d
    29ef:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    29f4:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    29f9:	e9 b4 f3 ff ff       	jmp    1db2 <n100_private_lz4_compress_fast_continue+0x3c2>
    29fe:	49 63 f4             	movslq %r12d,%rsi
    2a01:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    2a08:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    2a0d:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    2a12:	4c 89 5c 24 28       	mov    %r11,0x28(%rsp)
    2a17:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    2a1c:	44 89 44 24 18       	mov    %r8d,0x18(%rsp)
    2a21:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    2a26:	e8 00 00 00 00       	call   2a2b <n100_private_lz4_compress_fast_continue+0x103b>
    2a2b:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    2a30:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    2a35:	4c 8b 5c 24 28       	mov    0x28(%rsp),%r11
    2a3a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    2a3f:	44 8b 44 24 18       	mov    0x18(%rsp),%r8d
    2a44:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    2a49:	e9 71 f3 ff ff       	jmp    1dbf <n100_private_lz4_compress_fast_continue+0x3cf>
    2a4e:	4d 89 df             	mov    %r11,%r15
    2a51:	e9 0c f8 ff ff       	jmp    2262 <n100_private_lz4_compress_fast_continue+0x872>
    2a56:	4c 8b 5c 24 50       	mov    0x50(%rsp),%r11
    2a5b:	4c 8b 64 24 60       	mov    0x60(%rsp),%r12
    2a60:	4c 39 c5             	cmp    %r8,%rbp
    2a63:	73 14                	jae    2a79 <n100_private_lz4_compress_fast_continue+0x1089>
    2a65:	4d 39 ec             	cmp    %r13,%r12
    2a68:	73 0f                	jae    2a79 <n100_private_lz4_compress_fast_continue+0x1089>
    2a6a:	0f b6 74 18 ff       	movzbl -0x1(%rax,%rbx,1),%esi
    2a6f:	41 38 75 ff          	cmp    %sil,-0x1(%r13)
    2a73:	0f 84 09 08 00 00    	je     3282 <n100_private_lz4_compress_fast_continue+0x1892>
    2a79:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    2a7e:	4c 89 ef             	mov    %r13,%rdi
    2a81:	4c 29 e7             	sub    %r12,%rdi
    2a84:	48 8d 56 01          	lea    0x1(%rsi),%rdx
    2a88:	41 89 f8             	mov    %edi,%r8d
    2a8b:	be 81 80 80 80       	mov    $0x80808081,%esi
    2a90:	49 0f af f0          	imul   %r8,%rsi
    2a94:	48 c1 ee 27          	shr    $0x27,%rsi
    2a98:	49 8d 74 30 08       	lea    0x8(%r8,%rsi,1),%rsi
    2a9d:	48 01 d6             	add    %rdx,%rsi
    2aa0:	48 39 74 24 28       	cmp    %rsi,0x28(%rsp)
    2aa5:	0f 82 46 f4 ff ff    	jb     1ef1 <n100_private_lz4_compress_fast_continue+0x501>
    2aab:	83 ff 0e             	cmp    $0xe,%edi
    2aae:	0f 87 c8 03 00 00    	ja     2e7c <n100_private_lz4_compress_fast_continue+0x148c>
    2ab4:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    2ab9:	c1 e7 04             	shl    $0x4,%edi
    2abc:	40 88 3e             	mov    %dil,(%rsi)
    2abf:	4e 8d 3c 02          	lea    (%rdx,%r8,1),%r15
    2ac3:	49 8b 34 24          	mov    (%r12),%rsi
    2ac7:	48 83 c2 08          	add    $0x8,%rdx
    2acb:	49 83 c4 08          	add    $0x8,%r12
    2acf:	48 89 72 f8          	mov    %rsi,-0x8(%rdx)
    2ad3:	4c 39 fa             	cmp    %r15,%rdx
    2ad6:	72 eb                	jb     2ac3 <n100_private_lz4_compress_fast_continue+0x10d3>
    2ad8:	49 bc 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r12
    2adf:	bc 1b cf 
    2ae2:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
    2ae7:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    2aec:	e9 0d 01 00 00       	jmp    2bfe <n100_private_lz4_compress_fast_continue+0x120e>
    2af1:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    2af6:	48 01 d8             	add    %rbx,%rax
    2af9:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
    2afe:	48 29 c7             	sub    %rax,%rdi
    2b01:	4c 01 ef             	add    %r13,%rdi
    2b04:	48 39 fa             	cmp    %rdi,%rdx
    2b07:	48 0f 46 fa          	cmovbe %rdx,%rdi
    2b0b:	48 8d 50 04          	lea    0x4(%rax),%rdx
    2b0f:	48 89 f0             	mov    %rsi,%rax
    2b12:	48 8d 6f f9          	lea    -0x7(%rdi),%rbp
    2b16:	48 39 ee             	cmp    %rbp,%rsi
    2b19:	0f 83 2c 02 00 00    	jae    2d4b <n100_private_lz4_compress_fast_continue+0x135b>
    2b1f:	4c 8b 02             	mov    (%rdx),%r8
    2b22:	48 8b 18             	mov    (%rax),%rbx
    2b25:	49 39 d8             	cmp    %rbx,%r8
    2b28:	0f 84 0c 02 00 00    	je     2d3a <n100_private_lz4_compress_fast_continue+0x134a>
    2b2e:	4c 89 c2             	mov    %r8,%rdx
    2b31:	48 31 da             	xor    %rbx,%rdx
    2b34:	f3 48 0f bc d2       	tzcnt  %rdx,%rdx
    2b39:	48 c1 ea 03          	shr    $0x3,%rdx
    2b3d:	01 d0                	add    %edx,%eax
    2b3f:	29 f0                	sub    %esi,%eax
    2b41:	8d 50 04             	lea    0x4(%rax),%edx
    2b44:	49 01 d5             	add    %rdx,%r13
    2b47:	4c 39 ef             	cmp    %r13,%rdi
    2b4a:	0f 84 f2 02 00 00    	je     2e42 <n100_private_lz4_compress_fast_continue+0x1452>
    2b50:	89 c2                	mov    %eax,%edx
    2b52:	c1 ea 08             	shr    $0x8,%edx
    2b55:	83 c2 06             	add    $0x6,%edx
    2b58:	4c 01 ca             	add    %r9,%rdx
    2b5b:	48 39 54 24 28       	cmp    %rdx,0x28(%rsp)
    2b60:	0f 82 c1 01 00 00    	jb     2d27 <n100_private_lz4_compress_fast_continue+0x1337>
    2b66:	0f b6 11             	movzbl (%rcx),%edx
    2b69:	83 f8 0e             	cmp    $0xe,%eax
    2b6c:	0f 87 f2 00 00 00    	ja     2c64 <n100_private_lz4_compress_fast_continue+0x1274>
    2b72:	01 c2                	add    %eax,%edx
    2b74:	88 11                	mov    %dl,(%rcx)
    2b76:	4c 89 c9             	mov    %r9,%rcx
    2b79:	4c 39 6c 24 08       	cmp    %r13,0x8(%rsp)
    2b7e:	0f 82 17 04 00 00    	jb     2f9b <n100_private_lz4_compress_fast_continue+0x15ab>
    2b84:	49 8b 45 fe          	mov    -0x2(%r13),%rax
    2b88:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
    2b8d:	49 8d 55 fe          	lea    -0x2(%r13),%rdx
    2b91:	4c 29 f2             	sub    %r14,%rdx
    2b94:	49 0f af c4          	imul   %r12,%rax
    2b98:	48 c1 e8 36          	shr    $0x36,%rax
    2b9c:	89 14 86             	mov    %edx,(%rsi,%rax,4)
    2b9f:	49 8b 45 00          	mov    0x0(%r13),%rax
    2ba3:	49 0f af c4          	imul   %r12,%rax
    2ba7:	48 c1 e8 36          	shr    $0x36,%rax
    2bab:	48 8d 14 86          	lea    (%rsi,%rax,4),%rdx
    2baf:	8b 02                	mov    (%rdx),%eax
    2bb1:	4c 01 f0             	add    %r14,%rax
    2bb4:	4c 39 d0             	cmp    %r10,%rax
    2bb7:	0f 83 9d 00 00 00    	jae    2c5a <n100_private_lz4_compress_fast_continue+0x126a>
    2bbd:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    2bc2:	48 8b 6c 24 40       	mov    0x40(%rsp),%rbp
    2bc7:	4c 89 ee             	mov    %r13,%rsi
    2bca:	4c 29 f6             	sub    %r14,%rsi
    2bcd:	89 32                	mov    %esi,(%rdx)
    2bcf:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax
    2bd4:	0f 82 d7 02 00 00    	jb     2eb1 <n100_private_lz4_compress_fast_continue+0x14c1>
    2bda:	48 8d 90 ff ff 00 00 	lea    0xffff(%rax),%rdx
    2be1:	4c 39 ea             	cmp    %r13,%rdx
    2be4:	0f 82 c7 02 00 00    	jb     2eb1 <n100_private_lz4_compress_fast_continue+0x14c1>
    2bea:	41 8b 75 00          	mov    0x0(%r13),%esi
    2bee:	39 34 18             	cmp    %esi,(%rax,%rbx,1)
    2bf1:	0f 85 ba 02 00 00    	jne    2eb1 <n100_private_lz4_compress_fast_continue+0x14c1>
    2bf7:	c6 01 00             	movb   $0x0,(%rcx)
    2bfa:	4c 8d 79 01          	lea    0x1(%rcx),%r15
    2bfe:	4c 89 ea             	mov    %r13,%rdx
    2c01:	4d 8d 4f 02          	lea    0x2(%r15),%r9
    2c05:	49 8d 75 04          	lea    0x4(%r13),%rsi
    2c09:	48 29 c2             	sub    %rax,%rdx
    2c0c:	66 41 89 17          	mov    %dx,(%r15)
    2c10:	48 3b 6c 24 40       	cmp    0x40(%rsp),%rbp
    2c15:	0f 84 d6 fe ff ff    	je     2af1 <n100_private_lz4_compress_fast_continue+0x1101>
    2c1b:	48 83 c0 04          	add    $0x4,%rax
    2c1f:	48 89 f2             	mov    %rsi,%rdx
    2c22:	48 3b 74 24 08       	cmp    0x8(%rsp),%rsi
    2c27:	0f 83 ab 00 00 00    	jae    2cd8 <n100_private_lz4_compress_fast_continue+0x12e8>
    2c2d:	48 8b 38             	mov    (%rax),%rdi
    2c30:	4c 8b 02             	mov    (%rdx),%r8
    2c33:	4c 39 c7             	cmp    %r8,%rdi
    2c36:	0f 84 89 00 00 00    	je     2cc5 <n100_private_lz4_compress_fast_continue+0x12d5>
    2c3c:	48 89 f8             	mov    %rdi,%rax
    2c3f:	4c 31 c0             	xor    %r8,%rax
    2c42:	f3 48 0f bc c0       	tzcnt  %rax,%rax
    2c47:	48 c1 e8 03          	shr    $0x3,%rax
    2c4b:	01 d0                	add    %edx,%eax
    2c4d:	29 f0                	sub    %esi,%eax
    2c4f:	8d 50 04             	lea    0x4(%rax),%edx
    2c52:	49 01 d5             	add    %rdx,%r13
    2c55:	e9 f6 fe ff ff       	jmp    2b50 <n100_private_lz4_compress_fast_continue+0x1160>
    2c5a:	4c 89 d5             	mov    %r10,%rbp
    2c5d:	31 db                	xor    %ebx,%ebx
    2c5f:	e9 63 ff ff ff       	jmp    2bc7 <n100_private_lz4_compress_fast_continue+0x11d7>
    2c64:	83 c2 0f             	add    $0xf,%edx
    2c67:	83 e8 0f             	sub    $0xf,%eax
    2c6a:	88 11                	mov    %dl,(%rcx)
    2c6c:	41 c7 47 02 ff ff ff 	movl   $0xffffffff,0x2(%r15)
    2c73:	ff 
    2c74:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    2c79:	76 17                	jbe    2c92 <n100_private_lz4_compress_fast_continue+0x12a2>
    2c7b:	2d fc 03 00 00       	sub    $0x3fc,%eax
    2c80:	49 83 c1 04          	add    $0x4,%r9
    2c84:	41 c7 01 ff ff ff ff 	movl   $0xffffffff,(%r9)
    2c8b:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    2c90:	77 e9                	ja     2c7b <n100_private_lz4_compress_fast_continue+0x128b>
    2c92:	89 c2                	mov    %eax,%edx
    2c94:	be 81 80 80 80       	mov    $0x80808081,%esi
    2c99:	48 0f af d6          	imul   %rsi,%rdx
    2c9d:	48 c1 ea 27          	shr    $0x27,%rdx
    2ca1:	89 d7                	mov    %edx,%edi
    2ca3:	89 d6                	mov    %edx,%esi
    2ca5:	c1 e7 08             	shl    $0x8,%edi
    2ca8:	49 8d 4c 31 01       	lea    0x1(%r9,%rsi,1),%rcx
    2cad:	29 d7                	sub    %edx,%edi
    2caf:	29 f8                	sub    %edi,%eax
    2cb1:	41 88 04 31          	mov    %al,(%r9,%rsi,1)
    2cb5:	e9 bf fe ff ff       	jmp    2b79 <n100_private_lz4_compress_fast_continue+0x1189>
    2cba:	4c 8b 24 24          	mov    (%rsp),%r12
    2cbe:	31 f6                	xor    %esi,%esi
    2cc0:	e9 50 f3 ff ff       	jmp    2015 <n100_private_lz4_compress_fast_continue+0x625>
    2cc5:	48 83 c2 08          	add    $0x8,%rdx
    2cc9:	48 83 c0 08          	add    $0x8,%rax
    2ccd:	48 3b 54 24 08       	cmp    0x8(%rsp),%rdx
    2cd2:	0f 82 55 ff ff ff    	jb     2c2d <n100_private_lz4_compress_fast_continue+0x123d>
    2cd8:	49 8d 7b f8          	lea    -0x8(%r11),%rdi
    2cdc:	48 39 fa             	cmp    %rdi,%rdx
    2cdf:	73 0e                	jae    2cef <n100_private_lz4_compress_fast_continue+0x12ff>
    2ce1:	8b 3a                	mov    (%rdx),%edi
    2ce3:	39 38                	cmp    %edi,(%rax)
    2ce5:	75 08                	jne    2cef <n100_private_lz4_compress_fast_continue+0x12ff>
    2ce7:	48 83 c2 04          	add    $0x4,%rdx
    2ceb:	48 83 c0 04          	add    $0x4,%rax
    2cef:	49 8d 7b fa          	lea    -0x6(%r11),%rdi
    2cf3:	48 39 fa             	cmp    %rdi,%rdx
    2cf6:	73 10                	jae    2d08 <n100_private_lz4_compress_fast_continue+0x1318>
    2cf8:	0f b7 3a             	movzwl (%rdx),%edi
    2cfb:	66 39 38             	cmp    %di,(%rax)
    2cfe:	75 08                	jne    2d08 <n100_private_lz4_compress_fast_continue+0x1318>
    2d00:	48 83 c2 02          	add    $0x2,%rdx
    2d04:	48 83 c0 02          	add    $0x2,%rax
    2d08:	48 3b 54 24 30       	cmp    0x30(%rsp),%rdx
    2d0d:	73 0f                	jae    2d1e <n100_private_lz4_compress_fast_continue+0x132e>
    2d0f:	0f b6 3a             	movzbl (%rdx),%edi
    2d12:	40 38 38             	cmp    %dil,(%rax)
    2d15:	0f 94 c0             	sete   %al
    2d18:	0f b6 c0             	movzbl %al,%eax
    2d1b:	48 01 c2             	add    %rax,%rdx
    2d1e:	89 d0                	mov    %edx,%eax
    2d20:	29 f0                	sub    %esi,%eax
    2d22:	e9 28 ff ff ff       	jmp    2c4f <n100_private_lz4_compress_fast_continue+0x125f>
    2d27:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    2d2c:	31 c0                	xor    %eax,%eax
    2d2e:	44 8b a9 00 10 00 00 	mov    0x1000(%rcx),%r13d
    2d35:	e9 4e f1 ff ff       	jmp    1e88 <n100_private_lz4_compress_fast_continue+0x498>
    2d3a:	48 83 c0 08          	add    $0x8,%rax
    2d3e:	48 83 c2 08          	add    $0x8,%rdx
    2d42:	48 39 e8             	cmp    %rbp,%rax
    2d45:	0f 82 d4 fd ff ff    	jb     2b1f <n100_private_lz4_compress_fast_continue+0x112f>
    2d4b:	4c 8d 47 fd          	lea    -0x3(%rdi),%r8
    2d4f:	4c 39 c0             	cmp    %r8,%rax
    2d52:	73 0e                	jae    2d62 <n100_private_lz4_compress_fast_continue+0x1372>
    2d54:	8b 18                	mov    (%rax),%ebx
    2d56:	39 1a                	cmp    %ebx,(%rdx)
    2d58:	75 08                	jne    2d62 <n100_private_lz4_compress_fast_continue+0x1372>
    2d5a:	48 83 c0 04          	add    $0x4,%rax
    2d5e:	48 83 c2 04          	add    $0x4,%rdx
    2d62:	4c 8d 47 ff          	lea    -0x1(%rdi),%r8
    2d66:	4c 39 c0             	cmp    %r8,%rax
    2d69:	73 10                	jae    2d7b <n100_private_lz4_compress_fast_continue+0x138b>
    2d6b:	0f b7 18             	movzwl (%rax),%ebx
    2d6e:	66 39 1a             	cmp    %bx,(%rdx)
    2d71:	75 08                	jne    2d7b <n100_private_lz4_compress_fast_continue+0x138b>
    2d73:	48 83 c0 02          	add    $0x2,%rax
    2d77:	48 83 c2 02          	add    $0x2,%rdx
    2d7b:	48 39 f8             	cmp    %rdi,%rax
    2d7e:	73 0e                	jae    2d8e <n100_private_lz4_compress_fast_continue+0x139e>
    2d80:	0f b6 18             	movzbl (%rax),%ebx
    2d83:	38 1a                	cmp    %bl,(%rdx)
    2d85:	0f 94 c2             	sete   %dl
    2d88:	0f b6 d2             	movzbl %dl,%edx
    2d8b:	48 01 d0             	add    %rdx,%rax
    2d8e:	29 f0                	sub    %esi,%eax
    2d90:	e9 ac fd ff ff       	jmp    2b41 <n100_private_lz4_compress_fast_continue+0x1151>
    2d95:	48 89 d8             	mov    %rbx,%rax
    2d98:	48 89 5c 24 40       	mov    %rbx,0x40(%rsp)
    2d9d:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    2da2:	49 89 f9             	mov    %rdi,%r9
    2da5:	48 2b 04 24          	sub    (%rsp),%rax
    2da9:	e9 3b f0 ff ff       	jmp    1de9 <n100_private_lz4_compress_fast_continue+0x3f9>
    2dae:	48 83 c2 08          	add    $0x8,%rdx
    2db2:	49 83 c1 08          	add    $0x8,%r9
    2db6:	4c 39 e2             	cmp    %r12,%rdx
    2db9:	0f 82 03 f9 ff ff    	jb     26c2 <n100_private_lz4_compress_fast_continue+0xcd2>
    2dbf:	4c 8b 5c 24 50       	mov    0x50(%rsp),%r11
    2dc4:	49 83 eb 08          	sub    $0x8,%r11
    2dc8:	4c 39 da             	cmp    %r11,%rdx
    2dcb:	73 10                	jae    2ddd <n100_private_lz4_compress_fast_continue+0x13ed>
    2dcd:	44 8b 1a             	mov    (%rdx),%r11d
    2dd0:	45 39 19             	cmp    %r11d,(%r9)
    2dd3:	75 08                	jne    2ddd <n100_private_lz4_compress_fast_continue+0x13ed>
    2dd5:	48 83 c2 04          	add    $0x4,%rdx
    2dd9:	49 83 c1 04          	add    $0x4,%r9
    2ddd:	4c 8b 5c 24 50       	mov    0x50(%rsp),%r11
    2de2:	49 83 eb 06          	sub    $0x6,%r11
    2de6:	4c 39 da             	cmp    %r11,%rdx
    2de9:	73 12                	jae    2dfd <n100_private_lz4_compress_fast_continue+0x140d>
    2deb:	44 0f b7 1a          	movzwl (%rdx),%r11d
    2def:	66 45 39 19          	cmp    %r11w,(%r9)
    2df3:	75 08                	jne    2dfd <n100_private_lz4_compress_fast_continue+0x140d>
    2df5:	48 83 c2 02          	add    $0x2,%rdx
    2df9:	49 83 c1 02          	add    $0x2,%r9
    2dfd:	48 3b 54 24 30       	cmp    0x30(%rsp),%rdx
    2e02:	73 09                	jae    2e0d <n100_private_lz4_compress_fast_continue+0x141d>
    2e04:	44 0f b6 1a          	movzbl (%rdx),%r11d
    2e08:	45 38 19             	cmp    %r11b,(%r9)
    2e0b:	74 2a                	je     2e37 <n100_private_lz4_compress_fast_continue+0x1447>
    2e0d:	29 fa                	sub    %edi,%edx
    2e0f:	e9 ce f8 ff ff       	jmp    26e2 <n100_private_lz4_compress_fast_continue+0xcf2>
    2e14:	48 83 ea 01          	sub    $0x1,%rdx
    2e18:	48 83 ef 01          	sub    $0x1,%rdi
    2e1c:	48 8d 04 2a          	lea    (%rdx,%rbp,1),%rax
    2e20:	49 39 c5             	cmp    %rax,%r13
    2e23:	0f 83 e5 f4 ff ff    	jae    230e <n100_private_lz4_compress_fast_continue+0x91e>
    2e29:	49 39 f9             	cmp    %rdi,%r9
    2e2c:	0f 82 ce f4 ff ff    	jb     2300 <n100_private_lz4_compress_fast_continue+0x910>
    2e32:	e9 d7 f4 ff ff       	jmp    230e <n100_private_lz4_compress_fast_continue+0x91e>
    2e37:	48 83 c2 01          	add    $0x1,%rdx
    2e3b:	29 fa                	sub    %edi,%edx
    2e3d:	e9 a0 f8 ff ff       	jmp    26e2 <n100_private_lz4_compress_fast_continue+0xcf2>
    2e42:	4c 89 ea             	mov    %r13,%rdx
    2e45:	4c 89 d6             	mov    %r10,%rsi
    2e48:	4c 3b 6c 24 08       	cmp    0x8(%rsp),%r13
    2e4d:	0f 83 9a 00 00 00    	jae    2eed <n100_private_lz4_compress_fast_continue+0x14fd>
    2e53:	48 8b 3e             	mov    (%rsi),%rdi
    2e56:	4c 8b 02             	mov    (%rdx),%r8
    2e59:	4c 39 c7             	cmp    %r8,%rdi
    2e5c:	74 7c                	je     2eda <n100_private_lz4_compress_fast_continue+0x14ea>
    2e5e:	48 89 fe             	mov    %rdi,%rsi
    2e61:	4c 31 c6             	xor    %r8,%rsi
    2e64:	f3 48 0f bc f6       	tzcnt  %rsi,%rsi
    2e69:	48 c1 ee 03          	shr    $0x3,%rsi
    2e6d:	01 f2                	add    %esi,%edx
    2e6f:	44 29 ea             	sub    %r13d,%edx
    2e72:	01 d0                	add    %edx,%eax
    2e74:	49 01 d5             	add    %rdx,%r13
    2e77:	e9 d4 fc ff ff       	jmp    2b50 <n100_private_lz4_compress_fast_continue+0x1160>
    2e7c:	8d 77 f1             	lea    -0xf(%rdi),%esi
    2e7f:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
    2e84:	c6 07 f0             	movb   $0xf0,(%rdi)
    2e87:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    2e8d:	7e 16                	jle    2ea5 <n100_private_lz4_compress_fast_continue+0x14b5>
    2e8f:	81 ee ff 00 00 00    	sub    $0xff,%esi
    2e95:	48 83 c2 01          	add    $0x1,%rdx
    2e99:	c6 42 ff ff          	movb   $0xff,-0x1(%rdx)
    2e9d:	81 fe fe 00 00 00    	cmp    $0xfe,%esi
    2ea3:	7f ea                	jg     2e8f <n100_private_lz4_compress_fast_continue+0x149f>
    2ea5:	40 88 32             	mov    %sil,(%rdx)
    2ea8:	48 83 c2 01          	add    $0x1,%rdx
    2eac:	e9 0e fc ff ff       	jmp    2abf <n100_private_lz4_compress_fast_continue+0x10cf>
    2eb1:	48 ba 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rdx
    2eb8:	bc 1b cf 
    2ebb:	49 0f af 55 01       	imul   0x1(%r13),%rdx
    2ec0:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    2ec5:	4d 89 ec             	mov    %r13,%r12
    2ec8:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    2ecd:	49 83 c5 01          	add    $0x1,%r13
    2ed1:	48 c1 ea 36          	shr    $0x36,%rdx
    2ed5:	e9 09 ed ff ff       	jmp    1be3 <n100_private_lz4_compress_fast_continue+0x1f3>
    2eda:	48 83 c2 08          	add    $0x8,%rdx
    2ede:	48 83 c6 08          	add    $0x8,%rsi
    2ee2:	48 3b 54 24 08       	cmp    0x8(%rsp),%rdx
    2ee7:	0f 82 66 ff ff ff    	jb     2e53 <n100_private_lz4_compress_fast_continue+0x1463>
    2eed:	49 8d 7b f8          	lea    -0x8(%r11),%rdi
    2ef1:	48 39 fa             	cmp    %rdi,%rdx
    2ef4:	73 0e                	jae    2f04 <n100_private_lz4_compress_fast_continue+0x1514>
    2ef6:	8b 3a                	mov    (%rdx),%edi
    2ef8:	39 3e                	cmp    %edi,(%rsi)
    2efa:	75 08                	jne    2f04 <n100_private_lz4_compress_fast_continue+0x1514>
    2efc:	48 83 c2 04          	add    $0x4,%rdx
    2f00:	48 83 c6 04          	add    $0x4,%rsi
    2f04:	49 8d 7b fa          	lea    -0x6(%r11),%rdi
    2f08:	48 39 fa             	cmp    %rdi,%rdx
    2f0b:	73 10                	jae    2f1d <n100_private_lz4_compress_fast_continue+0x152d>
    2f0d:	0f b7 3a             	movzwl (%rdx),%edi
    2f10:	66 39 3e             	cmp    %di,(%rsi)
    2f13:	75 08                	jne    2f1d <n100_private_lz4_compress_fast_continue+0x152d>
    2f15:	48 83 c2 02          	add    $0x2,%rdx
    2f19:	48 83 c6 02          	add    $0x2,%rsi
    2f1d:	48 3b 54 24 30       	cmp    0x30(%rsp),%rdx
    2f22:	73 0c                	jae    2f30 <n100_private_lz4_compress_fast_continue+0x1540>
    2f24:	0f b6 3a             	movzbl (%rdx),%edi
    2f27:	40 38 3e             	cmp    %dil,(%rsi)
    2f2a:	75 04                	jne    2f30 <n100_private_lz4_compress_fast_continue+0x1540>
    2f2c:	48 83 c2 01          	add    $0x1,%rdx
    2f30:	44 29 ea             	sub    %r13d,%edx
    2f33:	e9 3a ff ff ff       	jmp    2e72 <n100_private_lz4_compress_fast_continue+0x1482>
    2f38:	89 f2                	mov    %esi,%edx
    2f3a:	41 89 f0             	mov    %esi,%r8d
    2f3d:	49 89 d3             	mov    %rdx,%r11
    2f40:	49 f7 db             	neg    %r11
    2f43:	e9 f0 f2 ff ff       	jmp    2238 <n100_private_lz4_compress_fast_continue+0x848>
    2f48:	49 83 eb 01          	sub    $0x1,%r11
    2f4c:	48 83 e8 01          	sub    $0x1,%rax
    2f50:	4d 39 da             	cmp    %r11,%r10
    2f53:	0f 83 02 f8 ff ff    	jae    275b <n100_private_lz4_compress_fast_continue+0xd6b>
    2f59:	48 39 44 24 18       	cmp    %rax,0x18(%rsp)
    2f5e:	0f 82 e9 f7 ff ff    	jb     274d <n100_private_lz4_compress_fast_continue+0xd5d>
    2f64:	e9 f2 f7 ff ff       	jmp    275b <n100_private_lz4_compress_fast_continue+0xd6b>
    2f69:	48 b8 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rax
    2f70:	bc 1b cf 
    2f73:	49 0f af 43 01       	imul   0x1(%r11),%rax
    2f78:	4d 89 da             	mov    %r11,%r10
    2f7b:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    2f7f:	49 83 c3 01          	add    $0x1,%r11
    2f83:	48 c1 e8 36          	shr    $0x36,%rax
    2f87:	e9 a1 f1 ff ff       	jmp    212d <n100_private_lz4_compress_fast_continue+0x73d>
    2f8c:	4c 89 e6             	mov    %r12,%rsi
    2f8f:	4d 89 da             	mov    %r11,%r10
    2f92:	48 2b 34 24          	sub    (%rsp),%rsi
    2f96:	e9 19 f2 ff ff       	jmp    21b4 <n100_private_lz4_compress_fast_continue+0x7c4>
    2f9b:	48 89 c8             	mov    %rcx,%rax
    2f9e:	48 2b 04 24          	sub    (%rsp),%rax
    2fa2:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    2fa7:	4d 89 df             	mov    %r11,%r15
    2faa:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    2faf:	48 89 c6             	mov    %rax,%rsi
    2fb2:	4d 89 ec             	mov    %r13,%r12
    2fb5:	e9 b1 f2 ff ff       	jmp    226b <n100_private_lz4_compress_fast_continue+0x87b>
    2fba:	48 39 44 24 18       	cmp    %rax,0x18(%rsp)
    2fbf:	73 13                	jae    2fd4 <n100_private_lz4_compress_fast_continue+0x15e4>
    2fc1:	49 39 ea             	cmp    %rbp,%r10
    2fc4:	73 0e                	jae    2fd4 <n100_private_lz4_compress_fast_continue+0x15e4>
    2fc6:	0f b6 78 ff          	movzbl -0x1(%rax),%edi
    2fca:	40 38 7d ff          	cmp    %dil,-0x1(%rbp)
    2fce:	0f 84 9d 01 00 00    	je     3171 <n100_private_lz4_compress_fast_continue+0x1781>
    2fd4:	48 89 ef             	mov    %rbp,%rdi
    2fd7:	41 b8 81 80 80 80    	mov    $0x80808081,%r8d
    2fdd:	49 8d 54 24 01       	lea    0x1(%r12),%rdx
    2fe2:	4c 29 d7             	sub    %r10,%rdi
    2fe5:	89 fe                	mov    %edi,%esi
    2fe7:	4c 0f af c6          	imul   %rsi,%r8
    2feb:	49 c1 e8 27          	shr    $0x27,%r8
    2fef:	4e 8d 44 06 08       	lea    0x8(%rsi,%r8,1),%r8
    2ff4:	49 01 d0             	add    %rdx,%r8
    2ff7:	4c 39 44 24 28       	cmp    %r8,0x28(%rsp)
    2ffc:	0f 82 53 f5 ff ff    	jb     2555 <n100_private_lz4_compress_fast_continue+0xb65>
    3002:	83 ff 0e             	cmp    $0xe,%edi
    3005:	0f 87 87 01 00 00    	ja     3192 <n100_private_lz4_compress_fast_continue+0x17a2>
    300b:	c1 e7 04             	shl    $0x4,%edi
    300e:	41 88 3c 24          	mov    %dil,(%r12)
    3012:	48 01 d6             	add    %rdx,%rsi
    3015:	49 8b 3a             	mov    (%r10),%rdi
    3018:	48 83 c2 08          	add    $0x8,%rdx
    301c:	49 83 c2 08          	add    $0x8,%r10
    3020:	48 89 7a f8          	mov    %rdi,-0x8(%rdx)
    3024:	48 39 f2             	cmp    %rsi,%rdx
    3027:	72 ec                	jb     3015 <n100_private_lz4_compress_fast_continue+0x1625>
    3029:	49 ba 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%r10
    3030:	bc 1b cf 
    3033:	41 bb 81 80 80 80    	mov    $0x80808081,%r11d
    3039:	eb 77                	jmp    30b2 <n100_private_lz4_compress_fast_continue+0x16c2>
    303b:	01 c2                	add    %eax,%edx
    303d:	41 88 14 24          	mov    %dl,(%r12)
    3041:	4d 89 c4             	mov    %r8,%r12
    3044:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    3049:	0f 82 94 01 00 00    	jb     31e3 <n100_private_lz4_compress_fast_continue+0x17f3>
    304f:	48 8b 45 fe          	mov    -0x2(%rbp),%rax
    3053:	48 8d 55 fe          	lea    -0x2(%rbp),%rdx
    3057:	4c 29 f2             	sub    %r14,%rdx
    305a:	49 0f af c2          	imul   %r10,%rax
    305e:	48 c1 e8 36          	shr    $0x36,%rax
    3062:	89 14 81             	mov    %edx,(%rcx,%rax,4)
    3065:	48 8b 45 00          	mov    0x0(%rbp),%rax
    3069:	48 89 ea             	mov    %rbp,%rdx
    306c:	4c 29 f2             	sub    %r14,%rdx
    306f:	49 0f af c2          	imul   %r10,%rax
    3073:	48 c1 e8 36          	shr    $0x36,%rax
    3077:	48 8d 34 81          	lea    (%rcx,%rax,4),%rsi
    307b:	8b 06                	mov    (%rsi),%eax
    307d:	89 16                	mov    %edx,(%rsi)
    307f:	4c 01 f0             	add    %r14,%rax
    3082:	48 3b 44 24 18       	cmp    0x18(%rsp),%rax
    3087:	0f 82 37 01 00 00    	jb     31c4 <n100_private_lz4_compress_fast_continue+0x17d4>
    308d:	48 8d 90 ff ff 00 00 	lea    0xffff(%rax),%rdx
    3094:	48 39 ea             	cmp    %rbp,%rdx
    3097:	0f 82 27 01 00 00    	jb     31c4 <n100_private_lz4_compress_fast_continue+0x17d4>
    309d:	8b 7d 00             	mov    0x0(%rbp),%edi
    30a0:	39 38                	cmp    %edi,(%rax)
    30a2:	0f 85 1c 01 00 00    	jne    31c4 <n100_private_lz4_compress_fast_continue+0x17d4>
    30a8:	41 c6 04 24 00       	movb   $0x0,(%r12)
    30ad:	49 8d 74 24 01       	lea    0x1(%r12),%rsi
    30b2:	48 89 ea             	mov    %rbp,%rdx
    30b5:	4c 8d 4d 04          	lea    0x4(%rbp),%r9
    30b9:	4c 8d 46 02          	lea    0x2(%rsi),%r8
    30bd:	48 29 c2             	sub    %rax,%rdx
    30c0:	66 89 16             	mov    %dx,(%rsi)
    30c3:	48 8d 50 04          	lea    0x4(%rax),%rdx
    30c7:	4c 89 c8             	mov    %r9,%rax
    30ca:	4c 3b 4c 24 08       	cmp    0x8(%rsp),%r9
    30cf:	0f 83 30 01 00 00    	jae    3205 <n100_private_lz4_compress_fast_continue+0x1815>
    30d5:	48 8b 3a             	mov    (%rdx),%rdi
    30d8:	48 8b 18             	mov    (%rax),%rbx
    30db:	48 39 df             	cmp    %rbx,%rdi
    30de:	0f 84 0e 01 00 00    	je     31f2 <n100_private_lz4_compress_fast_continue+0x1802>
    30e4:	48 31 df             	xor    %rbx,%rdi
    30e7:	f3 48 0f bc d7       	tzcnt  %rdi,%rdx
    30ec:	48 c1 ea 03          	shr    $0x3,%rdx
    30f0:	01 d0                	add    %edx,%eax
    30f2:	44 29 c8             	sub    %r9d,%eax
    30f5:	89 c2                	mov    %eax,%edx
    30f7:	c1 ea 08             	shr    $0x8,%edx
    30fa:	83 c2 06             	add    $0x6,%edx
    30fd:	4c 01 c2             	add    %r8,%rdx
    3100:	48 39 54 24 28       	cmp    %rdx,0x28(%rsp)
    3105:	0f 82 4a f4 ff ff    	jb     2555 <n100_private_lz4_compress_fast_continue+0xb65>
    310b:	8d 50 04             	lea    0x4(%rax),%edx
    310e:	48 01 d5             	add    %rdx,%rbp
    3111:	41 0f b6 14 24       	movzbl (%r12),%edx
    3116:	83 f8 0e             	cmp    $0xe,%eax
    3119:	0f 86 1c ff ff ff    	jbe    303b <n100_private_lz4_compress_fast_continue+0x164b>
    311f:	83 c2 0f             	add    $0xf,%edx
    3122:	83 e8 0f             	sub    $0xf,%eax
    3125:	41 88 14 24          	mov    %dl,(%r12)
    3129:	c7 46 02 ff ff ff ff 	movl   $0xffffffff,0x2(%rsi)
    3130:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    3135:	76 17                	jbe    314e <n100_private_lz4_compress_fast_continue+0x175e>
    3137:	2d fc 03 00 00       	sub    $0x3fc,%eax
    313c:	49 83 c0 04          	add    $0x4,%r8
    3140:	41 c7 00 ff ff ff ff 	movl   $0xffffffff,(%r8)
    3147:	3d fb 03 00 00       	cmp    $0x3fb,%eax
    314c:	77 e9                	ja     3137 <n100_private_lz4_compress_fast_continue+0x1747>
    314e:	89 c2                	mov    %eax,%edx
    3150:	49 0f af d3          	imul   %r11,%rdx
    3154:	48 c1 ea 27          	shr    $0x27,%rdx
    3158:	89 d7                	mov    %edx,%edi
    315a:	89 d6                	mov    %edx,%esi
    315c:	c1 e7 08             	shl    $0x8,%edi
    315f:	4d 8d 64 30 01       	lea    0x1(%r8,%rsi,1),%r12
    3164:	29 d7                	sub    %edx,%edi
    3166:	29 f8                	sub    %edi,%eax
    3168:	41 88 04 30          	mov    %al,(%r8,%rsi,1)
    316c:	e9 d3 fe ff ff       	jmp    3044 <n100_private_lz4_compress_fast_continue+0x1654>
    3171:	48 83 ed 01          	sub    $0x1,%rbp
    3175:	48 83 e8 01          	sub    $0x1,%rax
    3179:	49 39 ea             	cmp    %rbp,%r10
    317c:	0f 83 52 fe ff ff    	jae    2fd4 <n100_private_lz4_compress_fast_continue+0x15e4>
    3182:	48 39 44 24 18       	cmp    %rax,0x18(%rsp)
    3187:	0f 82 39 fe ff ff    	jb     2fc6 <n100_private_lz4_compress_fast_continue+0x15d6>
    318d:	e9 42 fe ff ff       	jmp    2fd4 <n100_private_lz4_compress_fast_continue+0x15e4>
    3192:	83 ef 0f             	sub    $0xf,%edi
    3195:	41 c6 04 24 f0       	movb   $0xf0,(%r12)
    319a:	81 ff fe 00 00 00    	cmp    $0xfe,%edi
    31a0:	7e 16                	jle    31b8 <n100_private_lz4_compress_fast_continue+0x17c8>
    31a2:	81 ef ff 00 00 00    	sub    $0xff,%edi
    31a8:	48 83 c2 01          	add    $0x1,%rdx
    31ac:	c6 42 ff ff          	movb   $0xff,-0x1(%rdx)
    31b0:	81 ff fe 00 00 00    	cmp    $0xfe,%edi
    31b6:	7f ea                	jg     31a2 <n100_private_lz4_compress_fast_continue+0x17b2>
    31b8:	40 88 3a             	mov    %dil,(%rdx)
    31bb:	48 83 c2 01          	add    $0x1,%rdx
    31bf:	e9 4e fe ff ff       	jmp    3012 <n100_private_lz4_compress_fast_continue+0x1622>
    31c4:	48 bf 00 00 00 bb dc 	movabs $0xcf1bbcdcbb000000,%rdi
    31cb:	bc 1b cf 
    31ce:	48 0f af 7d 01       	imul   0x1(%rbp),%rdi
    31d3:	49 89 ea             	mov    %rbp,%r10
    31d6:	48 83 c5 01          	add    $0x1,%rbp
    31da:	48 c1 ef 36          	shr    $0x36,%rdi
    31de:	e9 ac ed ff ff       	jmp    1f8f <n100_private_lz4_compress_fast_continue+0x59f>
    31e3:	4c 89 e6             	mov    %r12,%rsi
    31e6:	49 89 ea             	mov    %rbp,%r10
    31e9:	48 2b 34 24          	sub    (%rsp),%rsi
    31ed:	e9 23 ee ff ff       	jmp    2015 <n100_private_lz4_compress_fast_continue+0x625>
    31f2:	48 83 c0 08          	add    $0x8,%rax
    31f6:	48 83 c2 08          	add    $0x8,%rdx
    31fa:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
    31ff:	0f 82 d0 fe ff ff    	jb     30d5 <n100_private_lz4_compress_fast_continue+0x16e5>
    3205:	49 8d 7f f8          	lea    -0x8(%r15),%rdi
    3209:	48 39 f8             	cmp    %rdi,%rax
    320c:	73 0e                	jae    321c <n100_private_lz4_compress_fast_continue+0x182c>
    320e:	8b 38                	mov    (%rax),%edi
    3210:	39 3a                	cmp    %edi,(%rdx)
    3212:	75 08                	jne    321c <n100_private_lz4_compress_fast_continue+0x182c>
    3214:	48 83 c0 04          	add    $0x4,%rax
    3218:	48 83 c2 04          	add    $0x4,%rdx
    321c:	49 8d 7f fa          	lea    -0x6(%r15),%rdi
    3220:	48 39 f8             	cmp    %rdi,%rax
    3223:	73 10                	jae    3235 <n100_private_lz4_compress_fast_continue+0x1845>
    3225:	0f b7 38             	movzwl (%rax),%edi
    3228:	66 39 3a             	cmp    %di,(%rdx)
    322b:	75 08                	jne    3235 <n100_private_lz4_compress_fast_continue+0x1845>
    322d:	48 83 c0 02          	add    $0x2,%rax
    3231:	48 83 c2 02          	add    $0x2,%rdx
    3235:	48 3b 44 24 30       	cmp    0x30(%rsp),%rax
    323a:	73 0c                	jae    3248 <n100_private_lz4_compress_fast_continue+0x1858>
    323c:	0f b6 38             	movzbl (%rax),%edi
    323f:	40 38 3a             	cmp    %dil,(%rdx)
    3242:	75 04                	jne    3248 <n100_private_lz4_compress_fast_continue+0x1858>
    3244:	48 83 c0 01          	add    $0x1,%rax
    3248:	44 29 c8             	sub    %r9d,%eax
    324b:	e9 a5 fe ff ff       	jmp    30f5 <n100_private_lz4_compress_fast_continue+0x1705>
    3250:	83 ef 0f             	sub    $0xf,%edi
    3253:	41 c6 04 24 f0       	movb   $0xf0,(%r12)
    3258:	81 ff fe 00 00 00    	cmp    $0xfe,%edi
    325e:	7e 16                	jle    3276 <n100_private_lz4_compress_fast_continue+0x1886>
    3260:	81 ef ff 00 00 00    	sub    $0xff,%edi
    3266:	48 83 c2 01          	add    $0x1,%rdx
    326a:	c6 42 ff ff          	movb   $0xff,-0x1(%rdx)
    326e:	81 ff fe 00 00 00    	cmp    $0xfe,%edi
    3274:	7f ea                	jg     3260 <n100_private_lz4_compress_fast_continue+0x1870>
    3276:	40 88 3a             	mov    %dil,(%rdx)
    3279:	48 83 c2 01          	add    $0x1,%rdx
    327d:	e9 17 f5 ff ff       	jmp    2799 <n100_private_lz4_compress_fast_continue+0xda9>
    3282:	48 83 e8 01          	sub    $0x1,%rax
    3286:	49 83 ed 01          	sub    $0x1,%r13
    328a:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    328e:	48 39 d5             	cmp    %rdx,%rbp
    3291:	0f 82 ce f7 ff ff    	jb     2a65 <n100_private_lz4_compress_fast_continue+0x1075>
    3297:	e9 dd f7 ff ff       	jmp    2a79 <n100_private_lz4_compress_fast_continue+0x1089>
