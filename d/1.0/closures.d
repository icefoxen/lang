// Hmm.  DYNAMIC closures, not static closures.
// Eek.  Silly of them.

int delegate() foo()
{
   int a = 10;
   int bar()
   {
      // Well, that's right at least.
      int c = 10;
      return c;
   }

   return &bar;
}

int clobberStackNastily()
{
   int a = 10;
   int b = 20;
   int c = 30;
   int d = 40;
   int e = 50;
   return a + b + c + d + e;
}

struct Bop
{   int a = 7;
   int bar() { return a; }
}

int boo(int delegate() dg)
{
   return dg() + 1;
}


void test()
{
   int x = 27;
   int abc() { return x; }
   Bop f;
   
   printf( "Local function: %d  Faux-static closure: %d\n", 
           boo( &abc ), boo( &f.bar ) );
}

/* Heh... Cycles like this won't work.  The type system forbids it.  ^_^
void test2()
{
   int x = 91;
   int fop1( int delegate() a )
   {
      printf( "Fop1: %d\n", a() );
      int fop2( int delegate() b )
      {
         printf( "Fop2: %d\n", b() );
         return b() + 5;
      }
      return fop2( a ) + a();
   }

   int fop3( int delgate( int delegate(...) )

   printf( "test2: %d\n", fop1( &fop1 ) );
}
*/

int main( char[][] args )
{
   int a = 20;
   int delegate() f = foo();
   clobberStackNastily();
   int b = f();

   printf( "%d\n", b );
   test();
   return 0;
}
