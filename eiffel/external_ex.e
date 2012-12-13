-- external_ex.e
-- Demonstrates Eiffel/C FFI along with external.c
-- Compile with 
-- compile -o external external_ex.e make external.c
-- or
-- gcc -c -Wall external.c 
-- compile -o external_ex external_ex.e make external.o
-- From: http://cs.anu.edu.au/student/comp2100/lec-eiffel-c.html 
indexing
   description: "C/Eiffel FFI example"
class 
   EXTERNAL_EX
creation
   make

feature

   integer_attribute: INTEGER

   make is
      -- Test FFI calls
      local
         s: STRING
      do
         c_write_integer( 6 )

	 change_integer( $integer_attribute )
	 io.put_integer( integer_attribute )
	 io.put_new_line

	 s := "Hello from C" 
	 c_write_string( s.to_external )
	 
	 change_integer( s.to_external )
	 -- This func. expects an INT, but we pass it a STRING.
	 -- So, it clobbers the string when we print it below:
	 c_write_string( s.to_external )
      end

      c_write_integer( i : INTEGER ) is
         -- Ask C to print 'i'
	 external
	    "C"
	 alias
	    "print_int"
	 end

      c_write_string( sp : POINTER ) is
         -- Ask C to print string pointed to by 'sp'
	 external
	    "C"
	 alias
	    "print_string"
	 end

      change_integer( ip : POINTER ) is
         -- Ask C to change the value of the integer pointed to by 'ip'
	 external
	    "C"
	 alias
	    "set_val"
	 end

end --EXTERNAL_EX
