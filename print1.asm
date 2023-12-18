section .data
string db "1 + 2 + 3 +...+ 99 = ", 0
sum dw 0
ascii db "0000", 10, 0

section .text
global _start

_start:
    ; Initialize cx register
    xor cx, cx ; Clear cx
    inc cx      ; Set cx to 1

    ; Calculate 1+2+3+...+99
sum_loop:
    add [sum], cx ; sum += cx
    inc cx        ; cx++
    cmp cx, 100   ; compare cx with 100
    jb sum_loop   ; if(cx<100) goto sum_loop

    ; Convert sum to ASCII
    lea rcx, [ascii+3] ; Point rcx to the end of the ascii buffer
    mov ax, [sum]      ; ax = sum
convert_loop:
    xor dx, dx    ; Clear dx
    mov bx, 10    ; bx = 10
    div bx        ; dx = (dx:ax) % 10, ax = (dx:ax) / 10
    add dl, '0'   ; Convert to ASCII
    mov [rcx], dl ; Store the ASCII character
    dec rcx       ; Move to the previous position
    test ax, ax   ; Check if ax is zero
    jnz convert_loop ; If not, continue loop

    ; Output the string
    mov rax, 1   ; SYS_write
    mov rdi, 1   ; STDOUT
    mov rsi, string ; address of string
    mov rdx, 21  ; length of string
    syscall

    ; Output the ASCII representation
    mov rax, 1   ; SYS_write
    mov rdi, 1   ; STDOUT
    mov rsi, ascii ; address of ascii
    mov rdx, 6   ; length of ascii (including newline)
    syscall

    ; Exit the program
    mov rax, 60  ; terminate executing process
    mov rdi, 0   ; exit status
    syscall

