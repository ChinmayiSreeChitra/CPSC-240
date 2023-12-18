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

    ; Convert buffer to n
    mov rbx, buffer          ; rbx = address of buffer
    call toInteger

    ; Calculate 1 + 2 + 3 + ... + N
    mov rcx, 0               ; rcx = 0
    mov edi, dword[n]        ; edi = n
    call calculate

    ; Convert sumN into ascii
    call toString

    ; Print results
    print msg2, 16           ; cout << msg2
    print buffer, 3          ; cout << buffer
    print msg3, 3            ; cout << " = "
    print ascii, 7           ; cout << ascii

    ; Terminate program
    mov rax, 60              ; terminate program
    mov rdi, 0               ; exit status
    syscall                  ; calling system services

; String to Integer function
toInteger:
    mov rax, 0               ; clear rax
    mov rdi, 10              ; rdi = 10
    mov rsi, 0               ; counter = rsi = 0

mulLoop:
    mov r10b, byte[rbx+rsi]
    and r10b, 0fh            ; convert ascii to number
    add al, r10b             ; al = r10b = number
    adc ah, 0                ; ah = 0

    cmp rsi, 2               ; compare rsi with 2
    je mulSkip               ; if rsi=2 goto mulSkip
    mul di                   ; dx:ax = ax * di

mulSkip:
    inc rsi                  ; rcx++
    cmp rsi, 3               ; compare rsi with 3
    jl mulLoop               ; if rsi < 3 goto mulLoop

    mov word[n], ax          ; n = ax
    ret

; Calculation function
calculate:
sumLoop:
    add dword[sumN], ecx     ; sumN += ecx
    inc ecx                  ; ecx++
    cmp ecx, edi             ; compare ecx and edi = n
    jbe sumLoop              ; if(cx <= n) jump to sumLoop
    ret

; Integer to String function
toString:
    ; Part A - Successive division
    mov eax, dword[sumN]     ; get integer
    mov rcx, 0               ; digitCount = 0
    mov ebx, 10              ; set for dividing by 10

divideLoop:
    mov edx, 0
    div ebx                  ; divide number by 10
    push rdx                 ; push remainder
    inc rcx                  ; increment digitCount
    cmp eax, 0               ; if (quotient != 0)
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
    ret

