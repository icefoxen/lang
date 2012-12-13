public class Fib
{
   public static void main( String[] args )
   {
      fib( 30 );
   }

   public static int fib( int i )
   {
      if( i < 2 ) return 1;
      return fib( i - 1 ) + fib( i - 2 );
	      
   }
}
