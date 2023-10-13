section .data
    array db 12, 1003, 6543, 24680, 789, 30123, 32766
    even db 0, 0, 0, 0, 0, 0, 0
    rsi dq 0
    rdi dq 0
    format db "Even numbers: %d, %d, %d, %d, %d, %d, %d", 10, 0  ; Format string for printf

section .text
global main
extern printf

main:
    mov rsi, 0           ; Initialize rsi to 0 (rsi is used as an index for array)
    mov rdi, 0           ; Initialize rdi to 0 (rdi is used as an index for even)

loop_start:
    movzx ax, byte [array + rsi]  ; Load the value from array[rsi] into ax (zero-extend)
    test ax, 1           ; Test if the value is odd (lowest bit set)
    jnz skip_even        ; If it's odd, skip storing in the even array

    ; Store the even value in even[rdi]
    mov [even + rdi], ax
    inc rdi              ; Increment rdi (even array index)

skip_even:
    inc rsi              ; Increment rsi (array index)
    cmp rsi, 7           ; Compare rsi with 7 (the size of the array)
    jl loop_start        ; If rsi is less than 7, continue the loop

    ; Prepare arguments for printf
    lea rdi, [format]     ; Load the address of the format string
    lea rsi, [even]       ; Load the address of the even array
    mov rax, 0            ; Clear RAX for vararg terminator
    call printf           ; Call the printf function

    ; Exit the program
    mov rax, 60          ; syscall: exit
    xor rdi, rdi         ; status: 0
    syscall
