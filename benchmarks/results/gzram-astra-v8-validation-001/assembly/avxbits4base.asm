
build/astra-v8/hybrid-avxbits4base.o:     file format elf64-x86-64


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

00000000000004d0 <gzram_avx2_available>:
     4d0:	48 8b 05 00 00 00 00 	mov    rax,QWORD PTR [rip+0x0]        # 4d7 <gzram_avx2_available+0x7>
     4d7:	0f b6 40 0d          	movzx  eax,BYTE PTR [rax+0xd]
     4db:	c0 e8 02             	shr    al,0x2
     4de:	83 e0 01             	and    eax,0x1
     4e1:	c3                   	ret
     4e2:	0f 1f 00             	nop    DWORD PTR [rax]
     4e5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     4ec:	00 00 00 00 

00000000000004f0 <gzram_base_encode_scalar>:
     4f0:	41 8d 40 fb          	lea    eax,[r8-0x5]
     4f4:	83 f8 07             	cmp    eax,0x7
     4f7:	0f 87 eb 00 00 00    	ja     5e8 <gzram_base_encode_scalar+0xf8>
     4fd:	48 81 fe 00 10 00 00 	cmp    rsi,0x1000
     504:	0f 87 de 00 00 00    	ja     5e8 <gzram_base_encode_scalar+0xf8>
     50a:	48 85 d2             	test   rdx,rdx
     50d:	0f 84 d5 00 00 00    	je     5e8 <gzram_base_encode_scalar+0xf8>
     513:	48 85 ff             	test   rdi,rdi
     516:	41 0f 94 c1          	sete   r9b
     51a:	48 85 f6             	test   rsi,rsi
     51d:	0f 95 c0             	setne  al
     520:	41 84 c1             	test   r9b,al
     523:	0f 85 bf 00 00 00    	jne    5e8 <gzram_base_encode_scalar+0xf8>
     529:	48 83 f9 07          	cmp    rcx,0x7
     52d:	0f 86 b5 00 00 00    	jbe    5e8 <gzram_base_encode_scalar+0xf8>
     533:	48 81 ec 38 01 00 00 	sub    rsp,0x138
     53a:	48 89 c8             	mov    rax,rcx
     53d:	41 bb 01 00 00 00    	mov    r11d,0x1
     543:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
     548:	44 89 c1             	mov    ecx,r8d
     54b:	49 d3 e3             	shl    r11,cl
     54e:	4c 89 bc 24 30 01 00 	mov    QWORD PTR [rsp+0x130],r15
     555:	00 
     556:	49 89 d7             	mov    r15,rdx
     559:	49 8d 54 33 ff       	lea    rdx,[r11+rsi*1-0x1]
     55e:	4c 89 b4 24 28 01 00 	mov    QWORD PTR [rsp+0x128],r14
     565:	00 
     566:	45 89 c6             	mov    r14d,r8d
     569:	48 d3 ea             	shr    rdx,cl
     56c:	48 89 ac 24 10 01 00 	mov    QWORD PTR [rsp+0x110],rbp
     573:	00 
     574:	48 89 f5             	mov    rbp,rsi
     577:	48 8d 76 08          	lea    rsi,[rsi+0x8]
     57b:	4c 8d 42 08          	lea    r8,[rdx+0x8]
     57f:	4c 89 a4 24 18 01 00 	mov    QWORD PTR [rsp+0x118],r12
     586:	00 
     587:	49 89 fc             	mov    r12,rdi
     58a:	4c 39 c0             	cmp    rax,r8
     58d:	73 60                	jae    5ef <gzram_base_encode_scalar+0xff>
     58f:	48 39 f0             	cmp    rax,rsi
     592:	72 57                	jb     5eb <gzram_base_encode_scalar+0xfb>
     594:	48 85 ed             	test   rbp,rbp
     597:	0f 85 b5 04 00 00    	jne    a52 <gzram_base_encode_scalar+0x562>
     59d:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     5a4:	8d 45 08             	lea    eax,[rbp+0x8]
     5a7:	41 88 6f 04          	mov    BYTE PTR [r15+0x4],bpl
     5ab:	41 c6 47 05 00       	mov    BYTE PTR [r15+0x5],0x0
     5b0:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     5b4:	41 c6 47 07 01       	mov    BYTE PTR [r15+0x7],0x1
     5b9:	48 8b ac 24 10 01 00 	mov    rbp,QWORD PTR [rsp+0x110]
     5c0:	00 
     5c1:	4c 8b a4 24 18 01 00 	mov    r12,QWORD PTR [rsp+0x118]
     5c8:	00 
     5c9:	4c 8b b4 24 28 01 00 	mov    r14,QWORD PTR [rsp+0x128]
     5d0:	00 
     5d1:	4c 8b bc 24 30 01 00 	mov    r15,QWORD PTR [rsp+0x130]
     5d8:	00 
     5d9:	48 81 c4 38 01 00 00 	add    rsp,0x138
     5e0:	c3                   	ret
     5e1:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
     5e8:	31 c0                	xor    eax,eax
     5ea:	c3                   	ret
     5eb:	31 c0                	xor    eax,eax
     5ed:	eb ca                	jmp    5b9 <gzram_base_encode_scalar+0xc9>
     5ef:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     5f6:	66 41 89 6f 04       	mov    WORD PTR [r15+0x4],bp
     5fb:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     5ff:	41 c6 47 07 00       	mov    BYTE PTR [r15+0x7],0x0
     604:	48 85 d2             	test   rdx,rdx
     607:	0f 84 80 07 00 00    	je     d8d <gzram_base_encode_scalar+0x89d>
     60d:	49 8d 7f 08          	lea    rdi,[r15+0x8]
     611:	48 89 9c 24 08 01 00 	mov    QWORD PTR [rsp+0x108],rbx
     618:	00 
     619:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 620 <gzram_base_encode_scalar+0x130>
     620:	48 8d 04 17          	lea    rax,[rdi+rdx*1]
     624:	4c 89 ac 24 20 01 00 	mov    QWORD PTR [rsp+0x120],r13
     62b:	00 
     62c:	49 89 fd             	mov    r13,rdi
     62f:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
     634:	49 8d 04 2c          	lea    rax,[r12+rbp*1]
     638:	4c 89 7c 24 18       	mov    QWORD PTR [rsp+0x18],r15
     63d:	4d 89 df             	mov    r15,r11
     640:	44 89 74 24 44       	mov    DWORD PTR [rsp+0x44],r14d
     645:	4d 89 c6             	mov    r14,r8
     648:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
     64d:	48 89 74 24 28       	mov    QWORD PTR [rsp+0x28],rsi
     652:	48 89 7c 24 48       	mov    QWORD PTR [rsp+0x48],rdi
     657:	4c 89 64 24 30       	mov    QWORD PTR [rsp+0x30],r12
     65c:	48 89 6c 24 38       	mov    QWORD PTR [rsp+0x38],rbp
     661:	eb 44                	jmp    6a7 <gzram_base_encode_scalar+0x1b7>
     663:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     668:	48 8b 44 24 20       	mov    rax,QWORD PTR [rsp+0x20]
     66d:	4c 29 f0             	sub    rax,r14
     670:	48 39 e8             	cmp    rax,rbp
     673:	0f 82 75 01 00 00    	jb     7ee <gzram_base_encode_scalar+0x2fe>
     679:	41 c6 45 00 00       	mov    BYTE PTR [r13+0x0],0x0
     67e:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
     683:	48 89 ea             	mov    rdx,rbp
     686:	4c 89 e6             	mov    rsi,r12
     689:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
     68d:	49 01 ee             	add    r14,rbp
     690:	e8 00 00 00 00       	call   695 <gzram_base_encode_scalar+0x1a5>
     695:	4d 01 fc             	add    r12,r15
     698:	49 83 c5 01          	add    r13,0x1
     69c:	4c 39 6c 24 10       	cmp    QWORD PTR [rsp+0x10],r13
     6a1:	0f 84 72 03 00 00    	je     a19 <gzram_base_encode_scalar+0x529>
     6a7:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
     6ac:	4c 29 e5             	sub    rbp,r12
     6af:	4c 39 fd             	cmp    rbp,r15
     6b2:	49 0f 47 ef          	cmova  rbp,r15
     6b6:	40 f6 c5 1f          	test   bpl,0x1f
     6ba:	75 ac                	jne    668 <gzram_base_encode_scalar+0x178>
     6bc:	49 8b 3c 24          	mov    rdi,QWORD PTR [r12]
     6c0:	4d 8b 54 24 10       	mov    r10,QWORD PTR [r12+0x10]
     6c5:	4d 8b 44 24 08       	mov    r8,QWORD PTR [r12+0x8]
     6ca:	4d 8b 4c 24 18       	mov    r9,QWORD PTR [r12+0x18]
     6cf:	4c 39 d7             	cmp    rdi,r10
     6d2:	48 89 7c 24 58       	mov    QWORD PTR [rsp+0x58],rdi
     6d7:	4c 89 44 24 60       	mov    QWORD PTR [rsp+0x60],r8
     6dc:	0f 94 c0             	sete   al
     6df:	4c 89 54 24 68       	mov    QWORD PTR [rsp+0x68],r10
     6e4:	4c 89 4c 24 70       	mov    QWORD PTR [rsp+0x70],r9
     6e9:	4c 39 c7             	cmp    rdi,r8
     6ec:	0f 84 60 02 00 00    	je     952 <gzram_base_encode_scalar+0x462>
     6f2:	4d 39 c8             	cmp    r8,r9
     6f5:	75 08                	jne    6ff <gzram_base_encode_scalar+0x20f>
     6f7:	84 c0                	test   al,al
     6f9:	0f 85 05 03 00 00    	jne    a04 <gzram_base_encode_scalar+0x514>
     6ff:	be 1f 00 00 00       	mov    esi,0x1f
     704:	b8 20 00 00 00       	mov    eax,0x20
     709:	41 bb 20 00 00 00    	mov    r11d,0x20
     70f:	48 83 fd 20          	cmp    rbp,0x20
     713:	0f 86 04 04 00 00    	jbe    b1d <gzram_base_encode_scalar+0x62d>
     719:	48 39 e8             	cmp    rax,rbp
     71c:	0f 83 04 04 00 00    	jae    b26 <gzram_base_encode_scalar+0x636>
     722:	48 89 f9             	mov    rcx,rdi
     725:	b8 20 00 00 00       	mov    eax,0x20
     72a:	eb 23                	jmp    74f <gzram_base_encode_scalar+0x25f>
     72c:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     733:	00 00 
     735:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     73c:	00 00 00 00 
     740:	48 89 c2             	mov    rdx,rax
     743:	48 21 f2             	and    rdx,rsi
     746:	48 c1 ea 03          	shr    rdx,0x3
     74a:	48 8b 4c d4 58       	mov    rcx,QWORD PTR [rsp+rdx*8+0x58]
     74f:	49 8b 14 04          	mov    rdx,QWORD PTR [r12+rax*1]
     753:	48 83 c0 08          	add    rax,0x8
     757:	48 39 ca             	cmp    rdx,rcx
     75a:	0f 85 10 01 00 00    	jne    870 <gzram_base_encode_scalar+0x380>
     760:	48 39 e8             	cmp    rax,rbp
     763:	72 db                	jb     740 <gzram_base_encode_scalar+0x250>
     765:	48 39 ca             	cmp    rdx,rcx
     768:	0f 85 02 01 00 00    	jne    870 <gzram_base_encode_scalar+0x380>
     76e:	48 85 ff             	test   rdi,rdi
     771:	0f 85 01 02 00 00    	jne    978 <gzram_base_encode_scalar+0x488>
     777:	4d 85 c0             	test   r8,r8
     77a:	75 0e                	jne    78a <gzram_base_encode_scalar+0x29a>
     77c:	4d 85 d2             	test   r10,r10
     77f:	75 09                	jne    78a <gzram_base_encode_scalar+0x29a>
     781:	4d 85 c9             	test   r9,r9
     784:	0f 84 be 01 00 00    	je     948 <gzram_base_encode_scalar+0x458>
     78a:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     791:	01 00 00 00 
     795:	41 83 fb 08          	cmp    r11d,0x8
     799:	0f 84 b0 00 00 00    	je     84f <gzram_base_encode_scalar+0x35f>
     79f:	41 83 fb 10          	cmp    r11d,0x10
     7a3:	0f 84 68 05 00 00    	je     d11 <gzram_base_encode_scalar+0x821>
     7a9:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x8
     7b0:	08 00 00 00 
     7b4:	48 83 fd 20          	cmp    rbp,0x20
     7b8:	0f 87 d9 02 00 00    	ja     a97 <gzram_base_encode_scalar+0x5a7>
     7be:	bf 01 00 00 00       	mov    edi,0x1
     7c3:	49 89 e9             	mov    r9,rbp
     7c6:	48 8b 54 24 20       	mov    rdx,QWORD PTR [rsp+0x20]
     7cb:	8d 04 bd 00 00 00 00 	lea    eax,[rdi*4+0x0]
     7d2:	49 c1 e9 05          	shr    r9,0x5
     7d6:	4c 01 c8             	add    rax,r9
     7d9:	4c 29 f2             	sub    rdx,r14
     7dc:	48 39 e8             	cmp    rax,rbp
     7df:	0f 82 63 03 00 00    	jb     b48 <gzram_base_encode_scalar+0x658>
     7e5:	48 39 ea             	cmp    rdx,rbp
     7e8:	0f 83 8b fe ff ff    	jae    679 <gzram_base_encode_scalar+0x189>
     7ee:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
     7f3:	48 8b 7c 24 48       	mov    rdi,QWORD PTR [rsp+0x48]
     7f8:	31 c0                	xor    eax,eax
     7fa:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     7ff:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     804:	4c 8b 7c 24 18       	mov    r15,QWORD PTR [rsp+0x18]
     809:	44 8b 74 24 44       	mov    r14d,DWORD PTR [rsp+0x44]
     80e:	48 39 74 24 20       	cmp    QWORD PTR [rsp+0x20],rsi
     813:	0f 82 3b 05 00 00    	jb     d54 <gzram_base_encode_scalar+0x864>
     819:	48 85 ed             	test   rbp,rbp
     81c:	0f 85 47 05 00 00    	jne    d69 <gzram_base_encode_scalar+0x879>
     822:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     829:	8d 45 08             	lea    eax,[rbp+0x8]
     82c:	66 41 89 6f 04       	mov    WORD PTR [r15+0x4],bp
     831:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     835:	41 c6 47 07 01       	mov    BYTE PTR [r15+0x7],0x1
     83a:	48 8b 9c 24 08 01 00 	mov    rbx,QWORD PTR [rsp+0x108]
     841:	00 
     842:	4c 8b ac 24 20 01 00 	mov    r13,QWORD PTR [rsp+0x120]
     849:	00 
     84a:	e9 6a fd ff ff       	jmp    5b9 <gzram_base_encode_scalar+0xc9>
     84f:	48 83 fd 04          	cmp    rbp,0x4
     853:	0f 86 20 fe ff ff    	jbe    679 <gzram_base_encode_scalar+0x189>
     859:	ba 02 00 00 00       	mov    edx,0x2
     85e:	b8 04 00 00 00       	mov    eax,0x4
     863:	e9 48 01 00 00       	jmp    9b0 <gzram_base_encode_scalar+0x4c0>
     868:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     86f:	00 
     870:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     877:	00 00 00 00 
     87b:	49 89 e8             	mov    r8,rbp
     87e:	49 c1 e8 05          	shr    r8,0x5
     882:	49 c1 e0 05          	shl    r8,0x5
     886:	48 8d 74 24 78       	lea    rsi,[rsp+0x78]
     88b:	4c 89 e0             	mov    rax,r12
     88e:	31 ff                	xor    edi,edi
     890:	4d 01 e0             	add    r8,r12
     893:	66 90                	xchg   ax,ax
     895:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     89c:	00 00 00 00 
     8a0:	8b 48 04             	mov    ecx,DWORD PTR [rax+0x4]
     8a3:	44 8b 48 08          	mov    r9d,DWORD PTR [rax+0x8]
     8a7:	31 d2                	xor    edx,edx
     8a9:	44 8b 10             	mov    r10d,DWORD PTR [rax]
     8ac:	44 8b 58 0c          	mov    r11d,DWORD PTR [rax+0xc]
     8b0:	85 c9                	test   ecx,ecx
     8b2:	0f 95 c2             	setne  dl
     8b5:	31 c9                	xor    ecx,ecx
     8b7:	01 d2                	add    edx,edx
     8b9:	45 85 c9             	test   r9d,r9d
     8bc:	44 8b 48 10          	mov    r9d,DWORD PTR [rax+0x10]
     8c0:	0f 95 c1             	setne  cl
     8c3:	c1 e1 02             	shl    ecx,0x2
     8c6:	09 ca                	or     edx,ecx
     8c8:	31 c9                	xor    ecx,ecx
     8ca:	45 85 d2             	test   r10d,r10d
     8cd:	44 8b 50 14          	mov    r10d,DWORD PTR [rax+0x14]
     8d1:	0f 95 c1             	setne  cl
     8d4:	09 ca                	or     edx,ecx
     8d6:	31 c9                	xor    ecx,ecx
     8d8:	45 85 db             	test   r11d,r11d
     8db:	44 8b 58 18          	mov    r11d,DWORD PTR [rax+0x18]
     8df:	0f 95 c1             	setne  cl
     8e2:	c1 e1 03             	shl    ecx,0x3
     8e5:	09 ca                	or     edx,ecx
     8e7:	31 c9                	xor    ecx,ecx
     8e9:	45 85 c9             	test   r9d,r9d
     8ec:	44 8b 48 1c          	mov    r9d,DWORD PTR [rax+0x1c]
     8f0:	0f 95 c1             	setne  cl
     8f3:	c1 e1 04             	shl    ecx,0x4
     8f6:	09 d1                	or     ecx,edx
     8f8:	31 d2                	xor    edx,edx
     8fa:	45 85 d2             	test   r10d,r10d
     8fd:	0f 95 c2             	setne  dl
     900:	c1 e2 05             	shl    edx,0x5
     903:	09 ca                	or     edx,ecx
     905:	31 c9                	xor    ecx,ecx
     907:	45 85 db             	test   r11d,r11d
     90a:	0f 95 c1             	setne  cl
     90d:	c1 e1 06             	shl    ecx,0x6
     910:	09 d1                	or     ecx,edx
     912:	31 d2                	xor    edx,edx
     914:	45 85 c9             	test   r9d,r9d
     917:	0f 95 c2             	setne  dl
     91a:	48 83 c0 20          	add    rax,0x20
     91e:	48 83 c6 01          	add    rsi,0x1
     922:	c1 e2 07             	shl    edx,0x7
     925:	09 ca                	or     edx,ecx
     927:	88 56 ff             	mov    BYTE PTR [rsi-0x1],dl
     92a:	0f b6 14 13          	movzx  edx,BYTE PTR [rbx+rdx*1]
     92e:	01 d7                	add    edi,edx
     930:	49 39 c0             	cmp    r8,rax
     933:	0f 85 67 ff ff ff    	jne    8a0 <gzram_base_encode_scalar+0x3b0>
     939:	89 bc 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],edi
     940:	85 ff                	test   edi,edi
     942:	0f 85 7b fe ff ff    	jne    7c3 <gzram_base_encode_scalar+0x2d3>
     948:	41 c6 45 00 01       	mov    BYTE PTR [r13+0x0],0x1
     94d:	e9 43 fd ff ff       	jmp    695 <gzram_base_encode_scalar+0x1a5>
     952:	4c 39 cf             	cmp    rdi,r9
     955:	0f 85 a4 fd ff ff    	jne    6ff <gzram_base_encode_scalar+0x20f>
     95b:	84 c0                	test   al,al
     95d:	0f 84 9c fd ff ff    	je     6ff <gzram_base_encode_scalar+0x20f>
     963:	be 07 00 00 00       	mov    esi,0x7
     968:	b8 08 00 00 00       	mov    eax,0x8
     96d:	41 bb 08 00 00 00    	mov    r11d,0x8
     973:	e9 97 fd ff ff       	jmp    70f <gzram_base_encode_scalar+0x21f>
     978:	c7 84 24 f8 00 00 00 	mov    DWORD PTR [rsp+0xf8],0x1
     97f:	01 00 00 00 
     983:	41 83 fb 08          	cmp    r11d,0x8
     987:	0f 85 12 fe ff ff    	jne    79f <gzram_base_encode_scalar+0x2af>
     98d:	48 89 f8             	mov    rax,rdi
     990:	48 c1 e8 20          	shr    rax,0x20
     994:	39 c7                	cmp    edi,eax
     996:	0f 84 b3 fe ff ff    	je     84f <gzram_base_encode_scalar+0x35f>
     99c:	48 83 fd 08          	cmp    rbp,0x8
     9a0:	0f 86 d3 fc ff ff    	jbe    679 <gzram_base_encode_scalar+0x189>
     9a6:	ba 03 00 00 00       	mov    edx,0x3
     9ab:	b8 08 00 00 00       	mov    eax,0x8
     9b0:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
     9b5:	4c 29 f1             	sub    rcx,r14
     9b8:	48 39 c1             	cmp    rcx,rax
     9bb:	0f 82 2d fe ff ff    	jb     7ee <gzram_base_encode_scalar+0x2fe>
     9c1:	48 8b 7c 24 18       	mov    rdi,QWORD PTR [rsp+0x18]
     9c6:	41 88 55 00          	mov    BYTE PTR [r13+0x0],dl
     9ca:	89 c2                	mov    edx,eax
     9cc:	4a 8d 0c 37          	lea    rcx,[rdi+r14*1]
     9d0:	83 f8 20             	cmp    eax,0x20
     9d3:	0f 83 d7 00 00 00    	jae    ab0 <gzram_base_encode_scalar+0x5c0>
     9d9:	a8 10                	test   al,0x10
     9db:	0f 85 01 03 00 00    	jne    ce2 <gzram_base_encode_scalar+0x7f2>
     9e1:	a8 08                	test   al,0x8
     9e3:	0f 85 41 03 00 00    	jne    d2a <gzram_base_encode_scalar+0x83a>
     9e9:	a8 04                	test   al,0x4
     9eb:	0f 85 4f 03 00 00    	jne    d40 <gzram_base_encode_scalar+0x850>
     9f1:	85 c0                	test   eax,eax
     9f3:	74 07                	je     9fc <gzram_base_encode_scalar+0x50c>
     9f5:	41 0f b6 14 24       	movzx  edx,BYTE PTR [r12]
     9fa:	88 11                	mov    BYTE PTR [rcx],dl
     9fc:	49 01 c6             	add    r14,rax
     9ff:	e9 91 fc ff ff       	jmp    695 <gzram_base_encode_scalar+0x1a5>
     a04:	be 0f 00 00 00       	mov    esi,0xf
     a09:	b8 10 00 00 00       	mov    eax,0x10
     a0e:	41 bb 10 00 00 00    	mov    r11d,0x10
     a14:	e9 f6 fc ff ff       	jmp    70f <gzram_base_encode_scalar+0x21f>
     a19:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
     a1e:	4d 89 f0             	mov    r8,r14
     a21:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
     a26:	48 8b 6c 24 38       	mov    rbp,QWORD PTR [rsp+0x38]
     a2b:	4c 8b 7c 24 18       	mov    r15,QWORD PTR [rsp+0x18]
     a30:	44 8b 74 24 44       	mov    r14d,DWORD PTR [rsp+0x44]
     a35:	48 8b 9c 24 08 01 00 	mov    rbx,QWORD PTR [rsp+0x108]
     a3c:	00 
     a3d:	4c 8b ac 24 20 01 00 	mov    r13,QWORD PTR [rsp+0x120]
     a44:	00 
     a45:	49 39 f0             	cmp    r8,rsi
     a48:	73 1c                	jae    a66 <gzram_base_encode_scalar+0x576>
     a4a:	44 89 c0             	mov    eax,r8d
     a4d:	e9 67 fb ff ff       	jmp    5b9 <gzram_base_encode_scalar+0xc9>
     a52:	49 8d 7f 08          	lea    rdi,[r15+0x8]
     a56:	48 89 ea             	mov    rdx,rbp
     a59:	4c 89 e6             	mov    rsi,r12
     a5c:	e8 00 00 00 00       	call   a61 <gzram_base_encode_scalar+0x571>
     a61:	e9 37 fb ff ff       	jmp    59d <gzram_base_encode_scalar+0xad>
     a66:	48 39 74 24 20       	cmp    QWORD PTR [rsp+0x20],rsi
     a6b:	0f 82 7a fb ff ff    	jb     5eb <gzram_base_encode_scalar+0xfb>
     a71:	48 85 ed             	test   rbp,rbp
     a74:	0f 85 ff 02 00 00    	jne    d79 <gzram_base_encode_scalar+0x889>
     a7a:	41 c7 07 47 5a 52 31 	mov    DWORD PTR [r15],0x31525a47
     a81:	8d 45 08             	lea    eax,[rbp+0x8]
     a84:	66 41 89 6f 04       	mov    WORD PTR [r15+0x4],bp
     a89:	45 88 77 06          	mov    BYTE PTR [r15+0x6],r14b
     a8d:	41 c6 47 07 01       	mov    BYTE PTR [r15+0x7],0x1
     a92:	e9 22 fb ff ff       	jmp    5b9 <gzram_base_encode_scalar+0xc9>
     a97:	ba 06 00 00 00       	mov    edx,0x6
     a9c:	b8 20 00 00 00       	mov    eax,0x20
     aa1:	e9 0a ff ff ff       	jmp    9b0 <gzram_base_encode_scalar+0x4c0>
     aa6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
     aad:	00 00 00 
     ab0:	49 8d 34 04          	lea    rsi,[r12+rax*1]
     ab4:	8d 50 ff             	lea    edx,[rax-0x1]
     ab7:	48 8b 7e e0          	mov    rdi,QWORD PTR [rsi-0x20]
     abb:	48 89 7c 08 e0       	mov    QWORD PTR [rax+rcx*1-0x20],rdi
     ac0:	48 8b 7e e8          	mov    rdi,QWORD PTR [rsi-0x18]
     ac4:	48 89 7c 08 e8       	mov    QWORD PTR [rax+rcx*1-0x18],rdi
     ac9:	48 8b 7e f0          	mov    rdi,QWORD PTR [rsi-0x10]
     acd:	48 89 7c 08 f0       	mov    QWORD PTR [rax+rcx*1-0x10],rdi
     ad2:	48 8b 76 f8          	mov    rsi,QWORD PTR [rsi-0x8]
     ad6:	48 89 74 08 f8       	mov    QWORD PTR [rax+rcx*1-0x8],rsi
     adb:	83 fa 20             	cmp    edx,0x20
     ade:	0f 82 18 ff ff ff    	jb     9fc <gzram_base_encode_scalar+0x50c>
     ae4:	83 e2 e0             	and    edx,0xffffffe0
     ae7:	31 ff                	xor    edi,edi
     ae9:	89 fe                	mov    esi,edi
     aeb:	83 c7 20             	add    edi,0x20
     aee:	4d 8b 1c 34          	mov    r11,QWORD PTR [r12+rsi*1]
     af2:	4d 8b 54 34 08       	mov    r10,QWORD PTR [r12+rsi*1+0x8]
     af7:	4d 8b 4c 34 10       	mov    r9,QWORD PTR [r12+rsi*1+0x10]
     afc:	4d 8b 44 34 18       	mov    r8,QWORD PTR [r12+rsi*1+0x18]
     b01:	4c 89 1c 31          	mov    QWORD PTR [rcx+rsi*1],r11
     b05:	4c 89 54 31 08       	mov    QWORD PTR [rcx+rsi*1+0x8],r10
     b0a:	4c 89 4c 31 10       	mov    QWORD PTR [rcx+rsi*1+0x10],r9
     b0f:	4c 89 44 31 18       	mov    QWORD PTR [rcx+rsi*1+0x18],r8
     b14:	39 d7                	cmp    edi,edx
     b16:	72 d1                	jb     ae9 <gzram_base_encode_scalar+0x5f9>
     b18:	e9 df fe ff ff       	jmp    9fc <gzram_base_encode_scalar+0x50c>
     b1d:	48 39 e8             	cmp    rax,rbp
     b20:	0f 82 48 fc ff ff    	jb     76e <gzram_base_encode_scalar+0x27e>
     b26:	c7 84 24 fc 00 00 00 	mov    DWORD PTR [rsp+0xfc],0x0
     b2d:	00 00 00 00 
     b31:	49 89 e8             	mov    r8,rbp
     b34:	49 c1 e8 05          	shr    r8,0x5
     b38:	0f 84 0a fe ff ff    	je     948 <gzram_base_encode_scalar+0x458>
     b3e:	e9 3f fd ff ff       	jmp    882 <gzram_base_encode_scalar+0x392>
     b43:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
     b48:	48 39 c2             	cmp    rdx,rax
     b4b:	0f 82 9d fc ff ff    	jb     7ee <gzram_base_encode_scalar+0x2fe>
     b51:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
     b56:	41 c6 45 00 04       	mov    BYTE PTR [r13+0x0],0x4
     b5b:	4c 01 f0             	add    rax,r14
     b5e:	41 83 f9 20          	cmp    r9d,0x20
     b62:	0f 83 f7 00 00 00    	jae    c5f <gzram_base_encode_scalar+0x76f>
     b68:	41 f6 c1 10          	test   r9b,0x10
     b6c:	0f 85 30 02 00 00    	jne    da2 <gzram_base_encode_scalar+0x8b2>
     b72:	41 f6 c1 08          	test   r9b,0x8
     b76:	0f 85 75 02 00 00    	jne    df1 <gzram_base_encode_scalar+0x901>
     b7c:	41 f6 c1 04          	test   r9b,0x4
     b80:	0f 85 55 02 00 00    	jne    ddb <gzram_base_encode_scalar+0x8eb>
     b86:	45 85 c9             	test   r9d,r9d
     b89:	74 11                	je     b9c <gzram_base_encode_scalar+0x6ac>
     b8b:	0f b6 54 24 78       	movzx  edx,BYTE PTR [rsp+0x78]
     b90:	88 10                	mov    BYTE PTR [rax],dl
     b92:	41 f6 c1 02          	test   r9b,0x2
     b96:	0f 85 6f 02 00 00    	jne    e0b <gzram_base_encode_scalar+0x91b>
     b9c:	4d 01 ce             	add    r14,r9
     b9f:	4d 85 c9             	test   r9,r9
     ba2:	0f 84 ed fa ff ff    	je     695 <gzram_base_encode_scalar+0x1a5>
     ba8:	49 c1 e1 05          	shl    r9,0x5
     bac:	4c 8b 5c 24 18       	mov    r11,QWORD PTR [rsp+0x18]
     bb1:	4c 8d 44 24 78       	lea    r8,[rsp+0x78]
     bb6:	4c 89 e7             	mov    rdi,r12
     bb9:	4d 01 e1             	add    r9,r12
     bbc:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # bc3 <gzram_base_encode_scalar+0x6d3>
     bc3:	66 90                	xchg   ax,ax
     bc5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     bcc:	00 00 00 00 
     bd0:	41 0f b6 08          	movzx  ecx,BYTE PTR [r8]
     bd4:	4b 8d 14 33          	lea    rdx,[r11+r14*1]
     bd8:	81 f9 ff 00 00 00    	cmp    ecx,0xff
     bde:	74 5f                	je     c3f <gzram_base_encode_scalar+0x74f>
     be0:	89 c8                	mov    eax,ecx
     be2:	85 c9                	test   ecx,ecx
     be4:	74 38                	je     c1e <gzram_base_encode_scalar+0x72e>
     be6:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     bea:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     bf1:	00 00 00 00 
     bf5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     bfc:	00 00 00 00 
     c00:	31 ed                	xor    ebp,ebp
     c02:	8d 70 ff             	lea    esi,[rax-0x1]
     c05:	48 83 c2 04          	add    rdx,0x4
     c09:	f3 0f bc e8          	tzcnt  ebp,eax
     c0d:	8d 2c ad 00 00 00 00 	lea    ebp,[rbp*4+0x0]
     c14:	8b 2c 2f             	mov    ebp,DWORD PTR [rdi+rbp*1]
     c17:	89 6a fc             	mov    DWORD PTR [rdx-0x4],ebp
     c1a:	21 f0                	and    eax,esi
     c1c:	75 e2                	jne    c00 <gzram_base_encode_scalar+0x710>
     c1e:	41 0f b6 04 0a       	movzx  eax,BYTE PTR [r10+rcx*1]
     c23:	48 83 c7 20          	add    rdi,0x20
     c27:	49 83 c0 01          	add    r8,0x1
     c2b:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
     c32:	49 01 c6             	add    r14,rax
     c35:	4c 39 cf             	cmp    rdi,r9
     c38:	75 96                	jne    bd0 <gzram_base_encode_scalar+0x6e0>
     c3a:	e9 56 fa ff ff       	jmp    695 <gzram_base_encode_scalar+0x1a5>
     c3f:	48 8b 07             	mov    rax,QWORD PTR [rdi]
     c42:	48 89 02             	mov    QWORD PTR [rdx],rax
     c45:	48 8b 47 08          	mov    rax,QWORD PTR [rdi+0x8]
     c49:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
     c4d:	48 8b 47 10          	mov    rax,QWORD PTR [rdi+0x10]
     c51:	48 89 42 10          	mov    QWORD PTR [rdx+0x10],rax
     c55:	48 8b 47 18          	mov    rax,QWORD PTR [rdi+0x18]
     c59:	48 89 42 18          	mov    QWORD PTR [rdx+0x18],rax
     c5d:	eb bf                	jmp    c1e <gzram_base_encode_scalar+0x72e>
     c5f:	44 89 c9             	mov    ecx,r9d
     c62:	48 8d 14 08          	lea    rdx,[rax+rcx*1]
     c66:	48 8d 4c 0c 78       	lea    rcx,[rsp+rcx*1+0x78]
     c6b:	48 8b 71 e0          	mov    rsi,QWORD PTR [rcx-0x20]
     c6f:	48 89 72 e0          	mov    QWORD PTR [rdx-0x20],rsi
     c73:	48 8b 71 e8          	mov    rsi,QWORD PTR [rcx-0x18]
     c77:	48 89 72 e8          	mov    QWORD PTR [rdx-0x18],rsi
     c7b:	48 8b 71 f0          	mov    rsi,QWORD PTR [rcx-0x10]
     c7f:	48 89 72 f0          	mov    QWORD PTR [rdx-0x10],rsi
     c83:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
     c87:	48 89 4a f8          	mov    QWORD PTR [rdx-0x8],rcx
     c8b:	41 8d 51 ff          	lea    edx,[r9-0x1]
     c8f:	83 fa 20             	cmp    edx,0x20
     c92:	0f 82 04 ff ff ff    	jb     b9c <gzram_base_encode_scalar+0x6ac>
     c98:	83 e2 e0             	and    edx,0xffffffe0
     c9b:	45 31 c0             	xor    r8d,r8d
     c9e:	41 89 d2             	mov    r10d,edx
     ca1:	44 89 c2             	mov    edx,r8d
     ca4:	41 83 c0 20          	add    r8d,0x20
     ca8:	4c 8b 5c 14 78       	mov    r11,QWORD PTR [rsp+rdx*1+0x78]
     cad:	48 8b bc 14 80 00 00 	mov    rdi,QWORD PTR [rsp+rdx*1+0x80]
     cb4:	00 
     cb5:	48 8b b4 14 88 00 00 	mov    rsi,QWORD PTR [rsp+rdx*1+0x88]
     cbc:	00 
     cbd:	48 8b 8c 14 90 00 00 	mov    rcx,QWORD PTR [rsp+rdx*1+0x90]
     cc4:	00 
     cc5:	4c 89 1c 10          	mov    QWORD PTR [rax+rdx*1],r11
     cc9:	48 89 7c 10 08       	mov    QWORD PTR [rax+rdx*1+0x8],rdi
     cce:	48 89 74 10 10       	mov    QWORD PTR [rax+rdx*1+0x10],rsi
     cd3:	48 89 4c 10 18       	mov    QWORD PTR [rax+rdx*1+0x18],rcx
     cd8:	45 39 d0             	cmp    r8d,r10d
     cdb:	72 c4                	jb     ca1 <gzram_base_encode_scalar+0x7b1>
     cdd:	e9 ba fe ff ff       	jmp    b9c <gzram_base_encode_scalar+0x6ac>
     ce2:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     ce6:	48 89 31             	mov    QWORD PTR [rcx],rsi
     ce9:	49 8b 74 24 08       	mov    rsi,QWORD PTR [r12+0x8]
     cee:	48 89 71 08          	mov    QWORD PTR [rcx+0x8],rsi
     cf2:	48 8d 4c 11 10       	lea    rcx,[rcx+rdx*1+0x10]
     cf7:	49 8d 54 14 10       	lea    rdx,[r12+rdx*1+0x10]
     cfc:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
     d00:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
     d04:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     d08:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
     d0c:	e9 eb fc ff ff       	jmp    9fc <gzram_base_encode_scalar+0x50c>
     d11:	48 83 fd 10          	cmp    rbp,0x10
     d15:	0f 86 5e f9 ff ff    	jbe    679 <gzram_base_encode_scalar+0x189>
     d1b:	ba 05 00 00 00       	mov    edx,0x5
     d20:	b8 10 00 00 00       	mov    eax,0x10
     d25:	e9 86 fc ff ff       	jmp    9b0 <gzram_base_encode_scalar+0x4c0>
     d2a:	49 8b 34 24          	mov    rsi,QWORD PTR [r12]
     d2e:	48 89 31             	mov    QWORD PTR [rcx],rsi
     d31:	49 8b 74 14 f8       	mov    rsi,QWORD PTR [r12+rdx*1-0x8]
     d36:	48 89 74 11 f8       	mov    QWORD PTR [rcx+rdx*1-0x8],rsi
     d3b:	e9 bc fc ff ff       	jmp    9fc <gzram_base_encode_scalar+0x50c>
     d40:	41 8b 34 24          	mov    esi,DWORD PTR [r12]
     d44:	89 31                	mov    DWORD PTR [rcx],esi
     d46:	41 8b 74 14 fc       	mov    esi,DWORD PTR [r12+rdx*1-0x4]
     d4b:	89 74 11 fc          	mov    DWORD PTR [rcx+rdx*1-0x4],esi
     d4f:	e9 a8 fc ff ff       	jmp    9fc <gzram_base_encode_scalar+0x50c>
     d54:	48 8b 9c 24 08 01 00 	mov    rbx,QWORD PTR [rsp+0x108]
     d5b:	00 
     d5c:	4c 8b ac 24 20 01 00 	mov    r13,QWORD PTR [rsp+0x120]
     d63:	00 
     d64:	e9 50 f8 ff ff       	jmp    5b9 <gzram_base_encode_scalar+0xc9>
     d69:	48 89 ea             	mov    rdx,rbp
     d6c:	4c 89 e6             	mov    rsi,r12
     d6f:	e8 00 00 00 00       	call   d74 <gzram_base_encode_scalar+0x884>
     d74:	e9 a9 fa ff ff       	jmp    822 <gzram_base_encode_scalar+0x332>
     d79:	49 8d 7f 08          	lea    rdi,[r15+0x8]
     d7d:	48 89 ea             	mov    rdx,rbp
     d80:	4c 89 e6             	mov    rsi,r12
     d83:	e8 00 00 00 00       	call   d88 <gzram_base_encode_scalar+0x898>
     d88:	e9 ed fc ff ff       	jmp    a7a <gzram_base_encode_scalar+0x58a>
     d8d:	41 b8 08 00 00 00    	mov    r8d,0x8
     d93:	48 83 fe 08          	cmp    rsi,0x8
     d97:	0f 85 ad fc ff ff    	jne    a4a <gzram_base_encode_scalar+0x55a>
     d9d:	e9 cf fc ff ff       	jmp    a71 <gzram_base_encode_scalar+0x581>
     da2:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     da7:	48 89 10             	mov    QWORD PTR [rax],rdx
     daa:	48 8b 94 24 80 00 00 	mov    rdx,QWORD PTR [rsp+0x80]
     db1:	00 
     db2:	48 89 50 08          	mov    QWORD PTR [rax+0x8],rdx
     db6:	44 89 ca             	mov    edx,r9d
     db9:	48 8d 44 10 10       	lea    rax,[rax+rdx*1+0x10]
     dbe:	48 8d 94 14 88 00 00 	lea    rdx,[rsp+rdx*1+0x88]
     dc5:	00 
     dc6:	48 8b 4a e0          	mov    rcx,QWORD PTR [rdx-0x20]
     dca:	48 89 48 e0          	mov    QWORD PTR [rax-0x20],rcx
     dce:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
     dd2:	48 89 50 e8          	mov    QWORD PTR [rax-0x18],rdx
     dd6:	e9 c1 fd ff ff       	jmp    b9c <gzram_base_encode_scalar+0x6ac>
     ddb:	8b 54 24 78          	mov    edx,DWORD PTR [rsp+0x78]
     ddf:	89 10                	mov    DWORD PTR [rax],edx
     de1:	44 89 ca             	mov    edx,r9d
     de4:	8b 4c 14 74          	mov    ecx,DWORD PTR [rsp+rdx*1+0x74]
     de8:	89 4c 10 fc          	mov    DWORD PTR [rax+rdx*1-0x4],ecx
     dec:	e9 ab fd ff ff       	jmp    b9c <gzram_base_encode_scalar+0x6ac>
     df1:	48 8b 54 24 78       	mov    rdx,QWORD PTR [rsp+0x78]
     df6:	48 89 10             	mov    QWORD PTR [rax],rdx
     df9:	44 89 ca             	mov    edx,r9d
     dfc:	48 8b 4c 14 70       	mov    rcx,QWORD PTR [rsp+rdx*1+0x70]
     e01:	48 89 4c 10 f8       	mov    QWORD PTR [rax+rdx*1-0x8],rcx
     e06:	e9 91 fd ff ff       	jmp    b9c <gzram_base_encode_scalar+0x6ac>
     e0b:	44 89 ca             	mov    edx,r9d
     e0e:	0f b7 4c 14 76       	movzx  ecx,WORD PTR [rsp+rdx*1+0x76]
     e13:	66 89 4c 10 fe       	mov    WORD PTR [rax+rdx*1-0x2],cx
     e18:	e9 7f fd ff ff       	jmp    b9c <gzram_base_encode_scalar+0x6ac>
     e1d:	0f 1f 00             	nop    DWORD PTR [rax]

