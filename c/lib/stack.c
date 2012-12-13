/* stack.c
 * Actual implementation of a stack datatype.  More a more sophisticated
 * discussion, go to stack.h
 *
 *
 * Simon Heath
 * 15/11/2002
 * 
 * Implemented a infinate-size stack by adding ExpandStack and changing a few
 * things.
 * 16/11/2002
 */

#include <stdio.h>

#include "stack.h"

#define InitialStackSize 100


/* stackCDT
 * Concrete representation of a stack data type.
 * You can mess around with this as much as you want, but all the client
 * programs will be using stackADT, so they'll never notice the difference.
 */

struct stackCDT
{
	stackElement *elements;
	int count;
	int size;
};


/* Private functions */

/* remember... 'static' effectively means 'private'... it's NOT the same as
 * 'static' in Java!!!!!!!!! 
 */
static void ExpandStack( stackADT stack )
{
	stackElement *array;
	int i;
	int newsize = stack->size * 2;
	
	array = (stackElement *) myalloc( newsize );
	for( i = 0; i < stack->size; i++ )
	{
		array[i] = stack->elements[i];
	}

	/*free( stack->elements ); */
	stack->elements = array;
	stack->size = newsize;
}



/* exported functions. */

stackADT NewStack( void )
{
	stackADT stack; 
	
	stack = myalloc( sizeof( stackADT ) );
	stack->elements = (stackElement *) myalloc( InitialStackSize );
	stack->count = 0;
	stack->size = InitialStackSize;
	return stack;
}


void FreeStack( stackADT stack )
{
	free( stack->elements );
	free( stack );
}


void push( stackADT stack, stackElement element )
{
	if( stack->count == stack->size ) ExpandStack( stack );
	stack->elements[ stack->count++ ] = element;
}


stackElement pop( stackADT stack )
{
	if( StackIsEmpty( stack ) ) 
	   Error( "Trying to pop an empty stack" );
	return ( stack->elements[ --stack->count ] );
}


int StackIsEmpty( stackADT stack )
{
	return (stack->count == 0 );
}


/* Depreciated; stack is dynamic now */
int StackIsFull( stackADT stack )
{
	return 0;
}


int StackDepth( stackADT stack )
{
	return (stack->count);
}


stackElement peek( stackADT stack, int index )
{
	if( index < 0 || index >= stack->count )
		Error( "Non-existant stack element" );
	return ( stack->elements[ stack->count - index - 1 ] );
}
