/* selectsort.c 
 * Does a selection-sort of an array.
 * Okay for small arrays; computation time increases rather geometrically with
 * the array size, though.
 *
 * Number of operations N is roughly:
 * O( N^2 / 2 )
 * 
 * I may implement this as a library if I ever need to.
 *
 * 
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>
#include "lib/myalloc.h"

#define ARRLEN 20000


/* SelectSort
 * Does a selection-sort of an integer array
 */
void SelectSort( int array[], int n )
{
	int lh, rh, i, temp;

	for( lh = 0; lh < n; lh++ )
	{
		rh = lh;
		for( i = lh + 1; i < n; i++ )
		{
			if( array[i] < array[rh] ) rh = i;
		}

		temp = array[lh];
		array[lh] = array[rh];
		array[rh] = temp;
				 
	}
}


main()
{
	int i, s;
	int a[ ARRLEN ];

	printf( "this does a selection sort on a randomized array.\n" );
	

	FillRandomArray( a, ARRLEN );

   printf( "Array is:\n" );
	for( i = 0; i < ARRLEN; i++ )
		printf( "%d ", a[i] );
	printf( "\n" );
	
	SelectSort( a, ARRLEN );

	printf( "Sorted array is:\n" ); 
	for( i = 0; i < ARRLEN; i++ )
		printf( "%d ", a[i] );
}
