(* test2.ml
   ...now we test the actual LIBRARY...

   Simon Heath
   10/9/2004
*)

open Lua;;
open Lualib;;

let _ =
   let l = luaOpen () in
   openAll l;
   
   (* Grab table.foreach *)
   getglobal l "table";
   pushstring l "foreachi";
   gettable l (-2);
   if not (isfunction l (-1)) then
      Printf.eprintf "table.foreach could not be found!\n";
   
   (* Push a table and put a bunch of values in it *)
   let setfield x y =
      pushnumber l x;
      pushnumber l y; 
      settable l (-3)
   in

   newtable l;
   for x = 0 to 10 do
      setfield (float_of_int x) (float_of_int (x * x));
   done;

   pushstring l "n";
   pushnumber l 10.0;
   settable l (-3);
   
   (* Grab the print function, then call table.foreach *)
   getglobal l "print";
   let result = (pcall l 2 0 0) in
   if result > 0 then
      Printf.eprintf "Something went wrong with the functioncall\n";

   luaClose l;
;;
