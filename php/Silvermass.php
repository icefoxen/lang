<?php
// Right, let's guesstimate Silverstar's mass, then do a bit of figuring
// to figure out how much energy it would take to move that mass by 1 m/s
// the figure out how much that would be in grams of antimatter.
// I'm nuts.  But PHP is the most convenient langage I know to do it in.
// Simon Heath
// 30/04/2002

// Set up a for loop to build a bignum -- I don't know if you even CAN use
// exponants in PHP.  Or rather, I don't know the function to do so.
// Come to think of it, I could write one.  Later.

$temp = 1;                     // initialize
for ($i = 0; $i <= 7; $i++)    // the 7 means we're getting 10^7;
{                              // change as necessary.
   $bignum = $temp * 10;
   $temp = $bignum;           // I'm not sure how it'll evaluate; BSTS
}


$maSS = 5 * $bignum;        // Silverstar's mass in kg -roughly 50 million kg
$deltaV = 1;                // Desired change in motion in meters/second.
$eSS = $maSS * $deltaV;     // total energy needed to move it
$time = 1;                 // how many seconds you are applying the force over
$fSS = $eSS / $time;       // force needed per second.

echo $eSS;
echo " joules to move $deltaV meters per second\n";

$mAM = 1;                  // Amount of kilograms of antimatter -keep this at 1
$c = 297000000;            // C in meters per second
$e = $mAM * ($c ^ 2);      // e=mc^2  --energy in per kilogram of AM.

echo $e;
echo " joules in $mAM kilograms of antimatter\n";
echo $e / 1000;
echo " joules in $mAM grams of antimatter\n";

$fuel = $eSS / $e;

echo $fuel;
echo " * $mAM kilograms of antimatter needed to accelerate $deltaV meters";
echo " per second.\n";
echo $fuel * 1000;
echo " * $mAM grams of antimatter to blah blah blah\n";
?>
