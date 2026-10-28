
build/astra-v8/hybrid-blockdirect3base.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <pack_avx2>:
       0:	85 d2                	test   edx,edx
       2:	74 6c                	je     70 <pack_avx2+0x70>
       4:	c5 fe 6f 07          	vmovdqu ymm0,YMMWORD PTR [rdi]
       8:	81 fa ff 00 00 00    	cmp    edx,0xff
       e:	74 50                	je     60 <pack_avx2+0x60>
      10:	55                   	push   rbp
      11:	89 d2                	mov    edx,edx
      13:	48 8d 0d 00 00 00 00 	lea    rcx,[rip+0x0]        # 1a <pack_avx2+0x1a>
      1a:	48 89 f7             	mov    rdi,rsi
      1d:	48 89 d0             	mov    rax,rdx
      20:	48 c1 e0 05          	shl    rax,0x5
      24:	48 89 e5             	mov    rbp,rsp
      27:	48 83 e4 e0          	and    rsp,0xffffffffffffffe0
      2b:	48 83 ec 20          	sub    rsp,0x20
      2f:	c5 fd 6f 0c 01       	vmovdqa ymm1,YMMWORD PTR [rcx+rax*1]
      34:	48 8d 05 00 00 00 00 	lea    rax,[rip+0x0]        # 3b <pack_avx2+0x3b>
      3b:	0f b6 04 10          	movzx  eax,BYTE PTR [rax+rdx*1]
      3f:	48 89 e6             	mov    rsi,rsp
      42:	c4 e2 75 36 c0       	vpermd ymm0,ymm1,ymm0
      47:	c5 fd 7f 04 24       	vmovdqa YMMWORD PTR [rsp],ymm0
      4c:	8d 14 85 00 00 00 00 	lea    edx,[rax*4+0x0]
      53:	c5 f8 77             	vzeroupper
      56:	e8 00 00 00 00       	call   5b <pack_avx2+0x5b>
      5b:	c9                   	leave
      5c:	c3                   	ret
      5d:	0f 1f 00             	nop    DWORD PTR [rax]
      60:	c5 fe 7f 06          	vmovdqu YMMWORD PTR [rsi],ymm0
      64:	c5 f8 77             	vzeroupper
      67:	c3                   	ret
      68:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
      6f:	00 
      70:	c3                   	ret
      71:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
      75:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
      7c:	00 00 00 00 

0000000000000080 <repeat_avx2>:
      80:	55                   	push   rbp
      81:	48 89 e5             	mov    rbp,rsp
      84:	41 57                	push   r15
      86:	49 89 f7             	mov    r15,rsi
      89:	41 56                	push   r14
      8b:	41 55                	push   r13
      8d:	41 54                	push   r12
      8f:	53                   	push   rbx
      90:	48 83 e4 e0          	and    rsp,0xffffffffffffffe0
      94:	83 f9 04             	cmp    ecx,0x4
      97:	0f 84 f3 00 00 00    	je     190 <repeat_avx2+0x110>
      9d:	83 f9 08             	cmp    ecx,0x8
      a0:	0f 84 ba 00 00 00    	je     160 <repeat_avx2+0xe0>
      a6:	83 f9 10             	cmp    ecx,0x10
      a9:	0f 84 f1 00 00 00    	je     1a0 <repeat_avx2+0x120>
      af:	c5 fe 6f 06          	vmovdqu ymm0,YMMWORD PTR [rsi]
      b3:	48 83 fa 1f          	cmp    rdx,0x1f
      b7:	0f 86 b2 00 00 00    	jbe    16f <repeat_avx2+0xef>
      bd:	48 8d 5a e0          	lea    rbx,[rdx-0x20]
      c1:	48 89 f8             	mov    rax,rdi
      c4:	48 89 de             	mov    rsi,rbx
      c7:	48 83 e6 e0          	and    rsi,0xffffffffffffffe0
      cb:	48 8d 74 37 20       	lea    rsi,[rdi+rsi*1+0x20]
      d0:	49 89 f0             	mov    r8,rsi
      d3:	49 29 f8             	sub    r8,rdi
      d6:	41 83 e0 20          	and    r8d,0x20
      da:	74 24                	je     100 <repeat_avx2+0x80>
      dc:	48 8d 47 20          	lea    rax,[rdi+0x20]
      e0:	c5 fe 7f 07          	vmovdqu YMMWORD PTR [rdi],ymm0
      e4:	48 39 f0             	cmp    rax,rsi
      e7:	74 29                	je     112 <repeat_avx2+0x92>
      e9:	90                   	nop
      ea:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
      f1:	00 00 00 00 
      f5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
      fc:	00 00 00 00 
     100:	c5 fe 7f 00          	vmovdqu YMMWORD PTR [rax],ymm0
     104:	48 83 c0 40          	add    rax,0x40
     108:	c5 fe 7f 40 e0       	vmovdqu YMMWORD PTR [rax-0x20],ymm0
     10d:	48 39 f0             	cmp    rax,rsi
     110:	75 ee                	jne    100 <repeat_avx2+0x80>
     112:	48 83 e3 e0          	and    rbx,0xffffffffffffffe0
     116:	48 83 c3 20          	add    rbx,0x20
     11a:	48 39 d3             	cmp    rbx,rdx
     11d:	73 57                	jae    176 <repeat_avx2+0xf6>
     11f:	49 89 d6             	mov    r14,rdx
     122:	49 89 fd             	mov    r13,rdi
     125:	41 89 cc             	mov    r12d,ecx
     128:	c5 f8 77             	vzeroupper
     12b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     130:	49 8d 7c 1d 00       	lea    rdi,[r13+rbx*1+0x0]
     135:	4c 89 e2             	mov    rdx,r12
     138:	4c 89 fe             	mov    rsi,r15
     13b:	4c 01 e3             	add    rbx,r12
     13e:	e8 00 00 00 00       	call   143 <repeat_avx2+0xc3>
     143:	4c 39 f3             	cmp    rbx,r14
     146:	72 e8                	jb     130 <repeat_avx2+0xb0>
     148:	48 8d 65 d8          	lea    rsp,[rbp-0x28]
     14c:	5b                   	pop    rbx
     14d:	41 5c                	pop    r12
     14f:	41 5d                	pop    r13
     151:	41 5e                	pop    r14
     153:	41 5f                	pop    r15
     155:	5d                   	pop    rbp
     156:	c3                   	ret
     157:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     15e:	00 00 
     160:	c4 e2 7d 59 06       	vpbroadcastq ymm0,QWORD PTR [rsi]
     165:	48 83 fa 1f          	cmp    rdx,0x1f
     169:	0f 87 4e ff ff ff    	ja     bd <repeat_avx2+0x3d>
     16f:	31 db                	xor    ebx,ebx
     171:	48 39 d3             	cmp    rbx,rdx
     174:	72 a9                	jb     11f <repeat_avx2+0x9f>
     176:	c5 f8 77             	vzeroupper
     179:	48 8d 65 d8          	lea    rsp,[rbp-0x28]
     17d:	5b                   	pop    rbx
     17e:	41 5c                	pop    r12
     180:	41 5d                	pop    r13
     182:	41 5e                	pop    r14
     184:	41 5f                	pop    r15
     186:	5d                   	pop    rbp
     187:	c3                   	ret
     188:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     18f:	00 
     190:	c4 e2 7d 58 06       	vpbroadcastd ymm0,DWORD PTR [rsi]
     195:	e9 19 ff ff ff       	jmp    b3 <repeat_avx2+0x33>
     19a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     1a0:	c4 e2 7d 5a 06       	vbroadcasti128 ymm0,XMMWORD PTR [rsi]
     1a5:	e9 09 ff ff ff       	jmp    b3 <repeat_avx2+0x33>
     1aa:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

00000000000001b0 <scan_avx2>:
     1b0:	49 89 f8             	mov    r8,rdi
     1b3:	48 c1 ee 05          	shr    rsi,0x5
     1b7:	c5 c9 ef f6          	vpxor  xmm6,xmm6,xmm6
     1bb:	48 89 d7             	mov    rdi,rdx
     1be:	41 8b 00             	mov    eax,DWORD PTR [r8]
     1c1:	c4 41 7a 7e 00       	vmovq  xmm8,QWORD PTR [r8]
     1c6:	c4 c1 7a 6f 38       	vmovdqu xmm7,XMMWORD PTR [r8]
     1cb:	c4 41 7e 6f 10       	vmovdqu ymm10,YMMWORD PTR [r8]
     1d0:	c7 82 80 00 00 00 00 	mov    DWORD PTR [rdx+0x80],0x0
     1d7:	00 00 00 
     1da:	0f 84 c8 00 00 00    	je     2a8 <scan_avx2+0xf8>
     1e0:	c5 79 6e c8          	vmovd  xmm9,eax
     1e4:	c4 e3 45 38 ff 01    	vinserti128 ymm7,ymm7,xmm7,0x1
     1ea:	31 c9                	xor    ecx,ecx
     1ec:	31 d2                	xor    edx,edx
     1ee:	c4 42 7d 58 c9       	vpbroadcastd ymm9,xmm9
     1f3:	c4 42 7d 59 c0       	vpbroadcastq ymm8,xmm8
     1f8:	c5 fd 6f ce          	vmovdqa ymm1,ymm6
     1fc:	c5 fd 6f d6          	vmovdqa ymm2,ymm6
     200:	c5 fd 6f de          	vmovdqa ymm3,ymm6
     204:	c5 fd 6f e6          	vmovdqa ymm4,ymm6
     208:	4c 8d 0d 00 00 00 00 	lea    r9,[rip+0x0]        # 20f <scan_avx2+0x5f>
     20f:	90                   	nop
     210:	48 89 d0             	mov    rax,rdx
     213:	48 c1 e0 05          	shl    rax,0x5
     217:	c4 c1 7e 6f 04 00    	vmovdqu ymm0,YMMWORD PTR [r8+rax*1]
     21d:	c5 fd 76 ee          	vpcmpeqd ymm5,ymm0,ymm6
     221:	c5 fc 50 c5          	vmovmskps eax,ymm5
     225:	c4 c1 7d ef e9       	vpxor  ymm5,ymm0,ymm9
     22a:	34 ff                	xor    al,0xff
     22c:	c5 d5 eb e4          	vpor   ymm4,ymm5,ymm4
     230:	c5 bd ef e8          	vpxor  ymm5,ymm8,ymm0
     234:	88 04 17             	mov    BYTE PTR [rdi+rdx*1],al
     237:	89 c0                	mov    eax,eax
     239:	c5 d5 eb db          	vpor   ymm3,ymm5,ymm3
     23d:	48 83 c2 01          	add    rdx,0x1
     241:	41 0f b6 04 01       	movzx  eax,BYTE PTR [r9+rax*1]
     246:	c5 c5 ef e8          	vpxor  ymm5,ymm7,ymm0
     24a:	c5 ad ef c0          	vpxor  ymm0,ymm10,ymm0
     24e:	c5 d5 eb d2          	vpor   ymm2,ymm5,ymm2
     252:	c5 fd eb c9          	vpor   ymm1,ymm0,ymm1
     256:	01 c1                	add    ecx,eax
     258:	89 8f 80 00 00 00    	mov    DWORD PTR [rdi+0x80],ecx
     25e:	48 39 f2             	cmp    rdx,rsi
     261:	75 ad                	jne    210 <scan_avx2+0x60>
     263:	31 f6                	xor    esi,esi
     265:	c4 e2 7d 17 e4       	vptest ymm4,ymm4
     26a:	40 0f 94 c6          	sete   sil
     26e:	31 c0                	xor    eax,eax
     270:	c4 e2 7d 17 db       	vptest ymm3,ymm3
     275:	0f 94 c0             	sete   al
     278:	31 c9                	xor    ecx,ecx
     27a:	c4 e2 7d 17 d2       	vptest ymm2,ymm2
     27f:	0f 94 c1             	sete   cl
     282:	31 d2                	xor    edx,edx
     284:	c4 e2 7d 17 c9       	vptest ymm1,ymm1
     289:	0f 94 c2             	sete   dl
     28c:	01 c0                	add    eax,eax
     28e:	c1 e1 02             	shl    ecx,0x2
     291:	09 c8                	or     eax,ecx
     293:	c1 e2 03             	shl    edx,0x3
     296:	09 f0                	or     eax,esi
     298:	09 d0                	or     eax,edx
     29a:	89 87 84 00 00 00    	mov    DWORD PTR [rdi+0x84],eax
     2a0:	c5 f8 77             	vzeroupper
     2a3:	c3                   	ret
     2a4:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     2a8:	c5 fd 6f ce          	vmovdqa ymm1,ymm6
     2ac:	c5 fd 6f d6          	vmovdqa ymm2,ymm6
     2b0:	c5 fd 6f de          	vmovdqa ymm3,ymm6
     2b4:	c5 fd 6f e6          	vmovdqa ymm4,ymm6
     2b8:	eb a9                	jmp    263 <scan_avx2+0xb3>
     2ba:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

00000000000002c0 <unpack_avx2>:
     2c0:	55                   	push   rbp
     2c1:	c5 f9 ef c0          	vpxor  xmm0,xmm0,xmm0
     2c5:	48 89 e5             	mov    rbp,rsp
     2c8:	41 55                	push   r13
     2ca:	49 89 f5             	mov    r13,rsi
     2cd:	48 89 fe             	mov    rsi,rdi
     2d0:	41 54                	push   r12
     2d2:	41 89 d4             	mov    r12d,edx
     2d5:	48 8d 15 00 00 00 00 	lea    rdx,[rip+0x0]        # 2dc <unpack_avx2+0x1c>
     2dc:	53                   	push   rbx
     2dd:	4c 89 e3             	mov    rbx,r12
     2e0:	48 83 e4 e0          	and    rsp,0xffffffffffffffe0
     2e4:	48 83 ec 20          	sub    rsp,0x20
     2e8:	42 0f b6 14 22       	movzx  edx,BYTE PTR [rdx+r12*1]
     2ed:	c5 fd 7f 04 24       	vmovdqa YMMWORD PTR [rsp],ymm0
     2f2:	48 89 e7             	mov    rdi,rsp
     2f5:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
     2fc:	c5 f8 77             	vzeroupper
     2ff:	49 c1 e4 05          	shl    r12,0x5
     303:	e8 00 00 00 00       	call   308 <unpack_avx2+0x48>
     308:	c5 f9 6e c3          	vmovd  xmm0,ebx
     30c:	c5 f1 ef c9          	vpxor  xmm1,xmm1,xmm1
     310:	48 8d 05 00 00 00 00 	lea    rax,[rip+0x0]        # 317 <unpack_avx2+0x57>
     317:	c4 e2 7d 58 c0       	vpbroadcastd ymm0,xmm0
     31c:	c5 fd db 05 00 00 00 	vpand  ymm0,ymm0,YMMWORD PTR [rip+0x0]        # 324 <unpack_avx2+0x64>
     323:	00 
     324:	c4 a1 7d 6f 14 20    	vmovdqa ymm2,YMMWORD PTR [rax+r12*1]
     32a:	c4 e2 6d 36 14 24    	vpermd ymm2,ymm2,YMMWORD PTR [rsp]
     330:	c5 fd 76 c1          	vpcmpeqd ymm0,ymm0,ymm1
     334:	c5 fd df c2          	vpandn ymm0,ymm0,ymm2
     338:	c4 c1 7e 7f 45 00    	vmovdqu YMMWORD PTR [r13+0x0],ymm0
     33e:	c5 f8 77             	vzeroupper
     341:	48 8d 65 e8          	lea    rsp,[rbp-0x18]
     345:	5b                   	pop    rbx
     346:	41 5c                	pop    r12
     348:	41 5d                	pop    r13
     34a:	5d                   	pop    rbp
     34b:	c3                   	ret
     34c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000000350 <pack_scalar>:
     350:	81 fa ff 00 00 00    	cmp    edx,0xff
     356:	74 28                	je     380 <pack_scalar+0x30>
     358:	85 d2                	test   edx,edx
     35a:	74 44                	je     3a0 <pack_scalar+0x50>
     35c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     360:	31 c9                	xor    ecx,ecx
     362:	8d 42 ff             	lea    eax,[rdx-0x1]
     365:	48 83 c6 04          	add    rsi,0x4
     369:	f3 0f bc ca          	tzcnt  ecx,edx
     36d:	8d 0c 8d 00 00 00 00 	lea    ecx,[rcx*4+0x0]
     374:	8b 0c 0f             	mov    ecx,DWORD PTR [rdi+rcx*1]
     377:	89 4e fc             	mov    DWORD PTR [rsi-0x4],ecx
     37a:	21 c2                	and    edx,eax
     37c:	75 e2                	jne    360 <pack_scalar+0x10>
     37e:	c3                   	ret
     37f:	90                   	nop
     380:	48 8b 07             	mov    rax,QWORD PTR [rdi]
     383:	48 89 06             	mov    QWORD PTR [rsi],rax
     386:	48 8b 47 08          	mov    rax,QWORD PTR [rdi+0x8]
     38a:	48 89 46 08          	mov    QWORD PTR [rsi+0x8],rax
     38e:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
     392:	48 89 46 10          	mov    QWORD PTR [rsi+0x10],rax
     396:	48 8b 47 18          	mov    rax,QWORD PTR [rdi+0x18]
     39a:	48 89 46 18          	mov    QWORD PTR [rsi+0x18],rax
     39e:	c3                   	ret
     39f:	90                   	nop
     3a0:	c3                   	ret
     3a1:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     3a5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     3ac:	00 00 00 00 

