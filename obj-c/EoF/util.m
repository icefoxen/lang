/* util.m
 * Utility functions.
 *
 * Simon Heath
 * 30/6/2003
 */

#import "EoF.h"


// Loading images
SDL_Surface *LoadImage( char* filename )
{
   char result[256] = "images/";
   SDL_Surface *image;
   
   strcat( result, filename );
   image = IMG_Load( result );
   if( image == NULL )
   {
      printf( "Could not load image %s\n", filename );
      ErrorAndDie();
   }
   printf( "Image %s loaded\n", filename );
   return image;
}



// Universal error
void ErrorAndDie()
{
   printf( "Nasty, evil error: %s\n", SDL_GetError() );
   SDL_Quit();
   exit( 1 );
}

/* SCRATCH! */

/* 

void DrawBall()
{   
   int screenx, screeny;
   int scalex, scaley;
   
   screenx = X2Screen( ball.x );
   screeny = Y2Screen( ball.y );
   

   // Scale the thang!
   scalex = ball.image->w * zoom;
   scaley = ball.image->h * zoom;

   // Blit the thang!
   // the screenN - scaleN / 2 makes the image positioned from the center,
   // not the upper-left corner.
   rotate_scaled_sprite( buffer, ball.image, 
                screenx - scalex /2, screeny - scaley / 2,
                ConvertDegrees( ball.direction ), ftofix( zoom ) );
                
                //ftofix( ball.direction ), ftofix( zoom ) );
                
}
*/
