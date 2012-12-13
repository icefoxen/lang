/* This program implements a stack-based calculator.
 * Like Linux's dc, but not as good.
 * You get the idea.
 *
 * Simon Heath
 * 16/11/2002
 */

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "lib/stack.h"


/* Private function prototypes */

static void ApplyOperator( char op, stackADT stack );
static void ClearStack( stackADT stack );
static void DisplayStack( stackADT stack );


/* Main program */

main()
{
	stackADT stack;
	char line[64];
	char ch;

	printf( "Stack-based calculator --lower-case only please!\n" );
	printf( "q = quit, c = clear stack, s = display stack, n = show stack depth.\nType numbers to enter them, +-*/ are the only valid operators.\n" );
	stack = NewStack();

	while( 1 )
	{
		printf( "> " );
		scanf( "%s", &line );
		ch = line[0];
		
		switch( ch )
		{
			case 'q': exit( 0 );
			case 'c': ClearStack( stack ); break;
			case 's': DisplayStack( stack ); break;
			case 'n': printf( "%d\n", StackDepth( stack ) ); break;
			default:
			   if( ch >= 48 && ch < 58 ) /* is a digit */
				{
					push( stack, atof( line ) );
				}
				else
				{
			      ApplyOperator( ch, stack );
				}
				break;
		}
	}
}


/* Private functions */

static void ApplyOperator( char op, stackADT stack )
{
   double lhs, rhs, result;
	rhs = pop( stack );
	lhs = pop( stack );
	switch( op )
	{
      case '+': result = lhs + rhs; break;
		case '-': result = lhs - rhs; break;
		case '*': result = lhs * rhs; break;
		case '/': result = lhs / rhs; break;
		default: Error( "Illegal operator" );
	}

	printf( "%f\n", result );
	push( stack, result );
}


static void ClearStack( stackADT stack )
{
	while( !StackIsEmpty( stack ) )
		(void) pop( stack );
}


static void DisplayStack( stackADT stack )
{
	int i, depth;

	printf( "Stack: " );
	depth = StackDepth( stack );
	if( depth == 0 )
		printf( "Empty\n" );
	else
	{
		for( i = depth - 1; i >= 0; i-- )
		{
			if( i < depth - 1 ) printf( ", " );
			printf( "%f", peek( stack, i ) );
		}

		printf( "\n" );
	}
}
