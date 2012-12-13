/* detab.c
 * turns tabs into three-space indents.
 * 
 * Simon Heath
 * 3/11/2002
 */

#include <stdio.h>
#include <string.h>

void usage()
{
   printf( "Turns all the tabs in a file into spaces.\n" );
   printf( "Usage:  detab <infile> <outfile>\n\n" );
   exit( 0 );
}


main( int argc, char **argv )
{
   FILE *infile, *outfile;
   int ch;

   if( argc < 2 )
   {
      usage();
   }

   infile = fopen( argv[1], "r" );
   outfile = fopen( argv[2], "a" );

   while( (ch = getc( infile )) != EOF )
   {
      if( ch == '\t' )
         fputs( "        ", outfile );
      else
         putc( ch, outfile );
   }

   fclose( infile );
   fclose( outfile );
}


