.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

#define A 2
#define B 3
#define C 4

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
    str_kernel_start: .asciz "kernel started!\n"
    str_result: .asciz "Result: "
.section .text
__kernel_reset__:
    ldr r0, =str_kernel_start       @ load data from memory
    bl dbgput_line                  @ print data
    
    @ calculate
    ldr r0, =A          @ a
    ldr r1, =B          @ b
    ldr r2, =C          @ c
    bl func4            @ call func
    
    @ saving result in r4 (print funcs change r0-r3)
    mov r4, r0
    
    @ msg: result
    ldr r0, =str_result
    bl dbgput
    mov r0, r4
    bl dbgput_num

    
    end:
    b end

func4:
    mul r3, r0, r1      @ a * b, result in r3
    
    cmp r3, #10         @ comparing result with 10
    ITE GE
    orrge r3, r0, r1    @ a | b, result in r3
    andlt r3, r0, r1    @ a & b, result in r3
    
    mul r0, r3, r2      @ r3 * c, result in r0
    bx lr               @ exit from func

