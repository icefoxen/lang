indexing
   description: "Pseudorandom real number generator"
class RANDOM_GENERATOR
creation
   reset

feature

   reset( new_seed : INTEGER ) is
      -- Reset the random number generator with a new seed
      require
         positive: new_seed >= 0
      do
         seed := new_seed

      end  --reset

   next is
      -- Advance the generator
      do
         seed := aa + seed * bb
	 if seed < 0 then
	    seed := -seed
	 end --if

      end --next

   last_random_real( lower, upper : REAL ) : REAL is
      -- Return an evenly distributed random number over the interval 
      -- [lower, upper]
      require
         non_empty_interval: lower < upper 
      do
         Result := lower + uniform * (upper - lower ) 
      ensure
         in_bounds: Result >= lower and Result < upper

      end --last_random_real

feature {NONE} -- PRIVATE data.  Neat!
               -- Note that even public data can't be altered by callers!
   seed : INTEGER
   aa : INTEGER is 987654321
   bb : INTEGER is 31415926

   invmaxint : REAL is  
      -- Inverse of largest positive integer
      once  -- Only performs the evaluation once --evals a constant.  Handy!
         Result := 1.0 / (2^(31) - 1)

      end --invmaxint

   uniform : REAL is
      -- Return an evenly distributed random number over [0.0, 1.0]
      do
         Result := seed * invmaxint 
      ensure
         normed: Result >= 0.0 and Result < 1.0

      end --uniform

   invariant  -- More built-in sanity checking?  Sure is a lot of that.
      non_negative_seed: seed >= 0

end --RANDOM_GENERATOR
