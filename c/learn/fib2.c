/* fib2.c
 * Uses the AdditiveSequence() function to implement a more efficient
 * fibonacci function.
 *
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>

int AdditiveSequence( int n, int t0, int t1 )
{
	printf( "%d\t%d\t%d\n", n, t0, t1 );
	if( n == 0 ) return t0;
	if( n == 1 ) return t1;
	return ( AdditiveSequence( n - 1, t1, t0 + t1 ) );
}

int fib( int n )
{
	return AdditiveSequence( n, 0, 1 );
}

main()
{
	int in, out;

	printf( "Enter a number to fibonacci-ize\n" );
	scanf( "%d", &in );

	out = fib( in );

	printf( "%d'th number of the fibonacci sequence is: %d\n", in, out );
}
