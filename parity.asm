section .data
    array dw 12, 1003, 6543, 24680, 789, 30123, 32766   ; Use 'dw' to specify 16-bit values
    even dw 0, 0, 0, 0, 0, 0, 0
    format db "Even numbers: %d, %d, %d, %d, %d, %d, %d", 10, 0

section .text
global main
extern printf

main:
    mov rsi, 0
    mov rdi, 0

loop_start:
    mov ax, [array + rsi] ; Load a 16-bit value
    test ax, 1
    jnz skip_even

    mov [even + rdi], ax
    inc rdi

skip_even:
    inc rsi
    cmp rsi, 14
    jl loop_start

    lea rdi, [format]
    lea rsi, [even]
    xor rax, rax
    call printf

    mov rax, 60
    xor rdi, rdi
    syscall
