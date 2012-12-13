/* A trivial Xt program
 * Compile with:
 * gcc -I/usr/X11R6/include -L/usr/X11R6/lib -lXaw -lXmu -lXext -lXt -lX11
 * filename.c
 *
 * Simon Heath
 * 4/9/2003
 */

#include <X11/StringDefs.h>
#include <X11/Intrinsic.h>
#include <X11/Xaw/Command.h>

extern int exit();

int main( int argc, char **argv )
{
   Widget toplevel, button;
   XtAppContext app;

   /* Initialize the app */
   toplevel = XtAppInitialize( &app, "Trivial App",
      NULL, 0, &argc, argv, NULL, NULL );

   /* Create a widget structure */
   button = XtVaCreateManagedWiget( "Button",
      CommandWigetClass, toplevel, XtNlabel, "Hello World!",
      XtNwidth, 256, XtNheight, 256, NULL );

   /* Add a callback to exit when a mouse button is pressed */
   XtAddCallback( button, XtNcallback, exit, NULL );

   /* Display the widget */
   XtRealizeWidget( toplevel );

   /* Do mainloop */
   XtAppMainloop( app );

   return 0;

}
