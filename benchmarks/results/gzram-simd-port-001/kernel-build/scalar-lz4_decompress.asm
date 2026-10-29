
/home/dan/n100-zram/build/astra-simd-kernel-002/scalar/lz4_decompress.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <n100_private_lz4_decompress_safe_withPrefix64k-0x10>:
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

0000000000000010 <n100_private_lz4_decompress_safe_withPrefix64k>:
      10:	e8 00 00 00 00       	call   15 <n100_private_lz4_decompress_safe_withPrefix64k+0x5>
      15:	85 c9                	test   %ecx,%ecx
      17:	0f 84 6d 02 00 00    	je     28a <n100_private_lz4_decompress_safe_withPrefix64k+0x27a>
      1d:	85 d2                	test   %edx,%edx
      1f:	0f 84 6a 02 00 00    	je     28f <n100_private_lz4_decompress_safe_withPrefix64k+0x27f>
      25:	48 83 ec 68          	sub    $0x68,%rsp
      29:	48 63 d2             	movslq %edx,%rdx
      2c:	48 63 c9             	movslq %ecx,%rcx
      2f:	48 89 f0             	mov    %rsi,%rax
      32:	4c 89 74 24 58       	mov    %r14,0x58(%rsp)
      37:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
      3b:	48 01 f1             	add    %rsi,%rcx
      3e:	49 89 f9             	mov    %rdi,%r9
      41:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
      46:	48 89 f3             	mov    %rsi,%rbx
      49:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
      4e:	48 89 fd             	mov    %rdi,%rbp
      51:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
      56:	4d 8d 60 f0          	lea    -0x10(%r8),%r12
      5a:	4c 89 6c 24 50       	mov    %r13,0x50(%rsp)
      5f:	4c 8d 69 e0          	lea    -0x20(%rcx),%r13
      63:	41 0f b6 11          	movzbl (%r9),%edx
      67:	49 8d 71 01          	lea    0x1(%r9),%rsi
      6b:	89 d7                	mov    %edx,%edi
      6d:	c1 ea 04             	shr    $0x4,%edx
      70:	83 fa 0f             	cmp    $0xf,%edx
      73:	74 74                	je     e9 <n100_private_lz4_decompress_safe_withPrefix64k+0xd9>
      75:	4c 39 e6             	cmp    %r12,%rsi
      78:	0f 83 1b 02 00 00    	jae    299 <n100_private_lz4_decompress_safe_withPrefix64k+0x289>
      7e:	49 39 c5             	cmp    %rax,%r13
      81:	0f 82 12 02 00 00    	jb     299 <n100_private_lz4_decompress_safe_withPrefix64k+0x289>
      87:	4d 8b 49 01          	mov    0x1(%r9),%r9
      8b:	4c 8d 34 16          	lea    (%rsi,%rdx,1),%r14
      8f:	49 89 fb             	mov    %rdi,%r11
      92:	4c 8d 14 10          	lea    (%rax,%rdx,1),%r10
      96:	f7 d7                	not    %edi
      98:	41 83 e3 0f          	and    $0xf,%r11d
      9c:	4c 89 08             	mov    %r9,(%rax)
      9f:	48 8b 76 08          	mov    0x8(%rsi),%rsi
      a3:	4d 8d 4e 02          	lea    0x2(%r14),%r9
      a7:	48 89 70 08          	mov    %rsi,0x8(%rax)
      ab:	41 0f b7 36          	movzwl (%r14),%esi
      af:	48 29 f2             	sub    %rsi,%rdx
      b2:	48 01 c2             	add    %rax,%rdx
      b5:	83 e7 0f             	and    $0xf,%edi
      b8:	0f 84 0b 01 00 00    	je     1c9 <n100_private_lz4_decompress_safe_withPrefix64k+0x1b9>
      be:	48 83 fe 07          	cmp    $0x7,%rsi
      c2:	0f 86 01 01 00 00    	jbe    1c9 <n100_private_lz4_decompress_safe_withPrefix64k+0x1b9>
      c8:	48 8b 02             	mov    (%rdx),%rax
      cb:	49 89 02             	mov    %rax,(%r10)
      ce:	48 8b 42 08          	mov    0x8(%rdx),%rax
      d2:	49 89 42 08          	mov    %rax,0x8(%r10)
      d6:	0f b7 42 10          	movzwl 0x10(%rdx),%eax
      da:	66 41 89 42 10       	mov    %ax,0x10(%r10)
      df:	4b 8d 44 1a 04       	lea    0x4(%r10,%r11,1),%rax
      e4:	e9 7a ff ff ff       	jmp    63 <n100_private_lz4_decompress_safe_withPrefix64k+0x53>
      e9:	4d 8d 58 f1          	lea    -0xf(%r8),%r11
      ed:	4c 39 de             	cmp    %r11,%rsi
      f0:	0f 83 88 01 00 00    	jae    27e <n100_private_lz4_decompress_safe_withPrefix64k+0x26e>
      f6:	ba 0f 00 00 00       	mov    $0xf,%edx
      fb:	eb 09                	jmp    106 <n100_private_lz4_decompress_safe_withPrefix64k+0xf6>
      fd:	0f 1f 00             	nopl   (%rax)
     100:	41 80 fa ff          	cmp    $0xff,%r10b
     104:	75 10                	jne    116 <n100_private_lz4_decompress_safe_withPrefix64k+0x106>
     106:	44 0f b6 16          	movzbl (%rsi),%r10d
     10a:	48 83 c6 01          	add    $0x1,%rsi
     10e:	4c 01 d2             	add    %r10,%rdx
     111:	49 39 f3             	cmp    %rsi,%r11
     114:	75 ea                	jne    100 <n100_private_lz4_decompress_safe_withPrefix64k+0xf0>
     116:	49 89 c6             	mov    %rax,%r14
     119:	4c 8d 1c 02          	lea    (%rdx,%rax,1),%r11
     11d:	49 01 d6             	add    %rdx,%r14
     120:	0f 82 58 01 00 00    	jb     27e <n100_private_lz4_decompress_safe_withPrefix64k+0x26e>
     126:	49 89 f6             	mov    %rsi,%r14
     129:	4c 8d 0c 32          	lea    (%rdx,%rsi,1),%r9
     12d:	49 01 d6             	add    %rdx,%r14
     130:	0f 82 48 01 00 00    	jb     27e <n100_private_lz4_decompress_safe_withPrefix64k+0x26e>
     136:	4c 8d 71 f4          	lea    -0xc(%rcx),%r14
     13a:	4d 89 da             	mov    %r11,%r10
     13d:	4d 39 de             	cmp    %r11,%r14
     140:	73 45                	jae    187 <n100_private_lz4_decompress_safe_withPrefix64k+0x177>
     142:	4d 39 c8             	cmp    %r9,%r8
     145:	0f 85 33 01 00 00    	jne    27e <n100_private_lz4_decompress_safe_withPrefix64k+0x26e>
     14b:	4c 39 d9             	cmp    %r11,%rcx
     14e:	0f 82 2a 01 00 00    	jb     27e <n100_private_lz4_decompress_safe_withPrefix64k+0x26e>
     154:	48 89 c7             	mov    %rax,%rdi
     157:	4c 89 1c 24          	mov    %r11,(%rsp)
     15b:	e8 00 00 00 00       	call   160 <n100_private_lz4_decompress_safe_withPrefix64k+0x150>
     160:	8b 04 24             	mov    (%rsp),%eax
     163:	29 d8                	sub    %ebx,%eax
     165:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
     16a:	48 8b 6c 24 40       	mov    0x40(%rsp),%rbp
     16f:	4c 8b 64 24 48       	mov    0x48(%rsp),%r12
     174:	4c 8b 6c 24 50       	mov    0x50(%rsp),%r13
     179:	4c 8b 74 24 58       	mov    0x58(%rsp),%r14
     17e:	48 83 c4 68          	add    $0x68,%rsp
     182:	e9 00 00 00 00       	jmp    187 <n100_private_lz4_decompress_safe_withPrefix64k+0x177>
     187:	4d 8d 70 f8          	lea    -0x8(%r8),%r14
     18b:	4d 39 ce             	cmp    %r9,%r14
     18e:	72 b2                	jb     142 <n100_private_lz4_decompress_safe_withPrefix64k+0x132>
     190:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     195:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     19c:	00 00 00 00 
     1a0:	48 8b 16             	mov    (%rsi),%rdx
     1a3:	48 83 c0 08          	add    $0x8,%rax
     1a7:	48 83 c6 08          	add    $0x8,%rsi
     1ab:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
     1af:	4c 39 d8             	cmp    %r11,%rax
     1b2:	72 ec                	jb     1a0 <n100_private_lz4_decompress_safe_withPrefix64k+0x190>
     1b4:	41 0f b7 31          	movzwl (%r9),%esi
     1b8:	4c 89 da             	mov    %r11,%rdx
     1bb:	49 89 fb             	mov    %rdi,%r11
     1be:	49 83 c1 02          	add    $0x2,%r9
     1c2:	41 83 e3 0f          	and    $0xf,%r11d
     1c6:	48 29 f2             	sub    %rsi,%rdx
     1c9:	48 8d 83 00 00 ff ff 	lea    -0x10000(%rbx),%rax
     1d0:	48 39 c2             	cmp    %rax,%rdx
     1d3:	0f 82 a2 00 00 00    	jb     27b <n100_private_lz4_decompress_safe_withPrefix64k+0x26b>
     1d9:	41 89 32             	mov    %esi,(%r10)
     1dc:	49 83 fb 0f          	cmp    $0xf,%r11
     1e0:	74 77                	je     259 <n100_private_lz4_decompress_safe_withPrefix64k+0x249>
     1e2:	4d 8d 73 04          	lea    0x4(%r11),%r14
     1e6:	4b 8d 04 32          	lea    (%r10,%r14,1),%rax
     1ea:	48 83 fe 07          	cmp    $0x7,%rsi
     1ee:	0f 86 be 00 00 00    	jbe    2b2 <n100_private_lz4_decompress_safe_withPrefix64k+0x2a2>
     1f4:	48 8b 32             	mov    (%rdx),%rsi
     1f7:	48 83 c2 08          	add    $0x8,%rdx
     1fb:	49 89 32             	mov    %rsi,(%r10)
     1fe:	48 8d 71 f4          	lea    -0xc(%rcx),%rsi
     202:	48 39 c6             	cmp    %rax,%rsi
     205:	0f 82 f9 00 00 00    	jb     304 <n100_private_lz4_decompress_safe_withPrefix64k+0x2f4>
     20b:	48 8b 32             	mov    (%rdx),%rsi
     20e:	49 89 72 08          	mov    %rsi,0x8(%r10)
     212:	49 83 fe 10          	cmp    $0x10,%r14
     216:	0f 86 47 fe ff ff    	jbe    63 <n100_private_lz4_decompress_safe_withPrefix64k+0x53>
     21c:	48 83 c2 08          	add    $0x8,%rdx
     220:	49 83 c2 10          	add    $0x10,%r10
     224:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     22a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     231:	00 00 00 00 
     235:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     23c:	00 00 00 00 
     240:	48 8b 32             	mov    (%rdx),%rsi
     243:	49 83 c2 08          	add    $0x8,%r10
     247:	48 83 c2 08          	add    $0x8,%rdx
     24b:	49 89 72 f8          	mov    %rsi,-0x8(%r10)
     24f:	49 39 c2             	cmp    %rax,%r10
     252:	72 ec                	jb     240 <n100_private_lz4_decompress_safe_withPrefix64k+0x230>
     254:	e9 0a fe ff ff       	jmp    63 <n100_private_lz4_decompress_safe_withPrefix64k+0x53>
     259:	4d 8d 70 fb          	lea    -0x5(%r8),%r14
     25d:	eb 13                	jmp    272 <n100_private_lz4_decompress_safe_withPrefix64k+0x262>
     25f:	90                   	nop
     260:	41 0f b6 79 ff       	movzbl -0x1(%r9),%edi
     265:	49 01 fb             	add    %rdi,%r11
     268:	40 80 ff ff          	cmp    $0xff,%dil
     26c:	0f 85 e4 00 00 00    	jne    356 <n100_private_lz4_decompress_safe_withPrefix64k+0x346>
     272:	49 83 c1 01          	add    $0x1,%r9
     276:	4d 39 ce             	cmp    %r9,%r14
     279:	73 e5                	jae    260 <n100_private_lz4_decompress_safe_withPrefix64k+0x250>
     27b:	4c 89 ce             	mov    %r9,%rsi
     27e:	48 29 ee             	sub    %rbp,%rsi
     281:	89 f0                	mov    %esi,%eax
     283:	f7 d0                	not    %eax
     285:	e9 db fe ff ff       	jmp    165 <n100_private_lz4_decompress_safe_withPrefix64k+0x155>
     28a:	83 fa 01             	cmp    $0x1,%edx
     28d:	74 17                	je     2a6 <n100_private_lz4_decompress_safe_withPrefix64k+0x296>
     28f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     294:	e9 00 00 00 00       	jmp    299 <n100_private_lz4_decompress_safe_withPrefix64k+0x289>
     299:	4c 8d 1c 10          	lea    (%rax,%rdx,1),%r11
     29d:	4c 8d 0c 16          	lea    (%rsi,%rdx,1),%r9
     2a1:	e9 90 fe ff ff       	jmp    136 <n100_private_lz4_decompress_safe_withPrefix64k+0x126>
     2a6:	0f b6 07             	movzbl (%rdi),%eax
     2a9:	f6 d8                	neg    %al
     2ab:	19 c0                	sbb    %eax,%eax
     2ad:	e9 00 00 00 00       	jmp    2b2 <n100_private_lz4_decompress_safe_withPrefix64k+0x2a2>
     2b2:	0f b6 3a             	movzbl (%rdx),%edi
     2b5:	41 88 3a             	mov    %dil,(%r10)
     2b8:	0f b6 7a 01          	movzbl 0x1(%rdx),%edi
     2bc:	41 88 7a 01          	mov    %dil,0x1(%r10)
     2c0:	0f b6 7a 02          	movzbl 0x2(%rdx),%edi
     2c4:	41 88 7a 02          	mov    %dil,0x2(%r10)
     2c8:	0f b6 7a 03          	movzbl 0x3(%rdx),%edi
     2cc:	41 88 7a 03          	mov    %dil,0x3(%r10)
     2d0:	48 83 fe 08          	cmp    $0x8,%rsi
     2d4:	0f 83 20 01 00 00    	jae    3fa <n100_private_lz4_decompress_safe_withPrefix64k+0x3ea>
     2da:	8b 3c b5 00 00 00 00 	mov    0x0(,%rsi,4),%edi
     2e1:	48 01 fa             	add    %rdi,%rdx
     2e4:	8b 3a                	mov    (%rdx),%edi
     2e6:	41 89 7a 04          	mov    %edi,0x4(%r10)
     2ea:	48 83 fe 08          	cmp    $0x8,%rsi
     2ee:	0f 83 b1 00 00 00    	jae    3a5 <n100_private_lz4_decompress_safe_withPrefix64k+0x395>
     2f4:	48 63 34 b5 00 00 00 	movslq 0x0(,%rsi,4),%rsi
     2fb:	00 
     2fc:	48 29 f2             	sub    %rsi,%rdx
     2ff:	e9 fa fe ff ff       	jmp    1fe <n100_private_lz4_decompress_safe_withPrefix64k+0x1ee>
     304:	48 8d 71 fb          	lea    -0x5(%rcx),%rsi
     308:	48 39 c6             	cmp    %rax,%rsi
     30b:	0f 82 6a ff ff ff    	jb     27b <n100_private_lz4_decompress_safe_withPrefix64k+0x26b>
     311:	49 83 c2 08          	add    $0x8,%r10
     315:	4c 8d 59 f9          	lea    -0x7(%rcx),%r11
     319:	4d 39 da             	cmp    %r11,%r10
     31c:	72 49                	jb     367 <n100_private_lz4_decompress_safe_withPrefix64k+0x357>
     31e:	49 89 c3             	mov    %rax,%r11
     321:	31 f6                	xor    %esi,%esi
     323:	4d 29 d3             	sub    %r10,%r11
     326:	49 39 c2             	cmp    %rax,%r10
     329:	0f 83 34 fd ff ff    	jae    63 <n100_private_lz4_decompress_safe_withPrefix64k+0x53>
     32f:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     335:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     33c:	00 00 00 00 
     340:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
     344:	41 88 3c 32          	mov    %dil,(%r10,%rsi,1)
     348:	48 83 c6 01          	add    $0x1,%rsi
     34c:	4c 39 de             	cmp    %r11,%rsi
     34f:	75 ef                	jne    340 <n100_private_lz4_decompress_safe_withPrefix64k+0x330>
     351:	e9 0d fd ff ff       	jmp    63 <n100_private_lz4_decompress_safe_withPrefix64k+0x53>
     356:	4c 89 d0             	mov    %r10,%rax
     359:	4c 01 d8             	add    %r11,%rax
     35c:	0f 83 80 fe ff ff    	jae    1e2 <n100_private_lz4_decompress_safe_withPrefix64k+0x1d2>
     362:	e9 14 ff ff ff       	jmp    27b <n100_private_lz4_decompress_safe_withPrefix64k+0x26b>
     367:	48 89 d7             	mov    %rdx,%rdi
     36a:	4c 89 d6             	mov    %r10,%rsi
     36d:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     374:	00 
     375:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     37c:	00 00 00 00 
     380:	4c 8b 37             	mov    (%rdi),%r14
     383:	48 83 c6 08          	add    $0x8,%rsi
     387:	48 83 c7 08          	add    $0x8,%rdi
     38b:	4c 89 76 f8          	mov    %r14,-0x8(%rsi)
     38f:	4c 39 de             	cmp    %r11,%rsi
     392:	72 ec                	jb     380 <n100_private_lz4_decompress_safe_withPrefix64k+0x370>
     394:	4c 89 de             	mov    %r11,%rsi
     397:	4c 29 d6             	sub    %r10,%rsi
     39a:	4d 89 da             	mov    %r11,%r10
     39d:	48 01 f2             	add    %rsi,%rdx
     3a0:	e9 79 ff ff ff       	jmp    31e <n100_private_lz4_decompress_safe_withPrefix64k+0x30e>
     3a5:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     3ac:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
     3b1:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
     3b6:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
     3bb:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     3c0:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
     3c5:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
     3ca:	48 89 34 24          	mov    %rsi,(%rsp)
     3ce:	e8 00 00 00 00       	call   3d3 <n100_private_lz4_decompress_safe_withPrefix64k+0x3c3>
     3d3:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
     3d8:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
     3dd:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
     3e2:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     3e7:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
     3ec:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
     3f1:	48 8b 34 24          	mov    (%rsp),%rsi
     3f5:	e9 fa fe ff ff       	jmp    2f4 <n100_private_lz4_decompress_safe_withPrefix64k+0x2e4>
     3fa:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     401:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
     406:	4c 89 54 24 28       	mov    %r10,0x28(%rsp)
     40b:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
     410:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     415:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
     41a:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
     41f:	48 89 34 24          	mov    %rsi,(%rsp)
     423:	e8 00 00 00 00       	call   428 <n100_private_lz4_decompress_safe_withPrefix64k+0x418>
     428:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
     42d:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
     432:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
     437:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     43c:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
     441:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
     446:	48 8b 34 24          	mov    (%rsp),%rsi
     44a:	e9 8b fe ff ff       	jmp    2da <n100_private_lz4_decompress_safe_withPrefix64k+0x2ca>
     44f:	90                   	nop
     450:	90                   	nop
     451:	90                   	nop
     452:	90                   	nop
     453:	90                   	nop
     454:	90                   	nop
     455:	90                   	nop
     456:	90                   	nop
     457:	90                   	nop
     458:	90                   	nop
     459:	90                   	nop
     45a:	90                   	nop
     45b:	90                   	nop
     45c:	90                   	nop
     45d:	90                   	nop
     45e:	90                   	nop
     45f:	90                   	nop

