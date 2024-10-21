%define   CRLF    0DH,0AH
MAX_SIZE  EQU     20
%include "../io.mac"
.DATA
    prompt_msg    db    "Enter nonzero integers to be sorted.",CRLF
                  db    "Enter zero to terminate the input.",0
    output_msg    db    "Input numbers in ascending order:",0
    error_msg     db    "No input entered.",0

.UDATA
    array         resd  MAX_SIZE

.CODE
extern    bubble_sort
extern    read_array
extern    output_array

    .STARTUP
    PutStr    prompt_msg
    nwln
    mov       EBX,array
    mov       ECX,MAX_SIZE
    call      read_array

    cmp       EAX,0
    ja        input_OK
    PutStr    error_msg
    nwln
    jmp       short done
input_OK:
    push      EAX
    push      array
    call      bubble_sort

    PutStr    output_msg
    nwln
    mov       EBX,array
    mov       ECX,EAX
    call      output_array
done:
    .EXIT
