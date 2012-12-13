; Data directives - reserves memory.
L1	db	0	; Byte called L1 that contains 0
L2	dd	12h	; Double word (32 bits) called L2 that contains 0x12
L3	db	0,1,2,3	; Defines 4 bytes 1, 2, 3, 4
L4	db	'foo',0	; Defines a C string = 'foo'

L5	times 100 db 0	; Equal to 100 (db 0)
L6	resw	10	; Reserves 10 words - not initialized.


mov	al, [L1]	; Note the operands are the same size!
mov	ebx, [L2]	; Here they are NOT, but it compiles!
mov	ebx, [L2]
mov	word [L6], 1	; Must tell it that L6 is a word, 'cause 1 can be of
			; arbitrary size
mov	dword [L6], 2

mov	eax, L1		; Stores the location of L1 instead of the contents.
mov	ecx, L2
mov	byte [L4], 1
