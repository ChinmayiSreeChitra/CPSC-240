section .data
msg db 'Enter the equation: ', 0

section .bss
equation resb 100

section .text
global _start

_start:
    ; display the prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 18
    int 0x80
    
    ; read the equation from the user
    mov eax, 3
    mov ebx, 0
    mov ecx, equation
    mov edx, 100
    int 0x80
    
    ; initialize the variables
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    mov esi, equation

parse_loop:
    ; parse the operand
    mov al, byte [esi]
    cmp al, 0
    je calculate
    
    sub al, '0'
    cmp al, 0
    jl parse_operator
    cmp al, 9
    jg parse_operator
    
    mov ebx, eax
    mov eax, edx
    imul eax, 10
    add eax, ebx
    add eax, al
    
    inc esi
    jmp parse_loop
    
parse_operator:
    ; parse the operator
    mov cl, byte [esi]
    cmp cl, 0
    je calculate
    
    inc esi
    
    ; parse the next operand
    mov al, byte [esi]
    sub al, '0'
    cmp al, 0
    jl parse_operator
    cmp al, 9
    jg parse_operator
    
    mov ebx, eax
    mov eax, edx
    imul eax, 10
    add eax, ebx
    
    ; perform the calculation
    cmp cl, '+'
    je add_op
    cmp cl, '-'
    je sub_op
    cmp cl, '*'
    je mul_op
    cmp cl, '/'
    je div_op
    
add_op:
    add edx, eax
    jmp parse_loop
    
sub_op:
    sub edx, eax
    jmp parse_loop
    
mul_op:
    imul edx, eax
    jmp parse_loop
    
div_op:
    idiv eax, edx
    mov edx, 0
    jmp parse_loop
    
calculate:
    ; display the result
    mov eax, 4
    mov ebx, 1
    mov ecx, equation
    mov edx, 100
    int 0x80
    
    ; exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
