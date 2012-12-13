# Nessus.py
# A graphical shell/file browser using pygame.
#
# Simon Heath
# 10/2/2003

import pygame
from pygame.locals import *

# import system data
from Nessus_data import *

import sys, os



# Local/dynamic data
all_group = pygame.sprite.RenderClear()  # Group for all sprites
# Thegroups handle draw/clear/dirtyrecting.  


# MAINLOOP 
def main():
   "Main program."
   global SND, IMG
   pygame.init()

   # Checks on images and music
   if not pygame.image.get_extended():
      raise SystemExit, "Sorry, extended image module required"

   if pygame.mixer and not pygame.mixer.get_init():
      print "Warning, no sound"
      pygame.mixer = None

   # Set display mode
   winstyle = 0  # 1 = fullscreen?
   screen = pygame.display.set_mode( SCREENRECT.size ) # Create screen

   # Load images
   IMG['tab'] = load_image( "tab.png" )
   IMG['tab_c'] = load_image( "tab_c.png" )
   IMG['def_prog_icon'] = load_image( "def_prog_icon.png" )
   IMG['def_file_icon'] = load_image( "def_file_icon.png" )
   IMG['def_file_icon_c'] = load_image( "def_file_icon_c.png" )

   # Decorate game window
   icon = pygame.transform.scale( IMG['tab'], (32, 32) )
   pygame.display.set_icon( icon )
   pygame.display.set_caption( "Nessus" )
   pygame.mouse.set_visible( 1 )
   pygame.mouse.set_cursor( *pygame.cursors.tri_left )

   # Assign default groups to each sprite class
   ProgramPanel.containers = all_group
   FilePanel.containers = all_group
   Tab.containers = all_group
   Status.containers = all_group
   Terminal.containers = all_group

   # Start clock
   clock = pygame.time.Clock()

   # Create background
   IMG['bg'] = pygame.Surface( SCREENRECT.size )
   IMG['bg'].fill( (0, 0, 0) )  # Set bg to black
   screen.blit( IMG['bg'], (0, 0) )
   pygame.display.flip()
   # Creates a black surface, blits it onto the screen.
   # The final flip() makes sure it's displayed.

   # Load config files
   load_progs()
   load_files()

   # Init sprites
   pPanel = ProgramPanel( "Load Image here" )
   fPanel = FilePanel( "Load Image Here" )
   stat = Status( "Load Image Here" )
   tab = Tab( IMG['tab'], IMG['tab_c'] )
   term = Terminal()

   # Causes some interesting effects, heh.  The formatting tends to get
   # screwity though.
   #sys.stdin = term
   #sys.stdout = term

   # MAINLOOP
   while 1:
      # EVENT HANDLING
      # Create a queue so events won't be missed
      for event in pygame.event.get():
         # Search for quit events
         if event.type == QUIT or \
            (event.type == KEYDOWN and event.key == K_ESCAPE):
               sys.exit( 0 )

         # Search for click events
         if event.type == MOUSEBUTTONDOWN and event.button == 1:
	    # Check for panel toggling...
            if tab.rect.collidepoint( event.pos ):
               pPanel.toggle()
	       fPanel.toggle()
	    # Check for panel clicking...
            if pPanel.rect.collidepoint( event.pos ):
               pPanel.click( event.pos )
	       i = pPanel.get_icon( event.pos )
	       if i:
                  stat.string = "Executing: " + i.name
		  stat.show_string()
            if fPanel.rect.collidepoint( event.pos ):
               fPanel.click( event.pos )

	 # Check for tab clicking...
         if event.type == MOUSEBUTTONUP and event.button == 1:
            if tab.clicked:
               tab.unclick()

         if event.type == MOUSEBUTTONDOWN and event.button == 3:
	    # Check for right-clicks on panel icons...
            if pPanel.rect.collidepoint( event.pos ): 
               icon = pPanel.get_icon( event.pos )
	       if icon:
                  stat.string = "Program - " + icon.name
                  stat.show_string()
            if fPanel.rect.collidepoint( event.pos ):
               icon = fPanel.get_icon( event.pos )
	       if icon:
                  stat.string = "File - " + icon.name
                  stat.show_string()
         # Key presses
         if event.type == KEYDOWN:
            term.write( event.unicode )
	    stat.string = "Terminal - " + term.string
	    stat.show_string()
         # Else, print.  This slows things down much and makes it sometimes
         # miss events.
         #print `event`


      # SPRITES
      # Clear last drawn sprites
      all_group.clear( screen, IMG['bg'] ) 
      
      # Update sprites
      all_group.update() 

      # Draw the scene
      all_group.draw( screen )
      pygame.display.update()

      # Cap framerate
      clock.tick( 40 )

if __name__ == '__main__':
   main()
