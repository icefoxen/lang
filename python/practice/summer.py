# summer.py
# sums up numbers in a file beginning with '$'
# Simon Heath
# 16/07/2002

from string import split, atof  # use these string functions

def calc ( filename='orders' ):  # the x='orders' is a default, AFAIK
   f = open(filename, 'r')  # Open the file
   text = f.read()  # Read the whole thing as a string
   f.close()  # Close file
   list = text.split( ' ' )  # Put in whitespace-seperated 
   # substring list.  

   # Now look for strings that start with $ and add
   # them up if possible.
   total = 0.0
   for s in list:
      if s[0] = '$':
         try:
            total = total + atof( s[1:] )  # atof(): string -> float
         except: pass  # s[1:] isn't a number, ignore it.
   return total