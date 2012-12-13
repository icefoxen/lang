(* Datatypes for a straightline tree program.
   This whole mess is from the book "Modern Compiler Implementation in ML"
   Shibby, ne?

   Simon Heath
   15/5/2003
 *)

(* These types are used to build a syntax tree of a simple non-looping
   (straight-line) language *)

type id = string;;

type binop = Plus | Minus | Times | Div;;

(* Statement *)
type stm =
   CompoundStm of stm * stm
 | AssignStm of id * exp
 | Printstm of exp list

(* Expression *)
and exp =
   IdExp of id
 | NumExp of int
 | OpExp of exp * binop * exp
 | EseqExp of stm * exp;;
