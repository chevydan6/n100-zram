
build/astra-v8/hybrid-block2avxbits4base.o:     file format elf64-x86-64


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
     1b0:	55                   	push   rbp
     1b1:	49 89 f3             	mov    r11,rsi
     1b4:	c4 41 21 ef db       	vpxor  xmm11,xmm11,xmm11
     1b9:	49 89 f9             	mov    r9,rdi
     1bc:	49 89 d2             	mov    r10,rdx
     1bf:	49 c1 eb 05          	shr    r11,0x5
     1c3:	48 89 e5             	mov    rbp,rsp
     1c6:	48 83 ec 20          	sub    rsp,0x20
     1ca:	48 89 5d e0          	mov    QWORD PTR [rbp-0x20],rbx
     1ce:	c4 62 7d 58 0f       	vpbroadcastd ymm9,DWORD PTR [rdi]
     1d3:	c4 e2 7d 59 37       	vpbroadcastq ymm6,QWORD PTR [rdi]
     1d8:	c4 e2 7d 5a 3f       	vbroadcasti128 ymm7,XMMWORD PTR [rdi]
     1dd:	c5 7e 6f 07          	vmovdqu ymm8,YMMWORD PTR [rdi]
     1e1:	c7 82 80 00 00 00 00 	mov    DWORD PTR [rdx+0x80],0x0
     1e8:	00 00 00 
     1eb:	48 83 fe 7f          	cmp    rsi,0x7f
     1ef:	0f 86 29 02 00 00    	jbe    41e <scan_avx2+0x26e>
     1f5:	4c 89 6d f0          	mov    QWORD PTR [rbp-0x10],r13
     1f9:	4d 8d 6b fc          	lea    r13,[r11-0x4]
     1fd:	48 89 d0             	mov    rax,rdx
     200:	45 31 c0             	xor    r8d,r8d
     203:	4c 89 ea             	mov    rdx,r13
     206:	4c 89 65 e8          	mov    QWORD PTR [rbp-0x18],r12
     20a:	c4 41 7d 6f eb       	vmovdqa ymm13,ymm11
     20f:	49 89 fc             	mov    r12,rdi
     212:	48 83 e2 fc          	and    rdx,0xfffffffffffffffc
     216:	4c 89 75 f8          	mov    QWORD PTR [rbp-0x8],r14
     21a:	c5 7d 7f dc          	vmovdqa ymm4,ymm11
     21e:	c5 7d 7f dd          	vmovdqa ymm5,ymm11
     222:	4d 8d 74 12 04       	lea    r14,[r10+rdx*1+0x4]
     227:	c4 41 7d 6f e3       	vmovdqa ymm12,ymm11
     22c:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 233 <scan_avx2+0x83>
     233:	c4 41 7d 6f d3       	vmovdqa ymm10,ymm11
     238:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     23f:	00 
     240:	c4 c1 7e 6f 1c 24    	vmovdqu ymm3,YMMWORD PTR [r12]
     246:	c4 c1 7e 6f 54 24 40 	vmovdqu ymm2,YMMWORD PTR [r12+0x40]
     24d:	48 83 c0 04          	add    rax,0x4
     251:	49 83 ec 80          	sub    r12,0xffffffffffffff80
     255:	c4 c1 65 76 c2       	vpcmpeqd ymm0,ymm3,ymm10
     25a:	c5 fc 50 f8          	vmovmskps edi,ymm0
     25e:	c4 c1 7e 6f 44 24 a0 	vmovdqu ymm0,YMMWORD PTR [r12-0x60]
     265:	40 80 f7 ff          	xor    dil,0xff
     269:	c4 c1 7d 76 ca       	vpcmpeqd ymm1,ymm0,ymm10
     26e:	c5 4c 57 f8          	vxorps ymm15,ymm6,ymm0
     272:	c5 fc 50 f1          	vmovmskps esi,ymm1
     276:	c4 c1 6d 76 ca       	vpcmpeqd ymm1,ymm2,ymm10
     27b:	40 80 f6 ff          	xor    sil,0xff
     27f:	c5 fc 50 c9          	vmovmskps ecx,ymm1
     283:	c4 c1 7e 6f 4c 24 e0 	vmovdqu ymm1,YMMWORD PTR [r12-0x20]
     28a:	40 88 78 fc          	mov    BYTE PTR [rax-0x4],dil
     28e:	89 ff                	mov    edi,edi
     290:	40 88 70 fd          	mov    BYTE PTR [rax-0x3],sil
     294:	89 f6                	mov    esi,esi
     296:	80 f1 ff             	xor    cl,0xff
     299:	0f b6 3c 3b          	movzx  edi,BYTE PTR [rbx+rdi*1]
     29d:	c4 41 75 76 f2       	vpcmpeqd ymm14,ymm1,ymm10
     2a2:	0f b6 34 33          	movzx  esi,BYTE PTR [rbx+rsi*1]
     2a6:	88 48 fe             	mov    BYTE PTR [rax-0x2],cl
     2a9:	89 c9                	mov    ecx,ecx
     2ab:	01 f7                	add    edi,esi
     2ad:	0f b6 34 0b          	movzx  esi,BYTE PTR [rbx+rcx*1]
     2b1:	c4 c1 7c 50 d6       	vmovmskps edx,ymm14
     2b6:	c5 34 57 f3          	vxorps ymm14,ymm9,ymm3
     2ba:	c4 41 1c 56 e6       	vorps  ymm12,ymm12,ymm14
     2bf:	c5 4c 57 f3          	vxorps ymm14,ymm6,ymm3
     2c3:	80 f2 ff             	xor    dl,0xff
     2c6:	01 fe                	add    esi,edi
     2c8:	c4 c1 54 56 ee       	vorps  ymm5,ymm5,ymm14
     2cd:	c5 44 57 f3          	vxorps ymm14,ymm7,ymm3
     2d1:	c5 bc 57 db          	vxorps ymm3,ymm8,ymm3
     2d5:	89 d1                	mov    ecx,edx
     2d7:	c4 c1 5c 56 e6       	vorps  ymm4,ymm4,ymm14
     2dc:	c5 94 56 db          	vorps  ymm3,ymm13,ymm3
     2e0:	c5 34 57 f0          	vxorps ymm14,ymm9,ymm0
     2e4:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
     2e7:	c5 44 57 e8          	vxorps ymm13,ymm7,ymm0
     2eb:	c5 bc 57 c0          	vxorps ymm0,ymm8,ymm0
     2ef:	c4 41 1c 56 f6       	vorps  ymm14,ymm12,ymm14
     2f4:	0f b6 14 0b          	movzx  edx,BYTE PTR [rbx+rcx*1]
     2f8:	c4 41 5c 56 ed       	vorps  ymm13,ymm4,ymm13
     2fd:	c4 41 54 56 ff       	vorps  ymm15,ymm5,ymm15
     302:	c5 34 57 e2          	vxorps ymm12,ymm9,ymm2
     306:	c5 cc 57 ea          	vxorps ymm5,ymm6,ymm2
     30a:	c5 c4 57 e2          	vxorps ymm4,ymm7,ymm2
     30e:	c5 e4 56 c0          	vorps  ymm0,ymm3,ymm0
     312:	01 f2                	add    edx,esi
     314:	c5 bc 57 d2          	vxorps ymm2,ymm8,ymm2
     318:	c4 41 0c 56 e4       	vorps  ymm12,ymm14,ymm12
     31d:	c5 84 56 ed          	vorps  ymm5,ymm15,ymm5
     321:	41 01 d0             	add    r8d,edx
     324:	c5 fc 56 c2          	vorps  ymm0,ymm0,ymm2
     328:	c5 b4 57 d1          	vxorps ymm2,ymm9,ymm1
     32c:	c5 94 56 e4          	vorps  ymm4,ymm13,ymm4
     330:	45 89 82 80 00 00 00 	mov    DWORD PTR [r10+0x80],r8d
     337:	c5 1c 56 e2          	vorps  ymm12,ymm12,ymm2
     33b:	c5 cc 57 d1          	vxorps ymm2,ymm6,ymm1
     33f:	c5 d4 56 ea          	vorps  ymm5,ymm5,ymm2
     343:	c5 c4 57 d1          	vxorps ymm2,ymm7,ymm1
     347:	c5 bc 57 c9          	vxorps ymm1,ymm8,ymm1
     34b:	c5 dc 56 e2          	vorps  ymm4,ymm4,ymm2
     34f:	c5 7c 56 e9          	vorps  ymm13,ymm0,ymm1
     353:	49 39 c6             	cmp    r14,rax
     356:	0f 85 e4 fe ff ff    	jne    240 <scan_avx2+0x90>
     35c:	4c 89 ea             	mov    rdx,r13
     35f:	4c 8b 65 e8          	mov    r12,QWORD PTR [rbp-0x18]
     363:	4c 8b 6d f0          	mov    r13,QWORD PTR [rbp-0x10]
     367:	48 83 e2 fc          	and    rdx,0xfffffffffffffffc
     36b:	4c 8b 75 f8          	mov    r14,QWORD PTR [rbp-0x8]
     36f:	48 83 c2 04          	add    rdx,0x4
     373:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 37a <scan_avx2+0x1ca>
     37a:	4c 39 da             	cmp    rdx,r11
     37d:	73 58                	jae    3d7 <scan_avx2+0x227>
     37f:	90                   	nop
     380:	48 89 d0             	mov    rax,rdx
     383:	48 c1 e0 05          	shl    rax,0x5
     387:	c4 c1 7e 6f 04 01    	vmovdqu ymm0,YMMWORD PTR [r9+rax*1]
     38d:	c4 c1 7d 76 cb       	vpcmpeqd ymm1,ymm0,ymm11
     392:	c5 fc 50 c1          	vmovmskps eax,ymm1
     396:	c5 b4 57 c8          	vxorps ymm1,ymm9,ymm0
     39a:	34 ff                	xor    al,0xff
     39c:	c4 41 74 56 e4       	vorps  ymm12,ymm1,ymm12
     3a1:	c5 cc 57 c8          	vxorps ymm1,ymm6,ymm0
     3a5:	41 88 04 12          	mov    BYTE PTR [r10+rdx*1],al
     3a9:	89 c0                	mov    eax,eax
     3ab:	c5 f4 56 ed          	vorps  ymm5,ymm1,ymm5
     3af:	48 83 c2 01          	add    rdx,0x1
     3b3:	0f b6 04 03          	movzx  eax,BYTE PTR [rbx+rax*1]
     3b7:	c5 c4 57 c8          	vxorps ymm1,ymm7,ymm0
     3bb:	c5 bc 57 c0          	vxorps ymm0,ymm8,ymm0
     3bf:	c5 f4 56 e4          	vorps  ymm4,ymm1,ymm4
     3c3:	c4 41 7c 56 ed       	vorps  ymm13,ymm0,ymm13
     3c8:	41 01 c0             	add    r8d,eax
     3cb:	45 89 82 80 00 00 00 	mov    DWORD PTR [r10+0x80],r8d
     3d2:	49 39 d3             	cmp    r11,rdx
     3d5:	75 a9                	jne    380 <scan_avx2+0x1d0>
     3d7:	31 f6                	xor    esi,esi
     3d9:	c4 42 7d 17 e4       	vptest ymm12,ymm12
     3de:	40 0f 94 c6          	sete   sil
     3e2:	31 c0                	xor    eax,eax
     3e4:	c4 e2 7d 17 ed       	vptest ymm5,ymm5
     3e9:	0f 94 c0             	sete   al
     3ec:	31 c9                	xor    ecx,ecx
     3ee:	c4 e2 7d 17 e4       	vptest ymm4,ymm4
     3f3:	0f 94 c1             	sete   cl
     3f6:	31 d2                	xor    edx,edx
     3f8:	c4 42 7d 17 ed       	vptest ymm13,ymm13
     3fd:	0f 94 c2             	sete   dl
     400:	01 c0                	add    eax,eax
     402:	c1 e1 02             	shl    ecx,0x2
     405:	09 c8                	or     eax,ecx
     407:	c1 e2 03             	shl    edx,0x3
     40a:	09 f0                	or     eax,esi
     40c:	09 d0                	or     eax,edx
     40e:	41 89 82 84 00 00 00 	mov    DWORD PTR [r10+0x84],eax
     415:	c5 f8 77             	vzeroupper
     418:	48 8b 5d e0          	mov    rbx,QWORD PTR [rbp-0x20]
     41c:	c9                   	leave
     41d:	c3                   	ret
     41e:	45 31 c0             	xor    r8d,r8d
     421:	c4 41 7d 6f eb       	vmovdqa ymm13,ymm11
     426:	c5 7d 7f dc          	vmovdqa ymm4,ymm11
     42a:	31 d2                	xor    edx,edx
     42c:	c5 7d 7f dd          	vmovdqa ymm5,ymm11
     430:	c4 41 7d 6f e3       	vmovdqa ymm12,ymm11
     435:	e9 39 ff ff ff       	jmp    373 <scan_avx2+0x1c3>
     43a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

0000000000000440 <unpack_avx2>:
     440:	55                   	push   rbp
     441:	c5 f9 ef c0          	vpxor  xmm0,xmm0,xmm0
     445:	48 89 e5             	mov    rbp,rsp
     448:	41 55                	push   r13
     44a:	49 89 f5             	mov    r13,rsi
     44d:	48 89 fe             	mov    rsi,rdi
     450:	41 54                	push   r12
     452:	41 89 d4             	mov    r12d,edx
     455:	48 8d 15 00 00 00 00 	lea    rdx,[rip+0x0]        # 45c <unpack_avx2+0x1c>
     45c:	53                   	push   rbx
     45d:	4c 89 e3             	mov    rbx,r12
     460:	48 83 e4 e0          	and    rsp,0xffffffffffffffe0
     464:	48 83 ec 20          	sub    rsp,0x20
     468:	42 0f b6 14 22       	movzx  edx,BYTE PTR [rdx+r12*1]
     46d:	c5 fd 7f 04 24       	vmovdqa YMMWORD PTR [rsp],ymm0
     472:	48 89 e7             	mov    rdi,rsp
     475:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
     47c:	c5 f8 77             	vzeroupper
     47f:	49 c1 e4 05          	shl    r12,0x5
     483:	e8 00 00 00 00       	call   488 <unpack_avx2+0x48>
     488:	c5 f9 6e c3          	vmovd  xmm0,ebx
     48c:	c5 f1 ef c9          	vpxor  xmm1,xmm1,xmm1
     490:	48 8d 05 00 00 00 00 	lea    rax,[rip+0x0]        # 497 <unpack_avx2+0x57>
     497:	c4 e2 7d 58 c0       	vpbroadcastd ymm0,xmm0
     49c:	c5 fd db 05 00 00 00 	vpand  ymm0,ymm0,YMMWORD PTR [rip+0x0]        # 4a4 <unpack_avx2+0x64>
     4a3:	00 
     4a4:	c4 a1 7d 6f 14 20    	vmovdqa ymm2,YMMWORD PTR [rax+r12*1]
     4aa:	c4 e2 6d 36 14 24    	vpermd ymm2,ymm2,YMMWORD PTR [rsp]
     4b0:	c5 fd 76 c1          	vpcmpeqd ymm0,ymm0,ymm1
     4b4:	c5 fd df c2          	vpandn ymm0,ymm0,ymm2
     4b8:	c4 c1 7e 7f 45 00    	vmovdqu YMMWORD PTR [r13+0x0],ymm0
     4be:	c5 f8 77             	vzeroupper
     4c1:	48 8d 65 e8          	lea    rsp,[rbp-0x18]
     4c5:	5b                   	pop    rbx
     4c6:	41 5c                	pop    r12
     4c8:	41 5d                	pop    r13
     4ca:	5d                   	pop    rbp
     4cb:	c3                   	ret
     4cc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000000004d0 <pack_scalar>:
     4d0:	81 fa ff 00 00 00    	cmp    edx,0xff
     4d6:	74 28                	je     500 <pack_scalar+0x30>
     4d8:	85 d2                	test   edx,edx
     4da:	74 44                	je     520 <pack_scalar+0x50>
     4dc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     4e0:	31 c9                	xor    ecx,ecx
     4e2:	8d 42 ff             	lea    eax,[rdx-0x1]
     4e5:	48 83 c6 04          	add    rsi,0x4
     4e9:	f3 0f bc ca          	tzcnt  ecx,edx
     4ed:	8d 0c 8d 00 00 00 00 	lea    ecx,[rcx*4+0x0]
     4f4:	8b 0c 0f             	mov    ecx,DWORD PTR [rdi+rcx*1]
     4f7:	89 4e fc             	mov    DWORD PTR [rsi-0x4],ecx
     4fa:	21 c2                	and    edx,eax
     4fc:	75 e2                	jne    4e0 <pack_scalar+0x10>
     4fe:	c3                   	ret
     4ff:	90                   	nop
     500:	48 8b 07             	mov    rax,QWORD PTR [rdi]
     503:	48 89 06             	mov    QWORD PTR [rsi],rax
     506:	48 8b 47 08          	mov    rax,QWORD PTR [rdi+0x8]
     50a:	48 89 46 08          	mov    QWORD PTR [rsi+0x8],rax
     50e:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
     512:	48 89 46 10          	mov    QWORD PTR [rsi+0x10],rax
     516:	48 8b 47 18          	mov    rax,QWORD PTR [rdi+0x18]
     51a:	48 89 46 18          	mov    QWORD PTR [rsi+0x18],rax
     51e:	c3                   	ret
     51f:	90                   	nop
     520:	c3                   	ret
     521:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     525:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     52c:	00 00 00 00 

