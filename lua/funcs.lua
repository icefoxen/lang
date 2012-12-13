-- Functions!  Yay!
function f(x)   return x * 2 end
-- is the same as
d = function(x) return x * 2 end

print( f( 10 ) )
print( d( 10 ) )

-- Functions are dynamically typed, of course.
a = "string"
a = d
print( d( 20 ) )

print( type( d ) )

-- "Gracefully" handles ungiven and overgiven args
function foo( a, b ) print( a, b ) end
foo()
foo( 10 )
foo( 10, 20 )
foo( 10, 20, 30 )

-- We can have variable numbers of args, which turns into an array called 
-- "arg"
function bar( ... )
   table.foreach( arg, print )
end
bar( 10, 20, 30, 40, 50 )


-- Hmm, this is a bit curious...
print( "Unpacking" )
a = {10, 20, 30}
bar( a )
bar( unpack( a ) )


print( "Returning multiple values!" )
-- We can also return more than one value
function div( x, y )
   -- Recall that all numbers are floats!
   return math.floor(x/y), math.mod(x, y)
end

print( div( 22, 5 ) )
i,j = div( 55, 7 )
print( i, j )
t = { div( 9, 8 ) }
table.foreachi( t, print )
-- And to get only the first arg, surround the funcall in ()'s
print( (div( 22, 5 )) )


-- Iterators, just for the hell of it.
print( "Iterators!" )
function square( state, n )
   if n < state then
      n = n + 1
      return n, n*n
   end
end

for i, n in square, 10, 0 do
   print( i, n )
end

--[[  pairs() is weeeird.
a = {10,20,30,40,50}
for a, b, c in pairs, a, c  do
   print( a, b, c )
end
]]


-- Local vars!
-- All vars are global by default
print( "Local vars!" )
a = 10
function foo() a = 20 end
function bar() local a = 30 end
print( a )
foo()
print( a )
bar()
print( a )
