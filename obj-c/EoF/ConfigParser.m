/* ConfigParser.m
 * Implementation of a ConfigParser.
 * It's dead simple; a pair of arrays, one for keys, the other for values.
 * keys[3] will apply to values[3], keys[4] -> values[4], and so on.  I could
 * do this as a hashtable and it might be quicker to search, but all I'm using 
 * this for is to read config files for ships and sprites and such, so I don't 
 * have to re-compile the whole bloody thing each time I decide to tweak the 
 * balance a little.
 *
 *
 * Simon Heath
 * 30/6/2003/
 */

#include <stdio.h>
#include <string.h>
#import <objc/Object.h>

#import "ConfigParser.h"
#import "EoF.h"

@implementation ConfigParser

+ new: (char *) name
{
   id s = [super new];
   [s init: name];
   return s;
}

- init: (char *) name
{
   FILE *configFile;
   char configpath[256] = "";
   char buffer[256];
   char bufchar;
   int lineIndex = 0;

   if( name == "" )
   {
      printf( "Invalid name given to configparser!\n" );
      ErrorAndDie();
   }


   // We stick the filename to the path and add the .cfg extension...
   strcat( configpath, "config/" );
   strcat( configpath, name );
   strcat( configpath, ".cfg" );
   strcpy( filename, configpath );
   
   // Open the thing
   configFile = fopen( configpath, "r" );
   printf( "file %s opened\n", configpath );

   if( configFile == NULL )
   {
      printf( "Config file %s does not exist!\n", configpath );
      ErrorAndDie();
   }
   
   do
   {
      bufchar = getc( configFile );
      // We check for comments, and if we find one, we read a line and
      // throw it away.
      if( bufchar == '#' )
      {
         fgets( buffer, 256, configFile );
      }
      // If the char is a newline, then we've found an empty line and should
      // keep going.
      else if( bufchar == '\n' )
      {
         continue;
      }
      // Else we put the char back where we found it, and parse the line and
      // stick it in the arrays.
      else
      {
         ungetc( bufchar, configFile );
	 fscanf( configFile, "%s\t%s\n", keys[lineIndex], values[lineIndex] );
	 lineIndex++;
      }
      
      // Error checking...
      if( lineIndex >= 512 )
      {
         printf( "Config file %s excessively long; current max 512 values\n",
	   filename ); 
      }
   }
   while( bufchar != EOF );

   fclose( configFile );
   printf( "Config file %s read --%d entries\n", filename, lineIndex - 1 );

   return self;
}


- (int) getIntValue: (char *) key
{
   if( [self keyExists: key] )
   {
      return atoi( values[ [self indexOf: key] ] );
   }
   else
   {
      printf( "Malformed config file: %s.  Doesn't have key %s\n",
         filename, key );
   }

   // Should never be reached --either return a valid value, or error and die
   return -1;
}


- (float) getFloatValue: (char *) key
{
   if( [self keyExists: key] )
   {
      return atof( values[ [self indexOf: key] ] );
   }
   else
   {
      printf( "Malformed config file: %s.  Doesn't have key %s\n",
         filename, key );
   }

   return -1;
}


- (char *) getStringValue: (char *) key
{
   if( [self keyExists: key] )
   {
      return values[ [self indexOf: key] ];
   }
   else
   {
      printf( "Malformed config file: %s.  Doesn't have key %s\n",
         filename, key );
   }

   return NULL;
}


// Returns true if the given key exists
- (BOOL) keyExists: (char *) key
{
   if( [self indexOf: key] >= 0 )
      return YES;
   else
      return NO;
}


// Returns the index of a key
- (int) indexOf: (char *) key
{
   int i;
   for( i = 0; i < 256; i++ )
   {
      if( strcmp( keys[i], key ) == 0 )
         return i;
   }
   return -1;
}

@end
