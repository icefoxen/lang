// Ship.java
// Kay, this method should define any object that could exist in a solar 
// system, and all the fundamental properties
// associated with it.
// Let's keep this simple for now.
// Simon Heath
// 18/04/2002

package simon.IJ;

public class SystemObject {
   private int X, Y;
   private String name;
   protected boolean ISSHIP;
   protected boolean ISPLANET;

   // No-arg constructor
   public SystemObject ()
   {
      X = 0;
      Y = 1;
      name = "Fix the arguments in the call!";
      ISSHIP = false;
      ISPLANET = false;
   }
   // Constructor
   public SystemObject ( int x, int y, String s )
   {
      X = x;
      Y = y;
      name = s;
      ISSHIP = false;
      ISPLANET = false;
   }
   
   public int getX ()
   {
      return X;
   }
   
   public int getY ()
   {
      return Y;
   }
   
   public void setX ( int x )
   {
      X = x;
   }
   
   public void setY ( int y )
   {
      Y = y;
   }
   
   public void moveTo ( int x, int y )
   {
      X = x;
      Y = y;
   }
   
   public String getName ()
   {
      return name;
   }
   
   public void setName ( String s )
   {
      name = s;
   }
   
   public boolean isShip ()
   {
      return ISSHIP;
   }
   
   public boolean isPlanet ()
   {
      return ISPLANET;
   }
   
   public String toString ()
   {
      String output = name + "\n[" + X + "," + Y + "]";
      return output;
   }
}
