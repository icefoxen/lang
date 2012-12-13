// Interface.java
// Right, let's try to build the GUI.  All I have is a Planet data-type,
// but hopefully that should do to start.
// Simon Heath
// 18/04/2002

import simon.IJ.PlanetRandom;
import simon.IJ.Ship;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class Interface extends JFrame {
   private JPanel rightPanel, bottomPanel;
   private JButton scan, exit, blank;
   private JButton a1, a2;
   private JLabel location, shipName;
   private FlowLayout bottomLayout;
   private FlowLayout rightLayout;
   private JTextArea scanField;
   public Ship myShip;
   public SolSystem solSystem;
   
   public Interface ()
   {
      super ( "Infinity Junction" );
      
      // Initialize objects
      SolSystem solSystem = new SolSystem ();
      Container c = getContentPane ();
      rightPanel = new JPanel ();
      bottomPanel = new JPanel ();
      scan = new JButton ( "Scan Planet" );
      exit = new JButton ( "Exit" );
      a1 = new JButton ( "a1" );
      a2 = new JButton ( "a2" );
      location = new JLabel ( 
	 "[" + myShip.getX() + "," + myShip.getY () + "]" );
      shipName = new JLabel ( myShip.getName () );
      scanField = new JTextArea ( 35, 5 );
      
      // Initialize layouts
      bottomLayout = new FlowLayout ();
      bottomLayout.setAlignment ( FlowLayout.RIGHT );
      rightLayout = new FlowLayout (); // ( 6, 1 );  // width, height
      
      // Build rightPanel
      rightPanel.setLayout ( rightLayout );
      rightPanel.add ( a1 );
      rightPanel.add ( a2 );
      rightPanel.add ( a3 );
      rightPanel.add ( a4 );
      rightPanel.add ( scan );
      rightPanel.add ( new JScrollPane ( scanField ) );
      
      // Build bottomPanel
      bottomPanel.setLayout ( bottomLayout );
      bottomPanel.add ( exit );
      
      // Set panels on container
      c.add ( rightPanel, BorderLayout.EAST );  // getContentPane default
      // layout is BorderLayout, change with c.setLayout()
      c.add ( bottomPanel, BorderLayout.SOUTH );
      
      // Add actionListeners to buttons
      ScanButtonHandler handler = new ScanButtonHandler ();
      scan.addActionListener ( handler );
      
      ExitButtonHandler exiter = new ExitButtonHandler ();
      exit.addActionListener ( exiter );
      
      // Display window
      setSize ( 640, 480 );
      show ();
   }
   
      public static void main ( String args[] )
   {
      Interface app = new Interface ();
      
      app.addWindowListener (
	 new WindowAdapter () {
	    public void windowClosing ( WindowEvent e )
	    {
	       System.exit ( 0 );
	    }
	 }  // End anon class
			      ); // End addWindowListener arg
   }  // End method main
   
   // Inner class for Scan button handling
   private class ScanButtonHandler implements ActionListener {
      public void actionPerformed ( ActionEvent e )
      {
	 PlanetRandom planet = new PlanetRandom ( "Rock" );  // Generate new Rock planet
	 scanField.setText ( planet.toString () );
      }  // End method
   }  // End inner class
   
   // Inner class for Exit button handling
   private class ExitButtonHandler implements ActionListener {
      public void actionPerformed ( ActionEvent e )
      {
	 System.exit ( 0 );
      }  // End method
   }  // End inner class
}  // End class
