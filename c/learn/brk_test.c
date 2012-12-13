/* brk_test.c
   Playing with brk and sbrk.
   Includes a bit of dabbling with raw pointers and signal handlers.

   Simon Heath
   10/3/2005
*/

#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

int* b;

void printB( int f )
{
   printf( "Smashed something important at: 0x%X\n", (int) b );
   exit( 1 );
}

int main()
{
   /* We get the current data segment end and set signal handler */
   int c;
   int a = (int) sbrk( 0 );
   signal( SIGSEGV, printB );
   
   printf( "Current data segment end: 0x%X\n", a );
   /* We increase the data segment size (if we add 0x2FFFFFFF we get ENOMEM,
    * and if we add 0xFFFFFFFF it wraps right around the address space) */
   /*  Same as sbrk( ... ) */
   if( brk( (void*) (a + 0x1FFFFFFF) ) )
   {
      c = errno;
      printf( "Error with brk: %s\n", strerror( c ) );
   }
   /* We get it again and print it out */
   a = (int) sbrk( 0 );
   printf( "Current data segment end: 0x%X\n", a );
   /* We find out just how big it really is; how far we can go off the end
      of the address space before we smash something.  This is what the signal
      handler is for. */
   b = (void*) a;
   for( ;;b++ )
      *b = (int) b;

   return 0;
}
