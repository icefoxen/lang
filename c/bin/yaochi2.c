/* yaochi2.c
 * This is a text-formatting program that takes a word as input, and prints
 * html formatted to produce that word as rainbow-colored text.
 * Created for a MZDM avatar who does the color-text thing sometimes.
 *
 * This is different from the first version 'cause it adds size difference and
 * the colors are completely random (within the set range).
 *
 * Created at 12:30 am, which explains much.
 *
 * Simon Heath
 * 18/11/2002
 */

#include <string.h>
#include <stdio.h>
#include "lib/random.h"

main( int argc, char **argv )
{
	int i, c, slen, size;
	int r, g, b;

	slen = 0;
	Randomize();  /* Seed random number gen. */
	r = g = b = 0x33;  /* Don't wanna start things off black... */

	for( i = 1; i < argc; i++ ) 
	/* Outer loop executes inner loop for each command line argument... */
	{

		slen = strlen( argv[i] );
		size = 3;
		
		for( c = 0; c < slen; c++ ) 
		/* Inner loop executes for each letter of each arg... */
		{
			printf( "<font color=\"#%02x%02x%02x\" size=\"%d\">%c</font>", 
								 r, g, b, size, argv[i][c] );
			/* Result is something like <font color="#330000" size="6">h</font>
			 */
			size = RandomInt( 3, 6 );
			r = RandomInt( 0x66, 0xFF );
			g = RandomInt( 0x66, 0xFF );
			b = RandomInt( 0x66, 0xFF ); 
		}

		printf( " " ); /* After each arg, print a space. */
	}
}
