<?php
/* Kay, let's do this more formally, ne?
 * Let's also start out a bit simpler.  Just
 * adding number variables together and displaying
 * the result.
 * Simon Heath
 * 30/04/2002
 * Ooh, and watch out: Comments have to be INSIDE the
 * <?php and ?> tags!!
 */

$a = 4;
$b = 7;
$c = 2 + 4 * $a + 5 * $b; /* Order of operations apply */
echo $c;
?>
