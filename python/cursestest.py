#!/usr/bin/env python
import curses



def main():
   try:
      # Startup
      stdscr = curses.initscr()
      curses.noecho()
      # cbreak passes signals like Ctrl-C, raw does not.
      curses.cbreak()
      stdscr.keypad(1)

      # Do stuff
   finally:
      # Teardown
      curses.nocbreak()
      stdscr.keypad(0)
      curses.echo()
      curses.endwin()

# Or we can use curses.wrapper() which we probably should.
def hook(stdscr):
   # curses.wrapper uses cbreak, but I rather want raw so things
   # don't get utterly fucked when I hit ctrl-s
   curses.raw()
   curses.curs_set(0)  # Hide cursor
   x = 5
   y = 10
   w = 5
   h = 10
   # Wow, I already want to punch the writer of this library.
   #win = curses.newwin(h, w, y, x)
   pad = curses.newpad(50,50)
   for y in range(0,50):
      for x in range(0,50):
         try:
            pad.addch(y,x,ord('a') + (x*x+y*y) % 26)
         except curses.error: pass
   # Displays a pad in the middle of the screen.
   pad.refresh(0,0, 5,5, 20,75)
   # Wait for input
   pad.getch()
      # Set up a color pair
   curses.init_pair(1, curses.COLOR_RED, curses.COLOR_BLACK)
   stdscr.addstr(5, 0, "Current mode: Your mom", \
                 curses.A_REVERSE | curses.color_pair(1))
   stdscr.refresh()
   stdscr.getch()


if __name__ == '__main__':
   curses.wrapper(hook)
