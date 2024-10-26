; Multiplies two 32-bit signed integers

%include "io.mac"

.DATA
prompt_msg  db  "Enter two integers: ",0
output_msg  db  "The product = ",0
oflow_msg   db  "Sorry! Result out of range.",0
query_msg   db  "Do you want to quit? (Y/N): ",0

.CODE
    .STARTUP
read_input:
    PutStr    prompt_msg
    GetLInt   eax
    GetLInt   ebx
    imul      ebx
    jo        overflow
    PutStr    output_msg
    PutLInt   eax
    nwln
    jmp       short user_query
overflow:
    PutStr    oflow_msg
    nwln
user_query:
    PutStr    query_msg
    GetCh     al
    cmp       al,'Y'
    jne       read_input
done:
    .EXIT