0000000000000530 <pack_block_avx2>:
     530:	55                   	push   rbp
     531:	48 89 e5             	mov    rbp,rsp
     534:	41 57                	push   r15
     536:	41 56                	push   r14
     538:	41 55                	push   r13
     53a:	41 54                	push   r12
     53c:	53                   	push   rbx
     53d:	48 83 e4 e0          	and    rsp,0xffffffffffffffe0
     541:	48 83 ec 40          	sub    rsp,0x40
     545:	48 85 c9             	test   rcx,rcx
     548:	0f 84 c2 00 00 00    	je     610 <pack_block_avx2+0xe0>
     54e:	48 89 74 24 10       	mov    QWORD PTR [rsp+0x10],rsi
     553:	49 89 d5             	mov    r13,rdx
     556:	49 89 fe             	mov    r14,rdi
     559:	48 8d 1c 0a          	lea    rbx,[rdx+rcx*1]
     55d:	45 31 ff             	xor    r15d,r15d
     560:	4c 8d 25 00 00 00 00 	lea    r12,[rip+0x0]        # 567 <pack_block_avx2+0x37>
     567:	eb 49                	jmp    5b2 <pack_block_avx2+0x82>
     569:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     570:	48 c1 e0 05          	shl    rax,0x5
     574:	48 89 54 24 18       	mov    QWORD PTR [rsp+0x18],rdx
     579:	48 8d 74 24 20       	lea    rsi,[rsp+0x20]
     57e:	48 8d 0d 00 00 00 00 	lea    rcx,[rip+0x0]        # 585 <pack_block_avx2+0x55>
     585:	c5 fd 6f 0c 01       	vmovdqa ymm1,YMMWORD PTR [rcx+rax*1]
     58a:	c4 e2 75 36 c0       	vpermd ymm0,ymm1,ymm0
     58f:	c5 fd 7f 44 24 20    	vmovdqa YMMWORD PTR [rsp+0x20],ymm0
     595:	c5 f8 77             	vzeroupper
     598:	e8 00 00 00 00       	call   59d <pack_block_avx2+0x6d>
     59d:	48 8b 54 24 18       	mov    rdx,QWORD PTR [rsp+0x18]
     5a2:	49 83 c5 01          	add    r13,0x1
     5a6:	49 01 d7             	add    r15,rdx
     5a9:	49 83 c6 20          	add    r14,0x20
     5ad:	4c 39 eb             	cmp    rbx,r13
     5b0:	74 46                	je     5f8 <pack_block_avx2+0xc8>
     5b2:	41 0f b6 75 00       	movzx  esi,BYTE PTR [r13+0x0]
     5b7:	40 0f b6 d6          	movzx  edx,sil
     5bb:	48 89 f0             	mov    rax,rsi
     5be:	41 0f b6 14 14       	movzx  edx,BYTE PTR [r12+rdx*1]
     5c3:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
     5ca:	85 f6                	test   esi,esi
     5cc:	74 d4                	je     5a2 <pack_block_avx2+0x72>
     5ce:	48 8b 4c 24 10       	mov    rcx,QWORD PTR [rsp+0x10]
     5d3:	c4 c1 7e 6f 06       	vmovdqu ymm0,YMMWORD PTR [r14]
     5d8:	4a 8d 3c 39          	lea    rdi,[rcx+r15*1]
     5dc:	81 fe ff 00 00 00    	cmp    esi,0xff
     5e2:	75 8c                	jne    570 <pack_block_avx2+0x40>
     5e4:	49 83 c5 01          	add    r13,0x1
     5e8:	c5 fe 7f 07          	vmovdqu YMMWORD PTR [rdi],ymm0
     5ec:	49 01 d7             	add    r15,rdx
     5ef:	49 83 c6 20          	add    r14,0x20
     5f3:	4c 39 eb             	cmp    rbx,r13
     5f6:	75 ba                	jne    5b2 <pack_block_avx2+0x82>
     5f8:	c5 f8 77             	vzeroupper
     5fb:	48 8d 65 d8          	lea    rsp,[rbp-0x28]
     5ff:	4c 89 f8             	mov    rax,r15
     602:	5b                   	pop    rbx
     603:	41 5c                	pop    r12
     605:	41 5d                	pop    r13
     607:	41 5e                	pop    r14
     609:	41 5f                	pop    r15
     60b:	5d                   	pop    rbp
     60c:	c3                   	ret
     60d:	0f 1f 00             	nop    DWORD PTR [rax]
     610:	45 31 ff             	xor    r15d,r15d
     613:	eb e6                	jmp    5fb <pack_block_avx2+0xcb>
     615:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     61c:	00 00 00 00 

0000000000000620 <gzram_avx2_available>:
     620:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 627 <gzram_avx2_available+0x7>
     627:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     62b:	c0 e8 02             	shr    al,0x2
     62e:	83 e0 01             	and    eax,0x1
     631:	c3                   	ret
     632:	0f 1f 00             	nop    DWORD PTR [rax]
     635:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     63c:	00 00 00 00 