0000000000000460 <n100_private_lz4_decompress_safe_withSmallPrefix>:
     460:	e8 00 00 00 00       	call   465 <n100_private_lz4_decompress_safe_withSmallPrefix+0x5>
     465:	85 c9                	test   %ecx,%ecx
     467:	0f 84 49 02 00 00    	je     6b6 <n100_private_lz4_decompress_safe_withSmallPrefix+0x256>
     46d:	85 d2                	test   %edx,%edx
     46f:	0f 84 46 02 00 00    	je     6bb <n100_private_lz4_decompress_safe_withSmallPrefix+0x25b>
     475:	41 57                	push   %r15
     477:	48 63 c9             	movslq %ecx,%rcx
     47a:	48 63 d2             	movslq %edx,%rdx
     47d:	48 89 f0             	mov    %rsi,%rax
     480:	41 56                	push   %r14
     482:	4c 8d 0c 17          	lea    (%rdi,%rdx,1),%r9
     486:	41 55                	push   %r13
     488:	4d 8d 69 f0          	lea    -0x10(%r9),%r13
     48c:	41 54                	push   %r12
     48e:	49 89 f4             	mov    %rsi,%r12
     491:	55                   	push   %rbp
     492:	4d 29 c4             	sub    %r8,%r12
     495:	4c 8d 04 0e          	lea    (%rsi,%rcx,1),%r8
     499:	48 89 fd             	mov    %rdi,%rbp
     49c:	53                   	push   %rbx
     49d:	4d 8d 78 e0          	lea    -0x20(%r8),%r15
     4a1:	48 89 f3             	mov    %rsi,%rbx
     4a4:	48 89 f9             	mov    %rdi,%rcx
     4a7:	48 83 ec 38          	sub    $0x38,%rsp
     4ab:	0f b6 11             	movzbl (%rcx),%edx
     4ae:	48 8d 71 01          	lea    0x1(%rcx),%rsi
     4b2:	89 d7                	mov    %edx,%edi
     4b4:	c1 ea 04             	shr    $0x4,%edx
     4b7:	83 fa 0f             	cmp    $0xf,%edx
     4ba:	74 7d                	je     539 <n100_private_lz4_decompress_safe_withSmallPrefix+0xd9>
     4bc:	4c 39 ee             	cmp    %r13,%rsi
     4bf:	0f 83 00 02 00 00    	jae    6c5 <n100_private_lz4_decompress_safe_withSmallPrefix+0x265>
     4c5:	49 39 c7             	cmp    %rax,%r15
     4c8:	0f 82 f7 01 00 00    	jb     6c5 <n100_private_lz4_decompress_safe_withSmallPrefix+0x265>
     4ce:	48 8b 49 01          	mov    0x1(%rcx),%rcx
     4d2:	4c 8d 34 16          	lea    (%rsi,%rdx,1),%r14
     4d6:	49 89 fb             	mov    %rdi,%r11
     4d9:	4c 8d 14 10          	lea    (%rax,%rdx,1),%r10
     4dd:	f7 d7                	not    %edi
     4df:	41 83 e3 0f          	and    $0xf,%r11d
     4e3:	48 89 08             	mov    %rcx,(%rax)
     4e6:	48 8b 4e 08          	mov    0x8(%rsi),%rcx
     4ea:	48 89 48 08          	mov    %rcx,0x8(%rax)
     4ee:	41 0f b7 36          	movzwl (%r14),%esi
     4f2:	49 8d 4e 02          	lea    0x2(%r14),%rcx
     4f6:	48 29 f2             	sub    %rsi,%rdx
     4f9:	48 01 c2             	add    %rax,%rdx
     4fc:	83 e7 0f             	and    $0xf,%edi
     4ff:	0f 84 23 01 00 00    	je     628 <n100_private_lz4_decompress_safe_withSmallPrefix+0x1c8>
     505:	48 83 fe 07          	cmp    $0x7,%rsi
     509:	0f 86 19 01 00 00    	jbe    628 <n100_private_lz4_decompress_safe_withSmallPrefix+0x1c8>
     50f:	4c 39 e2             	cmp    %r12,%rdx
     512:	0f 82 84 01 00 00    	jb     69c <n100_private_lz4_decompress_safe_withSmallPrefix+0x23c>
     518:	48 8b 02             	mov    (%rdx),%rax
     51b:	49 89 02             	mov    %rax,(%r10)
     51e:	48 8b 42 08          	mov    0x8(%rdx),%rax
     522:	49 89 42 08          	mov    %rax,0x8(%r10)
     526:	0f b7 42 10          	movzwl 0x10(%rdx),%eax
     52a:	66 41 89 42 10       	mov    %ax,0x10(%r10)
     52f:	4b 8d 44 1a 04       	lea    0x4(%r10,%r11,1),%rax
     534:	e9 72 ff ff ff       	jmp    4ab <n100_private_lz4_decompress_safe_withSmallPrefix+0x4b>
     539:	4d 8d 59 f1          	lea    -0xf(%r9),%r11
     53d:	4c 39 de             	cmp    %r11,%rsi
     540:	0f 83 53 01 00 00    	jae    699 <n100_private_lz4_decompress_safe_withSmallPrefix+0x239>
     546:	ba 0f 00 00 00       	mov    $0xf,%edx
     54b:	eb 19                	jmp    566 <n100_private_lz4_decompress_safe_withSmallPrefix+0x106>
     54d:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     554:	00 
     555:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     55c:	00 00 00 00 
     560:	41 80 fa ff          	cmp    $0xff,%r10b
     564:	75 10                	jne    576 <n100_private_lz4_decompress_safe_withSmallPrefix+0x116>
     566:	44 0f b6 16          	movzbl (%rsi),%r10d
     56a:	48 83 c6 01          	add    $0x1,%rsi
     56e:	4c 01 d2             	add    %r10,%rdx
     571:	49 39 f3             	cmp    %rsi,%r11
     574:	75 ea                	jne    560 <n100_private_lz4_decompress_safe_withSmallPrefix+0x100>
     576:	48 89 c1             	mov    %rax,%rcx
     579:	4c 8d 1c 02          	lea    (%rdx,%rax,1),%r11
     57d:	48 01 d1             	add    %rdx,%rcx
     580:	0f 82 13 01 00 00    	jb     699 <n100_private_lz4_decompress_safe_withSmallPrefix+0x239>
     586:	49 89 f6             	mov    %rsi,%r14
     589:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
     58d:	49 01 d6             	add    %rdx,%r14
     590:	0f 82 03 01 00 00    	jb     699 <n100_private_lz4_decompress_safe_withSmallPrefix+0x239>
     596:	4d 8d 70 f4          	lea    -0xc(%r8),%r14
     59a:	4d 89 da             	mov    %r11,%r10
     59d:	4d 39 de             	cmp    %r11,%r14
     5a0:	73 36                	jae    5d8 <n100_private_lz4_decompress_safe_withSmallPrefix+0x178>
     5a2:	49 39 c9             	cmp    %rcx,%r9
     5a5:	0f 85 ee 00 00 00    	jne    699 <n100_private_lz4_decompress_safe_withSmallPrefix+0x239>
     5ab:	4d 39 d8             	cmp    %r11,%r8
     5ae:	0f 82 e5 00 00 00    	jb     699 <n100_private_lz4_decompress_safe_withSmallPrefix+0x239>
     5b4:	48 89 c7             	mov    %rax,%rdi
     5b7:	4c 89 1c 24          	mov    %r11,(%rsp)
     5bb:	e8 00 00 00 00       	call   5c0 <n100_private_lz4_decompress_safe_withSmallPrefix+0x160>
     5c0:	8b 04 24             	mov    (%rsp),%eax
     5c3:	48 83 c4 38          	add    $0x38,%rsp
     5c7:	29 d8                	sub    %ebx,%eax
     5c9:	5b                   	pop    %rbx
     5ca:	5d                   	pop    %rbp
     5cb:	41 5c                	pop    %r12
     5cd:	41 5d                	pop    %r13
     5cf:	41 5e                	pop    %r14
     5d1:	41 5f                	pop    %r15
     5d3:	e9 00 00 00 00       	jmp    5d8 <n100_private_lz4_decompress_safe_withSmallPrefix+0x178>
     5d8:	4d 8d 71 f8          	lea    -0x8(%r9),%r14
     5dc:	49 39 ce             	cmp    %rcx,%r14
     5df:	72 c1                	jb     5a2 <n100_private_lz4_decompress_safe_withSmallPrefix+0x142>
     5e1:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
     5e8:	00 00 
     5ea:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     5f1:	00 00 00 00 
     5f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     5fc:	00 00 00 00 
     600:	48 8b 16             	mov    (%rsi),%rdx
     603:	48 83 c0 08          	add    $0x8,%rax
     607:	48 83 c6 08          	add    $0x8,%rsi
     60b:	48 89 50 f8          	mov    %rdx,-0x8(%rax)
     60f:	4c 39 d8             	cmp    %r11,%rax
     612:	72 ec                	jb     600 <n100_private_lz4_decompress_safe_withSmallPrefix+0x1a0>
     614:	0f b7 31             	movzwl (%rcx),%esi
     617:	4c 89 da             	mov    %r11,%rdx
     61a:	49 89 fb             	mov    %rdi,%r11
     61d:	48 83 c1 02          	add    $0x2,%rcx
     621:	41 83 e3 0f          	and    $0xf,%r11d
     625:	48 29 f2             	sub    %rsi,%rdx
     628:	4c 39 e2             	cmp    %r12,%rdx
     62b:	72 6f                	jb     69c <n100_private_lz4_decompress_safe_withSmallPrefix+0x23c>
     62d:	41 89 32             	mov    %esi,(%r10)
     630:	49 83 fb 0f          	cmp    $0xf,%r11
     634:	0f 84 a4 00 00 00    	je     6de <n100_private_lz4_decompress_safe_withSmallPrefix+0x27e>
     63a:	4d 8d 73 04          	lea    0x4(%r11),%r14
     63e:	4b 8d 04 32          	lea    (%r10,%r14,1),%rax
     642:	48 83 fe 07          	cmp    $0x7,%rsi
     646:	0f 86 db 00 00 00    	jbe    727 <n100_private_lz4_decompress_safe_withSmallPrefix+0x2c7>
     64c:	48 8b 32             	mov    (%rdx),%rsi
     64f:	48 83 c2 08          	add    $0x8,%rdx
     653:	49 89 32             	mov    %rsi,(%r10)
     656:	49 8d 70 f4          	lea    -0xc(%r8),%rsi
     65a:	48 39 c6             	cmp    %rax,%rsi
     65d:	0f 82 12 01 00 00    	jb     775 <n100_private_lz4_decompress_safe_withSmallPrefix+0x315>
     663:	48 8b 32             	mov    (%rdx),%rsi
     666:	49 89 72 08          	mov    %rsi,0x8(%r10)
     66a:	49 83 fe 10          	cmp    $0x10,%r14
     66e:	0f 86 37 fe ff ff    	jbe    4ab <n100_private_lz4_decompress_safe_withSmallPrefix+0x4b>
     674:	48 83 c2 08          	add    $0x8,%rdx
     678:	49 83 c2 10          	add    $0x10,%r10
     67c:	0f 1f 40 00          	nopl   0x0(%rax)
     680:	48 8b 32             	mov    (%rdx),%rsi
     683:	49 83 c2 08          	add    $0x8,%r10
     687:	48 83 c2 08          	add    $0x8,%rdx
     68b:	49 89 72 f8          	mov    %rsi,-0x8(%r10)
     68f:	49 39 c2             	cmp    %rax,%r10
     692:	72 ec                	jb     680 <n100_private_lz4_decompress_safe_withSmallPrefix+0x220>
     694:	e9 12 fe ff ff       	jmp    4ab <n100_private_lz4_decompress_safe_withSmallPrefix+0x4b>
     699:	48 89 f1             	mov    %rsi,%rcx
     69c:	48 29 e9             	sub    %rbp,%rcx
     69f:	48 83 c4 38          	add    $0x38,%rsp
     6a3:	89 c8                	mov    %ecx,%eax
     6a5:	5b                   	pop    %rbx
     6a6:	5d                   	pop    %rbp
     6a7:	f7 d0                	not    %eax
     6a9:	41 5c                	pop    %r12
     6ab:	41 5d                	pop    %r13
     6ad:	41 5e                	pop    %r14
     6af:	41 5f                	pop    %r15
     6b1:	e9 00 00 00 00       	jmp    6b6 <n100_private_lz4_decompress_safe_withSmallPrefix+0x256>
     6b6:	83 fa 01             	cmp    $0x1,%edx
     6b9:	74 17                	je     6d2 <n100_private_lz4_decompress_safe_withSmallPrefix+0x272>
     6bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     6c0:	e9 00 00 00 00       	jmp    6c5 <n100_private_lz4_decompress_safe_withSmallPrefix+0x265>
     6c5:	4c 8d 1c 10          	lea    (%rax,%rdx,1),%r11
     6c9:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
     6cd:	e9 c4 fe ff ff       	jmp    596 <n100_private_lz4_decompress_safe_withSmallPrefix+0x136>
     6d2:	0f b6 07             	movzbl (%rdi),%eax
     6d5:	f6 d8                	neg    %al
     6d7:	19 c0                	sbb    %eax,%eax
     6d9:	e9 00 00 00 00       	jmp    6de <n100_private_lz4_decompress_safe_withSmallPrefix+0x27e>
     6de:	4d 8d 71 fb          	lea    -0x5(%r9),%r14
     6e2:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
     6e9:	00 
     6ea:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     6f1:	00 00 00 00 
     6f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     6fc:	00 00 00 00 
     700:	48 83 c1 01          	add    $0x1,%rcx
     704:	49 39 ce             	cmp    %rcx,%r14
     707:	72 93                	jb     69c <n100_private_lz4_decompress_safe_withSmallPrefix+0x23c>
     709:	0f b6 79 ff          	movzbl -0x1(%rcx),%edi
     70d:	49 01 fb             	add    %rdi,%r11
     710:	40 80 ff ff          	cmp    $0xff,%dil
     714:	74 ea                	je     700 <n100_private_lz4_decompress_safe_withSmallPrefix+0x2a0>
     716:	4c 89 d0             	mov    %r10,%rax
     719:	4c 01 d8             	add    %r11,%rax
     71c:	0f 83 18 ff ff ff    	jae    63a <n100_private_lz4_decompress_safe_withSmallPrefix+0x1da>
     722:	e9 75 ff ff ff       	jmp    69c <n100_private_lz4_decompress_safe_withSmallPrefix+0x23c>
     727:	0f b6 3a             	movzbl (%rdx),%edi
     72a:	41 88 3a             	mov    %dil,(%r10)
     72d:	0f b6 7a 01          	movzbl 0x1(%rdx),%edi
     731:	41 88 7a 01          	mov    %dil,0x1(%r10)
     735:	0f b6 7a 02          	movzbl 0x2(%rdx),%edi
     739:	41 88 7a 02          	mov    %dil,0x2(%r10)
     73d:	0f b6 7a 03          	movzbl 0x3(%rdx),%edi
     741:	41 88 7a 03          	mov    %dil,0x3(%r10)
     745:	48 83 fe 08          	cmp    $0x8,%rsi
     749:	0f 83 e8 00 00 00    	jae    837 <n100_private_lz4_decompress_safe_withSmallPrefix+0x3d7>
     74f:	8b 3c b5 00 00 00 00 	mov    0x0(,%rsi,4),%edi
     756:	48 01 fa             	add    %rdi,%rdx
     759:	8b 3a                	mov    (%rdx),%edi
     75b:	41 89 7a 04          	mov    %edi,0x4(%r10)
     75f:	48 83 fe 08          	cmp    $0x8,%rsi
     763:	73 7d                	jae    7e2 <n100_private_lz4_decompress_safe_withSmallPrefix+0x382>
     765:	48 63 34 b5 00 00 00 	movslq 0x0(,%rsi,4),%rsi
     76c:	00 
     76d:	48 29 f2             	sub    %rsi,%rdx
     770:	e9 e1 fe ff ff       	jmp    656 <n100_private_lz4_decompress_safe_withSmallPrefix+0x1f6>
     775:	49 8d 70 fb          	lea    -0x5(%r8),%rsi
     779:	48 39 c6             	cmp    %rax,%rsi
     77c:	0f 82 1a ff ff ff    	jb     69c <n100_private_lz4_decompress_safe_withSmallPrefix+0x23c>
     782:	49 83 c2 08          	add    $0x8,%r10
     786:	4d 8d 70 f9          	lea    -0x7(%r8),%r14
     78a:	4d 39 f2             	cmp    %r14,%r10
     78d:	72 27                	jb     7b6 <n100_private_lz4_decompress_safe_withSmallPrefix+0x356>
     78f:	49 89 c3             	mov    %rax,%r11
     792:	31 f6                	xor    %esi,%esi
     794:	4d 29 d3             	sub    %r10,%r11
     797:	49 39 c2             	cmp    %rax,%r10
     79a:	0f 83 0b fd ff ff    	jae    4ab <n100_private_lz4_decompress_safe_withSmallPrefix+0x4b>
     7a0:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
     7a4:	41 88 3c 32          	mov    %dil,(%r10,%rsi,1)
     7a8:	48 83 c6 01          	add    $0x1,%rsi
     7ac:	4c 39 de             	cmp    %r11,%rsi
     7af:	75 ef                	jne    7a0 <n100_private_lz4_decompress_safe_withSmallPrefix+0x340>
     7b1:	e9 f5 fc ff ff       	jmp    4ab <n100_private_lz4_decompress_safe_withSmallPrefix+0x4b>
     7b6:	48 89 d7             	mov    %rdx,%rdi
     7b9:	4c 89 d6             	mov    %r10,%rsi
     7bc:	0f 1f 40 00          	nopl   0x0(%rax)
     7c0:	4c 8b 1f             	mov    (%rdi),%r11
     7c3:	48 83 c6 08          	add    $0x8,%rsi
     7c7:	48 83 c7 08          	add    $0x8,%rdi
     7cb:	4c 89 5e f8          	mov    %r11,-0x8(%rsi)
     7cf:	4c 39 f6             	cmp    %r14,%rsi
     7d2:	72 ec                	jb     7c0 <n100_private_lz4_decompress_safe_withSmallPrefix+0x360>
     7d4:	4c 89 f6             	mov    %r14,%rsi
     7d7:	4c 29 d6             	sub    %r10,%rsi
     7da:	4d 89 f2             	mov    %r14,%r10
     7dd:	48 01 f2             	add    %rsi,%rdx
     7e0:	eb ad                	jmp    78f <n100_private_lz4_decompress_safe_withSmallPrefix+0x32f>
     7e2:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     7e9:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
     7ee:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
     7f3:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
     7f8:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     7fd:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
     802:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
     807:	48 89 34 24          	mov    %rsi,(%rsp)
     80b:	e8 00 00 00 00       	call   810 <n100_private_lz4_decompress_safe_withSmallPrefix+0x3b0>
     810:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
     815:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
     81a:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
     81f:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     824:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
     829:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
     82e:	48 8b 34 24          	mov    (%rsp),%rsi
     832:	e9 2e ff ff ff       	jmp    765 <n100_private_lz4_decompress_safe_withSmallPrefix+0x305>
     837:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     83e:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
     843:	4c 89 54 24 28       	mov    %r10,0x28(%rsp)
     848:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
     84d:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     852:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
     857:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
     85c:	48 89 34 24          	mov    %rsi,(%rsp)
     860:	e8 00 00 00 00       	call   865 <n100_private_lz4_decompress_safe_withSmallPrefix+0x405>
     865:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
     86a:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
     86f:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
     874:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     879:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
     87e:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
     883:	48 8b 34 24          	mov    (%rsp),%rsi
     887:	e9 c3 fe ff ff       	jmp    74f <n100_private_lz4_decompress_safe_withSmallPrefix+0x2ef>
     88c:	0f 1f 40 00          	nopl   0x0(%rax)
     890:	90                   	nop
     891:	90                   	nop
     892:	90                   	nop
     893:	90                   	nop
     894:	90                   	nop
     895:	90                   	nop
     896:	90                   	nop
     897:	90                   	nop
     898:	90                   	nop
     899:	90                   	nop
     89a:	90                   	nop
     89b:	90                   	nop
     89c:	90                   	nop
     89d:	90                   	nop
     89e:	90                   	nop
     89f:	90                   	nop

