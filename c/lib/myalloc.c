/* myalloc.c
 * Some memory-allocation functions with a bit of error checking and such
 * built in.  Also a couple things to easily build arrays for checking.
 *
 * Simon Heath
 * 11/11/2002
 */


/* Beeps and prints an error message to stderr */
void Error( char c[] )
{
	printf( "\x07" ); /* beep */
	fprintf( stderr, "This guy can't even program me right!\n" );
	fprintf( stderr, "Error: %s\n", c );
}

void *myalloc( int h )
{
	void *t;
	t = malloc( h );
	if (t == NULL) Error( "No memory avaliable." );
}

void FillArray( int *arr, int size, int start )
{
	int i;
	for( i = 0; i < size; i++ )
	{
		*arr = i + start;
		arr++;
	}
}

void FillRandomArray( int *arr, int size )
{
	int i;
	Randomize(); /* init random number generator */

	for( i = 0; i < size; i++ )
	{
		*arr = RandomInt( -10000, 10000);
		arr++;
	}
}
