let rec fib x = 
   if x < 2 then 1
   else (fib x - 1) + (fib x - 2)
;;

printfn "%d\n" (fib 40);;
