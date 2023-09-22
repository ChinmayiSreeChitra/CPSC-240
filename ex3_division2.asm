; ex3_division2.asm
; unsigned int num1 = 100000;
; unsigned short num2 = 333;
; unsigned short quot = 0, remd = 0;
; quot = num1 / num2;
; remd = num1 % num2;

section .data
        num1      dd      100000                                ;num1 = 100000 = 0001 86A0h
        num2      dw      333                                   ;num2 = 333 = 014Dh
        quotient  dw      0                                     ;quotient = 0000h
	remainder dw      0                                     ;remainder = 0000h

section .text
        global _start

_start:
	mov	dx, word[num1+2]				;dx = num1+2 = 0001
        mov     ax, word[num1+0]                                ;ax = num1+0 = 86A0h
        div     word[num2]                                  	;ax=ax/num2=012Ch=300
								;dx=ax%num2=0064h=100
        mov     word[quotient], ax                              ;quotient =ax=012Ch=300
        mov     word[remainder], dx                             ;remainder=dx=0001h=100

        mov     rax, 60                                         ;terminate excuting process
        mov     rdi, 0                                          ;exit status
        syscall                                                 ;calling system services
