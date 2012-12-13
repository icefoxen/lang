(* test.ml
   Tests the Ocaml/lua GC interface in a rather informal manner
   
   Simon Heath
   10/9/2004
*)

open Lua;;
open Gc;;

let pc a = match a with
   a,b,c -> Printf.printf "Minor: %f Major %f Promoted %f\n" a b c
;;

pc (counters ());;
let l = ref (luaOpen ());;
pc (counters ());;

for x = 0 to 100000 do
   l := (luaOpen ())
done;;

pc (counters ());;

for x = 0 to 100000 do
   l := (luaOpen ());
   luaClose !l;
done;;
pc (counters ());;
