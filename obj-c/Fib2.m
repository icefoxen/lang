#import <objc/Object.h>
#import <stdio.h>

@interface Fib : Object
{
}
- (int) fib: (int) x;
- (int) add: (int) x: (int) y;
- (int) sub: (int) x: (int) y;

@end

@implementation Fib

- (int) fib: (int) x
{
   if( x < 2 )
      return 1;
   else
      return [self add: 
                [self fib: [self sub: x: 1]]: 
		[self fib: [self sub: x: 2]]];
}

- (int) add: (int) x: (int) y
{
   return x + y;
}

- (int) sub: (int) x: (int) y
{
   return x - y;
}

@end


int main(int argc, char **argv )
{
   id f = [Fib new];
   printf( "%d\n", [f fib: 40] );
   return 0;
}

