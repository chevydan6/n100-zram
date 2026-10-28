
build/astra-v7/libgzram-hybrid-bitdirectpipe4.so:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

0000000000002590 <gzram_decode_avx2>:
    2590:	48 83 ec 48          	sub    rsp,0x48
    2594:	48 89 5c 24 30       	mov    QWORD PTR [rsp+0x30],rbx
    2599:	48 85 ff             	test   rdi,rdi
    259c:	0f 84 f6 00 00 00    	je     2698 <gzram_decode_avx2+0x108>
    25a2:	4c 8d 56 f8          	lea    r10,[rsi-0x8]
    25a6:	49 81 fa 20 10 00 00 	cmp    r10,0x1020
    25ad:	0f 87 e5 00 00 00    	ja     2698 <gzram_decode_avx2+0x108>
    25b3:	81 3f 47 48 59 31    	cmp    DWORD PTR [rdi],0x31594847
    25b9:	0f 85 d9 00 00 00    	jne    2698 <gzram_decode_avx2+0x108>
    25bf:	0f b6 47 06          	movzx  eax,BYTE PTR [rdi+0x6]
    25c3:	3c 02                	cmp    al,0x2
    25c5:	0f 87 cd 00 00 00    	ja     2698 <gzram_decode_avx2+0x108>
    25cb:	80 7f 07 00          	cmp    BYTE PTR [rdi+0x7],0x0
    25cf:	0f 85 c3 00 00 00    	jne    2698 <gzram_decode_avx2+0x108>
    25d5:	41 b8 00 10 00 00    	mov    r8d,0x1000
    25db:	44 0f b7 5f 04       	movzx  r11d,WORD PTR [rdi+0x4]
    25e0:	4c 39 c1             	cmp    rcx,r8
    25e3:	49 0f 47 c8          	cmova  rcx,r8
    25e7:	4d 89 d9             	mov    r9,r11
    25ea:	4c 39 d9             	cmp    rcx,r11
    25ed:	0f 82 a5 00 00 00    	jb     2698 <gzram_decode_avx2+0x108>
    25f3:	48 85 d2             	test   rdx,rdx
    25f6:	75 09                	jne    2601 <gzram_decode_avx2+0x71>
    25f8:	4d 85 db             	test   r11,r11
    25fb:	0f 85 97 00 00 00    	jne    2698 <gzram_decode_avx2+0x108>
    2601:	49 89 d0             	mov    r8,rdx
    2604:	85 c0                	test   eax,eax
    2606:	75 28                	jne    2630 <gzram_decode_avx2+0xa0>
    2608:	49 8d 43 08          	lea    rax,[r11+0x8]
    260c:	48 39 c6             	cmp    rsi,rax
    260f:	0f 85 83 00 00 00    	jne    2698 <gzram_decode_avx2+0x108>
    2615:	4d 85 db             	test   r11,r11
    2618:	0f 85 92 00 00 00    	jne    26b0 <gzram_decode_avx2+0x120>
    261e:	41 0f b7 d9          	movzx  ebx,r9w
    2622:	89 d8                	mov    eax,ebx
    2624:	48 8b 5c 24 30       	mov    rbx,QWORD PTR [rsp+0x30]
    2629:	48 83 c4 48          	add    rsp,0x48
    262d:	c3                   	ret
    262e:	66 90                	xchg   ax,ax
    2630:	4d 85 db             	test   r11,r11
    2633:	74 63                	je     2698 <gzram_decode_avx2+0x108>
    2635:	41 0f b7 d9          	movzx  ebx,r9w
    2639:	83 f8 01             	cmp    eax,0x1
    263c:	75 42                	jne    2680 <gzram_decode_avx2+0xf0>
    263e:	48 8d 05 0b 37 00 00 	lea    rax,[rip+0x370b]        # 5d50 <gzram_ctz_decode_scalar>
    2645:	48 39 05 74 59 01 00 	cmp    QWORD PTR [rip+0x15974],rax        # 17fc0 <_DYNAMIC+0x1c8>
    264c:	0f 84 7e 00 00 00    	je     26d0 <gzram_decode_avx2+0x140>
    2652:	48 83 c7 08          	add    rdi,0x8
    2656:	4c 89 d9             	mov    rcx,r11
    2659:	4c 89 c2             	mov    rdx,r8
    265c:	4c 89 d6             	mov    rsi,r10
    265f:	e8 dc 40 00 00       	call   6740 <gzram_ctz_decode>
    2664:	39 d8                	cmp    eax,ebx
    2666:	b8 ff ff ff ff       	mov    eax,0xffffffff
    266b:	0f 45 d8             	cmovne ebx,eax
    266e:	89 d8                	mov    eax,ebx
    2670:	48 8b 5c 24 30       	mov    rbx,QWORD PTR [rsp+0x30]
    2675:	48 83 c4 48          	add    rsp,0x48
    2679:	c3                   	ret
    267a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    2680:	8d 56 f8             	lea    edx,[rsi-0x8]
    2683:	48 83 c7 08          	add    rdi,0x8
    2687:	89 d9                	mov    ecx,ebx
    2689:	4c 89 c6             	mov    rsi,r8
    268c:	e8 bf 8c 00 00       	call   b350 <LZ4_decompress_safe>
    2691:	eb d1                	jmp    2664 <gzram_decode_avx2+0xd4>
    2693:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
    2698:	bb ff ff ff ff       	mov    ebx,0xffffffff
    269d:	89 d8                	mov    eax,ebx
    269f:	48 8b 5c 24 30       	mov    rbx,QWORD PTR [rsp+0x30]
    26a4:	48 83 c4 48          	add    rsp,0x48
    26a8:	c3                   	ret
    26a9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    26b0:	48 8d 77 08          	lea    rsi,[rdi+0x8]
    26b4:	4c 89 da             	mov    rdx,r11
    26b7:	4c 89 c7             	mov    rdi,r8
    26ba:	44 89 4c 24 0c       	mov    DWORD PTR [rsp+0xc],r9d
    26bf:	e8 0c dc ff ff       	call   2d0 <memcpy@plt>
    26c4:	44 8b 4c 24 0c       	mov    r9d,DWORD PTR [rsp+0xc]
    26c9:	e9 50 ff ff ff       	jmp    261e <gzram_decode_avx2+0x8e>
    26ce:	66 90                	xchg   ax,ax
    26d0:	49 83 fa 08          	cmp    r10,0x8
    26d4:	0f 86 78 ff ff ff    	jbe    2652 <gzram_decode_avx2+0xc2>
    26da:	81 7f 08 47 5a 52 31 	cmp    DWORD PTR [rdi+0x8],0x31525a47
    26e1:	0f 85 6b ff ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    26e7:	80 7f 0e 0c          	cmp    BYTE PTR [rdi+0xe],0xc
    26eb:	0f 85 61 ff ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    26f1:	80 7f 0f 00          	cmp    BYTE PTR [rdi+0xf],0x0
    26f5:	0f 85 57 ff ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    26fb:	0f b7 47 0c          	movzx  eax,WORD PTR [rdi+0xc]
    26ff:	49 39 c3             	cmp    r11,rax
    2702:	0f 85 4a ff ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    2708:	0f b6 47 10          	movzx  eax,BYTE PTR [rdi+0x10]
    270c:	3c 05                	cmp    al,0x5
    270e:	0f 84 67 01 00 00    	je     287b <gzram_decode_avx2+0x2eb>
    2714:	0f 87 31 01 00 00    	ja     284b <gzram_decode_avx2+0x2bb>
    271a:	3c 02                	cmp    al,0x2
    271c:	0f 84 81 01 00 00    	je     28a3 <gzram_decode_avx2+0x313>
    2722:	3c 03                	cmp    al,0x3
    2724:	0f 85 28 ff ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    272a:	49 83 fb 07          	cmp    r11,0x7
    272e:	0f 86 1e ff ff ff    	jbe    2652 <gzram_decode_avx2+0xc2>
    2734:	41 80 e1 07          	and    r9b,0x7
    2738:	0f 85 14 ff ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    273e:	b8 07 00 00 00       	mov    eax,0x7
    2743:	49 83 fa 11          	cmp    r10,0x11
    2747:	0f 85 05 ff ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    274d:	48 8b 57 11          	mov    rdx,QWORD PTR [rdi+0x11]
    2751:	48 89 54 24 10       	mov    QWORD PTR [rsp+0x10],rdx
    2756:	89 c2                	mov    edx,eax
    2758:	83 e2 08             	and    edx,0x8
    275b:	48 8b 54 17 11       	mov    rdx,QWORD PTR [rdi+rdx*1+0x11]
    2760:	48 89 54 24 18       	mov    QWORD PTR [rsp+0x18],rdx
    2765:	89 c2                	mov    edx,eax
    2767:	83 e0 18             	and    eax,0x18
    276a:	83 e2 10             	and    edx,0x10
    276d:	48 8b 44 07 11       	mov    rax,QWORD PTR [rdi+rax*1+0x11]
    2772:	48 8b 54 17 11       	mov    rdx,QWORD PTR [rdi+rdx*1+0x11]
    2777:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
    277c:	48 89 54 24 20       	mov    QWORD PTR [rsp+0x20],rdx
    2781:	49 83 fb 1f          	cmp    r11,0x1f
    2785:	0f 86 5c 01 00 00    	jbe    28e7 <gzram_decode_avx2+0x357>
    278b:	49 8d 4b e0          	lea    rcx,[r11-0x20]
    278f:	4c 89 74 24 38       	mov    QWORD PTR [rsp+0x38],r14
    2794:	48 8b 44 24 10       	mov    rax,QWORD PTR [rsp+0x10]
    2799:	4c 89 c2             	mov    rdx,r8
    279c:	49 89 ce             	mov    r14,rcx
    279f:	4c 8b 54 24 18       	mov    r10,QWORD PTR [rsp+0x18]
    27a4:	48 83 e1 e0          	and    rcx,0xffffffffffffffe0
    27a8:	4c 8b 4c 24 20       	mov    r9,QWORD PTR [rsp+0x20]
    27ad:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
    27b2:	4c 89 7c 24 40       	mov    QWORD PTR [rsp+0x40],r15
    27b7:	49 89 cf             	mov    r15,rcx
    27ba:	49 8d 4c 08 20       	lea    rcx,[r8+rcx*1+0x20]
    27bf:	48 89 02             	mov    QWORD PTR [rdx],rax
    27c2:	48 83 c2 20          	add    rdx,0x20
    27c6:	4c 89 52 e8          	mov    QWORD PTR [rdx-0x18],r10
    27ca:	4c 89 4a f0          	mov    QWORD PTR [rdx-0x10],r9
    27ce:	48 89 72 f8          	mov    QWORD PTR [rdx-0x8],rsi
    27d2:	48 39 ca             	cmp    rdx,rcx
    27d5:	75 e8                	jne    27bf <gzram_decode_avx2+0x22f>
    27d7:	4c 89 f0             	mov    rax,r14
    27da:	4c 89 f2             	mov    rdx,r14
    27dd:	4c 8b 74 24 38       	mov    r14,QWORD PTR [rsp+0x38]
    27e2:	4c 29 fa             	sub    rdx,r15
    27e5:	48 83 e0 e0          	and    rax,0xffffffffffffffe0
    27e9:	4c 8b 7c 24 40       	mov    r15,QWORD PTR [rsp+0x40]
    27ee:	48 83 c0 20          	add    rax,0x20
    27f2:	48 83 fa 07          	cmp    rdx,0x7
    27f6:	76 3e                	jbe    2836 <gzram_decode_avx2+0x2a6>
    27f8:	49 8d 4b f8          	lea    rcx,[r11-0x8]
    27fc:	48 8d 50 08          	lea    rdx,[rax+0x8]
    2800:	48 29 c1             	sub    rcx,rax
    2803:	49 89 d2             	mov    r10,rdx
    2806:	48 89 ce             	mov    rsi,rcx
    2809:	48 83 e6 f8          	and    rsi,0xfffffffffffffff8
    280d:	48 01 d6             	add    rsi,rdx
    2810:	eb 04                	jmp    2816 <gzram_decode_avx2+0x286>
    2812:	48 83 c2 08          	add    rdx,0x8
    2816:	49 89 c1             	mov    r9,rax
    2819:	41 83 e1 18          	and    r9d,0x18
    281d:	4e 8b 4c 0c 10       	mov    r9,QWORD PTR [rsp+r9*1+0x10]
    2822:	4d 89 0c 00          	mov    QWORD PTR [r8+rax*1],r9
    2826:	48 89 d0             	mov    rax,rdx
    2829:	48 39 d6             	cmp    rsi,rdx
    282c:	75 e4                	jne    2812 <gzram_decode_avx2+0x282>
    282e:	48 83 e1 f8          	and    rcx,0xfffffffffffffff8
    2832:	4a 8d 04 11          	lea    rax,[rcx+r10*1]
    2836:	49 39 c3             	cmp    r11,rax
    2839:	0f 84 e3 fd ff ff    	je     2622 <gzram_decode_avx2+0x92>
    283f:	8b 57 11             	mov    edx,DWORD PTR [rdi+0x11]
    2842:	41 89 14 00          	mov    DWORD PTR [r8+rax*1],edx
    2846:	e9 d7 fd ff ff       	jmp    2622 <gzram_decode_avx2+0x92>
    284b:	3c 06                	cmp    al,0x6
    284d:	0f 85 ff fd ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    2853:	49 83 fb 1f          	cmp    r11,0x1f
    2857:	0f 86 f5 fd ff ff    	jbe    2652 <gzram_decode_avx2+0xc2>
    285d:	41 80 e1 1f          	and    r9b,0x1f
    2861:	0f 85 eb fd ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    2867:	b8 1f 00 00 00       	mov    eax,0x1f
    286c:	49 83 fa 29          	cmp    r10,0x29
    2870:	0f 84 d7 fe ff ff    	je     274d <gzram_decode_avx2+0x1bd>
    2876:	e9 d7 fd ff ff       	jmp    2652 <gzram_decode_avx2+0xc2>
    287b:	49 83 fb 0f          	cmp    r11,0xf
    287f:	0f 86 cd fd ff ff    	jbe    2652 <gzram_decode_avx2+0xc2>
    2885:	41 80 e1 0f          	and    r9b,0xf
    2889:	0f 85 c3 fd ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    288f:	b8 0f 00 00 00       	mov    eax,0xf
    2894:	49 83 fa 19          	cmp    r10,0x19
    2898:	0f 84 af fe ff ff    	je     274d <gzram_decode_avx2+0x1bd>
    289e:	e9 af fd ff ff       	jmp    2652 <gzram_decode_avx2+0xc2>
    28a3:	49 83 fb 03          	cmp    r11,0x3
    28a7:	0f 86 a5 fd ff ff    	jbe    2652 <gzram_decode_avx2+0xc2>
    28ad:	41 80 e1 03          	and    r9b,0x3
    28b1:	0f 85 9b fd ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    28b7:	49 83 fa 0d          	cmp    r10,0xd
    28bb:	0f 85 91 fd ff ff    	jne    2652 <gzram_decode_avx2+0xc2>
    28c1:	8b 57 11             	mov    edx,DWORD PTR [rdi+0x11]
    28c4:	48 89 d0             	mov    rax,rdx
    28c7:	48 c1 e0 20          	shl    rax,0x20
    28cb:	48 01 d0             	add    rax,rdx
    28ce:	48 89 44 24 10       	mov    QWORD PTR [rsp+0x10],rax
    28d3:	48 89 44 24 18       	mov    QWORD PTR [rsp+0x18],rax
    28d8:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
    28dd:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
    28e2:	e9 9a fe ff ff       	jmp    2781 <gzram_decode_avx2+0x1f1>
    28e7:	4c 89 da             	mov    rdx,r11
    28ea:	31 c0                	xor    eax,eax
    28ec:	e9 01 ff ff ff       	jmp    27f2 <gzram_decode_avx2+0x262>

Disassembly of section .fini:
