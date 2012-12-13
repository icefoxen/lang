// SolSystem.java
// Kay.  The SystemObjects are actual things; ships, planets, etc.
// This, the SolSystem, takes a collection of those things and hands it
// to the Interface.  This is necessary 'cause you can have more than one
// SolSystem instance but only one Interface instance.
// Simon Heath
// 18/04/2002

package simon.IJ;

public class SolSystem {
   private SystemObject xy[][];
   public Ship myShip;
   
   // Constructor
   public SolSystem ()
   {
      // Everything is emptiness
      for ( int i; i < 100; i++ )
	for ( int j; j < 100; j++ )
	  xy[i][j] = null;
    
      // Add your ship
      myShip = new Ship ( 50, 0, "Godslayer", "Simon" );
   }
   
   // Add a Planet
   public void addPlanet ( double grav, double orb, double atmo, double dy,
		   int diam, int tlt, int tmp, int moon, int ordr,
		   int x, int y, String s, String typ )
   {
      xy[ x ][ y ] = new Planet ( grav, orb, atmo, dy,
				  diam, tlt, tmp, moon,
				  ordr, x, y, s, typ );
   }
      
   // Add a ship
   public void addShip ( int x, int y, String n, String o )
   {
      xy[ x ][ y ] = new Ship ( x, y, n, o );
     
   }
   
   // Move a ship
   public void moveShip ( Ship s, int x, int y )
   {
      
   }
