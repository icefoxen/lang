/* fib1.c
 * Fibonacci sequence; more recursion.
 * There's actually a much more efficient way to do this... we'll do that
 * next.
 *
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>

int Fib( int n );

int main()
{
 	int p;
	p = Fib( 40 );
	printf( "%d\n", p );
}

int Fib( int n )
{
	if( n < 2 ) 
	   return 1;
	else 
	   return (Fib( n - 1 ) + Fib( n - 2 ));
}
