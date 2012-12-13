using System;

class ArrayTest {
   public static void Main( string[] args ) {
      int[] array1 = new int[100];
      // The following two lines are equivilant.
      int[] array2 = new int[] {1,2,3,4,5,6,7,8,9,0};
      int[] array3 = {1,2,3,4,5,6,7,8,9,0};

      foreach( int x in array1 ) {
         Console.Write( "{0} ", x );
      }
      Console.WriteLine();
      for( int i = 0; i < array2.Length; i++ ) {
         Console.Write( "{0} ", array2[i] );
      }
      Console.WriteLine();
      Console.WriteLine( "{0}", array3 );

      // Rectangular, non-jagged array
      int[,] rectarr = new int[2,3];
      int[,] squarearr = {{1,2},{3,4}};
      // Oops, not ACTUALLY arrays of arrays.
      foreach( int x in rectarr ) {
         Console.WriteLine( "Rect {0}", x );
      }

      // XXX: Why does this crash?
      for( int i = 0; i < squarearr.GetLength( 0 ); i++ ) {
         for( int j = 0; j < squarearr.GetLength( 1 ); i++ ) {
            Console.WriteLine( "Square {0}", squarearr[i,j] );
         }
      }

   }
}
