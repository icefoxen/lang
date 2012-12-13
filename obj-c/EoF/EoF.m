/* Edge of Infinity main game file.
 * 
 *
 * Simon Heath
 * 24/3/2003
 */

#include <time.h>           // Standard libraries
#include <stdlib.h>         //
#include <string.h>

#import "EoF.h"             // Main game header --includes SDL.h

#import "LinkedList.h"      // LinkedList class definition
#import "Sprite.h"          // Sprite class


/****************************************************************************/
/** CONSTANTS AND DEFINITIONS ***********************************************/


/****************************************************************************/
/** GLOBAL DATA *************************************************************/

// The screen surface
SDL_Surface *screen;

// Linked list of ship objects
id shipList;



/****************************************************************************/
/** UTILITY FUNCTIONS *******************************************************/

// Cleanup
void FreeSurfaces()
{
   SDL_FreeSurface( screen );
   printf( "Surfaces freed\n" );
   return;
}


/****************************************************************************/
/** MAIN ********************************************************************/

void mainloop()
{
   id currentShip;
   int dun = 0;
   int i;
   int paletteBlack = SDL_MapRGB( screen->format, 0, 0, 0 );
   char *keys;
   SDL_Rect *shiprect;

   printf( "Running mainloop\n" );
   
   while( !dun )
   {
      // Event handling
      // We need to do the PollEvent for the event handling to work.
      SDL_PollEvent( NULL );
      keys = SDL_GetKeyState( NULL );
      
      if( keys[SDLK_UP] )
         ;
      if( keys[SDLK_DOWN] )
         ;
      if( keys[SDLK_LEFT] )
         ;
      if( keys[SDLK_RIGHT] )
         ;
      if( keys[SDLK_q] || keys[SDLK_ESCAPE] )
      {
	 printf( "Quit key pressed...\n" );
         dun = 1;
      }
      
      
      // Erase the background
      if( SDL_FillRect( screen, NULL, paletteBlack ) < 0 )
         ErrorAndDie();
      
      // XXX: Something's wrong here, it doesn't display the ship.
      // Consistancy problems, possibly...  Czech for off-by-one errors in the
      // LinkedList code!
      
      // Loop over the shiplist and draw each ship.
      for( i = 0; i < [shipList length]; i++ )
      {
	 currentShip = [shipList getNth: i];
	 printf( "  Processing ship #%d: %s\n", i, [currentShip getName] );
	 printf( "  Game: x=%f y=%f\n", [currentShip getX], 
	    [currentShip getY] );
	 /* printf( "  Screen: x=%d y=%d\n", [currentShip getScreenX],
	    [currentShip getScreenY] );
	 */
         [currentShip drawOnScreen: screen: 0: 0: 800: 600];
	 [currentShip calculate];
      }
      [[shipList getNth: 0] drawOn: screen: 400: 400];
      // Blit the image --double buffering is done automatically.
      //SDL_BlitSurface( [[shipList getNth: 0] getCurrentImage], NULL,
      //                     screen, &[[shipList getNth: 0] getRect] );
         
      // Update the screen --I believe this does dirtyrecting
      *shiprect = [[shipList getNth: 0] getRect];
      SDL_UpdateRects( screen, 1, shiprect );

      SDL_Flip( screen );
   }

   printf( "Leaving mainloop\n" );
   
   return;
}

int main( int argc, char **argv )
{   

   // Initialize random number generator
   srand( time( NULL ) );

   // Initialize SDL
   if( SDL_Init( SDL_INIT_EVERYTHING ) < 0 )
      ErrorAndDie();
   printf( "SDL initialized.\n" );
   
   // Init screen -fastest way, I believe.
   // --800 x 600, native bit depth preferred.
   // --Hardware surface with fullscreen and double-buffering
   // XXX The res should be grabbed from a config file someday!
   screen = SDL_SetVideoMode( 800, 600, 0, 
               SDL_HWSURFACE | SDL_FULLSCREEN | SDL_DOUBLEBUF );
   if( screen == NULL )
      ErrorAndDie();
   printf( "Set %dx%d at %d bits-per-pixel mode\n",
             screen->w, screen->h, screen->format->BitsPerPixel );
             
   // Hide the mouse cursor
   SDL_ShowCursor( SDL_DISABLE );
   
   // Load and display stuff
   
   // Set transparency if we want any --not needed here yet, thank you...  
   //SDL_SetColorKey( image, SDL_SRCCOLORKEY, 
   //                        SDL_MapRGB( image->format, 0, 0, 0 ) );
   
   // Timer -- Calls testfunc every 30 ms
   // This is just an example.
   // SDL_AddTimer( 1000, (SDL_NewTimerCallback) &testfunc, NULL );


   // Initialize objects
   shipList = [[LinkedList new] init];
   printf( "Shiplist init'ed\n" );
   [Sprite new: "TestShip"];
   printf( "Sprites loaded\n" );

   mainloop();
   
   /* Cleanup */
   [shipList freeAll];
   FreeSurfaces();
   SDL_Quit();
   printf( "Quitting...\n" );
   exit( 0 );
}
