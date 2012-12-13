# graf.py
# A directed-graph data type and filesystem-ish interface for it.  This was
# basically to test out the idea of a graph-based filesystem, as opposing a
# tree or set.  It's do-able I suppose, but it doesn't have the flexibility of
# sets.  Ah well.
# Simon Heath
# 23/2/2003


class Node:
   """Node( name, contents={} ) -> Node
A node of a directed-graph data structure.  Each node has a unique name."""

   def __init__( self, name, items={} ):
      self.name = name
      self.items = items
      self.destinations = []   # Nodes this one leads to
      self.sources = []        # Nodes leading to this one

   def addDest( self, node ):
      """Adds a link going from the current to the given node"""
      self.destinations.append( node )
      node.sources.append( self )

   def removeDest( self, node ):
      """Removes a link between nodes"""
      if self.destinations.__contains__( node ):
         self.destinations.remove( node )
         node.sources.remove( self )
      else:
         raise "Node " + self.name + " does not lead to " + node.name

   def addItem( self, name, item ):
      """Adds an item to this node"""
      self.items[name] = item

   def removeItem( self, name ):
      """Removes an item from this node"""
      self.items.__delitem__( name )


# The below functions and data involve the actual interface.  The above is
# just the ADT.


# Create an initial node
root = Node( 'Root', {'code.txt':'d:\\code.txt', 'graf.py':'d:\\graf.py' } )
# Create a list of all existing nodes
nodes = [root]
# Start at the root node
current = root




def goto( name ):
   """Moves to the destination node"""
   global current
   for x in current.destinations:
      if x.name == name:
         current = x
         return
   print "Error: Node " + name + " does not exist."

def addNode( name ):
   """Creates a new node"""
   for x in nodes:
      if x.name == name:
         print "Error: Node " + name + " already exists."
         return
   nodes.append( Node( name ) )

def delNode( name ):
   """Removes a node"""
   for x in nodes:
      if x.name == name:
         nodes.remove( x )
         return
   print "Error: Node " + name + " does not exist."


def evalCommand( str ):
   """This evaluates a given string and does all the decision-making.  Very
simple and straightforward, and rather inefficient.
Command include:
items, sources, dests, adddest, additem, nodes, newnode, goto, exec, quit"""

   global current, nodes
   lst = str.split( ' ' )
   command = lst[0]
   args = lst[1:]

   if command == 'items':
      print current.items

   elif command == 'sources':
      for x in current.sources:
         print x.name + ' ',
      print

   elif command == 'dests':
      for x in current.destinations:
         print x.name + ' ',
      print

   elif command == 'adddest':
      for x in nodes:
         if x.name == args[0]:
            current.addDest( x )
	    return
      print "Error: Node " + args[0] + " does not exist."

   elif command == 'additem':
      if current.items.keys().__contains__( args[0] ):
         print "Error: Item already exists"
      else:
         current.items[args[0]] = args[1]

   elif command == 'nodes':
      for x in nodes:
         print x.name + " ",
      print
      print nodes

   elif command == 'newnode':
      nodes.append( Node( args[0] ) )

   elif command == 'goto':
      goto( args[0] )

   # This is debugging.  It executes an arbitrary Python instruction, letting
   # you poke directly at the nodes.  V. handy.
   elif command == 'exec':
      import string
      cmd = string.join( args )
      exec( cmd )

   elif command == 'quit':
      import sys
      sys.exit()

def main(): 
   """This just does I/O"""
   global root, nodes, current
   while 1:
      evalCommand( raw_input( current.name + '-> ' ) )


if __name__ == '__main__':
   main()
