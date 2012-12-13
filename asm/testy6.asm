global main

main:
	pusha
	push 0
	push 1
	pop ebx
	pop eax

	popa
	ret
