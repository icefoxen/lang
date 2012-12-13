using System;

public class EnumTest {

   public enum DAYS: byte {
      Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
   }

   public static void Main() {
      // Note this is NOT equivilant to DAYS[].  Hmm.
      Array dayArray = Enum.GetValues( typeof( EnumTest.DAYS ) );
      foreach( DAYS day in dayArray ) {
         Console.WriteLine( "Number {0} of EnumTest.DAYS is {1}",
               day.ToString( "d" ), day );
      }
   } 
}
