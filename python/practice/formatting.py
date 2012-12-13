# These two operations are different ways to do the same thing.

for x in range( 1, 11):
   print '%2d %3d %4d' % (x, x*x, x*x*x)

for x in range(1, 11):
	print string.rjust(`x`, 2), string.rjust(`x*x`, 3),
	print string.rjust(`x*x*x`, 4)

# Output:
#  1   1    1
#  2   4    8
#  3   9   27
#  4  16   64
#  5  25  125
#  6  36  216
#  7  49  343
#  8  64  512
#  9  81  729
# 10 100 1000