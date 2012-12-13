(* node.mli
   A directed graph type for Sinful.  
   Sinful uses a directed graph to represent areas.
   The graph itself is contained in a linked list; all references are logical
   rather than actual.

   ...this interface file isn't doing it's job.  The junk in the implementation
   file still depends on all the functions it uses being declared first, so this
   really isn't even as "useful" as a C header file.
   
   Simon Heath
   4/7/2003
*)


(* This is a node type for the graph.  It contains all relevant data. 
   Remember, this stuff is referenced Node.field *)
type node = {
   name   : string;
   desc   : string;
   events : unit list;  (* XXX: Define an event type! *)
   items  : string list;
   edges  : string list (* Note that we refer to other nodes by NAME, not by
                           reference!  *)
   };;

exception InvalidGraphNode of string;;


val makeNode : string -> string -> unit list -> string list -> string list -> node

val hasEdge : node -> string -> bool


(* Adds an edge to a node and returns the new one.  Makes no change if the
   edge already exists *)
val addEdge : node -> string -> node 


(* Removes an edge from a node and returns the new one.  Makes no change if 
   the edge doesn't exist.  *)
val delEdge : node -> string -> node


(* These are functions designed to help you search for a node. *)
val getNodeName : node -> string


(* If a node with a name "name" exists in the given list, return it *)
val getNodeByName : string -> node list -> node


(* Returns true if a node with name "name" exists in the given list *)
val nodeExists : node -> node list -> bool

val s_nodeExists : string -> node list -> bool

val verifyNode : node -> node list -> bool

val verifyGraph : node list -> bool

val s_hasEdge : string -> string -> node list -> bool
val s_addEdge : string -> string -> node list -> node
val s_delEdge : string -> string -> node list -> node


val nodeExists : node -> node list -> bool
val s_nodeExists : string -> node list -> bool
val addNode : node -> node list -> node list
val delNode : node -> node list -> node list
val replaceNode : node -> node -> node list -> node list
val s_replaceNode : string -> node -> node list -> node list


val addItem : node -> string -> node
val delItem : node -> string -> node
