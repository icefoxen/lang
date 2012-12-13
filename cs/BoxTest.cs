using System;

class Hello {
   static void Main() {
      int i = 123;
      float j = 1;
      object box = i;
      if( box is int ) {
         Console.WriteLine( "Box contains an int" );
      } else if( box is float ) {
         Console.WriteLine( "Box contains an int" );
      } else {
         Console.WriteLine( "Box contains something else" );
      }
   }
}
