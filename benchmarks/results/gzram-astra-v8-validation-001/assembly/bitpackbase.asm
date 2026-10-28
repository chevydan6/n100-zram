
build/astra-v8/hybrid-bitpackbase.o:     file format elf64-x86-64


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

0000000000000350 <gzram_avx2_available>:
     350:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 357 <gzram_avx2_available+0x7>
     357:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     35b:	c0 e8 02             	shr    al,0x2
     35e:	83 e0 01             	and    eax,0x1
     361:	c3                   	ret
     362:	0f 1f 00             	nop    DWORD PTR [rax]
     365:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     36c:	00 00 00 00 

0000000000000370 <gzram_base_encode_scalar>:
     370:	41 8d 40 fb          	lea    eax,[r8-0x5]
     374:	83 f8 07             	cmp    eax,0x7
     377:	0f 87 eb 00 00 00    	ja     468 <gzram_base_encode_scalar+0xf8>
     37d:	48 81 fe 00 10 00 00 	cmp    rsi,0x1000
     384:	0f 87 de 00 00 00    	ja     468 <gzram_base_encode_scalar+0xf8>
     38a:	48 85 d2             	test   rdx,rdx
     38d:	0f 84 d5 00 00 00    	je     468 <gzram_base_encode_scalar+0xf8>
     393:	48 85 ff             	test   rdi,rdi
     396:	41 0f 94 c1          	sete   r9b
     39a:	48 85 f6             	test   rsi,rsi
     39d:	0f 95 c0             	setne  al
     3a0:	41 84 c1             	test   r9b,al
     3a3:	0f 85 bf 00 00 00    	jne    468 <gzram_base_encode_scalar+0xf8>
     3a9:	48 83 f9 07          	cmp    rcx,0x7
     3ad:	0f 86 b5 00 00 00    	jbe    468 <gzram_base_encode_scalar+0xf8>
     3b3:	48 81 ec 38 01 00 00 	sub    rsp,0x138
     3ba:	48 89 c8             	mov    rax,rcx
     3bd:	41 bb 01 00 00 00    	mov    r11d,0x1
     3c3:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
     3c8:	44 89 c1             	mov    ecx,r8d
     3cb:	49 d3 e3             	shl    r11,cl
     3ce:	4c 89 bc 24 30 01 00 	mov    QWORD PTR [rsp+0x130],r15
     3d5:	00 
     3d6:	49 89 d7             	mov    r15,rdx
     3d9:	49 8d 54 33 ff       	lea    rdx,[r11+rsi*1-0x1]
     3de:	4c 89 b4 24 28 01 00 	mov    QWORD PTR [rsp+0x128],r14
     3e5:	00 
     3e6:	45 89 c6             	mov    r14d,r8d
     3e9:	48 d3 ea             	shr    rdx,cl
     3ec:	48 89 ac 24 10 01 00 	mov    QWORD PTR [rsp+0x110],rbp
     3f3:	00 
     3f4:	48 89 f5             	mov    rbp,rsi
     3f7:	48 8d 76 08          	lea    rsi,[rsi+0x8]
     3fb:	4c 8d 42 08          	lea    r8,[rdx+0x8]
     3ff:	4c 89 a4 24 18 01 00 	mov    QWORD PTR [rsp+0x118],r12
     406:	00 
     407:	49 89 fc             	mov    r12,rdi
     40a:	4c 39 c0             	cmp    rax,r8
     40d:	73 60                	jae    46f <gzram_base_encode_scalar+0xff>
     40f:	48 39 f0             	cmp    rax,rsi
     412:	72 57                	jb     46b <gzram_base_encode_scalar+0xfb>
     414:	48 85 ed             	test   rbp,rbp
     417:	0f 85 b5 04 00 00    	jne    8d2 <gzram_base_encode_scalar+0x562>
     41d:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     424:	8d 45 08             	lea    eax,[rbp+0x8]
     427:	41 88 6f 04          	mov    BYTE PTR [r15+0x4],bpl
     42b:	41 c6 47 05 00       	mov    BYTE PTR [r15+0x5],0x0
     430:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     434:	41 c6 47 07 01       	mov    BYTE PTR [r15+0x7],0x1
     439:	48 8b ac 24 10 01 00 	mov    rbp,QWORD PTR [rsp+0x110]
     440:	00 
     441:	4c 8b a4 24 18 01 00 	mov    r12,QWORD PTR [rsp+0x118]
     448:	00 
     449:	4c 8b b4 24 28 01 00 	mov    r14,QWORD PTR [rsp+0x128]
     450:	00 
     451:	4c 8b bc 24 30 01 00 	mov    r15,QWORD PTR [rsp+0x130]
     458:	00 
     459:	48 81 c4 38 01 00 00 	add    rsp,0x138
     460:	c3                   	ret
     461:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     468:	31 c0                	xor    eax,eax
     46a:	c3                   	ret
     46b:	31 c0                	xor    eax,eax
     46d:	eb ca                	jmp    439 <gzram_base_encode_scalar+0xc9>
     46f:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     476:	66 41 89 6f 04       	mov    WORD PTR [r15+0x4],bp
     47b:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     47f:	41 c6 47 07 00       	mov    BYTE PTR [r15+0x7],0x0
     484:	48 85 d2             	test   rdx,rdx
     487:	0f 84 80 07 00 00    	je     c0d <gzram_base_encode_scalar+0x89d>
     48d:	49 8d 7f 08          	lea    rdi,[r15+0x8]
     491:	48 89 9c 24 08 01 00 	mov    QWORD PTR [rsp+0x108],rbx
     498:	00 
     499:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 4a0 <gzram_base_encode_scalar+0x130>
     4a0:	48 8d 04 17          	lea    rax,[rdi+rdx*1]
     4a4:	4c 89 ac 24 20 01 00 	mov    QWORD PTR [rsp+0x120],r13
     4ab:	00 
     4ac:	49 89 fd             	mov    r13,rdi
     4af:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
     4b4:	49 8d 04 2c          	lea    rax,[r12+rbp*1]
     4b8:	4c 89 7c 24 18       	mov    QWORD PTR [rsp+0x18],r15
     4bd:	4d 89 df             	mov    r15,r11
     4c0:	44 89 74 24 44       	mov    DWORD PTR [rsp+0x44],r14d
     4c5:	4d 89 c6             	mov    r14,r8
     4c8:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
     4cd:	48 89 74 24 28       	mov    QWORD PTR [rsp+0x28],rsi
     4d2:	48 89 7c 24 48       	mov    QWORD PTR [rsp+0x48],rdi
     4d7:	4c 89 64 24 30       	mov    QWORD PTR [rsp+0x30],r12
     4dc:	48 89 6c 24 38       	mov    QWORD PTR [rsp+0x38],rbp
     4e1:	eb 44                	jmp    527 <gzram_base_encode_scalar+0x1b7>
     4e3:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     4e8:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
     4ed:	4c 29 f0             	sub    rax,r14
     4f0:	48 39 e8             	cmp    rax,rbp
     4f3:	0f 82 75 01 00 00    	jb     66e <gzram_base_encode_scalar+0x2fe>
     4f9:	41 c6 45 00 00       	mov    BYTE PTR [r13+0x0],0x0
     4fe:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
     503:	48 89 ea             	mov    rdx,rbp
     506:	4c 89 e6             	mov    rsi,r12
     509:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
     50d:	49 01 ee             	add    r14,rbp
     510:	e8 00 00 00 00       	call   515 <gzram_base_encode_scalar+0x1a5>
     515:	4d 01 fc             	add    r12,r15
     518:	49 83 c5 01          	add    r13,0x1
     51c:	4c 39 6c 24 10       	cmp    QWORD PTR [rsp+0x10],r13
     521:	0f 84 72 03 00 00    	je     899 <gzram_base_encode_scalar+0x529>
     527:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
     52c:	4c 29 e5             	sub    rbp,r12
     52f:	4c 39 fd             	cmp    rbp,r15
     532:	49 0f 47 ef          	cmova  rbp,r15
     536:	40 f6 c5 1f          	test   bpl,0x1f
     53a:	75 ac                	jne    4e8 <gzram_base_encode_scalar+0x178>
     53c:	49 8b 3c 24          	mov    rdi,QWORD PTR [r12]
     540:	4d 8b 54 24 10       	mov    r10,QWORD PTR [r12+0x10]
     545:	4d 8b 44 24 08       	mov    r8,QWORD PTR [r12+0x8]
     54a:	4d 8b 4c 24 18       	mov    r9,QWORD PTR [r12+0x18]
     54f:	4c 39 d7             	cmp    rdi,r10
     552:	48 89 7c 24 58       	mov    QWORD PTR [rsp+0x58],rdi
     557:	4c 89 44 24 60       	mov    QWORD PTR [rsp+0x60],r8
     55c:	0f 94 c0             	sete   al
     55f:	4c 89 54 24 68       	mov    QWORD PTR [rsp+0x68],r10
     564:	4c 89 4c 24 70       	mov    QWORD PTR [rsp+0x70],r9
     569:	4c 39 c7             	cmp    rdi,r8
     56c:	0f 84 60 02 00 00    	je     7d2 <gzram_base_encode_scalar+0x462>
     572:	4d 39 c8             	cmp    r8,r9
     575:	75 08                	jne    57f <gzram_base_encode_scalar+0x20f>
     577:	84 c0                	test   al,al
     579:	0f 85 05 03 00 00    	jne    884 <gzram_base_encode_scalar+0x514>
     57f:	be 1f 00 00 00       	mov    esi,0x1f
     584:	b8 20 00 00 00       	mov    eax,0x20
     589:	41 bb 20 00 00 00    	mov    r11d,0x20
     58f:	48 83 fd 20          	cmp    rbp,0x20
     593:	0f 86 04 04 00 00    	jbe    99d <gzram_base_encode_scalar+0x62d>
     599:	48 39 e8             	cmp    rax,rbp
     59c:	0f 83 04 04 00 00    	jae    9a6 <gzram_base_encode_scalar+0x636>
     5a2:	48 89 f9             	mov    rcx,rdi
     5a5:	b8 20 00 00 00       	mov    eax,0x20
     5aa:	eb 23                	jmp    5cf <gzram_base_encode_scalar+0x25f>
     5ac:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     5b3:	00 00 
     5b5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     5bc:	00 00 00 00 
     5c0:	48 89 c2             	mov    rdx,rax
     5c3:	48 21 f2             	and    rdx,rsi
     5c6:	48 c1 ea 03          	shr    rdx,0x3
     5ca:	48 8b 4c d4 58       	mov    rcx,QWORD PTR [rsp+rdx*8+0x58]
     5cf:	49 8b 14 04          	mov    rdx,QWORD PTR [r12+rax*1]
     5d3:	48 83 c0 08          	add    rax,0x8
     5d7:	48 39 ca             	cmp    rdx,rcx
     5da:	0f 85 10 01 00 00    	jne    6f0 <gzram_base_encode_scalar+0x380>
     5e0:	48 39 e8             	cmp    rax,rbp
     5e3:	72 db                	jb     5c0 <gzram_base_encode_scalar+0x250>
     5e5:	48 39 ca             	cmp    rdx,rcx
     5e8:	0f 85 02 01 00 00    	jne    6f0 <gzram_base_encode_scalar+0x380>
     5ee:	48 85 ff             	test   rdi,rdi
     5f1:	0f 85 01 02 00 00    	jne    7f8 <gzram_base_encode_scalar+0x488>
     5f7:	4d 85 c0             	test   r8,r8
     5fa:	75 0e                	jne    60a <gzram_base_encode_scalar+0x29a>
     5fc:	4d 85 d2             	test   r10,r10
     5ff:	75 09                	jne    60a <gzram_base_encode_scalar+0x29a>
     601:	4d 85 c9             	test   r9,r9
     604:	0f 84 be 01 00 00    	je     7c8 <gzram_base_encode_scalar+0x458>
     60a:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     611:	01 00 00 00 
     615:	41 83 fb 08          	cmp    r11d,0x8
     619:	0f 84 b0 00 00 00    	je     6cf <gzram_base_encode_scalar+0x35f>
     61f:	41 83 fb 10          	cmp    r11d,0x10
     623:	0f 84 68 05 00 00    	je     b91 <gzram_base_encode_scalar+0x821>
     629:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x8
     630:	08 00 00 00 
     634:	48 83 fd 20          	cmp    rbp,0x20
     638:	0f 87 d9 02 00 00    	ja     917 <gzram_base_encode_scalar+0x5a7>
     63e:	bf 01 00 00 00       	mov    edi,0x1
     643:	49 89 e9             	mov    r9,rbp
     646:	48 8b 54 24 20       	mov    rdx,QWORD PTR [rsp+0x20]
     64b:	8d 04 bd 00 00 00 00 	lea    eax,[rdi*4+0x0]
     652:	49 c1 e9 05          	shr    r9,0x5
     656:	4c 01 c8             	add    rax,r9
     659:	4c 29 f2             	sub    rdx,r14
     65c:	48 39 e8             	cmp    rax,rbp
     65f:	0f 82 63 03 00 00    	jb     9c8 <gzram_base_encode_scalar+0x658>
     665:	48 39 ea             	cmp    rdx,rbp
     668:	0f 83 8b fe ff ff    	jae    4f9 <gzram_base_encode_scalar+0x189>
     66e:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
     673:	48 8b 7c 24 48       	mov    rdi,QWORD PTR [rsp+0x48]
     678:	31 c0                	xor    eax,eax
     67a:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     67f:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     684:	4c 8b 7c 24 18       	mov    r15,QWORD PTR [rsp+0x18]
     689:	44 8b 74 24 44       	mov    r14d,DWORD PTR [rsp+0x44]
     68e:	48 39 74 24 20       	cmp    QWORD PTR [rsp+0x20],rsi
     693:	0f 82 3b 05 00 00    	jb     bd4 <gzram_base_encode_scalar+0x864>
     699:	48 85 ed             	test   rbp,rbp
     69c:	0f 85 47 05 00 00    	jne    be9 <gzram_base_encode_scalar+0x879>
     6a2:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     6a9:	8d 45 08             	lea    eax,[rbp+0x8]
     6ac:	66 41 89 6f 04       	mov    WORD PTR [r15+0x4],bp
     6b1:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     6b5:	41 c6 47 07 01       	mov    BYTE PTR [r15+0x7],0x1
     6ba:	48 8b 9c 24 08 01 00 	mov    rbx,QWORD PTR [rsp+0x108]
     6c1:	00 
     6c2:	4c 8b ac 24 20 01 00 	mov    r13,QWORD PTR [rsp+0x120]
     6c9:	00 
     6ca:	e9 6a fd ff ff       	jmp    439 <gzram_base_encode_scalar+0xc9>
     6cf:	48 83 fd 04          	cmp    rbp,0x4
     6d3:	0f 86 20 fe ff ff    	jbe    4f9 <gzram_base_encode_scalar+0x189>
     6d9:	ba 02 00 00 00       	mov    edx,0x2
     6de:	b8 04 00 00 00       	mov    eax,0x4
     6e3:	e9 48 01 00 00       	jmp    830 <gzram_base_encode_scalar+0x4c0>
     6e8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     6ef:	00 
     6f0:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     6f7:	00 00 00 00 
     6fb:	49 89 e8             	mov    r8,rbp
     6fe:	49 c1 e8 05          	shr    r8,0x5
     702:	49 c1 e0 05          	shl    r8,0x5
     706:	48 8d 74 24 78       	lea    rsi,[rsp+0x78]
     70b:	4c 89 e0             	mov    rax,r12
     70e:	31 ff                	xor    edi,edi
     710:	4d 01 e0             	add    r8,r12
     713:	66 90                	xchg   ax,ax
     715:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     71c:	00 00 00 00 
     720:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
     723:	44 8b 48 08          	mov    r9d,DWORD PTR [rax+0x8]
     727:	31 d2                	xor    edx,edx
     729:	44 8b 10             	mov    r10d,DWORD PTR [rax]
     72c:	44 8b 58 0c          	mov    r11d,DWORD PTR [rax+0xc]
     730:	85 c9                	test   ecx,ecx
     732:	0f 95 c2             	setne  dl
     735:	31 c9                	xor    ecx,ecx
     737:	01 d2                	add    edx,edx
     739:	45 85 c9             	test   r9d,r9d
     73c:	44 8b 48 10          	mov    r9d,DWORD PTR [rax+0x10]
     740:	0f 95 c1             	setne  cl
     743:	c1 e1 02             	shl    ecx,0x2
     746:	09 ca                	or     edx,ecx
     748:	31 c9                	xor    ecx,ecx
     74a:	45 85 d2             	test   r10d,r10d
     74d:	44 8b 50 14          	mov    r10d,DWORD PTR [rax+0x14]
     751:	0f 95 c1             	setne  cl
     754:	09 ca                	or     edx,ecx
     756:	31 c9                	xor    ecx,ecx
     758:	45 85 db             	test   r11d,r11d
     75b:	44 8b 58 18          	mov    r11d,DWORD PTR [rax+0x18]
     75f:	0f 95 c1             	setne  cl
     762:	c1 e1 03             	shl    ecx,0x3
     765:	09 ca                	or     edx,ecx
     767:	31 c9                	xor    ecx,ecx
     769:	45 85 c9             	test   r9d,r9d
     76c:	44 8b 48 1c          	mov    r9d,DWORD PTR [rax+0x1c]
     770:	0f 95 c1             	setne  cl
     773:	c1 e1 04             	shl    ecx,0x4
     776:	09 d1                	or     ecx,edx
     778:	31 d2                	xor    edx,edx
     77a:	45 85 d2             	test   r10d,r10d
     77d:	0f 95 c2             	setne  dl
     780:	c1 e2 05             	shl    edx,0x5
     783:	09 ca                	or     edx,ecx
     785:	31 c9                	xor    ecx,ecx
     787:	45 85 db             	test   r11d,r11d
     78a:	0f 95 c1             	setne  cl
     78d:	c1 e1 06             	shl    ecx,0x6
     790:	09 d1                	or     ecx,edx
     792:	31 d2                	xor    edx,edx
     794:	45 85 c9             	test   r9d,r9d
     797:	0f 95 c2             	setne  dl
     79a:	48 83 c0 20          	add    rax,0x20
     79e:	48 83 c6 01          	add    rsi,0x1
     7a2:	c1 e2 07             	shl    edx,0x7
     7a5:	09 ca                	or     edx,ecx
     7a7:	88 56 ff             	mov    BYTE PTR [rsi-0x1],dl
     7aa:	0f b6 14 13          	movzx  edx,BYTE PTR [rbx+rdx*1]
     7ae:	01 d7                	add    edi,edx
     7b0:	49 39 c0             	cmp    r8,rax
     7b3:	0f 85 67 ff ff ff    	jne    720 <gzram_base_encode_scalar+0x3b0>
     7b9:	89 bc 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],edi
     7c0:	85 ff                	test   edi,edi
     7c2:	0f 85 7b fe ff ff    	jne    643 <gzram_base_encode_scalar+0x2d3>
     7c8:	41 c6 45 00 01       	mov    BYTE PTR [r13+0x0],0x1
     7cd:	e9 43 fd ff ff       	jmp    515 <gzram_base_encode_scalar+0x1a5>
     7d2:	4c 39 cf             	cmp    rdi,r9
     7d5:	0f 85 a4 fd ff ff    	jne    57f <gzram_base_encode_scalar+0x20f>
     7db:	84 c0                	test   al,al
     7dd:	0f 84 9c fd ff ff    	je     57f <gzram_base_encode_scalar+0x20f>
     7e3:	be 07 00 00 00       	mov    esi,0x7
     7e8:	b8 08 00 00 00       	mov    eax,0x8
     7ed:	41 bb 08 00 00 00    	mov    r11d,0x8
     7f3:	e9 97 fd ff ff       	jmp    58f <gzram_base_encode_scalar+0x21f>
     7f8:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     7ff:	01 00 00 00 
     803:	41 83 fb 08          	cmp    r11d,0x8
     807:	0f 85 12 fe ff ff    	jne    61f <gzram_base_encode_scalar+0x2af>
     80d:	48 89 f8             	mov    rax,rdi
     810:	48 c1 e8 20          	shr    rax,0x20
     814:	39 c7                	cmp    edi,eax
     816:	0f 84 b3 fe ff ff    	je     6cf <gzram_base_encode_scalar+0x35f>
     81c:	48 83 fd 08          	cmp    rbp,0x8
     820:	0f 86 d3 fc ff ff    	jbe    4f9 <gzram_base_encode_scalar+0x189>
     826:	ba 03 00 00 00       	mov    edx,0x3
     82b:	b8 08 00 00 00       	mov    eax,0x8
     830:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
     835:	4c 29 f1             	sub    rcx,r14
     838:	48 39 c1             	cmp    rcx,rax
     83b:	0f 82 2d fe ff ff    	jb     66e <gzram_base_encode_scalar+0x2fe>
     841:	48 8b 7c 24 18       	mov    rdi,QWORD PTR [rsp+0x18]
     846:	41 88 55 00          	mov    BYTE PTR [r13+0x0],dl
     84a:	89 c2                	mov    edx,eax
     84c:	4a 8d 0c 37          	lea    rcx,[rdi+r14*1]
     850:	83 f8 20             	cmp    eax,0x20
     853:	0f 83 d7 00 00 00    	jae    930 <gzram_base_encode_scalar+0x5c0>
     859:	a8 10                	test   al,0x10
     85b:	0f 85 01 03 00 00    	jne    b62 <gzram_base_encode_scalar+0x7f2>
     861:	a8 08                	test   al,0x8
     863:	0f 85 41 03 00 00    	jne    baa <gzram_base_encode_scalar+0x83a>
     869:	a8 04                	test   al,0x4
     86b:	0f 85 4f 03 00 00    	jne    bc0 <gzram_base_encode_scalar+0x850>
     871:	85 c0                	test   eax,eax
     873:	74 07                	je     87c <gzram_base_encode_scalar+0x50c>
     875:	41 0f b6 14 24       	movzx  edx,BYTE PTR [r12]
     87a:	88 11                	mov    BYTE PTR [rcx],dl
     87c:	49 01 c6             	add    r14,rax
     87f:	e9 91 fc ff ff       	jmp    515 <gzram_base_encode_scalar+0x1a5>
     884:	be 0f 00 00 00       	mov    esi,0xf
     889:	b8 10 00 00 00       	mov    eax,0x10
     88e:	41 bb 10 00 00 00    	mov    r11d,0x10
     894:	e9 f6 fc ff ff       	jmp    58f <gzram_base_encode_scalar+0x21f>
     899:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
     89e:	4d 89 f0             	mov    r8,r14
     8a1:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     8a6:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     8ab:	4c 8b 7c 24 18       	mov    r15,QWORD PTR [rsp+0x18]
     8b0:	44 8b 74 24 44       	mov    r14d,DWORD PTR [rsp+0x44]
     8b5:	48 8b 9c 24 08 01 00 	mov    rbx,QWORD PTR [rsp+0x108]
     8bc:	00 
     8bd:	4c 8b ac 24 20 01 00 	mov    r13,QWORD PTR [rsp+0x120]
     8c4:	00 
     8c5:	49 39 f0             	cmp    r8,rsi
     8c8:	73 1c                	jae    8e6 <gzram_base_encode_scalar+0x576>
     8ca:	44 89 c0             	mov    eax,r8d
     8cd:	e9 67 fb ff ff       	jmp    439 <gzram_base_encode_scalar+0xc9>
     8d2:	49 8d 7f 08          	lea    rdi,[r15+0x8]
     8d6:	48 89 ea             	mov    rdx,rbp
     8d9:	4c 89 e6             	mov    rsi,r12
     8dc:	e8 00 00 00 00       	call   8e1 <gzram_base_encode_scalar+0x571>
     8e1:	e9 37 fb ff ff       	jmp    41d <gzram_base_encode_scalar+0xad>
     8e6:	48 39 74 24 20       	cmp    QWORD PTR [rsp+0x20],rsi
     8eb:	0f 82 7a fb ff ff    	jb     46b <gzram_base_encode_scalar+0xfb>
     8f1:	48 85 ed             	test   rbp,rbp
     8f4:	0f 85 ff 02 00 00    	jne    bf9 <gzram_base_encode_scalar+0x889>
     8fa:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     901:	8d 45 08             	lea    eax,[rbp+0x8]
     904:	66 41 89 6f 04       	mov    WORD PTR [r15+0x4],bp
     909:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     90d:	41 c6 47 07 01       	mov    BYTE PTR [r15+0x7],0x1
     912:	e9 22 fb ff ff       	jmp    439 <gzram_base_encode_scalar+0xc9>
     917:	ba 06 00 00 00       	mov    edx,0x6
     91c:	b8 20 00 00 00       	mov    eax,0x20
     921:	e9 0a ff ff ff       	jmp    830 <gzram_base_encode_scalar+0x4c0>
     926:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
     92d:	00 00 00 
     930:	49 8d 34 04          	lea    rsi,[r12+rax*1]
     934:	8d 50 ff             	lea    edx,[rax-0x1]
     937:	48 8b 7e e0          	mov    rdi,QWORD PTR [rsi-0x20]
     93b:	48 89 7c 08 e0       	mov    QWORD PTR [rax+rcx*1-0x20],rdi
     940:	48 8b 7e e8          	mov    rdi,QWORD PTR [rsi-0x18]
     944:	48 89 7c 08 e8       	mov    QWORD PTR [rax+rcx*1-0x18],rdi
     949:	48 8b 7e f0          	mov    rdi,QWORD PTR [rsi-0x10]
     94d:	48 89 7c 08 f0       	mov    QWORD PTR [rax+rcx*1-0x10],rdi
     952:	48 8b 76 f8          	mov    rsi,QWORD PTR [rsi-0x8]
     956:	48 89 74 08 f8       	mov    QWORD PTR [rax+rcx*1-0x8],rsi
     95b:	83 fa 20             	cmp    edx,0x20
     95e:	0f 82 18 ff ff ff    	jb     87c <gzram_base_encode_scalar+0x50c>
     964:	83 e2 e0             	and    edx,0xffffffe0
     967:	31 ff                	xor    edi,edi
     969:	89 fe                	mov    esi,edi
     96b:	83 c7 20             	add    edi,0x20
     96e:	4d 8b 1c 34          	mov    r11,QWORD PTR [r12+rsi*1]
     972:	4d 8b 54 34 08       	mov    r10,QWORD PTR [r12+rsi*1+0x8]
     977:	4d 8b 4c 34 10       	mov    r9,QWORD PTR [r12+rsi*1+0x10]
     97c:	4d 8b 44 34 18       	mov    r8,QWORD PTR [r12+rsi*1+0x18]
     981:	4c 89 1c 31          	mov    QWORD PTR [rcx+rsi*1],r11
     985:	4c 89 54 31 08       	mov    QWORD PTR [rcx+rsi*1+0x8],r10
     98a:	4c 89 4c 31 10       	mov    QWORD PTR [rcx+rsi*1+0x10],r9
     98f:	4c 89 44 31 18       	mov    QWORD PTR [rcx+rsi*1+0x18],r8
     994:	39 d7                	cmp    edi,edx
     996:	72 d1                	jb     969 <gzram_base_encode_scalar+0x5f9>
     998:	e9 df fe ff ff       	jmp    87c <gzram_base_encode_scalar+0x50c>
     99d:	48 39 e8             	cmp    rax,rbp
     9a0:	0f 82 48 fc ff ff    	jb     5ee <gzram_base_encode_scalar+0x27e>
     9a6:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     9ad:	00 00 00 00 
     9b1:	49 89 e8             	mov    r8,rbp
     9b4:	49 c1 e8 05          	shr    r8,0x5
     9b8:	0f 84 0a fe ff ff    	je     7c8 <gzram_base_encode_scalar+0x458>
     9be:	e9 3f fd ff ff       	jmp    702 <gzram_base_encode_scalar+0x392>
     9c3:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     9c8:	48 39 c2             	cmp    rdx,rax
     9cb:	0f 82 9d fc ff ff    	jb     66e <gzram_base_encode_scalar+0x2fe>
     9d1:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
     9d6:	41 c6 45 00 04       	mov    BYTE PTR [r13+0x0],0x4
     9db:	4c 01 f0             	add    rax,r14
     9de:	41 83 f9 20          	cmp    r9d,0x20
     9e2:	0f 83 f7 00 00 00    	jae    adf <gzram_base_encode_scalar+0x76f>
     9e8:	41 f6 c1 10          	test   r9b,0x10
     9ec:	0f 85 30 02 00 00    	jne    c22 <gzram_base_encode_scalar+0x8b2>
     9f2:	41 f6 c1 08          	test   r9b,0x8
     9f6:	0f 85 75 02 00 00    	jne    c71 <gzram_base_encode_scalar+0x901>
     9fc:	41 f6 c1 04          	test   r9b,0x4
     a00:	0f 85 55 02 00 00    	jne    c5b <gzram_base_encode_scalar+0x8eb>
     a06:	45 85 c9             	test   r9d,r9d
     a09:	74 11                	je     a1c <gzram_base_encode_scalar+0x6ac>
     a0b:	0f b6 54 24 78       	movzx  edx,BYTE PTR [rsp+0x78]
     a10:	88 10                	mov    BYTE PTR [rax],dl
     a12:	41 f6 c1 02          	test   r9b,0x2
     a16:	0f 85 6f 02 00 00    	jne    c8b <gzram_base_encode_scalar+0x91b>
     a1c:	4d 01 ce             	add    r14,r9
     a1f:	4d 85 c9             	test   r9,r9
     a22:	0f 84 ed fa ff ff    	je     515 <gzram_base_encode_scalar+0x1a5>
     a28:	49 c1 e1 05          	shl    r9,0x5
     a2c:	4c 8b 5c 24 18       	mov    r11,QWORD PTR [rsp+0x18]
     a31:	4c 8d 44 24 78       	lea    r8,[rsp+0x78]
     a36:	4c 89 e7             	mov    rdi,r12
     a39:	4d 01 e1             	add    r9,r12
     a3c:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # a43 <gzram_base_encode_scalar+0x6d3>
     a43:	66 90                	xchg   ax,ax
     a45:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     a4c:	00 00 00 00 
     a50:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
     a54:	4b 8d 14 33          	lea    rdx,[r11+r14*1]
     a58:	81 f9 ff 00 00 00    	cmp    ecx,0xff
     a5e:	74 5f                	je     abf <gzram_base_encode_scalar+0x74f>
     a60:	89 c8                	mov    eax,ecx
     a62:	85 c9                	test   ecx,ecx
     a64:	74 38                	je     a9e <gzram_base_encode_scalar+0x72e>
     a66:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     a6a:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     a71:	00 00 00 00 
     a75:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     a7c:	00 00 00 00 
     a80:	31 ed                	xor    ebp,ebp
     a82:	8d 70 ff             	lea    esi,[rax-0x1]
     a85:	48 83 c2 04          	add    rdx,0x4
     a89:	f3 0f bc e8          	tzcnt  ebp,eax
     a8d:	8d 2c ad 00 00 00 00 	lea    ebp,[rbp*4+0x0]
     a94:	8b 2c 2f             	mov    ebp,DWORD PTR [rdi+rbp*1]
     a97:	89 6a fc             	mov    DWORD PTR [rdx-0x4],ebp
     a9a:	21 f0                	and    eax,esi
     a9c:	75 e2                	jne    a80 <gzram_base_encode_scalar+0x710>
     a9e:	41 0f b6 04 0a       	movzx  eax,BYTE PTR [r10+rcx*1]
     aa3:	48 83 c7 20          	add    rdi,0x20
     aa7:	49 83 c0 01          	add    r8,0x1
     aab:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
     ab2:	49 01 c6             	add    r14,rax
     ab5:	4c 39 cf             	cmp    rdi,r9
     ab8:	75 96                	jne    a50 <gzram_base_encode_scalar+0x6e0>
     aba:	e9 56 fa ff ff       	jmp    515 <gzram_base_encode_scalar+0x1a5>
     abf:	48 8b 07             	mov    rax,QWORD PTR [rdi]
     ac2:	48 89 02             	mov    QWORD PTR [rdx],rax
     ac5:	48 8b 47 08          	mov    rax,QWORD PTR [rdi+0x8]
     ac9:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
     acd:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
     ad1:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
     ad5:	48 8b 47 18          	mov    rax,QWORD PTR [rdi+0x18]
     ad9:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
     add:	eb bf                	jmp    a9e <gzram_base_encode_scalar+0x72e>
     adf:	44 89 c9             	mov    ecx,r9d
     ae2:	48 8d 14 08          	lea    rdx,[rax+rcx*1]
     ae6:	48 8d 4c 0c 78       	lea    rcx,[rsp+rcx*1+0x78]
     aeb:	48 8b 71 e0          	mov    rsi,QWORD PTR [rcx-0x20]
     aef:	48 89 72 e0          	mov    QWORD PTR [rdx-0x20],rsi
     af3:	48 8b 71 e8          	mov    rsi,QWORD PTR [rcx-0x18]
     af7:	48 89 72 e8          	mov    QWORD PTR [rdx-0x18],rsi
     afb:	48 8b 71 f0          	mov    rsi,QWORD PTR [rcx-0x10]
     aff:	48 89 72 f0          	mov    QWORD PTR [rdx-0x10],rsi
     b03:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
     b07:	48 89 4a f8          	mov    QWORD PTR [rdx-0x8],rcx
     b0b:	41 8d 51 ff          	lea    edx,[r9-0x1]
     b0f:	83 fa 20             	cmp    edx,0x20
     b12:	0f 82 04 ff ff ff    	jb     a1c <gzram_base_encode_scalar+0x6ac>
     b18:	83 e2 e0             	and    edx,0xffffffe0
     b1b:	45 31 c0             	xor    r8d,r8d
     b1e:	41 89 d2             	mov    r10d,edx
     b21:	44 89 c2             	mov    edx,r8d
     b24:	41 83 c0 20          	add    r8d,0x20
     b28:	4c 8b 5c 14 78       	mov    r11,QWORD PTR [rsp+rdx*1+0x78]
     b2d:	48 8b bc 14 80 00 00 	mov    rdi,QWORD PTR [rsp+rdx*1+0x80]
     b34:	00 
     b35:	48 8b b4 14 88 00 00 	mov    rsi,QWORD PTR [rsp+rdx*1+0x88]
     b3c:	00 
     b3d:	48 8b 8c 14 90 00 00 	mov    rcx,QWORD PTR [rsp+rdx*1+0x90]
     b44:	00 
     b45:	4c 89 1c 10          	mov    QWORD PTR [rax+rdx*1],r11
     b49:	48 89 7c 10 08       	mov    QWORD PTR [rax+rdx*1+0x8],rdi
     b4e:	48 89 74 10 10       	mov    QWORD PTR [rax+rdx*1+0x10],rsi
     b53:	48 89 4c 10 18       	mov    QWORD PTR [rax+rdx*1+0x18],rcx
     b58:	45 39 d0             	cmp    r8d,r10d
     b5b:	72 c4                	jb     b21 <gzram_base_encode_scalar+0x7b1>
     b5d:	e9 ba fe ff ff       	jmp    a1c <gzram_base_encode_scalar+0x6ac>
     b62:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     b66:	48 89 31             	mov    QWORD PTR [rcx],rsi
     b69:	49 8b 74 24 08       	mov    rsi,QWORD PTR [r12+0x8]
     b6e:	48 89 71 08          	mov    QWORD PTR [rcx+0x8],rsi
     b72:	48 8d 4c 11 10       	lea    rcx,[rcx+rdx*1+0x10]
     b77:	49 8d 54 14 10       	lea    rdx,[r12+rdx*1+0x10]
     b7c:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
     b80:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
     b84:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     b88:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
     b8c:	e9 eb fc ff ff       	jmp    87c <gzram_base_encode_scalar+0x50c>
     b91:	48 83 fd 10          	cmp    rbp,0x10
     b95:	0f 86 5e f9 ff ff    	jbe    4f9 <gzram_base_encode_scalar+0x189>
     b9b:	ba 05 00 00 00       	mov    edx,0x5
     ba0:	b8 10 00 00 00       	mov    eax,0x10
     ba5:	e9 86 fc ff ff       	jmp    830 <gzram_base_encode_scalar+0x4c0>
     baa:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     bae:	48 89 31             	mov    QWORD PTR [rcx],rsi
     bb1:	49 8b 74 14 f8       	mov    rsi,QWORD PTR [r12+rdx*1-0x8]
     bb6:	48 89 74 11 f8       	mov    QWORD PTR [rcx+rdx*1-0x8],rsi
     bbb:	e9 bc fc ff ff       	jmp    87c <gzram_base_encode_scalar+0x50c>
     bc0:	41 8b 34 24          	mov    esi,DWORD PTR [r12]
     bc4:	89 31                	mov    DWORD PTR [rcx],esi
     bc6:	41 8b 74 14 fc       	mov    esi,DWORD PTR [r12+rdx*1-0x4]
     bcb:	89 74 11 fc          	mov    DWORD PTR [rcx+rdx*1-0x4],esi
     bcf:	e9 a8 fc ff ff       	jmp    87c <gzram_base_encode_scalar+0x50c>
     bd4:	48 8b 9c 24 08 01 00 	mov    rbx,QWORD PTR [rsp+0x108]
     bdb:	00 
     bdc:	4c 8b ac 24 20 01 00 	mov    r13,QWORD PTR [rsp+0x120]
     be3:	00 
     be4:	e9 50 f8 ff ff       	jmp    439 <gzram_base_encode_scalar+0xc9>
     be9:	48 89 ea             	mov    rdx,rbp
     bec:	4c 89 e6             	mov    rsi,r12
     bef:	e8 00 00 00 00       	call   bf4 <gzram_base_encode_scalar+0x884>
     bf4:	e9 a9 fa ff ff       	jmp    6a2 <gzram_base_encode_scalar+0x332>
     bf9:	49 8d 7f 08          	lea    rdi,[r15+0x8]
     bfd:	48 89 ea             	mov    rdx,rbp
     c00:	4c 89 e6             	mov    rsi,r12
     c03:	e8 00 00 00 00       	call   c08 <gzram_base_encode_scalar+0x898>
     c08:	e9 ed fc ff ff       	jmp    8fa <gzram_base_encode_scalar+0x58a>
     c0d:	41 b8 08 00 00 00    	mov    r8d,0x8
     c13:	48 83 fe 08          	cmp    rsi,0x8
     c17:	0f 85 ad fc ff ff    	jne    8ca <gzram_base_encode_scalar+0x55a>
     c1d:	e9 cf fc ff ff       	jmp    8f1 <gzram_base_encode_scalar+0x581>
     c22:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     c27:	48 89 10             	mov    QWORD PTR [rax],rdx
     c2a:	48 8b 94 24 80 00 00 	mov    rdx,QWORD PTR [rsp+0x80]
     c31:	00 
     c32:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     c36:	44 89 ca             	mov    edx,r9d
     c39:	48 8d 44 10 10       	lea    rax,[rax+rdx*1+0x10]
     c3e:	48 8d 94 14 88 00 00 	lea    rdx,[rsp+rdx*1+0x88]
     c45:	00 
     c46:	48 8b 4a e0          	mov    rcx,QWORD PTR [rdx-0x20]
     c4a:	48 89 48 e0          	mov    QWORD PTR [rax-0x20],rcx
     c4e:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     c52:	48 89 50 e8          	mov    QWORD PTR [rax-0x18],rdx
     c56:	e9 c1 fd ff ff       	jmp    a1c <gzram_base_encode_scalar+0x6ac>
     c5b:	8b 54 24 78          	mov    edx,DWORD PTR [rsp+0x78]
     c5f:	89 10                	mov    DWORD PTR [rax],edx
     c61:	44 89 ca             	mov    edx,r9d
     c64:	8b 4c 14 74          	mov    ecx,DWORD PTR [rsp+rdx*1+0x74]
     c68:	89 4c 10 fc          	mov    DWORD PTR [rax+rdx*1-0x4],ecx
     c6c:	e9 ab fd ff ff       	jmp    a1c <gzram_base_encode_scalar+0x6ac>
     c71:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     c76:	48 89 10             	mov    QWORD PTR [rax],rdx
     c79:	44 89 ca             	mov    edx,r9d
     c7c:	48 8b 4c 14 70       	mov    rcx,QWORD PTR [rsp+rdx*1+0x70]
     c81:	48 89 4c 10 f8       	mov    QWORD PTR [rax+rdx*1-0x8],rcx
     c86:	e9 91 fd ff ff       	jmp    a1c <gzram_base_encode_scalar+0x6ac>
     c8b:	44 89 ca             	mov    edx,r9d
     c8e:	0f b7 4c 14 76       	movzx  ecx,WORD PTR [rsp+rdx*1+0x76]
     c93:	66 89 4c 10 fe       	mov    WORD PTR [rax+rdx*1-0x2],cx
     c98:	e9 7f fd ff ff       	jmp    a1c <gzram_base_encode_scalar+0x6ac>
     c9d:	0f 1f 00             	nop    DWORD PTR [rax]

