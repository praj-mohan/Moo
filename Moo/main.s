.cpu cortex-a72
.fpu neon-fp-armv8

.data
filename: .asciz "cow.wav" @ the source file
finalfile:.asciz "echo.wav" @ the file where the echo would be stored
rwIOw:    .asciz "wb" @ writes the file
rwIOr:    .asciz "rb" @reads the file
sum: .asciz "size: %d\n" @tells the user the size of the file

.text
.align 2
.global main
.type main, %function

main:
    push {fp, lr}    
    add fp, sp, #4
     

    @ opens the cow.wav file  to read it and stores it into r4
    ldr r0, =filename 
    ldr r1, =rwIOr
    bl fopen   
    mov r4, r0 

    @ moves the file and #4 into parameters  and calls reader function
    mov r0, r4
    mov r1, #4
    bl reader
    
    @ closes cow.wav file 
    mov r5, r0
    mov r0, r4
    bl fclose


    @ tells the user the total size of the file
    add r5, r5, #8 @ r5 = filesize + 8 (since the result is off by 8)
    @ prints the results
    ldr r0, =sum 
    mov r1, r5
    bl printf 

testingarray:
  @ initializes an array to the size of the file
  mov r1, #4
  mul r5, r5, r1
  sub sp, sp, r5 @ sp = sp - filesize
  mov r6, #0 @ i = 0
  

  @ restores r5 to the original datasize number
  mov r3, #4
 UDIV r5, r5, r3
b loop

loop:

@ stores the value 1 in all array locations
  
  cmp r6, r5 @ checks if r6 < r5
  bge loopexit @ exits the loop if the condition isn't true

  mov r0, #4 @ r0 = 4   
  mov r1, #1 @ r1 = 1
  mul r0, r6, r0 @ r0  = r10 * 4
  add r0, sp, r0  @ sp + (4 * r10)
  str r1, [r0] @ stores the value 1 into the array location
  add r6, r6, #1 @ r10 is incremented by 1
  b loop



loopexit:


    @ opens cow.wav file to read it and stores it into r4
    ldr r0, =filename 
    ldr r1, =rwIOr
    bl fopen   
    mov r4, r0


    @calls array function and sends array and file as parameters
    mov r0, sp
    mov r1, r4
    bl array

    @closes cow.wav file
    mov r0, r4
    bl fclose   

   
    @ calls modifyfile function and sends array as a parameter
    mov r0, sp
    bl modifyfile

   
    @ opens the echo.wav file to write it and stores it into r4
    ldr r0, =finalfile 
    ldr r1, =rwIOw
    bl fopen
    mov r4, r0

    @ calls copyfile function and passes array and file as parameters
    mov r0, sp 
    mov r1, r4
    bl copyfile  

    @ closes echo.wav file
    mov r0, r4
    bl fclose






exit:

    sub sp, fp, #4
    pop {fp, pc}

