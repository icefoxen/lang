/* Testing a function to merge arrays.
 *
 * Simon Heath
 * 14/11/2002
 */

#include <stdio.h>
#include "lib/myalloc.h"

#define ARRLEN 10

static void merge( int array[], int arr1[], int n1, int arr2[], int n2 );

main()
{
	int arr1[] = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
	int arr2[] = { 5, 15, 25, 35, 45, 55, 65, 75, 85, 95 };
	int i;
	int array[20];

   printf( "\nArray 1:\n" );
	for( i = 0; i < ARRLEN; i++ )
		printf( "%d ", arr1[i] );
	
   printf( "\nArray 2:\n" );
	for( i = 0; i < ARRLEN; i++ )
		printf( "%d ", arr2[i] );
	
	printf( "\n\n" );
   merge( array, arr1, ARRLEN, arr2, ARRLEN );

   printf( "\nResult:\n" );
	for( i = 0; i < ARRLEN * 2; i++ )
		printf( "%d ", array[i] );
}

static void merge( int array[], int arr1[], int n1, int arr2[], int n2 )
{
   int p, p1, p2;
	p = p1 = p2 = 0;

	while( p1 < n1 && p2 < n2 )
	{
		if( arr1[p1] < arr2[p2] )
		{
			array[p] = arr1[p1];
			printf( "array[%d]\t=\tarr1[%d]\n%d\t%d\n", p, p1, array[p], arr1[p1] );
			p++;
			p1++;
		}
		else
		{
			array[p] = arr2[p2];
			printf( "array[%d]\t=\tarr2[%d]\n%d\t%d\n", p, p2, array[p], arr1[p2] );
			p++;
			p2++;
		}
	}


	while( p1 < n1 )
	{
	   array[p] = arr1[p1];
		printf( "array[%d]\t=\tarr1[%d]\n%d\t%d\n", p, p1, array[p], arr1[p1] );
		p++;
		p1++;

	}
	while( p2 < n2 )
	{ 
	   array[p] = arr2[p2];
		printf( "array[%d]\t=\tarr2[%d]\n%d\t%d\n", p, p2, array[p], arr1[p2] );
		p++;
		p2++;
	}

}
