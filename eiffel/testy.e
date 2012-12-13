-- testy.e
-- This just test out various nifty things.
-- Simon Heath
-- 3/1/2003
-- Pungenday, 3rd of Chaos, YOLD 3169

class TESTY
creation
   make
feature
   STRING1 : STRING is "Hello, world!"  -- constant value
   string2 : STRING
   RED, GREEN, BLUE : INTEGER is unique  -- Unique, compiler-generated value.
   int_testy : INTEGER_REF  -- Is a pointer to an int instead of a real int
                            -- Have yet to discover what difference this makes
   --int_testy2 : expanded INTEGER_REF -- This is a real variable, not a pointer
   int_testy3 : INTEGER              -- So is this.
   -- Pointers are called "reference objects".  Counterintuitively, real vars
   -- are called "expanded objects"
   -- INTEGER_REF's are NOT the same as INTEGERS... not even when expanded!
   -- No initialization is needed, 'cause they have defaults!  Yay!

   make is
      do
         int_testy := 50
	 --int_testy2 := 40 
	 int_testy3 := 30

	 print( int_testy )
	 --print( int_testy2 )
	 print( int_testy3 )
	 print( "%N" )

	 -- Yay, conditionals!
	 if int_testy > 90 then
	    print( "int_testy is greater than 90" )
	 elseif int_testy < 90 then
	    print( "int_testy is less than 90" )
	 else
	    print( "Guess it's equal to 90 " )
	 end --if

	 foo( RED, GREEN )
	 foo( int_testy3, 0 )

      end  --make

   foo( bar, bop : INTEGER ) is
      require
         bar_non_void: bar /= Void
      local
         n : INTEGER
      do
         print( STRING1 ) 
	 print( bar )
	 
	 -- loops!
         from n := 0
	 until n > 9
	 loop
	    print( n );  print( "%N" )
	    n := n + 1
	 end --loop
      end --foo

end --TESTY
