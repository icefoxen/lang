// Tests global scope and module stuff...

import module2;

int x = 10;
char[] a = "Local a\n";
char[] b = "Local b\n";

int main( char[][] args )
{
   int x = 20;

   printf( "local x: %d, global x: %d\n", x, .x );

   printf( a );
   printf( b );
   printf( module2.a );
   printf( module2.b );

   return 0;
}