0000000000000ca0 <gzram_base_encode_avx2>:
     ca0:	48 81 ec 28 01 00 00 	sub    rsp,0x128
     ca7:	48 89 ac 24 00 01 00 	mov    QWORD PTR [rsp+0x100],rbp
     cae:	00 
     caf:	48 89 d5             	mov    rbp,rdx
     cb2:	4c 89 a4 24 08 01 00 	mov    QWORD PTR [rsp+0x108],r12
     cb9:	00 
     cba:	49 89 f4             	mov    r12,rsi
     cbd:	4c 89 ac 24 10 01 00 	mov    QWORD PTR [rsp+0x110],r13
     cc4:	00 
     cc5:	49 89 cd             	mov    r13,rcx
     cc8:	4c 89 b4 24 18 01 00 	mov    QWORD PTR [rsp+0x118],r14
     ccf:	00 
     cd0:	49 89 fe             	mov    r14,rdi
     cd3:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
     cd8:	e8 00 00 00 00       	call   cdd <gzram_base_encode_avx2+0x3d>
     cdd:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
     ce2:	85 c0                	test   eax,eax
     ce4:	0f 84 a6 00 00 00    	je     d90 <gzram_base_encode_avx2+0xf0>
     cea:	41 8d 40 fb          	lea    eax,[r8-0x5]
     cee:	83 f8 07             	cmp    eax,0x7
     cf1:	0f 87 e9 00 00 00    	ja     de0 <gzram_base_encode_avx2+0x140>
     cf7:	49 81 fc 00 10 00 00 	cmp    r12,0x1000
     cfe:	0f 87 dc 00 00 00    	ja     de0 <gzram_base_encode_avx2+0x140>
     d04:	48 85 ed             	test   rbp,rbp
     d07:	0f 84 d3 00 00 00    	je     de0 <gzram_base_encode_avx2+0x140>
     d0d:	4d 85 f6             	test   r14,r14
     d10:	0f 94 c2             	sete   dl
     d13:	4d 85 e4             	test   r12,r12
     d16:	0f 95 c0             	setne  al
     d19:	84 c2                	test   dl,al
     d1b:	0f 85 bf 00 00 00    	jne    de0 <gzram_base_encode_avx2+0x140>
     d21:	49 83 fd 07          	cmp    r13,0x7
     d25:	0f 86 b5 00 00 00    	jbe    de0 <gzram_base_encode_avx2+0x140>
     d2b:	44 89 c1             	mov    ecx,r8d
     d2e:	41 ba 01 00 00 00    	mov    r10d,0x1
     d34:	49 8d 74 24 08       	lea    rsi,[r12+0x8]
     d39:	48 89 9c 24 f8 00 00 	mov    QWORD PTR [rsp+0xf8],rbx
     d40:	00 
     d41:	49 d3 e2             	shl    r10,cl
     d44:	4b 8d 44 22 ff       	lea    rax,[r10+r12*1-0x1]
     d49:	48 d3 e8             	shr    rax,cl
     d4c:	48 8d 58 08          	lea    rbx,[rax+0x8]
     d50:	49 39 dd             	cmp    r13,rbx
     d53:	0f 83 b7 00 00 00    	jae    e10 <gzram_base_encode_avx2+0x170>
     d59:	49 39 f5             	cmp    r13,rsi
     d5c:	72 72                	jb     dd0 <gzram_base_encode_avx2+0x130>
     d5e:	4d 85 e4             	test   r12,r12
     d61:	0f 85 61 03 00 00    	jne    10c8 <gzram_base_encode_avx2+0x428>
     d67:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
     d6e:	41 8d 44 24 08       	lea    eax,[r12+0x8]
     d73:	44 88 65 04          	mov    BYTE PTR [rbp+0x4],r12b
     d77:	c6 45 05 00          	mov    BYTE PTR [rbp+0x5],0x0
     d7b:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
     d7f:	c6 45 07 01          	mov    BYTE PTR [rbp+0x7],0x1
     d83:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
     d8a:	00 
     d8b:	eb 55                	jmp    de2 <gzram_base_encode_avx2+0x142>
     d8d:	0f 1f 00             	nop    DWORD PTR [rax]
     d90:	4c 89 e9             	mov    rcx,r13
     d93:	48 89 ea             	mov    rdx,rbp
     d96:	4c 89 e6             	mov    rsi,r12
     d99:	4c 89 f7             	mov    rdi,r14
     d9c:	48 8b ac 24 00 01 00 	mov    rbp,QWORD PTR [rsp+0x100]
     da3:	00 
     da4:	4c 8b a4 24 08 01 00 	mov    r12,QWORD PTR [rsp+0x108]
     dab:	00 
     dac:	4c 8b ac 24 10 01 00 	mov    r13,QWORD PTR [rsp+0x110]
     db3:	00 
     db4:	4c 8b b4 24 18 01 00 	mov    r14,QWORD PTR [rsp+0x118]
     dbb:	00 
     dbc:	48 81 c4 28 01 00 00 	add    rsp,0x128
     dc3:	e9 00 00 00 00       	jmp    dc8 <gzram_base_encode_avx2+0x128>
     dc8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     dcf:	00 
     dd0:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
     dd7:	00 
     dd8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     ddf:	00 
     de0:	31 c0                	xor    eax,eax
     de2:	48 8b ac 24 00 01 00 	mov    rbp,QWORD PTR [rsp+0x100]
     de9:	00 
     dea:	4c 8b a4 24 08 01 00 	mov    r12,QWORD PTR [rsp+0x108]
     df1:	00 
     df2:	4c 8b ac 24 10 01 00 	mov    r13,QWORD PTR [rsp+0x110]
     df9:	00 
     dfa:	4c 8b b4 24 18 01 00 	mov    r14,QWORD PTR [rsp+0x118]
     e01:	00 
     e02:	48 81 c4 28 01 00 00 	add    rsp,0x128
     e09:	c3                   	ret
     e0a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     e10:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
     e17:	66 44 89 65 04       	mov    WORD PTR [rbp+0x4],r12w
     e1c:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
     e20:	c6 45 07 00          	mov    BYTE PTR [rbp+0x7],0x0
     e24:	48 85 c0             	test   rax,rax
     e27:	0f 84 19 05 00 00    	je     1346 <gzram_base_encode_avx2+0x6a6>
     e2d:	48 8d 7d 08          	lea    rdi,[rbp+0x8]
     e31:	4c 89 f1             	mov    rcx,r14
     e34:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
     e39:	48 01 f8             	add    rax,rdi
     e3c:	4c 89 bc 24 20 01 00 	mov    QWORD PTR [rsp+0x120],r15
     e43:	00 
     e44:	49 89 df             	mov    r15,rbx
     e47:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
     e4c:	4b 8d 04 26          	lea    rax,[r14+r12*1]
     e50:	49 89 fe             	mov    r14,rdi
     e53:	4c 89 64 24 30       	mov    QWORD PTR [rsp+0x30],r12
     e58:	49 89 cc             	mov    r12,rcx
     e5b:	4c 89 6c 24 18       	mov    QWORD PTR [rsp+0x18],r13
     e60:	4d 89 d5             	mov    r13,r10
     e63:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
     e68:	48 89 74 24 20       	mov    QWORD PTR [rsp+0x20],rsi
     e6d:	48 89 7c 24 40       	mov    QWORD PTR [rsp+0x40],rdi
     e72:	44 89 44 24 3c       	mov    DWORD PTR [rsp+0x3c],r8d
     e77:	eb 41                	jmp    eba <gzram_base_encode_avx2+0x21a>
     e79:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     e80:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
     e85:	4c 29 f8             	sub    rax,r15
     e88:	48 39 d8             	cmp    rax,rbx
     e8b:	0f 82 af 01 00 00    	jb     1040 <gzram_base_encode_avx2+0x3a0>
     e91:	41 c6 06 00          	mov    BYTE PTR [r14],0x0
     e95:	4a 8d 7c 3d 00       	lea    rdi,[rbp+r15*1+0x0]
     e9a:	48 89 da             	mov    rdx,rbx
     e9d:	4c 89 e6             	mov    rsi,r12
     ea0:	49 01 df             	add    r15,rbx
     ea3:	e8 00 00 00 00       	call   ea8 <gzram_base_encode_avx2+0x208>
     ea8:	4d 01 ec             	add    r12,r13
     eab:	49 83 c6 01          	add    r14,0x1
     eaf:	4c 39 74 24 10       	cmp    QWORD PTR [rsp+0x10],r14
     eb4:	0f 84 3e 01 00 00    	je     ff8 <gzram_base_encode_avx2+0x358>
     eba:	48 8b 4c 24 08       	mov    rcx,QWORD PTR [rsp+0x8]
     ebf:	4c 29 e1             	sub    rcx,r12
     ec2:	4c 39 e9             	cmp    rcx,r13
     ec5:	48 89 cb             	mov    rbx,rcx
     ec8:	49 0f 47 dd          	cmova  rbx,r13
     ecc:	f6 c3 1f             	test   bl,0x1f
     ecf:	75 af                	jne    e80 <gzram_base_encode_avx2+0x1e0>
     ed1:	48 8d 54 24 68       	lea    rdx,[rsp+0x68]
     ed6:	48 89 de             	mov    rsi,rbx
     ed9:	4c 89 e7             	mov    rdi,r12
     edc:	e8 cf f2 ff ff       	call   1b0 <scan_avx2>
     ee1:	8b 84 24 e8 00 00 00 	mov    eax,DWORD PTR [rsp+0xe8]
     ee8:	85 c0                	test   eax,eax
     eea:	75 0c                	jne    ef8 <gzram_base_encode_avx2+0x258>
     eec:	41 c6 06 01          	mov    BYTE PTR [r14],0x1
     ef0:	eb b6                	jmp    ea8 <gzram_base_encode_avx2+0x208>
     ef2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     ef8:	8b 94 24 ec 00 00 00 	mov    edx,DWORD PTR [rsp+0xec]
     eff:	f6 c2 01             	test   dl,0x1
     f02:	0f 84 c8 00 00 00    	je     fd0 <gzram_base_encode_avx2+0x330>
     f08:	48 83 fb 04          	cmp    rbx,0x4
     f0c:	76 83                	jbe    e91 <gzram_base_encode_avx2+0x1f1>
     f0e:	ba 02 00 00 00       	mov    edx,0x2
     f13:	b8 04 00 00 00       	mov    eax,0x4
     f18:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
     f1d:	4c 29 f9             	sub    rcx,r15
     f20:	48 39 c1             	cmp    rcx,rax
     f23:	0f 82 17 01 00 00    	jb     1040 <gzram_base_encode_avx2+0x3a0>
     f29:	41 88 16             	mov    BYTE PTR [r14],dl
     f2c:	4a 8d 74 3d 00       	lea    rsi,[rbp+r15*1+0x0]
     f31:	89 c2                	mov    edx,eax
     f33:	83 f8 20             	cmp    eax,0x20
     f36:	73 30                	jae    f68 <gzram_base_encode_avx2+0x2c8>
     f38:	a8 10                	test   al,0x10
     f3a:	0f 85 a6 01 00 00    	jne    10e6 <gzram_base_encode_avx2+0x446>
     f40:	a8 08                	test   al,0x8
     f42:	0f 85 90 03 00 00    	jne    12d8 <gzram_base_encode_avx2+0x638>
     f48:	a8 04                	test   al,0x4
     f4a:	0f 85 9e 03 00 00    	jne    12ee <gzram_base_encode_avx2+0x64e>
     f50:	85 c0                	test   eax,eax
     f52:	74 07                	je     f5b <gzram_base_encode_avx2+0x2bb>
     f54:	41 0f b6 14 24       	movzx  edx,BYTE PTR [r12]
     f59:	88 16                	mov    BYTE PTR [rsi],dl
     f5b:	49 01 c7             	add    r15,rax
     f5e:	e9 45 ff ff ff       	jmp    ea8 <gzram_base_encode_avx2+0x208>
     f63:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     f68:	49 8d 0c 04          	lea    rcx,[r12+rax*1]
     f6c:	8d 50 ff             	lea    edx,[rax-0x1]
     f6f:	48 8b 79 e0          	mov    rdi,QWORD PTR [rcx-0x20]
     f73:	48 89 7c 30 e0       	mov    QWORD PTR [rax+rsi*1-0x20],rdi
     f78:	48 8b 79 e8          	mov    rdi,QWORD PTR [rcx-0x18]
     f7c:	48 89 7c 30 e8       	mov    QWORD PTR [rax+rsi*1-0x18],rdi
     f81:	48 8b 79 f0          	mov    rdi,QWORD PTR [rcx-0x10]
     f85:	48 89 7c 30 f0       	mov    QWORD PTR [rax+rsi*1-0x10],rdi
     f8a:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
     f8e:	48 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],rcx
     f93:	83 fa 20             	cmp    edx,0x20
     f96:	72 c3                	jb     f5b <gzram_base_encode_avx2+0x2bb>
     f98:	83 e2 e0             	and    edx,0xffffffe0
     f9b:	31 ff                	xor    edi,edi
     f9d:	89 f9                	mov    ecx,edi
     f9f:	83 c7 20             	add    edi,0x20
     fa2:	4d 8b 1c 0c          	mov    r11,QWORD PTR [r12+rcx*1]
     fa6:	4d 8b 54 0c 08       	mov    r10,QWORD PTR [r12+rcx*1+0x8]
     fab:	4d 8b 4c 0c 10       	mov    r9,QWORD PTR [r12+rcx*1+0x10]
     fb0:	4d 8b 44 0c 18       	mov    r8,QWORD PTR [r12+rcx*1+0x18]
     fb5:	4c 89 1c 0e          	mov    QWORD PTR [rsi+rcx*1],r11
     fb9:	4c 89 54 0e 08       	mov    QWORD PTR [rsi+rcx*1+0x8],r10
     fbe:	4c 89 4c 0e 10       	mov    QWORD PTR [rsi+rcx*1+0x10],r9
     fc3:	4c 89 44 0e 18       	mov    QWORD PTR [rsi+rcx*1+0x18],r8
     fc8:	39 d7                	cmp    edi,edx
     fca:	72 d1                	jb     f9d <gzram_base_encode_avx2+0x2fd>
     fcc:	eb 8d                	jmp    f5b <gzram_base_encode_avx2+0x2bb>
     fce:	66 90                	xchg   ax,ax
     fd0:	f6 c2 02             	test   dl,0x2
     fd3:	0f 84 c7 00 00 00    	je     10a0 <gzram_base_encode_avx2+0x400>
     fd9:	48 83 fb 08          	cmp    rbx,0x8
     fdd:	0f 86 ae fe ff ff    	jbe    e91 <gzram_base_encode_avx2+0x1f1>
     fe3:	ba 03 00 00 00       	mov    edx,0x3
     fe8:	b8 08 00 00 00       	mov    eax,0x8
     fed:	e9 26 ff ff ff       	jmp    f18 <gzram_base_encode_avx2+0x278>
     ff2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     ff8:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
     ffd:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1002:	4c 89 fb             	mov    rbx,r15
    1005:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
    100a:	44 8b 44 24 3c       	mov    r8d,DWORD PTR [rsp+0x3c]
    100f:	49 39 f7             	cmp    r15,rsi
    1012:	0f 83 fd 00 00 00    	jae    1115 <gzram_base_encode_avx2+0x475>
    1018:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    101f:	00 
    1020:	89 d8                	mov    eax,ebx
    1022:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    1029:	00 
    102a:	e9 b3 fd ff ff       	jmp    de2 <gzram_base_encode_avx2+0x142>
    102f:	48 39 da             	cmp    rdx,rbx
    1032:	0f 83 59 fe ff ff    	jae    e91 <gzram_base_encode_avx2+0x1f1>
    1038:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    103f:	00 
    1040:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
    1045:	4c 8b 6c 24 18       	mov    r13,QWORD PTR [rsp+0x18]
    104a:	31 c0                	xor    eax,eax
    104c:	48 8b 7c 24 40       	mov    rdi,QWORD PTR [rsp+0x40]
    1051:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1056:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
    105b:	44 8b 44 24 3c       	mov    r8d,DWORD PTR [rsp+0x3c]
    1060:	49 39 f5             	cmp    r13,rsi
    1063:	0f 82 99 02 00 00    	jb     1302 <gzram_base_encode_avx2+0x662>
    1069:	4d 85 e4             	test   r12,r12
    106c:	0f 85 a5 02 00 00    	jne    1317 <gzram_base_encode_avx2+0x677>
    1072:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
    1079:	41 8d 44 24 08       	lea    eax,[r12+0x8]
    107e:	66 44 89 65 04       	mov    WORD PTR [rbp+0x4],r12w
    1083:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
    1087:	c6 45 07 01          	mov    BYTE PTR [rbp+0x7],0x1
    108b:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    1092:	00 
    1093:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    109a:	00 
    109b:	e9 42 fd ff ff       	jmp    de2 <gzram_base_encode_avx2+0x142>
    10a0:	f6 c2 04             	test   dl,0x4
    10a3:	0f 84 ae 00 00 00    	je     1157 <gzram_base_encode_avx2+0x4b7>
    10a9:	48 83 fb 10          	cmp    rbx,0x10
    10ad:	0f 86 de fd ff ff    	jbe    e91 <gzram_base_encode_avx2+0x1f1>
    10b3:	ba 05 00 00 00       	mov    edx,0x5
    10b8:	b8 10 00 00 00       	mov    eax,0x10
    10bd:	e9 56 fe ff ff       	jmp    f18 <gzram_base_encode_avx2+0x278>
    10c2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    10c8:	48 8d 7d 08          	lea    rdi,[rbp+0x8]
    10cc:	4c 89 e2             	mov    rdx,r12
    10cf:	4c 89 f6             	mov    rsi,r14
    10d2:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    10d7:	e8 00 00 00 00       	call   10dc <gzram_base_encode_avx2+0x43c>
    10dc:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
    10e1:	e9 81 fc ff ff       	jmp    d67 <gzram_base_encode_avx2+0xc7>
    10e6:	49 8b 0c 24          	mov    rcx,QWORD PTR [r12]
    10ea:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    10ed:	49 8b 4c 24 08       	mov    rcx,QWORD PTR [r12+0x8]
    10f2:	48 89 4e 08          	mov    QWORD PTR [rsi+0x8],rcx
    10f6:	48 8d 4c 16 10       	lea    rcx,[rsi+rdx*1+0x10]
    10fb:	49 8d 54 14 10       	lea    rdx,[r12+rdx*1+0x10]
    1100:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
    1104:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
    1108:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    110c:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
    1110:	e9 46 fe ff ff       	jmp    f5b <gzram_base_encode_avx2+0x2bb>
    1115:	48 39 74 24 18       	cmp    QWORD PTR [rsp+0x18],rsi
    111a:	0f 82 11 02 00 00    	jb     1331 <gzram_base_encode_avx2+0x691>
    1120:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    1127:	00 
    1128:	4d 85 e4             	test   r12,r12
    112b:	0f 85 29 02 00 00    	jne    135a <gzram_base_encode_avx2+0x6ba>
    1131:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
    1138:	41 8d 44 24 08       	lea    eax,[r12+0x8]
    113d:	66 44 89 65 04       	mov    WORD PTR [rbp+0x4],r12w
    1142:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
    1146:	c6 45 07 01          	mov    BYTE PTR [rbp+0x7],0x1
    114a:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    1151:	00 
    1152:	e9 8b fc ff ff       	jmp    de2 <gzram_base_encode_avx2+0x142>
    1157:	83 e2 08             	and    edx,0x8
    115a:	74 0a                	je     1166 <gzram_base_encode_avx2+0x4c6>
    115c:	48 83 fb 20          	cmp    rbx,0x20
    1160:	0f 87 12 02 00 00    	ja     1378 <gzram_base_encode_avx2+0x6d8>
    1166:	48 89 df             	mov    rdi,rbx
    1169:	48 8b 54 24 18       	mov    rdx,QWORD PTR [rsp+0x18]
    116e:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1175:	48 c1 ef 05          	shr    rdi,0x5
    1179:	48 01 f8             	add    rax,rdi
    117c:	4c 29 fa             	sub    rdx,r15
    117f:	48 39 d8             	cmp    rax,rbx
    1182:	0f 83 a7 fe ff ff    	jae    102f <gzram_base_encode_avx2+0x38f>
    1188:	48 39 c2             	cmp    rdx,rax
    118b:	0f 82 af fe ff ff    	jb     1040 <gzram_base_encode_avx2+0x3a0>
    1191:	41 c6 06 04          	mov    BYTE PTR [r14],0x4
    1195:	4a 8d 54 3d 00       	lea    rdx,[rbp+r15*1+0x0]
    119a:	83 ff 20             	cmp    edi,0x20
    119d:	0f 83 bd 00 00 00    	jae    1260 <gzram_base_encode_avx2+0x5c0>
    11a3:	40 f6 c7 10          	test   dil,0x10
    11a7:	0f 85 da 01 00 00    	jne    1387 <gzram_base_encode_avx2+0x6e7>
    11ad:	40 f6 c7 08          	test   dil,0x8
    11b1:	0f 85 02 02 00 00    	jne    13b9 <gzram_base_encode_avx2+0x719>
    11b7:	40 f6 c7 04          	test   dil,0x4
    11bb:	0f 85 11 02 00 00    	jne    13d2 <gzram_base_encode_avx2+0x732>
    11c1:	85 ff                	test   edi,edi
    11c3:	74 11                	je     11d6 <gzram_base_encode_avx2+0x536>
    11c5:	0f b6 44 24 68       	movzx  eax,BYTE PTR [rsp+0x68]
    11ca:	88 02                	mov    BYTE PTR [rdx],al
    11cc:	40 f6 c7 02          	test   dil,0x2
    11d0:	0f 85 11 02 00 00    	jne    13e7 <gzram_base_encode_avx2+0x747>
    11d6:	49 01 ff             	add    r15,rdi
    11d9:	48 85 ff             	test   rdi,rdi
    11dc:	0f 84 c6 fc ff ff    	je     ea8 <gzram_base_encode_avx2+0x208>
    11e2:	48 c1 e7 05          	shl    rdi,0x5
    11e6:	4c 89 6c 24 48       	mov    QWORD PTR [rsp+0x48],r13
    11eb:	4d 89 e5             	mov    r13,r12
    11ee:	4a 8d 34 27          	lea    rsi,[rdi+r12*1]
    11f2:	4c 89 74 24 50       	mov    QWORD PTR [rsp+0x50],r14
    11f7:	4c 8d 74 24 68       	lea    r14,[rsp+0x68]
    11fc:	4c 89 64 24 58       	mov    QWORD PTR [rsp+0x58],r12
    1201:	49 89 ec             	mov    r12,rbp
    1204:	48 89 f5             	mov    rbp,rsi
    1207:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    120e:	00 00 
    1210:	41 0f b6 1e          	movzx  ebx,BYTE PTR [r14]
    1214:	4b 8d 34 3c          	lea    rsi,[r12+r15*1]
    1218:	4c 89 ef             	mov    rdi,r13
    121b:	49 83 c5 20          	add    r13,0x20
    121f:	49 83 c6 01          	add    r14,0x1
    1223:	89 da                	mov    edx,ebx
    1225:	e8 d6 ed ff ff       	call   0 <pack_avx2>
    122a:	48 8d 05 00 00 00 00 	lea    rax,[rip+0x0]        # 1231 <gzram_base_encode_avx2+0x591>
    1231:	0f b6 14 18          	movzx  edx,BYTE PTR [rax+rbx*1]
    1235:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
    123c:	49 01 d7             	add    r15,rdx
    123f:	49 39 ed             	cmp    r13,rbp
    1242:	75 cc                	jne    1210 <gzram_base_encode_avx2+0x570>
    1244:	4c 89 e5             	mov    rbp,r12
    1247:	4c 8b 6c 24 48       	mov    r13,QWORD PTR [rsp+0x48]
    124c:	4c 8b 74 24 50       	mov    r14,QWORD PTR [rsp+0x50]
    1251:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1256:	e9 4d fc ff ff       	jmp    ea8 <gzram_base_encode_avx2+0x208>
    125b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1260:	89 f8                	mov    eax,edi
    1262:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    1266:	48 8d 44 04 68       	lea    rax,[rsp+rax*1+0x68]
    126b:	48 8b 70 e0          	mov    rsi,QWORD PTR [rax-0x20]
    126f:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
    1273:	48 8b 70 e8          	mov    rsi,QWORD PTR [rax-0x18]
    1277:	48 89 71 e8          	mov    QWORD PTR [rcx-0x18],rsi
    127b:	48 8b 70 f0          	mov    rsi,QWORD PTR [rax-0x10]
    127f:	48 89 71 f0          	mov    QWORD PTR [rcx-0x10],rsi
    1283:	48 8b 40 f8          	mov    rax,QWORD PTR [rax-0x8]
    1287:	48 89 41 f8          	mov    QWORD PTR [rcx-0x8],rax
    128b:	8d 47 ff             	lea    eax,[rdi-0x1]
    128e:	83 f8 20             	cmp    eax,0x20
    1291:	0f 82 3f ff ff ff    	jb     11d6 <gzram_base_encode_avx2+0x536>
    1297:	83 e0 e0             	and    eax,0xffffffe0
    129a:	31 c9                	xor    ecx,ecx
    129c:	41 89 c3             	mov    r11d,eax
    129f:	89 c8                	mov    eax,ecx
    12a1:	83 c1 20             	add    ecx,0x20
    12a4:	4c 8b 54 04 68       	mov    r10,QWORD PTR [rsp+rax*1+0x68]
    12a9:	4c 8b 4c 04 70       	mov    r9,QWORD PTR [rsp+rax*1+0x70]
    12ae:	4c 8b 44 04 78       	mov    r8,QWORD PTR [rsp+rax*1+0x78]
    12b3:	48 8b b4 04 80 00 00 	mov    rsi,QWORD PTR [rsp+rax*1+0x80]
    12ba:	00 
    12bb:	4c 89 14 02          	mov    QWORD PTR [rdx+rax*1],r10
    12bf:	4c 89 4c 02 08       	mov    QWORD PTR [rdx+rax*1+0x8],r9
    12c4:	4c 89 44 02 10       	mov    QWORD PTR [rdx+rax*1+0x10],r8
    12c9:	48 89 74 02 18       	mov    QWORD PTR [rdx+rax*1+0x18],rsi
    12ce:	44 39 d9             	cmp    ecx,r11d
    12d1:	72 cc                	jb     129f <gzram_base_encode_avx2+0x5ff>
    12d3:	e9 fe fe ff ff       	jmp    11d6 <gzram_base_encode_avx2+0x536>
    12d8:	49 8b 0c 24          	mov    rcx,QWORD PTR [r12]
    12dc:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    12df:	49 8b 4c 14 f8       	mov    rcx,QWORD PTR [r12+rdx*1-0x8]
    12e4:	48 89 4c 16 f8       	mov    QWORD PTR [rsi+rdx*1-0x8],rcx
    12e9:	e9 6d fc ff ff       	jmp    f5b <gzram_base_encode_avx2+0x2bb>
    12ee:	41 8b 0c 24          	mov    ecx,DWORD PTR [r12]
    12f2:	89 0e                	mov    DWORD PTR [rsi],ecx
    12f4:	41 8b 4c 14 fc       	mov    ecx,DWORD PTR [r12+rdx*1-0x4]
    12f9:	89 4c 16 fc          	mov    DWORD PTR [rsi+rdx*1-0x4],ecx
    12fd:	e9 59 fc ff ff       	jmp    f5b <gzram_base_encode_avx2+0x2bb>
    1302:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    1309:	00 
    130a:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    1311:	00 
    1312:	e9 cb fa ff ff       	jmp    de2 <gzram_base_encode_avx2+0x142>
    1317:	4c 89 e2             	mov    rdx,r12
    131a:	4c 89 f6             	mov    rsi,r14
    131d:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    1322:	e8 00 00 00 00       	call   1327 <gzram_base_encode_avx2+0x687>
    1327:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
    132c:	e9 41 fd ff ff       	jmp    1072 <gzram_base_encode_avx2+0x3d2>
    1331:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    1338:	00 
    1339:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    1340:	00 
    1341:	e9 9a fa ff ff       	jmp    de0 <gzram_base_encode_avx2+0x140>
    1346:	bb 08 00 00 00       	mov    ebx,0x8
    134b:	48 83 fe 08          	cmp    rsi,0x8
    134f:	0f 85 cb fc ff ff    	jne    1020 <gzram_base_encode_avx2+0x380>
    1355:	e9 ce fd ff ff       	jmp    1128 <gzram_base_encode_avx2+0x488>
    135a:	48 8d 7d 08          	lea    rdi,[rbp+0x8]
    135e:	4c 89 e2             	mov    rdx,r12
    1361:	4c 89 f6             	mov    rsi,r14
    1364:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    1369:	e8 00 00 00 00       	call   136e <gzram_base_encode_avx2+0x6ce>
    136e:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
    1373:	e9 b9 fd ff ff       	jmp    1131 <gzram_base_encode_avx2+0x491>
    1378:	ba 06 00 00 00       	mov    edx,0x6
    137d:	b8 20 00 00 00       	mov    eax,0x20
    1382:	e9 91 fb ff ff       	jmp    f18 <gzram_base_encode_avx2+0x278>
    1387:	48 8b 44 24 68       	mov    rax,QWORD PTR [rsp+0x68]
    138c:	89 f9                	mov    ecx,edi
    138e:	48 89 02             	mov    QWORD PTR [rdx],rax
    1391:	48 8b 44 24 70       	mov    rax,QWORD PTR [rsp+0x70]
    1396:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
    139a:	48 8d 44 0a 10       	lea    rax,[rdx+rcx*1+0x10]
    139f:	48 8d 54 0c 78       	lea    rdx,[rsp+rcx*1+0x78]
    13a4:	48 8b 4a e0          	mov    rcx,QWORD PTR [rdx-0x20]
    13a8:	48 89 48 e0          	mov    QWORD PTR [rax-0x20],rcx
    13ac:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    13b0:	48 89 50 e8          	mov    QWORD PTR [rax-0x18],rdx
    13b4:	e9 1d fe ff ff       	jmp    11d6 <gzram_base_encode_avx2+0x536>
    13b9:	48 8b 44 24 68       	mov    rax,QWORD PTR [rsp+0x68]
    13be:	48 89 02             	mov    QWORD PTR [rdx],rax
    13c1:	89 f8                	mov    eax,edi
    13c3:	48 8b 4c 04 60       	mov    rcx,QWORD PTR [rsp+rax*1+0x60]
    13c8:	48 89 4c 02 f8       	mov    QWORD PTR [rdx+rax*1-0x8],rcx
    13cd:	e9 04 fe ff ff       	jmp    11d6 <gzram_base_encode_avx2+0x536>
    13d2:	8b 44 24 68          	mov    eax,DWORD PTR [rsp+0x68]
    13d6:	89 02                	mov    DWORD PTR [rdx],eax
    13d8:	89 f8                	mov    eax,edi
    13da:	8b 4c 04 64          	mov    ecx,DWORD PTR [rsp+rax*1+0x64]
    13de:	89 4c 02 fc          	mov    DWORD PTR [rdx+rax*1-0x4],ecx
    13e2:	e9 ef fd ff ff       	jmp    11d6 <gzram_base_encode_avx2+0x536>
    13e7:	89 f8                	mov    eax,edi
    13e9:	0f b7 4c 04 66       	movzx  ecx,WORD PTR [rsp+rax*1+0x66]
    13ee:	66 89 4c 02 fe       	mov    WORD PTR [rdx+rax*1-0x2],cx
    13f3:	e9 de fd ff ff       	jmp    11d6 <gzram_base_encode_avx2+0x536>
    13f8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    13ff:	00 

