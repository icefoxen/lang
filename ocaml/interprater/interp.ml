(* An interpreter framework for sexp-based languages.
   From the book "Programming Languages: An Interpreter-Based Approach"
   by Samuel N. Kamin.
   Program translated from Pascal, heh.

   Simon Heath
   3/5/2003
 *)

(****************************************************************************)
(** TYPE DECLERATIONS *******************************************************)

let prompt  = "-> ";;
let prompt2 = ">  ";;
let commentchar = ';';;

(* Data structures to hold values for the language *)
type value = Value of int;;

(* Expressions types... *)
type exp = 
   Valexp of value                  (* Value                 *)
 | Varexp of string                 (* Variable              *)
 | Apexp of string * exp list;;     (* User-defined function *)

(* Functions... *)
type fundef = {
   funname : string;
   formals : string list;
   body : exp;
 };;

(* Variables... *)
(* Only numbers for now, but to change that ye just have to modify type
 * "value" *)
type env = (string * value) list;;


(* Built-in operations 
 * -op suffix avoids name clashes *)
type controlop = 
   Ifop 
 | Whileop
 | Setop
 | Beginop
type valueop =
   Plusop
 | Minusop
 | Timesop
 | Divop
 | Eqop
 | Ltop
 | Gtop
 | Printop;;

(* Kinda a kludge, but... well, it does fuse two types together into one. *)
type builtinop = 
   Cop of controlop 
 | Vop of valueop;;


(****************************************************************************)
(** VARIABLES ***************************************************************)

(* Function definitions, list type fundef *)
let fundefs = ref [];;

(* Global variables, list type env *)
let globalenv = ref [];;

(* Current expression, list type exp *)
(* XXX: Not yet used *)
let currentExp = ref [];;

(* User input *)
(* XXX: Not yet used *)
let userInput = ref "";;

let quit = false;;


(****************************************************************************)
(** NAME MANAGEMENT *********************************************************)

(* Finds a function name, and returns the function *)
let fetchFun fname =
  List.find (function f -> f.funname = fname) !fundefs;;

(* Creates a new function and parameters and sticks it on the fundefs list
 * It should first check whether or not the function name already exists; 
 * but I'm too lazy.  The new definition will override the old, but the old
 * won't be removed.  *)
let newFunDef name nl exp =
      fundefs := { funname = name; formals = nl; body = exp } :: !fundefs;;


(****************************************************************************)
(** INPUT *******************************************************************)


(* Preeeetty obvious. *)
let isWhitespace = function
   ' '  -> true
 | '\t' -> true
 | '\n' -> true
 | '\r' -> true
 | _    -> false;;


(* Input must be de-whitespaced *)
let isDelim = function
   ' ' -> true
 | '(' -> true
 | ')' -> true
 |  _  -> false;;

(* Returns the number of un-closed parenthesis in a string *)
let count_parens str =
   let count = ref 0 in
   for i = 0 to (String.length str) - 1 do
      match String.get str i with
         '(' -> count := !count + 1
       | ')' -> count := !count - 1
       | _   -> ()
   done;
   !count;;


(* Converts a char to a string... why isn't this a library func? *)
let string_of_char c =
   String.make 1 c;;


(* Reads input until all parens are closed *)
(* XXX: Ideally, this should be able to take input from arbitrary sources,
 * but seeing as it has to know when to stop reading and when to ask for
 * more, that's kinda hard.  Something to fix later.  Pass a stream as
 * an argument?  *)
let readparens () =
   print_string prompt;
   let str = ref (read_line ()) in
   while count_parens !str > 0 do
      print_string prompt2;
      (* Must append newline so we know when comments end *)
      str := !str ^ "\n" ^ read_line ();
   done;
   !str ^ "\n";;  (* Same as above *)


(* Removes single-line comments from a string... starts with "commentchar"
 * (';' in this case, Lisp-style) 'till the end of the line *)
let decomment str =
   let incomment = ref false in
   let ret = ref "" in
   for i = 0 to (String.length str) - 1 do
      if String.get str i = commentchar then
         incomment := true
      else
      if !incomment && String.get str i = '\n' then
         incomment := false
      else ();
      if not !incomment then
         ret := !ret ^ string_of_char (String.get str i)
      else ();
   done;
   !ret;;


(* Turns all whitespace into spaces to make it easier to handle;
 * Must be called AFTER de-commenting!!!! *)
let deWhitespace str =
   let ret = ref "" in
   for i = 0 to (String.length str) - 1 do
      if isWhitespace (String.get str i) then
         ret := !ret ^ " "
      else
         ret := !ret ^ string_of_char (String.get str i);
   done;
   !ret;;


(* The "read" bit of the read-eval-print loop *)
(* Capitalize to make the sucker case-insensitive *)
let read () =
      String.uppercase (deWhitespace (decomment (readparens ())));;

(* Returns the location of the next NON-WHITESPACE char *)
let nextChar str i =
   if (String.get str i) <> ' ' then
      i
   else
      nextSpace str i + 1;;


let isDigit = function
   '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' -> true
 | _ -> false;;

(* Tells whether a string is a number *)
let isNumber str =
   if isDigit (String.get str 0) then true
   else if (String.get str 0 = '-') 
        && isDigit (String.get str 1) then true
   else false;;


let parseVal str =

(* These functions handle things at the token level *)
let currentexp = ref [];;


(* Pushes a token onto the list *)
let pushToken str =
   currentexp := str :: !currentexp;;




