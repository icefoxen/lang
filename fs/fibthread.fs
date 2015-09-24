// Attempts to start a new thread with a bigger stack to
// avoid stack overflows.  But, doesn't work, so!
// .NET doesn't let you arbitrarily increase stack size
// very easily.
// And the real error was not putting ()'s around the 
// math in the recursive calls to fib.

let rec fib x = 
   if x < 2 then 1
   else (fib (x - 1)) + (fib (x - 2))
;;

let start () =
   printfn "%d\n" (fib 40)
;;


open System.Threading

let t = new Thread(start);;
t.Start();