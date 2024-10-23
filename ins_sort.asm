; Sorting an array by insertion sort

%include "io.mac"

.DATA
  MAX_SIZE      equ   100
  input_prompt  db    "Please enter input array: "
                db    "(negative number terminates input)",0
  out_msg       db    "The sorted array is:",0

.UDATA
  array         resd  MAX_SIZE

.CODE
      .STARTUP
      PutStr    input_prompt
      mov       ebx,array
      mov       ecx,MAX_SIZE 
 array_loop:
      GetLInt   eax
      cmp       eax,0
      jl        exit_loop
      mov       [ebx],eax
      add       ebx,4
      loop      array_loop
 exit_loop:
      mov       edx,ebx     ; edx keeps the actual array size
      sub       edx,array
      shr       edx,2
      push      edx
      push      array
      call      insertion_sort
      PutStr    out_msg
      nwln
      mov       ecx,edx
      mov       ebx,array
 display_loop:
      PutLInt   [ebx]
      nwln
      add       ebx,4
      loop      display_loop
 done:
      .EXIT


;---------------------------------------------------------------
; This procedure receives a pointer to an array of integers
; and the array size in edx registers via the stack. The array
; is sorted by using insertion sort. All registers are preserved
;---------------------------------------------------------------
%define   SORT_ARRAY    ebx
insertion_sort:
      pushad
      mov       ebp,esp                 ; save local variables
      mov       ebx,[ebp+36]            ; array pointer
      mov       ecx,[ebp+40]            ; array size
      mov       esi,4                   ; array left of esi is sorted
for_loop:
      ; variables of the algorithm are mapped as follows.
      ; edx = temp, esi = i and edi = j
      mov       edx,[SORT_ARRAY+esi]    ; temp
      mov       edi,esi                 ; j = i-1
      sub       edi,4
while_loop:
      cmp       edx,[SORT_ARRAY+edi]    ; temp < array[j]
      jge       exit_while_loop
      ; array[j+1] = array[j]
      mov       eax,[SORT_ARRAY+edi]
      mov       [SORT_ARRAY+edi+4],eax
      sub       edi,4                   ; j = i-1
      cmp       edi,0                   ; j >= 0
      jge       while_loop
exit_while_loop:
      ; array[j+1] = temp
      mov       [SORT_ARRAY+edi+4],edx
      add       esi,4
      dec       ecx
      cmp       ecx,1                   ; if ecx = 1, we are done
      jne       for_loop
sort_done:
      popad
      ret       8





