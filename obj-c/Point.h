/* Testing of the Portable Object compiler.
 *
 * Simon Heath
 * 14/6/2003
 */

#import <objc/Object.h>
#import "Proto.h"


@interface Point : Object // < Proto > // Protocol decleration
// Hmm...  It doesn't look like the Portable Object Compiler supports
// protocols, either...  
{
   int x;
   int y; 

}

+ new;
- init;

- (int) getX;
- (int) getY;
- (void) moveTo: (int) newx: (int) newy;
- (void) print;
@end
