.global lab4
.syntax unified

// Variant 8124%5=4

.section .rodata
    X1: .quad -17
    X2: .quad 12
    X3: .quad 17
    X4: .quad 3
    rs: .quad 0
.section .text
lab4:
    push {lr}           @ saving lr in stack
    bl task1
    bl task2
    pop {pc}

task1:
    push {lr}           @ saving lr in stack
    ldr r0, =X1          @ X1
    ldm r0, {r1-r2}
    
    ldr r0, =X2          @ X2
    ldm r0, {r3-r4}
    
    ldr r0, =X3          @ X3
    ldm r0, {r5-r6}
    
    @ X2/2
    ASRS r4, #1
    LSR r3, #1
    ldr r0, =0x80000000
    IT CS
    ORRCS r3, r0
    
    @X1 OR X2/2
    ORR r2, r4
    ORR r1, r3
    
    @/8
    ASRS r2, #1
    LSR r1, #1
    IT CS
    ORRCS r1, r0
    
    ASRS r2, #1
    LSR r1, #1
    IT CS
    ORRCS r1, r0
    
    ASRS r2, #1
    LSR r1, #1
    IT CS
    ORRCS r1, r0

    
    
    @NOT X3
    MVN r3, r5
    MVN r4, r6
    
    @XOR 1
    EOR r3, #1
    EOR r4, #0
    
    @*2
    lsls r3, #1
    lsl r4, #1
    adc r4, #0
    
    @-
    SUBS r1, r3
    SBC r2, r4
    
    bl check            @ call func
    pop {pc}            @ restoring lr and exit from lab4

check:
    checkF:
        BVS correction
        BVC choice
    correction:
        LSRS r2, #1
        LSR r1, #1
        LDR r0, =0x80000000
        IT CS
        ORRCS r1, r0
        
        ORR r2, r0    @ save overflow
    choice:
        cmp r1, #0
        BEQ high
        BNE plus
    high:
        @ 8124 -> 0b1111110111100 -> 0b1111(f) 1101(d) 1110(e) 0 --> 0xfde00000
        ldr r0, =0xfde00000
        mov r1, r0
    plus:
        ldr r0, =8124
        add r2, r0
    corr:
        ASRS r2, #1
        LSR r1, #1
        ldr r0, =0x80000000
        IT CS
        ORRCS r1, r0
    save:
        ldr r0, =rs
        stm r0, {r1, r2}
    bx lr               @ exit from func

task2:
    push {lr}           @ saving lr in stack
    
    ldr r0, =5
    ldr r1, =7
    
    bl algo1
    
    pop {pc}

algo1:
    push {lr}
    step1:
        adds r3, r0, r1
    step2:
        adds r3, r0, r1
    step3:
        adds r3, r0, r1
    step4:
        bmi step6
    step5:
        adds r3, r0, r1
    step7:
        adds r3, r0, r1
        b step8
    step6:
        adds r3, r0, r1
    step8:
        @ entrance to the hell (algo2)
        bl algo2
        
        bvs step3
    step9:
        adds r3, r0, r1
    pop {pc}

algo2:
    push {lr}
    
    step10:
        adds r3, r0, r1
        @ entrance to the hell (algo3)
        bl algo3
    step11:
        bne step13
    step12:
        adds r3, r0, r1
    step13:
        bmi step10
    step14:
        adds r3, r0, r1
    step15:
        adds r3, r0, r1
    pop {pc}
    
algo3:
    step17:
        adds r3, r0, r1
    step18:
        adds r3, r0, r1
    
    bx lr
