module Main where

sieve (p:ns) = p:(sieve [n | n <- ns, n `mod` p /= 0])

main = do
  let primes = sieve [2..] in 
    print (show (take 1000000 primes))
