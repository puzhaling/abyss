%include "../io.mac"

.CODE
global string_length
string_length:
    ; all registers except AX are preserved
    push  ESI
    mov   ESI,EBX
repeat:
    cmp   byte [ESI],0
    je    done
    inc   ESI
    jmp   repeat
done:
    sub   ESI,EBX
    mov   AX,SI
    pop   ESI
    ret
