(* matchtest.ml
   Compile this, then decompile it to see how matches work...
*)



type foo = 
    Alpha
  | Beta
  | Gamma
  | Delta
  | Epsilon
;;



let bop = function
    Alpha -> 1
  | Beta -> 2
  | Gamma -> 3
  | Delta -> 4
  | _ -> 5
;;
