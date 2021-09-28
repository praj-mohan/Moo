.cpu cortex-a72
.fpu neon-fp-armv8

.data
test: .asciz "%d\n"
.text
.align 2
.global modifyfile
.type modifyfile, %function


modifyfile:
    push {fp, lr}    
    add fp, sp, #4

    mov r10, r0 @ r10 = array
    mov r7, r5 @ stores size of file into r7
    
    @ makes r1 = to 7502 (1/5 of 37510 and roughly 0.2 seconds)
    mov r1, #100
    mov r2, #75
    mul r1, r1, r2
    add r1, r1, #2



    sub r6, r7, r1 @ r6 = 37546 - 7502
   
    @ makes r8 = 32767
    mov r8, #128
    mov r2, #2
    mul r8, r8, r8
    mul r8, r8, r2
    sub r8, r8, #1



 
loop:
    cmp r6, #44 @ checks if the array is near the contents of the header, leaves if condition is true.
    ble exit


    @ loads the file content from the prior 0.2 second
    mov r0, #4
    mul r0, r0, r6
    add r0, r0, r10  @ r0 = 4i + sp
    ldr r3, [r0]


    @ loads the file content from the current place
    mov r0, #4
    mul r0, r0, r7
    add r0, r0, r10  @ r0 = 4i + sp
    ldr r2, [r0]

    @ adds both file values together into r3  
    add r3, r3, r2

    @ checks if the value exceeds 32767, goes to replacevalue if condition is true
    cmp r3, r8
    bgt replacevalue

    @ stores the value in the current place
    mov r0, #4
    mul r0, r0, r7
    add r0, r0, r10  @ r0 = 4i + sp
    str r3, [r0]  

    @ decrements to the next 0.2 second and the the 0.2 second before that 
    sub r7, r7, #1 
    sub r6, r6, #1

    b loop
        


replacevalue:
    @ stores 32767 into the current place
    mov r0, #4
    mul r0, r0, r7
    add r0, r0, r10  @ r0 = 4i + sp
    str r8, [r0]

    @ decrements to the next 0.2 second and the the 0.2 second before that 
    sub r7, r7, #1 
    sub r6, r6, #1

    b loop  




exit: 
   sub sp, fp, #4
    pop {fp, pc}

