
type num =
   Fixnum of int
 | Bignum of int list
 | Irrational of {i : int; j : int}
 | Rational of {num : int; den : int}
 | Float of float
 ;;

type func = {
   name    : string; 
   formals : string * token list;
   body    : value
   };


type value =
   Num
 | value list
 | func
 | Char of char
 | String of string
 ;;

type token =
   Lparen
 | Rparen
 | Value
