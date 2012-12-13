/* QuickSort.  You know what that is.
 *
 * Simon Heath
 * 14/11/2002
 */


#include <stdio.h>
#include "lib/myalloc.h"

#define ARRLEN 100000

/* QuickSort -- Recursive sort function.  You get the idea.
 */
void QuickSort( int array[], int n );

/* Partition --seperates an array so that all values on the left are lower
 * than the "pivot" point, and all on the right are higher.
 */
static int Partition( int array[], int n );


/* The program itself */
main()
{
	int i, s;
	int a[ ARRLEN ];

	printf( "this does a quicksort on a randomized array.\n" );
	

	Randomize();
	FillRandomArray( a, ARRLEN );

   printf( "Array is:\n" );
	for( i = ARRLEN - 100; i < ARRLEN; i++ )
		printf( "%d ", a[i] );
	printf( "\n" );
	
	QuickSort( a, ARRLEN );

	printf( "Sorted array is:\n" ); 
	for( i = ARRLEN - 100; i < ARRLEN; i++ )
		printf( "%d ", a[i] );
}


void QuickSort( int array[], int n )
{
	int boundary;

	if( n < 2 ) return;

	boundary = Partition( array, n );

	QuickSort( array, boundary );
	QuickSort( array + boundary + 1, n - boundary - 1 );
}

static int Partition( int array[], int n )
{
	int lh, rh, pivot, temp;

	pivot = array[0];
	lh = 1;
	rh = n - 1;

	while( 1 )
	{
		while( lh < rh && array[rh] >= pivot) rh--;
		while( lh < rh && array[lh] < pivot) lh++;
		if( lh == rh ) break;
		temp = array[lh];
		array[lh] = array[rh];
		array[rh] = temp;
	}
	if( array[lh] >= pivot) return 0;
	array[0] = array[lh];
	array[lh] = pivot;
	return lh;
}

