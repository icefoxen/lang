#!/usr/bin/python
def fib(x):
   if x < 2:
      return 1
   else:
      return fib( x - 1 ) + fib (x - 2)

if __name__ == "__main__":
   print( fib( 30 ) )
