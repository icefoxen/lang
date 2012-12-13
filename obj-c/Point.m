/* Implementation.  Yay!
 *
 * Simon Heath
 * 14/6/2003
 */

#import "Point.h"

@implementation Point

+ new
{
   return [super new];
}

- init
{
   x = 0;
   y = 0;
   return self;
}

- (int) getX
{
   return x;
}

- (int) getY
{
   return y;
}

- (void) moveTo: (int) newx: (int) newy
{
   x = newx;
   y = newy;
}

- (void) print
{
   printf( "(%d, %d)\n", x, y );
}

@end
