/* So, this is a test of several things:
 * First, whether DJGPP has all the important libraries it should,
 * Second, it's messing around with the ANSI string functions,
 * Third, it's testing dynamic memory allocation using malloc().
 * Seems to have worked pretty well, ne?
 *
 * Simon Heath
 * 3/11/2002
 */

#include <malloc.h>
#include <string.h>

main()
{
   int x;
	char c[] = "Hello world!";
	char *d;

	printf( "string c = %s\n", c );
	printf( "Address of c = %d\n", &c );
	printf( "length of c is: %d\n", strlen( c ) );

	d = (char *) malloc( strlen( c ) );
	printf( "New memory allocated to 'd', addr %d\n", d );
	strcpy( d, c );
	/* We can't just do strcpy( malloc( strlen( c ) ), c )
	 * That wouldn't return any value, so while the memory would be
	 * allocated and the string copied, we wouldn't be able to GET to it
	 * afterwards.
	 */

	printf( "String 'c' copied to 'd'\n" );
	printf( "string d = %s\n", d ); 
	printf( "Address of d = %d\n", d );
	printf( "Length of d is: %d\n", strlen( d ) );

}
