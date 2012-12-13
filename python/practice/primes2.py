# Primes.py
# Calculates prime numbers.  V. nice.
# Good practice.
# 8/30/2002

def main():
   import sys   # Local namespace -imports only into the function
   min, max = 2, 10000
   if sys.argv[1:]:
      min = int( eval( sys.argv[1] ) )  # Eval turns string to number
      if sys.argv[2:]:
         max = int( eval( sys.argv[2] ) )
   primes( min, max )

def primes( min, max ):
   if 2 >= min:
      print 2
   primes = [2]
   i = 3
   while i <= max:
      for p in primes:  # Can check against known primes, instead 
                        # of against all numbers
         if (i % p == 0) or (p * p > i):
            break
      if (i % p != 0):
         primes.append( i )
         if i >= min:
            print i
      i = i + 2  # Even #'s are automatically not prime

main()