section .data
msg1 db "Input a number (1~9): ", 0
msg2 db " is a multiple of ", 0
num_format db "3", 10, 0 ; Since we only check for multiples of 3

section .bss
buffer resb 2 ; Buffer for user input (1 digit + newline)
count resb 1 ; Counter for the number of inputs

section .text
global _start

_start:
    mov byte [count], 0 ; Initialize counter to 0

input_loop:
    ; Clear buffer
    mov word [buffer], 0

    ; Output request message to the user
    mov rax, 1
    mov rdi, 1 ; STDOUT
    mov rsi, msg1
    mov rdx, 24 ; Length of msg1
    syscall

    ; Read user input
    mov rax, 0
    mov rdi, 0 ; STDIN
    mov rsi, buffer
    mov rdx, 2 ; Read 2 bytes (digit + newline)
    syscall

    ; Check if input is a multiple of 3
    movzx rax, byte [buffer]
    sub al, '0' ; Convert ASCII to integer
    test al, al ; Check for zero (invalid input)
    jz input_done
    mov ah, 0
    mov bl, 3
    div bl ; Divide by 3
    test ah, ah ; Check remainder
    jnz input_done

    ; It's a multiple of 3, output the digit and message
    mov rax, 1 ; syscall number for write
    mov rdi, 1 ; STDOUT
    mov rsi, buffer ; digit to output
    mov rdx, 1 ; output one digit
    syscall

    mov rax, 1 ; syscall number for write
    mov rdi, 1 ; STDOUT
    mov rsi, msg2 ; message to output
    mov rdx, 18 ; length of msg2
    syscall

    mov rax, 1 ; syscall number for write
    mov rdi, 1 ; STDOUT
    mov rsi, num_format ; number to output
    mov rdx, 2 ; length of number and newline
    syscall

    inc byte [count] ; increment the counter

input_done:
    cmp byte [count], 9
    jae exit_program ; if 9 or more inputs, exit

    jmp input_loop ; otherwise, continue loop

exit_program:
    ; Exit the program
    mov rax, 60 ; syscall number for exit
    xor rdi, rdi ; status code 0
    syscall

