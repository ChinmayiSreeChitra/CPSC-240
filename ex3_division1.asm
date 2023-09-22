; ex3_division1.asm
; unsigned char num1 = 50, num2 = 3;
; unsigned char quot = 0, remd = 0;
; quot = num1 / num2;
; remd = num1 % num2;

section .data
        num1     db      50                                     ;num1 = 50 = 32h
        num2     db      3                                      ;num2 = 3 = 03h
        quot     db      0                                      ;quot = 00h
	remd     db      0                                      ;remd = 00h

section .text
        global _start

_start:
        mov     al, byte[num1]                                  ;al = num1 = 32h
	cbw							;movzx ax, al
        div     byte[num2]                                  	;al=ax/num2=10h,ah=ax%num2=02h 
        mov     byte[quot], al                                  ;quot = al = 10h
        mov     byte[remd], ah                                  ;remd = ah = 02h

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
