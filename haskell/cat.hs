{- cat.hs
   This asks you for a filename, then prints it out.

   Simon Heath
   2/7/2003
-}

module Main
   where

import IO

main = do
   hSetBuffering stdin LineBuffering
   putStrLn "Enter filename to read: "
   file <- getLine
   putStrLn file
   s <- readFile file
   putStrLn s
