;Parameter passing via registers
;
;           Objective: To show parameter passing via registers.
;               Input: Requests two integers from the user.
;              Output: Outputs the sum of the input integers.

%include "io.mac"

.DATA
    prompt_msg1    DB    "Please input the first number: ",0
    prompt_msg2    DB    "Please input the second number: ",0
    sum_msg        DB    "The sum is ",0

.CODE
    .STARTUP
    PutStr    prompt_msg1
    GetInt    CX

    PutStr    prompt_msg2
    GetInt    DX

    call      sum
    PutStr    sum_msg
    PutInt    AX
    nwln

done:
    .EXIT


;-----------------------------------------------------
;Procedure sum receives two integers in CX and DX.
;The sum of the two integers is returned in AX.
;----------------------------------------------------
sum:
    mov       AX,CX
    add       AX,DX
    ret
