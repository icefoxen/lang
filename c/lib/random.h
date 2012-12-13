/* random.h
 * An interface for generating pseudorandom numbers.
 * ....shouldn't it include random.c???
 */
#ifndef _random_h
#define _random_h
#include "random.c"

/* Function: RandomInt
 * Returns a random integer in the range low to high inclusive.
 */
int RandomInt( int low, int high );

/* Function: RandomDouble
 * Returns a random double in the range low to high, excluding high.
 */
double RandomDouble( double low, double high );


/* Function: Randomize
 * Seeds the random number generator.
 */
void Randomize( void );

#endif
