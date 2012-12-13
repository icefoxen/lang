# Defines a set abstraction using lists.
# Has a class set, methods for it, and functions that act upon it.


class set:
   """set( [list] ) -> new set
Set datatype.
A set can contain any element, but not more than ONE of each element.  Sets
can be compared by union, intersection, and all that nice stuff."""

   def __init__( self, data=[] ):
      self.setdata = []
      for x in data:
         try:  # Must take care of exception handling
            self.addElement( x )
         except: pass


   def contains( self, element ):
      """set.contains( element ) -> boolean
Returns true if the set contains element."""
      if self.setdata.__contains__( element ):
         return 1
      else:
         return 0


   def elements( self ):
      """set.elements() -> list
Returns a list of all elements in the set."""
      return self.setdata


   def addElement( self, element ):
      """set.addElement( element ) -> None
Adds an element to the set.  If the element already exists, 
raise an exception."""
      if self.contains( element ):
         raise "Set already contains " + `element` + "!"
      else:
         self.setdata.append( element )


   def removeElement( self, element ):
      """set.removeElement( element ) -> None
Removes an element from the set.  If the element doesn't exist,
raise an exception."""
      if not self.contains( element ):
         raise "Set doesn't contain " + `element` + "!"
      else:
         self.setdata.remove( element )

   def subset( self, set1 ):
      """set.subset( set1 ) -> Boolean
Returns true if set1 is a SUBSET of the current set."""
      for x in set1.elements():
         if self.contains( x ):
            pass
         else:  # If not a subset, break and return.
            return 0
      return 1  # If you haven't returned by now, it's a subset.

# Functions that act on sets themselves 
def union( set1, set2 ):
   """union( set1, set2 ) -> set
Returns a new of all elements in set1 OR set2"""
   u = set( set1.elements() )
   for x in set2.elements():
      try:
         u.addElement( x )
      except: pass
   return u 


def intersection( set1, set2 ):
   """intersection( set1, set2 ) -> set
Returns a new set of all elements in set1 AND set2"""
   i = set()
   for x in set1.elements():
      if set2.contains( x ):
         i.addElement( x )
   return i


def xunion( set1, set2 ):
   """xunion( set1, set2 ) -> set
Return a set with all elements in set1 or set2, but not both (XOR)"""
   x = set()
   for y in set1.elements():
      if not set2.contains( y ):
         x.addElement( y )
   for y in set2.elements():
      if not set1.contains( y ):
         x.addElement( y )
   return x


def exclude( set1, set2 ):
   """exclude( set1, set2 ) -> set
Returns a set of all elements in set1 that are NOT in set2"""
   e = set()
   for x in set1.elements():
      if not set2.contains( x ):
         e.addElement( x )
   return e 


# Functions that act on LISTS of sets
def setsWith( element, index ):
   """setsWith( element, index) -> list
Takes a list of sets and returns a list of all sets with the element in 
them."""
   a = []
   for set in index:
      if set.contains( element ):
         a.append( set )
   return a



a = set( [1, 2, 3, 4, 5] )
b = set( [2, 3, 4, 5, 6] )
c = set( [3, 4, 5] )