00000000000003b0 <pack_block_avx2>:
     3b0:	55                   	push   rbp
     3b1:	48 89 e5             	mov    rbp,rsp
     3b4:	41 57                	push   r15
     3b6:	41 56                	push   r14
     3b8:	41 55                	push   r13
     3ba:	41 54                	push   r12
     3bc:	53                   	push   rbx
     3bd:	48 83 e4 e0          	and    rsp,0xffffffffffffffe0
     3c1:	48 83 ec 40          	sub    rsp,0x40
     3c5:	48 85 c9             	test   rcx,rcx
     3c8:	0f 84 c2 00 00 00    	je     490 <pack_block_avx2+0xe0>
     3ce:	48 89 74 24 10       	mov    QWORD PTR [rsp+0x10],rsi
     3d3:	49 89 d5             	mov    r13,rdx
     3d6:	49 89 fe             	mov    r14,rdi
     3d9:	48 8d 1c 0a          	lea    rbx,[rdx+rcx*1]
     3dd:	45 31 ff             	xor    r15d,r15d
     3e0:	4c 8d 25 00 00 00 00 	lea    r12,[rip+0x0]        # 3e7 <pack_block_avx2+0x37>
     3e7:	eb 49                	jmp    432 <pack_block_avx2+0x82>
     3e9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     3f0:	48 c1 e0 05          	shl    rax,0x5
     3f4:	48 89 54 24 18       	mov    QWORD PTR [rsp+0x18],rdx
     3f9:	48 8d 74 24 20       	lea    rsi,[rsp+0x20]
     3fe:	48 8d 0d 00 00 00 00 	lea    rcx,[rip+0x0]        # 405 <pack_block_avx2+0x55>
     405:	c5 fd 6f 0c 01       	vmovdqa ymm1,YMMWORD PTR [rcx+rax*1]
     40a:	c4 e2 75 36 c0       	vpermd ymm0,ymm1,ymm0
     40f:	c5 fd 7f 44 24 20    	vmovdqa YMMWORD PTR [rsp+0x20],ymm0
     415:	c5 f8 77             	vzeroupper
     418:	e8 00 00 00 00       	call   41d <pack_block_avx2+0x6d>
     41d:	48 8b 54 24 18       	mov    rdx,QWORD PTR [rsp+0x18]
     422:	49 83 c5 01          	add    r13,0x1
     426:	49 01 d7             	add    r15,rdx
     429:	49 83 c6 20          	add    r14,0x20
     42d:	4c 39 eb             	cmp    rbx,r13
     430:	74 46                	je     478 <pack_block_avx2+0xc8>
     432:	41 0f b6 75 00       	movzx  esi,BYTE PTR [r13+0x0]
     437:	40 0f b6 d6          	movzx  edx,sil
     43b:	48 89 f0             	mov    rax,rsi
     43e:	41 0f b6 14 14       	movzx  edx,BYTE PTR [r12+rdx*1]
     443:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
     44a:	85 f6                	test   esi,esi
     44c:	74 d4                	je     422 <pack_block_avx2+0x72>
     44e:	48 8b 4c 24 10       	mov    rcx,QWORD PTR [rsp+0x10]
     453:	c4 c1 7e 6f 06       	vmovdqu ymm0,YMMWORD PTR [r14]
     458:	4a 8d 3c 39          	lea    rdi,[rcx+r15*1]
     45c:	81 fe ff 00 00 00    	cmp    esi,0xff
     462:	75 8c                	jne    3f0 <pack_block_avx2+0x40>
     464:	49 83 c5 01          	add    r13,0x1
     468:	c5 fe 7f 07          	vmovdqu YMMWORD PTR [rdi],ymm0
     46c:	49 01 d7             	add    r15,rdx
     46f:	49 83 c6 20          	add    r14,0x20
     473:	4c 39 eb             	cmp    rbx,r13
     476:	75 ba                	jne    432 <pack_block_avx2+0x82>
     478:	c5 f8 77             	vzeroupper
     47b:	48 8d 65 d8          	lea    rsp,[rbp-0x28]
     47f:	4c 89 f8             	mov    rax,r15
     482:	5b                   	pop    rbx
     483:	41 5c                	pop    r12
     485:	41 5d                	pop    r13
     487:	41 5e                	pop    r14
     489:	41 5f                	pop    r15
     48b:	5d                   	pop    rbp
     48c:	c3                   	ret
     48d:	0f 1f 00             	nop    DWORD PTR [rax]
     490:	45 31 ff             	xor    r15d,r15d
     493:	eb e6                	jmp    47b <pack_block_avx2+0xcb>
     495:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     49c:	00 00 00 00 

00000000000004a0 <gzram_avx2_available>:
     4a0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 4a7 <gzram_avx2_available+0x7>
     4a7:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     4ab:	c0 e8 02             	shr    al,0x2
     4ae:	83 e0 01             	and    eax,0x1
     4b1:	c3                   	ret
     4b2:	0f 1f 00             	nop    DWORD PTR [rax]
     4b5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     4bc:	00 00 00 00 

