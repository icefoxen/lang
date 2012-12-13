/* mergesort.c
 * Recursive sort algorithm.
 * Efficiency is O( N log N ) --rather more efficient than Selection Sort, but
 * MergeSort's secondary overhead makes the former more efficient for small
 * arrays ( <100 elements or so ).
 *
 * I suspect it's a bit more memory intensive though.
 *
 * Simon Heath
 * 12/11/2002
 */


#include <stdio.h>
#include "lib/myalloc.h"

#define ARRLEN 10

/* MergeSort() works by splitting each array into halves, sorting each half, and
 * joining them together.  It's recursive, with the base case being an array
 * with either 0 or 1 elements, which by definition is already sorted.
 * Wild.
 */
void MergeSort( int array[], int n );


/* Merge() merges two sorted arrays together; pretty simple.
 * merges arr1 of length n1 + arr2 of length n2 into array.
 */
static void Merge( int array[], int arr1[], int n1, int arr2[], int n2 );

/* CopySubArray --pretty self-explainatory.
 */
static int *CopySubArray( int array[], int start, int n );


/* The program itself */
main()
{
	int i, s;
	int a[ ARRLEN ];

	printf( "this does a merge sort on a randomized array.\n" );
	

	Randomize();
	FillRandomArray( a, ARRLEN );

   printf( "Array is:\n" );
	for( i = 0; i < ARRLEN; i++ )
		printf( "%d ", a[i] );
	printf( "\n" );
	
	MergeSort( a, ARRLEN );

	printf( "Sorted array is:\n" ); 
	for( i = 0; i < ARRLEN; i++ )
		printf( "%d ", a[i] );
}



void MergeSort( int array[], int n )
{
	int n1, n2, *arr1, *arr2;

	if ( n <= 1 ) return;

	n1 = n / 2;
	n2 = n - n1;

	arr1 = (int *) CopySubArray( array, 0, n1 );
	arr2 = (int *) CopySubArray( array, n1, n2 );
	MergeSort( arr1, n1 );
	MergeSort( arr2, n2 );
	Merge( array, arr1, n1, arr2, n2 );

	
	/* For some reason, an error occurs with these free()'s... but why? 
	 * There's a logic error if I comment them out; could the logic error be
	 * causing them to screw up?  How?  It's hardly a large program...
	 */
	/*
	free( arr1 );
	free( arr2 );
	*/
}



static void Merge( int array[], int arr1[], int n1, int arr2[], int n2 )
{
   int p, p1, p2;
	p = p1 = p2 = 0;

	while( p1 < n1 && p2 < n2 )
	{
		if( arr1[p1] < arr2[p2] )
		{
			array[p] = arr1[p1];
			p++;
			p1++;
		}
		else
		{
			array[p] = arr2[p2];
			p++;
			p2++;
		}
	}


	while( p1 < n1 )
	{
	   array[p] = arr1[p1];
		p++;
		p1++;

	}
	while( p2 < n2 )
	{ 
	   array[p] = arr2[p2];
		p++;
		p2++;
	}

}


static int *CopySubArray( int array[], int start, int n )
{
	int i, *result;

	result = (int *) myalloc( n );
	for( i = 0; i < n; i++ )
		*(result + i) = array[ start + i ];

	return result;
}
