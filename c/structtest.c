#include <stdio.h>
#include <malloc.h>

typedef struct foo {
   int a;
   double b;
} foo;

typedef struct bar {
   struct foo a;
   foo* b;
} bar;

int main()
{
   foo a;
   bar b;
   b.a = a;
   return 0;
}