0000000000000e20 <gzram_base_encode_avx2>:
     e20:	48 81 ec 28 01 00 00 	sub    rsp,0x128
     e27:	48 89 ac 24 00 01 00 	mov    QWORD PTR [rsp+0x100],rbp
     e2e:	00 
     e2f:	48 89 d5             	mov    rbp,rdx
     e32:	4c 89 a4 24 08 01 00 	mov    QWORD PTR [rsp+0x108],r12
     e39:	00 
     e3a:	49 89 f4             	mov    r12,rsi
     e3d:	4c 89 ac 24 10 01 00 	mov    QWORD PTR [rsp+0x110],r13
     e44:	00 
     e45:	49 89 cd             	mov    r13,rcx
     e48:	4c 89 b4 24 18 01 00 	mov    QWORD PTR [rsp+0x118],r14
     e4f:	00 
     e50:	49 89 fe             	mov    r14,rdi
     e53:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
     e58:	e8 00 00 00 00       	call   e5d <gzram_base_encode_avx2+0x3d>
     e5d:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
     e62:	85 c0                	test   eax,eax
     e64:	0f 84 a6 00 00 00    	je     f10 <gzram_base_encode_avx2+0xf0>
     e6a:	41 8d 40 fb          	lea    eax,[r8-0x5]
     e6e:	83 f8 07             	cmp    eax,0x7
     e71:	0f 87 e9 00 00 00    	ja     f60 <gzram_base_encode_avx2+0x140>
     e77:	49 81 fc 00 10 00 00 	cmp    r12,0x1000
     e7e:	0f 87 dc 00 00 00    	ja     f60 <gzram_base_encode_avx2+0x140>
     e84:	48 85 ed             	test   rbp,rbp
     e87:	0f 84 d3 00 00 00    	je     f60 <gzram_base_encode_avx2+0x140>
     e8d:	4d 85 f6             	test   r14,r14
     e90:	0f 94 c2             	sete   dl
     e93:	4d 85 e4             	test   r12,r12
     e96:	0f 95 c0             	setne  al
     e99:	84 c2                	test   dl,al
     e9b:	0f 85 bf 00 00 00    	jne    f60 <gzram_base_encode_avx2+0x140>
     ea1:	49 83 fd 07          	cmp    r13,0x7
     ea5:	0f 86 b5 00 00 00    	jbe    f60 <gzram_base_encode_avx2+0x140>
     eab:	44 89 c1             	mov    ecx,r8d
     eae:	41 ba 01 00 00 00    	mov    r10d,0x1
     eb4:	49 8d 74 24 08       	lea    rsi,[r12+0x8]
     eb9:	48 89 9c 24 f8 00 00 	mov    QWORD PTR [rsp+0xf8],rbx
     ec0:	00 
     ec1:	49 d3 e2             	shl    r10,cl
     ec4:	4b 8d 44 22 ff       	lea    rax,[r10+r12*1-0x1]
     ec9:	48 d3 e8             	shr    rax,cl
     ecc:	48 8d 58 08          	lea    rbx,[rax+0x8]
     ed0:	49 39 dd             	cmp    r13,rbx
     ed3:	0f 83 b7 00 00 00    	jae    f90 <gzram_base_encode_avx2+0x170>
     ed9:	49 39 f5             	cmp    r13,rsi
     edc:	72 72                	jb     f50 <gzram_base_encode_avx2+0x130>
     ede:	4d 85 e4             	test   r12,r12
     ee1:	0f 85 61 03 00 00    	jne    1248 <gzram_base_encode_avx2+0x428>
     ee7:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
     eee:	41 8d 44 24 08       	lea    eax,[r12+0x8]
     ef3:	44 88 65 04          	mov    BYTE PTR [rbp+0x4],r12b
     ef7:	c6 45 05 00          	mov    BYTE PTR [rbp+0x5],0x0
     efb:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
     eff:	c6 45 07 01          	mov    BYTE PTR [rbp+0x7],0x1
     f03:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
     f0a:	00 
     f0b:	eb 55                	jmp    f62 <gzram_base_encode_avx2+0x142>
     f0d:	0f 1f 00             	nop    DWORD PTR [rax]
     f10:	4c 89 e9             	mov    rcx,r13
     f13:	48 89 ea             	mov    rdx,rbp
     f16:	4c 89 e6             	mov    rsi,r12
     f19:	4c 89 f7             	mov    rdi,r14
     f1c:	48 8b ac 24 00 01 00 	mov    rbp,QWORD PTR [rsp+0x100]
     f23:	00 
     f24:	4c 8b a4 24 08 01 00 	mov    r12,QWORD PTR [rsp+0x108]
     f2b:	00 
     f2c:	4c 8b ac 24 10 01 00 	mov    r13,QWORD PTR [rsp+0x110]
     f33:	00 
     f34:	4c 8b b4 24 18 01 00 	mov    r14,QWORD PTR [rsp+0x118]
     f3b:	00 
     f3c:	48 81 c4 28 01 00 00 	add    rsp,0x128
     f43:	e9 00 00 00 00       	jmp    f48 <gzram_base_encode_avx2+0x128>
     f48:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     f4f:	00 
     f50:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
     f57:	00 
     f58:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
     f5f:	00 
     f60:	31 c0                	xor    eax,eax
     f62:	48 8b ac 24 00 01 00 	mov    rbp,QWORD PTR [rsp+0x100]
     f69:	00 
     f6a:	4c 8b a4 24 08 01 00 	mov    r12,QWORD PTR [rsp+0x108]
     f71:	00 
     f72:	4c 8b ac 24 10 01 00 	mov    r13,QWORD PTR [rsp+0x110]
     f79:	00 
     f7a:	4c 8b b4 24 18 01 00 	mov    r14,QWORD PTR [rsp+0x118]
     f81:	00 
     f82:	48 81 c4 28 01 00 00 	add    rsp,0x128
     f89:	c3                   	ret
     f8a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
     f90:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
     f97:	66 44 89 65 04       	mov    WORD PTR [rbp+0x4],r12w
     f9c:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
     fa0:	c6 45 07 00          	mov    BYTE PTR [rbp+0x7],0x0
     fa4:	48 85 c0             	test   rax,rax
     fa7:	0f 84 19 05 00 00    	je     14c6 <gzram_base_encode_avx2+0x6a6>
     fad:	48 8d 7d 08          	lea    rdi,[rbp+0x8]
     fb1:	4c 89 f1             	mov    rcx,r14
     fb4:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
     fb9:	48 01 f8             	add    rax,rdi
     fbc:	4c 89 bc 24 20 01 00 	mov    QWORD PTR [rsp+0x120],r15
     fc3:	00 
     fc4:	49 89 df             	mov    r15,rbx
     fc7:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
     fcc:	4b 8d 04 26          	lea    rax,[r14+r12*1]
     fd0:	49 89 fe             	mov    r14,rdi
     fd3:	4c 89 64 24 30       	mov    QWORD PTR [rsp+0x30],r12
     fd8:	49 89 cc             	mov    r12,rcx
     fdb:	4c 89 6c 24 18       	mov    QWORD PTR [rsp+0x18],r13
     fe0:	4d 89 d5             	mov    r13,r10
     fe3:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
     fe8:	48 89 74 24 20       	mov    QWORD PTR [rsp+0x20],rsi
     fed:	48 89 7c 24 40       	mov    QWORD PTR [rsp+0x40],rdi
     ff2:	44 89 44 24 3c       	mov    DWORD PTR [rsp+0x3c],r8d
     ff7:	eb 41                	jmp    103a <gzram_base_encode_avx2+0x21a>
     ff9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1000:	48 8b 44 24 18       	mov    rax,QWORD PTR [rsp+0x18]
    1005:	4c 29 f8             	sub    rax,r15
    1008:	48 39 d8             	cmp    rax,rbx
    100b:	0f 82 af 01 00 00    	jb     11c0 <gzram_base_encode_avx2+0x3a0>
    1011:	41 c6 06 00          	mov    BYTE PTR [r14],0x0
    1015:	4a 8d 7c 3d 00       	lea    rdi,[rbp+r15*1+0x0]
    101a:	48 89 da             	mov    rdx,rbx
    101d:	4c 89 e6             	mov    rsi,r12
    1020:	49 01 df             	add    r15,rbx
    1023:	e8 00 00 00 00       	call   1028 <gzram_base_encode_avx2+0x208>
    1028:	4d 01 ec             	add    r12,r13
    102b:	49 83 c6 01          	add    r14,0x1
    102f:	4c 39 74 24 10       	cmp    QWORD PTR [rsp+0x10],r14
    1034:	0f 84 3e 01 00 00    	je     1178 <gzram_base_encode_avx2+0x358>
    103a:	48 8b 4c 24 08       	mov    rcx,QWORD PTR [rsp+0x8]
    103f:	4c 29 e1             	sub    rcx,r12
    1042:	4c 39 e9             	cmp    rcx,r13
    1045:	48 89 cb             	mov    rbx,rcx
    1048:	49 0f 47 dd          	cmova  rbx,r13
    104c:	f6 c3 1f             	test   bl,0x1f
    104f:	75 af                	jne    1000 <gzram_base_encode_avx2+0x1e0>
    1051:	48 8d 54 24 68       	lea    rdx,[rsp+0x68]
    1056:	48 89 de             	mov    rsi,rbx
    1059:	4c 89 e7             	mov    rdi,r12
    105c:	e8 4f f1 ff ff       	call   1b0 <scan_avx2>
    1061:	8b 84 24 e8 00 00 00 	mov    eax,DWORD PTR [rsp+0xe8]
    1068:	85 c0                	test   eax,eax
    106a:	75 0c                	jne    1078 <gzram_base_encode_avx2+0x258>
    106c:	41 c6 06 01          	mov    BYTE PTR [r14],0x1
    1070:	eb b6                	jmp    1028 <gzram_base_encode_avx2+0x208>
    1072:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1078:	8b 94 24 ec 00 00 00 	mov    edx,DWORD PTR [rsp+0xec]
    107f:	f6 c2 01             	test   dl,0x1
    1082:	0f 84 c8 00 00 00    	je     1150 <gzram_base_encode_avx2+0x330>
    1088:	48 83 fb 04          	cmp    rbx,0x4
    108c:	76 83                	jbe    1011 <gzram_base_encode_avx2+0x1f1>
    108e:	ba 02 00 00 00       	mov    edx,0x2
    1093:	b8 04 00 00 00       	mov    eax,0x4
    1098:	48 8b 4c 24 18       	mov    rcx,QWORD PTR [rsp+0x18]
    109d:	4c 29 f9             	sub    rcx,r15
    10a0:	48 39 c1             	cmp    rcx,rax
    10a3:	0f 82 17 01 00 00    	jb     11c0 <gzram_base_encode_avx2+0x3a0>
    10a9:	41 88 16             	mov    BYTE PTR [r14],dl
    10ac:	4a 8d 74 3d 00       	lea    rsi,[rbp+r15*1+0x0]
    10b1:	89 c2                	mov    edx,eax
    10b3:	83 f8 20             	cmp    eax,0x20
    10b6:	73 30                	jae    10e8 <gzram_base_encode_avx2+0x2c8>
    10b8:	a8 10                	test   al,0x10
    10ba:	0f 85 a6 01 00 00    	jne    1266 <gzram_base_encode_avx2+0x446>
    10c0:	a8 08                	test   al,0x8
    10c2:	0f 85 90 03 00 00    	jne    1458 <gzram_base_encode_avx2+0x638>
    10c8:	a8 04                	test   al,0x4
    10ca:	0f 85 9e 03 00 00    	jne    146e <gzram_base_encode_avx2+0x64e>
    10d0:	85 c0                	test   eax,eax
    10d2:	74 07                	je     10db <gzram_base_encode_avx2+0x2bb>
    10d4:	41 0f b6 14 24       	movzx  edx,BYTE PTR [r12]
    10d9:	88 16                	mov    BYTE PTR [rsi],dl
    10db:	49 01 c7             	add    r15,rax
    10de:	e9 45 ff ff ff       	jmp    1028 <gzram_base_encode_avx2+0x208>
    10e3:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    10e8:	49 8d 0c 04          	lea    rcx,[r12+rax*1]
    10ec:	8d 50 ff             	lea    edx,[rax-0x1]
    10ef:	48 8b 79 e0          	mov    rdi,QWORD PTR [rcx-0x20]
    10f3:	48 89 7c 30 e0       	mov    QWORD PTR [rax+rsi*1-0x20],rdi
    10f8:	48 8b 79 e8          	mov    rdi,QWORD PTR [rcx-0x18]
    10fc:	48 89 7c 30 e8       	mov    QWORD PTR [rax+rsi*1-0x18],rdi
    1101:	48 8b 79 f0          	mov    rdi,QWORD PTR [rcx-0x10]
    1105:	48 89 7c 30 f0       	mov    QWORD PTR [rax+rsi*1-0x10],rdi
    110a:	48 8b 49 f8          	mov    rcx,QWORD PTR [rcx-0x8]
    110e:	48 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],rcx
    1113:	83 fa 20             	cmp    edx,0x20
    1116:	72 c3                	jb     10db <gzram_base_encode_avx2+0x2bb>
    1118:	83 e2 e0             	and    edx,0xffffffe0
    111b:	31 ff                	xor    edi,edi
    111d:	89 f9                	mov    ecx,edi
    111f:	83 c7 20             	add    edi,0x20
    1122:	4d 8b 1c 0c          	mov    r11,QWORD PTR [r12+rcx*1]
    1126:	4d 8b 54 0c 08       	mov    r10,QWORD PTR [r12+rcx*1+0x8]
    112b:	4d 8b 4c 0c 10       	mov    r9,QWORD PTR [r12+rcx*1+0x10]
    1130:	4d 8b 44 0c 18       	mov    r8,QWORD PTR [r12+rcx*1+0x18]
    1135:	4c 89 1c 0e          	mov    QWORD PTR [rsi+rcx*1],r11
    1139:	4c 89 54 0e 08       	mov    QWORD PTR [rsi+rcx*1+0x8],r10
    113e:	4c 89 4c 0e 10       	mov    QWORD PTR [rsi+rcx*1+0x10],r9
    1143:	4c 89 44 0e 18       	mov    QWORD PTR [rsi+rcx*1+0x18],r8
    1148:	39 d7                	cmp    edi,edx
    114a:	72 d1                	jb     111d <gzram_base_encode_avx2+0x2fd>
    114c:	eb 8d                	jmp    10db <gzram_base_encode_avx2+0x2bb>
    114e:	66 90                	xchg   ax,ax
    1150:	f6 c2 02             	test   dl,0x2
    1153:	0f 84 c7 00 00 00    	je     1220 <gzram_base_encode_avx2+0x400>
    1159:	48 83 fb 08          	cmp    rbx,0x8
    115d:	0f 86 ae fe ff ff    	jbe    1011 <gzram_base_encode_avx2+0x1f1>
    1163:	ba 03 00 00 00       	mov    edx,0x3
    1168:	b8 08 00 00 00       	mov    eax,0x8
    116d:	e9 26 ff ff ff       	jmp    1098 <gzram_base_encode_avx2+0x278>
    1172:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1178:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
    117d:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1182:	4c 89 fb             	mov    rbx,r15
    1185:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
    118a:	44 8b 44 24 3c       	mov    r8d,DWORD PTR [rsp+0x3c]
    118f:	49 39 f7             	cmp    r15,rsi
    1192:	0f 83 fd 00 00 00    	jae    1295 <gzram_base_encode_avx2+0x475>
    1198:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    119f:	00 
    11a0:	89 d8                	mov    eax,ebx
    11a2:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    11a9:	00 
    11aa:	e9 b3 fd ff ff       	jmp    f62 <gzram_base_encode_avx2+0x142>
    11af:	48 39 da             	cmp    rdx,rbx
    11b2:	0f 83 59 fe ff ff    	jae    1011 <gzram_base_encode_avx2+0x1f1>
    11b8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    11bf:	00 
    11c0:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
    11c5:	4c 8b 6c 24 18       	mov    r13,QWORD PTR [rsp+0x18]
    11ca:	31 c0                	xor    eax,eax
    11cc:	48 8b 7c 24 40       	mov    rdi,QWORD PTR [rsp+0x40]
    11d1:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    11d6:	4c 8b 64 24 30       	mov    r12,QWORD PTR [rsp+0x30]
    11db:	44 8b 44 24 3c       	mov    r8d,DWORD PTR [rsp+0x3c]
    11e0:	49 39 f5             	cmp    r13,rsi
    11e3:	0f 82 99 02 00 00    	jb     1482 <gzram_base_encode_avx2+0x662>
    11e9:	4d 85 e4             	test   r12,r12
    11ec:	0f 85 a5 02 00 00    	jne    1497 <gzram_base_encode_avx2+0x677>
    11f2:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
    11f9:	41 8d 44 24 08       	lea    eax,[r12+0x8]
    11fe:	66 44 89 65 04       	mov    WORD PTR [rbp+0x4],r12w
    1203:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
    1207:	c6 45 07 01          	mov    BYTE PTR [rbp+0x7],0x1
    120b:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    1212:	00 
    1213:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    121a:	00 
    121b:	e9 42 fd ff ff       	jmp    f62 <gzram_base_encode_avx2+0x142>
    1220:	f6 c2 04             	test   dl,0x4
    1223:	0f 84 ae 00 00 00    	je     12d7 <gzram_base_encode_avx2+0x4b7>
    1229:	48 83 fb 10          	cmp    rbx,0x10
    122d:	0f 86 de fd ff ff    	jbe    1011 <gzram_base_encode_avx2+0x1f1>
    1233:	ba 05 00 00 00       	mov    edx,0x5
    1238:	b8 10 00 00 00       	mov    eax,0x10
    123d:	e9 56 fe ff ff       	jmp    1098 <gzram_base_encode_avx2+0x278>
    1242:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1248:	48 8d 7d 08          	lea    rdi,[rbp+0x8]
    124c:	4c 89 e2             	mov    rdx,r12
    124f:	4c 89 f6             	mov    rsi,r14
    1252:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    1257:	e8 00 00 00 00       	call   125c <gzram_base_encode_avx2+0x43c>
    125c:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
    1261:	e9 81 fc ff ff       	jmp    ee7 <gzram_base_encode_avx2+0xc7>
    1266:	49 8b 0c 24          	mov    rcx,QWORD PTR [r12]
    126a:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    126d:	49 8b 4c 24 08       	mov    rcx,QWORD PTR [r12+0x8]
    1272:	48 89 4e 08          	mov    QWORD PTR [rsi+0x8],rcx
    1276:	48 8d 4c 16 10       	lea    rcx,[rsi+rdx*1+0x10]
    127b:	49 8d 54 14 10       	lea    rdx,[r12+rdx*1+0x10]
    1280:	48 8b 72 e0          	mov    rsi,QWORD PTR [rdx-0x20]
    1284:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
    1288:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    128c:	48 89 51 e8          	mov    QWORD PTR [rcx-0x18],rdx
    1290:	e9 46 fe ff ff       	jmp    10db <gzram_base_encode_avx2+0x2bb>
    1295:	48 39 74 24 18       	cmp    QWORD PTR [rsp+0x18],rsi
    129a:	0f 82 11 02 00 00    	jb     14b1 <gzram_base_encode_avx2+0x691>
    12a0:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    12a7:	00 
    12a8:	4d 85 e4             	test   r12,r12
    12ab:	0f 85 29 02 00 00    	jne    14da <gzram_base_encode_avx2+0x6ba>
    12b1:	c7 45 00 47 5a 52 31 	mov    DWORD PTR [rbp+0x0],0x31525a47
    12b8:	41 8d 44 24 08       	lea    eax,[r12+0x8]
    12bd:	66 44 89 65 04       	mov    WORD PTR [rbp+0x4],r12w
    12c2:	44 88 45 06          	mov    BYTE PTR [rbp+0x6],r8b
    12c6:	c6 45 07 01          	mov    BYTE PTR [rbp+0x7],0x1
    12ca:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    12d1:	00 
    12d2:	e9 8b fc ff ff       	jmp    f62 <gzram_base_encode_avx2+0x142>
    12d7:	83 e2 08             	and    edx,0x8
    12da:	74 0a                	je     12e6 <gzram_base_encode_avx2+0x4c6>
    12dc:	48 83 fb 20          	cmp    rbx,0x20
    12e0:	0f 87 12 02 00 00    	ja     14f8 <gzram_base_encode_avx2+0x6d8>
    12e6:	48 89 df             	mov    rdi,rbx
    12e9:	48 8b 54 24 18       	mov    rdx,QWORD PTR [rsp+0x18]
    12ee:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    12f5:	48 c1 ef 05          	shr    rdi,0x5
    12f9:	48 01 f8             	add    rax,rdi
    12fc:	4c 29 fa             	sub    rdx,r15
    12ff:	48 39 d8             	cmp    rax,rbx
    1302:	0f 83 a7 fe ff ff    	jae    11af <gzram_base_encode_avx2+0x38f>
    1308:	48 39 c2             	cmp    rdx,rax
    130b:	0f 82 af fe ff ff    	jb     11c0 <gzram_base_encode_avx2+0x3a0>
    1311:	41 c6 06 04          	mov    BYTE PTR [r14],0x4
    1315:	4a 8d 54 3d 00       	lea    rdx,[rbp+r15*1+0x0]
    131a:	83 ff 20             	cmp    edi,0x20
    131d:	0f 83 bd 00 00 00    	jae    13e0 <gzram_base_encode_avx2+0x5c0>
    1323:	40 f6 c7 10          	test   dil,0x10
    1327:	0f 85 da 01 00 00    	jne    1507 <gzram_base_encode_avx2+0x6e7>
    132d:	40 f6 c7 08          	test   dil,0x8
    1331:	0f 85 02 02 00 00    	jne    1539 <gzram_base_encode_avx2+0x719>
    1337:	40 f6 c7 04          	test   dil,0x4
    133b:	0f 85 11 02 00 00    	jne    1552 <gzram_base_encode_avx2+0x732>
    1341:	85 ff                	test   edi,edi
    1343:	74 11                	je     1356 <gzram_base_encode_avx2+0x536>
    1345:	0f b6 44 24 68       	movzx  eax,BYTE PTR [rsp+0x68]
    134a:	88 02                	mov    BYTE PTR [rdx],al
    134c:	40 f6 c7 02          	test   dil,0x2
    1350:	0f 85 11 02 00 00    	jne    1567 <gzram_base_encode_avx2+0x747>
    1356:	49 01 ff             	add    r15,rdi
    1359:	48 85 ff             	test   rdi,rdi
    135c:	0f 84 c6 fc ff ff    	je     1028 <gzram_base_encode_avx2+0x208>
    1362:	48 c1 e7 05          	shl    rdi,0x5
    1366:	4c 89 6c 24 48       	mov    QWORD PTR [rsp+0x48],r13
    136b:	4d 89 e5             	mov    r13,r12
    136e:	4a 8d 34 27          	lea    rsi,[rdi+r12*1]
    1372:	4c 89 74 24 50       	mov    QWORD PTR [rsp+0x50],r14
    1377:	4c 8d 74 24 68       	lea    r14,[rsp+0x68]
    137c:	4c 89 64 24 58       	mov    QWORD PTR [rsp+0x58],r12
    1381:	49 89 ec             	mov    r12,rbp
    1384:	48 89 f5             	mov    rbp,rsi
    1387:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    138e:	00 00 
    1390:	41 0f b6 1e          	movzx  ebx,BYTE PTR [r14]
    1394:	4b 8d 34 3c          	lea    rsi,[r12+r15*1]
    1398:	4c 89 ef             	mov    rdi,r13
    139b:	49 83 c5 20          	add    r13,0x20
    139f:	49 83 c6 01          	add    r14,0x1
    13a3:	89 da                	mov    edx,ebx
    13a5:	e8 56 ec ff ff       	call   0 <pack_avx2>
    13aa:	48 8d 05 00 00 00 00 	lea    rax,[rip+0x0]        # 13b1 <gzram_base_encode_avx2+0x591>
    13b1:	0f b6 14 18          	movzx  edx,BYTE PTR [rax+rbx*1]
    13b5:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
    13bc:	49 01 d7             	add    r15,rdx
    13bf:	49 39 ed             	cmp    r13,rbp
    13c2:	75 cc                	jne    1390 <gzram_base_encode_avx2+0x570>
    13c4:	4c 89 e5             	mov    rbp,r12
    13c7:	4c 8b 6c 24 48       	mov    r13,QWORD PTR [rsp+0x48]
    13cc:	4c 8b 74 24 50       	mov    r14,QWORD PTR [rsp+0x50]
    13d1:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    13d6:	e9 4d fc ff ff       	jmp    1028 <gzram_base_encode_avx2+0x208>
    13db:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    13e0:	89 f8                	mov    eax,edi
    13e2:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
    13e6:	48 8d 44 04 68       	lea    rax,[rsp+rax*1+0x68]
    13eb:	48 8b 70 e0          	mov    rsi,QWORD PTR [rax-0x20]
    13ef:	48 89 71 e0          	mov    QWORD PTR [rcx-0x20],rsi
    13f3:	48 8b 70 e8          	mov    rsi,QWORD PTR [rax-0x18]
    13f7:	48 89 71 e8          	mov    QWORD PTR [rcx-0x18],rsi
    13fb:	48 8b 70 f0          	mov    rsi,QWORD PTR [rax-0x10]
    13ff:	48 89 71 f0          	mov    QWORD PTR [rcx-0x10],rsi
    1403:	48 8b 40 f8          	mov    rax,QWORD PTR [rax-0x8]
    1407:	48 89 41 f8          	mov    QWORD PTR [rcx-0x8],rax
    140b:	8d 47 ff             	lea    eax,[rdi-0x1]
    140e:	83 f8 20             	cmp    eax,0x20
    1411:	0f 82 3f ff ff ff    	jb     1356 <gzram_base_encode_avx2+0x536>
    1417:	83 e0 e0             	and    eax,0xffffffe0
    141a:	31 c9                	xor    ecx,ecx
    141c:	41 89 c3             	mov    r11d,eax
    141f:	89 c8                	mov    eax,ecx
    1421:	83 c1 20             	add    ecx,0x20
    1424:	4c 8b 54 04 68       	mov    r10,QWORD PTR [rsp+rax*1+0x68]
    1429:	4c 8b 4c 04 70       	mov    r9,QWORD PTR [rsp+rax*1+0x70]
    142e:	4c 8b 44 04 78       	mov    r8,QWORD PTR [rsp+rax*1+0x78]
    1433:	48 8b b4 04 80 00 00 	mov    rsi,QWORD PTR [rsp+rax*1+0x80]
    143a:	00 
    143b:	4c 89 14 02          	mov    QWORD PTR [rdx+rax*1],r10
    143f:	4c 89 4c 02 08       	mov    QWORD PTR [rdx+rax*1+0x8],r9
    1444:	4c 89 44 02 10       	mov    QWORD PTR [rdx+rax*1+0x10],r8
    1449:	48 89 74 02 18       	mov    QWORD PTR [rdx+rax*1+0x18],rsi
    144e:	44 39 d9             	cmp    ecx,r11d
    1451:	72 cc                	jb     141f <gzram_base_encode_avx2+0x5ff>
    1453:	e9 fe fe ff ff       	jmp    1356 <gzram_base_encode_avx2+0x536>
    1458:	49 8b 0c 24          	mov    rcx,QWORD PTR [r12]
    145c:	48 89 0e             	mov    QWORD PTR [rsi],rcx
    145f:	49 8b 4c 14 f8       	mov    rcx,QWORD PTR [r12+rdx*1-0x8]
    1464:	48 89 4c 16 f8       	mov    QWORD PTR [rsi+rdx*1-0x8],rcx
    1469:	e9 6d fc ff ff       	jmp    10db <gzram_base_encode_avx2+0x2bb>
    146e:	41 8b 0c 24          	mov    ecx,DWORD PTR [r12]
    1472:	89 0e                	mov    DWORD PTR [rsi],ecx
    1474:	41 8b 4c 14 fc       	mov    ecx,DWORD PTR [r12+rdx*1-0x4]
    1479:	89 4c 16 fc          	mov    DWORD PTR [rsi+rdx*1-0x4],ecx
    147d:	e9 59 fc ff ff       	jmp    10db <gzram_base_encode_avx2+0x2bb>
    1482:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    1489:	00 
    148a:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    1491:	00 
    1492:	e9 cb fa ff ff       	jmp    f62 <gzram_base_encode_avx2+0x142>
    1497:	4c 89 e2             	mov    rdx,r12
    149a:	4c 89 f6             	mov    rsi,r14
    149d:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    14a2:	e8 00 00 00 00       	call   14a7 <gzram_base_encode_avx2+0x687>
    14a7:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
    14ac:	e9 41 fd ff ff       	jmp    11f2 <gzram_base_encode_avx2+0x3d2>
    14b1:	48 8b 9c 24 f8 00 00 	mov    rbx,QWORD PTR [rsp+0xf8]
    14b8:	00 
    14b9:	4c 8b bc 24 20 01 00 	mov    r15,QWORD PTR [rsp+0x120]
    14c0:	00 
    14c1:	e9 9a fa ff ff       	jmp    f60 <gzram_base_encode_avx2+0x140>
    14c6:	bb 08 00 00 00       	mov    ebx,0x8
    14cb:	48 83 fe 08          	cmp    rsi,0x8
    14cf:	0f 85 cb fc ff ff    	jne    11a0 <gzram_base_encode_avx2+0x380>
    14d5:	e9 ce fd ff ff       	jmp    12a8 <gzram_base_encode_avx2+0x488>
    14da:	48 8d 7d 08          	lea    rdi,[rbp+0x8]
    14de:	4c 89 e2             	mov    rdx,r12
    14e1:	4c 89 f6             	mov    rsi,r14
    14e4:	44 89 44 24 08       	mov    DWORD PTR [rsp+0x8],r8d
    14e9:	e8 00 00 00 00       	call   14ee <gzram_base_encode_avx2+0x6ce>
    14ee:	44 8b 44 24 08       	mov    r8d,DWORD PTR [rsp+0x8]
    14f3:	e9 b9 fd ff ff       	jmp    12b1 <gzram_base_encode_avx2+0x491>
    14f8:	ba 06 00 00 00       	mov    edx,0x6
    14fd:	b8 20 00 00 00       	mov    eax,0x20
    1502:	e9 91 fb ff ff       	jmp    1098 <gzram_base_encode_avx2+0x278>
    1507:	48 8b 44 24 68       	mov    rax,QWORD PTR [rsp+0x68]
    150c:	89 f9                	mov    ecx,edi
    150e:	48 89 02             	mov    QWORD PTR [rdx],rax
    1511:	48 8b 44 24 70       	mov    rax,QWORD PTR [rsp+0x70]
    1516:	48 89 42 08          	mov    QWORD PTR [rdx+0x8],rax
    151a:	48 8d 44 0a 10       	lea    rax,[rdx+rcx*1+0x10]
    151f:	48 8d 54 0c 78       	lea    rdx,[rsp+rcx*1+0x78]
    1524:	48 8b 4a e0          	mov    rcx,QWORD PTR [rdx-0x20]
    1528:	48 89 48 e0          	mov    QWORD PTR [rax-0x20],rcx
    152c:	48 8b 52 e8          	mov    rdx,QWORD PTR [rdx-0x18]
    1530:	48 89 50 e8          	mov    QWORD PTR [rax-0x18],rdx
    1534:	e9 1d fe ff ff       	jmp    1356 <gzram_base_encode_avx2+0x536>
    1539:	48 8b 44 24 68       	mov    rax,QWORD PTR [rsp+0x68]
    153e:	48 89 02             	mov    QWORD PTR [rdx],rax
    1541:	89 f8                	mov    eax,edi
    1543:	48 8b 4c 04 60       	mov    rcx,QWORD PTR [rsp+rax*1+0x60]
    1548:	48 89 4c 02 f8       	mov    QWORD PTR [rdx+rax*1-0x8],rcx
    154d:	e9 04 fe ff ff       	jmp    1356 <gzram_base_encode_avx2+0x536>
    1552:	8b 44 24 68          	mov    eax,DWORD PTR [rsp+0x68]
    1556:	89 02                	mov    DWORD PTR [rdx],eax
    1558:	89 f8                	mov    eax,edi
    155a:	8b 4c 04 64          	mov    ecx,DWORD PTR [rsp+rax*1+0x64]
    155e:	89 4c 02 fc          	mov    DWORD PTR [rdx+rax*1-0x4],ecx
    1562:	e9 ef fd ff ff       	jmp    1356 <gzram_base_encode_avx2+0x536>
    1567:	89 f8                	mov    eax,edi
    1569:	0f b7 4c 04 66       	movzx  ecx,WORD PTR [rsp+rax*1+0x66]
    156e:	66 89 4c 02 fe       	mov    WORD PTR [rdx+rax*1-0x2],cx
    1573:	e9 de fd ff ff       	jmp    1356 <gzram_base_encode_avx2+0x536>
    1578:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    157f:	00 

