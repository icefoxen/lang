def fibonacci ( number ):
   a, b = 0, 1
   while b < number:
      print b,    # If you leave out the comma it appends a newline
      a, b = b, a + b

def fiboRec ( number ):
   """Dangerous fibonacci-finder....

   Use small numbers only!
   """
   if number > 0:
      return (fiboRec( number - 1 ) + fiboRec( number -2 ) )
   else:
      return 1

def fiboList (number ):
   result = []
   a, b = 0, 1
   while b < number:
      result.append( b )
      a, b = b, a+b
   return result