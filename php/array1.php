<?php
/* Arrays now.  Same C/Java syntax, a variable with
 * the array subscript surrounded by [].
 * You can fill the subscript with a number or leave
 * it blank if you don't care which subscript the 
 * variable gets, or /fill it with a string!/  Cool!
 * Simon Heath
 * 30/04/2002
 */

$data[ 'firstName' ] = 'Simon';
$data[ 'last name' ] = 'Heath';
/* It's a string literal, so you can have a space in it. */
$data[ 'nick' ] = 'Icefox';
$data[ 'age' ] = 17;

echo 'Hello ' . $data[ 'firstName' ] . '!  Your full name'
   . ' is ' . $data[ 'firstName' ] . ' ' . $data[ 'nick' ] .
   ' ' . $data[ 'last name' ] . '.  We know you are ' .
   $data[ 'age' ] . ' years old.';
?>
