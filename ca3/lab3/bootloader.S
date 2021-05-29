.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

@ bootload must be visible in start.S
.global bootload

.section .rodata
    @ labels for locating image with kernel program
    image: .incbin "kernel.bin" @ saving kernel file into memory
    end_of_image:               @ label on next word after image
    
    @ strings for checking
    str_boot_start: .asciz "bootloader started"
    str_boot_end: .asciz "bootloader end"
    str_boot_indicate: .asciz "#"
bootload:
    @ msg: bootloader started
    ldr r0, =str_boot_start
    bl dbgput_line
    
    @ loading info about image
    ldr r0, =end_of_image   @
    ldr r1, =image          @
    ldr r2, =_ram_start     @
    
    @ copy kernel program from memory to RAM
    load_loop:
        ldm r1!, {r3-r4}
        stm r2!, {r3-r4}
        cmp r0, r1
        bhi load_loop
    
    @ msg: bootloader ended
    bl newline
    ldr r0, =str_boot_end
    bl dbgput_line
    
    @ save address of bootload_end+1 to lr 
    ldr lr, bootload_end
    add lr, #1              @ why +1 ????
    
    @ loading program first command
    ldr r2, =_ram_start
    add r2, #4              @ add 4 to address (__reset_kernel__, second word))
    ldr r0, [r2]            @ load command (__reset_kernel__)
    bx r0                   @ jump
    
    bootload_end:
    b bootload_end
