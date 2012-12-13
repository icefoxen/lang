// Ansiotropic mapping mode.
// This means that X and Y are logical, and the aspect ratio can change.
// Simon Heath
// 13/07/2002

import java.awt.*;
import java.awt.event.*;

public class Ansio extends Frame {
   public static void main ( String args[] )
   {
      new Ansio();
   }

   Ansio ()
   {
	   super( "Ansiotropic Mapping Mode" );
		addWindowListener( new WindowAdapter ()
		   { public void windowClosing ( WindowEvent e )
			   { System.exit( 0 ); }});
		setSize( 400, 300 );
		add( "Center", new CvAnsio() );
//		setCursor( Cursor.getPredefinedCursor( CROSSHAIR_CURSOR ) );  // Depreciated!
		show();
	}

	class CvAnsio extends Canvas
	{
	   int maxX,
		    maxY;
	   float pixelWidth,
		      pixelHeight,
				rWidth = 10.0F,  // Logical width
				rHeight = 7.5F,  // Logical height
				xP = -1,
				yP;
	   
		CvAnsio()
		{
		   addMouseListener( new MouseAdapter()
			   { public void mousePressed( MouseEvent evt )
			      { xP = fx( evt.getX() );
					  yP = fy( evt.getY() );
					  repaint();
					}}); 
		}

		void initgr()
		{
		   Dimension d = getSize();
			maxX = d.width - 1;
			maxY = d.height - 1;
		   pixelWidth = rWidth / maxX;    // These define the logical width
			pixelHeight = rHeight / maxY;  // And height
		}

		int iX ( float x )
	   { 
		   return Math.round( x / pixelWidth ); 
			// Turns a logical float co-ord to a machine int co-ord
		}

		int iY ( float y )
	   { 
		   return Math.round( y / pixelHeight ); 
			// Turns a logical float co-ord to a machine int co-ord
		}

      float fx ( int X )
	   { 
		   return X * pixelWidth;
			// Turns a real machine co-ord into logical float co-ord
		}
		
		float fy ( int Y )
	   { 
		   return (maxY - Y) * pixelHeight;
			// Turns a real machine co-ord into logical float co-ord
			// Also makes the y base at the bottom corner instead of top
		}

		public void paint ( Graphics g )
		{
		   initgr();
			
			int left = iX( 0 ),
			    right = iX( rWidth ),
				 bottom = iY( 0 ),
				 top = iY( rHeight );
		   
		   if ( xP >= 0 )  // Detects mouseclick
			   g.drawString( "Logical co-ords of selected point: " +
									xP + " " + yP, 20, 100 );

			g.setColor( Color.red );
			g.drawLine( left, bottom, right, bottom );
			g.drawLine( right, bottom, right, top );
			g.drawLine( right, top, left, top );
			g.drawLine( left, top, left, bottom );
		}
	}
}
