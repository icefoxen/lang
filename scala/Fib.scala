object Fib {
   def main(args: Array[String]) {
      println(fib(45))
      println("foo?")
   }

   def fib(i: Int): Int = {
      if(i < 2) {
         i
      } else {
         fib(i - 1) + fib(i - 2)
      } 
   }

}
