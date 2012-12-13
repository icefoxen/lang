(* polymorphtest.ml
   Built to be disassembled; this lets me see how OCaml's parametric
   polymorphism works.

   Simon Heath
   30/3/2005
*)

let f a c =
   if a < c then
      a
   else
      c
;;

let j () =
   f 10 20
;;
