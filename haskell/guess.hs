{- guess.hs
   Asks you to guess a number for it.

   Simon Heath
   2/7/2003
-}

module Main
   where

import IO
import Random

main = do
   hSetBuffering stdin LineBuffering
   num <- randomRIO (1::Int, 100)
   putStrLn "I'm thinking of a number between 1 and 100"
   doGuessing num

doGuessing num = do
  putStrLn "Enter your guess:"
  guess <- getLine
  if (read guess) < num then 
      do 
        putStrLn "Too low!"
        doGuessing num
  else if (read guess) > num then 
      do
        putStrLn "Too high!"
        doGuessing num
  else 
      do
	putStrLn "You win!"
