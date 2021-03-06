module Main where

import IO
import Random

main = do
   hSetBuffering stdin LineBuffering
   num <- randomRIO (1::Int, 100)
   putStrLn "I'm thinking of a number between 1 and 100."
   doGuessing num

doGuessing num = do
   putStrLn "Enter your guess:"
   guess <- getLine  -- Read the guess
   let guessNum = read guess -- turn the guess into a value
   -- And, Mjolnir might be right about indentation as syntax.
   if guessNum < num then do {
      putStrLn "Too low!";
      doGuessing num
   } else if guessNum > num then do {
         putStrLn "Too high!";
         doGuessing num
   } else putStrLn "You win!"

