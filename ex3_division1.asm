section .data
    num1      dq 50000000000   ; num1 = 50,000,000,000
    num2      dd 3333333       ; num2 = 3,333,333
    quotient  dd 0             ; quotient = 0
    remainder dd 0             ; remainder = 0

section .text
global _start

_start:
    mov     rax, [num1]       ; Load num1 into rax
    mov     rdx, 0            ; Clear rdx for the division
    mov     rcx, [num2]       ; Load num2 into rcx
    div     rcx               ; Divide rax by rcx; quotient in rax, remainder in rdx

    mov     [quotient], eax   ; Store the quotient in quotient
    mov     [remainder], edx  ; Store the remainder in remainder

    ; Exit the program
    mov     rax, 60           ; syscall number for exit
    xor     rdi, rdi          ; Exit status 0
    syscall
