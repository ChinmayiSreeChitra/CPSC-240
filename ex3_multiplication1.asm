section .data
    num1 dd 300000        ; num1 = 300,000
    num2 dd 400000        ; num2 = 400,000
    product dq 0          ; product = 0 (64-bit)

section .text
global _start

_start:
    mov eax, [num1]      ; Load num1 into eax
    mul dword [num2]     ; Multiply eax by num2 (32-bit multiplication)
    mov [product], rax   ; Store the 64-bit result in product

    ; Exit the program
    mov eax, 60          ; syscall number for exit
    xor edi, edi         ; exit status 0
    syscall
