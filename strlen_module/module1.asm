BUF_SIZE  EQU  41
%include "../io.mac"

.DATA
  prompt_msg  db   "Please input a string: ",0
  length_msg  db   "String length is: ",0

.UDATA
  string1     resb BUF_SIZE

.CODE
extern  string_length
    .STARTUP
    PutStr  prompt_msg
    GetStr  string1,BUF_SIZE

    mov     EBX,string1
    call    string_length
    PutStr  length_msg
    PutInt  AX
    nwln
done:
    .EXIT