00000000000008a0 <n100_private_lz4_decompress_safe_forceExtDict>:
     8a0:	e8 00 00 00 00       	call   8a5 <n100_private_lz4_decompress_safe_forceExtDict+0x5>
     8a5:	85 c9                	test   %ecx,%ecx
     8a7:	0f 84 91 03 00 00    	je     c3e <n100_private_lz4_decompress_safe_forceExtDict+0x39e>
     8ad:	85 d2                	test   %edx,%edx
     8af:	0f 84 8e 03 00 00    	je     c43 <n100_private_lz4_decompress_safe_forceExtDict+0x3a3>
     8b5:	41 57                	push   %r15
     8b7:	48 63 c9             	movslq %ecx,%rcx
     8ba:	48 63 d2             	movslq %edx,%rdx
     8bd:	41 56                	push   %r14
     8bf:	4c 8d 14 0e          	lea    (%rsi,%rcx,1),%r10
     8c3:	4c 8d 1c 17          	lea    (%rdi,%rdx,1),%r11
     8c7:	48 89 f1             	mov    %rsi,%rcx
     8ca:	41 55                	push   %r13
     8cc:	49 8d 42 e0          	lea    -0x20(%r10),%rax
     8d0:	4d 8d 6b f0          	lea    -0x10(%r11),%r13
     8d4:	41 54                	push   %r12
     8d6:	4d 89 cc             	mov    %r9,%r12
     8d9:	55                   	push   %rbp
     8da:	48 89 fd             	mov    %rdi,%rbp
     8dd:	53                   	push   %rbx
     8de:	48 89 f3             	mov    %rsi,%rbx
     8e1:	48 83 ec 40          	sub    $0x40,%rsp
     8e5:	48 89 04 24          	mov    %rax,(%rsp)
     8e9:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
     8ee:	49 89 f8             	mov    %rdi,%r8
     8f1:	41 0f b6 10          	movzbl (%r8),%edx
     8f5:	49 8d 70 01          	lea    0x1(%r8),%rsi
     8f9:	89 d7                	mov    %edx,%edi
     8fb:	c1 ea 04             	shr    $0x4,%edx
     8fe:	83 fa 0f             	cmp    $0xf,%edx
     901:	0f 84 d8 00 00 00    	je     9df <n100_private_lz4_decompress_safe_forceExtDict+0x13f>
     907:	4c 39 ee             	cmp    %r13,%rsi
     90a:	0f 83 3d 03 00 00    	jae    c4d <n100_private_lz4_decompress_safe_forceExtDict+0x3ad>
     910:	48 39 0c 24          	cmp    %rcx,(%rsp)
     914:	0f 82 33 03 00 00    	jb     c4d <n100_private_lz4_decompress_safe_forceExtDict+0x3ad>
     91a:	49 8b 40 01          	mov    0x1(%r8),%rax
     91e:	4c 8d 34 16          	lea    (%rsi,%rdx,1),%r14
     922:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
     926:	4d 8d 46 02          	lea    0x2(%r14),%r8
     92a:	48 89 01             	mov    %rax,(%rcx)
     92d:	48 8b 46 08          	mov    0x8(%rsi),%rax
     931:	48 89 41 08          	mov    %rax,0x8(%rcx)
     935:	41 0f b7 36          	movzwl (%r14),%esi
     939:	48 89 f8             	mov    %rdi,%rax
     93c:	f7 d7                	not    %edi
     93e:	83 e0 0f             	and    $0xf,%eax
     941:	48 29 f2             	sub    %rsi,%rdx
     944:	83 e7 0f             	and    $0xf,%edi
     947:	49 89 f1             	mov    %rsi,%r9
     94a:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
     94e:	0f 84 51 01 00 00    	je     aa5 <n100_private_lz4_decompress_safe_forceExtDict+0x205>
     954:	48 83 fe 07          	cmp    $0x7,%rsi
     958:	0f 86 47 01 00 00    	jbe    aa5 <n100_private_lz4_decompress_safe_forceExtDict+0x205>
     95e:	49 39 de             	cmp    %rbx,%r14
     961:	0f 83 10 02 00 00    	jae    b77 <n100_private_lz4_decompress_safe_forceExtDict+0x2d7>
     967:	49 81 fc ff ff 00 00 	cmp    $0xffff,%r12
     96e:	0f 86 34 02 00 00    	jbe    ba8 <n100_private_lz4_decompress_safe_forceExtDict+0x308>
     974:	45 89 0f             	mov    %r9d,(%r15)
     977:	48 83 c0 04          	add    $0x4,%rax
     97b:	49 8d 0c 07          	lea    (%r15,%rax,1),%rcx
     97f:	49 8d 52 fb          	lea    -0x5(%r10),%rdx
     983:	48 39 ca             	cmp    %rcx,%rdx
     986:	0f 82 ce 01 00 00    	jb     b5a <n100_private_lz4_decompress_safe_forceExtDict+0x2ba>
     98c:	48 89 da             	mov    %rbx,%rdx
     98f:	4c 29 f2             	sub    %r14,%rdx
     992:	49 29 de             	sub    %rbx,%r14
     995:	4b 8d 34 26          	lea    (%r14,%r12,1),%rsi
     999:	48 03 74 24 08       	add    0x8(%rsp),%rsi
     99e:	48 39 c2             	cmp    %rax,%rdx
     9a1:	0f 82 10 02 00 00    	jb     bb7 <n100_private_lz4_decompress_safe_forceExtDict+0x317>
     9a7:	4c 89 ff             	mov    %r15,%rdi
     9aa:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
     9af:	48 89 c2             	mov    %rax,%rdx
     9b2:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
     9b7:	4c 89 54 24 18       	mov    %r10,0x18(%rsp)
     9bc:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
     9c1:	e8 00 00 00 00       	call   9c6 <n100_private_lz4_decompress_safe_forceExtDict+0x126>
     9c6:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
     9cb:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
     9d0:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
     9d5:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
     9da:	e9 12 ff ff ff       	jmp    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     9df:	4d 8d 4b f1          	lea    -0xf(%r11),%r9
     9e3:	4c 39 ce             	cmp    %r9,%rsi
     9e6:	0f 83 71 01 00 00    	jae    b5d <n100_private_lz4_decompress_safe_forceExtDict+0x2bd>
     9ec:	ba 0f 00 00 00       	mov    $0xf,%edx
     9f1:	eb 13                	jmp    a06 <n100_private_lz4_decompress_safe_forceExtDict+0x166>
     9f3:	66 90                	xchg   %ax,%ax
     9f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     9fc:	00 00 00 00 
     a00:	41 80 f8 ff          	cmp    $0xff,%r8b
     a04:	75 10                	jne    a16 <n100_private_lz4_decompress_safe_forceExtDict+0x176>
     a06:	44 0f b6 06          	movzbl (%rsi),%r8d
     a0a:	48 83 c6 01          	add    $0x1,%rsi
     a0e:	4c 01 c2             	add    %r8,%rdx
     a11:	49 39 f1             	cmp    %rsi,%r9
     a14:	75 ea                	jne    a00 <n100_private_lz4_decompress_safe_forceExtDict+0x160>
     a16:	48 89 c8             	mov    %rcx,%rax
     a19:	4c 8d 34 0a          	lea    (%rdx,%rcx,1),%r14
     a1d:	48 01 d0             	add    %rdx,%rax
     a20:	0f 82 37 01 00 00    	jb     b5d <n100_private_lz4_decompress_safe_forceExtDict+0x2bd>
     a26:	48 89 f0             	mov    %rsi,%rax
     a29:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
     a2d:	48 01 d0             	add    %rdx,%rax
     a30:	0f 82 27 01 00 00    	jb     b5d <n100_private_lz4_decompress_safe_forceExtDict+0x2bd>
     a36:	49 8d 42 f4          	lea    -0xc(%r10),%rax
     a3a:	4d 89 f7             	mov    %r14,%r15
     a3d:	4c 39 f0             	cmp    %r14,%rax
     a40:	73 32                	jae    a74 <n100_private_lz4_decompress_safe_forceExtDict+0x1d4>
     a42:	4d 39 c3             	cmp    %r8,%r11
     a45:	0f 85 12 01 00 00    	jne    b5d <n100_private_lz4_decompress_safe_forceExtDict+0x2bd>
     a4b:	4d 39 f2             	cmp    %r14,%r10
     a4e:	0f 82 09 01 00 00    	jb     b5d <n100_private_lz4_decompress_safe_forceExtDict+0x2bd>
     a54:	48 89 cf             	mov    %rcx,%rdi
     a57:	e8 00 00 00 00       	call   a5c <n100_private_lz4_decompress_safe_forceExtDict+0x1bc>
     a5c:	44 89 f0             	mov    %r14d,%eax
     a5f:	48 83 c4 40          	add    $0x40,%rsp
     a63:	29 d8                	sub    %ebx,%eax
     a65:	5b                   	pop    %rbx
     a66:	5d                   	pop    %rbp
     a67:	41 5c                	pop    %r12
     a69:	41 5d                	pop    %r13
     a6b:	41 5e                	pop    %r14
     a6d:	41 5f                	pop    %r15
     a6f:	e9 00 00 00 00       	jmp    a74 <n100_private_lz4_decompress_safe_forceExtDict+0x1d4>
     a74:	49 8d 43 f8          	lea    -0x8(%r11),%rax
     a78:	4c 39 c0             	cmp    %r8,%rax
     a7b:	72 c5                	jb     a42 <n100_private_lz4_decompress_safe_forceExtDict+0x1a2>
     a7d:	0f 1f 00             	nopl   (%rax)
     a80:	48 8b 06             	mov    (%rsi),%rax
     a83:	48 83 c1 08          	add    $0x8,%rcx
     a87:	48 83 c6 08          	add    $0x8,%rsi
     a8b:	48 89 41 f8          	mov    %rax,-0x8(%rcx)
     a8f:	4c 39 f1             	cmp    %r14,%rcx
     a92:	72 ec                	jb     a80 <n100_private_lz4_decompress_safe_forceExtDict+0x1e0>
     a94:	41 0f b7 30          	movzwl (%r8),%esi
     a98:	48 89 f8             	mov    %rdi,%rax
     a9b:	49 83 c0 02          	add    $0x2,%r8
     a9f:	83 e0 0f             	and    $0xf,%eax
     aa2:	49 29 f6             	sub    %rsi,%r14
     aa5:	49 81 fc ff ff 00 00 	cmp    $0xffff,%r12
     aac:	0f 86 e7 00 00 00    	jbe    b99 <n100_private_lz4_decompress_safe_forceExtDict+0x2f9>
     ab2:	41 89 37             	mov    %esi,(%r15)
     ab5:	48 83 f8 0f          	cmp    $0xf,%rax
     ab9:	74 7e                	je     b39 <n100_private_lz4_decompress_safe_forceExtDict+0x299>
     abb:	48 83 c0 04          	add    $0x4,%rax
     abf:	49 39 de             	cmp    %rbx,%r14
     ac2:	0f 82 b3 fe ff ff    	jb     97b <n100_private_lz4_decompress_safe_forceExtDict+0xdb>
     ac8:	49 8d 0c 07          	lea    (%r15,%rax,1),%rcx
     acc:	48 83 fe 07          	cmp    $0x7,%rsi
     ad0:	0f 86 d0 01 00 00    	jbe    ca6 <n100_private_lz4_decompress_safe_forceExtDict+0x406>
     ad6:	49 8b 16             	mov    (%r14),%rdx
     ad9:	49 89 17             	mov    %rdx,(%r15)
     adc:	49 8d 56 08          	lea    0x8(%r14),%rdx
     ae0:	49 8d 72 f4          	lea    -0xc(%r10),%rsi
     ae4:	48 39 ce             	cmp    %rcx,%rsi
     ae7:	0f 82 13 02 00 00    	jb     d00 <n100_private_lz4_decompress_safe_forceExtDict+0x460>
     aed:	48 8b 32             	mov    (%rdx),%rsi
     af0:	49 89 77 08          	mov    %rsi,0x8(%r15)
     af4:	48 83 f8 10          	cmp    $0x10,%rax
     af8:	0f 86 f3 fd ff ff    	jbe    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     afe:	48 8d 42 08          	lea    0x8(%rdx),%rax
     b02:	49 83 c7 10          	add    $0x10,%r15
     b06:	0f 1f 40 00          	nopl   0x0(%rax)
     b0a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     b11:	00 00 00 00 
     b15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     b1c:	00 00 00 00 
     b20:	48 8b 10             	mov    (%rax),%rdx
     b23:	49 83 c7 08          	add    $0x8,%r15
     b27:	48 83 c0 08          	add    $0x8,%rax
     b2b:	49 89 57 f8          	mov    %rdx,-0x8(%r15)
     b2f:	49 39 cf             	cmp    %rcx,%r15
     b32:	72 ec                	jb     b20 <n100_private_lz4_decompress_safe_forceExtDict+0x280>
     b34:	e9 b8 fd ff ff       	jmp    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     b39:	49 8d 7b fb          	lea    -0x5(%r11),%rdi
     b3d:	eb 12                	jmp    b51 <n100_private_lz4_decompress_safe_forceExtDict+0x2b1>
     b3f:	90                   	nop
     b40:	41 0f b6 48 ff       	movzbl -0x1(%r8),%ecx
     b45:	48 01 c8             	add    %rcx,%rax
     b48:	80 f9 ff             	cmp    $0xff,%cl
     b4b:	0f 85 44 01 00 00    	jne    c95 <n100_private_lz4_decompress_safe_forceExtDict+0x3f5>
     b51:	49 83 c0 01          	add    $0x1,%r8
     b55:	4c 39 c7             	cmp    %r8,%rdi
     b58:	73 e6                	jae    b40 <n100_private_lz4_decompress_safe_forceExtDict+0x2a0>
     b5a:	4c 89 c6             	mov    %r8,%rsi
     b5d:	48 29 ee             	sub    %rbp,%rsi
     b60:	48 83 c4 40          	add    $0x40,%rsp
     b64:	89 f0                	mov    %esi,%eax
     b66:	5b                   	pop    %rbx
     b67:	5d                   	pop    %rbp
     b68:	f7 d0                	not    %eax
     b6a:	41 5c                	pop    %r12
     b6c:	41 5d                	pop    %r13
     b6e:	41 5e                	pop    %r14
     b70:	41 5f                	pop    %r15
     b72:	e9 00 00 00 00       	jmp    b77 <n100_private_lz4_decompress_safe_forceExtDict+0x2d7>
     b77:	49 8b 16             	mov    (%r14),%rdx
     b7a:	49 8d 4c 07 04       	lea    0x4(%r15,%rax,1),%rcx
     b7f:	49 89 17             	mov    %rdx,(%r15)
     b82:	49 8b 56 08          	mov    0x8(%r14),%rdx
     b86:	49 89 57 08          	mov    %rdx,0x8(%r15)
     b8a:	41 0f b7 56 10       	movzwl 0x10(%r14),%edx
     b8f:	66 41 89 57 10       	mov    %dx,0x10(%r15)
     b94:	e9 58 fd ff ff       	jmp    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     b99:	4b 8d 14 26          	lea    (%r14,%r12,1),%rdx
     b9d:	48 39 da             	cmp    %rbx,%rdx
     ba0:	0f 83 0c ff ff ff    	jae    ab2 <n100_private_lz4_decompress_safe_forceExtDict+0x212>
     ba6:	eb b2                	jmp    b5a <n100_private_lz4_decompress_safe_forceExtDict+0x2ba>
     ba8:	4b 8d 14 26          	lea    (%r14,%r12,1),%rdx
     bac:	48 39 da             	cmp    %rbx,%rdx
     baf:	0f 83 bf fd ff ff    	jae    974 <n100_private_lz4_decompress_safe_forceExtDict+0xd4>
     bb5:	eb a3                	jmp    b5a <n100_private_lz4_decompress_safe_forceExtDict+0x2ba>
     bb7:	48 29 d0             	sub    %rdx,%rax
     bba:	4c 89 ff             	mov    %r15,%rdi
     bbd:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
     bc2:	4c 89 44 24 28       	mov    %r8,0x28(%rsp)
     bc7:	49 89 c6             	mov    %rax,%r14
     bca:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
     bcf:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
     bd4:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
     bd9:	e8 00 00 00 00       	call   bde <n100_private_lz4_decompress_safe_forceExtDict+0x33e>
     bde:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
     be3:	4c 8b 5c 24 18       	mov    0x18(%rsp),%r11
     be8:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
     bed:	4c 8b 44 24 28       	mov    0x28(%rsp),%r8
     bf2:	49 8d 3c 17          	lea    (%r15,%rdx,1),%rdi
     bf6:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
     bfb:	48 89 f8             	mov    %rdi,%rax
     bfe:	48 29 d8             	sub    %rbx,%rax
     c01:	4c 39 f0             	cmp    %r14,%rax
     c04:	72 60                	jb     c66 <n100_private_lz4_decompress_safe_forceExtDict+0x3c6>
     c06:	4c 89 f2             	mov    %r14,%rdx
     c09:	48 89 de             	mov    %rbx,%rsi
     c0c:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
     c11:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
     c16:	4c 89 54 24 18       	mov    %r10,0x18(%rsp)
     c1b:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
     c20:	e8 00 00 00 00       	call   c25 <n100_private_lz4_decompress_safe_forceExtDict+0x385>
     c25:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
     c2a:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
     c2f:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
     c34:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
     c39:	e9 b3 fc ff ff       	jmp    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     c3e:	83 fa 01             	cmp    $0x1,%edx
     c41:	74 17                	je     c5a <n100_private_lz4_decompress_safe_forceExtDict+0x3ba>
     c43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c48:	e9 00 00 00 00       	jmp    c4d <n100_private_lz4_decompress_safe_forceExtDict+0x3ad>
     c4d:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
     c51:	4c 8d 04 16          	lea    (%rsi,%rdx,1),%r8
     c55:	e9 dc fd ff ff       	jmp    a36 <n100_private_lz4_decompress_safe_forceExtDict+0x196>
     c5a:	0f b6 07             	movzbl (%rdi),%eax
     c5d:	f6 d8                	neg    %al
     c5f:	19 c0                	sbb    %eax,%eax
     c61:	e9 00 00 00 00       	jmp    c66 <n100_private_lz4_decompress_safe_forceExtDict+0x3c6>
     c66:	48 39 cf             	cmp    %rcx,%rdi
     c69:	0f 83 0f 01 00 00    	jae    d7e <n100_private_lz4_decompress_safe_forceExtDict+0x4de>
     c6f:	31 c0                	xor    %eax,%eax
     c71:	0f 1f 40 00          	nopl   0x0(%rax)
     c75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     c7c:	00 00 00 00 
     c80:	0f b6 14 03          	movzbl (%rbx,%rax,1),%edx
     c84:	88 14 07             	mov    %dl,(%rdi,%rax,1)
     c87:	48 83 c0 01          	add    $0x1,%rax
     c8b:	49 39 c6             	cmp    %rax,%r14
     c8e:	75 f0                	jne    c80 <n100_private_lz4_decompress_safe_forceExtDict+0x3e0>
     c90:	e9 5c fc ff ff       	jmp    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     c95:	4c 89 ff             	mov    %r15,%rdi
     c98:	48 01 c7             	add    %rax,%rdi
     c9b:	0f 83 1a fe ff ff    	jae    abb <n100_private_lz4_decompress_safe_forceExtDict+0x21b>
     ca1:	e9 b4 fe ff ff       	jmp    b5a <n100_private_lz4_decompress_safe_forceExtDict+0x2ba>
     ca6:	41 0f b6 16          	movzbl (%r14),%edx
     caa:	41 88 17             	mov    %dl,(%r15)
     cad:	41 0f b6 56 01       	movzbl 0x1(%r14),%edx
     cb2:	41 88 57 01          	mov    %dl,0x1(%r15)
     cb6:	41 0f b6 56 02       	movzbl 0x2(%r14),%edx
     cbb:	41 88 57 02          	mov    %dl,0x2(%r15)
     cbf:	41 0f b6 56 03       	movzbl 0x3(%r14),%edx
     cc4:	41 88 57 03          	mov    %dl,0x3(%r15)
     cc8:	48 83 fe 08          	cmp    $0x8,%rsi
     ccc:	0f 83 01 01 00 00    	jae    dd3 <n100_private_lz4_decompress_safe_forceExtDict+0x533>
     cd2:	8b 14 b5 00 00 00 00 	mov    0x0(,%rsi,4),%edx
     cd9:	49 01 d6             	add    %rdx,%r14
     cdc:	41 8b 16             	mov    (%r14),%edx
     cdf:	41 89 57 04          	mov    %edx,0x4(%r15)
     ce3:	48 83 fe 08          	cmp    $0x8,%rsi
     ce7:	0f 83 99 00 00 00    	jae    d86 <n100_private_lz4_decompress_safe_forceExtDict+0x4e6>
     ced:	48 63 34 b5 00 00 00 	movslq 0x0(,%rsi,4),%rsi
     cf4:	00 
     cf5:	4c 89 f2             	mov    %r14,%rdx
     cf8:	48 29 f2             	sub    %rsi,%rdx
     cfb:	e9 e0 fd ff ff       	jmp    ae0 <n100_private_lz4_decompress_safe_forceExtDict+0x240>
     d00:	49 8d 42 fb          	lea    -0x5(%r10),%rax
     d04:	48 39 c8             	cmp    %rcx,%rax
     d07:	0f 82 4d fe ff ff    	jb     b5a <n100_private_lz4_decompress_safe_forceExtDict+0x2ba>
     d0d:	49 83 c7 08          	add    $0x8,%r15
     d11:	4d 8d 4a f9          	lea    -0x7(%r10),%r9
     d15:	4d 39 cf             	cmp    %r9,%r15
     d18:	72 3c                	jb     d56 <n100_private_lz4_decompress_safe_forceExtDict+0x4b6>
     d1a:	48 89 cf             	mov    %rcx,%rdi
     d1d:	31 c0                	xor    %eax,%eax
     d1f:	4c 29 ff             	sub    %r15,%rdi
     d22:	49 39 cf             	cmp    %rcx,%r15
     d25:	0f 83 c6 fb ff ff    	jae    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     d2b:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
     d32:	00 00 00 
     d35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     d3c:	00 00 00 00 
     d40:	0f b6 34 02          	movzbl (%rdx,%rax,1),%esi
     d44:	41 88 34 07          	mov    %sil,(%r15,%rax,1)
     d48:	48 83 c0 01          	add    $0x1,%rax
     d4c:	48 39 f8             	cmp    %rdi,%rax
     d4f:	75 ef                	jne    d40 <n100_private_lz4_decompress_safe_forceExtDict+0x4a0>
     d51:	e9 9b fb ff ff       	jmp    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     d56:	48 89 d6             	mov    %rdx,%rsi
     d59:	4c 89 f8             	mov    %r15,%rax
     d5c:	48 8b 3e             	mov    (%rsi),%rdi
     d5f:	48 83 c0 08          	add    $0x8,%rax
     d63:	48 83 c6 08          	add    $0x8,%rsi
     d67:	48 89 78 f8          	mov    %rdi,-0x8(%rax)
     d6b:	4c 39 c8             	cmp    %r9,%rax
     d6e:	72 ec                	jb     d5c <n100_private_lz4_decompress_safe_forceExtDict+0x4bc>
     d70:	4c 89 c8             	mov    %r9,%rax
     d73:	4c 29 f8             	sub    %r15,%rax
     d76:	4d 89 cf             	mov    %r9,%r15
     d79:	48 01 c2             	add    %rax,%rdx
     d7c:	eb 9c                	jmp    d1a <n100_private_lz4_decompress_safe_forceExtDict+0x47a>
     d7e:	48 89 f9             	mov    %rdi,%rcx
     d81:	e9 6b fb ff ff       	jmp    8f1 <n100_private_lz4_decompress_safe_forceExtDict+0x51>
     d86:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     d8d:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
     d92:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
     d97:	4c 89 54 24 28       	mov    %r10,0x28(%rsp)
     d9c:	4c 89 5c 24 20       	mov    %r11,0x20(%rsp)
     da1:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     da6:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
     dab:	e8 00 00 00 00       	call   db0 <n100_private_lz4_decompress_safe_forceExtDict+0x510>
     db0:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
     db5:	4c 8b 44 24 30       	mov    0x30(%rsp),%r8
     dba:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
     dbf:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
     dc4:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     dc9:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     dce:	e9 1a ff ff ff       	jmp    ced <n100_private_lz4_decompress_safe_forceExtDict+0x44d>
     dd3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
     dda:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
     ddf:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
     de4:	4c 89 54 24 28       	mov    %r10,0x28(%rsp)
     de9:	4c 89 5c 24 20       	mov    %r11,0x20(%rsp)
     dee:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
     df3:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
     df8:	e8 00 00 00 00       	call   dfd <n100_private_lz4_decompress_safe_forceExtDict+0x55d>
     dfd:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
     e02:	4c 8b 44 24 30       	mov    0x30(%rsp),%r8
     e07:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
     e0c:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
     e11:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
     e16:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
     e1b:	e9 b2 fe ff ff       	jmp    cd2 <n100_private_lz4_decompress_safe_forceExtDict+0x432>
     e20:	90                   	nop
     e21:	90                   	nop
     e22:	90                   	nop
     e23:	90                   	nop
     e24:	90                   	nop
     e25:	90                   	nop
     e26:	90                   	nop
     e27:	90                   	nop
     e28:	90                   	nop
     e29:	90                   	nop
     e2a:	90                   	nop
     e2b:	90                   	nop
     e2c:	90                   	nop
     e2d:	90                   	nop
     e2e:	90                   	nop
     e2f:	90                   	nop

0000000000000e30 <n100_private_lz4_decompress_fast_extDict>:
     e30:	e8 00 00 00 00       	call   e35 <n100_private_lz4_decompress_fast_extDict+0x5>
     e35:	85 d2                	test   %edx,%edx
     e37:	0f 84 a4 02 00 00    	je     10e1 <n100_private_lz4_decompress_fast_extDict+0x2b1>
     e3d:	41 57                	push   %r15
     e3f:	48 63 d2             	movslq %edx,%rdx
     e42:	49 89 fa             	mov    %rdi,%r10
     e45:	41 56                	push   %r14
     e47:	4c 8d 1c 16          	lea    (%rsi,%rdx,1),%r11
     e4b:	41 55                	push   %r13
     e4d:	4d 8d 7b e6          	lea    -0x1a(%r11),%r15
     e51:	4d 89 c5             	mov    %r8,%r13
     e54:	4d 8d 73 f8          	lea    -0x8(%r11),%r14
     e58:	41 54                	push   %r12
     e5a:	49 89 f0             	mov    %rsi,%r8
     e5d:	49 89 fc             	mov    %rdi,%r12
     e60:	55                   	push   %rbp
     e61:	53                   	push   %rbx
     e62:	48 83 ec 40          	sub    $0x40,%rsp
     e66:	48 89 0c 24          	mov    %rcx,(%rsp)
     e6a:	48 89 f1             	mov    %rsi,%rcx
     e6d:	41 0f b6 02          	movzbl (%r10),%eax
     e71:	49 8d 6a 01          	lea    0x1(%r10),%rbp
     e75:	89 c6                	mov    %eax,%esi
     e77:	c1 e8 04             	shr    $0x4,%eax
     e7a:	89 c3                	mov    %eax,%ebx
     e7c:	83 f8 08             	cmp    $0x8,%eax
     e7f:	0f 87 b3 00 00 00    	ja     f38 <n100_private_lz4_decompress_fast_extDict+0x108>
     e85:	49 39 cf             	cmp    %rcx,%r15
     e88:	0f 82 b3 00 00 00    	jb     f41 <n100_private_lz4_decompress_fast_extDict+0x111>
     e8e:	49 8b 42 01          	mov    0x1(%r10),%rax
     e92:	48 01 dd             	add    %rbx,%rbp
     e95:	48 89 f2             	mov    %rsi,%rdx
     e98:	4c 8d 0c 19          	lea    (%rcx,%rbx,1),%r9
     e9c:	f7 d6                	not    %esi
     e9e:	83 e2 0f             	and    $0xf,%edx
     ea1:	4c 8d 55 02          	lea    0x2(%rbp),%r10
     ea5:	48 89 01             	mov    %rax,(%rcx)
     ea8:	0f b7 45 00          	movzwl 0x0(%rbp),%eax
     eac:	48 29 c3             	sub    %rax,%rbx
     eaf:	48 01 cb             	add    %rcx,%rbx
     eb2:	83 e6 0f             	and    $0xf,%esi
     eb5:	0f 84 f0 00 00 00    	je     fab <n100_private_lz4_decompress_fast_extDict+0x17b>
     ebb:	48 83 f8 07          	cmp    $0x7,%rax
     ebf:	0f 86 e6 00 00 00    	jbe    fab <n100_private_lz4_decompress_fast_extDict+0x17b>
     ec5:	48 83 c2 04          	add    $0x4,%rdx
     ec9:	4c 39 c3             	cmp    %r8,%rbx
     ecc:	0f 83 83 01 00 00    	jae    1055 <n100_private_lz4_decompress_fast_extDict+0x225>
     ed2:	41 89 01             	mov    %eax,(%r9)
     ed5:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
     ed9:	49 8d 43 fb          	lea    -0x5(%r11),%rax
     edd:	48 39 c8             	cmp    %rcx,%rax
     ee0:	0f 82 0e 02 00 00    	jb     10f4 <n100_private_lz4_decompress_fast_extDict+0x2c4>
     ee6:	4c 89 c5             	mov    %r8,%rbp
     ee9:	48 8b 04 24          	mov    (%rsp),%rax
     eed:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
     ef2:	48 29 dd             	sub    %rbx,%rbp
     ef5:	4c 29 c3             	sub    %r8,%rbx
     ef8:	4c 89 54 24 18       	mov    %r10,0x18(%rsp)
     efd:	4c 01 eb             	add    %r13,%rbx
     f00:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
     f05:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
     f0a:	48 8d 34 18          	lea    (%rax,%rbx,1),%rsi
     f0e:	48 39 d5             	cmp    %rdx,%rbp
     f11:	0f 82 5e 01 00 00    	jb     1075 <n100_private_lz4_decompress_fast_extDict+0x245>
     f17:	4c 89 cf             	mov    %r9,%rdi
     f1a:	e8 00 00 00 00       	call   f1f <n100_private_lz4_decompress_fast_extDict+0xef>
     f1f:	4c 8b 5c 24 08       	mov    0x8(%rsp),%r11
     f24:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
     f29:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
     f2e:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
     f33:	e9 35 ff ff ff       	jmp    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
     f38:	83 f8 0f             	cmp    $0xf,%eax
     f3b:	0f 84 f2 00 00 00    	je     1033 <n100_private_lz4_decompress_fast_extDict+0x203>
     f41:	4c 8d 0c 19          	lea    (%rcx,%rbx,1),%r9
     f45:	4d 39 ce             	cmp    %r9,%r14
     f48:	73 32                	jae    f7c <n100_private_lz4_decompress_fast_extDict+0x14c>
     f4a:	4d 39 cb             	cmp    %r9,%r11
     f4d:	0f 85 9e 01 00 00    	jne    10f1 <n100_private_lz4_decompress_fast_extDict+0x2c1>
     f53:	48 89 da             	mov    %rbx,%rdx
     f56:	48 89 ee             	mov    %rbp,%rsi
     f59:	48 89 cf             	mov    %rcx,%rdi
     f5c:	e8 00 00 00 00       	call   f61 <n100_private_lz4_decompress_fast_extDict+0x131>
     f61:	48 8d 44 1d 00       	lea    0x0(%rbp,%rbx,1),%rax
     f66:	44 29 e0             	sub    %r12d,%eax
     f69:	48 83 c4 40          	add    $0x40,%rsp
     f6d:	5b                   	pop    %rbx
     f6e:	5d                   	pop    %rbp
     f6f:	41 5c                	pop    %r12
     f71:	41 5d                	pop    %r13
     f73:	41 5e                	pop    %r14
     f75:	41 5f                	pop    %r15
     f77:	e9 00 00 00 00       	jmp    f7c <n100_private_lz4_decompress_fast_extDict+0x14c>
     f7c:	48 89 e8             	mov    %rbp,%rax
     f7f:	90                   	nop
     f80:	48 8b 10             	mov    (%rax),%rdx
     f83:	48 83 c1 08          	add    $0x8,%rcx
     f87:	48 83 c0 08          	add    $0x8,%rax
     f8b:	48 89 51 f8          	mov    %rdx,-0x8(%rcx)
     f8f:	4c 39 c9             	cmp    %r9,%rcx
     f92:	72 ec                	jb     f80 <n100_private_lz4_decompress_fast_extDict+0x150>
     f94:	48 01 dd             	add    %rbx,%rbp
     f97:	48 89 f2             	mov    %rsi,%rdx
     f9a:	4c 89 cb             	mov    %r9,%rbx
     f9d:	0f b7 45 00          	movzwl 0x0(%rbp),%eax
     fa1:	4c 8d 55 02          	lea    0x2(%rbp),%r10
     fa5:	83 e2 0f             	and    $0xf,%edx
     fa8:	48 29 c3             	sub    %rax,%rbx
     fab:	41 89 01             	mov    %eax,(%r9)
     fae:	48 83 fa 0f          	cmp    $0xf,%rdx
     fb2:	74 6c                	je     1020 <n100_private_lz4_decompress_fast_extDict+0x1f0>
     fb4:	48 83 c2 04          	add    $0x4,%rdx
     fb8:	4c 39 c3             	cmp    %r8,%rbx
     fbb:	0f 82 14 ff ff ff    	jb     ed5 <n100_private_lz4_decompress_fast_extDict+0xa5>
     fc1:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
     fc5:	48 83 f8 07          	cmp    $0x7,%rax
     fc9:	0f 86 a7 01 00 00    	jbe    1176 <n100_private_lz4_decompress_fast_extDict+0x346>
     fcf:	48 8b 03             	mov    (%rbx),%rax
     fd2:	49 89 01             	mov    %rax,(%r9)
     fd5:	48 8d 43 08          	lea    0x8(%rbx),%rax
     fd9:	49 8d 73 f4          	lea    -0xc(%r11),%rsi
     fdd:	48 39 ce             	cmp    %rcx,%rsi
     fe0:	0f 82 50 01 00 00    	jb     1136 <n100_private_lz4_decompress_fast_extDict+0x306>
     fe6:	48 8b 30             	mov    (%rax),%rsi
     fe9:	49 89 71 08          	mov    %rsi,0x8(%r9)
     fed:	48 83 fa 10          	cmp    $0x10,%rdx
     ff1:	0f 86 76 fe ff ff    	jbe    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
     ff7:	48 83 c0 08          	add    $0x8,%rax
     ffb:	49 83 c1 10          	add    $0x10,%r9
     fff:	90                   	nop
    1000:	48 8b 10             	mov    (%rax),%rdx
    1003:	49 83 c1 08          	add    $0x8,%r9
    1007:	48 83 c0 08          	add    $0x8,%rax
    100b:	49 89 51 f8          	mov    %rdx,-0x8(%r9)
    100f:	49 39 c9             	cmp    %rcx,%r9
    1012:	72 ec                	jb     1000 <n100_private_lz4_decompress_fast_extDict+0x1d0>
    1014:	e9 54 fe ff ff       	jmp    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
    1019:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1020:	41 0f b6 32          	movzbl (%r10),%esi
    1024:	49 83 c2 01          	add    $0x1,%r10
    1028:	48 01 f2             	add    %rsi,%rdx
    102b:	40 80 fe ff          	cmp    $0xff,%sil
    102f:	74 ef                	je     1020 <n100_private_lz4_decompress_fast_extDict+0x1f0>
    1031:	eb 81                	jmp    fb4 <n100_private_lz4_decompress_fast_extDict+0x184>
    1033:	bb 0f 00 00 00       	mov    $0xf,%ebx
    1038:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    103f:	00 
    1040:	0f b6 55 00          	movzbl 0x0(%rbp),%edx
    1044:	48 83 c5 01          	add    $0x1,%rbp
    1048:	48 01 d3             	add    %rdx,%rbx
    104b:	80 fa ff             	cmp    $0xff,%dl
    104e:	74 f0                	je     1040 <n100_private_lz4_decompress_fast_extDict+0x210>
    1050:	e9 ec fe ff ff       	jmp    f41 <n100_private_lz4_decompress_fast_extDict+0x111>
    1055:	48 8b 03             	mov    (%rbx),%rax
    1058:	49 8d 0c 11          	lea    (%r9,%rdx,1),%rcx
    105c:	49 89 01             	mov    %rax,(%r9)
    105f:	48 8b 43 08          	mov    0x8(%rbx),%rax
    1063:	49 89 41 08          	mov    %rax,0x8(%r9)
    1067:	0f b7 43 10          	movzwl 0x10(%rbx),%eax
    106b:	66 41 89 41 10       	mov    %ax,0x10(%r9)
    1070:	e9 f8 fd ff ff       	jmp    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
    1075:	48 89 d3             	mov    %rdx,%rbx
    1078:	4c 89 cf             	mov    %r9,%rdi
    107b:	48 89 ea             	mov    %rbp,%rdx
    107e:	e8 00 00 00 00       	call   1083 <n100_private_lz4_decompress_fast_extDict+0x253>
    1083:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    1088:	48 29 eb             	sub    %rbp,%rbx
    108b:	4c 8b 5c 24 08       	mov    0x8(%rsp),%r11
    1090:	48 8d 3c 28          	lea    (%rax,%rbp,1),%rdi
    1094:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    1099:	4c 8b 54 24 18       	mov    0x18(%rsp),%r10
    109e:	48 89 f8             	mov    %rdi,%rax
    10a1:	4c 29 c0             	sub    %r8,%rax
    10a4:	48 39 d8             	cmp    %rbx,%rax
    10a7:	72 58                	jb     1101 <n100_private_lz4_decompress_fast_extDict+0x2d1>
    10a9:	4c 89 c6             	mov    %r8,%rsi
    10ac:	48 89 da             	mov    %rbx,%rdx
    10af:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    10b4:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
    10b9:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
    10be:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
    10c3:	e8 00 00 00 00       	call   10c8 <n100_private_lz4_decompress_fast_extDict+0x298>
    10c8:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    10cd:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
    10d2:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    10d7:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
    10dc:	e9 8c fd ff ff       	jmp    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
    10e1:	80 3f 01             	cmpb   $0x1,(%rdi)
    10e4:	19 c0                	sbb    %eax,%eax
    10e6:	83 e0 02             	and    $0x2,%eax
    10e9:	83 e8 01             	sub    $0x1,%eax
    10ec:	e9 00 00 00 00       	jmp    10f1 <n100_private_lz4_decompress_fast_extDict+0x2c1>
    10f1:	49 89 ea             	mov    %rbp,%r10
    10f4:	4d 29 e2             	sub    %r12,%r10
    10f7:	44 89 d0             	mov    %r10d,%eax
    10fa:	f7 d0                	not    %eax
    10fc:	e9 68 fe ff ff       	jmp    f69 <n100_private_lz4_decompress_fast_extDict+0x139>
    1101:	48 39 cf             	cmp    %rcx,%rdi
    1104:	0f 83 fb 00 00 00    	jae    1205 <n100_private_lz4_decompress_fast_extDict+0x3d5>
    110a:	31 c0                	xor    %eax,%eax
    110c:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    1113:	00 00 
    1115:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    111c:	00 00 00 00 
    1120:	41 0f b6 14 00       	movzbl (%r8,%rax,1),%edx
    1125:	88 14 07             	mov    %dl,(%rdi,%rax,1)
    1128:	48 83 c0 01          	add    $0x1,%rax
    112c:	48 39 c3             	cmp    %rax,%rbx
    112f:	75 ef                	jne    1120 <n100_private_lz4_decompress_fast_extDict+0x2f0>
    1131:	e9 37 fd ff ff       	jmp    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
    1136:	49 8d 53 fb          	lea    -0x5(%r11),%rdx
    113a:	48 39 ca             	cmp    %rcx,%rdx
    113d:	72 b5                	jb     10f4 <n100_private_lz4_decompress_fast_extDict+0x2c4>
    113f:	49 83 c1 08          	add    $0x8,%r9
    1143:	49 8d 7b f9          	lea    -0x7(%r11),%rdi
    1147:	49 39 f9             	cmp    %rdi,%r9
    114a:	72 7b                	jb     11c7 <n100_private_lz4_decompress_fast_extDict+0x397>
    114c:	48 89 cf             	mov    %rcx,%rdi
    114f:	31 d2                	xor    %edx,%edx
    1151:	4c 29 cf             	sub    %r9,%rdi
    1154:	49 39 c9             	cmp    %rcx,%r9
    1157:	0f 83 10 fd ff ff    	jae    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
    115d:	0f 1f 00             	nopl   (%rax)
    1160:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
    1164:	41 88 34 11          	mov    %sil,(%r9,%rdx,1)
    1168:	48 83 c2 01          	add    $0x1,%rdx
    116c:	48 39 d7             	cmp    %rdx,%rdi
    116f:	75 ef                	jne    1160 <n100_private_lz4_decompress_fast_extDict+0x330>
    1171:	e9 f7 fc ff ff       	jmp    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
    1176:	0f b6 33             	movzbl (%rbx),%esi
    1179:	41 88 31             	mov    %sil,(%r9)
    117c:	0f b6 73 01          	movzbl 0x1(%rbx),%esi
    1180:	41 88 71 01          	mov    %sil,0x1(%r9)
    1184:	0f b6 73 02          	movzbl 0x2(%rbx),%esi
    1188:	41 88 71 02          	mov    %sil,0x2(%r9)
    118c:	0f b6 73 03          	movzbl 0x3(%rbx),%esi
    1190:	41 88 71 03          	mov    %sil,0x3(%r9)
    1194:	48 83 f8 08          	cmp    $0x8,%rax
    1198:	0f 83 c9 00 00 00    	jae    1267 <n100_private_lz4_decompress_fast_extDict+0x437>
    119e:	8b 34 85 00 00 00 00 	mov    0x0(,%rax,4),%esi
    11a5:	48 01 f3             	add    %rsi,%rbx
    11a8:	8b 33                	mov    (%rbx),%esi
    11aa:	41 89 71 04          	mov    %esi,0x4(%r9)
    11ae:	48 83 f8 08          	cmp    $0x8,%rax
    11b2:	73 59                	jae    120d <n100_private_lz4_decompress_fast_extDict+0x3dd>
    11b4:	48 63 34 85 00 00 00 	movslq 0x0(,%rax,4),%rsi
    11bb:	00 
    11bc:	48 89 d8             	mov    %rbx,%rax
    11bf:	48 29 f0             	sub    %rsi,%rax
    11c2:	e9 12 fe ff ff       	jmp    fd9 <n100_private_lz4_decompress_fast_extDict+0x1a9>
    11c7:	48 89 c6             	mov    %rax,%rsi
    11ca:	4c 89 ca             	mov    %r9,%rdx
    11cd:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    11d4:	00 
    11d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    11dc:	00 00 00 00 
    11e0:	48 8b 1e             	mov    (%rsi),%rbx
    11e3:	48 83 c2 08          	add    $0x8,%rdx
    11e7:	48 83 c6 08          	add    $0x8,%rsi
    11eb:	48 89 5a f8          	mov    %rbx,-0x8(%rdx)
    11ef:	48 39 fa             	cmp    %rdi,%rdx
    11f2:	72 ec                	jb     11e0 <n100_private_lz4_decompress_fast_extDict+0x3b0>
    11f4:	48 89 fa             	mov    %rdi,%rdx
    11f7:	4c 29 ca             	sub    %r9,%rdx
    11fa:	49 89 f9             	mov    %rdi,%r9
    11fd:	48 01 d0             	add    %rdx,%rax
    1200:	e9 47 ff ff ff       	jmp    114c <n100_private_lz4_decompress_fast_extDict+0x31c>
    1205:	48 89 f9             	mov    %rdi,%rcx
    1208:	e9 60 fc ff ff       	jmp    e6d <n100_private_lz4_decompress_fast_extDict+0x3d>
    120d:	48 89 c6             	mov    %rax,%rsi
    1210:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1217:	4c 89 44 24 38       	mov    %r8,0x38(%rsp)
    121c:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    1221:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
    1226:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    122b:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
    1230:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
    1235:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    123a:	e8 00 00 00 00       	call   123f <n100_private_lz4_decompress_fast_extDict+0x40f>
    123f:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
    1244:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    1249:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
    124e:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
    1253:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    1258:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
    125d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    1262:	e9 4d ff ff ff       	jmp    11b4 <n100_private_lz4_decompress_fast_extDict+0x384>
    1267:	48 89 c6             	mov    %rax,%rsi
    126a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1271:	4c 89 44 24 38       	mov    %r8,0x38(%rsp)
    1276:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    127b:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
    1280:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    1285:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
    128a:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
    128f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1294:	e8 00 00 00 00       	call   1299 <n100_private_lz4_decompress_fast_extDict+0x469>
    1299:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
    129e:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    12a3:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
    12a8:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
    12ad:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    12b2:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
    12b7:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    12bc:	e9 dd fe ff ff       	jmp    119e <n100_private_lz4_decompress_fast_extDict+0x36e>
    12c1:	0f 1f 40 00          	nopl   0x0(%rax)
    12c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    12cc:	00 00 00 00 
    12d0:	90                   	nop
    12d1:	90                   	nop
    12d2:	90                   	nop
    12d3:	90                   	nop
    12d4:	90                   	nop
    12d5:	90                   	nop
    12d6:	90                   	nop
    12d7:	90                   	nop
    12d8:	90                   	nop
    12d9:	90                   	nop
    12da:	90                   	nop
    12db:	90                   	nop
    12dc:	90                   	nop
    12dd:	90                   	nop
    12de:	90                   	nop
    12df:	90                   	nop

