
build/astra-v7/hybrid-pipe1base.o:     file format elf64-x86-64


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
     1da:	0f 84 c6 00 00 00    	je     2a6 <scan_avx2+0xf6>
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
     230:	c4 c1 7d ef e8       	vpxor  ymm5,ymm0,ymm8
     235:	88 04 17             	mov    BYTE PTR [rdi+rdx*1],al
     238:	89 c0                	mov    eax,eax
     23a:	c5 d5 eb db          	vpor   ymm3,ymm5,ymm3
     23e:	48 83 c2 01          	add    rdx,0x1
     242:	41 0f b6 04 01       	movzx  eax,BYTE PTR [r9+rax*1]
     247:	c5 fd ef ef          	vpxor  ymm5,ymm0,ymm7
     24b:	c4 c1 7d ef c2       	vpxor  ymm0,ymm0,ymm10
     250:	c5 d5 eb d2          	vpor   ymm2,ymm5,ymm2
     254:	c5 fd eb c9          	vpor   ymm1,ymm0,ymm1
     258:	01 c1                	add    ecx,eax
     25a:	89 8f 80 00 00 00    	mov    DWORD PTR [rdi+0x80],ecx
     260:	48 39 d6             	cmp    rsi,rdx
     263:	75 ab                	jne    210 <scan_avx2+0x60>
     265:	31 f6                	xor    esi,esi
     267:	c4 e2 7d 17 e4       	vptest ymm4,ymm4
     26c:	40 0f 94 c6          	sete   sil
     270:	31 c0                	xor    eax,eax
     272:	c4 e2 7d 17 db       	vptest ymm3,ymm3
     277:	0f 94 c0             	sete   al
     27a:	31 c9                	xor    ecx,ecx
     27c:	c4 e2 7d 17 d2       	vptest ymm2,ymm2
     281:	0f 94 c1             	sete   cl
     284:	31 d2                	xor    edx,edx
     286:	c4 e2 7d 17 c9       	vptest ymm1,ymm1
     28b:	0f 94 c2             	sete   dl
     28e:	01 c0                	add    eax,eax
     290:	c1 e1 02             	shl    ecx,0x2
     293:	09 c8                	or     eax,ecx
     295:	c1 e2 03             	shl    edx,0x3
     298:	09 f0                	or     eax,esi
     29a:	09 d0                	or     eax,edx
     29c:	89 87 84 00 00 00    	mov    DWORD PTR [rdi+0x84],eax
     2a2:	c5 f8 77             	vzeroupper
     2a5:	c3                   	ret
     2a6:	c5 fd 6f ce          	vmovdqa ymm1,ymm6
     2aa:	c5 fd 6f d6          	vmovdqa ymm2,ymm6
     2ae:	c5 fd 6f de          	vmovdqa ymm3,ymm6
     2b2:	c5 fd 6f e6          	vmovdqa ymm4,ymm6
     2b6:	eb ad                	jmp    265 <scan_avx2+0xb5>
