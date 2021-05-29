.global lab1
.syntax unified

// Variant 8124%5=4

#define A 4
#define B 2
#define C 3

lab1:
    push {lr}           @ saving lr in stack
    ldr r0, =A          @ a
    ldr r1, =B          @ b
    ldr r2, =C          @ c
    bl func4            @ call func
    pop {pc}            @ restoring lr and exit from lab1 

func4:
    mul r3, r0, r1      @ a * b, result in r3
    
    cmp r3, #10         @ comparing result with 10
    ITE GE
    orrge r3, r0, r1    @ a | b, result in r3
    andlt r3, r0, r1    @ a & b, result in r3
    
    mul r0, r3, r2      @ r3 * c, result in r0
    bx lr               @ exit from func

func1:
    sub r0, r1          @ a-b
    mov r3, #3
    mul r0, r3          @ r0*3
    
    mov r3, #1
    add r0, lsl r3, r2  @ r0 + 2^r2
    bx lr
