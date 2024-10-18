;Parameter passing via registers
;
;             Objective: To show parameter passing via registers.
;                 Input: Requests a character string from the user.
;                Output: Outputs the length of the input string.

%include "io.mac"

BUF_LEN           EQU   41

.DATA
    prompt_msg    db    "Please input a string: ",0
    lenght_msg    db    "The string length is ",0

.UDATA
    string        resb  BUF_LEN

.CODE
    .STARTUP
    PutStr    prompt_msg
    GetStr    string,BUF_LEN

    mov       EBX,string
    call      str_len
    PutStr    lenght_msg
    PutInt    AX
    nwln

done:
    .EXIT


;----------------------------------------------------------
;Procedure str_len receives a pointer to a string in BX.
;String length is returned in AX.
;----------------------------------------------------------
str_len:
    push      EBX
    sub       AX,AX

repeat:
    cmp       byte [EBX],0
    je        str_len_done
    inc       AX
    inc       EBX
    jmp       repeat

str_len_done:
    pop       EBX
    ret









