/* palindrome1.c
 * Checks to see if a word is a palindrome.
 * More recursion.
 * 
 * Simon Heath
 * 11/11/2002
 */

#include <stdio.h>


/* Wrapper function */
int IsPalindrome( char str[] )
{
   return CheckPalindrome( str, strlen( str ) );
}

int CheckPalindrome( char str[], int len )
{
   printf( "%s\n", str );
   if( len <= 1 )
      return 1;
   else
   {
      return (str[0] == str[ len-1 ] && CheckPalindrome( str + 1, len - 2 ) );
   }
}

main()
{
   char c[ 64 ];

   printf( "Enter a string to check if it's a palindrome\n" );
   scanf( "%s", &c );
   
   if( IsPalindrome( c ) )
   {
      printf( "%s is a palindrome\n" );
   }
   else
   {
      printf( "%s is not a palindrome\n" );
   }
}
