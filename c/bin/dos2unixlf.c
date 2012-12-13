/* dos2unixlf.c
   Turns dos-style linefeeds into unix-style linefeeds.
   Hopefully.

   Simon Heath
   19/12/2002
*/

#include <stdio.h>
#include <string.h>

void usage()
{
   printf( 
     "Turns all DOS-style linefeeds in a file into UNIX-style linefeeds.\n" );
   printf( "Usage: dos2unixlf <infile> <outfile>\n" ); 
   printf( "Make sure <infile> and <outfile> are different.\n\n" );
   exit( 1 );
}

main( int argc, char **argv )
{
   FILE *infile, *outfile;
   int ch;

   if( strcmp( argv[1], "--help" ) || strcmp( argv[1], "-h" ) )
   {
      usage(); 
      exit( 0 );
   }
   else if( argc < 2 )
   {
      infile = stdin;
      outfile = stdout;
   }
   else
   {
      infile = fopen( argv[1], "r" );
      outfile = fopen( argv[2], "a" );

   }

   while( (ch = getc( infile)) != EOF )
   {
      if( ch == 0x0d )
         ;
      else
         putc( ch, outfile );
   }

   fclose( infile );
   fclose( outfile );

}
