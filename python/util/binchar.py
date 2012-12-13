# This generates the binary characters 0-255 and writes them in to
# a file.  Inelegant but cool anyway.

f = open( 'd:\\testy.txt', 'w' )
for x in range( 255 ):
   str = 'chr( ' + `x` + ' )'
   f.write( eval( str ) )   # Yay eval()!!  Yay Lisp!  *grins*
   f.write( '\n' )
f.close()
