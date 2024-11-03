%include "io.mac"

;--------------------------------------------------
;PutInt8 procedure displays a signed 8-bit integer
;in the AL register. All registers are preserved.
;--------------------------------------------------
PutInt8:
    enter 3,0
    push  ax
    push  bx
    push  esi
    test  al,80h      ; negative number?
    jz    positive
negative:
    PutCh '-'
    neg   al
repeat1:
    sub   ah,ah
    div   bl
    add   ah,'0'
    mov   [ebp+esi-3],ah
    inc   esi
    cmp   al,0
    jne   repeat1
display_digit:
    dec   esi
    mov   al,[ebp+esi-3]
    PutCh al
    jnz   display_digit
display_done:
    pop   esi
    pop   bx
    pop   ax
    leave
    ret

