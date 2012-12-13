
# This is a nifty little program that will take a text file and turn it into
# very nasty-looking binary jumble.  And even more impressively, will turn the
# binary jumble back into a text file!  *waits for applause to die down*
# One more thing.  Specifically, this is NOT real encryption!  It's just a
# substitution cypher, the equivilant of "A=1, B=2, C=3...".  If someone grabs
# a hex editor and a book on codebreaking, they can break it.
# Thanx to Jen for the idea.
# Simon Heath
# 16/09/2002

import string, sys

VERBOSE = 1
CODEWHEEL = {}
DECODEWHEEL = {}

for num in range( 255, (255 - len( string.printable )), -1 ):
   CODEWHEEL[ string.printable[ num - 156 ] ] = chr( num )

   # explination... This initializes the codewheel dictionary.
   # string.printable are all printable ASCII characters.  'abcde...' etc.
   # it includes whitespace.  The for loop sets 
   # the CODEWHEEL key to the num'th character in string.printable,
   # 'a', 'b', 'c', and soforth, and
   # the CODEWHEEL value to chr( num ) which is a byte with the same value 
   # as num.  chr( 1 ) == '\x01', chr( 2 ) == '\x02', etc.
   # Actual coding starts from 255, chr( 1 ) == '\0xff', 
   # chr( 2 ) == '\0xfe', etc.  This is 'cause ASCII chars 0-31 are
   # control characters, like <backspace> or <end of file> that would
   # rather mess up the data as it was written to the file.
   # THAT is why the 'for' starts at 255 and counts backwards to
   # 255 - len( string.printable ).  Then, of course, you have to be
   # careful when iterating through string.printable[] so you don't try
   # to start at index 255



ks = CODEWHEEL.values()
vs = CODEWHEEL.keys()

for x in range( len( ks ) ):
   DECODEWHEEL[ ks[x] ] = vs[x]

# The above lines initialize DECODEWHEEL.  It's
# a dictionary that's the reverse of CODEWHEEL, since you can't assoc
# a dictionary by values.  *pouts*



def usage():
   """
Prints out usage message"""

   print """
Usage:      
  python bincode.py -e file1 file2: Encodes file1 to binary, output to file2
  python bincode.py -d file1 file2: Decodes file1 from binary, output to file2
  Adding -v to the end of the line (...file2 -v) turns on VERBOSE mode
   """
   sys.exit( 0 )
   # Verbose is kinda broken.  Just change the constant


# Following are functions to encode and decode the data.  Simple, really.

def encode( data ):
   """
encode( string ) -> binary string

Encodes a string from ASCII to a custom binary format."""

   result = ''
   print "Encoding data..."
   count = 0
   length = len( data )
   for c in data:
      result += CODEWHEEL[ c ]
      if VERBOSE and (not count % 100):
         print "Encoding char " + `count` + " of " + `length` + "\r",
         count += 1
      else:
         count += 1
         # Nifty "percent complete" thang.
   return result


def decode( data ):
   """
decode( string ) -> string

Decodes a binary string binary-ized by encode()"""
   result = ''
   print "Decoding data..."
   length = len( data )
   count = 0
   for c in data:
      result += DECODEWHEEL[ c ]
      if VERBOSE and (not count % 100):
         print "Encoding char " + `count` + " of " + `length` + "\r",
         count += 1
      else:
         count += 1
         # Nifty "percent complete" thang.
   return result


# Functions to handle encoding and decoding files instead of just strings


def encodefile( filein, fileout ):
   """
encodefile( filein, fileout ) -> nothing

Encodes filein and writes the code to fileout"""
   try:
      fin = open( filein, 'r' )
   except IOError:
      print "Error: No such file " + filein + "?"
      sys.exit( 1 ) 
   print "Reading file..."
   instring = fin.read()
   fin.close()
   outstring = encode( instring )

   try:
      fout = open( fileout, 'w' )
   except IOError:
      print "Error: could not make file " + fileout
      sys.exit( 1 )
   print "\nWriting file..."
   fout.write( outstring )
   fout.close()
   print "Done!"
   

def decodefile( filein, fileout ):
   """
decodefile( filein, fileout ) -> nothing

Decodes filein and writes the text to fileout"""
   try:
      fin = open( filein, 'r' )
   except IOError:
      print "Error: No such file " + filein + "?"
      sys.exit( 1 ) 
   print "Reading file..."
   instring = fin.read()
   fin.close()
   outstring = decode( instring )

   try:
      fout = open( fileout, 'w' )
   except IOError:
      print "Error: could not make file " + fileout
      sys.exit( 1 )
   print "Writing file..."
   fout.write( outstring )
   fout.close()
   print "Done!"


def main():
   """Main function.  Handles interface, arguments, etc...
   """
   if len( sys.argv ) < 4:        # Not all args provided...
      usage()
#   if sys.argv[4] == '-v':       # Verbose
#      VERBOSE = 1                # Local-scope is being bitchy
   if sys.argv[1] == '-e':        # Encode file
      encodefile( sys.argv[2], sys.argv[3] )
   elif sys.argv[1] == '-d':      # Decode file
      decodefile( sys.argv[2], sys.argv[3] )
   else:
      usage()


if __name__ == '__main__':
   main()