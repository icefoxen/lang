#include <stdio.h>
#include <malloc.h>

typedef struct foo {
   int a;
   int b;
   struct foo *f;
} foo;

void printFoo( foo* a )
{
   printf( "Foo: %d, %d, with next foo at %d\n", 
           a->a, a->b, (int) a->f );
}

int main()
{
   struct foo *a = (foo*) malloc( sizeof( foo ) );
   struct foo *b = (foo*) malloc( sizeof( foo ) );

   a->a = 10;
   a->b = 20;
   a->f = b;

   b->a = 30;
   b->b = 40;
   b->f = a;
   printFoo( a );
   printFoo( b );
   printf( "bop: %d, %d\n", a->f->a, a->f->b );
   return 10;
}
