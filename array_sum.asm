%include "io.mac"

.DATA
    test_marks    dd    90,50,70,94,81,40,67,55,60,73
    ; ^^^^ $ points to the byte after the array storage space
    NO_STUDENTS   equ   ($-test_marks)/4    ; number of students
    sum_msg       db    "The sum of test marks is: ",0

.CODE
    .STARTUP
    mov     cx,NO_STUDENTS
    sub     eax,eax
    sub     esi,esi
add_loop:
    mov     ebx,[test_marks+esi*4]
    PutLInt ebx
    nwln
    add     eax,[test_marks+esi*4]
    inc     esi
    loop    add_loop

    PutStr  sum_msg
    PutLInt eax
    nwln
    .EXIT
