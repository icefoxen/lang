#include <stdio.h>
int main()
{
   printf( "Foo!\n" );
   asm( "jmp _start" );
   return 0;
}
