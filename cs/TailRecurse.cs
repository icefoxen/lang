using System;

class TailRecurse {
   static void Main() {
      int count = 2000000;
      try {
         Console.WriteLine("Tail recursed {0} times.", TailRecurseUp(0, count));
         //Console.WriteLine("Recursed {0} times.", RecurseDown(count));
      } catch(StackOverflowException) {
         Console.WriteLine("Stack overflow!");
      }
   }

   static int RecurseDown(int i) {
      if(i > 0) {
         return RecurseDown(i-1) + 1;
      } else {
         return 0;
      }
   }

   static int RecurseDown(int i, int accumulator) {
      if(i > 0) {
         return RecurseDown(i-1, accumulator + 1);
      } else {
         return accumulator;
      }
   }

   static int TailRecurseUp(int i, int goal) {
      if(i < goal) {
         return TailRecurseUp(i+1, goal);
      } else {
         return i;
      }
   }
}
