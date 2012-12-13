/* functions!  Finally. */


pull a
say square( a ) add( a, 10 )
pull b
say mul( a, b )
exit

square:
parse arg in
return in * in

add:
parse arg a,b
return a + b

/* Playing with syntax */
mul: arg a, b
do
   return a * b
end
