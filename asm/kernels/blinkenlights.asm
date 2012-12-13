; second.asm
; Just like first.asm 'cept it prints a string
;
; compile with: 
; nasm -f elf second.asm
; ld --oformat=elf32-i386 -Ttext 100000 first.o -o kernel
;
;
; Simon Heath
; 21/5/2003

global _start


_start
	jmp start2
	align 4
	dd 0x1badb002
	dd 0
	dd 0 - 0x1badb002

start2:
	mov byte [0x000b8100], 'H'
	mov byte [0x000b8102], 'e'
	mov byte [0x000b8104], 'l'
	mov byte [0x000b8106], 'l'
	mov byte [0x000b8108], 'o'
	mov byte [0x000b810A], ' '
	mov byte [0x000b810C], 'W'
	mov byte [0x000b810E], 'o'
	mov byte [0x000b8110], 'r'
	mov byte [0x000b8112], 'l'
	mov byte [0x000b8114], 'f'
	mov byte [0x000b8116], '!'


	; Set mode to graphics...?
	; This is a BIOS call, mook.  It won't work in protected mode.
	;mov ah, 0x00
	;mov al, 0x13
	;int 0x10

	mov eax, 0x000A0000
	mov ebx, 0x000b8001 

	mov ecx, 0xFFFF

	
loopy:
	cmp ecx, 0
	jz hang
	mov byte [eax], 'A'
	mov byte [ebx], cl
	add eax, 2
	add ebx, 2
	dec ecx
	jmp loopy

hang:
	jmp hang