0000000000001580 <gzram_base_decode_scalar>:
    1580:	48 89 c8             	mov    rax,rcx
    1583:	48 8d 4e f8          	lea    rcx,[rsi-0x8]
    1587:	48 81 f9 00 10 00 00 	cmp    rcx,0x1000
    158e:	0f 87 8b 06 00 00    	ja     1c1f <gzram_base_decode_scalar+0x69f>
    1594:	48 85 ff             	test   rdi,rdi
    1597:	0f 84 82 06 00 00    	je     1c1f <gzram_base_decode_scalar+0x69f>
    159d:	81 3f 47 5a 52 31    	cmp    DWORD PTR [rdi],0x31525a47
    15a3:	0f 85 76 06 00 00    	jne    1c1f <gzram_base_decode_scalar+0x69f>
    15a9:	0f b6 4f 06          	movzx  ecx,BYTE PTR [rdi+0x6]
    15ad:	44 8d 41 fb          	lea    r8d,[rcx-0x5]
    15b1:	41 80 f8 07          	cmp    r8b,0x7
    15b5:	0f 87 64 06 00 00    	ja     1c1f <gzram_base_decode_scalar+0x69f>
    15bb:	44 0f b6 4f 07       	movzx  r9d,BYTE PTR [rdi+0x7]
    15c0:	41 80 f9 01          	cmp    r9b,0x1
    15c4:	0f 87 55 06 00 00    	ja     1c1f <gzram_base_decode_scalar+0x69f>
    15ca:	41 ba 00 10 00 00    	mov    r10d,0x1000
    15d0:	48 81 ec a8 00 00 00 	sub    rsp,0xa8
    15d7:	4c 39 d0             	cmp    rax,r10
    15da:	48 89 5c 24 78       	mov    QWORD PTR [rsp+0x78],rbx
    15df:	44 0f b7 47 04       	movzx  r8d,WORD PTR [rdi+0x4]
    15e4:	49 0f 47 c2          	cmova  rax,r10
    15e8:	4c 89 c3             	mov    rbx,r8
    15eb:	4c 39 c0             	cmp    rax,r8
    15ee:	0f 82 c6 04 00 00    	jb     1aba <gzram_base_decode_scalar+0x53a>
    15f4:	48 85 d2             	test   rdx,rdx
    15f7:	75 09                	jne    1602 <gzram_base_decode_scalar+0x82>
    15f9:	4d 85 c0             	test   r8,r8
    15fc:	0f 85 b8 04 00 00    	jne    1aba <gzram_base_decode_scalar+0x53a>
    1602:	4c 89 b4 24 98 00 00 	mov    QWORD PTR [rsp+0x98],r14
    1609:	00 
    160a:	49 89 d6             	mov    r14,rdx
    160d:	4c 89 a4 24 88 00 00 	mov    QWORD PTR [rsp+0x88],r12
    1614:	00 
    1615:	48 89 74 24 38       	mov    QWORD PTR [rsp+0x38],rsi
    161a:	45 84 c9             	test   r9b,r9b
    161d:	0f 85 9d 00 00 00    	jne    16c0 <gzram_base_decode_scalar+0x140>
    1623:	ba 01 00 00 00       	mov    edx,0x1
    1628:	4c 89 bc 24 a0 00 00 	mov    QWORD PTR [rsp+0xa0],r15
    162f:	00 
    1630:	48 d3 e2             	shl    rdx,cl
    1633:	49 89 d7             	mov    r15,rdx
    1636:	49 8d 54 10 ff       	lea    rdx,[r8+rdx*1-0x1]
    163b:	48 d3 ea             	shr    rdx,cl
    163e:	4c 8d 52 08          	lea    r10,[rdx+0x8]
    1642:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    1647:	0f 82 e3 05 00 00    	jb     1c30 <gzram_base_decode_scalar+0x6b0>
    164d:	48 85 d2             	test   rdx,rdx
    1650:	0f 84 cf 05 00 00    	je     1c25 <gzram_base_decode_scalar+0x6a5>
    1656:	4c 89 ac 24 90 00 00 	mov    QWORD PTR [rsp+0x90],r13
    165d:	00 
    165e:	4c 8d 6f 08          	lea    r13,[rdi+0x8]
    1662:	4d 89 f9             	mov    r9,r15
    1665:	4a 8d 04 2a          	lea    rax,[rdx+r13*1]
    1669:	66 89 5c 24 6e       	mov    WORD PTR [rsp+0x6e],bx
    166e:	48 89 44 24 50       	mov    QWORD PTR [rsp+0x50],rax
    1673:	4b 8d 04 06          	lea    rax,[r14+r8*1]
    1677:	48 89 44 24 40       	mov    QWORD PTR [rsp+0x40],rax
    167c:	48 89 7c 24 10       	mov    QWORD PTR [rsp+0x10],rdi
    1681:	48 89 ac 24 80 00 00 	mov    QWORD PTR [rsp+0x80],rbp
    1688:	00 
    1689:	4c 89 d5             	mov    rbp,r10
    168c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1690:	48 8b 5c 24 40       	mov    rbx,QWORD PTR [rsp+0x40]
    1695:	4c 29 f3             	sub    rbx,r14
    1698:	4c 39 cb             	cmp    rbx,r9
    169b:	49 0f 47 d9          	cmova  rbx,r9
    169f:	41 80 7d 00 06       	cmp    BYTE PTR [r13+0x0],0x6
    16a4:	0f 87 e8 03 00 00    	ja     1a92 <gzram_base_decode_scalar+0x512>
    16aa:	41 0f b6 45 00       	movzx  eax,BYTE PTR [r13+0x0]
    16af:	48 8d 3d 00 00 00 00 	lea    rdi,[rip+0x0]        # 16b6 <gzram_base_decode_scalar+0x136>
    16b6:	48 63 04 87          	movsxd rax,DWORD PTR [rdi+rax*4]
    16ba:	48 01 f8             	add    rax,rdi
    16bd:	ff e0                	jmp    rax
    16bf:	90                   	nop
    16c0:	49 8d 50 08          	lea    rdx,[r8+0x8]
    16c4:	48 39 d6             	cmp    rsi,rdx
    16c7:	0f 85 3d 05 00 00    	jne    1c0a <gzram_base_decode_scalar+0x68a>
    16cd:	4d 85 c0             	test   r8,r8
    16d0:	0f 85 20 05 00 00    	jne    1bf6 <gzram_base_decode_scalar+0x676>
    16d6:	0f b7 c3             	movzx  eax,bx
    16d9:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    16e0:	00 
    16e1:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    16e8:	00 
    16e9:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    16ee:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    16f5:	c3                   	ret
    16f6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    16fd:	00 00 00 
    1700:	b9 08 00 00 00       	mov    ecx,0x8
    1705:	48 89 d8             	mov    rax,rbx
    1708:	31 d2                	xor    edx,edx
    170a:	48 f7 f1             	div    rcx
    170d:	48 85 d2             	test   rdx,rdx
    1710:	0f 85 7c 03 00 00    	jne    1a92 <gzram_base_decode_scalar+0x512>
    1716:	48 39 cb             	cmp    rbx,rcx
    1719:	0f 82 73 03 00 00    	jb     1a92 <gzram_base_decode_scalar+0x512>
    171f:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    1724:	48 29 e8             	sub    rax,rbp
    1727:	48 39 c8             	cmp    rax,rcx
    172a:	0f 82 62 03 00 00    	jb     1a92 <gzram_base_decode_scalar+0x512>
    1730:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1735:	44 8d 51 ff          	lea    r10d,[rcx-0x1]
    1739:	89 ce                	mov    esi,ecx
    173b:	89 4c 24 68          	mov    DWORD PTR [rsp+0x68],ecx
    173f:	4c 89 4c 24 58       	mov    QWORD PTR [rsp+0x58],r9
    1744:	41 89 cb             	mov    r11d,ecx
    1747:	41 89 cf             	mov    r15d,ecx
    174a:	83 e6 04             	and    esi,0x4
    174d:	48 8d 3c 28          	lea    rdi,[rax+rbp*1]
    1751:	44 89 d0             	mov    eax,r10d
    1754:	48 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],rbp
    1759:	41 89 cc             	mov    r12d,ecx
    175c:	83 e0 e0             	and    eax,0xffffffe0
    175f:	4c 8d 04 0f          	lea    r8,[rdi+rcx*1]
    1763:	41 83 e3 10          	and    r11d,0x10
    1767:	41 83 e7 08          	and    r15d,0x8
    176b:	89 44 24 08          	mov    DWORD PTR [rsp+0x8],eax
    176f:	89 c8                	mov    eax,ecx
    1771:	89 f5                	mov    ebp,esi
    1773:	83 e0 02             	and    eax,0x2
    1776:	89 44 24 4c          	mov    DWORD PTR [rsp+0x4c],eax
    177a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1780:	49 8d 04 16          	lea    rax,[r14+rdx*1]
    1784:	83 f9 20             	cmp    ecx,0x20
    1787:	0f 83 43 03 00 00    	jae    1ad0 <gzram_base_decode_scalar+0x550>
    178d:	45 85 db             	test   r11d,r11d
    1790:	0f 85 e2 03 00 00    	jne    1b78 <gzram_base_decode_scalar+0x5f8>
    1796:	45 85 ff             	test   r15d,r15d
    1799:	0f 85 11 04 00 00    	jne    1bb0 <gzram_base_decode_scalar+0x630>
    179f:	85 ed                	test   ebp,ebp
    17a1:	0f 85 29 04 00 00    	jne    1bd0 <gzram_base_decode_scalar+0x650>
    17a7:	85 c9                	test   ecx,ecx
    17a9:	74 12                	je     17bd <gzram_base_decode_scalar+0x23d>
    17ab:	0f b6 37             	movzx  esi,BYTE PTR [rdi]
    17ae:	40 88 30             	mov    BYTE PTR [rax],sil
    17b1:	8b 74 24 4c          	mov    esi,DWORD PTR [rsp+0x4c]
    17b5:	85 f6                	test   esi,esi
    17b7:	0f 85 2a 04 00 00    	jne    1be7 <gzram_base_decode_scalar+0x667>
    17bd:	48 01 ca             	add    rdx,rcx
    17c0:	48 39 da             	cmp    rdx,rbx
    17c3:	72 bb                	jb     1780 <gzram_base_decode_scalar+0x200>
    17c5:	48 8b 6c 24 60       	mov    rbp,QWORD PTR [rsp+0x60]
    17ca:	4c 8b 4c 24 58       	mov    r9,QWORD PTR [rsp+0x58]
    17cf:	48 01 cd             	add    rbp,rcx
    17d2:	49 83 c5 01          	add    r13,0x1
    17d6:	4d 01 ce             	add    r14,r9
    17d9:	4c 39 6c 24 50       	cmp    QWORD PTR [rsp+0x50],r13
    17de:	0f 85 ac fe ff ff    	jne    1690 <gzram_base_decode_scalar+0x110>
    17e4:	49 89 ea             	mov    r10,rbp
    17e7:	0f b7 5c 24 6e       	movzx  ebx,WORD PTR [rsp+0x6e]
    17ec:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    17f3:	00 
    17f4:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    17fb:	00 
    17fc:	4c 39 54 24 38       	cmp    QWORD PTR [rsp+0x38],r10
    1801:	0f 85 29 04 00 00    	jne    1c30 <gzram_base_decode_scalar+0x6b0>
    1807:	0f b7 c3             	movzx  eax,bx
    180a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1811:	00 
    1812:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1819:	00 
    181a:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1821:	00 
    1822:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    1827:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    182e:	c3                   	ret
    182f:	90                   	nop
    1830:	b9 04 00 00 00       	mov    ecx,0x4
    1835:	e9 cb fe ff ff       	jmp    1705 <gzram_base_decode_scalar+0x185>
    183a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1840:	48 89 da             	mov    rdx,rbx
    1843:	31 f6                	xor    esi,esi
    1845:	4c 89 f7             	mov    rdi,r14
    1848:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    184d:	e8 00 00 00 00       	call   1852 <gzram_base_decode_scalar+0x2d2>
    1852:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    1857:	e9 76 ff ff ff       	jmp    17d2 <gzram_base_decode_scalar+0x252>
    185c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1860:	b9 10 00 00 00       	mov    ecx,0x10
    1865:	e9 9b fe ff ff       	jmp    1705 <gzram_base_decode_scalar+0x185>
    186a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1870:	48 89 d8             	mov    rax,rbx
    1873:	83 e0 1f             	and    eax,0x1f
    1876:	0f 85 16 02 00 00    	jne    1a92 <gzram_base_decode_scalar+0x512>
    187c:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    1881:	48 c1 eb 05          	shr    rbx,0x5
    1885:	48 29 ea             	sub    rdx,rbp
    1888:	48 39 da             	cmp    rdx,rbx
    188b:	0f 82 01 02 00 00    	jb     1a92 <gzram_base_decode_scalar+0x512>
    1891:	48 8d 34 2b          	lea    rsi,[rbx+rbp*1]
    1895:	48 85 db             	test   rbx,rbx
    1898:	0f 84 a0 01 00 00    	je     1a3e <gzram_base_decode_scalar+0x4be>
    189e:	48 03 6c 24 10       	add    rbp,QWORD PTR [rsp+0x10]
    18a3:	4c 8d 05 00 00 00 00 	lea    r8,[rip+0x0]        # 18aa <gzram_base_decode_scalar+0x32a>
    18aa:	48 8d 3c 2b          	lea    rdi,[rbx+rbp*1]
    18ae:	48 89 ea             	mov    rdx,rbp
    18b1:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    18b5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    18bc:	00 00 00 00 
    18c0:	0f b6 0a             	movzx  ecx,BYTE PTR [rdx]
    18c3:	48 83 c2 01          	add    rdx,0x1
    18c7:	41 0f b6 0c 08       	movzx  ecx,BYTE PTR [r8+rcx*1]
    18cc:	8d 0c 8d 00 00 00 00 	lea    ecx,[rcx*4+0x0]
    18d3:	48 01 c8             	add    rax,rcx
    18d6:	48 39 d7             	cmp    rdi,rdx
    18d9:	75 e5                	jne    18c0 <gzram_base_decode_scalar+0x340>
    18db:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
    18e0:	48 29 f2             	sub    rdx,rsi
    18e3:	48 39 c2             	cmp    rdx,rax
    18e6:	0f 82 a6 01 00 00    	jb     1a92 <gzram_base_decode_scalar+0x512>
    18ec:	4c 89 f1             	mov    rcx,r14
    18ef:	e9 a0 00 00 00       	jmp    1994 <gzram_base_decode_scalar+0x414>
    18f4:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    18f8:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    18fb:	48 83 c0 04          	add    rax,0x4
    18ff:	44 89 51 04          	mov    DWORD PTR [rcx+0x4],r10d
    1903:	f6 c2 04             	test   dl,0x4
    1906:	0f 84 c0 00 00 00    	je     19cc <gzram_base_decode_scalar+0x44c>
    190c:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    190f:	48 83 c0 04          	add    rax,0x4
    1913:	44 89 51 08          	mov    DWORD PTR [rcx+0x8],r10d
    1917:	f6 c2 08             	test   dl,0x8
    191a:	0f 84 bc 00 00 00    	je     19dc <gzram_base_decode_scalar+0x45c>
    1920:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1923:	48 83 c0 04          	add    rax,0x4
    1927:	44 89 51 0c          	mov    DWORD PTR [rcx+0xc],r10d
    192b:	f6 c2 10             	test   dl,0x10
    192e:	0f 84 b8 00 00 00    	je     19ec <gzram_base_decode_scalar+0x46c>
    1934:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    1937:	48 83 c0 04          	add    rax,0x4
    193b:	44 89 51 10          	mov    DWORD PTR [rcx+0x10],r10d
    193f:	f6 c2 20             	test   dl,0x20
    1942:	0f 84 b4 00 00 00    	je     19fc <gzram_base_decode_scalar+0x47c>
    1948:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    194b:	48 83 c0 04          	add    rax,0x4
    194f:	44 89 51 14          	mov    DWORD PTR [rcx+0x14],r10d
    1953:	f6 c2 40             	test   dl,0x40
    1956:	0f 84 b0 00 00 00    	je     1a0c <gzram_base_decode_scalar+0x48c>
    195c:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    195f:	48 83 c0 04          	add    rax,0x4
    1963:	44 89 51 18          	mov    DWORD PTR [rcx+0x18],r10d
    1967:	84 d2                	test   dl,dl
    1969:	0f 89 ac 00 00 00    	jns    1a1b <gzram_base_decode_scalar+0x49b>
    196f:	8b 00                	mov    eax,DWORD PTR [rax]
    1971:	48 83 c5 01          	add    rbp,0x1
    1975:	89 41 1c             	mov    DWORD PTR [rcx+0x1c],eax
    1978:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    197d:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1984:	48 01 c6             	add    rsi,rax
    1987:	48 39 ef             	cmp    rdi,rbp
    198a:	0f 84 ae 00 00 00    	je     1a3e <gzram_base_decode_scalar+0x4be>
    1990:	48 83 c1 20          	add    rcx,0x20
    1994:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1999:	0f b6 55 00          	movzx  edx,BYTE PTR [rbp+0x0]
    199d:	48 01 f0             	add    rax,rsi
    19a0:	f6 c2 01             	test   dl,0x1
    19a3:	0f 84 bf 01 00 00    	je     1b68 <gzram_base_decode_scalar+0x5e8>
    19a9:	44 8b 10             	mov    r10d,DWORD PTR [rax]
    19ac:	48 83 c0 04          	add    rax,0x4
    19b0:	44 89 11             	mov    DWORD PTR [rcx],r10d
    19b3:	f6 c2 02             	test   dl,0x2
    19b6:	0f 85 3c ff ff ff    	jne    18f8 <gzram_base_decode_scalar+0x378>
    19bc:	c7 41 04 00 00 00 00 	mov    DWORD PTR [rcx+0x4],0x0
    19c3:	f6 c2 04             	test   dl,0x4
    19c6:	0f 85 40 ff ff ff    	jne    190c <gzram_base_decode_scalar+0x38c>
    19cc:	c7 41 08 00 00 00 00 	mov    DWORD PTR [rcx+0x8],0x0
    19d3:	f6 c2 08             	test   dl,0x8
    19d6:	0f 85 44 ff ff ff    	jne    1920 <gzram_base_decode_scalar+0x3a0>
    19dc:	c7 41 0c 00 00 00 00 	mov    DWORD PTR [rcx+0xc],0x0
    19e3:	f6 c2 10             	test   dl,0x10
    19e6:	0f 85 48 ff ff ff    	jne    1934 <gzram_base_decode_scalar+0x3b4>
    19ec:	c7 41 10 00 00 00 00 	mov    DWORD PTR [rcx+0x10],0x0
    19f3:	f6 c2 20             	test   dl,0x20
    19f6:	0f 85 4c ff ff ff    	jne    1948 <gzram_base_decode_scalar+0x3c8>
    19fc:	c7 41 14 00 00 00 00 	mov    DWORD PTR [rcx+0x14],0x0
    1a03:	f6 c2 40             	test   dl,0x40
    1a06:	0f 85 50 ff ff ff    	jne    195c <gzram_base_decode_scalar+0x3dc>
    1a0c:	c7 41 18 00 00 00 00 	mov    DWORD PTR [rcx+0x18],0x0
    1a13:	84 d2                	test   dl,dl
    1a15:	0f 88 54 ff ff ff    	js     196f <gzram_base_decode_scalar+0x3ef>
    1a1b:	41 0f b6 04 10       	movzx  eax,BYTE PTR [r8+rdx*1]
    1a20:	48 83 c5 01          	add    rbp,0x1
    1a24:	c7 41 1c 00 00 00 00 	mov    DWORD PTR [rcx+0x1c],0x0
    1a2b:	8d 04 85 00 00 00 00 	lea    eax,[rax*4+0x0]
    1a32:	48 01 c6             	add    rsi,rax
    1a35:	48 39 fd             	cmp    rbp,rdi
    1a38:	0f 85 52 ff ff ff    	jne    1990 <gzram_base_decode_scalar+0x410>
    1a3e:	48 89 f5             	mov    rbp,rsi
    1a41:	e9 8c fd ff ff       	jmp    17d2 <gzram_base_decode_scalar+0x252>
    1a46:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1a4d:	00 00 00 
    1a50:	48 8b 44 24 38       	mov    rax,QWORD PTR [rsp+0x38]
    1a55:	48 29 e8             	sub    rax,rbp
    1a58:	48 39 d8             	cmp    rax,rbx
    1a5b:	72 35                	jb     1a92 <gzram_base_decode_scalar+0x512>
    1a5d:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1a62:	48 89 da             	mov    rdx,rbx
    1a65:	4c 89 f7             	mov    rdi,r14
    1a68:	4c 89 4c 24 08       	mov    QWORD PTR [rsp+0x8],r9
    1a6d:	48 8d 34 28          	lea    rsi,[rax+rbp*1]
    1a71:	48 01 dd             	add    rbp,rbx
    1a74:	e8 00 00 00 00       	call   1a79 <gzram_base_decode_scalar+0x4f9>
    1a79:	4c 8b 4c 24 08       	mov    r9,QWORD PTR [rsp+0x8]
    1a7e:	e9 4f fd ff ff       	jmp    17d2 <gzram_base_decode_scalar+0x252>
    1a83:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1a88:	b9 20 00 00 00       	mov    ecx,0x20
    1a8d:	e9 73 fc ff ff       	jmp    1705 <gzram_base_decode_scalar+0x185>
    1a92:	48 8b ac 24 80 00 00 	mov    rbp,QWORD PTR [rsp+0x80]
    1a99:	00 
    1a9a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1aa1:	00 
    1aa2:	4c 8b ac 24 90 00 00 	mov    r13,QWORD PTR [rsp+0x90]
    1aa9:	00 
    1aaa:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1ab1:	00 
    1ab2:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1ab9:	00 
    1aba:	48 8b 5c 24 78       	mov    rbx,QWORD PTR [rsp+0x78]
    1abf:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1ac4:	48 81 c4 a8 00 00 00 	add    rsp,0xa8
    1acb:	c3                   	ret
    1acc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1ad0:	4d 8b 48 e0          	mov    r9,QWORD PTR [r8-0x20]
    1ad4:	4e 89 4c 20 e0       	mov    QWORD PTR [rax+r12*1-0x20],r9
    1ad9:	4d 8b 48 e8          	mov    r9,QWORD PTR [r8-0x18]
    1add:	4e 89 4c 20 e8       	mov    QWORD PTR [rax+r12*1-0x18],r9
    1ae2:	4d 8b 48 f0          	mov    r9,QWORD PTR [r8-0x10]
    1ae6:	4e 89 4c 20 f0       	mov    QWORD PTR [rax+r12*1-0x10],r9
    1aeb:	4d 8b 48 f8          	mov    r9,QWORD PTR [r8-0x8]
    1aef:	4e 89 4c 20 f8       	mov    QWORD PTR [rax+r12*1-0x8],r9
    1af4:	41 83 fa 20          	cmp    r10d,0x20
    1af8:	0f 82 bf fc ff ff    	jb     17bd <gzram_base_decode_scalar+0x23d>
    1afe:	48 89 5c 24 18       	mov    QWORD PTR [rsp+0x18],rbx
    1b03:	45 31 c9             	xor    r9d,r9d
    1b06:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
    1b0b:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    1b10:	48 89 54 24 30       	mov    QWORD PTR [rsp+0x30],rdx
    1b15:	44 89 c9             	mov    ecx,r9d
    1b18:	41 83 c1 20          	add    r9d,0x20
    1b1c:	4c 8b 74 0f 08       	mov    r14,QWORD PTR [rdi+rcx*1+0x8]
    1b21:	48 8b 5c 0f 10       	mov    rbx,QWORD PTR [rdi+rcx*1+0x10]
    1b26:	48 8b 74 0f 18       	mov    rsi,QWORD PTR [rdi+rcx*1+0x18]
    1b2b:	48 8b 14 0f          	mov    rdx,QWORD PTR [rdi+rcx*1]
    1b2f:	4c 89 74 08 08       	mov    QWORD PTR [rax+rcx*1+0x8],r14
    1b34:	48 89 14 08          	mov    QWORD PTR [rax+rcx*1],rdx
    1b38:	48 89 5c 08 10       	mov    QWORD PTR [rax+rcx*1+0x10],rbx
    1b3d:	48 89 74 08 18       	mov    QWORD PTR [rax+rcx*1+0x18],rsi
    1b42:	44 3b 4c 24 08       	cmp    r9d,DWORD PTR [rsp+0x8]
    1b47:	72 cc                	jb     1b15 <gzram_base_decode_scalar+0x595>
    1b49:	48 8b 5c 24 18       	mov    rbx,QWORD PTR [rsp+0x18]
    1b4e:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
    1b53:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    1b58:	48 8b 54 24 30       	mov    rdx,QWORD PTR [rsp+0x30]
    1b5d:	e9 5b fc ff ff       	jmp    17bd <gzram_base_decode_scalar+0x23d>
    1b62:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1b68:	c7 01 00 00 00 00    	mov    DWORD PTR [rcx],0x0
    1b6e:	e9 40 fe ff ff       	jmp    19b3 <gzram_base_decode_scalar+0x433>
    1b73:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    1b78:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    1b7b:	48 89 30             	mov    QWORD PTR [rax],rsi
    1b7e:	48 8b 77 08          	mov    rsi,QWORD PTR [rdi+0x8]
    1b82:	48 89 70 08          	mov    QWORD PTR [rax+0x8],rsi
    1b86:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1b8a:	48 8d 44 30 10       	lea    rax,[rax+rsi*1+0x10]
    1b8f:	48 8d 74 37 10       	lea    rsi,[rdi+rsi*1+0x10]
    1b94:	4c 8b 4e e0          	mov    r9,QWORD PTR [rsi-0x20]
    1b98:	4c 89 48 e0          	mov    QWORD PTR [rax-0x20],r9
    1b9c:	48 8b 76 e8          	mov    rsi,QWORD PTR [rsi-0x18]
    1ba0:	48 89 70 e8          	mov    QWORD PTR [rax-0x18],rsi
    1ba4:	e9 14 fc ff ff       	jmp    17bd <gzram_base_decode_scalar+0x23d>
    1ba9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1bb0:	48 8b 37             	mov    rsi,QWORD PTR [rdi]
    1bb3:	48 89 30             	mov    QWORD PTR [rax],rsi
    1bb6:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1bba:	4c 8b 4c 37 f8       	mov    r9,QWORD PTR [rdi+rsi*1-0x8]
    1bbf:	4c 89 4c 30 f8       	mov    QWORD PTR [rax+rsi*1-0x8],r9
    1bc4:	e9 f4 fb ff ff       	jmp    17bd <gzram_base_decode_scalar+0x23d>
    1bc9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1bd0:	8b 37                	mov    esi,DWORD PTR [rdi]
    1bd2:	89 30                	mov    DWORD PTR [rax],esi
    1bd4:	8b 74 24 68          	mov    esi,DWORD PTR [rsp+0x68]
    1bd8:	44 8b 4c 37 fc       	mov    r9d,DWORD PTR [rdi+rsi*1-0x4]
    1bdd:	44 89 4c 30 fc       	mov    DWORD PTR [rax+rsi*1-0x4],r9d
    1be2:	e9 d6 fb ff ff       	jmp    17bd <gzram_base_decode_scalar+0x23d>
    1be7:	0f b7 74 0f fe       	movzx  esi,WORD PTR [rdi+rcx*1-0x2]
    1bec:	66 89 74 01 fe       	mov    WORD PTR [rcx+rax*1-0x2],si
    1bf1:	e9 c7 fb ff ff       	jmp    17bd <gzram_base_decode_scalar+0x23d>
    1bf6:	48 8d 77 08          	lea    rsi,[rdi+0x8]
    1bfa:	4c 89 c2             	mov    rdx,r8
    1bfd:	4c 89 f7             	mov    rdi,r14
    1c00:	e8 00 00 00 00       	call   1c05 <gzram_base_decode_scalar+0x685>
    1c05:	e9 cc fa ff ff       	jmp    16d6 <gzram_base_decode_scalar+0x156>
    1c0a:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1c11:	00 
    1c12:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1c19:	00 
    1c1a:	e9 9b fe ff ff       	jmp    1aba <gzram_base_decode_scalar+0x53a>
    1c1f:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1c24:	c3                   	ret
    1c25:	41 ba 08 00 00 00    	mov    r10d,0x8
    1c2b:	e9 cc fb ff ff       	jmp    17fc <gzram_base_decode_scalar+0x27c>
    1c30:	4c 8b a4 24 88 00 00 	mov    r12,QWORD PTR [rsp+0x88]
    1c37:	00 
    1c38:	4c 8b b4 24 98 00 00 	mov    r14,QWORD PTR [rsp+0x98]
    1c3f:	00 
    1c40:	4c 8b bc 24 a0 00 00 	mov    r15,QWORD PTR [rsp+0xa0]
    1c47:	00 
    1c48:	e9 6d fe ff ff       	jmp    1aba <gzram_base_decode_scalar+0x53a>
    1c4d:	0f 1f 00             	nop    DWORD PTR [rax]

