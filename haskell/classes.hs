module Main where

class Foo a where
   fa, fb :: a -> a -> a
   fc :: a -> a


instance Foo Int where
   fa = (+)
   fb = (-)
   fc = negate

main =
   print (fa 10 20)
