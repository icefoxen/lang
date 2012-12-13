/* craps.c
 * Plays craps.
 * You start by rolling a pair of dice.  If your first roll is 7 or 11, you
 * win.  If you roll a 2, 3, or 12, you lose.  Else, the number you rolled 
 * becomes your "point".  You then roll again until you roll 7 and lose, or
 * roll your point and win.
 *
 * Simon Heath
 * 3/11/2002
 */

#include <stdio.h>
#include "../lib/random.h"

/* Function prototypes.  These just make it easier to see what's happening. 
 * They also help the compiler sometimes....(?)
 */

static int TryForPoint( int point );
static int RollTwoDice( void );

/*  Main program */

main()
{
   int point;

   Randomize();  /* Init random number generator */

   printf( "This program plays a game of craps.\n" );
   point = RollTwoDice();

   switch( point )
   {
      case 7: case 11:
         printf( "That's a natural.  You win." );
	 break;
      case 2: case 3: case 12:
	 printf( "That's craps.  You lose." );
	 break;
      default:
	 printf( "Your point is %d\n", point );
	 if( TryForPoint( point ) )
            printf( "You made your point.  You win." );
	 else
	    printf( "You rolled a seven.  You lose." );
   }
}


static int TryForPoint( int point )
{
   int total;
   while( 1 )
   {
      total = RollTwoDice();
      if( total == point ) return 1;
      if( total == 7 ) return 0;
   }
}

static int RollTwoDice( void ) /* do I have to put void here? */
{
   int d1, d2, total;

   printf( "Rolling the dice...\n" );
   d1 = RandomInt( 1, 6 );
   d2 = RandomInt( 1, 6 );
   total = d1 + d2;
   
   printf( "You rolled %d and %d -- that's %d\n", d1, d2, total );
   return total;
}
