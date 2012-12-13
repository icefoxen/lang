/* Basic messing around with input and stuff.
 */

#include <stdio.h>

main( int argc, char **argv )
{
   char a[64];
   char *g;
	int i;

	printf( "Type something to test gets()\n" );
   g = gets( a );  /* Turns out that gets() returns a pointer to the string
							 Can't imagine why... */
   printf( 
	"You typed: %s\nA pointer to the first char returns: %c\n\n", a, *g );

   printf( "You gave %d args, including the program name.\n", argc );
	
	for( i = 0; i < argc; i++ )
	{
      printf( "arg %d is: %s\n", i, argv[i] );
	}
}
