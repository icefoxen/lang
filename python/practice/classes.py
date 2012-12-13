# Classes.py --Simple demo of class definition and inheritance.
# Simon Heath
# 17/06/2002

class QSroot:  # Common behaviors superclass

   def __init__( self ):  # Instance initializer --constructor
      self.front = self.back = None  # No back initially
      self.store = {}  # Empty dictionary

   def isEmpty( self ):
      return self.front == None  # If no front, it must be empty

   def pop( self ):  # Get/delete front element
      result = self.store[ self.front ] # get it
      del self.store[ self.front ]      # delete it
      # reinitialize self, if this is the last element.
      if self.front == self.back:
         self.__init__()
      else:
         self.front = self.front - 1  # otherwise decrement front
      return result

class Stack( QSroot ):
   def push( self, item ):  # Add new front
      # If structure is empty initialize front,back to 0

      if self.isEmpty():
         self.front = self.back = 0
      else:
         self.front = self.front + 1  # Otherwise increment front
      self.store[ self.front ] = item # Store the item as new index

class Queue( QSroot ):  # Last-in/first-out archive
   def enqueue (self, item):  # Add new back, analogous to Stack.Push
      if self.isEmpty():
         self.front = self.back = 0
      else:
         self.back = self.back - 1
      self.store[ self.back ] = item

   getFront = QSroot.pop  # More appropriate name for a Queue method

# Double queue, add ability to get/delete back element.
class DoubleQ( Queue, Stack ):
   def getBack( self ):  # Get/delete back element
      result = self.store[ self.back ]
      del self.store[ self.back ]
      if self.front == self.back:
         self.__init__()
      else:
         self.back = self.back + 1
      return result