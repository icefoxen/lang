/* fib1.c
 * Fibonacci sequence; more recursion.
 * There's actually a much more efficient way to do this... we'll do that
 * next.
 *
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>

float Fib( float n );

main()
{
 	float p;
	p = Fib( 45 );
	printf( "%f\n", p );
}

float Fib( float n )
{
	if( n < 2 ) 
	   return 1;
	else 
	   return (Fib( n - 1 ) + Fib( n - 2 ));
}
