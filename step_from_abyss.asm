section .data                   ; Section containing initialized data
    hello db 'Hello, World!', 0 ; Null-terminated string to be printed

section .text                   ; Section containing code
    global _start               ; Entry point for the program

_start:                          ; Program starting point
    ; Write the string to stdout
    mov eax, 4                   ; syscall number for sys_write (Linux)
    mov ebx, 1                   ; file descriptor 1 is stdout
    mov ecx, hello               ; pointer to the string to output
    mov edx, 13                  ; length of the string
    int 0x80                     ; make system call

    ; Exit the program
    mov eax, 1                   ; syscall number for sys_exit (Linux)
    xor ebx, ebx                 ; return 0 status
    int 0x80                     ; make system call
