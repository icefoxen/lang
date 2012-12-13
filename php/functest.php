<?php
/* Kay, the cool stuff now.  Let's make a function.
 * Simon Heath
 * 30/04/2002
 */

/* Declare, name, argument */
function funky ( $arg )
{
   if ( $arg < 10 )
   {
      echo "$arg is less than 10\n";
   }
   else
   {
      echo "$arg is greater than 10\n";
   }
}

funky ( 15 );

echo 'did it work?  I had my eyes closed!';
?>

