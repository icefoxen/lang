/* Wrapper for being able to allocate and free memory from assembly.
 * Takes an integer argument from the stack, returns a pointer to the
 * memory in eax.
 *
 * Simon Heath
 * 22/5/2003
 */

#include <malloc.h>

int *allocate( int n )
{
   return malloc( n );
}

void freemem( char *n )
{
   return free( n );
}
