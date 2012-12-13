/* pointdemo.c
   Demonstrates using pointers to do call-by-reference instead of
   the usual call-by-value.  */

/* Is past two ints and pointers to two more.  It compares the ints
   and sets the pointers to the larger and smaller ones.  */

void MinMax( X, Y, Minptr, Maxptr )
   int X, Y, *Minptr, *Maxptr;
{
   if ( X < Y )
   {
      *Minptr = X;
      *Maxptr = Y;
/* Alternative:  Pass the vars themselves and do *Minptr = &X;
   Well, yes, you can, but it'll cause a core dump. */
   }
   else
   {
      *Minptr = Y;
      *Maxptr = X;
   }
}

main()
{
   int var1 = 54, 
       var2 = 12;

   printf( "We have two numbers, var1= %d and var2= %d.\n\
Will use pointers and call-by-reference to set var1 to the smaller\n\
number, and var2 to the bigger number.\n\
This is important 'cause these are NOT global vars, \n\
but we still affect them outside the main() function!\n\n", var1, var2 );

   MinMax( var1, var2, var1, var2 );

   printf( "Now, var1= %d and var2= %d", &var1, &var2 );
}
