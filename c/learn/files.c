/* files.c
 * Tests file functions and junk.
 * 
 * Simon Heath
 * 3/11/2002
 */

#include <stdio.h>

main()
{
   FILE *infile, *outfile;
   int ch;

   infile = fopen( "testy.txt", "r" );
   outfile = fopen( "out.txt", "a" );

   while( (ch = getc( infile )) != EOF )
   {
      putc( ch, outfile );
   }

   fclose( infile );
   fclose( outfile );
}
