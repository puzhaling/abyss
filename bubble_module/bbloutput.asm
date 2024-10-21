%include "../io.mac"

.CODE
global    output_array

output_array:
    push    EBX
    push    ECX
print_loop:
    PutLInt [EBX]
    nwln
    add     EBX,4
    loop    print_loop
    pop     ECX
    pop     EBX
    ret
