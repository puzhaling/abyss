%include "io.mac"

MAX_SIZE    EQU   20

.DATA
input_prompt    db    "Enter at most 20 nonzero values "
                db    "(entering zero terminates input):",0
out_msg         db    "The array contents are: ",0
empty_msg       db    "The array is empty. ",0
query_msg       db    "Do you want to quit (Y/N): ",0

.UDATA
array           resd  MAX_SIZE

.CODE
      .STARTUP
read_input:
      PutStr    input_prompt
      xor       esi,esi       ; esi = 0 (esi is used as an index)
      mov       ecx,MAX_SIZE
read_loop:
      GetLInt   eax
      mov       [array+esi*4],eax
      inc       esi
      cmp       eax,0
      loopne    read_loop
exit_loop:
      jnz       skip
      dec       esi           ; dec esi to keep the array size
skip:
      mov       ecx,esi
      jecxz     empty_array
      xor       esi,esi
      PutStr    out_msg
write_loop:
      PutLInt   [array+esi*4]
      nwln
      inc       esi
      loop      write_loop
      jmp       short user_query
empty_array:
      PutStr    empty_msg
      nwln
user_query:
      PutStr    query_msg
      GetCh     al
      cmp       al,'Y'
      jne       read_input
done:
      .EXIT
