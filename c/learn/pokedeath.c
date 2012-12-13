/* Poke 'o Death.c
   Basically sets a pointer at the beginning of your memory and lets
   it run free.  Bye bye. */

main()
{
   char *x = 1;
   while( 1 )
      printf( "%d", *x );
      *x++;
}