0000000000001400 <gzram_base_decode_scalar>:
    1400:	48 89 c8             	mov    rax,rcx
    1403:	48 8d 4e f8          	lea    rcx,[rsi-0x8]
    1407:	48 81 f9 00 10 00 00 	cmp    rcx,0x1000
    140e:	0f 87 8b 06 00 00    	ja     1a9f <gzram_base_decode_scalar+0x69f>
    1414:	48 85 ff             	test   rdi,rdi
    1417:	0f 84 82 06 00 00    	je     1a9f <gzram_base_decode_scalar+0x69f>
    141d:	81 3f 47 5a 52 31    	cmp    DWORD PTR [rdi],0x31525a47
    1423:	0f 85 76 06 00 00    	jne    1a9f <gzram_base_decode_scalar+0x69f>
    1429:	0f b6 4f 06          	movzx  ecx,BYTE PTR [rdi+0x6]
    142d:	44 8d 41 fb          	lea    r8d,[rcx-0x5]
    1431:	41 80 f8 07          	cmp    r8b,0x7
    1435:	0f 87 64 06 00 00    	ja     1a9f <gzram_base_decode_scalar+0x69f>
    143b:	44 0f b6 4f 07       	movzx  r9d,BYTE PTR [rdi+0x7]
    1440:	41 80 f9 01          	cmp    r9b,0x1
    1444:	0f 87 55 06 00 00    	ja     1a9f <gzram_base_decode_scalar+0x69f>
    144a:	41 ba 00 10 00 00    	mov    r10d,0x1000
    1450:	48 81 ec a8 00 00 00 	sub    rsp,0xa8
    1457:	4c 39 d0             	cmp    rax,r10
    145a:	48 89 5c 24 78       	mov    QWORD PTR [rsp+0x78],rbx
    145f:	44 0f b7 47 04       	movzx  r8d,WORD PTR [rdi+0x4]
    1464:	49 0f 47 c2          	cmova  rax,r10
    1468:	4c 89 c3             	mov    rbx,r8
    146b:	4c 39 c0             	cmp    rax,r8
    146e:	0f 82 c6 04 00 00    	jb     193a <gzram_base_decode_scalar+0x53a>
    1474:	48 85 d2             	test   rdx,rdx
    1477:	75 09                	jne    1482 <gzram_base_decode_scalar+0x82>
    1479:	4d 85 c0             	test   r8,r8
    147c:	0f 85 b8 04 00 00    	jne    193a <gzram_base_decode_scalar+0x53a>
    1482:	4c 89 b4 24 98 00 00 	mov    QWORD PTR [rsp+0x98],r14
    1489:	00 
    148a:	49 89 d6             	mov    r14,rdx
    148d:	4c 89 a4 24 88 00 00 	mov    QWORD PTR [rsp+0x88],r12
    1494:	00 
    1495:	48 89 74 24 38       	mov    QWORD PTR [rsp+0x38],rsi
    149a:	45 84 c9             	test   r9b,r9b
    149d:	0f 85 9d 00 00 00    	jne    1540 <gzram_base_decode_scalar+0x140>
    14a3:	ba 01 00 00 00       	mov    edx,0x1
    14a8:	4c 89 bc 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],r15
    14af:	00 
    14b0:	48 d3 e2             	shl    rdx,cl
    14b3:	49 89 d7             	mov    r15,rdx
    14b6:	49 8d 54 10 ff       	lea    rdx,[r8+rdx*1-0x1]
    14bb:	48 d3 ea             	shr    rdx,cl
    14be:	4c 8d 52 08          	lea    r10,[rdx+0x8]
    14c2:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    14c7:	0f 82 e3 05 00 00    	jb     1ab0 <gzram_base_decode_scalar+0x6b0>
    14cd:	48 85 d2             	test   rdx,rdx
    14d0:	0f 84 cf 05 00 00    	je     1aa5 <gzram_base_decode_scalar+0x6a5>
    14d6:	4c 89 ac 24 90 00 00 	mov    QWORD PTR [rsp+0x90],r13
    14dd:	00 
    14de:	4c 8d 6f 08          	lea    r13,[rdi+0x8]
    14e2:	4d 89 f9             	mov    r9,r15
    14e5:	4a 8d 04 2a          	lea    rax,[rdx+r13*1]
    14e9:	66 89 5c 24 6e       	mov    WORD PTR [rsp+0x6e],bx
    14ee:	48 89 44 24 50       	mov    QWORD PTR [rsp+0x50],rax
    14f3:	4b 8d 04 06          	lea    rax,[r14+r8*1]
    14f7:	48 89 44 24 40       	mov    QWORD PTR [rsp+0x40],rax
    14fc:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
    1501:	48 89 ac 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rbp
    1508:	00 
    1509:	4c 89 d5             	mov    rbp,r10
    150c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1510:	48 8b 5c 24 40       	mov    rbx,QWORD PTR [rsp+0x40]
    1515:	4c 29 f3             	sub    rbx,r14
    1518:	4c 39 cb             	cmp    rbx,r9
    151b:	49 0f 47 d9          	cmova  rbx,r9
    151f:	41 80 7d 00 06       	cmp    BYTE PTR [r13+0x0],0x6
    1524:	0f 87 e8 03 00 00    	ja     1912 <gzram_base_decode_scalar+0x512>
    152a:	41 0f b6 45 00       	movzx  eax,BYTE PTR [r13+0x0]
    152f:	48 8d 3d 00 00 00 00 	lea    rdi,[rip+0x0]        # 1536 <gzram_base_decode_scalar+0x136>
    1536:	48 63 04 87          	movsxd rax,DWORD PTR [rdi+rax*4]
    153a:	48 01 f8             	add    rax,rdi
    153d:	ff e0                	jmp    rax
    153f:	90                   	nop
    1540:	49 8d 50 08          	lea    rdx,[r8+0x8]
    1544:	48 39 d6             	cmp    rsi,rdx
    1547:	0f 85 3d 05 00 00    	jne    1a8a <gzram_base_decode_scalar+0x68a>
    154d:	4d 85 c0             	test   r8,r8
    1550:	0f 85 20 05 00 00    	jne    1a76 <gzram_base_decode_scalar+0x676>
    1556:	0f b7 c3             	movzx  eax,bx
    1559:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1560:	00 
    1561:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1568:	00 
    1569:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    156e:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    1575:	c3                   	ret
    1576:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    157d:	00 00 00 
    1580:	b9 08 00 00 00       	mov    ecx,0x8
    1585:	48 89 d8             	mov    rax,rbx
    1588:	31 d2                	xor    edx,edx
    158a:	48 f7 f1             	div    rcx
    158d:	48 85 d2             	test   rdx,rdx
    1590:	0f 85 7c 03 00 00    	jne    1912 <gzram_base_decode_scalar+0x512>
    1596:	48 39 cb             	cmp    rbx,rcx
    1599:	0f 82 73 03 00 00    	jb     1912 <gzram_base_decode_scalar+0x512>
    159f:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    15a4:	48 29 e8             	sub    rax,rbp
    15a7:	48 39 c8             	cmp    rax,rcx
    15aa:	0f 82 62 03 00 00    	jb     1912 <gzram_base_decode_scalar+0x512>
    15b0:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    15b5:	44 8d 51 ff          	lea    r10d,[rcx-0x1]
    15b9:	89 ce                	mov    esi,ecx
    15bb:	89 4c 24 68          	mov    DWORD PTR [rsp+0x68],ecx
    15bf:	4c 89 4c 24 58       	mov    QWORD PTR [rsp+0x58],r9
    15c4:	41 89 cb             	mov    r11d,ecx
    15c7:	41 89 cf             	mov    r15d,ecx
    15ca:	83 e6 04             	and    esi,0x4
    15cd:	48 8d 3c 28          	lea    rdi,[rax+rbp*1]
    15d1:	44 89 d0             	mov    eax,r10d
    15d4:	48 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],rbp
    15d9:	41 89 cc             	mov    r12d,ecx
    15dc:	83 e0 e0             	and    eax,0xffffffe0
    15df:	4c 8d 04 0f          	lea    r8,[rdi+rcx*1]
    15e3:	41 83 e3 10          	and    r11d,0x10
    15e7:	41 83 e7 08          	and    r15d,0x8
    15eb:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
    15ef:	89 c8                	mov    eax,ecx
    15f1:	89 f5                	mov    ebp,esi
    15f3:	83 e0 02             	and    eax,0x2
    15f6:	89 44 24 4c          	mov    DWORD PTR [rsp+0x4c],eax
    15fa:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1600:	49 8d 04 16          	lea    rax,[r14+rdx*1]
    1604:	83 f9 20             	cmp    ecx,0x20
    1607:	0f 83 43 03 00 00    	jae    1950 <gzram_base_decode_scalar+0x550>
    160d:	45 85 db             	test   r11d,r11d
    1610:	0f 85 e2 03 00 00    	jne    19f8 <gzram_base_decode_scalar+0x5f8>
    1616:	45 85 ff             	test   r15d,r15d
    1619:	0f 85 11 04 00 00    	jne    1a30 <gzram_base_decode_scalar+0x630>
    161f:	85 ed                	test   ebp,ebp
    1621:	0f 85 29 04 00 00    	jne    1a50 <gzram_base_decode_scalar+0x650>
    1627:	85 c9                	test   ecx,ecx
    1629:	74 12                	je     163d <gzram_base_decode_scalar+0x23d>
    162b:	0f b6 37             	movzx  esi,BYTE PTR [rdi]
    162e:	40 88 30             	mov    BYTE PTR [rax],sil
    1631:	8b 74 24 4c          	mov    esi,DWORD PTR [rsp+0x4c]
    1635:	85 f6                	test   esi,esi
    1637:	0f 85 2a 04 00 00    	jne    1a67 <gzram_base_decode_scalar+0x667>
    163d:	48 01 ca             	add    rdx,rcx
    1640:	48 39 da             	cmp    rdx,rbx
    1643:	72 bb                	jb     1600 <gzram_base_decode_scalar+0x200>
    1645:	48 8b 6c 24 60       	mov    rbp,QWORD PTR [rsp+0x60]
    164a:	4c 8b 4c 24 58       	mov    r9,QWORD PTR [rsp+0x58]
    164f:	48 01 cd             	add    rbp,rcx
    1652:	49 83 c5 01          	add    r13,0x1
    1656:	4d 01 ce             	add    r14,r9
    1659:	4c 39 6c 24 50       	cmp    QWORD PTR [rsp+0x50],r13
    165e:	0f 85 ac fe ff ff    	jne    1510 <gzram_base_decode_scalar+0x110>
    1664:	49 89 ea             	mov    r10,rbp
    1667:	0f b7 5c 24 6e       	movzx  ebx,WORD PTR [rsp+0x6e]
    166c:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    1673:	00 
    1674:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    167b:	00 
    167c:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    1681:	0f 85 29 04 00 00    	jne    1ab0 <gzram_base_decode_scalar+0x6b0>
    1687:	0f b7 c3             	movzx  eax,bx
    168a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1691:	00 
    1692:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1699:	00 
    169a:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    16a1:	00 
    16a2:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    16a7:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    16ae:	c3                   	ret
    16af:	90                   	nop
    16b0:	b9 04 00 00 00       	mov    ecx,0x4
    16b5:	e9 cb fe ff ff       	jmp    1585 <gzram_base_decode_scalar+0x185>
    16ba:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    16c0:	48 89 da             	mov    rdx,rbx
    16c3:	31 f6                	xor    esi,esi
    16c5:	4c 89 f7             	mov    rdi,r14
    16c8:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    16cd:	e8 00 00 00 00       	call   16d2 <gzram_base_decode_scalar+0x2d2>
    16d2:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    16d7:	e9 76 ff ff ff       	jmp    1652 <gzram_base_decode_scalar+0x252>
    16dc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    16e0:	b9 10 00 00 00       	mov    ecx,0x10
    16e5:	e9 9b fe ff ff       	jmp    1585 <gzram_base_decode_scalar+0x185>
    16ea:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    16f0:	48 89 d8             	mov    rax,rbx
    16f3:	83 e0 1f             	and    eax,0x1f
    16f6:	0f 85 16 02 00 00    	jne    1912 <gzram_base_decode_scalar+0x512>
    16fc:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    1701:	48 c1 eb 05          	shr    rbx,0x5
    1705:	48 29 ea             	sub    rdx,rbp
    1708:	48 39 da             	cmp    rdx,rbx
    170b:	0f 82 01 02 00 00    	jb     1912 <gzram_base_decode_scalar+0x512>
    1711:	48 8d 34 2b          	lea    rsi,[rbx+rbp*1]
    1715:	48 85 db             	test   rbx,rbx
    1718:	0f 84 a0 01 00 00    	je     18be <gzram_base_decode_scalar+0x4be>
    171e:	48 03 6c 24 10       	add    rbp,QWORD PTR [rsp+0x10]
    1723:	4c 8d 05 00 00 00 00 	lea    r8,[rip+0x0]        # 172a <gzram_base_decode_scalar+0x32a>
    172a:	48 8d 3c 2b          	lea    rdi,[rbx+rbp*1]
    172e:	48 89 ea             	mov    rdx,rbp
    1731:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1735:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    173c:	00 00 00 00 
    1740:	0f b6 0a             	movzx  ecx,BYTE PTR [rdx]
    1743:	48 83 c2 01          	add    rdx,0x1
    1747:	41 0f b6 0c 08       	movzx  ecx,BYTE PTR [r8+rcx*1]
    174c:	8d 0c 8d 00 00 00 00 	lea    ecx,[rcx*4+0x0]
    1753:	48 01 c8             	add    rax,rcx
    1756:	48 39 d7             	cmp    rdi,rdx
    1759:	75 e5                	jne    1740 <gzram_base_decode_scalar+0x340>
    175b:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    1760:	48 29 f2             	sub    rdx,rsi
    1763:	48 39 c2             	cmp    rdx,rax
    1766:	0f 82 a6 01 00 00    	jb     1912 <gzram_base_decode_scalar+0x512>
    176c:	4c 89 f1             	mov    rcx,r14
    176f:	e9 a0 00 00 00       	jmp    1814 <gzram_base_decode_scalar+0x414>
    1774:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1778:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    177b:	48 83 c0 04          	add    rax,0x4
    177f:	44 89 51 04          	mov    DWORD PTR [rcx+0x4],r10d
    1783:	f6 c2 04             	test   dl,0x4
    1786:	0f 84 c0 00 00 00    	je     184c <gzram_base_decode_scalar+0x44c>
    178c:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    178f:	48 83 c0 04          	add    rax,0x4
    1793:	44 89 51 08          	mov    DWORD PTR [rcx+0x8],r10d
    1797:	f6 c2 08             	test   dl,0x8
    179a:	0f 84 bc 00 00 00    	je     185c <gzram_base_decode_scalar+0x45c>
    17a0:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    17a3:	48 83 c0 04          	add    rax,0x4
    17a7:	44 89 51 0c          	mov    DWORD PTR [rcx+0xc],r10d
    17ab:	f6 c2 10             	test   dl,0x10
    17ae:	0f 84 b8 00 00 00    	je     186c <gzram_base_decode_scalar+0x46c>
    17b4:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    17b7:	48 83 c0 04          	add    rax,0x4
    17bb:	44 89 51 10          	mov    DWORD PTR [rcx+0x10],r10d
    17bf:	f6 c2 20             	test   dl,0x20
    17c2:	0f 84 b4 00 00 00    	je     187c <gzram_base_decode_scalar+0x47c>
    17c8:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    17cb:	48 83 c0 04          	add    rax,0x4
    17cf:	44 89 51 14          	mov    DWORD PTR [rcx+0x14],r10d
    17d3:	f6 c2 40             	test   dl,0x40
    17d6:	0f 84 b0 00 00 00    	je     188c <gzram_base_decode_scalar+0x48c>
    17dc:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    17df:	48 83 c0 04          	add    rax,0x4
    17e3:	44 89 51 18          	mov    DWORD PTR [rcx+0x18],r10d
    17e7:	84 d2                	test   dl,dl
    17e9:	0f 89 ac 00 00 00    	jns    189b <gzram_base_decode_scalar+0x49b>
    17ef:	8b 00                	mov    eax,DWORD PTR [rax]
    17f1:	48 83 c5 01          	add    rbp,0x1
    17f5:	89 41 1c             	mov    DWORD PTR [rcx+0x1c],eax
    17f8:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    17fd:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1804:	48 01 c6             	add    rsi,rax
    1807:	48 39 ef             	cmp    rdi,rbp
    180a:	0f 84 ae 00 00 00    	je     18be <gzram_base_decode_scalar+0x4be>
    1810:	48 83 c1 20          	add    rcx,0x20
    1814:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1819:	0f b6 55 00          	movzx  edx,BYTE PTR [rbp+0x0]
    181d:	48 01 f0             	add    rax,rsi
    1820:	f6 c2 01             	test   dl,0x1
    1823:	0f 84 bf 01 00 00    	je     19e8 <gzram_base_decode_scalar+0x5e8>
    1829:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    182c:	48 83 c0 04          	add    rax,0x4
    1830:	44 89 11             	mov    DWORD PTR [rcx],r10d
    1833:	f6 c2 02             	test   dl,0x2
    1836:	0f 85 3c ff ff ff    	jne    1778 <gzram_base_decode_scalar+0x378>
    183c:	c7 41 04 00 00 00 00 	mov    DWORD PTR [rcx+0x4],0x0
    1843:	f6 c2 04             	test   dl,0x4
    1846:	0f 85 40 ff ff ff    	jne    178c <gzram_base_decode_scalar+0x38c>
    184c:	c7 41 08 00 00 00 00 	mov    DWORD PTR [rcx+0x8],0x0
    1853:	f6 c2 08             	test   dl,0x8
    1856:	0f 85 44 ff ff ff    	jne    17a0 <gzram_base_decode_scalar+0x3a0>
    185c:	c7 41 0c 00 00 00 00 	mov    DWORD PTR [rcx+0xc],0x0
    1863:	f6 c2 10             	test   dl,0x10
    1866:	0f 85 48 ff ff ff    	jne    17b4 <gzram_base_decode_scalar+0x3b4>
    186c:	c7 41 10 00 00 00 00 	mov    DWORD PTR [rcx+0x10],0x0
    1873:	f6 c2 20             	test   dl,0x20
    1876:	0f 85 4c ff ff ff    	jne    17c8 <gzram_base_decode_scalar+0x3c8>
    187c:	c7 41 14 00 00 00 00 	mov    DWORD PTR [rcx+0x14],0x0
    1883:	f6 c2 40             	test   dl,0x40
    1886:	0f 85 50 ff ff ff    	jne    17dc <gzram_base_decode_scalar+0x3dc>
    188c:	c7 41 18 00 00 00 00 	mov    DWORD PTR [rcx+0x18],0x0
    1893:	84 d2                	test   dl,dl
    1895:	0f 88 54 ff ff ff    	js     17ef <gzram_base_decode_scalar+0x3ef>
    189b:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    18a0:	48 83 c5 01          	add    rbp,0x1
    18a4:	c7 41 1c 00 00 00 00 	mov    DWORD PTR [rcx+0x1c],0x0
    18ab:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    18b2:	48 01 c6             	add    rsi,rax
    18b5:	48 39 fd             	cmp    rbp,rdi
    18b8:	0f 85 52 ff ff ff    	jne    1810 <gzram_base_decode_scalar+0x410>
    18be:	48 89 f5             	mov    rbp,rsi
    18c1:	e9 8c fd ff ff       	jmp    1652 <gzram_base_decode_scalar+0x252>
    18c6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    18cd:	00 00 00 
    18d0:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    18d5:	48 29 e8             	sub    rax,rbp
    18d8:	48 39 d8             	cmp    rax,rbx
    18db:	72 35                	jb     1912 <gzram_base_decode_scalar+0x512>
    18dd:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    18e2:	48 89 da             	mov    rdx,rbx
    18e5:	4c 89 f7             	mov    rdi,r14
    18e8:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    18ed:	48 8d 34 28          	lea    rsi,[rax+rbp*1]
    18f1:	48 01 dd             	add    rbp,rbx
    18f4:	e8 00 00 00 00       	call   18f9 <gzram_base_decode_scalar+0x4f9>
    18f9:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    18fe:	e9 4f fd ff ff       	jmp    1652 <gzram_base_decode_scalar+0x252>
    1903:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1908:	b9 20 00 00 00       	mov    ecx,0x20
    190d:	e9 73 fc ff ff       	jmp    1585 <gzram_base_decode_scalar+0x185>
    1912:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    1919:	00 
    191a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1921:	00 
    1922:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    1929:	00 
    192a:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1931:	00 
    1932:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1939:	00 
    193a:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    193f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1944:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    194b:	c3                   	ret
    194c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1950:	4d 8b 48 e0          	mov    r9,QWORD PTR [r8-0x20]
    1954:	4e 89 4c 20 e0       	mov    QWORD PTR [rax+r12*1-0x20],r9
    1959:	4d 8b 48 e8          	mov    r9,QWORD PTR [r8-0x18]
    195d:	4e 89 4c 20 e8       	mov    QWORD PTR [rax+r12*1-0x18],r9
    1962:	4d 8b 48 f0          	mov    r9,QWORD PTR [r8-0x10]
    1966:	4e 89 4c 20 f0       	mov    QWORD PTR [rax+r12*1-0x10],r9
    196b:	4d 8b 48 f8          	mov    r9,QWORD PTR [r8-0x8]
    196f:	4e 89 4c 20 f8       	mov    QWORD PTR [rax+r12*1-0x8],r9
    1974:	41 83 fa 20          	cmp    r10d,0x20
    1978:	0f 82 bf fc ff ff    	jb     163d <gzram_base_decode_scalar+0x23d>
    197e:	48 89 5c 24 18       	mov    QWORD PTR [rsp+0x18],rbx
    1983:	45 31 c9             	xor    r9d,r9d
    1986:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
    198b:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    1990:	48 89 54 24 30       	mov    QWORD PTR [rsp+0x30],rdx
    1995:	44 89 c9             	mov    ecx,r9d
    1998:	41 83 c1 20          	add    r9d,0x20
    199c:	4c 8b 74 0f 08       	mov    r14,QWORD PTR [rdi+rcx*1+0x8]
    19a1:	48 8b 5c 0f 10       	mov    rbx,QWORD PTR [rdi+rcx*1+0x10]
    19a6:	48 8b 74 0f 18       	mov    rsi,QWORD PTR [rdi+rcx*1+0x18]
    19ab:	48 8b 14 0f          	mov    rdx,QWORD PTR [rdi+rcx*1]
    19af:	4c 89 74 08 08       	mov    QWORD PTR [rax+rcx*1+0x8],r14
    19b4:	48 89 14 08          	mov    QWORD PTR [rax+rcx*1],rdx
    19b8:	48 89 5c 08 10       	mov    QWORD PTR [rax+rcx*1+0x10],rbx
    19bd:	48 89 74 08 18       	mov    QWORD PTR [rax+rcx*1+0x18],rsi
    19c2:	44 3b 4c 24 08       	cmp    r9d,DWORD PTR [rsp+0x8]
    19c7:	72 cc                	jb     1995 <gzram_base_decode_scalar+0x595>
    19c9:	48 8b 5c 24 18       	mov    rbx,QWORD PTR [rsp+0x18]
    19ce:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
    19d3:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    19d8:	48 8b 54 24 30       	mov    rdx,QWORD PTR [rsp+0x30]
    19dd:	e9 5b fc ff ff       	jmp    163d <gzram_base_decode_scalar+0x23d>
    19e2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    19e8:	c7 01 00 00 00 00    	mov    DWORD PTR [rcx],0x0
    19ee:	e9 40 fe ff ff       	jmp    1833 <gzram_base_decode_scalar+0x433>
    19f3:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    19f8:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    19fb:	48 89 30             	mov    QWORD PTR [rax],rsi
    19fe:	48 8b 77 08          	mov    rsi,QWORD PTR [rdi+0x8]
    1a02:	48 89 70 08          	mov    QWORD PTR [rax+0x8],rsi
    1a06:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1a0a:	48 8d 44 30 10       	lea    rax,[rax+rsi*1+0x10]
    1a0f:	48 8d 74 37 10       	lea    rsi,[rdi+rsi*1+0x10]
    1a14:	4c 8b 4e e0          	mov    r9,QWORD PTR [rsi-0x20]
    1a18:	4c 89 48 e0          	mov    QWORD PTR [rax-0x20],r9
    1a1c:	48 8b 76 e8          	mov    rsi,QWORD PTR [rsi-0x18]
    1a20:	48 89 70 e8          	mov    QWORD PTR [rax-0x18],rsi
    1a24:	e9 14 fc ff ff       	jmp    163d <gzram_base_decode_scalar+0x23d>
    1a29:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1a30:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    1a33:	48 89 30             	mov    QWORD PTR [rax],rsi
    1a36:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1a3a:	4c 8b 4c 37 f8       	mov    r9,QWORD PTR [rdi+rsi*1-0x8]
    1a3f:	4c 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],r9
    1a44:	e9 f4 fb ff ff       	jmp    163d <gzram_base_decode_scalar+0x23d>
    1a49:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1a50:	8b 37                	mov    esi,DWORD PTR [rdi]
    1a52:	89 30                	mov    DWORD PTR [rax],esi
    1a54:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1a58:	44 8b 4c 37 fc       	mov    r9d,DWORD PTR [rdi+rsi*1-0x4]
    1a5d:	44 89 4c 30 fc       	mov    DWORD PTR [rax+rsi*1-0x4],r9d
    1a62:	e9 d6 fb ff ff       	jmp    163d <gzram_base_decode_scalar+0x23d>
    1a67:	0f b7 74 0f fe       	movzx  esi,WORD PTR [rdi+rcx*1-0x2]
    1a6c:	66 89 74 01 fe       	mov    WORD PTR [rcx+rax*1-0x2],si
    1a71:	e9 c7 fb ff ff       	jmp    163d <gzram_base_decode_scalar+0x23d>
    1a76:	48 8d 77 08          	lea    rsi,[rdi+0x8]
    1a7a:	4c 89 c2             	mov    rdx,r8
    1a7d:	4c 89 f7             	mov    rdi,r14
    1a80:	e8 00 00 00 00       	call   1a85 <gzram_base_decode_scalar+0x685>
    1a85:	e9 cc fa ff ff       	jmp    1556 <gzram_base_decode_scalar+0x156>
    1a8a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1a91:	00 
    1a92:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1a99:	00 
    1a9a:	e9 9b fe ff ff       	jmp    193a <gzram_base_decode_scalar+0x53a>
    1a9f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1aa4:	c3                   	ret
    1aa5:	41 ba 08 00 00 00    	mov    r10d,0x8
    1aab:	e9 cc fb ff ff       	jmp    167c <gzram_base_decode_scalar+0x27c>
    1ab0:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1ab7:	00 
    1ab8:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1abf:	00 
    1ac0:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1ac7:	00 
    1ac8:	e9 6d fe ff ff       	jmp    193a <gzram_base_decode_scalar+0x53a>
    1acd:	0f 1f 00             	nop    DWORD PTR [rax]

