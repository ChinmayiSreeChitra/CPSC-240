section .data
    num dw 225
    mul_15 dw 0     ; mul_15 = 0
    other dw 0      ; other = 0

section .text
global _start

_start:
    mov ax, word[num]   ; ax = num
    mov bl, 3           ; bl = 3
    div bl              ; ah = ax % bl, al = ax / bl
    cmp ah, 0           ; compare ah, 0
    jne else            ; if (ax % 3 != 0) goto else

    mov ax, word[num]   ; ax = num
    mov bl, 5           ; bl = 5
    div bl              ; ah = ax % bl, al = ax / bl
    cmp ah, 0           ; compare ah, 0
    jne else            ; if (ax % 5 != 0) goto else

    inc word[mul_15]    ; mul_15 = mul_15 + 1
    jmp end_if          ; goto end_if

else:
    inc word[other]     ; other = other + 1

end_if:
    mov rax, 60         ; terminate executing process
    mov rdi, 0          ; exit status
    syscall

