module Main where

fib x =
   if x < 2 then 1
   else fib (x - 1) + fib (x - 2)

main = do
   putStrLn $ show (fib 40)
