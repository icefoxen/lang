/* opengl1.c
   Create an opengl window.
   
   Simon Heath
   13/3/2003
 */

#include <windows.h>
#include <gl/gl.h>
#include <gl/glu.h>

/* Set up rendering context */
HGLRC hRC = NULL;
/* Set up device context */
HDC hDC = NULL;
/* Set up window handle */
HWND hWnd = NULL;
/* Set up the instance of the application */
HINSTANCE hInstance;

/* Array to hold keypresses */
int keys[256];
/* Is the window active? */
int active = 1;
/* Is it fullscreen? */
int fullscreen = 1;

/* Function prototypes */
LRESULT CALLBACK WndProc( HWND, UINT, WPARAM, LPARAM );

/* Resize the GLwossname everytime the window is resized,
   and at least once when the program is started. */
GLvoid ReSizeGLScene( GLsizei width, GLsizei height )
{
   if( height == 0 )
      height = 1;
   
   glViewport( 0, 0, width, height );
   
   /* This bit sets up and resets the projection matrix,
    * which handles perspective. */
   glMatrixMode( GL_PROJECTION );
   glLoadIdentity();
   
   /* Calculate the aspect ratio of the window.
    * 0.1 is the closest anything can get to the screen,
    * 100.0 is the farthest. */
   gluPerspective( 45.0f, (GLfloat) width / (GLfloat) height, 0.1f, 100.0f );
   
   /* Select and reset the modelview matrix */
   glMatrixMode( GL_MODELVIEW );
   glLoadIdentity();
}

/* This is the function that initializes GL */
int InitGL()
{
   /* Enable smooth shading */
   glShadeModel( GL_SMOOTH );
   /* Create black background --fourth color is alpha */
   glClearColor( 0.0f, 0.0f, 0.0f, 0.0f );
   
   /* Create depth buffer */
   glClearDepth( 1.0f );
   glEnable( GL_DEPTH_TEST );
   glDepthFunc( GL_LEQUAL );
   
   /* Tell it to do the nicest perspective stuff */
   glHint( GL_PERSPECTIVE_CORRECTION, GL_NICEST );
   
   return 1;
}

/* This draws the actual scene. */
int DrawGLScene()
{
   /* Clear the scene and depth buffer */
   glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
   /* Reset the current modelview matrix */
   glLoadIdentity();
   
   return 1;
}


