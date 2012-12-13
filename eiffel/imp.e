class IMP
creation
   make
feature
   res : BOOLEAN
   
   make is
      do
         res := True implies True
	 print( res ); print( "%N" )
	 res := True implies False 
	 print( res ); print( "%N" )
	 res := False implies True
	 print( res ); print( "%N" )
	 res := False implies False
	 print( res ); print( "%N" )
      end --make
end --IMP
