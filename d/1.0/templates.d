// Hmmm.

import std.c.stdio;


// Generic copy template
template TCopy(T)
{
   void copy( T from, out T to )
   {
      to = from;
   }
}

// Erf?  What's the point of this?
// Templates can be overloaded just like functions, but...
template Foo( U : int, int T : 10 )
{
   U x = T;
}

template Foo( U )
{

   char[] fop = U;
}

// Erm!

template factorial(int n : 1)
{
   enum { factorial = 1 }
}

template factorial(int n)
{
   // Note: . ish used to find global template rather than enum
   enum { factorial = n * .factorial!(n-1) }
}

// Muahahaha...  >_>
// Recall that anonymous enums are used for unique constants.
template fib( int n : 0 )
{
   enum { fib = 1 }
}
template fib( int n : 1 )
{
   enum { fib = 1 }
}
template fib( int n )
{
   enum { fib = .fib!( n - 1 ) + .fib!( n - 2 ) }
}


// Versions can be stacked!  Cool!
version = Foo;
version = Bar;

int main( char[][] args )
{
   int i;
   TCopy!(int).copy( 3, i );

   char[] d;
   TCopy!(char[]).copy( "Hello!", d );

   printf( "%d\n", i );
   // Causes a segfault...  o_O
   //printf( "%s\n", d );
   // Works fine... O_o
   puts( d );

   assert( Foo!(int, 10).x == 10 );

   printf( "Fact 10: %d\n", factorial!( 10 ) );
   printf( "Fib 10: %d\n", fib!( 10 ) );


   version( Foo )
   {
      puts( "Version foo!" );
   }
   version( Bar )
   {
      puts( "Version bar!" );
   }
   debug
   {
      puts( "Debugging on!" );
   }

   return 0;
}
