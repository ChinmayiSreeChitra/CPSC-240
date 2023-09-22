; ex3_multiplication2.asm
; unsigned short num1 = 2500, num2 = 3500;
; unsigned int mult = 0;
; mult = int(num1 * num2);

section .data
        num1     dw      2500                                   ;num1 = 09C4h
        num2     dw      3500                                   ;num2 = 0DACh
        mult     dd      0                                      ;mult = 0000 0000h

section .text
        global _start

_start:
        mov     ax, word[num1]                                  ;ax = num1 = 09C4h
        mul     word[num2]                                  	;dx:ax = ax * num2 = 0085:83B0h
        mov     word[mult], ax                                  ;mult = ax = 83B0h
        mov     word[mult+2], dx                                ;mult+2 = dx = 0085h

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
