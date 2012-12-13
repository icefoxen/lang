; Compile WITH:
; nasm -f elf testy4.asm
; gcc testy4.o
; For some weird weird diseased wrong reason, you have to run the object file
; through gcc, it doesn't work alone with ld.  I think it has something to do
; with how it sets up the _start procedure.

global main 

segment .data

segment .bss

segment .docstring
maindoc	db "Foody foody foo!", 0

segment .text

main:
	; This instruction is necessary if you don't want a segfault
	;enter 0, 0

	; This one is optional but it's good to save the old state...
	;pusha

	
	push eax
	push ebx


	pop ebx
	pop eax

	; the mov isn't necessary, but it's a good thing to leave
	; memory in a consistant state.
	;mov eax, 0
	;leave
	ret
