(* bintree.ml
   Binary tree implementation.
   Mostly as a way to test the efficiency of a certain shibby sorting 
   algorithm.
   Turns a list into a binary tree to sort it, then turns the tree back into
   a list.  Wyld, ne?

   Simon Heath
   16/4/2003
 *)


type 'a bintree =
   Empty
 | Node of 'a bintree * 'a * 'a bintree;;

let rec add_node (elt:'a) (tree:'a bintree) =
   match tree with
   Empty -> Node( Empty, elt, Empty )
 | Node( ltree, item, rtree ) ->
      if elt < item then
         Node( add_node elt ltree, item, rtree )
      else
         Node( ltree, item, add_node elt rtree );;

let rec tree_of_list =
   function
   [] -> Empty
 | car :: cdr -> add_node car (tree_of_list cdr);;

let rec list_of_tree =
   function
   Empty -> []
 | Node( ltree, item, rtree ) ->
      (list_of_tree ltree) @ (item :: list_of_tree rtree);;

let sort x = list_of_tree (tree_of_list x);;
