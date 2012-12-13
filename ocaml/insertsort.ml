(* insertsort.ml
   An insertion sort algorithm.
   Just practice.
   Two different ways of implementing the same algorithm.  The first way
   is more imperative, the second is more functional.

   Simon Heath
   16/4/2003
 *)


let rec insert element lst =
   match lst with
   [] -> [element]
 | car :: cdr ->
      if element <= car then
         element :: lst
      else
         car :: (insert element cdr)
 and
   sort x =
      match x with
      [] -> []
    | car :: cdr -> insert car (sort cdr);;


let rec sort2 x =
   let insert elt lst = 
      match lst with
      [] -> [elt]
    | car :: cdr ->
         if elt <= car then
            elt :: lst
         else
            car :: (insert elt cdr)
   in
      match x with
      [] -> []
    | car :: cdr -> insert car (sort cdr);;
