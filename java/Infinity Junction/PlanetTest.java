// PlanetTest.java
// Tests class Planet.

import simon.IJ.Planet;

public class PlanetTest {
   public static void main ( String args[] )
   {
      Planet p = new Planet (
	 21.556, 66.43, 0.043, 19.521,
	 21254, 43, -65, 13, 4, 
	 91, 17, "Catlintonia", "Rainbow World" );
      
      System.out.println ( p.toString () );
      
      p.setX ( 5 );
      p.setY ( 10 );
      System.out.println ( "\n" + p.toString () );
   }
}
