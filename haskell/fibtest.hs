{- fibtest.hs
   Fibonacci test benchmark.
   Compile this!
   ...I need to figure out how to get command-line args.

   Simon Heath
   2/7/2003
-}

module Main
   where

fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n =
   fib (n - 1) + fib (n - 2)

main =
   print (fib 40)
