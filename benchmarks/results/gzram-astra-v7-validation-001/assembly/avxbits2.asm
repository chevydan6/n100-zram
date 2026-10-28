
build/astra-v7/hybrid-avxbits2base.o:     file format elf64-x86-64


Disassembly of section .text:

00000000000001b0 <scan_avx2>:
     1b0:	55                   	push   rbp
     1b1:	49 89 f8             	mov    r8,rdi
     1b4:	49 89 f2             	mov    r10,rsi
     1b7:	c4 41 19 ef e4       	vpxor  xmm12,xmm12,xmm12
     1bc:	48 89 d7             	mov    rdi,rdx
     1bf:	49 c1 ea 05          	shr    r10,0x5
     1c3:	48 89 e5             	mov    rbp,rsp
     1c6:	48 83 ec 10          	sub    rsp,0x10
     1ca:	c4 42 7d 58 10       	vpbroadcastd ymm10,DWORD PTR [r8]
     1cf:	c4 c2 7d 59 38       	vpbroadcastq ymm7,QWORD PTR [r8]
     1d4:	c4 42 7d 5a 00       	vbroadcasti128 ymm8,XMMWORD PTR [r8]
     1d9:	c4 41 7e 6f 08       	vmovdqu ymm9,YMMWORD PTR [r8]
     1de:	c7 82 80 00 00 00 00 	mov    DWORD PTR [rdx+0x80],0x0
     1e5:	00 00 00 
     1e8:	48 83 fe 3f          	cmp    rsi,0x3f
     1ec:	0f 86 83 01 00 00    	jbe    375 <scan_avx2+0x1c5>
     1f2:	49 8d 72 fe          	lea    rsi,[r10-0x2]
     1f6:	48 89 5d f0          	mov    QWORD PTR [rbp-0x10],rbx
     1fa:	49 89 d3             	mov    r11,rdx
     1fd:	49 8d 58 20          	lea    rbx,[r8+0x20]
     201:	48 89 f0             	mov    rax,rsi
     204:	4c 89 65 f8          	mov    QWORD PTR [rbp-0x8],r12
     208:	31 c9                	xor    ecx,ecx
     20a:	c5 7d 7f e5          	vmovdqa ymm5,ymm12
     20e:	c5 7d 7f e2          	vmovdqa ymm2,ymm12
     212:	c5 7d 7f e3          	vmovdqa ymm3,ymm12
     216:	c5 7d 7f e4          	vmovdqa ymm4,ymm12
     21a:	48 83 e0 fe          	and    rax,0xfffffffffffffffe
     21e:	4c 8d 64 02 02       	lea    r12,[rdx+rax*1+0x2]
     223:	4c 8d 0d 00 00 00 00 	lea    r9,[rip+0x0]        # 22a <scan_avx2+0x7a>
     22a:	c4 41 7d 6f dc       	vmovdqa ymm11,ymm12
     22f:	90                   	nop
     230:	c5 fe 6f 4b e0       	vmovdqu ymm1,YMMWORD PTR [rbx-0x20]
     235:	49 83 c3 02          	add    r11,0x2
     239:	48 83 c3 40          	add    rbx,0x40
     23d:	c4 c1 75 76 c3       	vpcmpeqd ymm0,ymm1,ymm11
     242:	c5 2c 57 f1          	vxorps ymm14,ymm10,ymm1
     246:	c5 44 57 e9          	vxorps ymm13,ymm7,ymm1
     24a:	c4 41 5c 56 f6       	vorps  ymm14,ymm4,ymm14
     24f:	c4 41 64 56 ed       	vorps  ymm13,ymm3,ymm13
     254:	c5 fc 50 d0          	vmovmskps edx,ymm0
     258:	c5 fe 6f 43 c0       	vmovdqu ymm0,YMMWORD PTR [rbx-0x40]
     25d:	80 f2 ff             	xor    dl,0xff
     260:	c4 c1 7d 76 f3       	vpcmpeqd ymm6,ymm0,ymm11
     265:	41 88 53 fe          	mov    BYTE PTR [r11-0x2],dl
     269:	89 d2                	mov    edx,edx
     26b:	c5 ac 57 e0          	vxorps ymm4,ymm10,ymm0
     26f:	41 0f b6 14 11       	movzx  edx,BYTE PTR [r9+rdx*1]
     274:	c5 c4 57 d8          	vxorps ymm3,ymm7,ymm0
     278:	c5 8c 56 e4          	vorps  ymm4,ymm14,ymm4
     27c:	c5 94 56 db          	vorps  ymm3,ymm13,ymm3
     280:	c5 fc 50 c6          	vmovmskps eax,ymm6
     284:	c5 bc 57 f1          	vxorps ymm6,ymm8,ymm1
     288:	c5 b4 57 c9          	vxorps ymm1,ymm9,ymm1
     28c:	34 ff                	xor    al,0xff
     28e:	c5 ec 56 f6          	vorps  ymm6,ymm2,ymm6
     292:	c5 d4 56 c9          	vorps  ymm1,ymm5,ymm1
     296:	41 88 43 ff          	mov    BYTE PTR [r11-0x1],al
     29a:	89 c0                	mov    eax,eax
     29c:	c5 bc 57 d0          	vxorps ymm2,ymm8,ymm0
     2a0:	c5 b4 57 c0          	vxorps ymm0,ymm9,ymm0
     2a4:	41 0f b6 04 01       	movzx  eax,BYTE PTR [r9+rax*1]
     2a9:	c5 cc 56 d2          	vorps  ymm2,ymm6,ymm2
     2ad:	c5 f4 56 e8          	vorps  ymm5,ymm1,ymm0
     2b1:	01 d0                	add    eax,edx
     2b3:	01 c1                	add    ecx,eax
     2b5:	89 8f 80 00 00 00    	mov    DWORD PTR [rdi+0x80],ecx
     2bb:	4d 39 dc             	cmp    r12,r11
     2be:	0f 85 6c ff ff ff    	jne    230 <scan_avx2+0x80>
     2c4:	48 83 e6 fe          	and    rsi,0xfffffffffffffffe
     2c8:	48 8b 5d f0          	mov    rbx,QWORD PTR [rbp-0x10]
     2cc:	4c 8b 65 f8          	mov    r12,QWORD PTR [rbp-0x8]
     2d0:	48 83 c6 02          	add    rsi,0x2
     2d4:	4c 8d 0d 00 00 00 00 	lea    r9,[rip+0x0]        # 2db <scan_avx2+0x12b>
     2db:	4c 39 d6             	cmp    rsi,r10
     2de:	73 53                	jae    333 <scan_avx2+0x183>
     2e0:	48 89 f0             	mov    rax,rsi
     2e3:	48 c1 e0 05          	shl    rax,0x5
     2e7:	c4 c1 7e 6f 04 00    	vmovdqu ymm0,YMMWORD PTR [r8+rax*1]
     2ed:	c4 c1 7d 76 cc       	vpcmpeqd ymm1,ymm0,ymm12
     2f2:	c5 fc 50 c1          	vmovmskps eax,ymm1
     2f6:	c5 ac 57 c8          	vxorps ymm1,ymm10,ymm0
     2fa:	34 ff                	xor    al,0xff
     2fc:	c5 f4 56 e4          	vorps  ymm4,ymm1,ymm4
     300:	c5 c4 57 c8          	vxorps ymm1,ymm7,ymm0
     304:	88 04 37             	mov    BYTE PTR [rdi+rsi*1],al
     307:	89 c0                	mov    eax,eax
     309:	c5 f4 56 db          	vorps  ymm3,ymm1,ymm3
     30d:	48 83 c6 01          	add    rsi,0x1
     311:	41 0f b6 04 01       	movzx  eax,BYTE PTR [r9+rax*1]
     316:	c5 bc 57 c8          	vxorps ymm1,ymm8,ymm0
     31a:	c5 b4 57 c0          	vxorps ymm0,ymm9,ymm0
     31e:	c5 f4 56 d2          	vorps  ymm2,ymm1,ymm2
     322:	c5 fc 56 ed          	vorps  ymm5,ymm0,ymm5
     326:	01 c1                	add    ecx,eax
     328:	89 8f 80 00 00 00    	mov    DWORD PTR [rdi+0x80],ecx
     32e:	49 39 f2             	cmp    r10,rsi
     331:	75 ad                	jne    2e0 <scan_avx2+0x130>
     333:	31 f6                	xor    esi,esi
     335:	c4 e2 7d 17 e4       	vptest ymm4,ymm4
     33a:	40 0f 94 c6          	sete   sil
     33e:	31 c0                	xor    eax,eax
     340:	c4 e2 7d 17 db       	vptest ymm3,ymm3
     345:	0f 94 c0             	sete   al
     348:	31 c9                	xor    ecx,ecx
     34a:	c4 e2 7d 17 d2       	vptest ymm2,ymm2
     34f:	0f 94 c1             	sete   cl
     352:	31 d2                	xor    edx,edx
     354:	c4 e2 7d 17 ed       	vptest ymm5,ymm5
     359:	0f 94 c2             	sete   dl
     35c:	01 c0                	add    eax,eax
     35e:	c1 e1 02             	shl    ecx,0x2
     361:	09 c8                	or     eax,ecx
     363:	c1 e2 03             	shl    edx,0x3
     366:	09 f0                	or     eax,esi
     368:	09 d0                	or     eax,edx
     36a:	89 87 84 00 00 00    	mov    DWORD PTR [rdi+0x84],eax
     370:	c5 f8 77             	vzeroupper
     373:	c9                   	leave
     374:	c3                   	ret
     375:	31 c9                	xor    ecx,ecx
     377:	c5 7d 7f e5          	vmovdqa ymm5,ymm12
     37b:	c5 7d 7f e2          	vmovdqa ymm2,ymm12
     37f:	31 f6                	xor    esi,esi
     381:	c5 7d 7f e3          	vmovdqa ymm3,ymm12
     385:	c5 7d 7f e4          	vmovdqa ymm4,ymm12
     389:	e9 46 ff ff ff       	jmp    2d4 <scan_avx2+0x124>
