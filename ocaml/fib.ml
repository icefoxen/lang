(* Fib.ml
 * Just re-learning this stuff; fibonacci sequence.
 * Simon Heath
 * 4/4/2003
 *)

let rec fib i =
   match i with
   0 -> 1
 | 1 -> 1
 | _ -> fib (i - 1) + fib (i - 2);;

let rec fib2 i =
   if i < 2 then
      1
   else
      (fib (i - 1)) + (fib (i - 2));;

let main =
   print_int (fib2 (int_of_string Sys.argv.(1)));
   print_newline ();;
