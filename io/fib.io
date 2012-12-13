fib := method( i,
   if( i < 2, 1, fib( i - 1 ) + fib( i - 2 ) )
)

fib( 30 )
