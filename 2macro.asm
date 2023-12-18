; Macros to define print and scan

%macro print 2
    mov rax, 1               ; SYS_write
    mov rdi, 1               ; standard output device
    mov rsi, %1              ; output string address
    mov rdx, %2              ; number of characters
    syscall                  ; calling system services
%endmacro

%macro scan 2
    mov rax, 0               ; SYS_read
    mov rdi, 0               ; standard input device
    mov rsi, %1              ; input buffer address
    mov rdx, %2              ; number of characters
    syscall                  ; calling system services
%endmacro

section .bss
    buffer resb 4
    n resd 1
    sumN resd 1
    ascii resb 10

section .data
    msg1 db "Input a number (004~999): "
    msg2 db "1 + 2 + 3 +...+ "
    msg3 db " = "

section .text
global _start

_start:
    ; Print message
    print msg1, 26           ; cout << msg1

    ; Read input
    scan buffer, 4           ; cin >> buffer

    ; Initialize variables
    mov ax, 0                ; clear ax
    mov bx, 10               ; bx = 10
    mov rsi, 0               ; counter = 0

inputLoop:
    mov cl, byte[buffer+rsi] ; cl = byte[buffer+rsi]
    and cl, 0fh              ; convert ASCII to number
    add al, cl               ; al = number
    adc ah, 0                ; ah = 0

    cmp rsi, 2               ; compare rsi with 2
    je skipMul               ; if rsi=2 goto skipMul
    mul bx                   ; dx:ax = ax * bx

skipMul:
    inc rsi                  ; rcx++
    cmp rsi, 3               ; compare rsi with 3
    jl inputLoop             ; if rsi < 3 goto inputLoop

    mov word[n], ax          ; n = ax

    ; Calculate 1 + 2 + 3 + ... + N
    mov ecx, 0               ; ecx = 0

sumLoop:
    add dword[sumN], ecx     ; sumN += ecx
    inc ecx                  ; ecx++
    cmp ecx, dword[n]        ; compare ecx with n
    jbe sumLoop              ; if (ecx <= n) goto sumLoop

    ; Convert sumN into ASCII
    ; Part A - Successive division
    mov eax, dword[sumN]     ; get integer
    mov rcx, 0               ; digitCount = 0
    mov ebx, 10              ; set for dividing by 10

divideLoop:
    mov edx, 0
    div ebx                  ; divide number by 10
    push rdx                 ; push remainder
    inc rcx                  ; increment digitCount
    cmp eax, 0               ; if (result > 0)
    jne divideLoop           ; goto divideLoop

    ; Part B - Convert remainders and store
    mov rbx, ascii           ; get addr of ascii
    mov rdi, 0               ; rdi = 0

popLoop:
    pop rax                  ; pop intDigit
    add al, "0"              ; al = al + 0x30
    mov byte [rbx+rdi], al  ; string[rdi] = al
    inc rdi                  ; increment rdi
    loop popLoop             ; if (digitCount > 0) goto popLoop

    mov byte [rbx+rdi], 10  ; string[rdi] = newline

    ; Print results
    print msg2, 16           ; cout << msg2
    print buffer, 3          ; cout << buffer
    print msg3, 3            ; cout << " = "
    print ascii, 7           ; cout << ascii

    ; Terminate program
    mov rax, 60              ; terminate program
    mov rdi, 0               ; exit status
    syscall