0000000000000640 <gzram_base_encode_scalar>:
     640:	41 8d 40 fb          	lea    eax,[r8-0x5]
     644:	83 f8 07             	cmp    eax,0x7
     647:	0f 87 c3 00 00 00    	ja     710 <gzram_base_encode_scalar+0xd0>
     64d:	48 81 fe 00 10 00 00 	cmp    rsi,0x1000
     654:	0f 87 b6 00 00 00    	ja     710 <gzram_base_encode_scalar+0xd0>
     65a:	48 85 d2             	test   rdx,rdx
     65d:	0f 84 ad 00 00 00    	je     710 <gzram_base_encode_scalar+0xd0>
     663:	48 85 ff             	test   rdi,rdi
     666:	41 0f 94 c1          	sete   r9b
     66a:	48 85 f6             	test   rsi,rsi
     66d:	0f 95 c0             	setne  al
     670:	41 84 c1             	test   r9b,al
     673:	0f 85 97 00 00 00    	jne    710 <gzram_base_encode_scalar+0xd0>
     679:	48 83 f9 07          	cmp    rcx,0x7
     67d:	0f 86 8d 00 00 00    	jbe    710 <gzram_base_encode_scalar+0xd0>
     683:	41 57                	push   r15
     685:	b8 01 00 00 00       	mov    eax,0x1
     68a:	41 56                	push   r14
     68c:	49 89 d6             	mov    r14,rdx
     68f:	48 8d 56 08          	lea    rdx,[rsi+0x8]
     693:	41 55                	push   r13
     695:	45 89 c5             	mov    r13d,r8d
     698:	41 54                	push   r12
     69a:	49 89 fc             	mov    r12,rdi
     69d:	55                   	push   rbp
     69e:	48 89 f5             	mov    rbp,rsi
     6a1:	53                   	push   rbx
     6a2:	48 89 cb             	mov    rbx,rcx
     6a5:	48 81 ec 08 01 00 00 	sub    rsp,0x108
     6ac:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
     6b1:	44 89 c1             	mov    ecx,r8d
     6b4:	48 d3 e0             	shl    rax,cl
     6b7:	49 89 c7             	mov    r15,rax
     6ba:	48 8d 44 30 ff       	lea    rax,[rax+rsi*1-0x1]
     6bf:	48 d3 e8             	shr    rax,cl
     6c2:	4c 8d 40 08          	lea    r8,[rax+0x8]
     6c6:	4c 39 c3             	cmp    rbx,r8
     6c9:	73 55                	jae    720 <gzram_base_encode_scalar+0xe0>
     6cb:	48 39 d3             	cmp    rbx,rdx
     6ce:	72 43                	jb     713 <gzram_base_encode_scalar+0xd3>
     6d0:	48 85 f6             	test   rsi,rsi
     6d3:	0f 85 91 04 00 00    	jne    b6a <gzram_base_encode_scalar+0x52a>
     6d9:	41 c7 06 47 5a 52 31 	mov    DWORD PTR [r14],0x31525a47
     6e0:	8d 45 08             	lea    eax,[rbp+0x8]
     6e3:	41 88 6e 04          	mov    BYTE PTR [r14+0x4],bpl
     6e7:	41 c6 46 05 00       	mov    BYTE PTR [r14+0x5],0x0
     6ec:	45 88 6e 06          	mov    BYTE PTR [r14+0x6],r13b
     6f0:	41 c6 46 07 01       	mov    BYTE PTR [r14+0x7],0x1
     6f5:	48 81 c4 08 01 00 00 	add    rsp,0x108
     6fc:	5b                   	pop    rbx
     6fd:	5d                   	pop    rbp
     6fe:	41 5c                	pop    r12
     700:	41 5d                	pop    r13
     702:	41 5e                	pop    r14
     704:	41 5f                	pop    r15
     706:	c3                   	ret
     707:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     70e:	00 00 
     710:	31 c0                	xor    eax,eax
     712:	c3                   	ret
     713:	31 c0                	xor    eax,eax
     715:	eb de                	jmp    6f5 <gzram_base_encode_scalar+0xb5>
     717:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     71e:	00 00 
     720:	41 c7 06 47 5a 52 31 	mov    DWORD PTR [r14],0x31525a47
     727:	66 41 89 76 04       	mov    WORD PTR [r14+0x4],si
     72c:	45 88 6e 06          	mov    BYTE PTR [r14+0x6],r13b
     730:	41 c6 46 07 00       	mov    BYTE PTR [r14+0x7],0x0
     735:	48 85 c0             	test   rax,rax
     738:	0f 84 81 07 00 00    	je     ebf <gzram_base_encode_scalar+0x87f>
     73e:	49 8d 7e 08          	lea    rdi,[r14+0x8]
     742:	4c 89 74 24 10       	mov    QWORD PTR [rsp+0x10],r14
     747:	4d 89 c6             	mov    r14,r8
     74a:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 751 <gzram_base_encode_scalar+0x111>
     751:	48 01 f8             	add    rax,rdi
     754:	44 89 6c 24 44       	mov    DWORD PTR [rsp+0x44],r13d
     759:	49 89 fd             	mov    r13,rdi
     75c:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
     761:	49 8d 04 34          	lea    rax,[r12+rsi*1]
     765:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
     76a:	48 89 54 24 28       	mov    QWORD PTR [rsp+0x28],rdx
     76f:	48 89 7c 24 48       	mov    QWORD PTR [rsp+0x48],rdi
     774:	4c 89 64 24 30       	mov    QWORD PTR [rsp+0x30],r12
     779:	48 89 74 24 38       	mov    QWORD PTR [rsp+0x38],rsi
     77e:	eb 3f                	jmp    7bf <gzram_base_encode_scalar+0x17f>
     780:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
     785:	4c 29 f0             	sub    rax,r14
     788:	48 39 e8             	cmp    rax,rbp
     78b:	0f 82 80 02 00 00    	jb     a11 <gzram_base_encode_scalar+0x3d1>
     791:	41 c6 45 00 00       	mov    BYTE PTR [r13+0x0],0x0
     796:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
     79b:	48 89 ea             	mov    rdx,rbp
     79e:	4c 89 e6             	mov    rsi,r12
     7a1:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
     7a5:	49 01 ee             	add    r14,rbp
     7a8:	e8 00 00 00 00       	call   7ad <gzram_base_encode_scalar+0x16d>
     7ad:	4d 01 fc             	add    r12,r15
     7b0:	49 83 c5 01          	add    r13,0x1
     7b4:	4c 39 6c 24 18       	cmp    QWORD PTR [rsp+0x18],r13
     7b9:	0f 84 82 03 00 00    	je     b41 <gzram_base_encode_scalar+0x501>
     7bf:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
     7c4:	4c 29 e5             	sub    rbp,r12
     7c7:	4c 39 fd             	cmp    rbp,r15
     7ca:	49 0f 47 ef          	cmova  rbp,r15
     7ce:	48 89 ee             	mov    rsi,rbp
     7d1:	83 e6 1f             	and    esi,0x1f
     7d4:	75 aa                	jne    780 <gzram_base_encode_scalar+0x140>
     7d6:	4d 8b 04 24          	mov    r8,QWORD PTR [r12]
     7da:	4d 8b 54 24 10       	mov    r10,QWORD PTR [r12+0x10]
     7df:	4d 8b 4c 24 08       	mov    r9,QWORD PTR [r12+0x8]
     7e4:	4d 8b 5c 24 18       	mov    r11,QWORD PTR [r12+0x18]
     7e9:	4d 39 d0             	cmp    r8,r10
     7ec:	4c 89 44 24 58       	mov    QWORD PTR [rsp+0x58],r8
     7f1:	4c 89 4c 24 60       	mov    QWORD PTR [rsp+0x60],r9
     7f6:	0f 94 c0             	sete   al
     7f9:	4c 89 54 24 68       	mov    QWORD PTR [rsp+0x68],r10
     7fe:	4c 89 5c 24 70       	mov    QWORD PTR [rsp+0x70],r11
     803:	4d 39 c8             	cmp    r8,r9
     806:	0f 84 64 02 00 00    	je     a70 <gzram_base_encode_scalar+0x430>
     80c:	4d 39 d9             	cmp    r9,r11
     80f:	75 08                	jne    819 <gzram_base_encode_scalar+0x1d9>
     811:	84 c0                	test   al,al
     813:	0f 85 11 03 00 00    	jne    b2a <gzram_base_encode_scalar+0x4ea>
     819:	c7 44 24 40 20 00 00 	mov    DWORD PTR [rsp+0x40],0x20
     820:	00 
     821:	bf 1f 00 00 00       	mov    edi,0x1f
     826:	b8 20 00 00 00       	mov    eax,0x20
     82b:	48 39 e8             	cmp    rax,rbp
     82e:	0f 83 02 04 00 00    	jae    c36 <gzram_base_encode_scalar+0x5f6>
     834:	48 83 fd 20          	cmp    rbp,0x20
     838:	0f 86 ef 03 00 00    	jbe    c2d <gzram_base_encode_scalar+0x5ed>
     83e:	4c 89 c2             	mov    rdx,r8
     841:	b8 20 00 00 00       	mov    eax,0x20
     846:	eb 47                	jmp    88f <gzram_base_encode_scalar+0x24f>
     848:	90                   	nop
     849:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     850:	00 00 00 00 
     854:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     85b:	00 00 00 00 
     85f:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     866:	00 00 00 00 
     86a:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     871:	00 00 00 00 
     875:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     87c:	00 00 00 00 
     880:	48 89 c2             	mov    rdx,rax
     883:	48 21 fa             	and    rdx,rdi
     886:	48 c1 ea 03          	shr    rdx,0x3
     88a:	48 8b 54 d4 58       	mov    rdx,QWORD PTR [rsp+rdx*8+0x58]
     88f:	49 8b 0c 04          	mov    rcx,QWORD PTR [r12+rax*1]
     893:	48 83 c0 08          	add    rax,0x8
     897:	48 39 e8             	cmp    rax,rbp
     89a:	0f 83 e8 00 00 00    	jae    988 <gzram_base_encode_scalar+0x348>
     8a0:	48 39 d1             	cmp    rcx,rdx
     8a3:	74 db                	je     880 <gzram_base_encode_scalar+0x240>
     8a5:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     8ac:	00 00 00 00 
     8b0:	49 89 e9             	mov    r9,rbp
     8b3:	49 c1 e9 05          	shr    r9,0x5
     8b7:	49 c1 e1 05          	shl    r9,0x5
     8bb:	48 8d 7c 24 78       	lea    rdi,[rsp+0x78]
     8c0:	4c 89 e0             	mov    rax,r12
     8c3:	45 31 c0             	xor    r8d,r8d
     8c6:	4d 01 e1             	add    r9,r12
     8c9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     8d0:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
     8d3:	44 8b 50 08          	mov    r10d,DWORD PTR [rax+0x8]
     8d7:	31 d2                	xor    edx,edx
     8d9:	44 8b 18             	mov    r11d,DWORD PTR [rax]
     8dc:	85 c9                	test   ecx,ecx
     8de:	0f 95 c2             	setne  dl
     8e1:	31 c9                	xor    ecx,ecx
     8e3:	01 d2                	add    edx,edx
     8e5:	45 85 d2             	test   r10d,r10d
     8e8:	44 8b 50 0c          	mov    r10d,DWORD PTR [rax+0xc]
     8ec:	0f 95 c1             	setne  cl
     8ef:	c1 e1 02             	shl    ecx,0x2
     8f2:	09 ca                	or     edx,ecx
     8f4:	31 c9                	xor    ecx,ecx
     8f6:	45 85 db             	test   r11d,r11d
     8f9:	44 8b 58 10          	mov    r11d,DWORD PTR [rax+0x10]
     8fd:	0f 95 c1             	setne  cl
     900:	09 ca                	or     edx,ecx
     902:	31 c9                	xor    ecx,ecx
     904:	45 85 d2             	test   r10d,r10d
     907:	44 8b 50 14          	mov    r10d,DWORD PTR [rax+0x14]
     90b:	0f 95 c1             	setne  cl
     90e:	c1 e1 03             	shl    ecx,0x3
     911:	09 ca                	or     edx,ecx
     913:	31 c9                	xor    ecx,ecx
     915:	45 85 db             	test   r11d,r11d
     918:	44 8b 58 18          	mov    r11d,DWORD PTR [rax+0x18]
     91c:	0f 95 c1             	setne  cl
     91f:	c1 e1 04             	shl    ecx,0x4
     922:	09 d1                	or     ecx,edx
     924:	31 d2                	xor    edx,edx
     926:	45 85 d2             	test   r10d,r10d
     929:	44 8b 50 1c          	mov    r10d,DWORD PTR [rax+0x1c]
     92d:	0f 95 c2             	setne  dl
     930:	c1 e2 05             	shl    edx,0x5
     933:	09 ca                	or     edx,ecx
     935:	31 c9                	xor    ecx,ecx
     937:	45 85 db             	test   r11d,r11d
     93a:	0f 95 c1             	setne  cl
     93d:	c1 e1 06             	shl    ecx,0x6
     940:	09 d1                	or     ecx,edx
     942:	31 d2                	xor    edx,edx
     944:	45 85 d2             	test   r10d,r10d
     947:	0f 95 c2             	setne  dl
     94a:	48 83 c0 20          	add    rax,0x20
     94e:	48 83 c7 01          	add    rdi,0x1
     952:	c1 e2 07             	shl    edx,0x7
     955:	09 ca                	or     edx,ecx
     957:	88 57 ff             	mov    BYTE PTR [rdi-0x1],dl
     95a:	0f b6 14 13          	movzx  edx,BYTE PTR [rbx+rdx*1]
     95e:	41 01 d0             	add    r8d,edx
     961:	49 39 c1             	cmp    r9,rax
     964:	0f 85 66 ff ff ff    	jne    8d0 <gzram_base_encode_scalar+0x290>
     96a:	44 89 84 24 f8 00 00 	mov    DWORD PTR [rsp+0xf8],r8d
     971:	00 
     972:	45 85 c0             	test   r8d,r8d
     975:	75 6e                	jne    9e5 <gzram_base_encode_scalar+0x3a5>
     977:	41 c6 45 00 01       	mov    BYTE PTR [r13+0x0],0x1
     97c:	e9 2c fe ff ff       	jmp    7ad <gzram_base_encode_scalar+0x16d>
     981:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     988:	48 39 d1             	cmp    rcx,rdx
     98b:	0f 85 14 ff ff ff    	jne    8a5 <gzram_base_encode_scalar+0x265>
     991:	4d 85 c0             	test   r8,r8
     994:	0f 85 06 01 00 00    	jne    aa0 <gzram_base_encode_scalar+0x460>
     99a:	4d 85 c9             	test   r9,r9
     99d:	75 0a                	jne    9a9 <gzram_base_encode_scalar+0x369>
     99f:	4d 85 d2             	test   r10,r10
     9a2:	75 05                	jne    9a9 <gzram_base_encode_scalar+0x369>
     9a4:	4d 85 db             	test   r11,r11
     9a7:	74 ce                	je     977 <gzram_base_encode_scalar+0x337>
     9a9:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     9b0:	01 00 00 00 
     9b4:	83 7c 24 40 08       	cmp    DWORD PTR [rsp+0x40],0x8
     9b9:	0f 84 96 00 00 00    	je     a55 <gzram_base_encode_scalar+0x415>
     9bf:	83 7c 24 40 10       	cmp    DWORD PTR [rsp+0x40],0x10
     9c4:	0f 84 1a 04 00 00    	je     de4 <gzram_base_encode_scalar+0x7a4>
     9ca:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x8
     9d1:	08 00 00 00 
     9d5:	48 83 fd 20          	cmp    rbp,0x20
     9d9:	0f 87 d0 01 00 00    	ja     baf <gzram_base_encode_scalar+0x56f>
     9df:	41 b8 01 00 00 00    	mov    r8d,0x1
     9e5:	49 89 ea             	mov    r10,rbp
     9e8:	48 8b 54 24 20       	mov    rdx,QWORD PTR [rsp+0x20]
     9ed:	42 8d 04 85 00 00 00 	lea    eax,[r8*4+0x0]
     9f4:	00 
     9f5:	49 c1 ea 05          	shr    r10,0x5
     9f9:	4c 01 d0             	add    rax,r10
     9fc:	4c 29 f2             	sub    rdx,r14
     9ff:	48 39 e8             	cmp    rax,rbp
     a02:	0f 82 50 02 00 00    	jb     c58 <gzram_base_encode_scalar+0x618>
     a08:	48 39 ea             	cmp    rdx,rbp
     a0b:	0f 83 80 fd ff ff    	jae    791 <gzram_base_encode_scalar+0x151>
     a11:	48 8b 54 24 28       	mov    rdx,QWORD PTR [rsp+0x28]
     a16:	48 8b 7c 24 48       	mov    rdi,QWORD PTR [rsp+0x48]
     a1b:	31 c0                	xor    eax,eax
     a1d:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     a22:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     a27:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
     a2c:	44 8b 6c 24 44       	mov    r13d,DWORD PTR [rsp+0x44]
     a31:	48 39 54 24 20       	cmp    QWORD PTR [rsp+0x20],rdx
     a36:	0f 82 b9 fc ff ff    	jb     6f5 <gzram_base_encode_scalar+0xb5>
     a3c:	48 85 ed             	test   rbp,rbp
     a3f:	0f 84 4d 01 00 00    	je     b92 <gzram_base_encode_scalar+0x552>
     a45:	48 89 ea             	mov    rdx,rbp
     a48:	4c 89 e6             	mov    rsi,r12
     a4b:	e8 00 00 00 00       	call   a50 <gzram_base_encode_scalar+0x410>
     a50:	e9 3d 01 00 00       	jmp    b92 <gzram_base_encode_scalar+0x552>
     a55:	48 83 fd 04          	cmp    rbp,0x4
     a59:	0f 86 32 fd ff ff    	jbe    791 <gzram_base_encode_scalar+0x151>
     a5f:	ba 02 00 00 00       	mov    edx,0x2
     a64:	b8 04 00 00 00       	mov    eax,0x4
     a69:	eb 6b                	jmp    ad6 <gzram_base_encode_scalar+0x496>
     a6b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     a70:	4d 39 d8             	cmp    r8,r11
     a73:	0f 85 a0 fd ff ff    	jne    819 <gzram_base_encode_scalar+0x1d9>
     a79:	84 c0                	test   al,al
     a7b:	0f 84 98 fd ff ff    	je     819 <gzram_base_encode_scalar+0x1d9>
     a81:	c7 44 24 40 08 00 00 	mov    DWORD PTR [rsp+0x40],0x8
     a88:	00 
     a89:	bf 07 00 00 00       	mov    edi,0x7
     a8e:	b8 08 00 00 00       	mov    eax,0x8
     a93:	e9 93 fd ff ff       	jmp    82b <gzram_base_encode_scalar+0x1eb>
     a98:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     a9f:	00 
     aa0:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     aa7:	01 00 00 00 
     aab:	83 7c 24 40 08       	cmp    DWORD PTR [rsp+0x40],0x8
     ab0:	0f 85 09 ff ff ff    	jne    9bf <gzram_base_encode_scalar+0x37f>
     ab6:	4c 89 c0             	mov    rax,r8
     ab9:	48 c1 e8 20          	shr    rax,0x20
     abd:	41 39 c0             	cmp    r8d,eax
     ac0:	74 93                	je     a55 <gzram_base_encode_scalar+0x415>
     ac2:	48 83 fd 08          	cmp    rbp,0x8
     ac6:	0f 86 c5 fc ff ff    	jbe    791 <gzram_base_encode_scalar+0x151>
     acc:	ba 03 00 00 00       	mov    edx,0x3
     ad1:	b8 08 00 00 00       	mov    eax,0x8
     ad6:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
     adb:	4c 29 f1             	sub    rcx,r14
     ade:	48 39 c1             	cmp    rcx,rax
     ae1:	0f 82 2a ff ff ff    	jb     a11 <gzram_base_encode_scalar+0x3d1>
     ae7:	48 8b 74 24 10       	mov    rsi,QWORD PTR [rsp+0x10]
     aec:	41 88 55 00          	mov    BYTE PTR [r13+0x0],dl
     af0:	89 c2                	mov    edx,eax
     af2:	4a 8d 0c 36          	lea    rcx,[rsi+r14*1]
     af6:	83 f8 20             	cmp    eax,0x20
     af9:	0f 83 c1 00 00 00    	jae    bc0 <gzram_base_encode_scalar+0x580>
     aff:	a8 10                	test   al,0x10
     b01:	0f 85 f6 02 00 00    	jne    dfd <gzram_base_encode_scalar+0x7bd>
     b07:	a8 08                	test   al,0x8
     b09:	0f 85 1d 03 00 00    	jne    e2c <gzram_base_encode_scalar+0x7ec>
     b0f:	a8 04                	test   al,0x4
     b11:	0f 85 2b 03 00 00    	jne    e42 <gzram_base_encode_scalar+0x802>
     b17:	85 c0                	test   eax,eax
     b19:	74 07                	je     b22 <gzram_base_encode_scalar+0x4e2>
     b1b:	41 0f b6 14 24       	movzx  edx,BYTE PTR [r12]
     b20:	88 11                	mov    BYTE PTR [rcx],dl
     b22:	49 01 c6             	add    r14,rax
     b25:	e9 83 fc ff ff       	jmp    7ad <gzram_base_encode_scalar+0x16d>
     b2a:	c7 44 24 40 10 00 00 	mov    DWORD PTR [rsp+0x40],0x10
     b31:	00 
     b32:	bf 0f 00 00 00       	mov    edi,0xf
     b37:	b8 10 00 00 00       	mov    eax,0x10
     b3c:	e9 ea fc ff ff       	jmp    82b <gzram_base_encode_scalar+0x1eb>
     b41:	48 8b 54 24 28       	mov    rdx,QWORD PTR [rsp+0x28]
     b46:	4d 89 f0             	mov    r8,r14
     b49:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     b4e:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     b53:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
     b58:	44 8b 6c 24 44       	mov    r13d,DWORD PTR [rsp+0x44]
     b5d:	49 39 d0             	cmp    r8,rdx
     b60:	73 1c                	jae    b7e <gzram_base_encode_scalar+0x53e>
     b62:	44 89 c0             	mov    eax,r8d
     b65:	e9 8b fb ff ff       	jmp    6f5 <gzram_base_encode_scalar+0xb5>
     b6a:	48 89 f2             	mov    rdx,rsi
     b6d:	49 8d 7e 08          	lea    rdi,[r14+0x8]
     b71:	4c 89 e6             	mov    rsi,r12
     b74:	e8 00 00 00 00       	call   b79 <gzram_base_encode_scalar+0x539>
     b79:	e9 5b fb ff ff       	jmp    6d9 <gzram_base_encode_scalar+0x99>
     b7e:	48 39 54 24 20       	cmp    QWORD PTR [rsp+0x20],rdx
     b83:	0f 82 8a fb ff ff    	jb     713 <gzram_base_encode_scalar+0xd3>
     b89:	48 85 ed             	test   rbp,rbp
     b8c:	0f 85 42 03 00 00    	jne    ed4 <gzram_base_encode_scalar+0x894>
     b92:	41 c7 06 47 5a 52 31 	mov    DWORD PTR [r14],0x31525a47
     b99:	8d 45 08             	lea    eax,[rbp+0x8]
     b9c:	66 41 89 6e 04       	mov    WORD PTR [r14+0x4],bp
     ba1:	45 88 6e 06          	mov    BYTE PTR [r14+0x6],r13b
     ba5:	41 c6 46 07 01       	mov    BYTE PTR [r14+0x7],0x1
     baa:	e9 46 fb ff ff       	jmp    6f5 <gzram_base_encode_scalar+0xb5>
     baf:	ba 06 00 00 00       	mov    edx,0x6
     bb4:	b8 20 00 00 00       	mov    eax,0x20
     bb9:	e9 18 ff ff ff       	jmp    ad6 <gzram_base_encode_scalar+0x496>
     bbe:	66 90                	xchg   ax,ax
     bc0:	49 8d 34 04          	lea    rsi,[r12+rax*1]
     bc4:	8d 50 ff             	lea    edx,[rax-0x1]
     bc7:	48 8b 7e e0          	mov    rdi,QWORD PTR [rsi-0x20]
     bcb:	48 89 7c 08 e0       	mov    QWORD PTR [rax+rcx*1-0x20],rdi
     bd0:	48 8b 7e e8          	mov    rdi,QWORD PTR [rsi-0x18]
     bd4:	48 89 7c 08 e8       	mov    QWORD PTR [rax+rcx*1-0x18],rdi
     bd9:	48 8b 7e f0          	mov    rdi,QWORD PTR [rsi-0x10]
     bdd:	48 89 7c 08 f0       	mov    QWORD PTR [rax+rcx*1-0x10],rdi
     be2:	48 8b 76 f8          	mov    rsi,QWORD PTR [rsi-0x8]
     be6:	48 89 74 08 f8       	mov    QWORD PTR [rax+rcx*1-0x8],rsi
     beb:	83 fa 20             	cmp    edx,0x20
     bee:	0f 82 2e ff ff ff    	jb     b22 <gzram_base_encode_scalar+0x4e2>
     bf4:	83 e2 e0             	and    edx,0xffffffe0
     bf7:	31 ff                	xor    edi,edi
     bf9:	89 fe                	mov    esi,edi
     bfb:	83 c7 20             	add    edi,0x20
     bfe:	4d 8b 1c 34          	mov    r11,QWORD PTR [r12+rsi*1]
     c02:	4d 8b 54 34 08       	mov    r10,QWORD PTR [r12+rsi*1+0x8]
     c07:	4d 8b 4c 34 10       	mov    r9,QWORD PTR [r12+rsi*1+0x10]
     c0c:	4d 8b 44 34 18       	mov    r8,QWORD PTR [r12+rsi*1+0x18]
     c11:	4c 89 1c 31          	mov    QWORD PTR [rcx+rsi*1],r11
     c15:	4c 89 54 31 08       	mov    QWORD PTR [rcx+rsi*1+0x8],r10
     c1a:	4c 89 4c 31 10       	mov    QWORD PTR [rcx+rsi*1+0x10],r9
     c1f:	4c 89 44 31 18       	mov    QWORD PTR [rcx+rsi*1+0x18],r8
     c24:	39 d7                	cmp    edi,edx
     c26:	72 d1                	jb     bf9 <gzram_base_encode_scalar+0x5b9>
     c28:	e9 f5 fe ff ff       	jmp    b22 <gzram_base_encode_scalar+0x4e2>
     c2d:	48 39 e8             	cmp    rax,rbp
     c30:	0f 82 5b fd ff ff    	jb     991 <gzram_base_encode_scalar+0x351>
     c36:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     c3d:	00 00 00 00 
     c41:	49 89 e9             	mov    r9,rbp
     c44:	49 c1 e9 05          	shr    r9,0x5
     c48:	0f 84 29 fd ff ff    	je     977 <gzram_base_encode_scalar+0x337>
     c4e:	e9 64 fc ff ff       	jmp    8b7 <gzram_base_encode_scalar+0x277>
     c53:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     c58:	48 39 c2             	cmp    rdx,rax
     c5b:	0f 82 b0 fd ff ff    	jb     a11 <gzram_base_encode_scalar+0x3d1>
     c61:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
     c66:	41 c6 45 00 04       	mov    BYTE PTR [r13+0x0],0x4
     c6b:	4c 01 f0             	add    rax,r14
     c6e:	41 83 fa 20          	cmp    r10d,0x20
     c72:	0f 83 f0 00 00 00    	jae    d68 <gzram_base_encode_scalar+0x728>
     c78:	41 f6 c2 10          	test   r10b,0x10
     c7c:	0f 85 d4 01 00 00    	jne    e56 <gzram_base_encode_scalar+0x816>
     c82:	41 f6 c2 08          	test   r10b,0x8
     c86:	0f 85 03 02 00 00    	jne    e8f <gzram_base_encode_scalar+0x84f>
     c8c:	41 f6 c2 04          	test   r10b,0x4
     c90:	0f 85 13 02 00 00    	jne    ea9 <gzram_base_encode_scalar+0x869>
     c96:	45 85 d2             	test   r10d,r10d
     c99:	74 11                	je     cac <gzram_base_encode_scalar+0x66c>
     c9b:	0f b6 54 24 78       	movzx  edx,BYTE PTR [rsp+0x78]
     ca0:	88 10                	mov    BYTE PTR [rax],dl
     ca2:	41 f6 c2 02          	test   r10b,0x2
     ca6:	0f 85 31 02 00 00    	jne    edd <gzram_base_encode_scalar+0x89d>
     cac:	4d 01 d6             	add    r14,r10
     caf:	4d 85 d2             	test   r10,r10
     cb2:	0f 84 f5 fa ff ff    	je     7ad <gzram_base_encode_scalar+0x16d>
     cb8:	49 c1 e2 05          	shl    r10,0x5
     cbc:	4c 8b 5c 24 10       	mov    r11,QWORD PTR [rsp+0x10]
     cc1:	4c 8d 4c 24 78       	lea    r9,[rsp+0x78]
     cc6:	4d 89 e0             	mov    r8,r12
     cc9:	4d 01 e2             	add    r10,r12
     ccc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     cd0:	41 0f b6 09          	movzx  ecx,BYTE PTR [r9]
     cd4:	49 8d 14 36          	lea    rdx,[r14+rsi*1]
     cd8:	4c 01 da             	add    rdx,r11
     cdb:	81 f9 ff 00 00 00    	cmp    ecx,0xff
     ce1:	74 65                	je     d48 <gzram_base_encode_scalar+0x708>
     ce3:	89 c8                	mov    eax,ecx
     ce5:	85 c9                	test   ecx,ecx
     ce7:	74 36                	je     d1f <gzram_base_encode_scalar+0x6df>
     ce9:	90                   	nop
     cea:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     cf1:	00 00 00 00 
     cf5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     cfc:	00 00 00 00 
     d00:	31 ed                	xor    ebp,ebp
     d02:	8d 78 ff             	lea    edi,[rax-0x1]
     d05:	48 83 c2 04          	add    rdx,0x4
     d09:	f3 0f bc e8          	tzcnt  ebp,eax
     d0d:	8d 2c ad 00 00 00 00 	lea    ebp,[rbp*4+0x0]
     d14:	41 8b 2c 28          	mov    ebp,DWORD PTR [r8+rbp*1]
     d18:	89 6a fc             	mov    DWORD PTR [rdx-0x4],ebp
     d1b:	21 f8                	and    eax,edi
     d1d:	75 e1                	jne    d00 <gzram_base_encode_scalar+0x6c0>
     d1f:	0f b6 04 0b          	movzx  eax,BYTE PTR [rbx+rcx*1]
     d23:	49 83 c0 20          	add    r8,0x20
     d27:	49 83 c1 01          	add    r9,0x1
     d2b:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
     d32:	48 01 c6             	add    rsi,rax
     d35:	4d 39 d0             	cmp    r8,r10
     d38:	75 96                	jne    cd0 <gzram_base_encode_scalar+0x690>
     d3a:	49 01 f6             	add    r14,rsi
     d3d:	e9 6b fa ff ff       	jmp    7ad <gzram_base_encode_scalar+0x16d>
     d42:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     d48:	49 8b 00             	mov    rax,QWORD PTR [r8]
     d4b:	48 89 02             	mov    QWORD PTR [rdx],rax
     d4e:	49 8b 40 08          	mov    rax,QWORD PTR [r8+0x8]
     d52:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
     d56:	49 8b 40 10          	mov    rax,QWORD PTR [r8+0x10]
     d5a:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
     d5e:	49 8b 40 18          	mov    rax,QWORD PTR [r8+0x18]
     d62:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
     d66:	eb b7                	jmp    d1f <gzram_base_encode_scalar+0x6df>
     d68:	44 89 d1             	mov    ecx,r10d
     d6b:	48 8d 14 08          	lea    rdx,[rax+rcx*1]
     d6f:	48 8d 4c 0c 78       	lea    rcx,[rsp+rcx*1+0x78]
     d74:	48 8b 79 e0          	mov    rdi,QWORD PTR [rcx-0x20]
     d78:	48 89 7a e0          	mov    QWORD PTR [rdx-0x20],rdi
     d7c:	48 8b 79 e8          	mov    rdi,QWORD PTR [rcx-0x18]
     d80:	48 89 7a e8          	mov    QWORD PTR [rdx-0x18],rdi
     d84:	48 8b 79 f0          	mov    rdi,QWORD PTR [rcx-0x10]
     d88:	48 89 7a f0          	mov    QWORD PTR [rdx-0x10],rdi
     d8c:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
     d90:	48 89 4a f8          	mov    QWORD PTR [rdx-0x8],rcx
     d94:	41 8d 4a ff          	lea    ecx,[r10-0x1]
     d98:	83 f9 20             	cmp    ecx,0x20
     d9b:	0f 82 0b ff ff ff    	jb     cac <gzram_base_encode_scalar+0x66c>
     da1:	83 e1 e0             	and    ecx,0xffffffe0
     da4:	31 ff                	xor    edi,edi
     da6:	89 fa                	mov    edx,edi
     da8:	83 c7 20             	add    edi,0x20
     dab:	48 8b 6c 14 78       	mov    rbp,QWORD PTR [rsp+rdx*1+0x78]
     db0:	4c 8b 9c 14 80 00 00 	mov    r11,QWORD PTR [rsp+rdx*1+0x80]
     db7:	00 
     db8:	4c 8b 8c 14 88 00 00 	mov    r9,QWORD PTR [rsp+rdx*1+0x88]
     dbf:	00 
     dc0:	4c 8b 84 14 90 00 00 	mov    r8,QWORD PTR [rsp+rdx*1+0x90]
     dc7:	00 
     dc8:	48 89 2c 10          	mov    QWORD PTR [rax+rdx*1],rbp
     dcc:	4c 89 5c 10 08       	mov    QWORD PTR [rax+rdx*1+0x8],r11
     dd1:	4c 89 4c 10 10       	mov    QWORD PTR [rax+rdx*1+0x10],r9
     dd6:	4c 89 44 10 18       	mov    QWORD PTR [rax+rdx*1+0x18],r8
     ddb:	39 cf                	cmp    edi,ecx
     ddd:	72 c7                	jb     da6 <gzram_base_encode_scalar+0x766>
     ddf:	e9 c8 fe ff ff       	jmp    cac <gzram_base_encode_scalar+0x66c>
     de4:	48 83 fd 10          	cmp    rbp,0x10
     de8:	0f 86 a3 f9 ff ff    	jbe    791 <gzram_base_encode_scalar+0x151>
     dee:	ba 05 00 00 00       	mov    edx,0x5
     df3:	b8 10 00 00 00       	mov    eax,0x10
     df8:	e9 d9 fc ff ff       	jmp    ad6 <gzram_base_encode_scalar+0x496>
     dfd:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     e01:	48 89 31             	mov    QWORD PTR [rcx],rsi
     e04:	49 8b 74 24 08       	mov    rsi,QWORD PTR [r12+0x8]
     e09:	48 89 71 08          	mov    QWORD PTR [rcx+0x8],rsi
     e0d:	48 8d 4c 11 10       	lea    rcx,[rcx+rdx*1+0x10]
     e12:	49 8d 54 14 10       	lea    rdx,[r12+rdx*1+0x10]
     e17:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
     e1b:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
     e1f:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     e23:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
     e27:	e9 f6 fc ff ff       	jmp    b22 <gzram_base_encode_scalar+0x4e2>
     e2c:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     e30:	48 89 31             	mov    QWORD PTR [rcx],rsi
     e33:	49 8b 74 14 f8       	mov    rsi,QWORD PTR [r12+rdx*1-0x8]
     e38:	48 89 74 11 f8       	mov    QWORD PTR [rcx+rdx*1-0x8],rsi
     e3d:	e9 e0 fc ff ff       	jmp    b22 <gzram_base_encode_scalar+0x4e2>
     e42:	41 8b 34 24          	mov    esi,DWORD PTR [r12]
     e46:	89 31                	mov    DWORD PTR [rcx],esi
     e48:	41 8b 74 14 fc       	mov    esi,DWORD PTR [r12+rdx*1-0x4]
     e4d:	89 74 11 fc          	mov    DWORD PTR [rcx+rdx*1-0x4],esi
     e51:	e9 cc fc ff ff       	jmp    b22 <gzram_base_encode_scalar+0x4e2>
     e56:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     e5b:	48 89 10             	mov    QWORD PTR [rax],rdx
     e5e:	48 8b 94 24 80 00 00 	mov    rdx,QWORD PTR [rsp+0x80]
     e65:	00 
     e66:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     e6a:	44 89 d2             	mov    edx,r10d
     e6d:	48 8d 44 10 10       	lea    rax,[rax+rdx*1+0x10]
     e72:	48 8d 94 14 88 00 00 	lea    rdx,[rsp+rdx*1+0x88]
     e79:	00 
     e7a:	48 8b 4a e0          	mov    rcx,QWORD PTR [rdx-0x20]
     e7e:	48 89 48 e0          	mov    QWORD PTR [rax-0x20],rcx
     e82:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     e86:	48 89 50 e8          	mov    QWORD PTR [rax-0x18],rdx
     e8a:	e9 1d fe ff ff       	jmp    cac <gzram_base_encode_scalar+0x66c>
     e8f:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     e94:	48 89 10             	mov    QWORD PTR [rax],rdx
     e97:	44 89 d2             	mov    edx,r10d
     e9a:	48 8b 4c 14 70       	mov    rcx,QWORD PTR [rsp+rdx*1+0x70]
     e9f:	48 89 4c 10 f8       	mov    QWORD PTR [rax+rdx*1-0x8],rcx
     ea4:	e9 03 fe ff ff       	jmp    cac <gzram_base_encode_scalar+0x66c>
     ea9:	8b 54 24 78          	mov    edx,DWORD PTR [rsp+0x78]
     ead:	89 10                	mov    DWORD PTR [rax],edx
     eaf:	44 89 d2             	mov    edx,r10d
     eb2:	8b 4c 14 74          	mov    ecx,DWORD PTR [rsp+rdx*1+0x74]
     eb6:	89 4c 10 fc          	mov    DWORD PTR [rax+rdx*1-0x4],ecx
     eba:	e9 ed fd ff ff       	jmp    cac <gzram_base_encode_scalar+0x66c>
     ebf:	41 b8 08 00 00 00    	mov    r8d,0x8
     ec5:	48 83 fa 08          	cmp    rdx,0x8
     ec9:	0f 85 93 fc ff ff    	jne    b62 <gzram_base_encode_scalar+0x522>
     ecf:	e9 b5 fc ff ff       	jmp    b89 <gzram_base_encode_scalar+0x549>
     ed4:	49 8d 7e 08          	lea    rdi,[r14+0x8]
     ed8:	e9 68 fb ff ff       	jmp    a45 <gzram_base_encode_scalar+0x405>
     edd:	44 89 d2             	mov    edx,r10d
     ee0:	0f b7 4c 14 76       	movzx  ecx,WORD PTR [rsp+rdx*1+0x76]
     ee5:	66 89 4c 10 fe       	mov    WORD PTR [rax+rdx*1-0x2],cx
     eea:	e9 bd fd ff ff       	jmp    cac <gzram_base_encode_scalar+0x66c>
     eef:	90                   	nop

