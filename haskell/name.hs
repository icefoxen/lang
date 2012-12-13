{- name.hs
   Asks for your name and says hi.
   Imperativeness.

   Simon Heath
   2/7/2003
-}

module Main
   where

import IO

main = do
   -- This tells it to read only a line instead of a big block.
   hSetBuffering stdin LineBuffering
   putStrLn "Please enter your name: "
   name <- getLine
   putStrLn ("Hi, " ++ name ++ "!  What's kickin'?")
