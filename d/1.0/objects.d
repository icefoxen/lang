// Yay OO-ish-ness!
// Here's to hoping it doesn't reek TOO much of C++.
// Simon Heath
// 22/04/2004


class Foo
{
   int a = -1;
   long b = 7;
   float c = 1;  // Initializer for floats is NaN

   this()
   {
      printf( "Class Foo: Constructor called!\n" );
   }
   this( int na )
   {
      b = na;
      printf( "Class Foo: Constructor called with arg!\n" );
   }

   invariant
   {
      assert( a <= 0 );
      assert( c >= 0 );
   }

   void fop()
   {
      printf( "Class Foo: a: %d b: %d c: %f\n", a, b, c );
   }

   ~this()
   {
      printf( "Class Foo: Destructor called!\n" );
   }
}

class Bar : Foo
{
   int d;

   this( int x, int y )
   {
      a = x;
      c = y;
      super( 10 );
   }

   ~this()
   {
      printf( "Class Bar: Destructor called!\n" );
   }
}


int main( char[][] args )
{
   Foo a = new Foo;
   Bar b = new Bar( -15, 20 );

   return 0;
}
