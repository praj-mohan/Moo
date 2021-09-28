.cpu cortex-a72
.fpu neon-fp-armv8

.data
filename: .asciz "cow.wav"
rwtext:   .asciz "rb"
test: .asciz "%d\n"

.text
.align 2
.global reader
.type reader, %function

reader:
    push {fp, lr}
    add fp, sp, #4

    mov r10, r0  @r10 = r0 
    mov r9, r1   @r9 = 4 (skip number)


    @ passes the file, skip number, and start location to the fseek function
    mov r0, r10  
    mov r1, r9
    mov r2, #0
    bl fseek

    mov r8, #0  @ i = 0;
    mov r7, #0  @ sum = 0;

loop:
    @ i < 4
    cmp r8, #4   
    bge exit      

    @ gets the value of the first sets of data from the file
    mov r0, r10
    bl fgetc   @ stores results in r0

    

    @ r1 = r8 * 8
    mov r1, #8
    mul r1, r8, r1  @ r1 = factor

    mov r1, r0, LSL r1   @ temp*factor

    add r7, r7, r1 @ sum 

    add r8, r8, #1 @ i++;

    b loop

exit:

    mov r0, r7  @ returns the sum

    sub sp, fp, #4
    pop {fp, pc}

    