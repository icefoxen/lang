def fib(x as int) as int:
   if x < 2:
      return x
   else:
      return fib(x-1)+fib(x-2)

print fib(45)
