# Example of using a lambda form.
def makeIncrementor( n ):
	"""Example of using a lambda form
	"""
	return lambda x: x + n

f = makeIncrementor( 50 )
f( 20 )

#####################################################################

# Documentation strings.
def func():
   """Do nothing, but document it.
   
   Really, it doesn't do anything.
   """
   pass

# >>> print func.__doc__
# Do nothing, but document it.
# 
#    Really, it doesn't do anything.

#####################################################################

# List methods
a = [66.6, 333, 333, 1, 1234.5]
print a.count( 333 ), a.count( 66.6 ), a.count( 'x' )
# Result is >>> 2 1 0

a.insert( 2, -1 )
a.append( 333 )
# a is now [66.6, -1, 333, 1, 1234.5, 333]

a.remove( 333 )
# only removes the first one

a.reverse()
a.sort()

#####################################################################

# Using a list as a simple stack.
stack = [3, 4, 5]
stack.append( 6 )
stack.append( 7 )
stack
stack.pop()
stack.pop()
stack.pop()

# You can also use it as a queue

stack.append( "tom" )
stack.append( "Dick" )
stack.append( "harry" )
stack
stack.pop(0)
stack.pop(0)

#####################################################################

# filter( function, sequence )
# returns a sequence containing the items for which function() is true.
def f(x):
   return (x % 2 != 0) and (x % 3 != 0)

filter( f, range( 2, 25 ) )

#####################################################################

# map( function, sequence ) is just like Lisp.
# It applys function() to each member of the sequence and returns it.

def cube(x):
   return x*x*x

map( cube, range( 1, 15 ) )

# Is also useful for turning a pair of lists into a list of pairs.
a = [1, 2, 3, 4, 5]
b = ['a', 'b', 'c', 'd', 'e']
map( None, a, b )
# result:  [(1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e')]

#####################################################################

# These things are rather... odd.
# It's sorta like mapping.
[x*5 for x in [1, 2, 3, 4, 5]]
# Result:  [5, 10, 15, 20, 25]

[x/2.0 for x in [1, 2, 3, 4, 5] if x > 2]
# Result:  [1.5, 2.0, 2.5]