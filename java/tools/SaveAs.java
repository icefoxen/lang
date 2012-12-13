// SaveAs.java
// This is cool.  A class that just gets an object, and saves it to a file.
// That prevents you having to write it all out again.  Let's see if it works.
// Simon Heath
// 09/05/2002


//package simon.file;
import java.io.*;
import javax.swing.*;

public class SaveAs {
   ObjectOutputStream saveStream;

   public SaveAs ()
   {

   }   

   public SaveAs ( Object o )
   {
      save( o );
   }
   
   public void save ( Object ob )
   {
       openFile();

       try
       {
          saveStream.writeObject( ob );
	    saveStream.flush();
       }
       catch ( IOException ioexw )
       {
          JOptionPane.showMessageDialog ( null, "Error Writing File",
	     "IO Error!", JOptionPane.ERROR_MESSAGE );
	  
	  closeFile();

	  ioexw.printStackTrace();
      }

      closeFile();
   }
   
   private void openFile ()
   {
      JFileChooser chooser = new JFileChooser();
      chooser.setFileSelectionMode( JFileChooser.FILES_ONLY );

      int result = chooser.showSaveDialog( null );

      // If cancel button is clicked...
      if ( result == JFileChooser.CANCEL_OPTION )
         return;
      
      File fileName = chooser.getSelectedFile();

      if ( fileName == null || fileName.getName().equals( "" ) )
        JOptionPane.showMessageDialog( null, "Invalid File Name",
	   "Invalid File Name", JOptionPane.ERROR_MESSAGE );
      else  // open file
      {
         try
	 {
	    saveStream = new ObjectOutputStream( 
	       new FileOutputStream( fileName ) );
	 }
	 catch ( IOException ioeo )
	 {
 
	    JOptionPane.showMessageDialog( null, "Something messed up opening the " +
	       "file.", "IO Error!", JOptionPane.ERROR_MESSAGE );
	    
	    ioeo.printStackTrace();
	 }
      }
   }

   private void closeFile()
   {
      try
      {
         saveStream.close();
      }
      catch ( IOException ioexx )
      {
	 JOptionPane.showMessageDialog( null, "Something messed up opening the " +
	    "file.", "IO Error!", JOptionPane.ERROR_MESSAGE );
	    
	 ioexx.printStackTrace();
      }
   }   
}
