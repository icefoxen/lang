-- Defines a factorial function
function fact( n )
   if n == 0 then
      return 1
   else
      return n * factorial( n - 1 )
   end
end

print "Enter a number: "
a = read( "*number" )  -- Read a number
print( factorial( a ) )
