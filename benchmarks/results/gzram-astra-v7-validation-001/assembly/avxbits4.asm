
build/astra-v7/hybrid-avxbits4base.o:     file format elf64-x86-64


Disassembly of section .text:

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
