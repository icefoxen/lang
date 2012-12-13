/* RelPoint.h
 * This is a CATEGORY file; 'tis sorta like a subclass, 'cept it doesn't
 * define a new class, just adds to the current one.
 * This means you can break up a class into several different files.  This has
 * all the associated advantage in organization, co-development, and
 * flexibility.
 * Hmm.  Does this only work for the NeXT compiler?
 *
 * Simon Heath
 * 14/6/2003
 */

#import "Point.h"

@interface Point (RelPoint)

// We get to add new methods, but no new data.
// However, we can access all local data, even stuff marked @private.
// We can override methods declared in the base class or superclasses,
// but we can't reliably overwrite methods in other categories of the same
// class

- (BOOL) isLeftOf: (id) point;
- (BOOL) isRightOf: (id) point;
- (BOOL) isAbove: (id) point;
- (BOOL) isBelow: (id) point;
- (BOOL) isSameAs: (id) point;

@end