0000000000000ef0 <gzram_base_encode_avx2>:
     ef0:	48 81 ec 18 01 00 00 	sub    rsp,0x118
     ef7:	48 89 9c 24 e8 00 00 	mov    QWORD PTR [rsp+0xe8],rbx
     efe:	00 
     eff:	48 89 d3             	mov    rbx,rdx
     f02:	48 89 ac 24 f0 00 00 	mov    QWORD PTR [rsp+0xf0],rbp
     f09:	00 
     f0a:	48 89 f5             	mov    rbp,rsi
     f0d:	4c 89 a4 24 f8 00 00 	mov    QWORD PTR [rsp+0xf8],r12
     f14:	00 
     f15:	45 89 c4             	mov    r12d,r8d
     f18:	4c 89 ac 24 00 01 00 	mov    QWORD PTR [rsp+0x100],r13
     f1f:	00 
     f20:	49 89 cd             	mov    r13,rcx
     f23:	4c 89 bc 24 10 01 00 	mov    QWORD PTR [rsp+0x110],r15
     f2a:	00 
     f2b:	49 89 ff             	mov    r15,rdi
     f2e:	e8 00 00 00 00       	call   f33 <gzram_base_encode_avx2+0x43>
     f33:	85 c0                	test   eax,eax
     f35:	0f 84 a5 00 00 00    	je     fe0 <gzram_base_encode_avx2+0xf0>
     f3b:	41 8d 44 24 fb       	lea    eax,[r12-0x5]
     f40:	83 f8 07             	cmp    eax,0x7
     f43:	0f 87 e7 00 00 00    	ja     1030 <gzram_base_encode_avx2+0x140>
     f49:	48 81 fd 00 10 00 00 	cmp    rbp,0x1000
     f50:	0f 87 da 00 00 00    	ja     1030 <gzram_base_encode_avx2+0x140>
     f56:	48 85 db             	test   rbx,rbx
     f59:	0f 84 d1 00 00 00    	je     1030 <gzram_base_encode_avx2+0x140>
     f5f:	4d 85 ff             	test   r15,r15
     f62:	0f 94 c2             	sete   dl
     f65:	48 85 ed             	test   rbp,rbp
     f68:	0f 95 c0             	setne  al
     f6b:	84 c2                	test   dl,al
     f6d:	0f 85 bd 00 00 00    	jne    1030 <gzram_base_encode_avx2+0x140>
     f73:	49 83 fd 07          	cmp    r13,0x7
     f77:	0f 86 b3 00 00 00    	jbe    1030 <gzram_base_encode_avx2+0x140>
     f7d:	44 89 e1             	mov    ecx,r12d
     f80:	b8 01 00 00 00       	mov    eax,0x1
     f85:	4c 89 b4 24 08 01 00 	mov    QWORD PTR [rsp+0x108],r14
     f8c:	00 
     f8d:	48 8d 75 08          	lea    rsi,[rbp+0x8]
     f91:	48 d3 e0             	shl    rax,cl
     f94:	49 89 c6             	mov    r14,rax
     f97:	48 8d 44 28 ff       	lea    rax,[rax+rbp*1-0x1]
     f9c:	48 d3 e8             	shr    rax,cl
     f9f:	4c 8d 40 08          	lea    r8,[rax+0x8]
     fa3:	4d 39 c5             	cmp    r13,r8
     fa6:	0f 83 bc 00 00 00    	jae    1068 <gzram_base_encode_avx2+0x178>
     fac:	49 39 f5             	cmp    r13,rsi
     faf:	72 72                	jb     1023 <gzram_base_encode_avx2+0x133>
     fb1:	48 85 ed             	test   rbp,rbp
     fb4:	0f 85 49 03 00 00    	jne    1303 <gzram_base_encode_avx2+0x413>
     fba:	c7 03 47 5a 52 31    	mov    DWORD PTR [rbx],0x31525a47
     fc0:	8d 45 08             	lea    eax,[rbp+0x8]
     fc3:	40 88 6b 04          	mov    BYTE PTR [rbx+0x4],bpl
     fc7:	c6 43 05 00          	mov    BYTE PTR [rbx+0x5],0x0
     fcb:	44 88 63 06          	mov    BYTE PTR [rbx+0x6],r12b
     fcf:	c6 43 07 01          	mov    BYTE PTR [rbx+0x7],0x1
     fd3:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
     fda:	00 
     fdb:	eb 55                	jmp    1032 <gzram_base_encode_avx2+0x142>
     fdd:	0f 1f 00             	nop    DWORD PTR [rax]
     fe0:	45 89 e0             	mov    r8d,r12d
     fe3:	4c 89 e9             	mov    rcx,r13
     fe6:	48 89 da             	mov    rdx,rbx
     fe9:	48 89 ee             	mov    rsi,rbp
     fec:	48 8b 9c 24 e8 00 00 	mov    rbx,QWORD PTR [rsp+0xe8]
     ff3:	00 
     ff4:	48 8b ac 24 f0 00 00 	mov    rbp,QWORD PTR [rsp+0xf0]
     ffb:	00 
     ffc:	4c 89 ff             	mov    rdi,r15
     fff:	4c 8b a4 24 f8 00 00 	mov    r12,QWORD PTR [rsp+0xf8]
    1006:	00 
    1007:	4c 8b ac 24 00 01 00 	mov    r13,QWORD PTR [rsp+0x100]
    100e:	00 
    100f:	4c 8b bc 24 10 01 00 	mov    r15,QWORD PTR [rsp+0x110]
    1016:	00 
    1017:	48 81 c4 18 01 00 00 	add    rsp,0x118
    101e:	e9 00 00 00 00       	jmp    1023 <gzram_base_encode_avx2+0x133>
    1023:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
    102a:	00 
    102b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1030:	31 c0                	xor    eax,eax
    1032:	48 8b 9c 24 e8 00 00 	mov    rbx,QWORD PTR [rsp+0xe8]
    1039:	00 
    103a:	48 8b ac 24 f0 00 00 	mov    rbp,QWORD PTR [rsp+0xf0]
    1041:	00 
    1042:	4c 8b a4 24 f8 00 00 	mov    r12,QWORD PTR [rsp+0xf8]
    1049:	00 
    104a:	4c 8b ac 24 00 01 00 	mov    r13,QWORD PTR [rsp+0x100]
    1051:	00 
    1052:	4c 8b bc 24 10 01 00 	mov    r15,QWORD PTR [rsp+0x110]
    1059:	00 
    105a:	48 81 c4 18 01 00 00 	add    rsp,0x118
    1061:	c3                   	ret
    1062:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1068:	c7 03 47 5a 52 31    	mov    DWORD PTR [rbx],0x31525a47
    106e:	66 89 6b 04          	mov    WORD PTR [rbx+0x4],bp
    1072:	44 88 63 06          	mov    BYTE PTR [rbx+0x6],r12b
    1076:	c6 43 07 00          	mov    BYTE PTR [rbx+0x7],0x0
    107a:	48 85 c0             	test   rax,rax
    107d:	0f 84 83 05 00 00    	je     1606 <gzram_base_encode_avx2+0x716>
    1083:	4c 8d 5b 08          	lea    r11,[rbx+0x8]
    1087:	48 89 6c 24 38       	mov    QWORD PTR [rsp+0x38],rbp
    108c:	4c 01 d8             	add    rax,r11
    108f:	4c 89 6c 24 20       	mov    QWORD PTR [rsp+0x20],r13
    1094:	4d 89 c5             	mov    r13,r8
    1097:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
    109c:	49 8d 04 2f          	lea    rax,[r15+rbp*1]
    10a0:	4c 89 fd             	mov    rbp,r15
    10a3:	44 89 64 24 44       	mov    DWORD PTR [rsp+0x44],r12d
    10a8:	4d 89 dc             	mov    r12,r11
    10ab:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
    10b0:	48 89 74 24 28       	mov    QWORD PTR [rsp+0x28],rsi
    10b5:	4c 89 5c 24 48       	mov    QWORD PTR [rsp+0x48],r11
    10ba:	4c 89 7c 24 30       	mov    QWORD PTR [rsp+0x30],r15
    10bf:	eb 48                	jmp    1109 <gzram_base_encode_avx2+0x219>
    10c1:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    10c8:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
    10cd:	4c 29 e8             	sub    rax,r13
    10d0:	4c 39 c0             	cmp    rax,r8
    10d3:	0f 82 b8 01 00 00    	jb     1291 <gzram_base_encode_avx2+0x3a1>
    10d9:	41 c6 04 24 00       	mov    BYTE PTR [r12],0x0
    10de:	4a 8d 3c 2b          	lea    rdi,[rbx+r13*1]
    10e2:	4c 89 c2             	mov    rdx,r8
    10e5:	48 89 ee             	mov    rsi,rbp
    10e8:	4c 89 44 24 18       	mov    QWORD PTR [rsp+0x18],r8
    10ed:	e8 00 00 00 00       	call   10f2 <gzram_base_encode_avx2+0x202>
    10f2:	4c 03 6c 24 18       	add    r13,QWORD PTR [rsp+0x18]
    10f7:	4c 01 f5             	add    rbp,r14
    10fa:	49 83 c4 01          	add    r12,0x1
    10fe:	4c 39 64 24 10       	cmp    QWORD PTR [rsp+0x10],r12
    1103:	0f 84 4f 01 00 00    	je     1258 <gzram_base_encode_avx2+0x368>
    1109:	4c 8b 44 24 08       	mov    r8,QWORD PTR [rsp+0x8]
    110e:	49 29 e8             	sub    r8,rbp
    1111:	4d 39 f0             	cmp    r8,r14
    1114:	4d 0f 47 c6          	cmova  r8,r14
    1118:	4d 89 c7             	mov    r15,r8
    111b:	41 83 e7 1f          	and    r15d,0x1f
    111f:	75 a7                	jne    10c8 <gzram_base_encode_avx2+0x1d8>
    1121:	4c 89 c6             	mov    rsi,r8
    1124:	48 8d 54 24 58       	lea    rdx,[rsp+0x58]
    1129:	48 89 ef             	mov    rdi,rbp
    112c:	4c 89 44 24 18       	mov    QWORD PTR [rsp+0x18],r8
    1131:	e8 7a f0 ff ff       	call   1b0 <scan_avx2>
    1136:	8b 84 24 d8 00 00 00 	mov    eax,DWORD PTR [rsp+0xd8]
    113d:	4c 8b 44 24 18       	mov    r8,QWORD PTR [rsp+0x18]
    1142:	85 c0                	test   eax,eax
    1144:	75 0a                	jne    1150 <gzram_base_encode_avx2+0x260>
    1146:	41 c6 04 24 01       	mov    BYTE PTR [r12],0x1
    114b:	eb aa                	jmp    10f7 <gzram_base_encode_avx2+0x207>
    114d:	0f 1f 00             	nop    DWORD PTR [rax]
    1150:	8b 94 24 dc 00 00 00 	mov    edx,DWORD PTR [rsp+0xdc]
    1157:	f6 c2 01             	test   dl,0x1
    115a:	0f 84 d0 00 00 00    	je     1230 <gzram_base_encode_avx2+0x340>
    1160:	49 83 f8 04          	cmp    r8,0x4
    1164:	0f 86 6f ff ff ff    	jbe    10d9 <gzram_base_encode_avx2+0x1e9>
    116a:	ba 02 00 00 00       	mov    edx,0x2
    116f:	b8 04 00 00 00       	mov    eax,0x4
    1174:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
    1179:	4c 29 e9             	sub    rcx,r13
    117c:	48 39 c1             	cmp    rcx,rax
    117f:	0f 82 0c 01 00 00    	jb     1291 <gzram_base_encode_avx2+0x3a1>
    1185:	41 88 14 24          	mov    BYTE PTR [r12],dl
    1189:	4a 8d 34 2b          	lea    rsi,[rbx+r13*1]
    118d:	89 c2                	mov    edx,eax
    118f:	83 f8 20             	cmp    eax,0x20
    1192:	73 2c                	jae    11c0 <gzram_base_encode_avx2+0x2d0>
    1194:	a8 10                	test   al,0x10
    1196:	0f 85 a9 03 00 00    	jne    1545 <gzram_base_encode_avx2+0x655>
    119c:	a8 08                	test   al,0x8
    119e:	0f 85 cf 03 00 00    	jne    1573 <gzram_base_encode_avx2+0x683>
    11a4:	a8 04                	test   al,0x4
    11a6:	0f 85 dd 03 00 00    	jne    1589 <gzram_base_encode_avx2+0x699>
    11ac:	85 c0                	test   eax,eax
    11ae:	74 06                	je     11b6 <gzram_base_encode_avx2+0x2c6>
    11b0:	0f b6 55 00          	movzx  edx,BYTE PTR [rbp+0x0]
    11b4:	88 16                	mov    BYTE PTR [rsi],dl
    11b6:	49 01 c5             	add    r13,rax
    11b9:	e9 39 ff ff ff       	jmp    10f7 <gzram_base_encode_avx2+0x207>
    11be:	66 90                	xchg   ax,ax
    11c0:	48 8d 4c 05 00       	lea    rcx,[rbp+rax*1+0x0]
    11c5:	8d 50 ff             	lea    edx,[rax-0x1]
    11c8:	48 8b 79 e0          	mov    rdi,QWORD PTR [rcx-0x20]
    11cc:	48 89 7c 30 e0       	mov    QWORD PTR [rax+rsi*1-0x20],rdi
    11d1:	48 8b 79 e8          	mov    rdi,QWORD PTR [rcx-0x18]
    11d5:	48 89 7c 30 e8       	mov    QWORD PTR [rax+rsi*1-0x18],rdi
    11da:	48 8b 79 f0          	mov    rdi,QWORD PTR [rcx-0x10]
    11de:	48 89 7c 30 f0       	mov    QWORD PTR [rax+rsi*1-0x10],rdi
    11e3:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
    11e7:	48 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],rcx
    11ec:	83 fa 20             	cmp    edx,0x20
    11ef:	72 c5                	jb     11b6 <gzram_base_encode_avx2+0x2c6>
    11f1:	83 e2 e0             	and    edx,0xffffffe0
    11f4:	31 ff                	xor    edi,edi
    11f6:	89 f9                	mov    ecx,edi
    11f8:	83 c7 20             	add    edi,0x20
    11fb:	4c 8b 5c 0d 00       	mov    r11,QWORD PTR [rbp+rcx*1+0x0]
    1200:	4c 8b 54 0d 08       	mov    r10,QWORD PTR [rbp+rcx*1+0x8]
    1205:	4c 8b 4c 0d 10       	mov    r9,QWORD PTR [rbp+rcx*1+0x10]
    120a:	4c 8b 44 0d 18       	mov    r8,QWORD PTR [rbp+rcx*1+0x18]
    120f:	4c 89 1c 0e          	mov    QWORD PTR [rsi+rcx*1],r11
    1213:	4c 89 54 0e 08       	mov    QWORD PTR [rsi+rcx*1+0x8],r10
    1218:	4c 89 4c 0e 10       	mov    QWORD PTR [rsi+rcx*1+0x10],r9
    121d:	4c 89 44 0e 18       	mov    QWORD PTR [rsi+rcx*1+0x18],r8
    1222:	39 d7                	cmp    edi,edx
    1224:	72 d0                	jb     11f6 <gzram_base_encode_avx2+0x306>
    1226:	eb 8e                	jmp    11b6 <gzram_base_encode_avx2+0x2c6>
    1228:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    122f:	00 
    1230:	f6 c2 02             	test   dl,0x2
    1233:	0f 84 ac 00 00 00    	je     12e5 <gzram_base_encode_avx2+0x3f5>
    1239:	49 83 f8 08          	cmp    r8,0x8
    123d:	0f 86 96 fe ff ff    	jbe    10d9 <gzram_base_encode_avx2+0x1e9>
    1243:	ba 03 00 00 00       	mov    edx,0x3
    1248:	b8 08 00 00 00       	mov    eax,0x8
    124d:	e9 22 ff ff ff       	jmp    1174 <gzram_base_encode_avx2+0x284>
    1252:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1258:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
    125d:	4c 8b 7c 24 30       	mov    r15,QWORD PTR [rsp+0x30]
    1262:	4d 89 e8             	mov    r8,r13
    1265:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
    126a:	44 8b 64 24 44       	mov    r12d,DWORD PTR [rsp+0x44]
    126f:	49 39 f5             	cmp    r13,rsi
    1272:	0f 83 9f 00 00 00    	jae    1317 <gzram_base_encode_avx2+0x427>
    1278:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
    127f:	00 
    1280:	44 89 c0             	mov    eax,r8d
    1283:	e9 aa fd ff ff       	jmp    1032 <gzram_base_encode_avx2+0x142>
    1288:	4c 39 c6             	cmp    rsi,r8
    128b:	0f 83 48 fe ff ff    	jae    10d9 <gzram_base_encode_avx2+0x1e9>
    1291:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
    1296:	4c 8b 6c 24 20       	mov    r13,QWORD PTR [rsp+0x20]
    129b:	31 c0                	xor    eax,eax
    129d:	4c 8b 5c 24 48       	mov    r11,QWORD PTR [rsp+0x48]
    12a2:	4c 8b 7c 24 30       	mov    r15,QWORD PTR [rsp+0x30]
    12a7:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
    12ac:	44 8b 64 24 44       	mov    r12d,DWORD PTR [rsp+0x44]
    12b1:	49 39 f5             	cmp    r13,rsi
    12b4:	0f 82 e1 02 00 00    	jb     159b <gzram_base_encode_avx2+0x6ab>
    12ba:	48 85 ed             	test   rbp,rbp
    12bd:	0f 85 e5 02 00 00    	jne    15a8 <gzram_base_encode_avx2+0x6b8>
    12c3:	c7 03 47 5a 52 31    	mov    DWORD PTR [rbx],0x31525a47
    12c9:	8d 45 08             	lea    eax,[rbp+0x8]
    12cc:	66 89 6b 04          	mov    WORD PTR [rbx+0x4],bp
    12d0:	44 88 63 06          	mov    BYTE PTR [rbx+0x6],r12b
    12d4:	c6 43 07 01          	mov    BYTE PTR [rbx+0x7],0x1
    12d8:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
    12df:	00 
    12e0:	e9 4d fd ff ff       	jmp    1032 <gzram_base_encode_avx2+0x142>
    12e5:	f6 c2 04             	test   dl,0x4
    12e8:	74 4e                	je     1338 <gzram_base_encode_avx2+0x448>
    12ea:	49 83 f8 10          	cmp    r8,0x10
    12ee:	0f 86 e5 fd ff ff    	jbe    10d9 <gzram_base_encode_avx2+0x1e9>
    12f4:	ba 05 00 00 00       	mov    edx,0x5
    12f9:	b8 10 00 00 00       	mov    eax,0x10
    12fe:	e9 71 fe ff ff       	jmp    1174 <gzram_base_encode_avx2+0x284>
    1303:	48 8d 7b 08          	lea    rdi,[rbx+0x8]
    1307:	48 89 ea             	mov    rdx,rbp
    130a:	4c 89 fe             	mov    rsi,r15
    130d:	e8 00 00 00 00       	call   1312 <gzram_base_encode_avx2+0x422>
    1312:	e9 a3 fc ff ff       	jmp    fba <gzram_base_encode_avx2+0xca>
    1317:	48 39 74 24 20       	cmp    QWORD PTR [rsp+0x20],rsi
    131c:	0f 82 01 fd ff ff    	jb     1023 <gzram_base_encode_avx2+0x133>
    1322:	48 85 ed             	test   rbp,rbp
    1325:	74 9c                	je     12c3 <gzram_base_encode_avx2+0x3d3>
    1327:	48 8d 7b 08          	lea    rdi,[rbx+0x8]
    132b:	48 89 ea             	mov    rdx,rbp
    132e:	4c 89 fe             	mov    rsi,r15
    1331:	e8 00 00 00 00       	call   1336 <gzram_base_encode_avx2+0x446>
    1336:	eb 8b                	jmp    12c3 <gzram_base_encode_avx2+0x3d3>
    1338:	83 e2 08             	and    edx,0x8
    133b:	74 0a                	je     1347 <gzram_base_encode_avx2+0x457>
    133d:	49 83 f8 20          	cmp    r8,0x20
    1341:	0f 87 e9 02 00 00    	ja     1630 <gzram_base_encode_avx2+0x740>
    1347:	4c 89 c1             	mov    rcx,r8
    134a:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
    134f:	8d 14 85 00 00 00 00 	lea    edx,[rax*4+0x0]
    1356:	48 c1 e9 05          	shr    rcx,0x5
    135a:	48 01 ca             	add    rdx,rcx
    135d:	4c 29 ee             	sub    rsi,r13
    1360:	4c 39 c2             	cmp    rdx,r8
    1363:	0f 83 1f ff ff ff    	jae    1288 <gzram_base_encode_avx2+0x398>
    1369:	48 39 d6             	cmp    rsi,rdx
    136c:	0f 82 1f ff ff ff    	jb     1291 <gzram_base_encode_avx2+0x3a1>
    1372:	41 c6 04 24 04       	mov    BYTE PTR [r12],0x4
    1377:	4a 8d 34 2b          	lea    rsi,[rbx+r13*1]
    137b:	83 f9 20             	cmp    ecx,0x20
    137e:	0f 83 2c 01 00 00    	jae    14b0 <gzram_base_encode_avx2+0x5c0>
    1384:	f6 c1 10             	test   cl,0x10
    1387:	0f 85 2e 02 00 00    	jne    15bb <gzram_base_encode_avx2+0x6cb>
    138d:	f6 c1 08             	test   cl,0x8
    1390:	0f 85 57 02 00 00    	jne    15ed <gzram_base_encode_avx2+0x6fd>
    1396:	f6 c1 04             	test   cl,0x4
    1399:	0f 85 7c 02 00 00    	jne    161b <gzram_base_encode_avx2+0x72b>
    139f:	85 c9                	test   ecx,ecx
    13a1:	74 10                	je     13b3 <gzram_base_encode_avx2+0x4c3>
    13a3:	0f b6 54 24 58       	movzx  edx,BYTE PTR [rsp+0x58]
    13a8:	88 16                	mov    BYTE PTR [rsi],dl
    13aa:	f6 c1 02             	test   cl,0x2
    13ad:	0f 85 8c 02 00 00    	jne    163f <gzram_base_encode_avx2+0x74f>
    13b3:	89 c0                	mov    eax,eax
    13b5:	48 8d 14 09          	lea    rdx,[rcx+rcx*1]
    13b9:	49 01 cd             	add    r13,rcx
    13bc:	48 39 c2             	cmp    rdx,rax
    13bf:	0f 82 6a 01 00 00    	jb     152f <gzram_base_encode_avx2+0x63f>
    13c5:	48 85 c9             	test   rcx,rcx
    13c8:	0f 84 29 fd ff ff    	je     10f7 <gzram_base_encode_avx2+0x207>
    13ce:	48 c1 e1 05          	shl    rcx,0x5
    13d2:	4c 8d 44 24 58       	lea    r8,[rsp+0x58]
    13d7:	48 89 ef             	mov    rdi,rbp
    13da:	4c 8d 0c 29          	lea    r9,[rcx+rbp*1]
    13de:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 13e5 <gzram_base_encode_avx2+0x4f5>
    13e5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    13ec:	00 00 00 00 
    13f0:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
    13f4:	4b 8d 54 3d 00       	lea    rdx,[r13+r15*1+0x0]
    13f9:	48 01 da             	add    rdx,rbx
    13fc:	81 f9 ff 00 00 00    	cmp    ecx,0xff
    1402:	0f 84 88 00 00 00    	je     1490 <gzram_base_encode_avx2+0x5a0>
    1408:	89 c8                	mov    eax,ecx
    140a:	85 c9                	test   ecx,ecx
    140c:	74 55                	je     1463 <gzram_base_encode_avx2+0x573>
    140e:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1414:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    141b:	00 00 00 00 
    141f:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1426:	00 00 00 00 
    142a:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1431:	00 00 00 00 
    1435:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    143c:	00 00 00 00 
    1440:	45 31 db             	xor    r11d,r11d
    1443:	8d 70 ff             	lea    esi,[rax-0x1]
    1446:	48 83 c2 04          	add    rdx,0x4
    144a:	f3 44 0f bc d8       	tzcnt  r11d,eax
    144f:	46 8d 1c 9d 00 00 00 	lea    r11d,[r11*4+0x0]
    1456:	00 
    1457:	46 8b 1c 1f          	mov    r11d,DWORD PTR [rdi+r11*1]
    145b:	44 89 5a fc          	mov    DWORD PTR [rdx-0x4],r11d
    145f:	21 f0                	and    eax,esi
    1461:	75 dd                	jne    1440 <gzram_base_encode_avx2+0x550>
    1463:	41 0f b6 04 0a       	movzx  eax,BYTE PTR [r10+rcx*1]
    1468:	48 83 c7 20          	add    rdi,0x20
    146c:	49 83 c0 01          	add    r8,0x1
    1470:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1477:	49 01 c7             	add    r15,rax
    147a:	4c 39 cf             	cmp    rdi,r9
    147d:	0f 85 6d ff ff ff    	jne    13f0 <gzram_base_encode_avx2+0x500>
    1483:	4d 01 fd             	add    r13,r15
    1486:	e9 6c fc ff ff       	jmp    10f7 <gzram_base_encode_avx2+0x207>
    148b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1490:	48 8b 07             	mov    rax,QWORD PTR [rdi]
    1493:	48 89 02             	mov    QWORD PTR [rdx],rax
    1496:	48 8b 47 08          	mov    rax,QWORD PTR [rdi+0x8]
    149a:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
    149e:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
    14a2:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
    14a6:	48 8b 47 18          	mov    rax,QWORD PTR [rdi+0x18]
    14aa:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
    14ae:	eb b3                	jmp    1463 <gzram_base_encode_avx2+0x573>
    14b0:	89 ca                	mov    edx,ecx
    14b2:	48 8d 3c 16          	lea    rdi,[rsi+rdx*1]
    14b6:	48 8d 54 14 58       	lea    rdx,[rsp+rdx*1+0x58]
    14bb:	4c 8b 42 e0          	mov    r8,QWORD PTR [rdx-0x20]
    14bf:	4c 89 47 e0          	mov    QWORD PTR [rdi-0x20],r8
    14c3:	4c 8b 42 e8          	mov    r8,QWORD PTR [rdx-0x18]
    14c7:	4c 89 47 e8          	mov    QWORD PTR [rdi-0x18],r8
    14cb:	4c 8b 42 f0          	mov    r8,QWORD PTR [rdx-0x10]
    14cf:	4c 89 47 f0          	mov    QWORD PTR [rdi-0x10],r8
    14d3:	48 8b 52 f8          	mov    rdx,QWORD PTR [rdx-0x8]
    14d7:	48 89 57 f8          	mov    QWORD PTR [rdi-0x8],rdx
    14db:	8d 79 ff             	lea    edi,[rcx-0x1]
    14de:	83 ff 20             	cmp    edi,0x20
    14e1:	0f 82 cc fe ff ff    	jb     13b3 <gzram_base_encode_avx2+0x4c3>
    14e7:	83 e7 e0             	and    edi,0xffffffe0
    14ea:	45 31 c0             	xor    r8d,r8d
    14ed:	44 89 c2             	mov    edx,r8d
    14f0:	41 83 c0 20          	add    r8d,0x20
    14f4:	4c 8b 54 14 58       	mov    r10,QWORD PTR [rsp+rdx*1+0x58]
    14f9:	4c 8b 4c 14 68       	mov    r9,QWORD PTR [rsp+rdx*1+0x68]
    14fe:	4c 8b 5c 14 60       	mov    r11,QWORD PTR [rsp+rdx*1+0x60]
    1503:	4c 89 4c 24 18       	mov    QWORD PTR [rsp+0x18],r9
    1508:	4c 8b 4c 14 70       	mov    r9,QWORD PTR [rsp+rdx*1+0x70]
    150d:	4c 89 14 16          	mov    QWORD PTR [rsi+rdx*1],r10
    1511:	4c 89 5c 16 08       	mov    QWORD PTR [rsi+rdx*1+0x8],r11
    1516:	4c 8b 54 24 18       	mov    r10,QWORD PTR [rsp+0x18]
    151b:	4c 89 4c 16 18       	mov    QWORD PTR [rsi+rdx*1+0x18],r9
    1520:	4c 89 54 16 10       	mov    QWORD PTR [rsi+rdx*1+0x10],r10
    1525:	41 39 f8             	cmp    r8d,edi
    1528:	72 c3                	jb     14ed <gzram_base_encode_avx2+0x5fd>
    152a:	e9 84 fe ff ff       	jmp    13b3 <gzram_base_encode_avx2+0x4c3>
    152f:	4a 8d 34 2b          	lea    rsi,[rbx+r13*1]
    1533:	48 8d 54 24 58       	lea    rdx,[rsp+0x58]
    1538:	48 89 ef             	mov    rdi,rbp
    153b:	e8 f0 ef ff ff       	call   530 <pack_block_avx2>
    1540:	e9 71 fc ff ff       	jmp    11b6 <gzram_base_encode_avx2+0x2c6>
    1545:	48 8b 4d 00          	mov    rcx,QWORD PTR [rbp+0x0]
    1549:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    154c:	48 8b 4d 08          	mov    rcx,QWORD PTR [rbp+0x8]
    1550:	48 89 4e 08          	mov    QWORD PTR [rsi+0x8],rcx
    1554:	48 8d 4c 16 10       	lea    rcx,[rsi+rdx*1+0x10]
    1559:	48 8d 54 15 10       	lea    rdx,[rbp+rdx*1+0x10]
    155e:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
    1562:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
    1566:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    156a:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
    156e:	e9 43 fc ff ff       	jmp    11b6 <gzram_base_encode_avx2+0x2c6>
    1573:	48 8b 4d 00          	mov    rcx,QWORD PTR [rbp+0x0]
    1577:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    157a:	48 8b 4c 15 f8       	mov    rcx,QWORD PTR [rbp+rdx*1-0x8]
    157f:	48 89 4c 16 f8       	mov    QWORD PTR [rsi+rdx*1-0x8],rcx
    1584:	e9 2d fc ff ff       	jmp    11b6 <gzram_base_encode_avx2+0x2c6>
    1589:	8b 4d 00             	mov    ecx,DWORD PTR [rbp+0x0]
    158c:	89 0e                	mov    DWORD PTR [rsi],ecx
    158e:	8b 4c 15 fc          	mov    ecx,DWORD PTR [rbp+rdx*1-0x4]
    1592:	89 4c 16 fc          	mov    DWORD PTR [rsi+rdx*1-0x4],ecx
    1596:	e9 1b fc ff ff       	jmp    11b6 <gzram_base_encode_avx2+0x2c6>
    159b:	4c 8b b4 24 08 01 00 	mov    r14,QWORD PTR [rsp+0x108]
    15a2:	00 
    15a3:	e9 8a fa ff ff       	jmp    1032 <gzram_base_encode_avx2+0x142>
    15a8:	48 89 ea             	mov    rdx,rbp
    15ab:	4c 89 fe             	mov    rsi,r15
    15ae:	4c 89 df             	mov    rdi,r11
    15b1:	e8 00 00 00 00       	call   15b6 <gzram_base_encode_avx2+0x6c6>
    15b6:	e9 08 fd ff ff       	jmp    12c3 <gzram_base_encode_avx2+0x3d3>
    15bb:	48 8b 54 24 58       	mov    rdx,QWORD PTR [rsp+0x58]
    15c0:	48 89 16             	mov    QWORD PTR [rsi],rdx
    15c3:	48 8b 54 24 60       	mov    rdx,QWORD PTR [rsp+0x60]
    15c8:	48 89 56 08          	mov    QWORD PTR [rsi+0x8],rdx
    15cc:	89 ca                	mov    edx,ecx
    15ce:	48 8d 74 16 10       	lea    rsi,[rsi+rdx*1+0x10]
    15d3:	48 8d 54 14 68       	lea    rdx,[rsp+rdx*1+0x68]
    15d8:	48 8b 7a e0          	mov    rdi,QWORD PTR [rdx-0x20]
    15dc:	48 89 7e e0          	mov    QWORD PTR [rsi-0x20],rdi
    15e0:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    15e4:	48 89 56 e8          	mov    QWORD PTR [rsi-0x18],rdx
    15e8:	e9 c6 fd ff ff       	jmp    13b3 <gzram_base_encode_avx2+0x4c3>
    15ed:	48 8b 54 24 58       	mov    rdx,QWORD PTR [rsp+0x58]
    15f2:	48 89 16             	mov    QWORD PTR [rsi],rdx
    15f5:	89 ca                	mov    edx,ecx
    15f7:	48 8b 7c 14 50       	mov    rdi,QWORD PTR [rsp+rdx*1+0x50]
    15fc:	48 89 7c 16 f8       	mov    QWORD PTR [rsi+rdx*1-0x8],rdi
    1601:	e9 ad fd ff ff       	jmp    13b3 <gzram_base_encode_avx2+0x4c3>
    1606:	41 b8 08 00 00 00    	mov    r8d,0x8
    160c:	48 83 fe 08          	cmp    rsi,0x8
    1610:	0f 85 62 fc ff ff    	jne    1278 <gzram_base_encode_avx2+0x388>
    1616:	e9 07 fd ff ff       	jmp    1322 <gzram_base_encode_avx2+0x432>
    161b:	8b 54 24 58          	mov    edx,DWORD PTR [rsp+0x58]
    161f:	89 16                	mov    DWORD PTR [rsi],edx
    1621:	89 ca                	mov    edx,ecx
    1623:	8b 7c 14 54          	mov    edi,DWORD PTR [rsp+rdx*1+0x54]
    1627:	89 7c 16 fc          	mov    DWORD PTR [rsi+rdx*1-0x4],edi
    162b:	e9 83 fd ff ff       	jmp    13b3 <gzram_base_encode_avx2+0x4c3>
    1630:	ba 06 00 00 00       	mov    edx,0x6
    1635:	b8 20 00 00 00       	mov    eax,0x20
    163a:	e9 35 fb ff ff       	jmp    1174 <gzram_base_encode_avx2+0x284>
    163f:	89 ca                	mov    edx,ecx
    1641:	0f b7 7c 14 56       	movzx  edi,WORD PTR [rsp+rdx*1+0x56]
    1646:	66 89 7c 16 fe       	mov    WORD PTR [rsi+rdx*1-0x2],di
    164b:	e9 63 fd ff ff       	jmp    13b3 <gzram_base_encode_avx2+0x4c3>

