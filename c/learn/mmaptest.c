/* mmaptest.c
   Playing with mmap(2).
   Who wants to bet this'll cause mucho crasho?

   Run two instances of it at once and see what happens...
   Hey!  It actually works!

   Simon Heath
   15/05/2004
*/

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int main( int argc, char** argv )
{
   int f = open( "/home/icefox/my.src/c/foo", O_RDWR  );
   /* mmap( start, length, prot, flags, fd, offset ) */
   int* n = mmap( 0, 20, PROT_READ | PROT_WRITE, MAP_SHARED, f, 0 );
   printf( "Stuff read from map: %X %X %X\n", *n, *(n + 1), *(n + 2) );
   printf( "Writing 10, 20, 30 to map.\n" );
   *n = 10;
   *(n + 1) = 20;
   *(n + 2) = 30;

   sleep( 10 );

   if( munmap( n, 10 ) )
      printf( "Memory failed to unmap!\n" );
   else
      printf( "Memory unmapped correctly\n" );

   return 0;
}
