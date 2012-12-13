parse arg x
say fib( x )
exit

fib:
procedure
parse arg p
if p < 2 then return 1
else return fib( p - 1 ) + fib( p - 2)
