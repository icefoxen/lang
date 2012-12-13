(* mltoc.ml
   Tests using a C function in OCaml.

   Simon Heath
   25/4/2003
 *)

(* External C function... computes n * n in a rather roundabout fashion *)
external cpow : int -> int = "csum";;

let main = 
   print_int (cpow 100);;
