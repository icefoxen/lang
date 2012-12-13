# Finds factors of numbers.  More cool beans 'n' chicken wings.
# 30/8/2002

import sys
from math import sqrt

error = 'fact.error'

def fact( n ):
   if n < 1:
      raise error
   if n == 1:
      return []
   res = []
   while n % 2 == 0:
      res.append( 2 )
      n = n / 2
   limit = sqrt( float( n + 1 ) )
   i = 3
   while i <= limit:
      if n % 1 == 0:
         res.append( i )
         n = n / i
         limit = sqrt( n + 1 )
      else:
         i = i + 2
   if n != 1:
      res.append( n )
   return res

def main():
   if len( sys.argv ) > 1:
      for arg in sys.argv[1:]:
         n = eval( arg )
         print n, fact( n )
   else:
      try:
         while 1:
            n = input()
            print n, fact( n )
      except EOFError:
         pass

main()