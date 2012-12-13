(* items.ml
   This is the item system.  Items are basically a tuple with a name, and a
   description.  You can pick up and put down items, and their presence can
   trigger events.

   Simon Heath
   5/7/2003
*)


(* This is the item type.  The first string is the name, the second is the
   description.  *)
type item = Item of string * string;;


let makeItem name desc =
   Item( name, desc );;


let getItemName = function
   Item( name, _ ) -> name;;

let getItemDesc = function
   Item( _ , desc ) -> desc;;


let setItemName item newName =
   match item with
      Item( _, desc ) -> Item( newName, desc );;

let setItemDesc item newDesc =
   match item with
      Item( name, _ ) -> Item( name, newDesc );;


let itemExists (name : string) (itemList : item list) =
   List.mem name (List.map getItemName itemList);;

let getItem (item : item) (itemList : item list) =
   List.hd (List.filter (function x -> x = item) 
                        itemList);; 

let s_getItem (name : string) (itemList : item list) =
   List.hd (List.filter (function x -> ((getItemName x) = name)) 
                        itemList);;


let addItem (item : item) (itemLst : item list) =
   if not (itemExists (getItemName item) itemLst)
   then item :: itemLst
   else itemLst;;

let delItem (item : item) (itemList : item list) =
   if itemExists (getItemName item) itemList
   then List.filter (function x -> (x <> item)) itemList
   else itemList;;

let s_delItem (item : string) (itemList : item list) =
   if (itemExists item itemList)
   then 
      let itm = s_getItem item itemList
      in delItem itm itemList
   else itemList;;