0000000000001ad0 <gzram_base_decode_avx2>:
    1ad0:	48 83 ec 78          	sub    rsp,0x78
    1ad4:	48 89 5c 24 48       	mov    QWORD PTR [rsp+0x48],rbx
    1ad9:	48 89 cb             	mov    rbx,rcx
    1adc:	48 89 6c 24 50       	mov    QWORD PTR [rsp+0x50],rbp
    1ae1:	48 89 d5             	mov    rbp,rdx
    1ae4:	4c 89 64 24 58       	mov    QWORD PTR [rsp+0x58],r12
    1ae9:	49 89 fc             	mov    r12,rdi
    1aec:	4c 89 74 24 68       	mov    QWORD PTR [rsp+0x68],r14
    1af1:	49 89 f6             	mov    r14,rsi
    1af4:	e8 00 00 00 00       	call   1af9 <gzram_base_decode_avx2+0x29>
    1af9:	85 c0                	test   eax,eax
    1afb:	0f 84 af 00 00 00    	je     1bb0 <gzram_base_decode_avx2+0xe0>
    1b01:	49 8d 46 f8          	lea    rax,[r14-0x8]
    1b05:	48 3d 00 10 00 00    	cmp    rax,0x1000
    1b0b:	0f 87 ff 01 00 00    	ja     1d10 <gzram_base_decode_avx2+0x240>
    1b11:	4d 85 e4             	test   r12,r12
    1b14:	0f 84 f6 01 00 00    	je     1d10 <gzram_base_decode_avx2+0x240>
    1b1a:	41 81 3c 24 47 5a 52 	cmp    DWORD PTR [r12],0x31525a47
    1b21:	31 
    1b22:	0f 85 e8 01 00 00    	jne    1d10 <gzram_base_decode_avx2+0x240>
    1b28:	41 0f b6 4c 24 06    	movzx  ecx,BYTE PTR [r12+0x6]
    1b2e:	8d 41 fb             	lea    eax,[rcx-0x5]
    1b31:	3c 07                	cmp    al,0x7
    1b33:	0f 87 d7 01 00 00    	ja     1d10 <gzram_base_decode_avx2+0x240>
    1b39:	41 0f b6 7c 24 07    	movzx  edi,BYTE PTR [r12+0x7]
    1b3f:	40 80 ff 01          	cmp    dil,0x1
    1b43:	0f 87 c7 01 00 00    	ja     1d10 <gzram_base_decode_avx2+0x240>
    1b49:	b8 00 10 00 00       	mov    eax,0x1000
    1b4e:	41 0f b7 54 24 04    	movzx  edx,WORD PTR [r12+0x4]
    1b54:	48 39 c3             	cmp    rbx,rax
    1b57:	48 0f 46 c3          	cmovbe rax,rbx
    1b5b:	49 89 d2             	mov    r10,rdx
    1b5e:	48 39 d0             	cmp    rax,rdx
    1b61:	0f 82 a9 01 00 00    	jb     1d10 <gzram_base_decode_avx2+0x240>
    1b67:	48 85 ed             	test   rbp,rbp
    1b6a:	75 09                	jne    1b75 <gzram_base_decode_avx2+0xa5>
    1b6c:	48 85 d2             	test   rdx,rdx
    1b6f:	0f 85 9b 01 00 00    	jne    1d10 <gzram_base_decode_avx2+0x240>
    1b75:	40 84 ff             	test   dil,dil
    1b78:	74 66                	je     1be0 <gzram_base_decode_avx2+0x110>
    1b7a:	48 8d 42 08          	lea    rax,[rdx+0x8]
    1b7e:	49 39 c6             	cmp    r14,rax
    1b81:	0f 85 89 01 00 00    	jne    1d10 <gzram_base_decode_avx2+0x240>
    1b87:	48 85 d2             	test   rdx,rdx
    1b8a:	0f 85 18 03 00 00    	jne    1ea8 <gzram_base_decode_avx2+0x3d8>
    1b90:	41 0f b7 c2          	movzx  eax,r10w
    1b94:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1b99:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1b9e:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1ba3:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1ba8:	48 83 c4 78          	add    rsp,0x78
    1bac:	c3                   	ret
    1bad:	0f 1f 00             	nop    DWORD PTR [rax]
    1bb0:	48 89 d9             	mov    rcx,rbx
    1bb3:	48 89 ea             	mov    rdx,rbp
    1bb6:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1bbb:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1bc0:	4c 89 f6             	mov    rsi,r14
    1bc3:	4c 89 e7             	mov    rdi,r12
    1bc6:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1bcb:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1bd0:	48 83 c4 78          	add    rsp,0x78
    1bd4:	e9 00 00 00 00       	jmp    1bd9 <gzram_base_decode_avx2+0x109>
    1bd9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1be0:	41 b9 01 00 00 00    	mov    r9d,0x1
    1be6:	49 d3 e1             	shl    r9,cl
    1be9:	4a 8d 44 0a ff       	lea    rax,[rdx+r9*1-0x1]
    1bee:	48 d3 e8             	shr    rax,cl
    1bf1:	48 8d 58 08          	lea    rbx,[rax+0x8]
    1bf5:	49 39 de             	cmp    r14,rbx
    1bf8:	0f 82 12 01 00 00    	jb     1d10 <gzram_base_decode_avx2+0x240>
    1bfe:	48 85 c0             	test   rax,rax
    1c01:	0f 84 e1 02 00 00    	je     1ee8 <gzram_base_decode_avx2+0x418>
    1c07:	49 8d 44 04 08       	lea    rax,[r12+rax*1+0x8]
    1c0c:	66 44 89 54 24 3e    	mov    WORD PTR [rsp+0x3e],r10w
    1c12:	4d 8d 44 24 08       	lea    r8,[r12+0x8]
    1c17:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
    1c1c:	48 8d 44 15 00       	lea    rax,[rbp+rdx*1+0x0]
    1c21:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
    1c26:	4c 89 24 24          	mov    QWORD PTR [rsp],r12
    1c2a:	4c 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],r13
    1c2f:	4c 8d 2d 00 00 00 00 	lea    r13,[rip+0x0]        # 1c36 <gzram_base_decode_avx2+0x166>
    1c36:	4c 89 7c 24 70       	mov    QWORD PTR [rsp+0x70],r15
    1c3b:	4d 89 cf             	mov    r15,r9
    1c3e:	4c 89 74 24 10       	mov    QWORD PTR [rsp+0x10],r14
    1c43:	49 89 ee             	mov    r14,rbp
    1c46:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1c4d:	00 00 00 
    1c50:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
    1c55:	4c 29 f5             	sub    rbp,r14
    1c58:	4c 39 fd             	cmp    rbp,r15
    1c5b:	49 0f 47 ef          	cmova  rbp,r15
    1c5f:	41 80 38 06          	cmp    BYTE PTR [r8],0x6
    1c63:	0f 87 5f 02 00 00    	ja     1ec8 <gzram_base_decode_avx2+0x3f8>
    1c69:	41 0f b6 00          	movzx  eax,BYTE PTR [r8]
    1c6d:	49 63 44 85 00       	movsxd rax,DWORD PTR [r13+rax*4+0x0]
    1c72:	4c 01 e8             	add    rax,r13
    1c75:	ff e0                	jmp    rax
    1c77:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    1c7e:	00 00 
    1c80:	41 ba 08 00 00 00    	mov    r10d,0x8
    1c86:	b9 08 00 00 00       	mov    ecx,0x8
    1c8b:	48 89 e8             	mov    rax,rbp
    1c8e:	31 d2                	xor    edx,edx
    1c90:	49 f7 f2             	div    r10
    1c93:	48 85 d2             	test   rdx,rdx
    1c96:	0f 85 2c 02 00 00    	jne    1ec8 <gzram_base_decode_avx2+0x3f8>
    1c9c:	4c 39 d5             	cmp    rbp,r10
    1c9f:	0f 82 23 02 00 00    	jb     1ec8 <gzram_base_decode_avx2+0x3f8>
    1ca5:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1caa:	48 29 d8             	sub    rax,rbx
    1cad:	4c 39 d0             	cmp    rax,r10
    1cb0:	0f 82 12 02 00 00    	jb     1ec8 <gzram_base_decode_avx2+0x3f8>
    1cb6:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1cba:	48 89 ea             	mov    rdx,rbp
    1cbd:	4c 89 f7             	mov    rdi,r14
    1cc0:	4c 89 44 24 28       	mov    QWORD PTR [rsp+0x28],r8
    1cc5:	4c 89 54 24 20       	mov    QWORD PTR [rsp+0x20],r10
    1cca:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1cce:	e8 ad e3 ff ff       	call   80 <repeat_avx2>
    1cd3:	4c 8b 44 24 28       	mov    r8,QWORD PTR [rsp+0x28]
    1cd8:	48 03 5c 24 20       	add    rbx,QWORD PTR [rsp+0x20]
    1cdd:	49 83 c0 01          	add    r8,0x1
    1ce1:	4d 01 fe             	add    r14,r15
    1ce4:	4c 39 44 24 18       	cmp    QWORD PTR [rsp+0x18],r8
    1ce9:	0f 85 61 ff ff ff    	jne    1c50 <gzram_base_decode_avx2+0x180>
    1cef:	44 0f b7 54 24 3e    	movzx  r10d,WORD PTR [rsp+0x3e]
    1cf5:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
    1cfa:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    1cff:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    1d04:	49 39 de             	cmp    r14,rbx
    1d07:	0f 84 83 fe ff ff    	je     1b90 <gzram_base_decode_avx2+0xc0>
    1d0d:	0f 1f 00             	nop    DWORD PTR [rax]
    1d10:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d15:	e9 7a fe ff ff       	jmp    1b94 <gzram_base_decode_avx2+0xc4>
    1d1a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1d20:	41 ba 04 00 00 00    	mov    r10d,0x4
    1d26:	b9 04 00 00 00       	mov    ecx,0x4
    1d2b:	e9 5b ff ff ff       	jmp    1c8b <gzram_base_decode_avx2+0x1bb>
    1d30:	48 89 ea             	mov    rdx,rbp
    1d33:	31 f6                	xor    esi,esi
    1d35:	4c 89 f7             	mov    rdi,r14
    1d38:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1d3d:	e8 00 00 00 00       	call   1d42 <gzram_base_decode_avx2+0x272>
    1d42:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1d47:	eb 94                	jmp    1cdd <gzram_base_decode_avx2+0x20d>
    1d49:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1d50:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1d55:	48 29 d8             	sub    rax,rbx
    1d58:	48 39 e8             	cmp    rax,rbp
    1d5b:	0f 82 67 01 00 00    	jb     1ec8 <gzram_base_decode_avx2+0x3f8>
    1d61:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1d65:	48 89 ea             	mov    rdx,rbp
    1d68:	4c 89 f7             	mov    rdi,r14
    1d6b:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1d70:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1d74:	48 01 eb             	add    rbx,rbp
    1d77:	e8 00 00 00 00       	call   1d7c <gzram_base_decode_avx2+0x2ac>
    1d7c:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1d81:	e9 57 ff ff ff       	jmp    1cdd <gzram_base_decode_avx2+0x20d>
    1d86:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1d8d:	00 00 00 
    1d90:	41 ba 20 00 00 00    	mov    r10d,0x20
    1d96:	b9 20 00 00 00       	mov    ecx,0x20
    1d9b:	e9 eb fe ff ff       	jmp    1c8b <gzram_base_decode_avx2+0x1bb>
    1da0:	41 ba 10 00 00 00    	mov    r10d,0x10
    1da6:	b9 10 00 00 00       	mov    ecx,0x10
    1dab:	e9 db fe ff ff       	jmp    1c8b <gzram_base_decode_avx2+0x1bb>
    1db0:	48 89 e9             	mov    rcx,rbp
    1db3:	83 e1 1f             	and    ecx,0x1f
    1db6:	0f 85 0c 01 00 00    	jne    1ec8 <gzram_base_decode_avx2+0x3f8>
    1dbc:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1dc1:	48 c1 ed 05          	shr    rbp,0x5
    1dc5:	48 29 d8             	sub    rax,rbx
    1dc8:	48 39 e8             	cmp    rax,rbp
    1dcb:	0f 82 f7 00 00 00    	jb     1ec8 <gzram_base_decode_avx2+0x3f8>
    1dd1:	48 8d 74 1d 00       	lea    rsi,[rbp+rbx*1+0x0]
    1dd6:	48 85 ed             	test   rbp,rbp
    1dd9:	0f 84 01 01 00 00    	je     1ee0 <gzram_base_decode_avx2+0x410>
    1ddf:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1de3:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 1dea <gzram_base_decode_avx2+0x31a>
    1dea:	48 01 d8             	add    rax,rbx
    1ded:	48 8d 14 28          	lea    rdx,[rax+rbp*1]
    1df1:	49 89 c3             	mov    r11,rax
    1df4:	90                   	nop
    1df5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1dfc:	00 00 00 00 
    1e00:	41 0f b6 3b          	movzx  edi,BYTE PTR [r11]
    1e04:	49 83 c3 01          	add    r11,0x1
    1e08:	41 0f b6 3c 3a       	movzx  edi,BYTE PTR [r10+rdi*1]
    1e0d:	8d 3c bd 00 00 00 00 	lea    edi,[rdi*4+0x0]
    1e14:	48 01 f9             	add    rcx,rdi
    1e17:	49 39 d3             	cmp    r11,rdx
    1e1a:	75 e4                	jne    1e00 <gzram_base_decode_avx2+0x330>
    1e1c:	4c 8b 5c 24 10       	mov    r11,QWORD PTR [rsp+0x10]
    1e21:	49 29 f3             	sub    r11,rsi
    1e24:	49 39 cb             	cmp    r11,rcx
    1e27:	0f 82 9b 00 00 00    	jb     1ec8 <gzram_base_decode_avx2+0x3f8>
    1e2d:	4c 89 44 24 30       	mov    QWORD PTR [rsp+0x30],r8
    1e32:	48 89 c3             	mov    rbx,rax
    1e35:	48 89 d5             	mov    rbp,rdx
    1e38:	4c 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],r15
    1e3d:	4d 89 f7             	mov    r15,r14
    1e40:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    1e45:	49 89 f6             	mov    r14,rsi
    1e48:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    1e4f:	00 
    1e50:	44 0f b6 23          	movzx  r12d,BYTE PTR [rbx]
    1e54:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1e58:	4c 89 fe             	mov    rsi,r15
    1e5b:	48 83 c3 01          	add    rbx,0x1
    1e5f:	49 83 c7 20          	add    r15,0x20
    1e63:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
    1e67:	44 89 e2             	mov    edx,r12d
    1e6a:	e8 51 e4 ff ff       	call   2c0 <unpack_avx2>
    1e6f:	44 89 e2             	mov    edx,r12d
    1e72:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 1e79 <gzram_base_decode_avx2+0x3a9>
    1e79:	41 0f b6 14 12       	movzx  edx,BYTE PTR [r10+rdx*1]
    1e7e:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
    1e85:	49 01 d6             	add    r14,rdx
    1e88:	48 39 eb             	cmp    rbx,rbp
    1e8b:	75 c3                	jne    1e50 <gzram_base_decode_avx2+0x380>
    1e8d:	4c 89 f3             	mov    rbx,r14
    1e90:	4c 8b 7c 24 20       	mov    r15,QWORD PTR [rsp+0x20]
    1e95:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1e9a:	4c 8b 44 24 30       	mov    r8,QWORD PTR [rsp+0x30]
    1e9f:	e9 39 fe ff ff       	jmp    1cdd <gzram_base_decode_avx2+0x20d>
    1ea4:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1ea8:	49 8d 74 24 08       	lea    rsi,[r12+0x8]
    1ead:	48 89 ef             	mov    rdi,rbp
    1eb0:	44 89 14 24          	mov    DWORD PTR [rsp],r10d
    1eb4:	e8 00 00 00 00       	call   1eb9 <gzram_base_decode_avx2+0x3e9>
    1eb9:	44 8b 14 24          	mov    r10d,DWORD PTR [rsp]
    1ebd:	e9 ce fc ff ff       	jmp    1b90 <gzram_base_decode_avx2+0xc0>
    1ec2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1ec8:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    1ecd:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    1ed2:	e9 39 fe ff ff       	jmp    1d10 <gzram_base_decode_avx2+0x240>
    1ed7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    1ede:	00 00 
    1ee0:	48 89 f3             	mov    rbx,rsi
    1ee3:	e9 f5 fd ff ff       	jmp    1cdd <gzram_base_decode_avx2+0x20d>
    1ee8:	bb 08 00 00 00       	mov    ebx,0x8
    1eed:	e9 12 fe ff ff       	jmp    1d04 <gzram_base_decode_avx2+0x234>
