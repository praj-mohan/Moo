.cpu cortex-a72
.fpu neon-fp-armv8

.data
.text
.align 2
.global copyfile
.type copyfile, %function


copyfile:
    push {fp, lr}
    add fp, sp, #4


    mov r10, r0 @r10 = array
    mov r9, r1 @r9 = file
 
    mov r7, r5 @r7 = file size
    mov r6, #0 @ i = 0



 
loop:
    cmp r6, r7  @ checks if all the values have been transferred into file, exits if condition is true
    bge exit
 
  
    @ loads the value from array
    mov r0, #4 @r0 = 4
    mul r0, r0, r6 @ r0 = 4 * i 
    add r0, r0, r10  @ r0 = 4i + sp
    ldr r8, [r0] @ r1 is given the value of the array location


    @ puts the array value into the file
    mov r0, r8 @ r0 = value
    mov r1, r9 @ r1 = file
    bl fputc
    
    
     @ i++
    add r6, r6, #1
    b loop

exit:
    sub sp, fp, #4
    pop {fp, pc}

    