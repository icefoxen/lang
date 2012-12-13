public class ClosestPair {
  public final static double INF = java.lang.Double.POSITIVE_INFINITY;



  public static PointPair closestPair(XYPoint[] points){
    XYPoint pointsByX [] = new XYPoint [points.length];
    XYPoint pointsByY [] = new XYPoint [points.length];
	for (int j = 0; j < points.length; j++)
	  {
	    pointsByX[j] = points[j];
	    pointsByY[j] = points[j];
	  }
	
	// Ensure sorting precondition for divide-and-conquer algorithm.
	XComparator xcomp = new XComparator();
	YComparator ycomp = new YComparator();
	Sort.msort(pointsByX, xcomp); // sort by x-coord
	Sort.msort(pointsByY, ycomp); // sort by y-coord
  	return findClosestPair(pointsByX, pointsByY);
  }

   static PointPair bruteForceFind( XYPoint[] ptsByX, XYPoint[] ptsByY )
   {
      PointPair closest = new PointPair();
      for( int i = 0; i < ptsByX.length; i++ )
      {
         for( int j = i; j < ptsByX.length; j++ )
         {
            if( ptsByX[i].dist( ptsByX[j] ) < closest.dist )
               closest = new PointPair( ptsByX[i], ptsByX[j] );
         }
      }
      return closest;
   }

   // Hrm.  Wiggy termination conditions.
   static PointPair findClosestPair(XYPoint[] ptsByX, XYPoint[] ptsByY)
   {

//      System.out.println( "Searching a field with " + ptsByX.length + " points." );
      int n = ptsByX.length;
      // Handle base cases: if only one point, return out-of-band
      // value.  If two points, return the distance between them.
      if( n < 2 ) return new PointPair();
      if( n == 2 ) return new PointPair( ptsByX[0], ptsByX[1] );
      // Else, divide and recurse.
      // ...Would the opposite of recursing be "reblessing"???
      XYPoint xL[] = new XYPoint[ (int) Math.ceil( (double) n / 2.0 ) ];
      XYPoint yL[] = new XYPoint[ (int) Math.ceil( (double) n / 2.0 ) ];
      XYPoint xR[] = new XYPoint[ (int) Math.floor( (double) n / 2.0 ) ];
      XYPoint yR[] = new XYPoint[ (int) Math.floor( (double) n / 2.0 ) ];


      // We divvy the area up into two halves...
      splitArrays( xL, yL, xR, yR, ptsByX, ptsByY );
//      System.out.println( "Points divvied." );


      // Print out all the points so we can make sure they're in order.
      // They are!  Yaay!
/*
      
      for( int i = 0; i < xL.length; i++ )
      {
         System.out.print( "xL: " );
         System.out.println( xL[i] );
      }
      for( int i = 0; i < yL.length; i++ )
      {
         System.out.print( "yL: " );
         System.out.println( yL[i] );
      }
      for( int i = 0; i < xR.length; i++ )
      {
         System.out.print( "xR: " );
         System.out.println( xR[i] );
      }
      for( int i = 0; i < yR.length; i++ )
      {
         System.out.print( "yR: " );
         System.out.println( yR[i] );
      }
*/
      
      // Okay.  So that's the divide bit of the divide-and-conquor.

      PointPair dL = findClosestPair( xL, yL );
      PointPair dR = findClosestPair( xR, yR );
//      System.out.println( dL );
//      System.out.println( dR );
      
      PointPair ret;
      double d = Math.min( dL.dist, dR.dist );
      if( dL.dist < dR.dist ) ret = dL;
      else ret = dR;

//      System.out.println( "Of " + dL.dist + " and " + dR.dist + ", " + d + " is the smaller one." );
      // Right, so we've found the distance for left and right sections.
      // Now we check the middle.

//      System.out.println( "Building y-strip." );
      // Create and fill an array representing the middle...
      XYPoint ystrip[] = new XYPoint[ ptsByY.length ];
      int b = 0;
      // If (n - d < px < n + d), where n is the middlepoint, then p
      // is in ystrip.
      int k = xL[ xL.length - 1 ].x;
      double dist;
      for( int i = 0; i < ystrip.length; i++ )
      {
         if( k - d < ptsByY[i].x && k + d > ptsByY[i].x )
         {
            ystrip[b] = ptsByY[i];
            b++;
         }
      }

//      System.out.println( "ystrip is " + k + " +- " + d );
//      for( int i = 0; i < b; i++ )
//         System.out.println( ystrip[i] );


      for( int i = 0; i < b - 1; i++ )
      {
         if( b < 2 ) break;

         dist = ystrip[i].dist( ystrip[i + 1] );
         if( dist < d ) ret = new PointPair( ystrip[i], ystrip[i + 1] );
      }

      return ret; //new PointPair(ptsByX[0],ptsByX[1]);
   }


   private static void splitArrays( XYPoint xL[], XYPoint yL[],
                                    XYPoint xR[], XYPoint yR[],
                                    XYPoint srcX[], XYPoint srcY[] )
   {
      int mid = xL.length;
      for( int i = 0; i < mid; i++ )
      {
         xL[i] = srcX[i];
      }
      for( int i = 0; i < xR.length; i++ )
      {
         xR[i] = srcX[i + mid];
      }

      int lyindex = 0;
      int ryindex = 0;
      for( int i = 0; i < srcY.length; i++ )
      {
         if( contains( xL, srcY[i] ) )
         {
            yL[lyindex] = srcY[i];
            lyindex++;
         }
         else if( contains( xR, srcY[i] ) )
         {
            yR[ryindex] = srcY[i];
            ryindex++;
         }
      }

   }

   private static boolean contains( Object ar[], Object o )
   {
      for( int i = 0; i < ar.length; i++ )
      {
         if( ar[i] == o )
            return true;
      }
      return false;
   }
}

