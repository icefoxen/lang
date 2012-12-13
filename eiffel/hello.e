class HELLO
creation
   make
feature
   make is
      -- class entry point
      do
         print( "Hello, world!%N" )
	 io.put_string( "Hello world!" )
         io.put_new_line
      end
end --HELLO
