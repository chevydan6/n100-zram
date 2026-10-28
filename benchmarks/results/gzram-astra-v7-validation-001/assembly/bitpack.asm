
build/astra-v7/hybrid-bitpackbase.o:     file format elf64-x86-64


Disassembly of section .text:

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
