#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Okay.  This works fine.  >_> */
int parseBinary( char* s )
{
   char* start = (s + 2);
   char* end = s + strlen( s ) - 1;
   long int ret = strtol( start, &end, 2 );
   return ret;
}

/* Buggy as hell */
int parseNumber( char* s )
{
   char* start = s;
   char* end = s + strlen( s ) - 1;
   int base = 10;
   long int ret;
   printf( "Control char: %c\n", s[1] );
   if( s[1] == 'x' )
   {
      base = 16;
      s += 2;
   }
   if( s[1] == 'o' )
   {
      base = 8;
      s += 2;
   }


   ret = strtol( start, &end, base ); 
   while( start != end )
   {
      putc( *start, stdout );
      start++;
   }
   printf( "Number parsed in base %d: %d\n", base, (int) ret );
   return ret;
}

int main( int argc, char** argv )
{
   int result = -1;
   char* str = *(argv + 1);
   char* f = "771";
   char* fe = f + strlen( f ) - 1;
   printf( "Parsing %s to number\n", str );
   result = parseNumber( str );
   printf( "Number parsed: %s -> %d\n", str, result );

   printf( "strtol() thinks 771 should be: %d\n", strtol( f, &fe, 8 ) );

   return 0;
}
