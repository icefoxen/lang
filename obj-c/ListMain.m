#import <objc/Object.h>
#import "List.h"

int main()
{
   id list;             // id is the type for an OBJECT.

   list = [List new];
   [list addEntry: 5];
   [list print];
   [list addEntry: 6];
   [list addEntry: 3];
   [list print];
   [list free];         // Get rid of the thang.

   return 0;
}
