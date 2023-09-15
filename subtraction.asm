section .data
    num1 dw 50000      ; num1 = 50000 (C350h in hexadecimal)
    num2 dw 40000      ; num2 = 40000 (9C40h in hexadecimal)
    dif dw 0           ; Initialize dif to 0 (16-bit)

section .text
global _start

_start:
    mov ax, word [num1] ; Load num1 into AX (16-bit)
    sub ax, word [num2] ; Subtract num2 from AX (16-bit)
    mov [dif], ax       ; Store the result in dif

    mov rax, 60         ; Exit syscall number
    xor rdi, rdi        ; Exit status (0)
    syscall             ; Call the system to terminate the process
