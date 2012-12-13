/* yaochifont.c
 * This is a text-formatting program that takes a word as input, and prints
 * html formatted to produce that word as rainbow-colored text.
 * Created for a MZDM avatar who does the color-text thing sometimes.
 *
 * Created at 12:30 am, which explains much.
 *
 * Simon Heath
 * 18/11/2002
 */

#include <string.h>
#include <stdio.h>

main( int argc, char **argv )
{
	int i, c, slen;
	int r, g, b;
	char buf;

	slen = 0;
	r = g = b = 0x33;  /* Don't wanna start things off black... */

	for( i = 1; i < argc; i++ ) 
	/* Outer loop executes inner loop for each command line argument... */
	{

		slen = strlen( argv[i] );
		
		for( c = 0; c < slen; c++ ) 
		/* Inner loop executes for each letter of each arg... */
		{
			printf( "<font color=\"#%02x%02x%02x\">%c</font>", 
								 r, g, b, argv[i][c] );
			/* Result is something like <font color="#330000">h</font>
			 */
			
			r += 0x33;  /* Rotate the red value a tad... */
			
			if( r > 0xFF ) /* Then test to flip all the other colors */
			{
				r = 0x33;   /* Reset to 0x33 so we don't have black letters */
				b += 0x33;
			}
			else if( b > 0xFF )
			{
				b = 0x33;
				g += 0x33;
			}
			else if( g > 0xFF )
			{
				g = 0x33;
			}

			if( r == 0xFF && g == 0xFF && b == 0xFF )
			{
				r = g = b = 0x99;
			}
		}

		printf( " " ); /* After each arg, print a space. */
	}
}
