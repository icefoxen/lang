global asm_main
extern fop

asm_main:
	push ebp
	mov ebp, esp

	sub esp, byte 0x18
	mov dword [ebp - 0x04], 0x0a
	add dword [ebp - 0x04], byte 0x0a

	mov eax, [ebp - 0x04]

	push 0x20  ; Ish the function argument.  Hehehe!
	call fop   ; Defined in the C
	
	leave
	ret
