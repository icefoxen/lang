# This just encodes ASCII characters into a different format.
# Say, instead of \n being 0x20 it's something like 0xCC
# This is just a substitution algorithm, the equivilant of a=1 b=2 c=3.
# It's just that 1, 2, 3 etc. are binary values instead.
# Good for freaking people out or hiding text by making it look like binary
# garbage, but it is NOT real encryption!
# Simon Heath
# 5/10/2002

import string


############### INITIALIZATION #################################
def __init__():
	"""Setup stuff.  Should run automatically when script is loaded.
	Makes sure the codewheel dictionaries get built even when loaded as a
	module.
	I hope."""

   CODEWHEEL = {}

   for num in range( len( string.printable ) ):
      CODEWHEEL[ string.printable[ num ] ] = chr( num )
      # explination... This initializes the codewheel dictionary.
	   # string.printable are all printable ASCII characters.  'abcde...' etc.
	   # it includes whitespace.  The for loop sets 
	   # the CODEWHEEL key to the num'th character in string.printable,
	   # 'a', 'b', 'c', and soforth, and
	   # the CODEWHEEL value to chr( num ) which is a byte with the same value 
	   # as num.  chr( 1 ) == '\x01', chr( 2 ) == '\x02', etc.

   DECODEWHEEL = {}
   # A dictionary that's the reverse of CODEWHEEL, since you can't assoc
   # a dictionary by values.  *pouts*

   ks = CODEWHEEL.values()
   vs = CODEWHEEL.keys()

   for x in range( len( ks ) ):
      DECODEWHEEL[ ks[x] ] = vs[x]


############### USAGE ##############################

def usage():
	"""
Prints out usage message"""

   print """
Usage:      
  python bincode.py [-e] file1 file2: Encodes file1 to binary, output to file2
  python bincode.py [-d] file1 file2: Decodes file1 from binary, output to file2
   """

############### ACTUAL DO-AGE ###################

# Functions to encode and decode the data.  Simple, really.

def encode( data ):
   """
encode( string ) -> binary string

Encodes a string from ASCII to a custom binary format."""

   result = ''
	for c in data:
      result += CODEWHEEL[ c ]
	return result

def decode( data ):
   """
decode( string ) -> string

Decodes a binary string binary-ized by encode()"""

	result = ''
	for c in data:
		result += DECODEWHEEL[ c ]
	return result