00000000000004c0 <gzram_base_encode_scalar>:
     4c0:	41 8d 40 fb          	lea    eax,[r8-0x5]
     4c4:	83 f8 07             	cmp    eax,0x7
     4c7:	0f 87 c3 00 00 00    	ja     590 <gzram_base_encode_scalar+0xd0>
     4cd:	48 81 fe 00 10 00 00 	cmp    rsi,0x1000
     4d4:	0f 87 b6 00 00 00    	ja     590 <gzram_base_encode_scalar+0xd0>
     4da:	48 85 d2             	test   rdx,rdx
     4dd:	0f 84 ad 00 00 00    	je     590 <gzram_base_encode_scalar+0xd0>
     4e3:	48 85 ff             	test   rdi,rdi
     4e6:	41 0f 94 c1          	sete   r9b
     4ea:	48 85 f6             	test   rsi,rsi
     4ed:	0f 95 c0             	setne  al
     4f0:	41 84 c1             	test   r9b,al
     4f3:	0f 85 97 00 00 00    	jne    590 <gzram_base_encode_scalar+0xd0>
     4f9:	48 83 f9 07          	cmp    rcx,0x7
     4fd:	0f 86 8d 00 00 00    	jbe    590 <gzram_base_encode_scalar+0xd0>
     503:	41 57                	push   r15
     505:	b8 01 00 00 00       	mov    eax,0x1
     50a:	41 56                	push   r14
     50c:	49 89 d6             	mov    r14,rdx
     50f:	48 8d 56 08          	lea    rdx,[rsi+0x8]
     513:	41 55                	push   r13
     515:	45 89 c5             	mov    r13d,r8d
     518:	41 54                	push   r12
     51a:	49 89 fc             	mov    r12,rdi
     51d:	55                   	push   rbp
     51e:	48 89 f5             	mov    rbp,rsi
     521:	53                   	push   rbx
     522:	48 89 cb             	mov    rbx,rcx
     525:	48 81 ec 08 01 00 00 	sub    rsp,0x108
     52c:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
     531:	44 89 c1             	mov    ecx,r8d
     534:	48 d3 e0             	shl    rax,cl
     537:	49 89 c7             	mov    r15,rax
     53a:	48 8d 44 30 ff       	lea    rax,[rax+rsi*1-0x1]
     53f:	48 d3 e8             	shr    rax,cl
     542:	4c 8d 40 08          	lea    r8,[rax+0x8]
     546:	4c 39 c3             	cmp    rbx,r8
     549:	73 55                	jae    5a0 <gzram_base_encode_scalar+0xe0>
     54b:	48 39 d3             	cmp    rbx,rdx
     54e:	72 43                	jb     593 <gzram_base_encode_scalar+0xd3>
     550:	48 85 f6             	test   rsi,rsi
     553:	0f 85 91 04 00 00    	jne    9ea <gzram_base_encode_scalar+0x52a>
     559:	41 c7 06 47 5a 52 31 	mov    DWORD PTR [r14],0x31525a47
     560:	8d 45 08             	lea    eax,[rbp+0x8]
     563:	41 88 6e 04          	mov    BYTE PTR [r14+0x4],bpl
     567:	41 c6 46 05 00       	mov    BYTE PTR [r14+0x5],0x0
     56c:	45 88 6e 06          	mov    BYTE PTR [r14+0x6],r13b
     570:	41 c6 46 07 01       	mov    BYTE PTR [r14+0x7],0x1
     575:	48 81 c4 08 01 00 00 	add    rsp,0x108
     57c:	5b                   	pop    rbx
     57d:	5d                   	pop    rbp
     57e:	41 5c                	pop    r12
     580:	41 5d                	pop    r13
     582:	41 5e                	pop    r14
     584:	41 5f                	pop    r15
     586:	c3                   	ret
     587:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     58e:	00 00 
     590:	31 c0                	xor    eax,eax
     592:	c3                   	ret
     593:	31 c0                	xor    eax,eax
     595:	eb de                	jmp    575 <gzram_base_encode_scalar+0xb5>
     597:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     59e:	00 00 
     5a0:	41 c7 06 47 5a 52 31 	mov    DWORD PTR [r14],0x31525a47
     5a7:	66 41 89 76 04       	mov    WORD PTR [r14+0x4],si
     5ac:	45 88 6e 06          	mov    BYTE PTR [r14+0x6],r13b
     5b0:	41 c6 46 07 00       	mov    BYTE PTR [r14+0x7],0x0
     5b5:	48 85 c0             	test   rax,rax
     5b8:	0f 84 81 07 00 00    	je     d3f <gzram_base_encode_scalar+0x87f>
     5be:	49 8d 7e 08          	lea    rdi,[r14+0x8]
     5c2:	4c 89 74 24 10       	mov    QWORD PTR [rsp+0x10],r14
     5c7:	4d 89 c6             	mov    r14,r8
     5ca:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 5d1 <gzram_base_encode_scalar+0x111>
     5d1:	48 01 f8             	add    rax,rdi
     5d4:	44 89 6c 24 44       	mov    DWORD PTR [rsp+0x44],r13d
     5d9:	49 89 fd             	mov    r13,rdi
     5dc:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
     5e1:	49 8d 04 34          	lea    rax,[r12+rsi*1]
     5e5:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
     5ea:	48 89 54 24 28       	mov    QWORD PTR [rsp+0x28],rdx
     5ef:	48 89 7c 24 48       	mov    QWORD PTR [rsp+0x48],rdi
     5f4:	4c 89 64 24 30       	mov    QWORD PTR [rsp+0x30],r12
     5f9:	48 89 74 24 38       	mov    QWORD PTR [rsp+0x38],rsi
     5fe:	eb 3f                	jmp    63f <gzram_base_encode_scalar+0x17f>
     600:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
     605:	4c 29 f0             	sub    rax,r14
     608:	48 39 e8             	cmp    rax,rbp
     60b:	0f 82 80 02 00 00    	jb     891 <gzram_base_encode_scalar+0x3d1>
     611:	41 c6 45 00 00       	mov    BYTE PTR [r13+0x0],0x0
     616:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
     61b:	48 89 ea             	mov    rdx,rbp
     61e:	4c 89 e6             	mov    rsi,r12
     621:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
     625:	49 01 ee             	add    r14,rbp
     628:	e8 00 00 00 00       	call   62d <gzram_base_encode_scalar+0x16d>
     62d:	4d 01 fc             	add    r12,r15
     630:	49 83 c5 01          	add    r13,0x1
     634:	4c 39 6c 24 18       	cmp    QWORD PTR [rsp+0x18],r13
     639:	0f 84 82 03 00 00    	je     9c1 <gzram_base_encode_scalar+0x501>
     63f:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
     644:	4c 29 e5             	sub    rbp,r12
     647:	4c 39 fd             	cmp    rbp,r15
     64a:	49 0f 47 ef          	cmova  rbp,r15
     64e:	48 89 ee             	mov    rsi,rbp
     651:	83 e6 1f             	and    esi,0x1f
     654:	75 aa                	jne    600 <gzram_base_encode_scalar+0x140>
     656:	4d 8b 04 24          	mov    r8,QWORD PTR [r12]
     65a:	4d 8b 54 24 10       	mov    r10,QWORD PTR [r12+0x10]
     65f:	4d 8b 4c 24 08       	mov    r9,QWORD PTR [r12+0x8]
     664:	4d 8b 5c 24 18       	mov    r11,QWORD PTR [r12+0x18]
     669:	4d 39 d0             	cmp    r8,r10
     66c:	4c 89 44 24 58       	mov    QWORD PTR [rsp+0x58],r8
     671:	4c 89 4c 24 60       	mov    QWORD PTR [rsp+0x60],r9
     676:	0f 94 c0             	sete   al
     679:	4c 89 54 24 68       	mov    QWORD PTR [rsp+0x68],r10
     67e:	4c 89 5c 24 70       	mov    QWORD PTR [rsp+0x70],r11
     683:	4d 39 c8             	cmp    r8,r9
     686:	0f 84 64 02 00 00    	je     8f0 <gzram_base_encode_scalar+0x430>
     68c:	4d 39 d9             	cmp    r9,r11
     68f:	75 08                	jne    699 <gzram_base_encode_scalar+0x1d9>
     691:	84 c0                	test   al,al
     693:	0f 85 11 03 00 00    	jne    9aa <gzram_base_encode_scalar+0x4ea>
     699:	c7 44 24 40 20 00 00 	mov    DWORD PTR [rsp+0x40],0x20
     6a0:	00 
     6a1:	bf 1f 00 00 00       	mov    edi,0x1f
     6a6:	b8 20 00 00 00       	mov    eax,0x20
     6ab:	48 39 e8             	cmp    rax,rbp
     6ae:	0f 83 02 04 00 00    	jae    ab6 <gzram_base_encode_scalar+0x5f6>
     6b4:	48 83 fd 20          	cmp    rbp,0x20
     6b8:	0f 86 ef 03 00 00    	jbe    aad <gzram_base_encode_scalar+0x5ed>
     6be:	4c 89 c2             	mov    rdx,r8
     6c1:	b8 20 00 00 00       	mov    eax,0x20
     6c6:	eb 47                	jmp    70f <gzram_base_encode_scalar+0x24f>
     6c8:	90                   	nop
     6c9:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     6d0:	00 00 00 00 
     6d4:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     6db:	00 00 00 00 
     6df:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     6e6:	00 00 00 00 
     6ea:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     6f1:	00 00 00 00 
     6f5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     6fc:	00 00 00 00 
     700:	48 89 c2             	mov    rdx,rax
     703:	48 21 fa             	and    rdx,rdi
     706:	48 c1 ea 03          	shr    rdx,0x3
     70a:	48 8b 54 d4 58       	mov    rdx,QWORD PTR [rsp+rdx*8+0x58]
     70f:	49 8b 0c 04          	mov    rcx,QWORD PTR [r12+rax*1]
     713:	48 83 c0 08          	add    rax,0x8
     717:	48 39 e8             	cmp    rax,rbp
     71a:	0f 83 e8 00 00 00    	jae    808 <gzram_base_encode_scalar+0x348>
     720:	48 39 d1             	cmp    rcx,rdx
     723:	74 db                	je     700 <gzram_base_encode_scalar+0x240>
     725:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     72c:	00 00 00 00 
     730:	49 89 e9             	mov    r9,rbp
     733:	49 c1 e9 05          	shr    r9,0x5
     737:	49 c1 e1 05          	shl    r9,0x5
     73b:	48 8d 7c 24 78       	lea    rdi,[rsp+0x78]
     740:	4c 89 e0             	mov    rax,r12
     743:	45 31 c0             	xor    r8d,r8d
     746:	4d 01 e1             	add    r9,r12
     749:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     750:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
     753:	44 8b 50 08          	mov    r10d,DWORD PTR [rax+0x8]
     757:	31 d2                	xor    edx,edx
     759:	44 8b 18             	mov    r11d,DWORD PTR [rax]
     75c:	85 c9                	test   ecx,ecx
     75e:	0f 95 c2             	setne  dl
     761:	31 c9                	xor    ecx,ecx
     763:	01 d2                	add    edx,edx
     765:	45 85 d2             	test   r10d,r10d
     768:	44 8b 50 0c          	mov    r10d,DWORD PTR [rax+0xc]
     76c:	0f 95 c1             	setne  cl
     76f:	c1 e1 02             	shl    ecx,0x2
     772:	09 ca                	or     edx,ecx
     774:	31 c9                	xor    ecx,ecx
     776:	45 85 db             	test   r11d,r11d
     779:	44 8b 58 10          	mov    r11d,DWORD PTR [rax+0x10]
     77d:	0f 95 c1             	setne  cl
     780:	09 ca                	or     edx,ecx
     782:	31 c9                	xor    ecx,ecx
     784:	45 85 d2             	test   r10d,r10d
     787:	44 8b 50 14          	mov    r10d,DWORD PTR [rax+0x14]
     78b:	0f 95 c1             	setne  cl
     78e:	c1 e1 03             	shl    ecx,0x3
     791:	09 ca                	or     edx,ecx
     793:	31 c9                	xor    ecx,ecx
     795:	45 85 db             	test   r11d,r11d
     798:	44 8b 58 18          	mov    r11d,DWORD PTR [rax+0x18]
     79c:	0f 95 c1             	setne  cl
     79f:	c1 e1 04             	shl    ecx,0x4
     7a2:	09 d1                	or     ecx,edx
     7a4:	31 d2                	xor    edx,edx
     7a6:	45 85 d2             	test   r10d,r10d
     7a9:	44 8b 50 1c          	mov    r10d,DWORD PTR [rax+0x1c]
     7ad:	0f 95 c2             	setne  dl
     7b0:	c1 e2 05             	shl    edx,0x5
     7b3:	09 ca                	or     edx,ecx
     7b5:	31 c9                	xor    ecx,ecx
     7b7:	45 85 db             	test   r11d,r11d
     7ba:	0f 95 c1             	setne  cl
     7bd:	c1 e1 06             	shl    ecx,0x6
     7c0:	09 d1                	or     ecx,edx
     7c2:	31 d2                	xor    edx,edx
     7c4:	45 85 d2             	test   r10d,r10d
     7c7:	0f 95 c2             	setne  dl
     7ca:	48 83 c0 20          	add    rax,0x20
     7ce:	48 83 c7 01          	add    rdi,0x1
     7d2:	c1 e2 07             	shl    edx,0x7
     7d5:	09 ca                	or     edx,ecx
     7d7:	88 57 ff             	mov    BYTE PTR [rdi-0x1],dl
     7da:	0f b6 14 13          	movzx  edx,BYTE PTR [rbx+rdx*1]
     7de:	41 01 d0             	add    r8d,edx
     7e1:	49 39 c1             	cmp    r9,rax
     7e4:	0f 85 66 ff ff ff    	jne    750 <gzram_base_encode_scalar+0x290>
     7ea:	44 89 84 24 f8 00 00 	mov    DWORD PTR [rsp+0xf8],r8d
     7f1:	00 
     7f2:	45 85 c0             	test   r8d,r8d
     7f5:	75 6e                	jne    865 <gzram_base_encode_scalar+0x3a5>
     7f7:	41 c6 45 00 01       	mov    BYTE PTR [r13+0x0],0x1
     7fc:	e9 2c fe ff ff       	jmp    62d <gzram_base_encode_scalar+0x16d>
     801:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     808:	48 39 d1             	cmp    rcx,rdx
     80b:	0f 85 14 ff ff ff    	jne    725 <gzram_base_encode_scalar+0x265>
     811:	4d 85 c0             	test   r8,r8
     814:	0f 85 06 01 00 00    	jne    920 <gzram_base_encode_scalar+0x460>
     81a:	4d 85 c9             	test   r9,r9
     81d:	75 0a                	jne    829 <gzram_base_encode_scalar+0x369>
     81f:	4d 85 d2             	test   r10,r10
     822:	75 05                	jne    829 <gzram_base_encode_scalar+0x369>
     824:	4d 85 db             	test   r11,r11
     827:	74 ce                	je     7f7 <gzram_base_encode_scalar+0x337>
     829:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     830:	01 00 00 00 
     834:	83 7c 24 40 08       	cmp    DWORD PTR [rsp+0x40],0x8
     839:	0f 84 96 00 00 00    	je     8d5 <gzram_base_encode_scalar+0x415>
     83f:	83 7c 24 40 10       	cmp    DWORD PTR [rsp+0x40],0x10
     844:	0f 84 1a 04 00 00    	je     c64 <gzram_base_encode_scalar+0x7a4>
     84a:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x8
     851:	08 00 00 00 
     855:	48 83 fd 20          	cmp    rbp,0x20
     859:	0f 87 d0 01 00 00    	ja     a2f <gzram_base_encode_scalar+0x56f>
     85f:	41 b8 01 00 00 00    	mov    r8d,0x1
     865:	49 89 ea             	mov    r10,rbp
     868:	48 8b 54 24 20       	mov    rdx,QWORD PTR [rsp+0x20]
     86d:	42 8d 04 85 00 00 00 	lea    eax,[r8*4+0x0]
     874:	00 
     875:	49 c1 ea 05          	shr    r10,0x5
     879:	4c 01 d0             	add    rax,r10
     87c:	4c 29 f2             	sub    rdx,r14
     87f:	48 39 e8             	cmp    rax,rbp
     882:	0f 82 50 02 00 00    	jb     ad8 <gzram_base_encode_scalar+0x618>
     888:	48 39 ea             	cmp    rdx,rbp
     88b:	0f 83 80 fd ff ff    	jae    611 <gzram_base_encode_scalar+0x151>
     891:	48 8b 54 24 28       	mov    rdx,QWORD PTR [rsp+0x28]
     896:	48 8b 7c 24 48       	mov    rdi,QWORD PTR [rsp+0x48]
     89b:	31 c0                	xor    eax,eax
     89d:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     8a2:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     8a7:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
     8ac:	44 8b 6c 24 44       	mov    r13d,DWORD PTR [rsp+0x44]
     8b1:	48 39 54 24 20       	cmp    QWORD PTR [rsp+0x20],rdx
     8b6:	0f 82 b9 fc ff ff    	jb     575 <gzram_base_encode_scalar+0xb5>
     8bc:	48 85 ed             	test   rbp,rbp
     8bf:	0f 84 4d 01 00 00    	je     a12 <gzram_base_encode_scalar+0x552>
     8c5:	48 89 ea             	mov    rdx,rbp
     8c8:	4c 89 e6             	mov    rsi,r12
     8cb:	e8 00 00 00 00       	call   8d0 <gzram_base_encode_scalar+0x410>
     8d0:	e9 3d 01 00 00       	jmp    a12 <gzram_base_encode_scalar+0x552>
     8d5:	48 83 fd 04          	cmp    rbp,0x4
     8d9:	0f 86 32 fd ff ff    	jbe    611 <gzram_base_encode_scalar+0x151>
     8df:	ba 02 00 00 00       	mov    edx,0x2
     8e4:	b8 04 00 00 00       	mov    eax,0x4
     8e9:	eb 6b                	jmp    956 <gzram_base_encode_scalar+0x496>
     8eb:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     8f0:	4d 39 d8             	cmp    r8,r11
     8f3:	0f 85 a0 fd ff ff    	jne    699 <gzram_base_encode_scalar+0x1d9>
     8f9:	84 c0                	test   al,al
     8fb:	0f 84 98 fd ff ff    	je     699 <gzram_base_encode_scalar+0x1d9>
     901:	c7 44 24 40 08 00 00 	mov    DWORD PTR [rsp+0x40],0x8
     908:	00 
     909:	bf 07 00 00 00       	mov    edi,0x7
     90e:	b8 08 00 00 00       	mov    eax,0x8
     913:	e9 93 fd ff ff       	jmp    6ab <gzram_base_encode_scalar+0x1eb>
     918:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     91f:	00 
     920:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     927:	01 00 00 00 
     92b:	83 7c 24 40 08       	cmp    DWORD PTR [rsp+0x40],0x8
     930:	0f 85 09 ff ff ff    	jne    83f <gzram_base_encode_scalar+0x37f>
     936:	4c 89 c0             	mov    rax,r8
     939:	48 c1 e8 20          	shr    rax,0x20
     93d:	41 39 c0             	cmp    r8d,eax
     940:	74 93                	je     8d5 <gzram_base_encode_scalar+0x415>
     942:	48 83 fd 08          	cmp    rbp,0x8
     946:	0f 86 c5 fc ff ff    	jbe    611 <gzram_base_encode_scalar+0x151>
     94c:	ba 03 00 00 00       	mov    edx,0x3
     951:	b8 08 00 00 00       	mov    eax,0x8
     956:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
     95b:	4c 29 f1             	sub    rcx,r14
     95e:	48 39 c1             	cmp    rcx,rax
     961:	0f 82 2a ff ff ff    	jb     891 <gzram_base_encode_scalar+0x3d1>
     967:	48 8b 74 24 10       	mov    rsi,QWORD PTR [rsp+0x10]
     96c:	41 88 55 00          	mov    BYTE PTR [r13+0x0],dl
     970:	89 c2                	mov    edx,eax
     972:	4a 8d 0c 36          	lea    rcx,[rsi+r14*1]
     976:	83 f8 20             	cmp    eax,0x20
     979:	0f 83 c1 00 00 00    	jae    a40 <gzram_base_encode_scalar+0x580>
     97f:	a8 10                	test   al,0x10
     981:	0f 85 f6 02 00 00    	jne    c7d <gzram_base_encode_scalar+0x7bd>
     987:	a8 08                	test   al,0x8
     989:	0f 85 1d 03 00 00    	jne    cac <gzram_base_encode_scalar+0x7ec>
     98f:	a8 04                	test   al,0x4
     991:	0f 85 2b 03 00 00    	jne    cc2 <gzram_base_encode_scalar+0x802>
     997:	85 c0                	test   eax,eax
     999:	74 07                	je     9a2 <gzram_base_encode_scalar+0x4e2>
     99b:	41 0f b6 14 24       	movzx  edx,BYTE PTR [r12]
     9a0:	88 11                	mov    BYTE PTR [rcx],dl
     9a2:	49 01 c6             	add    r14,rax
     9a5:	e9 83 fc ff ff       	jmp    62d <gzram_base_encode_scalar+0x16d>
     9aa:	c7 44 24 40 10 00 00 	mov    DWORD PTR [rsp+0x40],0x10
     9b1:	00 
     9b2:	bf 0f 00 00 00       	mov    edi,0xf
     9b7:	b8 10 00 00 00       	mov    eax,0x10
     9bc:	e9 ea fc ff ff       	jmp    6ab <gzram_base_encode_scalar+0x1eb>
     9c1:	48 8b 54 24 28       	mov    rdx,QWORD PTR [rsp+0x28]
     9c6:	4d 89 f0             	mov    r8,r14
     9c9:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     9ce:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     9d3:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
     9d8:	44 8b 6c 24 44       	mov    r13d,DWORD PTR [rsp+0x44]
     9dd:	49 39 d0             	cmp    r8,rdx
     9e0:	73 1c                	jae    9fe <gzram_base_encode_scalar+0x53e>
     9e2:	44 89 c0             	mov    eax,r8d
     9e5:	e9 8b fb ff ff       	jmp    575 <gzram_base_encode_scalar+0xb5>
     9ea:	48 89 f2             	mov    rdx,rsi
     9ed:	49 8d 7e 08          	lea    rdi,[r14+0x8]
     9f1:	4c 89 e6             	mov    rsi,r12
     9f4:	e8 00 00 00 00       	call   9f9 <gzram_base_encode_scalar+0x539>
     9f9:	e9 5b fb ff ff       	jmp    559 <gzram_base_encode_scalar+0x99>
     9fe:	48 39 54 24 20       	cmp    QWORD PTR [rsp+0x20],rdx
     a03:	0f 82 8a fb ff ff    	jb     593 <gzram_base_encode_scalar+0xd3>
     a09:	48 85 ed             	test   rbp,rbp
     a0c:	0f 85 42 03 00 00    	jne    d54 <gzram_base_encode_scalar+0x894>
     a12:	41 c7 06 47 5a 52 31 	mov    DWORD PTR [r14],0x31525a47
     a19:	8d 45 08             	lea    eax,[rbp+0x8]
     a1c:	66 41 89 6e 04       	mov    WORD PTR [r14+0x4],bp
     a21:	45 88 6e 06          	mov    BYTE PTR [r14+0x6],r13b
     a25:	41 c6 46 07 01       	mov    BYTE PTR [r14+0x7],0x1
     a2a:	e9 46 fb ff ff       	jmp    575 <gzram_base_encode_scalar+0xb5>
     a2f:	ba 06 00 00 00       	mov    edx,0x6
     a34:	b8 20 00 00 00       	mov    eax,0x20
     a39:	e9 18 ff ff ff       	jmp    956 <gzram_base_encode_scalar+0x496>
     a3e:	66 90                	xchg   ax,ax
     a40:	49 8d 34 04          	lea    rsi,[r12+rax*1]
     a44:	8d 50 ff             	lea    edx,[rax-0x1]
     a47:	48 8b 7e e0          	mov    rdi,QWORD PTR [rsi-0x20]
     a4b:	48 89 7c 08 e0       	mov    QWORD PTR [rax+rcx*1-0x20],rdi
     a50:	48 8b 7e e8          	mov    rdi,QWORD PTR [rsi-0x18]
     a54:	48 89 7c 08 e8       	mov    QWORD PTR [rax+rcx*1-0x18],rdi
     a59:	48 8b 7e f0          	mov    rdi,QWORD PTR [rsi-0x10]
     a5d:	48 89 7c 08 f0       	mov    QWORD PTR [rax+rcx*1-0x10],rdi
     a62:	48 8b 76 f8          	mov    rsi,QWORD PTR [rsi-0x8]
     a66:	48 89 74 08 f8       	mov    QWORD PTR [rax+rcx*1-0x8],rsi
     a6b:	83 fa 20             	cmp    edx,0x20
     a6e:	0f 82 2e ff ff ff    	jb     9a2 <gzram_base_encode_scalar+0x4e2>
     a74:	83 e2 e0             	and    edx,0xffffffe0
     a77:	31 ff                	xor    edi,edi
     a79:	89 fe                	mov    esi,edi
     a7b:	83 c7 20             	add    edi,0x20
     a7e:	4d 8b 1c 34          	mov    r11,QWORD PTR [r12+rsi*1]
     a82:	4d 8b 54 34 08       	mov    r10,QWORD PTR [r12+rsi*1+0x8]
     a87:	4d 8b 4c 34 10       	mov    r9,QWORD PTR [r12+rsi*1+0x10]
     a8c:	4d 8b 44 34 18       	mov    r8,QWORD PTR [r12+rsi*1+0x18]
     a91:	4c 89 1c 31          	mov    QWORD PTR [rcx+rsi*1],r11
     a95:	4c 89 54 31 08       	mov    QWORD PTR [rcx+rsi*1+0x8],r10
     a9a:	4c 89 4c 31 10       	mov    QWORD PTR [rcx+rsi*1+0x10],r9
     a9f:	4c 89 44 31 18       	mov    QWORD PTR [rcx+rsi*1+0x18],r8
     aa4:	39 d7                	cmp    edi,edx
     aa6:	72 d1                	jb     a79 <gzram_base_encode_scalar+0x5b9>
     aa8:	e9 f5 fe ff ff       	jmp    9a2 <gzram_base_encode_scalar+0x4e2>
     aad:	48 39 e8             	cmp    rax,rbp
     ab0:	0f 82 5b fd ff ff    	jb     811 <gzram_base_encode_scalar+0x351>
     ab6:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     abd:	00 00 00 00 
     ac1:	49 89 e9             	mov    r9,rbp
     ac4:	49 c1 e9 05          	shr    r9,0x5
     ac8:	0f 84 29 fd ff ff    	je     7f7 <gzram_base_encode_scalar+0x337>
     ace:	e9 64 fc ff ff       	jmp    737 <gzram_base_encode_scalar+0x277>
     ad3:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     ad8:	48 39 c2             	cmp    rdx,rax
     adb:	0f 82 b0 fd ff ff    	jb     891 <gzram_base_encode_scalar+0x3d1>
     ae1:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
     ae6:	41 c6 45 00 04       	mov    BYTE PTR [r13+0x0],0x4
     aeb:	4c 01 f0             	add    rax,r14
     aee:	41 83 fa 20          	cmp    r10d,0x20
     af2:	0f 83 f0 00 00 00    	jae    be8 <gzram_base_encode_scalar+0x728>
     af8:	41 f6 c2 10          	test   r10b,0x10
     afc:	0f 85 d4 01 00 00    	jne    cd6 <gzram_base_encode_scalar+0x816>
     b02:	41 f6 c2 08          	test   r10b,0x8
     b06:	0f 85 03 02 00 00    	jne    d0f <gzram_base_encode_scalar+0x84f>
     b0c:	41 f6 c2 04          	test   r10b,0x4
     b10:	0f 85 13 02 00 00    	jne    d29 <gzram_base_encode_scalar+0x869>
     b16:	45 85 d2             	test   r10d,r10d
     b19:	74 11                	je     b2c <gzram_base_encode_scalar+0x66c>
     b1b:	0f b6 54 24 78       	movzx  edx,BYTE PTR [rsp+0x78]
     b20:	88 10                	mov    BYTE PTR [rax],dl
     b22:	41 f6 c2 02          	test   r10b,0x2
     b26:	0f 85 31 02 00 00    	jne    d5d <gzram_base_encode_scalar+0x89d>
     b2c:	4d 01 d6             	add    r14,r10
     b2f:	4d 85 d2             	test   r10,r10
     b32:	0f 84 f5 fa ff ff    	je     62d <gzram_base_encode_scalar+0x16d>
     b38:	49 c1 e2 05          	shl    r10,0x5
     b3c:	4c 8b 5c 24 10       	mov    r11,QWORD PTR [rsp+0x10]
     b41:	4c 8d 4c 24 78       	lea    r9,[rsp+0x78]
     b46:	4d 89 e0             	mov    r8,r12
     b49:	4d 01 e2             	add    r10,r12
     b4c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     b50:	41 0f b6 09          	movzx  ecx,BYTE PTR [r9]
     b54:	49 8d 14 36          	lea    rdx,[r14+rsi*1]
     b58:	4c 01 da             	add    rdx,r11
     b5b:	81 f9 ff 00 00 00    	cmp    ecx,0xff
     b61:	74 65                	je     bc8 <gzram_base_encode_scalar+0x708>
     b63:	89 c8                	mov    eax,ecx
     b65:	85 c9                	test   ecx,ecx
     b67:	74 36                	je     b9f <gzram_base_encode_scalar+0x6df>
     b69:	90                   	nop
     b6a:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     b71:	00 00 00 00 
     b75:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     b7c:	00 00 00 00 
     b80:	31 ed                	xor    ebp,ebp
     b82:	8d 78 ff             	lea    edi,[rax-0x1]
     b85:	48 83 c2 04          	add    rdx,0x4
     b89:	f3 0f bc e8          	tzcnt  ebp,eax
     b8d:	8d 2c ad 00 00 00 00 	lea    ebp,[rbp*4+0x0]
     b94:	41 8b 2c 28          	mov    ebp,DWORD PTR [r8+rbp*1]
     b98:	89 6a fc             	mov    DWORD PTR [rdx-0x4],ebp
     b9b:	21 f8                	and    eax,edi
     b9d:	75 e1                	jne    b80 <gzram_base_encode_scalar+0x6c0>
     b9f:	0f b6 04 0b          	movzx  eax,BYTE PTR [rbx+rcx*1]
     ba3:	49 83 c0 20          	add    r8,0x20
     ba7:	49 83 c1 01          	add    r9,0x1
     bab:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
     bb2:	48 01 c6             	add    rsi,rax
     bb5:	4d 39 d0             	cmp    r8,r10
     bb8:	75 96                	jne    b50 <gzram_base_encode_scalar+0x690>
     bba:	49 01 f6             	add    r14,rsi
     bbd:	e9 6b fa ff ff       	jmp    62d <gzram_base_encode_scalar+0x16d>
     bc2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     bc8:	49 8b 00             	mov    rax,QWORD PTR [r8]
     bcb:	48 89 02             	mov    QWORD PTR [rdx],rax
     bce:	49 8b 40 08          	mov    rax,QWORD PTR [r8+0x8]
     bd2:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
     bd6:	49 8b 40 10          	mov    rax,QWORD PTR [r8+0x10]
     bda:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
     bde:	49 8b 40 18          	mov    rax,QWORD PTR [r8+0x18]
     be2:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
     be6:	eb b7                	jmp    b9f <gzram_base_encode_scalar+0x6df>
     be8:	44 89 d1             	mov    ecx,r10d
     beb:	48 8d 14 08          	lea    rdx,[rax+rcx*1]
     bef:	48 8d 4c 0c 78       	lea    rcx,[rsp+rcx*1+0x78]
     bf4:	48 8b 79 e0          	mov    rdi,QWORD PTR [rcx-0x20]
     bf8:	48 89 7a e0          	mov    QWORD PTR [rdx-0x20],rdi
     bfc:	48 8b 79 e8          	mov    rdi,QWORD PTR [rcx-0x18]
     c00:	48 89 7a e8          	mov    QWORD PTR [rdx-0x18],rdi
     c04:	48 8b 79 f0          	mov    rdi,QWORD PTR [rcx-0x10]
     c08:	48 89 7a f0          	mov    QWORD PTR [rdx-0x10],rdi
     c0c:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
     c10:	48 89 4a f8          	mov    QWORD PTR [rdx-0x8],rcx
     c14:	41 8d 4a ff          	lea    ecx,[r10-0x1]
     c18:	83 f9 20             	cmp    ecx,0x20
     c1b:	0f 82 0b ff ff ff    	jb     b2c <gzram_base_encode_scalar+0x66c>
     c21:	83 e1 e0             	and    ecx,0xffffffe0
     c24:	31 ff                	xor    edi,edi
     c26:	89 fa                	mov    edx,edi
     c28:	83 c7 20             	add    edi,0x20
     c2b:	48 8b 6c 14 78       	mov    rbp,QWORD PTR [rsp+rdx*1+0x78]
     c30:	4c 8b 9c 14 80 00 00 	mov    r11,QWORD PTR [rsp+rdx*1+0x80]
     c37:	00 
     c38:	4c 8b 8c 14 88 00 00 	mov    r9,QWORD PTR [rsp+rdx*1+0x88]
     c3f:	00 
     c40:	4c 8b 84 14 90 00 00 	mov    r8,QWORD PTR [rsp+rdx*1+0x90]
     c47:	00 
     c48:	48 89 2c 10          	mov    QWORD PTR [rax+rdx*1],rbp
     c4c:	4c 89 5c 10 08       	mov    QWORD PTR [rax+rdx*1+0x8],r11
     c51:	4c 89 4c 10 10       	mov    QWORD PTR [rax+rdx*1+0x10],r9
     c56:	4c 89 44 10 18       	mov    QWORD PTR [rax+rdx*1+0x18],r8
     c5b:	39 cf                	cmp    edi,ecx
     c5d:	72 c7                	jb     c26 <gzram_base_encode_scalar+0x766>
     c5f:	e9 c8 fe ff ff       	jmp    b2c <gzram_base_encode_scalar+0x66c>
     c64:	48 83 fd 10          	cmp    rbp,0x10
     c68:	0f 86 a3 f9 ff ff    	jbe    611 <gzram_base_encode_scalar+0x151>
     c6e:	ba 05 00 00 00       	mov    edx,0x5
     c73:	b8 10 00 00 00       	mov    eax,0x10
     c78:	e9 d9 fc ff ff       	jmp    956 <gzram_base_encode_scalar+0x496>
     c7d:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     c81:	48 89 31             	mov    QWORD PTR [rcx],rsi
     c84:	49 8b 74 24 08       	mov    rsi,QWORD PTR [r12+0x8]
     c89:	48 89 71 08          	mov    QWORD PTR [rcx+0x8],rsi
     c8d:	48 8d 4c 11 10       	lea    rcx,[rcx+rdx*1+0x10]
     c92:	49 8d 54 14 10       	lea    rdx,[r12+rdx*1+0x10]
     c97:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
     c9b:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
     c9f:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     ca3:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
     ca7:	e9 f6 fc ff ff       	jmp    9a2 <gzram_base_encode_scalar+0x4e2>
     cac:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     cb0:	48 89 31             	mov    QWORD PTR [rcx],rsi
     cb3:	49 8b 74 14 f8       	mov    rsi,QWORD PTR [r12+rdx*1-0x8]
     cb8:	48 89 74 11 f8       	mov    QWORD PTR [rcx+rdx*1-0x8],rsi
     cbd:	e9 e0 fc ff ff       	jmp    9a2 <gzram_base_encode_scalar+0x4e2>
     cc2:	41 8b 34 24          	mov    esi,DWORD PTR [r12]
     cc6:	89 31                	mov    DWORD PTR [rcx],esi
     cc8:	41 8b 74 14 fc       	mov    esi,DWORD PTR [r12+rdx*1-0x4]
     ccd:	89 74 11 fc          	mov    DWORD PTR [rcx+rdx*1-0x4],esi
     cd1:	e9 cc fc ff ff       	jmp    9a2 <gzram_base_encode_scalar+0x4e2>
     cd6:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     cdb:	48 89 10             	mov    QWORD PTR [rax],rdx
     cde:	48 8b 94 24 80 00 00 	mov    rdx,QWORD PTR [rsp+0x80]
     ce5:	00 
     ce6:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     cea:	44 89 d2             	mov    edx,r10d
     ced:	48 8d 44 10 10       	lea    rax,[rax+rdx*1+0x10]
     cf2:	48 8d 94 14 88 00 00 	lea    rdx,[rsp+rdx*1+0x88]
     cf9:	00 
     cfa:	48 8b 4a e0          	mov    rcx,QWORD PTR [rdx-0x20]
     cfe:	48 89 48 e0          	mov    QWORD PTR [rax-0x20],rcx
     d02:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     d06:	48 89 50 e8          	mov    QWORD PTR [rax-0x18],rdx
     d0a:	e9 1d fe ff ff       	jmp    b2c <gzram_base_encode_scalar+0x66c>
     d0f:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     d14:	48 89 10             	mov    QWORD PTR [rax],rdx
     d17:	44 89 d2             	mov    edx,r10d
     d1a:	48 8b 4c 14 70       	mov    rcx,QWORD PTR [rsp+rdx*1+0x70]
     d1f:	48 89 4c 10 f8       	mov    QWORD PTR [rax+rdx*1-0x8],rcx
     d24:	e9 03 fe ff ff       	jmp    b2c <gzram_base_encode_scalar+0x66c>
     d29:	8b 54 24 78          	mov    edx,DWORD PTR [rsp+0x78]
     d2d:	89 10                	mov    DWORD PTR [rax],edx
     d2f:	44 89 d2             	mov    edx,r10d
     d32:	8b 4c 14 74          	mov    ecx,DWORD PTR [rsp+rdx*1+0x74]
     d36:	89 4c 10 fc          	mov    DWORD PTR [rax+rdx*1-0x4],ecx
     d3a:	e9 ed fd ff ff       	jmp    b2c <gzram_base_encode_scalar+0x66c>
     d3f:	41 b8 08 00 00 00    	mov    r8d,0x8
     d45:	48 83 fa 08          	cmp    rdx,0x8
     d49:	0f 85 93 fc ff ff    	jne    9e2 <gzram_base_encode_scalar+0x522>
     d4f:	e9 b5 fc ff ff       	jmp    a09 <gzram_base_encode_scalar+0x549>
     d54:	49 8d 7e 08          	lea    rdi,[r14+0x8]
     d58:	e9 68 fb ff ff       	jmp    8c5 <gzram_base_encode_scalar+0x405>
     d5d:	44 89 d2             	mov    edx,r10d
     d60:	0f b7 4c 14 76       	movzx  ecx,WORD PTR [rsp+rdx*1+0x76]
     d65:	66 89 4c 10 fe       	mov    WORD PTR [rax+rdx*1-0x2],cx
     d6a:	e9 bd fd ff ff       	jmp    b2c <gzram_base_encode_scalar+0x66c>
     d6f:	90                   	nop

