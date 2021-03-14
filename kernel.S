.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

#define A #7
#define B #2
#define C #3

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector

vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata

	data: .asciz "kernel started!\n"
	final: .asciz "Result value in register #3	: "
    
.section .text

__kernel_reset__:
	ldr r0, =data
	bl dbgput_line

// calculate
	mov r2, A
	mov r3, B
	mul r3, r2
	mov r4, 10
	cmp r3, r4
	
ITE	GE
	orrGE r3, r2, B
	andLT r3, r2, B
	
	mov r4, C
	mul r3, r4

	ldr r0, =final
	bl dbgput
	mov r0, r3
	bl dbgput_num
    
end:
	b end
