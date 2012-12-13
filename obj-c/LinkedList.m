// This is the actual implementation
// ...This is rather funny.  I'm screwing up because I'm writing
// procedurally in an object-oriented language.

#import "LinkedList.h"

@implementation LinkedList

// Define NEW function... the + means it's a class function
// (like "static" in Java)
+ new
{
   self = [super new];
   [self init];
   return self;
}

// Init method
- init
{
   [super init];  // ?
   item = 0;
   next = nil;
}


// Define get method
- (void *) getItem: (int) index
{
   return [self getItemRec: index: 0];
}

// Driver function for "getItem"
- (int) getItemRec: (int) index: (int) current
{
   if( index == current )
      return item;
   else if( index == (int) nil )
      // Check if it's not there...
      return nil;
   else
      // The "self" here is just a tad necessary...
      return [self getItemRec: index: current++];
}

// Adds an item to the list.
- (void) addItem: (int) itm
{
   id currentNode = nil;
   while( currentNode->next != nil )
   {
      currentNode = currentNode->next;
   }
   currentNode->next = itm;
}

// Returns length of the list
// Let's do it iteratively this time.
- (int) length
{
   id currentNode = self;
   int count = 0;
   while( currentNode->next != nil )
   {
      count++;
      currentNode = currentNode->next;
   }
   return count;
}


// Prints the list.
- print
{
   id currentNode = self;
   while( currentNode->next != nil )
   {
      printf( "%d ", currentNode->item );
      currentNode = currentNode->next;
   }
}

- (int) isEmpty
{
   if( next == nil )
      return 1;
   else
      return 0;
}

@end
