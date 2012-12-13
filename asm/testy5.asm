global main

main:
	; I think the enter instruction clears the registers and saves
	; the state.  You can omit it w/o harm, as long as you uncomment
	; the push instruction after it.  Weird.
	;enter 0,0
	push ebp
	
	mov ebp, esp
	sub esp, byte +0x18
	mov word [ebp - 0x4], +0xA
	add word [ebp - 0x4], +0xA

	call foo


	; Undoes whatever stack and register shifts we do, which is the
	; same stuff 'leave' does.
	add esp, byte +0x18
	pop ebp
	;leave
	ret

foo:
	push eax
	pop eax

	; We're not making any net changes to the state, so we don't
	; need a leave instruction.
	ret
