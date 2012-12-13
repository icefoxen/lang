def detab ( filename ):
   """detab( 'filename' )

   Turns all tabs in a file in to spaces.
   """

   f1 = file( filename, 'r' )
   text = f1.read()
   f1.close()

   text = text.split( '\t' )
   sep = ' ' * 8
   text = sep.join( text )

   f1 = file( filename, 'w' )
   f1.write( text )
   f1.close()


def main():
   import sys
   if (len( sys.argv ) < 2 ):
      print "Usage:  detab.py filename"
      sys.exit( 0 )
   else:
      detab( sys.argv[1] )
      print "File", sys.argv[1], "de-tabbed"

if __name__ == '__main__':
   main()
