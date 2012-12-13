/* This reads a file, removing all C-style comments in it.
 *
 * It demonstrates both ungetc(), and some high-level file-twitching
 * functions.
 *
 * Simon Heath
 * 7/11/2002
 */

#include <stdio.h>
#define BUFSIZE 64

void unComment( FILE *infile, FILE *outfile )
{
   int ch, nxtch;
   char commentFlag = 0;  /* Used as a boolean */

   while( (ch = getc( infile )) != EOF )
   {
      if( commentFlag )  /* If you're in a comment... */
      {
         if( ch == '*' ) /* Test for the * that would start an ending flag */
	 {
	    nxtch = getc( infile );
	    if( nxtch = '/' ) /* If it's there, test for the / */
	    {
	       commentFlag = 0; /* We're out of the comment */
	    }
	    else /* Or no, we're still in the comment, unget the char */
	    {
	       ungetc( nxtch, infile ); 
	    } /* ungetc()'ing it isn't strictly necessary, since we're removing
		 the comments anyway.  But it shows the idea better. */
	 }
      }
      else /* No, we're not in a comment, test for a / followed by * */
      {
         if( ch == '/' )
	 {
	    nxtch = getc( infile );
	    if( nxtch == '*' )
	    {
	       commentFlag = 1;
	    }
	    else /* Here it IS necessary to ungetc() it. */
	    {
	       ungetc( nxtch, infile );
	    }
	 }

      }  /* End else */

   if( !commentFlag ) putc( ch, outfile );

   } /* End while */
}  /* End unComment() */


main()
{
   char filename[BUFSIZE], tmp[BUFSIZE]; /* filenames */
   FILE *infile, *outfile; /* actual files */

   printf( "This program removes C-style comments from a file.\n" );
   while( 1 )
   {
      printf( "Input filename: " );
      gets( filename );  /* Reads a line to filename */
      
      infile = fopen( filename, "r" );
      if( filename != NULL ) break;
      printf( "File %s not found --try again", filename );
   }
   
   tmp[0] = "$";  /* There should be a function to handle tmp files, but
	             it's acting screwy...  We'll just put a $ before it. 
		     Only fing is... if there's a file already named $filename,
		     we'll clobber it.  It's rather unlikely, but I still 
		     wouldn't wanna give this prog to the general public.  */
   /* ...Or no, it doesn't.  Weird.  ...By passing "$" to tmp[0] instead of 
    * '$', I guess we add the $ and the null bit together, 'cause instead of 
    * creating $filename it creates åfilename.  ...I suppose that's actually 
    * a good thing.  It's pretty freaky tho.
    */

   /* Oddly, we have to put the [0] after tmp to get this to work.
    * It also works if we make tmp a pointer and do the following:

   tmp = (char *) malloc( BUFSIZE );
   
   *tmp = "$"; 
   
   Anyhoo.  On with the show.*/

   strncat( tmp, filename, (BUFSIZE - 1) );
   /* This appends filename to tmp, and transfers a max of BUFSIZE - 1
    * characters. 
    */

   
   printf( "%s\n", tmp );
   outfile = fopen( tmp, "w" );
   
   if( outfile == NULL ) exit( 1 );
   
   unComment( infile, outfile );

   fclose( infile );
   fclose( outfile );

   remove( filename );
   rename( tmp, filename );  /* These replace the old file with the new. */
}
