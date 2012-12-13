(* node.ml
   A directed graph type for Sinful.  
   Sinful uses a directed graph to represent areas.
   The graph itself is contained in a linked list; all references are logical
   rather than actual.
   
   Simon Heath
   4/7/2003
*)



(* This is a node type for the graph.  It contains all relevant data. 
   Remember, this stuff is referenced Node.field *)
type node = {
   name   : string;
   desc   : string;
   events : unit list;  (* XXX: Define an event type! *)
   items  : Items.item list;
   edges  : string list (* Note that we refer to other nodes by NAME *)
   };;

exception InvalidGraphNode of string;;


let makeNode nam des evnts itms edgs = { 
   name = nam;
   desc = des;
   events = evnts;
   items = itms;
   edges = edgs
   };;


(* Growl... should addEdge, delEdge, and hasEdge take nodes or names?? *) 

let hasEdge srcNode dstNode =
   (* List.mem x y returns true if list y contains x *)
   List.mem dstNode srcNode.edges;;



(* Adds an edge to a node and returns the new one.  Makes no change if the
   edge already exists *)
let addEdge srcNode dstNode = 
   (* Check to see if an edge exists already before adding it *)
   if not (hasEdge srcNode dstNode)
   then
      makeNode srcNode.name 
               srcNode.desc 
               srcNode.events 
               srcNode.items
               (dstNode :: srcNode.edges)
   (* If the edge exists, then we just return the original node *)
   else
      srcNode;;


(* Removes an edge from a node and returns the new one.  Makes no change if 
   the edge doesn't exist.  *)
let delEdge srcNode dstNode =
   if hasEdge srcNode dstNode
   then
      makeNode srcNode.name
               srcNode.desc
               srcNode.events
               srcNode.items
               (List.filter ((<>) dstNode) srcNode.edges)
   else
      srcNode;;


(* These are functions designed to help you search for a node. *)
let getNodeName node =
   node.name;;


(* If a node with a name "name" exists in the given list, return it *)
let rec getNodeByName name nodeLst =
   match nodeLst with
      fst :: rst ->
         if fst.name = name
         then fst
         else getNodeByName name rst
    | [] -> raise (InvalidGraphNode ("Node " ^ name ^ " does not exist!" ))
   ;;


(* Returns true if a node exists in the given list.  the s_ version takes
   the name of the node rather than the node itself.  *) 
let nodeExists (node : node) (nodeList : node list) =
   List.mem node nodeList;;

(* This'll throw an exception if it fails instead of returning false, since
   getNodeByName is called with the same list we're searching  *)
let s_nodeExists node nodeList =
   nodeExists (getNodeByName node nodeList) nodeList;;


(* Returns true if a node with name "name" exists in the given list *)
(*
let rec nodeExists (name : string) (nodeLst : node list) =
   match nodeLst with
      fst :: rst ->
         if fst.name = name
         then true
         else nodeExists name rst
    | [] -> false
   ;;
*)


(* This takes a list of edges and returns true if each edge points to a valid
   node in nodeList.  *)
let rec verifyNode' edgeList nodeList =
   match edgeList with
      hd :: tl ->
         (* Okay, here we check to see whether the first element of the node's
            edgelist actually exists.  If it does, we check the next one.
            If it doesn't we throw an exception. *)
         if s_nodeExists hd nodeList
         then verifyNode' tl nodeList
         else raise (InvalidGraphNode
                       ("Node " ^ hd ^ 
                        " refers to a node which doesn't exist!"))
      (* Congrats!  We're at the end of the list and everything checked out! *)
    | [] -> true
   ;;



(* This verifies that all the edges in a single node exist, at least within
   the list given.  *)
let verifyNode node nodeList =
   verifyNode' node.edges nodeList;;



(* This does the actual work; it needs two arguments, cause it recurses.  The
   first is the list of nodes not yet searched, and the second is the total
   list of nodes to search.  *)
let rec verifyGraph' nodesToSearch nodeList =
   match nodesToSearch with
      fst :: rst ->
         (* We verify the first node in the list.  If it's fine, we do the
            next one.  If it's not we raise an exception. *)
         if verifyNode fst nodeList
         then verifyGraph' rst nodeList
         (* This shouldn't happen, 'cause if verifyNode fails it throws an
            exception, not returning false.  This is just for the sake of
            completeness. *)
         else raise (InvalidGraphNode ("Node " ^ fst.name ^ 
                       " references an invalid node!"))

      (* Congrats, we're at the end of the list and everything checked out! *)
    | [] -> true
   ;;


(* This checks each node in a list, and throws an exception if one of them has
   an edge to a node that doesn't exist.  *)
let verifyGraph nodeList =
   verifyGraph' nodeList nodeList;;


(* These functions are exactly the same as hasEdge, delEdge and hasEdge, but
   they take the nodes by name and a list of nodes to search, instead of
   referencing the nodes directly.  *)

let s_hasEdge srcNode dstNode nodeList =
   let src = getNodeByName srcNode nodeList
   in
      hasEdge src dstNode;;

let s_addEdge srcNode dstNode nodeList =
   let src = getNodeByName srcNode nodeList
   in
      addEdge src dstNode;;

let s_delEdge srcNode dstNode nodeList =
   let src = getNodeByName srcNode nodeList
   in
      delEdge src dstNode;;


(* These are higher-level functions that act upon entire graphs more than
   individual nodes.  *)


let addNode node nodeList =
   if not (nodeExists node nodeList)
   then node :: nodeList
   else nodeList
   ;;

let delNode node nodeList =
   if (nodeExists node nodeList)
   then
      List.filter ((<>) node) nodeList
   else
      nodeList;;

let replaceNode oldNode newNode nodeList =
   addNode oldNode (delNode newNode nodeList)
   ;;

let s_replaceNode oldNode newNode nodeList =
   let old = getNodeByName oldNode nodeList
   in
      replaceNode old newNode nodeList;;


(* These functions add and remove items from a node  *)
let addNodeItem node item =
   makeNode node.name node.desc node.events 
            (Items.addItem item node.items) node.edges
   ;;

let delNodeItem node item =
   makeNode node.name node.desc node.events
            (Items.delItem item node.items) node.edges;;


let s_delNodeItem node itemName =
   makeNode node.name node.desc node.events
            (Items.s_delItem itemName node.items) node.edges;;

let nodeItemExists (item : string) node =
   Items.itemExists item node.items;;
