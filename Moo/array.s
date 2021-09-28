.cpu cortex-a72
.fpu neon-fp-armv8

.data


.text
.align 2
.global array
.type array, %function



array:

    push {fp, lr}    
    add fp, sp, #4


    mov r10, r1 @ r10 = file
    mov r9, r0 @ r9 = array
    mov r6, #0 @ r6 = 0
   
    @ gets the first value of the file stores it into r8
    mov r0, r10 
    bl fgetc   
    mov r8, r0

    @ makes r7 the value of EOF
    mov r7, #0
    sub r7, r7, #1


loop: 
   @ checks if the loop has reached EOF of the cow.wav file. Leaves if the condition is true
    cmp r8, r7
    beq exit     


    @ transfers the file contents into the array
    mov r0, #4 @ r0 = 4   
    mov r1, r8 @ r1 = 1
    mul r0, r0, r6 @ r0  = r6 * 4
    add r0, r0, r9  @ sp + (4 * r6)
    str r1, [r0] @ stores the value from vile into the array location
    add r6, r6, #1 @ increments r6
 
   @ gets the next value of the file stores it into r8
    mov r0, r10
    bl fgetc   
    mov r8, r0

    b loop

exit:
    sub sp, fp, #4
    pop {fp, pc}






