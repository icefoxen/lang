/* The actual implementation is simple,
 * we just add methods/predicates that tell where it is in relation to
 * another Point object.
 *
 * Simon Heath
 * 14/6/2003
 */

#import "RelPoint.h"

@implementation Point (RelPoint)

- (BOOL) isLeftOf: (id) point
{
   if( x < [point getX] )
      return YES;
   else
      return NO;
}

- (BOOL) isRightOf: (id) point
{
   if( x > [point getX] )
      return YES;
   else
      return NO;
}

- (BOOL) isAbove: (id) point
{
   if( y > [point getY] )
      return YES;
   else
      return NO;
}

- (BOOL) isBelow: (id) point
{
   if( y < [point getY] )
      return YES;
   else
      return NO;
}

- (BOOL) isSameAs: (id) point
{
   if( x == [point getX] && y == [point getY] )
      return YES;
   else
      return NO;
}

@end
