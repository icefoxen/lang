(* sintest.ml
   Tests the speed of calculating sines and cosines vs grabbing 'em from a
   table.
   ...grr, it's hard 'cause everything has to be in radians, so the sintbl
   has to have a range of 0 to 2*pi radians in increments of 2*pi/1000.

   Verdict: Bytecode, direct sine is faster by very little.  Native code,
   table sine is about 20% faster.

   Simon Heath
   28/4/2005
*)

(* Make an array of 1000 floats; this takes 8000 bytes *)
let sintbl = Array.make 1000 0.0;;

let pi = acos (-1.0);;

let fillsintbl () =
   for x = 0 to 999 do
      let n = (((float_of_int x) +. 1.) /. 1000.) *. (pi *. 2.) in
         sintbl.(x) <- sin n
   done;
;;

let testsin x =
   sin x
;;

(* I don't even know if this is actually right, but... *)
let testsintbl x =
   let n = int_of_float (x *. 1000. /. (pi *. 2.)) in
   sintbl.(n)
;;

let _ = 
   fillsintbl ();
   let starttime = Unix.gettimeofday () in
   for x = 0 to 50000000 do
      ignore (testsin (Random.float (pi *. 2.)))
   done;
   let midtime = Unix.gettimeofday () in
   for x = 0 to 50000000 do
      ignore (testsintbl (Random.float (pi *. 2.)))
   done;
   let endtime = Unix.gettimeofday () in
   let sintime = midtime -. starttime
   and tbltime = endtime -. midtime in
   Printf.printf 
      "Time for direct sine calc: %f\nTime for table sine calc: %f\n"
      sintime tbltime
;;
