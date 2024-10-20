;Parameter passing via the stack
;
;           Objective: To show paramater passing via the stack.
;               Input: Requests a character string from the user.
;              Output: Outputs the input string with the first
;                      two characters swapped.

BUF_LEN   EQU   41
%include "io.mac"

.DATA
    prompt_msg    db    "Please input a string: ",0
    output_msg    db    "The swapped string is: ",0

.UDATA
    string        resb  BUF_LEN

.CODE
    .STARTUP
    PutStr    prompt_msg
    GetStr    string,BUF_LEN

    mov       EAX,string
    push      EAX
    inc       EAX
    push      EAX
    call      swap
    PutStr    output_msg
    PutStr    string
    nwln
done:
    .EXIT

;-------------------------------------------------------------
;Procedure swap receives two pointers (via the stack) to
;characters of a string. It exchanges these two characters.
;-------------------------------------------------------------
swap:
    enter     0,0
    push      EBX
    mov       EBX,[EBP+12]
    xchg      AL,[EBX]
    mov       EBX,[EBP+8]
    xchg      AL,[EBX]
    mov       EBX,[EBP+12]
    xchg      AL,[EBX]
    ;swap ends here
    pop       EBX
    leave
    ret       8
                       
