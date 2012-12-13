/* This pretty much tests whether or not there's a gets() and puts()
 * function.  There's fgets() and fputs(), so....
 */

#include <stdio.h> /* for some weird reason, this changes gets()... */
#define BUFSIZE 64

main()
{
   char str[BUFSIZE];
   gets( str );
   puts( str );
}
