global _start

_start:
	jmp main
	align 4
	dd 0x1badb002
	dd 0
	dd 0 - 0x1badb002


main:
	call _pushstack
	mov dword [esp], 0x20

	mov eax, [esp]
	imul eax, 0x02
	mov [esp], eax

	mov edx, [esp]
	call _printedx

	;call times2
	call _popstack

	leave 
	ret
	

_pushstack:
	sub esp, byte 0x04
	leave
	ret

_popstack:
	add esp, byte 0x04
	leave
	ret

_printedx:
	mov [0x000b8010], edx
	leave
	ret
