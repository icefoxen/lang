(* sinful.ml
   These are functions for the actual interpreter.  Basically they connect the
   abstract data to the actual user, and hold game state data.

   Commands it understands:
   take/get
   drop
   inv/inventory
   go/move
   look

   Simon Heath
   6/7/2003
*)

(* Global game data *)

(* The node you're currently in  *)
let currentNode = ref (Node.makeNode "" "" [] [] []);;

(* The graph of nodes; the actual map.  Kinda important, that.  *)
let mapGraph = ref [];;

(* A list of items you're holding  *)
let heldItems = ref [];;

(* This holds the game name, which is also the directory for the data files  *)
let gamename = ref "";;

(* Probably defined in a special self.itm file... *)
let selfDescription = ref "";;

(* A list of Flags that are set or unset for events.  *)
let flags = ref [];;

(* The string just entered; used mainly for events  *)
let userString = ref "";;


let lookAt str =

let getItem str =

let dropItem str =

(* Arbitrary movement *)
let warpTo str =

(* Can only go to a node through an edge in currentNode *)
let moveTo str =

(* Facilities for altering descriptions...  where will we get the new
   descriptions though?  Simply create a new object with a different desc?
   Yeah, that could work.  Hmm...  *)
let setDesc obj desc =

(* Returns a list of names of all current objects: the current node, all the
   items, and yourself.  *)
let getCurrentObjects () =


(* This is the interpreter parser; it splits up the strings you enter.  *)
let parseAction str =

(* This actually does the stuff  *)
let doAction action obj =

(* This prints out a list of strings  *)
let printStrList strLst = 


(* This tests to see if an event is true, and evals it if it is.  Imperative;
   returns ()  *)
let evalEvent evt =
   match evt with
      Events.Event( _, test, action ) ->
         if test ()
         then action ()
         else ()
   ;;

(* This evals a whole list of events  --It's imperative, so the return value
   doesn't matter  *)
let evalEvents evtList =
   List.map evalEvent evtList;
   ();;
