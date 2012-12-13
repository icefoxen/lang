/* LinkedList.m
 * Linked list implementation
 *
 * Simon Heath
 * 19/6/2003
 */

#include <malloc.h>

#import "LinkedList.h"

@implementation LinkedList

// Allocate a new list
+ new
{
   return [super new]; 
}

// Returns true if two lists are equal
+ (BOOL) equal: lst1: lst2
{
   id itm1 = lst1, itm2 = lst2;

   // First test for length
   if( [lst1 length] != [lst2 length] )
      return NO;

   // While neither list has ended...
   while( (lst1 != nil) && (lst2 != nil) )
   {
      // If itm1 == itm2, increment 'em both and continue
      if( [itm1 getItem] == [itm2 getItem] )
      {
         itm1 = [itm1 getNext];
	 itm2 = [itm2 getNext];
      }
      // Else, they're not equal.
      else
      {
         return NO;
      }
   }

   // If both lists have ended, return true
   return YES;
}

// Concatenates two lists together and returns a new list
// Note that the pointers still point to the same objects!
+ concat: lst1: lst2
{
   // Make a new list and init it to the first item of the first list
   id newList = [[LinkedList new] init: [lst1 getItem]: nil];
   id l1 = [lst1 getNext];
   id l2 = lst2;
   
   // Add lst1 to it
   while( l1 != nil )
   {
      [newList addNode: [l1 getItem]];
      l1 = [l1 getNext];
   }

   // Add lst2 to it
   while( l2 != nil )
   {
      [newList addNode: [l2 getItem]];
      l2 = [l2 getNext];
   }
   
   return newList;
}


// Initialize a new list with no args
- init
{
   item = nil;
   next = nil;
   return self;
}

// Initialize a new list with an item and link
- init: itm: link;
{
   item = itm;
   next = link;
   return self;
}


// Returns the current node's item
- getItem
{
   return item;
}


// Returns the next node
- getNext
{
   return next;
}

// Sets the current node's item
- (void) setItem: itm
{
   item = itm;
}

// Sets the current node's link
- (void) setNext: itm
{
   next = itm;
}

// Return the list's length
- (int) length
{
   id n = self;
   int a = 0;
   while( [n getNext] != nil )
   {
      a++;
      n = [n getNext];
   }

   return a;
}

// Get the n'th node
// XXX: Hmm... does this count from 0 or 1??
- getIndex: (int) index
{
   int n = index;
   id currentNode = self;
   while( n )
   {
      n--;
      currentNode = [currentNode getNext];
   }

   return currentNode;
}

// Get the n'th node's item
- getNth: (int) index
{
   return [[self getIndex: index] getItem];
}

// Adds a new node to the end
- (void) addNode: itm
{
   id last = [self getIndex: [self length]];
   [last setNext: [[LinkedList new] init: itm: nil]];
}

// Removes the n'th node
- (void) removeNode: (int) index
{
   id node = [self getIndex: index];
   id toFree = [node getNext];
   [node setNext: [toFree getNext]];
   free( toFree );
}

// Returns the number of the node with the given item
- (int) search: itm
{
   int a = 0;
   id node = self;
   if( [node getItem] == item )
   {
      return a;
   }
   else
   {
      node = [node getNext];
      a++;
   }

   // If we don't find it...
   return -1;
}

// Appends another list onto this one
- (void) append: lst
{
   id node = lst;
   while( [node getNext] != nil )
   {
      [self addNode: [node getItem]];
      node = [node getNext];
   }
}



// Free's the single node
- freeNode
{
   return [super free];
}

// Frees the entire list
- freeList
{
   if( [self getNext] == nil )
   {
      return [self freeNode];
   }
   // Yay recursion!
   else
   {
      [[self getNext] freeList];
      return [self freeNode];
   }
}

// Frees the entire list and everything attached to it
- freeAll
{ 
   if( [self getNext] == nil )
   {
      [item free];
      [self freeNode];
   }
   // Yay recursion!
   else
   {
      [[self getNext] freeAll];
      return [self freeNode];
   }
   return self;
}

@end
