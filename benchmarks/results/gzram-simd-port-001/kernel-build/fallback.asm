
/home/dan/n100-zram/build/astra-simd-kernel-002/fallback.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <header-0x10>:
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop

0000000000000010 <header>:
  10:	e8 00 00 00 00       	call   15 <header+0x5>
  15:	c7 07 47 48 59 31    	movl   $0x31594847,(%rdi)
  1b:	66 89 77 04          	mov    %si,0x4(%rdi)
  1f:	88 57 06             	mov    %dl,0x6(%rdi)
  22:	c6 47 07 00          	movb   $0x0,0x7(%rdi)
  26:	e9 00 00 00 00       	jmp    2b <header+0x1b>
  2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

0000000000000040 <n100_lz4_fallback>:
  40:	f3 0f 1e fa          	endbr64
  44:	e8 00 00 00 00       	call   49 <n100_lz4_fallback+0x9>
  49:	48 83 ec 30          	sub    $0x30,%rsp
  4d:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
  52:	48 8d 59 f8          	lea    -0x8(%rcx),%rbx
  56:	b9 20 10 00 00       	mov    $0x1020,%ecx
  5b:	48 39 cb             	cmp    %rcx,%rbx
  5e:	4c 89 64 24 18       	mov    %r12,0x18(%rsp)
  63:	49 89 d4             	mov    %rdx,%r12
  66:	89 f2                	mov    %esi,%edx
  68:	48 0f 46 cb          	cmovbe %rbx,%rcx
  6c:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
  71:	48 89 f5             	mov    %rsi,%rbp
  74:	49 8d 74 24 08       	lea    0x8(%r12),%rsi
  79:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
  7e:	49 89 fd             	mov    %rdi,%r13
  81:	e8 00 00 00 00       	call   86 <n100_lz4_fallback+0x46>
  86:	48 63 d0             	movslq %eax,%rdx
  89:	48 39 ea             	cmp    %rbp,%rdx
  8c:	73 04                	jae    92 <n100_lz4_fallback+0x52>
  8e:	85 c0                	test   %eax,%eax
  90:	7f 44                	jg     d6 <n100_lz4_fallback+0x96>
  92:	31 c0                	xor    %eax,%eax
  94:	48 39 eb             	cmp    %rbp,%rbx
  97:	72 20                	jb     b9 <n100_lz4_fallback+0x79>
  99:	4c 89 ee             	mov    %r13,%rsi
  9c:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  a1:	48 89 ea             	mov    %rbp,%rdx
  a4:	e8 00 00 00 00       	call   a9 <n100_lz4_fallback+0x69>
  a9:	31 d2                	xor    %edx,%edx
  ab:	48 89 ee             	mov    %rbp,%rsi
  ae:	4c 89 e7             	mov    %r12,%rdi
  b1:	e8 5a ff ff ff       	call   10 <header>
  b6:	8d 45 08             	lea    0x8(%rbp),%eax
  b9:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
  be:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
  c3:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
  c8:	4c 8b 6c 24 20       	mov    0x20(%rsp),%r13
  cd:	48 83 c4 30          	add    $0x30,%rsp
  d1:	e9 00 00 00 00       	jmp    d6 <n100_lz4_fallback+0x96>
  d6:	ba 02 00 00 00       	mov    $0x2,%edx
  db:	48 89 ee             	mov    %rbp,%rsi
  de:	4c 89 e7             	mov    %r12,%rdi
  e1:	89 44 24 04          	mov    %eax,0x4(%rsp)
  e5:	e8 26 ff ff ff       	call   10 <header>
  ea:	8b 44 24 04          	mov    0x4(%rsp),%eax
  ee:	83 c0 08             	add    $0x8,%eax
  f1:	eb c6                	jmp    b9 <n100_lz4_fallback+0x79>