0000000000000d70 <gzram_base_encode_avx2>:
     d70:	48 81 ec 18 01 00 00 	sub    rsp,0x118
     d77:	48 89 9c 24 e8 00 00 	mov    QWORD PTR [rsp+0xe8],rbx
     d7e:	00 
     d7f:	48 89 d3             	mov    rbx,rdx
     d82:	48 89 ac 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rbp
     d89:	00 
     d8a:	48 89 f5             	mov    rbp,rsi
     d8d:	4c 89 a4 24 f8 00 00 	mov    QWORD PTR [rsp+0xf8],r12
     d94:	00 
     d95:	45 89 c4             	mov    r12d,r8d
     d98:	4c 89 ac 24 00 01 00 	mov    QWORD PTR [rsp+0x100],r13
     d9f:	00 
     da0:	49 89 cd             	mov    r13,rcx
     da3:	4c 89 bc 24 10 01 00 	mov    QWORD PTR [rsp+0x110],r15
     daa:	00 
     dab:	49 89 ff             	mov    r15,rdi
     dae:	e8 00 00 00 00       	call   db3 <gzram_base_encode_avx2+0x43>
     db3:	85 c0                	test   eax,eax
     db5:	0f 84 a5 00 00 00    	je     e60 <gzram_base_encode_avx2+0xf0>
     dbb:	41 8d 44 24 fb       	lea    eax,[r12-0x5]
     dc0:	83 f8 07             	cmp    eax,0x7
     dc3:	0f 87 e7 00 00 00    	ja     eb0 <gzram_base_encode_avx2+0x140>
     dc9:	48 81 fd 00 10 00 00 	cmp    rbp,0x1000
     dd0:	0f 87 da 00 00 00    	ja     eb0 <gzram_base_encode_avx2+0x140>
     dd6:	48 85 db             	test   rbx,rbx
     dd9:	0f 84 d1 00 00 00    	je     eb0 <gzram_base_encode_avx2+0x140>
     ddf:	4d 85 ff             	test   r15,r15
     de2:	0f 94 c2             	sete   dl
     de5:	48 85 ed             	test   rbp,rbp
     de8:	0f 95 c0             	setne  al
     deb:	84 c2                	test   dl,al
     ded:	0f 85 bd 00 00 00    	jne    eb0 <gzram_base_encode_avx2+0x140>
     df3:	49 83 fd 07          	cmp    r13,0x7
     df7:	0f 86 b3 00 00 00    	jbe    eb0 <gzram_base_encode_avx2+0x140>
     dfd:	44 89 e1             	mov    ecx,r12d
     e00:	b8 01 00 00 00       	mov    eax,0x1
     e05:	4c 89 b4 24 08 01 00 	mov    QWORD PTR [rsp+0x108],r14
     e0c:	00 
     e0d:	48 8d 75 08          	lea    rsi,[rbp+0x8]
     e11:	48 d3 e0             	shl    rax,cl
     e14:	49 89 c6             	mov    r14,rax
     e17:	48 8d 44 28 ff       	lea    rax,[rax+rbp*1-0x1]
     e1c:	48 d3 e8             	shr    rax,cl
     e1f:	4c 8d 40 08          	lea    r8,[rax+0x8]
     e23:	4d 39 c5             	cmp    r13,r8
     e26:	0f 83 bc 00 00 00    	jae    ee8 <gzram_base_encode_avx2+0x178>
     e2c:	49 39 f5             	cmp    r13,rsi
     e2f:	72 72                	jb     ea3 <gzram_base_encode_avx2+0x133>
     e31:	48 85 ed             	test   rbp,rbp
     e34:	0f 85 39 03 00 00    	jne    1173 <gzram_base_encode_avx2+0x403>
     e3a:	c7 03 47 5a 52 31    	mov    DWORD PTR [rbx],0x31525a47
     e40:	8d 45 08             	lea    eax,[rbp+0x8]
     e43:	40 88 6b 04          	mov    BYTE PTR [rbx+0x4],bpl
     e47:	c6 43 05 00          	mov    BYTE PTR [rbx+0x5],0x0
     e4b:	44 88 63 06          	mov    BYTE PTR [rbx+0x6],r12b
     e4f:	c6 43 07 01          	mov    BYTE PTR [rbx+0x7],0x1
     e53:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
     e5a:	00 
     e5b:	eb 55                	jmp    eb2 <gzram_base_encode_avx2+0x142>
     e5d:	0f 1f 00             	nop    DWORD PTR [rax]
     e60:	45 89 e0             	mov    r8d,r12d
     e63:	4c 89 e9             	mov    rcx,r13
     e66:	48 89 da             	mov    rdx,rbx
     e69:	48 89 ee             	mov    rsi,rbp
     e6c:	48 8b 9c 24 e8 00 00 	mov    rbx,QWORD PTR [rsp+0xe8]
     e73:	00 
     e74:	48 8b ac 24 f0 00 00 	mov    rbp,QWORD PTR [rsp+0xf0]
     e7b:	00 
     e7c:	4c 89 ff             	mov    rdi,r15
     e7f:	4c 8b a4 24 f8 00 00 	mov    r12,QWORD PTR [rsp+0xf8]
     e86:	00 
     e87:	4c 8b ac 24 00 01 00 	mov    r13,QWORD PTR [rsp+0x100]
     e8e:	00 
     e8f:	4c 8b bc 24 10 01 00 	mov    r15,QWORD PTR [rsp+0x110]
     e96:	00 
     e97:	48 81 c4 18 01 00 00 	add    rsp,0x118
     e9e:	e9 00 00 00 00       	jmp    ea3 <gzram_base_encode_avx2+0x133>
     ea3:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
     eaa:	00 
     eab:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     eb0:	31 c0                	xor    eax,eax
     eb2:	48 8b 9c 24 e8 00 00 	mov    rbx,QWORD PTR [rsp+0xe8]
     eb9:	00 
     eba:	48 8b ac 24 f0 00 00 	mov    rbp,QWORD PTR [rsp+0xf0]
     ec1:	00 
     ec2:	4c 8b a4 24 f8 00 00 	mov    r12,QWORD PTR [rsp+0xf8]
     ec9:	00 
     eca:	4c 8b ac 24 00 01 00 	mov    r13,QWORD PTR [rsp+0x100]
     ed1:	00 
     ed2:	4c 8b bc 24 10 01 00 	mov    r15,QWORD PTR [rsp+0x110]
     ed9:	00 
     eda:	48 81 c4 18 01 00 00 	add    rsp,0x118
     ee1:	c3                   	ret
     ee2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     ee8:	c7 03 47 5a 52 31    	mov    DWORD PTR [rbx],0x31525a47
     eee:	66 89 6b 04          	mov    WORD PTR [rbx+0x4],bp
     ef2:	44 88 63 06          	mov    BYTE PTR [rbx+0x6],r12b
     ef6:	c6 43 07 00          	mov    BYTE PTR [rbx+0x7],0x0
     efa:	48 85 c0             	test   rax,rax
     efd:	0f 84 43 05 00 00    	je     1446 <gzram_base_encode_avx2+0x6d6>
     f03:	4c 8d 5b 08          	lea    r11,[rbx+0x8]
     f07:	48 89 6c 24 30       	mov    QWORD PTR [rsp+0x30],rbp
     f0c:	4c 01 d8             	add    rax,r11
     f0f:	4c 89 6c 24 18       	mov    QWORD PTR [rsp+0x18],r13
     f14:	4d 89 c5             	mov    r13,r8
     f17:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
     f1c:	49 8d 04 2f          	lea    rax,[r15+rbp*1]
     f20:	4c 89 fd             	mov    rbp,r15
     f23:	44 89 64 24 3c       	mov    DWORD PTR [rsp+0x3c],r12d
     f28:	4d 89 dc             	mov    r12,r11
     f2b:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
     f30:	48 89 74 24 20       	mov    QWORD PTR [rsp+0x20],rsi
     f35:	4c 89 5c 24 40       	mov    QWORD PTR [rsp+0x40],r11
     f3a:	4c 89 7c 24 28       	mov    QWORD PTR [rsp+0x28],r15
     f3f:	eb 41                	jmp    f82 <gzram_base_encode_avx2+0x212>
     f41:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     f48:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
     f4d:	4c 29 e8             	sub    rax,r13
     f50:	4c 39 c0             	cmp    rax,r8
     f53:	0f 82 a8 01 00 00    	jb     1101 <gzram_base_encode_avx2+0x391>
     f59:	41 c6 04 24 00       	mov    BYTE PTR [r12],0x0
     f5e:	4a 8d 3c 2b          	lea    rdi,[rbx+r13*1]
     f62:	4c 89 fa             	mov    rdx,r15
     f65:	48 89 ee             	mov    rsi,rbp
     f68:	4d 01 fd             	add    r13,r15
     f6b:	e8 00 00 00 00       	call   f70 <gzram_base_encode_avx2+0x200>
     f70:	4c 01 f5             	add    rbp,r14
     f73:	49 83 c4 01          	add    r12,0x1
     f77:	4c 39 64 24 10       	cmp    QWORD PTR [rsp+0x10],r12
     f7c:	0f 84 46 01 00 00    	je     10c8 <gzram_base_encode_avx2+0x358>
     f82:	4c 8b 44 24 08       	mov    r8,QWORD PTR [rsp+0x8]
     f87:	49 29 e8             	sub    r8,rbp
     f8a:	4d 39 f0             	cmp    r8,r14
     f8d:	4d 0f 47 c6          	cmova  r8,r14
     f91:	4d 89 c2             	mov    r10,r8
     f94:	4d 89 c7             	mov    r15,r8
     f97:	41 83 e2 1f          	and    r10d,0x1f
     f9b:	75 ab                	jne    f48 <gzram_base_encode_avx2+0x1d8>
     f9d:	48 8d 54 24 58       	lea    rdx,[rsp+0x58]
     fa2:	4c 89 c6             	mov    rsi,r8
     fa5:	48 89 ef             	mov    rdi,rbp
     fa8:	e8 03 f2 ff ff       	call   1b0 <scan_avx2>
     fad:	8b 84 24 d8 00 00 00 	mov    eax,DWORD PTR [rsp+0xd8]
     fb4:	85 c0                	test   eax,eax
     fb6:	75 08                	jne    fc0 <gzram_base_encode_avx2+0x250>
     fb8:	41 c6 04 24 01       	mov    BYTE PTR [r12],0x1
     fbd:	eb b1                	jmp    f70 <gzram_base_encode_avx2+0x200>
     fbf:	90                   	nop
     fc0:	8b 94 24 dc 00 00 00 	mov    edx,DWORD PTR [rsp+0xdc]
     fc7:	f6 c2 01             	test   dl,0x1
     fca:	0f 84 d0 00 00 00    	je     10a0 <gzram_base_encode_avx2+0x330>
     fd0:	49 83 ff 04          	cmp    r15,0x4
     fd4:	76 83                	jbe    f59 <gzram_base_encode_avx2+0x1e9>
     fd6:	ba 02 00 00 00       	mov    edx,0x2
     fdb:	b8 04 00 00 00       	mov    eax,0x4
     fe0:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
     fe5:	4c 29 e9             	sub    rcx,r13
     fe8:	48 39 c1             	cmp    rcx,rax
     feb:	0f 82 10 01 00 00    	jb     1101 <gzram_base_encode_avx2+0x391>
     ff1:	41 88 14 24          	mov    BYTE PTR [r12],dl
     ff5:	4a 8d 34 2b          	lea    rsi,[rbx+r13*1]
     ff9:	89 c2                	mov    edx,eax
     ffb:	83 f8 20             	cmp    eax,0x20
     ffe:	73 30                	jae    1030 <gzram_base_encode_avx2+0x2c0>
    1000:	a8 10                	test   al,0x10
    1002:	0f 85 7d 03 00 00    	jne    1385 <gzram_base_encode_avx2+0x615>
    1008:	a8 08                	test   al,0x8
    100a:	0f 85 a3 03 00 00    	jne    13b3 <gzram_base_encode_avx2+0x643>
    1010:	a8 04                	test   al,0x4
    1012:	0f 85 b1 03 00 00    	jne    13c9 <gzram_base_encode_avx2+0x659>
    1018:	85 c0                	test   eax,eax
    101a:	74 06                	je     1022 <gzram_base_encode_avx2+0x2b2>
    101c:	0f b6 55 00          	movzx  edx,BYTE PTR [rbp+0x0]
    1020:	88 16                	mov    BYTE PTR [rsi],dl
    1022:	49 01 c5             	add    r13,rax
    1025:	e9 46 ff ff ff       	jmp    f70 <gzram_base_encode_avx2+0x200>
    102a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1030:	48 8d 4c 05 00       	lea    rcx,[rbp+rax*1+0x0]
    1035:	8d 50 ff             	lea    edx,[rax-0x1]
    1038:	48 8b 79 e0          	mov    rdi,QWORD PTR [rcx-0x20]
    103c:	48 89 7c 30 e0       	mov    QWORD PTR [rax+rsi*1-0x20],rdi
    1041:	48 8b 79 e8          	mov    rdi,QWORD PTR [rcx-0x18]
    1045:	48 89 7c 30 e8       	mov    QWORD PTR [rax+rsi*1-0x18],rdi
    104a:	48 8b 79 f0          	mov    rdi,QWORD PTR [rcx-0x10]
    104e:	48 89 7c 30 f0       	mov    QWORD PTR [rax+rsi*1-0x10],rdi
    1053:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
    1057:	48 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],rcx
    105c:	83 fa 20             	cmp    edx,0x20
    105f:	72 c1                	jb     1022 <gzram_base_encode_avx2+0x2b2>
    1061:	83 e2 e0             	and    edx,0xffffffe0
    1064:	31 ff                	xor    edi,edi
    1066:	89 f9                	mov    ecx,edi
    1068:	83 c7 20             	add    edi,0x20
    106b:	4c 8b 5c 0d 00       	mov    r11,QWORD PTR [rbp+rcx*1+0x0]
    1070:	4c 8b 54 0d 08       	mov    r10,QWORD PTR [rbp+rcx*1+0x8]
    1075:	4c 8b 4c 0d 10       	mov    r9,QWORD PTR [rbp+rcx*1+0x10]
    107a:	4c 8b 44 0d 18       	mov    r8,QWORD PTR [rbp+rcx*1+0x18]
    107f:	4c 89 1c 0e          	mov    QWORD PTR [rsi+rcx*1],r11
    1083:	4c 89 54 0e 08       	mov    QWORD PTR [rsi+rcx*1+0x8],r10
    1088:	4c 89 4c 0e 10       	mov    QWORD PTR [rsi+rcx*1+0x10],r9
    108d:	4c 89 44 0e 18       	mov    QWORD PTR [rsi+rcx*1+0x18],r8
    1092:	39 d7                	cmp    edi,edx
    1094:	72 d0                	jb     1066 <gzram_base_encode_avx2+0x2f6>
    1096:	eb 8a                	jmp    1022 <gzram_base_encode_avx2+0x2b2>
    1098:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    109f:	00 
    10a0:	f6 c2 02             	test   dl,0x2
    10a3:	0f 84 ac 00 00 00    	je     1155 <gzram_base_encode_avx2+0x3e5>
    10a9:	49 83 ff 08          	cmp    r15,0x8
    10ad:	0f 86 a6 fe ff ff    	jbe    f59 <gzram_base_encode_avx2+0x1e9>
    10b3:	ba 03 00 00 00       	mov    edx,0x3
    10b8:	b8 08 00 00 00       	mov    eax,0x8
    10bd:	e9 1e ff ff ff       	jmp    fe0 <gzram_base_encode_avx2+0x270>
    10c2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    10c8:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
    10cd:	4c 8b 7c 24 28       	mov    r15,QWORD PTR [rsp+0x28]
    10d2:	4d 89 e8             	mov    r8,r13
    10d5:	48 8b 6c 24 30       	mov    rbp,QWORD PTR [rsp+0x30]
    10da:	44 8b 64 24 3c       	mov    r12d,DWORD PTR [rsp+0x3c]
    10df:	49 39 f5             	cmp    r13,rsi
    10e2:	0f 83 9f 00 00 00    	jae    1187 <gzram_base_encode_avx2+0x417>
    10e8:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
    10ef:	00 
    10f0:	44 89 c0             	mov    eax,r8d
    10f3:	e9 ba fd ff ff       	jmp    eb2 <gzram_base_encode_avx2+0x142>
    10f8:	4c 39 fe             	cmp    rsi,r15
    10fb:	0f 83 58 fe ff ff    	jae    f59 <gzram_base_encode_avx2+0x1e9>
    1101:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
    1106:	4c 8b 6c 24 18       	mov    r13,QWORD PTR [rsp+0x18]
    110b:	31 c0                	xor    eax,eax
    110d:	4c 8b 5c 24 40       	mov    r11,QWORD PTR [rsp+0x40]
    1112:	4c 8b 7c 24 28       	mov    r15,QWORD PTR [rsp+0x28]
    1117:	48 8b 6c 24 30       	mov    rbp,QWORD PTR [rsp+0x30]
    111c:	44 8b 64 24 3c       	mov    r12d,DWORD PTR [rsp+0x3c]
    1121:	49 39 f5             	cmp    r13,rsi
    1124:	0f 82 b1 02 00 00    	jb     13db <gzram_base_encode_avx2+0x66b>
    112a:	48 85 ed             	test   rbp,rbp
    112d:	0f 85 b5 02 00 00    	jne    13e8 <gzram_base_encode_avx2+0x678>
    1133:	c7 03 47 5a 52 31    	mov    DWORD PTR [rbx],0x31525a47
    1139:	8d 45 08             	lea    eax,[rbp+0x8]
    113c:	66 89 6b 04          	mov    WORD PTR [rbx+0x4],bp
    1140:	44 88 63 06          	mov    BYTE PTR [rbx+0x6],r12b
    1144:	c6 43 07 01          	mov    BYTE PTR [rbx+0x7],0x1
    1148:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
    114f:	00 
    1150:	e9 5d fd ff ff       	jmp    eb2 <gzram_base_encode_avx2+0x142>
    1155:	f6 c2 04             	test   dl,0x4
    1158:	74 4e                	je     11a8 <gzram_base_encode_avx2+0x438>
    115a:	49 83 ff 10          	cmp    r15,0x10
    115e:	0f 86 f5 fd ff ff    	jbe    f59 <gzram_base_encode_avx2+0x1e9>
    1164:	ba 05 00 00 00       	mov    edx,0x5
    1169:	b8 10 00 00 00       	mov    eax,0x10
    116e:	e9 6d fe ff ff       	jmp    fe0 <gzram_base_encode_avx2+0x270>
    1173:	48 8d 7b 08          	lea    rdi,[rbx+0x8]
    1177:	48 89 ea             	mov    rdx,rbp
    117a:	4c 89 fe             	mov    rsi,r15
    117d:	e8 00 00 00 00       	call   1182 <gzram_base_encode_avx2+0x412>
    1182:	e9 b3 fc ff ff       	jmp    e3a <gzram_base_encode_avx2+0xca>
    1187:	48 39 74 24 18       	cmp    QWORD PTR [rsp+0x18],rsi
    118c:	0f 82 11 fd ff ff    	jb     ea3 <gzram_base_encode_avx2+0x133>
    1192:	48 85 ed             	test   rbp,rbp
    1195:	74 9c                	je     1133 <gzram_base_encode_avx2+0x3c3>
    1197:	48 8d 7b 08          	lea    rdi,[rbx+0x8]
    119b:	48 89 ea             	mov    rdx,rbp
    119e:	4c 89 fe             	mov    rsi,r15
    11a1:	e8 00 00 00 00       	call   11a6 <gzram_base_encode_avx2+0x436>
    11a6:	eb 8b                	jmp    1133 <gzram_base_encode_avx2+0x3c3>
    11a8:	83 e2 08             	and    edx,0x8
    11ab:	74 0a                	je     11b7 <gzram_base_encode_avx2+0x447>
    11ad:	49 83 ff 20          	cmp    r15,0x20
    11b1:	0f 87 b9 02 00 00    	ja     1470 <gzram_base_encode_avx2+0x700>
    11b7:	4c 89 f9             	mov    rcx,r15
    11ba:	48 8b 74 24 18       	mov    rsi,QWORD PTR [rsp+0x18]
    11bf:	8d 14 85 00 00 00 00 	lea    edx,[rax*4+0x0]
    11c6:	48 c1 e9 05          	shr    rcx,0x5
    11ca:	48 01 ca             	add    rdx,rcx
    11cd:	4c 29 ee             	sub    rsi,r13
    11d0:	4c 39 fa             	cmp    rdx,r15
    11d3:	0f 83 1f ff ff ff    	jae    10f8 <gzram_base_encode_avx2+0x388>
    11d9:	48 39 d6             	cmp    rsi,rdx
    11dc:	0f 82 1f ff ff ff    	jb     1101 <gzram_base_encode_avx2+0x391>
    11e2:	41 c6 04 24 04       	mov    BYTE PTR [r12],0x4
    11e7:	4a 8d 34 2b          	lea    rsi,[rbx+r13*1]
    11eb:	83 f9 20             	cmp    ecx,0x20
    11ee:	0f 83 fc 00 00 00    	jae    12f0 <gzram_base_encode_avx2+0x580>
    11f4:	f6 c1 10             	test   cl,0x10
    11f7:	0f 85 fe 01 00 00    	jne    13fb <gzram_base_encode_avx2+0x68b>
    11fd:	f6 c1 08             	test   cl,0x8
    1200:	0f 85 27 02 00 00    	jne    142d <gzram_base_encode_avx2+0x6bd>
    1206:	f6 c1 04             	test   cl,0x4
    1209:	0f 85 4c 02 00 00    	jne    145b <gzram_base_encode_avx2+0x6eb>
    120f:	85 c9                	test   ecx,ecx
    1211:	74 10                	je     1223 <gzram_base_encode_avx2+0x4b3>
    1213:	0f b6 54 24 58       	movzx  edx,BYTE PTR [rsp+0x58]
    1218:	88 16                	mov    BYTE PTR [rsi],dl
    121a:	f6 c1 02             	test   cl,0x2
    121d:	0f 85 5c 02 00 00    	jne    147f <gzram_base_encode_avx2+0x70f>
    1223:	89 c0                	mov    eax,eax
    1225:	48 8d 14 49          	lea    rdx,[rcx+rcx*2]
    1229:	49 01 cd             	add    r13,rcx
    122c:	48 39 c2             	cmp    rdx,rax
    122f:	0f 82 3a 01 00 00    	jb     136f <gzram_base_encode_avx2+0x5ff>
    1235:	48 85 c9             	test   rcx,rcx
    1238:	0f 84 32 fd ff ff    	je     f70 <gzram_base_encode_avx2+0x200>
    123e:	48 c1 e1 05          	shl    rcx,0x5
    1242:	4c 8d 44 24 58       	lea    r8,[rsp+0x58]
    1247:	48 89 ef             	mov    rdi,rbp
    124a:	4c 8d 0c 29          	lea    r9,[rcx+rbp*1]
    124e:	4c 8d 1d 00 00 00 00 	lea    r11,[rip+0x0]        # 1255 <gzram_base_encode_avx2+0x4e5>
    1255:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    125c:	00 00 00 00 
    1260:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
    1264:	4b 8d 54 15 00       	lea    rdx,[r13+r10*1+0x0]
    1269:	48 01 da             	add    rdx,rbx
    126c:	81 f9 ff 00 00 00    	cmp    ecx,0xff
    1272:	74 5c                	je     12d0 <gzram_base_encode_avx2+0x560>
    1274:	89 c8                	mov    eax,ecx
    1276:	85 c9                	test   ecx,ecx
    1278:	74 29                	je     12a3 <gzram_base_encode_avx2+0x533>
    127a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1280:	45 31 ff             	xor    r15d,r15d
    1283:	8d 70 ff             	lea    esi,[rax-0x1]
    1286:	48 83 c2 04          	add    rdx,0x4
    128a:	f3 44 0f bc f8       	tzcnt  r15d,eax
    128f:	46 8d 3c bd 00 00 00 	lea    r15d,[r15*4+0x0]
    1296:	00 
    1297:	46 8b 3c 3f          	mov    r15d,DWORD PTR [rdi+r15*1]
    129b:	44 89 7a fc          	mov    DWORD PTR [rdx-0x4],r15d
    129f:	21 f0                	and    eax,esi
    12a1:	75 dd                	jne    1280 <gzram_base_encode_avx2+0x510>
    12a3:	41 0f b6 04 0b       	movzx  eax,BYTE PTR [r11+rcx*1]
    12a8:	48 83 c7 20          	add    rdi,0x20
    12ac:	49 83 c0 01          	add    r8,0x1
    12b0:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    12b7:	49 01 c2             	add    r10,rax
    12ba:	4c 39 cf             	cmp    rdi,r9
    12bd:	0f 85 9d ff ff ff    	jne    1260 <gzram_base_encode_avx2+0x4f0>
    12c3:	4d 01 d5             	add    r13,r10
    12c6:	e9 a5 fc ff ff       	jmp    f70 <gzram_base_encode_avx2+0x200>
    12cb:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    12d0:	48 8b 07             	mov    rax,QWORD PTR [rdi]
    12d3:	48 89 02             	mov    QWORD PTR [rdx],rax
    12d6:	48 8b 47 08          	mov    rax,QWORD PTR [rdi+0x8]
    12da:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
    12de:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
    12e2:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
    12e6:	48 8b 47 18          	mov    rax,QWORD PTR [rdi+0x18]
    12ea:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
    12ee:	eb b3                	jmp    12a3 <gzram_base_encode_avx2+0x533>
    12f0:	89 ca                	mov    edx,ecx
    12f2:	48 8d 3c 16          	lea    rdi,[rsi+rdx*1]
    12f6:	48 8d 54 14 58       	lea    rdx,[rsp+rdx*1+0x58]
    12fb:	4c 8b 42 e0          	mov    r8,QWORD PTR [rdx-0x20]
    12ff:	4c 89 47 e0          	mov    QWORD PTR [rdi-0x20],r8
    1303:	4c 8b 42 e8          	mov    r8,QWORD PTR [rdx-0x18]
    1307:	4c 89 47 e8          	mov    QWORD PTR [rdi-0x18],r8
    130b:	4c 8b 42 f0          	mov    r8,QWORD PTR [rdx-0x10]
    130f:	4c 89 47 f0          	mov    QWORD PTR [rdi-0x10],r8
    1313:	48 8b 52 f8          	mov    rdx,QWORD PTR [rdx-0x8]
    1317:	48 89 57 f8          	mov    QWORD PTR [rdi-0x8],rdx
    131b:	8d 79 ff             	lea    edi,[rcx-0x1]
    131e:	83 ff 20             	cmp    edi,0x20
    1321:	0f 82 fc fe ff ff    	jb     1223 <gzram_base_encode_avx2+0x4b3>
    1327:	83 e7 e0             	and    edi,0xffffffe0
    132a:	45 31 c0             	xor    r8d,r8d
    132d:	44 89 c2             	mov    edx,r8d
    1330:	41 83 c0 20          	add    r8d,0x20
    1334:	4c 8b 5c 14 58       	mov    r11,QWORD PTR [rsp+rdx*1+0x58]
    1339:	4c 8b 4c 14 68       	mov    r9,QWORD PTR [rsp+rdx*1+0x68]
    133e:	4c 8b 7c 14 60       	mov    r15,QWORD PTR [rsp+rdx*1+0x60]
    1343:	4c 89 4c 24 48       	mov    QWORD PTR [rsp+0x48],r9
    1348:	4c 8b 4c 14 70       	mov    r9,QWORD PTR [rsp+rdx*1+0x70]
    134d:	4c 89 1c 16          	mov    QWORD PTR [rsi+rdx*1],r11
    1351:	4c 89 7c 16 08       	mov    QWORD PTR [rsi+rdx*1+0x8],r15
    1356:	4c 8b 5c 24 48       	mov    r11,QWORD PTR [rsp+0x48]
    135b:	4c 89 4c 16 18       	mov    QWORD PTR [rsi+rdx*1+0x18],r9
    1360:	4c 89 5c 16 10       	mov    QWORD PTR [rsi+rdx*1+0x10],r11
    1365:	41 39 f8             	cmp    r8d,edi
    1368:	72 c3                	jb     132d <gzram_base_encode_avx2+0x5bd>
    136a:	e9 b4 fe ff ff       	jmp    1223 <gzram_base_encode_avx2+0x4b3>
    136f:	4a 8d 34 2b          	lea    rsi,[rbx+r13*1]
    1373:	48 8d 54 24 58       	lea    rdx,[rsp+0x58]
    1378:	48 89 ef             	mov    rdi,rbp
    137b:	e8 30 f0 ff ff       	call   3b0 <pack_block_avx2>
    1380:	e9 9d fc ff ff       	jmp    1022 <gzram_base_encode_avx2+0x2b2>
    1385:	48 8b 4d 00          	mov    rcx,QWORD PTR [rbp+0x0]
    1389:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    138c:	48 8b 4d 08          	mov    rcx,QWORD PTR [rbp+0x8]
    1390:	48 89 4e 08          	mov    QWORD PTR [rsi+0x8],rcx
    1394:	48 8d 4c 16 10       	lea    rcx,[rsi+rdx*1+0x10]
    1399:	48 8d 54 15 10       	lea    rdx,[rbp+rdx*1+0x10]
    139e:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
    13a2:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
    13a6:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    13aa:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
    13ae:	e9 6f fc ff ff       	jmp    1022 <gzram_base_encode_avx2+0x2b2>
    13b3:	48 8b 4d 00          	mov    rcx,QWORD PTR [rbp+0x0]
    13b7:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    13ba:	48 8b 4c 15 f8       	mov    rcx,QWORD PTR [rbp+rdx*1-0x8]
    13bf:	48 89 4c 16 f8       	mov    QWORD PTR [rsi+rdx*1-0x8],rcx
    13c4:	e9 59 fc ff ff       	jmp    1022 <gzram_base_encode_avx2+0x2b2>
    13c9:	8b 4d 00             	mov    ecx,DWORD PTR [rbp+0x0]
    13cc:	89 0e                	mov    DWORD PTR [rsi],ecx
    13ce:	8b 4c 15 fc          	mov    ecx,DWORD PTR [rbp+rdx*1-0x4]
    13d2:	89 4c 16 fc          	mov    DWORD PTR [rsi+rdx*1-0x4],ecx
    13d6:	e9 47 fc ff ff       	jmp    1022 <gzram_base_encode_avx2+0x2b2>
    13db:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
    13e2:	00 
    13e3:	e9 ca fa ff ff       	jmp    eb2 <gzram_base_encode_avx2+0x142>
    13e8:	48 89 ea             	mov    rdx,rbp
    13eb:	4c 89 fe             	mov    rsi,r15
    13ee:	4c 89 df             	mov    rdi,r11
    13f1:	e8 00 00 00 00       	call   13f6 <gzram_base_encode_avx2+0x686>
    13f6:	e9 38 fd ff ff       	jmp    1133 <gzram_base_encode_avx2+0x3c3>
    13fb:	48 8b 54 24 58       	mov    rdx,QWORD PTR [rsp+0x58]
    1400:	48 89 16             	mov    QWORD PTR [rsi],rdx
    1403:	48 8b 54 24 60       	mov    rdx,QWORD PTR [rsp+0x60]
    1408:	48 89 56 08          	mov    QWORD PTR [rsi+0x8],rdx
    140c:	89 ca                	mov    edx,ecx
    140e:	48 8d 74 16 10       	lea    rsi,[rsi+rdx*1+0x10]
    1413:	48 8d 54 14 68       	lea    rdx,[rsp+rdx*1+0x68]
    1418:	48 8b 7a e0          	mov    rdi,QWORD PTR [rdx-0x20]
    141c:	48 89 7e e0          	mov    QWORD PTR [rsi-0x20],rdi
    1420:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    1424:	48 89 56 e8          	mov    QWORD PTR [rsi-0x18],rdx
    1428:	e9 f6 fd ff ff       	jmp    1223 <gzram_base_encode_avx2+0x4b3>
    142d:	48 8b 54 24 58       	mov    rdx,QWORD PTR [rsp+0x58]
    1432:	48 89 16             	mov    QWORD PTR [rsi],rdx
    1435:	89 ca                	mov    edx,ecx
    1437:	48 8b 7c 14 50       	mov    rdi,QWORD PTR [rsp+rdx*1+0x50]
    143c:	48 89 7c 16 f8       	mov    QWORD PTR [rsi+rdx*1-0x8],rdi
    1441:	e9 dd fd ff ff       	jmp    1223 <gzram_base_encode_avx2+0x4b3>
    1446:	41 b8 08 00 00 00    	mov    r8d,0x8
    144c:	48 83 fe 08          	cmp    rsi,0x8
    1450:	0f 85 92 fc ff ff    	jne    10e8 <gzram_base_encode_avx2+0x378>
    1456:	e9 37 fd ff ff       	jmp    1192 <gzram_base_encode_avx2+0x422>
    145b:	8b 54 24 58          	mov    edx,DWORD PTR [rsp+0x58]
    145f:	89 16                	mov    DWORD PTR [rsi],edx
    1461:	89 ca                	mov    edx,ecx
    1463:	8b 7c 14 54          	mov    edi,DWORD PTR [rsp+rdx*1+0x54]
    1467:	89 7c 16 fc          	mov    DWORD PTR [rsi+rdx*1-0x4],edi
    146b:	e9 b3 fd ff ff       	jmp    1223 <gzram_base_encode_avx2+0x4b3>
    1470:	ba 06 00 00 00       	mov    edx,0x6
    1475:	b8 20 00 00 00       	mov    eax,0x20
    147a:	e9 61 fb ff ff       	jmp    fe0 <gzram_base_encode_avx2+0x270>
    147f:	89 ca                	mov    edx,ecx
    1481:	0f b7 7c 14 56       	movzx  edi,WORD PTR [rsp+rdx*1+0x56]
    1486:	66 89 7c 16 fe       	mov    WORD PTR [rsi+rdx*1-0x2],di
    148b:	e9 93 fd ff ff       	jmp    1223 <gzram_base_encode_avx2+0x4b3>

0000000000001490 <gzram_base_decode_scalar>:
    1490:	48 89 c8             	mov    rax,rcx
    1493:	48 8d 4e f8          	lea    rcx,[rsi-0x8]
    1497:	48 81 f9 00 10 00 00 	cmp    rcx,0x1000
    149e:	0f 87 9b 06 00 00    	ja     1b3f <gzram_base_decode_scalar+0x6af>
    14a4:	48 85 ff             	test   rdi,rdi
    14a7:	0f 84 92 06 00 00    	je     1b3f <gzram_base_decode_scalar+0x6af>
    14ad:	81 3f 47 5a 52 31    	cmp    DWORD PTR [rdi],0x31525a47
    14b3:	0f 85 86 06 00 00    	jne    1b3f <gzram_base_decode_scalar+0x6af>
    14b9:	0f b6 4f 06          	movzx  ecx,BYTE PTR [rdi+0x6]
    14bd:	44 8d 41 fb          	lea    r8d,[rcx-0x5]
    14c1:	41 80 f8 07          	cmp    r8b,0x7
    14c5:	0f 87 74 06 00 00    	ja     1b3f <gzram_base_decode_scalar+0x6af>
    14cb:	44 0f b6 4f 07       	movzx  r9d,BYTE PTR [rdi+0x7]
    14d0:	41 80 f9 01          	cmp    r9b,0x1
    14d4:	0f 87 65 06 00 00    	ja     1b3f <gzram_base_decode_scalar+0x6af>
    14da:	41 ba 00 10 00 00    	mov    r10d,0x1000
    14e0:	48 81 ec a8 00 00 00 	sub    rsp,0xa8
    14e7:	4c 39 d0             	cmp    rax,r10
    14ea:	48 89 5c 24 78       	mov    QWORD PTR [rsp+0x78],rbx
    14ef:	44 0f b7 47 04       	movzx  r8d,WORD PTR [rdi+0x4]
    14f4:	49 0f 47 c2          	cmova  rax,r10
    14f8:	4c 89 c3             	mov    rbx,r8
    14fb:	4c 39 c0             	cmp    rax,r8
    14fe:	0f 82 d6 04 00 00    	jb     19da <gzram_base_decode_scalar+0x54a>
    1504:	48 85 d2             	test   rdx,rdx
    1507:	75 09                	jne    1512 <gzram_base_decode_scalar+0x82>
    1509:	4d 85 c0             	test   r8,r8
    150c:	0f 85 c8 04 00 00    	jne    19da <gzram_base_decode_scalar+0x54a>
    1512:	4c 89 b4 24 98 00 00 	mov    QWORD PTR [rsp+0x98],r14
    1519:	00 
    151a:	49 89 d6             	mov    r14,rdx
    151d:	4c 89 a4 24 88 00 00 	mov    QWORD PTR [rsp+0x88],r12
    1524:	00 
    1525:	48 89 74 24 38       	mov    QWORD PTR [rsp+0x38],rsi
    152a:	45 84 c9             	test   r9b,r9b
    152d:	0f 85 9d 00 00 00    	jne    15d0 <gzram_base_decode_scalar+0x140>
    1533:	ba 01 00 00 00       	mov    edx,0x1
    1538:	4c 89 bc 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],r15
    153f:	00 
    1540:	48 d3 e2             	shl    rdx,cl
    1543:	49 89 d7             	mov    r15,rdx
    1546:	49 8d 54 10 ff       	lea    rdx,[r8+rdx*1-0x1]
    154b:	48 d3 ea             	shr    rdx,cl
    154e:	4c 8d 52 08          	lea    r10,[rdx+0x8]
    1552:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    1557:	0f 82 f3 05 00 00    	jb     1b50 <gzram_base_decode_scalar+0x6c0>
    155d:	48 85 d2             	test   rdx,rdx
    1560:	0f 84 df 05 00 00    	je     1b45 <gzram_base_decode_scalar+0x6b5>
    1566:	4c 89 ac 24 90 00 00 	mov    QWORD PTR [rsp+0x90],r13
    156d:	00 
    156e:	4c 8d 6f 08          	lea    r13,[rdi+0x8]
    1572:	4d 89 f9             	mov    r9,r15
    1575:	4a 8d 04 2a          	lea    rax,[rdx+r13*1]
    1579:	66 89 5c 24 6e       	mov    WORD PTR [rsp+0x6e],bx
    157e:	48 89 44 24 50       	mov    QWORD PTR [rsp+0x50],rax
    1583:	4b 8d 04 06          	lea    rax,[r14+r8*1]
    1587:	48 89 44 24 40       	mov    QWORD PTR [rsp+0x40],rax
    158c:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
    1591:	48 89 ac 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rbp
    1598:	00 
    1599:	4c 89 d5             	mov    rbp,r10
    159c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    15a0:	48 8b 5c 24 40       	mov    rbx,QWORD PTR [rsp+0x40]
    15a5:	4c 29 f3             	sub    rbx,r14
    15a8:	4c 39 cb             	cmp    rbx,r9
    15ab:	49 0f 47 d9          	cmova  rbx,r9
    15af:	41 80 7d 00 06       	cmp    BYTE PTR [r13+0x0],0x6
    15b4:	0f 87 f8 03 00 00    	ja     19b2 <gzram_base_decode_scalar+0x522>
    15ba:	41 0f b6 45 00       	movzx  eax,BYTE PTR [r13+0x0]
    15bf:	48 8d 3d 00 00 00 00 	lea    rdi,[rip+0x0]        # 15c6 <gzram_base_decode_scalar+0x136>
    15c6:	48 63 04 87          	movsxd rax,DWORD PTR [rdi+rax*4]
    15ca:	48 01 f8             	add    rax,rdi
    15cd:	ff e0                	jmp    rax
    15cf:	90                   	nop
    15d0:	49 8d 50 08          	lea    rdx,[r8+0x8]
    15d4:	48 39 d6             	cmp    rsi,rdx
    15d7:	0f 85 4d 05 00 00    	jne    1b2a <gzram_base_decode_scalar+0x69a>
    15dd:	4d 85 c0             	test   r8,r8
    15e0:	0f 85 30 05 00 00    	jne    1b16 <gzram_base_decode_scalar+0x686>
    15e6:	0f b7 c3             	movzx  eax,bx
    15e9:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    15f0:	00 
    15f1:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    15f8:	00 
    15f9:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    15fe:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    1605:	c3                   	ret
    1606:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    160d:	00 00 00 
    1610:	b9 08 00 00 00       	mov    ecx,0x8
    1615:	48 89 d8             	mov    rax,rbx
    1618:	31 d2                	xor    edx,edx
    161a:	48 f7 f1             	div    rcx
    161d:	48 85 d2             	test   rdx,rdx
    1620:	0f 85 8c 03 00 00    	jne    19b2 <gzram_base_decode_scalar+0x522>
    1626:	48 39 cb             	cmp    rbx,rcx
    1629:	0f 82 83 03 00 00    	jb     19b2 <gzram_base_decode_scalar+0x522>
    162f:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    1634:	48 29 e8             	sub    rax,rbp
    1637:	48 39 c8             	cmp    rax,rcx
    163a:	0f 82 72 03 00 00    	jb     19b2 <gzram_base_decode_scalar+0x522>
    1640:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1645:	44 8d 51 ff          	lea    r10d,[rcx-0x1]
    1649:	89 ce                	mov    esi,ecx
    164b:	89 4c 24 68          	mov    DWORD PTR [rsp+0x68],ecx
    164f:	4c 89 4c 24 58       	mov    QWORD PTR [rsp+0x58],r9
    1654:	41 89 cb             	mov    r11d,ecx
    1657:	41 89 cf             	mov    r15d,ecx
    165a:	83 e6 04             	and    esi,0x4
    165d:	48 8d 3c 28          	lea    rdi,[rax+rbp*1]
    1661:	44 89 d0             	mov    eax,r10d
    1664:	48 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],rbp
    1669:	41 89 cc             	mov    r12d,ecx
    166c:	83 e0 e0             	and    eax,0xffffffe0
    166f:	4c 8d 04 0f          	lea    r8,[rdi+rcx*1]
    1673:	41 83 e3 10          	and    r11d,0x10
    1677:	41 83 e7 08          	and    r15d,0x8
    167b:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
    167f:	89 c8                	mov    eax,ecx
    1681:	89 f5                	mov    ebp,esi
    1683:	83 e0 02             	and    eax,0x2
    1686:	89 44 24 4c          	mov    DWORD PTR [rsp+0x4c],eax
    168a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1690:	49 8d 04 16          	lea    rax,[r14+rdx*1]
    1694:	83 f9 20             	cmp    ecx,0x20
    1697:	0f 83 53 03 00 00    	jae    19f0 <gzram_base_decode_scalar+0x560>
    169d:	45 85 db             	test   r11d,r11d
    16a0:	0f 85 f2 03 00 00    	jne    1a98 <gzram_base_decode_scalar+0x608>
    16a6:	45 85 ff             	test   r15d,r15d
    16a9:	0f 85 21 04 00 00    	jne    1ad0 <gzram_base_decode_scalar+0x640>
    16af:	85 ed                	test   ebp,ebp
    16b1:	0f 85 39 04 00 00    	jne    1af0 <gzram_base_decode_scalar+0x660>
    16b7:	85 c9                	test   ecx,ecx
    16b9:	74 12                	je     16cd <gzram_base_decode_scalar+0x23d>
    16bb:	0f b6 37             	movzx  esi,BYTE PTR [rdi]
    16be:	40 88 30             	mov    BYTE PTR [rax],sil
    16c1:	8b 74 24 4c          	mov    esi,DWORD PTR [rsp+0x4c]
    16c5:	85 f6                	test   esi,esi
    16c7:	0f 85 3a 04 00 00    	jne    1b07 <gzram_base_decode_scalar+0x677>
    16cd:	48 01 ca             	add    rdx,rcx
    16d0:	48 39 da             	cmp    rdx,rbx
    16d3:	72 bb                	jb     1690 <gzram_base_decode_scalar+0x200>
    16d5:	48 8b 6c 24 60       	mov    rbp,QWORD PTR [rsp+0x60]
    16da:	4c 8b 4c 24 58       	mov    r9,QWORD PTR [rsp+0x58]
    16df:	48 01 cd             	add    rbp,rcx
    16e2:	49 83 c5 01          	add    r13,0x1
    16e6:	4d 01 ce             	add    r14,r9
    16e9:	4c 39 6c 24 50       	cmp    QWORD PTR [rsp+0x50],r13
    16ee:	0f 85 ac fe ff ff    	jne    15a0 <gzram_base_decode_scalar+0x110>
    16f4:	49 89 ea             	mov    r10,rbp
    16f7:	0f b7 5c 24 6e       	movzx  ebx,WORD PTR [rsp+0x6e]
    16fc:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    1703:	00 
    1704:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    170b:	00 
    170c:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    1711:	0f 85 39 04 00 00    	jne    1b50 <gzram_base_decode_scalar+0x6c0>
    1717:	0f b7 c3             	movzx  eax,bx
    171a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1721:	00 
    1722:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1729:	00 
    172a:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1731:	00 
    1732:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    1737:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    173e:	c3                   	ret
    173f:	90                   	nop
    1740:	b9 04 00 00 00       	mov    ecx,0x4
    1745:	e9 cb fe ff ff       	jmp    1615 <gzram_base_decode_scalar+0x185>
    174a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1750:	48 89 da             	mov    rdx,rbx
    1753:	31 f6                	xor    esi,esi
    1755:	4c 89 f7             	mov    rdi,r14
    1758:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    175d:	e8 00 00 00 00       	call   1762 <gzram_base_decode_scalar+0x2d2>
    1762:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    1767:	e9 76 ff ff ff       	jmp    16e2 <gzram_base_decode_scalar+0x252>
    176c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1770:	b9 10 00 00 00       	mov    ecx,0x10
    1775:	e9 9b fe ff ff       	jmp    1615 <gzram_base_decode_scalar+0x185>
    177a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1780:	48 89 d8             	mov    rax,rbx
    1783:	83 e0 1f             	and    eax,0x1f
    1786:	0f 85 26 02 00 00    	jne    19b2 <gzram_base_decode_scalar+0x522>
    178c:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    1791:	48 c1 eb 05          	shr    rbx,0x5
    1795:	48 29 ea             	sub    rdx,rbp
    1798:	48 39 da             	cmp    rdx,rbx
    179b:	0f 82 11 02 00 00    	jb     19b2 <gzram_base_decode_scalar+0x522>
    17a1:	48 8d 34 2b          	lea    rsi,[rbx+rbp*1]
    17a5:	48 85 db             	test   rbx,rbx
    17a8:	0f 84 b0 01 00 00    	je     195e <gzram_base_decode_scalar+0x4ce>
    17ae:	48 03 6c 24 10       	add    rbp,QWORD PTR [rsp+0x10]
    17b3:	4c 8d 05 00 00 00 00 	lea    r8,[rip+0x0]        # 17ba <gzram_base_decode_scalar+0x32a>
    17ba:	48 8d 3c 2b          	lea    rdi,[rbx+rbp*1]
    17be:	48 89 ea             	mov    rdx,rbp
    17c1:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    17c8:	00 00 
    17ca:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    17d1:	00 00 00 00 
    17d5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    17dc:	00 00 00 00 
    17e0:	0f b6 0a             	movzx  ecx,BYTE PTR [rdx]
    17e3:	48 83 c2 01          	add    rdx,0x1
    17e7:	41 0f b6 0c 08       	movzx  ecx,BYTE PTR [r8+rcx*1]
    17ec:	8d 0c 8d 00 00 00 00 	lea    ecx,[rcx*4+0x0]
    17f3:	48 01 c8             	add    rax,rcx
    17f6:	48 39 d7             	cmp    rdi,rdx
    17f9:	75 e5                	jne    17e0 <gzram_base_decode_scalar+0x350>
    17fb:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    1800:	48 29 f2             	sub    rdx,rsi
    1803:	48 39 c2             	cmp    rdx,rax
    1806:	0f 82 a6 01 00 00    	jb     19b2 <gzram_base_decode_scalar+0x522>
    180c:	4c 89 f1             	mov    rcx,r14
    180f:	e9 a0 00 00 00       	jmp    18b4 <gzram_base_decode_scalar+0x424>
    1814:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1818:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    181b:	48 83 c0 04          	add    rax,0x4
    181f:	44 89 51 04          	mov    DWORD PTR [rcx+0x4],r10d
    1823:	f6 c2 04             	test   dl,0x4
    1826:	0f 84 c0 00 00 00    	je     18ec <gzram_base_decode_scalar+0x45c>
    182c:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    182f:	48 83 c0 04          	add    rax,0x4
    1833:	44 89 51 08          	mov    DWORD PTR [rcx+0x8],r10d
    1837:	f6 c2 08             	test   dl,0x8
    183a:	0f 84 bc 00 00 00    	je     18fc <gzram_base_decode_scalar+0x46c>
    1840:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1843:	48 83 c0 04          	add    rax,0x4
    1847:	44 89 51 0c          	mov    DWORD PTR [rcx+0xc],r10d
    184b:	f6 c2 10             	test   dl,0x10
    184e:	0f 84 b8 00 00 00    	je     190c <gzram_base_decode_scalar+0x47c>
    1854:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1857:	48 83 c0 04          	add    rax,0x4
    185b:	44 89 51 10          	mov    DWORD PTR [rcx+0x10],r10d
    185f:	f6 c2 20             	test   dl,0x20
    1862:	0f 84 b4 00 00 00    	je     191c <gzram_base_decode_scalar+0x48c>
    1868:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    186b:	48 83 c0 04          	add    rax,0x4
    186f:	44 89 51 14          	mov    DWORD PTR [rcx+0x14],r10d
    1873:	f6 c2 40             	test   dl,0x40
    1876:	0f 84 b0 00 00 00    	je     192c <gzram_base_decode_scalar+0x49c>
    187c:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    187f:	48 83 c0 04          	add    rax,0x4
    1883:	44 89 51 18          	mov    DWORD PTR [rcx+0x18],r10d
    1887:	84 d2                	test   dl,dl
    1889:	0f 89 ac 00 00 00    	jns    193b <gzram_base_decode_scalar+0x4ab>
    188f:	8b 00                	mov    eax,DWORD PTR [rax]
    1891:	48 83 c5 01          	add    rbp,0x1
    1895:	89 41 1c             	mov    DWORD PTR [rcx+0x1c],eax
    1898:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    189d:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    18a4:	48 01 c6             	add    rsi,rax
    18a7:	48 39 ef             	cmp    rdi,rbp
    18aa:	0f 84 ae 00 00 00    	je     195e <gzram_base_decode_scalar+0x4ce>
    18b0:	48 83 c1 20          	add    rcx,0x20
    18b4:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    18b9:	0f b6 55 00          	movzx  edx,BYTE PTR [rbp+0x0]
    18bd:	48 01 f0             	add    rax,rsi
    18c0:	f6 c2 01             	test   dl,0x1
    18c3:	0f 84 bf 01 00 00    	je     1a88 <gzram_base_decode_scalar+0x5f8>
    18c9:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    18cc:	48 83 c0 04          	add    rax,0x4
    18d0:	44 89 11             	mov    DWORD PTR [rcx],r10d
    18d3:	f6 c2 02             	test   dl,0x2
    18d6:	0f 85 3c ff ff ff    	jne    1818 <gzram_base_decode_scalar+0x388>
    18dc:	c7 41 04 00 00 00 00 	mov    DWORD PTR [rcx+0x4],0x0
    18e3:	f6 c2 04             	test   dl,0x4
    18e6:	0f 85 40 ff ff ff    	jne    182c <gzram_base_decode_scalar+0x39c>
    18ec:	c7 41 08 00 00 00 00 	mov    DWORD PTR [rcx+0x8],0x0
    18f3:	f6 c2 08             	test   dl,0x8
    18f6:	0f 85 44 ff ff ff    	jne    1840 <gzram_base_decode_scalar+0x3b0>
    18fc:	c7 41 0c 00 00 00 00 	mov    DWORD PTR [rcx+0xc],0x0
    1903:	f6 c2 10             	test   dl,0x10
    1906:	0f 85 48 ff ff ff    	jne    1854 <gzram_base_decode_scalar+0x3c4>
    190c:	c7 41 10 00 00 00 00 	mov    DWORD PTR [rcx+0x10],0x0
    1913:	f6 c2 20             	test   dl,0x20
    1916:	0f 85 4c ff ff ff    	jne    1868 <gzram_base_decode_scalar+0x3d8>
    191c:	c7 41 14 00 00 00 00 	mov    DWORD PTR [rcx+0x14],0x0
    1923:	f6 c2 40             	test   dl,0x40
    1926:	0f 85 50 ff ff ff    	jne    187c <gzram_base_decode_scalar+0x3ec>
    192c:	c7 41 18 00 00 00 00 	mov    DWORD PTR [rcx+0x18],0x0
    1933:	84 d2                	test   dl,dl
    1935:	0f 88 54 ff ff ff    	js     188f <gzram_base_decode_scalar+0x3ff>
    193b:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    1940:	48 83 c5 01          	add    rbp,0x1
    1944:	c7 41 1c 00 00 00 00 	mov    DWORD PTR [rcx+0x1c],0x0
    194b:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1952:	48 01 c6             	add    rsi,rax
    1955:	48 39 fd             	cmp    rbp,rdi
    1958:	0f 85 52 ff ff ff    	jne    18b0 <gzram_base_decode_scalar+0x420>
    195e:	48 89 f5             	mov    rbp,rsi
    1961:	e9 7c fd ff ff       	jmp    16e2 <gzram_base_decode_scalar+0x252>
    1966:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    196d:	00 00 00 
    1970:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    1975:	48 29 e8             	sub    rax,rbp
    1978:	48 39 d8             	cmp    rax,rbx
    197b:	72 35                	jb     19b2 <gzram_base_decode_scalar+0x522>
    197d:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1982:	48 89 da             	mov    rdx,rbx
    1985:	4c 89 f7             	mov    rdi,r14
    1988:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    198d:	48 8d 34 28          	lea    rsi,[rax+rbp*1]
    1991:	48 01 dd             	add    rbp,rbx
    1994:	e8 00 00 00 00       	call   1999 <gzram_base_decode_scalar+0x509>
    1999:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    199e:	e9 3f fd ff ff       	jmp    16e2 <gzram_base_decode_scalar+0x252>
    19a3:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    19a8:	b9 20 00 00 00       	mov    ecx,0x20
    19ad:	e9 63 fc ff ff       	jmp    1615 <gzram_base_decode_scalar+0x185>
    19b2:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    19b9:	00 
    19ba:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    19c1:	00 
    19c2:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    19c9:	00 
    19ca:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    19d1:	00 
    19d2:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    19d9:	00 
    19da:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    19df:	b8 ff ff ff ff       	mov    eax,0xffffffff
    19e4:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    19eb:	c3                   	ret
    19ec:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    19f0:	4d 8b 48 e0          	mov    r9,QWORD PTR [r8-0x20]
    19f4:	4e 89 4c 20 e0       	mov    QWORD PTR [rax+r12*1-0x20],r9
    19f9:	4d 8b 48 e8          	mov    r9,QWORD PTR [r8-0x18]
    19fd:	4e 89 4c 20 e8       	mov    QWORD PTR [rax+r12*1-0x18],r9
    1a02:	4d 8b 48 f0          	mov    r9,QWORD PTR [r8-0x10]
    1a06:	4e 89 4c 20 f0       	mov    QWORD PTR [rax+r12*1-0x10],r9
    1a0b:	4d 8b 48 f8          	mov    r9,QWORD PTR [r8-0x8]
    1a0f:	4e 89 4c 20 f8       	mov    QWORD PTR [rax+r12*1-0x8],r9
    1a14:	41 83 fa 20          	cmp    r10d,0x20
    1a18:	0f 82 af fc ff ff    	jb     16cd <gzram_base_decode_scalar+0x23d>
    1a1e:	48 89 5c 24 18       	mov    QWORD PTR [rsp+0x18],rbx
    1a23:	45 31 c9             	xor    r9d,r9d
    1a26:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
    1a2b:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    1a30:	48 89 54 24 30       	mov    QWORD PTR [rsp+0x30],rdx
    1a35:	44 89 c9             	mov    ecx,r9d
    1a38:	41 83 c1 20          	add    r9d,0x20
    1a3c:	4c 8b 74 0f 08       	mov    r14,QWORD PTR [rdi+rcx*1+0x8]
    1a41:	48 8b 5c 0f 10       	mov    rbx,QWORD PTR [rdi+rcx*1+0x10]
    1a46:	48 8b 74 0f 18       	mov    rsi,QWORD PTR [rdi+rcx*1+0x18]
    1a4b:	48 8b 14 0f          	mov    rdx,QWORD PTR [rdi+rcx*1]
    1a4f:	4c 89 74 08 08       	mov    QWORD PTR [rax+rcx*1+0x8],r14
    1a54:	48 89 14 08          	mov    QWORD PTR [rax+rcx*1],rdx
    1a58:	48 89 5c 08 10       	mov    QWORD PTR [rax+rcx*1+0x10],rbx
    1a5d:	48 89 74 08 18       	mov    QWORD PTR [rax+rcx*1+0x18],rsi
    1a62:	44 3b 4c 24 08       	cmp    r9d,DWORD PTR [rsp+0x8]
    1a67:	72 cc                	jb     1a35 <gzram_base_decode_scalar+0x5a5>
    1a69:	48 8b 5c 24 18       	mov    rbx,QWORD PTR [rsp+0x18]
    1a6e:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
    1a73:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1a78:	48 8b 54 24 30       	mov    rdx,QWORD PTR [rsp+0x30]
    1a7d:	e9 4b fc ff ff       	jmp    16cd <gzram_base_decode_scalar+0x23d>
    1a82:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1a88:	c7 01 00 00 00 00    	mov    DWORD PTR [rcx],0x0
    1a8e:	e9 40 fe ff ff       	jmp    18d3 <gzram_base_decode_scalar+0x443>
    1a93:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1a98:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    1a9b:	48 89 30             	mov    QWORD PTR [rax],rsi
    1a9e:	48 8b 77 08          	mov    rsi,QWORD PTR [rdi+0x8]
    1aa2:	48 89 70 08          	mov    QWORD PTR [rax+0x8],rsi
    1aa6:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1aaa:	48 8d 44 30 10       	lea    rax,[rax+rsi*1+0x10]
    1aaf:	48 8d 74 37 10       	lea    rsi,[rdi+rsi*1+0x10]
    1ab4:	4c 8b 4e e0          	mov    r9,QWORD PTR [rsi-0x20]
    1ab8:	4c 89 48 e0          	mov    QWORD PTR [rax-0x20],r9
    1abc:	48 8b 76 e8          	mov    rsi,QWORD PTR [rsi-0x18]
    1ac0:	48 89 70 e8          	mov    QWORD PTR [rax-0x18],rsi
    1ac4:	e9 04 fc ff ff       	jmp    16cd <gzram_base_decode_scalar+0x23d>
    1ac9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1ad0:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    1ad3:	48 89 30             	mov    QWORD PTR [rax],rsi
    1ad6:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1ada:	4c 8b 4c 37 f8       	mov    r9,QWORD PTR [rdi+rsi*1-0x8]
    1adf:	4c 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],r9
    1ae4:	e9 e4 fb ff ff       	jmp    16cd <gzram_base_decode_scalar+0x23d>
    1ae9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1af0:	8b 37                	mov    esi,DWORD PTR [rdi]
    1af2:	89 30                	mov    DWORD PTR [rax],esi
    1af4:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1af8:	44 8b 4c 37 fc       	mov    r9d,DWORD PTR [rdi+rsi*1-0x4]
    1afd:	44 89 4c 30 fc       	mov    DWORD PTR [rax+rsi*1-0x4],r9d
    1b02:	e9 c6 fb ff ff       	jmp    16cd <gzram_base_decode_scalar+0x23d>
    1b07:	0f b7 74 0f fe       	movzx  esi,WORD PTR [rdi+rcx*1-0x2]
    1b0c:	66 89 74 01 fe       	mov    WORD PTR [rcx+rax*1-0x2],si
    1b11:	e9 b7 fb ff ff       	jmp    16cd <gzram_base_decode_scalar+0x23d>
    1b16:	48 8d 77 08          	lea    rsi,[rdi+0x8]
    1b1a:	4c 89 c2             	mov    rdx,r8
    1b1d:	4c 89 f7             	mov    rdi,r14
    1b20:	e8 00 00 00 00       	call   1b25 <gzram_base_decode_scalar+0x695>
    1b25:	e9 bc fa ff ff       	jmp    15e6 <gzram_base_decode_scalar+0x156>
    1b2a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1b31:	00 
    1b32:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1b39:	00 
    1b3a:	e9 9b fe ff ff       	jmp    19da <gzram_base_decode_scalar+0x54a>
    1b3f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1b44:	c3                   	ret
    1b45:	41 ba 08 00 00 00    	mov    r10d,0x8
    1b4b:	e9 bc fb ff ff       	jmp    170c <gzram_base_decode_scalar+0x27c>
    1b50:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1b57:	00 
    1b58:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1b5f:	00 
    1b60:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1b67:	00 
    1b68:	e9 6d fe ff ff       	jmp    19da <gzram_base_decode_scalar+0x54a>
    1b6d:	0f 1f 00             	nop    DWORD PTR [rax]

