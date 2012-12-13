/* fib1.c
 * Fibonacci sequence; more recursion.
 * There's actually a much more efficient way to do this... we'll do that
 * next.
 *
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>

#define MinIndex 0
/* #define MaxIndex 12 */

/* function prototypes */

int Fib( int n );

int Add( int n, int m )
{
	return n + m;
}

int Sub( int n, int m )
{
	return n - m;
}

/* main program */

int main()
{
	int p;

	p = Fib( 45 );
	printf( "%d\n", p );
	return 0;
}

int Fib( int n )
{
	if( n < 2 ) 
	   return 1;
	else 
	   return Add( Fib( Sub( n, 1 ) ), Fib( Sub( n, 2 ) ) );
}
