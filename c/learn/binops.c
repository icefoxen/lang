/* binops.c
 * Plays with binary operations some.
 *
 * Simon Heath
 * 19/7/2004
 */

#include <stdio.h>

int main( int argc, char** argv )
{
   int a = 0xABCD;
   int b = 0xFAD3;

   printf( "%X & %X = %X\n", a, b, a & b );
   printf( "%X | %X = %X\n", a, b, a | b );
   printf( "%X ^ %X = %X\n", a, b, a ^ b );
   printf( "!%X = %X\n", a, !a );
   printf( "~%X = %X\n", a, ~a );
   printf( "~%X & %X = %X\n", a, a, ~a & a );

   return 0;
}
