#include <book.h>

int main()
{
   Book a( "Their book", "Them", "00000", 1453, 12 );
   Book *b = new Book( "My Book", "Me", "12456", 1995, 2543 );
   
   a.printBook();
   b->printBook();

   delete b;
}
