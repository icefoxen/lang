# planettemp.rb
# Program to calculate the change in temperature of a planetoid when hit
# by another planetoid.
# 
# Simon Heath
# 21/1/2007

# Gravitational constant (m^3/kg*s^2)
G = 6.67e-11

# Density of rock (kg/m^3)
RHO = 3000.0

# Specific heat of rock (J/(kg*K))
C = 1000.0

# V = 4/3 * pi * r^3  (m^3)
def volumeOfSphere( r )
   return (4.0/3.0) * Math::PI * (r**3)
end

# V*RHO (kg)
def massFromRadius( r )
   return volumeOfSphere( r ) * RHO
end

# Ve = sqrt( 2GM/r ) (m/s)
def escapeVel( r )
   m = massFromRadius( r )
   return Math::sqrt( (2*G*m)/r )
end

# DeltaT = 1/2 * v^2/C * m/M   (degrees C?)
def deltaT( rPlanetoid1 )
   rPlanetoid2 = rPlanetoid1 / 2
   m1 = massFromRadius( rPlanetoid1 )
   m2 = massFromRadius( rPlanetoid2 )
   v = escapeVel( rPlanetoid1 )

   return 0.5 * v**2/C * m2/m1
end

# The above done a different way to double-check.
def deltaT2( rPlanetoid1 )
   rPlanetoid2 = rPlanetoid1 / 2
   m1 = massFromRadius( rPlanetoid1 )
   m2 = massFromRadius( rPlanetoid2 )

   return (((2 * G * m1) / rPlanetoid1) * m2) / (2 * C * m1)
end

# Radii (m)
rMercury = 2437000
rVenus   = 6051000
rEarth   = 6371000
rMars    = 3390000
rMoon    = 1738000
rPluto   = 1195000

initialT = 500

print( "Mass of mercury: ", massFromRadius( rMercury ), "\n" )
print( "Mass of venus: ", massFromRadius( rVenus ), "\n" )
print( "Mass of earth: ", massFromRadius( rEarth ), "\n" )
print( "Mass of mars: ", massFromRadius( rMars ), "\n" )
print( "Mass of pluto: ", massFromRadius( rPluto ), "\n" )
print( "Mass of moon: ", massFromRadius( rMoon ), "\n" )

print( "\n" )

print( "Mercury: ", deltaT2( rMercury ), "\n" )
print( "Venus:   ", deltaT2( rVenus ), "\n" )
print( "Earth:   ", deltaT2( rEarth ), "\n" )
print( "Mars:    ", deltaT2( rMars ) , "\n" )
print( "Pluto:   ", deltaT2( rPluto ), "\n" )
print( "Moon:    ", deltaT2( rMoon ), "\n" )

print( "\n" )

# W00t, my math doesn't suck!
print( "Mercury: ", deltaT( rMercury ) + initialT, "\n" )
print( "Venus:   ", deltaT( rVenus ) + initialT, "\n" )
print( "Earth:   ", deltaT( rEarth ) + initialT, "\n" )
print( "Mars:    ", deltaT( rMars ) + initialT, "\n" )
print( "Pluto:   ", deltaT( rPluto ) + initialT, "\n" )
print( "Moon:    ", deltaT( rMoon ) + initialT, "\n" )
