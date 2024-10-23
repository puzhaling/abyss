%include "io.mac"

.DATA
NO_ROWS       equ   5
NO_COLUMNS    equ   3
NO_ROW_BYTES  equ   NO_COLUMNS * 2
class_marks   dw    90,89,90
              dw    79,66,70
              dw    70,60,77
              dw    60,55,68
              dw    51,59,57

sum_msg       db    "The sum of the last test marks is: ",0

.CODE
      .STARTUP
      mov     cx,NO_ROWS
      sub     ax,ax
      ; ESI = index of class_marks[0,2]
      sub     ebx,ebx
      mov     esi,NO_COLUMNS-1
sum_loop:
      add     ax,[class_marks+EBX+ESI*2]
      add     ebx,NO_ROW_BYTES
      loop    sum_loop

      PutStr  sum_msg
      PutInt  ax
      nwln
done:
      .EXIT
