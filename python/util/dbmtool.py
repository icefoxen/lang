#!/bin/python
# Database management script.  Basically a front-end for the Python
# database functions.  Handy, though.  Simple and sweet.
# 31/8/2002

import os
import sys
import anydbm

def opendb( file, flag ):
   try:
      db = anydbm.open( file, flag )
   except:
      raise "Woah!", "Error opening DBM:", + anydbm.error
   return db

def dump( db ):
   for key in db.keys():
      print key ": ", db[ key ]

def setvalue( db, key, value ):
   try:
      db[ key ] = value
   except:
      raise "Woah!", "Couldn't set the value of", key + " to " + value
   print "Set value of " + key + " to " + value

def getvalue( db, key ):
   try:
      data = db[ key ]
   except:
      raise "Woah!", "Key " + key + " does not exist in db."
   print "Value of " + key +  " is " + data

def delkey( db, key ):
   try:
      del db[ key ]
   except:
      raise "Woah!", "Key " + key + " does not exist in db."
   print key,  "is gone.  Bye."

def main():
   import getopt  # Get command line options
   opts, args = getopt.getopt( sys.argv[ 1:-1 ], 'k:v:du' )

   if len( sys.argv ) > 2:
      db = opendb( sys.argv[ -1 ], "c" )
      realopts = {}

      for o, a in opts:
         realopts[ o ] = a

      if realopts.has_key( '-k' ) and realopts.has_key( '-v' ):
         setvalue( db, realopts[ '-k' ], realopts[ '-v' ] )

      elif realopts.has_key( '-k' ) and realopts.has_key( '-d' ):
         delkey( db, realopts[ '-k' ] )

      elif realopts.has_key( '-k' ):
         getvalue( db, realopts[ '-k' ] )

      elif realopts.has_key( '-u' ):
         dump( db )

   else:
         print """
Usage: dbmtool.py [-k key [[-v value] | [-d]] | -u db

Where:
-k key    Selects (and displays) the key value
-v value  Sets of the value of key to value
-d        Deletes the specified key
-u        Dumps the entire database
"""

main()
