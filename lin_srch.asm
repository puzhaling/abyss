%include "io.mac"

MAX_SIZE    EQU   20

.DATA
input_prompt    db    "Please enter input values "
                db    "(a negative number terminates input):",0
query_number    db    "Enter the number to be searched: ",0
out_msg         db    "The number is at position ",0
not_found_msg   db    "Number not in the array!",0
query_msg       db    "Do you want to quit (Y/N): ",0


.UDATA
array           resw  MAX_SIZE

.CODE
      .STARTUP
      PutStr    input_prompt
      xor       esi,esi       ; index = 0
      mov       ecx,MAX_SIZE
array_loop:
      GetInt    ax
      cmp       ax,0
      jl        read_input
      mov       [array+esi*2],ax
      inc       esi
      loop      array_loop
read_input:
      PutStr    query_number
      GetInt    ax            ; push number, size & array pointer
      push      ax
      push      esi
      push      array
      call      linear_search
      ; linear search returns in ax the position of the number
      ; in the array; if not found, it returns 0.
      cmp       ax,0
      je        not_found
      PutStr    out_msg
      PutInt    ax
      jmp       SHORT user_query
not_found:
      PutStr    not_found_msg
user_query:
      nwln
      PutStr    query_msg
      GetCh     al
      cmp       al,'Y'
      jne       read_input
done:
      .EXIT





linear_search:
      enter     0,0
      push      ebx
      push      ecx
      mov       ebx,[ebp+8]       ; copy array pointer
      mov       ecx,[ebp+12]      ; copy array size
      mov       ax,[ebp+16]       ; copy number to be searched
      sub       ebx,2
enter_loop:
      add       ebx,2
      cmp       ax,[ebx]
      loopne    search_loop
      mov       ax,0
      jne       number_not_found
      mov       eax,[ebp+12]      ; copy array size
      sub       eax,ecx           ; compute array index of number
number_not_found:
      pop       ecx
      pop       ebx
      leave     
      ret       10
