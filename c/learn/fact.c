/* fact.c
 * Calculates a factorial.
 * Yay, recursion!
 * 
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>

unsigned long Fact( unsigned long n )
{
   if( n == 0)
	   return 1;
	else
		return( n * Fact( n - 1) );
}

main()
{
	unsigned long i;

	while( 1 )
	{
   	printf( "Enter a number to get the factorial of, or 0 to quit.\nBeware big numbers; this is limited-precision.\n" );
   
	   scanf( "%d", &i );
		if( i == 0 ) break;
		else printf( "%d! is %d\n", i, Fact( i ) );

	}
}
