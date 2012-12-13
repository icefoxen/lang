
{- hello.hs
   Hello world in Haskell!
   Ooh, I like these comments.  Shibby!  ^_^
   Anyway... so far as I've gotten, Haskell is much like OCaml in terms of
   form, structure and abilities.  However, two things:
   1) It's "lazy", which means that things aren't evaluated unless they have
   to be.  So, say, circular lists don't cause the thing to hang if you're
   only counting a finite number of elements in it.
   2) Whitespace is significant!  Just like Python.

   Compile this with:
   ghc --make hello.hs -o hello.exe

   The --make tells it to link it into an executable, also.

   Simon Heath
   2/7/2003
-}

module Main
   where

main = putStrLn "Hello world!"
