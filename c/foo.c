#include <stdio.h>

typedef size_t fop;

int main()
{
   size_t a = 10;
   fop b = 30;
   a += 20;
   b += a;
   return a - b + 1;
}
