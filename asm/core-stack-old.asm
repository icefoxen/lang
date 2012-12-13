; core-stack.asm
; Memory calls for Sig.  Low-level stack-handling junkin.
;
; Yes, stack.  The assembly instruction stack has some limitations
; that I wanna get around.  In Sig, each program has it's own stack, Forth-
; style.  This makes functions absurdly easy to write and parse.  However,
; if I just make it a big honkin' dynamically-allocated array, it'll be a
; big waste of space.  Sure, it could be programmer-tuned, but why bother?
; It would just be a pain in the ass to worry about.
;
; Make it a doubly-linked list instead.  Yes, a doubly-linked list.  That way
; it's more space efficient overall than a static array, and it's easy to
; stick new elements on it and remove old ones.  The speed hit of not using
; an array is helped by the double-linking, and the memory usage (and
; end-user simplicity) of using a list is better than an array, so we can
; waste an extra 4 bytes per node.
;
; Unless you think that hard-wiring stack overflows into your program is
; a good idea.  ;-D
;
; 12/9/2005: ...man, I was stupid two years ago.  Dynamic arrays don't have
; a bad memory/speed curve.  It's just a bit erratic.
;
; TODO: Debug listlength and freelist
;
; Keep listlength in a var??  Would cut down error handling...
;
; Simon Heath
; 24/5/2003

extern allocmem, freemem, print_int, newline
global stackbottom, stacktop, _initstack, _pushstack, _popstack
global _listlength, _freelist


; Declare vars
segment .data
; Save the locations of the top and bottom of the stack.
stackbottom 	dd 0
stacktop	dd 0


segment .bss


segment .text

; Creates a new doubly-linked list node.  First 4 bytes are the value, 
; second 4 bytes are the next node, last 4 bytes are the previous node.
; This takes eax as a link to the previous node, and ebx as a link to the
; next one.  If one or the other doesn't exist, you MUST put 0 there.
; It returns the address of the created node in eax.
_makenode:
	; Save registers
	push ecx
	push edx

	mov ecx, eax		; Move the prevnode pointer to ecx

	mov eax, 0x0C		; Set arg to 12
	call allocmem		; Allocate 12 bytes of memory

	; now eax = node, ebx = nextnode, ecx = prevnode

	mov dword [eax], 0	; Initialize element to 0
	mov [eax+0x4], ebx	; Set nextnode
	mov [eax+0x8], ecx	; Set prevnode


	cmp ecx, 0		; Test if this is the lists's first node
	jz next			; If so, skip it, else,
	mov [ecx+0x4], eax	; Re-route prevnode's nextnode to currentnode
next:

	mov [stacktop], eax	; Move stacktop to current node

	; Restore registers and leave
	pop edx
	pop ecx
	ret

; Initializes the stack.
_initstack:
	enter 0, 0

	mov dword [stacktop], 0
	mov dword [stackbottom], 0
	
	leave
	ret

; Pushes an element from eax onto the stack.
_pushstack:

	; Save registers
	push ebx

	; Allocate new node
	push eax		; Push element
	mov eax, [stacktop]	; prevnode = current stacktop 
	mov ebx, 0		; nextnode = null
	call _makenode		; build it!

	; Set element
	pop ebx			; Pop element
	mov [eax], ebx		; Move element to node

	mov [stacktop], eax	; Set stacktop to new node

	; Restore registers
	pop ebx

	ret


; Pops an element from the stack into eax.
_popstack:


	; Save registers in case of anything important
	push ebx
	push ecx

	; Check for stack underflow
	cmp dword [stacktop], 0
	jz error

	mov ebx, [stacktop]	; Move the top node element to ebx
	mov ebx, [ebx]		; We're dealing with a pointer to a pointer...
	mov ecx, [stacktop]	; Move the prevnode pointer to ecx
	mov ecx, [ecx+0x08]	; Same here.
	; Y'see, stacktop is a pointer to a node.  So when we get the value
	; of stacktop into a register, we have a pointer TO that node.
	; To get any actual VALUES from that node, we have to reference
	; it again.

	; Free the old node
	mov eax, [stacktop]
	call freemem

	; Set the new stacktop
	mov [stacktop], ecx	; Set the new stacktop to prevnode
	cmp ecx, 0		; See if ecx is 0.  If so,
	jz then2		; Then there's no nextnode pointer to remove
	mov dword [ecx+0x04], 0	; else, move nextnode pointer from the node
then2:

	; Move the element to eax
	mov eax, ebx

	; Restore registers
	pop ecx
	pop ebx

	ret


; XXX Force a segfault and print a 0
error:
	mov eax, 0
	call print_int
	mov dword [0], 91

	
; Takes the linked list in eax and returns the length of it in eax.
_listlength:
	;enter 0, 0

	; We use ebx as the accumulator
	push ebx
	mov ebx, 0

	; Iterate!
doblock:
	cmp dword [eax+0x04], 0	; Check if nextnode = 0
	jnz thenblock		; If so, jump to thenblock
	inc ebx			; else, inc ebx
	mov eax, [eax+0x04]	; Move to next node
	jmp doblock		; and iterate
thenblock:			; If nextnode = 0,
	mov eax, ebx		; Move ebx (the counter) to eax

	pop ebx
	;leave			; And exit.
	ret

; Free a list given in eax.  The same as above but with a different operation.
; ...This is actually easier with a double-linked list than a single-linked,
; 'Cause a link to the previous node is maintained even when you move to
; the next one.  That means ye don't have to waste an extra register.  :-)
_freelist: 
	;enter 0, 0

	; We use ebx as the accumulator
	push ebx
	mov ebx, 0

	; Iterate!
doblock2:
	cmp dword [eax+0x04], 0	; Check if nextnode = 0
	jnz thenblock2		; If so, jump to thenblock
	mov eax, [eax+0x04]	; else, Move to next node
	push dword [eax+0x08]	; Push the prevnode pointer,
	call freemem		; Free the previous node
	jmp doblock2		; and iterate
thenblock2:			; If nextnode = 0,
	pop ebx			; Just exit
	;leave
	ret
