-- test1.lua
-- Recieves a table from C, sums the concepts, returns the sum.
-- Simon Heath
-- 28/08/2004

io.write( "The table the script received has:\n" )

x = 0

for i, j in foo do
   print( i, j )
   x = x + j
end

io.write( "Returning data back to C\n" )

return x
