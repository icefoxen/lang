/* rlimit_test.c
   Plays with the getrlimit and setrlimit functions.
   See the man pages for more detail.  They do low-level stuff like
   memory manamgement and so on.

   Simon Heath
   9/3/2005
*/

#include <sys/time.h>
#include <sys/resource.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>
#include <malloc.h>
#include <string.h>

/*
struct rlimit {
   rlim_t rlim_cur;
   rlim_t rlim_max;
} rlimit;
*/

void fiddleStack( int i, int lim )
{
   struct rlimit a;
   if( i == lim )
      return;
   else
   {
      getrlimit( RLIMIT_STACK, &a );
      printf( "Recursling #%d...  stack rlimit soft limit: %d hard limit: %d\n",
              i, a.rlim_cur, a.rlim_max );
      fiddleStack( i + 1, lim );
   }
   return;
}

int main()
{
   struct rlimit a[RLIMIT_NLIMITS];
   struct rlimit b;
   int i;
   char* c;

   for( i = 0; i < RLIMIT_NLIMITS; i++ ) 
   {
      getrlimit( i, &a[i] );
      printf( "Resource %d: softlim: %u hardlim: %u\n", i, a[i].rlim_cur,
              a[i].rlim_max );
   }

   /* Try to decrease the stack size */
   b.rlim_cur = 10;
   b.rlim_max = 20;
   setrlimit( RLIMIT_STACK, &b );
   fiddleStack( 0, 100 );

   /* Play with the heap size */
   if( !setrlimit( RLIMIT_DATA, &b ) ) 
   {
      printf( "Error: %s\n", strerror( i ) );
   }
   c = malloc( 1000000 ); 

   return 0;
}
