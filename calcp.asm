section .data
    prompt db "Enter equation: ", 0
    result_msg db "Result: ", 0

section .bss
    input resb 256
    result resd 1
    result_str resb 32  ; buffer to store the string representation of the result

section .text
    global _start

_start:
    ; Prompt user for input
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 17
    int 0x80

    ; Read input from user
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 256
    int 0x80

    ; Parse and evaluate the expression
    mov esi, input  ; Set ESI to point to the input buffer
    call parse_expression
    mov [result], eax  ; Store the result in the result variable

    ; Convert the result to a string
    mov eax, [result]
    call itoa

    ; Output the result message
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 8
    int 0x80

    ; Output the result string
    mov eax, 4
    mov ebx, 1
    mov ecx, result_str
    mov edx, edi         ; EDI points to the end of the string
    sub edx, result_str  ; Subtract the start address to get the length
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Recursive descent parser for mathematical expressions
parse_expression:
    call parse_term
    jmp parse_next_operator_expression

parse_next_operator_expression:
    ; Check for the next operator
    mov al, byte [esi]
    cmp al, 0
    je done_expression

    ; Determine the operation
    cmp al, '+'
    je perform_addition_expression
    cmp al, '-'
    je perform_subtraction_expression
    jmp done_expression

perform_addition_expression:
    inc esi
    call parse_term
    add eax, [result]
    jmp parse_next_operator_expression

perform_subtraction_expression:
    inc esi
    call parse_term
    sub eax, [result]
    jmp parse_next_operator_expression

parse_term:
    call parse_factor
    jmp parse_next_operator_term

parse_next_operator_term:
    ; Check for the next operator
    mov al, byte [esi]
    cmp al, 0
    je done_term

    ; Determine the operation
    cmp al, '*'
    je perform_multiplication_term
    cmp al, '/'
    je perform_division_term
    jmp done_term

perform_multiplication_term:
    inc esi
    call parse_factor
    imul eax, [result]
    mov [result], eax
    jmp parse_next_operator_term

perform_division_term:
    inc esi
    call parse_factor
    cdq
    idiv dword [result]
    mov [result], eax
    jmp parse_next_operator_term

parse_factor:
    ; Parse and evaluate the next factor (e.g., numbers)
    ; You may need to add additional parsing logic here

done_expression:
    ret

done_term:
    ret

itoa:
    mov ebx, 10          ; divisor (base 10)
    mov edi, result_str  ; destination buffer for the converted number
    mov ecx, edi         ; save the start of the buffer in ECX

    ; Check if eax is zero and handle this special case
    test eax, eax
    jz handle_zero

itoa_loop:
    xor edx, edx        ; clear edx for division
    div ebx             ; divide eax by 10, result in eax, remainder in edx
    add dl, '0'         ; convert remainder to ASCII
    mov [edi], dl       ; store ASCII character
    inc edi             ; move to the next byte in the buffer
    test eax, eax       ; check if eax is zero
    jnz itoa_loop

    mov [edi], byte 0   ; null-terminate the string
    mov eax, ecx        ; pointer to the start of the string
    ret

handle_zero:
    mov byte [edi], '0' ; store '0'
    inc edi
    mov byte [edi], 0   ; null-terminate the string
    mov eax, ecx
    ret

