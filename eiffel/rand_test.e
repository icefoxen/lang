class RAND_TEST
creation
   make
feature
   
   make is
      local
         gen : RANDOM_GENERATOR
         i : INTEGER
	 mean, rnd : REAL
	 
      do
         !!gen.reset( 1234 )

         from i := 1
	 until i > 1000
	 loop
	    gen.next
	    rnd := gen.last_random_real( 0, 100 )
	    mean := mean + rnd
	    i := i + 1

	 end --loop

	 mean := mean / 1000
	 print( "Mean = " ); print( mean ); print( "%N" ) 

      end --make

end --RAND_TEST