00000000000012e0 <n100_private_lz4_decompress_safe>:
    12e0:	f3 0f 1e fa          	endbr64
    12e4:	e8 00 00 00 00       	call   12e9 <n100_private_lz4_decompress_safe+0x9>
    12e9:	85 c9                	test   %ecx,%ecx
    12eb:	0f 84 41 02 00 00    	je     1532 <n100_private_lz4_decompress_safe+0x252>
    12f1:	85 d2                	test   %edx,%edx
    12f3:	0f 84 3e 02 00 00    	je     1537 <n100_private_lz4_decompress_safe+0x257>
    12f9:	41 56                	push   %r14
    12fb:	48 63 d2             	movslq %edx,%rdx
    12fe:	48 63 c9             	movslq %ecx,%rcx
    1301:	49 89 f3             	mov    %rsi,%r11
    1304:	41 55                	push   %r13
    1306:	4c 8d 14 17          	lea    (%rdi,%rdx,1),%r10
    130a:	4c 8d 0c 0e          	lea    (%rsi,%rcx,1),%r9
    130e:	49 89 f0             	mov    %rsi,%r8
    1311:	41 54                	push   %r12
    1313:	48 89 f8             	mov    %rdi,%rax
    1316:	4d 8d 61 e0          	lea    -0x20(%r9),%r12
    131a:	55                   	push   %rbp
    131b:	49 8d 6a f0          	lea    -0x10(%r10),%rbp
    131f:	53                   	push   %rbx
    1320:	48 89 fb             	mov    %rdi,%rbx
    1323:	48 83 ec 38          	sub    $0x38,%rsp
    1327:	0f b6 10             	movzbl (%rax),%edx
    132a:	48 8d 70 01          	lea    0x1(%rax),%rsi
    132e:	89 d7                	mov    %edx,%edi
    1330:	c1 ea 04             	shr    $0x4,%edx
    1333:	83 fa 0f             	cmp    $0xf,%edx
    1336:	74 7d                	je     13b5 <n100_private_lz4_decompress_safe+0xd5>
    1338:	48 39 ee             	cmp    %rbp,%rsi
    133b:	0f 83 00 02 00 00    	jae    1541 <n100_private_lz4_decompress_safe+0x261>
    1341:	4d 39 c4             	cmp    %r8,%r12
    1344:	0f 82 f7 01 00 00    	jb     1541 <n100_private_lz4_decompress_safe+0x261>
    134a:	48 8b 40 01          	mov    0x1(%rax),%rax
    134e:	4c 8d 34 16          	lea    (%rsi,%rdx,1),%r14
    1352:	48 89 f9             	mov    %rdi,%rcx
    1355:	4d 8d 2c 10          	lea    (%r8,%rdx,1),%r13
    1359:	f7 d7                	not    %edi
    135b:	83 e1 0f             	and    $0xf,%ecx
    135e:	49 89 00             	mov    %rax,(%r8)
    1361:	48 8b 46 08          	mov    0x8(%rsi),%rax
    1365:	49 89 40 08          	mov    %rax,0x8(%r8)
    1369:	41 0f b7 36          	movzwl (%r14),%esi
    136d:	49 8d 46 02          	lea    0x2(%r14),%rax
    1371:	48 29 f2             	sub    %rsi,%rdx
    1374:	4c 01 c2             	add    %r8,%rdx
    1377:	83 e7 0f             	and    $0xf,%edi
    137a:	0f 84 27 01 00 00    	je     14a7 <n100_private_lz4_decompress_safe+0x1c7>
    1380:	48 83 fe 07          	cmp    $0x7,%rsi
    1384:	0f 86 1d 01 00 00    	jbe    14a7 <n100_private_lz4_decompress_safe+0x1c7>
    138a:	4c 39 da             	cmp    %r11,%rdx
    138d:	0f 82 89 01 00 00    	jb     151c <n100_private_lz4_decompress_safe+0x23c>
    1393:	48 8b 32             	mov    (%rdx),%rsi
    1396:	4d 8d 44 0d 04       	lea    0x4(%r13,%rcx,1),%r8
    139b:	49 89 75 00          	mov    %rsi,0x0(%r13)
    139f:	48 8b 72 08          	mov    0x8(%rdx),%rsi
    13a3:	49 89 75 08          	mov    %rsi,0x8(%r13)
    13a7:	0f b7 52 10          	movzwl 0x10(%rdx),%edx
    13ab:	66 41 89 55 10       	mov    %dx,0x10(%r13)
    13b0:	e9 72 ff ff ff       	jmp    1327 <n100_private_lz4_decompress_safe+0x47>
    13b5:	4d 8d 6a f1          	lea    -0xf(%r10),%r13
    13b9:	4c 39 ee             	cmp    %r13,%rsi
    13bc:	0f 83 57 01 00 00    	jae    1519 <n100_private_lz4_decompress_safe+0x239>
    13c2:	ba 0f 00 00 00       	mov    $0xf,%edx
    13c7:	eb 1c                	jmp    13e5 <n100_private_lz4_decompress_safe+0x105>
    13c9:	90                   	nop
    13ca:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    13d1:	00 00 00 00 
    13d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    13dc:	00 00 00 00 
    13e0:	80 f9 ff             	cmp    $0xff,%cl
    13e3:	75 0f                	jne    13f4 <n100_private_lz4_decompress_safe+0x114>
    13e5:	0f b6 0e             	movzbl (%rsi),%ecx
    13e8:	48 83 c6 01          	add    $0x1,%rsi
    13ec:	48 01 ca             	add    %rcx,%rdx
    13ef:	49 39 f5             	cmp    %rsi,%r13
    13f2:	75 ec                	jne    13e0 <n100_private_lz4_decompress_safe+0x100>
    13f4:	4c 89 c0             	mov    %r8,%rax
    13f7:	4a 8d 0c 02          	lea    (%rdx,%r8,1),%rcx
    13fb:	48 01 d0             	add    %rdx,%rax
    13fe:	0f 82 15 01 00 00    	jb     1519 <n100_private_lz4_decompress_safe+0x239>
    1404:	49 89 f6             	mov    %rsi,%r14
    1407:	48 8d 04 32          	lea    (%rdx,%rsi,1),%rax
    140b:	49 01 d6             	add    %rdx,%r14
    140e:	0f 82 05 01 00 00    	jb     1519 <n100_private_lz4_decompress_safe+0x239>
    1414:	4d 8d 71 f4          	lea    -0xc(%r9),%r14
    1418:	49 89 cd             	mov    %rcx,%r13
    141b:	49 39 ce             	cmp    %rcx,%r14
    141e:	73 3b                	jae    145b <n100_private_lz4_decompress_safe+0x17b>
    1420:	49 39 c2             	cmp    %rax,%r10
    1423:	0f 85 f0 00 00 00    	jne    1519 <n100_private_lz4_decompress_safe+0x239>
    1429:	49 39 c9             	cmp    %rcx,%r9
    142c:	0f 82 e7 00 00 00    	jb     1519 <n100_private_lz4_decompress_safe+0x239>
    1432:	4c 89 c7             	mov    %r8,%rdi
    1435:	48 89 0c 24          	mov    %rcx,(%rsp)
    1439:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
    143e:	e8 00 00 00 00       	call   1443 <n100_private_lz4_decompress_safe+0x163>
    1443:	8b 04 24             	mov    (%rsp),%eax
    1446:	2b 44 24 08          	sub    0x8(%rsp),%eax
    144a:	48 83 c4 38          	add    $0x38,%rsp
    144e:	5b                   	pop    %rbx
    144f:	5d                   	pop    %rbp
    1450:	41 5c                	pop    %r12
    1452:	41 5d                	pop    %r13
    1454:	41 5e                	pop    %r14
    1456:	e9 00 00 00 00       	jmp    145b <n100_private_lz4_decompress_safe+0x17b>
    145b:	4d 8d 72 f8          	lea    -0x8(%r10),%r14
    145f:	49 39 c6             	cmp    %rax,%r14
    1462:	72 bc                	jb     1420 <n100_private_lz4_decompress_safe+0x140>
    1464:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    146a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1471:	00 00 00 00 
    1475:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    147c:	00 00 00 00 
    1480:	48 8b 16             	mov    (%rsi),%rdx
    1483:	49 83 c0 08          	add    $0x8,%r8
    1487:	48 83 c6 08          	add    $0x8,%rsi
    148b:	49 89 50 f8          	mov    %rdx,-0x8(%r8)
    148f:	49 39 c8             	cmp    %rcx,%r8
    1492:	72 ec                	jb     1480 <n100_private_lz4_decompress_safe+0x1a0>
    1494:	0f b7 30             	movzwl (%rax),%esi
    1497:	48 83 c0 02          	add    $0x2,%rax
    149b:	48 29 f1             	sub    %rsi,%rcx
    149e:	48 89 ca             	mov    %rcx,%rdx
    14a1:	48 89 f9             	mov    %rdi,%rcx
    14a4:	83 e1 0f             	and    $0xf,%ecx
    14a7:	4c 39 da             	cmp    %r11,%rdx
    14aa:	72 70                	jb     151c <n100_private_lz4_decompress_safe+0x23c>
    14ac:	41 89 75 00          	mov    %esi,0x0(%r13)
    14b0:	48 83 f9 0f          	cmp    $0xf,%rcx
    14b4:	0f 84 a0 00 00 00    	je     155a <n100_private_lz4_decompress_safe+0x27a>
    14ba:	4c 8d 71 04          	lea    0x4(%rcx),%r14
    14be:	4f 8d 44 35 00       	lea    0x0(%r13,%r14,1),%r8
    14c3:	48 83 fe 07          	cmp    $0x7,%rsi
    14c7:	0f 86 b8 00 00 00    	jbe    1585 <n100_private_lz4_decompress_safe+0x2a5>
    14cd:	48 8b 0a             	mov    (%rdx),%rcx
    14d0:	49 89 4d 00          	mov    %rcx,0x0(%r13)
    14d4:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
    14d8:	49 8d 51 f4          	lea    -0xc(%r9),%rdx
    14dc:	4c 39 c2             	cmp    %r8,%rdx
    14df:	0f 82 ef 00 00 00    	jb     15d4 <n100_private_lz4_decompress_safe+0x2f4>
    14e5:	48 8b 11             	mov    (%rcx),%rdx
    14e8:	49 89 55 08          	mov    %rdx,0x8(%r13)
    14ec:	49 83 fe 10          	cmp    $0x10,%r14
    14f0:	0f 86 31 fe ff ff    	jbe    1327 <n100_private_lz4_decompress_safe+0x47>
    14f6:	48 83 c1 08          	add    $0x8,%rcx
    14fa:	49 8d 55 10          	lea    0x10(%r13),%rdx
    14fe:	66 90                	xchg   %ax,%ax
    1500:	48 8b 31             	mov    (%rcx),%rsi
    1503:	48 83 c2 08          	add    $0x8,%rdx
    1507:	48 83 c1 08          	add    $0x8,%rcx
    150b:	48 89 72 f8          	mov    %rsi,-0x8(%rdx)
    150f:	4c 39 c2             	cmp    %r8,%rdx
    1512:	72 ec                	jb     1500 <n100_private_lz4_decompress_safe+0x220>
    1514:	e9 0e fe ff ff       	jmp    1327 <n100_private_lz4_decompress_safe+0x47>
    1519:	48 89 f0             	mov    %rsi,%rax
    151c:	48 83 c4 38          	add    $0x38,%rsp
    1520:	48 29 d8             	sub    %rbx,%rax
    1523:	f7 d0                	not    %eax
    1525:	5b                   	pop    %rbx
    1526:	5d                   	pop    %rbp
    1527:	41 5c                	pop    %r12
    1529:	41 5d                	pop    %r13
    152b:	41 5e                	pop    %r14
    152d:	e9 00 00 00 00       	jmp    1532 <n100_private_lz4_decompress_safe+0x252>
    1532:	83 fa 01             	cmp    $0x1,%edx
    1535:	74 17                	je     154e <n100_private_lz4_decompress_safe+0x26e>
    1537:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    153c:	e9 00 00 00 00       	jmp    1541 <n100_private_lz4_decompress_safe+0x261>
    1541:	49 8d 0c 10          	lea    (%r8,%rdx,1),%rcx
    1545:	48 8d 04 16          	lea    (%rsi,%rdx,1),%rax
    1549:	e9 c6 fe ff ff       	jmp    1414 <n100_private_lz4_decompress_safe+0x134>
    154e:	0f b6 07             	movzbl (%rdi),%eax
    1551:	f6 d8                	neg    %al
    1553:	19 c0                	sbb    %eax,%eax
    1555:	e9 00 00 00 00       	jmp    155a <n100_private_lz4_decompress_safe+0x27a>
    155a:	4d 8d 72 fb          	lea    -0x5(%r10),%r14
    155e:	66 90                	xchg   %ax,%ax
    1560:	48 83 c0 01          	add    $0x1,%rax
    1564:	49 39 c6             	cmp    %rax,%r14
    1567:	72 b3                	jb     151c <n100_private_lz4_decompress_safe+0x23c>
    1569:	44 0f b6 40 ff       	movzbl -0x1(%rax),%r8d
    156e:	4c 01 c1             	add    %r8,%rcx
    1571:	41 80 f8 ff          	cmp    $0xff,%r8b
    1575:	74 e9                	je     1560 <n100_private_lz4_decompress_safe+0x280>
    1577:	4c 89 ef             	mov    %r13,%rdi
    157a:	48 01 cf             	add    %rcx,%rdi
    157d:	0f 83 37 ff ff ff    	jae    14ba <n100_private_lz4_decompress_safe+0x1da>
    1583:	eb 97                	jmp    151c <n100_private_lz4_decompress_safe+0x23c>
    1585:	0f b6 0a             	movzbl (%rdx),%ecx
    1588:	41 88 4d 00          	mov    %cl,0x0(%r13)
    158c:	0f b6 4a 01          	movzbl 0x1(%rdx),%ecx
    1590:	41 88 4d 01          	mov    %cl,0x1(%r13)
    1594:	0f b6 4a 02          	movzbl 0x2(%rdx),%ecx
    1598:	41 88 4d 02          	mov    %cl,0x2(%r13)
    159c:	0f b6 4a 03          	movzbl 0x3(%rdx),%ecx
    15a0:	41 88 4d 03          	mov    %cl,0x3(%r13)
    15a4:	48 83 fe 08          	cmp    $0x8,%rsi
    15a8:	0f 83 e9 00 00 00    	jae    1697 <n100_private_lz4_decompress_safe+0x3b7>
    15ae:	8b 0c b5 00 00 00 00 	mov    0x0(,%rsi,4),%ecx
    15b5:	48 01 d1             	add    %rdx,%rcx
    15b8:	8b 11                	mov    (%rcx),%edx
    15ba:	41 89 55 04          	mov    %edx,0x4(%r13)
    15be:	48 83 fe 08          	cmp    $0x8,%rsi
    15c2:	73 7e                	jae    1642 <n100_private_lz4_decompress_safe+0x362>
    15c4:	48 63 14 b5 00 00 00 	movslq 0x0(,%rsi,4),%rdx
    15cb:	00 
    15cc:	48 29 d1             	sub    %rdx,%rcx
    15cf:	e9 04 ff ff ff       	jmp    14d8 <n100_private_lz4_decompress_safe+0x1f8>
    15d4:	49 8d 51 fb          	lea    -0x5(%r9),%rdx
    15d8:	4c 39 c2             	cmp    %r8,%rdx
    15db:	0f 82 3b ff ff ff    	jb     151c <n100_private_lz4_decompress_safe+0x23c>
    15e1:	49 8d 55 08          	lea    0x8(%r13),%rdx
    15e5:	4d 8d 71 f9          	lea    -0x7(%r9),%r14
    15e9:	4c 39 f2             	cmp    %r14,%rdx
    15ec:	72 28                	jb     1616 <n100_private_lz4_decompress_safe+0x336>
    15ee:	4d 89 c5             	mov    %r8,%r13
    15f1:	31 f6                	xor    %esi,%esi
    15f3:	49 29 d5             	sub    %rdx,%r13
    15f6:	4c 39 c2             	cmp    %r8,%rdx
    15f9:	0f 83 28 fd ff ff    	jae    1327 <n100_private_lz4_decompress_safe+0x47>
    15ff:	90                   	nop
    1600:	0f b6 3c 31          	movzbl (%rcx,%rsi,1),%edi
    1604:	40 88 3c 32          	mov    %dil,(%rdx,%rsi,1)
    1608:	48 83 c6 01          	add    $0x1,%rsi
    160c:	4c 39 ee             	cmp    %r13,%rsi
    160f:	75 ef                	jne    1600 <n100_private_lz4_decompress_safe+0x320>
    1611:	e9 11 fd ff ff       	jmp    1327 <n100_private_lz4_decompress_safe+0x47>
    1616:	48 89 cf             	mov    %rcx,%rdi
    1619:	48 89 d6             	mov    %rdx,%rsi
    161c:	0f 1f 40 00          	nopl   0x0(%rax)
    1620:	4c 8b 2f             	mov    (%rdi),%r13
    1623:	48 83 c6 08          	add    $0x8,%rsi
    1627:	48 83 c7 08          	add    $0x8,%rdi
    162b:	4c 89 6e f8          	mov    %r13,-0x8(%rsi)
    162f:	4c 39 f6             	cmp    %r14,%rsi
    1632:	72 ec                	jb     1620 <n100_private_lz4_decompress_safe+0x340>
    1634:	4c 89 f6             	mov    %r14,%rsi
    1637:	48 29 d6             	sub    %rdx,%rsi
    163a:	4c 89 f2             	mov    %r14,%rdx
    163d:	48 01 f1             	add    %rsi,%rcx
    1640:	eb ac                	jmp    15ee <n100_private_lz4_decompress_safe+0x30e>
    1642:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1649:	4c 89 5c 24 30       	mov    %r11,0x30(%rsp)
    164e:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    1653:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    1658:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    165d:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    1662:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
    1667:	48 89 34 24          	mov    %rsi,(%rsp)
    166b:	e8 00 00 00 00       	call   1670 <n100_private_lz4_decompress_safe+0x390>
    1670:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
    1675:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    167a:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    167f:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
    1684:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    1689:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
    168e:	48 8b 34 24          	mov    (%rsp),%rsi
    1692:	e9 2d ff ff ff       	jmp    15c4 <n100_private_lz4_decompress_safe+0x2e4>
    1697:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    169e:	4c 89 5c 24 30       	mov    %r11,0x30(%rsp)
    16a3:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    16a8:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    16ad:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    16b2:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    16b7:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
    16bc:	48 89 34 24          	mov    %rsi,(%rsp)
    16c0:	e8 00 00 00 00       	call   16c5 <n100_private_lz4_decompress_safe+0x3e5>
    16c5:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
    16ca:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    16cf:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    16d4:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
    16d9:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
    16de:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
    16e3:	48 8b 34 24          	mov    (%rsp),%rsi
    16e7:	e9 c2 fe ff ff       	jmp    15ae <n100_private_lz4_decompress_safe+0x2ce>
    16ec:	0f 1f 40 00          	nopl   0x0(%rax)
    16f0:	90                   	nop
    16f1:	90                   	nop
    16f2:	90                   	nop
    16f3:	90                   	nop
    16f4:	90                   	nop
    16f5:	90                   	nop
    16f6:	90                   	nop
    16f7:	90                   	nop
    16f8:	90                   	nop
    16f9:	90                   	nop
    16fa:	90                   	nop
    16fb:	90                   	nop
    16fc:	90                   	nop
    16fd:	90                   	nop
    16fe:	90                   	nop
    16ff:	90                   	nop

