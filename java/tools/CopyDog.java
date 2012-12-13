// Okaydee.  This is a simple program to copy a file.
// Piece of cake.  I/O demo.
// Been too long since I coded anything.
// This uses byte streams instead of character streams.
// Simon Heath
// 16/05/2002

import java.io.*;

public class CopyDog {
   public static void main ( String args[] ) throws Exception
   {
      if ( args.length != 2 )
         System.out.println( "Usage:\njava CopyDog <inputfile> <outputfile>" );
      else
      {
         File inputFile = new File( args[ 0 ] );
         File outputFile = new File( args[ 1 ] );

         FileInputStream in = new FileInputStream( inputFile );
         FileOutputStream out = new FileOutputStream( outputFile );
         int c;

         while ( (c = in.read()) != -1 )
            out.write( c );
         
         in.close();
         out.close();
      }
   }
}   
