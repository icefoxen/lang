# pgr.py
# Pygame Revision!
# Oookey, let's see what we can do about a pong-clone, ne?
# OOoh, no, let's try building an inertia-model!  That would be MUCH more
# fun!!
# 
# Simon Heath
# 3/2/2003

import pygame
from pygame.locals import *
import sys, os

# import game data
from pgr_data import *


# Local/dynamic data
all_group = pygame.sprite.RenderClear()  # Group for all sprites
box_group = pygame.sprite.RenderClear() # Group for boxes
# The groups handle draw/clear/dirtyrecting.  


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
   winstyle = 0  # 0 = fullscreen?
   screen = pygame.display.set_mode( SCREENRECT.size ) # Create screen

   # Load images
   IMG['player'] = load_image( "player.png" )

   # Decorate game window
   icon = pygame.transform.scale( IMG['player'], (32, 32) )
   pygame.display.set_icon( icon )
   pygame.display.set_caption( "PGR" )
   pygame.mouse.set_visible( 0 )

   # Assign default groups to each sprite class
   Player.containers = all_group

   # Start clock
   clock = pygame.time.Clock()

   # Create background
   IMG['bg'] = pygame.Surface( SCREENRECT.size )
   IMG['bg'].fill( (0, 0, 0) )  # Set bg to black
   screen.blit( IMG['bg'], (0, 0) )
   pygame.display.flip()
   # Creates a black surface, blits it onto the screen.
   # The final flip() makes sure it's displayed.

   # Init sprites
   player = Player( IMG['player'] )


   # MAINLOOP
   while 1:
      # EVENT HANDLING
      # Create a queue so escape events won't be missed
      for event in pygame.event.get():
         if event.type == QUIT or \
            (event.type == KEYDOWN and event.key == K_ESCAPE):
               sys.exit( 0 )
      # Otherwise, just grab the current key
      keystate = pygame.key.get_pressed()

      # Handle player input
      accel = keystate[K_UP] - keystate[K_DOWN]
      if accel:
         player.accel( accel )
      rotate = keystate[K_RIGHT] - keystate[K_LEFT]
      if rotate:
         player.rotate( rotate )
      print accel, rotate
      player.move()


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
