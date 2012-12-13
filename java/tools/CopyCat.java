// Okaydee.  This is a simple program to copy a file.
// Piece of cake.  I/O demo.
// Been too long since I coded anything.
// Simon Heath
// 16/05/2002

import java.io.*;

public class CopyCat {
   public static void main ( String args[] ) throws Exception
   {
      if ( args.length != 2 )
         System.out.println( "Usage:\njava CopyCat <inputfile> <outputfile>" );
      else
      {
         File inputFile = new File( args[ 0 ] );
         File outputFile = new File( args[ 1 ] );

         FileReader in = new FileReader( inputFile );
         FileWriter out = new FileWriter( outputFile );
         int c;

         while ( (c = in.read()) != -1 )
            out.write( c );
         
         in.close();
         out.close();
      }
   }
}   
