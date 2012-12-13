#include <stdio.h>
extern int asm_main();

void fop( int n )
{
   printf( "Fop!  %d\n", n );
}

int main () 
{
	printf( "%d\n", asm_main() );
	return 0;
}
