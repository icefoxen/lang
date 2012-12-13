(* testinit.ml
   Simple init-tester thingn.  Wossname.  You know.

   Simon Heath
   15/05/2004
*)

let _ =
   let i = ref "" in
   print_endline "Prints out all entered text until only a . is typed, then
   starts bash";
   while !i <> "." do
      i := input_line stdin;
      print_endline !i;
   done;
   Unix.execv "/bin/bash" [|""|]
;;
