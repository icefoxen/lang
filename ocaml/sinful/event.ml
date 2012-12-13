(* event.ml
   This contains the code that will trigger events for the Sinful game engine.  
   
   Events can:
   add/remove items,
   move you to a different location,
   or cause certain text to be displayed.
   
   An event can be caused by:
   you being in a certain location,
   posessing a certain item,
   typing a certain phrase (eg "xyzzy"),
   certain triggers/flags being set (say, by a previous event),
   random chance,
   or a combination of any of them.

   How the hell I'm gonna do this, I haven't a clue.
   ...Well, I don't know about the conditional triggering, but for the actual
   action I'm gonna have to write the facilities to actually do the stuff first.
   So.

   Simon Heath
   4/7/2003
*)

(* An Event is a three-element tuple; the first field is the name, the second
   is the condition, the third is a function that performs the event.  *)

(* So, I have to figure out how to make OCaml evaluate an arbitrary string/file.
   That is proving... pesky.
   I'm gonna need a couple more data files though.  I'm gonna need a flags.flg
   file, and a bunch of .evt files and facilities to parse them.  Whee!  *)


(* An event type; the string is the name, the first func is the condition, the
   second is the action itself.  *)
type event = Event of string * (unit -> bool) * (unit -> unit);;


(* Condition functions -- these all access the global vars defined in 
   sinful.ml.  They're the highest level interface for creating event
   conditions.  *)
let flagIsSet flag =
   let f = Flags.getFlag flag !Sinful.flags
   in
      f.flagval;;
      
let flagIsUnset flag =
   not (flagIsSet flag);;


let itemHeld item =
   let s = !Sinful.heldItems
   in
      Items.itemExists item s;;


let locationEquals location =
   location = !Sinful.currentnode.name;;


let inputEquals str =
   str = !Sinful.userString;;


let randomChance percent =
   Random.self_init ();
   if percent < (Random.int 100)
   then true
   else false
   ;;
