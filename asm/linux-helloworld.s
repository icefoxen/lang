// Ow, my syntax hurts!

msg: .ascii "Hello world!\n"
msgend:

.global _start

_start:
	mov $4, %eax
	mov $1, %ebx
	mov $msg, %ecx
	mov $msgend - msg, %edx
	int $0x80

	mov $1, %eax
	mov $0, %ebx
	int $0x80


