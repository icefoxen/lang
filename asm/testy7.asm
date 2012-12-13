global main

main:
	enter 0, 0

	mov eax, esp
	sub esp, 0x04
	mov dword [esp], 0x91

	mov esp, eax 
	
	leave
	ret
