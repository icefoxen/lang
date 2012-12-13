#import <objc/Object.h>
#import <stdio.h>

@interface Fib : Object
{
}
- (int) fib: (int) x;

@end

@implementation Fib

- (int) fib: (int) x
{
   if( x < 2 )
      return 1;
   else
      return ([self fib: (x - 1)] + [self fib: (x - 2)]);
}

@end


int main(int argc, char **argv )
{
   id f = [Fib new];
   printf( "%d\n", [f fib: 40] );
   return 0;
}

