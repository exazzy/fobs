.section .init
.global _init
.type _init, @function

_init:
	push %ebp
	movl %esp, %ebp
