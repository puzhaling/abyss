%include "io.mac"

.DATA
    number_prompt  db   "Please type a number (<11 digits): ",0
    out_msg        db   "The sum of individual digits is: ",0

.UDATA
    number         resb 11

.CODE
    .STARTUP
    PutStr  number_prompt
    GetStr  number,11

    mov     EBX,number
    sub     DX,DX

repeat_add:
    mov     AL,[EBX]
    cmp     AL,0
    je      done
    and     AL,0FH      ; mask off the upper 4 bits
    add     DL,AL
    inc     EBX
    jmp     repeat_add

done:
    PutStr  out_msg
    PutInt  DX          ; write sum
    nwln
    .EXIT

