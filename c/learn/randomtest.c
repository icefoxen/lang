/* Tests the random.c and random.h library.
 * Simon Heath
 * 3/11/2002
 */

#include "../lib/random.h"

main()
{
   int r1;
   double r2;

   Randomize();
   printf( "Random seed set\n" );

   r1 = RandomInt( 1, 10 );
   r2 = RandomDouble( (double) 2, (double) 20 );

   printf( "Random numbers created.\n" );

   printf( "Random int between 1 and 10: %d\n", r1 );
   printf( "Random double between 2 and 20: %f\n", r2 );
}