0000000000001700 <n100_private_lz4_decompress_safe_partial>:
    1700:	f3 0f 1e fa          	endbr64
    1704:	e8 00 00 00 00       	call   1709 <n100_private_lz4_decompress_safe_partial+0x9>
    1709:	44 39 c1             	cmp    %r8d,%ecx
    170c:	41 0f 4f c8          	cmovg  %r8d,%ecx
    1710:	85 c9                	test   %ecx,%ecx
    1712:	0f 84 64 03 00 00    	je     1a7c <n100_private_lz4_decompress_safe_partial+0x37c>
    1718:	85 d2                	test   %edx,%edx
    171a:	0f 84 61 03 00 00    	je     1a81 <n100_private_lz4_decompress_safe_partial+0x381>
    1720:	41 57                	push   %r15
    1722:	48 63 d2             	movslq %edx,%rdx
    1725:	48 63 c9             	movslq %ecx,%rcx
    1728:	49 89 f0             	mov    %rsi,%r8
    172b:	41 56                	push   %r14
    172d:	4c 8d 34 17          	lea    (%rdi,%rdx,1),%r14
    1731:	41 55                	push   %r13
    1733:	49 8d 46 f0          	lea    -0x10(%r14),%rax
    1737:	49 89 fd             	mov    %rdi,%r13
    173a:	41 54                	push   %r12
    173c:	49 89 f4             	mov    %rsi,%r12
    173f:	55                   	push   %rbp
    1740:	48 8d 2c 0e          	lea    (%rsi,%rcx,1),%rbp
    1744:	48 89 f9             	mov    %rdi,%rcx
    1747:	53                   	push   %rbx
    1748:	48 83 ec 38          	sub    $0x38,%rsp
    174c:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1751:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
    1755:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    175a:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
    175e:	48 89 04 24          	mov    %rax,(%rsp)
    1762:	0f b6 11             	movzbl (%rcx),%edx
    1765:	48 8d 71 01          	lea    0x1(%rcx),%rsi
    1769:	41 89 d7             	mov    %edx,%r15d
    176c:	c1 ea 04             	shr    $0x4,%edx
    176f:	83 fa 0f             	cmp    $0xf,%edx
    1772:	74 7c                	je     17f0 <n100_private_lz4_decompress_safe_partial+0xf0>
    1774:	48 3b 74 24 08       	cmp    0x8(%rsp),%rsi
    1779:	0f 83 0c 03 00 00    	jae    1a8b <n100_private_lz4_decompress_safe_partial+0x38b>
    177f:	4c 39 44 24 10       	cmp    %r8,0x10(%rsp)
    1784:	0f 82 01 03 00 00    	jb     1a8b <n100_private_lz4_decompress_safe_partial+0x38b>
    178a:	48 8b 41 01          	mov    0x1(%rcx),%rax
    178e:	4c 89 ff             	mov    %r15,%rdi
    1791:	41 f7 d7             	not    %r15d
    1794:	49 8d 1c 10          	lea    (%r8,%rdx,1),%rbx
    1798:	83 e7 0f             	and    $0xf,%edi
    179b:	49 89 00             	mov    %rax,(%r8)
    179e:	48 8b 46 08          	mov    0x8(%rsi),%rax
    17a2:	49 89 40 08          	mov    %rax,0x8(%r8)
    17a6:	48 8d 04 16          	lea    (%rsi,%rdx,1),%rax
    17aa:	0f b7 30             	movzwl (%rax),%esi
    17ad:	48 8d 48 02          	lea    0x2(%rax),%rcx
    17b1:	48 29 f2             	sub    %rsi,%rdx
    17b4:	41 83 e7 0f          	and    $0xf,%r15d
    17b8:	49 8d 04 10          	lea    (%r8,%rdx,1),%rax
    17bc:	0f 84 f9 00 00 00    	je     18bb <n100_private_lz4_decompress_safe_partial+0x1bb>
    17c2:	48 83 fe 07          	cmp    $0x7,%rsi
    17c6:	0f 86 ef 00 00 00    	jbe    18bb <n100_private_lz4_decompress_safe_partial+0x1bb>
    17cc:	4c 39 e0             	cmp    %r12,%rax
    17cf:	0f 83 24 02 00 00    	jae    19f9 <n100_private_lz4_decompress_safe_partial+0x2f9>
    17d5:	48 89 c8             	mov    %rcx,%rax
    17d8:	48 83 c4 38          	add    $0x38,%rsp
    17dc:	4c 29 e8             	sub    %r13,%rax
    17df:	5b                   	pop    %rbx
    17e0:	5d                   	pop    %rbp
    17e1:	f7 d0                	not    %eax
    17e3:	41 5c                	pop    %r12
    17e5:	41 5d                	pop    %r13
    17e7:	41 5e                	pop    %r14
    17e9:	41 5f                	pop    %r15
    17eb:	e9 00 00 00 00       	jmp    17f0 <n100_private_lz4_decompress_safe_partial+0xf0>
    17f0:	49 8d 7e f1          	lea    -0xf(%r14),%rdi
    17f4:	48 39 fe             	cmp    %rdi,%rsi
    17f7:	0f 83 54 01 00 00    	jae    1951 <n100_private_lz4_decompress_safe_partial+0x251>
    17fd:	ba 0f 00 00 00       	mov    $0xf,%edx
    1802:	eb 21                	jmp    1825 <n100_private_lz4_decompress_safe_partial+0x125>
    1804:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    180a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1811:	00 00 00 00 
    1815:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    181c:	00 00 00 00 
    1820:	80 f9 ff             	cmp    $0xff,%cl
    1823:	75 0f                	jne    1834 <n100_private_lz4_decompress_safe_partial+0x134>
    1825:	0f b6 0e             	movzbl (%rsi),%ecx
    1828:	48 83 c6 01          	add    $0x1,%rsi
    182c:	48 01 ca             	add    %rcx,%rdx
    182f:	48 39 f7             	cmp    %rsi,%rdi
    1832:	75 ec                	jne    1820 <n100_private_lz4_decompress_safe_partial+0x120>
    1834:	4c 89 c0             	mov    %r8,%rax
    1837:	4e 8d 14 02          	lea    (%rdx,%r8,1),%r10
    183b:	48 01 d0             	add    %rdx,%rax
    183e:	0f 82 0d 01 00 00    	jb     1951 <n100_private_lz4_decompress_safe_partial+0x251>
    1844:	48 89 f0             	mov    %rsi,%rax
    1847:	48 01 d0             	add    %rdx,%rax
    184a:	0f 82 01 01 00 00    	jb     1951 <n100_private_lz4_decompress_safe_partial+0x251>
    1850:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
    1854:	4c 89 d3             	mov    %r10,%rbx
    1857:	4c 39 d0             	cmp    %r10,%rax
    185a:	0f 83 59 01 00 00    	jae    19b9 <n100_private_lz4_decompress_safe_partial+0x2b9>
    1860:	4c 39 d5             	cmp    %r10,%rbp
    1863:	0f 82 d5 00 00 00    	jb     193e <n100_private_lz4_decompress_safe_partial+0x23e>
    1869:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
    186d:	49 39 ce             	cmp    %rcx,%r14
    1870:	0f 82 db 00 00 00    	jb     1951 <n100_private_lz4_decompress_safe_partial+0x251>
    1876:	4c 89 c7             	mov    %r8,%rdi
    1879:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    187e:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
    1883:	e8 00 00 00 00       	call   1888 <n100_private_lz4_decompress_safe_partial+0x188>
    1888:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
    188d:	4c 39 d5             	cmp    %r10,%rbp
    1890:	0f 84 70 02 00 00    	je     1b06 <n100_private_lz4_decompress_safe_partial+0x406>
    1896:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    189b:	49 8d 46 fe          	lea    -0x2(%r14),%rax
    189f:	48 39 c1             	cmp    %rax,%rcx
    18a2:	0f 83 5e 02 00 00    	jae    1b06 <n100_private_lz4_decompress_safe_partial+0x406>
    18a8:	0f b7 31             	movzwl (%rcx),%esi
    18ab:	4c 89 d0             	mov    %r10,%rax
    18ae:	4c 89 ff             	mov    %r15,%rdi
    18b1:	48 83 c1 02          	add    $0x2,%rcx
    18b5:	83 e7 0f             	and    $0xf,%edi
    18b8:	48 29 f0             	sub    %rsi,%rax
    18bb:	4c 39 e0             	cmp    %r12,%rax
    18be:	0f 82 11 ff ff ff    	jb     17d5 <n100_private_lz4_decompress_safe_partial+0xd5>
    18c4:	48 83 ff 0f          	cmp    $0xf,%rdi
    18c8:	0f 84 88 01 00 00    	je     1a56 <n100_private_lz4_decompress_safe_partial+0x356>
    18ce:	4c 8d 7f 04          	lea    0x4(%rdi),%r15
    18d2:	4e 8d 04 3b          	lea    (%rbx,%r15,1),%r8
    18d6:	4c 39 04 24          	cmp    %r8,(%rsp)
    18da:	73 7d                	jae    1959 <n100_private_lz4_decompress_safe_partial+0x259>
    18dc:	48 89 ee             	mov    %rbp,%rsi
    18df:	48 29 de             	sub    %rbx,%rsi
    18e2:	4c 39 fe             	cmp    %r15,%rsi
    18e5:	49 0f 47 f7          	cmova  %r15,%rsi
    18e9:	48 8d 14 30          	lea    (%rax,%rsi,1),%rdx
    18ed:	4c 8d 04 33          	lea    (%rbx,%rsi,1),%r8
    18f1:	48 39 d3             	cmp    %rdx,%rbx
    18f4:	0f 82 1f 01 00 00    	jb     1a19 <n100_private_lz4_decompress_safe_partial+0x319>
    18fa:	48 89 f2             	mov    %rsi,%rdx
    18fd:	48 89 df             	mov    %rbx,%rdi
    1900:	48 89 c6             	mov    %rax,%rsi
    1903:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    1908:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    190d:	e8 00 00 00 00       	call   1912 <n100_private_lz4_decompress_safe_partial+0x212>
    1912:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    1917:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
    191c:	4c 39 c5             	cmp    %r8,%rbp
    191f:	0f 85 3d fe ff ff    	jne    1762 <n100_private_lz4_decompress_safe_partial+0x62>
    1925:	48 83 c4 38          	add    $0x38,%rsp
    1929:	44 89 c0             	mov    %r8d,%eax
    192c:	5b                   	pop    %rbx
    192d:	44 29 e0             	sub    %r12d,%eax
    1930:	5d                   	pop    %rbp
    1931:	41 5c                	pop    %r12
    1933:	41 5d                	pop    %r13
    1935:	41 5e                	pop    %r14
    1937:	41 5f                	pop    %r15
    1939:	e9 00 00 00 00       	jmp    193e <n100_private_lz4_decompress_safe_partial+0x23e>
    193e:	48 89 ea             	mov    %rbp,%rdx
    1941:	4c 29 c2             	sub    %r8,%rdx
    1944:	48 8d 04 16          	lea    (%rsi,%rdx,1),%rax
    1948:	49 39 c6             	cmp    %rax,%r14
    194b:	0f 83 a5 01 00 00    	jae    1af6 <n100_private_lz4_decompress_safe_partial+0x3f6>
    1951:	48 89 f1             	mov    %rsi,%rcx
    1954:	e9 7c fe ff ff       	jmp    17d5 <n100_private_lz4_decompress_safe_partial+0xd5>
    1959:	48 83 fe 07          	cmp    $0x7,%rsi
    195d:	0f 86 42 01 00 00    	jbe    1aa5 <n100_private_lz4_decompress_safe_partial+0x3a5>
    1963:	48 8b 10             	mov    (%rax),%rdx
    1966:	48 83 c0 08          	add    $0x8,%rax
    196a:	48 89 13             	mov    %rdx,(%rbx)
    196d:	48 8b 10             	mov    (%rax),%rdx
    1970:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    1974:	49 83 ff 10          	cmp    $0x10,%r15
    1978:	0f 86 e4 fd ff ff    	jbe    1762 <n100_private_lz4_decompress_safe_partial+0x62>
    197e:	48 83 c0 08          	add    $0x8,%rax
    1982:	48 83 c3 10          	add    $0x10,%rbx
    1986:	0f 1f 40 00          	nopl   0x0(%rax)
    198a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1991:	00 00 00 00 
    1995:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    199c:	00 00 00 00 
    19a0:	48 8b 10             	mov    (%rax),%rdx
    19a3:	48 83 c3 08          	add    $0x8,%rbx
    19a7:	48 83 c0 08          	add    $0x8,%rax
    19ab:	48 89 53 f8          	mov    %rdx,-0x8(%rbx)
    19af:	4c 39 c3             	cmp    %r8,%rbx
    19b2:	72 ec                	jb     19a0 <n100_private_lz4_decompress_safe_partial+0x2a0>
    19b4:	e9 a9 fd ff ff       	jmp    1762 <n100_private_lz4_decompress_safe_partial+0x62>
    19b9:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
    19bd:	49 8d 46 f8          	lea    -0x8(%r14),%rax
    19c1:	48 39 c8             	cmp    %rcx,%rax
    19c4:	0f 82 96 fe ff ff    	jb     1860 <n100_private_lz4_decompress_safe_partial+0x160>
    19ca:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    19d1:	00 00 00 00 
    19d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    19dc:	00 00 00 00 
    19e0:	48 8b 06             	mov    (%rsi),%rax
    19e3:	49 83 c0 08          	add    $0x8,%r8
    19e7:	48 83 c6 08          	add    $0x8,%rsi
    19eb:	49 89 40 f8          	mov    %rax,-0x8(%r8)
    19ef:	4d 39 d0             	cmp    %r10,%r8
    19f2:	72 ec                	jb     19e0 <n100_private_lz4_decompress_safe_partial+0x2e0>
    19f4:	e9 af fe ff ff       	jmp    18a8 <n100_private_lz4_decompress_safe_partial+0x1a8>
    19f9:	48 8b 10             	mov    (%rax),%rdx
    19fc:	4c 8d 44 3b 04       	lea    0x4(%rbx,%rdi,1),%r8
    1a01:	48 89 13             	mov    %rdx,(%rbx)
    1a04:	48 8b 50 08          	mov    0x8(%rax),%rdx
    1a08:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    1a0c:	0f b7 40 10          	movzwl 0x10(%rax),%eax
    1a10:	66 89 43 10          	mov    %ax,0x10(%rbx)
    1a14:	e9 49 fd ff ff       	jmp    1762 <n100_private_lz4_decompress_safe_partial+0x62>
    1a19:	4c 39 c3             	cmp    %r8,%rbx
    1a1c:	0f 83 fa fe ff ff    	jae    191c <n100_private_lz4_decompress_safe_partial+0x21c>
    1a22:	31 d2                	xor    %edx,%edx
    1a24:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1a2a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1a31:	00 00 00 00 
    1a35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1a3c:	00 00 00 00 
    1a40:	0f b6 3c 10          	movzbl (%rax,%rdx,1),%edi
    1a44:	40 88 3c 13          	mov    %dil,(%rbx,%rdx,1)
    1a48:	48 83 c2 01          	add    $0x1,%rdx
    1a4c:	48 39 d6             	cmp    %rdx,%rsi
    1a4f:	75 ef                	jne    1a40 <n100_private_lz4_decompress_safe_partial+0x340>
    1a51:	e9 c6 fe ff ff       	jmp    191c <n100_private_lz4_decompress_safe_partial+0x21c>
    1a56:	4d 8d 56 fb          	lea    -0x5(%r14),%r10
    1a5a:	eb 12                	jmp    1a6e <n100_private_lz4_decompress_safe_partial+0x36e>
    1a5c:	0f 1f 40 00          	nopl   0x0(%rax)
    1a60:	44 0f b6 41 ff       	movzbl -0x1(%rcx),%r8d
    1a65:	4c 01 c7             	add    %r8,%rdi
    1a68:	41 80 f8 ff          	cmp    $0xff,%r8b
    1a6c:	75 26                	jne    1a94 <n100_private_lz4_decompress_safe_partial+0x394>
    1a6e:	48 83 c1 01          	add    $0x1,%rcx
    1a72:	49 39 ca             	cmp    %rcx,%r10
    1a75:	73 e9                	jae    1a60 <n100_private_lz4_decompress_safe_partial+0x360>
    1a77:	e9 59 fd ff ff       	jmp    17d5 <n100_private_lz4_decompress_safe_partial+0xd5>
    1a7c:	83 fa 01             	cmp    $0x1,%edx
    1a7f:	74 69                	je     1aea <n100_private_lz4_decompress_safe_partial+0x3ea>
    1a81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1a86:	e9 00 00 00 00       	jmp    1a8b <n100_private_lz4_decompress_safe_partial+0x38b>
    1a8b:	4d 8d 14 10          	lea    (%r8,%rdx,1),%r10
    1a8f:	e9 bc fd ff ff       	jmp    1850 <n100_private_lz4_decompress_safe_partial+0x150>
    1a94:	48 89 da             	mov    %rbx,%rdx
    1a97:	48 01 fa             	add    %rdi,%rdx
    1a9a:	0f 83 2e fe ff ff    	jae    18ce <n100_private_lz4_decompress_safe_partial+0x1ce>
    1aa0:	e9 30 fd ff ff       	jmp    17d5 <n100_private_lz4_decompress_safe_partial+0xd5>
    1aa5:	0f b6 10             	movzbl (%rax),%edx
    1aa8:	88 13                	mov    %dl,(%rbx)
    1aaa:	0f b6 50 01          	movzbl 0x1(%rax),%edx
    1aae:	88 53 01             	mov    %dl,0x1(%rbx)
    1ab1:	0f b6 50 02          	movzbl 0x2(%rax),%edx
    1ab5:	88 53 02             	mov    %dl,0x2(%rbx)
    1ab8:	0f b6 50 03          	movzbl 0x3(%rax),%edx
    1abc:	88 53 03             	mov    %dl,0x3(%rbx)
    1abf:	48 83 fe 08          	cmp    $0x8,%rsi
    1ac3:	73 7f                	jae    1b44 <n100_private_lz4_decompress_safe_partial+0x444>
    1ac5:	8b 14 b5 00 00 00 00 	mov    0x0(,%rsi,4),%edx
    1acc:	48 01 d0             	add    %rdx,%rax
    1acf:	8b 10                	mov    (%rax),%edx
    1ad1:	89 53 04             	mov    %edx,0x4(%rbx)
    1ad4:	48 83 fe 08          	cmp    $0x8,%rsi
    1ad8:	73 34                	jae    1b0e <n100_private_lz4_decompress_safe_partial+0x40e>
    1ada:	48 63 14 b5 00 00 00 	movslq 0x0(,%rsi,4),%rdx
    1ae1:	00 
    1ae2:	48 29 d0             	sub    %rdx,%rax
    1ae5:	e9 83 fe ff ff       	jmp    196d <n100_private_lz4_decompress_safe_partial+0x26d>
    1aea:	0f b6 07             	movzbl (%rdi),%eax
    1aed:	f6 d8                	neg    %al
    1aef:	19 c0                	sbb    %eax,%eax
    1af1:	e9 00 00 00 00       	jmp    1af6 <n100_private_lz4_decompress_safe_partial+0x3f6>
    1af6:	4c 89 c7             	mov    %r8,%rdi
    1af9:	e8 00 00 00 00       	call   1afe <n100_private_lz4_decompress_safe_partial+0x3fe>
    1afe:	49 89 e8             	mov    %rbp,%r8
    1b01:	e9 1f fe ff ff       	jmp    1925 <n100_private_lz4_decompress_safe_partial+0x225>
    1b06:	4d 89 d0             	mov    %r10,%r8
    1b09:	e9 17 fe ff ff       	jmp    1925 <n100_private_lz4_decompress_safe_partial+0x225>
    1b0e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b15:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
    1b1a:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    1b1f:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    1b24:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    1b29:	e8 00 00 00 00       	call   1b2e <n100_private_lz4_decompress_safe_partial+0x42e>
    1b2e:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    1b33:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    1b38:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    1b3d:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    1b42:	eb 96                	jmp    1ada <n100_private_lz4_decompress_safe_partial+0x3da>
    1b44:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1b4b:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
    1b50:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    1b55:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    1b5a:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    1b5f:	e8 00 00 00 00       	call   1b64 <n100_private_lz4_decompress_safe_partial+0x464>
    1b64:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    1b69:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    1b6e:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    1b73:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    1b78:	e9 48 ff ff ff       	jmp    1ac5 <n100_private_lz4_decompress_safe_partial+0x3c5>
    1b7d:	0f 1f 00             	nopl   (%rax)
    1b80:	90                   	nop
    1b81:	90                   	nop
    1b82:	90                   	nop
    1b83:	90                   	nop
    1b84:	90                   	nop
    1b85:	90                   	nop
    1b86:	90                   	nop
    1b87:	90                   	nop
    1b88:	90                   	nop
    1b89:	90                   	nop
    1b8a:	90                   	nop
    1b8b:	90                   	nop
    1b8c:	90                   	nop
    1b8d:	90                   	nop
    1b8e:	90                   	nop
    1b8f:	90                   	nop

