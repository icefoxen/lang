(* olua_interp.ml
   A simple toplevel loop for Lua written Ocaml.

   To compile:
   ./build
   ocamlc -custom -o oluarep olua.cma olua_rep.ml
   XXX: Hmmm... It SEEMS to work okay.  Except for ocamlopt, which fails
   mysteriously saying it can't find olua.a.  Which is just wrong on so many
   levels.  It works fine if you copy libolua.a to ./olua.a in the current
   directory.
   
   Simon Heath
   11/9/2004
*)

open Lua;;
open Lualib;;
open Lauxlib;;

let _ =
  let l = luaOpen () in
    openAll l;
    try
      while true do
	print_string "OLua> ";
	flush stdout;
	let line = input_line stdin in
	let ret = (loadbuffer l line (String.length line) "line") in
	let ret2 = (pcall l 0 0 0) in
	if (ret lor ret2) <> 0 then (
	  Printf.eprintf "Error: %s\n" (tostring l (-1));
	  flush stderr;
	  pop l 1; (* Pop error message from stack *)
	)
		    
      done
    with
	End_of_file -> exit 0
;;
