-- arraytest.e
-- Tests arrays.
-- Simon Heath
-- 4/1/2002
-- Prickle-Prickle, 4th of Chaos, YOLD 3169
class ARRAYTEST
creation
   make
feature
   my_arr : ARRAY[INTEGER]
   i : INTEGER

   make is
      require -- nothing needed, but I wanna practice the syntax
      local
      do
         create my_arr.make( 0, 9 ) -- allocates a new array

	 print( "Array upper bound: " )
	 print( my_arr.upper ); print( "%N" )
	 print( "Array lower bound: " )
	 print( my_arr.lower ); print( "%N" )
	 print( "Number of elements: " )
	 print( my_arr.count ); print( "%N" )

         from i := 0 
	 invariant
	    less_than_upper: i <= my_arr.upper + 1 --off-by-one error
	    greater_than_lower: i >= my_arr.lower
	 variant
	    left_to_count: my_arr.count - i 
	 until i = my_arr.count
	 loop
	    my_arr.put( (i * 5), i )   -- array.put( val, index )
	    i := i + 1                 -- REMEMBER THIS!!!
	 end --loop

	 from i := 0
	 until i = my_arr.count
	 loop
	    print( my_arr @ i ); print( "%N" )     -- array @ index -> val
	    i := i + 1
	 end --loop

      ensure
      end --make

invariant
end --ARRAYTEST 
