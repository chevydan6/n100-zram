
build/astra-v7/hybrid-pipe4base.o:     file format elf64-x86-64


Disassembly of section .text:

00000000000001b0 <scan_avx2>:
     1b0:	55                   	push   rbp
     1b1:	49 89 f3             	mov    r11,rsi
     1b4:	c4 41 29 ef d2       	vpxor  xmm10,xmm10,xmm10
     1b9:	49 89 f9             	mov    r9,rdi
     1bc:	49 89 d2             	mov    r10,rdx
     1bf:	49 c1 eb 05          	shr    r11,0x5
     1c3:	48 89 e5             	mov    rbp,rsp
     1c6:	48 83 ec 20          	sub    rsp,0x20
     1ca:	48 89 5d e0          	mov    QWORD PTR [rbp-0x20],rbx
     1ce:	c4 62 7d 58 07       	vpbroadcastd ymm8,DWORD PTR [rdi]
     1d3:	c4 e2 7d 59 2f       	vpbroadcastq ymm5,QWORD PTR [rdi]
     1d8:	c4 e2 7d 5a 37       	vbroadcasti128 ymm6,XMMWORD PTR [rdi]
     1dd:	c5 fe 6f 3f          	vmovdqu ymm7,YMMWORD PTR [rdi]
     1e1:	c7 82 80 00 00 00 00 	mov    DWORD PTR [rdx+0x80],0x0
     1e8:	00 00 00 
     1eb:	48 83 fe 7f          	cmp    rsi,0x7f
     1ef:	0f 86 39 02 00 00    	jbe    42e <scan_avx2+0x27e>
     1f5:	4c 89 6d f0          	mov    QWORD PTR [rbp-0x10],r13
     1f9:	4d 8d 6b fc          	lea    r13,[r11-0x4]
     1fd:	48 89 d0             	mov    rax,rdx
     200:	45 31 c0             	xor    r8d,r8d
     203:	4c 89 ea             	mov    rdx,r13
     206:	4c 89 65 e8          	mov    QWORD PTR [rbp-0x18],r12
     20a:	c4 41 7d 6f e2       	vmovdqa ymm12,ymm10
     20f:	49 89 fc             	mov    r12,rdi
     212:	48 83 e2 fc          	and    rdx,0xfffffffffffffffc
     216:	4c 89 75 f8          	mov    QWORD PTR [rbp-0x8],r14
     21a:	c5 7d 7f d2          	vmovdqa ymm2,ymm10
     21e:	c5 7d 7f d3          	vmovdqa ymm3,ymm10
     222:	4d 8d 74 12 04       	lea    r14,[r10+rdx*1+0x4]
     227:	c5 7d 7f d4          	vmovdqa ymm4,ymm10
     22b:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 232 <scan_avx2+0x82>
     232:	c4 41 7d 6f ca       	vmovdqa ymm9,ymm10
     237:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
     23e:	00 00 
     240:	c4 c1 7e 6f 04 24    	vmovdqu ymm0,YMMWORD PTR [r12]
     246:	c4 41 7e 6f 6c 24 20 	vmovdqu ymm13,YMMWORD PTR [r12+0x20]
     24d:	48 83 c0 04          	add    rax,0x4
     251:	49 83 ec 80          	sub    r12,0xffffffffffffff80
     255:	c4 c1 7d 76 c9       	vpcmpeqd ymm1,ymm0,ymm9
     25a:	c4 41 15 ef f8       	vpxor  ymm15,ymm13,ymm8
     25f:	c5 fc 50 f9          	vmovmskps edi,ymm1
     263:	c4 c1 15 76 c9       	vpcmpeqd ymm1,ymm13,ymm9
     268:	40 80 f7 ff          	xor    dil,0xff
     26c:	c5 fc 50 f1          	vmovmskps esi,ymm1
     270:	c4 c1 7e 6f 4c 24 c0 	vmovdqu ymm1,YMMWORD PTR [r12-0x40]
     277:	40 80 f6 ff          	xor    sil,0xff
     27b:	c4 41 75 76 d9       	vpcmpeqd ymm11,ymm1,ymm9
     280:	c4 c1 7c 50 cb       	vmovmskps ecx,ymm11
     285:	c4 41 7e 6f 5c 24 e0 	vmovdqu ymm11,YMMWORD PTR [r12-0x20]
     28c:	40 88 78 fc          	mov    BYTE PTR [rax-0x4],dil
     290:	89 ff                	mov    edi,edi
     292:	40 88 70 fd          	mov    BYTE PTR [rax-0x3],sil
     296:	89 f6                	mov    esi,esi
     298:	80 f1 ff             	xor    cl,0xff
     29b:	0f b6 3c 3b          	movzx  edi,BYTE PTR [rbx+rdi*1]
     29f:	c4 41 25 76 f1       	vpcmpeqd ymm14,ymm11,ymm9
     2a4:	0f b6 34 33          	movzx  esi,BYTE PTR [rbx+rsi*1]
     2a8:	88 48 fe             	mov    BYTE PTR [rax-0x2],cl
     2ab:	89 c9                	mov    ecx,ecx
     2ad:	01 f7                	add    edi,esi
     2af:	0f b6 34 0b          	movzx  esi,BYTE PTR [rbx+rcx*1]
     2b3:	c4 c1 7c 50 d6       	vmovmskps edx,ymm14
     2b8:	c4 41 7d ef f0       	vpxor  ymm14,ymm0,ymm8
     2bd:	c4 41 0d eb f7       	vpor   ymm14,ymm14,ymm15
     2c2:	c4 41 25 ef f8       	vpxor  ymm15,ymm11,ymm8
     2c7:	80 f2 ff             	xor    dl,0xff
     2ca:	01 fe                	add    esi,edi
     2cc:	c5 0d eb f4          	vpor   ymm14,ymm14,ymm4
     2d0:	c4 c1 75 ef e0       	vpxor  ymm4,ymm1,ymm8
     2d5:	89 d1                	mov    ecx,edx
     2d7:	88 50 ff             	mov    BYTE PTR [rax-0x1],dl
     2da:	c4 c1 5d eb e7       	vpor   ymm4,ymm4,ymm15
     2df:	c4 41 55 ef fd       	vpxor  ymm15,ymm5,ymm13
     2e4:	0f b6 14 0b          	movzx  edx,BYTE PTR [rbx+rcx*1]
     2e8:	c5 8d eb e4          	vpor   ymm4,ymm14,ymm4
     2ec:	c5 7d ef f5          	vpxor  ymm14,ymm0,ymm5
     2f0:	c4 41 0d eb f7       	vpor   ymm14,ymm14,ymm15
     2f5:	c4 41 55 ef fb       	vpxor  ymm15,ymm5,ymm11
     2fa:	01 f2                	add    edx,esi
     2fc:	c5 0d eb f3          	vpor   ymm14,ymm14,ymm3
     300:	c5 d5 ef d9          	vpxor  ymm3,ymm5,ymm1
     304:	41 01 d0             	add    r8d,edx
     307:	c4 c1 65 eb df       	vpor   ymm3,ymm3,ymm15
     30c:	c4 41 4d ef fd       	vpxor  ymm15,ymm6,ymm13
     311:	c4 41 45 ef ed       	vpxor  ymm13,ymm7,ymm13
     316:	45 89 82 80 00 00 00 	mov    DWORD PTR [r10+0x80],r8d
     31d:	c5 8d eb db          	vpor   ymm3,ymm14,ymm3
     321:	c5 7d ef f6          	vpxor  ymm14,ymm0,ymm6
     325:	c5 fd ef c7          	vpxor  ymm0,ymm0,ymm7
     329:	c4 41 0d eb f7       	vpor   ymm14,ymm14,ymm15
     32e:	c4 c1 7d eb c5       	vpor   ymm0,ymm0,ymm13
     333:	c4 41 4d ef fb       	vpxor  ymm15,ymm6,ymm11
     338:	c5 0d eb f2          	vpor   ymm14,ymm14,ymm2
     33c:	c4 41 45 ef db       	vpxor  ymm11,ymm7,ymm11
     341:	c5 cd ef d1          	vpxor  ymm2,ymm6,ymm1
     345:	c5 c5 ef c9          	vpxor  ymm1,ymm7,ymm1
     349:	c4 c1 6d eb d7       	vpor   ymm2,ymm2,ymm15
     34e:	c4 c1 7d eb c4       	vpor   ymm0,ymm0,ymm12
     353:	c4 c1 75 eb cb       	vpor   ymm1,ymm1,ymm11
     358:	c5 8d eb d2          	vpor   ymm2,ymm14,ymm2
     35c:	c5 7d eb e1          	vpor   ymm12,ymm0,ymm1
     360:	49 39 c6             	cmp    r14,rax
     363:	0f 85 d7 fe ff ff    	jne    240 <scan_avx2+0x90>
     369:	4c 89 ea             	mov    rdx,r13
     36c:	4c 8b 65 e8          	mov    r12,QWORD PTR [rbp-0x18]
     370:	4c 8b 6d f0          	mov    r13,QWORD PTR [rbp-0x10]
     374:	48 83 e2 fc          	and    rdx,0xfffffffffffffffc
     378:	4c 8b 75 f8          	mov    r14,QWORD PTR [rbp-0x8]
     37c:	48 83 c2 04          	add    rdx,0x4
     380:	48 8d 1d 00 00 00 00 	lea    rbx,[rip+0x0]        # 387 <scan_avx2+0x1d7>
     387:	4c 39 da             	cmp    rdx,r11
     38a:	73 5b                	jae    3e7 <scan_avx2+0x237>
     38c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
     390:	48 89 d0             	mov    rax,rdx
     393:	48 c1 e0 05          	shl    rax,0x5
     397:	c4 c1 7e 6f 04 01    	vmovdqu ymm0,YMMWORD PTR [r9+rax*1]
     39d:	c4 c1 7d 76 ca       	vpcmpeqd ymm1,ymm0,ymm10
     3a2:	c5 fc 50 c1          	vmovmskps eax,ymm1
     3a6:	c4 c1 7d ef c8       	vpxor  ymm1,ymm0,ymm8
     3ab:	34 ff                	xor    al,0xff
     3ad:	c5 f5 eb e4          	vpor   ymm4,ymm1,ymm4
     3b1:	c5 d5 ef c8          	vpxor  ymm1,ymm5,ymm0
     3b5:	41 88 04 12          	mov    BYTE PTR [r10+rdx*1],al
     3b9:	89 c0                	mov    eax,eax
     3bb:	c5 f5 eb db          	vpor   ymm3,ymm1,ymm3
     3bf:	48 83 c2 01          	add    rdx,0x1
     3c3:	0f b6 04 03          	movzx  eax,BYTE PTR [rbx+rax*1]
     3c7:	c5 cd ef c8          	vpxor  ymm1,ymm6,ymm0
     3cb:	c5 c5 ef c0          	vpxor  ymm0,ymm7,ymm0
     3cf:	c5 f5 eb d2          	vpor   ymm2,ymm1,ymm2
     3d3:	c4 41 7d eb e4       	vpor   ymm12,ymm0,ymm12
     3d8:	41 01 c0             	add    r8d,eax
     3db:	45 89 82 80 00 00 00 	mov    DWORD PTR [r10+0x80],r8d
     3e2:	49 39 d3             	cmp    r11,rdx
     3e5:	75 a9                	jne    390 <scan_avx2+0x1e0>
     3e7:	31 f6                	xor    esi,esi
     3e9:	c4 e2 7d 17 e4       	vptest ymm4,ymm4
     3ee:	40 0f 94 c6          	sete   sil
     3f2:	31 c0                	xor    eax,eax
     3f4:	c4 e2 7d 17 db       	vptest ymm3,ymm3
     3f9:	0f 94 c0             	sete   al
     3fc:	31 c9                	xor    ecx,ecx
     3fe:	c4 e2 7d 17 d2       	vptest ymm2,ymm2
     403:	0f 94 c1             	sete   cl
     406:	31 d2                	xor    edx,edx
     408:	c4 42 7d 17 e4       	vptest ymm12,ymm12
     40d:	0f 94 c2             	sete   dl
     410:	01 c0                	add    eax,eax
     412:	c1 e1 02             	shl    ecx,0x2
     415:	09 c8                	or     eax,ecx
     417:	c1 e2 03             	shl    edx,0x3
     41a:	09 f0                	or     eax,esi
     41c:	09 d0                	or     eax,edx
     41e:	41 89 82 84 00 00 00 	mov    DWORD PTR [r10+0x84],eax
     425:	c5 f8 77             	vzeroupper
     428:	48 8b 5d e0          	mov    rbx,QWORD PTR [rbp-0x20]
     42c:	c9                   	leave
     42d:	c3                   	ret
     42e:	45 31 c0             	xor    r8d,r8d
     431:	c4 41 7d 6f e2       	vmovdqa ymm12,ymm10
     436:	c5 7d 7f d2          	vmovdqa ymm2,ymm10
     43a:	31 d2                	xor    edx,edx
     43c:	c5 7d 7f d3          	vmovdqa ymm3,ymm10
     440:	c5 7d 7f d4          	vmovdqa ymm4,ymm10
     444:	e9 37 ff ff ff       	jmp    380 <scan_avx2+0x1d0>
