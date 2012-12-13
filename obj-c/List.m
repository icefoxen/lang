#import "List.h"    // Shibby, no more #include's!  Yaay!

@implementation List

// What does the + and - mean?  I forget...
// The rest of this is pretty straightforward though.
// Class variables are defined in the INTERFACE, though!
+ new
{
   self = [super new];
   [self resetSize];
   return self;
}

- free
{
   return [super free];
}

// Takes an argument of type int called num, and returns an int
- (int) addEntry: (int) num
{
   list[size++] = num;
   return size;
}

- print
{
   int i;

   printf( "\n" );
   for( i = 0; i < size; ++i )
      printf( "%i ", list[i] );
   return self;
}

- resetSize
{
   size = 0;
   return self;
}

@end
