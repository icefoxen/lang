// Iso.java
// Isotropic mapping mode.
// Origin of logical co-ords in center of canvas, positive y-axis
// upward.  Square, tilted 45 degrees, just fits in to canvas.  Mouse
// click displays logical co-ords.

import java.awt.*;
import java.awt.event.*;

public class Iso extends Frame {
   public static void main ( String args[] )
   {
      new Iso();
   }

   Iso()
   {
      super( "Isotropic Mapping Mode" );
      addWindowListener( new WindowAdapter ()
         { public void windowClosing ( WindowEvent e )
            { System.exit( 0 ); }});
      setSize( 400, 300 );
      add( "Center", new CvIsotrop() );
      setCursor( Cursor.getPredefinedCursor( CROSSHAIR_CURSOR ) );
      show();
   }
}
   
class CvIsotrop extends Canvas {
   int centerX,
       centerY;
   float pixelSize,
         rWidth = 10.0F,  // The logical height and width of the graph,
         rHeight = 10.0F, // They can be any number really.
         xP = 1000000,    // Default cursor-location string position
         yP;

   CvIsotrop ()
   {
      addMouseListener( new MouseAdapter()
      { 
         public void mousePressed( MouseEvent evt )
         {
            xP = fX( evt.getX() );
            yP = fY( evt.getY() );
            repaint();
         }
      });
   }
   
   void initgr()
   {
      Dimension d = getSize();
      int maxX = d.width - 1,
          maxY = d.height - 1;
      
      // Gets the larger dimension
      pixelSize = Math.max( rWidth / maxX, rHeight / maxY );
      centerX = maxX / 2;
      centerY = maxY / 2; 
   }

   int iX( float x )
   {
      return Math.round( centerX + x / pixelSize );
   }

   int iY( float y )
   {
      return Math.round( centerY + y / pixelSize );
   }
   
   float fX ( int X )
   {
      return (X - centerX) * pixelSize;
   }

   float fY ( int Y )
   {
      return (centerY - Y) * pixelSize;
   }

   public void paint( Graphics g )
   {
      initgr();
      int left = iX( -rWidth / 2 ),
          right = iX( rWidth / 2 ),
          bottom = iY( -rHeight / 2 ),
          top = iY( rHeight / 2 ),
          xMiddle = iX( 0 ),
          yMiddle = iY( 0 );

      g.drawLine( xMiddle, bottom, right, yMiddle );
      g.drawLine( right, yMiddle, xMiddle, top );
      g.drawLine( xMiddle, top, left, yMiddle );
      g.drawLine( left, yMiddle, xMiddle, bottom );
      g.setColor( Color.red );
      g.drawLine( xMiddle, bottom, xMiddle, top );
      g.drawLine( left, yMiddle, right, yMiddle );

      g.setColor( Color.black );
      if (xP != 1000000 )
         g.drawString( "Logical co-ords of selected point: " +
                       xP + " " + yP, 20, 100 );
   }
}
