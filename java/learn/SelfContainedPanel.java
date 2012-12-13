// SelfContainedPanel.java
// JPanels do not recognize button or window events, but
// CAN recognize key and mouse events.  This class 
// creates a panel that listens for mouse events and draws
// an oval.
// Simon Heath
// 20/04/2002

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class SelfContainedPanel extends JPanel {
   private int x1, y1, x2, y2;
   
   public SelfContainedPanel ()
   {
      addMouseListener (
	 new MouseAdapter () {
	    public void mousePressed ( MouseEvent e )
	    {
	       x1 = e.getX ();
	       y1 = e.getY ();
             repaint ();
	    }
	    
	    public void mouseReleased ( MouseEvent e )
	    {
	       x2 = e.getX ();
	       y2 = e.getY ();
             repaint();
	    }
	 }  // End anon class
			);  // End arg
   }  // End constructor
   
   public Dimension getPreferredSize ()
   {
      return new Dimension ( 150, 150 );
   }
   
   public void paintComponent ( Graphics g )
   {
      super.paintComponent ( g );
      
      g.drawOval ( Math.min ( x1, x2 ), Math.min ( y1, y2 ),
		   Math.abs ( x1 - x2 ), Math.abs ( y1 - y2 ) );
   }
}
