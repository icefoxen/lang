<?php
// Skyhook Mass.
// This figures the mass of a skyhook.
// Simple, ne?  ;-D
// You have to guess on the necessary width and stuff though.
// Simon Heath
// 30/04/2002

$radius = 0.005;           // diameter of 0.01 meters, 1 cm
$length = 50000000;        // 50,000,000 meters, 50,000 km.

$base = $radius * $radius * 3.14159; // Figure the base area
$volume = $base * $length;

$mass = 2;                      // Mass in g/cm^3.  Buckyfiber is about 2.
$bigMass = $mass * 1000;        // Mass in kg/m^3 (100^3 / 1000)
$netMass = $bigMass * $volume;  // Skyhook total mass.

echo "Skyhook radius = $radius m\n";
echo "Skyhook length = $length m\n";
echo "Skyhook volume = $volume m^3\n";
echo "Material mass = $mass g/cm^3\n\n";

echo "Net Skyhook mass = $netMass kilograms.\n\n"
?>
