/* Sprite.m
 * A sprite class!  Yay!
 * Read the header file for more info on how this class fits into everything.
 *
 * Simon Heath
 * 30/6/2003
 */


#import "Sprite.h"
#import "EoF.h"

extern id shipList;

@implementation Sprite


/***************************************************************************/
/**  ALLOCATION  ***********************************************************/


// Allocate a new sprite
+ new: (char *) givenName
{
   id s = [super new];
   [s init: givenName];
   return s;
}

// Frees the sprite
- free
{
   int i;
   // Free all the surfaces
   for( i = 0; i <= 64; i++ )
   {
      SDL_FreeSurface( &image[i] );
   }
   // Remove the ship from shipList
   i = [shipList search: self];
   [shipList removeNode: i];
   printf( "Sprite %s freed", name );

   return [super free];
}


// Initialize all data
- init: (char *) givenName
{
   id config;
   int i;
   char* filename;
   
   x = 0.0;
   y = 0.0;
   angle = 0;

   // Set up the configparser
   printf( "setting up ConfigParser\n" );
   config = [ConfigParser new: givenName];
   
   // Add the sprite to shipList
   printf( "New shipList node made\n" );
   [shipList addNode: self];

   // Grab the image name from the config file, then load it.
   if( [config keyExists: "IMAGE"] )
      filename = [config getStringValue: "IMAGE"];
   else
   {
      printf( "Config file %s.cfg malformed: No IMAGE attribute", name );
      ErrorAndDie();
   }

   image[0] = *LoadImage( filename );

   // Build all the rotation-images
   for( i = 1; i <= 64; i++ )
   {
      // From the SDL_rotozoom library; it goes:
      // source_surface, angle, zoom, anti-alias
      image[i] = *rotozoomSurface( &image[0], i * 5.625, 1, YES );
   }
   
   // Get the rect... I think this is right...
   SDL_GetClipRect( &image[0], &rect ); 

   return self;
}


/***************************************************************************/
/**  ACCESSORS  ************************************************************/


// Accessors
- (SDL_Surface *) getImage
{
   return &image[0];
}


// This sets the basic image
- setImage: (SDL_Surface *) newImage
{
   image[0] = *newImage;

   return self;
}


- setImageRotation: (SDL_Surface *) newImage: (int) index
{
   if( index >= 0 && index < 64 )
   {
      image[index] = *newImage;
   }
   else
   {
      printf( "[Sprite setImageRotation]: invalid index: %d", index );
      ErrorAndDie();
   }
   return self;
}


// This returns the image with the proper amount of rotation.
- (SDL_Surface *) getCurrentImage
{
   int index = angle / 64;
   return &image[index];
}


- (SDL_Rect) getRect
{
   return rect;
}


- setRect: (SDL_Rect) newRect
{
   rect = newRect;
   return self;
}


- (char *) getName
{
   return name;
}


/***************************************************************************/
/**  MOVEMENT  *************************************************************/


// Movement functions
- moveTo: (float) newX: (float) newY
{
   x = newX;
   y = newY;

   return self;
}

- (float) getX
{
   return x;
}

- (float) getY
{
   return y;
}


- rotateTo: (int) newAngle
{
   angle = newAngle;
   angle = angle % 360;
   return self;
}

- rotateLeft: (int) degrees
{
   angle -= degrees;
   angle = angle % 360;
   return self;
}

- rotateRight: (int) degrees
{
   angle += degrees;
   angle = angle % 360;
   return self;
}

- (int) getAngle
{
   return angle;
}

// This is the function that is called whenever something hits the object
// Override this; default behavior is to do nothing
- collide: other
{
   
   return self;
}

// This function is called for EVERY game-loop.  It does anything that
// needs to be done, such as inertia and AI.
// Override this in subclasses!
- calculate
{

   return self;
}


/***************************************************************************/
/**  GRAPHICS  *************************************************************/
// XXX: Something's wrong with these, it doesn't display the ship.


// These determine the position of the sprite on the screen.  
- (int) getScreenX: (float) screenX: (int) screenWidth
{
   return x - screenX + (screenWidth / 2);
}

- (int) getScreenY: (float) screenY: (int) screenHeight
{
   return -y + screenY + (screenHeight / 2);
}


// Draws the sprite on a surface at the given co-ords.
- drawOn: (SDL_Surface *) surface: (int) screenx: (int) screeny
{
   
   SDL_Rect newRect;
   newRect.w = rect.w;
   newRect.h = rect.h;
   newRect.x = screenx;
   newRect.y = screeny;
   if( SDL_BlitSurface( [self getCurrentImage], NULL, surface, &newRect ) < 0 )
      ErrorAndDie();
   /*
   if( SDL_BlitSurface( [self getCurrentImage], NULL, surface, &rect ) < 0 )
      ErrorAndDie();
   */

   return self;
}


// Draws on the given surface after doing Gameworld-to-Screenworld
// translation.  screenX and screenY are the Gameworld co-ords of the screen
- drawOnScreen: (SDL_Surface *) screen: (float) screenX: (float) screenY:
                (int) screenWidth: (int) screenHeight
{
   int screenworldX, screenworldY;

   // Check to see if the things ON the screen, first....
   if( [self isOnScreen: screenX: screenY: screenWidth: screenHeight] )
   {
      screenworldX = [self getScreenX: screenX: screenWidth];
      screenworldY = [self getScreenY: screenY: screenHeight];
      [self drawOn: screen: screenworldX: screenworldY];
   }

   return self;
}


// Returns true if the sprite is within the bounds given.
- (BOOL) isOnScreen: (int) screenx: (int) screeny: (int) width: (int) height
{
   int screenX, screenY;
   screenX = [self getScreenX: screenx: width];
   screenY = [self getScreenY: screeny: height];
   if( (screenX >= 0 && screenX < width) && 
       (screenY >= 0 && screenY < height) )
      return YES;
   else
      return NO;
}


@end
