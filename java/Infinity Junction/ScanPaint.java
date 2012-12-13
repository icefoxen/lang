// ScanPaint.java
// Kay.  Let's do this incrementally.  This shall produce a Ship and a
// Planet object or three, and paint them.
// Simon Heath
// 18/04/2002

import simon.IJ.SystemObject;
import simon.IJ.Planet;
import simon.IJ.Ship;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class ScanPaint extends JFrame {
   private SystemObject o[];
   
   public ScanPaint ()
   {
      super ( "Scan Paint Test" );
      
      o[ 0 ] = new Ship ( 15, 59, "Kurgan", "Wozzer" );
      o[ 1 ] = new Ship ( 91, 32, "Wig", "Wog" );
      o[ 2 ] = new Planet ( 
			   21.556, 66.43, 0.043, 19.521,
			   21254, 43, -65, 13, 4, 
			   91, 17, "Catlintonia", "Rainbow World" );
      o[ 3 ] = new Planet (
			   12.673, 44.12, 0.32, 0.534,
			   4643, 532, 124, 65, 1,
			   43, 54, "Doglintonia", "Black World" );
      
      setSize ( 400, 400 );
      show ();
   }
   
   public void paint ( Graphics g )
   {
      g.setColor ( Color.black );
      g.fillRect ( 0, 0, 400, 400 );  // Background color
      
      for ( int i = 1; i < o.length; i++ )
      {
	 if ( o[ i ].isShip () )
	 {
	    g.setColor ( Color.green ); 
	    g.fillOval ( ( o[ i ].getX() - 2 ), ( o[ i ].getY() - 2 ),
			4, 6 );
	    g.drawString ( o[ i ].toString(), o[ i ].getX(), o[ i ].getY () );
	 }
	 else
	 {
	    g.setColor ( Color.blue );
	    g.fillOval ( ( o[ i ].getX() - 5 ), ( o[ i ].getY() - 5 ),
			 11, 11 );
	    g.drawString ( o[ i ].toString(), o[ i ].getX(), o[ i ].getY () );
	 }
      }  // End for
   }  // End paint
   
   public static void main ( String args[] )
   {
      ScanPaint app = new ScanPaint ();
      
      app.addWindowListener (
	 new WindowAdapter () {
	    public void windowClosing ( WindowEvent e )
	    {
	       System.exit ( 0 );
	    }
	 }  // End anon class
			      ); // End addWindowListener arg
   }  // End method main
}  // End class
