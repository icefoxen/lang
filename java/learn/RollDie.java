// RollDie.java
// This uses the random number generator method (from class java.lang)
// to generate 6000 random "dice-rolls" and see how random they REALLY are.
// Simon Heath
// 19/03/2002

import javax.swing.*;  // Import GUI componants

public class RollDie {
    public static void main ( String args [] )
    {
	int frequency1 = 0,  // The variables that measure how many time
	    frequency2 = 0,  // a particular number has been rolled.
	    frequency3 = 0,
	    frequency4 = 0,
	    frequency5 = 0,
	    frequency6 = 0,
	    face;            // The variable the random number is assigned to.

	// Roll 6000 times...
	for ( int roll = 1; roll <= 6000; roll++ )
	    {
		face = 1 + (int) ( Math.random() * 6 );
		// This generates a random number and assigns it to face.
		// Math.random creates a number between 0 and 1.  We multiply
		// it by six to create a number between 0 and 5, then use (int)
		// to turn it in to a temporary integer, then add 1 to bump
		// it up a notch to between 1 and 6.

		// This measures what number was rolled and adds one to
		// the appropriate frequency# variable.
		switch ( face )
		    {
		    case 1:
			frequency1++;
			break;
		    case 2:
			frequency2++;
			break;
		    case 3:
			frequency3++;
			break;
		    case 4:
			frequency4++;
			break;
		    case 5:
			frequency5++;
			break;
		    case 6:
			frequency6++;
			break;
		    } // Close switch
	    } // Close for

	// OUTPUT
	JTextArea outputArea = new JTextArea ( 7, 10 );
	// You know the drill, but go over it one more time.
	// This declares reference outputArea of type JTextArea,
	// and assigns it to a new JTextArea object of 7 rows and 10
	// columns.

	outputArea.setText
	    (
	     // Sticks the results on to outputArea
	     // Recall that \t is a tab space.
	     "Face\tFrequency" +
	     "\n1\t" + frequency1 +
	     "\n2\t" + frequency2 +
	     "\n3\t" + frequency3 +
	     "\n4\t" + frequency4 +
	     "\n5\t" + frequency5 +
	     "\n6\t" + frequency6
	     );

	JOptionPane.showMessageDialog
	    (
	     null,
	     outputArea,
	     "Rolling a die 6000 times",
	     JOptionPane.INFORMATION_MESSAGE
	     );

	System.exit ( 0 );
    }  // Close method
}  // Close class, of course.
