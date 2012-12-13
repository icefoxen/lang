<?php
/* Include Test.
 * This tests being able to define a function, then
 * save it as a file and use the include() statement
 * to import that function.
 * The function in this case is rnd.php
 * Simon Heath
 * 30/04/2002
 */

include( 'rnd.php' );
$var = 42.32423;
$sig = 3;

/* Round $var to $sig significant figures... */

$res = rnd( $var, $sig );
echo $res . "\n\n";

echo 'Well whaddya know, it works!!!';
?>
