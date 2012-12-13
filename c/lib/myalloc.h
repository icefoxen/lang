/* myalloc.h
 * A bunch of semi-custom memory allocation functions and such.
 * Includes array-filling and stuff, useful for testing sorting programs.
 * 
 * Uses "random.h"
 * 
 * Simon Heath
 * 11/11/2002
 */

#ifndef _myalloc_h
#define _myalloc_h

#include <stdio.h>
#include <malloc.h>
#include "random.h"

#include "myalloc.c"


/* Prints out an error message. */
void Error( char c[] );


/* Like malloc(), but does error-checking. */
void *myalloc( int n );


/* Fills an integer array of size with a linear set of integers, starting with
 * start.  So if you call it FillArray( foo, 10, 5 ); the result will be an
 * array with the values:
 * 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
 */
void FillArray( int arr[], int size, int start );


/* Like the above, but the numbers entered are completely random. */
void FillRandomArray( int arr[], int size );


#endif /* _myalloc_h */
