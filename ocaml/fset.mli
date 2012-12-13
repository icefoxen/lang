(* fset.mli
   This is an interface file; sorta like a C header file.
   It defines all the interfaces in a package; in this case we're building a
   simple set ADT. 
   
   Simon Heath
   2/3/2003  *)

(* Data type of the sets *)
type 'a t

(* Empty set *)
val empty : 'a t

(* Membership function *)
val mem : 'a -> 'a t -> bool

(* Insertion is functional *)
val insert : 'a -> 'a t -> 'a t
