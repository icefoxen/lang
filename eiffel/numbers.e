-- numbers.e
-- I guess integers are infinate-precision in Eiffel.  Wish people would tell
-- me these things.
-- Simon Heath
-- 4/1/2002
-- Prickle-Prickle, 4th of Chaos, YOLD 3169

class NUMBERS
creation
   make
feature
   a : INTEGER

   make is
      do
	 from a := 0
	 until False
         loop
            print( a ); print( "%N" )
            a := a + 10000
         end --loop
   
      end --make

end --NUMBERS
