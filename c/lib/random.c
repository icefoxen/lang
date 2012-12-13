/* Random.c
 * Implements the random.h interface.
 * RAND_MAX is defined along with all the other random functions,
 * I believe in stdlib.h
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "random.h"

/* Function: RandomInt
 * This function begins by using rand() (from stdlib.h, I believe) to
 * select an integer in the interval [0, RAND_MAX], then converts it to
 * the desired range.
 */
int RandomInt( int low, int high )
{
   int k;
	double d;

	d = (double) rand() / ((double) RAND_MAX + 1);
	k = (int) (d * (high - low + 1));

	return (low + k);
}

/* Function: RandomDouble:
 * Same as RandomInt but doesn't do the cast-to-(int) at the end.
 */
double RandomDouble( double low, double high )
{
   double d;
	d = (double) rand() / ((double) RAND_MAX + 1);
	return (low + d * (high - low));

}

/* Function: Randomize
 * Sets the random number seed.
 */
void Randomize( void )
{
   srand( (int) time( NULL ) );
}
