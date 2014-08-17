#include <stdlib.h>
#include <malloc.h>

#define COUNT 1024
int main() {
   void *x[COUNT]; 
   int counter = 0;

   for(int i = 0; i < COUNT; i++) {
      x[i] = NULL;
   }

   for(int i = 0; i < 100000; i++) {
      if(rand() % 100 > 50) {
         if(counter < COUNT-1) {
            x[counter] = malloc(72);
            counter += 1;
         }
      }
      if(rand() % 100 > 50) {
         if(counter > 0) {
            x[counter] = NULL;
            counter -= 1;
         } else {
            malloc(72);
         }
      }
   }
}
