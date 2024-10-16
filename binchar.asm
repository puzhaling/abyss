%include "io.mac"

.DATA
  char_prompt  db  "Please input a character: ", 0
  out_msg1     db  "The ASCII code of '", 0
  out_msg2     db  "' in binary is ", 0
  query_msg    db  "Do you want to quit (Y/N): ", 0

.CODE
    .STARTUP
read_char:
    PutStr  char_prompt
    GetCh   AL
    PutStr  out_msg1
    PutCh   AL
    PutStr  out_msg2
    mov     AH, 80H
    mov     CX, 8

print_bit:
    test    AL, AH
    jz      print_0
    PutCh   '1'
    jmp     skip1

print_0:
    PutCh   '0'

skip1:
    shr     AH, 1

    loop print_bit
    nwln
    PutStr  query_msg
    GetCh   AL
    cmp     AL, 'Y'
    jne     read_char

done:
    .EXIT
