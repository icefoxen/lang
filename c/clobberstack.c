#include <stdio.h>

int clobber( int a, int b )
{
   int c, d, e;
   c = 20;
   d = 30;
   e = 40;
   return a + b + c + d + e; 
}

void pointerthang( char* a )
{
   char b[] = "Blop!";
   a = b;
}

int main()
{
   char* a = "Hello world!";
   int b;
   pointerthang( a );
   printf( "a = %s\n", a );
   b = clobber( 10, 20 );
   printf( "a = %s\n", a );
   return 0;
}
