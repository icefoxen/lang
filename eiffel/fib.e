-- fib.e
-- Fibonacci function test.

class FIB
creation
   make
feature
   n : INTEGER

   make is
   do
      n := fib( 100 )
      print( n )
   end
   
   fib( i : INTEGER ) : INTEGER is
      require 
         non_negative: i >= 0
      do
         if i < 2 then
	    Result := 1
	 else
	    Result := fib( i - 1 ) + fib( i - 2 )
	 end
   end

end
