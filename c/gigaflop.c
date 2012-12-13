#include <stdio.h>

int main() {
   float d = 0;
   int i = 0;
   for( i = 0; i < 1000000000; i++ ) {
      d = d + 1;
   }
   printf( "%d\n", d );
   return 0;
}
