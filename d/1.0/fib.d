// fib.d
// Speed test!

int fib( int i )
{
   if( i < 2 )
      return 1;
   else
      return fib( i - 1 ) + fib( i - 2 );
}

int main( char[][] args )
{
   printf( "Fib 40: %d\n", fib( 40 ) );
   return 0;
}
