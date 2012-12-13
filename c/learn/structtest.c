/*
Struct test.
Demonstrates structs.  This lets you define new data structures.
Simple.
Simon Heath
29/09/2002
*/

main()
{
   struct aleph
   {
      int one, two;
      char let;
   };
   /* That defines a data type called "aleph" with three variables:
      ints one and two, and char let. */

   struct aleph ay, bee;  /* CREATES two structures of type aleph,
                             named ay and bee. */
   struct aleph *p;       /* creates a struct pointer */

   ay.one = 1;
   ay.two = 2;
   ay.let = 'c';
   /* Sets values to ay's variables.  I think you can also make 
      defaults in the initial struct definition.  Wouldn't surprise
      me.  */

   bee.one = 5;
   bee.two = 10;
   bee.let = 'S';


   printf( " ay.one == %d\n ay.two == %d\n ay.let == %c\n", 
      ay.one, ay.two, ay.let );
   printf( "  bee.one == %d\n  bee.two == %d\n  bee.let = %c\n",
      bee.one, bee.two, bee.let );


   p = &ay;  /* Sets p to point at ay --call-by-reference, remember */
   p->one = 10;  /* Sets ay.one to 10 */

   printf( "p->one = %d\tay.one = %d\n", p->one, ay.one );
   /* The above should be identical */

   printf( "p's addr: %d\n", p );
   p++;     /* Increments p's address */
   printf( "p's incremented addr: %d\n", p );
   printf( "p's value is now %d\b", *p );
}

