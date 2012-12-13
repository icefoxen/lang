/*
Kay, command line args.  main() has two args: argc and *argv[].
argc I think is the number of args.  *argv[] is an array of strings
or really, an array of pointers where each pointer points to a
string.  So in:

cmdline hello goodbye

argv[0] would be "cmdline", argv[1] would be "hello", and argv[2] would
be "goodbye".  argv[1][0] would be 'h', argv[1][0] would be 'e', 
argv[1][5] would be \0, etc.

I think.
*/

main( int argc, char **argv )
{
   int x;
   int y, *q;
   for( x = 0; x < argc; x++ ) /* print the args */
   {
      printf( "%s\n", argv[x] );
   }
   /* The above works, and I don't think it should... */

   y = 25;
   q = &y;
   printf( "%d\n", *q );
   printf( "%d\n", y );  /* These two should be the same... */

   printf( "%d\n", q );
   printf( "%d\n", &y );  /* If I'm right, these two should also be 
                             the same... */
/* 
Kay.  Calling *pointer reaches and grabs the VALUE of pointer.
Calling pointer grabs the ADDRESS that pointer is set to.  
So.  *y = x sets the VALUE of y to x.  y = &x sets y the ADDRESS
of y to the address of x.
You can also then do y = x, which sets the address of y to the value
of x.  And you can do *y = &x, which sets the value of y to the 
address of x.  Wild.  
*/
}
