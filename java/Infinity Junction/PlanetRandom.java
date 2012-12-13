// PlanetRandom.java
// This class generates a random planet.
// I may make it more complex once I get some planet types
// fleshed out, or even make seperate classes for each type.
// Hmm, to make the orbit and order calcs right I'll have to use a larger
// system-generating program.  Leave it for now.
// Simon Heath
// 17/04/2002  << Sort of, it's midnight on the 17th.  Heh.
 // 18/04/2002: Well I've fixed up a lotlotlot of stuff, divided
 // the seperate types of generators in to different methods, made it
 // more polymorphic, and in general improved the hell out of it.
 // I think I'm done with it for now.

package simon.IJ;

public class PlanetRandom extends Object {
   double gravity;
   double orbit;
   double atmos;
   double day;
   int diameter;
   int tilt;
   int temp;
   int moons;
   int order;
   String type;
   Planet p;
   
   // constructor
   public PlanetRandom ( String s )
   {
      type = s;
      diameterGen ( type );
      gravGen ( type );
      orbitGen ( type );
      atmosGen ( type );
      dayGen ( type );
      tempGen ( type );
      tiltGen ( type );
      moonsGen ( type );
      orderGen ( type );
      
      p = new Planet (
		      gravity, orbit, atmos, day,
		      diameter, tilt, temp, moons,
		      order, type );
   }

   
   public double gravGen ( String s )
   {
      if ( s.equals ( "Gas" ) )
	gravity = Math.random () * (diameter/2000) + 6;  // Measured in m/s
      else
	gravity = Math.random () / 2 * (diameter/120);
      
      return gravity;
   }
	
   public double orbitGen ( String s )
   {
      orbit = Math.random () * 8000;
      
      return orbit;
   }
	  
   public double atmosGen ( String s )
   {
      if ( s.equals ( "Gas" ) )
	atmos = 200;
      else if ( s.equals ( "Organic" ) )
	atmos = Math.random () * 4;
      else if ( s.equals ( "Inferno" ) )
	atmos = Math.random () * 80 + 50;
      else if ( s.equals ( "Water" ) )
	atmos = Math.random () + 0.3;
      else if ( s.equals ( "Volcano" ) )
	atmos = Math.random () / 2;
      else
	atmos = Math.random () - 0.4;
      
      return atmos;
   }
	    
   public double dayGen ( String s )
   {
      if ( s.equals ( "Gas" ) )
	day = (Math.random () * 20) + 8;
      else
      {
	 double tmp = Math.random ();
	 if ( tmp > 0.3 )
	   day = (Math.random () * 20) + 15;
	 else
	   day = (Math.random () * 300);
      }
      
      return day;
   }
	      
   public int diameterGen ( String s )
   {
      if ( s.equals ( "Gas" ) )
	diameter = (int) (Math.random () * 150000) + 50000;
      else
	diameter = (int) (Math.random () * 12000) + 2500;
      
      return diameter;
   }
	
   public int tiltGen ( String s )
   {
      double tmp = Math.random ();
      if ( tmp > 0.12 )
	tilt = (int) (Math.random () * 30);
      else
	tilt = (int) (Math.random () * 80);
      
      return tilt;
   }
   
   public int tempGen ( String s )
   {
      if ( s.equals ( "Inferno" ) )
	temp = (int) (Math.random () * 40 * atmos) + 450;
      else if ( s.equals ( "Gas" ) )
	temp = (int) (Math.random () * orbit / 10 ) + 
	       (int) (Math.random () * 30);
      else if ( s.equals ( "Volcanic" ) )
	temp = (int) (Math.random () * 40 + 200 );
      else
	temp = (int) (Math.random () * orbit / 10 * (atmos +0.01) ) 
	       + (int) (Math.random () * 30);
      
      return temp;
   }
   		    
   public int moonsGen ( String s )
   {
      if ( s.equals ( "Gas" ) )
	moons = (int) (Math.random () * gravity );
      else
	moons = (int) (Math.random () * 10) - 8;
      
      return moons;
   }
		      
   public int orderGen ( String s )
   {
      order = 1;
      
      return order;
   }
   
   public String toString ()
   {
      return p.toString ();
   }
}
