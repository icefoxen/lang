(* lauxlib.ml
   Auxilary library.
   Yeah.
   
   Simon Heath
   10/9/2004
*)

open Lua;;


(* XXX: external openlib : luaState -> string -> luaReg -> in -> unit *)
external getmetafield : luaState -> int -> string -> int = "olua_getmetafield"
external callmeta : luaState -> int -> string -> int = "olua_callmeta"
external typeerror : luaState -> int -> string -> int = "olua_typeerror"
external argerror : luaState -> int -> string -> int = "olua_argerror"
(* XXX: external checkstring : luaState -> int -> int -> string =
"olua_checkstring"  (takes a pointer to a number...)*)
(* XXX: external optstring : luaState -> int -> string -> int -> string 
   = "olua_optstring" *)

external checknumber : luaState -> int -> float = "olua_checknumber"
external optnumber : luaState -> int -> float -> float = "olua_optnumber"
external lcheckstack : luaState -> int -> string -> unit = "olua_lcheckstack"
external checktype : luaState -> int -> int -> unit = "olua_checktype"
external checkany : luaState -> int -> unit = "olua_checkany"

external newmetatable : luaState -> string -> int = "olua_newmetatable"
external lgetmetatable : luaState -> string -> int = "olua_lgetmetatable"
(* XXX: external checkudata : luaState -> int -> string -> *void *)

external where : luaState -> int -> unit = "olua_where"
(* XXX: external error : luaState -> string -> ... -> int *)

(* external findstring : string -> string list -> int = "olua_findstring" *)

external lref : luaState -> int -> int = "olua_lref"
external lunref : luaState -> int -> int -> unit = "olua_lunref"
external getn : luaState -> int -> int = "olua_getn"
external setn : luaState -> int -> int -> unit = "olua_setn"

external loadfile : luaState -> string -> int = "olua_loadfile"
external loadbuffer : luaState -> string -> int -> string -> int 
   = "olua_loadbuffer"

(*
let argcheck l cond numarg extramsg =
   if not cond then
      argerror l numarg extramsg
   else
      cond
;;
*)

let checkint l n =
   int_of_float (checknumber l n)
;;

let optint l n d =
   int_of_float (optnumber l n d)
;;

external dofile : luaState -> string -> int = "olua_dofile"
external dostring : luaState -> string -> int = "olua_dostring"

(* Left out all the buffer stuff... what's the point of it?  Does anything
   actually use said buffers? *)
