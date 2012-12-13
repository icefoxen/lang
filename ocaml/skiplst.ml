(* skiplst.ml
   A skiplist data structure.
   Lets see if this comes out right...

   Simon Heath
   13/06/2004
*)


type 'a item = 
    Item of 'a
  | Neginf
  | Posinf
;;

(* Skiplist type --tower *)
type ('a, 'b) t = {
  mutable tower : ('a, 'b) t array;
  mutable key : 'a item;
  mutable itm : 'b;
};;

let height twr =
  Array.length twr.tower
;;

(* The chance of a new tower increasing in height.
   That's a bad description but you know what I mean.
   Optimum efficiency happens when this is 1/e; lower than that makes it
   longer to search but lower on memory, higher vice-versa.
   0.25 and 0.5 are acceptable values.
*)
let c = 0.5;;

let buildTower k v =
  let h = ref 0 in
    while (Random.float 1.0) < c do
      incr h
    done; 

    let rec n = {
      (* A bit of subversion here... we can't do something like
	 let rec s = { itm = foo; tower = Array.make bar s; }
	 because we have to pass the object to Array.make before it's
	 done being built!  So we just break it down a bit.
      *)
      tower = [|n|];
      key = Item( k );
      itm = v;
    } in
    let t = Array.make !h n in
      n.tower <- t;
      n
;;



let doubleArray n =
  let arrlen = Array.length n 
  in
    Array.init (arrlen * 2) 
      (fun x ->
	 if x <= arrlen - 1 then
	   n.(x)
	 else
	   n.(0))
;;

(* Having to provide i is... imperfect.
   Oh well.
*)
let create n i = 
  let rec neginf = {
    tower = [|neginf;|];
    key = Neginf;
    itm = i;
  } in
  let rec posinf = {
    tower = [|posinf;|];
    key = Posinf;
    itm = i;
  } in
  let t1 = Array.make n neginf
  and t2 = Array.make n posinf in
    neginf.tower <- t1;
    posinf.tower <- t2;

    neginf;
;;
		 

(* i1 > i2 
   Neginf is smaller than everything, Posinf is bigger than everything.
   Including themselves.  Neginf > Neginf -> false, Posinf > Posinf -> true.
   That shouldn't matter though.
   compareItm n n -> false.  That one DOES matter.
*)
let compareItm i1 i2 =
  match i1 with
      Neginf -> false
    | Posinf -> true
    | Item a ->
	match i2 with
	    Neginf -> true
	  | Posinf -> false
	  | Item b -> a > b
;;


(* So, this searches from the top of a tower and moves forward
   until it finds an item matching it's key.  If it doesn't and it hits
   something bigger than it's key (ie Posinf) at level 0, it throws 
   Not_found.
*)

let getKey twr =
  twr.key
;;

let getItm twr =
  twr.itm
;;

let getNext twr lev =
  Printf.printf "%d\n" lev;
  twr.tower.(lev)
;;

let nextIsGreater twr lev =
  compareItm (getNext twr lev).key twr.key
;; 

let ofItem = function
    Item n -> n
  | Posinf -> raise (Invalid_argument "ofItem expects item, given Posinf")
  | Neginf -> raise (Invalid_argument "ofItem expects item, given Neginf")
;;

(* Okay, so what exactly are the conditions for this again?
   While there is a tower ahead that is not greater than the key,
   move ahead.
   Once you hit one that IS greater, move down a level and try again.
   If you ever find the key, return the value.
   If you hit level 0 and there's still something ahead that's greater,
   throw Not_found.  

   Yeah...  I THINK that's right...
*)

let find slst key =
  let cur = ref slst 
  and lev = ref ((height slst) - 1)
  and keepgoing = ref true 
  and key = Item( key ) in
    while not (nextIsGreater !cur !lev) && !keepgoing do

      (* Spin forward 'till you hit one that's greater ahead of you *)
      while not (nextIsGreater !cur !lev) do
	cur := (getNext !cur !lev);
      done;

      (* Not exactly the best way to break out of this... 
	 But Ocaml's silly enough not to have a "break" statement, so.
      *)
      if (getKey !cur) = key then
	keepgoing := false;

      (* Then spin down 'till you hit one that ISN'T greater ahead of you *)
      while (nextIsGreater !cur !lev) && !keepgoing do
	if !lev <= 0 then
	  raise Not_found
	else
	  decr lev;
      done;
    done;

    (* So if you found something, yay!  Return it! *)
    !cur.itm
;;

      
