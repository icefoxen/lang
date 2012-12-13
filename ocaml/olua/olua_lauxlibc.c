/* olua_lauxlib.c
   I think you can guess what this is by now.
   If not, read the other files first.

   Simon Heath
   10/9/2004
*/

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <lua.h>
#include <string.h>

#define getLuaState( v ) ((lua_State*) Field( v, 1 ))


value olua_getmetafield( value l, value i1, value s, value i2 )
{
   lua_State *m = getLuaState( l );
   int i = Int_val( i1 );
   int j = Int_val( i2 );
   /* XXX: Should c be freed? */
   char *c = String_val( s );
   int r = luaL_getmetafield( m, i, c, j );
   return Val_int( r );
}

value olua_callmeta( value l, value i, value s )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   char *c = String_val( s );
   int r = luaL_callmeta( m, j, c );
   return Val_int( r );
}

value olua_typeerror( value l, value i, value s )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   char *c = String_val( s );
   int r = luaL_typerror( m, j, c );
   return Val_int( r );
}

value olua_argerror( value l, value i, value s )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   char *c = String_val( s );
   int k = luaL_argerror( m, j, c );
   return Val_int( k );
}
/*
value olua_checkstring( value l, value i1, value i2 )
{ 
   lua_State *m = getLuaState( l );
   int j = Int_val( i1 );
   int k = Int_val( i2 );
   char *c = luaL_checklstring( m, j, k );
   return copy_string( c );
}

value optstring( value l, value i1, value s, value i2 )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i1 );
   int k = Int_val( i2 );
   char *c = String_val( s );
   char *d = luaL_optstring( l, j, c, k );
   return copy_string( d );
   
}
*/


value olua_checknumber( value l, value i )
{ 
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   double d = (double) luaL_checknumber( m, j );
   return copy_double( d );
}

value olua_optnumber( value l, value i, value f )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   double d = Double_val( f );
   double e = (double) luaL_optnumber( m, j, d );
   return copy_double( e ); 
}

value olua_lcheckstack( value l, value s )
{ 
   lua_State *m = getLuaState( l );
   char *c = String_val( s );
   luaL_checkstack( l, c );
   return Val_unit;
}

value olua_checktype( value l, value i1, value i2 )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i1 );
   int k = Int_val( i2 );
   luaL_checktype( l, j, k );
   return Val_unit;
}

value olua_checkany( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   luaL_checkany( l, j );
   return Val_unit;
}


value olua_newmetatable( value l, value s )
{
   lua_State *m = getLuaState( l );
   char *c = String_val( s );
   int i = luaL_newmetatable( m, c );
   return Val_int( i );
}

value olua_lgetmetatable( value l, value s )
{
   lua_State *m = getLuaState( l );
   char *c = String_val( s );
   int i = luaL_getmetatable( m, c );
   return Val_int( i );
}

value olua_where( value l, value i )
{
   lua_State *m = getLuaState( l );
   int k = Int_val( i );
   luaL_where( m, k );
   return Val_unit;
}


value olua_lref( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = luaL_ref( m, j );
   return Val_int( k );
}

value olua_lunref( value l, value i1, value i2 )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i1 );
   int k = Int_val( i2 );
   luaL_unref( m, j, k );
   return Val_unit; 
}

value olua_getn( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = luaL_getn( m, j );
   return Val_int( k );
}

value olua_setn( value l, value i1, value i2 )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i1 );
   int k = Int_val( i2 );
   luaL_setn( m, j, k );
   return Val_unit;
}

value olua_loadfile( value l, value s )
{
   lua_State *m = getLuaState( l );
   char *c = String_val( s );
   int i = luaL_loadfile( m, c );
   return Val_int( i ); 
}

value olua_loadbuffer( value l, value s1, value i, value s2 )
{
   lua_State *m = getLuaState( l );
   char *c = String_val( s1 );
   int j = Int_val( i );
   char *d = String_val( s2 );
   int k = luaL_loadbuffer( m, c, j, d );
   return Val_int( k );
}

value olua_dofile( value l, value s )
{
   lua_State *m = getLuaState( l );
   char *c = String_val( s );
   int i = lua_dofile( m, c );
   return Val_int( i );
}

value olua_dostring( value l, value s )
{
   lua_State *m = getLuaState( l );
   char *c = String_val( s );
   int i = lua_dostring( m, c );
   return Val_int( i );
}
