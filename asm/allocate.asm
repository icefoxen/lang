global main
extern allocate, freemem

main:
	enter 0,0
	push 0x20
	call allocate
	push eax
	call freemem

	leave
	ret
