import pygame
from pygame.locals import *
import sys
pygame.init()


class GameObject:
   def __init__( self, image, height, speed ):
      self.speed = speed
      self.image = image
      self.pos = image.get_rect().move( 0, height )
   def move( self ):
      self.pos = self.pos.move( self.speed, 0 )
      if self.pos.right > 600:
         self.pos.left = 0

screen = pygame.display.set_mode( (640, 480) )        # Create screen
player = pygame.image.load( 'player1.gif' ).convert() # Create player surface
bg = pygame.image.load( 'liquid.bmp' ).convert()      # Create background surface


# The convert() functions turn the pics into Surface objects with the
# same format as the screen.  This will speed things up.

screen.blit( bg, (0, 0) )  # Surface to blit, plus co-ords
objects = []

for x in range( 0, 10 ):  # Create 10 objects
   o = GameObject( player, x*50, (x+1)*3)
   objects.append( o )

while 1:
   for event in pygame.event.get():
      if event.type in (QUIT, KEYDOWN):
         sys.exit()
   for o in objects:  # Re-draw a cookie-cutter bit of the background over the image
      screen.blit( bg, o.pos, o.pos )
   for o in objects:  # Move the image, then re-draw it
      o.move()
      screen.blit( o.image, o.pos )
   pygame.display.update()
   pygame.time.delay( 50 )

