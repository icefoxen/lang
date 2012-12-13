#include <curses.h>
#include <signal.h>
#include <stdio.h>

static void finish( int sig );

main( int argc, char *argv[] ) {
   signal( SIGINT, finish );
   initscr();   // Initalize curses lib
   keypad( stdscr, TRUE ); // Enable keyboard mapping.
   nonl();     // Don't do NL->NL/CR on output
   cbreak();   // Non-buffered IO
   noecho();   // What it says

   // Simple color assignment
   if( has_colors() ) {
      start_color();
      // init_pair( colorpair, fgcolor, bgcolor )
      init_pair( COLOR_BLACK, COLOR_BLACK, COLOR_BLACK );
      init_pair( COLOR_GREEN, COLOR_GREEN, COLOR_BLACK );
      init_pair( COLOR_RED, COLOR_RED, COLOR_BLACK );
      init_pair( COLOR_CYAN, COLOR_CYAN, COLOR_BLACK );
      init_pair( COLOR_WHITE, COLOR_WHITE, COLOR_BLACK );
      init_pair( COLOR_MAGENTA, COLOR_MAGENTA, COLOR_BLACK );
      init_pair( COLOR_BLUE, COLOR_BLUE, COLOR_BLACK );
      init_pair( COLOR_YELLOW, COLOR_YELLOW, COLOR_BLACK );
   }

   wborder( stdscr, 0, 0, 0, 0, 0, 0, 0, 0 );

   for( ;; ) {
      int c = getch();
      if( c == 'q' ) break;
      else mvwaddch( stdscr, 10, 10, c | COLOR_PAIR(COLOR_CYAN) );
   }
   finish( 0 );
}

static void finish( int sig ) {
   endwin();
   exit( 0 );
}
