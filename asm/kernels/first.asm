; An actually operational OS kernel.
; If you count hanging infinately as operational, but hey!  ^_^
;
; compile with: 
; nasm -f elf first.asm
; ld --oformat=elf32-i386 -Ttext 100000 first.o -o kernel
;
; From here you can go on and make it do anything...  Just modify "start2"
; for instance, to have it run kernel.c all you need to do is this:
; * add "extern cmain"
; * to start2, add "push ebx, push eax, call cmain"
; * write kernel.c with a function "cmain()" (dunno how to do args yet)
; * compile and link it in
;
; Simon Heath
; 21/5/2003

global _start

_start:
	jmp start2
	align 4
	dd 0x1badb002
	dd 0
	dd 0 - 0x1badb002

start2:
	jmp start2
