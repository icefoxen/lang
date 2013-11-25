module Main
   where

-- Trying this with Int and Num
--fib :: Num -> Num
fib 0 = 1
fib 1 = 1
fib n =
   fib (n - 1) + fib (n - 2)

main =
   print (fib 40)
