#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

#define kWindowWidth 400
#define kWindowHeight 300


GLvoid InitGL( GLvoid );
GLvoid DrawGLScene( GLvoid );
GLvoid ReSizeGLScene( int Width, int Height );

int main( int argc, char** argv )
{
   glutInit( &argc, argv );
   glutInitDisplayMode( GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH );
   glutInitWindowSize( kWindowWidth, kWindowHeight );
   glutInitWindowPosition( 100, 100 );
   glutCreateWindow( argv[0] );

   InitGL();
   
   glutDisplayFunc( DrawGLScene );
   glutReshapeFunc( ReSizeGLScene );

   glutMainLoop();

   return 0;
}
