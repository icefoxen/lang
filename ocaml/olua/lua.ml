(* lua.mli
   Interface stub for the Lua interpreter.  Pretty dumb/basic translation.

   TODO: Error/exception handling, anything requiring void pointers or
   function pointers

   Simon Heath
   01/09/2004
*)


type luaState
type cfunc = (luaState -> int)

type luaType =
   LuaNil
 | LuaBool
 | LuaLightuserdata
 | LuaNumber
 | LuaString
 | LuaTable
 | LuaFunction
 | LuaUserdata
 | LuaThread
;;

(* Error codes for load and pcall *)
type luaError =
   ErrRun
 | ErrFile
 | ErrSyntax
 | ErrMem
 | ErrErr
;;

let lua_version = "Lua 5.0"
and lua_copyright = "Copyright (C) 1994-2003 Tecgraf, PUC-Rio"
and lua_authors = "R. Ierusalimschy, L. H. de Figueiredo & W. Celes"

and olua_version = "OLua 0.1"
;;

let lua_registryindex = (-10000)
and lua_globalsindex  = (-10001)
and lua_multiret = (-1)
;;



external luaOpen : unit -> luaState = "olua_Open"
(* I THINK I can get the GC to take care of this... 
   Well, it should, but it doesn't. *)
external luaClose : luaState -> unit = "olua_Close"

external luaNewthread : luaState -> luaState = "olua_Newthread"

external atPanic : cfunc -> cfunc = "olua_atPanic"

external getTop : luaState -> int = "olua_getTop"
external setTop : luaState -> int -> unit = "olua_setTop"
external pushValue : luaState -> int -> unit = "olua_pushValue"
external remove : luaState -> int -> unit = "olua_remove"
external insert : luaState -> int -> unit = "olua_insert"
external checkstack : luaState -> int -> unit = "olua_checkstack"

external xmove : luaState -> int -> int -> unit = "olua_xmove"


external isnumber : luaState -> int -> bool = "olua_isnumber"
external isstring : luaState -> int -> bool = "olua_isstring"
external iscfunction : luaState -> int -> bool = "olua_iscfunction"
external isuserdata : luaState -> int -> bool = "olua_isuserdata"
external gettype : luaState -> int -> luaType = "olua_gettype"
external typename : luaState -> int -> string = "olua_typename"

external equal : luaState -> int -> int -> bool = "olua_equal"
external rawequal : luaState -> int -> int -> bool = "olua_rawequal"
external lessthan : luaState -> int -> int -> bool = "olua_lessthan"


external tonumber : luaState -> int -> float = "olua_tonumber"
external toboolean : luaState -> int -> bool = "olua_toboolean"
external tostring : luaState -> int -> string = "olua_tostring"
external strlen : luaState -> int -> int = "olua_strlen"
external tocfunction : luaState -> int -> cfunc = "olua_tocfunction"
(* XXX: external touserdata : luaState -> int -> *void = "olua_touserdata" *)
external tothread : luaState -> int -> luaState = "olua_tothread"
(* XXX: external topointer luaState -> int -> ??? *)

external pushnil : luaState -> unit = "olua_pushnil"
external pushnumber : luaState -> float -> unit = "olua_pushnumber"
external pushstring : luaState -> string -> unit = "olua_pushstring"
(* XXX: external pushlstring luaState -> string -> int -> unit *)
(* XXX: external pushvfstring luaState -> string -> va_list -> string  *)
(* XXX: external pushfstring luaState -> string -> ... -> string *)
external pushclosure : luaState -> cfunc -> int -> unit = "olua_pushclosure"
external pushboolean : luaState -> bool -> unit = "olua_pushboolean"
(* XXX: external pushlightuserdata luaState -> *void -> unit *)

external gettable : luaState -> int -> unit = "olua_gettable"
external rawget : luaState -> int -> unit = "olua_rawget"
external rawgeti : luaState -> int -> int -> unit = "olua_rawgeti"
external newtable : luaState -> unit = "olua_newtable"
(* XXX: external newuserdata luaState -> int -> *void *)
external getmetatable : luaState -> int -> int = "olua_getmetatable"
external getfenv : luaState -> int -> unit = "olua_getfenv"




external settable : luaState -> int -> unit = "olua_settable"
external rawset : luaState -> int -> unit = "olua_rawset"
external rawseti : luaState -> int -> int -> unit = "olua_rawseti"
external setmetatable : luaState -> int -> int = "olua_setmetatable"
external setfenv : luaState -> int -> int = "olua_setfenv"



external call : luaState -> int -> int -> unit = "olua_call"
external pcall : luaState -> int -> int -> int -> int = "olua_pcall"
(* XXX: external cpcall luaState -> int -> cfunc -> *void -> int *)
(* XXX: external load luaState -> Chunkreader -> *void -> string -> int *)

(* XXX: external dump luaState -> Chunkwriter -> void* -> int  *)



external yield : luaState -> int -> int = "olua_yield"
external resume : luaState -> int -> int = "olua_resume"

external getgcthreshold : luaState -> int = "olua_getgcthreshold"
external getgccount : luaState -> int = "olua_getgccount"
external setgcthreshold : luaState -> int -> unit = "olua_setgcthreshold"



external error : luaState -> int = "olua_error"
external next : luaState -> int -> int = "olua_next"
external concat : luaState -> int -> unit = "olua_concat"

external pop : luaState -> int -> unit = "olua_pop"

(* XXX: external register : luaState -> int -> cfunc -> unit = "olua_register"
*)
(* external pushcfunction : luaState -> cfunc -> unit = "olua_pushcfunction"
*)
external isfunction : luaState -> int -> bool = "olua_isfunction"
external istable : luaState -> int -> bool = "olua_istable"
external islightuserdata : luaState -> int -> bool = "olua_islightuserdata"
external isnil : luaState -> int -> bool = "olua_isnil"
external isboolean : luaState -> int -> bool = "olua_isboolean"
external isnone : luaState -> int -> bool = "olua_isnone"
external isnoneornil : luaState -> int -> bool = "olua_isnoneornil"
(* XXX: external pushliteral : luaState -> string -> unit = "olua_pushliteral"
   ???*)

let getglobal l s =
   pushstring l s;
   gettable l lua_globalsindex;
;;

let getregistry l =
   pushValue l lua_registryindex
;;

let setglobal l s =
   pushstring l s;
   insert l (-2);
   settable l lua_globalsindex;
;;

(* XXX: Put in debug API?  Nah.  Not at the moment. *)
