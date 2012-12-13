/* binsearch.c
 * Does a binary-search of a sorted array.
 *
 * I may implement this as a library if I ever need to.
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>
#include "lib/myalloc.h"


/* BinSearch
 * Wrapper around BinarySearch
 * index = BinSearch( key, array, arrlen )
 */
int BinSearch( int key, int array[], int arrlen )
{
	return BinarySearch ( key, array, 0, arrlen - 1 );
}



/* BinarySearch
 * Does the work for BinSearch
 */
int BinarySearch( int key, int array[], int low, int high )
{
	int mid;

	if( low > high ) return -1;  /* not found */

	mid = (low + high) / 2;
	if( key == array[mid] ) 
	{
		printf( "Found at index %d\n", mid );
		return mid; /* found */
	}

	if( key >= mid ) /* keep looking */
	{
		printf( "Looking between %d and %d\n", mid + 1, high );
		return BinarySearch( key, array, mid + 1, high );
	}
	else
   {
		printf( "Lookinb between %d and %d\n", low, mid - 1 );
		return BinarySearch( key, array, low, mid - 1 );
	}
}

main()
{
	int i, s;
	int target;
	int a[50];

	printf( "Enter an integer to search for\n" );
	scanf( "%d", &target );


	FillArray( a, 50, 0 );

   printf( "Array is:\n" );
	for( i = 0; i < 50; i++ )
		printf( "%d ", a[i] );
	printf( "\n" );
	
	s = BinSearch( target, a, 50 );

	if( s < 0 ) printf( "Key not found\n" );
	else printf( "Key found at index %d\n", s );
}
