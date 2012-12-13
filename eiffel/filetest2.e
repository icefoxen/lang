indexing
   description: "Messing around with Eiffel's file library using a different notation for command-line args"

class FILETEST2
creation
   make

feature
   f1 : TEXT_FILE_READ
   f2 : TEXT_FILE_WRITE
   i : STD_INPUT
   args : expanded ARGUMENTS

   make is
      require
         has_input_arg: args.argument( 1 ) /= Void 
	 has_output_arg: args.argument( 2 ) /= Void
      do
         from !!f1.connect_to( args.argument( 1 ) )
	 until f1.end_of_input
	 loop
	    f1.read_line  -- reads a line and leaves it in laststring
	    print( f1.last_string ); print( "%N" )
	 end --loop
	 f1.disconnect

	 print( "Enter text to append to " ); print( args.argument( 2 ) ) 
	 print( "%N" ) 
	 print( "Terminate with a . on a line by itself.%N" )
	 !!i.make
	 from i.read_line; !!f2.connect_for_appending_to( args.argument( 2 ) )
	 until i.last_string.is_equal( "." )
	 loop 
	    f2.put_string( i.last_string )
            f2.put_new_line
	    i.read_line
	 end --loop
	 f2.disconnect 

      ensure
	 f1_is_disconnected: f1.is_connected = false
         f2_is_disconnected: f2.is_connected = false

      end --make


end --FILETEST2
