.file "first.s"
.text
.globl _start

_start:
   jmp start2
   .align 4
   dd 0x1badb002
   dd 0
   dd 0 - 0x1badb002

start2:
   jmp start2
