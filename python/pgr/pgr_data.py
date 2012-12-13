# pgr-classes.py
# Holds all the classes for PGR
# Organization, yaknow.
#
# Simon Heath
# 3/2/2002


import pygame
from pygame.locals import *
import os, math


##########################################################################
## DATA

# CONSTANTS
SCREENRECT = Rect( (0, 0, 640, 480) )
DATAPATH = "./"

# GLOBALS
IMG = {}
SND = {}


##########################################################################
## HELPER FUNCTIONS

# Utility functions to load data
def load_image( file ):
   "loads an image, prepares it for play"
   file = os.path.join( DATAPATH, file )
   try:
       surface = pygame.image.load( file ).convert()
   except pygame.error:
      raise SystemExit, \
         'Could not load image "%s" %s' % (file, pygame.get_error())
   return surface


def load_sound( name ):
   "Loads a sound and does error checking"
   class NoneSound:
      def play( self ): pass
   if not pygame.mixer or not pygame.mixer.get_init(): # If mixer is screwed...
      return NoneSound()   # Dummy class that'll pretty much act like a sound
      
   fullname = os.path.join( DATAPATH, name )
   try:
      sound = pygame.mixer.Sound( fullname )
   except pygame.error, message:
      print 'Cannot load sound:', fullname
      raise SystemExit, message
   return sound


# Convert degrees to radians for the Python math.sin/cos/tan functions, since
# all the pygame image functions take degrees.
# Oh, converts them back also.
def d2r( degrees ):
   return 1.0 * degrees * (math.pi / 180.0)

def r2d( radians ):
   return 1.0 * radians * (180.0 / math.pi)

##########################################################################
## CLASSES

class Dancer( pygame.sprite.Sprite ):
   """Dancer sprite.  A Dancer is any object on the screen that follows
inertial laws and can interact with other Dancers."""
   
   def __init__( self, image ):
      pygame.sprite.Sprite.__init__( self, self.containers ) # Call to Super

      # Set image
      self.images = []
      # Build rotated images
      for x in range( 64 ):
         self.images.append( \
	    pygame.transform.rotate( image, - int( 5.625 * x ) ) )
	 self.images[x].set_colorkey( (0, 0, 0), RLEACCEL )  # set transparent

      self.image = self.images[0]
      self.rect = self.images[8].get_rect()

      # Physics data  --change these in child classes.
      self.mass = 0.0       # These MUST be floats!
      self.thrust = 0.0
      self.maxspeed = 0.0
      self.turn = 0.0

      # Internal data 
      self.speed = 0.0      # MUST be a float
      self.direction = 0.0


   def accel( self, dir ):
      """Accelerate the Dancer
Positive number means move forward, negative number means move back, 0 means
stop.  Rather neat, ne?  Can also exaggerate speed by passing a higher
number."""
      self.speed += self.thrust / self.mass * dir
      if self.speed >= self.maxspeed:
         self.speed = self.maxspeed

   def rotate( self, dir ):
      """Rotate the dancer.
Positive means rotate clockwise, negative means counterclockwise, 0 means face
straight up."""
      self.direction += self.turn * dir
      if self.direction > 360:
         self.direction = 0
      # Rotate image
      self.image = self.images[ int( self.direction % 64 ) ]

   def move( self ):
      """Move the player.
Yay trig!"""
      # Crunch the trig to get new X and Y co-ords...
      movex = self.speed * math.sin( d2r( self.direction ) )
      movey = self.speed * math.cos( d2r( self.direction ) )
      print movex, movey, self.direction, self.speed
      self.rect.move_ip( movex, movey )

      # wrap around screen
      if self.rect.left > SCREENRECT.right:
         self.rect.right = SCREENRECT.left
      if self.rect.right < SCREENRECT.left:
         self.rect.left = SCREENRECT.right
      if self.rect.top > SCREENRECT.bottom:
         self.rect.bottom = SCREENRECT.top
      if self.rect.bottom < SCREENRECT.top:
         self.rect.top = SCREENRECT.bottom

      def collide():
         pass


# PLAYER
class Player( Dancer ):
   """Player sprite.  Inherits from Dancer"""

   def __init__( self, image ):
      "Player( image ) -> Dancer"
      Dancer.__init__( self, image ) # Call to Super

      self.mass = 10.0       # These MUST be floats!
      self.thrust = 1.0
      self.maxspeed = 10.0
      self.turn = 1.0


