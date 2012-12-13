-- playing with tables

a = {10, 20, 30, 40, 50}

print( "Size of a:", table.getn( a ) )
table.insert( a, 60 )
print( "Size of a:", table.getn( a ) )
table.insert( a, 9, 90 )
print( "Size of a:", table.getn( a ) )

for x,y in pairs( a ) do
   print( x, y )
end

table.remove( a, 3 )
print( "Size of a:", table.getn( a ) )

for x,y in pairs( a ) do
   print( x, y )
end

print( "For pairs" )
for x,y in pairs( a ) do
   print( x, y )
end

print( "For ipairs" )
for x,y in ipairs( a ) do
   print( x, y )
end

-- io.lines returns an iterator
x = 0
for line in io.lines( "table.lua" ) do
   x = x + 1
end
print( "Number of lines in this file:", x )

-- Another way of doing the same
x = 0
file = io.open( "table.lua", "r" )
for line in file:lines() do
   x = x + 1
end
print( "Number of lines in this file:", x )

-- If a table has an element "n" with a numerical value, library functions
-- tend to assume that value is the size
c = {10, 20, 30, n=10}
table.foreachi( c, print )

-- You can also explicitly set the size of a table
-- How does that affect the above?
--print( table.getn( c ) )
--table.setn( c, 5 )         -- Also sets the "n" element of the table
--print( table.getn( c ) )
--print( c.n )

print( "Concatenation into strings" )
print( table.concat( {1,2,3}, ", " ) )
print( table.concat( {1,2,3,4,5,6,7,8,9,0}, ", ", 3, 7 ) )

print( "Sorting" )
d = {432,654,23,6,32,7,243,7,432,6,31}

table.foreach( d, print )
table.sort( d )
table.foreach( d, print )
