// LinkedList.h
// Linked list implementation in Objective C.
// Just does integers.
// Let's see how good we really are.
// 
// Simon Heath
// 13/6/2003

#import <objc/Object.h>

// Declare the class and inheritance
@interface LinkedList : Object
{
   // Declare the local variables
   @public
   int item;
   id next;
}

// Public methods
- (int) getItem: (int) index;
- setItem: (int) itm;
- (int) length;
- addNode: (int) itm: (id) nxt;
- removeNode: (int) index;
- addNodeAfter: (int) itm: (int) index;
- print;
- (int) isEmpty;
//- free;

// Private methods
- init;
- (void *) getItemRec: (int) index: (int) current;

@end