0000000000001650 <gzram_base_decode_scalar>:
    1650:	48 89 c8             	mov    rax,rcx
    1653:	48 8d 4e f8          	lea    rcx,[rsi-0x8]
    1657:	48 81 f9 00 10 00 00 	cmp    rcx,0x1000
    165e:	0f 87 9b 06 00 00    	ja     1cff <gzram_base_decode_scalar+0x6af>
    1664:	48 85 ff             	test   rdi,rdi
    1667:	0f 84 92 06 00 00    	je     1cff <gzram_base_decode_scalar+0x6af>
    166d:	81 3f 47 5a 52 31    	cmp    DWORD PTR [rdi],0x31525a47
    1673:	0f 85 86 06 00 00    	jne    1cff <gzram_base_decode_scalar+0x6af>
    1679:	0f b6 4f 06          	movzx  ecx,BYTE PTR [rdi+0x6]
    167d:	44 8d 41 fb          	lea    r8d,[rcx-0x5]
    1681:	41 80 f8 07          	cmp    r8b,0x7
    1685:	0f 87 74 06 00 00    	ja     1cff <gzram_base_decode_scalar+0x6af>
    168b:	44 0f b6 4f 07       	movzx  r9d,BYTE PTR [rdi+0x7]
    1690:	41 80 f9 01          	cmp    r9b,0x1
    1694:	0f 87 65 06 00 00    	ja     1cff <gzram_base_decode_scalar+0x6af>
    169a:	41 ba 00 10 00 00    	mov    r10d,0x1000
    16a0:	48 81 ec a8 00 00 00 	sub    rsp,0xa8
    16a7:	4c 39 d0             	cmp    rax,r10
    16aa:	48 89 5c 24 78       	mov    QWORD PTR [rsp+0x78],rbx
    16af:	44 0f b7 47 04       	movzx  r8d,WORD PTR [rdi+0x4]
    16b4:	49 0f 47 c2          	cmova  rax,r10
    16b8:	4c 89 c3             	mov    rbx,r8
    16bb:	4c 39 c0             	cmp    rax,r8
    16be:	0f 82 d6 04 00 00    	jb     1b9a <gzram_base_decode_scalar+0x54a>
    16c4:	48 85 d2             	test   rdx,rdx
    16c7:	75 09                	jne    16d2 <gzram_base_decode_scalar+0x82>
    16c9:	4d 85 c0             	test   r8,r8
    16cc:	0f 85 c8 04 00 00    	jne    1b9a <gzram_base_decode_scalar+0x54a>
    16d2:	4c 89 b4 24 98 00 00 	mov    QWORD PTR [rsp+0x98],r14
    16d9:	00 
    16da:	49 89 d6             	mov    r14,rdx
    16dd:	4c 89 a4 24 88 00 00 	mov    QWORD PTR [rsp+0x88],r12
    16e4:	00 
    16e5:	48 89 74 24 38       	mov    QWORD PTR [rsp+0x38],rsi
    16ea:	45 84 c9             	test   r9b,r9b
    16ed:	0f 85 9d 00 00 00    	jne    1790 <gzram_base_decode_scalar+0x140>
    16f3:	ba 01 00 00 00       	mov    edx,0x1
    16f8:	4c 89 bc 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],r15
    16ff:	00 
    1700:	48 d3 e2             	shl    rdx,cl
    1703:	49 89 d7             	mov    r15,rdx
    1706:	49 8d 54 10 ff       	lea    rdx,[r8+rdx*1-0x1]
    170b:	48 d3 ea             	shr    rdx,cl
    170e:	4c 8d 52 08          	lea    r10,[rdx+0x8]
    1712:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    1717:	0f 82 f3 05 00 00    	jb     1d10 <gzram_base_decode_scalar+0x6c0>
    171d:	48 85 d2             	test   rdx,rdx
    1720:	0f 84 df 05 00 00    	je     1d05 <gzram_base_decode_scalar+0x6b5>
    1726:	4c 89 ac 24 90 00 00 	mov    QWORD PTR [rsp+0x90],r13
    172d:	00 
    172e:	4c 8d 6f 08          	lea    r13,[rdi+0x8]
    1732:	4d 89 f9             	mov    r9,r15
    1735:	4a 8d 04 2a          	lea    rax,[rdx+r13*1]
    1739:	66 89 5c 24 6e       	mov    WORD PTR [rsp+0x6e],bx
    173e:	48 89 44 24 50       	mov    QWORD PTR [rsp+0x50],rax
    1743:	4b 8d 04 06          	lea    rax,[r14+r8*1]
    1747:	48 89 44 24 40       	mov    QWORD PTR [rsp+0x40],rax
    174c:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
    1751:	48 89 ac 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rbp
    1758:	00 
    1759:	4c 89 d5             	mov    rbp,r10
    175c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1760:	48 8b 5c 24 40       	mov    rbx,QWORD PTR [rsp+0x40]
    1765:	4c 29 f3             	sub    rbx,r14
    1768:	4c 39 cb             	cmp    rbx,r9
    176b:	49 0f 47 d9          	cmova  rbx,r9
    176f:	41 80 7d 00 06       	cmp    BYTE PTR [r13+0x0],0x6
    1774:	0f 87 f8 03 00 00    	ja     1b72 <gzram_base_decode_scalar+0x522>
    177a:	41 0f b6 45 00       	movzx  eax,BYTE PTR [r13+0x0]
    177f:	48 8d 3d 00 00 00 00 	lea    rdi,[rip+0x0]        # 1786 <gzram_base_decode_scalar+0x136>
    1786:	48 63 04 87          	movsxd rax,DWORD PTR [rdi+rax*4]
    178a:	48 01 f8             	add    rax,rdi
    178d:	ff e0                	jmp    rax
    178f:	90                   	nop
    1790:	49 8d 50 08          	lea    rdx,[r8+0x8]
    1794:	48 39 d6             	cmp    rsi,rdx
    1797:	0f 85 4d 05 00 00    	jne    1cea <gzram_base_decode_scalar+0x69a>
    179d:	4d 85 c0             	test   r8,r8
    17a0:	0f 85 30 05 00 00    	jne    1cd6 <gzram_base_decode_scalar+0x686>
    17a6:	0f b7 c3             	movzx  eax,bx
    17a9:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    17b0:	00 
    17b1:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    17b8:	00 
    17b9:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    17be:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    17c5:	c3                   	ret
    17c6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    17cd:	00 00 00 
    17d0:	b9 08 00 00 00       	mov    ecx,0x8
    17d5:	48 89 d8             	mov    rax,rbx
    17d8:	31 d2                	xor    edx,edx
    17da:	48 f7 f1             	div    rcx
    17dd:	48 85 d2             	test   rdx,rdx
    17e0:	0f 85 8c 03 00 00    	jne    1b72 <gzram_base_decode_scalar+0x522>
    17e6:	48 39 cb             	cmp    rbx,rcx
    17e9:	0f 82 83 03 00 00    	jb     1b72 <gzram_base_decode_scalar+0x522>
    17ef:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    17f4:	48 29 e8             	sub    rax,rbp
    17f7:	48 39 c8             	cmp    rax,rcx
    17fa:	0f 82 72 03 00 00    	jb     1b72 <gzram_base_decode_scalar+0x522>
    1800:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1805:	44 8d 51 ff          	lea    r10d,[rcx-0x1]
    1809:	89 ce                	mov    esi,ecx
    180b:	89 4c 24 68          	mov    DWORD PTR [rsp+0x68],ecx
    180f:	4c 89 4c 24 58       	mov    QWORD PTR [rsp+0x58],r9
    1814:	41 89 cb             	mov    r11d,ecx
    1817:	41 89 cf             	mov    r15d,ecx
    181a:	83 e6 04             	and    esi,0x4
    181d:	48 8d 3c 28          	lea    rdi,[rax+rbp*1]
    1821:	44 89 d0             	mov    eax,r10d
    1824:	48 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],rbp
    1829:	41 89 cc             	mov    r12d,ecx
    182c:	83 e0 e0             	and    eax,0xffffffe0
    182f:	4c 8d 04 0f          	lea    r8,[rdi+rcx*1]
    1833:	41 83 e3 10          	and    r11d,0x10
    1837:	41 83 e7 08          	and    r15d,0x8
    183b:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
    183f:	89 c8                	mov    eax,ecx
    1841:	89 f5                	mov    ebp,esi
    1843:	83 e0 02             	and    eax,0x2
    1846:	89 44 24 4c          	mov    DWORD PTR [rsp+0x4c],eax
    184a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1850:	49 8d 04 16          	lea    rax,[r14+rdx*1]
    1854:	83 f9 20             	cmp    ecx,0x20
    1857:	0f 83 53 03 00 00    	jae    1bb0 <gzram_base_decode_scalar+0x560>
    185d:	45 85 db             	test   r11d,r11d
    1860:	0f 85 f2 03 00 00    	jne    1c58 <gzram_base_decode_scalar+0x608>
    1866:	45 85 ff             	test   r15d,r15d
    1869:	0f 85 21 04 00 00    	jne    1c90 <gzram_base_decode_scalar+0x640>
    186f:	85 ed                	test   ebp,ebp
    1871:	0f 85 39 04 00 00    	jne    1cb0 <gzram_base_decode_scalar+0x660>
    1877:	85 c9                	test   ecx,ecx
    1879:	74 12                	je     188d <gzram_base_decode_scalar+0x23d>
    187b:	0f b6 37             	movzx  esi,BYTE PTR [rdi]
    187e:	40 88 30             	mov    BYTE PTR [rax],sil
    1881:	8b 74 24 4c          	mov    esi,DWORD PTR [rsp+0x4c]
    1885:	85 f6                	test   esi,esi
    1887:	0f 85 3a 04 00 00    	jne    1cc7 <gzram_base_decode_scalar+0x677>
    188d:	48 01 ca             	add    rdx,rcx
    1890:	48 39 da             	cmp    rdx,rbx
    1893:	72 bb                	jb     1850 <gzram_base_decode_scalar+0x200>
    1895:	48 8b 6c 24 60       	mov    rbp,QWORD PTR [rsp+0x60]
    189a:	4c 8b 4c 24 58       	mov    r9,QWORD PTR [rsp+0x58]
    189f:	48 01 cd             	add    rbp,rcx
    18a2:	49 83 c5 01          	add    r13,0x1
    18a6:	4d 01 ce             	add    r14,r9
    18a9:	4c 39 6c 24 50       	cmp    QWORD PTR [rsp+0x50],r13
    18ae:	0f 85 ac fe ff ff    	jne    1760 <gzram_base_decode_scalar+0x110>
    18b4:	49 89 ea             	mov    r10,rbp
    18b7:	0f b7 5c 24 6e       	movzx  ebx,WORD PTR [rsp+0x6e]
    18bc:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    18c3:	00 
    18c4:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    18cb:	00 
    18cc:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    18d1:	0f 85 39 04 00 00    	jne    1d10 <gzram_base_decode_scalar+0x6c0>
    18d7:	0f b7 c3             	movzx  eax,bx
    18da:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    18e1:	00 
    18e2:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    18e9:	00 
    18ea:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    18f1:	00 
    18f2:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    18f7:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    18fe:	c3                   	ret
    18ff:	90                   	nop
    1900:	b9 04 00 00 00       	mov    ecx,0x4
    1905:	e9 cb fe ff ff       	jmp    17d5 <gzram_base_decode_scalar+0x185>
    190a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1910:	48 89 da             	mov    rdx,rbx
    1913:	31 f6                	xor    esi,esi
    1915:	4c 89 f7             	mov    rdi,r14
    1918:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    191d:	e8 00 00 00 00       	call   1922 <gzram_base_decode_scalar+0x2d2>
    1922:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    1927:	e9 76 ff ff ff       	jmp    18a2 <gzram_base_decode_scalar+0x252>
    192c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1930:	b9 10 00 00 00       	mov    ecx,0x10
    1935:	e9 9b fe ff ff       	jmp    17d5 <gzram_base_decode_scalar+0x185>
    193a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1940:	48 89 d8             	mov    rax,rbx
    1943:	83 e0 1f             	and    eax,0x1f
    1946:	0f 85 26 02 00 00    	jne    1b72 <gzram_base_decode_scalar+0x522>
    194c:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    1951:	48 c1 eb 05          	shr    rbx,0x5
    1955:	48 29 ea             	sub    rdx,rbp
    1958:	48 39 da             	cmp    rdx,rbx
    195b:	0f 82 11 02 00 00    	jb     1b72 <gzram_base_decode_scalar+0x522>
    1961:	48 8d 34 2b          	lea    rsi,[rbx+rbp*1]
    1965:	48 85 db             	test   rbx,rbx
    1968:	0f 84 b0 01 00 00    	je     1b1e <gzram_base_decode_scalar+0x4ce>
    196e:	48 03 6c 24 10       	add    rbp,QWORD PTR [rsp+0x10]
    1973:	4c 8d 05 00 00 00 00 	lea    r8,[rip+0x0]        # 197a <gzram_base_decode_scalar+0x32a>
    197a:	48 8d 3c 2b          	lea    rdi,[rbx+rbp*1]
    197e:	48 89 ea             	mov    rdx,rbp
    1981:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    1988:	00 00 
    198a:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1991:	00 00 00 00 
    1995:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    199c:	00 00 00 00 
    19a0:	0f b6 0a             	movzx  ecx,BYTE PTR [rdx]
    19a3:	48 83 c2 01          	add    rdx,0x1
    19a7:	41 0f b6 0c 08       	movzx  ecx,BYTE PTR [r8+rcx*1]
    19ac:	8d 0c 8d 00 00 00 00 	lea    ecx,[rcx*4+0x0]
    19b3:	48 01 c8             	add    rax,rcx
    19b6:	48 39 d7             	cmp    rdi,rdx
    19b9:	75 e5                	jne    19a0 <gzram_base_decode_scalar+0x350>
    19bb:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    19c0:	48 29 f2             	sub    rdx,rsi
    19c3:	48 39 c2             	cmp    rdx,rax
    19c6:	0f 82 a6 01 00 00    	jb     1b72 <gzram_base_decode_scalar+0x522>
    19cc:	4c 89 f1             	mov    rcx,r14
    19cf:	e9 a0 00 00 00       	jmp    1a74 <gzram_base_decode_scalar+0x424>
    19d4:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    19d8:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    19db:	48 83 c0 04          	add    rax,0x4
    19df:	44 89 51 04          	mov    DWORD PTR [rcx+0x4],r10d
    19e3:	f6 c2 04             	test   dl,0x4
    19e6:	0f 84 c0 00 00 00    	je     1aac <gzram_base_decode_scalar+0x45c>
    19ec:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    19ef:	48 83 c0 04          	add    rax,0x4
    19f3:	44 89 51 08          	mov    DWORD PTR [rcx+0x8],r10d
    19f7:	f6 c2 08             	test   dl,0x8
    19fa:	0f 84 bc 00 00 00    	je     1abc <gzram_base_decode_scalar+0x46c>
    1a00:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1a03:	48 83 c0 04          	add    rax,0x4
    1a07:	44 89 51 0c          	mov    DWORD PTR [rcx+0xc],r10d
    1a0b:	f6 c2 10             	test   dl,0x10
    1a0e:	0f 84 b8 00 00 00    	je     1acc <gzram_base_decode_scalar+0x47c>
    1a14:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1a17:	48 83 c0 04          	add    rax,0x4
    1a1b:	44 89 51 10          	mov    DWORD PTR [rcx+0x10],r10d
    1a1f:	f6 c2 20             	test   dl,0x20
    1a22:	0f 84 b4 00 00 00    	je     1adc <gzram_base_decode_scalar+0x48c>
    1a28:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1a2b:	48 83 c0 04          	add    rax,0x4
    1a2f:	44 89 51 14          	mov    DWORD PTR [rcx+0x14],r10d
    1a33:	f6 c2 40             	test   dl,0x40
    1a36:	0f 84 b0 00 00 00    	je     1aec <gzram_base_decode_scalar+0x49c>
    1a3c:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1a3f:	48 83 c0 04          	add    rax,0x4
    1a43:	44 89 51 18          	mov    DWORD PTR [rcx+0x18],r10d
    1a47:	84 d2                	test   dl,dl
    1a49:	0f 89 ac 00 00 00    	jns    1afb <gzram_base_decode_scalar+0x4ab>
    1a4f:	8b 00                	mov    eax,DWORD PTR [rax]
    1a51:	48 83 c5 01          	add    rbp,0x1
    1a55:	89 41 1c             	mov    DWORD PTR [rcx+0x1c],eax
    1a58:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    1a5d:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1a64:	48 01 c6             	add    rsi,rax
    1a67:	48 39 ef             	cmp    rdi,rbp
    1a6a:	0f 84 ae 00 00 00    	je     1b1e <gzram_base_decode_scalar+0x4ce>
    1a70:	48 83 c1 20          	add    rcx,0x20
    1a74:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1a79:	0f b6 55 00          	movzx  edx,BYTE PTR [rbp+0x0]
    1a7d:	48 01 f0             	add    rax,rsi
    1a80:	f6 c2 01             	test   dl,0x1
    1a83:	0f 84 bf 01 00 00    	je     1c48 <gzram_base_decode_scalar+0x5f8>
    1a89:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1a8c:	48 83 c0 04          	add    rax,0x4
    1a90:	44 89 11             	mov    DWORD PTR [rcx],r10d
    1a93:	f6 c2 02             	test   dl,0x2
    1a96:	0f 85 3c ff ff ff    	jne    19d8 <gzram_base_decode_scalar+0x388>
    1a9c:	c7 41 04 00 00 00 00 	mov    DWORD PTR [rcx+0x4],0x0
    1aa3:	f6 c2 04             	test   dl,0x4
    1aa6:	0f 85 40 ff ff ff    	jne    19ec <gzram_base_decode_scalar+0x39c>
    1aac:	c7 41 08 00 00 00 00 	mov    DWORD PTR [rcx+0x8],0x0
    1ab3:	f6 c2 08             	test   dl,0x8
    1ab6:	0f 85 44 ff ff ff    	jne    1a00 <gzram_base_decode_scalar+0x3b0>
    1abc:	c7 41 0c 00 00 00 00 	mov    DWORD PTR [rcx+0xc],0x0
    1ac3:	f6 c2 10             	test   dl,0x10
    1ac6:	0f 85 48 ff ff ff    	jne    1a14 <gzram_base_decode_scalar+0x3c4>
    1acc:	c7 41 10 00 00 00 00 	mov    DWORD PTR [rcx+0x10],0x0
    1ad3:	f6 c2 20             	test   dl,0x20
    1ad6:	0f 85 4c ff ff ff    	jne    1a28 <gzram_base_decode_scalar+0x3d8>
    1adc:	c7 41 14 00 00 00 00 	mov    DWORD PTR [rcx+0x14],0x0
    1ae3:	f6 c2 40             	test   dl,0x40
    1ae6:	0f 85 50 ff ff ff    	jne    1a3c <gzram_base_decode_scalar+0x3ec>
    1aec:	c7 41 18 00 00 00 00 	mov    DWORD PTR [rcx+0x18],0x0
    1af3:	84 d2                	test   dl,dl
    1af5:	0f 88 54 ff ff ff    	js     1a4f <gzram_base_decode_scalar+0x3ff>
    1afb:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    1b00:	48 83 c5 01          	add    rbp,0x1
    1b04:	c7 41 1c 00 00 00 00 	mov    DWORD PTR [rcx+0x1c],0x0
    1b0b:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1b12:	48 01 c6             	add    rsi,rax
    1b15:	48 39 fd             	cmp    rbp,rdi
    1b18:	0f 85 52 ff ff ff    	jne    1a70 <gzram_base_decode_scalar+0x420>
    1b1e:	48 89 f5             	mov    rbp,rsi
    1b21:	e9 7c fd ff ff       	jmp    18a2 <gzram_base_decode_scalar+0x252>
    1b26:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1b2d:	00 00 00 
    1b30:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    1b35:	48 29 e8             	sub    rax,rbp
    1b38:	48 39 d8             	cmp    rax,rbx
    1b3b:	72 35                	jb     1b72 <gzram_base_decode_scalar+0x522>
    1b3d:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1b42:	48 89 da             	mov    rdx,rbx
    1b45:	4c 89 f7             	mov    rdi,r14
    1b48:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    1b4d:	48 8d 34 28          	lea    rsi,[rax+rbp*1]
    1b51:	48 01 dd             	add    rbp,rbx
    1b54:	e8 00 00 00 00       	call   1b59 <gzram_base_decode_scalar+0x509>
    1b59:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    1b5e:	e9 3f fd ff ff       	jmp    18a2 <gzram_base_decode_scalar+0x252>
    1b63:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1b68:	b9 20 00 00 00       	mov    ecx,0x20
    1b6d:	e9 63 fc ff ff       	jmp    17d5 <gzram_base_decode_scalar+0x185>
    1b72:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    1b79:	00 
    1b7a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1b81:	00 
    1b82:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    1b89:	00 
    1b8a:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1b91:	00 
    1b92:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1b99:	00 
    1b9a:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    1b9f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1ba4:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    1bab:	c3                   	ret
    1bac:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1bb0:	4d 8b 48 e0          	mov    r9,QWORD PTR [r8-0x20]
    1bb4:	4e 89 4c 20 e0       	mov    QWORD PTR [rax+r12*1-0x20],r9
    1bb9:	4d 8b 48 e8          	mov    r9,QWORD PTR [r8-0x18]
    1bbd:	4e 89 4c 20 e8       	mov    QWORD PTR [rax+r12*1-0x18],r9
    1bc2:	4d 8b 48 f0          	mov    r9,QWORD PTR [r8-0x10]
    1bc6:	4e 89 4c 20 f0       	mov    QWORD PTR [rax+r12*1-0x10],r9
    1bcb:	4d 8b 48 f8          	mov    r9,QWORD PTR [r8-0x8]
    1bcf:	4e 89 4c 20 f8       	mov    QWORD PTR [rax+r12*1-0x8],r9
    1bd4:	41 83 fa 20          	cmp    r10d,0x20
    1bd8:	0f 82 af fc ff ff    	jb     188d <gzram_base_decode_scalar+0x23d>
    1bde:	48 89 5c 24 18       	mov    QWORD PTR [rsp+0x18],rbx
    1be3:	45 31 c9             	xor    r9d,r9d
    1be6:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
    1beb:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    1bf0:	48 89 54 24 30       	mov    QWORD PTR [rsp+0x30],rdx
    1bf5:	44 89 c9             	mov    ecx,r9d
    1bf8:	41 83 c1 20          	add    r9d,0x20
    1bfc:	4c 8b 74 0f 08       	mov    r14,QWORD PTR [rdi+rcx*1+0x8]
    1c01:	48 8b 5c 0f 10       	mov    rbx,QWORD PTR [rdi+rcx*1+0x10]
    1c06:	48 8b 74 0f 18       	mov    rsi,QWORD PTR [rdi+rcx*1+0x18]
    1c0b:	48 8b 14 0f          	mov    rdx,QWORD PTR [rdi+rcx*1]
    1c0f:	4c 89 74 08 08       	mov    QWORD PTR [rax+rcx*1+0x8],r14
    1c14:	48 89 14 08          	mov    QWORD PTR [rax+rcx*1],rdx
    1c18:	48 89 5c 08 10       	mov    QWORD PTR [rax+rcx*1+0x10],rbx
    1c1d:	48 89 74 08 18       	mov    QWORD PTR [rax+rcx*1+0x18],rsi
    1c22:	44 3b 4c 24 08       	cmp    r9d,DWORD PTR [rsp+0x8]
    1c27:	72 cc                	jb     1bf5 <gzram_base_decode_scalar+0x5a5>
    1c29:	48 8b 5c 24 18       	mov    rbx,QWORD PTR [rsp+0x18]
    1c2e:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
    1c33:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1c38:	48 8b 54 24 30       	mov    rdx,QWORD PTR [rsp+0x30]
    1c3d:	e9 4b fc ff ff       	jmp    188d <gzram_base_decode_scalar+0x23d>
    1c42:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1c48:	c7 01 00 00 00 00    	mov    DWORD PTR [rcx],0x0
    1c4e:	e9 40 fe ff ff       	jmp    1a93 <gzram_base_decode_scalar+0x443>
    1c53:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1c58:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    1c5b:	48 89 30             	mov    QWORD PTR [rax],rsi
    1c5e:	48 8b 77 08          	mov    rsi,QWORD PTR [rdi+0x8]
    1c62:	48 89 70 08          	mov    QWORD PTR [rax+0x8],rsi
    1c66:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1c6a:	48 8d 44 30 10       	lea    rax,[rax+rsi*1+0x10]
    1c6f:	48 8d 74 37 10       	lea    rsi,[rdi+rsi*1+0x10]
    1c74:	4c 8b 4e e0          	mov    r9,QWORD PTR [rsi-0x20]
    1c78:	4c 89 48 e0          	mov    QWORD PTR [rax-0x20],r9
    1c7c:	48 8b 76 e8          	mov    rsi,QWORD PTR [rsi-0x18]
    1c80:	48 89 70 e8          	mov    QWORD PTR [rax-0x18],rsi
    1c84:	e9 04 fc ff ff       	jmp    188d <gzram_base_decode_scalar+0x23d>
    1c89:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1c90:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    1c93:	48 89 30             	mov    QWORD PTR [rax],rsi
    1c96:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1c9a:	4c 8b 4c 37 f8       	mov    r9,QWORD PTR [rdi+rsi*1-0x8]
    1c9f:	4c 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],r9
    1ca4:	e9 e4 fb ff ff       	jmp    188d <gzram_base_decode_scalar+0x23d>
    1ca9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1cb0:	8b 37                	mov    esi,DWORD PTR [rdi]
    1cb2:	89 30                	mov    DWORD PTR [rax],esi
    1cb4:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1cb8:	44 8b 4c 37 fc       	mov    r9d,DWORD PTR [rdi+rsi*1-0x4]
    1cbd:	44 89 4c 30 fc       	mov    DWORD PTR [rax+rsi*1-0x4],r9d
    1cc2:	e9 c6 fb ff ff       	jmp    188d <gzram_base_decode_scalar+0x23d>
    1cc7:	0f b7 74 0f fe       	movzx  esi,WORD PTR [rdi+rcx*1-0x2]
    1ccc:	66 89 74 01 fe       	mov    WORD PTR [rcx+rax*1-0x2],si
    1cd1:	e9 b7 fb ff ff       	jmp    188d <gzram_base_decode_scalar+0x23d>
    1cd6:	48 8d 77 08          	lea    rsi,[rdi+0x8]
    1cda:	4c 89 c2             	mov    rdx,r8
    1cdd:	4c 89 f7             	mov    rdi,r14
    1ce0:	e8 00 00 00 00       	call   1ce5 <gzram_base_decode_scalar+0x695>
    1ce5:	e9 bc fa ff ff       	jmp    17a6 <gzram_base_decode_scalar+0x156>
    1cea:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1cf1:	00 
    1cf2:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1cf9:	00 
    1cfa:	e9 9b fe ff ff       	jmp    1b9a <gzram_base_decode_scalar+0x54a>
    1cff:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1d04:	c3                   	ret
    1d05:	41 ba 08 00 00 00    	mov    r10d,0x8
    1d0b:	e9 bc fb ff ff       	jmp    18cc <gzram_base_decode_scalar+0x27c>
    1d10:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1d17:	00 
    1d18:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1d1f:	00 
    1d20:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1d27:	00 
    1d28:	e9 6d fe ff ff       	jmp    1b9a <gzram_base_decode_scalar+0x54a>
    1d2d:	0f 1f 00             	nop    DWORD PTR [rax]

