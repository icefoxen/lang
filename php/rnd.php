<?php
/* A handy script I found to round decimals.
 * I didn't make it so I don't get to sign it.
 */

/* Rounds $float to $dec places */
function rnd( $float, $dec )
{
   if ( $dec == 0 )
   {
      return round( $float );
   }
   else
   {
      return floor( $float * pow( 10, $dec ) + 0.5 )
         / pow( 10, $dec );
   }
}

?>
