/* unions.c
 * Tests union data structs.
 * Perhaps this'll make polymorphism easier.
 * Yeesh.
 *
 * Simon Heath
 * 23/12/2003
 */

#include <stdio.h>
#include <malloc.h>

typedef union {
   int a;
   char b;
   double c;
} foo;


int main()
{
   foo *a;
   a = (foo *) malloc( sizeof( foo ) );

   a->a = 10;
   printf( "a: %d\n", a->a );

   a->b = 'c';
   printf( "b: %c\n", a->b );

   a->c = 91.43;
   printf( "c: %f\n", a->c );

   printf( "a again: %d\n", a->a );

   return 0;
}
