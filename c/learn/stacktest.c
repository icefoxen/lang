/* Tests some wiggy-looking things in my stack.h
 * That's all.
 *
 * Simon Heath
 * 16/11/2002
 */


#include <stdio.h>
#include "lib/stack.h"

main()
{
	stackADT s = NewStack();
	char input[64];
	
   while( 1 )
	{
   	printf( "Number of stack elements: %d\n", StackDepth( s ) );
		printf( "Top stack element: %f\n", peek( s, StackDepth( s ) - 1 ) );
		if( StackDepth( s ) > 1 )
		{
		   printf( "Second stack element: %f\n",  peek( s, StackDepth( s ) - 2 ) );
		}
		printf( "Input value to push, or q to quit: " );
		scanf( "%s", &input );
		if( input[0] == 'q' ) 
			break;
		else 
			push( s, atof( input ) );
	}
}
