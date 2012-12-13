// PlanetRandomTest.java
// Simon Heath
// 18/04/2002

import simon.IJ.PlanetRandom;

public class PlanetRandomTest {
   public static void main ( String args[] )
   {
      PlanetRandom r = new PlanetRandom ( "Gas" );
      PlanetRandom s = new PlanetRandom ( "Rock" );
      PlanetRandom t = new PlanetRandom ( "Ice" );
      PlanetRandom u = new PlanetRandom ( "Water" );
      PlanetRandom v = new PlanetRandom ( "Organic" );
      PlanetRandom w = new PlanetRandom ( "Volcanic" );
      PlanetRandom x = new PlanetRandom ( "Metal" );
      PlanetRandom y = new PlanetRandom ( "Inferno" );
      
      String output = r.toString () + "\n\n" +
	s.toString () + "\n\n" +
	t.toString () + "\n\n" +
	u.toString () + "\n\n" +
	v.toString () + "\n\n" +
	w.toString () + "\n\n" +
	x.toString () + "\n\n" +
	y.toString ();

      System.out.println ( output );
   }
}
