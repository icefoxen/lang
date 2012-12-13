#import <objc/Object.h>

@interface List : Object   // Inherits from class Object
{
   // We declare the class variables HERE!
   int list[100];
   int size;
}

// Public methods
- free;
- (int) addEntry: (int) num;
- print;

// Private methods
- resetSize;

@end