0000000000001b70 <gzram_base_decode_avx2>:
    1b70:	48 83 ec 78          	sub    rsp,0x78
    1b74:	48 89 5c 24 48       	mov    QWORD PTR [rsp+0x48],rbx
    1b79:	48 89 cb             	mov    rbx,rcx
    1b7c:	48 89 6c 24 50       	mov    QWORD PTR [rsp+0x50],rbp
    1b81:	48 89 d5             	mov    rbp,rdx
    1b84:	4c 89 64 24 58       	mov    QWORD PTR [rsp+0x58],r12
    1b89:	49 89 fc             	mov    r12,rdi
    1b8c:	4c 89 74 24 68       	mov    QWORD PTR [rsp+0x68],r14
    1b91:	49 89 f6             	mov    r14,rsi
    1b94:	e8 00 00 00 00       	call   1b99 <gzram_base_decode_avx2+0x29>
    1b99:	85 c0                	test   eax,eax
    1b9b:	0f 84 af 00 00 00    	je     1c50 <gzram_base_decode_avx2+0xe0>
    1ba1:	49 8d 46 f8          	lea    rax,[r14-0x8]
    1ba5:	48 3d 00 10 00 00    	cmp    rax,0x1000
    1bab:	0f 87 ff 01 00 00    	ja     1db0 <gzram_base_decode_avx2+0x240>
    1bb1:	4d 85 e4             	test   r12,r12
    1bb4:	0f 84 f6 01 00 00    	je     1db0 <gzram_base_decode_avx2+0x240>
    1bba:	41 81 3c 24 47 5a 52 	cmp    DWORD PTR [r12],0x31525a47
    1bc1:	31 
    1bc2:	0f 85 e8 01 00 00    	jne    1db0 <gzram_base_decode_avx2+0x240>
    1bc8:	41 0f b6 4c 24 06    	movzx  ecx,BYTE PTR [r12+0x6]
    1bce:	8d 41 fb             	lea    eax,[rcx-0x5]
    1bd1:	3c 07                	cmp    al,0x7
    1bd3:	0f 87 d7 01 00 00    	ja     1db0 <gzram_base_decode_avx2+0x240>
    1bd9:	41 0f b6 7c 24 07    	movzx  edi,BYTE PTR [r12+0x7]
    1bdf:	40 80 ff 01          	cmp    dil,0x1
    1be3:	0f 87 c7 01 00 00    	ja     1db0 <gzram_base_decode_avx2+0x240>
    1be9:	b8 00 10 00 00       	mov    eax,0x1000
    1bee:	41 0f b7 54 24 04    	movzx  edx,WORD PTR [r12+0x4]
    1bf4:	48 39 c3             	cmp    rbx,rax
    1bf7:	48 0f 46 c3          	cmovbe rax,rbx
    1bfb:	49 89 d2             	mov    r10,rdx
    1bfe:	48 39 d0             	cmp    rax,rdx
    1c01:	0f 82 a9 01 00 00    	jb     1db0 <gzram_base_decode_avx2+0x240>
    1c07:	48 85 ed             	test   rbp,rbp
    1c0a:	75 09                	jne    1c15 <gzram_base_decode_avx2+0xa5>
    1c0c:	48 85 d2             	test   rdx,rdx
    1c0f:	0f 85 9b 01 00 00    	jne    1db0 <gzram_base_decode_avx2+0x240>
    1c15:	40 84 ff             	test   dil,dil
    1c18:	74 66                	je     1c80 <gzram_base_decode_avx2+0x110>
    1c1a:	48 8d 42 08          	lea    rax,[rdx+0x8]
    1c1e:	49 39 c6             	cmp    r14,rax
    1c21:	0f 85 89 01 00 00    	jne    1db0 <gzram_base_decode_avx2+0x240>
    1c27:	48 85 d2             	test   rdx,rdx
    1c2a:	0f 85 18 03 00 00    	jne    1f48 <gzram_base_decode_avx2+0x3d8>
    1c30:	41 0f b7 c2          	movzx  eax,r10w
    1c34:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1c39:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1c3e:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1c43:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1c48:	48 83 c4 78          	add    rsp,0x78
    1c4c:	c3                   	ret
    1c4d:	0f 1f 00             	nop    DWORD PTR [rax]
    1c50:	48 89 d9             	mov    rcx,rbx
    1c53:	48 89 ea             	mov    rdx,rbp
    1c56:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1c5b:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1c60:	4c 89 f6             	mov    rsi,r14
    1c63:	4c 89 e7             	mov    rdi,r12
    1c66:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1c6b:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1c70:	48 83 c4 78          	add    rsp,0x78
    1c74:	e9 00 00 00 00       	jmp    1c79 <gzram_base_decode_avx2+0x109>
    1c79:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1c80:	41 b9 01 00 00 00    	mov    r9d,0x1
    1c86:	49 d3 e1             	shl    r9,cl
    1c89:	4a 8d 44 0a ff       	lea    rax,[rdx+r9*1-0x1]
    1c8e:	48 d3 e8             	shr    rax,cl
    1c91:	48 8d 58 08          	lea    rbx,[rax+0x8]
    1c95:	49 39 de             	cmp    r14,rbx
    1c98:	0f 82 12 01 00 00    	jb     1db0 <gzram_base_decode_avx2+0x240>
    1c9e:	48 85 c0             	test   rax,rax
    1ca1:	0f 84 e1 02 00 00    	je     1f88 <gzram_base_decode_avx2+0x418>
    1ca7:	49 8d 44 04 08       	lea    rax,[r12+rax*1+0x8]
    1cac:	66 44 89 54 24 3e    	mov    WORD PTR [rsp+0x3e],r10w
    1cb2:	4d 8d 44 24 08       	lea    r8,[r12+0x8]
    1cb7:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
    1cbc:	48 8d 44 15 00       	lea    rax,[rbp+rdx*1+0x0]
    1cc1:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
    1cc6:	4c 89 24 24          	mov    QWORD PTR [rsp],r12
    1cca:	4c 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],r13
    1ccf:	4c 8d 2d 00 00 00 00 	lea    r13,[rip+0x0]        # 1cd6 <gzram_base_decode_avx2+0x166>
    1cd6:	4c 89 7c 24 70       	mov    QWORD PTR [rsp+0x70],r15
    1cdb:	4d 89 cf             	mov    r15,r9
    1cde:	4c 89 74 24 10       	mov    QWORD PTR [rsp+0x10],r14
    1ce3:	49 89 ee             	mov    r14,rbp
    1ce6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1ced:	00 00 00 
    1cf0:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
    1cf5:	4c 29 f5             	sub    rbp,r14
    1cf8:	4c 39 fd             	cmp    rbp,r15
    1cfb:	49 0f 47 ef          	cmova  rbp,r15
    1cff:	41 80 38 06          	cmp    BYTE PTR [r8],0x6
    1d03:	0f 87 5f 02 00 00    	ja     1f68 <gzram_base_decode_avx2+0x3f8>
    1d09:	41 0f b6 00          	movzx  eax,BYTE PTR [r8]
    1d0d:	49 63 44 85 00       	movsxd rax,DWORD PTR [r13+rax*4+0x0]
    1d12:	4c 01 e8             	add    rax,r13
    1d15:	ff e0                	jmp    rax
    1d17:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    1d1e:	00 00 
    1d20:	41 ba 08 00 00 00    	mov    r10d,0x8
    1d26:	b9 08 00 00 00       	mov    ecx,0x8
    1d2b:	48 89 e8             	mov    rax,rbp
    1d2e:	31 d2                	xor    edx,edx
    1d30:	49 f7 f2             	div    r10
    1d33:	48 85 d2             	test   rdx,rdx
    1d36:	0f 85 2c 02 00 00    	jne    1f68 <gzram_base_decode_avx2+0x3f8>
    1d3c:	4c 39 d5             	cmp    rbp,r10
    1d3f:	0f 82 23 02 00 00    	jb     1f68 <gzram_base_decode_avx2+0x3f8>
    1d45:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1d4a:	48 29 d8             	sub    rax,rbx
    1d4d:	4c 39 d0             	cmp    rax,r10
    1d50:	0f 82 12 02 00 00    	jb     1f68 <gzram_base_decode_avx2+0x3f8>
    1d56:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1d5a:	48 89 ea             	mov    rdx,rbp
    1d5d:	4c 89 f7             	mov    rdi,r14
    1d60:	4c 89 44 24 28       	mov    QWORD PTR [rsp+0x28],r8
    1d65:	4c 89 54 24 20       	mov    QWORD PTR [rsp+0x20],r10
    1d6a:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1d6e:	e8 0d e3 ff ff       	call   80 <repeat_avx2>
    1d73:	4c 8b 44 24 28       	mov    r8,QWORD PTR [rsp+0x28]
    1d78:	48 03 5c 24 20       	add    rbx,QWORD PTR [rsp+0x20]
    1d7d:	49 83 c0 01          	add    r8,0x1
    1d81:	4d 01 fe             	add    r14,r15
    1d84:	4c 39 44 24 18       	cmp    QWORD PTR [rsp+0x18],r8
    1d89:	0f 85 61 ff ff ff    	jne    1cf0 <gzram_base_decode_avx2+0x180>
    1d8f:	44 0f b7 54 24 3e    	movzx  r10d,WORD PTR [rsp+0x3e]
    1d95:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
    1d9a:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    1d9f:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    1da4:	49 39 de             	cmp    r14,rbx
    1da7:	0f 84 83 fe ff ff    	je     1c30 <gzram_base_decode_avx2+0xc0>
    1dad:	0f 1f 00             	nop    DWORD PTR [rax]
    1db0:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1db5:	e9 7a fe ff ff       	jmp    1c34 <gzram_base_decode_avx2+0xc4>
    1dba:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1dc0:	41 ba 04 00 00 00    	mov    r10d,0x4
    1dc6:	b9 04 00 00 00       	mov    ecx,0x4
    1dcb:	e9 5b ff ff ff       	jmp    1d2b <gzram_base_decode_avx2+0x1bb>
    1dd0:	48 89 ea             	mov    rdx,rbp
    1dd3:	31 f6                	xor    esi,esi
    1dd5:	4c 89 f7             	mov    rdi,r14
    1dd8:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1ddd:	e8 00 00 00 00       	call   1de2 <gzram_base_decode_avx2+0x272>
    1de2:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1de7:	eb 94                	jmp    1d7d <gzram_base_decode_avx2+0x20d>
    1de9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1df0:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1df5:	48 29 d8             	sub    rax,rbx
    1df8:	48 39 e8             	cmp    rax,rbp
    1dfb:	0f 82 67 01 00 00    	jb     1f68 <gzram_base_decode_avx2+0x3f8>
    1e01:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1e05:	48 89 ea             	mov    rdx,rbp
    1e08:	4c 89 f7             	mov    rdi,r14
    1e0b:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1e10:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1e14:	48 01 eb             	add    rbx,rbp
    1e17:	e8 00 00 00 00       	call   1e1c <gzram_base_decode_avx2+0x2ac>
    1e1c:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1e21:	e9 57 ff ff ff       	jmp    1d7d <gzram_base_decode_avx2+0x20d>
    1e26:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1e2d:	00 00 00 
    1e30:	41 ba 20 00 00 00    	mov    r10d,0x20
    1e36:	b9 20 00 00 00       	mov    ecx,0x20
    1e3b:	e9 eb fe ff ff       	jmp    1d2b <gzram_base_decode_avx2+0x1bb>
    1e40:	41 ba 10 00 00 00    	mov    r10d,0x10
    1e46:	b9 10 00 00 00       	mov    ecx,0x10
    1e4b:	e9 db fe ff ff       	jmp    1d2b <gzram_base_decode_avx2+0x1bb>
    1e50:	48 89 e9             	mov    rcx,rbp
    1e53:	83 e1 1f             	and    ecx,0x1f
    1e56:	0f 85 0c 01 00 00    	jne    1f68 <gzram_base_decode_avx2+0x3f8>
    1e5c:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1e61:	48 c1 ed 05          	shr    rbp,0x5
    1e65:	48 29 d8             	sub    rax,rbx
    1e68:	48 39 e8             	cmp    rax,rbp
    1e6b:	0f 82 f7 00 00 00    	jb     1f68 <gzram_base_decode_avx2+0x3f8>
    1e71:	48 8d 74 1d 00       	lea    rsi,[rbp+rbx*1+0x0]
    1e76:	48 85 ed             	test   rbp,rbp
    1e79:	0f 84 01 01 00 00    	je     1f80 <gzram_base_decode_avx2+0x410>
    1e7f:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1e83:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 1e8a <gzram_base_decode_avx2+0x31a>
    1e8a:	48 01 d8             	add    rax,rbx
    1e8d:	48 8d 14 28          	lea    rdx,[rax+rbp*1]
    1e91:	49 89 c3             	mov    r11,rax
    1e94:	90                   	nop
    1e95:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1e9c:	00 00 00 00 
    1ea0:	41 0f b6 3b          	movzx  edi,BYTE PTR [r11]
    1ea4:	49 83 c3 01          	add    r11,0x1
    1ea8:	41 0f b6 3c 3a       	movzx  edi,BYTE PTR [r10+rdi*1]
    1ead:	8d 3c bd 00 00 00 00 	lea    edi,[rdi*4+0x0]
    1eb4:	48 01 f9             	add    rcx,rdi
    1eb7:	49 39 d3             	cmp    r11,rdx
    1eba:	75 e4                	jne    1ea0 <gzram_base_decode_avx2+0x330>
    1ebc:	4c 8b 5c 24 10       	mov    r11,QWORD PTR [rsp+0x10]
    1ec1:	49 29 f3             	sub    r11,rsi
    1ec4:	49 39 cb             	cmp    r11,rcx
    1ec7:	0f 82 9b 00 00 00    	jb     1f68 <gzram_base_decode_avx2+0x3f8>
    1ecd:	4c 89 44 24 30       	mov    QWORD PTR [rsp+0x30],r8
    1ed2:	48 89 c3             	mov    rbx,rax
    1ed5:	48 89 d5             	mov    rbp,rdx
    1ed8:	4c 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],r15
    1edd:	4d 89 f7             	mov    r15,r14
    1ee0:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    1ee5:	49 89 f6             	mov    r14,rsi
    1ee8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    1eef:	00 
    1ef0:	44 0f b6 23          	movzx  r12d,BYTE PTR [rbx]
    1ef4:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1ef8:	4c 89 fe             	mov    rsi,r15
    1efb:	48 83 c3 01          	add    rbx,0x1
    1eff:	49 83 c7 20          	add    r15,0x20
    1f03:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
    1f07:	44 89 e2             	mov    edx,r12d
    1f0a:	e8 b1 e3 ff ff       	call   2c0 <unpack_avx2>
    1f0f:	44 89 e2             	mov    edx,r12d
    1f12:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 1f19 <gzram_base_decode_avx2+0x3a9>
    1f19:	41 0f b6 14 12       	movzx  edx,BYTE PTR [r10+rdx*1]
    1f1e:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
    1f25:	49 01 d6             	add    r14,rdx
    1f28:	48 39 eb             	cmp    rbx,rbp
    1f2b:	75 c3                	jne    1ef0 <gzram_base_decode_avx2+0x380>
    1f2d:	4c 89 f3             	mov    rbx,r14
    1f30:	4c 8b 7c 24 20       	mov    r15,QWORD PTR [rsp+0x20]
    1f35:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1f3a:	4c 8b 44 24 30       	mov    r8,QWORD PTR [rsp+0x30]
    1f3f:	e9 39 fe ff ff       	jmp    1d7d <gzram_base_decode_avx2+0x20d>
    1f44:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1f48:	49 8d 74 24 08       	lea    rsi,[r12+0x8]
    1f4d:	48 89 ef             	mov    rdi,rbp
    1f50:	44 89 14 24          	mov    DWORD PTR [rsp],r10d
    1f54:	e8 00 00 00 00       	call   1f59 <gzram_base_decode_avx2+0x3e9>
    1f59:	44 8b 14 24          	mov    r10d,DWORD PTR [rsp]
    1f5d:	e9 ce fc ff ff       	jmp    1c30 <gzram_base_decode_avx2+0xc0>
    1f62:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1f68:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    1f6d:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    1f72:	e9 39 fe ff ff       	jmp    1db0 <gzram_base_decode_avx2+0x240>
    1f77:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    1f7e:	00 00 
    1f80:	48 89 f3             	mov    rbx,rsi
    1f83:	e9 f5 fd ff ff       	jmp    1d7d <gzram_base_decode_avx2+0x20d>
    1f88:	bb 08 00 00 00       	mov    ebx,0x8
    1f8d:	e9 12 fe ff ff       	jmp    1da4 <gzram_base_decode_avx2+0x234>
