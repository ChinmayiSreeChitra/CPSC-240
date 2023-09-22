section .data
    num1 dd 300000      ; num1 = 300,000
    num2 dd 400000      ; num2 = 400,000
    product dq 0        ; product = 0 (64-bit)

section .text
global _start

_start:
    mov rax, [num1]     ; Load num1 into rax
    mov rcx, [num2]     ; Load num2 into rcx
    imul rax, rcx       ; Multiply rax by rcx
    mov [product], rax  ; Store the result in product

    ; Exit the program
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; exit status 0
    syscall
