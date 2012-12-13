// Ship.java
// Kay, this method should define a ship, and all the properties
// associated with it.  It extends a SystemObject.
// Let's keep this simple for now.
// Simon Heath
// 18/04/2002

package simon.IJ;

public class Ship extends SystemObject {
   private String owner;

   // Inherits variables X, Y, and name.
   // Inherits methods get/setX, get/setY, get/setName, moveTo, 
   // and toString()
   
   // No-arg constructor
   public Ship ()
   {
      super ( 0, 1, "Add arguments!" );
      owner = "Ya mook!";
   }
   
   // Constructor 
   public Ship ( int x, int y, String n, String o )
   {
      super ( x, y, n );
      owner = o;
   }
   
   public void setOwner ( String o )
   {
      owner = o;
   }
   
   public String getOwner ()
   {
      return owner;
   }
   
   public String toString ()
   {
      String output =
	super.toString() + "\nOwner: " + owner;
      
      return output;
   }
}