0000000000001b90 <n100_private_lz4_decompress_fast>:
    1b90:	f3 0f 1e fa          	endbr64
    1b94:	e8 00 00 00 00       	call   1b99 <n100_private_lz4_decompress_fast+0x9>
    1b99:	85 d2                	test   %edx,%edx
    1b9b:	0f 84 f5 01 00 00    	je     1d96 <n100_private_lz4_decompress_fast+0x206>
    1ba1:	48 83 ec 58          	sub    $0x58,%rsp
    1ba5:	48 63 d2             	movslq %edx,%rdx
    1ba8:	48 89 f1             	mov    %rsi,%rcx
    1bab:	49 89 f8             	mov    %rdi,%r8
    1bae:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    1bb3:	4c 8d 0c 16          	lea    (%rsi,%rdx,1),%r9
    1bb7:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
    1bbc:	4d 8d 59 e6          	lea    -0x1a(%r9),%r11
    1bc0:	4d 8d 51 f8          	lea    -0x8(%r9),%r10
    1bc4:	4c 89 64 24 48       	mov    %r12,0x48(%rsp)
    1bc9:	49 89 fc             	mov    %rdi,%r12
    1bcc:	41 0f b6 00          	movzbl (%r8),%eax
    1bd0:	49 8d 68 01          	lea    0x1(%r8),%rbp
    1bd4:	89 c7                	mov    %eax,%edi
    1bd6:	c1 e8 04             	shr    $0x4,%eax
    1bd9:	89 c3                	mov    %eax,%ebx
    1bdb:	83 f8 08             	cmp    $0x8,%eax
    1bde:	77 5c                	ja     1c3c <n100_private_lz4_decompress_fast+0xac>
    1be0:	49 39 cb             	cmp    %rcx,%r11
    1be3:	72 5c                	jb     1c41 <n100_private_lz4_decompress_fast+0xb1>
    1be5:	49 8b 40 01          	mov    0x1(%r8),%rax
    1be9:	4c 8d 44 1d 00       	lea    0x0(%rbp,%rbx,1),%r8
    1bee:	48 89 fe             	mov    %rdi,%rsi
    1bf1:	48 8d 14 19          	lea    (%rcx,%rbx,1),%rdx
    1bf5:	f7 d7                	not    %edi
    1bf7:	83 e6 0f             	and    $0xf,%esi
    1bfa:	49 83 c0 02          	add    $0x2,%r8
    1bfe:	48 89 01             	mov    %rax,(%rcx)
    1c01:	41 0f b7 68 fe       	movzwl -0x2(%r8),%ebp
    1c06:	48 29 eb             	sub    %rbp,%rbx
    1c09:	48 01 cb             	add    %rcx,%rbx
    1c0c:	83 e7 0f             	and    $0xf,%edi
    1c0f:	0f 84 fd 00 00 00    	je     1d12 <n100_private_lz4_decompress_fast+0x182>
    1c15:	48 83 fd 07          	cmp    $0x7,%rbp
    1c19:	0f 86 f3 00 00 00    	jbe    1d12 <n100_private_lz4_decompress_fast+0x182>
    1c1f:	48 8b 03             	mov    (%rbx),%rax
    1c22:	48 8d 4c 32 04       	lea    0x4(%rdx,%rsi,1),%rcx
    1c27:	48 89 02             	mov    %rax,(%rdx)
    1c2a:	48 8b 43 08          	mov    0x8(%rbx),%rax
    1c2e:	48 89 42 08          	mov    %rax,0x8(%rdx)
    1c32:	0f b7 43 10          	movzwl 0x10(%rbx),%eax
    1c36:	66 89 42 10          	mov    %ax,0x10(%rdx)
    1c3a:	eb 90                	jmp    1bcc <n100_private_lz4_decompress_fast+0x3c>
    1c3c:	83 f8 0f             	cmp    $0xf,%eax
    1c3f:	74 40                	je     1c81 <n100_private_lz4_decompress_fast+0xf1>
    1c41:	48 8d 14 19          	lea    (%rcx,%rbx,1),%rdx
    1c45:	49 39 d2             	cmp    %rdx,%r10
    1c48:	73 5f                	jae    1ca9 <n100_private_lz4_decompress_fast+0x119>
    1c4a:	49 39 d1             	cmp    %rdx,%r9
    1c4d:	0f 85 3a 02 00 00    	jne    1e8d <n100_private_lz4_decompress_fast+0x2fd>
    1c53:	48 89 da             	mov    %rbx,%rdx
    1c56:	48 89 ee             	mov    %rbp,%rsi
    1c59:	48 89 cf             	mov    %rcx,%rdi
    1c5c:	e8 00 00 00 00       	call   1c61 <n100_private_lz4_decompress_fast+0xd1>
    1c61:	48 8d 44 1d 00       	lea    0x0(%rbp,%rbx,1),%rax
    1c66:	44 29 e0             	sub    %r12d,%eax
    1c69:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
    1c6e:	48 8b 6c 24 40       	mov    0x40(%rsp),%rbp
    1c73:	4c 8b 64 24 48       	mov    0x48(%rsp),%r12
    1c78:	48 83 c4 58          	add    $0x58,%rsp
    1c7c:	e9 00 00 00 00       	jmp    1c81 <n100_private_lz4_decompress_fast+0xf1>
    1c81:	bb 0f 00 00 00       	mov    $0xf,%ebx
    1c86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    1c8d:	00 00 00 
    1c90:	0f b6 55 00          	movzbl 0x0(%rbp),%edx
    1c94:	48 83 c5 01          	add    $0x1,%rbp
    1c98:	48 01 d3             	add    %rdx,%rbx
    1c9b:	80 fa ff             	cmp    $0xff,%dl
    1c9e:	74 f0                	je     1c90 <n100_private_lz4_decompress_fast+0x100>
    1ca0:	48 8d 14 19          	lea    (%rcx,%rbx,1),%rdx
    1ca4:	49 39 d2             	cmp    %rdx,%r10
    1ca7:	72 a1                	jb     1c4a <n100_private_lz4_decompress_fast+0xba>
    1ca9:	4c 89 6c 24 50       	mov    %r13,0x50(%rsp)
    1cae:	48 89 e8             	mov    %rbp,%rax
    1cb1:	0f 1f 40 00          	nopl   0x0(%rax)
    1cb5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1cbc:	00 00 00 00 
    1cc0:	48 8b 30             	mov    (%rax),%rsi
    1cc3:	48 83 c1 08          	add    $0x8,%rcx
    1cc7:	48 83 c0 08          	add    $0x8,%rax
    1ccb:	48 89 71 f8          	mov    %rsi,-0x8(%rcx)
    1ccf:	48 39 d1             	cmp    %rdx,%rcx
    1cd2:	72 ec                	jb     1cc0 <n100_private_lz4_decompress_fast+0x130>
    1cd4:	4c 8d 44 1d 00       	lea    0x0(%rbp,%rbx,1),%r8
    1cd9:	48 89 fe             	mov    %rdi,%rsi
    1cdc:	48 89 d3             	mov    %rdx,%rbx
    1cdf:	41 0f b7 28          	movzwl (%r8),%ebp
    1ce3:	83 e6 0f             	and    $0xf,%esi
    1ce6:	49 83 c0 02          	add    $0x2,%r8
    1cea:	89 2a                	mov    %ebp,(%rdx)
    1cec:	48 29 eb             	sub    %rbp,%rbx
    1cef:	48 83 fe 0f          	cmp    $0xf,%rsi
    1cf3:	75 2a                	jne    1d1f <n100_private_lz4_decompress_fast+0x18f>
    1cf5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1cfc:	00 00 00 00 
    1d00:	41 0f b6 08          	movzbl (%r8),%ecx
    1d04:	49 83 c0 01          	add    $0x1,%r8
    1d08:	48 01 ce             	add    %rcx,%rsi
    1d0b:	80 f9 ff             	cmp    $0xff,%cl
    1d0e:	74 f0                	je     1d00 <n100_private_lz4_decompress_fast+0x170>
    1d10:	eb 0d                	jmp    1d1f <n100_private_lz4_decompress_fast+0x18f>
    1d12:	4c 89 6c 24 50       	mov    %r13,0x50(%rsp)
    1d17:	89 2a                	mov    %ebp,(%rdx)
    1d19:	48 83 fe 0f          	cmp    $0xf,%rsi
    1d1d:	74 e1                	je     1d00 <n100_private_lz4_decompress_fast+0x170>
    1d1f:	4c 8d 6e 04          	lea    0x4(%rsi),%r13
    1d23:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    1d27:	48 83 fd 07          	cmp    $0x7,%rbp
    1d2b:	0f 86 c5 00 00 00    	jbe    1df6 <n100_private_lz4_decompress_fast+0x266>
    1d31:	48 8b 03             	mov    (%rbx),%rax
    1d34:	48 89 02             	mov    %rax,(%rdx)
    1d37:	48 8d 43 08          	lea    0x8(%rbx),%rax
    1d3b:	49 8d 71 f4          	lea    -0xc(%r9),%rsi
    1d3f:	48 39 ce             	cmp    %rcx,%rsi
    1d42:	72 62                	jb     1da6 <n100_private_lz4_decompress_fast+0x216>
    1d44:	48 8b 30             	mov    (%rax),%rsi
    1d47:	48 89 72 08          	mov    %rsi,0x8(%rdx)
    1d4b:	49 83 fd 10          	cmp    $0x10,%r13
    1d4f:	77 0a                	ja     1d5b <n100_private_lz4_decompress_fast+0x1cb>
    1d51:	4c 8b 6c 24 50       	mov    0x50(%rsp),%r13
    1d56:	e9 71 fe ff ff       	jmp    1bcc <n100_private_lz4_decompress_fast+0x3c>
    1d5b:	48 83 c0 08          	add    $0x8,%rax
    1d5f:	48 83 c2 10          	add    $0x10,%rdx
    1d63:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1d6a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1d71:	00 00 00 00 
    1d75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1d7c:	00 00 00 00 
    1d80:	48 8b 30             	mov    (%rax),%rsi
    1d83:	48 83 c2 08          	add    $0x8,%rdx
    1d87:	48 83 c0 08          	add    $0x8,%rax
    1d8b:	48 89 72 f8          	mov    %rsi,-0x8(%rdx)
    1d8f:	48 39 ca             	cmp    %rcx,%rdx
    1d92:	72 ec                	jb     1d80 <n100_private_lz4_decompress_fast+0x1f0>
    1d94:	eb bb                	jmp    1d51 <n100_private_lz4_decompress_fast+0x1c1>
    1d96:	80 3f 01             	cmpb   $0x1,(%rdi)
    1d99:	19 c0                	sbb    %eax,%eax
    1d9b:	83 e0 02             	and    $0x2,%eax
    1d9e:	83 e8 01             	sub    $0x1,%eax
    1da1:	e9 00 00 00 00       	jmp    1da6 <n100_private_lz4_decompress_fast+0x216>
    1da6:	49 8d 71 fb          	lea    -0x5(%r9),%rsi
    1daa:	48 39 ce             	cmp    %rcx,%rsi
    1dad:	0f 82 d2 00 00 00    	jb     1e85 <n100_private_lz4_decompress_fast+0x2f5>
    1db3:	48 83 c2 08          	add    $0x8,%rdx
    1db7:	49 8d 59 f9          	lea    -0x7(%r9),%rbx
    1dbb:	48 39 da             	cmp    %rbx,%rdx
    1dbe:	72 7f                	jb     1e3f <n100_private_lz4_decompress_fast+0x2af>
    1dc0:	48 89 cb             	mov    %rcx,%rbx
    1dc3:	31 f6                	xor    %esi,%esi
    1dc5:	48 29 d3             	sub    %rdx,%rbx
    1dc8:	48 39 ca             	cmp    %rcx,%rdx
    1dcb:	73 84                	jae    1d51 <n100_private_lz4_decompress_fast+0x1c1>
    1dcd:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    1dd4:	00 
    1dd5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1ddc:	00 00 00 00 
    1de0:	0f b6 3c 30          	movzbl (%rax,%rsi,1),%edi
    1de4:	40 88 3c 32          	mov    %dil,(%rdx,%rsi,1)
    1de8:	48 83 c6 01          	add    $0x1,%rsi
    1dec:	48 39 de             	cmp    %rbx,%rsi
    1def:	75 ef                	jne    1de0 <n100_private_lz4_decompress_fast+0x250>
    1df1:	e9 5b ff ff ff       	jmp    1d51 <n100_private_lz4_decompress_fast+0x1c1>
    1df6:	0f b6 03             	movzbl (%rbx),%eax
    1df9:	88 02                	mov    %al,(%rdx)
    1dfb:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
    1dff:	88 42 01             	mov    %al,0x1(%rdx)
    1e02:	0f b6 43 02          	movzbl 0x2(%rbx),%eax
    1e06:	88 42 02             	mov    %al,0x2(%rdx)
    1e09:	0f b6 43 03          	movzbl 0x3(%rbx),%eax
    1e0d:	88 42 03             	mov    %al,0x3(%rdx)
    1e10:	48 83 fd 08          	cmp    $0x8,%rbp
    1e14:	0f 83 d7 00 00 00    	jae    1ef1 <n100_private_lz4_decompress_fast+0x361>
    1e1a:	8b 04 ad 00 00 00 00 	mov    0x0(,%rbp,4),%eax
    1e21:	48 01 d8             	add    %rbx,%rax
    1e24:	8b 30                	mov    (%rax),%esi
    1e26:	89 72 04             	mov    %esi,0x4(%rdx)
    1e29:	48 83 fd 08          	cmp    $0x8,%rbp
    1e2d:	73 6a                	jae    1e99 <n100_private_lz4_decompress_fast+0x309>
    1e2f:	48 63 34 ad 00 00 00 	movslq 0x0(,%rbp,4),%rsi
    1e36:	00 
    1e37:	48 29 f0             	sub    %rsi,%rax
    1e3a:	e9 fc fe ff ff       	jmp    1d3b <n100_private_lz4_decompress_fast+0x1ab>
    1e3f:	48 89 c7             	mov    %rax,%rdi
    1e42:	48 89 d6             	mov    %rdx,%rsi
    1e45:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1e4a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1e51:	00 00 00 00 
    1e55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    1e5c:	00 00 00 00 
    1e60:	48 8b 2f             	mov    (%rdi),%rbp
    1e63:	48 83 c6 08          	add    $0x8,%rsi
    1e67:	48 83 c7 08          	add    $0x8,%rdi
    1e6b:	48 89 6e f8          	mov    %rbp,-0x8(%rsi)
    1e6f:	48 39 de             	cmp    %rbx,%rsi
    1e72:	72 ec                	jb     1e60 <n100_private_lz4_decompress_fast+0x2d0>
    1e74:	48 89 de             	mov    %rbx,%rsi
    1e77:	48 29 d6             	sub    %rdx,%rsi
    1e7a:	48 89 da             	mov    %rbx,%rdx
    1e7d:	48 01 f0             	add    %rsi,%rax
    1e80:	e9 3b ff ff ff       	jmp    1dc0 <n100_private_lz4_decompress_fast+0x230>
    1e85:	4c 8b 6c 24 50       	mov    0x50(%rsp),%r13
    1e8a:	4c 89 c5             	mov    %r8,%rbp
    1e8d:	4c 29 e5             	sub    %r12,%rbp
    1e90:	89 e8                	mov    %ebp,%eax
    1e92:	f7 d0                	not    %eax
    1e94:	e9 d0 fd ff ff       	jmp    1c69 <n100_private_lz4_decompress_fast+0xd9>
    1e99:	48 89 ee             	mov    %rbp,%rsi
    1e9c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1ea3:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    1ea8:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    1ead:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    1eb2:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1eb7:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
    1ebc:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
    1ec1:	4c 89 0c 24          	mov    %r9,(%rsp)
    1ec5:	e8 00 00 00 00       	call   1eca <n100_private_lz4_decompress_fast+0x33a>
    1eca:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    1ecf:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
    1ed4:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    1ed9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    1ede:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    1ee3:	4c 8b 5c 24 08       	mov    0x8(%rsp),%r11
    1ee8:	4c 8b 0c 24          	mov    (%rsp),%r9
    1eec:	e9 3e ff ff ff       	jmp    1e2f <n100_private_lz4_decompress_fast+0x29f>
    1ef1:	48 89 ee             	mov    %rbp,%rsi
    1ef4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    1efb:	4c 89 54 24 28       	mov    %r10,0x28(%rsp)
    1f00:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    1f05:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
    1f0a:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
    1f0f:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
    1f14:	4c 89 0c 24          	mov    %r9,(%rsp)
    1f18:	e8 00 00 00 00       	call   1f1d <n100_private_lz4_decompress_fast+0x38d>
    1f1d:	4c 8b 54 24 28       	mov    0x28(%rsp),%r10
    1f22:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    1f27:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
    1f2c:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    1f31:	4c 8b 5c 24 08       	mov    0x8(%rsp),%r11
    1f36:	4c 8b 0c 24          	mov    (%rsp),%r9
    1f3a:	e9 db fe ff ff       	jmp    1e1a <n100_private_lz4_decompress_fast+0x28a>
    1f3f:	90                   	nop
    1f40:	90                   	nop
    1f41:	90                   	nop
    1f42:	90                   	nop
    1f43:	90                   	nop
    1f44:	90                   	nop
    1f45:	90                   	nop
    1f46:	90                   	nop
    1f47:	90                   	nop
    1f48:	90                   	nop
    1f49:	90                   	nop
    1f4a:	90                   	nop
    1f4b:	90                   	nop
    1f4c:	90                   	nop
    1f4d:	90                   	nop
    1f4e:	90                   	nop
    1f4f:	90                   	nop

0000000000001f50 <n100_private_lz4_setStreamDecode>:
    1f50:	f3 0f 1e fa          	endbr64
    1f54:	e8 00 00 00 00       	call   1f59 <n100_private_lz4_setStreamDecode+0x9>
    1f59:	48 63 d2             	movslq %edx,%rdx
    1f5c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    1f63:	b8 01 00 00 00       	mov    $0x1,%eax
    1f68:	48 01 d6             	add    %rdx,%rsi
    1f6b:	48 89 57 18          	mov    %rdx,0x18(%rdi)
    1f6f:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    1f73:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    1f7a:	00 
    1f7b:	e9 00 00 00 00       	jmp    1f80 <n100_private_lz4_setStreamDecode+0x30>
    1f80:	90                   	nop
    1f81:	90                   	nop
    1f82:	90                   	nop
    1f83:	90                   	nop
    1f84:	90                   	nop
    1f85:	90                   	nop
    1f86:	90                   	nop
    1f87:	90                   	nop
    1f88:	90                   	nop
    1f89:	90                   	nop
    1f8a:	90                   	nop
    1f8b:	90                   	nop
    1f8c:	90                   	nop
    1f8d:	90                   	nop
    1f8e:	90                   	nop
    1f8f:	90                   	nop

