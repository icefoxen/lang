function fib( x )
   if x < 2 then return 1
   else return fib( x - 1 ) + fib( x - 2 )
   end
end

print( fib( 40 ) )
