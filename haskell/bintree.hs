{- bintree.hs
   A binary tree in Haskell.
   Yay!  ^_^

   Simon Heath
   2/7/2003
-}

-- Foist, we declare the data type

module Bintree
   where


data Bintree = 
   Nil 
 | Leaf Int 
 | Node (Bintree) Int (Bintree)


getLeft (Node a b c) = a
getRight (Node a b c) = c
getValue (Node a b c) = b
getValue (Leaf a) = a
getValue Nil = 0

insert :: Int -> Bintree -> Bintree
insert item tree =
   case tree of
      Nil -> Leaf item
      Leaf a -> 
         if item > a
	    then (Node Nil a (Leaf item))
	    else (Node (Leaf item) a Nil)
      Node a b c ->
         if item > b
	    then (insert item c)
	    else (insert item a)
