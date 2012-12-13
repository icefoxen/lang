; template.asm
; template file for assembly programs, compiled and linked with C.
; Simon Heath
; 22/4/2003

; Initialized data
segment .data

; Uninitialized data
segment .bss

; Code
segment .text
	global _asm_main

_asm_main:
	; Enter the routine
	enter	0,0
	pusha

	; Insert code here
	push	10

	; Return to C
	popa
	mov eax, 0
	leave
	ret
