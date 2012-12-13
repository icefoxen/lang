/* olua_lualibc.c
   Interface exposing the Lua library loading functions to Ocaml

   Simon Heath
   10/9/2004
*/


#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <lua.h>
#include <lualib.h>

#define getLuaState( v ) ((lua_State*) Field( v, 1 ))

value olua_openBase( value l )
{
   lua_State *m = getLuaState( l );
   int i = luaopen_base( m );
   return Val_unit /* Val_int( i ) */;
}

value olua_openTable( value l )
{
   lua_State *m = getLuaState( l );
   int i = luaopen_table( m );
   return Val_unit /* Val_int( i ) */;
}

value olua_openIo( value l )
{
   lua_State *m = getLuaState( l );
   int i = luaopen_io( m );
   return Val_unit /* Val_int( i ) */;
}

value olua_openString( value l )
{
   lua_State *m = getLuaState( l );
   int i = luaopen_string( m );
   return Val_unit /* Val_int( i ) */;
}

value olua_openMath( value l )
{
   lua_State *m = getLuaState( l );
   int i = luaopen_math( m );
   return Val_unit /* Val_int( i ) */;
}

value olua_openDebug( value l )
{
   lua_State *m = getLuaState( l );
   int i = luaopen_debug( m );
   return Val_unit /* Val_int( i ) */;
}

value olua_openLoadlib( value l )
{
   lua_State *m = getLuaState( l );
   int i = luaopen_loadlib( m );
   return Val_unit /* Val_int( i ) */;
}

