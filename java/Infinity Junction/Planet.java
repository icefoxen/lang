// Planet.java
// This data Object contains and formats data for planets in Infinity
// Junction.
// Simon Heath
// 17/04/2002

package simon.IJ;
import java.text.DecimalFormat;

public class Planet extends SystemObject {
   // Inherits variables X, Y, and name
   // Inherits methods get/setX, get/setY, get/setName, moveTo, and toString
   
   private double gravity;       // surface grav in m/s
   private double orbit;         // Orbit in millions of km
   private double atmos;         // Atmosphere in bars
   private double day;           // day in hours
   private int diameter;         // Diameter in km
   private int tilt;             // tilt in degrees
   private int temp;             // temp in degrees C (kelvin?)
   private int moons;            // number of moons
   private int order;            // closest to sun, 2nd, 3rd, etc
   private String type;          // Type of planet

   // Ai, I knew not having many constructors would bite me 
   // in the ass before long.  This includes args for X, Y and name
   public Planet ( double grav, double orb, double atmo, double dy,
		   int diam, int tlt, int tmp, int moon, int ordr, 
		   int x, int y, String s, String typ )
   {
      // Super constructor
      super ( x, y, s );  // Co-ords, name
      
      gravity = ( grav > 0 ? grav : 0 );  // Sanity checks
      orbit = ( orb > 0 ? orb : 0 );
      atmos = ( atmo > 0 ? atmo : 0 );
      day = ( dy > 0 ? dy : 0 );
      diameter = ( diam > 0 ? diam : 0 );
      tilt = ( tlt > 0 ? tlt : 0 );
      temp = ( tmp > 0 ? tmp : 0 );
      moons = ( moon >= 0 ? moon : 0 );
      order = ( ordr > 0 ? ordr : 0 );
      type = typ;
      
      ISSHIP = false;
      ISPLANET = true;
   }
   
   
   // Constructer; minus X, Y, and name
   public Planet ( double grav, double orb, double atmo, double dy,
		   int diam, int tlt, int tmp, int moon, int ordr, 
		   String typ )
   {
      // Default super-constructor
      super ( 0, 1, "Fix the arguments!" );
      gravity = ( grav > 0 ? grav : 0 );  // Sanity checks
      orbit = ( orb > 0 ? orb : 0 );
      atmos = ( atmo > 0 ? atmo : 0 );
      day = ( dy > 0 ? dy : 0 );
      diameter = ( diam > 0 ? diam : 0 );
      tilt = ( tlt > 0 ? tlt : 0 );
      temp = ( tmp > 0 ? tmp : 0 );
      moons = ( moon >= 0 ? moon : 0 );
      order = ( ordr > 0 ? ordr : 0 );
      type = typ;
      
      ISSHIP = false;
      ISPLANET = true;
   }
   
   // No-arg constructor
   public Planet ()
   {
      super ( 0, 1, "Add arguments!" );
      gravity = 0;
      orbit = 0;
      atmos = 0;
      day = 0;
      diameter = 0;
      tilt = 0;
      temp = 0;
      moons = 0;
      order = 0;
      type = "Empty!";
      
      ISSHIP = false;
      ISPLANET = true;
   }
   
   public double getGravity ()
     { return gravity; }
   
   public double getOrbit ()
     { return orbit; }
     
   public double getAtmos ()
     { return atmos; }
     
   public double getDay ()
     { return day; }
   
   public int getDiameter ()
     { return diameter; }
   
   public int getTilt ()
     { return tilt; }
   
   public int getTemp ()
     { return temp; }
   
   public int getMoons ()
     { return moons; }
   
   public int getOrder ()
     { return order; }
   
   public String getType ()
     { return type; }
     
   public String toString ()
   {
      String output;
      DecimalFormat form = new DecimalFormat ( "0.00" );
      
      output = 
	"Name: " + super.getName () +
	"\nLocation: [" + super.getX () + "," + super.getY () + "]" + 
	"\nType: " + type +
	"\nGravity: " + form.format ( gravity ) + " m/s" +
	"\nOrbit: " + form.format ( orbit ) + " x10^6 km" +
	"\nAtmosphere: " + atmosTest ( form.format ( atmos ) ) +
	"\nDay: " + form.format ( day ) + " hours" +
	"\nDiameter: " + diameter + " km" +
	"\nTilt: " + tilt + " deg." +
	"\nTemperature: " + temp + " K" +
	"\nOrder: " + order + "th";
      
      return output;
   }
   
   private String atmosTest ( String s )
   {
      if ( type.equals ( "Gas" ) )
	return "Superthick";
      else
	return s + " bar";
   }

}
