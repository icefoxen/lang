// SelfContainedPanelTest.java
// Creates a self-contained subclass of JPanel that processes
// it's own mouse events.  Hmm, good for customized GUIs, maybe?
// :-D
// Simon Heath
// 20/04/2002

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class SelfContainedPanelTest extends JFrame {
   private SelfContainedPanel myPanel;
   
   public SelfContainedPanelTest ()
   {
      myPanel = new SelfContainedPanel ();
      myPanel.setBackground ( Color.lightGray );
      
      Container c = getContentPane ();
      c.setLayout ( new FlowLayout () );
      c.add ( myPanel );
      
      addMouseMotionListener (
	 new MouseMotionListener () {
	    public void mouseDragged ( MouseEvent e )
	    {
	       setTitle ( "Dragging: x=" + e.getX () +
			  "; y=" + e.getY () );
	    }
	    
	    public void mouseMoved ( MouseEvent e )
	    {
	       setTitle ( "Moving: x=" + e.getX () +
			  "; y=" + e.getY () );
	    }
	 }  // End anon class
			      );  // End arg
      
      setSize ( 300, 200 );
      //show ();
   }
   
   public static void main ( String args[] )
   {
	  System.out.println( "Bop!" ); 
      SelfContainedPanelTest app = new SelfContainedPanelTest ();
      
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
