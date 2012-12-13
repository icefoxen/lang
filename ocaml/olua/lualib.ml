(* lualib.ml
   Opens lua libraries.
   Good stuff.

   Simon Heath
   10/9/2004
*)

open Lua

external openBase : luaState -> unit = "olua_openBase"
external openTable : luaState -> unit = "olua_openTable"
external openIo : luaState -> unit = "olua_openIo"
external openString : luaState -> unit = "olua_openString"
external openMath : luaState -> unit = "olua_openMath"
external openDebug : luaState -> unit = "olua_openDebug"
external openLoadlib : luaState -> unit = "olua_openLoadlib"

(* Opens all libraries and throws away whatever values they put on the stack
*)
let openAll l =
   openBase l;
   openTable l;
   openIo l;
   openString l;
   openMath l;
   openDebug l;
   openLoadlib l;
   setTop l 0
;;
