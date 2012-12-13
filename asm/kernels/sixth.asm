global _start
extern main

_start:
   call main
   align 4
   dd 0x1badb002
   dd 0
   dd 0 - 0x1badb002
