type t1 = float * float * float;;
type t2 = float array;;

let incf x =
   x := !x +. 1.;
;;

let i = ref 0.
and j = ref 1.
and k = ref 2.;;

let maket1 () =
   let a = (!i, !j, !k) in
   incf i;
   incf j;
   incf k;
   a;
;;

let maket2 () = 
   let a = [|!i; !j; !k|] in
   incf i;
   incf j;
   incf k;
   a;
;;

let maket1s () =
   let f = ref [] in
   for i = 0 to 5000000 do
      f := (maket1 ()) :: !f;
   done;
   !f
;;

let maket2s () =
   let f = ref [] in
   for i = 0 to 5000000 do
      f := (maket2 ()) :: !f;
   done;
   !f
;;


let sumt1s lst =
   let rec loop lst accm =
      if lst = [] then
         accm
      else
         let a, b, c = List.hd lst in
         loop (List.tl lst) (accm +. a +. b +. c)
   in
   loop lst 0.
;;

let sumt2s lst =
   let rec loop lst accm =
      if lst = [] then
         accm
      else
         let x = List.hd lst in
         loop (List.tl lst) (accm +. x.(0) +. x.(1) +. x.(2))
   in
   loop lst 0.
;;


let testTuples () =
   sumt1s (maket1s ())
;;

let testArrays () =
   sumt2s (maket2s ())
;;

let _ =
   testTuples ()
;;
