%include "../io.mac"

SORTED    EQU     0
UNSORTED  EQU     1

.CODE
global    bubble_sort
bubble_sort:
    pushad
    mov   EBP,ESP
    mov   ECX, [EBP+40]

next_pass:
    dec   ECX
    jz    sort_done
    mov   EDI,ECX
    
    mov   DL,SORTED
    
    mov   ESI,[EBP+36]
pass:
    mov   EAX,[ESI]
    mov   EBX,[ESI+4]
    cmp   EAX,EBX
    jg    swap

increment:
    add   ESI,4
    dec   EDI
    jnz   pass

    cmp   EDX,SORTED
    je    sort_done
    jmp   next_pass

swap:
    mov   [ESI+4],EAX
    mov   [ESI],EBX
    mov   EDX,UNSORTED
    jmp   increment

sort_done:
    popad
    ret   8

