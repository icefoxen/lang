/* olua_luac.c
   Interface exposing the basic Lua API to Ocaml

   Simon Heath
   9/9/2004
*/


#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <lua.h>
#include <string.h>

#define getLuaState( v ) ((lua_State*) Field( v, 1 ))
/* Sticks a lua state into an ocaml value */
#define makeLuaState( l, r ) \
   do{ \
   r = alloc_final( 2, &lua_State_finalizer, 0, 0 ); Field( r, 1 ) = (value) l; \
   }while(0)
                             

void lua_State_finalizer( value v )
{
   lua_State* l = (lua_State*) Field( v, 1 );
   lua_close( l );
}

/* makeLuaState SHOULD pass the lua_state to the Ocaml GC, but it doesn't
 * appear to actually do so.  So, we have luaClose.
 */
value olua_Open( value v )
{
   lua_State* l;
   value r;
   l = lua_open();
   makeLuaState( l, r );
   
   return r;
}

value olua_Close( value v )
{
   lua_State *l;
   l = getLuaState( v );
   lua_close( l );
   return Val_unit;
}

value olua_Newthread( value v )
{
   value r;
   lua_State *l = lua_newthread( getLuaState( v ) );
   makeLuaState( l, r );
   return r;

}

/* XXX */
value olua_atPanic( value v )
{
   return v;
}

value olua_getTop( value v )
{
   int i = lua_gettop( getLuaState( v ) );
   return Val_int( i );
}

value olua_setTop( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_settop( m, j );
   return Val_unit;
   
}

value olua_pushValue( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_pushvalue( m, j );
   return Val_unit;
}

value olua_remove( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_remove( m, j );
   return Val_unit;
}

value olua_insert( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_insert( m, j );
   return Val_unit;
}

value olua_checkstack( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_checkstack( m, j );
   return Val_unit;
}

value olua_xmove( value l, value i, value j )
{
   lua_State *m = getLuaState( l );
   lua_State *k = getLuaState( i );
   int h = Int_val( j );
   lua_xmove( m, k, h );
   return Val_unit;
}



value olua_isnumber( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isnumber( m, j ) )
      return Val_true;
   else
      return Val_false; 
}

