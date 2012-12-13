# Gives pi.  LOTSA pi.
# Uses bignums.  Looks very ugly and mathematical.

import sys

def main():
   k, a, b, a1, b1 = 2L, 4L, 1L, 12L, 4L
   while 1:
      p, q, k = (k * k), (2L * k + 1L), (k + 1L)
      a, b, a1, b1 = a1, b1, (p * a + q * a1), (p * b + q * b1)
      d, d1 = (a / b), (a1 / b1)
      while d == d1:
         output( d )
         a, a1 = (10L * (a % b)), (10L * (a1 % b1))
         d, d1 = (a / b), (a1 / b1)

def output( d ):
   sys.stdout.write( `int( d )` )   # Doesn't use 'print' so there's
                                    # no newline
   sys.stdout.flush()  # Flushes buffer, forcing stdout to print.

main()