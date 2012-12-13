{- testy2.hs
   Oh, in case I forget, line comments start with --, like Eiffel.
   This is just some silly tests.  Meant to be interpreted, not compiled.
   A handy trick in the interpreter is typing :r to reload a file.  ^_^

   Simon Heath
   2/7/2003
-}

module Testy2
   where

-- Just an if/then test
signum x =
   if x < 0
      then -1
      else if x == 0
         then 0
         else 1


-- Pattern matching!  Yay!
caseof x =
   case x of
      1 -> 10
      2 -> 15
      7 -> 9
      _ -> -1


-- ooh, you can also write your functions as a series of rules, like Prolog!
-- Check this, it works just like the above func.  This is actually sorta
-- handy; it lets you define different cases of functions, without a bigass 
-- if/then/else mess.
-- But make sure you match the _ wildcard last!!
caseof2 1 = 10
caseof2 2 = 15
caseof2 7 = 9
caseof2 _ = -1

square x = x * x

-- The (square . square) is FUNCTION COMPOSITION.  It basically tells it to
-- apply the first function to the second, as if you'd written:
-- square (square x)
-- This is actually a pretty good idea.  It's much prettier than doing a bunch
-- of pseudo-Lisp parenthesis.
fourth x = (square . square) x


-- Polynomial roots, dammit!  You know, x = (-b +- sqrt( b^2 - 4ac ) / 2a), if 
-- ax^2 + bx + c = 0.
-- Gods, I wish I had thought to write this ages ago...  Here, it's a sample 
-- of local variables.
roots a b c =
   -- Note indenting!
   let det = sqrt (b*b - 4*a*c)
       twice_a = 2 * a  
   in
      ((-b + det) / twice_a,
       (-b - det) / twice_a)

-- Here's another way to declare local values... I dunno how this is different
-- from the "let" above, except that it will definately shadow global
-- declerations.
det = "Hello world!"
twoa = "a a"
roots2 a b c =
   ((-b + det) / twoa, (-b - det) / twoa)
   where det = sqrt (b * b - 4 * a * c)
         twoa = 2 * a

-- They seem to work the same way...  Yeah, they do.  It's just different
-- ways of writing the same thing, apparently.
newdet =
   putStrLn det
   where det = "Foo!"

newdet2 =
   let det = "bar!"
   in
      putStrLn det

-- Recursion!  Yaaaay!
factorial 1 = 1
factorial n = n * factorial (n - 1)

-- Calculate a fibonacci number
fib 0 = 1
fib 1 = 1
fib n =
   fib (n - 1) + fib (n - 2)

-- Calculate an exponant
expt a 1 = a
expt a b = a * expt a (b - 1)

-- Find the length of a list
len [] = 0
len (x : xs) = 1 + length xs


-- Data types!  This defines a pair:
data Pair a b = Pair a b

pairFst (Pair x y) = x
pairSnd (Pair x y) = y


-- Hmm... this is a special type to return when a function may or may not
-- succeed.  Odd...
data Maybe a = 
   Nothing 
 | Just a

-- So this func uses it to return the first element of a list, taking into 
-- account that the list may not have a first element
-- This first line is the function typedef
firstElement :: [a] -> Testy2.Maybe a

firstElement [] = Testy2.Nothing
firstElement (x:xs) = Testy2.Just x


-- This is a test of defining a lambda function!  Yay!
square2 = \x -> x * x
foo = \x y -> 2 * x + y

-- You can also build them anonymously, for example:
-- (\x -> x * x) 5 ==> 25
-- (\x y -> 2 * x + y) 5 4 ==> 14
-- map (\ x -> x^x) [1, 2, 3, 4, 5]
