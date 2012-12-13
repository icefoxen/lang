/*
Implements a simplified UNIX wc...  Counts characters, words
and lines.  Reads from stdin.
23/09/2002  */


#define MaxLine 200

char Line[MaxLine];  /* One line from the file */

int NChars = 0,  /* Number of characters seen so far */
    NWords = 0,  /* Words seen so far */
    NLines = 0,  /* Lines seen so far */
    LineLength;  /* Length of current line */

PrintLine()  /* For debugging only */
{
   int i;
   for( i = 0; i < LineLength; i++ )
      printf( "%c", Line[i] );
   printf( "\n" );
}

int WordCount()
   /* Counts the number of words in a file, which is taken to be
      the number of spaces + 1, except if the line is only \n */
{
   int i,
       NBlanks = 0;

   for( i = 0; i < LineLength; i++ )
      if ( Line[i] == ' ' ) 
         NBlanks++;

   if (LineLength > 1) 
      return NBlanks + 1;
   else
      return 0;
}

int ReadLine()
   /* Reads one line of the file, returning number of chars.  Will 
      return 0 if end of line is reached. */
{
   char c;
   int i;

   if( scanf( "%c", &c ) == -1 )
      return 0;

   Line[0] = c;
   if ( c == '\n')
      return 1;

   for( i = 1; ; i++ )  /* The 'condition' is provided by the return */
   {                    /* statement. */
      scanf( "%c", &c ); /* &c means effectively that c will get */
      Line[i] = c;       /* called pass-by-REFERENCE, instead of */
      if( c == '\n' )    /* by value.  Important! */
         return i + 1;
   }
}

UpdateCounts()
{
   NChars += LineLength;
   NWords += WordCount();
   NLines++;
}

main()
{
   while( 1 )
   {
      LineLength = ReadLine();
      if( LineLength == 0 )
         break;
      UpdateCounts();
   }
   printf( "%d %d %d\n", &NChars, &NWords, &NLines );
}