0000000000001f90 <n100_private_lz4_decompress_safe_continue>:
    1f90:	f3 0f 1e fa          	endbr64
    1f94:	e8 00 00 00 00       	call   1f99 <n100_private_lz4_decompress_safe_continue+0x9>
    1f99:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    1fa0:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
    1fa5:	48 89 fb             	mov    %rdi,%rbx
    1fa8:	48 89 f7             	mov    %rsi,%rdi
    1fab:	48 89 6c 24 60       	mov    %rbp,0x60(%rsp)
    1fb0:	4c 8b 4b 18          	mov    0x18(%rbx),%r9
    1fb4:	48 89 d5             	mov    %rdx,%rbp
    1fb7:	89 ca                	mov    %ecx,%edx
    1fb9:	49 63 c8             	movslq %r8d,%rcx
    1fbc:	4d 85 c9             	test   %r9,%r9
    1fbf:	0f 84 bc 01 00 00    	je     2181 <n100_private_lz4_decompress_safe_continue+0x1f1>
    1fc5:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    1fc9:	48 39 ee             	cmp    %rbp,%rsi
    1fcc:	74 3c                	je     200a <n100_private_lz4_decompress_safe_continue+0x7a>
    1fce:	4c 29 ce             	sub    %r9,%rsi
    1fd1:	4c 89 4b 08          	mov    %r9,0x8(%rbx)
    1fd5:	48 89 33             	mov    %rsi,(%rbx)
    1fd8:	49 89 f0             	mov    %rsi,%r8
    1fdb:	48 89 ee             	mov    %rbp,%rsi
    1fde:	e8 bd e8 ff ff       	call   8a0 <n100_private_lz4_decompress_safe_forceExtDict>
    1fe3:	85 c0                	test   %eax,%eax
    1fe5:	7e 0d                	jle    1ff4 <n100_private_lz4_decompress_safe_continue+0x64>
    1fe7:	89 c2                	mov    %eax,%edx
    1fe9:	48 01 d5             	add    %rdx,%rbp
    1fec:	48 89 53 18          	mov    %rdx,0x18(%rbx)
    1ff0:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    1ff4:	48 8b 5c 24 58       	mov    0x58(%rsp),%rbx
    1ff9:	48 8b 6c 24 60       	mov    0x60(%rsp),%rbp
    1ffe:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    2005:	e9 00 00 00 00       	jmp    200a <n100_private_lz4_decompress_safe_continue+0x7a>
    200a:	49 81 f9 fe ff 00 00 	cmp    $0xfffe,%r9
    2011:	0f 87 ab 01 00 00    	ja     21c2 <n100_private_lz4_decompress_safe_continue+0x232>
    2017:	4c 8b 43 08          	mov    0x8(%rbx),%r8
    201b:	4d 85 c0             	test   %r8,%r8
    201e:	0f 84 7f 01 00 00    	je     21a3 <n100_private_lz4_decompress_safe_continue+0x213>
    2024:	85 c9                	test   %ecx,%ecx
    2026:	0f 84 67 03 00 00    	je     2393 <n100_private_lz4_decompress_safe_continue+0x403>
    202c:	85 d2                	test   %edx,%edx
    202e:	0f 84 55 03 00 00    	je     2389 <n100_private_lz4_decompress_safe_continue+0x3f9>
    2034:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    2039:	49 89 ea             	mov    %rbp,%r10
    203c:	49 89 fb             	mov    %rdi,%r11
    203f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
    2044:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    204b:	00 
    204c:	48 8b 03             	mov    (%rbx),%rax
    204f:	4c 8d 7c 0d 00       	lea    0x0(%rbp,%rcx,1),%r15
    2054:	4c 89 04 24          	mov    %r8,(%rsp)
    2058:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    205d:	48 89 e8             	mov    %rbp,%rax
    2060:	4c 29 c8             	sub    %r9,%rax
    2063:	4c 63 ca             	movslq %edx,%r9
    2066:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
    206b:	49 89 c4             	mov    %rax,%r12
    206e:	48 8d 44 0d e0       	lea    -0x20(%rbp,%rcx,1),%rax
    2073:	49 01 f9             	add    %rdi,%r9
    2076:	48 89 fd             	mov    %rdi,%rbp
    2079:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    207e:	4d 8d 69 f0          	lea    -0x10(%r9),%r13
    2082:	41 0f b6 13          	movzbl (%r11),%edx
    2086:	49 8d 73 01          	lea    0x1(%r11),%rsi
    208a:	89 d0                	mov    %edx,%eax
    208c:	c1 ea 04             	shr    $0x4,%edx
    208f:	83 fa 0f             	cmp    $0xf,%edx
    2092:	0f 84 31 01 00 00    	je     21c9 <n100_private_lz4_decompress_safe_continue+0x239>
    2098:	4c 39 ee             	cmp    %r13,%rsi
    209b:	0f 83 45 03 00 00    	jae    23e6 <n100_private_lz4_decompress_safe_continue+0x456>
    20a1:	4c 39 54 24 08       	cmp    %r10,0x8(%rsp)
    20a6:	0f 82 3a 03 00 00    	jb     23e6 <n100_private_lz4_decompress_safe_continue+0x456>
    20ac:	4c 89 74 24 78       	mov    %r14,0x78(%rsp)
    20b1:	4d 8b 43 01          	mov    0x1(%r11),%r8
    20b5:	48 8d 3c 16          	lea    (%rsi,%rdx,1),%rdi
    20b9:	49 8d 0c 12          	lea    (%r10,%rdx,1),%rcx
    20bd:	4c 8d 5f 02          	lea    0x2(%rdi),%r11
    20c1:	4d 89 02             	mov    %r8,(%r10)
    20c4:	48 8b 76 08          	mov    0x8(%rsi),%rsi
    20c8:	49 89 72 08          	mov    %rsi,0x8(%r10)
    20cc:	44 0f b7 07          	movzwl (%rdi),%r8d
    20d0:	48 89 c6             	mov    %rax,%rsi
    20d3:	f7 d0                	not    %eax
    20d5:	83 e6 0f             	and    $0xf,%esi
    20d8:	4c 29 c2             	sub    %r8,%rdx
    20db:	4d 89 c6             	mov    %r8,%r14
    20de:	4c 01 d2             	add    %r10,%rdx
    20e1:	a8 0f                	test   $0xf,%al
    20e3:	0f 84 96 02 00 00    	je     237f <n100_private_lz4_decompress_safe_continue+0x3ef>
    20e9:	49 83 f8 07          	cmp    $0x7,%r8
    20ed:	0f 86 8c 02 00 00    	jbe    237f <n100_private_lz4_decompress_safe_continue+0x3ef>
    20f3:	4c 39 e2             	cmp    %r12,%rdx
    20f6:	0f 83 3d 02 00 00    	jae    2339 <n100_private_lz4_decompress_safe_continue+0x3a9>
    20fc:	48 8b 04 24          	mov    (%rsp),%rax
    2100:	48 3d ff ff 00 00    	cmp    $0xffff,%rax
    2106:	77 0c                	ja     2114 <n100_private_lz4_decompress_safe_continue+0x184>
    2108:	48 01 d0             	add    %rdx,%rax
    210b:	4c 39 e0             	cmp    %r12,%rax
    210e:	0f 82 42 04 00 00    	jb     2556 <n100_private_lz4_decompress_safe_continue+0x5c6>
    2114:	41 0f b7 fe          	movzwl %r14w,%edi
    2118:	48 8d 46 04          	lea    0x4(%rsi),%rax
    211c:	89 39                	mov    %edi,(%rcx)
    211e:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    2123:	4c 8d 14 01          	lea    (%rcx,%rax,1),%r10
    2127:	49 8d 77 fb          	lea    -0x5(%r15),%rsi
    212b:	4c 39 d6             	cmp    %r10,%rsi
    212e:	0f 82 a7 02 00 00    	jb     23db <n100_private_lz4_decompress_safe_continue+0x44b>
    2134:	48 8b 3c 24          	mov    (%rsp),%rdi
    2138:	4d 89 e0             	mov    %r12,%r8
    213b:	49 29 d0             	sub    %rdx,%r8
    213e:	4c 29 e2             	sub    %r12,%rdx
    2141:	48 8d 34 3a          	lea    (%rdx,%rdi,1),%rsi
    2145:	48 03 74 24 18       	add    0x18(%rsp),%rsi
    214a:	49 39 c0             	cmp    %rax,%r8
    214d:	0f 82 a0 02 00 00    	jb     23f3 <n100_private_lz4_decompress_safe_continue+0x463>
    2153:	48 89 cf             	mov    %rcx,%rdi
    2156:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    215b:	48 89 c2             	mov    %rax,%rdx
    215e:	4c 89 5c 24 28       	mov    %r11,0x28(%rsp)
    2163:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    2168:	e8 00 00 00 00       	call   216d <n100_private_lz4_decompress_safe_continue+0x1dd>
    216d:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
    2172:	4c 8b 5c 24 28       	mov    0x28(%rsp),%r11
    2177:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    217c:	e9 01 ff ff ff       	jmp    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    2181:	48 89 ee             	mov    %rbp,%rsi
    2184:	e8 00 00 00 00       	call   2189 <n100_private_lz4_decompress_safe_continue+0x1f9>
    2189:	85 c0                	test   %eax,%eax
    218b:	0f 8e 63 fe ff ff    	jle    1ff4 <n100_private_lz4_decompress_safe_continue+0x64>
    2191:	89 c2                	mov    %eax,%edx
    2193:	48 89 53 18          	mov    %rdx,0x18(%rbx)
    2197:	48 01 ea             	add    %rbp,%rdx
    219a:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    219e:	e9 51 fe ff ff       	jmp    1ff4 <n100_private_lz4_decompress_safe_continue+0x64>
    21a3:	4d 89 c8             	mov    %r9,%r8
    21a6:	e8 b5 e2 ff ff       	call   460 <n100_private_lz4_decompress_safe_withSmallPrefix>
    21ab:	85 c0                	test   %eax,%eax
    21ad:	0f 8e 41 fe ff ff    	jle    1ff4 <n100_private_lz4_decompress_safe_continue+0x64>
    21b3:	89 c2                	mov    %eax,%edx
    21b5:	48 01 53 18          	add    %rdx,0x18(%rbx)
    21b9:	48 01 53 10          	add    %rdx,0x10(%rbx)
    21bd:	e9 32 fe ff ff       	jmp    1ff4 <n100_private_lz4_decompress_safe_continue+0x64>
    21c2:	e8 49 de ff ff       	call   10 <n100_private_lz4_decompress_safe_withPrefix64k>
    21c7:	eb e2                	jmp    21ab <n100_private_lz4_decompress_safe_continue+0x21b>
    21c9:	4d 8d 59 f1          	lea    -0xf(%r9),%r11
    21cd:	4c 39 de             	cmp    %r11,%rsi
    21d0:	0f 83 88 01 00 00    	jae    235e <n100_private_lz4_decompress_safe_continue+0x3ce>
    21d6:	ba 0f 00 00 00       	mov    $0xf,%edx
    21db:	eb 09                	jmp    21e6 <n100_private_lz4_decompress_safe_continue+0x256>
    21dd:	0f 1f 00             	nopl   (%rax)
    21e0:	40 80 ff ff          	cmp    $0xff,%dil
    21e4:	75 0f                	jne    21f5 <n100_private_lz4_decompress_safe_continue+0x265>
    21e6:	0f b6 3e             	movzbl (%rsi),%edi
    21e9:	48 83 c6 01          	add    $0x1,%rsi
    21ed:	48 01 fa             	add    %rdi,%rdx
    21f0:	49 39 f3             	cmp    %rsi,%r11
    21f3:	75 eb                	jne    21e0 <n100_private_lz4_decompress_safe_continue+0x250>
    21f5:	4c 89 d1             	mov    %r10,%rcx
    21f8:	4a 8d 3c 12          	lea    (%rdx,%r10,1),%rdi
    21fc:	48 01 d1             	add    %rdx,%rcx
    21ff:	0f 82 59 01 00 00    	jb     235e <n100_private_lz4_decompress_safe_continue+0x3ce>
    2205:	48 89 f1             	mov    %rsi,%rcx
    2208:	4c 8d 1c 32          	lea    (%rdx,%rsi,1),%r11
    220c:	48 01 d1             	add    %rdx,%rcx
    220f:	0f 82 49 01 00 00    	jb     235e <n100_private_lz4_decompress_safe_continue+0x3ce>
    2215:	4d 8d 47 f4          	lea    -0xc(%r15),%r8
    2219:	48 89 f9             	mov    %rdi,%rcx
    221c:	49 39 f8             	cmp    %rdi,%r8
    221f:	73 45                	jae    2266 <n100_private_lz4_decompress_safe_continue+0x2d6>
    2221:	48 89 f9             	mov    %rdi,%rcx
    2224:	48 89 ef             	mov    %rbp,%rdi
    2227:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    222c:	4d 39 d9             	cmp    %r11,%r9
    222f:	0f 85 2c 01 00 00    	jne    2361 <n100_private_lz4_decompress_safe_continue+0x3d1>
    2235:	49 39 cf             	cmp    %rcx,%r15
    2238:	0f 82 23 01 00 00    	jb     2361 <n100_private_lz4_decompress_safe_continue+0x3d1>
    223e:	4c 89 d7             	mov    %r10,%rdi
    2241:	48 89 0c 24          	mov    %rcx,(%rsp)
    2245:	e8 00 00 00 00       	call   224a <n100_private_lz4_decompress_safe_continue+0x2ba>
    224a:	8b 04 24             	mov    (%rsp),%eax
    224d:	4c 8b 64 24 68       	mov    0x68(%rsp),%r12
    2252:	4c 8b 6c 24 70       	mov    0x70(%rsp),%r13
    2257:	4c 8b bc 24 80 00 00 	mov    0x80(%rsp),%r15
    225e:	00 
    225f:	29 e8                	sub    %ebp,%eax
    2261:	e9 45 ff ff ff       	jmp    21ab <n100_private_lz4_decompress_safe_continue+0x21b>
    2266:	4d 8d 41 f8          	lea    -0x8(%r9),%r8
    226a:	4d 39 d8             	cmp    %r11,%r8
    226d:	72 b2                	jb     2221 <n100_private_lz4_decompress_safe_continue+0x291>
    226f:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    2275:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    227c:	00 00 00 00 
    2280:	48 8b 16             	mov    (%rsi),%rdx
    2283:	49 83 c2 08          	add    $0x8,%r10
    2287:	48 83 c6 08          	add    $0x8,%rsi
    228b:	49 89 52 f8          	mov    %rdx,-0x8(%r10)
    228f:	49 39 fa             	cmp    %rdi,%r10
    2292:	72 ec                	jb     2280 <n100_private_lz4_decompress_safe_continue+0x2f0>
    2294:	45 0f b7 03          	movzwl (%r11),%r8d
    2298:	48 89 c6             	mov    %rax,%rsi
    229b:	49 83 c3 02          	add    $0x2,%r11
    229f:	83 e6 0f             	and    $0xf,%esi
    22a2:	4c 29 c7             	sub    %r8,%rdi
    22a5:	48 89 fa             	mov    %rdi,%rdx
    22a8:	48 8b 04 24          	mov    (%rsp),%rax
    22ac:	48 3d ff ff 00 00    	cmp    $0xffff,%rax
    22b2:	77 0c                	ja     22c0 <n100_private_lz4_decompress_safe_continue+0x330>
    22b4:	48 01 d0             	add    %rdx,%rax
    22b7:	4c 39 e0             	cmp    %r12,%rax
    22ba:	0f 82 1b 01 00 00    	jb     23db <n100_private_lz4_decompress_safe_continue+0x44b>
    22c0:	44 89 01             	mov    %r8d,(%rcx)
    22c3:	48 83 fe 0f          	cmp    $0xf,%rsi
    22c7:	0f 84 d7 00 00 00    	je     23a4 <n100_private_lz4_decompress_safe_continue+0x414>
    22cd:	48 8d 46 04          	lea    0x4(%rsi),%rax
    22d1:	4c 39 e2             	cmp    %r12,%rdx
    22d4:	0f 82 49 fe ff ff    	jb     2123 <n100_private_lz4_decompress_safe_continue+0x193>
    22da:	4c 8d 14 01          	lea    (%rcx,%rax,1),%r10
    22de:	49 83 f8 07          	cmp    $0x7,%r8
    22e2:	0f 86 d3 01 00 00    	jbe    24bb <n100_private_lz4_decompress_safe_continue+0x52b>
    22e8:	48 8b 32             	mov    (%rdx),%rsi
    22eb:	48 83 c2 08          	add    $0x8,%rdx
    22ef:	48 89 31             	mov    %rsi,(%rcx)
    22f2:	49 8d 77 f4          	lea    -0xc(%r15),%rsi
    22f6:	4c 39 d6             	cmp    %r10,%rsi
    22f9:	0f 82 0e 02 00 00    	jb     250d <n100_private_lz4_decompress_safe_continue+0x57d>
    22ff:	48 8b 32             	mov    (%rdx),%rsi
    2302:	48 89 71 08          	mov    %rsi,0x8(%rcx)
    2306:	48 83 f8 10          	cmp    $0x10,%rax
    230a:	0f 86 72 fd ff ff    	jbe    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    2310:	48 8d 42 08          	lea    0x8(%rdx),%rax
    2314:	48 83 c1 10          	add    $0x10,%rcx
    2318:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    231f:	00 
    2320:	48 8b 10             	mov    (%rax),%rdx
    2323:	48 83 c1 08          	add    $0x8,%rcx
    2327:	48 83 c0 08          	add    $0x8,%rax
    232b:	48 89 51 f8          	mov    %rdx,-0x8(%rcx)
    232f:	4c 39 d1             	cmp    %r10,%rcx
    2332:	72 ec                	jb     2320 <n100_private_lz4_decompress_safe_continue+0x390>
    2334:	e9 49 fd ff ff       	jmp    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    2339:	48 8b 02             	mov    (%rdx),%rax
    233c:	4c 8d 54 31 04       	lea    0x4(%rcx,%rsi,1),%r10
    2341:	48 89 01             	mov    %rax,(%rcx)
    2344:	48 8b 42 08          	mov    0x8(%rdx),%rax
    2348:	48 89 41 08          	mov    %rax,0x8(%rcx)
    234c:	0f b7 42 10          	movzwl 0x10(%rdx),%eax
    2350:	66 89 41 10          	mov    %ax,0x10(%rcx)
    2354:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    2359:	e9 24 fd ff ff       	jmp    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    235e:	48 89 ef             	mov    %rbp,%rdi
    2361:	48 29 fe             	sub    %rdi,%rsi
    2364:	4c 8b 64 24 68       	mov    0x68(%rsp),%r12
    2369:	4c 8b 6c 24 70       	mov    0x70(%rsp),%r13
    236e:	89 f0                	mov    %esi,%eax
    2370:	4c 8b bc 24 80 00 00 	mov    0x80(%rsp),%r15
    2377:	00 
    2378:	f7 d0                	not    %eax
    237a:	e9 2c fe ff ff       	jmp    21ab <n100_private_lz4_decompress_safe_continue+0x21b>
    237f:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    2384:	e9 1f ff ff ff       	jmp    22a8 <n100_private_lz4_decompress_safe_continue+0x318>
    2389:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    238e:	e9 61 fc ff ff       	jmp    1ff4 <n100_private_lz4_decompress_safe_continue+0x64>
    2393:	83 fa 01             	cmp    $0x1,%edx
    2396:	75 f1                	jne    2389 <n100_private_lz4_decompress_safe_continue+0x3f9>
    2398:	0f b6 07             	movzbl (%rdi),%eax
    239b:	f6 d8                	neg    %al
    239d:	19 c0                	sbb    %eax,%eax
    239f:	e9 50 fc ff ff       	jmp    1ff4 <n100_private_lz4_decompress_safe_continue+0x64>
    23a4:	4d 8d 51 fb          	lea    -0x5(%r9),%r10
    23a8:	eb 28                	jmp    23d2 <n100_private_lz4_decompress_safe_continue+0x442>
    23aa:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    23b1:	00 00 00 00 
    23b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    23bc:	00 00 00 00 
    23c0:	41 0f b6 7b ff       	movzbl -0x1(%r11),%edi
    23c5:	48 01 fe             	add    %rdi,%rsi
    23c8:	40 80 ff ff          	cmp    $0xff,%dil
    23cc:	0f 85 a4 00 00 00    	jne    2476 <n100_private_lz4_decompress_safe_continue+0x4e6>
    23d2:	49 83 c3 01          	add    $0x1,%r11
    23d6:	4d 39 da             	cmp    %r11,%r10
    23d9:	73 e5                	jae    23c0 <n100_private_lz4_decompress_safe_continue+0x430>
    23db:	48 89 ef             	mov    %rbp,%rdi
    23de:	4c 89 de             	mov    %r11,%rsi
    23e1:	e9 7b ff ff ff       	jmp    2361 <n100_private_lz4_decompress_safe_continue+0x3d1>
    23e6:	49 8d 3c 12          	lea    (%r10,%rdx,1),%rdi
    23ea:	4c 8d 1c 16          	lea    (%rsi,%rdx,1),%r11
    23ee:	e9 22 fe ff ff       	jmp    2215 <n100_private_lz4_decompress_safe_continue+0x285>
    23f3:	4c 29 c0             	sub    %r8,%rax
    23f6:	4c 89 c2             	mov    %r8,%rdx
    23f9:	48 89 cf             	mov    %rcx,%rdi
    23fc:	4c 89 74 24 78       	mov    %r14,0x78(%rsp)
    2401:	4c 89 54 24 38       	mov    %r10,0x38(%rsp)
    2406:	49 89 c6             	mov    %rax,%r14
    2409:	4c 89 5c 24 30       	mov    %r11,0x30(%rsp)
    240e:	4c 89 4c 24 28       	mov    %r9,0x28(%rsp)
    2413:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    2418:	e8 00 00 00 00       	call   241d <n100_private_lz4_decompress_safe_continue+0x48d>
    241d:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    2422:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
    2427:	4c 89 f6             	mov    %r14,%rsi
    242a:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
    242f:	4c 8b 54 24 38       	mov    0x38(%rsp),%r10
    2434:	4a 8d 3c 00          	lea    (%rax,%r8,1),%rdi
    2438:	48 89 f8             	mov    %rdi,%rax
    243b:	4c 29 e0             	sub    %r12,%rax
    243e:	4c 39 f0             	cmp    %r14,%rax
    2441:	72 44                	jb     2487 <n100_private_lz4_decompress_safe_continue+0x4f7>
    2443:	4c 89 f2             	mov    %r14,%rdx
    2446:	4c 89 e6             	mov    %r12,%rsi
    2449:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
    244e:	4c 89 5c 24 28       	mov    %r11,0x28(%rsp)
    2453:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
    2458:	e8 00 00 00 00       	call   245d <n100_private_lz4_decompress_safe_continue+0x4cd>
    245d:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
    2462:	4c 8b 5c 24 28       	mov    0x28(%rsp),%r11
    2467:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
    246c:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    2471:	e9 0c fc ff ff       	jmp    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    2476:	48 89 c8             	mov    %rcx,%rax
    2479:	48 01 f0             	add    %rsi,%rax
    247c:	0f 83 4b fe ff ff    	jae    22cd <n100_private_lz4_decompress_safe_continue+0x33d>
    2482:	e9 54 ff ff ff       	jmp    23db <n100_private_lz4_decompress_safe_continue+0x44b>
    2487:	4c 39 d7             	cmp    %r10,%rdi
    248a:	0f 83 fe 00 00 00    	jae    258e <n100_private_lz4_decompress_safe_continue+0x5fe>
    2490:	31 c0                	xor    %eax,%eax
    2492:	0f 1f 00             	nopl   (%rax)
    2495:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    249c:	00 00 00 00 
    24a0:	41 0f b6 14 04       	movzbl (%r12,%rax,1),%edx
    24a5:	88 14 07             	mov    %dl,(%rdi,%rax,1)
    24a8:	48 83 c0 01          	add    $0x1,%rax
    24ac:	48 39 c6             	cmp    %rax,%rsi
    24af:	75 ef                	jne    24a0 <n100_private_lz4_decompress_safe_continue+0x510>
    24b1:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    24b6:	e9 c7 fb ff ff       	jmp    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    24bb:	0f b6 32             	movzbl (%rdx),%esi
    24be:	40 88 31             	mov    %sil,(%rcx)
    24c1:	0f b6 72 01          	movzbl 0x1(%rdx),%esi
    24c5:	40 88 71 01          	mov    %sil,0x1(%rcx)
    24c9:	0f b6 72 02          	movzbl 0x2(%rdx),%esi
    24cd:	40 88 71 02          	mov    %sil,0x2(%rcx)
    24d1:	0f b6 72 03          	movzbl 0x3(%rdx),%esi
    24d5:	40 88 71 03          	mov    %sil,0x3(%rcx)
    24d9:	49 83 f8 08          	cmp    $0x8,%r8
    24dd:	0f 83 0d 01 00 00    	jae    25f0 <n100_private_lz4_decompress_safe_continue+0x660>
    24e3:	42 8b 34 85 00 00 00 	mov    0x0(,%r8,4),%esi
    24ea:	00 
    24eb:	48 01 f2             	add    %rsi,%rdx
    24ee:	8b 32                	mov    (%rdx),%esi
    24f0:	89 71 04             	mov    %esi,0x4(%rcx)
    24f3:	49 83 f8 08          	cmp    $0x8,%r8
    24f7:	0f 83 99 00 00 00    	jae    2596 <n100_private_lz4_decompress_safe_continue+0x606>
    24fd:	4a 63 34 85 00 00 00 	movslq 0x0(,%r8,4),%rsi
    2504:	00 
    2505:	48 29 f2             	sub    %rsi,%rdx
    2508:	e9 e5 fd ff ff       	jmp    22f2 <n100_private_lz4_decompress_safe_continue+0x362>
    250d:	49 8d 47 fb          	lea    -0x5(%r15),%rax
    2511:	4c 39 d0             	cmp    %r10,%rax
    2514:	0f 82 c1 fe ff ff    	jb     23db <n100_private_lz4_decompress_safe_continue+0x44b>
    251a:	48 83 c1 08          	add    $0x8,%rcx
    251e:	49 8d 7f f9          	lea    -0x7(%r15),%rdi
    2522:	48 39 f9             	cmp    %rdi,%rcx
    2525:	72 3f                	jb     2566 <n100_private_lz4_decompress_safe_continue+0x5d6>
    2527:	4c 89 d7             	mov    %r10,%rdi
    252a:	31 c0                	xor    %eax,%eax
    252c:	48 29 cf             	sub    %rcx,%rdi
    252f:	4c 39 d1             	cmp    %r10,%rcx
    2532:	0f 83 4a fb ff ff    	jae    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    2538:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    253f:	00 
    2540:	0f b6 34 02          	movzbl (%rdx,%rax,1),%esi
    2544:	40 88 34 01          	mov    %sil,(%rcx,%rax,1)
    2548:	48 83 c0 01          	add    $0x1,%rax
    254c:	48 39 f8             	cmp    %rdi,%rax
    254f:	75 ef                	jne    2540 <n100_private_lz4_decompress_safe_continue+0x5b0>
    2551:	e9 2c fb ff ff       	jmp    2082 <n100_private_lz4_decompress_safe_continue+0xf2>
    2556:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    255b:	48 89 ef             	mov    %rbp,%rdi
    255e:	4c 89 de             	mov    %r11,%rsi
    2561:	e9 fb fd ff ff       	jmp    2361 <n100_private_lz4_decompress_safe_continue+0x3d1>
    2566:	48 89 d6             	mov    %rdx,%rsi
    2569:	48 89 c8             	mov    %rcx,%rax
    256c:	4c 8b 06             	mov    (%rsi),%r8
    256f:	48 83 c0 08          	add    $0x8,%rax
    2573:	48 83 c6 08          	add    $0x8,%rsi
    2577:	4c 89 40 f8          	mov    %r8,-0x8(%rax)
    257b:	48 39 f8             	cmp    %rdi,%rax
    257e:	72 ec                	jb     256c <n100_private_lz4_decompress_safe_continue+0x5dc>
    2580:	48 89 f8             	mov    %rdi,%rax
    2583:	48 29 c8             	sub    %rcx,%rax
    2586:	48 89 f9             	mov    %rdi,%rcx
    2589:	48 01 c2             	add    %rax,%rdx
    258c:	eb 99                	jmp    2527 <n100_private_lz4_decompress_safe_continue+0x597>
    258e:	49 89 fa             	mov    %rdi,%r10
    2591:	e9 1b ff ff ff       	jmp    24b1 <n100_private_lz4_decompress_safe_continue+0x521>
    2596:	4c 89 c6             	mov    %r8,%rsi
    2599:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    25a0:	4c 89 54 24 50       	mov    %r10,0x50(%rsp)
    25a5:	4c 89 5c 24 48       	mov    %r11,0x48(%rsp)
    25aa:	4c 89 4c 24 40       	mov    %r9,0x40(%rsp)
    25af:	48 89 54 24 38       	mov    %rdx,0x38(%rsp)
    25b4:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    25b9:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    25be:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    25c3:	e8 00 00 00 00       	call   25c8 <n100_private_lz4_decompress_safe_continue+0x638>
    25c8:	4c 8b 54 24 50       	mov    0x50(%rsp),%r10
    25cd:	4c 8b 5c 24 48       	mov    0x48(%rsp),%r11
    25d2:	4c 8b 4c 24 40       	mov    0x40(%rsp),%r9
    25d7:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
    25dc:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    25e1:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
    25e6:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    25eb:	e9 0d ff ff ff       	jmp    24fd <n100_private_lz4_decompress_safe_continue+0x56d>
    25f0:	4c 89 c6             	mov    %r8,%rsi
    25f3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    25fa:	4c 89 54 24 50       	mov    %r10,0x50(%rsp)
    25ff:	4c 89 5c 24 48       	mov    %r11,0x48(%rsp)
    2604:	4c 89 4c 24 40       	mov    %r9,0x40(%rsp)
    2609:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    260e:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
    2613:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
    2618:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
    261d:	e8 00 00 00 00       	call   2622 <n100_private_lz4_decompress_safe_continue+0x692>
    2622:	4c 8b 54 24 50       	mov    0x50(%rsp),%r10
    2627:	4c 8b 5c 24 48       	mov    0x48(%rsp),%r11
    262c:	4c 8b 4c 24 40       	mov    0x40(%rsp),%r9
    2631:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    2636:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    263b:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
    2640:	4c 8b 44 24 20       	mov    0x20(%rsp),%r8
    2645:	e9 99 fe ff ff       	jmp    24e3 <n100_private_lz4_decompress_safe_continue+0x553>
    264a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    2650:	90                   	nop
    2651:	90                   	nop
    2652:	90                   	nop
    2653:	90                   	nop
    2654:	90                   	nop
    2655:	90                   	nop
    2656:	90                   	nop
    2657:	90                   	nop
    2658:	90                   	nop
    2659:	90                   	nop
    265a:	90                   	nop
    265b:	90                   	nop
    265c:	90                   	nop
    265d:	90                   	nop
    265e:	90                   	nop
    265f:	90                   	nop

