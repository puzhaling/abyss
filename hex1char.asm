%include "io.mac"

.DATA
    char_prompt  db  "Please input a character: ",0
    out_msg1     db  "The ASCII code of '",0
    out_msg2     db  "' in hex is ",0
    query_msg    db  "Do you want to quit (Y/N): ",0

.CODE
    .STARTUP
read_char:
    PutStr    char_prompt
    GetCh     AL

    PutStr    out_msg1
    PutCh     AL
    PutStr    out_msg2
    mov       AH,AL
    shr       AL,4
    mov       CX,2

print_digit:
    cmp       AL,9
    jg        A_to_F
    add       AL,'0'
    jmp       skip

A_to_F:
    add       AL,'A'-10

skip:
    PutCh     AL
    mov       AL,AH
    and       AL,0FH
    loop      print_digit
    nwln
    PutStr    query_msg
    GetCh     AL

    cmp       AL,'Y'
    jne       read_char

done:
    .EXIT
