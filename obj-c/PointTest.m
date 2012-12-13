/* Tests the Point class.
 *
 * Simon Heath
 * 14/6/2003
 */

#import <stdio.h>

#import "Point.h"
#import "RelPoint.h"

int main()
{
   id p1;
   id p2;
   int x, y;
   p1 =  [[Point new] init];
   x = [p1 getX];
   y = [p1 getY];

   printf( "X: %d Y: %d\n", x, y );
   [p1 print];

   [p1 moveTo: 10: 20];
   [p1 print];

   p2 = [[Point new] init];
   [p2 moveTo: 10: 20];
   [p2 print];
   printf( "Is p1 the same as p2: %i\n", [p1 isSameAs: p2] );

   return 0;
}
