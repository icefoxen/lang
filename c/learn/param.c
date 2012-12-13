/* param.c 
Differentiates 'tween two different styles of function args.
GCC accepts both.  */

ansi( int a, int b, int c )  /* This is the ANSI C method, java-ish. */
{
   printf( "ansi: %d%d%d\n", a, b, c );
   a = 2; b = 4; c = 6;
   printf( "after: %d%d%d\n", a, b, c );
}

noansi( a, b, c )  /* This is non-ansi */
int a, b, c;
{
   printf( "noansi: %d%d%d\n", a, b, c );
   a = 2; b = 4; c = 6;
   printf( "after: %d%d%d\n", a, b, c );
}

main()
{
   int a, b, c;
   a = 1; b = 2; c = 3;
   ansi( a, b, c );
   noansi( a, b, c );
   return 0;
}
