section .bss
num1 resb 1
num2 resb 1
quotient resb 1
remainder resb 1
input resb 3 ; Enough to store one digit and a newline

section .data
prompt1 db "Input 1st number (0-9): ", 0
prompt2 db "Input 2nd number (1-9): ", 0
result_quotient db "quotient = ", 0
result_remainder db "remainder = ", 10, 0 ; Include a newline at the end

section .text
global _start

_start:
    ; Prompt for the first number
    mov rsi, prompt1
    call print_string
    call get_digit
    mov [num1], al

    ; Prompt for the second number
    mov rsi, prompt2
    call print_string
    call get_digit
    mov [num2], al

    ; Check if num2 is zero to avoid division by zero
    cmp byte [num2], 0
    je exit

    ; Perform division
    mov al, [num1]
    mov bl, [num2]
    xor ah, ah
    div bl
    mov [quotient], al
    mov [remainder], ah

    ; Print the quotient
    mov rsi, result_quotient
    call print_string
    mov al, [quotient]
    call print_digit

    ; Print the remainder
    mov rsi, result_remainder
    call print_string
    mov al, [remainder]
    call print_digit

exit:
    ; Exit the program
    mov rax, 60 ; sys_exit
    xor rdi, rdi
    syscall

; Prints a null-terminated string pointed to by RSI
print_string:
    mov rax, 1 ; sys_write
    mov rdi, 1 ; file descriptor (stdout)
    mov rdx, 0 ; string length counter
.count_string:
    cmp byte [rsi + rdx], 0
    je .done
    inc rdx
    jmp .count_string
.done:
    syscall
    ret

; Reads a single digit from the user, returns it in AL
get_digit:
    mov rax, 0 ; sys_read
    mov rdi, 0 ; file descriptor (stdin)
    mov rsi, input ; buffer to store the input
    mov rdx, 2 ; number of bytes to read (digit + newline)
    syscall
    ; Convert ASCII to digit
    movzx rax, byte [input]
    sub al, '0'
    ret

; Prints a single digit pointed to by AL
print_digit:
    add al, '0' ; Convert digit to ASCII
    mov [input], al ; Store ASCII character in buffer
    mov rax, 1 ; sys_write
    mov rdi, 1 ; file descriptor (stdout)
    mov rsi, input ; buffer to print from
    mov rdx, 1 ; number of bytes to write
    syscall
    ret

