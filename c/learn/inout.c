/* Tests standard input and output junkin.
 * Also sorta half-asses an input system.
 *
 * ...it gets some really weird results when using a getc() loop to build a
 * string, then printing it out with printf().
 * It also seems that getc()'s system-blocking creates some pretty wonky 
 * effects on the last while loop...  it blocks and reads into a 128-char
 * buffer until the while condition is met.
 * 
 * AH!  When getc() blocks, stdin is read into a buffer.  It then reads from
 * THAT BUFFER, not the device directly!
 *
 * Gods, if C is this mind-bending, I can't imagine what assembler must be
 * like.
 *
 * Simon Heath
 * 7/11/2002
 */

#include <stdio.h>
#define STRLEN 64

main()
{
   char str[STRLEN];
   int i = 0;
   char buf;

   printf( "This should just read the stdin to a buffer, then print it.\n" );
   for( i = 0; i < STRLEN; i++ )
   {
      str[i] = getc( stdin );
      if( str[i] == '\n' ) break;
      if( i == STRLEN ) break;
   }

   printf( "I'm gonna print it using a putc() loop, then with printf()\n" );

   for( i = 0; i < STRLEN; i++ )
      putc( str[i], stdout );

   printf( "%s\n\n", str );


   printf( "This should just getc() the stdin, then immedietely output it.\n" );
   printf( "Hit return to terminate it.\n" );

   while( (buf = getc( stdin )) != '\n' )
      putc( buf, stdout );

   printf( "\nThis is just a last test of a single getc and putc call.\n" );

   buf = getc( stdin );
   putc( '\n', stdout );
   putc( buf, stdout);
}
