section .data
    num1       db      195            ; num1 = 0xC3
    num2       db      115            ; num2 = 0x73
    num3       db      23             ; num3 = 0x17
    sum        dw      0              ; sum = 0x0000
    quotient   db      0              ; quotient = 0x00
    remainder  db      0              ; remainder = 0x00

section .text
    global _start

_start:
    ; Load num1 into lower 8 bits of rax and clear the upper 56 bits
    mov     rax, 0
    mov     al, byte[num1]

    ; Set a breakpoint here to view num1
    int3

    ; Load num2 into lower 8 bits of rax and clear the upper 56 bits
    mov     rax, 0
    mov     al, byte[num2]

    ; Set a breakpoint here to view num2
    int3

    ; Add num1 and num2 and store the result in sum
    add     rax, 0
    mov     word[sum], ax

    ; Set a breakpoint here to view sum
    int3

    ; Load num3 into lower 8 bits of rax and clear the upper 56 bits
    mov     rax, 0
    mov     al, byte[num3]

    ; Set a breakpoint here to view num3
    int3

    ; Perform division (quotient = sum / num3)
    xor     rdx, rdx              ; Clear the upper 64 bits of rdx
    div     rax, qword[num3]      ; Divide rax by num3
    mov     byte[quotient], al

    ; Set a breakpoint here to view quotient
    int3

    ; Calculate the remainder (remainder = sum % num3)
    xor     rdx, rdx              ; Clear the upper 64 bits of rdx
    div     rax, qword[num3]      ; Divide rax by num3
    mov     byte[remainder], al

    ; Set a breakpoint here to view remainder

    ; Exit the program
    mov     rax, 60                ; syscall number for exit
    xor     rdi, rdi               ; exit status = 0
    syscall
