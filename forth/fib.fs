( A Fibonacci function )

: fib recursive
  dup 2 <= if
    1 
  else
    dup 1- fib
    swap 2 - fib
  then + ;
