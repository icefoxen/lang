{- fibtest2.hs
   Fibonacci test benchmark.  This calculates several values in sequence,
   demonstrating the "do" keyword.  "do" allows sequencing and makes sure that
   all the thangs are executed, which isn't a given in a lazy language.
   Compile this!

   Simon Heath
   2/7/2003
-}

module Main
   where

fib 0 = 1
fib 1 = 1
fib n =
   fib (n - 1) + fib (n - 2)

main = do
   print "fib 25: "
   print (fib 25)
   print "fib 30: "
   print (fib 30)
   print "fib 32: "
   print (fib 32)
   print "fib 35: "
   print (fib 35)
