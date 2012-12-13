<?php
/* Kay, an example of concatenating two string-variables.
 * It doesn't work like Java, you can't do for instance
 * "Statement one" + var + "Statement two"
 * I think.  Let's find out.  Anyway, it's always easy
 * to just make another variable.
 * Simon Heath
 * 30/04/2002
 */

$firstName = 'Simon';
$lastName = 'Heath  ';
echo $firstName.$lastName;

$fullName = $firstName.$lastName;
echo $fullName;

$name2 = $firstName.' '.$lastName;
echo $name2;

$space = ' ';

$name3 = $firstName.$space.$lastName;
echo $name3;
/* The first two write SimonHeath, the last two write
 * Simon Heath.
 */
?>
