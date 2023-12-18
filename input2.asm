section .data
msg1 db "Input a number (1~9): ", 0
msg2 db " is a multiple of ", 0
newline db 10 ; Newline character
numbers db "123456789", 0 ; String of numbers for reference

section .bss
buffer resb 2 ; 2 bytes for buffer (1 for char, 1 for newline)
ascii resb 10 ; 10 bytes for ascii array

section .text
global _start

_start:
    mov r10, 0 ; Initialize counter to 0

; Input loop
input_loop:
    ; Print input message
    mov rax, 1 ; System call number for sys_write
    mov rdi, 1 ; File descriptor 1 is stdout
    mov rsi, msg1 ; Pointer to message
    mov rdx, 23 ; Length of message
    syscall

    ; Read character from user
    mov rax, 0 ; System call number for sys_read
    mov rdi, 0 ; File descriptor 0 is stdin
    mov rsi, buffer ; Pointer to buffer
    mov rdx, 2 ; Read two bytes (char + newline)
    syscall

    ; Store character in ascii array
    movzx rax, byte [buffer] ; Zero-extend byte to qword
    mov [ascii + r10], al
    inc r10
    cmp r10, 9
    jl input_loop

; Processing and Output loop
    mov r10, 0
output_loop:
    ; Load character from ascii array
    movzx rax, byte [ascii + r10]
    sub al, '0' ; Convert ASCII to integer

    ; Check if number is a multiple of 3
    cmp al, 0 ; Skip if number is 0
    je not_a_multiple
    mov ah, 0 ; Clear ah before division
    mov bl, 3
    div bl ; Divide ax by 3, result in al, remainder in ah
    cmp ah, 0
    jne not_a_multiple

    ; Print the number
    mov rax, 1
    lea rsi, [numbers + r10] ; Address of the current number in 'numbers'
    mov rdx, 1 ; Print one character
    syscall

    ; Print message
    mov rax, 1
    mov rsi, msg2
    mov rdx, 18 ; Length of message
    syscall

    ; Print the number again
    mov rax, 1
    lea rsi, [numbers + r10] ; Address of the current number in 'numbers'
    mov rdx, 1 ; Print one character
    syscall

    ; Print a newline
    mov rax, 1
    mov rsi, newline
    mov rdx, 1
    syscall

not_a_multiple:
    inc r10
    cmp r10, 9
    jl output_loop

; Exit the program
    mov rax, 60 ; System call for exit
    xor rdi, rdi ; Return 0 status
    syscall

