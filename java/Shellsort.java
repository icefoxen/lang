/* Shellsort.java
   Demonstrates a (somewhat limited) shellsort.

   Simon Heath
   3/5/2005
*/

public class Shellsort
{
   static void shellsort (int[] a, int n) {
      int j, h, v;
      int[] cols= { 4356424, 1355339, 543749, 213331, 84801, 27901,
                      11969, 4711, 1968, 815, 277, 97, 31, 7, 3, 1 };
      for (int k=0; k<16; k++) 
      {
          h=cols[k];
          for (int i=h; i<n; i++) 
	  {
             v=a[i];
             j=i;
             while (j>=h && a[j-h]>v) 
	     {
                a[j]=a[j-h];
                j=j-h;
             }
             a[j]=v;
          }
      }
   }

   public static void main( String args[] )
   {
      int[] a = {43, 543, 542, 6, 77, 432, 67, 43, 756};
      shellsort( a, a.length - 1 );
      for( int x = 0; x < a.length; x++ )
      {
         System.out.print( a[x] + " " );
      }
      System.out.println();
   }
}
