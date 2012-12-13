{- FileRead.hs
   A niffy little program to read or write to a file.
   Really basic, but demonstrates using I/O in an actual program.

   Simon Heath
   2/7/2003
-}

module Main
   where

import IO

main = do
   hSetBuffering stdin LineBuffering
   doLoop


-- Now that I think of it, I haven't seen any kind of iteration in Haskell
-- at all.  Is it like Scheme?
doLoop = do
   putStrLn "Enter a command rFN or wFN or q to quit:"
   command <- getLine
   case command of
      -- This is kinda cool... it uses list-ish pattern matching to grab
      -- the first char of a string.  And the rest of it, come to think of
      -- it.  Rather efficient...
      'q' : _ -> return ()
      'r' : filename -> do putStrLn ("Reading " ++ filename)
                           doRead filename
			   doLoop
      'w' : filename -> do putStrLn ("Writing " ++ filename)
                           doWrite filename
			   doLoop
      _ -> doLoop

doRead filename =
   -- the "bracket" function takes three arguments: The func to do at first,
   -- no matter what, the func to do last, no matter what, and the func
   -- to do between them, which may result in an error.
   bracket
      (openFile filename ReadMode)
      hClose
      (\h -> do
         contents <- hGetContents h  -- the h is the arg for the anonymous func
	 putStrLn "The first 100 chars:"
	 putStrLn (take 100 contents))


doWrite filename = do
   putStrLn "Enter text to go into the file:"
   contents <- getLine
   bracket
      (openFile filename WriteMode)
      hClose
      (\h -> hPutStrLn h contents)
