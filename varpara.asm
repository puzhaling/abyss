%define  CRLF  0DH,0AH
%include "io.mac"

.DATA
  prompt_msg  db  "Please input a set of nonzero integers.",CRLF
              db  "You must enter at least one integer.",CRLF
              db  "Enter zero to terminate the input.",0
  sum_msg     db  "The sum of the input numbers is: ",0

.CODE
  .STARTUP
  PutStr    prompt_msg
  nwln
  sub       ecx,ecx
read_number:
  GetLInt   eax
  cmp       eax,0
  je        stop_reading
  push      eax
  inc       ecx
  jmp       read_number
stop_reading:
  push      ecx
  call      variable_sum
  ; clear parameter space on the stack
  inc       ecx         ; increment ecx to include count
  add       ecx,ecx     ; ecx = ecx * 4 (space in bytes)
  add       ecx,ecx
  add       esp,ecx

  PutStr    sum_msg
  PutLInt   eax
  nwln
done:
  .EXIT


variable_sum:
  enter     0,0
  push      ebx
  push      ecx

  mov       ecx,[ebp+8]
  mov       ebx,ebp
  add       ebx,12
  sub       eax,eax
add_loop:
  add       eax,[ss:ebx]
  add       ebx,4
  loop      add_loop

  pop       ecx
  pop       ebx
  leave
  ret