0000000000001c50 <gzram_base_decode_avx2>:
    1c50:	48 83 ec 78          	sub    rsp,0x78
    1c54:	48 89 5c 24 48       	mov    QWORD PTR [rsp+0x48],rbx
    1c59:	48 89 cb             	mov    rbx,rcx
    1c5c:	48 89 6c 24 50       	mov    QWORD PTR [rsp+0x50],rbp
    1c61:	48 89 d5             	mov    rbp,rdx
    1c64:	4c 89 64 24 58       	mov    QWORD PTR [rsp+0x58],r12
    1c69:	49 89 fc             	mov    r12,rdi
    1c6c:	4c 89 74 24 68       	mov    QWORD PTR [rsp+0x68],r14
    1c71:	49 89 f6             	mov    r14,rsi
    1c74:	e8 00 00 00 00       	call   1c79 <gzram_base_decode_avx2+0x29>
    1c79:	85 c0                	test   eax,eax
    1c7b:	0f 84 af 00 00 00    	je     1d30 <gzram_base_decode_avx2+0xe0>
    1c81:	49 8d 46 f8          	lea    rax,[r14-0x8]
    1c85:	48 3d 00 10 00 00    	cmp    rax,0x1000
    1c8b:	0f 87 ff 01 00 00    	ja     1e90 <gzram_base_decode_avx2+0x240>
    1c91:	4d 85 e4             	test   r12,r12
    1c94:	0f 84 f6 01 00 00    	je     1e90 <gzram_base_decode_avx2+0x240>
    1c9a:	41 81 3c 24 47 5a 52 	cmp    DWORD PTR [r12],0x31525a47
    1ca1:	31 
    1ca2:	0f 85 e8 01 00 00    	jne    1e90 <gzram_base_decode_avx2+0x240>
    1ca8:	41 0f b6 4c 24 06    	movzx  ecx,BYTE PTR [r12+0x6]
    1cae:	8d 41 fb             	lea    eax,[rcx-0x5]
    1cb1:	3c 07                	cmp    al,0x7
    1cb3:	0f 87 d7 01 00 00    	ja     1e90 <gzram_base_decode_avx2+0x240>
    1cb9:	41 0f b6 7c 24 07    	movzx  edi,BYTE PTR [r12+0x7]
    1cbf:	40 80 ff 01          	cmp    dil,0x1
    1cc3:	0f 87 c7 01 00 00    	ja     1e90 <gzram_base_decode_avx2+0x240>
    1cc9:	b8 00 10 00 00       	mov    eax,0x1000
    1cce:	41 0f b7 54 24 04    	movzx  edx,WORD PTR [r12+0x4]
    1cd4:	48 39 c3             	cmp    rbx,rax
    1cd7:	48 0f 46 c3          	cmovbe rax,rbx
    1cdb:	49 89 d2             	mov    r10,rdx
    1cde:	48 39 d0             	cmp    rax,rdx
    1ce1:	0f 82 a9 01 00 00    	jb     1e90 <gzram_base_decode_avx2+0x240>
    1ce7:	48 85 ed             	test   rbp,rbp
    1cea:	75 09                	jne    1cf5 <gzram_base_decode_avx2+0xa5>
    1cec:	48 85 d2             	test   rdx,rdx
    1cef:	0f 85 9b 01 00 00    	jne    1e90 <gzram_base_decode_avx2+0x240>
    1cf5:	40 84 ff             	test   dil,dil
    1cf8:	74 66                	je     1d60 <gzram_base_decode_avx2+0x110>
    1cfa:	48 8d 42 08          	lea    rax,[rdx+0x8]
    1cfe:	49 39 c6             	cmp    r14,rax
    1d01:	0f 85 89 01 00 00    	jne    1e90 <gzram_base_decode_avx2+0x240>
    1d07:	48 85 d2             	test   rdx,rdx
    1d0a:	0f 85 18 03 00 00    	jne    2028 <gzram_base_decode_avx2+0x3d8>
    1d10:	41 0f b7 c2          	movzx  eax,r10w
    1d14:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1d19:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1d1e:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1d23:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1d28:	48 83 c4 78          	add    rsp,0x78
    1d2c:	c3                   	ret
    1d2d:	0f 1f 00             	nop    DWORD PTR [rax]
    1d30:	48 89 d9             	mov    rcx,rbx
    1d33:	48 89 ea             	mov    rdx,rbp
    1d36:	48 8b 5c 24 48       	mov    rbx,QWORD PTR [rsp+0x48]
    1d3b:	48 8b 6c 24 50       	mov    rbp,QWORD PTR [rsp+0x50]
    1d40:	4c 89 f6             	mov    rsi,r14
    1d43:	4c 89 e7             	mov    rdi,r12
    1d46:	4c 8b 74 24 68       	mov    r14,QWORD PTR [rsp+0x68]
    1d4b:	4c 8b 64 24 58       	mov    r12,QWORD PTR [rsp+0x58]
    1d50:	48 83 c4 78          	add    rsp,0x78
    1d54:	e9 00 00 00 00       	jmp    1d59 <gzram_base_decode_avx2+0x109>
    1d59:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1d60:	41 b9 01 00 00 00    	mov    r9d,0x1
    1d66:	49 d3 e1             	shl    r9,cl
    1d69:	4a 8d 44 0a ff       	lea    rax,[rdx+r9*1-0x1]
    1d6e:	48 d3 e8             	shr    rax,cl
    1d71:	48 8d 58 08          	lea    rbx,[rax+0x8]
    1d75:	49 39 de             	cmp    r14,rbx
    1d78:	0f 82 12 01 00 00    	jb     1e90 <gzram_base_decode_avx2+0x240>
    1d7e:	48 85 c0             	test   rax,rax
    1d81:	0f 84 e1 02 00 00    	je     2068 <gzram_base_decode_avx2+0x418>
    1d87:	49 8d 44 04 08       	lea    rax,[r12+rax*1+0x8]
    1d8c:	66 44 89 54 24 3e    	mov    WORD PTR [rsp+0x3e],r10w
    1d92:	4d 8d 44 24 08       	lea    r8,[r12+0x8]
    1d97:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
    1d9c:	48 8d 44 15 00       	lea    rax,[rbp+rdx*1+0x0]
    1da1:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
    1da6:	4c 89 24 24          	mov    QWORD PTR [rsp],r12
    1daa:	4c 89 6c 24 60       	mov    QWORD PTR [rsp+0x60],r13
    1daf:	4c 8d 2d 00 00 00 00 	lea    r13,[rip+0x0]        # 1db6 <gzram_base_decode_avx2+0x166>
    1db6:	4c 89 7c 24 70       	mov    QWORD PTR [rsp+0x70],r15
    1dbb:	4d 89 cf             	mov    r15,r9
    1dbe:	4c 89 74 24 10       	mov    QWORD PTR [rsp+0x10],r14
    1dc3:	49 89 ee             	mov    r14,rbp
    1dc6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1dcd:	00 00 00 
    1dd0:	48 8b 6c 24 08       	mov    rbp,QWORD PTR [rsp+0x8]
    1dd5:	4c 29 f5             	sub    rbp,r14
    1dd8:	4c 39 fd             	cmp    rbp,r15
    1ddb:	49 0f 47 ef          	cmova  rbp,r15
    1ddf:	41 80 38 06          	cmp    BYTE PTR [r8],0x6
    1de3:	0f 87 5f 02 00 00    	ja     2048 <gzram_base_decode_avx2+0x3f8>
    1de9:	41 0f b6 00          	movzx  eax,BYTE PTR [r8]
    1ded:	49 63 44 85 00       	movsxd rax,DWORD PTR [r13+rax*4+0x0]
    1df2:	4c 01 e8             	add    rax,r13
    1df5:	ff e0                	jmp    rax
    1df7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    1dfe:	00 00 
    1e00:	41 ba 08 00 00 00    	mov    r10d,0x8
    1e06:	b9 08 00 00 00       	mov    ecx,0x8
    1e0b:	48 89 e8             	mov    rax,rbp
    1e0e:	31 d2                	xor    edx,edx
    1e10:	49 f7 f2             	div    r10
    1e13:	48 85 d2             	test   rdx,rdx
    1e16:	0f 85 2c 02 00 00    	jne    2048 <gzram_base_decode_avx2+0x3f8>
    1e1c:	4c 39 d5             	cmp    rbp,r10
    1e1f:	0f 82 23 02 00 00    	jb     2048 <gzram_base_decode_avx2+0x3f8>
    1e25:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1e2a:	48 29 d8             	sub    rax,rbx
    1e2d:	4c 39 d0             	cmp    rax,r10
    1e30:	0f 82 12 02 00 00    	jb     2048 <gzram_base_decode_avx2+0x3f8>
    1e36:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1e3a:	48 89 ea             	mov    rdx,rbp
    1e3d:	4c 89 f7             	mov    rdi,r14
    1e40:	4c 89 44 24 28       	mov    QWORD PTR [rsp+0x28],r8
    1e45:	4c 89 54 24 20       	mov    QWORD PTR [rsp+0x20],r10
    1e4a:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1e4e:	e8 2d e2 ff ff       	call   80 <repeat_avx2>
    1e53:	4c 8b 44 24 28       	mov    r8,QWORD PTR [rsp+0x28]
    1e58:	48 03 5c 24 20       	add    rbx,QWORD PTR [rsp+0x20]
    1e5d:	49 83 c0 01          	add    r8,0x1
    1e61:	4d 01 fe             	add    r14,r15
    1e64:	4c 39 44 24 18       	cmp    QWORD PTR [rsp+0x18],r8
    1e69:	0f 85 61 ff ff ff    	jne    1dd0 <gzram_base_decode_avx2+0x180>
    1e6f:	44 0f b7 54 24 3e    	movzx  r10d,WORD PTR [rsp+0x3e]
    1e75:	4c 8b 74 24 10       	mov    r14,QWORD PTR [rsp+0x10]
    1e7a:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    1e7f:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    1e84:	49 39 de             	cmp    r14,rbx
    1e87:	0f 84 83 fe ff ff    	je     1d10 <gzram_base_decode_avx2+0xc0>
    1e8d:	0f 1f 00             	nop    DWORD PTR [rax]
    1e90:	b8 ff ff ff ff       	mov    eax,0xffffffff
    1e95:	e9 7a fe ff ff       	jmp    1d14 <gzram_base_decode_avx2+0xc4>
    1e9a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1ea0:	41 ba 04 00 00 00    	mov    r10d,0x4
    1ea6:	b9 04 00 00 00       	mov    ecx,0x4
    1eab:	e9 5b ff ff ff       	jmp    1e0b <gzram_base_decode_avx2+0x1bb>
    1eb0:	48 89 ea             	mov    rdx,rbp
    1eb3:	31 f6                	xor    esi,esi
    1eb5:	4c 89 f7             	mov    rdi,r14
    1eb8:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1ebd:	e8 00 00 00 00       	call   1ec2 <gzram_base_decode_avx2+0x272>
    1ec2:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1ec7:	eb 94                	jmp    1e5d <gzram_base_decode_avx2+0x20d>
    1ec9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1ed0:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1ed5:	48 29 d8             	sub    rax,rbx
    1ed8:	48 39 e8             	cmp    rax,rbp
    1edb:	0f 82 67 01 00 00    	jb     2048 <gzram_base_decode_avx2+0x3f8>
    1ee1:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1ee5:	48 89 ea             	mov    rdx,rbp
    1ee8:	4c 89 f7             	mov    rdi,r14
    1eeb:	4c 89 44 24 20       	mov    QWORD PTR [rsp+0x20],r8
    1ef0:	48 8d 34 18          	lea    rsi,[rax+rbx*1]
    1ef4:	48 01 eb             	add    rbx,rbp
    1ef7:	e8 00 00 00 00       	call   1efc <gzram_base_decode_avx2+0x2ac>
    1efc:	4c 8b 44 24 20       	mov    r8,QWORD PTR [rsp+0x20]
    1f01:	e9 57 ff ff ff       	jmp    1e5d <gzram_base_decode_avx2+0x20d>
    1f06:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    1f0d:	00 00 00 
    1f10:	41 ba 20 00 00 00    	mov    r10d,0x20
    1f16:	b9 20 00 00 00       	mov    ecx,0x20
    1f1b:	e9 eb fe ff ff       	jmp    1e0b <gzram_base_decode_avx2+0x1bb>
    1f20:	41 ba 10 00 00 00    	mov    r10d,0x10
    1f26:	b9 10 00 00 00       	mov    ecx,0x10
    1f2b:	e9 db fe ff ff       	jmp    1e0b <gzram_base_decode_avx2+0x1bb>
    1f30:	48 89 e9             	mov    rcx,rbp
    1f33:	83 e1 1f             	and    ecx,0x1f
    1f36:	0f 85 0c 01 00 00    	jne    2048 <gzram_base_decode_avx2+0x3f8>
    1f3c:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    1f41:	48 c1 ed 05          	shr    rbp,0x5
    1f45:	48 29 d8             	sub    rax,rbx
    1f48:	48 39 e8             	cmp    rax,rbp
    1f4b:	0f 82 f7 00 00 00    	jb     2048 <gzram_base_decode_avx2+0x3f8>
    1f51:	48 8d 74 1d 00       	lea    rsi,[rbp+rbx*1+0x0]
    1f56:	48 85 ed             	test   rbp,rbp
    1f59:	0f 84 01 01 00 00    	je     2060 <gzram_base_decode_avx2+0x410>
    1f5f:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1f63:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 1f6a <gzram_base_decode_avx2+0x31a>
    1f6a:	48 01 d8             	add    rax,rbx
    1f6d:	48 8d 14 28          	lea    rdx,[rax+rbp*1]
    1f71:	49 89 c3             	mov    r11,rax
    1f74:	90                   	nop
    1f75:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1f7c:	00 00 00 00 
    1f80:	41 0f b6 3b          	movzx  edi,BYTE PTR [r11]
    1f84:	49 83 c3 01          	add    r11,0x1
    1f88:	41 0f b6 3c 3a       	movzx  edi,BYTE PTR [r10+rdi*1]
    1f8d:	8d 3c bd 00 00 00 00 	lea    edi,[rdi*4+0x0]
    1f94:	48 01 f9             	add    rcx,rdi
    1f97:	49 39 d3             	cmp    r11,rdx
    1f9a:	75 e4                	jne    1f80 <gzram_base_decode_avx2+0x330>
    1f9c:	4c 8b 5c 24 10       	mov    r11,QWORD PTR [rsp+0x10]
    1fa1:	49 29 f3             	sub    r11,rsi
    1fa4:	49 39 cb             	cmp    r11,rcx
    1fa7:	0f 82 9b 00 00 00    	jb     2048 <gzram_base_decode_avx2+0x3f8>
    1fad:	4c 89 44 24 30       	mov    QWORD PTR [rsp+0x30],r8
    1fb2:	48 89 c3             	mov    rbx,rax
    1fb5:	48 89 d5             	mov    rbp,rdx
    1fb8:	4c 89 7c 24 20       	mov    QWORD PTR [rsp+0x20],r15
    1fbd:	4d 89 f7             	mov    r15,r14
    1fc0:	4c 89 74 24 28       	mov    QWORD PTR [rsp+0x28],r14
    1fc5:	49 89 f6             	mov    r14,rsi
    1fc8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
    1fcf:	00 
    1fd0:	44 0f b6 23          	movzx  r12d,BYTE PTR [rbx]
    1fd4:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
    1fd8:	4c 89 fe             	mov    rsi,r15
    1fdb:	48 83 c3 01          	add    rbx,0x1
    1fdf:	49 83 c7 20          	add    r15,0x20
    1fe3:	4a 8d 3c 30          	lea    rdi,[rax+r14*1]
    1fe7:	44 89 e2             	mov    edx,r12d
    1fea:	e8 51 e4 ff ff       	call   440 <unpack_avx2>
    1fef:	44 89 e2             	mov    edx,r12d
    1ff2:	4c 8d 15 00 00 00 00 	lea    r10,[rip+0x0]        # 1ff9 <gzram_base_decode_avx2+0x3a9>
    1ff9:	41 0f b6 14 12       	movzx  edx,BYTE PTR [r10+rdx*1]
    1ffe:	8d 14 95 00 00 00 00 	lea    edx,[rdx*4+0x0]
    2005:	49 01 d6             	add    r14,rdx
    2008:	48 39 eb             	cmp    rbx,rbp
    200b:	75 c3                	jne    1fd0 <gzram_base_decode_avx2+0x380>
    200d:	4c 89 f3             	mov    rbx,r14
    2010:	4c 8b 7c 24 20       	mov    r15,QWORD PTR [rsp+0x20]
    2015:	4c 8b 74 24 28       	mov    r14,QWORD PTR [rsp+0x28]
    201a:	4c 8b 44 24 30       	mov    r8,QWORD PTR [rsp+0x30]
    201f:	e9 39 fe ff ff       	jmp    1e5d <gzram_base_decode_avx2+0x20d>
    2024:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    2028:	49 8d 74 24 08       	lea    rsi,[r12+0x8]
    202d:	48 89 ef             	mov    rdi,rbp
    2030:	44 89 14 24          	mov    DWORD PTR [rsp],r10d
    2034:	e8 00 00 00 00       	call   2039 <gzram_base_decode_avx2+0x3e9>
    2039:	44 8b 14 24          	mov    r10d,DWORD PTR [rsp]
    203d:	e9 ce fc ff ff       	jmp    1d10 <gzram_base_decode_avx2+0xc0>
    2042:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    2048:	4c 8b 6c 24 60       	mov    r13,QWORD PTR [rsp+0x60]
    204d:	4c 8b 7c 24 70       	mov    r15,QWORD PTR [rsp+0x70]
    2052:	e9 39 fe ff ff       	jmp    1e90 <gzram_base_decode_avx2+0x240>
    2057:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
    205e:	00 00 
    2060:	48 89 f3             	mov    rbx,rsi
    2063:	e9 f5 fd ff ff       	jmp    1e5d <gzram_base_decode_avx2+0x20d>
    2068:	bb 08 00 00 00       	mov    ebx,0x8
    206d:	e9 12 fe ff ff       	jmp    1e84 <gzram_base_decode_avx2+0x234>
