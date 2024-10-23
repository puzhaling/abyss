%include "io.mac"

.DATA
MAX_SIZE      equ   100
input_prompt  db    "Please enter input array (in sorted order): "
              db    "(negative number terminates input)",0
query_number  db    "Enter the number to be searched: ",0
out_msg       db    "The number is at position ",0
not_found_msg db    "Number is not in the array!",0
query_msg     db    "Do you want to quit (Y/N): ",0

.UDATA
array         resw  MAX_SIZE

.CODE
      .STARTUP
      PutStr  input_prompt
      nwln
      sub     esi,esi
      mov     cx,MAX_SIZE
array_loop:
      GetInt  ax
      cmp     ax,0
      jl      exit_loop
      mov     [array+esi*2],ax
      inc     esi
      loop    array_loop
exit_loop:
read_input:
      PutStr  query_number
      GetInt  ax
      push    ax
      push    si
      push    array
      call    binary_search
      ; binary search returns in ax the position of the number
      ; in the array; if not found, it returns 0.
      cmp     ax,0
      je      not_found
      PutStr  out_msg
      PutInt  ax
      jmp     user_query
not_found:
      PutStr  not_found_msg
user_query:
      nwln
      PutStr  query_msg
      GetCh   al
      cmp     al,'Y'
      jne     read_input
done:
      .EXIT




binary_search:
      ; push ebp
      ; mov  ebp,esp
      ; sub  esp,0
      enter   0,0
      push    ebx
      push    esi
      push    cx
      push    dx
      mov     ebx,[ebp+8]     ; copy array pointer
      mov     cx,[ebp+12]     ; copy array size
      mov     dx,[ebp+14]     ; copy number to be searched
      xor     ax,ax           ; lower = 0
      dec     cx              ; upper = size-1
while_loop:
      cmp     ax,cx           ; lower > upper?
      ja      end_while
      sub     esi,esi
      mov     si,ax           ; middle = (lower + upper)/2
      add     si,cx
      shr     si,1
      cmp     dx,[ebx+esi*2]  ; number = array[middle]
      je      search_done
      jg      upper_half
lower_half:
      dec     si              ; middle = middle - 1
      mov     cx,si           ; upper = middle - 1
      jmp     while_loop
upper_half:
      inc     si              ; middle = middle + 1
      mov     ax,si           ; lower = middle + 1
      jmp     while_loop
end_while:
      sub     ax,ax           ; number not found
      jmp     skip1
search_done:  
      inc     si              ; position = index + 1
      mov     ax,si           ; return position
skip1:
      pop     dx
      pop     cx
      pop     esi
      pop     ebx
      leave
      ret     8               ; release space used by passed parametres






      
