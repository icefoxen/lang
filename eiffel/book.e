-- book.e
-- Example data class in Eiffel
-- Don't actually know how to build a driver for it, so let's just do
-- a few procedures...
-- Simon Heath
-- 4/1/2003
-- Prickle-Prickle, 4th of Chaos, YOLD 3169

class BOOK      -- class name
creation        -- in C++/Java, this would be called the constructor
   make         -- When a program is run, this is just called.  no "main" func
feature         -- body
   title : STRING
   authors : STRING
   inventory : INTEGER

   make( new_title, new_authors: STRING; new_inventory: INTEGER ) is
      -- make a new book record
      require  -- Interesting error-checking.... throws an exception if false.
         title_non_void: new_title /= Void  -- remember that /= is !=
	 authors_non_void: new_authors /= Void
	 -- Note here that all objects in Eiffel have a default value.
	 -- Default value for objects is Void, bools are false, numbers are 0,
	 -- etc.
      do -- Start procedure
         title := new_title
	 authors := new_authors
	 inventory := new_inventory
      end --make

   print_description is -- no args
      do
         print( title ); print( ", by " )
	 print( authors ); print( " (" )
	 print( inventory ); print( ")%N" )
      end -- print_description
end -- BOOK
