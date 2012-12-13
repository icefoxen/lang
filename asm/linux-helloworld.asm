msg:	db 	'Hello world!',0x0A,0
msgend:	db	0

global _start

_start:
	mov eax, 4	; "Write" system call
	mov ebx, 1	; stdout
	mov ecx, msg    ; String
	mov edx, msgend - msg  ; String length
	int 0x80

	mov eax, 1	; "_exit" system call
	mov ebx, 0	; EXIT_SUCCESS
	int 0x80

