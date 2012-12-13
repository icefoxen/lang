// Triangles.java
// Draws 50 triangles inside each other.
// Simon Heath
// 11/07/2002

import java.awt.*;
import java.awt.event.*;

public class Triangles3 extends Frame {
   public static void main ( String args[] )
   { new Triangles(); }
   
   Triangles3 ()
   {
      super( "Triangles: 50 triangles inside each other" );

      addWindowListener( new WindowAdapter()
         { public void windowClosing ( WindowEvent e)
	    { System.exit( 0 ); }});
      add( "Center", new CvTriangles() );
      setSize( 400, 300 );
      show();
   }
}

class CvTriangles extends Canvas {
   int maxX,
       maxY,
       minMaxXY,
       xCenter,
       yCenter;
   
   void initgr()
   {
      Dimension d = getSize();
      maxX = d.width - 1;
      maxY = d.height - 1;
      minMaxXY = Math.min( maxX, maxY );  // Gets the lower number
      xCenter = maxX / 2;
      yCenter = maxY / 2;
   }

   // These two methods turn logical floating-point co-ords in to real-machine
   // integer co-ords.
   int iX ( float x )
   { return Math.round( x ); }

   int iY ( float y )
   { return maxY - Math.round( y ); }

   public void paint ( Graphics g )
   {
      initgr();
      float side = 0.95F * minMaxXY,  // Side = 0.95 * smallest height/width dimension
            sideHalf = 0.5F * side,
	    h = sideHalf * (float) Math.sqrt( 3 ),
	    xA, yA, xB, yB, xC, yC,
	    xA1, yA1, xB1, yB1, xC1, yC1, p, q;
      q = 0.1F;   // THIS IS THE DIFFERENCE
      p = 1 - q;
      // I believe that all the x/y[ABC] etc are the endpoints of the
      // triangles -see the first 3 lines of the 'for' below.
      xA = xCenter - sideHalf;
      yA = yCenter - 0.5F * h;
      xB = xCenter + sideHalf;
      yB = yA;
      xC = xCenter;
      yC = yCenter + 0.5F * h;

      for ( int i = 0; i < 50; i++ )
      {
          g.drawLine( iX( xA ), iY( yA ), iX( xB ), iY( yB ) );
          g.drawLine( iX( xB ), iY( yB ), iX( xC ), iY( yC ) );
          g.drawLine( iX( xC ), iY( yC ), iX( xA ), iY( yA ) );
	    // The above draws the actual triangle
	    // And all the x[ABC]<number> are used to calculate the next set of
	    // co-ords for the triangle.
	    xA1 = p * xA + q * xB;
	    yA1 = p * yA + q * yB;
	    xB1 = p * xB + q * xC;
	    yB1 = p * yB + q * yC;
	    xC1 = p * xC + q * xA;
	    yC1 = p * yC + q * yA;

  	    xA = xA1;
	    xB = xB1;
	    xC = xC1;
	    yA = yA1;
	    yB = yB1;
	    yC = yC1;

      }
   }
}
