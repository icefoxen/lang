/* test1.c
 * Sets up lua, passes it a table, calls the script test1.lua, and recieves
 * the result.
 *
 * Simon Heath
 * 28/08/2004
 */

#include <stdlib.h>
#include <stdio.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>


void loadLuaLibs( lua_State *l )
{
   int a = luaopen_base( l );
   int b = luaopen_table( l );
   int c = luaopen_io( l );
   int d = luaopen_string( l );
   int e = luaopen_math( l );
   int f = luaopen_debug( l );
   int g = luaopen_loadlib( l );

   printf( "a:%d b:%d c:%d d:%d e:%d f:%d g:%d\n", a, b, c, d, e, f, g );

 /* Flush the stack by setting it's top to 0, to ignore any return from 
      the library init funcs */  
   lua_settop( l, 0 );
}




int main()
{
   int result, i;
   double sum;

   /* Create a new lua context */
   lua_State *l = lua_open();

   loadLuaLibs( l );

   /* Load the file containing our script */
   result = luaL_loadfile( l, "test1.lua" );
   if( result ) 
   { 
      fprintf( stderr, "Bad file, bad.  No biscuit.\n" );
      exit( 1 );
   }

   /* We tell Lua to create a new table on the stack */
   lua_newtable( l );

   /* To put values into the table, we push the index, then the value,
      then call lua_rawset with the index of the table in the stack.
      -1 always refers to the top of the stack.  In this case, that's the
      value, -2 would be the index, -3 would be the table.
      lua_rawset() pops the top two items of the stack, as well.
   */
   for( i = 0; i < 5; i++ )
   {
      lua_pushnumber( l, i );
      lua_pushnumber( l, i * i );
      lua_rawset( l, -3 );
   }

   /* A table must be terminated by a cell with the key the literal "n"
      and the value the size of the table. */
   lua_pushliteral( l, "n" );
   lua_pushnumber( l, i - 1 );  /* Push number of cells */
   lua_rawset( l, -3 );

   /* Tell lua that the table is called "foo" */
   lua_setglobal( l, "foo" );
   
   /* Tell lua to run our script */
   result = lua_pcall( l, 0, LUA_MULTRET, 0 );
   if( result ) 
   { 
      fprintf( stderr, "Bad file, bad.  No biscuit.\n" );
      exit( 1 );
   }

   /* Get the number returned on the top of the stack */
   sum = lua_tonumber( l, lua_gettop( l ) );
   if( !sum )
   {
      fprintf( stderr, "lua_tonumber() failed!\n" );
      exit( 1 );
   }

   printf( "Script returned %f\n", sum );

   /* Take returned value out of the stack and close lua. */
   lua_pop( l, 1 );
   lua_close( l );

   return 0;
}