0000000000002660 <n100_private_lz4_decompress_fast_continue>:
    2660:	f3 0f 1e fa          	endbr64
    2664:	e8 00 00 00 00       	call   2669 <n100_private_lz4_decompress_fast_continue+0x9>
    2669:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    2670:	49 89 f1             	mov    %rsi,%r9
    2673:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
    2678:	48 89 d3             	mov    %rdx,%rbx
    267b:	48 89 6c 24 60       	mov    %rbp,0x60(%rsp)
    2680:	48 63 e9             	movslq %ecx,%rbp
    2683:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    2688:	4c 8b 47 18          	mov    0x18(%rdi),%r8
    268c:	49 89 fc             	mov    %rdi,%r12
    268f:	4d 85 c0             	test   %r8,%r8
    2692:	0f 84 a2 01 00 00    	je     283a <n100_private_lz4_decompress_fast_continue+0x1da>
    2698:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    269c:	48 39 d1             	cmp    %rdx,%rcx
    269f:	74 43                	je     26e4 <n100_private_lz4_decompress_fast_continue+0x84>
    26a1:	4c 29 c1             	sub    %r8,%rcx
    26a4:	4c 89 47 08          	mov    %r8,0x8(%rdi)
    26a8:	89 ea                	mov    %ebp,%edx
    26aa:	48 89 de             	mov    %rbx,%rsi
    26ad:	48 89 0f             	mov    %rcx,(%rdi)
    26b0:	4c 89 cf             	mov    %r9,%rdi
    26b3:	e8 78 e7 ff ff       	call   e30 <n100_private_lz4_decompress_fast_extDict>
    26b8:	85 c0                	test   %eax,%eax
    26ba:	7e 0d                	jle    26c9 <n100_private_lz4_decompress_fast_continue+0x69>
    26bc:	48 01 eb             	add    %rbp,%rbx
    26bf:	49 89 6c 24 18       	mov    %rbp,0x18(%r12)
    26c4:	49 89 5c 24 10       	mov    %rbx,0x10(%r12)
    26c9:	48 8b 5c 24 58       	mov    0x58(%rsp),%rbx
    26ce:	48 8b 6c 24 60       	mov    0x60(%rsp),%rbp
    26d3:	4c 8b 64 24 68       	mov    0x68(%rsp),%r12
    26d8:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    26df:	e9 00 00 00 00       	jmp    26e4 <n100_private_lz4_decompress_fast_continue+0x84>
    26e4:	49 81 f8 fe ff 00 00 	cmp    $0xfffe,%r8
    26eb:	0f 87 15 01 00 00    	ja     2806 <n100_private_lz4_decompress_fast_continue+0x1a6>
    26f1:	4c 8b 5f 08          	mov    0x8(%rdi),%r11
    26f5:	4d 85 db             	test   %r11,%r11
    26f8:	0f 84 08 01 00 00    	je     2806 <n100_private_lz4_decompress_fast_continue+0x1a6>
    26fe:	85 ed                	test   %ebp,%ebp
    2700:	0f 84 4c 03 00 00    	je     2a52 <n100_private_lz4_decompress_fast_continue+0x3f2>
    2706:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
    270b:	48 8b 07             	mov    (%rdi),%rax
    270e:	4c 63 d5             	movslq %ebp,%r10
    2711:	48 89 f1             	mov    %rsi,%rcx
    2714:	49 01 d2             	add    %rdx,%r10
    2717:	4c 89 5c 24 18       	mov    %r11,0x18(%rsp)
    271c:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    2721:	48 89 d0             	mov    %rdx,%rax
    2724:	4c 29 c0             	sub    %r8,%rax
    2727:	49 89 c5             	mov    %rax,%r13
    272a:	49 8d 42 e6          	lea    -0x1a(%r10),%rax
    272e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2733:	49 8d 42 f8          	lea    -0x8(%r10),%rax
    2737:	48 89 04 24          	mov    %rax,(%rsp)
    273b:	0f b6 01             	movzbl (%rcx),%eax
    273e:	48 8d 71 01          	lea    0x1(%rcx),%rsi
    2742:	89 c7                	mov    %eax,%edi
    2744:	c1 e8 04             	shr    $0x4,%eax
    2747:	89 c2                	mov    %eax,%edx
    2749:	83 f8 08             	cmp    $0x8,%eax
    274c:	0f 87 0f 01 00 00    	ja     2861 <n100_private_lz4_decompress_fast_continue+0x201>
    2752:	48 39 5c 24 08       	cmp    %rbx,0x8(%rsp)
    2757:	0f 82 0d 01 00 00    	jb     286a <n100_private_lz4_decompress_fast_continue+0x20a>
    275d:	48 8b 41 01          	mov    0x1(%rcx),%rax
    2761:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
    2765:	4c 8d 04 13          	lea    (%rbx,%rdx,1),%r8
    2769:	48 83 c1 02          	add    $0x2,%rcx
    276d:	48 89 03             	mov    %rax,(%rbx)
    2770:	0f b7 71 fe          	movzwl -0x2(%rcx),%esi
    2774:	48 89 f8             	mov    %rdi,%rax
    2777:	f7 d7                	not    %edi
    2779:	83 e0 0f             	and    $0xf,%eax
    277c:	48 29 f2             	sub    %rsi,%rdx
    277f:	48 01 da             	add    %rbx,%rdx
    2782:	83 e7 0f             	and    $0xf,%edi
    2785:	0f 84 60 01 00 00    	je     28eb <n100_private_lz4_decompress_fast_continue+0x28b>
    278b:	48 83 fe 07          	cmp    $0x7,%rsi
    278f:	0f 86 56 01 00 00    	jbe    28eb <n100_private_lz4_decompress_fast_continue+0x28b>
    2795:	48 83 c0 04          	add    $0x4,%rax
    2799:	4c 39 ea             	cmp    %r13,%rdx
    279c:	0f 83 f2 01 00 00    	jae    2994 <n100_private_lz4_decompress_fast_continue+0x334>
    27a2:	0f b7 f6             	movzwl %si,%esi
    27a5:	41 89 30             	mov    %esi,(%r8)
    27a8:	49 8d 1c 00          	lea    (%r8,%rax,1),%rbx
    27ac:	49 8d 72 fb          	lea    -0x5(%r10),%rsi
    27b0:	48 39 de             	cmp    %rbx,%rsi
    27b3:	0f 82 fe 01 00 00    	jb     29b7 <n100_private_lz4_decompress_fast_continue+0x357>
    27b9:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    27be:	4c 89 ef             	mov    %r13,%rdi
    27c1:	48 29 d7             	sub    %rdx,%rdi
    27c4:	4c 29 ea             	sub    %r13,%rdx
    27c7:	48 03 54 24 18       	add    0x18(%rsp),%rdx
    27cc:	48 01 d6             	add    %rdx,%rsi
    27cf:	48 39 c7             	cmp    %rax,%rdi
    27d2:	0f 82 f1 01 00 00    	jb     29c9 <n100_private_lz4_decompress_fast_continue+0x369>
    27d8:	4c 89 c7             	mov    %r8,%rdi
    27db:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
    27e0:	48 89 c2             	mov    %rax,%rdx
    27e3:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    27e8:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    27ed:	e8 00 00 00 00       	call   27f2 <n100_private_lz4_decompress_fast_continue+0x192>
    27f2:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
    27f7:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
    27fc:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
    2801:	e9 35 ff ff ff       	jmp    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    2806:	89 ea                	mov    %ebp,%edx
    2808:	48 89 de             	mov    %rbx,%rsi
    280b:	4c 89 cf             	mov    %r9,%rdi
    280e:	e8 00 00 00 00       	call   2813 <n100_private_lz4_decompress_fast_continue+0x1b3>
    2813:	85 c0                	test   %eax,%eax
    2815:	0f 8e ae fe ff ff    	jle    26c9 <n100_private_lz4_decompress_fast_continue+0x69>
    281b:	4d 8b 44 24 18       	mov    0x18(%r12),%r8
    2820:	49 8b 5c 24 10       	mov    0x10(%r12),%rbx
    2825:	49 01 e8             	add    %rbp,%r8
    2828:	48 01 dd             	add    %rbx,%rbp
    282b:	4d 89 44 24 18       	mov    %r8,0x18(%r12)
    2830:	49 89 6c 24 10       	mov    %rbp,0x10(%r12)
    2835:	e9 8f fe ff ff       	jmp    26c9 <n100_private_lz4_decompress_fast_continue+0x69>
    283a:	89 ea                	mov    %ebp,%edx
    283c:	48 89 de             	mov    %rbx,%rsi
    283f:	4c 89 cf             	mov    %r9,%rdi
    2842:	e8 00 00 00 00       	call   2847 <n100_private_lz4_decompress_fast_continue+0x1e7>
    2847:	85 c0                	test   %eax,%eax
    2849:	0f 8e 7a fe ff ff    	jle    26c9 <n100_private_lz4_decompress_fast_continue+0x69>
    284f:	49 89 6c 24 18       	mov    %rbp,0x18(%r12)
    2854:	48 01 dd             	add    %rbx,%rbp
    2857:	49 89 6c 24 10       	mov    %rbp,0x10(%r12)
    285c:	e9 68 fe ff ff       	jmp    26c9 <n100_private_lz4_decompress_fast_continue+0x69>
    2861:	83 f8 0f             	cmp    $0xf,%eax
    2864:	0f 84 09 01 00 00    	je     2973 <n100_private_lz4_decompress_fast_continue+0x313>
    286a:	4c 8d 04 13          	lea    (%rbx,%rdx,1),%r8
    286e:	4c 39 04 24          	cmp    %r8,(%rsp)
    2872:	73 3a                	jae    28ae <n100_private_lz4_decompress_fast_continue+0x24e>
    2874:	4d 39 c2             	cmp    %r8,%r10
    2877:	0f 85 37 01 00 00    	jne    29b4 <n100_private_lz4_decompress_fast_continue+0x354>
    287d:	48 89 df             	mov    %rbx,%rdi
    2880:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    2885:	48 89 34 24          	mov    %rsi,(%rsp)
    2889:	4c 89 4c 24 10       	mov    %r9,0x10(%rsp)
    288e:	e8 00 00 00 00       	call   2893 <n100_private_lz4_decompress_fast_continue+0x233>
    2893:	48 8b 34 24          	mov    (%rsp),%rsi
    2897:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    289c:	4c 8b 6c 24 70       	mov    0x70(%rsp),%r13
    28a1:	48 8d 04 16          	lea    (%rsi,%rdx,1),%rax
    28a5:	2b 44 24 10          	sub    0x10(%rsp),%eax
    28a9:	e9 65 ff ff ff       	jmp    2813 <n100_private_lz4_decompress_fast_continue+0x1b3>
    28ae:	48 89 f0             	mov    %rsi,%rax
    28b1:	0f 1f 40 00          	nopl   0x0(%rax)
    28b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    28bc:	00 00 00 00 
    28c0:	48 8b 08             	mov    (%rax),%rcx
    28c3:	48 83 c3 08          	add    $0x8,%rbx
    28c7:	48 83 c0 08          	add    $0x8,%rax
    28cb:	48 89 4b f8          	mov    %rcx,-0x8(%rbx)
    28cf:	4c 39 c3             	cmp    %r8,%rbx
    28d2:	72 ec                	jb     28c0 <n100_private_lz4_decompress_fast_continue+0x260>
    28d4:	48 8d 04 16          	lea    (%rsi,%rdx,1),%rax
    28d8:	4c 89 c2             	mov    %r8,%rdx
    28db:	0f b7 30             	movzwl (%rax),%esi
    28de:	48 8d 48 02          	lea    0x2(%rax),%rcx
    28e2:	48 89 f8             	mov    %rdi,%rax
    28e5:	83 e0 0f             	and    $0xf,%eax
    28e8:	48 29 f2             	sub    %rsi,%rdx
    28eb:	41 89 30             	mov    %esi,(%r8)
    28ee:	48 83 f8 0f          	cmp    $0xf,%rax
    28f2:	74 6c                	je     2960 <n100_private_lz4_decompress_fast_continue+0x300>
    28f4:	48 83 c0 04          	add    $0x4,%rax
    28f8:	4c 39 ea             	cmp    %r13,%rdx
    28fb:	0f 82 a7 fe ff ff    	jb     27a8 <n100_private_lz4_decompress_fast_continue+0x148>
    2901:	49 8d 1c 00          	lea    (%r8,%rax,1),%rbx
    2905:	48 83 fe 07          	cmp    $0x7,%rsi
    2909:	0f 86 e7 01 00 00    	jbe    2af6 <n100_private_lz4_decompress_fast_continue+0x496>
    290f:	48 8b 32             	mov    (%rdx),%rsi
    2912:	48 83 c2 08          	add    $0x8,%rdx
    2916:	49 89 30             	mov    %rsi,(%r8)
    2919:	49 8d 72 f4          	lea    -0xc(%r10),%rsi
    291d:	48 39 de             	cmp    %rbx,%rsi
    2920:	0f 82 7e 01 00 00    	jb     2aa4 <n100_private_lz4_decompress_fast_continue+0x444>
    2926:	48 8b 32             	mov    (%rdx),%rsi
    2929:	49 89 70 08          	mov    %rsi,0x8(%r8)
    292d:	48 83 f8 10          	cmp    $0x10,%rax
    2931:	0f 86 04 fe ff ff    	jbe    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    2937:	48 8d 42 08          	lea    0x8(%rdx),%rax
    293b:	49 83 c0 10          	add    $0x10,%r8
    293f:	90                   	nop
    2940:	48 8b 10             	mov    (%rax),%rdx
    2943:	49 83 c0 08          	add    $0x8,%r8
    2947:	48 83 c0 08          	add    $0x8,%rax
    294b:	49 89 50 f8          	mov    %rdx,-0x8(%r8)
    294f:	49 39 d8             	cmp    %rbx,%r8
    2952:	72 ec                	jb     2940 <n100_private_lz4_decompress_fast_continue+0x2e0>
    2954:	e9 e2 fd ff ff       	jmp    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    2959:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2960:	44 0f b6 19          	movzbl (%rcx),%r11d
    2964:	48 83 c1 01          	add    $0x1,%rcx
    2968:	4c 01 d8             	add    %r11,%rax
    296b:	41 80 fb ff          	cmp    $0xff,%r11b
    296f:	74 ef                	je     2960 <n100_private_lz4_decompress_fast_continue+0x300>
    2971:	eb 81                	jmp    28f4 <n100_private_lz4_decompress_fast_continue+0x294>
    2973:	ba 0f 00 00 00       	mov    $0xf,%edx
    2978:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    297f:	00 
    2980:	0f b6 0e             	movzbl (%rsi),%ecx
    2983:	48 83 c6 01          	add    $0x1,%rsi
    2987:	48 01 ca             	add    %rcx,%rdx
    298a:	80 f9 ff             	cmp    $0xff,%cl
    298d:	74 f1                	je     2980 <n100_private_lz4_decompress_fast_continue+0x320>
    298f:	e9 d6 fe ff ff       	jmp    286a <n100_private_lz4_decompress_fast_continue+0x20a>
    2994:	49 8d 1c 00          	lea    (%r8,%rax,1),%rbx
    2998:	48 8b 02             	mov    (%rdx),%rax
    299b:	49 89 00             	mov    %rax,(%r8)
    299e:	48 8b 42 08          	mov    0x8(%rdx),%rax
    29a2:	49 89 40 08          	mov    %rax,0x8(%r8)
    29a6:	0f b7 42 10          	movzwl 0x10(%rdx),%eax
    29aa:	66 41 89 40 10       	mov    %ax,0x10(%r8)
    29af:	e9 87 fd ff ff       	jmp    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    29b4:	48 89 f1             	mov    %rsi,%rcx
    29b7:	48 89 c8             	mov    %rcx,%rax
    29ba:	4c 8b 6c 24 70       	mov    0x70(%rsp),%r13
    29bf:	4c 29 c8             	sub    %r9,%rax
    29c2:	f7 d0                	not    %eax
    29c4:	e9 4a fe ff ff       	jmp    2813 <n100_private_lz4_decompress_fast_continue+0x1b3>
    29c9:	48 29 f8             	sub    %rdi,%rax
    29cc:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    29d3:	00 
    29d4:	48 89 fa             	mov    %rdi,%rdx
    29d7:	49 89 ff             	mov    %rdi,%r15
    29da:	4c 89 c7             	mov    %r8,%rdi
    29dd:	4c 89 74 24 78       	mov    %r14,0x78(%rsp)
    29e2:	49 89 c6             	mov    %rax,%r14
    29e5:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
    29ea:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    29ef:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    29f4:	e8 00 00 00 00       	call   29f9 <n100_private_lz4_decompress_fast_continue+0x399>
    29f9:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
    29fe:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
    2a03:	4a 8d 3c 38          	lea    (%rax,%r15,1),%rdi
    2a07:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
    2a0c:	48 89 f8             	mov    %rdi,%rax
    2a0f:	4c 29 e8             	sub    %r13,%rax
    2a12:	4c 39 f0             	cmp    %r14,%rax
    2a15:	72 55                	jb     2a6c <n100_private_lz4_decompress_fast_continue+0x40c>
    2a17:	4c 89 f2             	mov    %r14,%rdx
    2a1a:	4c 89 ee             	mov    %r13,%rsi
    2a1d:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
    2a22:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    2a27:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
    2a2c:	e8 00 00 00 00       	call   2a31 <n100_private_lz4_decompress_fast_continue+0x3d1>
    2a31:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
    2a36:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
    2a3b:	4c 8b 4c 24 30       	mov    0x30(%rsp),%r9
    2a40:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    2a45:	4c 8b bc 24 80 00 00 	mov    0x80(%rsp),%r15
    2a4c:	00 
    2a4d:	e9 e9 fc ff ff       	jmp    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    2a52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2a57:	80 3e 00             	cmpb   $0x0,(%rsi)
    2a5a:	0f 85 69 fc ff ff    	jne    26c9 <n100_private_lz4_decompress_fast_continue+0x69>
    2a60:	31 ed                	xor    %ebp,%ebp
    2a62:	b8 01 00 00 00       	mov    $0x1,%eax
    2a67:	e9 b9 fd ff ff       	jmp    2825 <n100_private_lz4_decompress_fast_continue+0x1c5>
    2a6c:	48 39 df             	cmp    %rbx,%rdi
    2a6f:	0f 83 10 01 00 00    	jae    2b85 <n100_private_lz4_decompress_fast_continue+0x525>
    2a75:	31 c0                	xor    %eax,%eax
    2a77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    2a7e:	00 00 
    2a80:	41 0f b6 54 05 00    	movzbl 0x0(%r13,%rax,1),%edx
    2a86:	88 14 07             	mov    %dl,(%rdi,%rax,1)
    2a89:	48 83 c0 01          	add    $0x1,%rax
    2a8d:	49 39 c6             	cmp    %rax,%r14
    2a90:	75 ee                	jne    2a80 <n100_private_lz4_decompress_fast_continue+0x420>
    2a92:	4c 8b 74 24 78       	mov    0x78(%rsp),%r14
    2a97:	4c 8b bc 24 80 00 00 	mov    0x80(%rsp),%r15
    2a9e:	00 
    2a9f:	e9 97 fc ff ff       	jmp    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    2aa4:	49 8d 42 fb          	lea    -0x5(%r10),%rax
    2aa8:	48 39 d8             	cmp    %rbx,%rax
    2aab:	0f 82 06 ff ff ff    	jb     29b7 <n100_private_lz4_decompress_fast_continue+0x357>
    2ab1:	49 83 c0 08          	add    $0x8,%r8
    2ab5:	49 8d 7a f9          	lea    -0x7(%r10),%rdi
    2ab9:	49 39 f8             	cmp    %rdi,%r8
    2abc:	0f 82 82 00 00 00    	jb     2b44 <n100_private_lz4_decompress_fast_continue+0x4e4>
    2ac2:	48 89 df             	mov    %rbx,%rdi
    2ac5:	31 c0                	xor    %eax,%eax
    2ac7:	4c 29 c7             	sub    %r8,%rdi
    2aca:	49 39 d8             	cmp    %rbx,%r8
    2acd:	0f 83 68 fc ff ff    	jae    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    2ad3:	66 90                	xchg   %ax,%ax
    2ad5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2adc:	00 00 00 00 
    2ae0:	0f b6 34 02          	movzbl (%rdx,%rax,1),%esi
    2ae4:	41 88 34 00          	mov    %sil,(%r8,%rax,1)
    2ae8:	48 83 c0 01          	add    $0x1,%rax
    2aec:	48 39 c7             	cmp    %rax,%rdi
    2aef:	75 ef                	jne    2ae0 <n100_private_lz4_decompress_fast_continue+0x480>
    2af1:	e9 45 fc ff ff       	jmp    273b <n100_private_lz4_decompress_fast_continue+0xdb>
    2af6:	0f b6 3a             	movzbl (%rdx),%edi
    2af9:	41 88 38             	mov    %dil,(%r8)
    2afc:	0f b6 7a 01          	movzbl 0x1(%rdx),%edi
    2b00:	41 88 78 01          	mov    %dil,0x1(%r8)
    2b04:	0f b6 7a 02          	movzbl 0x2(%rdx),%edi
    2b08:	41 88 78 02          	mov    %dil,0x2(%r8)
    2b0c:	0f b6 7a 03          	movzbl 0x3(%rdx),%edi
    2b10:	41 88 78 03          	mov    %dil,0x3(%r8)
    2b14:	48 83 fe 08          	cmp    $0x8,%rsi
    2b18:	0f 83 c6 00 00 00    	jae    2be4 <n100_private_lz4_decompress_fast_continue+0x584>
    2b1e:	8b 3c b5 00 00 00 00 	mov    0x0(,%rsi,4),%edi
    2b25:	48 01 fa             	add    %rdi,%rdx
    2b28:	8b 3a                	mov    (%rdx),%edi
    2b2a:	41 89 78 04          	mov    %edi,0x4(%r8)
    2b2e:	48 83 fe 08          	cmp    $0x8,%rsi
    2b32:	73 59                	jae    2b8d <n100_private_lz4_decompress_fast_continue+0x52d>
    2b34:	48 63 34 b5 00 00 00 	movslq 0x0(,%rsi,4),%rsi
    2b3b:	00 
    2b3c:	48 29 f2             	sub    %rsi,%rdx
    2b3f:	e9 d5 fd ff ff       	jmp    2919 <n100_private_lz4_decompress_fast_continue+0x2b9>
    2b44:	48 89 d6             	mov    %rdx,%rsi
    2b47:	4c 89 c0             	mov    %r8,%rax
    2b4a:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2b51:	00 00 00 00 
    2b55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2b5c:	00 00 00 00 
    2b60:	4c 8b 1e             	mov    (%rsi),%r11
    2b63:	48 83 c0 08          	add    $0x8,%rax
    2b67:	48 83 c6 08          	add    $0x8,%rsi
    2b6b:	4c 89 58 f8          	mov    %r11,-0x8(%rax)
    2b6f:	48 39 f8             	cmp    %rdi,%rax
    2b72:	72 ec                	jb     2b60 <n100_private_lz4_decompress_fast_continue+0x500>
    2b74:	48 89 f8             	mov    %rdi,%rax
    2b77:	4c 29 c0             	sub    %r8,%rax
    2b7a:	49 89 f8             	mov    %rdi,%r8
    2b7d:	48 01 c2             	add    %rax,%rdx
    2b80:	e9 3d ff ff ff       	jmp    2ac2 <n100_private_lz4_decompress_fast_continue+0x462>
    2b85:	48 89 fb             	mov    %rdi,%rbx
    2b88:	e9 05 ff ff ff       	jmp    2a92 <n100_private_lz4_decompress_fast_continue+0x432>
    2b8d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    2b94:	4c 89 44 24 50       	mov    %r8,0x50(%rsp)
    2b99:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    2b9e:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
    2ba3:	4c 89 54 24 38       	mov    %r10,0x38(%rsp)
    2ba8:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    2bad:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    2bb2:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
    2bb7:	e8 00 00 00 00       	call   2bbc <n100_private_lz4_decompress_fast_continue+0x55c>
    2bbc:	4c 8b 44 24 50       	mov    0x50(%rsp),%r8
    2bc1:	4c 8b 4c 24 48       	mov    0x48(%rsp),%r9
    2bc6:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
    2bcb:	4c 8b 54 24 38       	mov    0x38(%rsp),%r10
    2bd0:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
    2bd5:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    2bda:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    2bdf:	e9 50 ff ff ff       	jmp    2b34 <n100_private_lz4_decompress_fast_continue+0x4d4>
    2be4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
    2beb:	4c 89 44 24 50       	mov    %r8,0x50(%rsp)
    2bf0:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    2bf5:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
    2bfa:	4c 89 54 24 38       	mov    %r10,0x38(%rsp)
    2bff:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    2c04:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
    2c09:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
    2c0e:	e8 00 00 00 00       	call   2c13 <n100_private_lz4_decompress_fast_continue+0x5b3>
    2c13:	4c 8b 44 24 50       	mov    0x50(%rsp),%r8
    2c18:	4c 8b 4c 24 48       	mov    0x48(%rsp),%r9
    2c1d:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
    2c22:	4c 8b 54 24 38       	mov    0x38(%rsp),%r10
    2c27:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    2c2c:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
    2c31:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
    2c36:	e9 e3 fe ff ff       	jmp    2b1e <n100_private_lz4_decompress_fast_continue+0x4be>
    2c3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    2c40:	90                   	nop
    2c41:	90                   	nop
    2c42:	90                   	nop
    2c43:	90                   	nop
    2c44:	90                   	nop
    2c45:	90                   	nop
    2c46:	90                   	nop
    2c47:	90                   	nop
    2c48:	90                   	nop
    2c49:	90                   	nop
    2c4a:	90                   	nop
    2c4b:	90                   	nop
    2c4c:	90                   	nop
    2c4d:	90                   	nop
    2c4e:	90                   	nop
    2c4f:	90                   	nop

0000000000002c50 <n100_private_lz4_decompress_safe_usingDict>:
    2c50:	f3 0f 1e fa          	endbr64
    2c54:	e8 00 00 00 00       	call   2c59 <n100_private_lz4_decompress_safe_usingDict+0x9>
    2c59:	45 85 c9             	test   %r9d,%r9d
    2c5c:	74 22                	je     2c80 <n100_private_lz4_decompress_safe_usingDict+0x30>
    2c5e:	49 63 c1             	movslq %r9d,%rax
    2c61:	4d 8d 14 00          	lea    (%r8,%rax,1),%r10
    2c65:	4c 39 d6             	cmp    %r10,%rsi
    2c68:	74 08                	je     2c72 <n100_private_lz4_decompress_safe_usingDict+0x22>
    2c6a:	49 89 c1             	mov    %rax,%r9
    2c6d:	e9 2e dc ff ff       	jmp    8a0 <n100_private_lz4_decompress_safe_forceExtDict>
    2c72:	41 81 f9 fe ff 00 00 	cmp    $0xfffe,%r9d
    2c79:	7e 0a                	jle    2c85 <n100_private_lz4_decompress_safe_usingDict+0x35>
    2c7b:	e9 90 d3 ff ff       	jmp    10 <n100_private_lz4_decompress_safe_withPrefix64k>
    2c80:	e9 5b e6 ff ff       	jmp    12e0 <n100_private_lz4_decompress_safe>
    2c85:	49 89 c0             	mov    %rax,%r8
    2c88:	e9 d3 d7 ff ff       	jmp    460 <n100_private_lz4_decompress_safe_withSmallPrefix>
    2c8d:	0f 1f 00             	nopl   (%rax)
    2c90:	90                   	nop
    2c91:	90                   	nop
    2c92:	90                   	nop
    2c93:	90                   	nop
    2c94:	90                   	nop
    2c95:	90                   	nop
    2c96:	90                   	nop
    2c97:	90                   	nop
    2c98:	90                   	nop
    2c99:	90                   	nop
    2c9a:	90                   	nop
    2c9b:	90                   	nop
    2c9c:	90                   	nop
    2c9d:	90                   	nop
    2c9e:	90                   	nop
    2c9f:	90                   	nop

0000000000002ca0 <n100_private_lz4_decompress_fast_usingDict>:
    2ca0:	f3 0f 1e fa          	endbr64
    2ca4:	e8 00 00 00 00       	call   2ca9 <n100_private_lz4_decompress_fast_usingDict+0x9>
    2ca9:	45 85 c0             	test   %r8d,%r8d
    2cac:	74 11                	je     2cbf <n100_private_lz4_decompress_fast_usingDict+0x1f>
    2cae:	4d 63 c0             	movslq %r8d,%r8
    2cb1:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    2cb5:	48 39 c6             	cmp    %rax,%rsi
    2cb8:	74 05                	je     2cbf <n100_private_lz4_decompress_fast_usingDict+0x1f>
    2cba:	e9 71 e1 ff ff       	jmp    e30 <n100_private_lz4_decompress_fast_extDict>
    2cbf:	e9 cc ee ff ff       	jmp    1b90 <n100_private_lz4_decompress_fast>