value olua_isstring( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isstring( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_iscfunction( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_iscfunction( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_isuserdata( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isuserdata( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_gettype( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   /* More fragile than I would like, but it should work... 
      XXX: Erm, except for LUA_TNONE...  */
   return Val_int( (int) lua_type( m, j ) );
}

value olua_typename( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   /* Erm, should s be freed?  But it's const... */
   const char* s = lua_typename( m, j );
   return copy_string( s );
}


value olua_equal( value l, value i, value j )
{
   lua_State *m = getLuaState( l );
   int k = Int_val( i );
   int h = Int_val( j ); 
   if( lua_equal( m, k, h ) )
      return Val_true;
   else
      return Val_false;
}

value olua_rawequal( value l, value i, value j )
{
   lua_State *m = getLuaState( l );
   int k = Int_val( i );
   int h = Int_val( j ); 
   if( lua_rawequal( m, k, h ) )
      return Val_true;
   else
      return Val_false;
}

value olua_lessthan( value l, value i, value j )
{
   lua_State *m = getLuaState( l );
   int k = Int_val( i );
   int h = Int_val( j ); 
   if( lua_lessthan( m, k, h ) )
      return Val_true;
   else
      return Val_false;
}

value olua_tonumber( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   double f = lua_tonumber( m, j );
   return copy_double( f );
}

value olua_toboolean( value l, value i )
{ 
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_toboolean( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_tostring( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   /* Again, should S be freed? */
   const char* s = lua_tostring( m, j );
   return copy_string( s );
}

value olua_strlen( value l, value i )
{ 
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   j = lua_strlen( m, j );
   return Val_int( j );
}

/* XXX */
value olua_tocfunction( value l, value i )
{
   return Val_unit;
}

value olua_tothread( value l, value i )
{
   value r;
   lua_State *m = getLuaState( l );
   lua_State *n;
   int j = Int_val( i );
   n = lua_tothread( m, j );
   makeLuaState( m, r );
   return r;
}

value olua_pushnil( value l )
{
   lua_State *m = getLuaState( l );
   lua_pushnil( m );
   return Val_unit;
}

value olua_pushnumber( value l, value f )
{
   lua_State *m = getLuaState( l );
   lua_Number j = Double_val( f );
   lua_pushnumber( m, j );
   return Val_unit;
}

value olua_pushstring( value l, value s )
{
   lua_State *m = getLuaState( l );
   char* str = String_val( s );
   size_t strlen = string_length( s );
   lua_pushlstring( m, str, strlen );
   return Val_unit;
   
}

/* XXX */
value olua_pushclosure( value cf, value i )
{
   return Val_unit;
}

value olua_pushboolean( value l, value b )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( b );
   lua_pushboolean( m, j );
   return Val_unit;
}

value olua_gettable( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_gettable( m, j );
   return Val_unit;
}

value olua_rawget( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_rawget( m, j );
   return Val_unit;
}

value olua_rawgeti( value l, value i, value j )
{
   lua_State *m = getLuaState( l );
   int h = Int_val( i );
   int k = Int_val( j );
   lua_rawgeti( m, h, k );
   return Val_unit;
}

value olua_newtable( value l )
{
   lua_State *m = getLuaState( l );
   lua_newtable( m );
   return Val_unit;
}

value olua_getmetatable( value l, value i )
{ 
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = lua_getmetatable( m, j );
   return Val_int( k );
}

value olua_getfenv( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_getfenv( m, j );
   return Val_unit;
}

value olua_settable( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_settable( m, j );
   return Val_unit;
}

value olua_rawset( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_rawset( m, j );
   return Val_unit;
}

value olua_rawseti( value l, value i, value j )
{
   lua_State *m = getLuaState( l );
   int h = Int_val( i );
   int k = Int_val( j );
   lua_rawseti( m, h, k );
   return Val_unit;
}

value olua_setmetatable( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = lua_setmetatable( m, j );
   return Val_int( k );
}

value olua_setfenv( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = lua_setfenv( m, j );
   return Val_int( k ); 
}


value olua_call( value l, value i, value j )
{
   lua_State *m = getLuaState( l );
   int h = Int_val( i );
   int k = Int_val( j );
   lua_call( m, h, k ); 
   return Val_unit;
}

value olua_pcall( value l, value i, value j, value k )
{
   lua_State *m = getLuaState( l );
   int i1 = Int_val( i );
   int i2 = Int_val( j );
   int i3 = Int_val( k );
   int r = lua_pcall( m, i1, i2, i3 ); 
   return Val_int( r );
}


value olua_yield( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = lua_yield( m, j );
   return Val_int( k );
}

value olua_resume( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = lua_resume( m, j );
   return Val_int( k );
}


value olua_getgcthreshold( value l )
{
   lua_State *m = getLuaState( l );
   int k = lua_getgcthreshold( m );
   return Val_int( k );
}

value olua_getgccount( value l )
{
   lua_State *m = getLuaState( l );
   int k = lua_getgccount( m );
   return Val_int( k );
}

value olua_setgcthreshold( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_setgcthreshold( m, j );
   return Val_unit;
}



value olua_error( value l )
{
   lua_State *m = getLuaState( l );
   int i = lua_error( m );
   return Val_int( i );
}

value olua_next( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   int k = lua_next( m, j );
   return Val_int( k );
}

value olua_concat( value l, value i )
{ 
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_concat( m, j );
   return Val_unit;
}



value olua_pop( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   lua_pop( m, j );
   return Val_unit;
}

value olua_isfunction( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isfunction( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_istable( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_istable( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_islightuserdata( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_islightuserdata( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_isnil( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isnil( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_isboolean( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isboolean( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_isnone( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isnone( m, j ) )
      return Val_true;
   else
      return Val_false;
}

value olua_isnoneornil( value l, value i )
{
   lua_State *m = getLuaState( l );
   int j = Int_val( i );
   if( lua_isnoneornil( m, j ) )
      return Val_true;
   else
      return Val_false;
}

/* XXX: ???
value olua_pushliteral( value l, value s )
{
   lua_State *m = getLuaState( l );
   char *str = String_val( s );
   lua_pushliteral( m, str );
   return Val_unit;
}

*/
