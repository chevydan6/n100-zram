
build/astra-v7/hybrid-pipe2base.o:     file format elf64-x86-64


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
     1ec:	0f 86 94 01 00 00    	jbe    386 <scan_avx2+0x1d6>
     1f2:	49 8d 72 fe          	lea    rsi,[r10-0x2]
     1f6:	48 89 5d f0          	mov    QWORD PTR [rbp-0x10],rbx
     1fa:	49 89 d3             	mov    r11,rdx
     1fd:	49 8d 58 20          	lea    rbx,[r8+0x20]
     201:	48 89 f0             	mov    rax,rsi
     204:	4c 89 65 f8          	mov    QWORD PTR [rbp-0x8],r12
     208:	31 c9                	xor    ecx,ecx
     20a:	c5 7d 7f e2          	vmovdqa ymm2,ymm12
     20e:	c5 7d 7f e3          	vmovdqa ymm3,ymm12
     212:	c5 7d 7f e4          	vmovdqa ymm4,ymm12
     216:	c5 7d 7f e5          	vmovdqa ymm5,ymm12
     21a:	48 83 e0 fe          	and    rax,0xfffffffffffffffe
     21e:	4c 8d 64 02 02       	lea    r12,[rdx+rax*1+0x2]
     223:	4c 8d 0d 00 00 00 00 	lea    r9,[rip+0x0]        # 22a <scan_avx2+0x7a>
     22a:	c4 41 7d 6f dc       	vmovdqa ymm11,ymm12
     22f:	90                   	nop
     230:	c5 fe 6f 43 e0       	vmovdqu ymm0,YMMWORD PTR [rbx-0x20]
     235:	49 83 c3 02          	add    r11,0x2
     239:	48 83 c3 40          	add    rbx,0x40
     23d:	c4 c1 7d 76 cb       	vpcmpeqd ymm1,ymm0,ymm11
     242:	c5 fc 50 d1          	vmovmskps edx,ymm1
     246:	c5 fe 6f 4b c0       	vmovdqu ymm1,YMMWORD PTR [rbx-0x40]
     24b:	80 f2 ff             	xor    dl,0xff
     24e:	c4 c1 75 76 f3       	vpcmpeqd ymm6,ymm1,ymm11
     253:	c4 41 75 ef ea       	vpxor  ymm13,ymm1,ymm10
     258:	41 88 53 fe          	mov    BYTE PTR [r11-0x2],dl
     25c:	89 d2                	mov    edx,edx
     25e:	41 0f b6 14 11       	movzx  edx,BYTE PTR [r9+rdx*1]
     263:	c5 fc 50 c6          	vmovmskps eax,ymm6
     267:	c4 c1 7d ef f2       	vpxor  ymm6,ymm0,ymm10
     26c:	34 ff                	xor    al,0xff
     26e:	c4 c1 4d eb f5       	vpor   ymm6,ymm6,ymm13
     273:	c5 45 ef e9          	vpxor  ymm13,ymm7,ymm1
     277:	41 88 43 ff          	mov    BYTE PTR [r11-0x1],al
     27b:	89 c0                	mov    eax,eax
     27d:	c5 cd eb ed          	vpor   ymm5,ymm6,ymm5
     281:	c5 fd ef f7          	vpxor  ymm6,ymm0,ymm7
     285:	41 0f b6 04 01       	movzx  eax,BYTE PTR [r9+rax*1]
     28a:	c4 c1 4d eb f5       	vpor   ymm6,ymm6,ymm13
     28f:	c5 3d ef e9          	vpxor  ymm13,ymm8,ymm1
     293:	c5 b5 ef c9          	vpxor  ymm1,ymm9,ymm1
     297:	c5 cd eb e4          	vpor   ymm4,ymm6,ymm4
     29b:	c4 c1 7d ef f0       	vpxor  ymm6,ymm0,ymm8
     2a0:	c4 c1 7d ef c1       	vpxor  ymm0,ymm0,ymm9
     2a5:	01 d0                	add    eax,edx
     2a7:	c4 c1 4d eb f5       	vpor   ymm6,ymm6,ymm13
     2ac:	c5 fd eb c1          	vpor   ymm0,ymm0,ymm1
     2b0:	01 c1                	add    ecx,eax
     2b2:	c5 cd eb db          	vpor   ymm3,ymm6,ymm3
     2b6:	c5 fd eb d2          	vpor   ymm2,ymm0,ymm2
     2ba:	89 8f 80 00 00 00    	mov    DWORD PTR [rdi+0x80],ecx
     2c0:	4d 39 dc             	cmp    r12,r11
     2c3:	0f 85 67 ff ff ff    	jne    230 <scan_avx2+0x80>
     2c9:	48 83 e6 fe          	and    rsi,0xfffffffffffffffe
     2cd:	48 8b 5d f0          	mov    rbx,QWORD PTR [rbp-0x10]
     2d1:	4c 8b 65 f8          	mov    r12,QWORD PTR [rbp-0x8]
     2d5:	48 83 c6 02          	add    rsi,0x2
     2d9:	4c 8d 0d 00 00 00 00 	lea    r9,[rip+0x0]        # 2e0 <scan_avx2+0x130>
     2e0:	4c 39 d6             	cmp    rsi,r10
     2e3:	73 5f                	jae    344 <scan_avx2+0x194>
     2e5:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
     2ec:	00 00 00 00 
     2f0:	48 89 f0             	mov    rax,rsi
     2f3:	48 c1 e0 05          	shl    rax,0x5
     2f7:	c4 c1 7e 6f 04 00    	vmovdqu ymm0,YMMWORD PTR [r8+rax*1]
     2fd:	c4 c1 7d 76 cc       	vpcmpeqd ymm1,ymm0,ymm12
     302:	c5 fc 50 c1          	vmovmskps eax,ymm1
     306:	c4 c1 7d ef ca       	vpxor  ymm1,ymm0,ymm10
     30b:	34 ff                	xor    al,0xff
     30d:	c5 f5 eb ed          	vpor   ymm5,ymm1,ymm5
     311:	c5 c5 ef c8          	vpxor  ymm1,ymm7,ymm0
     315:	88 04 37             	mov    BYTE PTR [rdi+rsi*1],al
     318:	89 c0                	mov    eax,eax
     31a:	c5 f5 eb e4          	vpor   ymm4,ymm1,ymm4
     31e:	48 83 c6 01          	add    rsi,0x1
     322:	41 0f b6 04 01       	movzx  eax,BYTE PTR [r9+rax*1]
     327:	c5 bd ef c8          	vpxor  ymm1,ymm8,ymm0
     32b:	c5 b5 ef c0          	vpxor  ymm0,ymm9,ymm0
     32f:	c5 f5 eb db          	vpor   ymm3,ymm1,ymm3
     333:	c5 fd eb d2          	vpor   ymm2,ymm0,ymm2
     337:	01 c1                	add    ecx,eax
     339:	89 8f 80 00 00 00    	mov    DWORD PTR [rdi+0x80],ecx
     33f:	49 39 f2             	cmp    r10,rsi
     342:	75 ac                	jne    2f0 <scan_avx2+0x140>
     344:	31 f6                	xor    esi,esi
     346:	c4 e2 7d 17 ed       	vptest ymm5,ymm5
     34b:	40 0f 94 c6          	sete   sil
     34f:	31 c0                	xor    eax,eax
     351:	c4 e2 7d 17 e4       	vptest ymm4,ymm4
     356:	0f 94 c0             	sete   al
     359:	31 c9                	xor    ecx,ecx
     35b:	c4 e2 7d 17 db       	vptest ymm3,ymm3
     360:	0f 94 c1             	sete   cl
     363:	31 d2                	xor    edx,edx
     365:	c4 e2 7d 17 d2       	vptest ymm2,ymm2
     36a:	0f 94 c2             	sete   dl
     36d:	01 c0                	add    eax,eax
     36f:	c1 e1 02             	shl    ecx,0x2
     372:	09 c8                	or     eax,ecx
     374:	c1 e2 03             	shl    edx,0x3
     377:	09 f0                	or     eax,esi
     379:	09 d0                	or     eax,edx
     37b:	89 87 84 00 00 00    	mov    DWORD PTR [rdi+0x84],eax
     381:	c5 f8 77             	vzeroupper
     384:	c9                   	leave
     385:	c3                   	ret
     386:	31 c9                	xor    ecx,ecx
     388:	c5 7d 7f e2          	vmovdqa ymm2,ymm12
     38c:	c5 7d 7f e3          	vmovdqa ymm3,ymm12
     390:	31 f6                	xor    esi,esi
     392:	c5 7d 7f e4          	vmovdqa ymm4,ymm12
     396:	c5 7d 7f e5          	vmovdqa ymm5,ymm12
     39a:	e9 3a ff ff ff       	jmp    2d9 <scan_avx2+0x129>
