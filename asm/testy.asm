mov	eax, 3		; 668b 0300 00  --little-endian, least-byte first.
mov	ebx, 4
mov	ecx, 6
mov	edx, 7
mov	ecx, eax
mov	si, ax		; ax is the lower 16 bits of eax, remember.

add	eax, 12 	; eax += 12
add	ebx, 18
sub	eax, ebx
inc	ebx		; ebx++
dec	si		; si--

foo equ 0		; Directive - defines a symbol
%define BAR 100		; Directive - defines a macro.

add	eax, foo	; add eax, 0
mov	edx, BAR	; mov edx, 100
