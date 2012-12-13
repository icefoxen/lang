# Grabbed off Usenet.  Slows stdout to typing speed.

class SlowStream:
	"""Slows stdout to typing speed.

	Usage:
	>>> import sys
	>>> ss = SlowStream( sys.stdout )
	>>> sys.stdout = ss
	>>> print 'whatever'
	When finished:
	>>> sys.stdout = ss.out"""

	from time import sleep
	def __init__(self, out):
		self.out = out
	def write( self, s ):
		for c in s:
			self.sleep( 0.25 )
			self.out.write( c )

# Usage:
# >>> import sys
# >>> ss = SlowStream( sys.stdout )
# >>> sys.stdout = ss
# >>> print '54321!@#$%^'

# To restore the old stdout:
# >>> sys.stdout = ss.out