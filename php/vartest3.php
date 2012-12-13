<?php
/* Let's test string variables now.
 * Simon Heath
 * 30/04/2002
 */

$firstName = 'Simon';
$greeting1 = "Hello, my first name is $firstName";
echo $greeting1;
$lastName = 'Heath';
$greeting2 = 'Goodbye, my last name is $lastName';
echo $greeting2;
/* Double quotes evaluate variables and escape 
 * escape characters.  Single quotes print literally.
 */
?>
