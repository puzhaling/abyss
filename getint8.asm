%include "io.mac"

;----------------------------------------------------------
;GetInt8 procedure reads an integers from the keyboard and
;stores its equivalent binary in AL register. If the number
;is within -128 and +127 (both inclusive), CF is cleared;
;otherwise, CF is set to indicate out-of-range error.
;No error check is done to se if the input consist of
;digits only. All registers are preserved except for AX.
;----------------------------------------------------------
GetInt8:
      push    bx
      push    cx
      push    dx
      push    esi
      sub     dx,dx
      sub     bx,bx
      GetStr  number,5
      mov     esi,number
get_next_char:
      mov     dl,[esi]
      cmp     dl,'-'
      je      sign
      cmp     dl,'+'
      jne     digit
sign:
      mov     bh,dl
      inc     esi
      jmp     get_next_char
digit:
      sub     ax,ax
      mov     bl,10
      sub     dl,'0'
      mov     al,dl
      mov     cx,2
convert_loop:
      inc     esi
      mov     dl,[esi]
      cmp     dl,0
      je      convert_done
      sub     dl,'0'
      mul     bl
      add     ax,dx
      loop    convert_loop
convert_done:
      cmp     ax,128
      ja      out_of_range
      jb      number_OK
      cmp     bh,'-'
      jne     out_of_range
number_OK:
      cmp     bh,'-'
      jne     number_done
      neg     al
number_done:
      clc
      jmp     done
out_of_range:
      stc
done:
      pop     esi
      pop     dx
      pop     cx
      pop     bx
      ret
      
