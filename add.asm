section .data
    num1 dw 50000      ; num1 = 50000 (C350h in hexadecimal)
    num2 dw 40000      ; num2 = 40000 (9C40h in hexadecimal)
    sum dd 0           ; Initialize sum to 0 (32-bit)

section .text
global _start

_start:
    mov ax, word [num1]  ; Load num1 into AX (16-bit)
    mov bx, word [num2]  ; Load num2 into BX (16-bit)
    add ax, bx           ; Add num1 and num2, result in AX

    ; Zero-extend AX to a 32-bit value in EAX
    movzx eax, ax        ; Zero-extend AX to EAX

    mov [sum], eax       ; Store the result in sum

    mov rax, 60          ; Exit syscall number
    xor rdi, rdi         ; Exit status (0)
    syscall              ; Call the system to terminate the process
