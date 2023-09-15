; ex2_subtraction.asm
; unsigned char num1 = 100, num2 = 200;
; signed short dif = 0;
; dif = short(num1 - num2);

section .data
        num1     db      100			;num1 = 64h
        num2     db      200			;num2 = 0C8h = 200
        dif      dw      0			;dif = 00h

section .text
        global _start

_start:
        mov     al, byte[num1]			;al = num1 = 64h
        sub     al, byte[num2]			;al = al - num2 = 9ch
	sbb	ah, 0				;ah = ah - 0 - CF = 0ffh
        mov     byte[dif+0], al			;dif = al = 9ch
        mov     byte[dif+1], ah			;dif = ah = 0ffh
						;mov word[dif], ax
        mov     rax, 60				;terminate excuting process
        mov     rdi, 0				;exit status
        syscall					;calling system services
