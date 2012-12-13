; third.asm
; Implements a really dumb stack.  Just to test memory handling and junk.
;
; compile with: 
; nasm -f elf second.asm
; ld --oformat=elf32-i386 -Ttext 100000 first.o -o kernel
;
;
; Simon Heath
; 21/5/2003

global _start


_start:
	jmp start2
	align 4
	dd 0x1badb002
	dd 0
	dd 0 - 0x1badb002

start2:
	mov eax, 0x1000000
	mov byte [eax], 'S'
	inc eax
	mov byte [eax], 'i'
	inc eax
	mov byte [eax], 'm'
	inc eax
	mov byte [eax], 'o'
	inc eax
	mov byte [eax], 'n'
	inc eax
	mov byte [eax], '!'
	inc eax
	

	dec eax
	mov [0x000b8000], eax

	dec eax
	mov [0x000b8002], eax

	dec eax
	mov [0x000b8004], eax

	dec eax
	mov [0x000b8006], eax

	dec eax
	mov [0x000b8008], eax

	dec eax
	mov [0x000b800A], eax

	mov byte [0xFFFFFFFF], 91	

	jmp hang



hang:
	mov word [0x000b800C], 'Q'
	jmp hang
