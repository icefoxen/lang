fun fib x =
   if x < 2 then 1
   else (fib (x - 1)) + (fib (x - 2))
;

print ((Int.toString (fib 45)) ^ "\n");
