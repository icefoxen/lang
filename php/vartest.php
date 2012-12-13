<?php
/* Declaring variables - php is weakly typed. */
/* Let's see how that affects math. */
$name = 'Simon';
$date = 'now';
$alpha = '5';
$beta = 6; /* notice no quotes */
$gamma = 10;

/* The . is the concat operator */
echo $name.' '.$date.'\n';
echo $alpha.$beta.$gamma.'\n';
echo $alpha + $beta.'\n';
/* echo $alpha + 5.'\n';  This doesn't work, it 
 * tries to concat the two strings, not add the two
 * numbers.  I had wondered.
*/

echo $beta + 5.'\n';
$delta = $beta + $gamma; /* Huh, it doesn't do this.
                          * odd. */
echo $delta;
?>
