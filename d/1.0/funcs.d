// Play with functions.


typedef int myint;
alias int int2;

void foo( int a )
{
   printf( "Passed an int!\n" );
}

void foo( myint a )
{
   printf( "Passed a myint!\n" );
}

void printArr( int[] a )
{
   foreach( int i; a )
   {
      printf( "%d ", i );
   }
   printf( "\n" );

}

int function() clostest( int a )
{
   static int b;
   b = a;
   // If you're gonna have real closures, you gotta make 'em static!
   // However, it's still not a real closure 'cause there's only one
   // instance of b
   static int ct()
   {
      b++;
      printf( "%d\n", b );
      return b;
   }
   
   return &ct;
}

struct closureobj {
   int a = 10;
   int foo() { return a; }
}


int main( char[][] args )
{
   // A variable called func that is a pointer to a function that
   // returns void and takes an int.  ^_^
   void (*func)(int);
   // A nicer function pointer syntax
   void function(int) func2;

   // You CAN theoretically cast just by doing (myint) but it's a bit
   // ambiguous, a la (myint) -10.
   // Is the above casting -10 to a myint, or subtracting 10 from the
   // var myint?
   int a = 10;
   myint b = cast(myint) 20;
   int2 c = 30;
   int d = 10;


   func = &foo;
   func2 = &foo;
   
   printf( "Testing function overloading...\n" );
   foo( a );
   foo( b );

   printf( "Testing function pointers...\n" );
   func( a );
   // Hrm... the below should be an error, ne...?  Or at least a cast...
   func( b );

   // An alias is just a name for a type, so this is an int.
   // Aliases can also do function/package names, etc.
   foo( c );

   func2( a );


   int function() clos1;
   int function() clos2;

   // Waitasec...  clos1 == clos2?  This is WEEEIRD...
   clos1 = clostest( 10 );
   clos2 = clostest( 20 );
   printf( "Closure 1\n" );
   clos1();
   clos1();
   clos1();
   printf( "Closure 2\n" );
   clos2();
   clos2();
   clos2();

   closureobj alpha;
   closureobj beta;
   alpha.a = 10;
   beta.a = 20;
   printf( "Closure struct: %d\n", alpha.foo() );
   printf( "Closure struct: %d\n", beta.foo() );


   wchar widechar = 'b';
   dchar doublechar = 'b';
   printf( "Sizeof unicode char: %d or %d\n", widechar.size, doublechar.size );

   printf( "Unicode string: " );
   foreach( wchar c; "Hello there!" )
   {
      printf( "0x%04X ", c );
   }
   printf( "\n" );

   // Array slicing!  Woohoo!
   int[10] arr1;
   // Arrays should be able to be initialized staticly, but oh well.
   foreach( int i, int foo; arr1 )
   {
      arr1[i] = i;
   }
   int[] arr2 = arr1[1..5];

   printf( "Array slices:\n" );
   printArr( arr2[] );

   printArr( arr1[3..9] );

   printArr( arr2[0..arr2.length] );

   // Array/string concatenation!
   printArr( arr1 ~ arr2 );

   printf( "foo " ~ "bar " ~ "bop" ~ "\n" );

   // A lot of the array and string handling is rather nicely
   // lifted from scripting languages...
   arr2 = arr1;
   // Hrm...  This SHOULD work, but doesn't.
   // arr1[] = arr2[] + 5;
   // printArr( arr1 )

   printf( "Array size: %d Array length: %d\n", arr1.size, arr2.length );
   printArr( arr1.reverse );
   printArr( arr1.sort );

   arr2.length = 5;
   printArr( arr2 );
   arr2.length = 15;
   printArr( arr2 );

   try {
      for( int i = 0; i < 100; i++ )
         printf( "%d ", arr1[i] );
   }
   // Should be an ArrayBoundsError, buuut... 
   catch( Error e ) {
      printf( "Eep!  Array out of bounds!  Exceptions work tho.  ^_^\n" );
   }

   // Associative arrays!!!  W00t!!!
   // And using strings for an index here causes a segfault for some reason...
   int[char] foo;
   foo['a'] = 10;
   foo['b'] = 20;
   foo['c'] = 30;
   foo['d'] = 40;
   foo['e'] = 50;
   foreach( char i, int v; foo )
   {
      printf( "%c\t->\t%d\n", i, v );
   }
   printf( "\n" );

   // Dynamic allocation
   float[] testy;
   testy = new float[30];
   delete testy;

   return 0;   
}
