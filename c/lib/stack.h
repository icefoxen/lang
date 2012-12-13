/* stack.h
 * Defines an abstraction for a stack data-type.
 * It can only hold one type of element though, such as a double or int.  Due
 * to this, there's a stackElement typedef that defines it as an int; you want
 * it to hold a different value type, just change this.
 *
 * You could use void * pointers in the stack which could point to any var
 * type, but that would mean that each var in the stack is really a pointer,
 * which means that the type of var has to be allocated at runtime, which is
 * rather complex.  Doable, though.  The book says that's the other major
 * solution to this problem.
 *
 * Now I know why object-oriented programming makes things easier; if you want
 * a data-type to hold different value types, just inherit from the abstract
 * base and redefine a couple things.  You can also use overloaded
 * constructors to even provide a unified interface.
 *
 * I wonder if I can do the same thing in C?  Can I somehow overload
 * functions?  Have it so I can call NewStack( "int" ) or NewStack( "double" )
 * ...We'll see, I suppose.  I suspect that such a function would just be a
 * wrapper around a whole mess of decision-making and specific-type data
 * structures.  DAMMIT, it it were object-oriented all we'd have to do is make
 * it compatable with the abstract type and it would automatically work with
 * everything inherited from that type.  Bloody freakin' polymorphism....
 *
 * Simon Heath
 * 15/11/2002
 */


#ifndef _stack_h
#define _stack_h


#include "myalloc.h"


/* stackElement type
 * Indicates the type of data that can be stored in the stack.
 * Can be just about anything.  This just presents a unified interface so when
 * you wanna change it, you only change this, not every single declaration in
 * the program.  Change this line if you want it to store something other than 
 * int.
 */
typedef float stackElement;


/* stackADT type
 * This represents the abstract data type.
 * Since it's just a pointer to the concrete data type, the client has no
 * access to the underlying implementation.
 * This means that you can mess with the concrete data type all you want and
 * the client program never notices.
 */
typedef struct stackCDT *stackADT;


stackADT NewStack( void );  /* makes a new stack */


void FreeStack( stackADT stack ); /* Frees a stack */


void push( stackADT stack, stackElement element ); /* pushes an element */

stackElement pop( stackADT stack );  /* pops an element */


/* These functions return true if true, and false if false
 */
int StackIsEmpty( stackADT stack );
int StackIsFull( stackADT stack );


int StackDepth( stackADT stack ); /* returns stack depth */


/* Peeks at a stack element's value without actually messing with it */
stackElement peek( stackADT stack, int index );


#include "stack.c"

#endif /* ifndef _stack_h */
