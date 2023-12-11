; Define the memory layout
section .data
num1 db 0 ; First operand
num2 db 0 ; Second operand
result db 0 ; Result
operator db 0 ; Operator symbol

; Define the code
section .text
global _start

_start:
    ; Get the first operand
    mov eax, 0 ; System call number for read
    mov ebx, num1 ; Buffer address
    mov ecx, 1 ; Buffer size
    syscall

    ; Get the operator symbol
    mov eax, 0 ; System call number for read
    mov ebx, operator ; Buffer address
    mov ecx, 1 ; Buffer size
    syscall

    ; Get the second operand
    mov eax, 0 ; System call number for read
    mov ebx, num2 ; Buffer address
    mov ecx, 1 ; Buffer size
    syscall

    ; Perform the operation
    cmp byte[operator], '+'
    je addition

    cmp byte[operator], '-'
    je subtraction

    cmp byte[operator], '*'
    je multiplication

    cmp byte[operator], '/'
    je division

    ; Invalid operator
    jmp exit

addition:
    add num1, num2
    mov result, num1
    jmp exit

subtraction:
    sub num1, num2
    mov result, num1
    jmp exit

multiplication:
    mul num1, num2
    mov result, num1
    jmp exit

division:
    xor dx, dx
    div num2
    mov result, al
    jmp exit

exit:
    ; Display the result
    mov eax, 4 ; System call number for write
    mov ebx, 1 ; File descriptor for stdout
    mov ecx, result ; Buffer address
    mov edx, 1 ; Buffer size
    syscall

    ; Terminate the program
    mov eax, 1 ; System call number for exit
    mov ebx, 0 ; Exit code
    syscall
