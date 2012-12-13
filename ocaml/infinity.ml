(* Stack overflow, yay! *)

(* the x * in front of it buggers the tail-recursion optomization *)
let rec infinity x =
   x * infinity x;;

let main =
   infinity 10;;

