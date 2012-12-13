let max_number = 100000;;

let get_random_list length =
   Random.self_init ();

   (* We define this internal function 'cause if we just recursed directly
    * we'd keep re-initializing the random generator.  *)
   let rec get_lst l =
      if length = 0 then
         [Random.int max_number]
      else
         Random.int max_number :: get_lst (l - 1)
   in
      get_lst length;;

let rec print_int_list lst =
   match lst with
   [] -> []
 | a :: b ->
      print_int a;
      print_char ' ';
      print_int_list b;;


(* "Contains type variables that cannot be generalized"???  You'd think the
compiler could give more helpful errors...  Line 28*)
let main = 
   let arg =  (* Here.  What's wrong with this?? *)
      try int_of_string Sys.argv.(1)
      with Invalid_argument( "Array.get" ) -> 0
   in
      Printf.printf "Sorting random list of length %d...\n" arg;
      print_int_list (Insertsort.sort (get_random_list arg));;

main;;
