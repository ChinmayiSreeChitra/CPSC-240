; ex2_addition.asm
; unsigned char num1 = 100, num2 = 200;
; unsigned short sum = 0;
; sum = short(num1 + num2);

section .data
        num1     db      100			;num1 = 64h
        num2     db      200			;num2 = 0C8h
        sum      dw      0			;sum = 00h

section .text
        global _start
_start:
	mov	ah, 0
        mov     al, byte[num1]			;al = num1 = 64h
        add     al, byte[num2]			;al = al + num2 = 2Ch
	adc	ah, 0				;ah = ah + 0 + CF = 01h
        mov     byte[sum+0], al			;sum = al = 9ch
        mov     byte[sum+1], ah			;sum = ah = 0ffh
						;mov word[sum], ax
        mov     rax, 60				;terminate excuting process
        mov     rdi, 0				;exit status
        syscall					;calling system services
