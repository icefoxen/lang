(* sorttest.ml
   Tests two different sorting algorithms, insertsort and binary-tree sort.
   Yaay.

   Simon Heath
   16/4/2003
 *)


let max_number = 100000;;

let get_random_list len =
   Random.self_init ();

   (* We define an internal function 'cause if we recursed directly we'd
    * keep re-setting the random number generator *)
   let rec get_lst length = 
      if length = 0 then
         [Random.int max_number]
      else
         (Random.int max_number) :: (get_lst (length - 1))
   in
      get_lst len;;

(* We don't need this here, but 'tis nice to have...
let rec print_int_list lst = 
   let printy x =
      print_int x;
      print_char ' ';
   in
      ignore (List.map printy lst);;
*)

let time_function func arg =
   let begintime = Unix.time () in
      let _ = func arg in
         Printf.printf "Function performed, took %f seconds\n" 
            (Unix.time() -. begintime);;

let main = function () ->
   let element_number = 1000 in
   let lst = (get_random_list element_number) in
   print_endline ("Random list of "
      ^ (string_of_int element_number) 
      ^ " gotten");
   print_endline "Function: insertsort";
   (time_function Insertsort.sort lst);;
   
