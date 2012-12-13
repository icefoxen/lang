(* config.ml
   Config file object.
   This is the interface between Edge of Infinity and Lua, through my own
   dastardly creation, OLua.
   At the moment, this is really limited to getting data from Lua, 
   evaluating    Lua forms, and loading Lua scripts.  Hopefully we'll 
   eventually find a way to register an Ocaml function into Lua, but it
   seems right now that we'll have to go through C to do so...
   Well, it might be possible to make that a bit more flexible.  Look at
   Callback.register.  We could have a set assortment of C functions
   registered in Lua, that call whatever we want them to by registering
   the Ocaml func at runtime.  TAD complex though.

   Simon Heath
   16/9/2004
*)


open Printf;;

exception LuaError of string;;


(* Operations:
   This is basically a hashtable initialized from a Lua file...
   Basically it should be able to get data, including functions...

   Hmm.  What if we ditch the "config" interface and instead make a "lua"
   interface.  Well, Ocaml hashtables are faster, so.  Caching?  That could
   work!  Instead of saying "cfg = getConfig cfgfile in cfg#getFloat "foo""
   etc... we just say "lua#getFloat "fooship.bar"".

   Advantages: we use Lua, we keep most of our speed, config files are much
   nicer and WAY more powerful.
   Disadvantages: we use a bit more memory, we load all the Lua config at 
   once which will probably take a while, we might have a namespace collision
   (shouldn't be much of a problem with table-modules).
*)

let top = (-1);;

let luaGetStr env str =
  let ret = (Lauxlib.loadbuffer env str (String.length str) "line") in
    if ret <> 0 then
      let errstr = sprintf 
		     "luaGetStr: %s: syntax error or does not exist?\n %s\n" 
		     str (Lua.tostring env top) in
	Lua.pop env top;
	raise (LuaError errstr)
    else
      if Lua.isstring env top then
	let r = Lua.tostring env top in
	  Lua.pop env top;
	  r
      else
	let errstr = sprintf 
		       "luaGetStr: %s: value is not a string!\n" str in
	  Lua.pop env top;
	  raise (LuaError errstr)
;;

let luaGetFloat env str =
  let ret = (Lauxlib.loadbuffer env str (String.length str) "line") in
    if ret <> 0 then
      let errstr = sprintf 
		     "luaGetFloat(or Int): %s: syntax error or does not exist?\n %s\n" 
		     str (Lua.tostring env top) in
	Lua.pop env top;
	raise (LuaError errstr)
    else
      if Lua.isnumber env top then
	let r = Lua.tonumber env top in
	  Lua.pop env top;
	  r

      else
	let errstr = sprintf 
		       "luaGetFloat(or Int): %s: value is not a number!\n" str in
	  Lua.pop env top;
	  raise (LuaError errstr)
;;


let luaGetBool env str =
  let ret = (Lauxlib.loadbuffer env str (String.length str) "line") in
    if ret <> 0 then
      let errstr = sprintf 
		     "luaGetBool: %s: syntax error or does not exist?\n %s\n" 
		     str (Lua.tostring env top) in
	Lua.pop env top;
	raise (LuaError errstr)
    else
      if Lua.isboolean env top then
	let r = Lua.toboolean env top in
	  Lua.pop env top;
	  r
      else
	let errstr = sprintf 
		       "luaGetBool: %s: value is not a boolean!\n" str in
	  Lua.pop env top;
	  raise (LuaError errstr)
;;

let luaGetInt env str =
  int_of_float (luaGetFloat env str)
;;

let luaLoadFile env str =
  let ret = Lauxlib.loadfile env str in
    if ret <> 0 then
      let errstr = sprintf 
		     "luaLoadFile: error in file %s:\n%s\n" 
		     str (Lua.tostring env top) in
	Lua.pop env top;
	raise (LuaError errstr)
;;

(* Right now, this only does a SINGLE Lua statement, all on ONE line,
   and leaves the return value on the stack.
   Incomplete -> Error
*)
let luaEval env str =
  let ret = (Lauxlib.loadbuffer env str (String.length str) "line") in
    if ret <> 0 then
      let errstr = sprintf 
		     "luaEval: %s: syntax error or does not exist?\n %s\n" 
		     str (Lua.tostring env top) in
	Lua.pop env top;
	raise (LuaError errstr)
    else
      ()
;;



class lua =
object (self)
  val env = Lua.luaOpen ()
  (* Use three caches to get by the typing problem... *)
  val scache = Hashtbl.create 32
  val bcache = Hashtbl.create 32
  val fcache = Hashtbl.create 32

  method loadFile str =
    luaLoadFile env str

  (* Do NOT use a "get" function to call a Lua function!  The value will
     be cached, and you will be passed that value next time without the
     function being invoked! *)
  method getStr str =
    if Hashtbl.mem scache str then
      Hashtbl.find scache str
    else 
      (* luaGetStr would throw an exception if the result wasn't a string. *)
      let v = luaGetStr env str in
	Hashtbl.add scache str v;
	v

  method getFloat str =
    if Hashtbl.mem fcache str then
      Hashtbl.find fcache str
    else 
      (* luaGetStr would throw an exception if the result wasn't a string. *)
      let v = luaGetFloat env str in
	Hashtbl.add fcache str v;
	v

  method getInt str =
    int_of_float (self#getFloat str)

  method getBool str =
    if Hashtbl.mem bcache str then
      Hashtbl.find bcache str
    else 
      (* luaGetStr would throw an exception if the result wasn't a string. *)
      let v = luaGetBool env str in
	Hashtbl.add bcache str v;
	v

  (* These just call the Lua functions directly, with no caching *)
  method evalToStr str =
    luaGetStr env str

  method evalToInt str =
    luaGetInt env str

  method evalToFloat str =
    luaGetFloat env str

  method evalToBool str =
    luaGetBool env str

  (* Does no type-checking, returns no value, leaves nothing on the stack *)
  method evalToUnit str =
    luaEval env str;
    Lua.pop env top;
    
  
(* So we can do primative Lua hacking on it if we need to. *)
  method getEnv = env

  method close = Lua.luaClose env

end;;
