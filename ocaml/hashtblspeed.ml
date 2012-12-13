(* Tests how fast hashtables are *)

let _ =
   let t = Hashtbl.create 10000 in
   let u = Hashtbl.create 10000 in
   for x = 0 to 1000000 do
      Hashtbl.add t (string_of_int x) x 
   done;
   for x = 0 to 1000000 do
      Hashtbl.add u (string_of_int x) (Hashtbl.find t (string_of_int x))
   done
;;
