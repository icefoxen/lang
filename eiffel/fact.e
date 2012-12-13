-- fact.e
-- Factorials, yay!
-- Simon Heath
-- 3/1/2003
-- Pungenday, 3rd of Chaos, YOLD 3169

class FACT
creation
   make
feature
   n : INTEGER
   
   make is
      -- Constructor procedure
      do
         n := fact( 100 )
         print( n )
      end --make

   fact( i : INTEGER ) : INTEGER is
      require
         non_negetive: i >= 0
      do 
         if i = 0 then
	    Result := 1  -- Result is the value returned.
	 else
	    Result := i * fact( (i - 1) )
	 end --if
      ensure
         -- Don't need an ensure... Recursive "leap of faith"
	 -- Gah...  The "ensure" clause says a lot of stuff I'm used to taking
	 -- for granted!!  For instance...
	 positive_result: Result > 0
	 factorial_computed:  -- Result = i!
      end --fact

end --FACT
