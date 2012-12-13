// Tests the LinkedList class

#import "LinkedList.h"

int main()
{
   id lst = [LinkedList new];
   [lst addItem: 10];
   [lst addItem: 20];
   [lst addItem: 30];

   printf( "Length of list is: %d\n", [lst length] );
   if( [lst isEmpty] )
      printf( "List is empty\n" );
   else
      printf( "List is not empty\n" );

   [lst print];

   return 0;
}