0000000000001d30 <gzram_base_decode_avx2>:
    1d30:	48 83 ec 78          	sub    rsp,0x78
    1d34:	48 89 5c 24 48       	mov    QWORD PTR [rsp+0x48],rbx
    1d39:	48 89 cb             	mov    rbx,rcx
    1d3c:	48 89 6c 24 50       	mov    QWORD PTR [rsp+0x50],rbp
    1d41:	48 89 d5             	mov    rbp,rdx
    1d44:	4c 89 64 24 58       	mov    QWORD PTR [rsp+0x58],r12
    1d49:	49 89 fc             	mov    r12,rdi
    1d4c:	4c 89 74 24 68       	mov    QWORD PTR [rsp+0x68],r14
    1d51:	49 89 f6             	mov    r14,rsi
    1d54:	e8 00 00 00 00       	call   1d59 <gzram_base_decode_avx2+0x29>
    1d59:	85 c0                	test   eax,eax
    1d5b:	0f 84 af 00 00 00    	je     1e10 <gzram_base_decode_avx2+0xe0>
    1d61:	49 8d 46 f8          	lea    rax,[r14-0x8]
    1d65:	48 3d 00 10 00 00    	cmp    rax,0x1000
    1d6b:	0f 87 ff 01 00 00    	ja     1f70 <gzram_base_decode_avx2+0x240>
    1d71:	4d 85 e4             	test   r12,r12
    1d74:	0f 84 f6 01 00 00    	je     1f70 <gzram_base_decode_avx2+0x240>
    1d7a:	41 81 3c 24 47 5a 52 	cmp    DWORD PTR [r12],0x31525a47
    1d81:	31 
    1d82:	0f 85 e8 01 00 00    	jne    1f70 <gzram_base_decode_avx2+0x240>
    1d88:	41 0f b6 4c 24 06    	movzx  ecx,BYTE PTR [r12+0x6]
    1d8e:	8d 41 fb             	lea    eax,[rcx-0x5]
    1d91:	3c 07                	cmp    al,0x7
    1d93:	0f 87 d7 01 00 00    	ja     1f70 <gzram_base_decode_avx2+0x240>
    1d99:	41 0f b6 7c 24 07    	movzx  edi,BYTE PTR [r12+0x7]
    1d9f:	40 80 ff 01          	cmp    dil,0x1
    1da3:	0f 87 c7 01 00 00    	ja     1f70 <gzram_base_decode_avx2+0x240>
    1da9:	b8 00 10 00 00       	mov    eax,0x1000
    1dae:	41 0f b7 54 24 04    	movzx  edx,WORD PTR [r12+0x4]
    1db4:	48 39 c3             	cmp    rbx,rax
    1db7:	48 0f 46 c3          	cmovbe rax,rbx
    1dbb:	49 89 d2             	mov    r10,rdx
    1dbe:	48 39 d0             	cmp    rax,rdx
    1dc1:	0f 82 a9 01 00 00    	jb     1f70 <gzram_base_decode_avx2+0x240>
    1dc7:	48 85 ed             	test   rbp,rbp
    1dca:	75 09                	jne    1dd5 <gzram_base_decode_avx2+0xa5>
    1dcc:	48 85 d2             	test   rdx,rdx
    1dcf:	0f 85 9b 01 00 00    	jne    1f70 <gzram_base_decode_avx2+0x240>
    1dd5:	40 84 ff             	test   dil,dil
    1dd8:	74 66                	je     1e40 <gzram_base_decode_avx2+0x110>
    1dda:	48 8d 42 08          	lea    rax,[rdx+0x8]
    1dde:	49 39 c6             	cmp    r14,rax
    1de1:	0f 85 89 01 00 00    	jne    1f70 <gzram_base_decode_avx2+0x240>
    1de7:	48 85 d2             	test   rdx,rdx
    1dea:	0f 85 18 03 00 00    	jne    2108 <gzram_base_decode_avx2+0x3d8>
    1df0:	41 0f b7 c2          	movzx  eax,r10w
    1df4:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1df9:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1dfe:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1e03:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1e08:	48 83 c4 78          	add    rsp,0x78
    1e0c:	c3                   	ret
    1e0d:	0f 1f 00             	nop    DWORD PTR [rax]
    1e10:	48 89 d9             	mov    rcx,rbx
    1e13:	48 89 ea             	mov    rdx,rbp
    1e16:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1e1b:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1e20:	4c 89 f6             	mov    rsi,r14
    1e23:	4c 89 e7             	mov    rdi,r12
    1e26:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1e2b:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1e30:	48 83 c4 78          	add    rsp,0x78
    1e34:	e9 00 00 00 00       	jmp    1e39 <gzram_base_decode_avx2+0x109>
    1e39:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1e40:	41 b9 01 00 00 00    	mov    r9d,0x1
    1e46:	49 d3 e1             	shl    r9,cl
    1e49:	4a 8d 44 0a ff       	lea    rax,[rdx+r9*1-0x1]
    1e4e:	48 d3 e8             	shr    rax,cl
    1e51:	48 8d 58 08          	lea    rbx,[rax+0x8]
    1e55:	49 39 de             	cmp    r14,rbx
    1e58:	0f 82 12 01 00 00    	jb     1f70 <gzram_base_decode_avx2+0x240>
    1e5e:	48 85 c0             	test   rax,rax
    1e61:	0f 84 e1 02 00 00    	je     2148 <gzram_base_decode_avx2+0x418>
    1e67:	49 8d 44 04 08       	lea    rax,[r12+rax*1+0x8]
    1e6c:	66 44 89 54 24 3e    	mov    WORD PTR [rsp+0x3e],r10w
    1e72:	4d 8d 44 24 08       	lea    r8,[r12+0x8]
    1e77:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
    1e7c:	48 8d 44 15 00       	lea    rax,[rbp+rdx*1+0x0]
    1e81:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
    1e86:	4c 89 24 24          	mov    QWORD PTR [rsp],r12
    1e8a:	4c 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],r13
    1e8f:	4c 8d 2d 00 00 00 00 	lea    r13,[rip+0x0]        # 1e96 <gzram_base_decode_avx2+0x166>
    1e96:	4c 89 7c 24 70       	mov    QWORD PTR [rsp+0x70],r15
    1e9b:	4d 89 cf             	mov    r15,r9
    1e9e:	4c 89 74 24 10       	mov    QWORD PTR [rsp+0x10],r14
    1ea3:	49 89 ee             	mov    r14,rbp
    1ea6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1ead:	00 00 00 
    1eb0:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
    1eb5:	4c 29 f5             	sub    rbp,r14
    1eb8:	4c 39 fd             	cmp    rbp,r15
    1ebb:	49 0f 47 ef          	cmova  rbp,r15
    1ebf:	41 80 38 06          	cmp    BYTE PTR [r8],0x6
    1ec3:	0f 87 5f 02 00 00    	ja     2128 <gzram_base_decode_avx2+0x3f8>
    1ec9:	41 0f b6 00          	movzx  eax,BYTE PTR [r8]
    1ecd:	49 63 44 85 00       	movsxd rax,DWORD PTR [r13+rax*4+0x0]
    1ed2:	4c 01 e8             	add    rax,r13
    1ed5:	ff e0                	jmp    rax
    1ed7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    1ede:	00 00 
    1ee0:	41 ba 08 00 00 00    	mov    r10d,0x8
    1ee6:	b9 08 00 00 00       	mov    ecx,0x8
    1eeb:	48 89 e8             	mov    rax,rbp
    1eee:	31 d2                	xor    edx,edx
    1ef0:	49 f7 f2             	div    r10
    1ef3:	48 85 d2             	test   rdx,rdx
    1ef6:	0f 85 2c 02 00 00    	jne    2128 <gzram_base_decode_avx2+0x3f8>
    1efc:	4c 39 d5             	cmp    rbp,r10
    1eff:	0f 82 23 02 00 00    	jb     2128 <gzram_base_decode_avx2+0x3f8>
    1f05:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1f0a:	48 29 d8             	sub    rax,rbx
    1f0d:	4c 39 d0             	cmp    rax,r10
    1f10:	0f 82 12 02 00 00    	jb     2128 <gzram_base_decode_avx2+0x3f8>
    1f16:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1f1a:	48 89 ea             	mov    rdx,rbp
    1f1d:	4c 89 f7             	mov    rdi,r14
    1f20:	4c 89 44 24 28       	mov    QWORD PTR [rsp+0x28],r8
    1f25:	4c 89 54 24 20       	mov    QWORD PTR [rsp+0x20],r10
    1f2a:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1f2e:	e8 4d e1 ff ff       	call   80 <repeat_avx2>
    1f33:	4c 8b 44 24 28       	mov    r8,QWORD PTR [rsp+0x28]
    1f38:	48 03 5c 24 20       	add    rbx,QWORD PTR [rsp+0x20]
    1f3d:	49 83 c0 01          	add    r8,0x1
    1f41:	4d 01 fe             	add    r14,r15
    1f44:	4c 39 44 24 18       	cmp    QWORD PTR [rsp+0x18],r8
    1f49:	0f 85 61 ff ff ff    	jne    1eb0 <gzram_base_decode_avx2+0x180>
    1f4f:	44 0f b7 54 24 3e    	movzx  r10d,WORD PTR [rsp+0x3e]
    1f55:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
    1f5a:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    1f5f:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    1f64:	49 39 de             	cmp    r14,rbx
    1f67:	0f 84 83 fe ff ff    	je     1df0 <gzram_base_decode_avx2+0xc0>
    1f6d:	0f 1f 00             	nop    DWORD PTR [rax]
    1f70:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1f75:	e9 7a fe ff ff       	jmp    1df4 <gzram_base_decode_avx2+0xc4>
    1f7a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1f80:	41 ba 04 00 00 00    	mov    r10d,0x4
    1f86:	b9 04 00 00 00       	mov    ecx,0x4
    1f8b:	e9 5b ff ff ff       	jmp    1eeb <gzram_base_decode_avx2+0x1bb>
    1f90:	48 89 ea             	mov    rdx,rbp
    1f93:	31 f6                	xor    esi,esi
    1f95:	4c 89 f7             	mov    rdi,r14
    1f98:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1f9d:	e8 00 00 00 00       	call   1fa2 <gzram_base_decode_avx2+0x272>
    1fa2:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1fa7:	eb 94                	jmp    1f3d <gzram_base_decode_avx2+0x20d>
    1fa9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1fb0:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1fb5:	48 29 d8             	sub    rax,rbx
    1fb8:	48 39 e8             	cmp    rax,rbp
    1fbb:	0f 82 67 01 00 00    	jb     2128 <gzram_base_decode_avx2+0x3f8>
    1fc1:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1fc5:	48 89 ea             	mov    rdx,rbp
    1fc8:	4c 89 f7             	mov    rdi,r14
    1fcb:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1fd0:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1fd4:	48 01 eb             	add    rbx,rbp
    1fd7:	e8 00 00 00 00       	call   1fdc <gzram_base_decode_avx2+0x2ac>
    1fdc:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1fe1:	e9 57 ff ff ff       	jmp    1f3d <gzram_base_decode_avx2+0x20d>
    1fe6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1fed:	00 00 00 
    1ff0:	41 ba 20 00 00 00    	mov    r10d,0x20
    1ff6:	b9 20 00 00 00       	mov    ecx,0x20
    1ffb:	e9 eb fe ff ff       	jmp    1eeb <gzram_base_decode_avx2+0x1bb>
    2000:	41 ba 10 00 00 00    	mov    r10d,0x10
    2006:	b9 10 00 00 00       	mov    ecx,0x10
    200b:	e9 db fe ff ff       	jmp    1eeb <gzram_base_decode_avx2+0x1bb>
    2010:	48 89 e9             	mov    rcx,rbp
    2013:	83 e1 1f             	and    ecx,0x1f
    2016:	0f 85 0c 01 00 00    	jne    2128 <gzram_base_decode_avx2+0x3f8>
    201c:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    2021:	48 c1 ed 05          	shr    rbp,0x5
    2025:	48 29 d8             	sub    rax,rbx
    2028:	48 39 e8             	cmp    rax,rbp
    202b:	0f 82 f7 00 00 00    	jb     2128 <gzram_base_decode_avx2+0x3f8>
    2031:	48 8d 74 1d 00       	lea    rsi,[rbp+rbx*1+0x0]
    2036:	48 85 ed             	test   rbp,rbp
    2039:	0f 84 01 01 00 00    	je     2140 <gzram_base_decode_avx2+0x410>
    203f:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    2043:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 204a <gzram_base_decode_avx2+0x31a>
    204a:	48 01 d8             	add    rax,rbx
    204d:	48 8d 14 28          	lea    rdx,[rax+rbp*1]
    2051:	49 89 c3             	mov    r11,rax
    2054:	90                   	nop
    2055:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    205c:	00 00 00 00 
    2060:	41 0f b6 3b          	movzx  edi,BYTE PTR [r11]
    2064:	49 83 c3 01          	add    r11,0x1
    2068:	41 0f b6 3c 3a       	movzx  edi,BYTE PTR [r10+rdi*1]
    206d:	8d 3c bd 00 00 00 00 	lea    edi,[rdi*4+0x0]
    2074:	48 01 f9             	add    rcx,rdi
    2077:	49 39 d3             	cmp    r11,rdx
    207a:	75 e4                	jne    2060 <gzram_base_decode_avx2+0x330>
    207c:	4c 8b 5c 24 10       	mov    r11,QWORD PTR [rsp+0x10]
    2081:	49 29 f3             	sub    r11,rsi
    2084:	49 39 cb             	cmp    r11,rcx
    2087:	0f 82 9b 00 00 00    	jb     2128 <gzram_base_decode_avx2+0x3f8>
    208d:	4c 89 44 24 30       	mov    QWORD PTR [rsp+0x30],r8
    2092:	48 89 c3             	mov    rbx,rax
    2095:	48 89 d5             	mov    rbp,rdx
    2098:	4c 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],r15
    209d:	4d 89 f7             	mov    r15,r14
    20a0:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    20a5:	49 89 f6             	mov    r14,rsi
    20a8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    20af:	00 
    20b0:	44 0f b6 23          	movzx  r12d,BYTE PTR [rbx]
    20b4:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    20b8:	4c 89 fe             	mov    rsi,r15
    20bb:	48 83 c3 01          	add    rbx,0x1
    20bf:	49 83 c7 20          	add    r15,0x20
    20c3:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
    20c7:	44 89 e2             	mov    edx,r12d
    20ca:	e8 71 e3 ff ff       	call   440 <unpack_avx2>
    20cf:	44 89 e2             	mov    edx,r12d
    20d2:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 20d9 <gzram_base_decode_avx2+0x3a9>
    20d9:	41 0f b6 14 12       	movzx  edx,BYTE PTR [r10+rdx*1]
    20de:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
    20e5:	49 01 d6             	add    r14,rdx
    20e8:	48 39 eb             	cmp    rbx,rbp
    20eb:	75 c3                	jne    20b0 <gzram_base_decode_avx2+0x380>
    20ed:	4c 89 f3             	mov    rbx,r14
    20f0:	4c 8b 7c 24 20       	mov    r15,QWORD PTR [rsp+0x20]
    20f5:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    20fa:	4c 8b 44 24 30       	mov    r8,QWORD PTR [rsp+0x30]
    20ff:	e9 39 fe ff ff       	jmp    1f3d <gzram_base_decode_avx2+0x20d>
    2104:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    2108:	49 8d 74 24 08       	lea    rsi,[r12+0x8]
    210d:	48 89 ef             	mov    rdi,rbp
    2110:	44 89 14 24          	mov    DWORD PTR [rsp],r10d
    2114:	e8 00 00 00 00       	call   2119 <gzram_base_decode_avx2+0x3e9>
    2119:	44 8b 14 24          	mov    r10d,DWORD PTR [rsp]
    211d:	e9 ce fc ff ff       	jmp    1df0 <gzram_base_decode_avx2+0xc0>
    2122:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    2128:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    212d:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    2132:	e9 39 fe ff ff       	jmp    1f70 <gzram_base_decode_avx2+0x240>
    2137:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    213e:	00 00 
    2140:	48 89 f3             	mov    rbx,rsi
    2143:	e9 f5 fd ff ff       	jmp    1f3d <gzram_base_decode_avx2+0x20d>
    2148:	bb 08 00 00 00       	mov    ebx,0x8
    214d:	e9 12 fe ff ff       	jmp    1f64 <gzram_base_decode_avx2+0x234>
