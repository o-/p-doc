	.file	"proto.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"entering method %p\n"
.LC1:
	.string	"local %d is: %p\n"
.LC2:
	.string	"return from %p\n"
	.text
	.p2align 4,,15
.globl mth
	.type	mth, @function
mth:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	movq	%r13, -16(%rbp)
	movq	%r14, -8(%rbp)
	movq	%rdi, %r13
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	movq	%rbx, -32(%rbp)
	movq	%r12, -24(%rbp)
	subq	$32, %rsp
	testq	%rsi, %rsi
	movq	%rsi, %r14
	je	.L13
	.cfi_offset 12, -40
	.cfi_offset 3, -48
	movq	%rdi, %rsi
	xorl	%eax, %eax
	movl	$.LC0, %edi
	call	printf
	movq	0(%r13), %rax
	leaq	8(%r13), %rbx
	leaq	30(,%rax,8), %rax
	andq	$-16, %rax
	subq	%rax, %rsp
	movq	8(%r13), %rax
	leaq	15(%rsp), %r12
	andq	$-16, %r12
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L3:
	movq	8(%rbx), %rsi
	movl	$.LC1, %edi
	xorl	%eax, %eax
	addq	$16, %rbx
	movq	(%r12,%rsi,8), %rdx
	call	printf
	movq	(%rbx), %rax
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L4:
	movq	8(%rbx), %rax
	movq	16(%rbx), %rdx
	addq	$24, %rbx
	movq	(%r12,%rax,8), %rdi
	leaq	(%r12,%rdx,8), %rsi
	call	mth
	movq	(%rbx), %rax
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L5:
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	addq	$24, %rbx
	movq	(%r12,%rdx,8), %rdx
	movq	%rdx, (%r12,%rax,8)
	movq	(%rbx), %rax
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L6:
	movq	16(%rbx), %rdx
	movq	8(%rbx), %rax
	addq	$24, %rbx
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, (%r12,%rax,8)
	movq	(%rbx), %rax
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L7:
	movq	%r13, %rsi
	movl	$.LC2, %edi
	xorl	%eax, %eax
	call	printf
.L1:
	movq	-32(%rbp), %rbx
	movq	-24(%rbp), %r12
	movq	-16(%rbp), %r13
	movq	-8(%rbp), %r14
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L13:
	.cfi_restore_state
	movq	$.L3, print(%rip)
	movq	$.L4, call_method(%rip)
	movq	$.L5, move_local(%rip)
	movq	$.L6, load_arg(%rip)
	movq	$.L7, return_(%rip)
	jmp	.L1
	.cfi_endproc
.LFE11:
	.size	mth, .-mth
	.p2align 4,,15
.globl main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	xorl	%esi, %esi
	xorl	%edi, %edi
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	movq	%rbx, -32(%rbp)
	movq	%r12, -24(%rbp)
	movq	%r13, -16(%rbp)
	movq	%r14, -8(%rbp)
	subq	$32, %rsp
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	.cfi_offset 3, -48
	call	mth
	movl	$168, %edi
	call	malloc
	movq	load_arg(%rip), %r13
	movq	print(%rip), %r12
	movq	%rax, %rbx
	movq	$1, 16(%rax)
	movq	$0, 24(%rax)
	movl	$88, %edi
	movq	$0, 40(%rax)
	movq	$1, 48(%rax)
	movq	%r13, 8(%rax)
	movq	%r13, 32(%rax)
	movq	%r12, 56(%rax)
	movq	%r12, 72(%rax)
	movq	$0, 64(%rax)
	movq	$1, 80(%rax)
	movq	return_(%rip), %r14
	movq	$2, (%rax)
	movq	call_method(%rip), %rax
	movq	$0, 96(%rbx)
	movq	$1, 104(%rbx)
	movq	%r14, 112(%rbx)
	movq	%rax, 88(%rbx)
	call	malloc
	subq	$32, %rsp
	movq	%r13, 8(%rax)
	movq	%r12, 32(%rax)
	leaq	15(%rsp), %rsi
	movq	%r14, 48(%rax)
	movq	$1, (%rax)
	movq	$0, 16(%rax)
	movq	$0, 24(%rax)
	movq	%rbx, %rdi
	andq	$-16, %rsi
	movq	$0, 40(%rax)
	movq	%rax, 8(%rsi)
	movq	$2, (%rsi)
	call	mth
	movq	-32(%rbp), %rbx
	movq	-24(%rbp), %r12
	movq	-16(%rbp), %r13
	movq	-8(%rbp), %r14
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.comm	print,8,16
	.comm	call_method,8,16
	.comm	move_local,8,16
	.comm	load_arg,8,16
	.comm	return_,8,16
	.ident	"GCC: (Debian 4.5.2-8) 4.5.2"
	.section	.note.GNU-stack,"",@progbits
