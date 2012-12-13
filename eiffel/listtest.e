indexing
   description: "Test driver class for LISTE[T]"
class LISTTEST
creation
   make

feature
   l : LISTE[INTEGER]

   make is
      do
         create l.make( 10, Void )
	 l.insert( 20 )
	 print( l.length ); print( "%N" )
	 l.insert( 30 )
	 print( l.length ); print( "%N" )
	 print( l.get( 0 ) ); print( "%N" )
	 print( l @ 2 ); print( "%N" )
	 print( l.has( 20 ) ); print( "%N" )
      end --make

end --LISTTEST
