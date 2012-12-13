(* Tells Ocaml what's in inspect.c 

   To compile: 
   ocamlmktop -custom -o inspector inspect.ml inspectc.c
*)

external inspect : 'a -> 'a = "inspect"

