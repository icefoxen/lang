# primes.py: compute the list of primes <= Limit
# demonstrates the use of 'else' in a 'for' block
# Simon Heath
# 16/07/2002

def PrimesLE ( Limit ):
   """ MESSED UP!  DO NOT USE!!
   """

   Primes = [2]   # A list with the first prime
   counter = 3    # The next number
   while counter <= Limit:
      for KnownPrime in Primes:

         if counter % KnownPrime == 0:
            # If counter is divisble by known prime....
            break  # Abandon this one and try the next
         else:
            # Since we didn't break, counter is not divisible
            # by previous prime, hence it's prime.
            Primes.append( counter )

         # Advance the counter (but skip even numbers)
         counter += 2
   return Primes