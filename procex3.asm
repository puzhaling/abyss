;Parameter passing via registers
;
;             Objective: To show parameter passing via the stack.
;                 Input: Requests two integers from the user.
;                Output: Outputs the sum of the input integers.

%include "io.mac"

.DATA
    prompt_msg1    db    "Please input the first number: ",0
    prompt_msg2    db    "Please input the second number: ",0
    sum_msg        db    "The sum is ",0

.CODE
    .STARTUP
    PutStr    prompt_msg1
    GetInt    CX

    PutStr    prompt_msg2
    GetInt    DX

    push      CX
    push      DX
    call      sum
    PutStr    sum_msg
    PutInt    AX
    nwln

done:
    .EXIT


;----------------------------------------------------------
;Procedure sum receives two integers via the stack.
;The sum of two integers is returned in AX.
;----------------------------------------------------------
sum:
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









