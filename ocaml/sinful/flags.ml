(* flags.ml
   This holds flag functions for events.

   Simon Heath
   6/7/2003
*)


(* A flag type for events.  A flag has a name, and is either true or false.  *)
type flag = { 
   flagname : string; 
   mutable flagval : bool 
   };;

exception InvalidFlag of string;;


(* Flag handling functions  *)

let rec flagExists name flagList =
   match flagList with
      hd :: tl -> 
         if hd.flagname = name
         then true
         else flagExists name tl
    | [] -> false
    ;;


let getFlag name flaglist =
   if flagExists name flaglist
   then List.hd (List.filter (function x -> x.flagname = name) flaglist)
   else raise (InvalidFlag ("Flag " ^ name ^ " does not exist!"));;


let addFlag flag flagList =
   if flagExists flag.flagname flagList
   then flagList
   else flag :: flagList;;


let delFlag flag flagList =
   if flagExists flag.flagname flagList
   then List.filter (function x -> x.flagname <> flag.flagname) flagList
   else flagList;;


let setFlagTrue flag =
   flag.flagval <- true;;


let setFlagFalse flag =
   flag.flagval <- false;;


let toggleFlag flag =
   if flag.flagval
   then flag.flagval <- false
   else flag.flagval <- true;;

(* turns a  "name\tvalue" pair into a flag  *)
let buildFlag str =
   let split = String.index str '\t'
   in
    { flagname = String.sub str 0 split;
      flagval = bool_of_string 
                (String.sub str split ((String.length str) - 1))
    };;

(* This loads a flags.flg file that has the syntax:

flagname1       flagval1
flagname2       flagval2
...

   where the seperator is a TAB.  No blank lines or other pesky characters are
   allowed.  *)
let loadFlags dir =
   let f = open_in (dir ^ "/flags.flg")
   and continue = ref true
   and finalList = ref []
   and line = ref ""
   in
      while !continue do
         try
            line := input_line f;
            finalList := (buildFlag !line) :: !finalList;
         with
            End_of_file -> continue := false
      done;
      !finalList;;
