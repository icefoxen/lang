/* Randtest.java
 * Tests random number generator!
 */

public class Randtest {
    public static void main( String args[] ) {
	int[] arr = testRand();
	for( int i = 0; i < 50; i++ ) {
	    System.out.println( i + ": " + arr[i] );
	}

	System.out.println();
	System.out.println( "Average: " + average( arr ) );
    }

    private static int[] testRand() {
	int values[] = new int[50];

	for( int i = 0; i < 10000000; i++ ) {
	    double random = Math.random() * 50;
	    int res = (int) random;
	    values[res]++;
	}
	return values;
    }

    private static double average( int[] vals ) {
	double accm = 0;
	for( int i = 0; i < vals.length; i++ ) {
	    accm += (double) i * vals[i];
	}
	accm = accm / vals.length / vals.length;
	return accm;
    }

}
