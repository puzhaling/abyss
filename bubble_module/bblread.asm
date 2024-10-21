%include "../io.mac"

.CODE
global  read_array

read_array:
    push    EDX
    push    EBX
    sub     EDX,EDX
read_loop:
    GetLInt EAX
    cmp     EAX,0
    je      read_done
    mov     [EBX],EAX
    add     EBX,4
    inc     EDX
    loop    read_loop
read_done:
    mov     EAX,EDX
    pop     EBX
    pop     EDX
    ret
