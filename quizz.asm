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
    ; Load num1 and num2 into AL and AH
    mov     al, byte[num1]
    mov     ah, byte[num2]

    ; Add num1 and num2 and store the result in sum
    add     ax, word[num2]
    mov     word[sum], ax

    ; Load num3 into AL
    mov     al, byte[num3]

    ; Perform division (quotient = sum / num3)
    xor     ah, ah              ; Clear AH to ensure AX is treated as 16-bit
    div     al                  ; Divide AX by AL
    mov     byte[quotient], al

    ; Calculate the remainder (remainder = sum % num3)
    xor     ah, ah              ; Clear AH again
    div     al                  ; Divide AX by AL
    mov     byte[remainder], al

    ; Exit the program
    mov     rax, 60             ; syscall number for exit
    xor     rdi, rdi            ; exit status = 0
    syscall
