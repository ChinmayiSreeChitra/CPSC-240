section .data
num db -12, 23, 34, -45, 57, 67, -78, 89, 99, 125
m3n5 resb 10
newline db 0xA  ; Newline character

section .text
global _start
_start:
    ; Initialize registers
    mov rsi, 0   ; rsi = 0
    mov rdi, 0   ; rdi = 0
    mov rcx, 10  ; rcx = 10

doloop:
    ; Load num[rsi] into al
    mov al, byte[num + rsi]

    ; Check if num[rsi] is a multiple of 3 and not a multiple of 5
    movzx rax, al      ; Clear upper bits
    imul rax, rax, 77  ; rax = num[rsi] * 77
    sar rax, 6         ; Shift rax to the right by 6 bits (signed divide by 64)

    cmp rax, 0          ; Check if the result is 0
    jnz not_m3n5        ; If not zero, not a multiple of 3, or multiple of 5

    ; Copy num[rsi] to m3n5[rdi]
    mov al, byte[num + rsi]
    mov byte[m3n5 + rdi], al
    inc rdi             ; rdi = rdi + 1

not_m3n5:
    inc rsi             ; rsi = rsi + 1
    loop doloop         ; Decrement rcx and loop if rcx != 0

    ; Print the result values of num
    mov rsi, num
    mov rdx, 10  ; Number of elements to print (size of num array)
print_num_loop:
    mov rax, 0x1  ; Write syscall
    mov rdi, 0x1  ; File descriptor for stdout
    mov rax, 0x1  ; sys_write
    syscall

    add rsi, 1    ; Move to the next element in num
    dec rdx       ; Decrement the counter
    jnz print_num_loop

    ; Print a newline character
    mov rax, 0x1
    mov rdi, 0x1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Print the result values of m3n5
    mov rsi, m3n5
    mov rdx, 10  ; Number of elements to print (size of m3n5 array)
print_m3n5_loop:
    mov rax, 0x1
    mov rdi, 0x1
    mov rax, 0x1
    syscall

    add rsi, 1
    dec rdx
    jnz print_m3n5_loop

    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall
