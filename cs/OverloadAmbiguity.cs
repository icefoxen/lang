using System;
namespace OverloadAmbiguity {
   public class A {
      public virtual int Func1() {
         return 1;
      }
      public virtual int Func2() {
         return 2;
      }
   }

   public class A2 : A {
      public override int Func1() {
         return 10;
      }
      public override int Func2() {
         return 20;
      }
   }

   public class B {
      public virtual int Funky1() {
         return 30;
      }
      public virtual int Funky2() {
         return 40;
      }
   }

   public class B2 : B {
      public override int Funky1() {
         return 3;
      }
      public override int Funky2() {
         return 4;
      }
   }

   public class OverloadAmbiguity {
      public static void Main() {
         Console.WriteLine("Stuff!");
         var a = new A2();
         var b = new B2();
         TerriblyAmbiguous(a, b);
      }

      static void TerriblyAmbiguous(A a, B b) {
         Console.WriteLine("Expected A and B, got {0} and {1}", a.Func1(), b.Funky1());
      }
      static void TerriblyAmbiguous(A2 a, B b) {
         Console.WriteLine("Expected A2 and B, got {0} and {1}", a.Func1(), b.Funky1());
      }
      static void TerriblyAmbiguous(A a, B2 b) {
         Console.WriteLine("Expected A and B2, got {0} and {1}", a.Func1(), b.Funky1());
      }
   }
}
